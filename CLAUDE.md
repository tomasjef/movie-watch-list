# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
bin/setup                          # install deps, create/migrate DB
bin/dev                            # start dev server
bin/rails db:migrate               # run migrations
bin/rails db:seed                  # seed movies from TMDB API
bundle exec rspec                  # run all tests
bundle exec rspec spec/models/bookmark_spec.rb  # run a single spec file
bin/rubocop                        # lint (rubocop-rails-omakase style)
bin/brakeman                       # static security analysis
```

## Architecture

Rails 8.1 app (Ruby 3.3.5) using PostgreSQL, Hotwire (Turbo + Stimulus), importmap (no JS bundler), Bootstrap 5.3 via gem, and `simple_form`.

### Domain model

Three core tables:

- **Movie** — read-only data seeded from the TMDB API (`https://tmdb.lewagon.com/movie/top_rated`). Fields: `title`, `overview`, `poster_url`, `rating`. Unique by title.
- **List** — a named watch list. Unique by name.
- **Bookmark** — join between `Movie` and `List`, carrying a `comment` (min 6 chars). The `(movie_id, list_id)` pair is unique, so a movie can only be bookmarked once per list.

```
List ──< Bookmark >── Movie
```

### Routes

```
GET  /lists              lists#index
GET  /lists/:id          lists#show
GET  /lists/new          lists#new
POST /lists              lists#create
GET  /lists/:list_id/bookmarks/new   bookmarks#new
POST /lists/:list_id/bookmarks       bookmarks#create
DELETE /bookmarks/:id                bookmarks#destroy
```

Root is `lists#index`.

### Tests

RSpec with `rails-controller-testing`. Specs live in `spec/` as a git submodule. Controller specs use `assigns()` (enabled by `rails-controller-testing`). Transactional fixtures are on; no factory gem — specs use `let` with `Model.create!` directly.
