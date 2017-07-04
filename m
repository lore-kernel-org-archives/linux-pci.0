Return-Path: <SRS0=4Z93=6H=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=4Z93=6H=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Date: Tue, 4 Jul 2017 19:17:37 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
	Mark Rutland <mark.rutland@arm.com>, Mason <slash.tmp@free.fr>,
	Marc Zyngier <marc.zyngier@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
Message-ID: <20170704181737.GF4902@n2100.armlinux.org.uk>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
 <20170703181128.GD4902@n2100.armlinux.org.uk>
 <20170704151502.GH13824@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170704151502.GH13824@bhelgaas-glaptop.roam.corp.google.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 04, 2017 at 10:15:02AM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 03, 2017 at 07:11:28PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Jul 03, 2017 at 08:40:31AM -0500, Bjorn Helgaas wrote:
> > > The problem is serializing vs. memory accesses, since they don't use
> > > any wrappers.  However, they are ioremapped(), so it's at least
> > > conceivable that another solution would be to use VM to trap those
> > > accesses.  I'm not a VM person, so I don't know whether that's
> > > feasible in Linux.
> > 
> > Bjorn,
> > 
> > You're forgetting that MMIO (iow, memory returned by ioremap()) must
> > be accessed through the appropriate accessors, and must not be
> > directly dereferenced in C.  (We do have buggy drivers that do that
> > but they are buggy, and in many cases are getting attention to fix
> > that.)
> 
> Oh, you're right, thank you!  I guess you're referring to readb()
> and friends.  I haven't found an actual prohibition on directly
> dereferencing addresses returned from ioremap(), but
> Documentation/driver-api/device-io.rst is clear that they're
> suitable for passing to readb(), etc.

There was a strong suggestion years ago that what is returned from
ioremap() is a cookie that must not be dereferenced by drivers, and
that there was a suggestion that having ioremap() return the virtual
address with an offset (which read*() and friends would undo) would
be a good idea.  However, even back then, we had some cases where
drivers would directly dereference the pointer.  We have sparse today
which helps point these places out (provided drivers stay away from
__force, but unfortunately, I think we've ended up with people who
think that silencing sparse warnings with __force is more preferable
than leaving them there to point out where things are actually wrong.)

So, imho, unfortunately sparse has lost its usefulness in this regard.

> I recently told someone else my mistaken idea that ioremap() must
> return a valid virtual address.  I wish I remembered who it was, so I
> could correct that.  Documentation/DMA-API-HOWTO.txt also suggests
> that ioremap() returns a virtual address -- I think I wrote that, and
> maybe that virtual address reference should be tweaked a bit.

For most implementations, ioremap() does indeed return a virtual address,
but that was never how the API was defined in the first place - it was
always referred to as returning a cookie.

> Another wrinkle is that the pci_mmap_resource() interface is exposed
> via sysfs and allows direct userspace mmap of PCI MMIO resources.  In
> that case, there is no accessor available.  I wonder if we need some
> way to disable this mmap when readb() is non-trivial.

Hmm, no comment, except that while the PCI MMIO space is available to
userspace, and userspace is capable of running that thread on any CPU,
PCI MMIO space can't be switched to config space.

That's another nail in this coffin...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
