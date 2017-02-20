Return-Path: <SRS0=VRWy=2B=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=VRWy=2B=h08.hostsharing.net=foo00@kernel.org>
Date: Mon, 20 Feb 2017 13:04:57 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Erik Veijola <erik.veijola@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 3/8] PCI: pciehp: Reinstate runtime PM on Thunderbolt
 hotplug ports
Message-ID: <20170220120457.GB19834@h08.hostsharing.net>
References: <cover.1486913733.git.lukas@wunner.de>
 <14ffd1ceeb76200b34e0abfebab134545e504bdc.1486913733.git.lukas@wunner.de>
 <20170214225926.GB19040@bhelgaas-glaptop.roam.corp.google.com>
 <20170218092516.GB1335@wunner.de>
 <20170219001606.GA7668@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170219001606.GA7668@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 18, 2017 at 06:16:06PM -0600, Bjorn Helgaas wrote:
> On Sat, Feb 18, 2017 at 10:25:16AM +0100, Lukas Wunner wrote:
> > On Tue, Feb 14, 2017 at 04:59:26PM -0600, Bjorn Helgaas wrote:
> > > On Sun, Feb 12, 2017 at 05:07:45PM +0100, Lukas Wunner wrote:
> > > > Commit 68db9bc81436 ("PCI: pciehp: Add runtime PM support for PCIe
> > > > hotplug ports") extended runtime PM for PCIe ports to hotplug ports.
> > > > However Yinghai Lu reported the following breakage caused by the commit:
> > > > 
> > > > * After disabling a slot on one of his servers, the slot signals PME
> > > >   which causes pciehp to immediately re-enable the card, thus defeating
> > > >   manual slot control via sysfs.
> > > 
> > > I don't think we've clearly established this.  It surprises me that a
> > > Downstream Port would signal PME after turning off power to the slot.
> > > Wouldn't that make PME useless?
> > > 
> > > I'd like to look at this in a little more detail, either by turning
> > > off PM and pciehp and poking things manually with setpci, or possibly
> > > by adding some debug output in the PME ISR and the pciehp ISR and
> > > "write command" paths.
> > 
> > I'm in the To: header of your e-mail but I am not in a position to
> > debug this as I don't have the hardware available.  It would have
> > to be done by Yinghai Lu or Intel.  This may already be clear to
> > everyone involved, so apologies for stating the obvious.
> 
> It is clear; I was just hoping you would make it as easy as possible
> for the folks with the hardware by proposing a debugging patch or a
> series of specific setpci commands to run.
> 
> > Also, I hope it's clear that these Intel servers are not affected
> > by v6 of this patch as it only enables runtime PM on *Thunderbolt*
> > hotplug ports.
> 
> Right.  I just don't understand what's happening, and I don't want
> this to become folk wisdom before we have more details.

If I understand Yinghai Lu's analysis correctly, the port is in D3hot,
we write to config space to enable power on the slot and request a
Command Complete interrupt, the port signals PME to request being
transferred to D0 so that it can deliver the Command Complete interrupt.

So this patch just papers over the issue by disabling PME. :-)

The issue doesn't manifest itself on Thunderbolt controllers because
(a) they don't support power control and (b) they never send Command
Complete interrupts (even though they claim to support it).

Since patch [3/8] of v6 of my series enables runtime PM only on
*Thunderbolt* hotplug ports, the series should be fine as is, however
this isn't really beautiful so if you decide to apply patch [3/8] I'll
come up with a fix, or if you'd rather postpone it I'll rework the patch
to keep the port runtime resumed whenever and for as long as we're waiting
for command completion.  I'll not be able to start working on this until
next week though.  If you do decide to postpone patch [3/8], maybe we
can at least come up with an agreeable version of patch [1/8] to go
into your 4.11 pull.

Thanks,

Lukas
