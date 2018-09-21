Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3328ECE562
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869462154B
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SrRhTJTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869462154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390082AbeIUQMn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35132 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389022AbeIUQMm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:12:42 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LAO7nP030566;
        Fri, 21 Sep 2018 05:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525447;
        bh=WfasnAWlcLsVQTlj7zbQefyfmRm0OJVS8gwd8Y4RkZE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SrRhTJTz9S1YGp1cSnqA9NSf+jCq0J0fPTAw2g58MEk803aF/ww1fL9j8nkVah+er
         C1Yx6OpQL/p4jhS1qWtd4+dubliONkeS2nKYIRPYbzeljqV9VX1/QiVhp2FpsbGk/D
         eM0E8OeDURs5LzqGK1UdgyblacV8X/0ah+KRlb8Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAO7K6019745;
        Fri, 21 Sep 2018 05:24:07 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:24:07 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:24:07 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtR032280;
        Fri, 21 Sep 2018 05:24:03 -0500
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
Subject: [RFC PATCH 23/40] PCI: keystone: Cleanup macros defined in pci-keystone.c
Date:   Fri, 21 Sep 2018 15:51:38 +0530
Message-ID: <20180921102155.22839-24-kishon@ti.com>
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

No functional change. Cleanup macros defined in pci-keystone.c
by removing unused macros, grouping the macros and aligning
it properly.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 41 +++++++++--------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index b1dfaea29530..75d007148804 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -28,21 +28,14 @@
 
 #include "pcie-designware.h"
 
-#define DRIVER_NAME	"keystone-pcie"
-
 #define PCIE_VENDORID_MASK	0xffff
 #define PCIE_DEVICEID_SHIFT	16
 
-/* DEV_STAT_CTRL */
-#define PCIE_CAP_BASE		0x70
-
-/* Application register defines */
-#define LTSSM_EN_VAL		        BIT(0)
-#define DBI_CS2				BIT(5)
-#define OB_XLAT_EN_VAL		        BIT(1)
-
 /* Application registers */
 #define CMD_STATUS			0x004
+#define LTSSM_EN_VAL		        BIT(0)
+#define OB_XLAT_EN_VAL		        BIT(1)
+#define DBI_CS2				BIT(5)
 
 #define CFG_SETUP			0x008
 #define CFG_BUS(x)			(((x) & 0xff) << 16)
@@ -65,18 +58,16 @@
 #define IRQ_ENABLE_SET(n)		(0x188 + ((n) << 4))
 #define INTx_EN				BIT(0)
 
-/* Error IRQ bits */
-#define ERR_AER		BIT(5)	/* ECRC error */
-#define ERR_AXI		BIT(4)	/* AXI tag lookup fatal error */
-#define ERR_CORR	BIT(3)	/* Correctable error */
-#define ERR_NONFATAL	BIT(2)	/* Non-fatal error */
-#define ERR_FATAL	BIT(1)	/* Fatal error */
-#define ERR_SYS		BIT(0)	/* System (fatal, non-fatal, or correctable) */
-#define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
-			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
 #define ERR_IRQ_STATUS			0x1c4
 #define ERR_IRQ_ENABLE_SET		0x1c8
-#define ERR_IRQ_ENABLE_CLR		0x1cc
+#define ERR_AER				BIT(5)	/* ECRC error */
+#define ERR_AXI				BIT(4)	/* AXI tag lookup fatal error */
+#define ERR_CORR			BIT(3)	/* Correctable error */
+#define ERR_NONFATAL			BIT(2)	/* Non-fatal error */
+#define ERR_FATAL			BIT(1)	/* Fatal error */
+#define ERR_SYS				BIT(0)	/* System error */
+#define ERR_IRQ_ALL			(ERR_AER | ERR_AXI | ERR_CORR | \
+					 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
 
 #define OB_OFFSET_INDEX(n)		(0x200 + (8 * (n)))
 #define OB_ENABLEN			BIT(0)
@@ -84,12 +75,12 @@
 #define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
 
 /* PCIE controller device IDs */
-#define PCIE_RC_K2HK		0xb008
-#define PCIE_RC_K2E		0xb009
-#define PCIE_RC_K2L		0xb00a
-#define PCIE_RC_K2G		0xb00b
+#define PCIE_RC_K2HK			0xb008
+#define PCIE_RC_K2E			0xb009
+#define PCIE_RC_K2L			0xb00a
+#define PCIE_RC_K2G			0xb00b
 
-#define to_keystone_pcie(x)	dev_get_drvdata((x)->dev)
+#define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
 static int ks_pcie_start_link(struct dw_pcie *pci);
 static void ks_pcie_stop_link(struct dw_pcie *pci);
-- 
2.17.1

