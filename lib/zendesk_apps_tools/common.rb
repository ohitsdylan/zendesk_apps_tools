require 'faraday'

module ZendeskAppsTools
  module Common
    def api_request(url, request = Faraday.new)
      request.get(url)
    end

    def say_error_and_exit(msg)
      say_error msg
      exit 1
    end

    def say_error(msg)
      say msg, :red
    end

    def get_value_from_stdin(prompt, opts = {})
      options = {
        valid_regex: opts[:allow_empty] ? /^.*$/ : /\S+/,
        error_msg: 'Invalid, try again:',
        allow_empty: false
      }.merge(opts)

      thor_options = { default: options[:default] }

      while input = ask(prompt, thor_options)
        return '' if options[:allow_empty] && input.empty?
        if input.to_s =~ options[:valid_regex]
          break
        else
          say_error options[:error_msg]
        end
      end

      input
    end

    def get_password_from_stdin(prompt)
      ask(prompt, echo: false)
      say ''
    end
  end
end
