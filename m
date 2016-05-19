Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:35260 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492AbcESLge (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 19 May 2016 07:36:34 -0400
Date: Thu, 19 May 2016 14:36:30 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Peter Wu <peter@lekensteyn.nl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: Rescanning is broken with runtime PM for PCIe ports
Message-ID: <20160519113630.GT2043@lahna.fi.intel.com>
References: <20160518171401.GC1222@al>
 <20160519074231.GJ2043@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160519074231.GJ2043@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 19, 2016 at 10:42:31AM +0300, Mika Westerberg wrote:
> On Wed, May 18, 2016 at 07:14:01PM +0200, Peter Wu wrote:
> > Hi,
> > 
> > While testing the pci/pm tree from Bjorn with HEAD being 0195d2813547
> > ("PCI: Add runtime PM support for PCIe ports"), I have noticed that
> > detaching and rescanning is broken.
> > 
> > When a bridgr is in D3 state, it cannot discover children. Reproducer:
> > 
> >     echo > /sys/bus/pci/devices/0000:01:00.0/remove 1
> >     # wait for the PCIe port to enter D3cold
> >     echo > /sys/bus/pci/devices/0000:00:01.0/rescan 1
> >     # Workaround to get the device back
> >     echo > /sys/bus/pci/devices/0000:00:01.0/power/control on
> >     echo > /sys/bus/pci/devices/0000:00:01.0/rescan 1
> > 
> > lspci:
> > 
> >     00:01.0 PCI bridge [0604]: Intel Corporation Skylake PCIe Controller (x16) [8086:1901] (rev 07)
> >     01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GM204M [GeForce GTX 965M] [10de:13d9] (rev a1)
> > 
> > Probably needs a pm_runtime_{get,put}_sync in pci_rescan_bus and
> > pci_rescan_bus_bridge_resize.
> 
> Thanks for reporting. Let me investigate this a bit.

I think it is enough if we make sure the bridge is powered when it is
being scanned. Can you try if the below patch works for you?

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8004f67c57ec..15e77c92311e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -16,6 +16,7 @@
 #include <linux/aer.h>
 #include <linux/acpi.h>
 #include <linux/irqdomain.h>
+#include <linux/pm_runtime.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -832,6 +833,12 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 	u8 primary, secondary, subordinate;
 	int broken = 0;
 
+	/*
+	 * Make sure the bridge is powered on to be able to access config
+	 * space of devices below it.
+	 */
+	pm_runtime_get_sync(&dev->dev);
+
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
 	primary = buses & 0xFF;
 	secondary = (buses >> 8) & 0xFF;
@@ -1012,6 +1019,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 out:
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
 
+	pm_runtime_put(&dev->dev);
+
 	return max;
 }
 EXPORT_SYMBOL(pci_scan_bridge);
