Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 23 Sep 2016 09:34:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 2/2] x86/vmd: Add PCI domain specific LED option
Message-ID: <20160923143441.GF1514@localhost>
References: <1473779140-4016-1-git-send-email-keith.busch@intel.com>
 <1473779140-4016-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473779140-4016-2-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 09:05:40AM -0600, Keith Busch wrote:
> This patch adds a new function to set PCI domain specific options as
> devices are added. The usage included in this patch is for LED indicator
> control in VMD domains, but may be extended in the future as new domain
> specific options are required.
> 
> PCIe LED Slot Control in a VMD domain is repurposed to a non-standard
> implementation. As such, all devices in a VMD domain will be flagged so
> pciehp does not attempt to use LED indicators. This user_led flag
> has pciehp provide a different sysfs entry for user exclusive control
> over the domain's slot indicators.
> 
> In order to determine if a bus is within a PCI domain, the patch appends
> a bool to the pci_sysdata structure that the VMD driver sets during
> initialization.
> 
> Requested-by: Kapil Karkra <kapil.karkra@intel.com>
> Tested-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Applied on pci/hotplug for v4.9, thanks!

I made the necessary changes to match the renaming I did in the first
patch, and I also used plain old "#ifdef" instead of "#if IS_ENABLED"
since the rest of the file uses the former style.  If there's a reason
to switch, we should change the whole file in a separate patch so we
can explain the rationale.

Please check it out and make sure everything you need made it in.

> ---
> 
> No change from previous version of this patch; just part of the series.
> 
>  arch/x86/include/asm/pci.h | 14 ++++++++++++++
>  arch/x86/pci/common.c      |  7 +++++++
>  arch/x86/pci/vmd.c         |  1 +
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 9ab7507..1411dbe 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -23,6 +23,9 @@ struct pci_sysdata {
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
>  	void		*fwnode;	/* IRQ domain for MSI assignment */
>  #endif
> +#if IS_ENABLED(CONFIG_VMD)
> +	bool vmd_domain;		/* True if in Intel VMD domain */
> +#endif
>  };
>  
>  extern int pci_routeirq;
> @@ -56,6 +59,17 @@ static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
>  #define pci_root_bus_fwnode	_pci_root_bus_fwnode
>  #endif
>  
> +static inline bool is_vmd(struct pci_bus *bus)
> +{
> +#if IS_ENABLED(CONFIG_VMD)
> +	struct pci_sysdata *sd = bus->sysdata;
> +
> +	return sd->vmd_domain;
> +#else
> +	return false;
> +#endif
> +}
> +
>  /* Can be used to override the logic in pci_scan_bus for skipping
>     already-configured bus numbers - to be used for buggy BIOSes
>     or architectures with incomplete PCI setup by the loader */
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 7b6a9d1..ccf696c 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -677,6 +677,12 @@ static void set_dma_domain_ops(struct pci_dev *pdev)
>  static void set_dma_domain_ops(struct pci_dev *pdev) {}
>  #endif
>  
> +static void set_dev_domain_options(struct pci_dev *pdev)
> +{
> +	if (is_vmd(pdev->bus))
> +		pdev->user_leds = 1;
> +}
> +
>  int pcibios_add_device(struct pci_dev *dev)
>  {
>  	struct setup_data *data;
> @@ -707,6 +713,7 @@ int pcibios_add_device(struct pci_dev *dev)
>  		iounmap(data);
>  	}
>  	set_dma_domain_ops(dev);
> +	set_dev_domain_options(dev);
>  	return 0;
>  }
>  
> diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> index b814ca6..a021b7b 100644
> --- a/arch/x86/pci/vmd.c
> +++ b/arch/x86/pci/vmd.c
> @@ -596,6 +596,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
>  		.parent = res,
>  	};
>  
> +	sd->vmd_domain = true;
>  	sd->domain = vmd_find_free_domain();
>  	if (sd->domain < 0)
>  		return sd->domain;
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
