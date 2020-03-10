jupyter:

	jupyter nbconvert --to markdown --output-dir . --NbConvertApp.output_files_dir=libs \
	    analysis/python-re.ipynb

	Rscript code/build-jupyter-notebook.R

cookbook:

	Rscript code/build.R

python-learning_notes0:

	Rscript code/build-python-learning_notes.R

python-learning_notes: jupyter cookbook clean push

readme:

	Rscript code/build-readme.R

push:

	Rscript code/push.R

copy:

	Rscript code/copy-md.R

clean:

	Rscript code/clean.R

all: jupyter cookbook clean push
