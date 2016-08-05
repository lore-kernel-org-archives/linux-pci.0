Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 07/13] PCI: pciehp: Ignore interrupts during D3cold
Date: Fri, 05 Aug 2016 02:29:33 +0200
Message-ID: <2207683.SCJbZF619B@vostro.rjw.lan>
In-Reply-To: <20160802162740.GA4036@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de> <20160617225204.GC10416@localhost> <20160802162740.GA4036@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, August 02, 2016 06:27:40 PM Lukas Wunner wrote:
> On Fri, Jun 17, 2016 at 05:52:04PM -0500, Bjorn Helgaas wrote:
> > On Fri, May 13, 2016 at 01:15:31PM +0200, Lukas Wunner wrote:
> > > If a hotplug port is suspended to D3cold, its slot status register
> > > cannot be read.  If that hotplug port happens to share its IRQ with
> > > other devices, then whenever an interrupt occurs for one of these
> > > devices, a "no response from device" message is logged with level
> > > KERN_INFO.  Apart from this annoyance, CPU time is needlessly spent
> > > trying to read the slot status register even though we know in advance
> > > that it will fail.
> > 
> > I guess this is a pretty generic problem that could affect any device
> > that shares an IRQ.
> > 
> > I think I'll queue this on my pci/pm branch, since it seems closely
> > related to Mika's "PCI: Add runtime PM support for PCIe ports".
> > 
> > Did you check for the same issue in other likely places, e.g., AER,
> > PME, etc.?
> 
> Apologies for the delay, I've checked all other port services now:
> 
> - Our AER and PME drivers bind only to root ports and I can't imagine
>   how those could go to D3cold, they're part of the root complex or
>   PCH and I'm not aware of a chipset that would allow turning off the
>   power well for individual PCIe ports.

No, they don't go into D3cold.  They can go into D3hot, however.

> - DPC on the other hand also binds to downstream ports. I do have
>   downstream ports in my machine (as part of the Thunderbolt switch)
>   but they do not have the DPC capability. I've never seen devices
>   with that capability and cannot estimate what the chances are of them
>   going to D3cold and sharing an IRQ with other devices. It's probably
>   not worth preparing for such a situation without knowing its likelihood.
> 
> - VC: We allocate a port service for this but do not have a driver.
> 
> Bottom line is that the patch for the PCIe hotplug driver seems to be
> sufficient.
> 
> FWIW, on my machine I see numerous devices with AER, PME and VC
> capabilities. The Nvidia GPU as well as network, Firewire and
> Thunderbolt controllers all have those. AFAICS we ignore them
> because their specific drivers do not care for the capabilities
> and portdrv only binds to root ports.
> 
> This seems to support your argument that the PCIe capabilities
> should be handled by the core rather than portdrv, as we could
> then make use of the capabilities on endpoint devices in a
> universal manner.

PME, for one, is not an endpoint capability.  It very specifically is
defined as a port capability AFAICS, and the whole idea here is that
endpoints will not use their in-band interrupts to signal PME.  That
is supposed to be done by ports.

> On the other hand, I think we cannot use a separate MSI for
> AER, PME et al, can we?

We can, at least in principle.

More precisely, the spec requires PME and hotplug to use the same interrupt
(please see the comment in pcie_port_enable_msix() on that), but AER can use
a different one.

> If we cannot, then AER and PME would
> share the IRQ with an endpoint device's regular interrupt handler,
> and that might ruin performance. E.g. the Broadcom wireless card
> generates millions of interrupts on a sufficiently active WiFi.
> Accessing the device's config space on every interrupt just to
> check for AER or PME seems like a bad idea. So at the very least
> we'd need some kind of opt-out.

That is why AER, PME and hotplug are all supposed to be signaled by ports,
possibly among other things.

Thanks,
Rafael
