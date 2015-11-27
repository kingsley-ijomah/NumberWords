require 'rails_helper'

=begin
	Clicking on each navigation link should bring up pages with the right
	numbers in words printed on the page, test to cover boundries, start, end
	and mid-ish section using 1000 as default display set.
=end

feature 'List number words' do

	scenario 'Clicking pagination in First Set' do
		visiting_index_path
		when_I_click_on 1
		then_I_expect_to_see 'one'
		I_also_expect_to_see 'one thousand'
		but_I_dont_expect_to_see 'one thousand and one'
	end

	scenario 'Clicking pagination in Fourth Set' do
		viting_index_with_params set_param: 4, page_param: 4
		when_I_click_on 170
		then_I_expect_to_see 'one hundred and sixty nine thousand and one'
		I_also_expect_to_see 'one hundred and seventy thousand'
		but_I_dont_expect_to_see 'one hundred and seventy thousand and one'
	end

	scenario 'Clicking pagination in Last Set' do
		visiting_index_path
		and_I_click_on_last_set
		when_I_click_on 1000
		then_I_expect_to_see 'nine hundred and ninety nine thousand and one'
		I_also_expect_to_see 'one million'
	end


	# Helper Methods.

	def visiting_index_path
		visit numbers_path
	end

	def when_I_click_on set 
		within '#paginate' do
			click_link set
		end
	end

	def then_I_expect_to_see num 
		expect(page.find('#number_words')).to have_content(num)
	end

	def I_also_expect_to_see num 
		expect(page.find('#number_words')).to have_content(num)
	end

	def but_I_dont_expect_to_see num 
		expect(page.find('#number_words')).to_not have_content(num)
	end

	def viting_index_with_params set_param:, page_param:
		visit numbers_path(set: set_param, page: page_param)
	end

	def and_I_click_on_last_set 
		within '#paginate' do
			click_link 'Last Set'
		end
	end
end