# escape=`

FROM buildtools as build


### Install packages and generate Find*.cmake files
COPY conan_files/profile.windows.conf /Users/ContainerAdministrator/.conan/profiles/windows
WORKDIR c:/code
COPY conan_files/conanfile.txt conan_files/conan.lock ./
RUN conan install . --build missing -pr:b=windows --profile=windows


### Copy source code
COPY . .
RUN cmake . -B build -G "Visual Studio 16 2019"
WORKDIR c:/code/build

### Build project with MSBuild
# We must invoke VsDevCmd.bat before using msbuild
# Otherwise, we'll get:
#  "C:\code\build\docker_windows_cpp.vcxproj" (default target) (1) ->
#          C:\code\build\docker_windows_cpp.vcxproj(32,3): error MSB4019: The imported project "C:\Program Files (x86)\Microsoft Visual 
# Studio\2022\BuildTools\MSBuild\Microsoft\VC\v170\Microsoft.Cpp.Default.props" was not found. Confirm that the expression in the Import declaration "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Microsoft\VC\v170\\Microsoft.Cpp.Default.props" is correct, and that the file exists on disk.

RUN VsDevCmd.bat && `
    msbuild /m docker_windows_cpp.vcxproj `
   		/p:Configuration=Release `
   		/p:Platform=x64 `
        -flp1:logfile=errors.txt;errorsonly -flp2:logfile=warnings.txt;warningsonly
WORKDIR c:/code/build/bin
ARG RUN_APP_CACHE_KEY=""
ENV RUN_APP_CACHE_KEY=${RUN_APP_CACHE_KEY}
RUN echo "Timestamp: %RUN_APP_CACHE_KEY%" && `
    .\docker_windows_cpp.exe
