# encoding: UTF-8
require 'fileutils'

require 'transducers/base'
require 'transducers/png'
require 'transducers/jpg'
require 'transducers/gif'
require 'transducers/svg'
require 'transducers/otf'
require 'transducers/ttf'
require 'transducers/pdf'

module VC
  module TransductionHelper
    def transduce(size=nil)
      if VC::Transducers.handlers[self.mime_type]
        size = size.nil? ? VC.settings("preview-image-size") : size
        if self.cached? size
          self.compose_path_2(size)
        else
          FileUtils.mkpath File.dirname(self.compose_path_2(size))
          VC::Transducers.handlers[self.mime_type].call(self, size)
        end
      else
        nil
      end
    end
    
    def transducer?
      VC::Transducers.handlers[self.mime_type] ? true : false
    end
  end
end
