# Makefile for releasing
# usage:
# TAG=x.y.z make version-set
# make release

TAG?=latest
VERSION:=$(shell cat VERSION)

version-set:
	@next="$(TAG)" && \
	current="$(VERSION)" && \
	/usr/bin/sed -i '' "s/$$current/$$next/g" VERSION && \
	/usr/bin/sed -i '' "s/tag: $$current/tag: $$next/g" samba4/values.yaml && \
	/usr/bin/sed -i '' "s/appVersion: $$current/appVersion: $$next/g" samba4/Chart.yaml && \
	/usr/bin/sed -i '' "s/version: $$current/version: $$next/g" samba4/Chart.yaml && \
	echo "Version $$next set in chart"

release:
	git tag -s -m $(VERSION) $(VERSION)
	git push origin $(VERSION)



