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

  def test_rejects_broken_contracts
    mutations = {
      'duplicate field IDs' => ['02-bug.en.yml', 'id: expected', 'id: actual'],
      'required must be boolean' => ['02-bug.en.yml', 'required: true', 'required: "true"'],
      'Bilingual field mismatch' => ['02-bug.en.yml', 'id: context', 'id: extra-context'],
      'invalid type or labels' => ['02-bug.en.yml', 'labels: [bug]', 'labels: [unknown]'],
      'duplicate YAML keys' => ['02-bug.en.yml', 'type: Bug', "type: Bug\ntype: Feature"],
      'Keep blank issues available' => ['config.yml', 'blank_issues_enabled: true', 'blank_issues_enabled: false'],
      'Wrong contact destinations' => ['config.yml', 'blob/main/SUPPORT.md', 'blob/main/MISSING.md']
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
