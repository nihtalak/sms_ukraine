require "spec_helper"

module SmsUkraine
  describe DSL do
    context "Not logged in" do
      describe "#login" do
        it "should create instance of SmsSender" do
          SmsSender.should_receive(:new).with("foo", "bar")
          login "foo", "bar"
        end
      end
    end

    context "Logged in" do
      before { login "foo", "bar" }

      describe "#balance" do
        before { SmsSender.any_instance.stub(:balance).and_return({balance: "0.33"}) }
        it "should call SmsSender#balance" do
          SmsSender.any_instance.should_receive(:balance)
          balance
        end

        it "should return value" do
          balance.should eq("0.33UAH")
        end
      end

      describe "send_sms" do
        before { SmsSender.any_instance.stub(:send_sms).and_return({id: "101", sms_count: "1"}) }
        it "should call SmsSender#send_sms" do
          SmsSender.any_instance.should_receive(:send_sms).with("123", "texty text", nil)
          send_sms "texty text", "123"
        end

        it "should send sms from nickname calling as method" do
          SmsSender.any_instance.should_receive(:send_sms).with("123", "texty text", "nickname")
          as "nickname"
          send_sms "texty text", "123"
        end

        it "should send sms to list of numbers" do
          SmsSender.any_instance.should_receive(:send_sms).with(/\d+/, "texty text", nil).twice
          number_list 123, 321
          send_sms "texty text"
        end

        it "should set id of last sent sms" do
          send_sms "texty text", 123
          sms_id.should eq("101")
        end
      end

      describe "status" do
        before { SmsSender.any_instance.stub(:status).and_return({status: "Доставлено", status_code: "3"}) }
        it "should call SmsSender#status" do
          SmsSender.any_instance.should_receive(:status).with(12312)
          status 12312
        end

        it "should return sms status" do
          status.should eq("Доставлено")
        end

        it "should return status of last message" do
          SmsSender.any_instance.stub(:send_sms).and_return({id: "13", sms_count: "1"})
          SmsSender.any_instance.should_receive(:status).with("13")
          send_sms "texty text", "123"
          status
        end
      end
    end
  end
end