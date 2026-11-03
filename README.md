# Xova GitHub configuration

Organization profile and community defaults for [Xova](https://github.com/xova-dev).

Reusable workflows and release tooling live in [xova-dev/actions](https://github.com/xova-dev/actions). See its [project workflow guide](https://github.com/xova-dev/actions/blob/main/docs/project-workflows.md) for integration.

- Organization profile: [`profile/README.md`](profile/README.md)
- Issue forms and chooser: [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE/) (two bilingual forms)
- Pull request template: [`.github/PULL_REQUEST_TEMPLATE.md`](.github/PULL_REQUEST_TEMPLATE.md) (bilingual)
- Contributing: [English](CONTRIBUTING.md) / [简体中文](CONTRIBUTING.zh-CN.md)
- Support and project navigation: [`SUPPORT.md`](SUPPORT.md) (bilingual)
- Private vulnerability reporting policy: [`SECURITY.md`](SECURITY.md) (bilingual)
- Optional PR labels: [`.github/labels.json`](.github/labels.json)

## Organization defaults

Once published on the default branch of this public `.github` repository, supported community health files serve as defaults for repositories without their own corresponding files. A repository's own issue templates or issue template configuration replace the entire default issue template set rather than merging with it.

The English `CONTRIBUTING.md` is the default entry point and links explicitly to the Chinese guide in this repository. Contributors may use either language.

`labels.json` lists four optional PR labels with bilingual descriptions: `bug`, `enhancement`, `documentation` and `dependencies`. Use them only for filtering or automation. This reference manifest does not synchronize or delete GitHub labels. Review workflow, bot and release dependencies before cleaning up existing labels.

Two bilingual issue forms select `Bug` or `Feature` without labels; keep these organization types enabled. Each form uses English / Chinese labels and short bilingual descriptions; contributors may answer in either language. Maintainers use the native `Priority` field. Dates and effort are optional. Numbered filenames put Bug before Feature; blank issues remain available for other work.

Keep native names stable and use short bilingual descriptions in organization settings:

| Type / field | Description |
| --- | --- |
| Bug | Unexpected behavior / 行为异常 |
| Feature | New capability or improvement / 新功能或改进 |
| Task | Other concrete work / 其他具体工作 |
| Priority | Work order, not severity / 处理顺序，非严重程度 |
| Start date | Planned start / 计划开始日期 |
| Target date | Planned completion / 计划完成日期 |
| Effort | Estimated work / 预估工作量 |

Priority options: `Urgent` — Immediate attention / 立即处理; `High` — Address next / 优先处理; `Medium` — As planned / 按计划处理; `Low` — When capacity allows / 有余力再处理. Unset means not yet prioritized. Organization settings are managed separately; this repository does not apply them.

## Security settings

The organization configuration **Private vulnerability reporting** enables private reports for public repositories and is the default for newly created public repositories. Other feature controls are **Not set**, and enforcement is off. Existing public repositories must have the configuration applied; check transferred repositories separately. The policy file alone does not enable reporting.

Use GitHub's default vulnerability report form. Maintainers should verify their repository **Watch → Custom → Security alerts** subscription and personal email notification preferences; this repository does not configure personal notifications. No CWE requirement, response deadline or bounty is imposed by the organization policy.

## Validation

Run `ruby scripts/check-community.rb` using Ruby's standard library; no dependency installation is needed. The check validates the supported issue-form structure, unique field IDs, required fields, chooser configuration and local documentation links. It is a repository-specific check, not a replacement for GitHub's own validation. Run `ruby tests/check-community-test.rb` for regression tests using Minitest. The repository's check workflow runs both commands on pull requests and pushes to main; it does not publish or change organization settings.

After publishing to the default branch, open a consuming repository's **New issue** chooser and preview both forms without submitting an issue. Verify ordering, bilingual text, types, required fields and attachments, and that forms add no labels; confirm security and support links work. Local checks do not establish GitHub UI rendering or real private report delivery.

Forms, required field sets and required contact destinations are declared together in the checker. Forms cannot set labels; fields may be reordered. Additional contact links are allowed as long as the support and security destinations remain present.

Link checks cover inline links in Markdown documents and issue-form introductions/descriptions, plus contact URLs targeting this repository. Plain and angle-bracket destinations and optional quoted or parenthesized titles are supported. This is not a full Markdown parser: reference-style links, anchor existence and external URL availability are not checked.

References: [default community health files](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file), [organization default labels](https://docs.github.com/en/organizations/managing-organization-settings/managing-default-labels-for-repositories-in-your-organization).
