# TODO - Update both 'key' values below to your app name
# TODO - Update the 'domain' value below to your API URL

if Rails.env == 'production'
  Rails.application.config.session_store :cookie_store, key: "_my_app_name", domain: "api.myappname.com"
else
  Rails.application.config.session_store :cookie_store, key: "_my_app_name"
end
