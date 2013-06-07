module SmsUkraine
  module DSL
    def login(log, pass)
      @sender = SmsSender.new(log, pass)
    end

    def balance
      "#{@sender.balance[:balance]}UAH"
    end

    def send_sms(text, *args)
      args = @number_list || [] if args.empty?
      args.each { |num| @last_id = @sender.send_sms(num.to_s, text, @from)[:id] }
    end


    def as(name)
      @from = name
    end

    def number_list(*args)
      @number_list = args
    end

    def sms_id
      @last_id
    end

    def status(id=nil)
      id = @last_id unless id
      @sender.status(id)[:status]
    end
  end
end