Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:37155 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPT0Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:26:24 -0400
Message-Id: <3cfa5672468ed406e6e00937eef1b5cff8b0cdb5.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 04/32] PCI: pciehp: Fix unprotected list iteration in IRQ
 handler
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit b440bde74f04 ("PCI: Add pci_ignore_hotplug() to ignore hotplug
events for a device") iterates over the devices on a hotplug port's
subordinate bus in pciehp's IRQ handler without acquiring pci_bus_sem.
It is thus possible for a user to cause a crash by concurrently
manipulating the device list, e.g. by disabling slot power via sysfs
on a different CPU or by initiating a remove/rescan via sysfs.

This can't be fixed by acquiring pci_bus_sem because it may sleep.
The simplest fix is to avoid the list iteration altogether and just
check the ignore_hotplug flag on the port itself.  This works because
pci_ignore_hotplug() sets the flag both on the device as well as on its
parent bridge.

We do lose the ability to print the name of the device blocking hotplug
in the debug message, but that's probably bearable.

Fixes: b440bde74f04 ("PCI: Add pci_ignore_hotplug() to ignore hotplug events for a device")
Cc: stable@vger.kernel.org
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 26b85440053e..044087e2683d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -539,8 +539,6 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 {
 	struct controller *ctrl = (struct controller *)dev_id;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	struct pci_bus *subordinate = pdev->subordinate;
-	struct pci_dev *dev;
 	struct slot *slot = ctrl->slot;
 	u16 status, events;
 	u8 present;
@@ -588,14 +586,9 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		wake_up(&ctrl->queue);
 	}
 
-	if (subordinate) {
-		list_for_each_entry(dev, &subordinate->devices, bus_list) {
-			if (dev->ignore_hotplug) {
-				ctrl_dbg(ctrl, "ignoring hotplug event %#06x (%s requested no hotplug)\n",
-					 events, pci_name(dev));
-				return IRQ_HANDLED;
-			}
-		}
+	if (pdev->ignore_hotplug) {
+		ctrl_dbg(ctrl, "ignoring hotplug event %#06x\n", events);
+		return IRQ_HANDLED;
 	}
 
 	/* Check Attention Button Pressed */
-- 
2.17.1
