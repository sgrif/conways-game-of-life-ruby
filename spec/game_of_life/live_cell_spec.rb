require 'fast_spec_helper'
require 'game_of_life/live_cell'

class GameOfLife
  describe LiveCell do
    subject { LiveCell.instance }

    describe '#to_s' do
      it 'is "o"' do
        expect(subject.to_s).to eq('o')
      end
    end

    it { should be_alive }

    describe '#survives?' do
      it 'survives if it has 2 or 3 neighbors' do
        expect(subject.survives?(2)).to be_true
        expect(subject.survives?(3)).to be_true
        expect(subject.survives?(1)).to be_false
        expect(subject.survives?(4)).to be_false
      end
    end
  end
end
