require 'rails_helper'

=begin
	Page sets should be visible at particular conditions and then removed
	when no longer required.
=end

feature 'Page Set visibility' do

	scenario '`First Set` visibility' do
		visiting_index_path
		I_dont_expect_to_see 'First Set'
		when_I_click_on 'Next Set'
		then_I_expect_to_see 'First Set'
		when_I_click_on 'First Set'
		I_no_longer_expect_to_see 'First Set'
	end

	scenario '`Prev Set` visibility' do
		visiting_index_path
		I_dont_expect_to_see 'Prev Set'
		when_I_click_on 'Next Set'
		then_I_expect_to_see 'Prev Set'
		when_I_click_on 'First Set'
		I_no_longer_expect_to_see 'Prev Set'
	end

	scenario '`Next Set` visibility' do
		visiting_index_path
		then_I_expect_to_see 'Next Set'
		when_I_click_on 'Last Set'
		I_no_longer_expect_to_see 'Next Set'
		but_when_click_on 'Prev Set'
		then_I_expect_to_see 'Next Set'
	end

	scenario '`Last Set` visibility' do
		visiting_index_path
		then_I_expect_to_see 'Last Set'
		but_when_click_on 'Last Set'
		I_no_longer_expect_to_see 'Last Set'
		but_when_click_on 'Prev Set'
		then_I_expect_to_see 'Last Set'
	end


	# Helper Methods.

	def visiting_index_path
		visit numbers_path
	end

	def I_dont_expect_to_see set 
		expect(page.find('#paginate')).not_to have_link(set)
	end

	def when_I_click_on set 
		within '#paginate' do
			click_link set
		end
	end

	def then_I_expect_to_see set 
		expect(page.find('#paginate')).to have_link(set)
	end

	def I_no_longer_expect_to_see set 
		expect(page.find('#paginate')).not_to have_link(set)
	end

	def but_when_click_on set 
		within '#paginate' do
			click_link set
		end
	end
end