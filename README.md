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
- [x] CRUD routes for persisting posts
- [x] CRUD routes for user management
- [x] Form validation

### Database
- [x] Database access in local environment
- [x] Database access in CI/CD environment
- [x] Database access in deployed (containerized) environment
- [x] Database migrations
- [x] Database model relationships

### Monitoring
- [ ] Request logging to /srv/app/log/app.log

### Developer Ergonomics
- [x] Unit tests with proper mocking
- [x] Integration tests against live (SQLite) db
- [x] Postman collection committed

### Security
- [x] Password encryption using bcrypt
- [x] Routes protected via Bearer token authentication
- [ ] Routes protected via ACLs
- [ ] ~~Forms protected by CSRF~~ (Not necessary due to using JWT)

### Orchestration & Deployment
- [ ] Optimized Docker image
- [ ] Environment validation script (env vars, database host and port are accessible)

### CI/CD Workflows
- [x] Test coverage reporting
- [x] Automated testing using GitHub Actions
- [x] Automated coverage reporting using ~~Coveralls~~ Codecov (Coveralls was not working)
- [ ] Postman in CI/CD steps
