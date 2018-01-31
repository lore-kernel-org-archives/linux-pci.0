Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:1495 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752534AbeAaHmA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jan 2018 02:42:00 -0500
From: Ryder Lee <ryder.lee@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Frank Rowand <frowand.list@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] of_pci_irq: add a check to fallback to standard device tree parsing
Date: Wed, 31 Jan 2018 15:41:49 +0800
Message-ID: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A root complex usually consist of a host bridge and multiple P2P bridges,
and someone may express that in the form of a root node with many subnodes
and list all four interrupts for each slot (child node) in the root node
like this:

	pcie-controller {
		...
		interrupt-map-mask = <0xf800 0 0 7>;
		interrupt-map = <0x0000 0 0 {INTx} &{interrupt parent} ...>
				 0x0800 0 0 {INTx} &{interrupt parent} ...>;

		pcie@0,0 {
			reg = <0x0000 0 0 0 0>;
			...
		};

		pcie@1,0 {
			reg = <0x0800 0 0 0 0>;
			...
		};
	};

As shown above, we'd like to propagate IRQs from a root port to the devices
in the hierarchy below it in this way.  However, it seems that the current
parser couldn't handle such cases and will get something unexpected below:

	pcieport 0000:00:01.0: assign IRQ: got 213
	igb 0000:01:00.0: assign IRQ: got 212

There is a device which is connected to 2nd slot, but the port doesn't share
the same IRQ with its downstream devices.  The problem here is that, if the
loop found a P2P bridge, it wouldn't check whether the reg property exists
in ppnode or not but just pass the subordinate devfn to of_irq_parse_raw(),
thus the subsequent flow couldn't correctly resolve them.

Fix this by adding a check to fallback to standard device tree parsing.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
Please refer to the previous discussion thread: https://patchwork.ozlabs.org/patch/829108/
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
