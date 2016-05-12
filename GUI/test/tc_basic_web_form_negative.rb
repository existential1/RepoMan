# File:  tc_basic_web_form_negative.rb

require "selenium-webdriver"
require "test/unit"

class TestBasicWebFormNegative < Test::Unit::TestCase

DEFAULTURL = "https://docs.google.com/forms/d/1emhA5uhsgx2lWJYk2o_jnSnG88_weQ_TV9aAA7M2t6Q/viewform"

  def setup
     @driver = Selenium::WebDriver.for :firefox
     @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
     @driver.navigate.to DEFAULTURL 
     @wait.until{ @driver.title == "Basic Web Form" }
  end  

  def test_nofields #no fields filled
    #Find and click the submit button
    @driver.find_element(:id,'ss-submit').click

    #Verify error
    assert_raise() { @driver.find_element(:link_text, "Submit another response") }
       
  end
  def test_norequired #no required fields/items filled/selected
    #find List and select item    
    select = Selenium::WebDriver::Support::Select.new(@driver.find_element(:tag_name, "select"))
    select.select_by(:text, "Cucumber")

    #find and place text in textbox 
    @driver.find_element(:id, "entry_649813199").send_keys("Blah, Blah, Blah")
    #now submit form
    @driver.find_element(:id,"ss-submit").click

    #Verify error
    assert_raise() { @driver.find_element(:link_text, "Submit another response") }

  end
  def test_onerequired_name #only one of the two required field/items filled/selected
    #find and set name field
    @driver.find_element(:id, "entry_1041466219").send_keys("Kilroy")
    #now submit form
    @driver.find_element(:id,"ss-submit").click

    #Verify error
    assert_raise() { @driver.find_element(:link_text, "Submit another response") }
  end
  def test_checkbox1_only #only one of the two required field/items - first checkbox
    #find and set first checkbox 
    @driver.find_element(:id, "group_310473641_1").click
    #now submit form
    @driver.find_element(:id,"ss-submit").click

    #Verify error
    assert_raise() { @driver.find_element(:link_text, "Submit another response") }
  end
  def test_checkbox2_only #only one of the two required field/items - second checkbox
    #find and set first checkbox 
    @driver.find_element(:id, "group_310473641_2").click
    #now submit form
    @driver.find_element(:id,"ss-submit").click

    #Verify error
    assert_raise() { @driver.find_element(:link_text, "Submit another response") }
  end
  def teardown
     @driver.quit
  end

end