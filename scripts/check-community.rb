#!/usr/bin/env ruby
# Repository-specific contracts for the subset of GitHub Issue Forms we use.
require 'json'
require 'yaml'

module CommunityChecks
  # Repository policy lives here; structural validation below is shared.
  FORM_GROUPS = {
    'Bug' => {
      files: %w[01-bug.zh-CN.yml 02-bug.en.yml], label: 'bug',
      required: %w[actual expected reproduction version]
    },
    'Feature' => {
      files: %w[03-feature.zh-CN.yml 04-feature.en.yml], label: 'enhancement',
      required: %w[problem outcome]
    }
  }.freeze
  DOCUMENT_URL = 'https://github.com/xova-dev/.github/blob/main/'.freeze
  REQUIRED_CONTACTS = %w[SECURITY.md SUPPORT.md].map { |file| DOCUMENT_URL + file }.freeze
  # Inline links only: plain/angle-bracket destinations, one level of path
  # parentheses, and optional double-, single- or parenthesis-delimited titles.
  INLINE_LINK = /\]\(\s*(?:<([^>\n]+)>|([^\s()]+(?:\([^()\s]*\)[^\s()]*)*))
    (?:\s+(?:"[^"\n]*"|'[^'\n]*'|\([^()\n]*\)))?\s*\)/x.freeze

  module_function

  def require_valid(condition, message)
    raise ArgumentError, message unless condition
  end

  def yaml(path)
    source = File.read(path)
    visit = lambda do |node|
      if node.is_a?(Psych::Nodes::Mapping)
        keys = node.children.each_slice(2).map { |key, _| key.value }
        require_valid(keys.uniq == keys, "#{path}: duplicate YAML keys")
      end
      Array(node.children).each { |child| visit.call(child) }
    end
    visit.call(Psych.parse_stream(source))
    YAML.safe_load(source)
  end

  def check_form(form, labels, path)
    require_valid(form.is_a?(Hash), "#{path}: expected a mapping")
    require_valid((form.keys - %w[name description type labels body]).empty?, "#{path}: unsupported form keys")
    %w[name description].each do |key|
      require_valid(form[key].is_a?(String) && !form[key].strip.empty?, "#{path}: missing #{key}")
    end
    expected_label = FORM_GROUPS.dig(form['type'], :label)
    require_valid(expected_label && form['labels'] == [expected_label] && labels.include?(expected_label), "#{path}: invalid type or labels")
    body = form['body']
    require_valid(body.is_a?(Array) && body.length > 1, "#{path}: missing body")
    fields = []
    body.each do |field|
      require_valid(field.is_a?(Hash) && (field.keys - %w[type id attributes validations]).empty?, "#{path}: invalid field keys")
      attributes = field['attributes']
      require_valid(attributes.is_a?(Hash), "#{path}: missing attributes")
      if field['type'] == 'markdown'
        require_valid(attributes.keys == ['value'] && attributes['value'].is_a?(String) && !attributes['value'].strip.empty?, "#{path}: invalid markdown")
        require_valid(!field.key?('id') && !field.key?('validations'), "#{path}: markdown cannot collect input")
        next
      end
      require_valid(%w[input textarea].include?(field['type']), "#{path}: unsupported field type")
      id = field['id']
      require_valid(id.is_a?(String) && id.match?(/\A[a-zA-Z0-9_-]+\z/), "#{path}: invalid field ID")
      require_valid((attributes.keys - %w[label description placeholder render]).empty?, "#{path}: unsupported attributes")
      %w[label description].each do |key|
        require_valid(attributes[key].is_a?(String) && !attributes[key].strip.empty?, "#{path}: missing field #{key}")
      end
      require_valid(!attributes.key?('placeholder') || attributes['placeholder'].is_a?(String), "#{path}: placeholder must be a string")
      require_valid(!attributes.key?('render') || (field['type'] == 'textarea' && attributes['render'] == 'text'), "#{path}: invalid render")
      validations = field['validations']
      require_valid(validations.is_a?(Hash) && validations.keys == ['required'] && [true, false].include?(validations['required']), "#{path}: required must be boolean")
      fields << [id, field['type'], validations['required'], attributes['render']]
    end
    require_valid(fields.map(&:first).uniq.length == fields.length, "#{path}: duplicate field IDs")
    require_valid(fields.any? { |field| field[2] }, "#{path}: no required input")
    fields
  end

  def check_link(target, root, source)
    return if target.start_with?('#')

    if target.start_with?(DOCUMENT_URL)
      destination = File.join(root, target.delete_prefix(DOCUMENT_URL).split('#').first)
    else
      return if target.match?(/\A[a-z][a-z0-9+.-]*:/i) || target.start_with?('//')

      destination = File.expand_path(target.split('#').first, File.dirname(source))
    end
    require_valid(File.exist?(destination), "#{source}: missing link #{target}")
  end

  def check_markdown(text, root, source)
    text.scan(INLINE_LINK).each { |angle, plain| check_link(angle || plain, root, source) }
  end

  def check(root)
    labels = JSON.parse(File.read(File.join(root, '.github/labels.json'))).map { |label| label.fetch('name') }
    directory = File.join(root, '.github/ISSUE_TEMPLATE')
    expected = FORM_GROUPS.values.flat_map { |group| group[:files] } + ['config.yml']
    require_valid(Dir.children(directory).sort == expected.sort, 'Unexpected or missing issue templates')
    names = []
    FORM_GROUPS.each do |type, group|
      signatures = group[:files].map do |name|
        path = File.join(directory, name)
        form = yaml(path)
        fields = check_form(form, labels, path)
        require_valid(form['type'] == type, "#{path}: wrong issue type")
        require_valid(fields.select { |field| field[2] }.map(&:first).sort == group[:required].sort, "#{path}: required fields changed")
        names << form['name']
        form['body'].each do |field|
          field['attributes'].values_at('value', 'description').compact.each do |text|
            check_markdown(text, root, path)
          end
        end
        fields
      end
      require_valid(signatures.uniq.length == 1, "#{type}: Bilingual field mismatch")
    end
    require_valid(names.uniq == names, 'Duplicate form names')
    chooser = yaml(File.join(directory, 'config.yml'))
    require_valid(chooser.is_a?(Hash) && chooser.keys.sort == %w[blank_issues_enabled contact_links] && chooser['blank_issues_enabled'] == true, 'Keep blank issues available')
    links = chooser['contact_links']
    require_valid(links.is_a?(Array), 'Expected contact links')
    links.each do |link|
      require_valid(link.is_a?(Hash) && link.keys.sort == %w[about name url] && link.values.all? { |value| value.is_a?(String) && !value.strip.empty? }, 'Invalid contact link')
      require_valid(link['url'].match?(/\Ahttps?:\/\/[^\s]+\z/), 'Invalid contact URL')
      check_link(link['url'], root, File.join(directory, 'config.yml'))
    end
    require_valid((REQUIRED_CONTACTS - links.map { |link| link['url'] }).empty?, 'Wrong contact destinations')
    documents = Dir.glob(File.join(root, '**/*.md'), File::FNM_DOTMATCH).reject { |path| path.include?('/.git/') }
    documents.each do |path|
      check_markdown(File.read(path), root, path)
    end
    true
  end
end

if $PROGRAM_NAME == __FILE__
  CommunityChecks.check(File.expand_path('..', __dir__))
  puts 'PASS: issue forms, bilingual field contracts, labels, chooser and local documentation links'
end
