Skywall.make.configure do |machine|
  
  machine.os = OS::WINDOWS7
  
  machine.user do |user|
    user.profile = COMPANY::BASE_EMPLOYEE
  end
  
  machine.install do |streefood|
    streefood.url = "www.streefood.com/downloads/1.1"
    streefood.download_location = "C:/Downloads/"
  end
end

Skywall::Test do |vm, program|
  context 'Basic Startup' do
    it 'opens the program' do
      program.open

      return error unless program.display_login_page
    end

    it 'logs in' do
      program.fill_credentials('TEST_USER', '123456')
      vm.move_mouse(vm.login_button).click
      
      return error unless program.display_front_page
    end

    it 'maintains state over time' do
      program.idle(1.year)
    end
end
