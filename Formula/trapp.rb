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

  def caveats
    <<~EOS
      To finish the installation, set the TRAPP_HOME environment variable in your shell:
      For bash users:
        echo 'export TRAPP_HOME="#{libexec}"' >> ~/.bash_profile

      For zsh users:
        echo 'export TRAPP_HOME="#{libexec}"' >> ~/.zshrc

      Then, restart your terminal or run:
      For bash users:
        source ~/.bash_profile

      For zsh users:
        source ~/.zshrc
    EOS
  end 
  
  def install
    # Place all project files in the package's libexec directory
    libexec.install Dir["*"]
    
    # Write an executable script that runs your `start.sh` script
    (bin/"trapp").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/start.sh" "$@"
    EOS
    bin.install_symlink "#{libexec}/start.sh" => "trapp"
  end

  test do
    # Replace with a suitable test, e.g., checking output of a command
    system "#{bin}/start.sh", "--help"
  end
end
