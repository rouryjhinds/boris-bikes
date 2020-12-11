require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike }

  it 'default capacity of dock' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  it "can call working on docking_station.release_bike => true" do
    subject.dock(Bike.new)
    bike = subject.release_bike
    expect(bike).to be_working 
  end

  it "respond to the dock method with 1 argument" do
    is_expected.to respond_to(:dock).with(1).argument
  end

  it "respond to the bike method" do
    is_expected.to respond_to :bikes
  end

  describe '#dock' do
    it "docks a bike" do
      bike = Bike.new
      expect(subject.dock(bike).pop).to eq bike
    end

    it 'raises an error when the dock is full' do
      subject.capacity.times { subject.dock(Bike.new) }
      expect { subject.dock(Bike.new) }.to raise_error('This dock be full, bro')
    end
  end

  it "return docked bikes" do
    bike = Bike.new
    subject.dock(bike)
    expect(subject.bikes.pop).to eq bike
  end

  describe '#release_bike' do
    it 'releases a bike' do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
    end

    it 'raises an error if there is no bike to release' do
      expect { subject.release_bike }.to raise_error('No bikes, bro')
    end
  end

  describe 'initialising docking station w/ capacity' do
    subject { DockingStation.new }
    let(:bike) { Bike.new }
    it 'has a variable capacity' do
      docking_station = DockingStation.new(50)
      50.times { docking_station.dock(Bike.new) }
      expect { docking_station.dock(Bike.new) }.to raise_error('This dock be full, bro')
    end
    it 'has a default capacity' do
      described_class::DEFAULT_CAPACITY.times do
        subject.dock(bike)
      end
      expect {subject.dock(bike) }.to raise_error('This dock be full, bro')
    end
  end
end