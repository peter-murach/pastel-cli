# encoding: utf-8

RSpec.describe 'pastel command' do

  it 'runs without arguments and shows help' do
    expect(`bin/pastel`).to match(/PASTEL\(1\)/)
    expect($?.exitstatus).to eq(0)
  end

  it "runs with --help/-h flags" do
    expect(`bin/pastel`).to match(/PASTEL\(1\)/)
    expect($?.exitstatus).to eq(0)
  end

  it 'runs with text only' do
    expect(`bin/pastel foo`).to match(/foo/)
    expect($?.exitstatus).to eq(0)
  end

  it 'runs with foreground option' do
    expect(`bin/pastel green foo`).to match(/\e\[32mfoo\e\[0m/)
    expect($?.exitstatus).to eq(0)
  end

  it "runs with foreground & background options" do
    expect(`bin/pastel green on_red foo`).to match(/\e\[32;41mfoo\e\[0m/)
    expect($?.exitstatus).to eq(0)
  end

  it "runs with foreground & background & style options" do
    expect(`bin/pastel green on_red bold foo`).to match(/\e\[32;41;1mfoo\e\[0m/)
    expect($?.exitstatus).to eq(0)
  end

  it "runs with piped input" do
    expect(`echo foo | bin/pastel green`).to match(/\e\[32mfoo\e\[0m/)
    expect($?.exitstatus).to eq(0)
  end

  it "runs with --enabled option" do
    expect(`bin/pastel --enabled green foo`).to match(/\e\[32mfoo\e\[0m/)
    expect($?.exitstatus).to eq(0)
  end
end
