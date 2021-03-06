# Saddlebag

Saddlebag is a Rail 3+ configuration toolkit.

## Installation

No surprises:

    gem 'saddlebag'

## Usage

Saddlebag bundles conveninent Rails 3+ configuration classes and modules.

### AssetHost

When it comes time to add CDN and/or cookie-free domains to serve assets,
the logic to set `config.controller.asset_host` can get pretty messy. AssetHost
makes it easy to point your assets to hosts with multiple subdomains, secure hosts
and gracefully handle asset pipeline compilation.

```ruby
# application.rb
require 'saddlebag'
config.action_controller.asset_host = Saddlebag::AssetHost.new

# config/environments/production.rb or in initializer
Saddlebag::AssetHost.configure do |a|
  a.enabled = true
  a.asset_host = 'http://assets%d.example.com'
  a.secure_asset_host = 'https://secureassets.example.com'
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
