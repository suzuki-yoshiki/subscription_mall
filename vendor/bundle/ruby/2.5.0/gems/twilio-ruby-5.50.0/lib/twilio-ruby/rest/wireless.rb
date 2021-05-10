##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Wireless < Domain
      ##
      # Initialize the Wireless Domain
      def initialize(twilio)
        super

        @base_url = 'https://wireless.twilio.com'
        @host = 'wireless.twilio.com'
        @port = 443

        # Versions
        @v1 = nil
      end

      ##
      # Version v1 of wireless
      def v1
        @v1 ||= V1.new self
      end

      ##
      # @return [Twilio::REST::Wireless::V1::UsageRecordInstance]
      def usage_records
        self.v1.usage_records()
      end

      ##
      # @param [String] sid The unique string that we created to identify the Command
      #   resource.
      # @return [Twilio::REST::Wireless::V1::CommandInstance] if sid was passed.
      # @return [Twilio::REST::Wireless::V1::CommandList]
      def commands(sid=:unset)
        self.v1.commands(sid)
      end

      ##
      # @param [String] sid The unique string that we created to identify the RatePlan
      #   resource.
      # @return [Twilio::REST::Wireless::V1::RatePlanInstance] if sid was passed.
      # @return [Twilio::REST::Wireless::V1::RatePlanList]
      def rate_plans(sid=:unset)
        self.v1.rate_plans(sid)
      end

      ##
      # @param [String] sid The unique string that we created to identify the Sim
      #   resource.
      # @return [Twilio::REST::Wireless::V1::SimInstance] if sid was passed.
      # @return [Twilio::REST::Wireless::V1::SimList]
      def sims(sid=:unset)
        self.v1.sims(sid)
      end

      ##
      # Provide a user friendly representation
      def to_s
        '#<Twilio::REST::Wireless>'
      end
    end
  end
end