require_relative '../Helpers/jso_nable'
class TextFilter < JSONable

  def Text=(text)
    @text = text
  end

  def OperatioClearFilter
    @operation = operation
  end


  #Methods
  def StartsWith(text)
    self.ClearFilter
    @text = text
    @operation = "STARTS_WITH"
    return self
  end

  def EndsWith(text)
    self.ClearFilter
    @text = text
    @operation = "ENDS_WITH"
    return self
  end

  def Is(text)
    self.ClearFilter
    @text = text
    @operation = "IS"
    return self
  end


  #private
  def ClearFilter
    @text = ""
    @operation = ""
  end

  #private String Text;
  #private String Operation;

end