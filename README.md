# TDD app

Follow this instructions to get the project running.

 

* Install Ruby version
  * 2.7.0

* Install Rails version
  * 5.1.7
* To generate the rails app with a specific version

  ```bash
  rails _5.1.7_ new tdd_app
  ```

* Configuration
  * Insert this lines to your `config/application.rb`

    ```ruby
    config.generators do |g|
          g.test_framework :rspec,
            fixtures: false,
            view_specs: false,
            helper_specs: false,
            routing_specs: false
    end
    ```

* gems to install

  ```ruby

  group :development, :test do
    gem 'rspec-rails', '~> 3.6'
    gem 'capybara'
  end

  group :development do
    gem 'spring-commands-rspec'
  end
  ```

*  Then run

  ```bash
  bundle install
  ```

* and then

  ```bash
  bundle exec spring binstub rspec
  ```

- Database creation

  ```bash
  rails db:create:all db:migrate
  ```
* How to run the test suite

  ```bash
  bin/rspec

  # or

  rspec
  ```

*


