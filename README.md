# Movie Watch List

A Rails app for building and curating personal movie watch lists. Users sign up, create named lists (e.g. "Comedy", "Horror"), search for movies via TMDB, and bookmark them into a list with a personal comment.

## Features

- **Accounts** — sign up / log in / edit profile via Devise; lists belong to the signed-in user
- **Lists** — create named watch lists with a cover image (falls back to a placeholder if none given)
- **Movie search** — search TMDB for a movie right from a list's page; results are cached locally as `Movie` records on first lookup
- **Bookmarks** — add a movie to a list with a short comment (min. 6 characters); a movie can only appear once per list

## Tech stack

- Ruby 3.3.5 / Rails 8.1, PostgreSQL
- Hotwire (Turbo + Stimulus), importmap (no JS bundler)
- Bootstrap 5.3 (gem) + `simple_form` for forms
- Devise for authentication
- RSpec for testing (specs live in `spec/`, an external git submodule)
