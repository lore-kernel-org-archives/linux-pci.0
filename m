Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B51C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312A92190A
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfCVQLr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:11:47 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:7466 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727169AbfCVQLr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 12:11:47 -0400
X-IronPort-AV: E=Sophos;i="5.60,256,1549897200"; 
   d="scan'208";a="11083843"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Mar 2019 01:11:43 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 442A24046149;
        Sat, 23 Mar 2019 01:11:42 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH] PCI: rcar-gen2: Ensure the mandatory clock is enabled
Date:   Fri, 22 Mar 2019 16:11:10 +0000
Message-Id: <1553271070-7509-1-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

All SoC devices that use this driver have a module stop clock associated
with it that we must ensure is enabled. All SoCs enabled this clock
by default, so I guess no one noticed that the driver didn't enable it.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
Note: This change was tested on RZN1 and R-Car M2 hardware. NULL is
passed to devm_clk_get for backwards compatibility reasons with R-Car gen2
devices which do not name the clock.

DTS files for Renesas devices that use this driver have been checked to
ensure they specify a clock and do not name that clock.  
---
 drivers/pci/controller/pci-rcar-gen2.c | 35 +++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index 326171c..4c94860 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -8,6 +8,7 @@
  * Author: Valentine Barshak <valentine.barshak@cogentembedded.com>
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -95,6 +96,7 @@
 
 struct rcar_pci_priv {
 	struct device *dev;
+	struct clk *clk;
 	void __iomem *reg;
 	struct resource mem_res;
 	struct resource *cfg_res;
@@ -340,6 +342,8 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	void __iomem *reg;
 	struct hw_pci hw;
 	void *hw_private[1];
+	struct clk *clk;
+	int ret;
 
 	cfg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(dev, cfg_res);
@@ -376,7 +380,6 @@ static int rcar_pci_probe(struct platform_device *pdev)
 
 	if (dev->of_node) {
 		struct resource busnr;
-		int ret;
 
 		ret = of_pci_parse_bus_range(dev->of_node, &busnr);
 		if (ret < 0) {
@@ -397,6 +400,14 @@ static int rcar_pci_probe(struct platform_device *pdev)
 		priv->busnr = pdev->id;
 	}
 
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+	priv->clk = clk;
+
 	hw_private[0] = priv;
 	memset(&hw, 0, sizeof(hw));
 	hw.nr_controllers = ARRAY_SIZE(hw_private);
@@ -409,6 +420,27 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused pci_rcar_gen2_suspend_noirq(struct device *dev)
+{
+	struct rcar_pci_priv *priv = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->clk);
+	return 0;
+}
+
+static int __maybe_unused pci_rcar_gen2_resume_noirq(struct device *dev)
+{
+	struct rcar_pci_priv *priv = dev_get_drvdata(dev);
+
+	clk_prepare_enable(priv->clk);
+	return 0;
+}
+
+static const struct dev_pm_ops pci_rcar_gen2_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pci_rcar_gen2_suspend_noirq,
+				      pci_rcar_gen2_resume_noirq)
+};
+
 static const struct of_device_id rcar_pci_of_match[] = {
 	{ .compatible = "renesas,pci-r8a7790", },
 	{ .compatible = "renesas,pci-r8a7791", },
@@ -422,6 +454,7 @@ static struct platform_driver rcar_pci_driver = {
 		.name = "pci-rcar-gen2",
 		.suppress_bind_attrs = true,
 		.of_match_table = rcar_pci_of_match,
+		.pm = &pci_rcar_gen2_pm_ops,
 	},
 	.probe = rcar_pci_probe,
 };
-- 
2.7.4

