# Rails API template

## Setup
- Ruby 3.1.0
- Rails 7.0.1
- Postgres
- Rspec
  - FactoryBot
  - Faker
  - Database Cleaner
- Registrations controller
  - With request specs
- Sessions controller
  - With request specs
- User model
  - Includes email/password validations + specs
- Pundit
- Rubocop

## Notes
### Development
- Run the development server with `rails s`.
- Default port is 3001.
- Update the `origins "http://localhost:3000"` line of `config/initializers/cors.rb` with the development URL of your frontend.
- Update both `key` values of `config/initializers/session_store.rb` with the name of your app.
- Update all instances of `rails_api_template` in `config/cable.yml`, `config/database.yml` and `config/environments/production.rb` to the name of your app, for example:
  - `config/cable/yml`
    - Update `channel_prefix: rails_api_template_production` to `channel_prefix: my_new_project_production`
  - `config/database.yml`
    - Update `database: rails_api_template_development` to `database: my_new_project_development`
    - Update `#username: rails_api_template` to `#username: my_new_project`
    - Update `database: rails_api_template_test` to `database: my_new_project_test`
    - Update `database: rails_api_template_production` to `database: my_new_project_production`
    - Update `username: rails_api_template` to `username: my_new_project`
    - Update `password: <%= ENV["RAILS_API_TEMPLATE_DATABASE_PASSWORD"] %>` to `password: <%= ENV["MY_NEW_PROJECT_DATABASE_PASSWORD"] %>`
  - `config/environments/production.rb`
    - Update `# config.active_job.queue_name_prefix = "rails_api_template_production"` to `# config.active_job.queue_name_prefix = "my_new_project_production"`
  - This is necessary for nothing but brevity if you only ever use this template once. However, if you use it multiple times without updating these values (particularly those in `config/database.yml`), you will run into issues such as both apps will start using the same development database.
### Production
- Update the `origins "https://myappurl.com"` line of `config/initializers/cors.rb` with the production URL of your frontend
- Update the `domain` value of `config/initializers/session_store.rb` with the production URL of your API

## Endpoints
### `GET` `http://localhost:3001/`
- Root, to check that the API is working
### `POST` `http://localhost:3001/api/v1/registrations`
- To register a user
- Requires a `user` param containing an `email`, `password` and `password_confirmation`, for example:
```
fetch('http://localhost:3001/api/v1/registrations', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      user: {
        email: 'example@email.com',
        password: 'password',
        password_confirmation: 'password',
      },
    }),
    credentials: 'include',
  });
```
### `POST` `http://localhost:3001/api/v1/sessions`
- To create a session (login a user)
- Requires a `user` param containing an `email` and `password`, for example:
```
fetch('http://localhost:3001/api/v1/sessions', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({
    user: {
      email: 'example@email.com',
      password: 'password',
    },
  }),
  credentials: 'include',
});
```
### `GET` `http://localhost:3001/api/v1/logged_in`
- To check if a user is logged-in
- Example request:
```
fetch('http://localhost:3001/api/v1/logged_in', {
  credentials: 'include',
});
```
### `DELETE` `http://localhost:3001/api/v1/logout`
- To logout a user
- Example request:
```
fetch('http://localhost:3001/api/v1/logout', {
    method: 'DELETE',
    credentials: 'include',
  });
```
