class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @expenses = current_user.expenses.includes(:author)
    @grouped_expenses = @expenses.grouped
    @total_spent = current_user.total_spent
  end

  def index_ungrouped
    @expenses = current_user.expenses.includes(:author)
    @ungrouped_expenses = @expenses.ungrouped
    @total_spent = current_user.total_spent
  end

  def show
    @expense = Expense.find(params[:id])
    @add_to_group_list = @expense.not_in_group
  end

  def new
    @expense = Expense.new
  end

  def edit; end

  def create
    @expense = current_user.expenses.build(expense_params)
    if @expense.save
      redirect_to @expense, notice: 'Expense created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @expense.update(expense_params)
      redirect_to @expense, notice: 'Expense updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_url, notice: 'Expense deleted'
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :description)
  end
end
