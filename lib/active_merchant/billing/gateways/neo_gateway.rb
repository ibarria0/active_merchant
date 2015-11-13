require 'cgi'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class NeoGatewayGateway < Gateway
      self.test_url = 'http://gatewaytest.merchantprocess.net/transaction.aspx'
      self.live_url = 'https://gateway.merchantprocess.net/transaction.aspx'

      self.money_format = :dollars
      self.supported_countries = ['PA']
      self.default_currency = 'USD'
      self.supported_cardtypes = [:visa, :master, :american_express, :discover]

      self.homepage_url = 'http://www.example.net/'
      self.display_name = 'Neo Gateway'

      SUCCESS_MESSAGE = "Success"

      SUCCESS_CODES = [
        "00", "11"
      ]

      STANDARD_ERROR_CODE_MAPPING = {
        #"00" => "Ok , or Approved",
        "01" => STANDARD_ERROR_CODE[:call_issuer],
        "02" => STANDARD_ERROR_CODE[:call_issuer],
        "03" => "Invalid Merchant",
        "04" => STANDARD_ERROR_CODE[:pickup_card],
        "05" => STANDARD_ERROR_CODE[:card_declined],
        "06" => STANDARD_ERROR_CODE[:call_issuer],
        "07" => STANDARD_ERROR_CODE[:pickup_card],
        "08" => "Error in File ISOBMP",
        "09" => STANDARD_ERROR_CODE[:card_declined],
        "10" => STANDARD_ERROR_CODE[:card_declined],
        #"11" => "Ok , or Approved",
        "12" => "Invalid Transaction",
        "13" => "Invalid Amount",
        "14" => STANDARD_ERROR_CODE[:invalid_number],#"Invalid Card",
        "15" => "Non Existent Issuer",
        "16" => STANDARD_ERROR_CODE[:card_declined],
        "17" => "Invalid Date Capture",
        "18" => STANDARD_ERROR_CODE[:card_declined],
        "19" => "Retry Transaction later. Processor timed out.",
        "20" => STANDARD_ERROR_CODE[:card_declined],
        "21" => "Invalid Reverse. Reference transaction does not exist.",
        "22" => STANDARD_ERROR_CODE[:card_declined],
        "23" => STANDARD_ERROR_CODE[:card_declined],
        "24" => STANDARD_ERROR_CODE[:card_declined],
        "25" => STANDARD_ERROR_CODE[:card_declined],
        "26" => STANDARD_ERROR_CODE[:card_declined],
        "27" => STANDARD_ERROR_CODE[:card_declined],
        "28" => STANDARD_ERROR_CODE[:card_declined],
        "29" => STANDARD_ERROR_CODE[:card_declined],
        "30" => "Format Error",
        "31" => "Bank not Allowed",
        "32" => STANDARD_ERROR_CODE[:card_declined],
        "33" => STANDARD_ERROR_CODE[:card_declined],
        "34" => STANDARD_ERROR_CODE[:card_declined],
        "35" => STANDARD_ERROR_CODE[:card_declined],
        "36" => STANDARD_ERROR_CODE[:card_declined],
        "37" => STANDARD_ERROR_CODE[:card_declined],
        "38" => STANDARD_ERROR_CODE[:card_declined],
        "39" => "Invalid Transaction.",
        "40" => STANDARD_ERROR_CODE[:card_declined],
        "41" => STANDARD_ERROR_CODE[:pickup_card],
        "42" => STANDARD_ERROR_CODE[:card_declined],
        "43" => STANDARD_ERROR_CODE[:pickup_card],
        "44" => STANDARD_ERROR_CODE[:card_declined],
        "45" => STANDARD_ERROR_CODE[:card_declined],
        "46" => STANDARD_ERROR_CODE[:card_declined],
        "47" => STANDARD_ERROR_CODE[:card_declined],
        "48" => STANDARD_ERROR_CODE[:card_declined],
        "49" => STANDARD_ERROR_CODE[:card_declined],
        "50" => STANDARD_ERROR_CODE[:card_declined],
        "51" => "Insufficient Funds",
        "52" => "Invalid Account",
        "53" => "Invalid Account",
        "54" => "Expired Card",
        "55" => "Invalid PIN",
        "56" => STANDARD_ERROR_CODE[:card_declined],
        "57" => STANDARD_ERROR_CODE[:card_declined],
        "58" => "Invalid Transaction",
        "59" => STANDARD_ERROR_CODE[:card_declined],
        "60" => STANDARD_ERROR_CODE[:card_declined],
        "61" => STANDARD_ERROR_CODE[:card_declined],
        "62" => STANDARD_ERROR_CODE[:card_declined],
        "63" => "Error MAC Key",
        "64" => STANDARD_ERROR_CODE[:card_declined],
        "65" => STANDARD_ERROR_CODE[:card_declined],
        "66" => STANDARD_ERROR_CODE[:card_declined],
        "67" => STANDARD_ERROR_CODE[:pickup_card],
        "68" => "Error, Slow Response",
        "69" => STANDARD_ERROR_CODE[:card_declined],
        "70" => "Declined. Transaction previously approved. If you are trying to submit an ",
        "71" => STANDARD_ERROR_CODE[:card_declined],
        "72" => STANDARD_ERROR_CODE[:card_declined],
        "73" => STANDARD_ERROR_CODE[:card_declined],
        "74" => STANDARD_ERROR_CODE[:card_declined],
        "75" => STANDARD_ERROR_CODE[:card_declined],
        "76" => "Declined. An approved preauthorization does not exist.",
        "77" => "Error in Close",
        "78" => "Trace Not Found",
        "79" => "Error in Key",
        "80" => "# Batch not Found",
        "81" => "TC not DB/CR",
        "82" => "REF. doesn't Exist",
        "83" => "Direct TX Doesn't Exist",
        "84" => "Invalid Life Cycle",
        "85" => STANDARD_ERROR_CODE[:card_declined],
        "86" => STANDARD_ERROR_CODE[:card_declined],
        "87" => STANDARD_ERROR_CODE[:incorrect_pin],#"Error en llave del PIN",
        "88" => "Error, Sync MAC",
        "89" => "Error, in TID",
        "90" => "Service not Available",
        "91" => "Issuer out of Service",
        "92" => "Invalid Issuer",
        "93" => STANDARD_ERROR_CODE[:card_declined],
        "94" => "Duplicate transmission",
        "95" => "Start Sending Batch",
        "96" => STANDARD_ERROR_CODE[:call_issuer],
        "97" => STANDARD_ERROR_CODE[:card_declined],
        "98" => "Error, Duplicate REV.",
        "A0" => "Monthly Volumen Exceded.",
        "A1" => "Highest Ticket Exceded",
        "N7" => STANDARD_ERROR_CODE[:invalid_cvc], #STANDARD_ERROR_CODE[:card_declined] for cvv2 failure."
        "XX" => "ActiveMerchant: Response failed to be decoded" # Custom error.
      }

      PROCESS_CODES = {
        :sale               => '000000',
        :preauthorization   => '300000',
        :adjustment         => '290000',
        :void               => '220000',
        :credit             => '200000',
        :rebill             => '100000'
      }

      # secret_key => AccCode
      def initialize(options={})
        requires!(options, :secret_key, :merchant, :terminal_id)
        super
      end

      def purchase(money, payment, options={})
        post = {}
        add_invoice(post, money, options)
        add_payment_method(post, payment)
        add_address(post, payment, options)
        add_customer_data(post, options)

        commit(:sale, post)
      end

      def authorize(money, payment, options={})
        post = {}
        add_invoice(post, money, options)
        add_payment_method(post, payment)
        add_address(post, payment, options)
        add_tracking(post, options)
        add_customer_data(post, options)

        commit(:preauthorization, post)
      end

      def capture(money, authorization, options={})
        post = {'Ballot':  authorization }
        add_payment_method(post, payment)
        add_tracking(post, options)
        commit(:adjustment, post)
      end

      def refund(money, authorization, options={})
        post = {'Ballot':  authorization }
        add_invoice(post, money, options)
        add_payment_method(post, payment)
        add_tracking(post, options)
        commit(:credit, post)
      end

      def void(authorization, options={})
        post = {'Ballot':  authorization }
        add_payment_method(post, payment)
        add_tracking(post, options)
        commit(:void, post)
      end

      def verify(credit_card, options={})
        MultiResponse.run(:use_first_response) do |r|
          r.process { authorize(100, credit_card, options) }
          r.process(:ignore_result) { void(r.authorization, options) }
        end
      end

      def supports_scrubbing?
        true
      end

      def scrub(transcript)

        # Removes sensitive data from the logs using Regexp
        transcript
          .gsub(/AccCode=[[:word:]]+/, 'AccCode=FILTERED')
          .gsub(/CardNumber=[[:word:]]+/, 'CardNumber=FILTERED')
          .gsub(/cvv2=[[:word:]]+/, 'cvv2=FILTERED')
      end

      private

      def add_customer_data(post, options)
        post['SiteIPAddress'] = options[:ip]
        post['Email'] = options[:email]
      end

      def add_address(post, creditcard, options)

        # Both addresses contain the same components
        billing_address = options[:billing_address] || options[:address]
        shipping_address = options[:shipping_address] || options[:address]

        # Add all the components of the address, just adding a prefix on the key
        parser = lambda do |address, prefix|
          post[prefix + 'address'] = address[:address1].to_s + " " + address[:address2].to_s
          post[prefix + 'city'] = address[:city]
          post[prefix + 'country'] = address[:country]
          post[prefix + 'state'] = address[:state]
          post[prefix + 'zip_code'] = address[:zip]
        end

        # Call the parser
        parser.call(billing_address, "Bill_") if billing_address.present?
        parser.call(shipping_address, "Ship_") if shipping_address.present?
      end

      def add_invoice(post, money, options)
        post['Amount'] = amount(money)
        #post['CurrencyCode'] = (options[:currency] || currency(money))
        post['CurrencyCode'] = 840 # USD Hardcoded
      end

      def add_payment_method(post, payment)
        post['Cardholder'] = payment.name
        post['CardNumber'] = payment.number
        post['Expiration'] = format(payment.month, :two_digits) + format(payment.year, :two_digits)
        post['cvv2'] = payment.verification_value
      end

      def add_tracking(post, options)
        post['Tracking'] = options[:tracking_number]
      end

      def parse_response(body)

        # Default response
        response = {
          :raw => body.to_s,
          :response_code => "XX",
          :reference_number => "0",
          :authorization_number => "0",
          :datetime => DateTime.now,
          :ballot_number => "0"
        }

        # Try to parse
        unless body.nil? || body.empty?
          array = body.split('~')
          response[:response_code]        = array[0]
          response[:reference_number]     = array[1]
          response[:authorization_number] = array[2]
          response[:ballot_number]        = array[5]

          # Try to parse the DateTime
          begin
            response[:datetime] = DateTime.strptime(
                array[3].to_s + "-" + array[4].to_s,
                "%H%M%S-%m%d"
              )
          rescue
          end
        end

        # Return response
        return response
      end

      def parse_query(parameters)

        # Parser: Parse the value in URL format and add it
        # only if neither the key nor the value is null
        parse_function = lambda do |item|
          item[0].to_s + "=" + CGI.escape(item[1].to_s) unless
            (item[0].nil? || item[1].nil?)
        end

        #Parse array
        return parameters.each
          .map(&parse_function)
          .compact
          .join('&')
      end

      def commit(action, parameters)

        # Add credentials
        parameters['AccCode'] = @options[:secret_key]
        parameters['ProcCode'] = PROCESS_CODES[action]
        parameters['Merchant'] = @options[:merchant]
        parameters['Terminal'] = @options[:terminal_id]

        # Build the query URL
        query = parse_query parameters
        final_url = (test? ? test_url : live_url) + "?" + query
        response = parse_response(ssl_post(final_url, nil))

        Response.new(
          success_from(response),
          message_from(response),
          response,
          authorization: authorization_from(response),
          avs_result: nil,
          cvv_result: nil,
          test: test?,
          error_code: error_code_from(response)
        )
      end

      def success_from(response)
        SUCCESS_CODES.include? response[:response_code]
      end

      def message_from(response)
        success_from(response) ? SUCCESS_MESSAGE : error_code_from(response)
      end

      def authorization_from(response)

        # Ballot number is the id one must repost to modify verified payments
        response[:ballot_number]
      end

      def error_code_from(response)
        unless success_from(response)
          STANDARD_ERROR_CODE_MAPPING[response[:response_code]]
        end
      end
    end
  end
end
