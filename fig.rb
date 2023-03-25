require "figaro"

module Fig
  def self.init
    Figaro.application =
      Figaro::Application.new(
        { "path" => File.join("./", "config", "application.yml") }
      )
    Figaro.load
  end
end
