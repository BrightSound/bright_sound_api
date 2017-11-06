require_relative '../helpers/authentication'
require_relative '../helpers/error'
module BrightSound
  module Endpoints
    class Base < Grape::API
      def self.inherited(subclass)
        super
        subclass.instance_eval do
          helpers Base::Helpers::Authentication
        end
      end
    end
  end
end
