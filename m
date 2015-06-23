Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:57009 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298AbbFWWpC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Jun 2015 18:45:02 -0400
Message-ID: <1435099343.3996.13.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: arnd@arndb.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
	linux-fbdev@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	konrad.wilk@oracle.com, ville.syrjala@linux.intel.com,
	david.vrabel@citrix.com, jbeulich@suse.com,
	Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Date: Wed, 24 Jun 2015 08:42:23 +1000
In-Reply-To: <1434751712-24333-6-git-send-email-mcgrof@do-not-panic.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
	 <1434751712-24333-6-git-send-email-mcgrof@do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2015-06-19 at 15:08 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> PCI BARs tell us whether prefetching is safe, but they don't say anything
> about write combining (WC).  WC changes ordering rules and allows writes to
> be collapsed, so it's not safe in general to use it on a prefetchable
> region.

Well, the PCIe spec at least specifies that a prefetchable BAR also
tolerates write merging... 

> Add pci_iomap_wc() and pci_iomap_wc_range() so drivers can take advantage
> of write combining when they know it's safe.
> 
> On architectures that don't fully support WC, e.g., x86 without PAT,
> drivers for legacy framebuffers may get some of the benefit by using
> arch_phys_wc_add() in addition to pci_iomap_wc().  But arch_phys_wc_add()
> is unreliable and should be avoided in general.  On x86, it uses MTRRs,
> which are limited in number and size, so the results will vary based on
> driver loading order.
> 
> The goals of adding pci_iomap_wc() are to:
> 
> - Give drivers an architecture-independent way to use WC so they can stop
>   using interfaces like mtrr_add() (on x86, pci_iomap_wc() uses
>   PAT when available)
> 
> - Move toward using _PAGE_CACHE_MODE_UC, not _PAGE_CACHE_MODE_UC_MINUS,
>   on x86 on ioremap_nocache() (see de33c442ed2a ("x86 PAT: fix
>   performance drop for glx, use UC minus for ioremap(), ioremap_nocache()
>   and pci_mmap_page_range()")
> 
> Link: http://lkml.kernel.org/r/1426893517-2511-6-git-send-email-mcgrof@do-not-panic.com
> Original-posting: http://lkml.kernel.org/r/1432163293-20965-1-git-send-email-mcgrof@do-not-panic.com
> Cc: Toshi Kani <toshi.kani@hp.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Suresh Siddha <sbsiddha@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: venkatesh.pallipadi@intel.com
> Cc: Stefan Bader <stefan.bader@canonical.com>
> Cc: Ville Syrjälä <syrjala@sci.fi>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: konrad.wilk@oracle.com
> Cc: ville.syrjala@linux.intel.com
> Cc: david.vrabel@citrix.com
> Cc: jbeulich@suse.com
> Cc: Roger Pau Monné <roger.pau@citrix.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: xen-devel@lists.xensource.com
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  include/asm-generic/pci_iomap.h | 14 ++++++++++
>  lib/pci_iomap.c                 | 61 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
> index 7389c87..b1e17fc 100644
> --- a/include/asm-generic/pci_iomap.h
> +++ b/include/asm-generic/pci_iomap.h
> @@ -15,9 +15,13 @@ struct pci_dev;
>  #ifdef CONFIG_PCI
>  /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
>  extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
> +extern void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long max);
>  extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
>  				     unsigned long offset,
>  				     unsigned long maxlen);
> +extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
> +					unsigned long offset,
> +					unsigned long maxlen);
>  /* Create a virtual mapping cookie for a port on a given PCI device.
>   * Do not call this directly, it exists to make it easier for architectures
>   * to override */
> @@ -34,12 +38,22 @@ static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned lon
>  	return NULL;
>  }
>  
> +static inline void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long max)
> +{
> +	return NULL;
> +}
>  static inline void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
>  					    unsigned long offset,
>  					    unsigned long maxlen)
>  {
>  	return NULL;
>  }
> +static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
> +					       unsigned long offset,
> +					       unsigned long maxlen)
> +{
> +	return NULL;
> +}
>  #endif
>  
>  #endif /* __ASM_GENERIC_IO_H */
> diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> index bcce5f1..9604dcb 100644
> --- a/lib/pci_iomap.c
> +++ b/lib/pci_iomap.c
> @@ -52,6 +52,46 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
>  EXPORT_SYMBOL(pci_iomap_range);
>  
>  /**
> + * pci_iomap_wc_range - create a virtual WC mapping cookie for a PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @offset: map memory at the given offset in BAR
> + * @maxlen: max length of the memory to map
> + *
> + * Using this function you will get a __iomem address to your device BAR.
> + * You can access it using ioread*() and iowrite*(). These functions hide
> + * the details if this is a MMIO or PIO address space and will just do what
> + * you expect from them in the correct way. When possible write combining
> + * is used.
> + *
> + * @maxlen specifies the maximum length to map. If you want to get access to
> + * the complete BAR from offset to the end, pass %0 here.
> + * */
> +void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
> +				 int bar,
> +				 unsigned long offset,
> +				 unsigned long maxlen)
> +{
> +	resource_size_t start = pci_resource_start(dev, bar);
> +	resource_size_t len = pci_resource_len(dev, bar);
> +	unsigned long flags = pci_resource_flags(dev, bar);
> +
> +	if (len <= offset || !start)
> +		return NULL;
> +	len -= offset;
> +	start += offset;
> +	if (maxlen && len > maxlen)
> +		len = maxlen;
> +	if (flags & IORESOURCE_IO)
> +		return NULL;
> +	if (flags & IORESOURCE_MEM)
> +		return ioremap_wc(start, len);
> +	/* What? */
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
> +
> +/**
>   * pci_iomap - create a virtual mapping cookie for a PCI BAR
>   * @dev: PCI device that owns the BAR
>   * @bar: BAR number
> @@ -70,4 +110,25 @@ void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
>  	return pci_iomap_range(dev, bar, 0, maxlen);
>  }
>  EXPORT_SYMBOL(pci_iomap);
> +
> +/**
> + * pci_iomap_wc - create a virtual WC mapping cookie for a PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @maxlen: length of the memory to map
> + *
> + * Using this function you will get a __iomem address to your device BAR.
> + * You can access it using ioread*() and iowrite*(). These functions hide
> + * the details if this is a MMIO or PIO address space and will just do what
> + * you expect from them in the correct way. When possible write combining
> + * is used.
> + *
> + * @maxlen specifies the maximum length to map. If you want to get access to
> + * the complete BAR without checking for its length first, pass %0 here.
> + * */
> +void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
> +{
> +	return pci_iomap_wc_range(dev, bar, 0, maxlen);
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_wc);
>  #endif /* CONFIG_PCI */


