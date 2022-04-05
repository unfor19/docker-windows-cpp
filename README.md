# docker-windows-cpp

This project is based on this example - https://github.com/ttroy50/cmake-examples/tree/master/07-package-management/D-conan/ii-basic-targets

## Requirements

1. Windows 10+
2. [Docker Windows Desktop](https://docs.docker.com/get-docker/)
3. [Windows Git Bash](https://gitforwindows.org/)
4. [Chocolatey](https://chocolatey.org/) - Windows package manager
5. [make](https://www.gnu.org/software/make/manual/make.html) - To be able to use the [Makefile](./Makefile)
   ```powershell
   # Elevated (Run as Administrator)
   choco install -y --no-progress --limitoutput make
   ```

## Getting Started

1. Build [Dockerfile.buildtools](./Dockerfile.buildtools)
   ```bash
   make docker-build-buildtools
   # Successfully tagged buildtools:latest   
   ```
1. Build [Dockerfile.app](./projects/Dockerfile.app)
   ```bash
   make docker-build-app
   "Timestamp: 1649119792" 
   Hello, world!
   !עולם, שלום
   ```

## Thoughts

- [BuildKit is not supported on Windows](https://github.com/microsoft/Windows-Containers/issues/34), hence `docker build --target mytarget .` won't build targets in parallel, so I split my Dockerfile into to files
  1. [Dockerfile.buildtools](./Dockerfile.buildtools) - The base image includes all relevant software and libraries to build a C++ application with:
     - [CMake 3.18.2](https://cmake.org/cmake/help/latest/release/3.18.html)
     - [MSVC](https://code.visualstudio.com/docs/cpp/config-msvc) 
     - [Conan](https://conan.io/) - package manager, like [chocolatey](https://chocolatey.org/), [pip](https://pypi.org/project/pip/), [npm](https://www.npmjs.com/), [brew](https://brew.sh/), etc.
  2. [Dockerfile.app](Dockerfile.app)
