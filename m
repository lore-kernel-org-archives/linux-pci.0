Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37332 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033380AbeEXOgh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 May 2018 10:36:37 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 4/6] PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
Date: Thu, 24 May 2018 16:36:22 +0200
Message-Id: <20180524143624.26718-5-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
References: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The data link active signal usually takes ~20 uSec to be asserted,
poll the bit more often to avoid useless delays in this function.
Use udelay() instead of usleep() for such a small delay as suggested
by the timer documentation and because this will be used in atomic
context later on when the suspend/resume patches land.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
V2: s/content/context in commit message
V3: Add cpu_relax()
V4: Rebase on top of Lorenzo's pci/rcar, fix up the rebase breakage
    induced by patches therein
---
 drivers/pci/host/pcie-rcar.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index d6a7e8482dcf..4843a4dc6059 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -546,13 +546,14 @@ static int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie)
 
 static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
 {
-	unsigned int timeout = 10;
+	unsigned int timeout = 10000;
 
 	while (timeout--) {
 		if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
 			return 0;
 
-		msleep(5);
+		udelay(5);
+		cpu_relax();
 	}
 
 	return -ETIMEDOUT;
-- 
2.16.2
