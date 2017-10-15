module AccountsHelper
	def current_balance(acc_no)
		dep_bal = Transaction.where("account_id = ? ", acc_no).sum(:deposite_amount)
		wid_bal = Transaction.where("account_id = ? ", acc_no).sum(:withdraw_amount)
		tran_bal = Transaction.where("account_id = ? ", acc_no).sum(:transfer_amount)

		bal = dep_bal - (wid_bal + tran_bal)
	end
end
