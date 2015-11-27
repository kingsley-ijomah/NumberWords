require 'rails_helper'

=begin
	First visit to numbers_path should show list of numbers in words starting
	from one, two, three ... to one thousand, but when you click on `Next Set`
	then the listing should start from `one thousand and one` ... to `two thousand`
=end

feature 'Update listing through page set' do
	scenario 'whilst on `First Set`' do
		viting_index_with_params set_param: 1, page_param: 1
		I_expect_number_to_have 'one'
		I_expect_number_to_have 'one thousand'
		but_I_do_not_expect_to_have 'one thousand and one'
	end

	scenario 'whilst on `Second Set`' do
		viting_index_with_params set_param: 2, page_param: 2
		I_expect_number_to_have 'one thousand and one'
		I_expect_number_to_have 'two thousand'
		but_I_do_not_expect_to_have 'two thousand and one'
	end

	scenario 'visiting `Last Set`' do
		visiting_index_path
		and_I_click_on_page_set 'Last Set'
		I_expect_number_to_have 'nine hundred and fifty thousand and one'
		I_expect_number_to_have 'nine hundred and fifty one thousand'
	end


	# Helper Methods.

	def visiting_index_path
		visit numbers_path
	end

	def viting_index_with_params set_param:, page_param:
		visit numbers_path(set: set_param, page: page_param)
	end

	def then_I_expect_number_to_have num 
		expect(page.find('#number_words')).to have_content(num)
	end

	def I_expect_number_to_have num 
		expect(page.find('#number_words')).to have_content(num)
	end

	def but_I_do_not_expect_to_have num 
		expect(page.find('#number_words')).to_not have_content(num)
	end

	def and_I_click_on_page_set set 
		within '#paginate' do
			click_link set
		end
	end
end