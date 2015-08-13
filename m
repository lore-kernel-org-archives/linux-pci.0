Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0103.outbound.protection.outlook.com ([65.55.169.103]:14784
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753761AbbHMSLi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Aug 2015 14:11:38 -0400
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 1/4] PCI: imx6: Simplify a trivial if-return sequence
Date: Thu, 13 Aug 2015 14:37:13 -0300
Message-ID: <1439487436-26989-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Simplify a trivial if-return sequence by combining it with a
preceding function call.

The semantic patch that makes this change is available
in scripts/coccinelle/misc/simple_return.cocci.

Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pci-imx6.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 233a196..8f3a981 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -117,11 +117,7 @@ static int pcie_phy_wait_ack(void __iomem *dbi_base, int addr)
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
 	writel(val, dbi_base + PCIE_PHY_CTRL);
 
-	ret = pcie_phy_poll_ack(dbi_base, 0);
-	if (ret)
-		return ret;
-
-	return 0;
+	return pcie_phy_poll_ack(dbi_base, 0);
 }
 
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
@@ -148,11 +144,7 @@ static int pcie_phy_read(void __iomem *dbi_base, int addr , int *data)
 	/* deassert Read signal */
 	writel(0x00, dbi_base + PCIE_PHY_CTRL);
 
-	ret = pcie_phy_poll_ack(dbi_base, 0);
-	if (ret)
-		return ret;
-
-	return 0;
+	return pcie_phy_poll_ack(dbi_base, 0);
 }
 
 static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)
-- 
1.9.1

