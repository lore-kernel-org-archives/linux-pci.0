Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [207.46.163.144] ([207.46.163.144]:33026 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753702AbaD2NAY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Apr 2014 09:00:24 -0400
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <thomas.petazzoni@free-electrons.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<jg1.han@samsung.com>, Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v3] pci: pci-mvebu: Use '%pa' for printing 'phys_addr_t' type
Date: Tue, 29 Apr 2014 09:58:07 -0300
Message-ID: <1398776287-14229-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix the following build warning that happens when building multi_v7_defconfig
with CONFIG_ARM_LPAE=y:

drivers/pci/host/pci-mvebu.c:334:5: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'phys_addr_t' [-Wformat=]

Fix the warning by using '%pa' to printing 'phys_addr_t' type. While at it,
also use the more standard notation [mem 0x - 0x] for memory region.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Introduce variable 'end' for printing the memory range

Changes since v1:
- use the [mem 0x - 0x] notation

 drivers/pci/host/pci-mvebu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index e384e25..8329592 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -329,9 +329,11 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
 		ret = mvebu_mbus_add_window_remap_by_id(target, attribute, base,
 							sz, remap);
 		if (ret) {
+			phys_addr_t end = base + sz;
+
 			dev_err(&port->pcie->pdev->dev,
-				"Could not create MBus window at 0x%x, size 0x%x: %d\n",
-				base, sz, ret);
+				"Could not create MBus window at [mem %pa - %pa] :%d\n",
+				&base, &end, ret);
 			mvebu_pcie_del_windows(port, base - size_mapped,
 					       size_mapped);
 			return;
-- 
1.8.3.2

