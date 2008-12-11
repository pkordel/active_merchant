require File.dirname(__FILE__) + '/../../../test_helper'

class DibHelperTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations
  
  def setup
    @helper = Dib::Helper.new('order_id','merchant_id', :amount => 500, :currency => 'nok')
  end
 
  def test_basic_helper_fields
    assert_field 'merchant', 'merchant_id'
    assert_field 'orderid', 'order_id'
    assert_field 'amount', '500'
    assert_field 'currency', '578'
  end
  
  def test_customer_fields
    @helper.customer :name => 'Winnie The Pooh'#, :last_name => 'Fauser', :email => 'cody@example.com'
    assert_field 'delivery1.Navn', 'Winnie The Pooh'
  end

  def test_address_mapping
    @helper.billing_address :street => '1 My Street'
    assert_field 'delivery2.Adresse', '1 My Street'
  end
  
  def test_currency_map
    @helper.currency_code = :nok
    assert_field 'currency', '578'
    @helper.currency_code = :dkk
    assert_field 'currency', '208'
  end
  
  def test_other_fields
    @helper.instant_capture = true
    assert_field 'capturenow','true'
    @helper.description = "This is a test"
    assert_field 'ordertext', 'This is a test'

    @helper.decorator = "invalid"
    assert_field 'decorator', nil

    @helper.decorator = "default"
    assert_field 'decorator', 'default'
    @helper.decorator = "basal"
    assert_field 'decorator', 'basal'
    @helper.decorator = "rich"
    assert_field 'decorator', 'rich'
  end
  
  # def test_customer_fields
  #   @helper.customer :first_name => 'Cody', :last_name => 'Fauser', :email => 'cody@example.com'
  #   assert_field '', 'Cody'
  #   assert_field '', 'Fauser'
  #   assert_field '', 'cody@example.com'
  # end
  # 
  # def test_address_mapping
  #   @helper.billing_address :address1 => '1 My Street',
  #                           :address2 => '',
  #                           :city => 'Leeds',
  #                           :state => 'Yorkshire',
  #                           :zip => 'LS2 7EE',
  #                           :country  => 'CA'
  #  
  #   assert_field '', '1 My Street'
  #   assert_field '', 'Leeds'
  #   assert_field '', 'Yorkshire'
  #   assert_field '', 'LS2 7EE'
  # end
  # 
  # def test_unknown_address_mapping
  #   @helper.billing_address :farm => 'CA'
  #   assert_equal 3, @helper.fields.size
  # end
  # 
  # def test_unknown_mapping
  #   assert_nothing_raised do
  #     @helper.company_address :address => '500 Dwemthy Fox Road'
  #   end
  # end
  # 
  # def test_setting_invalid_address_field
  #   fields = @helper.fields.dup
  #   @helper.billing_address :street => 'My Street'
  #   assert_equal fields, @helper.fields
  # end
end
