class I386LitchiElfGcc < Formula

  desc "GNU compiler collection for i386-elf development"
  homepage "https://gcc.gnu.org"
  url "https://ftp.gnu.org/gnu/gcc/gcc-10.1.0/gcc-10.1.0.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gcc/gcc-10.1.0/gcc-10.1.0.tar.xz"
  sha256 "b6898a23844b656f1b68691c5c012036c2e694ac4b53a8918d4712ad876e7ea2"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "i386-litchi-elf-binutils"

  def install
    binutils = Formulary.factory "i386-litchi-elf-binutils"

    args = [
      "--prefix=#{prefix}",
      "--enable-languages=c,c++",
      "--disable-werror",
      "--disable-nls",
      "--disable-libssp",
      "--disable-libmudflap",
      "--disable-multilib",
      "--with-as=#{binutils.bin}/i386-litchi-elf-as",
      "--with-ld=#{binutils.bin}/i386-litchi-elf-ld",
      "--with-newlib",
      "--without-headers",
      "--target=i386-litchi-elf"
    ]

    mkdir "build" do
      system "../configure", *args
      system "make", "all-gcc"
      system "make", "install-gcc"
      system "make", "all-target-libgcc"
      system "make", "install-target-libgcc"
    end

    # info and man7 files conflict with native gcc
    info.rmtree
    man7.rmtree
  end
end
