class MessageController < ApplicationController

  def index
  end

  def fonction
	@message=Message.new(params.(:text1))
	@message.save
        
	
  end 

 def print
	redirect_to action: 'print'
  end
 def see
	@message=Message.find(params[:text1])
end
    
  
end
