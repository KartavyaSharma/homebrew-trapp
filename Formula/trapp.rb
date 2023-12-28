class Trapp < Formula
  desc "Automated Job Application Tracker"
  homepage "trapp.sh"
  url "https://github.com/KartavyaSharma/trapp/releases/download/Production/trapp-v1.0.0.tar.gz"
  sha256 "b032abfa5400b2b58c2f65ddc035e4d938b1818d67be8eb4c5ee542503234ce8"

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
    trapp_dir = "~"/".trapp"
    mkdir_p trapp_dir
 
    # Move the contents of the tarball to the .trapp directory
    tarball_contents.each { |file| mv file, trapp_dir }

    # Link the bash script to bin
    bin.install trapp_dir/"start.sh" => "trapp"
  end

  test do
    # Replace with a suitable test, e.g., checking output of a command
    system "#{bin}/start.sh", "--help"
  end
end
