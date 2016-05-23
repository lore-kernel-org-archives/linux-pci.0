Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44523 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028AbcEWIUw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 May 2016 04:20:52 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Peter Wu <peter@lekensteyn.nl>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] PCI: Power on bridges before scanning new devices
Date: Mon, 23 May 2016 11:20:48 +0300
Message-Id: <1463991648-85051-1-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <20160519231234.GB1785@al>
References: <20160519231234.GB1785@al>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a PCI device is removed through sysfs interface the upstream bridge
(PCIe port) can be runtime suspended if it was the last device on that bus.
Now, if the bridge is in D3 we cannot find devices below the bridge
anymore. For example following fails to find the removed device again:

   # echo 1 > /sys/bus/pci/devices/0000:00:01.0/0000:01:00.0/remove
   # echo 1 > /sys/bus/pci/devices/0000:00:01.0/rescan

Where 0000:00:01.0 is the bridge device.

In order to be able to rescan devices below the bridge add
pm_runtime_get_sync()/pm_runtime_put() calls to pci_scan_bridge(). This
should keep bridges powered on while their children devices are being
scanned.

Reported-by: Peter Wu <peter@lekensteyn.nl>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/probe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

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
-- 
2.8.1

