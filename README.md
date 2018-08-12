# README

* Ruby version 2.5.1

* Configuration

```bash
cp .env.example .env.development
```

Update `RAILS_ENV` `DATABASE_URL` variables in `.env.development` file.

* Database creation

```bash
rake db:create
rake db:migrate
```

* How to run package updater manually

```bash
rails c
```

```ruby
UpdatePackagesObserverJob.perform_now
```


* How to run application

```bash
rails s
```


* How to run the test suite

```bash
rubocop && rspec
```
