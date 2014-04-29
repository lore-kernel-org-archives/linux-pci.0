Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:60924 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaD2DZM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Apr 2014 23:25:12 -0400
Received: by mail-yk0-f171.google.com with SMTP id 10so1338978ykt.16
        for <linux-pci@vger.kernel.org>; Mon, 28 Apr 2014 20:25:11 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: thomas.petazzoni@free-electrons.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	jg1.han@samsung.com, Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2] pci: pci-mvebu: Use '%pa' for printing 'phys_addr_t' type
Date: Tue, 29 Apr 2014 00:24:56 -0300
Message-Id: <1398741896-5953-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following build warning that happens when building multi_v7_defconfig
with CONFIG_ARM_LPAE=y:

drivers/pci/host/pci-mvebu.c:334:5: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'phys_addr_t' [-Wformat=]

Fix the warning by using '%pa' to printing 'phys_addr_t' type. While at it,
also use the more standard notation [mem 0x - 0x] for memory region.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- use the [mem 0x - 0x] notation

 drivers/pci/host/pci-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index e384e25..df57a6a 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -330,8 +330,8 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
 							sz, remap);
 		if (ret) {
 			dev_err(&port->pcie->pdev->dev,
-				"Could not create MBus window at 0x%x, size 0x%x: %d\n",
-				base, sz, ret);
+				"Could not create MBus window at [mem %pa - %pa] :%d\n",
+				&base, &base + sz, ret);
 			mvebu_pcie_del_windows(port, base - size_mapped,
 					       size_mapped);
 			return;
-- 
1.8.3.2

