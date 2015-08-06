Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:32931 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbbHFOt2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 10:49:28 -0400
Received: by pdrh1 with SMTP id h1so15306479pdr.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2015 07:49:27 -0700 (PDT)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>
Cc: "'Thomas Petazzoni'" <thomas.petazzoni@free-electrons.com>,
	"'Jayachandran C'" <jchandra@broadcom.com>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Russell King'" <linux@arm.linux.org.uk>,
	"'Arnd Bergmann'" <arnd@arndb.de>,
	"'Gabriele Paoloni'" <gabriele.paoloni@huawei.com>,
	"'Marc Zyngier'" <marc.zyngier@arm.com>,
	<linux-pci@vger.kernel.org>, "'Duc Dang'" <dhdang@apm.com>,
	"'Michal Simek'" <michal.simek@xilinx.com>,
	"'Simon Horman'" <horms@verge.net.au>,
	"'James Morse'" <james.morse@arm.com>,
	"'Tanmay Inamdar'" <tinamdar@apm.com>,
	"'Thierry Reding'" <thierry.reding@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>,
	"'Jason Cooper'" <jason@lakedaemon.net>,
	"'Jingoo Han'" <jingoohan1@gmail.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150804215411.9189.53901.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150804215411.9189.53901.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Subject: Re: [PATCH v5 3/9] ARM/PCI, designware, xilinx: Use pci_scan_root_bus_msi()
Date: Thu, 6 Aug 2015 23:49:16 +0900
Message-ID: <000501d0d057$177e4df0$467ae9d0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 05, 2015 6:54 AM, Bjorn Helgaas wrote:
> 
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> ARM previously stored the msi_controller pointer in its sysdata, struct
> pci_sys_data, and implemented pcibios_msi_controller() to retrieve it.
> That made PCI host controller drivers specific to ARM because they had to
> put the msi_controller pointer in the ARM-specific pci_sys_data.
> 
> There is now a generic mechanism, pci_scan_root_bus_msi(), for giving the
> msi_controller pointer to the PCI core.  Use this for all ARM systems and
> for the DesignWare and Xilinx PCI host controller drivers.
> 
> This removes an ARM dependency from the DesignWare, DRA7xx, EXYNOS, i.MX6,
> Keystone, Layerscape, SPEAr13xx, and Xilinx drivers.
> 
> [bhelgaas: changelog, split into separate patch]
> Suggested-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Pratyush Anand <pratyush.anand@gmail.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> CC: Simon Horman <horms@verge.net.au>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: Michal Simek <michal.simek@xilinx.com>
> CC: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/mach/pci.h    |    2 --
>  arch/arm/kernel/bios32.c           |    5 +++--
>  drivers/pci/host/pcie-designware.c |    6 +++---
>  drivers/pci/host/pcie-xilinx.c     |    5 ++---
>  4 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 28b9bb3..c074e7a 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -19,9 +19,7 @@ struct pci_bus;
>  struct device;
> 
>  struct hw_pci {
> -#ifdef CONFIG_PCI_MSI
>  	struct msi_controller *msi_ctrl;
> -#endif
>  	struct pci_ops	*ops;
>  	int		nr_controllers;
>  	void		**private_data;
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 4e95260..283bc1c 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -486,8 +486,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  			if (hw->scan)
>  				sys->bus = hw->scan(nr, sys);
>  			else
> -				sys->bus = pci_scan_root_bus(parent, sys->busnr,
> -						hw->ops, sys, &sys->resources);
> +				sys->bus = pci_scan_root_bus_msi(parent,
> +					sys->busnr, hw->ops, sys,
> +					&sys->resources, hw->msi_ctrl);
> 
>  			if (WARN(!sys->bus, "PCI: unable to scan bus!")) {
>  				kfree(sys);
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 69486be..bd0aeec 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -526,7 +526,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
> 
>  #ifdef CONFIG_PCI_MSI
>  	dw_pcie_msi_chip.dev = pp->dev;
> -	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
>  #endif
> 
>  	dw_pci.nr_controllers = 1;
> @@ -708,8 +707,9 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  	struct pcie_port *pp = sys_to_pcie(sys);
> 
>  	pp->root_bus_nr = sys->busnr;
> -	bus = pci_scan_root_bus(pp->dev, sys->busnr,
> -				  &dw_pcie_ops, sys, &sys->resources);
> +	bus = pci_scan_root_bus_msi(pp->dev, sys->busnr, &dw_pcie_ops, sys,
> +				    &sys->resources, &dw_pcie_msi_chip);
> +
>  	if (!bus)
>  		return NULL;
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index f1a06a0..526807d 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -647,8 +647,8 @@ static struct pci_bus *xilinx_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  	struct pci_bus *bus;
> 
>  	port->root_busno = sys->busnr;
> -	bus = pci_scan_root_bus(port->dev, sys->busnr, &xilinx_pcie_ops,
> -				sys, &sys->resources);
> +	bus = pci_scan_root_bus_msi(port->dev, sys->busnr, &xilinx_pcie_ops,
> +				sys, &sys->resources, &xilinx_pcie_msi_chip);
> 
>  	return bus;
>  }
> @@ -847,7 +847,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
> 
>  #ifdef CONFIG_PCI_MSI
>  	xilinx_pcie_msi_chip.dev = port->dev;
> -	hw.msi_ctrl = &xilinx_pcie_msi_chip;
>  #endif
>  	pci_common_init_dev(dev, &hw);
> 

