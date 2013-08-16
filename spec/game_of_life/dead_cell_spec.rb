require 'fast_spec_helper'
require 'game_of_life/dead_cell'

class GameOfLife
  describe DeadCell do
    subject { DeadCell.instance }

    describe'#to_s' do
      it 'is "."' do
        expect(subject.to_s).to eq('.')
      end
    end

    it { should_not be_alive }

    it 'survives if it has exactly 3 neighbors' do
      expect(subject.survives?(2)).to be_false
      expect(subject.survives?(3)).to be_true
      expect(subject.survives?(4)).to be_false
    end
  end
end
