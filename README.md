# crazy-train

[![crazy-train](https://github.com/galactic-filament/crazy-train/actions/workflows/crazy-train.yml/badge.svg)](https://github.com/galactic-filament/crazy-train/actions/workflows/crazy-train.yml)
[![codecov](https://codecov.io/gh/galactic-filament/crazy-train/branch/main/graph/badge.svg?token=28OR37KWWY)](https://codecov.io/gh/galactic-filament/crazy-train)

## Libraries

| Kind                  | Name                                                   |
|-----------------------|--------------------------------------------------------|
| Web Framework         | [Ruby on Rails](https://rubyonrails.org/)              |
| SQL ORM               | [ActiveRecord](https://rubygems.org/gems/activerecord) |
| Logging               | stdlib                                                 |
| Test Framework        | [Minitest](https://github.com/seattlerb/minitest)      |
| Test Coverage         | [Simplecov](https://github.com/colszowka/simplecov)    |
| Version Management    | [rbenv](https://github.com/rbenv/ruby-build)           |
| Dependency Management | [bundler](https://bundler.io/)                         |
| Linting/Formatting    | [Rubocop](https://rubocop.org/)                        |

## Features Implemented

### Functionality
- [x] Hello world routes
- [ ] CRUD routes for persisting posts
- [ ] CRUD routes for user management
- [ ] Form validation

### Database
- [ ] Database access in local environment
- [ ] Database access in CI/CD environment
- [ ] Database access in deployed (containerized) environment
- [ ] Database migrations
- [ ] Database model relationships

### Monitoring
- [ ] Request logging to /srv/app/log/app.log

### Developer Ergonomics
- [ ] Unit tests with proper mocking
- [ ] Integration tests against live (SQLite) db
- [ ] Postman collection committed

### Security
- [ ] Password encryption using bcrypt
- [ ] Routes protected via Bearer token authentication
- [ ] Routes protected via ACLs
- [ ] ~~Forms protected by CSRF~~ (Not necessary due to using JWT)

### Orchestration & Deployment
- [ ] Optimized Docker image
- [ ] Environment validation script (env vars, database host and port are accessible)

### CI/CD Workflows
- [x] Unit test coverage reporting
- [x] Automated testing using GitHub Actions
- [x] Automated coverage reporting using ~~Coveralls~~ Codecov (Coveralls was not working)
- [ ] Postman in CI/CD steps

