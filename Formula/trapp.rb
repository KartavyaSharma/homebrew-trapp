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
    # Extract the tarball contents
    tarball_contents = Dir["*"]
    
    # Create .trapp directory in the user's home
    trapp_dir = Pathname.new(ENV["HOME"])/".trapp"
    mkdir_p trapp_dir
    
    # Move the contents of the tarball to the .trapp directory
    tarball_contents.each { |file| mv file, trapp_dir }

    # Rename the start.sh script to trapp
    mv trapp_dir/"start.sh", trapp_dir/"trapp"

    # Link the bash script to bin
    bin.install_symlink trapp_dir/"trapp"
  end

  test do
    # Replace with a suitable test, e.g., checking output of a command
    system "#{bin}/start.sh", "--help"
  end
end
