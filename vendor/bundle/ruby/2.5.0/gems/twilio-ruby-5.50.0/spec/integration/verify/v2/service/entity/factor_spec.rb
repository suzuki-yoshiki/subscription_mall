##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

require 'spec_helper.rb'

describe 'Factor' do
  it "can create" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.verify.v2.services('VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                       .entities('identity') \
                       .factors.create(friendly_name: 'friendly_name', factor_type: 'push')
    }.to raise_exception(Twilio::REST::TwilioError)

    values = {'FriendlyName' => 'friendly_name', 'FactorType' => 'push', }
    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'post',
        url: 'https://verify.twilio.com/v2/Services/VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Entities/identity/Factors',
        data: values,
    ))).to eq(true)
  end

  it "receives create_push responses" do
    @holodeck.mock(Twilio::Response.new(
        201,
      %q[
      {
          "sid": "YFaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "account_sid": "ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "service_sid": "VAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "entity_sid": "YEaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "identity": "ff483d1ff591898a9942916050d2ca3f",
          "date_created": "2015-07-30T20:00:00Z",
          "date_updated": "2015-07-30T20:00:00Z",
          "friendly_name": "friendly_name",
          "status": "unverified",
          "factor_type": "push",
          "config": {
              "sdk_version": "1.0",
              "app_id": "com.example.myapp",
              "notification_platform": "fcm",
              "notification_token": "test_token"
          },
          "url": "https://verify.twilio.com/v2/Services/VAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Entities/ff483d1ff591898a9942916050d2ca3f/Factors/YFaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      }
      ]
    ))

    actual = @client.verify.v2.services('VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                              .entities('identity') \
                              .factors.create(friendly_name: 'friendly_name', factor_type: 'push')

    expect(actual).to_not eq(nil)
  end

  it "can delete" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.verify.v2.services('VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                       .entities('identity') \
                       .factors('YFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').delete()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'delete',
        url: 'https://verify.twilio.com/v2/Services/VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Entities/identity/Factors/YFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    ))).to eq(true)
  end

  it "receives delete responses" do
    @holodeck.mock(Twilio::Response.new(
        204,
      nil,
    ))

    actual = @client.verify.v2.services('VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                              .entities('identity') \
                              .factors('YFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').delete()

    expect(actual).to eq(true)
  end

  it "can fetch" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.verify.v2.services('VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                       .entities('identity') \
                       .factors('YFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').fetch()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'get',
        url: 'https://verify.twilio.com/v2/Services/VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Entities/identity/Factors/YFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    ))).to eq(true)
  end

  it "receives fetch_push responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "sid": "YFaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "account_sid": "ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "service_sid": "VAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "entity_sid": "YEaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "identity": "ff483d1ff591898a9942916050d2ca3f",
          "date_created": "2015-07-30T20:00:00Z",
          "date_updated": "2015-07-30T20:00:00Z",
          "friendly_name": "friendly_name",
          "status": "unverified",
          "factor_type": "push",
          "config": {
              "sdk_version": "1.0",
              "app_id": "com.example.myapp",
              "notification_platform": "fcm",
              "notification_token": "test_token"
          },
          "url": "https://verify.twilio.com/v2/Services/VAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Entities/ff483d1ff591898a9942916050d2ca3f/Factors/YFaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      }
      ]
    ))

    actual = @client.verify.v2.services('VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                              .entities('identity') \
                              .factors('YFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').fetch()

    expect(actual).to_not eq(nil)
  end

  it "can read" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.verify.v2.services('VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                       .entities('identity') \
                       .factors.list()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'get',
        url: 'https://verify.twilio.com/v2/Services/VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Entities/identity/Factors',
    ))).to eq(true)
  end

  it "receives read_empty responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "factors": [],
          "meta": {
              "page": 0,
              "page_size": 50,
              "first_page_url": "https://verify.twilio.com/v2/Services/VAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Entities/ff483d1ff591898a9942916050d2ca3f/Factors?PageSize=50&Page=0",
              "previous_page_url": null,
              "url": "https://verify.twilio.com/v2/Services/VAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Entities/ff483d1ff591898a9942916050d2ca3f/Factors?PageSize=50&Page=0",
              "next_page_url": null,
              "key": "factors"
          }
      }
      ]
    ))

    actual = @client.verify.v2.services('VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                              .entities('identity') \
                              .factors.list()

    expect(actual).to_not eq(nil)
  end

  it "receives read_full responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "factors": [
              {
                  "sid": "YFaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "account_sid": "ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "service_sid": "VAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "entity_sid": "YEaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "identity": "ff483d1ff591898a9942916050d2ca3f",
                  "date_created": "2015-07-30T20:00:00Z",
                  "date_updated": "2015-07-30T20:00:00Z",
                  "friendly_name": "friendly_name",
                  "status": "unverified",
                  "factor_type": "push",
                  "config": {
                      "sdk_version": "1.0",
                      "app_id": "com.example.myapp",
                      "notification_platform": "fcm",
                      "notification_token": "test_token"
                  },
                  "url": "https://verify.twilio.com/v2/Services/VAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Entities/ff483d1ff591898a9942916050d2ca3f/Factors/YFaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
              }
          ],
          "meta": {
              "page": 0,
              "page_size": 50,
              "first_page_url": "https://verify.twilio.com/v2/Services/VAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Entities/ff483d1ff591898a9942916050d2ca3f/Factors?PageSize=50&Page=0",
              "previous_page_url": null,
              "url": "https://verify.twilio.com/v2/Services/VAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Entities/ff483d1ff591898a9942916050d2ca3f/Factors?PageSize=50&Page=0",
              "next_page_url": null,
              "key": "factors"
          }
      }
      ]
    ))

    actual = @client.verify.v2.services('VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                              .entities('identity') \
                              .factors.list()

    expect(actual).to_not eq(nil)
  end

  it "can update" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.verify.v2.services('VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                       .entities('identity') \
                       .factors('YFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').update()
    }.to raise_exception(Twilio::REST::TwilioError)

    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'post',
        url: 'https://verify.twilio.com/v2/Services/VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Entities/identity/Factors/YFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    ))).to eq(true)
  end

  it "receives verify_push responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "sid": "YFaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "account_sid": "ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "service_sid": "VAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "entity_sid": "YEaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "identity": "ff483d1ff591898a9942916050d2ca3f",
          "date_created": "2015-07-30T20:00:00Z",
          "date_updated": "2015-07-30T20:00:00Z",
          "friendly_name": "friendly_name",
          "status": "verified",
          "factor_type": "push",
          "config": {
              "sdk_version": "1.0",
              "app_id": "com.example.myapp",
              "notification_platform": "fcm",
              "notification_token": "test_token"
          },
          "url": "https://verify.twilio.com/v2/Services/VAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Entities/ff483d1ff591898a9942916050d2ca3f/Factors/YFaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      }
      ]
    ))

    actual = @client.verify.v2.services('VAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                              .entities('identity') \
                              .factors('YFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').update()

    expect(actual).to_not eq(nil)
  end
end