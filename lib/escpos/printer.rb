require 'base64'

module Escpos

  class Printer
    
    def initialize(command_set: :esc_pos)
      
      @command_set = case command_set
      when :esc_p
        EscP
      else
        EscPos
      end
      
      # ensure only supported sequences are generated
      @data = "".force_encoding("ASCII-8BIT")
      @data = self.command_set.sequence self.command_set::HW_INIT
    end
    
    def command_set
      @command_set
    end

    def write(data)
      @data << data
    end

    def partial_cut!
      @data << sequence(:PAPER_PARTIAL_CUT)
    end

    def cut!
      @data << sequence(:PAPER_FULL_CUT)
    end

    def to_escpos
      @data
    end

    def to_base64
      Base64.strict_encode64 @data
    end
    
    def sequence(code)
      if code.kind_of?(Array)
        command_set.sequence(code)
      else
        command_set.sequence(command_set.const_get(code))
      end
    end

  end
end
