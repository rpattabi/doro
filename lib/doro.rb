=begin
# references
* usage of swt gem -- https://github.com/danlucraft/swt/blob/master/examples/menu_and_toolbar.rb
* SWT tray example -- http://git.eclipse.org/c/platform/eclipse.platform.swt.git/tree/examples/org.eclipse.swt.snippets/src/org/eclipse/swt/snippets/Snippet143.java
=end

require 'java'
require_relative '../dependencies/swt/lib/swt'

class Doro
  include Swt::Widgets

  IMAGE = File.expand_path('../../assets/doro.jpg', __FILE__)

  def initialize
    ui_start
    setup_tray
    ui_end
  end

  def ui_start
    display = Display.get_current
    @shell = Shell.new
    #@shell.text = self.class.to_s
  end

  def ui_end
    #@shell.set_bounds(50, 50, 300, 200)
    #@shell.visible = false
    @shell.pack
    @shell.open
  end

  def setup_tray
    display = @shell.display
    tray = display.get_system_tray
    tray_item = TrayItem.new(tray, Swt::SWT::NONE)
    tray_item.tool_tip_text = 'Doro'
    tray_item.image = Swt::Graphics::Image.new(display, IMAGE)

    tray_item.add_selection_listener { }

=begin
    tray_item.add_show_listener { |event| puts 'show' }
    tray_item.add_listener(Swt::SWT::Show, Swt::SWT::Listener.new { |event| puts 'show' })
    tray_item.add_hide_listener { }
    tray_item.add_default_selection_listener { }
=end

    setup_menu tray_item

    tray_item.visible = true
  end

  def setup_menu(parent)
    menu = Swt::Widgets::Menu.new(@shell, Swt::SWT::POP_UP)

    fileItem = Swt::Widgets::MenuItem.new(menu, Swt::SWT::PUSH)
    fileItem.setText("File")

    editItem = Swt::Widgets::MenuItem.new(menu, Swt::SWT::PUSH)
    editItem.setText("Edit")

    menu.visible = true

    parent.add_menu_detect_listener do
      menu.each { |m| m.visible = true }
    end
  end

  def start
    display = @shell.display

    while !@shell.isDisposed
      display.sleep unless display.read_and_dispatch
    end

    display.dispose
  end
end

app = Doro.new
Swt::Widgets::Display.set_app_name app.class.to_s
app.start

