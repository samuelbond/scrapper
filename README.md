# scrapper
A scrapper that scrapes Sainsbury's grocery site - Ripe Fruits page and returns a JSON array of all the products on the page

## To Install
   Run `pip install https://github.com/samuelbond/scrapper.git `

   If you don't have pip installed, visit https://pip.pypa.io/en/stable/installing/ for more info on installing pip

## To Install For Dev
   Run `git clone https://github.com/samuelbond/scrapper.git`

### Using virtualenv
   If you don't have virtualenv you can install it using pip `pip install virtualenv`

        Run mkdir scrapper_env
        Run virtualenv scrapper_env
        Run source scrapper_env/bin/activate

#### To install
   Run `pip install -e scrapper`

#### To run scrapper
   Run `python scrapper/bin/scrapper`
   Or Run `chmod +x scrapper/bin/scrapper` and then `./scrapper/bin/scrapper`

### To run Unit Test
        nosetests scrapper/

### To Run Cucumber BDD Test
   The cucumber test requires ruby >= 2.0, for more info on installing visit https://www.ruby-lang.org/en/documentation/installation

        Run cd scrapper/component-test/cucumber
        Run bundle install
   if you don't have bundler you can install it by running `gem install bundler`
        Run `./test`

   If you run into any permissions issue then you might need to run `sudo ./test` instead

### Known Issues
   When running `bundle install` on Ubuntu, there might be an error regarding sqlite, to resolve this issue
   Run `apt-get install libsqlite3-dev` and then re-run `bundle install`

