FatSecret
=========

Introduction
------------

A ruby wrapper for the FatSecret API. Currently only supports the foods.search and food.get methods, but I will add more when I have the need/time. Alternatively please feel free to send a tested pull request.

Prerequisits
------------

Get your api key and oauth tokens by signing up for an account with FatSecret at http://platform.fatsecret.com/api/Default.aspx?screen=r


Installation
------------

Bundler:

`gem 'fat_secret'`

Otherwise:

`gem install fat_secret`


Setup
-----

```ruby
FatSecret.configure do |config|
  config.access_key = <your access key>
  config.consumer_key = <your consumer key>
  config.shared_secret = <your shared secret>
  config.logger = <your logger> (OPTIONAL)
end
```

Searching for Food
------------------

```ruby
foods = FatSecret::Food.search('Milk')
```

Getting 1 Food
--------------

```ruby
food = FatSecret::Food.get(id)
food.servings (automatically lazy loaded for you)
```


Development
-----------

```
git clone git://github.com/mattbeedle/FatSecret.git
cd FatSecret
bundle install
```

Then add your own api keys to the `spec/support/helpers.rb` file before running the specs with

```
bundle exec rspec
```
