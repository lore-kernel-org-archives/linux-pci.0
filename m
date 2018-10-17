Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2D7ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8F121526
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GYJwDdAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8F121526
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJQPiG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:38:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56666 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbeJQPhS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:37:18 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9H7gaY9023114;
        Wed, 17 Oct 2018 02:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539762156;
        bh=FfzFXLPNbsilytzbMI6f3NeFSQyDfAzyipYlHvzpNtg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GYJwDdAGcmBlsjtB9GbZAXeF90RTCftddN5n+UlSA+otWD5ajvlL2wmr13ce/axny
         ZnvKZL49sk1lf95IUqcC1OJ0RYLpCufUMnqc6XqkXHSouH5ytmSeYr/yw4HzClUy+M
         Ti3wy0Ya1dFCr9LW5JT/j893w8aIYDZGT3Kcv714=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7gaRI009658;
        Wed, 17 Oct 2018 02:42:36 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 17
 Oct 2018 02:42:36 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 17 Oct 2018 02:42:36 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fgSa009413;
        Wed, 17 Oct 2018 02:42:33 -0500
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
Subject: [PATCH v2 15/21] PCI: keystone: Cleanup outbound window configuration
Date:   Wed, 17 Oct 2018 13:11:08 +0530
Message-ID: <20181017074114.28239-16-kishon@ti.com>
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

Outbound translation window is configured in order to access the
PCIe card's MEM space. Cleanup outbound translation configuration
here by using BIT() macros, adding a macro for window size and
using lower_32_bits/upper_32_bits macros for configuring the 64 bit
offset in the outbound translation region.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 32 ++++++++++++-----------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 608e40c4b991..3576a184b9eb 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -41,7 +41,7 @@
 #define LTSSM_STATE_MASK		0x1f
 #define LTSSM_STATE_L0			0x11
 #define DBI_CS2_EN_VAL			0x20
-#define OB_XLAT_EN_VAL		        2
+#define OB_XLAT_EN_VAL		        BIT(1)
 
 /* Application registers */
 #define CMD_STATUS			0x004
@@ -53,10 +53,11 @@
 #define CFG_TYPE1			BIT(24)
 
 #define OB_SIZE				0x030
-#define CFG_PCIM_WIN_SZ_IDX		3
 #define SPACE0_REMOTE_CFG_OFFSET	0x1000
 #define OB_OFFSET_INDEX(n)		(0x200 + (8 * (n)))
 #define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
+#define OB_ENABLEN			BIT(0)
+#define OB_WIN_SIZE			8	/* 8MB */
 
 /* IRQ register defines */
 #define IRQ_EOI				0x050
@@ -341,12 +342,13 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 
 static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
+	u32 val;
 	u32 num_viewport = ks_pcie->num_viewport;
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
-	u32 start = pp->mem->start, end = pp->mem->end;
-	int i, tr_size;
-	u32 val;
+	u64 start = pp->mem->start;
+	u64 end = pp->mem->end;
+	int i;
 
 	/* Disable BARs for inbound access */
 	ks_pcie_set_dbi_mode(ks_pcie);
@@ -354,21 +356,21 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
 	ks_pcie_clear_dbi_mode(ks_pcie);
 
-	/* Set outbound translation size per window division */
-	ks_pcie_app_writel(ks_pcie, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
-
-	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
+	val = ilog2(OB_WIN_SIZE);
+	ks_pcie_app_writel(ks_pcie, OB_SIZE, val);
 
 	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
-	for (i = 0; (i < num_viewport) && (start < end); i++) {
-		ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
-		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
-		start += tr_size;
+	for (i = 0; i < num_viewport && (start < end); i++) {
+		ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i),
+				   lower_32_bits(start) | OB_ENABLEN);
+		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
+				   upper_32_bits(start));
+		start += OB_WIN_SIZE;
 	}
 
-	/* Enable OB translation */
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
+	val |= OB_XLAT_EN_VAL;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
 }
 
 static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-- 
2.17.1

