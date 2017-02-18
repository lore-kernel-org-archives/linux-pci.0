Return-Path: <SRS0=djuk=Z7=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=djuk=Z7=wunner.de=lukas@kernel.org>
Date: Sat, 18 Feb 2017 10:25:16 +0100
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
Message-ID: <20170218092516.GB1335@wunner.de>
References: <cover.1486913733.git.lukas@wunner.de>
 <14ffd1ceeb76200b34e0abfebab134545e504bdc.1486913733.git.lukas@wunner.de>
 <20170214225926.GB19040@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170214225926.GB19040@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 14, 2017 at 04:59:26PM -0600, Bjorn Helgaas wrote:
> On Sun, Feb 12, 2017 at 05:07:45PM +0100, Lukas Wunner wrote:
> > Commit 68db9bc81436 ("PCI: pciehp: Add runtime PM support for PCIe
> > hotplug ports") extended runtime PM for PCIe ports to hotplug ports.
> > However Yinghai Lu reported the following breakage caused by the commit:
> > 
> > * After disabling a slot on one of his servers, the slot signals PME
> >   which causes pciehp to immediately re-enable the card, thus defeating
> >   manual slot control via sysfs.
> 
> I don't think we've clearly established this.  It surprises me that a
> Downstream Port would signal PME after turning off power to the slot.
> Wouldn't that make PME useless?
> 
> I'd like to look at this in a little more detail, either by turning
> off PM and pciehp and poking things manually with setpci, or possibly
> by adding some debug output in the PME ISR and the pciehp ISR and
> "write command" paths.

I'm in the To: header of your e-mail but I am not in a position to
debug this as I don't have the hardware available.  It would have
to be done by Yinghai Lu or Intel.  This may already be clear to
everyone involved, so apologies for stating the obvious.

Also, I hope it's clear that these Intel servers are not affected
by v6 of this patch as it only enables runtime PM on *Thunderbolt*
hotplug ports.


> > * On another server which has a Power Controller for PCIe hotplug ports
> >   (PCIe r3.1, sec 6.7.1.8), the slot cannot be re-enabled after manually
> >   disabling it via sysfs since commit 68db9bc81436 acquired a runtime
> >   ref only *after* enabling power on the slot, yet this particular
> >   SkyLake server requires that the port is in D0 when enabling power.
> 
> So this server requires that the Downstream Port must be in D0 before
> we turn on power to the slot below the Downstream Port?

Apparently.


> That seems like it would be a requirement for *all* systems.

Well, it's not mandated by the spec but indeed seems like a good idea.
Please note that the present patch does exactly that.


> If the bridge is
> not in D0, we can't generate any PCI transactions on the secondary bus
> (PCI PM r1.1., Table 19), so we can't enumerate anything in the slot.

Turning on slot power has nothing to do with accessing the secondary bus.
v5 of this patch resumed the hotplug port to D0 when accessing the
secondary bus. On top of that, v6 resumes it to D0 when turning on
slot power.

Thanks,

Lukas
