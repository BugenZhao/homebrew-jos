class X8664LitchiElfBinutils < Formula

  desc "FSF Binutils for x86_64-elf cross development"
  homepage "https://www.gnu.org/software/binutils/binutils.html"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.34.tar.xz"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.34.tar.xz"
  sha256 "f00b0e8803dc9bab1e2165bd568528135be734df3fabf8d0161828cd56028952"

  bottle do
    root_url "https://dl.bintray.com/bugenzhao/bottles-litchi"
    sha256 "b255a6fb2772199f6dd72048b6b49207f63b38581a06e4afc9ead704354158de" => :catalina
  end

  def install
    args = [
      "--prefix=#{prefix}",
      "--disable-werror",
      "--disable-nls",
      "--target=x86_64-litchi-elf"
    ]

    system "./configure", *args
    system "make"
    system "make", "install"

    info.rmtree
  end
end
