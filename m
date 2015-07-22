Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:40155 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143AbbGVJc5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2015 05:32:57 -0400
Message-ID: <55AF62BA.1000702@hisilicon.com>
Date: Wed, 22 Jul 2015 17:30:34 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	"Marc Zyngier" <marc.zyngier@arm.com>,
	James Morse <james.morse@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jayachandran C <jchandra@broadcom.com>
Subject: Re: [RFT PATCH] ARM: pci: kill pcibios_msi_controller
References: <1436784206-14414-1-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1436784206-14414-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/7/13 18:43, Lorenzo Pieralisi wrote:
> On ARM PCI systems relying on the pcibios API to initialize PCI host
> controllers, the pcibios_msi_controller weak callback is used to look-up
> the msi_controller pointer, through pci_sys_data msi_ctrl pointer.
> 
> pci_sys_data is an arch specific structure, which prevents using the
> same mechanism (so same PCI host controller drivers) on ARM64 systems.
> 
> Since the struct pci_bus already contains an msi_controller pointer and
> the kernel already uses it to look-up the msi controller,
> this patch converts ARM host controller and relate pcibios/host bridges
> initialization routines so that the msi_controller pointer look-up can be
> carried out by PCI core code through the struct pci_bus msi pointer,
> removing the need for arch specific pcibios_msi_controller callback
> and the related pci_sys_data msi_ctrl pointer.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Bjorn, all,
> 
> I am posting this patch to sound out if that's a reasonable approach.
> xgene implements MSI look-up this way at present and this would represent
> another step forward towards having common drivers for ARM/ARM64, comments
> and testing welcome.
> 
> Thanks,
> Lorenzo
> 
>  arch/arm/include/asm/mach/pci.h    |  3 ---
>  arch/arm/kernel/bios32.c           | 35 +++++++++++++++++------------------
>  drivers/pci/host/pcie-designware.c |  9 +++++++--
>  drivers/pci/host/pcie-xilinx.c     | 12 ++++++++++--
>  4 files changed, 34 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 28b9bb3..32abc0c 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -42,9 +42,6 @@ struct hw_pci {
>   * Per-controller structure
>   */
>  struct pci_sys_data {
> -#ifdef CONFIG_PCI_MSI
> -	struct msi_controller *msi_ctrl;
> -#endif
>  	struct list_head node;
>  	int		busnr;		/* primary bus number			*/
>  	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index fcbbbb1..c841b33 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -18,15 +18,6 @@
>  
>  static int debug_pci;
>  
> -#ifdef CONFIG_PCI_MSI
> -struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
> -{
> -	struct pci_sys_data *sysdata = dev->bus->sysdata;
> -
> -	return sysdata->msi_ctrl;
> -}
> -#endif
> -
>  /*
>   * We can't use pci_get_device() here since we are
>   * called from interrupt context.
> @@ -462,9 +453,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  		if (!sys)
>  			panic("PCI: unable to allocate sys data!");
>  
> -#ifdef CONFIG_PCI_MSI
> -		sys->msi_ctrl = hw->msi_ctrl;
> -#endif
>  		sys->busnr   = busnr;
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
> @@ -483,14 +471,25 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  				break;
>  			}
>  
> -			if (hw->scan)
> +			if (hw->scan) {
>  				sys->bus = hw->scan(nr, sys);
> -			else
> -				sys->bus = pci_scan_root_bus(parent, sys->busnr,
> -						hw->ops, sys, &sys->resources);
> +				if (!sys->bus)
> +					panic("PCI: unable to scan bus!");
> +			} else {
> +				sys->bus = pci_create_root_bus(parent,
> +							       sys->busnr,
> +							       hw->ops, sys,
> +							       &sys->resources);
> +				if (WARN_ON(!sys->bus)) {
> +					kfree(sys);
> +					break;
> +				}
> +#ifdef CONFIG_PCI_MSI
> +				sys->bus->msi = hw->msi_ctrl;
> +#endif
>  
> -			if (!sys->bus)
> -				panic("PCI: unable to scan bus!");
> +				pci_scan_child_bus(sys->bus);
> +			}
>  
>  			busnr = sys->bus->busn_res.end + 1;
>  
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 69486be..e584dfa 100644
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
> @@ -708,11 +707,17 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  	struct pcie_port *pp = sys_to_pcie(sys);
>  
>  	pp->root_bus_nr = sys->busnr;
> -	bus = pci_scan_root_bus(pp->dev, sys->busnr,
> +	bus = pci_create_root_bus(pp->dev, sys->busnr,
>  				  &dw_pcie_ops, sys, &sys->resources);
>  	if (!bus)
>  		return NULL;
>  
> +#ifdef CONFIG_PCI_MSI
> +	bus->msi = &dw_pcie_msi_chip;
> +#endif
> +
> +	pci_scan_child_bus(bus);
> +
>  	if (bus && pp->ops->scan_bus)
>  		pp->ops->scan_bus(pp);
>  
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index f1a06a0..b21eb7d 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -647,9 +647,18 @@ static struct pci_bus *xilinx_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  	struct pci_bus *bus;
>  
>  	port->root_busno = sys->busnr;
> -	bus = pci_scan_root_bus(port->dev, sys->busnr, &xilinx_pcie_ops,
> +	bus = pci_create_root_bus(port->dev, sys->busnr, &xilinx_pcie_ops,
>  				sys, &sys->resources);
>  
> +	if (!bus)
> +		return NULL;
> +
> +#ifdef CONFIG_PCI_MSI
> +	bus->msi = &xilinx_pcie_msi_chip;
> +#endif
> +
> +	pci_scan_child_bus(bus);
> +
>  	return bus;
>  }
>  
> @@ -847,7 +856,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
>  
>  #ifdef CONFIG_PCI_MSI
>  	xilinx_pcie_msi_chip.dev = port->dev;
> -	hw.msi_ctrl = &xilinx_pcie_msi_chip;
>  #endif
>  	pci_common_init_dev(dev, &hw);
>  
> 

Hi Lorenzo,

I wonder if we can delete weak pcibios_msi_controller and the call in
pci_msi_controller in drivers/pci/msi.c

Regards,
Zhou


