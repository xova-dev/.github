# Xova GitHub configuration

Shared GitHub metadata, organization defaults, and reusable workflows for [Xova](https://github.com/xova-dev).

This repository is maintained as organization infrastructure rather than as a standalone product.

- Organization profile: [`profile/README.md`](profile/README.md)
- Issue templates: [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE/) (Chinese and English)
- Pull request template: [`.github/PULL_REQUEST_TEMPLATE.md`](.github/PULL_REQUEST_TEMPLATE.md) (bilingual)
- Contributing: [English](CONTRIBUTING.md) / [简体中文](CONTRIBUTING.zh-CN.md)
- Shared label definitions: [`.github/labels.json`](.github/labels.json)
- npm publishing workflow: [`.github/workflows/npm-publish.yml`](.github/workflows/npm-publish.yml)
- npm publishing guide: [`docs/npm-publishing.md`](docs/npm-publishing.md)

## Organization defaults

Once published on the default branch of this public `.github` repository, supported community health files serve as defaults for repositories without their own corresponding files. A repository's own issue templates or issue template configuration replace the entire default issue template set rather than merging with it.

The English `CONTRIBUTING.md` is the default entry point and links explicitly to the Chinese guide in this repository. Contributors may use either language.

`labels.json` records the nine agreed label names, colors, and bilingual descriptions. It is a reference manifest, not a GitHub-native configuration file, and does not synchronize labels automatically. Configure organization default labels separately for newly created repositories. Existing repositories require a separate, explicitly scoped update; do not delete existing labels without reviewing their usage.

The `bug` and `enhancement` labels must exist in repositories using the issue templates for automatic labeling to work.

References: [default community health files](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file), [organization default labels](https://docs.github.com/en/organizations/managing-organization-settings/managing-default-labels-for-repositories-in-your-organization).
