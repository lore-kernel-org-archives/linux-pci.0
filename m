Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E811AC04AA5
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 13:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F87620652
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 13:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eUy9kYp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F87620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeJOUzv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:55:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48124 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeJOUzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 16:55:51 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9FD8tv9123996;
        Mon, 15 Oct 2018 08:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539608935;
        bh=He8Fq8dDb7VaE4sGfTh4TQgicbK+y4tv+ZJka4yzZfE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eUy9kYp4lHBBh9ktkT2P0BV+bz3aI1q7/i5376OEalnGKJC3oE9Q7uYitUmy+wqte
         q9ftpsl5w60TXWraNTcbqM8SsvQi3QedhA5QcsZ98Vt5p0gD01fleCo7fPRbPOm8JW
         vVH8/UMHHnskfRzDgeDKXy6uLPiz3HdSqKNwjtAU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FD8tCG001005;
        Mon, 15 Oct 2018 08:08:55 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 08:08:55 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 08:08:55 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FD7tLJ009433;
        Mon, 15 Oct 2018 08:08:52 -0500
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
Subject: [PATCH 16/19] PCI: keystone: Cleanup ks_pcie_link_up()
Date:   Mon, 15 Oct 2018 18:37:18 +0530
Message-ID: <20181015130721.5535-17-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181015130721.5535-1-kishon@ti.com>
References: <20181015130721.5535-1-kishon@ti.com>
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
 drivers/pci/controller/dwc/pci-keystone.c    | 11 +++--------
 drivers/pci/controller/dwc/pcie-designware.h |  4 ++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 7015a353a614..67646a64c895 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -38,8 +38,6 @@
 
 /* Application register defines */
 #define LTSSM_EN_VAL		        BIT(0)
-#define LTSSM_STATE_MASK		0x1f
-#define LTSSM_STATE_L0			0x11
 #define DBI_CS2				BIT(5)
 #define OB_XLAT_EN_VAL		        BIT(1)
 
@@ -91,11 +89,7 @@
 
 #define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
 
-/* Config space registers */
-#define DEBUG0				0x728
-
 #define MAX_MSI_HOST_IRQS		8
-
 /* PCIE controller device IDs */
 #define PCIE_RC_K2HK		0xb008
 #define PCIE_RC_K2E		0xb009
@@ -446,8 +440,9 @@ static int ks_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
-	val = dw_pcie_readl_dbi(pci, DEBUG0);
-	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
+	val &= PORT_LOGIC_LTSSM_STATE_MASK;
+	return (val == PORT_LOGIC_LTSSM_STATE_L0);
 }
 
 static void ks_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9f1a5e399b70..0989d880ac46 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -36,6 +36,10 @@
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

