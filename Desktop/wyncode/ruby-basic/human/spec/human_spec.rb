require_relative '../human.rb'

RSpec.describe Human do
  let :ed do
    one_day = 60*60*24
    yesterday = Time.now - one_day
    ed = Human.new("Ed", yesterday)
  end
  
  context "#initialize" do
    it "initializes a Human object with :name and :birth attributes" do 
      expect(ed).to be_a(Human)
    end

    it "initializes with name and birth reader methods" do
      expect(ed.methods).to include(:name)
      expect(ed.methods).to include(:birth)
    end
  end

  context "when it hasn't had breakfast" do
    it "before breakfast: hungry == true" do
      expect(ed.hungry?).to eql(true)
    end

    it "before breakfast: sleepy == true" do
      expect(ed.sleepy?).to eql(true)
    end
  end

  context "#have_breakfast" do
    it "is no longer hungry" do
      ed.have_breakfast
      expect(ed.hungry?).to eql(false)
    end

    it "is still sleepy" do
      expect(ed.sleepy?).to eql(true)
    end
  end

  context "#take_a_nap" do
    it "is no longer sleepy" do
      ed.take_a_nap
      expect(ed.sleepy?).to eql(false)
    end

    it "is hungry again" do
      expect(ed.hungry?).to eql(true)
    end
  end
end