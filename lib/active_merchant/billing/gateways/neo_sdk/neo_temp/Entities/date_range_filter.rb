require_relative '../Helpers/jso_nable'
class DateRangeFilter < JSONable

  def Date1=(date1)
    @date1 = date1
  end

  def Date2=(date2)
    @date2 = date2
  end

  def Operation=(operation)
    @operation = operation
  end

#Methods
  def GreaterThan(date)
    self.ClearFilter
    @date1 = date
    @operation = "GREATER_THAN"
    return self
  end

  def LessThan(date)
    self.ClearFilter
    @date1 = date
    @operation = "LESS_THAN"
    return self
  end

  def EqualTo(date)
    self.ClearFilter
    @date1 = date
    @operation = "EQUAL_TO"
    return self
  end

  def Between(dateFrom, dateTo)
    self.ClearFilter
    @date1 = dateFrom
    @date2 = dateTo
    @operation = "BETWEEN"
    return self
  end


  #private
  def ClearFilter
    @date1 = ""
    @date2 = ""
    @operation = ""
  end


  #private String Date1;
  #private String Date2;
  #private String Operation = "";

end