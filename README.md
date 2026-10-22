# Xova GitHub configuration

Organization profile and community defaults for [Xova](https://github.com/xova-dev).

Reusable workflows and release tooling live in [xova-dev/actions](https://github.com/xova-dev/actions). See its [project workflow guide](https://github.com/xova-dev/actions/blob/main/docs/project-workflows.md) for integration.

- Organization profile: [`profile/README.md`](profile/README.md)
- Issue forms and chooser: [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE/) (Chinese and English)
- Pull request template: [`.github/PULL_REQUEST_TEMPLATE.md`](.github/PULL_REQUEST_TEMPLATE.md) (bilingual)
- Contributing: [English](CONTRIBUTING.md) / [简体中文](CONTRIBUTING.zh-CN.md)
- Support and project navigation: [`SUPPORT.md`](SUPPORT.md) (bilingual)
- Private vulnerability reporting policy: [`SECURITY.md`](SECURITY.md) (bilingual)
- Shared label definitions: [`.github/labels.json`](.github/labels.json)

## Organization defaults

Once published on the default branch of this public `.github` repository, supported community health files serve as defaults for repositories without their own corresponding files. A repository's own issue templates or issue template configuration replace the entire default issue template set rather than merging with it.

The English `CONTRIBUTING.md` is the default entry point and links explicitly to the Chinese guide in this repository. Contributors may use either language.

`labels.json` records twelve shared labels: nine general labels and three priority labels, with colors and bilingual descriptions. It is a reference manifest, not a GitHub-native configuration file, and does not synchronize labels automatically. Configure organization default labels separately for newly created repositories. Existing repositories require a separate, explicitly scoped update; do not delete existing labels without reviewing their usage.

The `bug` and `enhancement` labels must exist in repositories using the issue forms for automatic labeling to work. Forms also select the organization issue types `Bug` and `Feature`; keep those types enabled. Priority remains a maintainer decision. Numbered filenames keep each language pair together in the chooser; blank issues remain available for questions and documentation feedback.

## Security settings

The organization configuration **Private vulnerability reporting** enables private reports for public repositories and is the default for newly created public repositories. Other feature controls are **Not set**, and enforcement is off. Existing public repositories must have the configuration applied; check transferred repositories separately. The policy file alone does not enable reporting.

Use GitHub's default vulnerability report form. Maintainers should verify their repository **Watch → Custom → Security alerts** subscription and personal email notification preferences; this repository does not configure personal notifications. No CWE requirement, response deadline or bounty is imposed by the organization policy.

## Validation

Run `ruby scripts/check-community.rb` using Ruby's standard library; no dependency installation is needed. The check validates the supported issue-form structure, unique field IDs, bilingual field parity, label references, chooser configuration and local documentation links. It is a repository-specific check, not a replacement for GitHub's own validation. Run `ruby tests/check-community-test.rb` for regression tests using Minitest. The repository's check workflow runs both commands on pull requests and pushes to main; it does not publish or change organization settings.

After publishing to the default branch, open a consuming repository's **New issue** chooser and preview all four forms without submitting an issue. Verify ordering, types, labels, required fields and attachments; confirm security and support links work. Local checks do not establish GitHub UI rendering or real private report delivery.

References: [default community health files](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file), [organization default labels](https://docs.github.com/en/organizations/managing-organization-settings/managing-default-labels-for-repositories-in-your-organization).
