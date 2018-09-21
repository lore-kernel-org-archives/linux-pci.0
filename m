Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32434C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A36206B7
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q7dw3roj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A36206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390202AbeIUQQn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:16:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35062 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389908AbeIUQMR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:12:17 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LANdqB030486;
        Fri, 21 Sep 2018 05:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525419;
        bh=dOWDR36pioDR/ZSigw8rJelA/kEL89WVadMViv1+T0A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Q7dw3rojv6JYmtbMq43WgOlsuZehYcIa3yT7ITZ2/RuCiJFtYwHqHEsCtPj7s5Avb
         jI+K+ugoIbAqhQlel7dJyIa22sBlU8UQIaKLXU04gwoaZaz87PYXE4icphp785H7vm
         LdH9++4feQlJksZ8NAO8SGXDxq/T06RmMEodeJBc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LANdBU018812;
        Fri, 21 Sep 2018 05:23:39 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:23:39 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:23:39 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtL032280;
        Fri, 21 Sep 2018 05:23:35 -0500
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
Subject: [RFC PATCH 17/40] PCI: keystone: Cleanup configuration space access
Date:   Fri, 21 Sep 2018 15:51:32 +0530
Message-ID: <20180921102155.22839-18-kishon@ti.com>
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

Cleanup configuration space access by removing ks_pcie_cfg_setup
which has an unncessary check of "if (bus == 0)" which will never be the
case of *_other_conf() and adding macros for configuring the CFG_SETUP
register required for accessing the configuration space of the device.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 70 +++++++----------------
 1 file changed, 20 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index f230344e1f4e..3ead1162235f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -45,7 +45,13 @@
 
 /* Application registers */
 #define CMD_STATUS			0x004
+
 #define CFG_SETUP			0x008
+#define CFG_BUS(x)			(((x) & 0xff) << 16)
+#define CFG_DEVICE(x)			(((x) & 0x1f) << 8)
+#define CFG_FUNC(x)			((x) & 0x7)
+#define CFG_TYPE1			BIT(24)
+
 #define OB_SIZE				0x030
 #define CFG_PCIM_WIN_SZ_IDX		3
 #define CFG_PCIM_WIN_CNT		32
@@ -261,60 +267,21 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	ks_pcie_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
 }
 
-/**
- * ks_pcie_cfg_setup() - Set up configuration space address for a device
- *
- * @ks_pcie: ptr to keystone_pcie structure
- * @bus: Bus number the device is residing on
- * @devfn: device, function number info
- *
- * Forms and returns the address of configuration space mapped in PCIESS
- * address space 0.  Also configures CFG_SETUP for remote configuration space
- * access.
- *
- * The address space has two regions to access configuration - local and remote.
- * We access local region for bus 0 (as RC is attached on bus 0) and remote
- * region for others with TYPE 1 access when bus > 1.  As for device on bus = 1,
- * we will do TYPE 0 access as it will be on our secondary bus (logical).
- * CFG_SETUP is needed only for remote configuration access.
- */
-static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *ks_pcie, u8 bus,
-				       unsigned int devfn)
-{
-	u8 device = PCI_SLOT(devfn), function = PCI_FUNC(devfn);
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	u32 regval;
-
-	if (bus == 0)
-		return pci->dbi_base;
-
-	regval = (bus << 16) | (device << 8) | function;
-
-	/*
-	 * Since Bus#1 will be a virtual bus, we need to have TYPE0
-	 * access only.
-	 * TYPE 1
-	 */
-	if (bus != 1)
-		regval |= BIT(24);
-
-	ks_pcie_app_writel(ks_pcie, CFG_SETUP, regval);
-	return pp->va_cfg0_base;
-}
-
 static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				 unsigned int devfn, int where, int size,
 				 u32 *val)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-	u8 bus_num = bus->number;
-	void __iomem *addr;
+	u32 reg;
 
-	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
+	reg = CFG_BUS(bus->number) | CFG_DEVICE(PCI_SLOT(devfn)) |
+		CFG_FUNC(PCI_FUNC(devfn));
+	if (bus->parent->number != pp->root_bus_nr)
+		reg |= CFG_TYPE1;
+	ks_pcie_app_writel(ks_pcie, CFG_SETUP, reg);
 
-	return dw_pcie_read(addr + where, size, val);
+	return dw_pcie_read(pp->va_cfg0_base + where, size, val);
 }
 
 static int ks_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
@@ -323,12 +290,15 @@ static int ks_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-	u8 bus_num = bus->number;
-	void __iomem *addr;
+	u32 reg;
 
-	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
+	reg = CFG_BUS(bus->number) | CFG_DEVICE(PCI_SLOT(devfn)) |
+		CFG_FUNC(PCI_FUNC(devfn));
+	if (bus->parent->number != pp->root_bus_nr)
+		reg |= CFG_TYPE1;
+	ks_pcie_app_writel(ks_pcie, CFG_SETUP, reg);
 
-	return dw_pcie_write(addr + where, size, val);
+	return dw_pcie_write(pp->va_cfg0_base + where, size, val);
 }
 
 /**
-- 
2.17.1

