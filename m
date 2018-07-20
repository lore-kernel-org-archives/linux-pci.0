Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gateway32.websitewelcome.com ([192.185.145.171]:30916 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731612AbeGTPul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jul 2018 11:50:41 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 4CE7EB81EF8
        for <linux-pci@vger.kernel.org>; Fri, 20 Jul 2018 10:02:00 -0500 (CDT)
Date: Fri, 20 Jul 2018 10:01:58 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] PCI: mediatek: Fix unchecked return value
Message-ID: <20180720150158.GA10922@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Check return value of devm_pci_remap_iospace.

Notice that, currently, all instances of devm_pci_remap_iospace
are being checked.

Addresses-Coverity-ID: 1471965 ("Unchecked return value")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pci/controller/pcie-mediatek.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 861dda6..1477939 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1109,7 +1109,9 @@ static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
 	if (err < 0)
 		return err;
 
-	devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
+	err = devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.7.4
