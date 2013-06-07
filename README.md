SMS UKRAINE
===========

http://smsukraine.com.ua/


Use case
--------

```ruby
require "sms_ukraine"
include SmsUkraine::DSL

login "380xxxxxxx", "xxxxxxx"     # login / password
as "Vova"                         # from name
number_list 380xxxxxx, 380xxxxxx  # list of numbers to send
send_sms "Texty text"             # sms text
puts sms_id                       # last sms id

as "Vlad"
send_sms "Not so texty", 380xxxx  # sms text, number to send
puts status                       # status of last sent message
puts balance                      # money balance
```