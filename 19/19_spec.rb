require 'rspec'
require './19a'
require './19b'
require 'pry'
require 'pry-nav'

RSpec.describe 'Day 19' do
  let(:ex_file) { 'ex_input.txt' }
  let(:main_file) { 'input.txt' }

  it 'works with the test input for part 1' do
    expect(part_one(ex_file)).to eq(79)
  end

  # it 'works with main input for part 1' do
  #   expect(part_one(main_file)).to eq(0)
  # end

  # it 'works with the test input for part 2' do
  #   expect(part_two(ex_file)).to eq(0)
  # end

  # it 'works with main input for part 2' do
  #   expect(part_two(main_file)).to eq(0)
  # end
end

# 1=x 2=y 3=z
# x,y,z
# x,z,-y
# x,-y,-z
# x,-z,y
# -x,-y,z
# -x,z,y
# -x,y,-z
# -x,-z,-y
# y,-x,z
# y,z,x
# y,x,-z
# y,-z,-x
# -y,x,z
# -y,z,-x
# -y,-x,-z
# -y,-z,x
# z,x,y
# z,y,-x
# z,-x,-y
# z,-y,x
# -z,y,x
# -z,x,-y
# -z,-y,-x
# -z,-x,y
  
# WG=1 DG=2 LG=3
# 1,2,3
# 1,3,-2
# 1,-2,-3
# 1,-3,2

# -1,-2,3
# -1,3,2
# -1,2,-3
# -1,-3,-2

# 2,-1,3
# 2,3,1
# 2,1,-3
# 2,-3,-1

# -2,1,3
# -2,3,-1
# -2,-1,-3
# -2,-3,1

# 3,1,2
# 3,2,-1
# 3,-1,-2
# 3,-2,1

# -3,2,1
# -3,1,-2
# -3,-2,-1
# -3,-1,2

