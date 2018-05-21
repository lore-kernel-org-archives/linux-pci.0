Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40529 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753972AbeEUWFS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 May 2018 18:05:18 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH][RFC] PCI: rcar: Add bus notifier so we can limit the DMA range
Date: Tue, 22 May 2018 00:05:14 +0200
Message-Id: <20180521220514.30256-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Phil Edworthy <phil.edworthy@renesas.com>

The PCIe DMA controller on RCar Gen2 and earlier is on 32bit bus,
so limit the DMA range to 32bit.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
NOTE: I'm aware of https://patchwork.kernel.org/patch/9495895/ , but the
      discussion seems to have gone way off, so I'm sending this as a
      RFC. Any feedback on how to do this limiting properly would be nice.
---
 drivers/pci/host/pcie-rcar.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index c3eab0b95290..db2b16f40bc1 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1325,3 +1325,31 @@ static struct platform_driver rcar_pcie_driver = {
 	.probe = rcar_pcie_probe,
 };
 builtin_platform_driver(rcar_pcie_driver);
+
+static int rcar_pcie_pci_notifier(struct notifier_block *nb,
+			    unsigned long action, void *data)
+{
+	struct device *dev = data;
+
+	switch (action) {
+	case BUS_NOTIFY_BOUND_DRIVER:
+		/* Force the DMA mask to lower 32-bits */
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block device_nb = {
+	.notifier_call = rcar_pcie_pci_notifier,
+};
+
+static int __init register_rcar_pcie_pci_notifier(void)
+{
+	return bus_register_notifier(&pci_bus_type, &device_nb);
+}
+
+arch_initcall(register_rcar_pcie_pci_notifier);
-- 
2.16.2
