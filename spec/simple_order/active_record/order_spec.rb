require 'spec_helper'

module SimpleOrder
  module AR
    describe Order do

      it "should have a date" do
        subject.date = nil
        expect(subject).not_to be_valid
        expect(subject).to have(1).errors
      end

      it "should have current date when initialized" do
        time = Time.parse('2013-09-13 10:33:59')
        Time.stub now: time

        expect(subject).to be_valid
        expect(subject).to have(:no).errors
        expect(subject.date).to be_eql(time)
      end
    end
  end
end