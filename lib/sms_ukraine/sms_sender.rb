module SmsUkraine
  class SmsSender
    require "open-uri"
    BASE_URI = "http://smsukraine.com.ua/api/http.php?"

    def initialize(log, pass)
      @params = {login: log, password: pass, version: "http"}
    end

    def balance
      execute(command: "balance")
    end

    def send_sms(to, message, name = nil)
      execute(command: "send", to: to, message: message, from: name || @params[:login])
    end

    def status(id)
      execute(command: "receive", id: id)
    end

    private
    def execute(hash)
      result = send_request(hash)    
      raise result[:errors] if result[:errors]
      result
    end

    def send_request(hash)
      command = URI.encode_www_form(hash.merge(@params))
      result = open(BASE_URI + command) { |f| f.read }

      hash = {}
      result.split("\n").each do |line|
        key, val = line.split(":")
        hash[key.to_sym] = val
      end
      hash
    end
  end
end