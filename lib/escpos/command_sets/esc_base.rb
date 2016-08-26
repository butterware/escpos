module EscBase
  
  # Transforms an array of codes into a string
  def sequence(arr_sequence)
    arr_sequence.pack('U*')
  end
  
end