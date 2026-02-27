# QAtlas.jl

[![docs: stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://codes.sota-shimozono.com/QAtlas.jl/stable/)
[![docs: dev](https://img.shields.io/badge/docs-dev-purple.svg)](https://codes.sota-shimozono.com/QAtlas.jl/dev/)
[![Julia](https://img.shields.io/badge/julia-v1.12+-9558b2.svg)](https://julialang.org)
[![Code Style: Blue](https://img.shields.io/badge/Code%20Style-Blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

[![codecov](https://codecov.io/gh/sotashimozono/QAtlas.jl/graph/badge.svg?token=dnvvwd7DVo)](https://codecov.io/gh/sotashimozono/QAtlas.jl)
[![Build Status](https://github.com/sotashimozono/QAtlas.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/sotashimozono/QAtlas.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

QAtlas (QUAntum Reference Table for Exact Tests) is a Julia package providing a standardized "Ground Truth" database for benchmarking numerical methods in quantum many-body systems.

When developing new algorithms like DMRG, TEBD, or Tensor Network methods, verifying the results against known values often involves scouring old papers or re-implementing Exact Diagonalization (ED) scripts. QAtlas.jl streamlines this process by providing instant access to high-precision reference data.

## 🚀 Key Features

- Curated Reference Data: Access exact results from ED, analytical solutions, and high-precision literature values.
- Seamless Integration: Retrieve data directly into your Julia environment for unit testing or convergence analysis.
- Comprehensive Metadata: Every data point includes information on the source (DOI), numerical precision, and the method used.
- Model Agnostic: Focuses on results rather than construction, making it compatible with any external Hamiltonian builder or simulation suite.
