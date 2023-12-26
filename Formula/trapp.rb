class Trapp < Formula
  desc "Automated Job Application Tracker"
  homepage "trapp.sh"
  url "https://github.com/KartavyaSharma/trapp/releases/download/Production/trapp-v1.0.0.tar.gz"
  sha256 "2e31db0a223f0cffdbde25041a345096bc9ab8bf13a58c059d3bb9395efdd653"

  depends_on "bash"
  depends_on "bat"
  depends_on "docker"
  depends_on "gum"
  depends_on "python3"
  depends_on "rm-improved"
  depends_on "gnu-tar"
  depends_on "unzip"
  depends_on "wget"

  if OS.mac?
    depends_on "colima"
    depends_on "coreutils"
    depends_on "openssl@1.1"
  elsif OS.linux?
    depends_on "build-essential"
    depends_on "python3-pip"
    depends_on "python3-setuptools"
    depends_on "python3-venv"
  end
  
  def install
    # Check if Google Chrome is installed
    unless File.exist?("/Applications/Google Chrome.app")
      odie "Google Chrome is required. Please install it with `brew install --cask google-chrome`."
    end

    # Create the ~/.trapp directory
    trapp_home = Pathname.new("#{ENV["HOME"]}/.trapp")
    mkdir_p trapp_home
  
    # Extract all files from the tarball into the ~/.trapp directory
    system "tar", "-xzf", "trapp-v1.0.0.tar.gz", "-C", trapp_home
  
    # Create the trapp command script
    (bin/"trapp").write <<~EOS
      #!/bin/bash
      #{trapp_home}/start.sh
    EOS
  
    # Ensure the start.sh script is executable
    chmod 0755, trapp_home/"start.sh"
  end 
  
  test do
    system "trapp", "--version"
  end
end
