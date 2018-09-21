Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AABC433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD11F21547
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mUYoOwvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD11F21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbeIUQMt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35152 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeIUQMt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:12:49 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LAOCEU030588;
        Fri, 21 Sep 2018 05:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525452;
        bh=eN2QjYF7XPN5wdQWDOgORmztfTZi1+IN0RnaI/q47uM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mUYoOwvOuF4LdCFoLhYliXtHs9zuYOSfzR388fCluI4435BPzRQms35ZdS4cjG+/b
         87Dlt47vHmJvxbyQdB5ByAWBdHRbWwAQ3aIeWnc6m/rLID4rrbTFEctCDN5a5K8QMC
         ST2WiPaQ9LMlAmjn9JMYShQGvhYFS1+F5oH4oTsg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAOCdB019982;
        Fri, 21 Sep 2018 05:24:12 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:24:12 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:24:12 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtS032280;
        Fri, 21 Sep 2018 05:24:07 -0500
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
Subject: [RFC PATCH 24/40] PCI: keystone: Move initializations to appropriate places
Date:   Fri, 21 Sep 2018 15:51:39 +0530
Message-ID: <20180921102155.22839-25-kishon@ti.com>
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

No functional change. Move host specific platform_get_resource to
ks_add_pcie_port and the common platform_get_resource (applicable
to both host and endpoint) to probe. This is in preparation for
adding endpoint support to pci-keystone driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 27 +++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 75d007148804..13e865f82f96 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -646,11 +646,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	struct resource *res;
 	int ret;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
-	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
 	if (IS_ERR(pp->va_cfg0_base))
@@ -658,13 +653,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 
 	pp->va_cfg1_base = pp->va_cfg0_base;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
-	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ks_pcie->va_app_base))
-		return PTR_ERR(ks_pcie->va_app_base);
-
-	ks_pcie->app = *res;
-
 	pp->ops = &ks_pcie_host_ops;
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
@@ -768,6 +756,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
 	struct device_link **link;
+	struct resource *res;
+	void __iomem *base;
 	u32 num_viewport;
 	struct phy **phy;
 	u32 num_lanes;
@@ -784,6 +774,19 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
+	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ks_pcie->va_app_base))
+		return PTR_ERR(ks_pcie->va_app_base);
+
+	ks_pcie->app = *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
+	base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pci->dbi_base = base;
 	pci->dev = dev;
 	pci->ops = &ks_pcie_dw_pcie_ops;
 
-- 
2.17.1

