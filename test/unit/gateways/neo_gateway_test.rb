require 'test_helper'
require 'securerandom'

class NeoGatewayTest < Test::Unit::TestCase
  def setup
    @gateway = NeoGatewayGateway.new(
        secret_key:'XXXXXX',
        merchant:'YYYYYY',
        terminal_id:'ZZZZZ'
      )
    @credit_card = credit_card
    @amount = 100

    @options = {
      tracking: SecureRandom.hex(30),
      order_id: '1',
      billing_address: address,
      description: 'Store Purchase'
    }
  end

  ### METHOD TESTS #####

  #Tests the correct parsing of the response
  def test_parse_response
    def @gateway.public_parse_response(response)
      parse_response(response)
    end
    test_response = @gateway.public_parse_response successful_purchase_response

    # Correct Response code
    assert_equal "00", test_response[:response_code]

    # Correct DateTime
    test_date = test_response[:datetime]
    assert_equal 05, test_date.month
    assert_equal 05, test_date.day
    assert_equal 12, test_date.hour
  end

  #Tests the correct parsing of the query
  def test_parse_query
    def @gateway.public_parse_query(parameters)
      parse_query(parameters)
    end

    test_data = {}
    test_data[:lorem] = "lorem"
    test_data[:ipsum] = nil
    test_data[nil] = "lorem"
    test_data[:IPSUM] = "LOREM IPSUM çè'e'"

    assert_equal "lorem=lorem&IPSUM=LOREM+IPSUM+%C3%A7%C3%A8%27e%27",
      @gateway.public_parse_query(test_data)

  end

  ### OPERATIONS TESTS ###

  def test_successful_purchase
    @gateway.expects(:ssl_post).returns(successful_purchase_response)

    response = @gateway.purchase(@amount, @credit_card, @options)
    assert_success response

    assert_equal '012345678', response.authorization
    assert response.test?
  end

  def test_failed_purchase
    @gateway.expects(:ssl_post).returns(failed_purchase_response)

    response = @gateway.purchase(@amount, @credit_card, @options)
    assert_failure response
    assert_equal Gateway::STANDARD_ERROR_CODE[:call_issuer], response.error_code
  end

  def test_successful_authorize
  end

  def test_failed_authorize
  end

  def test_successful_capture
  end

  def test_failed_capture
  end

  def test_successful_refund
  end

  def test_failed_refund
  end

  def test_successful_void
  end

  def test_failed_void
  end

  def test_successful_verify
  end

  def test_successful_verify_with_failed_void
  end

  def test_failed_verify
  end

  def test_scrub
    #assert @gateway.supports_scrubbing?
    #assert_equal @gateway.scrub(pre_scrubbed), post_scrubbed
  end

  private

  def pre_scrubbed
    %q(
      Run the remote tests for this gateway, and then put the contents of transcript.log here.
    )
  end

  def post_scrubbed
    %q(
      Put the scrubbed contents of transcript.log here after implementing your scrubbing function.
      Things to scrub:
        - Credit card number
        - CVV
        - Sensitive authentication details
    )
  end

  def successful_purchase_response
    "00~012345678901~012345~120000~0505~012345678"
  end

  def failed_purchase_response
    "01~012345678901~012345~120000~0505~012345678"
  end

  def successful_authorize_response
  end

  def failed_authorize_response
  end

  def successful_capture_response
  end

  def failed_capture_response
  end

  def successful_refund_response
  end

  def failed_refund_response
  end

  def successful_void_response
  end

  def failed_void_response
  end
end
