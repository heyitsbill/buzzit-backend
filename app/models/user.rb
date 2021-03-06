class User < ApplicationRecord
    has_many :responses
    belongs_to :room
    has_many :messages
    #validates :username, presence: true, uniqueness: true
    validates_uniqueness_of :name, :scope => [:room_id] 
    
    def self.destroy_by_name_and_room_id(name, room_id)
        user=User.find(name: name, room_id: room_id)
        user.destroy

    end

    def score
        totalSubmitted=self.responses.count
        numCorrect=self.responses.select{|response| response.option.is_correct==true}.count
        return numCorrect.to_s+"/"+totalSubmitted.to_s
    end
end
