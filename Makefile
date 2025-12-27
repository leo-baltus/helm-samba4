# Makefile for releasing
# usage:
# TAG=x.y.z make version-set
# <<final check in>>
# make release

TAG?=latest
VERSION:=$(shell cat VERSION)

version-set:
	@next="$(TAG)" && \
	current="$(VERSION)" && \
	sed -i '' "s/$$current/$$next/g" VERSION && \
	sed -i '' "s/tag: $$current/tag: $$next/g" samba4/values.yaml && \
	sed -i '' "s/appVersion: $$current/appVersion: $$next/g" samba4/Chart.yaml && \
	sed -i '' "s/version: $$current/version: $$next/g" samba4/Chart.yaml && \
	echo "Version $$next set"

release:
	git tag -s -m $(VERSION) $(VERSION)
	git push origin $(VERSION)

delete-tag:
	git tag -d $(VERSION)
	git push --delete origin $(VERSION)



