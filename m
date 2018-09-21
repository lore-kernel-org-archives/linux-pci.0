Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2642ECE562
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C80221547
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bxhKx+6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C80221547
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389673AbeIUQOZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:14:25 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54720 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389264AbeIUQOY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:14:24 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LANnA1032939;
        Fri, 21 Sep 2018 05:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525429;
        bh=oDF6ndAYJvQk5lqs0pyCrinasCIrID1DOTXjY2ayVww=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bxhKx+6y89OzMZGYuHtzWPoV5lsR1NRkqPJTDy6pzxhxSt8B60pbKD93LOfvQaq4m
         3nWggHxBSbjAoR7kd7TMXv75vOkeZu1xGk+cbpae7kfJU0jSne+Dxb9FU2KEty4GXJ
         7qbDt5XdprYqDR238FiAsGpGwuMkPYXtKNAl03qw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LANn7P018958;
        Fri, 21 Sep 2018 05:23:49 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:23:48 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:23:48 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtN032280;
        Fri, 21 Sep 2018 05:23:44 -0500
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
Subject: [RFC PATCH 19/40] PCI: keystone: Cleanup set_dbi_mode and get_dbi_mode
Date:   Fri, 21 Sep 2018 15:51:34 +0530
Message-ID: <20180921102155.22839-20-kishon@ti.com>
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

No functional change. Use BIT() macro for DBI_CS2 and cleanup
set_dbimode and get_dbi_mode

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index d5304c4a1eb5..728b1e0db314 100644
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
@@ -214,11 +214,12 @@ static void ks_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
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
@@ -232,11 +233,12 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
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
 
 static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-- 
2.17.1

