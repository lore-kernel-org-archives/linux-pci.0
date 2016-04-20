Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:33318 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbcDTOmH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2016 10:42:07 -0400
Message-Id: <158b8ef6bf71ae69ef54871e4762b98deb981d6e.1461162854.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 20 Apr 2016 16:44:27 +0200
Subject: [PATCH v2 1/2] PCI: Fix BUG on device attach failure
To: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously when pci_bus_add_device() called device_attach() and it
returned a negative value, we emitted a WARN but carried on.

Commit ab1a187bba5c ("PCI: Check device_attach() return value always"),
introduced in Linux 4.6-rc1, changed this to unwind all steps preceding
device_attach() and to not set dev->is_added = 1.

The latter leads to a BUG if pci_bus_add_device() was called from
pci_bus_add_devices(). Fix by not recursing to a child bus if
device_attach() failed for the bridge leading to it.

This can be triggered by plugging in a PCI device (e.g. Thunderbolt)
while the system is asleep. The system locks up when woken because
device_attach() returns -EPROBE_DEFER.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
v2: Split commit in two (Bjorn Helgaas).

 drivers/pci/bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 6c9f546..23a39fd 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -324,7 +324,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 	}
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		BUG_ON(!dev->is_added);
+		/* Skip if device attach failed */
+		if (!dev->is_added)
+			continue;
 		child = dev->subordinate;
 		if (child)
 			pci_bus_add_devices(child);
-- 
2.8.0.rc3

