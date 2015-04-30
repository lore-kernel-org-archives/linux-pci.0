Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 30 Apr 2015 10:59:17 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: mst@redhat.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com,
	airlied@linux.ie, daniel.vetter@intel.com,
	linux-fbdev@vger.kernel.org, luto@amacapital.net,
	cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	konrad.wilk@oracle.com, ville.syrjala@linux.intel.com,
	david.vrabel@citrix.com, jbeulich@suse.com,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	xen-devel@lists.xensource.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/5] pci: add pci_iomap_wc() variants
Message-ID: <20150430155917.GC7888@google.com>
References: <1430343372-687-1-git-send-email-mcgrof@do-not-panic.com>
 <1430343372-687-2-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430343372-687-2-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

Hi Luis,

On Wed, Apr 29, 2015 at 02:36:08PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> This allows drivers to take advantage of write-combining
> when possible. Ideally we'd have pci_read_bases() just
> peg an IORESOURCE_WC flag for us 

This makes it sound like pci_read_bases() could do a better job
if we just tried harder, but I don't think that's the case.  All
pci_read_bases() can do is look at the bits in the BAR.  For
memory BARs, there's a "prefetchable" bit and a "64-bit" bit.

If you just want to complain that the PCI spec didn't define a
way for software to discover whether a BAR can be mapped with WC,
that's fine, but it's misleading to suggest that pci_read_bases()
could figure out WC without some help from the spec.

> but where exactly
> video devices memory lie varies *largely* and at times things
> are mixed with MMIO registers, sometimes we can address
> the changes in drivers, other times the change requires
> intrusive changes.
> 
> Although there is also arch_phys_wc_add() that makes use of
> architecture specific write-combining alternatives (MTRR on
> x86 when a system does not have PAT) we void polluting
> pci_iomap() space with it and force drivers and subsystems
> that want to use it to be explicit.

I'm not quite sure I understand the point you're making here
about not polluting pci_iomap_wc() with arch_phys_wc_add().  I
think the choice is for a driver to do either this:

  info->screen_base = pci_iomap_wc(dev, 0, 0);

or this:

  info->screen_base = pci_iomap_wc(dev, 0, 0);
  par->wc_cookie = arch_phys_wc_add(pci_resource_start(dev, 0),
				    pci_resource_len(dev, 0));

The driver is *already* being explicit because it calls
pci_iomap_wc() instead of pci_iomap().

It seems like it would be ideal if ioremap_wc() could call
arch_phys_wc_add() internally.  Doesn't any caller of
arch_phys_wc_add() have to also do some sort of ioremap()
beforehand?  I assume there's some reason for separating them,
and I see that the current arch_phys_wc_add() requires the caller
to store a handle, but doing both seems confusing.

> There are a few motivations for this:
> 
> a) Take advantage of PAT when available
> 
> b) Help bury MTRR code away, MTRR is architecture specific and on
>    x86 its replaced by PAT
> 
> c) Help with the goal of eventually using _PAGE_CACHE_UC over
>    _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
>    de33c442e titled "x86 PAT: fix performance drop for glx,
>    use UC minus for ioremap(), ioremap_nocache() and
>    pci_mmap_page_range()")

I think these are now _PAGE_CACHE_MODE_UC and
_PAGE_CACHE_MODE_UC_MINUS, right? 

> ...

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
> +		return __pci_ioport_map(dev, start, len);

Is there any point in checking for IORESOURCE_IO?  If a driver
calls pci_iomap_wc_range(), I assume it already knows this is an
IORESOURCE_MEM BAR, so if we see IORESOURCE_IO here we should
just return an error, i.e., NULL.

> +	if (flags & IORESOURCE_MEM)
> +		return ioremap_wc(start, len);
> +	/* What? */
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_wc_range);

Bjorn
