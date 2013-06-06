require "spec_helper"

module SmsUkraine
  PHONE = "log"
  PASS  = "pass"
  describe SmsSender do
    let(:sender) { SmsSender.new(PHONE, PASS) }


    shared_examples 'request to smsukraine' do
      it "should send http request to http://smsukraine.com.ua/api/http.php" do
        sender.should_receive(:open).with(/http:\/\/smsukraine.com.ua\/api\/http.php/)
      end
    end

    describe "#balance" do
      before { sender.stub(:open).and_return("balance:1.23\n") }
      after { sender.balance }

      it_behaves_like "request to smsukraine" 

      it "should send command=balance" do
        sender.should_receive(:open).with(/command=balance/)
      end

      it "should return 1.23 when balance is 1.23UAH" do
        sender.balance[:balance].should eq('1.23')
      end
    end

    describe "#send" do
      before { sender.stub(:open).and_return("id:103796881\nsms_count:1\n") }
      context "url" do
        after { sender.send_sms("123123", "test message", "test") }

        it_behaves_like "request to smsukraine"

        it "should send command=send&to=phone&message=message&from=name" do
          sender.should_receive(:open).with(/command=send&to=123123&message=test\+message&from=test/)
        end

        it "should send from=login as default from" do
          sender.should_receive(:open).with(/command=send&to=123123&message=test\+message&from=log/)
          sender.send_sms("123123", "test message")
        end
      end

      context "result" do
        it "should return message id and sms count" do
          smsinfo = sender.send_sms("test", "number", "test")
          smsinfo[:id].should eq("103796881")
          smsinfo[:sms_count].should eq("1")
        end
      end
    end


    describe "status" do
      before { sender.stub(:open).and_return("status:Доставлено\nstatus_code:3\n")}
      context "url" do
        after { sender.status("12312") }

        it_behaves_like "request to smsukraine"

        it "should send command=receive&id=id" do
          sender.should_receive(:open).with(/command=receive&id=12312/)
        end
      end

      context "result" do
        it "should return message id and sms count" do
          smsinfo = sender.status("12312")
          smsinfo[:status].should eq("Доставлено")
          smsinfo[:status_code].should eq("3")
        end
      end
    end
  end
end