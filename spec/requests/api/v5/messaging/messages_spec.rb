require 'rails_helper'

describe MessagingController do 
  
  let!(:user) { FactoryGirl.create(:user, email: 'message@mail.com') }
  let!(:client) { FactoryGirl.create(:client) }
  let!(:employer) { FactoryGirl.create(:user, email: 'employer@messaging.com', user_type: "job_seeker") }
  let!(:job_seeker) { FactoryGirl.create(:job_seeker)}
  let!(:job_role) { FactoryGirl.create(:job_role) }
  let!(:job) { FactoryGirl.create(:job, job_role: job_role) }
  let!(:applicant) { FactoryGirl.create(:applicant, job: job, job_seeker: job_seeker, status: 4)}

  describe " POST /api/v5/messaging/messages" do

    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    context "reply to sender" do
      it "should send message back to sender" do

        receipt = user.send_message(job_seeker, 'body', 'subject')
        receipt1 = user.send_message(job_seeker, 'body', 'subject')
        allow_any_instance_of(JobSeeker).to receive(:reply_to_employer).and_return(receipt)

        job_seeker.mailbox.conversations.count == 0
        post reply_api_v5_messaging_index_path, { employer_id: user.id, body: 'message', "phone" => job_seeker.phone },{ "HTTP_AUTHORIZATION" => client.api_key }
        
        json = JSON.parse(response.body)
        json['receiver_id'] == receipt.receiver_id
        json['notification_id'] == receipt.notification_id
        job_seeker.mailbox.conversations.count == 2
      end
    end

    context "POST /api/v5/messaging/conversations" do
      it "should return all conversations" do
        receipt = employer.send_message(job_seeker, 'message 1', 'subject 1')
        receipt1 = employer.send_message(job_seeker, 'message 2', 'subject 2')

        post conversations_api_v5_messaging_index_path, { employer_id: employer.id, body: 'message', "phone" => job_seeker.phone },{ "HTTP_AUTHORIZATION" => client.api_key }

        json = JSON.parse(response.body)
        json.count == 2
        json.first['employer_id'] == employer.id
        json.first['last_message'] == 'message 2'
        json.last['last_message'] == 'message 1'
        json.last['subject'] == 'subject 1'
        json.first['subject'] == 'subject 2'
      end
    end

    context "POST /api/v5/messaging/conversations" do
      it "should return all conversation messages" do
        receipt = user.send_message(job_seeker, 'my message', 'all status')
        receipt1 = user.send_message(job_seeker, 'body', 'subject')

        post messages_api_v5_messaging_index_path, { employer_id: user.id, conversation_id: receipt.conversation.id, "phone" => job_seeker.phone },{ "HTTP_AUTHORIZATION" => client.api_key }
        
        json = JSON.parse(response.body)
        json.first['conversation_id'] == receipt.conversation.id
        json.first['sender_id'] == user.id
        json.first['body'] == 'my message'
        json.first['subject'] == 'all status'
      end
    end

    context "without apikey" do
      it "should return invalid api key error" do
        post conversations_api_v5_messaging_index_path, { employer_id: user.id, body: 'message', "phone" => job_seeker.phone }
        json = JSON.parse(response.body)
        json['message'] == "Invalid api key."
        json['status'] == 401
      end
    end

    context "with invalid api key" do
      it "should return invalid api key error" do
        post reply_api_v5_messaging_index_path, { employer_id: user.id, body: 'message', "phone" => job_seeker.phone },{ "HTTP_AUTHORIZATION" => 'invalid' }
        json = JSON.parse(response.body)
        json['message'] == "Invalid api key."
        json['status'] == 401
      end
    end

    context "without phone" do
      it "should return require phone" do
        post conversations_api_v5_messaging_index_path, { employer_id: user.id, body: 'message' },{ "HTTP_AUTHORIZATION" => client.api_key }
        json = JSON.parse(response.body)
        json['message'] == "Phone is required."
        json['status'] == 401
      end
    end

    context "with invalid job seeker" do
      it "should return job seeker does not exist" do
        post messages_api_v5_messaging_index_path, { employer_id: user.id, body: 'message', "phone" => 'invalid' },{ "HTTP_AUTHORIZATION" => client.api_key }
        json = JSON.parse(response.body)
        json['message'] == "Job Seeker with these credentials doesn't exist."
        json['status'] == 401
      end
    end

  end
end