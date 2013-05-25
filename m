Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:51075 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab3EYLhF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 May 2013 07:37:05 -0400
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: [PATCH 3/3] PCI: unset the resource if a wrong bus address is assigned by firmware
Date: Sat, 25 May 2013 19:36:27 +0800
Message-ID: <1369481787-21500-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1369481787-21500-1-git-send-email-haokexin@gmail.com>
References: <1369481787-21500-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In some situations, the bus and memory address used by kernel are
not equal and the firmware may assign a bus address which happen
to be a legitimate memory address to a PCI device, then the kernel
would not find a matching bus region in host bridge and assume an
offset of zero and translate it to a memory address the same as the
bus address. This will leave the bus address in the PCI BAR register
unchanged and this address is definitely not a legal bus address,
then cause the device malfunction. We try to detect this by doing
a invert translation. We can make sure that we run into this case
if the value we get from the invert translation is not equal to the
original bus address. In this case we would unset this resource and
wish the kernel would trigger a reassign later.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2:
Instead of tweak the pcibios_bus_to_resource and assume we know
about all the host bridge window, we do an invert translation to
check if we have a wrong bus address set in the PCI BAR register.

 drivers/pci/probe.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c57eb27..33c2e72 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -170,7 +170,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 {
 	u32 l, sz, mask;
 	u16 orig_cmd;
-	struct pci_bus_region region;
+	struct pci_bus_region region, inverted_region;
 	bool bar_too_big = false, bar_disabled = false;
 
 	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
@@ -267,6 +267,29 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 	pcibios_bus_to_resource(dev, res, &region);
 
+	/*
+	 * In some situations, the bus and memory address used by kernel are
+	 * not equal and the firmware may assign a bus address which happen
+	 * to be a legitimate memory address to a PCI device, then the kernel
+	 * would not find a matching bus region in host bridge and assume an
+	 * offset of zero and translate it to a memory address the same as the
+	 * bus address. This will leave the bus address in the PCI BAR register
+	 * unchanged and this address is definitely not a legal bus address,
+	 * then cause the device malfunction. We try to detect this by doing
+	 * a invert translation. We can make sure that we run into this case
+	 * if the value we get from the invert translation is not equal to the
+	 * original bus address.
+	 */
+	pcibios_resource_to_bus(dev, &inverted_region, res);
+	if (inverted_region.start != region.start ||
+		 inverted_region.end != region.end) {
+		dev_info(&dev->dev, "reg 0x%x: bus address [%pa - %pa] allocated by firmware is not in any of the address regions of PCI host bridge, we would force to reassign it later\n",
+			pos, &region.start, &region.end);
+		res->flags |= IORESOURCE_UNSET;
+		res->end -= res->start;
+		res->start = 0;
+	}
+
 	goto out;
 
 
-- 
1.8.1.4

