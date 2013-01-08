if Rails.env.production?
  PayPal::Recurring.configure do |config|
    config.sandbox = false
    config.username = ""
    config.password = ""
    config.signature = ""
  end
else
  PayPal::Recurring.configure do |config|
    config.sandbox = true
    config.username = "seller_1351256421_biz_api1.gmail.com"
    config.password = "1351256489"
    config.signature = "AFcWxV21C7fd0v3bYYYRCpSSRl31Ab0TSI3s0lwvZR9pkyOuHypaqhqA"
  end
end
