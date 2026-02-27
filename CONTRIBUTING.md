# Contributing to LatBench.jl

Thank you for your interest in LatBench! We welcome contributions to improve this reference database.

## Design Philosophy

- **Core focused**: The core package remains lightweight, prioritizing analytical results and universal properties.
- **Interface-based**: Numerical results from specific papers should ideally be implemented as external extensions or provided via Artifacts.

## How to Contribute

1. **Adding Aliases**: If you find missing common names for models or quantities, please update `src/core/alias.jl`.
2. **Adding Theories**: New analytical results for universality classes should go into `src/universalities/`.
3. **Bug Reports**: If you find a discrepancy between the implemented values and the literature, please open an issue with the reference (APA style preferred).

## Development Workflow

- Please ensure that `julia --project -e 'using Pkg; Pkg.test()'` passes before submitting a PR.
- Update the version in `Project.toml` if your change adds new features or fixes bugs.
