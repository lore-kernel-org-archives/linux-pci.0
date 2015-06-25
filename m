Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 Jun 2015 17:09:18 +0200
From: Borislav Petkov <bp@suse.de>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: mingo@kernel.org, arnd@arndb.de, bhelgaas@google.com,
	luto@amacapital.net, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com,
	linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com,
	benh@kernel.crashing.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Davidlohr Bueso <dbueso@suse.de>, konrad.wilk@oracle.com,
	ville.syrjala@linux.intel.com, david.vrabel@citrix.com,
	jbeulich@suse.com,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Subject: Re: [PATCH v8 5/9] PCI: Add pci_iomap_wc() variants
Message-ID: <20150625150918.GA4898@pd.tnic>
References: <1435195342-26879-1-git-send-email-mcgrof@do-not-panic.com>
 <1435195342-26879-6-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1435195342-26879-6-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 24, 2015 at 06:22:18PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> PCI BARs tell us whether prefetching is safe, but they don't say anything
> about write combining (WC).  WC changes ordering rules and allows writes to
> be collapsed, so it's not safe in general to use it on a prefetchable
> region.
> 
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

...

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

I've moved this check at the beginning of the function so that we bail
out before doing the computations above it.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
