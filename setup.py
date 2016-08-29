try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

config = {
    'name': 'Scrapper',
    'version': '1.0',
    'description': 'A scrapping tool',
    'packages': ['scrapper','scrapper.exceptions'],
    'url': 'https://github.com/samuelbond/scrapper',
    'author': 'Samuel Amaziro',
    'author_email': 'samuelizuchi@gmail.com',
    'long_description': 'A scrapper that scrapes Sainsbury grocery site - Ripe Fruits page and returns a JSON array of all the products on the page',
    'install_requires': [
        'requests',
        'lxml',
        'hurry.filesize',
        'simplejson',
        'mock',
        'requests_mock',
        ],
    'scripts': ['bin/scrapper']
}

setup(**config)
