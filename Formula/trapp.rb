class Trapp < Formula

    desc "Automated Job Application Tracker on the CLI"
    homepage "trapp.sh"
    url "https://github.com/KartavyaSharma/trapp/releases/download/Production/trapp-v1.0.0.tar.gz"
    sha256 "284dc5c1a8669f1d245365a75edcc18e9d5f044cc5372723fcbdee37fad2b8bd"

    depends_on "bash"
    depends_on "bat"
    depends_on "docker"
    depends_on "gum"
    depends_on "python3"
    depends_on "rm-improved"
    depends_on "gnu-tar"
    depends_on "gawk"
    depends_on "unzip"
    depends_on "wget"

    if OS.mac?
        depends_on "coreutils"
        depends_on "colima"
        depends_on "openssl@1.1"
    elsif OS.linux?
        depends_on "build-essential"
        depends_on "python3-pip"
        depends_on "python3-setuptools"
        depends_on "python3-venv"
    end

    def install
        libexec.install Dir["*"]

        (bin/"{name}").write <<~EOS
            #!/bin/bash
            exec "#{libexec}/start.sh" "$@"
        EOS
        bin.install_symlink "#{libexec}/start.sh" => "#{name}"
    end

    test do
        system "{name}", "--help"
    end

end
