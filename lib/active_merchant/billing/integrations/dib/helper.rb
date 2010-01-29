
# Credit card for testing
# 4711100000000000 06/24 684

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Dib
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          
          def initialize(order, account, options = {})
            super
            self.currency_code = options[:currency]
          end
          
          mapping :billing_address, 
            :street     => 'delivery2.Adresse'
          mapping :customer, 
            :name       => 'delivery1.Navn'
          
          def billing_address(mapping = {})
            mapping.each do |k, v|
              field = mappings[:billing_address][k]
              add_field(field, v) unless field.nil?
            end 
          end   
          
          def customer(mapping = {})
            mapping.each do |k, v|
              field = mappings[:customer][k]
              add_field(field, v) unless field.nil?
            end 
          end     
          
          # da = Danish (default)
          # sv = Swedish
          # no = Norwegian
          # en = English
          # nl = Dutch
          # de = German
          # fr = French
          # fi = Finnish
          # es = Spanish
          # it = Italian
          # fo = Faroese
          # pl = Polish
          def language=(language)
            if %w(da sv no en nl de fr fi es it fo pl).include?(language)
              add_field(:lang, language)
            end
          end
          
          def currency_codes
            {
              :dkk  => '208',
              :eur  => '978',
              :usd  => '840',
              :gbp  => '826',
              :sek  => '752',
              :aud  => '036',
              :cad  => '124',
              :isk  => '352',
              :jpy  => '392',
              :nzd  => '554',
              :nok  => '578',
              :chf  => '756',
              :try  => '949'
            }.with_indifferent_access
          end
          
          def currency_code=(a_code)
            curr = currency_codes[a_code.to_s.downcase.to_sym]
            add_field(:currency, curr)
          end
          
          def decorator=(a_decorator)
            if %w(default basal rich).include?(a_decorator)
              add_field 'decorator', a_decorator
            end
          end
          
          def color=(color)
            if %w(sand grey blue).include?(color)
              add_field 'color', color
            end
          end
          
          # Standard AM parameters
          mapping :account, 'merchant'
          mapping :amount, 'amount'
          mapping :order, 'orderid'
          mapping :notify_url, 'callbackurl'
          mapping :return_url, 'accepturl'
          mapping :cancel_return_url, 'cancelurl'
          mapping :description, 'ordertext'
          mapping :tax, 'priceinfo2.VAR'
          mapping :shipping, 'priceinfo1.shippingcosts'
          
          
          mapping :test, "test"
          mapping :currency, "currency"
          
          # Optional Dibs params
          # See http://tech.dibs.dk/integration-methods/flexwin/parameters/
          # for a list of all parameters
          
          mapping :calculate_fee, 'calcfee'
          mapping :decorator, 'decorator'
          mapping :color, 'color'
          mapping :instant_capture, 'capturenow'
          mapping :language, 'lang'
          mapping :paytype, 'paytype'
          mapping :uniqueoid, 'uniqueoid'
          mapping :skiplastpage, 'skiplastpage' # Set to skip last page of payment process and return to shop
          mapping :ticketrule, 'ticketrule'
          mapping :md5key, 'md5key'
          mapping :dib_account, 'account'
          mapping :capturenow, 'capturenow'
          mapping :ip, 'ip'
          mapping :HTTP_COOKIE, 'HTTP_COOKIE'
          mapping :maketicket, 'maketicket'
          
        end
      end
    end
  end
end
