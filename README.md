# scrapper
A scrapper that scrapes Sainsbury grocery site - Ripe Fruits page and returns a JSON array of all the products on the page

## To Install
    Run `pip install https://github.com/samuelbond/scrapper.git `

## To Install For Dev
   Run `git clone https://github.com/samuelbond/scrapper.git`
### Using Virtualenv
   If you don't have virtualenv you can install it using pip `pip install virtualenv`
        Run `mkdir scrapper_env`
        Run `virtualenv scrapper_env`
        Run `source bin/activate`
        Run `pip install -e scrapper`
        Run `nosetests scrapper`

### To Run Unit Test Without Virtualenv
        python scrapper/setup.py test

### To Run Cucumber BDD Test
   The cucumber test requires ruby >= 2.0, for more info on installing visit https://www.ruby-lang.org/en/documentation/installation
        Run `cd scrapper/component-test/cucumber`
        Run `bundle install` if you don't have bundler you can install it by running `gem install bundler`
        Run `./test`
