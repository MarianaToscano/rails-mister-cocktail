class DosesController < ApplicationController
  before_action :fetch_cocktail, only: [:new, :create] #o before action é pq antes do new e do create vou ter de ir buscar o fetch cocktail, ou seja qual o cocktail ao qual a dose pertence
  
  def new
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail #para ligar ao fetch
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'new'
    end
  end

  def destroy
    fetch_dose
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private
  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

  def fetch_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def fetch_dose
    @dose = Dose.find(params[:id])
  end
end
