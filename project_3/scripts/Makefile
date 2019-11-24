.PHONY: project_3
project_3: Dockerfile.Pythonscript Dockerfile.Rscript
	docker image build -f Dockerfile.Pythonscript .
	docker image build -f Dockerfile.Rscript .
	Rscript Project_3_Rscript.R
	python Project_3_PythonScript.py
