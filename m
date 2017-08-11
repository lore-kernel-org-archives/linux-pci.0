Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753219AbdHKRDV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Aug 2017 13:03:21 -0400
Date: Fri, 11 Aug 2017 12:03:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Scott Bauer <scott.bauer@intel.com>,
        David Fugate <david.fugate@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pci: Generalize is_vmd behavior
Message-ID: <20170811170319.GB17039@bhelgaas-glaptop.roam.corp.google.com>
References: <20170807195713.10963-1-jonathan.derrick@intel.com>
 <20170807195713.10963-2-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170807195713.10963-2-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 07, 2017 at 01:57:12PM -0600, Jon Derrick wrote:
> Generalize is_vmd behavior to remove dependency on domain number
> checking in pci quirks.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  arch/x86/include/asm/pci.h | 8 +++-----
>  arch/x86/pci/common.c      | 2 +-
>  drivers/pci/quirks.c       | 2 +-
>  include/linux/pci.h        | 4 ++++
>  4 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 473a729..5c5d54a 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -60,16 +60,14 @@ static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
>  #define pci_root_bus_fwnode	_pci_root_bus_fwnode
>  #endif
>  
> -static inline bool is_vmd(struct pci_bus *bus)
> -{
>  #if IS_ENABLED(CONFIG_VMD)
> +static inline bool pci_bus_is_vmd(struct pci_bus *bus)
> +{
>  	struct pci_sysdata *sd = bus->sysdata;
>  
>  	return sd->vmd_domain;
> -#else
> -	return false;
> -#endif
>  }
> +#endif
>  
>  /* Can be used to override the logic in pci_scan_bus for skipping
>     already-configured bus numbers - to be used for buggy BIOSes
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index dbe2132..18b2277 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -662,7 +662,7 @@ static void set_dma_domain_ops(struct pci_dev *pdev) {}
>  
>  static void set_dev_domain_options(struct pci_dev *pdev)
>  {
> -	if (is_vmd(pdev->bus))
> +	if (pci_bus_is_vmd(pdev->bus))
>  		pdev->hotplug_user_indicators = 1;
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6967c6b..ba47995 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4666,7 +4666,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>  static void quirk_no_aersid(struct pci_dev *pdev)
>  {
>  	/* VMD Domain */
> -	if (pdev->bus->sysdata && pci_domain_nr(pdev->bus) >= 0x10000)
> +	if (pci_bus_is_vmd(pdev->bus))

I like this part ...

>  		pdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_AERSID;
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_no_aersid);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4869e66..0299d8b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1471,6 +1471,10 @@ static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
>  static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>  #endif /* CONFIG_PCI_DOMAINS */
>  
> +#if !IS_ENABLED(CONFIG_VMD)
> +static inline bool pci_bus_is_vmd(struct pci_bus *bus) { return false; }
> +#endif

But not so much this part.  VMD is (AFAIK) still fundamentally an
x86-only thing, so I'd like it better if this could all be within
arch/x86.  Could this be done by moving quirk_no_aersid() to
arch/x86/pci/fixup.c?

BTW, CONFIG_VMD in drivers/pci/host/Kconfig is currently "depends on
SRCU".  I'm not a Kconfig expert, but that doesn't seem like an
intuitive connection.  And it's the only such dependency on SRCU in
the tree -- most other places use "select SRCU", which makes more
sense to me.

>  /*
>   * Generic implementation for PCI domain support. If your
>   * architecture does not need custom management of PCI
> -- 
> 2.9.4
> 
