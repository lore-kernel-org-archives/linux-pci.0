Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from stargate.chelsio.com ([67.207.112.58]:31955 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab3HFKZv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 06:25:51 -0400
From: Vipul Pandya <vipul@chelsio.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, leedom@chelsio.com, tomreu@chelsio.com,
	vipul@chelsio.com, divy@chelsio.com, dm@chelsio.com,
	nirranjan@chelsio.com, eilong@broadcom.com, netdev@vger.kernel.org
Subject: [PATCH V2 3/4] bnx2x: Use pci_wait_for_pending_transaction instead of for loop
Date: Tue,  6 Aug 2013 15:48:38 +0530
Message-Id: <1375784319-25760-4-git-send-email-vipul@chelsio.com>
In-Reply-To: <1375784319-25760-1-git-send-email-vipul@chelsio.com>
References: <1375784319-25760-1-git-send-email-vipul@chelsio.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Casey Leedom <leedom@chelsio.com>

New routine has been added to avoid duplication of waiting for pending pci
transaction code. This patch makes use of that routine.

Signed-off-by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Vipul Pandya <vipul@chelsio.com>
---
V2: Added pci_wait_for_pending_transaction routine and replaced it at respective
places. Made the patch series for the same.
V2: Used dev->msix_cap directly for capability offset
V2: Removed use of 'rc' variable.

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index e5da078..c51d2f8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9935,8 +9935,6 @@ static int bnx2x_prev_mark_path(struct bnx2x *bp, bool after_undi)
 
 static int bnx2x_do_flr(struct bnx2x *bp)
 {
-	int i;
-	u16 status;
 	struct pci_dev *dev = bp->pdev;
 
 	if (CHIP_IS_E1x(bp)) {
@@ -9951,20 +9949,8 @@ static int bnx2x_do_flr(struct bnx2x *bp)
 		return -EINVAL;
 	}
 
-	/* Wait for Transaction Pending bit clean */
-	for (i = 0; i < 4; i++) {
-		if (i)
-			msleep((1 << (i - 1)) * 100);
-
-		pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &status);
-		if (!(status & PCI_EXP_DEVSTA_TRPND))
-			goto clear;
-	}
-
-	dev_err(&dev->dev,
-		"transaction is not cleared; proceeding with reset anyway\n");
-
-clear:
+	if (!pci_wait_for_pending_transaction(dev))
+		dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
 
 	BNX2X_DEV_INFO("Initiating FLR\n");
 	bnx2x_fw_command(bp, DRV_MSG_CODE_INITIATE_FLR, 0);
-- 
1.8.0

