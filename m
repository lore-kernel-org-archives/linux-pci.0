Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A3AC433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FEC2150E
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="upjlIGZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FEC2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389759AbeIUQLx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:11:53 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51308 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUQLx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:11:53 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LAMlRp033016;
        Fri, 21 Sep 2018 05:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525367;
        bh=+JP9mVYOekfJBvJujjojWZ3FMQbKVAMaaTSl9wsQ4nA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=upjlIGZsZwDrAZaN6mjdJRQuvI23vmtYkT3EWLUgTn1I+BlaGkinTMsqIs6KeudnD
         dow5cvVpW6KZgbJRZBJAG6tap2+jKpxU6upvJv148M66bd18jtOFZkyNx9PsnLFNhS
         QPEvI9H7rZwo3OwiVoASYdjr9eO8MRzqftCviPQY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMlie029034;
        Fri, 21 Sep 2018 05:22:47 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:22:47 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:22:47 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtA032280;
        Fri, 21 Sep 2018 05:22:43 -0500
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
Subject: [RFC PATCH 06/40] PCI: keystone: Add start_link/stop_link dw_pcie_ops
Date:   Fri, 21 Sep 2018 15:51:21 +0530
Message-ID: <20180921102155.22839-7-kishon@ti.com>
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

Add start_link/stop_link dw_pcie_ops and invoke ks_pcie_start_link
directly from host_init. This will also be required for adding EP
support.

While at that also use BIT() for LTSSM_EN_VAL.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone-dw.c |  9 +++-
 drivers/pci/controller/dwc/pci-keystone.c    | 51 +++++++++++---------
 drivers/pci/controller/dwc/pci-keystone.h    |  3 +-
 3 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone-dw.c b/drivers/pci/controller/dwc/pci-keystone-dw.c
index 4bd6c6e2b177..ce399232cd99 100644
--- a/drivers/pci/controller/dwc/pci-keystone-dw.c
+++ b/drivers/pci/controller/dwc/pci-keystone-dw.c
@@ -21,7 +21,7 @@
 #include "pci-keystone.h"
 
 /* Application register defines */
-#define LTSSM_EN_VAL		        1
+#define LTSSM_EN_VAL		        BIT(0)
 #define LTSSM_STATE_MASK		0x1f
 #define LTSSM_STATE_L0			0x11
 #define DBI_CS2_EN_VAL			0x20
@@ -418,7 +418,7 @@ int ks_dw_pcie_link_up(struct dw_pcie *pci)
 	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
 }
 
-void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
+void ks_dw_pcie_stop_link(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
 
@@ -426,6 +426,11 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
 	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
 	val &= ~LTSSM_EN_VAL;
 	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+}
+
+void ks_dw_pcie_start_link(struct keystone_pcie *ks_pcie)
+{
+	u32 val;
 
 	/* Initiate Link Training */
 	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index f87ade2de711..24afc691443b 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -40,6 +40,9 @@
 
 #define to_keystone_pcie(x)	dev_get_drvdata((x)->dev)
 
+static int ks_pcie_start_link(struct dw_pcie *pci);
+static void ks_pcie_stop_link(struct dw_pcie *pci);
+
 static void quirk_limit_mrrs(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
@@ -83,26 +86,6 @@ static void quirk_limit_mrrs(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
 
-static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct device *dev = pci->dev;
-
-	if (dw_pcie_link_up(pci)) {
-		dev_info(dev, "Link already up\n");
-		return 0;
-	}
-
-	ks_dw_pcie_initiate_link_train(ks_pcie);
-
-	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pci))
-		return 0;
-
-	dev_err(dev, "phy link never came up\n");
-	return -ETIMEDOUT;
-}
-
 static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
@@ -263,7 +246,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	ks_pcie_establish_link(ks_pcie);
 	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
 	ks_pcie_setup_interrupts(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
@@ -279,7 +261,8 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	hook_fault_code(17, keystone_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
 
-	return 0;
+	ks_pcie_start_link(pci);
+	return dw_pcie_wait_for_link(pci);
 }
 
 static const struct dw_pcie_host_ops keystone_pcie_host_ops = {
@@ -358,7 +341,31 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	{ },
 };
 
+static int ks_pcie_start_link(struct dw_pcie *pci)
+{
+	struct device *dev = pci->dev;
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	if (dw_pcie_link_up(pci)) {
+		dev_WARN(dev, "Link already up\n");
+		return 0;
+	}
+
+	ks_dw_pcie_start_link(ks_pcie);
+
+	return 0;
+}
+
+static void ks_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	ks_dw_pcie_stop_link(ks_pcie);
+}
+
 static const struct dw_pcie_ops dw_pcie_ops = {
+	.start_link = ks_pcie_start_link,
+	.stop_link = ks_pcie_stop_link,
 	.link_up = ks_dw_pcie_link_up,
 };
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.h b/drivers/pci/controller/dwc/pci-keystone.h
index 4eacc263f157..a66deab626aa 100644
--- a/drivers/pci/controller/dwc/pci-keystone.h
+++ b/drivers/pci/controller/dwc/pci-keystone.h
@@ -47,7 +47,8 @@ int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		unsigned int devfn, int where, int size, u32 *val);
 void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie);
-void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie);
+void ks_dw_pcie_start_link(struct keystone_pcie *ks_pcie);
+void ks_dw_pcie_stop_link(struct keystone_pcie *ks_pcie);
 void ks_dw_pcie_msi_irq_ack(int i, struct pcie_port *pp);
 void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq);
 void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq);
-- 
2.17.1

