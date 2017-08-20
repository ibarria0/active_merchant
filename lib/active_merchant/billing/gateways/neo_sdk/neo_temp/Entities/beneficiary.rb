require_relative '../Entities/service'
require_relative '../Helpers/jso_nable'
class Beneficiary < JSONable

  def initialize(h = nil)

    if(h != nil)
      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="


        if(Beneficiary.instance_methods(false).include?(propNameFormatted.to_sym))
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

  def ShortCode=(shortCode)
    @shortCode = shortCode
  end

  def MerchantId=(merchantId)
    @merchantId = merchantId
  end

  def Type=(type)
    @type = type
  end

  def Status=(status)
    @status = status
  end

  def Services=(services) #List<Service> type
    @services = services
  end


  #Getters
  def getId
    return @id
  end

  def getName
    return @name
  end

  def getShortCode
    return @shortCode
  end

  def getMerchantId
    return @merchantId
  end

  def getType
    return @type
  end

  def getStatus
    return @status
  end

  def getServices
    return @services
  end


  #private int Id;
  #private String Name;
  #private String ShortCode;
  #private int MerchantId;
  #private String Type;
  #private String Status;
  #private List<Service> Services;

end