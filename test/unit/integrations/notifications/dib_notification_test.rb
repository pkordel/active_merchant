require File.dirname(__FILE__) + '/../../../test_helper'

class DibNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @dib = Dib::Notification.new(http_raw_data)
  end

  def test_accessors
    assert @dib.complete?
    assert_equal "2345", @dib.transaction_id
    assert_equal "111", @dib.order_id
    assert_equal "22", @dib.gross
    assert_equal "578", @dib.currency
    assert @dib.test?
  end
  
  # Replace with real successful acknowledgement code
  def test_acknowledgement    
  
  end
  
  def test_send_acknowledgement
  end
  
  def test_respond_to_acknowledge
    assert @dib.respond_to?(:acknowledge)
  end

  private
  def http_raw_data
    "transact=2345&orderid=111&amount=22&currency=578&test=test"
  end
  
  def currency
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
    }.detect{ |k,v| v == @dib.currency }[0].to_s.upcase
  end

  # def setup
  #   @dib = Dib::Notification.new(http_raw_data)
  # end
  # 
  # def test_accessors
  #   assert @dib.complete?
  #   assert_equal "", @dib.status
  #   assert_equal "", @dib.transaction_id
  #   assert_equal "", @dib.item_id
  #   assert_equal "", @dib.gross
  #   assert_equal "", @dib.currency
  #   assert_equal "", @dib.received_at
  #   assert @dib.test?
  # end
  # 
  # def test_compositions
  #   assert_equal Money.new(3166, 'USD'), @dib.amount
  # end
  # 
  # # Replace with real successful acknowledgement code
  # def test_acknowledgement    
  # 
  # end
  # 
  # def test_send_acknowledgement
  # end
  # 
  # def test_respond_to_acknowledge
  #   assert @dib.respond_to?(:acknowledge)
  # end
  # 
  # private
  # def http_raw_data
  #   ""
  # end  
end
