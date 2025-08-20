.PHONY: build

compileSlides:
	@echo "Compiling all slides using marp..."
	@find content/slides/ -type f -name "index.md" | while read file; do \
			folder_name=$$(basename "$$(dirname "$$file")"); \
			if [ "$$folder_name" != "slides" ]; then \
				echo "Converting $$file to static/slides/$$folder_name.pdf"; \
				marp -c .marprc.yml -o "static/slides/$$folder_name.pdf" "$$file"; \
			fi \
		done

serve: compileSlides
	@echo "Preview website server"
	@zola serve

build: compileSlides
	@zola build

clean:
	@rm -rf public/
