Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6065FECE562
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFB121547
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NXNlI2iH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFB121547
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390015AbeIUQMd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:33 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51406 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390016AbeIUQMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:12:33 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LANwdd033358;
        Fri, 21 Sep 2018 05:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525438;
        bh=JS8XxeiLDwlWjMuWVe6AENveVa8okkl8KrO0t1BBcnw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NXNlI2iH7IZY4U/SQ1UYE5vnYHF9vSqt0NJEbAtwBm2HaVPFS5CAeM7+QzOD2uNTI
         hljwJDGKsGEKeeKSx1ZeDlwLzDmgab+Z1qIw54DoV0GirZ1cHastPIv4d3ALjp3Ecg
         BWhvSJ0X34qQQSGXojVsi1Se0q4209csvmFrYAnU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LANwHA019071;
        Fri, 21 Sep 2018 05:23:58 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:23:58 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:23:57 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtP032280;
        Fri, 21 Sep 2018 05:23:53 -0500
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
Subject: [RFC PATCH 21/40] PCI: keystone: Add debug error message for all errors
Date:   Fri, 21 Sep 2018 15:51:36 +0530
Message-ID: <20180921102155.22839-22-kishon@ti.com>
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

commit 025dd3daeda77f61a280da87ae701 ("PCI: keystone: Add error IRQ
handler") added dev_err() message only for ERR_AXI and ERR_FATAL. Add
debug error message for ERR_SYS, ERR_NONFATAL, ERR_CORR and ERR_AER here.

While at that avoid using ERR_IRQ_STATUS_RAW and use ERR_IRQ_STATUS
instead.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 45 +++++++++++++----------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 240c39c58b0f..a3dec74da70c 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -74,8 +74,6 @@
 #define ERR_SYS		BIT(0)	/* System (fatal, non-fatal, or correctable) */
 #define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
 			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
-#define ERR_FATAL_IRQ	(ERR_FATAL | ERR_AXI)
-#define ERR_IRQ_STATUS_RAW		0x1c0
 #define ERR_IRQ_STATUS			0x1c4
 #define ERR_IRQ_ENABLE_SET		0x1c8
 #define ERR_IRQ_ENABLE_CLR		0x1cc
@@ -180,23 +178,6 @@ static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
 }
 
-static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
-{
-	u32 status;
-
-	status = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
-	if (!status)
-		return IRQ_NONE;
-
-	if (status & ERR_FATAL_IRQ)
-		dev_err(ks_pcie->pci->dev, "fatal error (status %#010x)\n",
-			status);
-
-	/* Ack the IRQ; status bits are RW1C */
-	ks_pcie_app_writel(ks_pcie, ERR_IRQ_STATUS, status);
-	return IRQ_HANDLED;
-}
-
 /**
  * ks_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask
  * registers
@@ -636,9 +617,33 @@ static const struct dw_pcie_host_ops ks_pcie_host_ops = {
 
 static irqreturn_t ks_pcie_err_irq_handler(int irq, void *priv)
 {
+	u32 reg;
 	struct keystone_pcie *ks_pcie = priv;
+	struct device *dev = ks_pcie->pci->dev;
 
-	return ks_pcie_handle_error_irq(ks_pcie);
+	reg = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS);
+
+	if (reg & ERR_SYS)
+		dev_err(dev, "System Error\n");
+
+	if (reg & ERR_FATAL)
+		dev_err(dev, "Fatal Error\n");
+
+	if (reg & ERR_NONFATAL)
+		dev_dbg(dev, "Non Fatal Error\n");
+
+	if (reg & ERR_CORR)
+		dev_dbg(dev, "Correctable Error\n");
+
+	if (reg & ERR_AXI)
+		dev_err(dev, "AXI tag lookup fatal Error\n");
+
+	if (reg & ERR_AER)
+		dev_err(dev, "ECRC Error\n");
+
+	ks_pcie_app_writel(ks_pcie, ERR_IRQ_STATUS, reg);
+
+	return IRQ_HANDLED;
 }
 
 static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
-- 
2.17.1

