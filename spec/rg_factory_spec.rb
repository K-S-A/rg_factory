require 'spec_helper'

describe RgFactory do
  before(:all) do
    @a = described_class.new(:h, :g)
  end
  subject { @a.new(2, 3) }
  context '.new' do
    it { expect(@a).to be_kind_of(Class) }
  end
  context '#new' do
    it { expect(subject).to have_attributes(:h => 2, :g => 3) }
    it { expect(subject).to respond_to(:h=, :g=) }
  end
  
  context '#inspect' do
    it { expect(subject).to respond_to(:inspect) }
    it 'should describe contents of this class in a string' do
      expect(subject.inspect).to eq("Object  @h=2, @g=3")
    end                              
  end
  
  context '#==' do
    it { expect(subject).to respond_to(:==) }
    it 'should compare objects by class name and attributes' do
      expect(subject == @a.new(2, 3)).to eq(true)
    end                              
  end

  context '#[]' do
    it { expect(subject).to respond_to(:[]) }
    it 'should get variable by index' do
      expect(subject[1]).to eq(3)
    end
    it 'should get variable by attribute as symbol' do
      expect(subject[:h]).to eq(2)
    end
    it 'should get variable by attribute as string' do
      expect(subject["g"]).to eq(3)
    end
  end
  
  context '#[]=' do
    it { expect(subject).to respond_to(:[]=) }
    it 'should set variable by index' do
      subject[1] = 5
      expect(subject[1]).to eq(5)
    end
    it 'should set variable by symbol' do
      subject[:h] = 7
      expect(subject[:h]).to eq(7)
    end
  end
  
  context '#each' do
    it { expect(subject).to respond_to(:each) }
    it 'should evaluate block once for each variable' do
      tmp = []
      subject.each { |x| tmp.push x*2 }
      expect(tmp).to eq([4, 6])
    end
  end
  
  context '#each_pair' do
    it { expect(subject).to respond_to(:each_pair) }
    it 'should calls block once for each instance variable, passing the name and the value as parameters' do
      tmp = []
      subject.each_pair {|sym, val| tmp.push([sym, val])}
      expect(tmp).to eq([[:h, 2], [:g, 3]])
    end 
  end
  
  context '#eql?' do
    it { expect(subject).to respond_to(:eql?) }
    it 'should compare objects by class name and attributes' do
      expect(subject).to eq(@a.new(2, 3))
    end 
  end
  
  context '#hash' do
    it { expect(subject).to respond_to(:hash) }
    it 'should return hash as Fixnum for object' do
      expect(subject.hash).to be_kind_of(Fixnum)
    end
  end
   
  context '#length' do
    it { expect(subject).to respond_to(:length) }
    it 'should return array of attributes as symbols' do
      expect(subject.length).to eq(2)
    end
  end
  
  context '#members' do
    it { expect(subject).to respond_to(:members) }
    it 'should return array of attributes as symbols' do
      expect(subject.members).to eq([:h, :g])
    end
  end
  
  context '#select' do
    it { expect(subject).to respond_to(:select) }
    it 'should return array of values for which block return true' do
      expect(subject.select {|v| (v % 3).zero? } ).to eq([3])
    end
  end
  
  context '#size' do
    it { expect(subject).to respond_to(:size) }
    it 'should return array of attributes as symbols' do
      expect(subject.size).to eq(2)
    end
  end
  
  context '#to_a' do
    it { expect(subject).to respond_to(:to_a) }
    it 'should return values as an Array' do
      expect(subject.to_a).to eq([2, 3])
    end  
  end
 
  context '#to_h' do
    it { expect(subject).to respond_to(:to_h) }
    it 'should return hash of object\'s variables names and values' do
      expect(subject.to_h).to eq( { :h => 2, :g => 3 } )
    end
  end
  
  context '#to_s' do
    it { expect(subject).to respond_to(:to_s) }
    it 'should describe contents of this class in a string' do
      expect(subject.to_s).to eq("Object  @h=2, @g=3")
    end
  end
  
  context '#values' do
    it { expect(subject).to respond_to(:values) }
    it 'should return values as an Array' do
      expect(subject.values).to eq([2, 3])
    end  
  end
  
  context '#values_at ' do
    it { expect(subject).to respond_to(:values_at) }
    it 'should return selected values as an Array' do
      expect(subject.values_at(1, 0)).to eq([3, 2])
    end 
  end
 
end
