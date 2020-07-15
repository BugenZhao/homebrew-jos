class X8664LitchiElfGcc < Formula

  desc "GNU compiler collection for x86_64-elf development"
  homepage "https://gcc.gnu.org"
  url "https://ftp.gnu.org/gnu/gcc/gcc-10.1.0/gcc-10.1.0.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gcc/gcc-10.1.0/gcc-10.1.0.tar.xz"
  sha256 "b6898a23844b656f1b68691c5c012036c2e694ac4b53a8918d4712ad876e7ea2"
  bottle do
    root_url "https://dl.bintray.com/bugenzhao/bottles-litchi"
    sha256 "10b9d821e5188649fe19dc8c281b1aba4e7b8296b5e64a1bcb25ae9584dd91d0" => :catalina
  end

  conflicts_with "i386-litchi-elf-gcc"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "x86_64-litchi-elf-binutils"
  
  resource "newlib" do
    url "https://github.com/bminor/newlib/archive/newlib-3.3.0.tar.gz"
    sha256 "0e3e50ddb1e864dac84b04680fb7e1680a8cfb05ec14d60260729e2ce552561c"
  end

  def install
    binutils = Formulary.factory "x86_64-litchi-elf-binutils"

    args = [
      "--prefix=#{prefix}",
      "--enable-languages=c,c++",
      "--disable-werror",
      "--disable-nls",
      "--disable-libssp",
      "--disable-libmudflap",
      "--enable-interwork",
      "--enable-multilib",
      "--with-as=#{binutils.bin}/x86_64-litchi-elf-as",
      "--with-ld=#{binutils.bin}/x86_64-litchi-elf-ld",
      "--without-headers",
      "--with-newlib",
#       "--disable-hosted-libstdcxx",
      "--target=x86_64-litchi-elf"
    ]

    mkdir "build" do
      system "../configure", *args
      system "make", "all-gcc"
      system "make", "install-gcc"
      
      ENV["PATH"] = ENV["PATH"] + ":#{prefix}/bin"
      ENV["CC"] = "gcc"
      
      resource("newlib").stage do
        system "./configure", "--prefix=#{prefix}",
                              "--target=x86_64-litchi-elf",
                              "--disable-libssp",
                              "--disable-nls"
        system "make"
        system "make", "-j1", "install"
      end
      
#       system "make", "all-target-libgcc"
#       system "make", "install-target-libgcc"
#       system "make", "all-target-libstdc++-v3"
#       system "make", "install-target-libstdc++-v3"
      system "make", "all"
      system "make", "install"
    end

    # info and man7 files conflict with native gcc
    info.rmtree
    man7.rmtree
  end
end
