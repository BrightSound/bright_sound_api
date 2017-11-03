require_relative '../helpers/helpers'
module BrightSound
  module Endpoints
    class Base < Grape::API
      def self.inherited(subclass)
        super
        subclass.instance_eval do
          helpers Base::Helpers
        end
      end
    end
  end
end
