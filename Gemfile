source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.8"

gem "rails", "~> 8.1"
gem "pg", "~> 1.6"
gem "puma", "~> 6.0"
gem "jwt"
gem "bootsnap", ">= 1.4.4", require: false
gem "tzinfo-data", platforms: [ :windows, :jruby ]

group :development do
  gem "listen", "~> 3.9"
end

group :development, :test do
  gem "debug", platforms: [ :mri, :windows ]
  gem "rubocop-rails-omakase", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rspec", require: false
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rspec-rails", "~> 8.0"
end
