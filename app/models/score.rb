class Score 
  MAX_FRAMES = 10
  MAX_PINS = 10
  MAX_ATTEMPTS_PER_FRAME = 2
  ALL_STRIKE_SCORE = 300

  attr_accessor :frames, :score

  def initialize(frames=[])
    self.score  = 0
    self.frames = frames
  end

  def make_frames(pin_arr)
    frames = []
    pin_arr.each_with_index do |frame_line, index|
      Frame.valid_frame?(frame_line, index)
      frames << Frame.new(frame_line[0], frame_line[1], index)
    end
    self.frames = frames
    @last_frame = pin_arr.last
    self
  end

  def get_frame_score
    scores = []
    self.frames.each do |frame|
      unless frame.last?
        self.score += frame.sum + (if frame.strike?
          next_two_ball(frame.num)
        end.to_i)
        puts "Frame and Score #{ frame.num}: [#{frame.ballx}, #{frame.bally}] #{ self.score }"
        frame.score = self.score
      else
        self.score += frame.sum + (if frame.strike?
          @last_frame[2]
        end.to_i)
        puts "Frame and Score #{ frame.num}: [#{frame.ballx}, #{frame.bally}] #{ self.score }"
        frame.score = self.score
      end
    end
  end

  def next_ball(frame_number)
    p "get points for next_ball"
    frames[frame_number + 1]
  end

  def next_two_ball(frame_number)
    p "get points for next_two_ball"
    next_frame = next_ball(frame_number)
    if next_frame.strike?
      next_frame.sum + get_spare_points(frame_number + 1).ballx
    else
      next_frame.sum
    end
  end

end 