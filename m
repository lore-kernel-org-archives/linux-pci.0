Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9783ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9F421526
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hzehwcI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9F421526
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeJQPie (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:38:34 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42516 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeJQPie (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:38:34 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9H7fqQt017481;
        Wed, 17 Oct 2018 02:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539762112;
        bh=CywUeyvOfH1tI2pu+soQCfVILjgvnQbtM9JU52QtGcs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hzehwcI363/UzswH605VR/6vK5/In7YhbcSUM4s1dTxj+WxbuSY1zXI+5MonU4NdL
         4TnfRUT63iibKz5JXKDIq8w/NAt7eb/Qmag+MYwQqZg1Z6l3z3bAgbXLFo1gW2sdKf
         WugEL9pGoG/g3F4hH49dC/m+KIbNEfTPjPSFKv5Q=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fqD4023179;
        Wed, 17 Oct 2018 02:41:52 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 17
 Oct 2018 02:41:52 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 17 Oct 2018 02:41:52 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fgSN009413;
        Wed, 17 Oct 2018 02:41:49 -0500
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
Subject: [PATCH v2 02/21] PCI: keystone: Use quirk to set MRRS for PCI host bridge
Date:   Wed, 17 Oct 2018 13:10:55 +0530
Message-ID: <20181017074114.28239-3-kishon@ti.com>
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

Reuse the already existing quirk to set MRRS for PCI host bridge
instead of explicitly setting MRRS in ks_pcie_host_init.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 37 +++++++++--------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 7d43e10a03b0..5d9c5d199ada 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -43,7 +43,7 @@
 static void quirk_limit_mrrs(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge = bus->self;
+	struct pci_dev *bridge;
 	static const struct pci_device_id rc_pci_devids[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
 		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
@@ -57,7 +57,7 @@ static void quirk_limit_mrrs(struct pci_dev *dev)
 	};
 
 	if (pci_is_root_bus(bus))
-		return;
+		bridge = dev;
 
 	/* look for the host bridge */
 	while (!pci_is_root_bus(bus)) {
@@ -65,18 +65,19 @@ static void quirk_limit_mrrs(struct pci_dev *dev)
 		bus = bus->parent;
 	}
 
-	if (bridge) {
-		/*
-		 * Keystone PCI controller has a h/w limitation of
-		 * 256 bytes maximum read request size.  It can't handle
-		 * anything higher than this.  So force this limit on
-		 * all downstream devices.
-		 */
-		if (pci_match_id(rc_pci_devids, bridge)) {
-			if (pcie_get_readrq(dev) > 256) {
-				dev_info(&dev->dev, "limiting MRRS to 256\n");
-				pcie_set_readrq(dev, 256);
-			}
+	if (!bridge)
+		return;
+
+	/*
+	 * Keystone PCI controller has a h/w limitation of
+	 * 256 bytes maximum read request size.  It can't handle
+	 * anything higher than this.  So force this limit on
+	 * all downstream devices.
+	 */
+	if (pci_match_id(rc_pci_devids, bridge)) {
+		if (pcie_get_readrq(dev) > 256) {
+			dev_info(&dev->dev, "limiting MRRS to 256\n");
+			pcie_set_readrq(dev, 256);
 		}
 	}
 }
@@ -264,7 +265,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-	u32 val;
 
 	ks_pcie_establish_link(ks_pcie);
 	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
@@ -275,13 +275,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	/* update the Vendor ID */
 	writew(ks_pcie->device_id, pci->dbi_base + PCI_DEVICE_ID);
 
-	/* update the DEV_STAT_CTRL to publish right mrrs */
-	val = readl(pci->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
-	val &= ~PCI_EXP_DEVCTL_READRQ;
-	/* set the mrrs to 256 bytes */
-	val |= BIT(12);
-	writel(val, pci->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
-
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
 	 * "External aborts"
-- 
2.17.1

