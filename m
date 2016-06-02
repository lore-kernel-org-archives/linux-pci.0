Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, Wenrui Li <wenrui.li@rock-chips.com>, Doug Anderson <dianders@chromium.org>, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>, Hannes Reinecke <hare@suse.de>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/3] pci: introduce read_bridge/write_bridge pci ops
Date: Thu, 02 Jun 2016 17:44:51 +0200
Message-ID: <4288331.jNpl6KXlNO@wuerfel>
In-Reply-To: <20160602140001.GB8262@localhost>
References: <1464784332-3775650-1-git-send-email-arnd@arndb.de> <4967020.J4dsRYGugq@wuerfel> <20160602140001.GB8262@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 2, 2016 9:00:01 AM CEST Bjorn Helgaas wrote:
> On Wed, Jun 01, 2016 at 10:37:28PM +0200, Arnd Bergmann wrote:
> > On Wednesday, June 1, 2016 2:04:30 PM CEST Bjorn Helgaas wrote:
> > > On Wed, Jun 01, 2016 at 05:41:53PM +0200, Arnd Bergmann wrote:
> > > > On Wednesday, June 1, 2016 10:09:29 AM CEST Bjorn Helgaas wrote:
> > > > > Hi Arnd,
> > > > > 
> > > > > On Wed, Jun 01, 2016 at 02:31:22PM +0200, Arnd Bergmann wrote:
> > > > > > A lot of PCI host bridges require different methods for initiating
> > > > > > type 0 and type 1 config space accesses, leading to duplication of
> > > > > > code.
> > > > > > 
> > > > > > This adds support for the two different kinds at the pci_ops
> > > > > > level, with the newly added map_bridge/read_bridge/write_bridge
> > > > > > operations for type 1 accesses.
> > > > > > 
> > > > > > When these are not set, we fall back to the regular map_bus/read/write
> > > > > > operations, so all existing drivers keep working, and bridges that
> > > > > > have identical operations continue to only require one set.
> > > > > 
> > > > > This adds new config accessor functions to struct pci_ops and makes
> > > > > the callers responsible for figuring out which one to use.  The
> > > > > benefit is to reduce code duplication in some host bridge drivers
> > > > > (DesignWare and MVEBU so far).
> > > > > 
> > > > > From a design perspective, I'm not comfortable with moving this burden
> > > > > from the host bridge drivers to the callers of the config accessors.
> > > > ...
> > > 
> > > > Maybe we can simply change them to use the normal API and come up with
> > > > a way to make the pci_ops harder to misuse? Would it make you feel better
> > > > if we also renamed .read/.write into .read_type0/.write_type0 or something
> > > > like that?
> > > 
> > > I'm trying to get a better feel for the tradeoff here.  It seems like
> > > an API complication vs. code duplication.
> > > 
> > > I don't really think the callers should have to figure out which
> > > accessor to use.  How much of a benefit do we really gain by
> > > complicating the callers?  We've managed for quite a few years with
> > > the current scheme, and it seems like only a couple new ARM platforms
> > > would benefit.
> > 
> > I just did a count of the implementations of pci_ops: I found 107
> > instances of 'struct pci_ops', and 67 of them treat type0 and type1
> > access differently in some form.
> > 
> > I'd estimate that about half of them, or roughly a third of the total
> > instances would benefit from my change, if we were to do them again.
> > Clearly there is no need to change the existing code here when it works,
> > unless the benefit is very clear and the code is actively maintained.
> > 
> > In some cases, the difference is only that the root bus has a limited
> > set of devices that are allowed to be accessed, so there would
> > likely be no benefit of this, compared to e.g. yet another callback
> > that checks the validity.
> > Some other instances have type0 registers at a different memory location
> > from type1, some use different layout inside of that space, and some
> > are completely different.
> 
> The type0/type1 distinction still seems out of place to me at the call
> site.  Is there any other reason a caller would care about the
> difference between type0 and type1?

Another idea based on my RFC patches to make pci_host_bridge the primary
structure for probing PCI: we could split out the old 'bus::pci_ops' with
the traditional read/write interface from a new structure that becomes
pci_host_bridge::pci_host_bridge_ops, and also contains the other callbacks
that we recently added to pci_ops, alongside type0/type1 accessors.

We could then have a set of default pci_ops that call
pci_host_bridge_ops->type0_read/type0_write/type1_read/type1_write,
and those in turn get a pci_host_bridge as an argument along with the
bus, device, function and register numbers instead of bus pointer
and devfn/where.

This way all existing code can keep working, but we can convert host
drivers (if desired) to provide only pci_host_bridge_ops and no
pci_ops, while making it easier to define those with a more modern
interface.

	Arnd
