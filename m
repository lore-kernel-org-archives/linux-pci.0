Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60712 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbeHBSsT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Aug 2018 14:48:19 -0400
Date: Thu, 2 Aug 2018 17:56:23 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] PCI/xilinx: Depend on OF instead of the ARCH
Message-ID: <20180802165623.GB13725@red-moon>
References: <20180801151403.20660-1-hch@lst.de>
 <20180801151403.20660-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180801151403.20660-4-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 01, 2018 at 05:14:03PM +0200, Christoph Hellwig wrote:
> There isn't a hard dependency of the Xilinx AXI-PCIe host bridge on any
> architecture.  For example: at SiFive we map RISC-V cores to Xilinx FPGAs
> and connect the Xilinx IP via a TileLink adapter, so the RISC-V Linux
> port will need to be able to enable PCIE_XILINX in order to have PCIe
> support.
> 
> This patch decouples the PCIE_XILINX support from ARCH.  Instead it just
> depends on OF, which I believe is the only true dependency.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> [hch: switch to OF instead of OF_PCI now that the latter is gone]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/controller/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I could have taken it for this merge window but unfortunately it is a
bit late (ie PCI patches queue is close), I can certainly queue it up
for v4.20 though.

Lorenzo

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index cc9fa02d32a0..0f7ce5eaeac8 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -102,7 +102,7 @@ config PCI_HOST_GENERIC
>  
>  config PCIE_XILINX
>  	bool "Xilinx AXI PCIe host bridge support"
> -	depends on ARCH_ZYNQ || MICROBLAZE || (MIPS && PCI_DRIVERS_GENERIC) || COMPILE_TEST
> +	depends on OF || COMPILE_TEST
>  	help
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>  	  Host Bridge driver.
> -- 
> 2.18.0
> 
