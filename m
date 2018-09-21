Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C30C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAD0206B7
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZTaVyzVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAD0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389894AbeIUQMN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:13 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51360 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389870AbeIUQML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:12:11 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LANZ6S033283;
        Fri, 21 Sep 2018 05:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525415;
        bh=foMA9sXY1vSacErr421Q9aMno8mL1g6LWM8DFq/dpjM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZTaVyzVoc7eqaZ47d1prlUYPAJr58HuwN2IaRCJNjoOmL9HVeHW/CRBz8uZ4XxchB
         t59bPDm+EnIVadP6fRBkFGpL9tqPP0uI0sMcjkl+tFFzaQqO6IM2bbmmk0b/fi/HkI
         Y3TgMVM0lJsCQtk7ynLsk4xdYI2AqxarK5f2aMwk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LANZid018768;
        Fri, 21 Sep 2018 05:23:35 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:23:35 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:23:35 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtK032280;
        Fri, 21 Sep 2018 05:23:30 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <Gustavo.Pimentel@synopsys.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 16/40] PCI: keystone: Invoke pm_runtime APIs to enable clock
Date:   Fri, 21 Sep 2018 15:51:31 +0530
Message-ID: <20180921102155.22839-17-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Invoke pm_runtime APIs to enable clocks and remove explicit
clock enabling using clk_prepare_enable().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 29 +++++++++++------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index b013776d9256..f230344e1f4e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -95,7 +95,6 @@ static void ks_pcie_stop_link(struct dw_pcie *pci);
 
 struct keystone_pcie {
 	struct dw_pcie		*pci;
-	struct	clk		*clk;
 	int			num_lanes;
 	struct phy		**phy;
 	struct device_link	**link;
@@ -879,26 +878,25 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, ks_pcie);
-	ks_pcie->clk = devm_clk_get(dev, "pcie");
-	if (IS_ERR(ks_pcie->clk)) {
-		dev_err(dev, "Failed to get pcie rc clock\n");
-		ret = PTR_ERR(ks_pcie->clk);
-		goto err_get_irq;
-	}
 
-	ret = clk_prepare_enable(ks_pcie->clk);
-	if (ret)
-		goto err_get_irq;
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed\n");
+		goto err_get_sync;
+	}
 
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
-		goto fail_clk;
+		goto err_get_sync;
 
 	ks_pcie_enable_error_irq(ks_pcie);
 
 	return 0;
-fail_clk:
-	clk_disable_unprepare(ks_pcie->clk);
+
+err_get_sync:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
 
 err_get_irq:
 	ks_pcie_disable_phy(ks_pcie);
@@ -915,10 +913,11 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
 	int num_lanes = ks_pcie->num_lanes;
+	struct device *dev = &pdev->dev;
 
-	clk_disable_unprepare(ks_pcie->clk);
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
-
 	while (num_lanes--)
 		device_link_del(link[num_lanes]);
 
-- 
2.17.1

