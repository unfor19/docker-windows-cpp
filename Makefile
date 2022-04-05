.EXPORT_ALL_VARIABLES:
GIT_COMMIT_SHORT=$(shell git rev-parse --short=7 HEAD)
TIMESTAMP=$(shell date +%s)


help:                           ## Available make commands
#----                           ##------------------------
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's~:~~' | sed -e 's~##~~'

usage: help

docker-build-buildtools:     ## Docker build the visualstudio2019 buildtools image
	docker build -f Dockerfile.buildtools -t buildtools:${GIT_COMMIT_SHORT} -t buildtools:latest .

docker-build-app:                 ## Docker build the base image of the app, includes conan cache
	docker build -f projects/Dockerfile.app --build-arg RUN_APP_CACHE_KEY=${TIMESTAMP} -t docker-windows-cpp:build-app-base-$(GIT_COMMIT_SHORT) projects
