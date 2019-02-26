Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CECC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 07:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31ED2173C
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 07:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rG+mpHw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfBZHAz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:00:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38077 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfBZHAz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Feb 2019 02:00:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id m2so5757105pgl.5
        for <linux-pci@vger.kernel.org>; Mon, 25 Feb 2019 23:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fx6OO5xoSrFOoloNsMCvFZvz3wzpFqdeDNJe3ZiTRtY=;
        b=rG+mpHw82l4jKk9Lyhe1R6E6UUgGXSlhL8OqBZAdZz4BJRpl+DhYjNXiTfuRmWuuii
         Mfo4StPJ/dRELqgBdjIEd7Z7j/eZ4AkDHatYMT/VR1BFFGjrwcNJdXGiF30/NIlxJXq5
         P520vYWT8p4I3TwuErmDsR5UpdbXlyAOCnt04dUJP6usQXTWdVQ/qQRScqGrtn3ZlT1i
         YujnBD82JRkYg8ddy/VDIMSYU7otGQOJXj4KEd6J7cv0jahJZDL2stufvyUzR76x6OSn
         1gLWGaIWe1LO3fLGlsajB4lQdfNGBWjH5QqNeExDtTzAJSiM+Suk9qSRfaBVV+9AU0M8
         eigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fx6OO5xoSrFOoloNsMCvFZvz3wzpFqdeDNJe3ZiTRtY=;
        b=kH6TLezPjBFjg2sYS9F6QHxVXW3GuO4JPVchqfM3ZTQ19hS84fN/oEd0R037EsrBc+
         eTFe9oV+CYLFa3BfhL/DsLh2B0QBxX7p97EE01zSZsMt8hW3qkJCa8mxFBrX5LXHA9T4
         P6v18+AGY1sIafTcfVM9UTLSWvJ7dNNUUfzlU+3444LRKIwmiJ5RqPpv3x2MF4UOPbX3
         3yrEdvPL1fNYFBLbTpSzklHP2d4RLe+3GpazOSYTbVlr4EXjobUyVnT9sUBbRGXSE33h
         WNn4Nq5to2/SImo06SUv+EiAVF5qiT3MCIxjqPfPh4O3ifdbdVcRsMhXj3GnSLMV24Bk
         KJQw==
X-Gm-Message-State: AHQUAuY2u50bzOqFmFTfIE1pF/cBc9GTBY8ua3Rv+wd4j/uYNmto2Oux
        bsZ3KGNzLLjqGsyf0IkXQLbkQA==
X-Google-Smtp-Source: AHgI3IaPGL1uNNwSLIUFsIkOzZmamOJ9SkhsT0ckRxGbLkZaq60BtNEGnfm4euYPG9XzyOzYV6nJSw==
X-Received: by 2002:a65:5003:: with SMTP id f3mr23117124pgo.39.1551164454136;
        Mon, 25 Feb 2019 23:00:54 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b26sm15047362pfo.33.2019.02.25.23.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 23:00:53 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pcie: qcom: Add support for sdm845 PCIe controller
Date:   Mon, 25 Feb 2019 23:01:25 -0800
Message-Id: <20190226070125.22318-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SDM845 has one Gen2 and one Gen3 controller, add support for these.

Due to lack of hardware only the Gen2 controller has been verified.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt     |  19 +++
 drivers/pci/controller/dwc/pcie-qcom.c        | 146 ++++++++++++++++++
 2 files changed, 165 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 1fd703bd73e0..2cf92ed39499 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -10,6 +10,7 @@
 			- "qcom,pcie-msm8996" for msm8996 or apq8096
 			- "qcom,pcie-ipq4019" for ipq4019
 			- "qcom,pcie-ipq8074" for ipq8074
+			- "qcom,pcie-sdm845" for sdm845
 
 - reg:
 	Usage: required
@@ -116,6 +117,18 @@
 			- "ahb"		AHB clock
 			- "aux"		Auxiliary clock
 
+- clock-names:
+	Usage: required for sdm845
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "aux"		Auxiliary clock
+			- "cfg"		Configuration clock
+			- "bus_master"	Master AXI clock
+			- "bus_slave"	Slave AXI clock
+			- "slave_q2a"	Slave Q2A clock
+			- "tbu"		PCIe TBU clock
+			- "pipe"	PIPE clock
+
 - resets:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -167,6 +180,12 @@
 			- "ahb"			AHB Reset
 			- "axi_m_sticky"	AXI Master Sticky reset
 
