require "selenium-webdriver"

# Create some objects
caps = Selenium::WebDriver::Remote::Capabilities.chrome("goog:chromeOptions" => {detach: true})
driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps
wait = Selenium::WebDriver::Wait.new(:timeout => 15)

# Find site and page
driver.navigate.to "https://pic-ofthe-litter.herokuapp.com"
driver.find_element(:link_text, 'Sign up').click

# Wait until inputs load and fill
username = wait.until {
    element = driver.find_element(:id, "user_username")
    element if element.displayed?
}
username.send_keys("username")

email = wait.until {
	element = driver.find_element(:id, 'user_email')
	element if element.displayed?
}
email.send_keys "none@none.com"

password = wait.until {
	element = driver.find_element(:id, 'user_password')
	element if element.displayed?
}
password.send_keys "password123"

confirm = wait.until {
	element = driver.find_element(:id, 'user_password_confirmation')
	element if element.displayed?
}
confirm.send_keys "password123"

# Submit form to create new user 

submit = wait.until {
	element = driver.find_element(:name, 'commit')
	element if element.displayed?
}
submit.click

driver.navigate.to "https://pic-ofthe-litter.herokuapp.com/users/edit"
element = driver.find_element(:link_text, 'Cancel my account' ).click
begin
  driver.switch_to.alert.accept
rescue Selenium::WebDriver::Error::NoAlertOpenError
  retry
end
