Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Thu, 26 May 2016 13:25:20 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Peter Wu <peter@lekensteyn.nl>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH] PCI: Wait for 50ms after bridge is powered up
Message-ID: <20160526102520.GV1789@lahna.fi.intel.com>
References: <20160524162833.GA30762@localhost>
 <1464188696-25782-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160526101006.GA6744@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160526101006.GA6744@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 26, 2016 at 12:10:06PM +0200, Lukas Wunner wrote:
> Hi,
> 
> On Wed, May 25, 2016 at 06:04:56PM +0300, Mika Westerberg wrote:
> > The PCI PM 1.2 specification requires minimum of 50ms before function on a
> > bus is accessed after the bus is transitioned from B2 to B0. Now that we
> > actually power down bridges we should make sure the specification is
> > followed accordingly.
> 
> This patch has the unfortunate side effect of increasing boot time on
> Macs with Thunderbolt by 320 ms. Granted, it's not much, but still
> noticeable:

Yes, that's the drawback.

> [    2.358041] pcieport 0000:06:03.0: enabling device (0000 -> 0002)
> [    2.358195] pcieport 0000:06:03.0: rpm_idle
> [    2.358222] pcieport 0000:06:03.0: rpm_suspend
> [    2.411664] pcieport 0000:06:04.0: enabling device (0000 -> 0003)
> [    2.411821] pcieport 0000:06:04.0: rpm_idle
> [    2.411848] pcieport 0000:06:04.0: rpm_suspend
> [    2.467664] pcieport 0000:06:05.0: enabling device (0000 -> 0003)
> [    2.467817] pcieport 0000:06:05.0: rpm_idle
> [    2.467843] pcieport 0000:06:05.0: rpm_suspend
> [    2.523664] pcieport 0000:06:06.0: enabling device (0000 -> 0002)
> [    2.523822] pcieport 0000:06:06.0: rpm_idle
> [    2.523848] pcieport 0000:06:06.0: rpm_suspend
> [    2.579685] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    2.579722] pcieport 0000:06:03.0: rpm_resume
> [    2.635750] pciehp 0000:06:03.0:pcie204: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> [    2.635853] pciehp 0000:06:03.0:pcie204: service driver pciehp loaded
> [    2.635858] pcieport 0000:06:03.0: rpm_idle
> [    2.635886] pcieport 0000:06:04.0: rpm_resume
> [    2.647645] pcieport 0000:06:03.0: rpm_suspend
> [    2.691747] pciehp 0000:06:04.0:pcie204: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> [    2.691856] pciehp 0000:06:04.0:pcie204: service driver pciehp loaded
> [    2.691859] pcieport 0000:06:04.0: rpm_idle
> [    2.691888] pcieport 0000:06:05.0: rpm_resume
> [    2.703649] pcieport 0000:06:04.0: rpm_suspend
> [    2.747748] pciehp 0000:06:05.0:pcie204: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> [    2.747842] pciehp 0000:06:05.0:pcie204: service driver pciehp loaded
> [    2.747845] pcieport 0000:06:06.0: rpm_resume
> [    2.749213] pcieport 0000:06:05.0: rpm_idle
> [    2.759650] pcieport 0000:06:05.0: rpm_suspend
> [    2.805049] pciehp 0000:06:06.0:pcie204: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> [    2.806464] pciehp 0000:06:06.0:pcie204: service driver pciehp loaded
> [    2.806471] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> [    2.807876] intel_idle: MWAIT substates: 0x21120
> [    2.807878] intel_idle: v0.4.1 model 0x3A
> [    2.808170] intel_idle: lapic_timer_reliable_states 0xffffffff
> [    2.808201] GHES: HEST is not enabled!
> [    2.809613] pcieport 0000:06:06.0: rpm_idle
> [    2.809644] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    2.810096] Linux agpgart interface v0.103
> [    2.810158] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
> [    2.810158] AMD IOMMUv2 functionality not available on this system
> [    2.816468] pcieport 0000:06:06.0: rpm_suspend
> 
> I've added debug messages whenever ->runtime_idle / _suspend / _resume
> is called for a device.
> 
> As can be seen, the PCI core now waits 50 ms after ->runtime_suspend.
> Also, the ports are resumed when the pciehp service driver is loaded,
> adding another 50 ms delay. For four hotplug ports, that's a total of
> 400 ms (versus 80 ms without the patch).
> 
> I'm wondering if the delay after ->runtime_suspend is really needed. Is
> this mandated by the spec? We could perhaps increase the autosuspend_delay
> in pcie_portdrv_probe() slightly to prevent the port from going to sleep
> between pci_enable_device() and loading the pciehp service driver.

The PCI PM specification version 1.2 says this in chapter 4.2 (page 37):

  There is a minimum time requirement of 50 ms which must be provided by
  system software between when the bus is switched from B2 to B0 and
  when a function on the bus is accessed to allow time for the clock to
  start up and the bus to settle.

Not sure how much of that still applies to modern hardware.

I don't see why we cannot increase autosuspend delay time, though.
