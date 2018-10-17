Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0738ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BE321528
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tpbOnIqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BE321528
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeJQPhc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:37:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60686 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeJQPhb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:37:31 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9H7gnPx054000;
        Wed, 17 Oct 2018 02:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539762169;
        bh=sZcazpbS9Y17cY1LGKKU1Lsa75B3lB78WemeAxANuhg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tpbOnIqXd1oBSfZlbO+X+DDrMA6mCL7mVF97GYrlsqE88R5+3ty56YawYkqZJja5Q
         vezQOU6AeoNCbcBrsQGDwEQkTOa460wYxXioPK5qQ2U713uZENeTT7GAURSyEE2uVu
         bPgZL7nc3Kgd4mVAW7nVBbR5VFgO18+6YXykyV+4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7gnm9025701;
        Wed, 17 Oct 2018 02:42:49 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 17
 Oct 2018 02:42:50 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 17 Oct 2018 02:42:49 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fgSe009413;
        Wed, 17 Oct 2018 02:42:46 -0500
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
Subject: [PATCH v2 19/21] PCI: keystone: Add debug error message for all errors
Date:   Wed, 17 Oct 2018 13:11:12 +0530
Message-ID: <20181017074114.28239-20-kishon@ti.com>
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

commit 025dd3daeda77f61a280da87ae701 ("PCI: keystone: Add error IRQ
handler") added dev_err() message only for ERR_AXI and ERR_FATAL. Add
debug error message for ERR_SYS, ERR_NONFATAL, ERR_CORR and ERR_AER here.

While at that avoid using ERR_IRQ_STATUS_RAW and use ERR_IRQ_STATUS
instead.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 32 ++++++++++++++++-------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index c0bba7b604fa..e9e646acc2d5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -79,7 +79,6 @@
 #define ERR_SYS		BIT(0)	/* System (fatal, non-fatal, or correctable) */
 #define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
 			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
-#define ERR_FATAL_IRQ	(ERR_FATAL | ERR_AXI)
 #define ERR_IRQ_STATUS			0x1c4
 #define ERR_IRQ_ENABLE_SET		0x1c8
 #define ERR_IRQ_ENABLE_CLR		0x1cc
@@ -246,18 +245,33 @@ static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 
 static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 {
-	u32 status;
+	u32 reg;
+	struct device *dev = ks_pcie->pci->dev;
 
-	status = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS);
-	if (!status)
+	reg = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS);
+	if (!reg)
 		return IRQ_NONE;
 
-	if (status & ERR_FATAL_IRQ)
-		dev_err(ks_pcie->pci->dev, "fatal error (status %#010x)\n",
-			status);
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
 
-	/* Ack the IRQ; status bits are RW1C */
-	ks_pcie_app_writel(ks_pcie, ERR_IRQ_STATUS, status);
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1

