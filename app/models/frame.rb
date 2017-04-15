class Frame
  attr_accessor :ballx, :bally, :num, :score

  def initialize(ballx, bally, num)
    self.num = num
    self.ballx  = ballx if ballx
    self.bally  = bally if bally
  end

  def strike?
    ballx.eql?(10)
  end

  def spare?
    (ballx + bally).eql?(10)
  end

  def sum
    ballx + bally.to_i
  end

  def last?
    num.eql?(Score::MAX_FRAMES-1)
  end

  def self.valid_frame?(frame_line, index)
    if index < Score::MAX_FRAMES-1
      # 0-8 frames
      if frame_line[0] == Score::MAX_PINS && frame_line[1].present?
        raise InvalidFrameError.new("Frame no #{index+1}: strike frame should include first throw.")
      
      elsif frame_line[0] != Score::MAX_PINS && ( frame_line.count != 2 || (frame_line[0].to_i+frame_line[1].to_i) > Score::MAX_PINS )  
        raise InvalidFrameError.new("Frame no #{index+1}: missing throw or including over 10 pins.")
      end

    elsif index == Score::MAX_FRAMES-1
      # 9/last frame
      if frame_line[0] == Score::MAX_PINS && frame_line.count != 3
        raise InvalidFrameError.new("Last frame: strike should include extra two throws.")
      
      elsif frame_line[0] != Score::MAX_PINS && ( frame_line.count != 2 || (frame_line[0].to_i+frame_line[1].to_i) > Score::MAX_PINS )
        raise InvalidFrameError.new("Last frame: missing throw or including over 10 pins.")
      end
    end
  end
end 