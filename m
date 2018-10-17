Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC67ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D9321528
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NaDmmUrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D9321528
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeJQPhX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:37:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56662 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeJQPhS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:37:18 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9H7gdO2023149;
        Wed, 17 Oct 2018 02:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539762159;
        bh=TJTKFDSXgapb2zFN4WzS4ePydA0M0F3UQ+j0dbzHS1Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NaDmmUrGsuN6+/FTceZnZveXi0OJRSpLwvSrwmnJRb8jqWkNydLJ9gibE0dS45cBx
         AbLMBJkXWVdPSbTWJTCajYes9utlZxSdsUKWuMsJoQ1E+aCgAX+AttmrH6DvUwAPUT
         298oCYDm9cb7MUaOeseUFGfwLbpO7Err6oO9QoeI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7gd2q025329;
        Wed, 17 Oct 2018 02:42:39 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 17
 Oct 2018 02:42:40 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 17 Oct 2018 02:42:39 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fgSb009413;
        Wed, 17 Oct 2018 02:42:36 -0500
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
Subject: [PATCH v2 16/21] PCI: keystone: Cleanup set_dbi_mode and get_dbi_mode
Date:   Wed, 17 Oct 2018 13:11:09 +0530
Message-ID: <20181017074114.28239-17-kishon@ti.com>
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

No functional change. Use BIT() macro for DBI_CS2 and cleanup
set_dbimode and get_dbi_mode

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 3576a184b9eb..2decbaec81a3 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -40,7 +40,7 @@
 #define LTSSM_EN_VAL		        BIT(0)
 #define LTSSM_STATE_MASK		0x1f
 #define LTSSM_STATE_L0			0x11
-#define DBI_CS2_EN_VAL			0x20
+#define DBI_CS2				BIT(5)
 #define OB_XLAT_EN_VAL		        BIT(1)
 
 /* Application registers */
@@ -315,11 +315,12 @@ static void ks_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
 	u32 val;
 
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, DBI_CS2_EN_VAL | val);
+	val |= DBI_CS2;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
 
 	do {
 		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	} while (!(val & DBI_CS2_EN_VAL));
+	} while (!(val & DBI_CS2));
 }
 
 /**
@@ -333,11 +334,12 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 	u32 val;
 
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, ~DBI_CS2_EN_VAL & val);
+	val &= ~DBI_CS2;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
 
 	do {
 		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	} while (val & DBI_CS2_EN_VAL);
+	} while (val & DBI_CS2);
 }
 
 static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
-- 
2.17.1

