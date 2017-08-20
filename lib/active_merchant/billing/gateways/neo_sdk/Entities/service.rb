require_relative '../Helpers/jso_nable'
class Service < JSONable

  def initialize(h = nil)

    if(h != nil)
      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="


        if(Service.instance_methods(false).include?(propNameFormatted.to_sym))
          public_send("#{k}=",v)
        end
      }
    end

  end

  def Id=(id)
    @id = id
  end

  def Name=(name)
    @name = name
  end

  def Description=(description)
    @description = description
  end

  def IdentificationName=(identificationName)
    @identificationName = identificationName
  end

  def CustomFields=(customFields) #Hash type
    @customFields = customFields
  end

  #Getters
  def getId
    return @id
  end

  def getName
    return @name
  end

  def getDescription
    return @description
  end

  def getIdentificationName
    return @identificationName
  end

  def getCustomFields
    return @customFields
  end



  #private int Id;
  #private String Name;
  #private String Description;
  #private String IdentificationName;
  #private HashMap CustomFields;

end