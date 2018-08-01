Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38726 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387639AbeHALcG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Aug 2018 07:32:06 -0400
Date: Wed, 1 Aug 2018 10:47:10 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        bhelgaas@google.com
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
 driver compile support
Message-ID: <20180801094710.GA12121@red-moon>
References: <1533107047-16704-1-git-send-email-l.subrahmanya@mobiveil.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533107047-16704-1-git-send-email-l.subrahmanya@mobiveil.co.in>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 01, 2018 at 03:04:07AM -0400, Subrahmanya Lingappa wrote:
> Adds missing support for compilation of Mobiveil PCIe Host
> Bridge IP driver.
> 
> Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> ---
>  drivers/pci/controller/Kconfig  | 6 ++++++
>  drivers/pci/controller/Makefile | 1 +
>  2 files changed, 7 insertions(+)

Have you tried compiling it ? (No).

I CC'ed you on this series:

https://patchwork.ozlabs.org/patch/950977/

The mainline kernel is not a dumping ground where you drop you
code and forget about it - you did not even compile the driver,
let me remind you that you are supposed to maintain it.

I will ask Bjorn to revert the driver, I am sorry about that
but that's not acceptable from a maintainership perspective.

Lorenzo

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index cc9fa02..ce26d7a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -186,6 +186,12 @@ config PCIE_ALTERA_MSI
>  	  Say Y here if you want PCIe MSI support for the Altera FPGA.
>  	  This MSI driver supports Altera MSI to GIC controller IP.
>  
> +config PCIE_MOBIVEIL
> +       bool "Mobiveil AXI PCIe host bridge support"
> +       help
> +         Say 'Y' here if you want kernel to support the Mobiveil AXI PCIe
> +         Host Bridge driver.
> +
>  config PCI_HOST_THUNDER_PEM
>  	bool "Cavium Thunder PCIe controller to off-chip devices"
>  	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index 24322b9..7c20553 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
>  obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>  obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
>  obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
> +obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
>  obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
> -- 
> 1.8.3.1
> 
