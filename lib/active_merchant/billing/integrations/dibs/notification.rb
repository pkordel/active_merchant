require 'net/http'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Dib
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def complete?
            !transaction_id.blank?
          end
          
          def order_id
            params['orderid']
          end 

          def transaction_id
            params['transact']
          end
          
          # the money amount we received in X.2 decimal.
          def gross
            params['amount']
          end
          
          def currency
            params['currency']
          end          

          # Was this a test transaction?
          def test?
            params['test'] == 'test'
          end

          # Acknowledge the transaction to Dib. This method has to be called after a new 
          # apc arrives. Dib will verify that all the information we received are correct and will return a 
          # ok or a fail. 
          # 
          # Example:
          # 
          #   def ipn
          #     notify = DibNotification.new(request.raw_post)
          #
          #     if notify.acknowledge 
          #       ... process order ... if notify.complete?
          #     else
          #       ... log possible hacking attempt ...
          #     end
          def acknowledge      
            true
            # payload = raw
            # 
            # uri = URI.parse(Dib.notification_confirmation_url)
            # 
            # request = Net::HTTP::Post.new(uri.path)
            # 
            # request['Content-Length'] = "#{payload.size}"
            # request['User-Agent'] = "Active Merchant -- http://home.leetsoft.com/am"
            # request['Content-Type'] = "application/x-www-form-urlencoded" 
            # 
            # http = Net::HTTP.new(uri.host, uri.port)
            # http.verify_mode    = OpenSSL::SSL::VERIFY_NONE unless @ssl_strict
            # http.use_ssl        = true
            # 
            # response = http.request(request, payload)
            # 
            # # Replace with the appropriate codes
            # raise StandardError.new("Faulty Dib result: #{response.body}") unless ["AUTHORISED", "DECLINED"].include?(response.body)
            # response.body == "AUTHORISED"
          end
 private

          # Take the posted data and move the relevant data into a hash
          def parse(post)
            @raw = post
            for line in post.split('&')
              key, value = *line.scan( %r{^(\w+)\=(.*)$} ).flatten
              params[key] = value
            end
          end
        end
      end
    end
  end
end
