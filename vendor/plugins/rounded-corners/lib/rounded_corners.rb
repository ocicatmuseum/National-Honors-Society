#=============================================================================
#
# Copyright 2007 Adam Wisniewski <adamw@tbcn.ca> 
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at 
#
#  http://www.apache.org/licenses/LICENSE-2.0 
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
#
#=============================================================================

require 'RMagick'

class RoundedCorners
  def self.generate ( color, background_color, height, width, corner )
    color_hex         = color =~ /[\da-fA-F]{6}/
    bg_hex            = background_color =~ /[\da-fA-F]{6}/

    # create iamge
    img = Magick::Image.new( width.to_i, height.to_i) {
      self.background_color = (bg_hex ? "#" : "") + background_color
    }
    
    img.format = 'png'
    
    # draw corner
    corners = Magick::Draw.new 
    corners.stroke = (color_hex ? "#" : "") + color
    corners.fill = (color_hex ? "#" : "") + color
    corners.roundrectangle(0, 0, 
                           img.columns * 2 - 1, img.rows * 2 - 1, 
                           img.columns, img.rows)
    corners.draw( img )
    
    # rotate image
    case corner 
      when "tr"
        img.rotate!( 90 )
      when "br"
        img.rotate!( 180 )
      when "bl"
        img.rotate!( 270 )
    end
    
    img.to_blob
                  
  end
end