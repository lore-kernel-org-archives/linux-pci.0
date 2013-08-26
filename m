Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:51364 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579Ab3HZIeE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2013 04:34:04 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>
Subject: [PATCH v9 2/2] PCI: Print warning message if unsafe mps detected
Date: Mon, 26 Aug 2013 16:33:06 +0800
Message-ID: <1377505986-7484-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1377505986-7484-1-git-send-email-wangyijing@huawei.com>
References: <1377505986-7484-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some broken BIOS configures incorrect mps for devices,
eg. bridge mps larger than connected Endpoint device mps.
So TLP packets maybe discarded by Endpoint device.
These devices may not work normally. Joe Jin reported
these problems, reference:
http://lkml.kernel.org/r/4FFA9B96.6040901@oracle.com
http://lkml.kernel.org/r/509B5038.8090304@oracle.com
For easy detect this issue, try to detect the unsafe mps
(unequal mps between device and its bridge device)
setting. If unsafe mps setting found, print warning message.

Reported-by: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>
---
 drivers/pci/probe.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 21ca9a1..e442744 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1587,6 +1587,23 @@ static void pcie_write_mrrs(struct pci_dev *dev)
 			"with pci=pcie_bus_safe.\n");
 }
 
+static void pcie_bus_detect_mps(struct pci_dev *dev)
+{
+	int mps, p_mps;
+
+	if (!dev->bus->self)
+		return;
+
+	mps = pcie_get_mps(dev);
+	p_mps = pcie_get_mps(dev->bus->self);
+
+	if (mps != p_mps)
+		dev_warn(&dev->dev, "Non-optimal MPS value of %d being used. "
+			"If problems are experienced, try running with "
+			"pci=pcie_bus_safe.\n", mps);
+	return;
+}
+
 static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 {
 	int mps, orig_mps;
@@ -1594,6 +1611,11 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 	if (!pci_is_pcie(dev))
 		return 0;
 
+	if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
+		pcie_bus_detect_mps(dev);
+		return 0;
+	}
+
 	mps = 128 << *(u8 *)data;
 	orig_mps = pcie_get_mps(dev);
 
@@ -1621,9 +1643,6 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
 	if (!pci_is_pcie(bus->self))
 		return;
 
-	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
-		return;
-
 	/* FIXME - Peer to peer DMA is possible, though the endpoint would need
 	 * to be aware of the MPS of the destination.  To work around this,
 	 * simply force the MPS of the entire system to the smallest possible.
-- 
1.7.1


