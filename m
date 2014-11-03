Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:23728 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbaKCBRv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Nov 2014 20:17:51 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEF002ZPVLIMYA0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 03 Nov 2014 10:17:43 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	liviu.dudau@arm.com, 'Arnd Bergmann' <arnd@arndb.de>,
	'Phil Edworthy' <phil.edworthy@renesas.com>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Russell King' <linux@arm.linux.org.uk>,
	'Mohit Kumar' <mohit.kumar@st.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Lucas Stach' <l.stach@pengutronix.de>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Murali Karicheri' <m-karicheri2@ti.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1414669490-1217-3-git-send-email-lorenzo.pieralisi@arm.com>
In-reply-to: <1414669490-1217-3-git-send-email-lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 2/2] arm: pcibios: move to generic PCI domains
Date: Mon, 03 Nov 2014 10:18:12 +0900
Message-id: <003401cff704$09755cd0$1c601670$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, October 30, 2014 8:45 PM, Lorenzo Pieralisi wrote:
> 
> Most if not all ARM PCI host controller device drivers either ignore the
> domain field in the pci_sys_data structure or just increment it every
> time a host controller is probed, using it as a domain counter.
> 
> Therefore, instead of relying on pci_sys_data to stash the domain number
> in a standard location, ARM pcibios code can be moved to the newly
> introduced generic PCI domains code, implemented in commits:
> 
> commit 41e5c0f81d3e676d671d96a0a1fafb27abfbd9
> ("of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr()")
> 
> commit 670ba0c8883b576d0aec28bd7a838358a4be1
> ("PCI: Add generic domain handling")
> 
> In order to assign a domain number dynamically, the ARM pcibios defines
> the function, called by core PCI code:
> 
> void pci_bus_assign_domain_nr(...)
> 
> that relies on a DT property to define the domain number or falls back to
> a counter; its usage replaces the current domain assignment code in PCI
> host controllers present in the kernel.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Mohit Kumar <mohit.kumar@st.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

(+CC Richard Zhu, Lucas Stach, Kishon Vijay Abraham I, Murali Karicheri)

Acked-by: Jingoo Han <jg1.han@samsung.com>

For a long time, I have wanted the patch like this. Personally,
I want to increase the build coverage and keep the same binary
regardless of config options as possible; thus, I don't like
#ifdef guards such as '#ifdef CONFIG_PCI_DOMAINS'. When I submitted
the first patch for 'pcie-designware.c', I was not able to find
a way to remove '#ifdef CONFIG_PCI_DOMAINS' from 'pcie-designware.c'.

This patch looks good and I think that this patch will not make
the problem. However, I didn't test this patch with Exynos platform,
due to some reasons. So, I hope that other engineers test this patch
on other SoC platforms related to designware PCIe.

To Mohit Kumar (ST SPEAR13XX), Richard Zhu/Lucas Stach (IMX6)
    Kishon Vijay Abraham I (TI DRA7XX), Murali Karicheri (TI KEYSTONE)

Would you test this patch and share the result?
It would be very helpful. Thank you.

Best regards,
Jingoo Han

