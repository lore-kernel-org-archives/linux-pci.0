Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:30783 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab2FWHmI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jun 2012 03:42:08 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 4/5] PCI, acpiphp: add is_hotplug_bridge detection
Date: Sat, 23 Jun 2012 00:42:04 -0700
Message-Id: <1340437325-29282-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When system support hotplug bridge with children hotplug slots, we need to make sure
that parent bridge get preallocated resource so later when device is plugged into
children slot, those children devices will get resource allocated.

We do not meet this problem, because for pcie hotplug card, when acpiphp is used,
pci_scan_bridge will set that for us when detect hotplug bit in slot cap.

Reported-and-tested-by: Jason Baron <jbaron@redhat.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Acked-by: Jason Baron <jbaron@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index ad6fd66..0f2b72d 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -783,6 +783,29 @@ static void acpiphp_set_acpi_region(struct acpiphp_slot *slot)
 	}
 }
 
+static void check_hotplug_bridge(struct acpiphp_slot *slot, struct pci_dev *dev)
+{
+	struct acpiphp_func *func;
+
+	if (!dev->subordinate)
+		return;
+
+	/* quirk, or pcie could set it already */
+	if (dev->is_hotplug_bridge)
+		return;
+
+	if (PCI_SLOT(dev->devfn) != slot->device)
+		return;
+
+	list_for_each_entry(func, &slot->funcs, sibling) {
+		if (PCI_FUNC(dev->devfn) == func->function) {
+			/* check if this bridge has ejectable slots */
+			if ((detect_ejectable_slots(func->handle) > 0))
+				dev->is_hotplug_bridge = 1;
+			break;
+		}
+	}
+}
 /**
  * enable_device - enable, configure a slot
  * @slot: slot to be enabled
@@ -817,8 +840,10 @@ static int __ref enable_device(struct acpiphp_slot *slot)
 			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
 			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
 				max = pci_scan_bridge(bus, dev, max, pass);
-				if (pass && dev->subordinate)
+				if (pass && dev->subordinate) {
+					check_hotplug_bridge(slot, dev);
 					pci_bus_size_bridges(dev->subordinate);
+				}
 			}
 		}
 	}
-- 
1.7.7

