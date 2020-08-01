# frozen_string_literal: true

RSpec.describe "pastel command" do
  it "runs without arguments and shows help" do
    expect(`pastel`).to match(/PASTEL\(1\)/)
    expect($?.exitstatus).to eq(0)
  end

  it "runs with --help/-h flags" do
    expect(`pastel`).to match(/PASTEL\(1\)/)
    expect($?.exitstatus).to eq(0)
  end

  it "runs with text only" do
    expect(`pastel foo`).to match(/foo/)
    expect($?.exitstatus).to eq(0)
  end

  it "runs with foreground option" do
    expect(`pastel green foo --enabled`).to match(/\e\[32mfoo\e\[0m/)
    expect($?.exitstatus).to eq(0)
  end

  it "runs with foreground & background options" do
    expect(`pastel --enabled green on_red foo`).to match(/\e\[32;41mfoo\e\[0m/)
    expect($?.exitstatus).to eq(0)
  end

  it "runs with foreground & background & style options" do
    expect(`pastel --enabled green on_red bold foo`).to match(/\e\[32;41;1mfoo\e\[0m/)
    expect($?.exitstatus).to eq(0)
  end

  it "runs with piped input" do
    expect(`echo foo | pastel green --enabled`).to match(/\e\[32mfoo\s*\e\[0m/)
    expect($?.exitstatus).to eq(0)
  end

  it "runs with --enabled option" do
    expect(`pastel --enabled green foo`).to match(/\e\[32mfoo\e\[0m/)
    expect($?.exitstatus).to eq(0)
  end

  it "preserves multiline content", unless: RSpec::Support::OS.windows? do
    output = `echo "foo\nbar" | pastel green --enabled`
    expect(output).to match(/\e\[32m\s*foo\nbar\s*\e\[0m/)
    expect($?.exitstatus).to eq(0)
  end

  it "displays information when wrong styles are used" do
    output = `pastel unknown foo --enabled`
    expect(output).to match(/^Bad style or unintialized constant/)
    expect($?.exitstatus).to eq(1)
  end

  it "shows available styles" do
    output = `pastel --styles --enabled`
    expect(output).to match(/Swatch    Name\n\e\[1m◼ pastel\e\[0m  bold\n\e\[2m◼ pastel\e\[0m  dark/)
  end
end
