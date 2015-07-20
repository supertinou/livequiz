class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]
  before_action :set_quiz, only: [:new, :create]

  # GET /sessions/1
  def show
  end

  # GET /sessions/new
  def new
    @session = Session.new
    @session.participants.build
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions
  def create
    @session = Session.new(session_params)
    @session.quiz = @quiz

    if @session.save
      redirect_to @session, notice: 'Session was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sessions/1
  def update
    if @session.update(session_params)
      redirect_to @session, notice: 'Session was successfully updated.'
    else
      set_quiz
      render :edit
    end
  end

  # DELETE /sessions/1
  def destroy
    quiz = @session.quiz
    @session.destroy
    redirect_to quiz_path(quiz,access_password: quiz.access_password), notice: 'Session was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_session
      @session = Session.find_by(access_key: params[:id])
    end

    def set_quiz
      @quiz = Quiz.find_by(access_key: params[:quiz_id], access_password: params[:access_password])
    end
    # Only allow a trusted parameter "white list" through.
    def session_params
      params.require(:session).permit(:trick, participants_attributes: [:id, :email, :name, :_destroy]).except(:trick)
    end
end
