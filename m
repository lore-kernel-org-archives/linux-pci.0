Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:3799 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932170AbeAJIEk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jan 2018 03:04:40 -0500
From: Ryder Lee <ryder.lee@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [RFC PATCH] of_pci_irq: add a check to fallback to device tree parsing
Date: Wed, 10 Jan 2018 16:04:28 +0800
Message-ID: <3fcf63d1ac22f1ed5f53cc16cd2d06a849684e08.1515570774.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A root complex normally consist of a host/PCI bridge and multiple P2P bridges.

It will get mismatched results if we implement the bindings in the form of
a root node with multiple subnodes (P2P bridge) and list all interrupt-map
properties for each slot in the parent - It maens that we want to propagate
IRQs from a root port to the devices in the hierarchy below it.

If we have a PCIe device which is connected to slot 1, and will get something
like this:
pcieport 0000:00:01.0: assign IRQ: got 213
	--> igb 0000:01:00.0: assign IRQ: got 212

The reason is that we use the subordinate 'devfn' but didn't obtain the actual
slot numbers from device tree, this patch add a check to fallback to use device
tree parsing if needed.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
Discussion thread: https://patchwork.ozlabs.org/patch/829108/
---
 drivers/of/of_pci_irq.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
index 3a05568..e445866 100644
--- a/drivers/of/of_pci_irq.c
+++ b/drivers/of/of_pci_irq.c
@@ -86,8 +86,18 @@ int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq
 	out_irq->np = ppnode;
 	out_irq->args_count = 1;
 	out_irq->args[0] = pin;
-	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
-	laddr[1] = laddr[2] = cpu_to_be32(0);
+
+	if (!dn && ppnode) {
+		const __be32 *addr;
+
+		addr = of_get_property(ppnode, "reg", NULL);
+		if (addr)
+			memcpy(laddr, addr, 3);
+	} else {
+		laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
+		laddr[1] = laddr[2] = cpu_to_be32(0);
+	}
+
 	rc = of_irq_parse_raw(laddr, out_irq);
 	if (rc)
 		goto err;
-- 
1.9.1
