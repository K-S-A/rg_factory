require 'spec_helper'

module RgFactory
  describe Factory do
    before(:all) do
      @a = described_class.new(:h, :g)
    end
    subject { @a.new(2, 3) }
    
    context '.new' do
      it { expect(@a).not_to be_kind_of(Struct) }
      it 'should set class name if first argument is a string' do
        expect(described_class.new("SomeName", :a, :b).name).to match(/SomeName/)
      end
      it{ expect{ described_class.new }.to raise_error ArgumentError, "wrong number of arguments (0 for 1+)" }
      it 'should raise NameError if class name is not a constant' do
        expect{ described_class.new("somename") }.to raise_error NameError, /wrong constant name/
      end
    end
    
    context '#new' do
      it { expect(subject).to have_attributes(:h => 2, :g => 3) }
      it { expect(subject).to respond_to(:h=, :g=) }
    end
    
    [:inspect, :to_s].each do |method|
      context "##{method}" do
        it { expect(subject).to respond_to(method) }
        it 'should describe contents of this class in a string' do
          expect(subject.send(method)).to eq("Object  @h=2, @g=3")
        end                              
      end
    end
    
    context '#==' do
      it { expect(subject).to respond_to(:==) }
      it 'should compare objects by class name and attributes' do
        expect(subject).to eq(@a.new(2, 3))
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
        expect{ subject[1] = 5 }.to change{ subject[1] }.from(3).to(5)
      end
      it 'should set variable by symbol' do
        expect{ subject[:h] = 7 }.to change{ subject[:h] }.from(2).to(7)
      end
    end
    
    context '#each' do
      it { expect(subject).to respond_to(:each) }
      it 'should evaluate block once for each variable' do
        tmp = []
        expect{ subject.each { |x| tmp.push x*2 } }.to change{ tmp }.from([]).to([4, 6])
      end
    end
    
    context '#each_pair' do
      it { expect(subject).to respond_to(:each_pair) }
      it 'should calls block once for each instance variable, passing the name and the value as parameters' do
        tmp = []
        expect{ subject.each_pair {|sym, val| tmp.push([sym, val])} }.to change{ tmp }.from([]).to([[:h, 2], [:g, 3]])
      end 
    end
    
    context '#hash' do
      it { expect(subject).to respond_to(:hash) }
      it 'should return hash as Fixnum for object' do
        expect(subject.hash).to be_kind_of(Fixnum)
      end
    end
    
    [:length, :size].each do |method| 
      context "##{method}" do
        it { expect(subject).to respond_to(method) }
        it "should return number of attributes" do
          expect(subject.send(method)).to eq(2)
        end
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
    
    [:to_a, :values].each do |method|
      context "##{method}" do
        it { expect(subject).to respond_to(method) }
        it 'should return values as an Array' do
          expect(subject.send(method)).to eq([2, 3])
        end  
      end
    end
   
    context '#to_h' do
      it { expect(subject).to respond_to(:to_h) }
      it 'should return hash of object\'s variables names and values' do
        expect(subject.to_h).to eq( { :h => 2, :g => 3 } )
      end
    end
    
    context '#values_at ' do
      it { expect(subject).to respond_to(:values_at) }
      it 'should return selected values as an Array' do
        expect(subject.values_at(1, 0)).to eq([3, 2])
      end 
    end
  end   
end
