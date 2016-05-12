# File:  tc_basic_web_form_positive.rb

require "selenium-webdriver"
require "test/unit"

class TestBasicWebFormPositive < Test::Unit::TestCase

DEFAULTURL = "https://docs.google.com/forms/d/1emhA5uhsgx2lWJYk2o_jnSnG88_weQ_TV9aAA7M2t6Q/viewform"

  def setup
     @driver = Selenium::WebDriver.for :firefox
     @driver.navigate.to DEFAULTURL 
     @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
     @wait.until{ @driver.title == "Basic Web Form" }
  end

  def test_required_1 #only fill/select name and first checkbox
    #find and set name field
    @driver.find_element(:id, "entry_1041466219").send_keys("Spartacus")
    #find and set first checkbox
    @driver.find_element(:id, "group_310473641_1").click
    #now submit form
    @driver.find_element(:id,"ss-submit").click

    #verify that form has been submitted and we are on response page
    @wait.until {@driver.find_element(:link_text, "Submit another response")}
    assert_equal("Thanks!", @driver.title)
  end

  def test_required_2 #only fill/select name and second checkbox
    #find and set name field
    @driver.find_element(:id, "entry_1041466219").send_keys("$Spartacus1")
    #find and set second checkbox
    @driver.find_element(:id, "group_310473641_2").click
    #now submit form
    @driver.find_element(:id,"ss-submit").click

    #verify that form has been submitted and we are on response page
    @wait.until {@driver.find_element(:link_text, "Submit another response")}
    assert_equal("Thanks!", @driver.title)
  end

  def test_bothcheckboxes #fill/select name and both checkboxes
    #find and set name field
    @driver.find_element(:id, "entry_1041466219").send_keys("Spartacus")
    #find and set first checkbox
    @driver.find_element(:id, "group_310473641_1").click
    #find and set second checkbox
    @driver.find_element(:id, "group_310473641_2").click
    #now submit form
    @driver.find_element(:id,"ss-submit").click

    #verify that form has been submitted and we are on response page
    @wait.until {@driver.find_element(:link_text, "Submit another response")}
    assert_equal("Thanks!", @driver.title)
  end    

  def test_all #fill/select all fields/items on form
    #find and set name field
    @driver.find_element(:id, "entry_1041466219").send_keys("Spartacus")
    #find and set first checkbox
    @driver.find_element(:id, "group_310473641_1").click
    #find and set second checkbox
    @driver.find_element(:id, "group_310473641_2").click

    #find List and select item    
    select = Selenium::WebDriver::Support::Select.new(@driver.find_element(:tag_name, "select"))
    select.select_by(:text, "Other")

    #find and place text in textbox 
    @driver.find_element(:id, "entry_649813199").send_keys("Yada, Yada, Yada")
    #now submit form
    @driver.find_element(:id,"ss-submit").click

    #verify that form has been submitted and we are on response page
    @wait.until {@driver.find_element(:link_text, "Submit another response")}
    assert_equal("Thanks!", @driver.title)  
           
  end

  def teardown
     @driver.quit
  end
end