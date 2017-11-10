module PasswordValidator

  def self.common_passwords
    @common_passwords ||=
      begin
        file = File.open(File.expand_path("../support/common.txt", __FILE__))
        words = file.each_line.to_a.map(&:chomp)
        file.close
        words
      end
  end

  def self.in_common?(password)
    @common_passwords.include? password
  end
end
PasswordValidator.common_passwords
