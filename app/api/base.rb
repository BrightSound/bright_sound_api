module BrightSound
  class Base < Grape::API
    def self.inherited(subclass)
      super
      subclass.instance_eval do
        helpers Base::Auth
      end
    end
  end
end
