Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE713C43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 16:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990B62087F
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 16:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfAHQYt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:24:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44858 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbfAHQYs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jan 2019 11:24:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 21D5B20A0D; Tue,  8 Jan 2019 17:24:46 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id BAA02209C2;
        Tue,  8 Jan 2019 17:24:45 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 03/15] PCI: aardvark: Add clock support
Date:   Tue,  8 Jan 2019 17:24:28 +0100
Message-Id: <20190108162441.5278-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108162441.5278-1-miquel.raynal@bootlin.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The IP relies on a gated clock. When we will add S2RAM support, this
clock will need to be resumed before any PCIe registers are
accessed. Add support for this clock.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 0f50163ae072..b1b8897d2d28 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -8,6 +8,7 @@
  * Author: Hezi Shahmoon <hezi.shahmoon@marvell.com>
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -187,6 +188,7 @@
 
 struct advk_pcie {
 	struct platform_device *pdev;
+	struct clk *clk;
 	void __iomem *base;
 	struct list_head resources;
 	struct irq_domain *irq_domain;
@@ -973,6 +975,29 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 	return err;
 }
 
+static int advk_pcie_setup_clk(struct advk_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	int ret;
+
+	pcie->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pcie->clk) && (PTR_ERR(pcie->clk) == -EPROBE_DEFER))
+		return PTR_ERR(pcie->clk);
+
+	/* Old bindings miss the clock handle */
+	if (IS_ERR(pcie->clk)) {
+		dev_warn(dev, "Clock unavailable (%ld)\n", PTR_ERR(pcie->clk));
+		pcie->clk = NULL;
+		return 0;
+	}
+
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		dev_err(dev, "Clock initialization failed (%d)\n", ret);
+
+	return ret;
+}
+
 static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1008,6 +1033,10 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = advk_pcie_setup_clk(pcie);
+	if (ret)
+		return ret;
+
 	advk_pcie_setup_hw(pcie);
 
 	advk_sw_pci_bridge_init(pcie);
-- 
2.19.1

