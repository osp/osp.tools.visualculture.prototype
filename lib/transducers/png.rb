# encoding: UTF-8
# PNG transducer
$:.unshift File.join(File.dirname(__FILE__), "..")
require 'visualculture'

module VC
  module Transducers
    png = lambda {|blob, size|
      r = Image.from_blob(blob.data)
      name = blob.compose_path_2(size)
      geometry = Geometry.new size, size, nil, nil, GreaterGeometry
      x = r[0].change_geometry geometry do |h,w,img|
        img.resize! h,w
      end
      x.write name
      name
    }
    @handlers["image/png"] = png
  end
end
