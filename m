Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCDDC282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 11:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297B521872
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 11:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tLpIty/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfBGLcq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:32:46 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59780 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbfBGLcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2019 06:32:45 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17BWRmB103886;
        Thu, 7 Feb 2019 05:32:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549539147;
        bh=Wg8eVVcGkCEzwPn38RuwoHwNSdtUXqnC8EdiJtBZloY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tLpIty/t5r+KKx0kDyOy+7/J5r4HfJqhRu8ssl9lI0ymMf7zzfsBkpxghenvO5tgv
         lcIHIJdCTnRPf4SoOr3m3k+Vlj9K0H05rKidDoaBVjMfHriXAa8r27kSLPlGG4isR3
         v1+Ae7uvSD3oQHJYz3FjYt4GBMeic4NMC7+L2bdc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17BWRUF017205
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 05:32:27 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 05:32:27 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 05:32:27 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17BVxas026282;
        Thu, 7 Feb 2019 05:32:24 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 8/9] PCI: dwc: Remove Keystone specific dw_pcie_host_ops
Date:   Thu, 7 Feb 2019 16:39:23 +0530
Message-ID: <20190207110924.30716-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207110924.30716-1-kishon@ti.com>
References: <20190207110924.30716-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that Keystone started using it's own msi_irq_chip, remove
Keystone specific callback function defined in dw_pcie_host_ops.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 45 ++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h  |  5 ---
 2 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 042de09b0451..9492b05e8ff0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -126,18 +126,12 @@ static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
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
-		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
-	else
-		msg->data = data->hwirq;
+	msg->data = data->hwirq;
 
 	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
 		(int)data->hwirq, msg->address_hi, msg->address_lo);
@@ -157,17 +151,13 @@ static void dw_pci_bottom_mask(struct irq_data *data)
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	if (pp->ops->msi_clear_irq) {
-		pp->ops->msi_clear_irq(pp, data->hwirq);
-	} else {
-		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
-		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
+	ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-		pp->irq_status[ctrl] &= ~(1 << bit);
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
-				    ~pp->irq_status[ctrl]);
-	}
+	pp->irq_status[ctrl] &= ~(1 << bit);
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
+			    ~pp->irq_status[ctrl]);
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
@@ -180,17 +170,13 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	if (pp->ops->msi_set_irq) {
-		pp->ops->msi_set_irq(pp, data->hwirq);
-	} else {
-		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
-		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
+	ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-		pp->irq_status[ctrl] |= 1 << bit;
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
-				    ~pp->irq_status[ctrl]);
-	}
+	pp->irq_status[ctrl] |= 1 << bit;
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
+			    ~pp->irq_status[ctrl]);
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
@@ -209,9 +195,6 @@ static void dw_pci_bottom_ack(struct irq_data *d)
 
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
 
-	if (pp->ops->msi_irq_ack)
-		pp->ops->msi_irq_ack(d->hwirq, pp);
-
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 95e0c3c93f48..ea4b215b605d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -142,14 +142,9 @@ struct dw_pcie_host_ops {
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

