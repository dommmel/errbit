require 'spec_helper'

describe NotificationService::HubotService do
  it "it should send a notification to Hubot" do
    # setup
    notice = Fabricate :notice
    notification_service = Fabricate :hubot_notification_service, :app => notice.app
    problem = notice.problem

    # faraday stubbing
    HTTParty.should_receive(:post).with(notification_service.api_token, :body => {:message => '[production][foo#bar] FooError: Too Much Bar', :room => notification_service.room_id}).and_return(true)

    notification_service.create_notification(problem)
  end
end
