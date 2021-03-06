check:
	pep8 eradicate eradicate.py setup.py
	pep257 eradicate eradicate.py setup.py
	pylint --report=no --include-ids=yes --disable=C0103,R0911,R0914,W0404,W0622 --rcfile=/dev/null eradicate.py setup.py
	python setup.py --long-description | rst2html --strict > /dev/null
	scspell eradicate eradicate.py setup.py test_eradicate.py README.rst

coverage:
	@rm -f .coverage
	@coverage run test_eradicate.py
	@coverage report
	@coverage html
	@rm -f .coverage
	@python -m webbrowser -n "file://${PWD}/htmlcov/index.html"

mutant:
	@mut.py --disable-operator RIL -t eradicate -u test_eradicate -mc

readme:
	@restview --long-description

register:
	@python setup.py register sdist upload --repository=https://pypi.python.org/pypi
	@srm ~/.pypirc
