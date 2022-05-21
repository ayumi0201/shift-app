class Administrator::AbsenceRequestsController < ApplicationController
  def index
    @absence_requests = AbsenceRequest.all
  end

  def edit
    @absence_request = AbsenceRequest.find_by(id: params[:id])
  end

  def update
    ActiveRecord::Base.transaction do
      absence_request = AbsenceRequest.find_by(id: params[:id])
      absence_request.update(absence_request_params)
      if params[:absence_request][:state] == "approval"
        absence_request.notifications.create!(action: "approval")
      else
        absence_request.notifications.create!(action: "rejection")
      end
      redirect_to administrator_absence_requests_path, notice: "欠勤申請編集が完了しました"
    end
  rescue
    redirect_to administrator_absence_requests_path, alert: "欠勤申請編集に失敗しました"
  end

  private

    def absence_request_params
      params.require(:absence_request).permit(:state)
    end

    def notification_params
      notification = Notification.new(action: params[:absence_request][:state])

      params[:notification].merge!(action: notification.action)
      params.require(:notification).permit(:action).merge(action: notification.action)
    end
end