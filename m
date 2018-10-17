Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40A8ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7634921526
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RnhcslOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7634921526
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJQPh2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:37:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60654 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeJQPh2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:37:28 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9H7ghFY053901;
        Wed, 17 Oct 2018 02:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539762163;
        bh=7J6+SCgM8p61/w90SEo09MilVPmCdhutv9TiE9uHRPU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RnhcslOhHQZXwSn6baYeJJu7tIaWD7mdPzbOtc4dvI/0L/lfC3lvEkNBCx9VhKHWs
         R24M92MjkBsdWgH5P0petDkrJ8HDeXW0lUvfYtrF3PVqP3ts5oGRiZ+IEpu+tNdXu+
         wuNFSb7V4s64NfNxkM6tG3Yzhc8gSNLifqp/EyLQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7ghLp009845;
        Wed, 17 Oct 2018 02:42:43 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 17
 Oct 2018 02:42:42 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 17 Oct 2018 02:42:42 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fgSc009413;
        Wed, 17 Oct 2018 02:42:40 -0500
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
Subject: [PATCH v2 17/21] PCI: keystone: Cleanup ks_pcie_link_up()
Date:   Wed, 17 Oct 2018 13:11:10 +0530
Message-ID: <20181017074114.28239-18-kishon@ti.com>
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

ks_pcie_link_up() uses registers from the designware core to get the
status of the link. Move the register defines to pcie-designware.h
and cleanup ks_pcie_link_up().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c    | 11 +++--------
 drivers/pci/controller/dwc/pcie-designware.h |  4 ++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 2decbaec81a3..e181e6277323 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -38,8 +38,6 @@
 
 /* Application register defines */
 #define LTSSM_EN_VAL		        BIT(0)
-#define LTSSM_STATE_MASK		0x1f
-#define LTSSM_STATE_L0			0x11
 #define DBI_CS2				BIT(5)
 #define OB_XLAT_EN_VAL		        BIT(1)
 
@@ -87,11 +85,7 @@
 #define ERR_IRQ_ENABLE_SET		0x1c8
 #define ERR_IRQ_ENABLE_CLR		0x1cc
 
-/* Config space registers */
-#define DEBUG0				0x728
-
 #define MAX_MSI_HOST_IRQS		8
-
 /* PCIE controller device IDs */
 #define PCIE_RC_K2HK		0xb008
 #define PCIE_RC_K2E		0xb009
@@ -442,8 +436,9 @@ static int ks_pcie_link_up(struct dw_pcie *pci)
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

