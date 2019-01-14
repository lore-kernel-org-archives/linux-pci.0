Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D6C43444
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 13:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB322086D
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 13:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mF9gl4t4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfANNZg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:25:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37158 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfANNZg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 08:25:36 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDPFgY098049;
        Mon, 14 Jan 2019 07:25:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547472315;
        bh=ZOxErDAenCR4nywVOJbopTCQfMydSgJQFf0ad6hjYzM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mF9gl4t4rXakuReor+2NmekbjsQHsDqFnPgnchwmK4VZN6lkWMgbMt2i9Hrbs9sVA
         5OjgHTqe7DqYPpyhsRIKH7tVjh0J2pQSEKQzrbFFNzrIbF6HrP7Ynw+qoh7LXh1csZ
         vwFIz4CZLWkI424EW72IKOGyj+wr0H50ETrC7zlE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDPFhj011765
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 07:25:15 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:25:15 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:25:15 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWQ028516;
        Mon, 14 Jan 2019 07:25:11 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-arm-kernel@axis.com>
Subject: [PATCH 04/24] PCI: keystone: Perform host initialization in a single function
Date:   Mon, 14 Jan 2019 18:54:04 +0530
Message-ID: <20190114132424.6445-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No functional change. Instead of having two functions
ks_pcie_add_pcie_port and ks_pcie_dw_host_init for initializing host,
have a single function to perform all the host initialization.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 63 +++++++++--------------
 1 file changed, 23 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index f63268aee2de..3f917ffa9105 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -446,45 +446,6 @@ static int ks_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
-/**
- * ks_pcie_dw_host_init() - initialize host for v3_65 dw hardware
- *
- * Ioremap the register resources, initialize legacy irq domain
- * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
- * PCI host controller.
- */
-static int __init ks_pcie_dw_host_init(struct keystone_pcie *ks_pcie)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	struct device *dev = pci->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *res;
-
-	/* Index 0 is the config reg. space address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
-
-	/*
-	 * We set these same and is used in pcie rd/wr_other_conf
-	 * functions
-	 */
-	pp->va_cfg0_base = pci->dbi_base + SPACE0_REMOTE_CFG_OFFSET;
-	pp->va_cfg1_base = pp->va_cfg0_base;
-
-	/* Index 1 is the application reg. space address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ks_pcie->va_app_base))
-		return PTR_ERR(ks_pcie->va_app_base);
-
-	ks_pcie->app = *res;
-
-	return dw_pcie_host_init(pp);
-}
-
 static void ks_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
@@ -826,10 +787,32 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
 	struct device *dev = &pdev->dev;
+	struct resource *res;
 	int ret;
 
+	/* Index 0 is the config reg. space address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	/*
+	 * We set these same and is used in pcie rd/wr_other_conf
+	 * functions
+	 */
+	pp->va_cfg0_base = pci->dbi_base + SPACE0_REMOTE_CFG_OFFSET;
+	pp->va_cfg1_base = pp->va_cfg0_base;
+
+	/* Index 1 is the application reg. space address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ks_pcie->va_app_base))
+		return PTR_ERR(ks_pcie->va_app_base);
+
+	ks_pcie->app = *res;
+
 	pp->ops = &ks_pcie_host_ops;
-	ret = ks_pcie_dw_host_init(ks_pcie);
+	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
 		return ret;
-- 
2.17.1