+- reset-names:
+	Usage: required for sdm845
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "pci"			PCIe core reset
+
 - power-domains:
 	Usage: required for apq8084 and msm8996/apq8096
 	Value type: <prop-encoded-array>
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d185ea5fe996..5147454a6ae5 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -54,6 +54,7 @@
 #define PCIE20_PARF_LTSSM			0x1B0
 #define PCIE20_PARF_SID_OFFSET			0x234
 #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
+#define PCIE20_PARF_DEVICE_TYPE			0x1000
 
 #define PCIE20_ELBI_SYS_CTRL			0x04
 #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
@@ -80,6 +81,8 @@
 #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
 #define SLV_ADDR_SPACE_SZ			0x10000000
 
+#define DEVICE_TYPE_RC				0x4
+
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
 struct qcom_pcie_resources_2_1_0 {
 	struct clk *iface_clk;
@@ -139,12 +142,21 @@ struct qcom_pcie_resources_2_3_3 {
 	struct reset_control *rst[7];
 };
 
+struct qcom_pcie_resources_2_7_0 {
+	struct clk_bulk_data clks[6];
+	struct regulator_bulk_data supplies[2];
+
+	struct reset_control *pci_reset;
+	struct clk *pipe_clk;
+};
+
 union qcom_pcie_resources {
 	struct qcom_pcie_resources_1_0_0 v1_0_0;
 	struct qcom_pcie_resources_2_1_0 v2_1_0;
 	struct qcom_pcie_resources_2_3_2 v2_3_2;
 	struct qcom_pcie_resources_2_3_3 v2_3_3;
 	struct qcom_pcie_resources_2_4_0 v2_4_0;
+	struct qcom_pcie_resources_2_7_0 v2_7_0;
 };
 
 struct qcom_pcie;
@@ -1076,6 +1088,129 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	return ret;
 }
 
+static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
+	if (IS_ERR(res->pci_reset))
+		return PTR_ERR(res->pci_reset);
+
+	res->supplies[0].supply = "vdda";
+	res->supplies[1].supply = "vddpe-3v3";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
+				      res->supplies);
+	if (ret)
+		return ret;
+
+	res->clks[0].id = "aux";
+	res->clks[1].id = "cfg";
+	res->clks[2].id = "bus_master";
+	res->clks[3].id = "bus_slave";
+	res->clks[4].id = "slave_q2a";
+	res->clks[5].id = "tbu";
+
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		return ret;
+
+	res->pipe_clk = devm_clk_get(dev, "pipe");
+	return PTR_ERR_OR_ZERO(res->pipe_clk);
+}
+
+static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	u32 val;
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
+	if (ret < 0) {
+		dev_err(dev, "cannot enable regulators\n");
+		return ret;
+	}
+
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		goto err_disable_regulators;
+
+	ret = reset_control_assert(res->pci_reset);
+	if (ret) {
+		dev_err(dev, "cannot deassert pci reset\n");
+		return ret;
+	}
+
+	msleep(10);
+
+	ret = reset_control_deassert(res->pci_reset);
+	if (ret) {
+		dev_err(dev, "cannot deassert pci reset\n");
+		return ret;
+	}
+
+	clk_prepare_enable(res->pipe_clk);
+
+	/* configure PCIe to RC mode */
+	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
+
+	/* enable PCIe clocks and resets */
+	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val &= ~BIT(0);
+	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+
+	/* change DBI base address */
+	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+
+	/* MAC PHY_POWERDOWN MUX DISABLE  */
+	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
+	val &= ~BIT(29);
+	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
+
+	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	val |= BIT(4);
+	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+		val |= BIT(31);
+		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+	}
+
+	return 0;
+
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
+
+	return ret;
+}
+
+static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
+}
+
+static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+
+	return clk_prepare_enable(res->pipe_clk);
+}
+
+static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+
+	clk_disable_unprepare(res->pipe_clk);
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 val = readw(pci->dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
@@ -1192,6 +1327,16 @@ static const struct qcom_pcie_ops ops_2_3_3 = {
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
+/* Qcom IP rev.: 2.7.0	Synopsys IP rev.: 4.30a */
+static const struct qcom_pcie_ops ops_2_7_0 = {
+	.get_resources = qcom_pcie_get_resources_2_7_0,
+	.init = qcom_pcie_init_2_7_0,
+	.deinit = qcom_pcie_deinit_2_7_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.post_init = qcom_pcie_post_init_2_7_0,
+	.post_deinit = qcom_pcie_post_deinit_2_7_0,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 };
@@ -1306,6 +1451,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
+	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
 	{ }
 };
 
-- 
2.18.0

