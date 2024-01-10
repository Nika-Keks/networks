clean:
	rm \
	lab*/*/*.aux \
	lab*/*/*.fdb_latexmk \
	lab*/*/*.fls \
	lab*/*/*.out \
	lab*/*/*.gz \
	lab*/*/*.toc \
	lab*/*/*.log \
	lab*/*/*.lof \
	lab*/*/*.dat


readme:
	cd $(lab)/doc && pandoc -s -f latex -t markdown $(lab).tex -o ./../README.md

report:
	cd $(lab)/doc && pdflatex $(lab).tex


