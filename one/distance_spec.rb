require "rspec"
require_relative "distance"

RSpec.describe "Distance" do

  def distance(directions)
    Distance.for(directions: directions)
  end

  it "returns 2 given no R2" do
    expect(distance("R2")).to eq 2
  end

  it "returns 5 given R2, L3" do
    expect(distance("R2, L3")).to eq 5
  end

  it "returns 2 given R2, R2, R2" do
    expect(distance("R2, R2, R2")).to eq 2
  end

  it "return 12 given R5, L5, R5, R3" do
    expect(distance("R5, L5, R5, R3")).to eq 12
  end
end

RSpec.describe "ParseDirections" do

  it "returns an array containing step distances" do
    directions = "R1, L2, L3"

    expect(ParseDirections.from(directions: directions).map{ |step| step[:distance] }).to eq [1, 2, 3]
  end

  it "returns an array containing step directions" do
    directions = "R1, L2, L3"

    expect(ParseDirections.from(directions: directions).map{ |step| step[:turn] }).to eq [:right, :left, :left]
  end
end

RSpec.describe "Direction" do

  subject { Direction.orient(bearing: bearing, turn: turn) }

  context "when bearing east" do
    let(:bearing) { :east }

    context "when turning left" do
      let(:turn) { :left }

      it { is_expected.to eq :north }
    end

    context "when turning right" do
      let(:turn) { :right }

      it { is_expected.to eq :south }
    end
  end

  context "when bearing west" do
    let(:bearing) { :west }

    context "when turning left" do
      let(:turn) { :left }

      it { is_expected.to eq :south }
    end

    context "when turning right" do
      let(:turn) { :right }

      it { is_expected.to eq :north }
    end
  end

  context "when bearing north" do
    let(:bearing) { :north }

    context "when turning left" do
      let(:turn) { :left }

      it { is_expected.to eq :west }
    end

    context "when turning right" do
      let(:turn) { :right }

      it { is_expected.to eq :east }
    end
  end

  context "when bearing south" do
    let(:bearing) { :south }

    context "when turning left" do
      let(:turn) { :left }

      it { is_expected.to eq :east }
    end

    context "when turning right" do
      let(:turn) { :right }

      it { is_expected.to eq :west }
    end
  end
end
