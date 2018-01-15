Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:34765 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752308AbeAOLJo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Jan 2018 06:09:44 -0500
Date: Mon, 15 Jan 2018 13:09:40 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Assume NoCompl+ for Thunderbolt ports
Message-ID: <20180115110940.GD27654@lahna.fi.intel.com>
References: <d0ac15a21de9e47157588a96b7d2f407295e358b.1515825290.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d0ac15a21de9e47157588a96b7d2f407295e358b.1515825290.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 13, 2018 at 07:38:39AM +0100, Lukas Wunner wrote:
> Certain Thunderbolt 1 controllers claim to support Command Completed
> events (value of 0b in the No Command Completed Support field of the
> Slot Capabilities register) but in reality neither set the Command
> Completed bit in the Slot Status register nor signal a Command
> Completed interrupt.
> 
> As a result, every call to pcie_write_cmd() takes 2 seconds (1 second
> for each invocation of pcie_wait_cmd()).  pcie_write_cmd() is called on
> ->remove via pcie_disable_notification(), so after such a Thunderbolt
> device is unplugged, 2 seconds elapse until pciehp is unbound:
> 
> [  337.942727] pciehp 0000:0a:00.0:pcie204: Timeout on hotplug command 0x1038 (issued 21176 msec ago)
> [  340.014735] pciehp 0000:0a:00.0:pcie204: Timeout on hotplug command 0x0000 (issued 2072 msec ago)
> 
> That by itself has always been unpleasant, but the situation has become
> worse with commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services
> during shutdown"):  Now pciehp is unbound on ->shutdown.  Because
> Thunderbolt controllers typically have 4 hotplug ports, every reboot and
> shutdown is now delayed by 8 seconds, plus another 2 seconds for every
> attached Thunderbolt 1 device.
> 
> By testing with my own equipment and by googling I was able to ascertain
> that at least the following chips are affected by this erratum:
> 8086:1513  CV82524 Thunderbolt Controller [Light Ridge 4C  2010]
> 8086:1547  DSL3510 Thunderbolt Controller [Cactus Ridge 4C 2012]
> 8086:1549  DSL2210 Thunderbolt Controller [Port Ridge 1C   2011]
> 
> The following newer chips are not affected as they have NoCompl+ in the
> Slot Capabilities register:
> 8086:156d  DSL5520 Thunderbolt 2 Bridge [Falcon Ridge 4C   2013]
> 8086:1578  DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C   2015]
> 
> Thunderbolt hotplug slots are not physical slots that one inserts cards
> into, but rather logical hotplug slots implemented in silicon.  Devices
> appear beyond those logical slots once a PCI tunnel is established on
> top of the Thunderbolt Converged I/O switch.  One would expect that
> commands written to the Slot Control register are executed pretty much
> immediately by the silicon, without requiring a delay, so the NoCompl+
> on newer chips makes sense.  It is unclear whether the older chips
> likewise do not require observing a delay or how long that delay needs
> to be.  There is still no public spec or errata sheet for Thunderbolt
> controllers.
> 
> I checked what macOS does:
> https://opensource.apple.com/source/IOPCIFamily/IOPCIFamily-320.1.1/IOPCIBridge.cpp.auto.html
> 
> They do not enable Command Completed events:
> 	// data link change, hot plug, presence detect change
> 	kSlotControlEnables = ((1 << 12) | (1 << 5) | (1 << 3))
> 
> They also do not call IODelay() or check the Command Completed bit after
> writing to the Slot Control register:
> 	fBridgeDevice->configWrite16( fBridgeDevice->reserved->expressCapability + 0x18, ...);
> 
> Do the same and assume NoCompl+ for any Thunderbolt hotplug port.
> 
> I've stress-tested this by alternatingly binding and unbinding pciehp to
> a Port Ridge hotplug bridge in an endless loop for a few minutes (by
> enabling/disabling slot power via sysfs), which causes rapid writes to
> the Slot Control register.  pciehp never missed a beat.
> 
> Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

We asked from the hardware people and indeed in the legacy controllers
before RR this bit was incorrectly set to 0.

I also tested on Macbook with Cactus Ridge (1st generation controller)
and without the patch I see command timeouts and reboot takes that ~8
seconds. With this patch applied reboot works immediately.

Feel free to add my,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
