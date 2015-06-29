module OAuthEmail
  module Command
    class CommandProxy
      def initialize(mod)
        @proxy_name = mod
        @proxy_target = mod.constantize
      end

      def commands
        @proxy_target.constants.map { |c| c.to_s.downcase }
      end

      def method_missing(name, *args, &blk)
        name = name.to_s
        bang = (!!name.delete!('!') && '!') || nil
        klass_name = name.classify

        if @proxy_target.const_defined?(klass_name)
          klass = [@proxy_name, klass_name].join('::').constantize
          klass.send("run#{bang}", *args, &blk)
        else
          raise NotImplementedError
        end
      end
    end

    class << self
      def proxies
        @proxies ||= {}
      end

      def [](mod)
        proxies[mod.to_s] ||= CommandProxy.new([name, mod.to_s.classify].join('::'))
      end
    end
  end
end
