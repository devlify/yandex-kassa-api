[![Code Climate](https://codeclimate.com/github/creepycheese/yandex-kassa-api/badges/gpa.svg)](https://codeclimate.com/github/creepycheese/yandex-kassa-api)
# YandexKassa
Simple API wrapper for [YandexKassa] (https://kassa.yandex.ru).
Official API documentaton [here](https://tech.yandex.ru/money/doc/payment-solution/payout/intro-docpage/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yandex_kassa'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yandex_kassa

## Usage

First of all configure gem.
```ruby
require "yandex_kassa"

YandexKassa.configure do |config|
  # API end url given by Yandex
  config.url = "https://bo-demo02.yamoney.ru:9094/webservice/deposition/api"
  #path to you *.cer generated by Yandex on your request
  config.cert = "123123.cer"
  #path to your private key
  config.key = "private.key"
  #path to deposit *.cer generated by Yandex
  config.deposit = "deposit.cer"
  #passphare for *.key file, omit if you don't need
  config.passphrase = "passphrase"
end
```

```ruby
#enable std loggin for Rest client
RestClient.log = 'stdout'

#create api instance
api = YandexKassa.create

#send test deposition request
test_deposition_params = {
  dst_account: "410011234567", amount: "10.00", currency: 10643,
  agent_id: "123123", contract: "Fun stuff", client_order_id: 1, request_dt: Time.now.iso8601
}

data = api.test_deposition(test_deposition_params)
# => "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<testDepositionResponse clientOrderId=\"1\" status=\"3\" error=\"41\" processedDT=\"2016-03-23T12:52:53.087+03:00\" identification=\"anonymous\" />\r\n"

#or equally
data = api.test_deposition do |request|
    request.dst_account = 410011234567
    request.amount = 10.00
    request.currency = 10643
    request.contract = "Fun stuff"
    request.dst_account = 410011234567
    request.client_order_id = 1
    request.request_dt = Time.now.iso8601
  end
# => "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<testDepositionResponse clientOrderId=\"1\" status=\"3\" error=\"41\" processedDT=\"2016-03-23T12:52:53.087+03:00\" identification=\"anonymous\" />\r\n"
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

