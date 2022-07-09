class Employee::AttendanceRequestsController < ApplicationController
  before_action :authenticate_employee!, only: %i[index new show]

  def index
    relation = AttendanceRequest.joins(:schedule)
    @attendance_requests = relation.where(schedules: { employee_id: current_employee.id }).page(params[:page]).per(10)
  end

  def new
    @attendance_request = AttendanceRequest.new
  end

  def create
    # シフト申請、勤怠情報、通知をまとめて登録するためトランザクション処理
    ActiveRecord::Base.transaction do
      schedule = current_employee.schedules.create!(
        starting_time: "#{params[:attendance_request][:starting_date]} #{params[:attendance_request][:starting_time]}",
        closing_time: "#{params[:attendance_request][:starting_date]} #{params[:attendance_request][:closing_time]}"
      )
      attendance_request = schedule.build_attendance_request(attendance_requests_params)
      attendance_request.save!

      attendance_request.attendance_request_notifications.create!(notification: Notification.new)
      redirect_to employee_schedules_path, notice: "シフト申請登録が完了しました"
    end
  rescue
    redirect_to employee_schedules_path, alert: "シフト申請登録に失敗しました"
  end

  def show
    @attendance_request = AttendanceRequest.find_by(id: params[:id])
  end

  private

    def attendance_requests_params
      params.require(:attendance_request).permit(:state)
    end

    def schedules_params
      params.require(:attendance_request).permit(:starting_date, :starting_time, :closing_time)
    end
end
