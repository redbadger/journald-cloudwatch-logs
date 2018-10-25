SOURCES := go.mod go.sum $(shell find . -type f -name "*.go" -not -path "./target/*")
TARGET := target/journald-cloudwatch-logs-linux-amd64
CHECKSUM := $(TARGET:=.sha256)
SIGNATURE := $(TARGET:=.asc)

$(TARGET): $(SOURCES)
	@cd build && docker-compose run --rm build

$(CHECKSUM): $(TARGET)
	@(cd $(dir $<); shasum --algorithm 256 $(notdir $<)) > $@

$(SIGNATURE): %.asc: %
	@gpg --batch --yes --armor --detach-sig --output $@ $<

build: $(TARGET)

clean:
	@[ -d target ] && chmod -R u+w target && rm -R target || true
	@cd build && docker-compose down --rmi local --volumes

release: $(CHECKSUM) $(SIGNATURE)

.DEFAULT_GOAL := build
.PHONY: build clean release
