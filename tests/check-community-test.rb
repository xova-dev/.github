require 'minitest/autorun'
require 'tmpdir'
require 'fileutils'
require_relative '../scripts/check-community'

class CommunityChecksTest < Minitest::Test
  ROOT = File.expand_path('..', __dir__)

  def with_fixture
    Dir.mktmpdir('community-check-') do |root|
      %w[.github profile README.md CONTRIBUTING.md CONTRIBUTING.zh-CN.md SUPPORT.md SECURITY.md].each do |path|
        FileUtils.cp_r(File.join(ROOT, path), root)
      end
      yield root
    end
  end

  def test_real_repository
    assert CommunityChecks.check(ROOT)
  end

  def edit_yaml(root, filename)
    path = File.join(root, '.github/ISSUE_TEMPLATE', filename)
    document = YAML.safe_load(File.read(path))
    yield document
    File.write(path, YAML.dump(document))
  end

  %w[value description].each do |attribute|
    define_method("test_rejects_broken_form_#{attribute}_link") do
      with_fixture do |root|
        edit_yaml(root, '02-bug.en.yml') do |form|
          field = form['body'].find { |item| item['attributes'].key?(attribute) }
          field['attributes'][attribute] = '[Security](https://github.com/xova-dev/.github/blob/main/MISSING.md "Policy")'
        end
        error = assert_raises(ArgumentError) { CommunityChecks.check(root) }
        assert_includes error.message, 'missing link'
      end
    end
  end

  { 'array' => ['invalid'], 'number' => 42, 'boolean' => false, 'mapping' => {}, 'null' => nil }.each do |name, value|
    %w[input textarea].each do |type|
      define_method("test_rejects_#{name}_placeholder_on_#{type}") do
        with_fixture do |root|
          edit_yaml(root, '02-bug.en.yml') do |form|
            form['body'].find { |field| field['type'] == type }['attributes']['placeholder'] = value
          end
          error = assert_raises(ArgumentError) { CommunityChecks.check(root) }
          assert_includes error.message, 'placeholder must be a string'
        end
      end
    end
  end

  def test_accepts_optional_string_placeholders
    with_fixture do |root|
      edit_yaml(root, '02-bug.en.yml') do |form|
        form['body'].find { |field| field['type'] == 'input' }['attributes']['placeholder'] = ''
        form['body'].find { |field| field['type'] == 'textarea' }['attributes']['placeholder'] = 'Describe the problem'
      end
      assert CommunityChecks.check(root)
    end
  end

  def test_accepts_inline_link_titles_and_destinations
    with_fixture do |root|
      File.write(File.join(root, 'Support guide.md'), '# Help')
      File.write(File.join(root, 'Support(en).md'), '# Help')
      examples = <<~MARKDOWN
        [Support](SUPPORT.md "Support guide")
        [Support](SUPPORT.md 'Support guide')
        [Support](SUPPORT.md (Support guide))
        [Support](<Support guide.md> "Support (guide)")
        [Support](Support(en).md)
        [Security](https://github.com/xova-dev/.github/blob/main/SECURITY.md#report-privately "Policy")
      MARKDOWN
      File.open(File.join(root, 'README.md'), 'a') { |file| file.puts examples }
      edit_yaml(root, '02-bug.en.yml') do |form|
        form['body'][0]['attributes']['value'] = '[Policy](https://github.com/xova-dev/.github/blob/main/SECURITY.md "Security policy")'
        form['body'][1]['attributes']['description'] = '[Support](https://github.com/xova-dev/.github/blob/main/SUPPORT.md)'
      end
      assert CommunityChecks.check(root)
    end
  end

  def test_rejects_missing_titled_link
    [
      '[Missing](MISSING.md "Guide")',
      "[Missing](MISSING.md 'Guide')",
      '[Missing](MISSING.md (Guide))',
      '[Missing](<MISSING guide.md> "Guide")',
      '[Missing](MISSING(en).md)'
    ].each do |link|
      with_fixture do |root|
        File.open(File.join(root, 'README.md'), 'a') { |file| file.puts link }
        error = assert_raises(ArgumentError) { CommunityChecks.check(root) }
        assert_includes error.message, 'missing link MISSING'
      end
    end
  end

  def test_accepts_matching_field_reordering
    with_fixture do |root|
      %w[01-bug.zh-CN.yml 02-bug.en.yml].each do |name|
        edit_yaml(root, name) { |form| form['body'][1], form['body'][2] = form['body'][2], form['body'][1] }
      end
      assert CommunityChecks.check(root)
    end
  end

  def test_accepts_additional_contact_link
    with_fixture do |root|
      edit_yaml(root, 'config.yml') do |chooser|
        chooser['contact_links'] << { 'name' => 'Contributing', 'about' => 'How to contribute', 'url' => 'https://github.com/xova-dev/.github/blob/main/CONTRIBUTING.md' }
      end
      assert CommunityChecks.check(root)
    end
  end

  def test_rejects_broken_additional_contact_link
    with_fixture do |root|
      edit_yaml(root, 'config.yml') do |chooser|
        chooser['contact_links'] << { 'name' => 'Missing', 'about' => 'Missing document', 'url' => 'https://github.com/xova-dev/.github/blob/main/MISSING.md' }
      end
      error = assert_raises(ArgumentError) { CommunityChecks.check(root) }
      assert_includes error.message, 'missing link'
    end
  end

  def test_rejects_broken_contracts
    mutations = {
      'duplicate field IDs' => ['02-bug.en.yml', 'id: expected', 'id: actual'],
      'required must be boolean' => ['02-bug.en.yml', 'required: true', 'required: "true"'],
      'Bilingual field mismatch' => ['02-bug.en.yml', 'id: context', 'id: extra-context'],
      'invalid type or labels' => ['02-bug.en.yml', 'labels: [bug]', 'labels: [unknown]'],
      'duplicate YAML keys' => ['02-bug.en.yml', 'type: Bug', "type: Bug\ntype: Feature"],
      'Keep blank issues available' => ['config.yml', 'blank_issues_enabled: true', 'blank_issues_enabled: false'],
      'Wrong contact destinations' => ['config.yml', 'blob/main/SUPPORT.md', 'blob/main/README.md']
    }
    mutations.each do |message, (file, before, after)|
      with_fixture do |root|
        path = File.join(root, '.github/ISSUE_TEMPLATE', file)
        source = File.read(path)
        assert_includes source, before
        File.write(path, source.sub(before, after))
        error = assert_raises(ArgumentError) { CommunityChecks.check(root) }
        assert_includes error.message, message
      end
    end
  end

  def test_rejects_missing_document
    with_fixture do |root|
      File.unlink(File.join(root, 'SUPPORT.md'))
      error = assert_raises(ArgumentError) { CommunityChecks.check(root) }
      assert_includes error.message, 'missing link'
    end
  end

  def test_rejects_legacy_template
    with_fixture do |root|
      File.write(File.join(root, '.github/ISSUE_TEMPLATE/old.md'), '# Old template')
      error = assert_raises(ArgumentError) { CommunityChecks.check(root) }
      assert_includes error.message, 'Unexpected or missing issue templates'
    end
  end
end
