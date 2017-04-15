require 'json'
class Api::ScoresController  < ApplicationController
	skip_before_filter :verify_authenticity_token

	def create
		return render json: {message: "Enter frame array."}, status: 400 if params[:frame_arr].blank?
		
		begin
			@frame_arr = JSON.parse(params[:frame_arr])
			return render json: {message: "Invaluid frame array."}, status: 400 if @frame_arr.count != Score::MAX_FRAMES

    	@score = Score.new()
			@score.make_frames(@frame_arr)
			@score.get_frame_score
			return render json: @score.frames.map{|m| m.score}, status: 200

		rescue JSON::ParserError => e
			return render json: {message: "Enter valid json format for input param."}, status: 400
		rescue Score::InvalidFrameError => e
      return render json: {message: e.message}, status: 400
    end
	end

end