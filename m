Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF99C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 10:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979C4218B0
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 10:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MEuxnSi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfCUKA6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:00:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51212 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfCUKA5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 06:00:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LA0kaO075277;
        Thu, 21 Mar 2019 05:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553162446;
        bh=HpbO8XiCvTyATuLouCiR5pn/exwKUCHNGg7zD44XRRg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MEuxnSi8JQ+tQd7Q/ZvAKXpxc3TVn9tW4L3k0RJ//HReXGaGFaUPBOcp1HrbThZTr
         nKPPAaWuABk9OIMHQmi1M6FguNblAM3lpz4lNHitMQXwawMSZ9MlFHu1mhqc1VveV2
         wNJxjHIa30028lVutyWBhpNDt5kJ7BI+cPK/jG6A=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LA0j8k094004
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 05:00:46 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 05:00:45 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 05:00:45 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LA0KOD014903;
        Thu, 21 Mar 2019 05:00:42 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 7/8] PCI: dwc: Remove Keystone specific dw_pcie_host_ops
Date:   Thu, 21 Mar 2019 15:29:26 +0530
Message-ID: <20190321095927.7058-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190321095927.7058-1-kishon@ti.com>
References: <20190321095927.7058-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that Keystone started using its own msi_irq_chip, remove
Keystone specific callback functions defined in dw_pcie_host_ops.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 50 ++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h  |  5 --
 2 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9e47bad82bbc..498422397609 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -126,18 +126,12 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	u64 msi_target;
 
-	if (pp->ops->get_msi_addr)
-		msi_target = pp->ops->get_msi_addr(pp);
-	else
-		msi_target = (u64)pp->msi_data;
+	msi_target = (u64)pp->msi_data;
 
 	msg->address_lo = lower_32_bits(msi_target);
 	msg->address_hi = upper_32_bits(msi_target);
 
-	if (pp->ops->get_msi_data)
-		msg->data = pp->ops->get_msi_data(pp, d->hwirq);
-	else
-		msg->data = d->hwirq;
+	msg->data = d->hwirq;
 
 	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
 		(int)d->hwirq, msg->address_hi, msg->address_lo);
@@ -157,17 +151,13 @@ static void dw_pci_bottom_mask(struct irq_data *d)
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	if (pp->ops->msi_clear_irq) {
-		pp->ops->msi_clear_irq(pp, d->hwirq);
-	} else {
-		ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
-		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
+	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-		pp->irq_mask[ctrl] |= BIT(bit);
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
-				    pp->irq_mask[ctrl]);
-	}
+	pp->irq_mask[ctrl] |= BIT(bit);
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
+			    pp->irq_mask[ctrl]);
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
@@ -180,17 +170,13 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	if (pp->ops->msi_set_irq) {
-		pp->ops->msi_set_irq(pp, d->hwirq);
-	} else {
-		ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
-		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
+	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-		pp->irq_mask[ctrl] &= ~BIT(bit);
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
-				    pp->irq_mask[ctrl]);
-	}
+	pp->irq_mask[ctrl] &= ~BIT(bit);
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
+			    pp->irq_mask[ctrl]);
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
@@ -199,20 +185,12 @@ static void dw_pci_bottom_ack(struct irq_data *d)
 {
 	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
 	unsigned int res, bit, ctrl;
-	unsigned long flags;
 
 	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
 	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-	raw_spin_lock_irqsave(&pp->lock, flags);
-
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, BIT(bit));
-
-	if (pp->ops->msi_irq_ack)
-		pp->ops->msi_irq_ack(d->hwirq, pp);
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static struct irq_chip dw_pci_msi_bottom_irq_chip = {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 6b0cea473ee7..ca3a3190a6f5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -145,14 +145,9 @@ struct dw_pcie_host_ops {
 	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
 			     unsigned int devfn, int where, int size, u32 val);
 	int (*host_init)(struct pcie_port *pp);
-	void (*msi_set_irq)(struct pcie_port *pp, int irq);
-	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
-	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
-	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 	void (*scan_bus)(struct pcie_port *pp);
 	void (*set_num_vectors)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp);
-	void (*msi_irq_ack)(int irq, struct pcie_port *pp);
 };
 
 struct pcie_port {
-- 
2.17.1

