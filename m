Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFADFECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53C6214C3
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CyKZS0qX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53C6214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeJQPjJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:39:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60848 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeJQPjJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:39:09 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9H7gQ0H053634;
        Wed, 17 Oct 2018 02:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539762146;
        bh=3tXh12gfv3WvFLRLSwdcwjJwvsr30mtoDMXXxlprXFE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CyKZS0qXubukKiPNUnJCrrGtmIm6RtJDySiGSU6pcGpYSCQWdHhSYDO57pyJZwASk
         2gwP4UjXrCbz2Vl+kJHeyuQLuV/E0XAdHzGld5Fi65wjwO7iyby7MZpCNZunhtZ0SS
         0W7Mh1f0PrOSCxD6ircnsFPKPTz4N4uAB46Ev8rk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7gQfG009378;
        Wed, 17 Oct 2018 02:42:26 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 17
 Oct 2018 02:42:26 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 17 Oct 2018 02:42:26 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fgSX009413;
        Wed, 17 Oct 2018 02:42:23 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 12/21] PCI: keystone: Invoke pm_runtime APIs to enable clock
Date:   Wed, 17 Oct 2018 13:11:05 +0530
Message-ID: <20181017074114.28239-13-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
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
 drivers/pci/controller/dwc/pci-keystone.c | 28 ++++++++++-------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5ae73c185c99..4f764ec49a4c 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -96,7 +96,6 @@
 
 struct keystone_pcie {
 	struct dw_pcie		*pci;
-	struct	clk		*clk;
 	/* PCI Device ID */
 	u32			device_id;
 	int			num_legacy_host_irqs;
@@ -989,26 +988,22 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, ks_pcie);
-	ks_pcie->clk = devm_clk_get(dev, "pcie");
-	if (IS_ERR(ks_pcie->clk)) {
-		dev_err(dev, "Failed to get pcie rc clock\n");
-		ret = PTR_ERR(ks_pcie->clk);
-		goto err_phy;
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed\n");
+		goto err_get_sync;
 	}
 
-	ret = clk_prepare_enable(ks_pcie->clk);
-	if (ret)
-		goto err_phy;
-
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
-		goto fail_clk;
+		goto err_get_sync;
 
 	return 0;
-fail_clk:
-	clk_disable_unprepare(ks_pcie->clk);
 
-err_phy:
+err_get_sync:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
 
 err_link:
@@ -1023,10 +1018,11 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
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

