Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gateway33.websitewelcome.com ([192.185.145.87]:35658 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750974AbeATDt2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jan 2018 22:49:28 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 911724110C
        for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2018 21:26:52 -0600 (CST)
Date: Fri, 19 Jan 2018 21:26:51 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Ley Foon Tan <lftan@altera.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: rfi@lists.rocketboards.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] PCI: altera: Fix bool initialization in tlp_read_packet
Message-ID: <20180120032651.GA14512@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bool initializations should use true and false.

This issue was detected with the help of Coccinelle.

Fixes: eaa6111b70a7 ("PCI: altera: Add Altera PCIe host controller driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pci/host/pcie-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 5cc4f59..f9ee090 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -156,7 +156,7 @@ static bool altera_pcie_valid_device(struct altera_pcie *pcie,
 static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
 {
 	int i;
-	bool sop = 0;
+	bool sop = false;
 	u32 ctrl;
 	u32 reg0, reg1;
 	u32 comp_status = 1;
-- 
2.7.4
