require_relative '../Helpers/jso_nable'
class AmountRangeFilter < JSONable

  def Amount1=(amount1) #double
    @amount1 = amount1
  end

  def Amount2=(amount2) #double
    @amount2 = amount2
  end

  def Operation=(operation)
    @operation = operation
  end

  def GreaterThan(amount)
    self.ClearFilter
    @amount1 = amount
    @operation = "GREATER_THAN"
    return self
  end

  def LessThan(amount)
    self.ClearFilter
    @amount1 = amount
    @operation = "LESS_THAN"
    return self
  end

  def EqualTo(amount)
    self.ClearFilter
    @amount1 = amount
    @operation = "EqualTo"
    return self
  end

  def Between(amountFrom, amountTo)
    self.ClearFilter
    @amount1 = amountFrom
    @amount2 = amountTo
    @operation = "BETWEEN"
    return self
  end


  #private

  def ClearFilter

    @amount1 = 0.00
    @amount2 = 0.00
    @operation = ""

  end

  #private double Amount1 = 0;
  #private double Amount2 = 0;
  #private String Operation = "";

end