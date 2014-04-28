Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:53241 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbaD1Kvg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Apr 2014 06:51:36 -0400
Received: by mail-yk0-f176.google.com with SMTP id 19so5485190ykq.21
        for <linux-pci@vger.kernel.org>; Mon, 28 Apr 2014 03:51:35 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: thomas.petazzoni@free-electrons.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] pci: pci-mvebu: Use '%pa' for printing 'phys_addr_t' type
Date: Mon, 28 Apr 2014 07:51:21 -0300
Message-Id: <1398682281-18772-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following build warning that happens when building multi_v7_defconfig
with CONFIG_ARM_LPAE=y:

drivers/pci/host/pci-mvebu.c:334:5: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'phys_addr_t' [-Wformat=]

While at it, also use '%zx' for printing 'size_t'. 

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pci-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index e384e25..572a7b5 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -330,8 +330,8 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
 							sz, remap);
 		if (ret) {
 			dev_err(&port->pcie->pdev->dev,
-				"Could not create MBus window at 0x%x, size 0x%x: %d\n",
-				base, sz, ret);
+				"Could not create MBus window at %pa, size 0x%zx: %d\n",
+				&base, sz, ret);
 			mvebu_pcie_del_windows(port, base - size_mapped,
 					       size_mapped);
 			return;
-- 
1.8.3.2

