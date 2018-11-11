# File Manager API

## Considerations

At a first moment, I though about using database to store the file name and tags. Although, when I started thinking about implementing the search endpoint, I realize it would be complex to create a query to retrieve the desired information. So I decided to facilitate things and let a search engine to the job, I used Elasticsearch. Since this is a simple application, I also decided to remove the database at all, relying only on Elasticsearch storage.

I would call the model that represents the file as `File`, but it would conflict with the built in Ruby class. That's why I used the `FileResource` name instead. The `resources/` folder is not related at all with the `FileResource` class. This directory contains files that represents the endpoint responses. Ideally, in order to keep the pattern, the response for the POST endpoint would be a class on this folder too. A better name for `FileResource` would also be appreciated to avoid this possible confusion.

Despite the test description introduces an `application that allows users to upload files`, I assumed no file upload feature would be needed because the API specifications does not describe an endpoint to actually upload a file. But in case it was needed, I would upload the files to AWS S3 using the aws-sdk.

To keep things simple and avoid exceeding more time, I developed the `related_tags` response for the search endpoint considering only the returned results from the requested page. Otherwise, it would need other request to Elasticsearch to retrieve all tags from all results, without pagination.

The following are some things I would develop if I had no time limit:
- Parameter validation to ensure correctness (validate `-+ ` chars for POST endpoint and `+-` signals for query on GET endpoint).
- Unit tests to resource and service.

## Dependencies

- Ruby 2.5.1
- Elasticsearch 6.2.4

## How to develop

First of all, make sure you have the correct Ruby version installed. Then, install bundler and project dependencies.
```bash
gem install bundler
bundle -j4
```

Copy configuration file example and fill elasticsearch host and port:
```bash
cp .env.example .env
```

Before starting the server, you should execute Elasticsearch. The easiest way is to run through docker:
```bash
docker run -it -p 9200:9200 docker.elastic.co/elasticsearch/elasticsearch:6.2.4
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

## How to use

You can setup the project manually as described on [How to Develop](https://github.com/danilospa/file-manager-api#how-to-develop) section.  
Or you can use `docker-compose`:
```bash
docker-compose up -d
```
