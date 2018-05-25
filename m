Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40526 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967628AbeEYSeH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 May 2018 14:34:07 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar: Clean up PHY init on failure
Date: Fri, 25 May 2018 20:33:26 +0200
Message-Id: <20180525183326.5245-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the Gen3 PHY fails to power up, the code does not undo the
initialization caused by phy_init(). Add the missing failure
handling to the rcar_pcie_phy_init_gen3() function.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
Fixes: 517ca93a7159 ("PCI: rcar: Add R-Car gen3 PHY support")
---
 drivers/pci/host/pcie-rcar.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 695781934f0a..477bf40cc031 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -678,7 +678,11 @@ static int rcar_pcie_phy_init_gen3(struct rcar_pcie *pcie)
 	if (err)
 		return err;
 
-	return phy_power_on(pcie->phy);
+	err = phy_power_on(pcie->phy);
+	if (err)
+		phy_exit(pcie->phy);
+
+	return err;
 }
 
 static int rcar_msi_alloc(struct rcar_msi *chip)
-- 
2.16.2
