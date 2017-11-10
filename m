Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:56324 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdKJV7A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2017 16:59:00 -0500
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2 1/5] PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
Date: Fri, 10 Nov 2017 22:58:39 +0100
Message-Id: <20171110215843.432-2-marek.vasut+renesas@gmail.com>
In-Reply-To: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
References: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The data link active signal usually takes ~20 uSec to be asserted,
poll the bit more often to avoid useless delays in this function.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
V2: New patch
---
 drivers/pci/host/pcie-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index e00f865952d5..351e1276b90a 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -531,13 +531,13 @@ static void phy_write_reg(struct rcar_pcie *pcie,
 
 static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
 {
-	unsigned int timeout = 10;
+	unsigned int timeout = 10000;
 
 	while (timeout--) {
 		if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
 			return 0;
 
-		msleep(5);
+		udelay(5);
 	}
 
 	return -ETIMEDOUT;
-- 
2.11.0
