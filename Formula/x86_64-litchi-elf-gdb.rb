class X8664LitchiElfGdb < Formula

  desc "GNU debugger"
  homepage "https://www.gnu.org/software/gdb/"
  url "http://ftpmirror.gnu.org/gdb/gdb-8.3.1.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gdb/gdb-8.3.1.tar.xz"
  sha256 "1e55b4d7cdca7b34be12f4ceae651623aa73b2fd640152313f9f66a7149757c4"

  bottle do
    root_url "https://dl.bintray.com/bugenzhao/bottles-litchi"
    sha256 "8a3dcf3099e8197b715d10989975e998dfdd8c22426789bc660e7b6425ecc017" => :catalina
  end

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
