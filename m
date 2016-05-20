Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:51430 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932667AbcETIqR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 May 2016 04:46:17 -0400
Date: Fri, 20 May 2016 10:45:31 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: Rescanning is broken with runtime PM for PCIe ports
Message-ID: <20160519231234.GB1785@al>
References: <20160518171401.GC1222@al>
 <20160519074231.GJ2043@lahna.fi.intel.com>
 <20160519113630.GT2043@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160519113630.GT2043@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 19, 2016 at 02:36:30PM +0300, Mika Westerberg wrote:
> On Thu, May 19, 2016 at 10:42:31AM +0300, Mika Westerberg wrote:
> > On Wed, May 18, 2016 at 07:14:01PM +0200, Peter Wu wrote:
> > > Hi,
> > > 
> > > While testing the pci/pm tree from Bjorn with HEAD being 0195d2813547
> > > ("PCI: Add runtime PM support for PCIe ports"), I have noticed that
> > > detaching and rescanning is broken.
> > > 
> > > When a bridgr is in D3 state, it cannot discover children. Reproducer:
> > > 
> > >     echo > /sys/bus/pci/devices/0000:01:00.0/remove 1
> > >     # wait for the PCIe port to enter D3cold
> > >     echo > /sys/bus/pci/devices/0000:00:01.0/rescan 1
> > >     # Workaround to get the device back
> > >     echo > /sys/bus/pci/devices/0000:00:01.0/power/control on
> > >     echo > /sys/bus/pci/devices/0000:00:01.0/rescan 1
> > > 
> > > lspci:
> > > 
> > >     00:01.0 PCI bridge [0604]: Intel Corporation Skylake PCIe Controller (x16) [8086:1901] (rev 07)
> > >     01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GM204M [GeForce GTX 965M] [10de:13d9] (rev a1)
> > > 
> > > Probably needs a pm_runtime_{get,put}_sync in pci_rescan_bus and
> > > pci_rescan_bus_bridge_resize.
> > 
> > Thanks for reporting. Let me investigate this a bit.
> 
> I think it is enough if we make sure the bridge is powered when it is
> being scanned. Can you try if the below patch works for you?
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8004f67c57ec..15e77c92311e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -16,6 +16,7 @@
>  #include <linux/aer.h>
>  #include <linux/acpi.h>
>  #include <linux/irqdomain.h>
> +#include <linux/pm_runtime.h>
>  #include "pci.h"
>  
>  #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
> @@ -832,6 +833,12 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
>  	u8 primary, secondary, subordinate;
>  	int broken = 0;
>  
> +	/*
> +	 * Make sure the bridge is powered on to be able to access config
> +	 * space of devices below it.
> +	 */
> +	pm_runtime_get_sync(&dev->dev);
> +
>  	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
>  	primary = buses & 0xFF;
>  	secondary = (buses >> 8) & 0xFF;
> @@ -1012,6 +1019,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
>  out:
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>  
> +	pm_runtime_put(&dev->dev);
> +
>  	return max;
>  }
>  EXPORT_SYMBOL(pci_scan_bridge);

Works for me on top of v4.6-rc7-216-g021351f.

May 20 01:08:27.340318 localhost kernel: pci 0000:01:00.0: PME# disabled
May 20 01:08:27.340589 localhost kernel: vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=none,decodes=io+mem:owns=io+mem
May 20 01:08:27.340755 localhost kernel: pcieport 0000:00:01.0: PME# enabled
May 20 01:08:27.388476 localhost kernel: pcieport 0000:00:01.0: power state changed by ACPI to D3cold
May 20 01:08:35.884288 localhost kernel: pci_bus 0000:00: scanning bus
May 20 01:08:36.033274 localhost kernel: pcieport 0000:00:01.0: power state changed by ACPI to D0
May 20 01:08:36.135063 localhost kernel: pcieport 0000:00:01.0: PME# disabled
May 20 01:08:36.136529 localhost kernel: pcieport 0000:00:01.0: scanning [bus 01-01] behind bridge, pass 0
May 20 01:08:36.136641 localhost kernel: pci_bus 0000:01: scanning bus
May 20 01:08:36.138618 localhost kernel: pci 0000:01:00.0: [10de:13d9] type 00 class 0x030000
May 20 01:08:36.138661 localhost kernel: pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00ffffff]
May 20 01:08:36.138693 localhost kernel: pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x0fffffff 64bit pref]
May 20 01:08:36.139226 localhost kernel: pci 0000:01:00.0: reg 0x1c: [mem 0x00000000-0x01ffffff 64bit pref]
May 20 01:08:36.140360 localhost kernel: pci 0000:01:00.0: reg 0x24: [io  0x0000-0x007f]
May 20 01:08:36.140384 localhost kernel: pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
May 20 01:08:36.141517 localhost kernel: pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
May 20 01:08:36.152493 localhost kernel: pci 0000:01:00.0: System wakeup disabled by ACPI
May 20 01:08:36.153654 localhost kernel: vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=none,locks=none
May 20 01:08:36.153681 localhost kernel: vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=none:owns=io+mem
May 20 01:08:36.157541 localhost kernel: pci_bus 0000:01: bus scan returning with max=01
May 20 01:08:36.157646 localhost kernel: pcieport 0000:00:1c.0: scanning [bus 02-02] behind bridge, pass 0
May 20 01:08:36.157730 localhost kernel: pci_bus 0000:02: scanning bus
May 20 01:08:36.158865 localhost kernel: pci_bus 0000:02: bus scan returning with max=02
May 20 01:08:36.158964 localhost kernel: pcieport 0000:00:1c.5: scanning [bus 03-03] behind bridge, pass 0
May 20 01:08:36.159567 localhost kernel: pci_bus 0000:03: scanning bus
May 20 01:08:36.160807 localhost kernel: pci_bus 0000:03: bus scan returning with max=03
May 20 01:08:36.160901 localhost kernel: pcieport 0000:00:01.0: scanning [bus 01-01] behind bridge, pass 1
May 20 01:08:36.161527 localhost kernel: pcieport 0000:00:1c.0: scanning [bus 02-02] behind bridge, pass 1
May 20 01:08:36.162753 localhost kernel: pcieport 0000:00:1c.5: scanning [bus 03-03] behind bridge, pass 1
May 20 01:08:36.162832 localhost kernel: pci_bus 0000:00: bus scan returning with max=03
May 20 01:08:36.164654 localhost kernel: pci 0000:01:00.0: BAR 1: assigned [mem 0xc0000000-0xcfffffff 64bit pref]
May 20 01:08:36.164762 localhost kernel: pci 0000:01:00.0: BAR 3: assigned [mem 0xd0000000-0xd1ffffff 64bit pref]
May 20 01:08:36.164847 localhost kernel: pci 0000:01:00.0: BAR 0: assigned [mem 0xde000000-0xdeffffff]
May 20 01:08:36.165284 localhost kernel: pci 0000:01:00.0: BAR 6: assigned [mem 0xdf000000-0xdf07ffff pref]
May 20 01:08:36.166515 localhost kernel: pci 0000:01:00.0: BAR 5: assigned [io  0xe000-0xe07f]
May 20 01:08:36.166612 localhost kernel: pci 0000:01:00.0: calling nv_msi_ht_cap_quirk_leaf+0x0/0x20
May 20 01:08:36.167799 localhost kernel: pci 0000:01:00.0: calling pci_fixup_video+0x0/0x100
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
