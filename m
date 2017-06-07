Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170606230007.19101-2-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-2-palmer@dabbelt.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jun 2017 09:17:16 +0200
Message-ID: <CAMuHMdXUS3m=o8CgscJO_B8yxbMkX1=jbYasG13sx2tDFPYw7Q@mail.gmail.com>
Subject: Re: [PATCH 01/17] drivers: support PCIe in RISCV
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        albert@sifive.com, patches@groups.riscv.org,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CC pci folks

On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
>
> There are RISC-V systems that have been mapped to Xilinx FPGAs that have
> their PCIe controllers on chip.  These build system changes allow RISC-V
> systems to enable the Xilinx PCIe controller, and to setup PCIe IRQs.
>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  drivers/pci/Makefile     | 1 +
>  drivers/pci/host/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 462c1f5f5546..a29d9ec05d13 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_MIPS) += setup-irq.o
>  obj-$(CONFIG_TILE) += setup-irq.o
>  obj-$(CONFIG_SPARC_LEON) += setup-irq.o
>  obj-$(CONFIG_M68K) += setup-irq.o
> +obj-$(CONFIG_RISCV) += setup-irq.o
>
>  #
>  # ACPI Related PCI FW Functions
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 7f47cd5e10a5..5148f3d3cab7 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -71,7 +71,7 @@ config PCI_HOST_GENERIC
>
>  config PCIE_XILINX
>         bool "Xilinx AXI PCIe host bridge support"
> -       depends on ARCH_ZYNQ || MICROBLAZE
> +       depends on ARCH_ZYNQ || MICROBLAZE || RISCV
>         help
>           Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>           Host Bridge driver.
> --
> 2.13.0
