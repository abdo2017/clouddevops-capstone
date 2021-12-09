docker-build: docker build . -t clouddevops-make

tidy-html: tidy -q -e *.html

check-dockerfile: hadolint Dockerfile