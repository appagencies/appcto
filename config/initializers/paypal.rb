
if Rails.env.production?
  PayPal::Recurring.configure do |config|
    config.sandbox = false
    config.username = "hello_api1.sebastianmortelmans.be"
    config.password = "WZJNLRPT8F5J7CPA"
    config.signature = "AdCV46iXcWu-yXmAIsU9J-V1QJzyAaPqO9spRQ6xQLZUPUhynhdEn6Hx"
  end
else
  PayPal::Recurring.configure do |config|
    config.sandbox = true
    config.username = "seller_1351256421_biz_api1.gmail.com"
    config.password = "1351256489"
    config.signature = "AFcWxV21C7fd0v3bYYYRCpSSRl31Ab0TSI3s0lwvZR9pkyOuHypaqhqA"
  end
end
