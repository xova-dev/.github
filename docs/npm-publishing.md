# npm publishing

Project repositories can call the organization-level reusable workflow:

```yaml
name: Publish

on:
  release:
    types: [published]
  workflow_dispatch:

permissions:
  contents: read
  id-token: write

jobs:
  publish:
    uses: xova-dev/.github/.github/workflows/npm-publish.yml@v1
```

Configure npm Trusted Publishing separately for each package:

- Organization: `xova-dev`
- Repository: the project repository
- Workflow filename: `publish.yml`
- Environment: `npm-publish`

The shared workflow uses GitHub OIDC and intentionally does not require `NPM_TOKEN` or `NODE_AUTH_TOKEN`.
Projects should commit a `mise.toml` containing the Node.js and pnpm versions used by development and CI.
The package should also declare its pnpm version through the `packageManager` field in `package.json`.
It also runs verification before publishing by default; projects can override the workflow inputs when needed.
