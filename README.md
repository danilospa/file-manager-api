# File Manager API

## Dependencies

- Ruby 2.5.1
- Elasticsearch 6.2.4

## How to setup

First of all, make sure you have the correct Ruby version installed. Then, install bundler and project dependencies.
```bash
gem install bundler
bundle -j4
```

Copy configuration file example and fill elasticsearch host and port:
```bash
cp .env.example .env
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

To run tests and watch for file changes:
```bash
bundle exec guard
```

## Request examples

```bash
curl -X POST "http://localhost:3000/file" -H 'content-type: application/json' --data '{"name":"file1","tags":["tag1","tag2","tag3","tag5"]}'
curl -X POST "http://localhost:3000/file" -H 'content-type: application/json' --data '{"name":"file2","tags":["tag2"]}'
curl -X POST "http://localhost:3000/file" -H 'content-type: application/json' --data '{"name":"file3","tags":["tag2","tag3","tag5"]}'
curl -X POST "http://localhost:3000/file" -H 'content-type: application/json' --data '{"name":"file4","tags":["tag2","tag3","tag4","tag5"]}'
curl -X POST "http://localhost:3000/file" -H 'content-type: application/json' --data '{"name":"file5","tags":["tag3","tag4"]}'
curl "http://localhost:3000/files/+tag2%20+tag3%20-tag4/1"
```
