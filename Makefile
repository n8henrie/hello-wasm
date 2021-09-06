all: build open

.PHONY: build
build: pkg/*.js

pkg/*.js: src/lib.rs executable-deps
	wasm-pack build --target web

.PHONY: executable-deps
executable-deps:
	@command -v wasm-pack >/dev/null || cargo install wasm-pack

.PHONY: open
open:
	bash -c '\
		trap "kill 0" INT; \
		python3 -m http.server 8080 & \
		open "http://localhost:8080"; \
		wait; \
		'

.PHONY: clean
clean:
	rm -rf ./pkg
	cargo clean
