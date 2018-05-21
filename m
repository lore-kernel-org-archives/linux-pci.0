Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40076 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753278AbeEURDA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 May 2018 13:03:00 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
Date: Mon, 21 May 2018 19:02:50 +0200
Message-Id: <20180521170250.13224-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The data link active signal usually takes ~20 uSec to be asserted,
poll the bit more often to avoid useless delays in this function.
Use udelay() instead of usleep() for such a small delay as suggested
by the timer documentation and because this will be used in atomic
content later on when the suspend/resume patches land.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/host/pcie-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 5c365f743df5..65ebe7aa3488 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -529,13 +529,13 @@ static void phy_write_reg(struct rcar_pcie *pcie,
 
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
2.16.2
