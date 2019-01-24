Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C36C282C5
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 08:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC4A218AC
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 08:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rC+b2m7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfAXIat (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:30:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39858 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfAXIar (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 03:30:47 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0O8UgXk098760;
        Thu, 24 Jan 2019 02:30:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548318642;
        bh=rBTDfWcJLr0Su51YjFGpjqwyJEANuC84XOH01oQgLOE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rC+b2m7dkj1HJTK/Z0mLwvDw90wkJZRkDRniN37fyBz0isF5voEydfT2VL+foxW+o
         6hIgBh7UhPRSwe/YaABzd2EK9XjEkP0wyUljYmVUPvP12XRhP/Tt0nQhPSVwasBuf3
         Zul3nRgygBi746a43yhQ4AvO18ACvwsDC3+8D+3g=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0O8Ug5e128022
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 02:30:42 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 02:30:41 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 02:30:42 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0O8UTbb012320;
        Thu, 24 Jan 2019 02:30:39 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] PCI: dra7xx: Enable x2 mode support for dra74x, dra76x and dra72x
Date:   Thu, 24 Jan 2019 13:59:57 +0530
Message-ID: <20190124082957.29077-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124082957.29077-1-kishon@ti.com>
References: <20190124082957.29077-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dra74x/dra76x and dra72x have separate compatible strings. Add support
for these compatible strings in pci-dra7xx driver to perform syscon
configurations required to get x2 mode working.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 77 +++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index b4fbb4be212f..efb26096ccb5 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -81,6 +81,10 @@
 #define MSI_REQ_GRANT					BIT(0)
 #define MSI_VECTOR_SHIFT				7
 
+#define PCIE_1LANE_2LANE_SELECTION			BIT(13)
+#define PCIE_B1C0_MODE_SEL				BIT(2)
+#define PCIE_B0_B1_TSYNCEN				BIT(0)
+
 struct dra7xx_pcie {
 	struct dw_pcie		*pci;
 	void __iomem		*base;		/* DT ti_conf */
@@ -93,6 +97,7 @@ struct dra7xx_pcie {
 
 struct dra7xx_pcie_of_data {
 	enum dw_pcie_device_mode mode;
+	u32 b1co_mode_sel_mask;
 };
 
 #define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
@@ -542,6 +547,26 @@ static const struct dra7xx_pcie_of_data dra7xx_pcie_ep_of_data = {
 	.mode = DW_PCIE_EP_TYPE,
 };
 
+static const struct dra7xx_pcie_of_data dra746_pcie_rc_of_data = {
+	.b1co_mode_sel_mask = BIT(2),
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static const struct dra7xx_pcie_of_data dra726_pcie_rc_of_data = {
+	.b1co_mode_sel_mask = GENMASK(3, 2),
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static const struct dra7xx_pcie_of_data dra746_pcie_ep_of_data = {
+	.b1co_mode_sel_mask = BIT(2),
+	.mode = DW_PCIE_EP_TYPE,
+};
+
+static const struct dra7xx_pcie_of_data dra726_pcie_ep_of_data = {
+	.b1co_mode_sel_mask = GENMASK(3, 2),
+	.mode = DW_PCIE_EP_TYPE,
+};
+
 static const struct of_device_id of_dra7xx_pcie_match[] = {
 	{
 		.compatible = "ti,dra7-pcie",
@@ -551,6 +576,22 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
 		.compatible = "ti,dra7-pcie-ep",
 		.data = &dra7xx_pcie_ep_of_data,
 	},
+	{
+		.compatible = "ti,dra746-pcie-rc",
+		.data = &dra746_pcie_rc_of_data,
+	},
+	{
+		.compatible = "ti,dra726-pcie-rc",
+		.data = &dra726_pcie_rc_of_data,
+	},
+	{
+		.compatible = "ti,dra746-pcie-ep",
+		.data = &dra746_pcie_ep_of_data,
+	},
+	{
+		.compatible = "ti,dra726-pcie-ep",
+		.data = &dra726_pcie_ep_of_data,
+	},
 	{},
 };
 
@@ -596,6 +637,34 @@ static int dra7xx_pcie_unaligned_memaccess(struct device *dev)
 	return ret;
 }
 
+static int dra7xx_pcie_configure_two_lane(struct device *dev,
+					  u32 b1co_mode_sel_mask)
+{
+	struct device_node *np = dev->of_node;
+	struct regmap *pcie_syscon;
+	unsigned int pcie_reg;
+	u32 mask;
+	u32 val;
+
+	pcie_syscon = syscon_regmap_lookup_by_phandle(np, "ti,syscon-lane-sel");
+	if (IS_ERR(pcie_syscon)) {
+		dev_err(dev, "unable to get ti,syscon-lane-sel\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32_index(np, "ti,syscon-lane-sel", 1,
+				       &pcie_reg)) {
+		dev_err(dev, "couldn't get lane selection reg offset\n");
+		return -EINVAL;
+	}
+
+	mask = b1co_mode_sel_mask | PCIE_B0_B1_TSYNCEN;
+	val = PCIE_B1C0_MODE_SEL | PCIE_B0_B1_TSYNCEN;
+	regmap_update_bits(pcie_syscon, pcie_reg, mask, val);
+
+	return 0;
+}
+
 static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
@@ -616,6 +685,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	const struct dra7xx_pcie_of_data *data;
 	enum dw_pcie_device_mode mode;
+	u32 b1co_mode_sel_mask;
 
 	match = of_match_device(of_match_ptr(of_dra7xx_pcie_match), dev);
 	if (!match)
@@ -623,6 +693,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	data = (struct dra7xx_pcie_of_data *)match->data;
 	mode = (enum dw_pcie_device_mode)data->mode;
+	b1co_mode_sel_mask = data->b1co_mode_sel_mask;
 
 	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
 	if (!dra7xx)
@@ -678,6 +749,12 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	dra7xx->pci = pci;
 	dra7xx->phy_count = phy_count;
 
+	if (phy_count == 2) {
+		ret = dra7xx_pcie_configure_two_lane(dev, b1co_mode_sel_mask);
+		if (ret < 0)
+			dra7xx->phy_count = 1; /* Fallback to x1 lane mode */
+	}
+
 	ret = dra7xx_pcie_enable_phy(dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
-- 
2.17.1

