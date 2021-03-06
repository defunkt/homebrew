require 'formula'

class Sdl <Formula
  url 'http://www.libsdl.org/release/SDL-1.2.14.tar.gz'
  homepage 'http://www.libsdl.org/'
  md5 'e52086d1b508fa0b76c52ee30b55bec4'

  # we have to do this because most build scripts assume that all sdl modules
  # are installed to the same prefix. Consequently SDL stuff cannot be
  # keg-only but I doubt that will be needed.
  def self.use_homebrew_prefix files
    inreplace files, '@prefix@', HOMEBREW_PREFIX
  end

  def install
    ENV.gcc_4_2
    Sdl.use_homebrew_prefix %w[sdl.pc.in sdl-config.in]

    system "./configure", "--prefix=#{prefix}", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-nasm"
    system "make install"

    # Copy source files needed for Ojective-C support.
    libexec.install Dir["src/main/macosx/*"]
  end
end
