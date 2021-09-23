# Github public repos fetcher

A simple one page app to search public repos on Github.

### How to use

1. To set up the project run `bundle` in the projects directory
2. Launch the server `bundle exec rails s`
3. Go to `http://localhost:3000/` and enter a name that a repository you're looking for contains. You can also use
   operators  `AND`, `OR`, or `NOT` to precise your search. Names bigger than 256 characters won't be searched.
4. The Project's main logic is in `app/services` directory, please proceed there to see more.
5. To run project's unit tests do `bundle exec rspec`.