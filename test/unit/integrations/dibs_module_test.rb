require File.dirname(__FILE__) + '/../../test_helper'

class DibModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations
  
  def test_notification_method
    assert_instance_of Dib::Notification, Dib.notification('name=cody')
  end
end 
