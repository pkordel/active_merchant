require File.dirname(__FILE__) + '/../../../test_helper'

class DibNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @dibs = Dib::Notification.new(http_raw_data)
  end

  def test_accessors
    assert @dibs.complete?
    assert_equal "2345", @dibs.transaction_id
    assert_equal "111", @dibs.order_id
    assert_equal "22", @dibs.gross
    assert_equal "578", @dibs.currency
    assert @dibs.test?
  end
  
  # Replace with real successful acknowledgement code
  def test_acknowledgement    
  
  end
  
  def test_send_acknowledgement
  end
  
  def test_respond_to_acknowledge
    assert @dibs.respond_to?(:acknowledge)
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
    }.detect{ |k,v| v == @dibs.currency }[0].to_s.upcase
  end

  # def setup
  #   @dibs = Dib::Notification.new(http_raw_data)
  # end
  # 
  # def test_accessors
  #   assert @dibs.complete?
  #   assert_equal "", @dibs.status
  #   assert_equal "", @dibs.transaction_id
  #   assert_equal "", @dibs.item_id
  #   assert_equal "", @dibs.gross
  #   assert_equal "", @dibs.currency
  #   assert_equal "", @dibs.received_at
  #   assert @dibs.test?
  # end
  # 
  # def test_compositions
  #   assert_equal Money.new(3166, 'USD'), @dibs.amount
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
  #   assert @dibs.respond_to?(:acknowledge)
  # end
  # 
  # private
  # def http_raw_data
  #   ""
  # end  
end
