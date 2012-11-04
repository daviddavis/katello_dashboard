class String
  def truncate(max_length = 10)
    str = ""
    self.split.each do |word|
      if (str.length + word.length) > max_length
        return str + "..."
      else
        str += (" " + word)
      end
    end
    return str
  end
end
