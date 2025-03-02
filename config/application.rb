require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HajimaruTodoapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

 # 強制的にNODE_OPTIONSを設定
    # 多分オプションを複数指定できるはず。ダメだったら --openssl-legacy-provider だけで試してみる。
    ENV['NODE_OPTIONS'] = '--openssl-legacy-provider'

    # 初期化中にコンソールに出力
    puts '********** config/application.rb **************' # どのファイルから出力されているかわかりやすいように追記
    puts "NODE_OPTIONS: #{ENV['NODE_OPTIONS']}"
    puts '***********************************************'

    config.load_defaults 6.0

    if Rails.env.development? || Rails.env.test?
      Bundler.require(*Rails.groups)
      Dotenv::Railtie.load
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.default_locale = :ja
  end
end
