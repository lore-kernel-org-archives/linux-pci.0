Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55287 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751650AbdKHJ2V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 04:28:21 -0500
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/3] PCI: rcar: Add the initialization of PCIe link in resume_noirq
Date: Wed,  8 Nov 2017 10:28:04 +0100
Message-Id: <20171108092806.10335-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>

Reestablish the PCIe link very early in the resume process in case it
went down to prevent PCI accesses from hanging the bus. Such accesses
can happen early in the PCI resume process, in the resume_noirq, thus
the link must be reestablished in the resume_noirq callback of the
driver.

Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/host/pcie-rcar.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 889603783f01..aa588a7d4811 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -43,6 +43,7 @@
 
 /* Transfer control */
 #define PCIETCTLR		0x02000
+#define  DL_DOWN		(1 << 3)
 #define  CFINIT			1
 #define PCIETSTR		0x02004
 #define  DATA_LINK_ACTIVE	1
@@ -529,7 +530,7 @@ static void phy_write_reg(struct rcar_pcie *pcie,
 	phy_wait_for_ack(pcie);
 }
 
-static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
+static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie, int atomic)
 {
 	unsigned int timeout = 10;
 
@@ -537,7 +538,10 @@ static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
 		if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
 			return 0;
 
-		msleep(5);
+		if (atomic)
+			mdelay(5);
+		else
+			msleep(5);
 	}
 
 	return -ETIMEDOUT;
@@ -595,7 +599,7 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
 
 	/* This will timeout if we don't have a link. */
-	err = rcar_pcie_wait_for_dl(pcie);
+	err = rcar_pcie_wait_for_dl(pcie, 0);
 	if (err)
 		return err;
 
@@ -1110,6 +1114,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
+	platform_set_drvdata(pdev, pcie);
 
 	INIT_LIST_HEAD(&pcie->resources);
 
@@ -1173,10 +1178,30 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int rcar_pcie_resume_noirq(struct device *dev)
+{
+	struct rcar_pcie *pcie = dev_get_drvdata(dev);
+	u32 val = rcar_pci_read_reg(pcie, PMSR);
+	int ret = 0;
+
+	if ((val == 0) || (rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN)) {
+		/* Re-establish the PCIe link */
+		rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
+		ret = rcar_pcie_wait_for_dl(pcie, 1);
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops rcar_pcie_pm_ops = {
+	.resume_noirq = rcar_pcie_resume_noirq,
+};
+
 static struct platform_driver rcar_pcie_driver = {
 	.driver = {
 		.name = "rcar-pcie",
 		.of_match_table = rcar_pcie_of_match,
+		.pm = &rcar_pcie_pm_ops,
 		.suppress_bind_attrs = true,
 	},
 	.probe = rcar_pcie_probe,
-- 
2.11.0
