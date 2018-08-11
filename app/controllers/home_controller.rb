class HomeController < ApplicationController
  def index
  end

  def redeem
    voucher_uuid = params.permit(:voucher)[:voucher]
    subject = params.permit(:subject)[:subject]

    voucher = Voucher.find_by_uuid(voucher_uuid)

    if not voucher or voucher.used?
      flash[:error] = 'Please provide a valid voucher code.'
      return redirect_to root_path
    end

    voucher.used = true
    voucher.save!

    if subject == 'math_ct_5'
      cheatsheet_path = File.join(Rails.root, 'app','assets', 'pdfs', 'meme.jpg')
      send_file cheatsheet_path
    elsif subject == 'fce_ct_1'
      cheatsheet_path = File.join(Rails.root, 'app','assets', 'pdfs', 'fce CT 1.pdf')
      send_file cheatsheet_path
    end
  end
end