require File.dirname(__FILE__) + '/dib/helper.rb'
require File.dirname(__FILE__) + '/dib/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Dib 
       
        mattr_accessor :service_url
        self.service_url = 'https://payment.architrade.com/paymentweb/start.action'

        def self.notification(post)
          Notification.new(post)
        end  
      end
    end
  end
end
