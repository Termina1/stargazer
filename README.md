Stargazer
=========

Simple full-text search through your starred repos on github.

One day I just got tired of Github's search through your starred repos and wrote my own implementation.
It consists of two apps:

1. Repo indexer written in Go [https://github.com/Termina1/startlight](startlight)</a>
2. Front end written in Rails

Used Rails 4.1 and Ruby 2.1.

Built on top of [http://www.mongodb.org/](MongoDB) for persistence and [http://redis.io/](Redis) for Pub/Sub.

## Config in secrets.yml

1. github_client: Client id for github app
2. github_secret: Client secret for github app
3. redis_channel: Pub/sub channel for Redis
