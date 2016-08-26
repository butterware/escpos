require 'erb'

module Escpos
  class Report
    include ERB::Util
    include Helpers

    def initialize(file_or_path, optr = {})
      
      @printer = optr.delete(:printer) || Printer.new
      
      if file_or_path.is_a?(String)
        @template = ERB.new(File.open(file_or_path).read)
      elsif file_or_path.is_a?(File)
        @template = ERB.new(file_or_path.read)
      else
        raise ArgumentError.new("Must pass instance of file or path as argument.")
      end
    end

    def render
      @template.result binding
    end
    
    def sequence(code)
      @printer.sequence(code)
    end
    
  end
end
