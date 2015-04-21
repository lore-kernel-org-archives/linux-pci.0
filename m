Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59848 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbbDUSrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Apr 2015 14:47:49 -0400
Date: Tue, 21 Apr 2015 20:46:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arndatarndb.de@suse.de>,
	Linus Walleij <linus.walleijatlinaro.org@suse.de>,
	Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Peter Senna Tschudin <peter.senna@gmail.com>,
	Sarah Sharp <sarah.a.sharp@intel.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com,
	Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-fbdev@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	Ingo Molnar <mingo@elte.hu>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Bader <stefan.bader@canonical.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?=
	<ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Benjamin Poirier <bpoirier@suse.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 05/47] pci: add pci_iomap_wc() variants
Message-ID: <20150421203623-mutt-send-email-mst@redhat.com>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-6-git-send-email-mcgrof@do-not-panic.com>
 <CAErSpo5LfgTM879jmt58yLrXD6e7spsaX1wNDcc2ppU9JrMXOg@mail.gmail.com>
 <20150326030054.GA5622@wotan.suse.de>
 <20150421175249.GN5622@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150421175249.GN5622@wotan.suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 21, 2015 at 07:52:49PM +0200, Luis R. Rodriguez wrote:
> On Thu, Mar 26, 2015 at 04:00:54AM +0100, Luis R. Rodriguez wrote:
> > On Mon, Mar 23, 2015 at 12:20:47PM -0500, Bjorn Helgaas wrote:
> > > Hi Luis,
> > > 
> > > This seems OK to me, 
> > 
> > Great.
> > 
> > > but I'm curious about a few things.
> > > 
> > > On Fri, Mar 20, 2015 at 6:17 PM, Luis R. Rodriguez
> > > <mcgrof@do-not-panic.com> wrote:
> > > > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > > >
> > > > This allows drivers to take advantage of write-combining
> > > > when possible. Ideally we'd have pci_read_bases() just
> > > > peg an IORESOURCE_WC flag for us
> > > 
> > > We do set IORESOURCE_PREFETCH.  Do you mean something different?
> > 
> > I did not think we had a WC IORESOURCE flag. Are you saying that we can use
> > IORESOURCE_PREFETCH for that purpose? If so then great.  As I read a PCI BAR
> > can have PCI_BASE_ADDRESS_MEM_PREFETCH and when that's the case we peg
> > IORESOURCE_PREFETCH. That seems to be what I want indeed. Questions below.
> > 
> > > >  but where exactly
> > > > video devices memory lie varies *largely* and at times things
> > > > are mixed with MMIO registers, sometimes we can address
> > > > the changes in drivers, other times the change requires
> > > > intrusive changes.
> > > 
> > > What does a video device address have to do with this?  I do see that
> > > if a BAR maps only a frame buffer, the device might be able to mark it
> > > prefetchable, while if the BAR mapped both a frame buffer and some
> > > registers, it might not be able to make it prefetchable.  But that
> > > doesn't seem like it depends on the *address*.
> > 
> > I meant the offsets for each of those, either registers or framebuffer,
> > and that typically they are mixed (primarily on older devices), so indeed your
> > summary of the problem is what I meant. Let's remember that we are trying to
> > take advantage of PAT here when available and avoid MTRR in that case, do we
> > know that the same PCI BARs that have always historically used MTRRs had
> > IORESOURCE_PREFETCH set, is that a fair assumption ? I realize they are
> > different things -- but its precisely why I ask.
> > 
> > > pci_iomap_range() already makes a cacheable mapping if
> > > IORESOURCE_CACHEABLE; I'm guessing that you would like it to
> > > automatically use WC if the BAR if IORESOURCE_PREFETCH, e.g.,
> > > 
> > >   if (flags & IORESOURCE_CACHEABLE)
> > >     return ioremap(start, len);
> > >   if (flags & IORESOURCE_PREFETCH)
> > >     return ioremap_wc(start, len);
> > >   return ioremap_nocache(start, len);
> > 
> > Indeed, that's exactly what I think we should strive towards.
> > 
> > > Is there a reason not to do that?
> > 
> > This depends on the exact defintion of IORESOURCE_PREFETCH and
> > PCI_BASE_ADDRESS_MEM_PREFETCH and how they are used all over and
> > accross *all devices*. This didn't look promising for starters:
> > 
> > include/uapi/linux/pci_regs.h:#define  PCI_BASE_ADDRESS_MEM_PREFETCH    0x08    /* prefetchable? */
> > 
> > PCI_BASE_ADDRESS_MEM_PREFETCH seems to be BAR specific, so a few questions:
> > 
> > 1) Can we rest assured for instance that if we check for
> > PCI_BASE_ADDRESS_MEM_PREFETCH and if set that it will *only* be set on a full
> > PCI BAR if the full PCI BAR does want WC? If not this can regress
> > functionality. That seems risky. It however would not be risky if we used
> > another API that did look for IORESOURCE_PREFETCH and if so use ioremap_wc() --
> > that way only drivers we know that do use the full PCI bar would use this API.
> > There's a bit of a problem with this though:
> > 
> > 2) Do we know that if a *full PCI BAR* is used for WC that
> > PCI_BASE_ADDRESS_MEM_PREFETCH *was* definitely set for the PCI BAR? If so then
> > the API usage would be restricted only to devices that we know *do* adhere to
> > this. That reduces the possible uses for older drivers and can create
> > regressions if used loosely without verification... but..
> > 

