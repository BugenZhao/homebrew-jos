class X8664LitchiElfGdb < Formula

  desc "GNU debugger"
  homepage "https://www.gnu.org/software/gdb/"
  url "http://ftpmirror.gnu.org/gdb/gdb-8.3.1.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gdb/gdb-8.3.1.tar.xz"
  sha256 "1e55b4d7cdca7b34be12f4ceae651623aa73b2fd640152313f9f66a7149757c4"

  def install
    args = %W[
      --prefix=#{prefix}
      --target=x86_64-litchi-elf
      --disable-werror
      --with-gdb-datadir=#{pkgshare}
    ]

    system "./configure", *args
    system "make"
    system "make", "install"

    rm_rf include
    rm_rf lib
    rm_rf share/"locale"
    rm_rf share/"info"
  end
end
