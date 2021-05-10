##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Preview < Domain
      class Marketplace < Version
        class InstalledAddOnContext < InstanceContext
          ##
          # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
          class InstalledAddOnExtensionList < ListResource
            ##
            # Initialize the InstalledAddOnExtensionList
            # @param [Version] version Version that contains the resource
            # @param [String] installed_add_on_sid The SID of the InstalledAddOn resource to
            #   which this extension applies.
            # @return [InstalledAddOnExtensionList] InstalledAddOnExtensionList
            def initialize(version, installed_add_on_sid: nil)
              super(version)

              # Path Solution
              @solution = {installed_add_on_sid: installed_add_on_sid}
              @uri = "/InstalledAddOns/#{@solution[:installed_add_on_sid]}/Extensions"
            end

            ##
            # Lists InstalledAddOnExtensionInstance records from the API as a list.
            # Unlike stream(), this operation is eager and will load `limit` records into
            # memory before returning.
            # @param [Integer] limit Upper limit for the number of records to return. stream()
            #    guarantees to never return more than limit.  Default is no limit
            # @param [Integer] page_size Number of records to fetch per request, when
            #    not set will use the default value of 50 records.  If no page_size is defined
            #    but a limit is defined, stream() will attempt to read the limit with the most
            #    efficient page size, i.e. min(limit, 1000)
            # @return [Array] Array of up to limit results
            def list(limit: nil, page_size: nil)
              self.stream(limit: limit, page_size: page_size).entries
            end

            ##
            # Streams InstalledAddOnExtensionInstance records from the API as an Enumerable.
            # This operation lazily loads records as efficiently as possible until the limit
            # is reached.
            # @param [Integer] limit Upper limit for the number of records to return. stream()
            #    guarantees to never return more than limit. Default is no limit.
            # @param [Integer] page_size Number of records to fetch per request, when
            #    not set will use the default value of 50 records. If no page_size is defined
            #    but a limit is defined, stream() will attempt to read the limit with the most
            #    efficient page size, i.e. min(limit, 1000)
            # @return [Enumerable] Enumerable that will yield up to limit results
            def stream(limit: nil, page_size: nil)
              limits = @version.read_limits(limit, page_size)

              page = self.page(page_size: limits[:page_size], )

              @version.stream(page, limit: limits[:limit], page_limit: limits[:page_limit])
            end

            ##
            # When passed a block, yields InstalledAddOnExtensionInstance records from the API.
            # This operation lazily loads records as efficiently as possible until the limit
            # is reached.
            def each
              limits = @version.read_limits

              page = self.page(page_size: limits[:page_size], )

              @version.stream(page,
                              limit: limits[:limit],
                              page_limit: limits[:page_limit]).each {|x| yield x}
            end

            ##
            # Retrieve a single page of InstalledAddOnExtensionInstance records from the API.
            # Request is executed immediately.
            # @param [String] page_token PageToken provided by the API
            # @param [Integer] page_number Page Number, this value is simply for client state
            # @param [Integer] page_size Number of records to return, defaults to 50
            # @return [Page] Page of InstalledAddOnExtensionInstance
            def page(page_token: :unset, page_number: :unset, page_size: :unset)
              params = Twilio::Values.of({
                  'PageToken' => page_token,
                  'Page' => page_number,
                  'PageSize' => page_size,
              })

              response = @version.page('GET', @uri, params: params)

              InstalledAddOnExtensionPage.new(@version, response, @solution)
            end

            ##
            # Retrieve a single page of InstalledAddOnExtensionInstance records from the API.
            # Request is executed immediately.
            # @param [String] target_url API-generated URL for the requested results page
            # @return [Page] Page of InstalledAddOnExtensionInstance
            def get_page(target_url)
              response = @version.domain.request(
                  'GET',
                  target_url
              )
              InstalledAddOnExtensionPage.new(@version, response, @solution)
            end

            ##
            # Provide a user friendly representation
            def to_s
              '#<Twilio.Preview.Marketplace.InstalledAddOnExtensionList>'
            end
          end

          ##
          # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
          class InstalledAddOnExtensionPage < Page
            ##
            # Initialize the InstalledAddOnExtensionPage
            # @param [Version] version Version that contains the resource
            # @param [Response] response Response from the API
            # @param [Hash] solution Path solution for the resource
            # @return [InstalledAddOnExtensionPage] InstalledAddOnExtensionPage
            def initialize(version, response, solution)
              super(version, response)

              # Path Solution
              @solution = solution
            end

            ##
            # Build an instance of InstalledAddOnExtensionInstance
            # @param [Hash] payload Payload response from the API
            # @return [InstalledAddOnExtensionInstance] InstalledAddOnExtensionInstance
            def get_instance(payload)
              InstalledAddOnExtensionInstance.new(
                  @version,
                  payload,
                  installed_add_on_sid: @solution[:installed_add_on_sid],
              )
            end

            ##
            # Provide a user friendly representation
            def to_s
              '<Twilio.Preview.Marketplace.InstalledAddOnExtensionPage>'
            end
          end

          ##
          # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
          class InstalledAddOnExtensionContext < InstanceContext
            ##
            # Initialize the InstalledAddOnExtensionContext
            # @param [Version] version Version that contains the resource
            # @param [String] installed_add_on_sid The SID of the InstalledAddOn resource with
            #   the extension to fetch.
            # @param [String] sid The SID of the InstalledAddOn Extension resource to fetch.
            # @return [InstalledAddOnExtensionContext] InstalledAddOnExtensionContext
            def initialize(version, installed_add_on_sid, sid)
              super(version)

              # Path Solution
              @solution = {installed_add_on_sid: installed_add_on_sid, sid: sid, }
              @uri = "/InstalledAddOns/#{@solution[:installed_add_on_sid]}/Extensions/#{@solution[:sid]}"
            end

            ##
            # Fetch the InstalledAddOnExtensionInstance
            # @return [InstalledAddOnExtensionInstance] Fetched InstalledAddOnExtensionInstance
            def fetch
              payload = @version.fetch('GET', @uri)

              InstalledAddOnExtensionInstance.new(
                  @version,
                  payload,
                  installed_add_on_sid: @solution[:installed_add_on_sid],
                  sid: @solution[:sid],
              )
            end

            ##
            # Update the InstalledAddOnExtensionInstance
            # @param [Boolean] enabled Whether the Extension should be invoked.
            # @return [InstalledAddOnExtensionInstance] Updated InstalledAddOnExtensionInstance
            def update(enabled: nil)
              data = Twilio::Values.of({'Enabled' => enabled, })

              payload = @version.update('POST', @uri, data: data)

              InstalledAddOnExtensionInstance.new(
                  @version,
                  payload,
                  installed_add_on_sid: @solution[:installed_add_on_sid],
                  sid: @solution[:sid],
              )
            end

            ##
            # Provide a user friendly representation
            def to_s
              context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
              "#<Twilio.Preview.Marketplace.InstalledAddOnExtensionContext #{context}>"
            end

            ##
            # Provide a detailed, user friendly representation
            def inspect
              context = @solution.map {|k, v| "#{k}: #{v}"}.join(',')
              "#<Twilio.Preview.Marketplace.InstalledAddOnExtensionContext #{context}>"
            end
          end

          ##
          # PLEASE NOTE that this class contains preview products that are subject to change. Use them with caution. If you currently do not have developer preview access, please contact help@twilio.com.
          class InstalledAddOnExtensionInstance < InstanceResource
            ##
            # Initialize the InstalledAddOnExtensionInstance
            # @param [Version] version Version that contains the resource
            # @param [Hash] payload payload that contains response from Twilio
            # @param [String] installed_add_on_sid The SID of the InstalledAddOn resource to
            #   which this extension applies.
            # @param [String] sid The SID of the InstalledAddOn Extension resource to fetch.
            # @return [InstalledAddOnExtensionInstance] InstalledAddOnExtensionInstance
            def initialize(version, payload, installed_add_on_sid: nil, sid: nil)
              super(version)

              # Marshaled Properties
              @properties = {
                  'sid' => payload['sid'],
                  'installed_add_on_sid' => payload['installed_add_on_sid'],
                  'friendly_name' => payload['friendly_name'],
                  'product_name' => payload['product_name'],
                  'unique_name' => payload['unique_name'],
                  'enabled' => payload['enabled'],
                  'url' => payload['url'],
              }

              # Context
              @instance_context = nil
              @params = {'installed_add_on_sid' => installed_add_on_sid, 'sid' => sid || @properties['sid'], }
            end

            ##
            # Generate an instance context for the instance, the context is capable of
            # performing various actions.  All instance actions are proxied to the context
            # @return [InstalledAddOnExtensionContext] InstalledAddOnExtensionContext for this InstalledAddOnExtensionInstance
            def context
              unless @instance_context
                @instance_context = InstalledAddOnExtensionContext.new(
                    @version,
                    @params['installed_add_on_sid'],
                    @params['sid'],
                )
              end
              @instance_context
            end

            ##
            # @return [String] The unique string that identifies the resource
            def sid
              @properties['sid']
            end

            ##
            # @return [String] The SID of the InstalledAddOn resource to which this extension applies
            def installed_add_on_sid
              @properties['installed_add_on_sid']
            end

            ##
            # @return [String] The string that you assigned to describe the resource
            def friendly_name
              @properties['friendly_name']
            end

            ##
            # @return [String] The name of the Extension's Product
            def product_name
              @properties['product_name']
            end

            ##
            # @return [String] An application-defined string that uniquely identifies the resource
            def unique_name
              @properties['unique_name']
            end

            ##
            # @return [Boolean] Whether the Extension will be invoked
            def enabled
              @properties['enabled']
            end

            ##
            # @return [String] The absolute URL of the resource
            def url
              @properties['url']
            end

            ##
            # Fetch the InstalledAddOnExtensionInstance
            # @return [InstalledAddOnExtensionInstance] Fetched InstalledAddOnExtensionInstance
            def fetch
              context.fetch
            end

            ##
            # Update the InstalledAddOnExtensionInstance
            # @param [Boolean] enabled Whether the Extension should be invoked.
            # @return [InstalledAddOnExtensionInstance] Updated InstalledAddOnExtensionInstance
            def update(enabled: nil)
              context.update(enabled: enabled, )
            end

            ##
            # Provide a user friendly representation
            def to_s
              values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
              "<Twilio.Preview.Marketplace.InstalledAddOnExtensionInstance #{values}>"
            end

            ##
            # Provide a detailed, user friendly representation
            def inspect
              values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
              "<Twilio.Preview.Marketplace.InstalledAddOnExtensionInstance #{values}>"
            end
          end
        end
      end
    end
  end
end