Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29799 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760371Ab2EVULk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 May 2012 16:11:40 -0400
Date: Tue, 22 May 2012 16:11:38 -0400
From: Jason Baron <jbaron@redhat.com>
Message-Id: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: mst@redhat.com
Subject: [PATCH] pci hotplug: rescan bridge after device hotplug
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm tyring to support bridge hotplug and devices below it in qemu via acpi
hotplug. Currently only 1 level or 32 slots are supported. By allowing for a
second level, we will be able to support 32^2 devices.

If I first hotplug the bridge with no devices intially below it, the hotplug
code sets the bridge memory window to 0 and does not increase it when
subsequent devices are added below it.

Fix this, by calling pci_rescan_bus_bridge_resize(), on the bridge directly
below the root to re-size all the birdge windows that may have changed.

Signed-off-by: Jason Baron <jbaron@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 806c44f..8960c1e 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -792,6 +792,7 @@ static int __ref enable_device(struct acpiphp_slot *slot)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus = slot->bridge->pci_bus;
+	struct pci_bus *rescan_bus;
 	struct acpiphp_func *func;
 	int retval = 0;
 	int num, max, pass;
@@ -821,6 +822,13 @@ static int __ref enable_device(struct acpiphp_slot *slot)
 		}
 	}
 
+	/* Ensure we rescan/setup a bridge for new devs hanging off of it */
+	rescan_bus = bus;
+	while (rescan_bus->parent && rescan_bus->parent->self)
+		rescan_bus = rescan_bus->parent;
+	if (rescan_bus->self)
+		pci_rescan_bus_bridge_resize(rescan_bus->self);
+
 	list_for_each_entry(func, &slot->funcs, sibling)
 		acpiphp_bus_add(func);
 
-- 
1.7.7.6

