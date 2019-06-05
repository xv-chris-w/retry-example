virtualtest: requirements.txt
	@python3 -m venv virtualtest --prompt vtest
	@(source virtualtest/bin/activate && pip install -r requirements.txt)