install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	python -m pytest -vv test_main.py --cov=main --cov-report term-missing

format:
	black *.py
  
lint:
	pylint --disable=R,C *.py
  
run:
	#python main.py

run-uvicorn:
	#uvicorn main:app --reload

killweb:
	#sudo killall uvicorn

all: install lint format
