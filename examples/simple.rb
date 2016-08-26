require 'escpos'

class MyReport < Escpos::Report
  
  def title(text)
    underline(text)
  end
  
end

@printer = Escpos::Printer.new(command_set: :esc_p)

report = MyReport.new File.join(__dir__, 'simple.erb'), printer: @printer



@printer.write @printer.sequence(:HW_SET_ESCP_MODE)       # ESC i a %d0
@printer.write @printer.sequence(:HW_INIT)                # ESC @
@printer.write @printer.sequence(:LANDSCAPE)              # ESC i L 0x01
@printer.write @printer.sequence(:PAGE_LENGTH)            # ESC ( C 0x02 0x00 0x6a 0x04
@printer.write @printer.sequence(:ABSOLUTE_HORIZONTAL_POSITION)                        # ESC $ 0x2C 0x01
@printer.write @printer.sequence(:ABSOLUTE_VERTICAL_POSITION)                        # ESC ( V 0x02 0x00 0x1C 0x02
@printer.write @printer.sequence(:TXT_FONT_HELSINKI)                        # ESC k 0x0b
@printer.write @printer.sequence(:TXT_CHARACTER_SIZE)                        # ESC X 0x00 0x64 0x00
@printer.write "Test"
@printer.write @printer.sequence(:CTL_FF) # FF


# @printer.write report.render
# @printer.cut!

# @printer.to_escpos or @printer.to_base64 contains resulting ESC/POS data
puts @printer.to_escpos.inspect
puts @printer.to_base64
