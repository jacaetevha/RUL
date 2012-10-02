source :rubygems

gem 'uuid'

group :test do
  platforms :mri_19 do
    gem 'debugger'
  end

  platforms :mri_18, :jruby do
    gem 'ruby-debug'
  end

  gem 'rails', '=3.0.4'
  gem 'rspec'
  gem 'mocha'
end
