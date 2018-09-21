Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A85ECE562
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A7721547
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iTm1mbld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A7721547
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbeIUQMa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35098 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389593AbeIUQM3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:12:29 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LANr3c030515;
        Fri, 21 Sep 2018 05:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525433;
        bh=WEywuUrRC8xwixfpR6xUMddJoaV2XLaFqJWCxARGqp4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iTm1mbldLKmFlacCbfFV4kwhBKNH9qCKTdFyhcBbmzwWNAQtqGu6UJ770JuLsJxz3
         SN8RE3QnJ2mYoccoOtzug7RH6Huw/syt85R3UbuGVyDOZCvk9bvkoN4BALNe1FYrgK
         2/+GiPCF/cWMuYmSbhA6nRRw9iRnnIIvrJu34bEM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LANrkt030309;
        Fri, 21 Sep 2018 05:23:53 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:23:53 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:23:53 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtO032280;
        Fri, 21 Sep 2018 05:23:49 -0500
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
Subject: [RFC PATCH 20/40] PCI: keystone: Cleanup ks_pcie_link_up()
Date:   Fri, 21 Sep 2018 15:51:35 +0530
Message-ID: <20180921102155.22839-21-kishon@ti.com>
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

ks_pcie_link_up() uses registers from the designware core to get the
status of the link. Move the register defines to pcie-designware.h
and cleanup ks_pcie_link_up().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c    | 10 +++-------
 drivers/pci/controller/dwc/pcie-designware.h |  4 ++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 728b1e0db314..240c39c58b0f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -38,8 +38,6 @@
 
 /* Application register defines */
 #define LTSSM_EN_VAL		        BIT(0)
-#define LTSSM_STATE_MASK		0x1f
-#define LTSSM_STATE_L0			0x11
 #define DBI_CS2				BIT(5)
 #define OB_XLAT_EN_VAL		        BIT(1)
 
@@ -87,9 +85,6 @@
 
 #define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
 
-/* Config space registers */
-#define DEBUG0				0x728
-
 /* PCIE controller device IDs */
 #define PCIE_RC_K2HK		0xb008
 #define PCIE_RC_K2E		0xb009
@@ -308,8 +303,9 @@ static int ks_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
-	val = dw_pcie_readl_dbi(pci, DEBUG0);
-	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
+	val &= PORT_LOGIC_LTSSM_STATE_MASK;
+	return (val == PORT_LOGIC_LTSSM_STATE_L0);
 }
 
 static void ks_pcie_quirk(struct pci_dev *dev)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 96126fd8403c..a4d939536faf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -37,6 +37,10 @@
 #define PORT_LINK_MODE_4_LANES		(0x7 << 16)
 #define PORT_LINK_MODE_8_LANES		(0xf << 16)
 
+#define PCIE_PORT_DEBUG0		0x728
+#define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
+#define PORT_LOGIC_LTSSM_STATE_L0	0x11
+
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
 #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
 #define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
-- 
2.17.1

