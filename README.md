# README

Advent of Code is an Advent calendar of small programming puzzles, see https://adventofcode.com/2022/about.

## Environment

We're using docker.

    docker compose build

Then

    docker compose up

To get to a terminal

    docker exec -it ruby3 /bin/bash

## Running test(s)

In a terminal, invoke ruby with a filename argument

    ruby ./test/test_foo.rb

As long as the test has `require "minitest/autorun"`, the tests should automatically run with results on standard out.
