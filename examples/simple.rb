require 'escpos'

class MyReport < Escpos::Report
  
  def title(text)
    underline(text)
  end
  
end

@printer = Escpos::Printer.new(command_set: :esc_p)

report = MyReport.new File.join(__dir__, 'simple.erb'), printer: @printer

puts report.render

@printer.write report.render
@printer.cut!

# @printer.to_escpos or @printer.to_base64 contains resulting ESC/POS data
puts @printer.to_escpos.inspect