require 'java'
require 'swt'

class Doro
  include Swt::Widgets

  def initialize
    display = Display.get_current
    @shell = Shell.new
    @shell.text = self.class.to_s

    @shell.pack
    @shell.open
  end

  def start
    display = Swt::Widgets::Display.get_current
    while !@shell.isDisposed
      display.sleep unless display.read_and_dispatch
    end

    display.dispose
  end
end

app = Doro.new
Swt::Widgets::Display.set_app_name app.class.to_s
app.start
