Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:63781 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756402AbbHZLIB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Aug 2015 07:08:01 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <jingoohan1@gmail.com>, <wangzhou1@hisilicon.com>,
	<pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <qiuzhenfa@hisilicon.com>,
	<zhangjukuo@huawei.com>, <liudongdong3@huawei.com>,
	<liguozhu@hisilicon.com>, <qiujiang@huawei.com>,
	gabriele paoloni <gabriele.paoloni@huawei.com>
Subject: [PATCH] PCI: Designware: Move num-lanes property read to dw_pcie_setup_rc
Date: Wed, 26 Aug 2015 19:14:16 +0800
Message-ID: <1440587656-84224-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

Currently num-lanes is read in dw_pcie_host_init().
for A SoC that performs the link-up operation in UEFI num-lanes
is not needed in the DTS but it has to be specified to any value;
otherwise dw_pcie_host_init will fail.
This patch moves the num-lanes property read in dw_pcie_setup_rc()
as num-lanes is only used there and, if the link is already up,
the PCIe controller driver can decide either to leave host_init
NULL or to return straightforward without proceeding to call
dw_pcie_setup_rc().

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/pci/host/pcie-designware.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be..7d707b7 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -483,11 +483,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	if (of_property_read_u32(np, "num-lanes", &pp->lanes)) {
-		dev_err(pp->dev, "Failed to parse the number of lanes\n");
-		return -EINVAL;
-	}
-
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		if (!pp->ops->msi_host_init) {
 			pp->irq_domain = irq_domain_add_linear(pp->dev->of_node,
@@ -742,7 +737,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	u32 val;
 	u32 membase;
 	u32 memlimit;
+	struct device_node *np = pp->dev->of_node;
 
+	if (of_property_read_u32(np, "num-lanes", &pp->lanes)) {
+		dev_err(pp->dev, "Failed to parse the number of lanes\n");
+		return;
+	}
 	/* set the number of lanes */
 	dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL, &val);
 	val &= ~PORT_LINK_MODE_MASK;
-- 
1.9.1

