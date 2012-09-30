require 'java'
require 'swt'

class Doro
  include Swt::Widgets

  def initialize
    ui_start
    setup_tray
    ui_end
  end

  def ui_start
    display = Display.get_current
    @shell = Shell.new
    @shell.text = self.class.to_s
  end

  def ui_end
    @shell.pack
    @shell.open
  end

  def setup_tray

  end

  def start
    display = Display.get_current

    while !@shell.isDisposed
      display.sleep unless display.read_and_dispatch
    end

    display.dispose
  end
end

app = Doro.new
Swt::Widgets::Display.set_app_name app.class.to_s
app.start
