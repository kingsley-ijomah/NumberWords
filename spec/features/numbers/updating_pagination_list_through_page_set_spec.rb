require 'rails_helper'

=begin
	Navigating by clicking on Page sets e.g `Next Set` should also set the
	appropriate paginated set e.g [1,2,3...50] for `First Set` and [51..100]
	for the `Second Set` etc
=end

feature 'Page Set pagination' do
	scenario 'visiting `First Set`' do
		visiting_index_path
		I_expect_page_set_to_have_min_pagination 1
		and_I_expect_page_set_max_pagination 50
	end

	scenario 'visiting `Second Set`' do
		viting_index_with_params set_param: 2, page_param: 2
		I_expect_page_set_to_have_min_pagination 51
		and_I_expect_page_set_max_pagination 100
	end

	scenario 'visiting `Last Set`' do
		visiting_index_path
		and_I_click_on_page_set 'Last Set'
		I_expect_page_set_to_have_min_pagination 951
		and_I_expect_page_set_max_pagination 1000
	end


	# Helper Methods.

	def visiting_index_path
		visit numbers_path
	end

	def I_expect_page_set_to_have_min_pagination num 
		Capybara.exact = true
		expect(page.find('#paginate')).to_not have_link(num - 1)
		expect(page.find('#paginate')).to have_link(num)
	end

	def and_I_expect_page_set_max_pagination num 
		Capybara.exact = true
		expect(page.find('#paginate')).to_not have_link(num + 1)
		expect(page.find('#paginate')).to have_link(num)
	end

	def viting_index_with_params set_param:, page_param:
		visit numbers_path(set: set_param, page: page_param)
	end

	def and_I_click_on_page_set set 
		within '#paginate' do
			click_link set
		end
	end
end