# SHRTNR
_the URL shortener_

### Preparation:
1. Clone this repo:
```sh
$ git clone git@github.com:gryaznov/shrtnr.git
$ cd shrtnr
```
2. Create `config/database.yml` file and fill it with your own DB credentials (see `config/database.yml.example` for a reference).
3. Install dependencies:
```
$ bundle install
```
4. Create development and test databases:
```
$ rake db:create db:migrate db:test:prepare
```
5. Run tests (optional):
```
$ rspec spec
```
6. Run webpack's build:
```
$ ./bin/webpack
```
7. Run rails server:
```
$ rails s
```
Application is awailable at `localhost:3000` now.
#### Post sciptum:
Of course, there is dozens of things which can be done/added: associate URLs with user and show it to them on demand; make the application 100% SPA with all requests/responses fully async; implement more presice validations and safety checks; add live previews of URLs, etc. But I am not sure how much time should be dedicated to this task and, after all, it is just a test task, so, I'll leave it to the future.
