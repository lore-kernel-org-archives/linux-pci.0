Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37453 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbcCMXa7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2016 19:30:59 -0400
Received: by mail-wm0-f47.google.com with SMTP id p65so81686646wmp.0
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2016 16:30:58 -0700 (PDT)
Message-ID: <1457911855.16725.41.camel@googlemail.com>
Subject: PCI: imx6: Factor out ref clock enable
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Date: Mon, 14 Mar 2016 00:30:55 +0100
In-Reply-To: <1457911590.16725.37.camel@googlemail.com>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
	 <1456411669-4699-3-git-send-email-chf.fritz@googlemail.com>
	 <20160311175850.GA4725@localhost>
	 <1457911590.16725.37.camel@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

commit dfcc1a16e6954e8ca6cadfc9dd309db6b6ef46b2
Author: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 11 Mar 2016 11:15:36 -0600

Factor out ref clock enable to make it cleaner to add imx6sx support.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/pci/host/pci-imx6.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index bd3f7d0..4e0e47f 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -264,6 +264,23 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 	return 0;
 }
 
+static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
+{
+	/* power up core phy and enable ref clock */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+	/*
+	 * the async reset input need ref clock to sync internally,
+	 * when the ref clock comes after reset, internal synced
+	 * reset time is too short, cannot meet the requirement.
+	 * add one ~10us delay here.
+	 */
+	udelay(10);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+	return 0;
+}
+
 static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
@@ -287,18 +304,11 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		goto err_pcie;
 	}
 
-	/* power up core phy and enable ref clock */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
-	/*
-	 * the async reset input need ref clock to sync internally,
-	 * when the ref clock comes after reset, internal synced
-	 * reset time is too short, cannot meet the requirement.
-	 * add one ~10us delay here.
-	 */
-	udelay(10);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
+	if (ret) {
+		dev_err(pp->dev, "unable to enable pcie ref clock\n");
+		goto err_ref_clk;
+	}
 
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
@@ -311,6 +321,8 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	}
 	return 0;
 
+err_ref_clk:
+	clk_disable_unprepare(imx6_pcie->pcie);
 err_pcie:
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
 err_pcie_bus:
-- 
2.1.4


