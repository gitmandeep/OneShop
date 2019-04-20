##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
# 
# frozen_string_literal: true

module Twilio
  module REST
    class Preview
      class HostedNumbers < Version
        ##
        # Initialize the HostedNumbers version of Preview
        def initialize(domain)
          super
          @version = 'HostedNumbers'
          @authorization_documents = nil
          @hosted_number_orders = nil
        end

        ##
        # @param [String] sid A 34 character string that uniquely identifies this
        #   AuthorizationDocument.
        # @return [Twilio::REST::Preview::HostedNumbers::AuthorizationDocumentContext] if sid was passed.
        # @return [Twilio::REST::Preview::HostedNumbers::AuthorizationDocumentList]
        def authorization_documents(sid=:unset)
          if sid.nil?
            raise ArgumentError, 'sid cannot be nil'
          elsif sid == :unset
            @authorization_documents ||= AuthorizationDocumentList.new self
          else
            AuthorizationDocumentContext.new(self, sid)
          end
        end

        ##
        # @param [String] sid A 34 character string that uniquely identifies this
        #   HostedNumberOrder.
        # @return [Twilio::REST::Preview::HostedNumbers::HostedNumberOrderContext] if sid was passed.
        # @return [Twilio::REST::Preview::HostedNumbers::HostedNumberOrderList]
        def hosted_number_orders(sid=:unset)
          if sid.nil?
            raise ArgumentError, 'sid cannot be nil'
          elsif sid == :unset
            @hosted_number_orders ||= HostedNumberOrderList.new self
          else
            HostedNumberOrderContext.new(self, sid)
          end
        end

        ##
        # Provide a user friendly representation
        def to_s
          '<Twilio::REST::Preview::HostedNumbers>'
        end
      end
    end
  end
end