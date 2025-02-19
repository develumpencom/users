# Users
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add the gem to your Rails project:

```bash
$ bundle add users --git https://github.com/develumpencom/users
```

And then install and run the migrations:
```bash
$ bin/rails users:install:migrations
$ bin/rails db:migrate
```

## Configuration

```ruby
Users.configure do |config|
  config.oauth_server_url = "https://breakabletoys.com"
  config.breakable_toys_client_id = Rails.application.credentials.breakable_toys.client_id
  config.breakable_toys_client_secret = Rails.application.credentials.breakable_toys.client_secret
  config.disable_form_access = true
end
```

So far this gem can only work with the OAuth implementation from [breakabletoys.com](https://breakabletoys.com). It was implemented following the guides at [oauth.com](https://www.oauth.com).

Get your `client_id` and `client_secret` at [breakabletoys.com](https://breakabletoys.com).

By default `users` offers a Sign in form at `/session/new`. If no form is needed because only OAuth is going to be used, `disable_form_access` will not expose those routes.

## License
Still figuring out a license, but basically let people know if you take anything from here.
