Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7713CC282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 23:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA97218CD
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 23:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPaX707s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfAYXqE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:46:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45548 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbfAYXpq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 18:45:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so4810380pgc.12
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2019 15:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9lDn59R0uKyyjUk+R0pUhwZFm9s0i+JBlQt24S6LAUM=;
        b=dPaX707sm4P6fO6/vpsObyTT+ANpT0ovkLA3sJY6QiBklBoE21UAqvMaZ2fioYUbmS
         JctrYQ/TeXkX17kt9x1vBJE8KEh5huwdm1/WlRvKRrftOZm+gbivrr91Lk0a+ZqMV1wr
         wvS3EjJMdZenzh91pPJ9x5szVhnZIkIvC2DuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9lDn59R0uKyyjUk+R0pUhwZFm9s0i+JBlQt24S6LAUM=;
        b=fd5ifbfBKlEdjZnRnVR0l8agOSqwAmQQZXFZOXbSHb5yn1f84E4FpPZbjJXtAgTmyZ
         XdUTCaHmLm+pKl/yEpMaVRPqYjDfSp98S06j7rJrYMnbVj2Sks1id4isltC3yRiBXWxs
         iIMHUJKpST1NmBk77s7lBzr20DUFClcLUUuvSHOQDuxQoe6IcF6SR3GAO704QcQFn1TC
         Z+UhPcIllJfIQ0P2nREtoYbs7TVf7lNc/otp/f7qlhwSUMQ6qrOavzT7h3x27olL8Rkn
         54gFHCHhqqd1XZqUc9NPpGYYyEti4TkEzzx6L34Ewq/ROCLW7C8eeLmTQC0RTG/Bvd98
         MPNA==
X-Gm-Message-State: AJcUukecD2qcbS1E+IPamvYfmKA/xJzG+M6GG3TRDfdlocRC5tF0HTeG
        ws6OAkH9xqpU20NrAYb/0tAAqA==
X-Google-Smtp-Source: ALg8bN7V10Njdd+vTdDprPZYYt4n+e3cBNTQnfBBJLL67VNpJiHFraOu+nKRJD1q8MO95gm1gZIysg==
X-Received: by 2002:a63:e247:: with SMTP id y7mr11246324pgj.84.1548459945361;
        Fri, 25 Jan 2019 15:45:45 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y9sm32950302pfi.74.2019.01.25.15.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:45:44 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 6/7] PCI: qcom: Add QCS404 PCIe controller support
Date:   Fri, 25 Jan 2019 15:45:08 -0800
Message-Id: <20190125234509.26419-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190125234509.26419-1-bjorn.andersson@linaro.org>
References: <20190125234509.26419-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The QCS404 platform contains a PCIe controller of version 2.4.0 and a
Qualcomm PCIe2 PHY. The driver already supports version 2.4.0, for the
IPQ4019, but this support touches clocks and resets related to the PHY
as well, and there's no upstream driver for the PHY.

On QCS404 we must initialize the PHY, so a separate PHY driver is
implemented to take care of this and the controller driver is updated to
not require the PHY related resources. This is done by relying on the
fact that operations in both the clock and reset framework are nops when
passed NULL, so we can isolate this change to only the get_resource
function.

For QCS404 we also need to enable the AHB (iface) clock, in order to
access the register space of the controller, but as this is not part of
the IPQ4019 DT binding this is only added for new users of the 2.4.0
controller.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 64 +++++++++++++++-----------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 9d366fad2b7f..6d4215ddcb42 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -113,7 +113,7 @@ struct qcom_pcie_resources_2_3_2 {
 };
 
 struct qcom_pcie_resources_2_4_0 {
-	struct clk_bulk_data clks[3];
+	struct clk_bulk_data clks[4];
 	int num_clks;
 	struct reset_control *axi_m_reset;
 	struct reset_control *axi_s_reset;
@@ -637,13 +637,16 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	bool is_ipq = of_device_is_compatible(dev->of_node, "qcom,pcie-ipq4019");
 	int ret;
 
 	res->clks[0].id = "aux";
 	res->clks[1].id = "master_bus";
 	res->clks[2].id = "slave_bus";
+	res->clks[3].id = "iface";
 
-	res->num_clks = 3;
+	/* qcom,pcie-ipq4019 is defined without "iface" */
+	res->num_clks = is_ipq ? 3 : 4;
 
 	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
 	if (ret < 0)
@@ -657,27 +660,33 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->axi_s_reset))
 		return PTR_ERR(res->axi_s_reset);
 
-	res->pipe_reset = devm_reset_control_get_exclusive(dev, "pipe");
-	if (IS_ERR(res->pipe_reset))
-		return PTR_ERR(res->pipe_reset);
-
-	res->axi_m_vmid_reset = devm_reset_control_get_exclusive(dev,
-								 "axi_m_vmid");
-	if (IS_ERR(res->axi_m_vmid_reset))
-		return PTR_ERR(res->axi_m_vmid_reset);
-
-	res->axi_s_xpu_reset = devm_reset_control_get_exclusive(dev,
-								"axi_s_xpu");
-	if (IS_ERR(res->axi_s_xpu_reset))
-		return PTR_ERR(res->axi_s_xpu_reset);
-
-	res->parf_reset = devm_reset_control_get_exclusive(dev, "parf");
-	if (IS_ERR(res->parf_reset))
-		return PTR_ERR(res->parf_reset);
-
-	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
-	if (IS_ERR(res->phy_reset))
-		return PTR_ERR(res->phy_reset);
+	if (is_ipq) {
+		/*
+		 * These resources relates to the PHY, but are controlled here
+		 * for IPQ4019
+		 */
+		res->pipe_reset = devm_reset_control_get_exclusive(dev, "pipe");
+		if (IS_ERR(res->pipe_reset))
+			return PTR_ERR(res->pipe_reset);
+
+		res->axi_m_vmid_reset = devm_reset_control_get_exclusive(dev,
+									 "axi_m_vmid");
+		if (IS_ERR(res->axi_m_vmid_reset))
+			return PTR_ERR(res->axi_m_vmid_reset);
+
+		res->axi_s_xpu_reset = devm_reset_control_get_exclusive(dev,
+									"axi_s_xpu");
+		if (IS_ERR(res->axi_s_xpu_reset))
+			return PTR_ERR(res->axi_s_xpu_reset);
+
+		res->parf_reset = devm_reset_control_get_exclusive(dev, "parf");
+		if (IS_ERR(res->parf_reset))
+			return PTR_ERR(res->parf_reset);
+
+		res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
+		if (IS_ERR(res->phy_reset))
+			return PTR_ERR(res->phy_reset);
+	}
 
 	res->axi_m_sticky_reset = devm_reset_control_get_exclusive(dev,
 								   "axi_m_sticky");
@@ -697,9 +706,11 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->ahb_reset))
 		return PTR_ERR(res->ahb_reset);
 
-	res->phy_ahb_reset = devm_reset_control_get_exclusive(dev, "phy_ahb");
-	if (IS_ERR(res->phy_ahb_reset))
-		return PTR_ERR(res->phy_ahb_reset);
+	if (is_ipq) {
+		res->phy_ahb_reset = devm_reset_control_get_exclusive(dev, "phy_ahb");
+		if (IS_ERR(res->phy_ahb_reset))
+			return PTR_ERR(res->phy_ahb_reset);
+	}
 
 	return 0;
 }
@@ -1284,6 +1295,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
+	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
 	{ }
 };
 
-- 
2.18.0

