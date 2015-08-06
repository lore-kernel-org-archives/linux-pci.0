Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35684 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbbHFOvg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 10:51:36 -0400
Received: by pdrg1 with SMTP id g1so33437023pdr.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2015 07:51:35 -0700 (PDT)
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
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150804215420.9189.22914.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150804215420.9189.22914.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Subject: Re: [PATCH v5 4/9] ARM/PCI: Remove msi_controller from struct pci_sys_data
Date: Thu, 6 Aug 2015 23:51:24 +0900
Message-ID: <000601d0d057$63c40fb0$2b4c2f10$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 05, 2015 6:54 AM, Bjorn Helgaas wrote:
> 
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> ARM now uses pci_bus->msi to store the msi_controller pointer, so we don't
> need to save it in struct pci_sys_data, and we don't need to implement
> pcibios_msi_controller() to get it out of pci_sys_data.
> 
> Remove msi_controller from struct pci_sys_data and
> pcibios_msi_controller().
> 
> [bhelgaas: changelog, split into separate patch]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  arch/arm/include/asm/mach/pci.h |    3 ---
>  arch/arm/kernel/bios32.c        |   12 ------------
>  2 files changed, 15 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index c074e7a..8857d28 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -40,9 +40,6 @@ struct hw_pci {
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
> index 283bc1c..874e182 100644
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
>  		if (WARN(!sys, "PCI: unable to allocate sys data!"))
>  			break;
> 
> -#ifdef CONFIG_PCI_MSI
> -		sys->msi_ctrl = hw->msi_ctrl;
> -#endif
>  		sys->busnr   = busnr;
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;

