.PHONY: project_3
project_3:
	docker image build -f Dockerfile.PythonScript .
	docker image build -f Dockerfile.RScript .
	Rscript Project_3_Rscript.R
	python Project_3_PythonScript.py
