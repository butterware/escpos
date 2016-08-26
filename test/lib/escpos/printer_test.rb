require_relative '../../test_helper'

class TestPrinter < Minitest::Test
  def setup
    @printer = Escpos::Printer.new
  end

  def test_styles
    require 'erb'
    template = File.open(File.join(__dir__, '../../fixtures/styles.erb'))
    @printer.write Class.new(Escpos::Report).new(template).render
    @printer.cut!
    #pp @printer.to_base64
    assert_equal @printer.to_base64, 'G0BVbmZvcm1hdHRlZCB0ZXh0CgpJU08tODg1OS0yIGVuY29kZWQgdGV4dC4gKOy56Pi+/eHt6fr5KQoKGyEATm9ybWFsIHRleHQbIQAKChshEERvdWJsZSBoZWlnaHQgdGV4dBshAAoKGyEgRG91YmxlIHdpZHRoIHRleHQbIQAKChshMFF1YWQgYXJlYSB0ZXh0GyEACgobLQFVbmRlcmxpbmVkIHRleHQbLQAKChstAlVuZGVybGluZWQgdGV4dCAoMikbLQAKChtFAUJvbGQgdGV4dBtFAAoKG2EATGVmdCBhbGlnbmVkIHRleHQbYQAKChthAlJpZ2h0IGFsaWduZWQgdGV4dBthAAoKG2EBQ2VudGVyZWQgdGV4dBthAAoKHUgAHXcDHWgyHWsCODU5NDQwNDAwMDU3MgoKCgoKHVYA'
  end

end
