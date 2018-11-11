# File Manager API

## Dependencies

- Ruby 2.5.3
- Elasticsearch 6.2.4

## How to setup

First of all, make sure you have the correct Ruby version installed. Then, install bundler and project dependencies.
```bash
gem install bundler
bundle install -j4
```

Start up the server:
```
bundle exec puma
```

It will listen on port 3000.

To run the linter:
```bash
bundle exec rubocop
```

To run tests:
```bash
bundle exec rspec
```
