require 'rspec'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'



describe 'Station' do
  station = Station.new('UK')

  train = Train.new('#74')
  train2 = Train.new('#76')

  arr_trains = [tc1 = CargoTrain.new('C 31'),
  tc2 = CargoTrain.new('C 32'),
  tp1 = PassengerTrain.new('P 11'),
  tp2 = PassengerTrain.new('P 12'),
  tp3 = PassengerTrain.new('P 13')]

  arr_trains.each{ |tr| station.accept_train(tr) }


  it 'create_station' do        
    expect(station.name).to eq 'UK'
  end

  it 'accept_train(train)' do   
    expect(station.accept_train(train)).to eq station.trains
  end

  it 'trains_by_type(:cargo)' do
    expect(station.trains_by_type(:cargo)).to eq arr_trains[0,2]
  end

  it 'trains_by_type(:passenger)' do
    expect(station.trains_by_type(:passenger)).to eq arr_trains[2,3]
  end

  it 'send_train(tp3 )' do
    expect(station.send_train(tp3)).to eq tp3
  end

end
