=begin
# references
* usage of swt gem -- https://github.com/danlucraft/swt/blob/master/examples/menu_and_toolbar.rb
* SWT tray example -- http://git.eclipse.org/c/platform/eclipse.platform.swt.git/tree/examples/org.eclipse.swt.snippets/src/org/eclipse/swt/snippets/Snippet143.java
=end

require 'java'
require_relative '../dependencies/swt/lib/swt'

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
    display = Display.get_current
    tray = display.get_system_tray
    tray_item = TrayItem.new(tray, SWT::NONE)
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