> ---
>  arch/arm/Kconfig                   |  3 +++
>  arch/arm/include/asm/mach/pci.h    |  3 ---
>  arch/arm/include/asm/pci.h         |  7 -------
>  arch/arm/kernel/bios32.c           | 26 +++++++++++++++++++++++---
>  drivers/pci/host/pci-mvebu.c       | 10 ++--------
>  drivers/pci/host/pcie-designware.c |  3 ---
>  drivers/pci/host/pcie-rcar.c       |  3 ---
>  7 files changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 89c4b5c..29544f0 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1292,6 +1292,9 @@ config PCI_DOMAINS
>  	bool
>  	depends on PCI
> 
> +config PCI_DOMAINS_GENERIC
> +	def_bool PCI_DOMAINS
> +
>  config PCI_NANOENGINE
>  	bool "BSE nanoEngine PCI support"
>  	depends on SA1100_NANOENGINE
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 7fc4278..f19f627 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -44,9 +44,6 @@ struct hw_pci {
>   * Per-controller structure
>   */
>  struct pci_sys_data {
> -#ifdef CONFIG_PCI_DOMAINS
> -	int		domain;
> -#endif
>  	struct list_head node;
>  	int		busnr;		/* primary bus number			*/
>  	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
> diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
> index 7e95d85..585dc33 100644
> --- a/arch/arm/include/asm/pci.h
> +++ b/arch/arm/include/asm/pci.h
> @@ -18,13 +18,6 @@ static inline int pcibios_assign_all_busses(void)
>  }
> 
>  #ifdef CONFIG_PCI_DOMAINS
> -static inline int pci_domain_nr(struct pci_bus *bus)
> -{
> -	struct pci_sys_data *root = bus->sysdata;
> -
> -	return root->domain;
> -}
> -
>  static inline int pci_proc_domain(struct pci_bus *bus)
>  {
>  	return pci_domain_nr(bus);
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 17a26c1..d8c2b4e 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -11,6 +11,8 @@
>  #include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_pci.h>
> 
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
> @@ -468,9 +470,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  		if (!sys)
>  			panic("PCI: unable to allocate sys data!");
> 
> -#ifdef CONFIG_PCI_DOMAINS
> -		sys->domain  = hw->domain;
> -#endif
>  		sys->busnr   = busnr;
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
> @@ -511,6 +510,27 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  	}
>  }
> 
> +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> +static bool dt_domain_found;
> +
> +void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> +{
> +	int domain = of_get_pci_domain_nr(parent->of_node);
> +
> +	if (domain >= 0) {
> +		dt_domain_found = true;
> +	} else if (dt_domain_found == true) {
> +		dev_err(parent, "Node %s is missing \"linux,pci-domain\" property in DT\n",
> +			parent->of_node->full_name);
> +		return;
> +	} else {
> +		domain = pci_get_new_domain_nr();
> +	}
> +
> +	bus->domain_nr = domain;
> +}
> +#endif
> +
>  void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
>  {
>  	struct pci_sys_data *sys;
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index b1315e1..2b4c1f2 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -722,17 +722,11 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
>  {
>  	struct mvebu_pcie *pcie = sys_to_pcie(sys);
>  	int i;
> -	int domain = 0;
> 
> -#ifdef CONFIG_PCI_DOMAINS
> -	domain = sys->domain;
> -#endif
> -
> -	snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x",
> -		 domain);
> +	snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x", nr);
>  	pcie->mem.name = pcie->mem_name;
> 
> -	snprintf(pcie->io_name, sizeof(pcie->io_name), "PCI I/O %04x", domain);
> +	snprintf(pcie->io_name, sizeof(pcie->io_name), "PCI I/O %04x", nr);
>  	pcie->realio.name = pcie->io_name;
> 
>  	if (request_resource(&iomem_resource, &pcie->mem))
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index dfed00a..6790b87 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -502,9 +502,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  	dw_pci.private_data = (void **)&pp;
> 
>  	pci_common_init_dev(pp->dev, &dw_pci);
> -#ifdef CONFIG_PCI_DOMAINS
> -	dw_pci.domain++;
> -#endif
> 
>  	return 0;
>  }
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 61158e0..b6b859e 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -404,9 +404,6 @@ static void rcar_pcie_enable(struct rcar_pcie *pcie)
>  	rcar_pci.private_data = (void **)&pcie;
> 
>  	pci_common_init_dev(&pdev->dev, &rcar_pci);
> -#ifdef CONFIG_PCI_DOMAINS
> -	rcar_pci.domain++;
> -#endif
>  }
> 
>  static int phy_wait_for_ack(struct rcar_pcie *pcie)
> --
> 2.1.2