In theory, PCI spec says this about prefetch memory:
	Bridges are permitted to merge writes into this range (refer to Section 3.2.6).

Exceptions could be:
	- devices not behind a bridge (e.g. intergrated in a root
	  complex)
	- devices behind a virtual bridge from same vendor
	  (which know bridge won't prefetch)

I worry that WC might also cause more reordering though.  I don't
remember this is true, off-hand.  Bridges can only reorder transactions
according to very specific rules.

> > 3) If from now on we get folks to commit to uset PCI_BASE_ADDRESS_MEM_PREFETCH
> > for full PCI BARs that do want WC perhaps newer devices / drivers will use
> > this very consistently ? Can we bank on that and is it worth it ?

Unfortunately there's a separate good reason to set memory as prefetcheable:
it's the only way to get 64 bit addresses for devices behind bridges.
So WC might be *safe* for prefetch BARs, but might not be a good idea.

> > 
> > 4) If a PCI BAR *does not* have PCI_BASE_ADDRESS_MEM_PREFETCH do we know it
> > must not never want WC ?

That's not true I think. It means device can't allow prefetch but maybe
it does allow combining.

> > 
> > If we don't have certainty on any of the above I'm afraid we can't do much
> > right now but perhaps we can push towards better use of PCI_BASE_ADDRESS_MEM_PREFETCH
> > and hope folks will only use this for the full PCI BAR only if WC is desired.
> > 
> > Thoughts?
> 
> Bjorn, now that you're done schooling me on English, any thoughts on the above?
>
> > > > Although there is also arch_phys_wc_add() that makes use of
> > > > architecture specific write-combinging alternatives (MTRR on
> > > > x86 when a system does not have PAT) we void polluting
> > > > pci_iomap() space with it and force drivers and subsystems
> > > > that want to use it to be explicit.
> > > >
> > > > There are a few motivations for this:
> > > >
> > > > a) Take advantage of PAT when available
> > > >
> > > > b) Help bury MTRR code away, MTRR is architecture specific and on
> > > >    x86 its replaced by PAT
> > > >
> > > > c) Help with the goal of eventually using _PAGE_CACHE_UC over
> > > >    _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (de33c442e)
> > > > ...
> > > 
> > > > +void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
> > > > +                                int bar,
> > > > +                                unsigned long offset,
> > > > +                                unsigned long maxlen)
> > > > +{
> > > > +       resource_size_t start = pci_resource_start(dev, bar);
> > > > +       resource_size_t len = pci_resource_len(dev, bar);
> > > > +       unsigned long flags = pci_resource_flags(dev, bar);
> > > > +
> > > > +       if (len <= offset || !start)
> > > > +               return NULL;
> > > > +       len -= offset;
> > > > +       start += offset;
> > > > +       if (maxlen && len > maxlen)
> > > > +               len = maxlen;
> > > > +       if (flags & IORESOURCE_IO)
> > > > +               return __pci_ioport_map(dev, start, len);
> > > > +       if (flags & IORESOURCE_MEM)
> > > 
> > > Should we log a note in dmesg if the BAR is *not* IORESOURCE_PREFETCH?
> > >  I know the driver might know it's safe even if the device didn't mark
> > > the BAR as prefetchable, but it does seem like an easy way for a
> > > driver to shoot itself in the foot.
> > 
> > You tell me. I would fear this may not be consistent and we'd end up
> > having bug reports open for something that has historically been a
> > non-issue. The above questions can help us gauge the risk of this.
> 
> Now, I'll tell you what I *think* but these are just guestimates (TM):
> 
>   * Likely PCI_BASE_ADDRESS_MEM_PREFETCH can implate IORESOURCE_PREFETCH
>     and use of ioremap_wc() on a full PCI BAR only, but this strict
>     definition likely cannot be 100% guaranteed and could break some
>     devices. We need something a bit more concrete and well known so
>     that next generation industry standards embrace and let us in
>     the kernel automatically detect specific ranges and their respective
>     page attribute requirements. Might be good to address here x86 and
>     ARM families
> 
> Curious: Sarah, how does USB address these different different page attribute
> needs on USB 3.0?
> 
>   Luis
