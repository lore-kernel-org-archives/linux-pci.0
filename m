Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:35467 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752615AbeB1OrP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 09:47:15 -0500
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Shadi Ammouri <shadi@marvell.com>,
        Omri Itach <omrii@marvell.com>,
        Hanna Hawa <hannah@marvell.com>,
        Igal Liberman <igall@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 1/2] PCI: armada8k: Remove useless test before clk_disable_unprepare
Date: Wed, 28 Feb 2018 15:47:03 +0100
Message-Id: <20180228144704.12947-2-gregory.clement@bootlin.com>
In-Reply-To: <20180228144704.12947-1-gregory.clement@bootlin.com>
References: <20180228144704.12947-1-gregory.clement@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

clk_disable_unprepare() already checks that the clock pointer is valid.
No need to test it before calling it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/pci/dwc/pcie-armada8k.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index b587352f8b9f..f9b1aec25c5c 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -247,8 +247,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 fail:
-	if (!IS_ERR(pcie->clk))
-		clk_disable_unprepare(pcie->clk);
+	clk_disable_unprepare(pcie->clk);
 
 	return ret;
 }
-- 
2.16.1
