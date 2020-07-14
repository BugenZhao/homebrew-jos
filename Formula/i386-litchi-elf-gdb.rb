class I386LitchiElfGdb < Formula

  desc "GNU debugger"
  homepage "https://www.gnu.org/software/gdb/"
  url "http://ftpmirror.gnu.org/gdb/gdb-8.3.1.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gdb/gdb-8.3.1.tar.xz"
  sha256 "1e55b4d7cdca7b34be12f4ceae651623aa73b2fd640152313f9f66a7149757c4"

  bottle do
    root_url "https://bintray.com/bugenzhao/bottles-litchi"
    sha256 "256ccbfebcc065c8c4e8742b626d6e27c2bca781ecf5b085067659d69526a263" => :catalina
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --target=i386-litchi-elf
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
