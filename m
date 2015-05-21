Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 21 May 2015 17:26:55 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: tomi.valkeinen@ti.com, airlied@linux.ie,
	linux-fbdev@vger.kernel.org, luto@amacapital.net,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	konrad.wilk@oracle.com, ville.syrjala@linux.intel.com,
	david.vrabel@citrix.com, jbeulich@suse.com,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [PATCH v6 1/4] pci: add pci_iomap_wc() variants
Message-ID: <20150521222655.GF32152@google.com>
References: <1432163293-20965-1-git-send-email-mcgrof@do-not-panic.com>
 <1432163293-20965-2-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432163293-20965-2-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 20, 2015 at 04:08:10PM -0700, Luis R. Rodriguez wrote:
> ...
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

Huh.  So you let me talk about marking the unused pcim_iomap_wc()
EXPORT_SYMBOL_GPL(), but didn't remind me that you also proposed to mark
the symbol you really care about, the one you already have a use for, as
EXPORT_SYMBOL_GPL().  Sigh.

In my opinion, if we're going to use EXPORT_SYMBOL_GPL() at all, we should
use it consistently and based on technical considerations.  I base this on
statements like the following:

  - "[EXPORT_SYMBOL_GPL()] implies that the function is considered an
    internal implementation issue, and not really an interface." [Rusty
    Russell, 1]

  - "... using the xxx_GPL() version to show that it's an internal
    interface ..." [Linus Torvalds, 2]

  - "Anything exported via EXPORT_SYMBOL_GPL() is considered by the author
    to be so fundamental to the kernel that using it would be impossible
    without creating a derivative work." [Matthew Garrett, 3]

  - "Linus's initial point for [_GPL symbols] has been so diluted by random
    lobby groups asking for every symbol to be _GPL that they are becoming
    effectively pointless now." [Dave Airlie, 4]

Existing interfaces like these are exported with EXPORT_SYMBOL():

  ioremap()
  ioremap_wc()
  ioremap_prot()
  pci_iomap()
  pci_map_rom()

I would argue that pci_iomap_wc() is similar in spirit and is no more an
internal implementation issue than they are, and should be exported
similarly.

So my *advice* is to use EXPORT_SYMBOL() in this case, because that's a
choice you can defend on technical grounds.  I think it's hard to argue
that pci_iomap_wc() is so fundamental or unique to Linux that a caller
would automatically be a derivative work.

Will I still merge it as EXPORT_SYMBOL_GPL()?  Maybe.  I don't feel *good*
about it because the only explanation I can give is "the author wanted it
that way," and that's unsatisfying.  But I did already ack it (before I
noticed the _GPL() issue), and I won't try to retract that and prevent
somebody else from merging it.  And maybe your proposal to clarify the
kernel-hacking.tmpl language will convince me.

Bjorn

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=b6c17ea4eff3
[2] http://lkml.kernel.org/r/Pine.LNX.4.64.0510050742550.31407@g5.osdl.org
[3] http://mjg59.dreamwidth.org/31357.html
[4] http://lkml.kernel.org/r/CAPM=9tzsT+nah2P-qZ8iKW=aTZJzYgm18mMWyy2-RVkoOSwyjg@mail.gmail.com
