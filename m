Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FE1C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 10:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9543720836
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 10:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QdwwbvMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfBUKSs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:18:48 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42098 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfBUKSs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 05:18:48 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1LAIanb053118;
        Thu, 21 Feb 2019 04:18:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550744316;
        bh=O91gWRkAPZIeJZ0Dq/o9XwGCH3T8ygNq4jnPeDJup+4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QdwwbvMUKBdIbwxTKwadx+2cvXEwSdYXFzfv1oI+vlXNc0RjwCOZVN+IJZlaTmbyW
         2wbxvWFEnA1QFupFroW1SlcrGxVZmb7mHO0zgMT3NFdBCmsseGjgE1Q8QVPcmHMxOH
         k6VIABc5DVkwzOBwQ961KCoS/K86LD50fEfefJuI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1LAIaeH070392
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 04:18:36 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 21
 Feb 2019 04:18:35 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 21 Feb 2019 04:18:35 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1LAIORI022198;
        Thu, 21 Feb 2019 04:18:33 -0600
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
Subject: [PATCH v4 3/9] PCI: keystone: Convert to using hierarchy domain for legacy interrupts
Date:   Thu, 21 Feb 2019 15:45:12 +0530
Message-ID: <20190221101518.22604-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221101518.22604-1-kishon@ti.com>
References: <20190221101518.22604-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

K2G provides separate IRQ lines for each of the four legacy interrupts.
Model this using hierarchy domain instead of linear domain with chained
IRQ handler.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 205 +++++++++++++---------
 1 file changed, 118 insertions(+), 87 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 47f0dcf638f2..7f1648453f54 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -61,6 +61,7 @@
 
 #define IRQ_STATUS(n)			(0x184 + ((n) << 4))
 #define IRQ_ENABLE_SET(n)		(0x188 + ((n) << 4))
+#define IRQ_ENABLE_CLR(n)		(0x18C + ((n) << 4))
 #define INTx_EN				BIT(0)
 
 #define ERR_IRQ_STATUS			0x1c4
@@ -87,7 +88,6 @@ struct keystone_pcie {
 	struct dw_pcie		*pci;
 	/* PCI Device ID */
 	u32			device_id;
-	int			legacy_host_irqs[PCI_NUM_INTX];
 	struct			device_node *legacy_intc_np;
 
 	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
@@ -96,7 +96,6 @@ struct keystone_pcie {
 	struct phy		**phy;
 	struct device_link	**link;
 	struct			device_node *msi_intc_np;
-	struct irq_domain	*legacy_irq_domain;
 	struct device_node	*np;
 
 	int error_irq;
@@ -199,26 +198,6 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
 	return dw_pcie_allocate_domains(pp);
 }
 
-static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
-				      int offset)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct device *dev = pci->dev;
-	u32 pending;
-	int virq;
-
-	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
-
-	if (BIT(0) & pending) {
-		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
-		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
-		generic_handle_irq(virq);
-	}
-
-	/* EOI the INTx interrupt */
-	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
-}
-
 static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 {
 	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
@@ -256,39 +235,117 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 	return IRQ_HANDLED;
 }
 
-static void ks_pcie_ack_legacy_irq(struct irq_data *d)
+void ks_pcie_irq_eoi(struct irq_data *data)
 {
+	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
+	irq_hw_number_t hwirq = data->hwirq;
+
+	ks_pcie_app_writel(ks_pcie, IRQ_EOI, hwirq);
+	irq_chip_eoi_parent(data);
 }
 
-static void ks_pcie_mask_legacy_irq(struct irq_data *d)
+void ks_pcie_irq_enable(struct irq_data *data)
 {
+	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
+	irq_hw_number_t hwirq = data->hwirq;
+
+	ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(hwirq), INTx_EN);
+	irq_chip_enable_parent(data);
 }
 
-static void ks_pcie_unmask_legacy_irq(struct irq_data *d)
+void ks_pcie_irq_disable(struct irq_data *data)
 {
+	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
+	irq_hw_number_t hwirq = data->hwirq;
+
+	ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_CLR(hwirq), INTx_EN);
+	irq_chip_disable_parent(data);
 }
 
 static struct irq_chip ks_pcie_legacy_irq_chip = {
-	.name = "Keystone-PCI-Legacy-IRQ",
-	.irq_ack = ks_pcie_ack_legacy_irq,
-	.irq_mask = ks_pcie_mask_legacy_irq,
-	.irq_unmask = ks_pcie_unmask_legacy_irq,
+	.name			= "Keystone-PCI-Legacy-IRQ",
+	.irq_enable		= ks_pcie_irq_enable,
+	.irq_disable		= ks_pcie_irq_disable,
+	.irq_eoi		= ks_pcie_irq_eoi,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
 };
 
-static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
-				       unsigned int irq,
-				       irq_hw_number_t hw_irq)
+static int ks_pcie_legacy_irq_domain_alloc(struct irq_domain *domain,
+					   unsigned int virq,
+					   unsigned int nr_irqs, void *data)
 {
-	irq_set_chip_and_handler(irq, &ks_pcie_legacy_irq_chip,
-				 handle_level_irq);
-	irq_set_chip_data(irq, d->host_data);
+	struct keystone_pcie *ks_pcie = domain->host_data;
+	struct device_node *np = ks_pcie->legacy_intc_np;
+	struct irq_fwspec parent_fwspec, *fwspec = data;
+	struct of_phandle_args out_irq;
+	int ret, i;
+
+	if (nr_irqs != 1)
+		return -EINVAL;
+
+	ret = of_irq_parse_one(np, fwspec->param[0], &out_irq);
+	if (ret < 0) {
+		pr_err("Failed to parse interrupt node\n");
+		return ret;
+	}
+
+	parent_fwspec.fwnode = &out_irq.np->fwnode;
+	parent_fwspec.param_count = out_irq.args_count;
+
+	for (i = 0; i < out_irq.args_count; i++)
+		parent_fwspec.param[i] = out_irq.args[i];
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
+	if (ret < 0) {
+		pr_err("Failed to allocate parent irq %u: %d\n",
+		       parent_fwspec.param[0], ret);
+		return ret;
+	}
+
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, fwspec->param[0],
+					    &ks_pcie_legacy_irq_chip, ks_pcie);
+	if (ret < 0) {
+		pr_err("Failed to set hwirq and chip\n");
+		goto err_set_hwirq_and_chip;
+	}
 
 	return 0;
+
+err_set_hwirq_and_chip:
+	irq_domain_free_irqs_parent(domain, virq, 1);
+
+	return ret;
+}
+
+static int ks_pcie_irq_domain_translate(struct irq_domain *domain,
+					struct irq_fwspec *fwspec,
+					unsigned long *hwirq,
+					unsigned int *type)
+{
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 2)
+			return -EINVAL;
+
+		if (fwspec->param[0] >= PCI_NUM_INTX)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1];
+
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static const struct irq_domain_ops ks_pcie_legacy_irq_domain_ops = {
-	.map = ks_pcie_init_legacy_irq_map,
-	.xlate = irq_domain_xlate_onetwocell,
+	.alloc		= ks_pcie_legacy_irq_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+	.translate	= ks_pcie_irq_domain_translate,
 };
 
 /**
@@ -572,35 +629,6 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-/**
- * ks_pcie_legacy_irq_handler() - Handle legacy interrupt
- * @irq: IRQ line for legacy interrupts
- * @desc: Pointer to irq descriptor
- *
- * Traverse through pending legacy interrupts and invoke handler for each. Also
- * takes care of interrupt controller level mask/ack operation.
- */
-static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
-{
-	unsigned int irq = irq_desc_get_irq(desc);
-	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct device *dev = pci->dev;
-	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
-
-	/*
-	 * The chained irq handler installation would have replaced normal
-	 * interrupt driver handler so we need to take care of mask/unmask and
-	 * ack operation.
-	 */
-	chained_irq_enter(chip, desc);
-	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
-	chained_irq_exit(chip, desc);
-}
-
 static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 {
 	struct device *dev = ks_pcie->pci->dev;
@@ -655,14 +683,33 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 	struct device *dev = ks_pcie->pci->dev;
 	struct irq_domain *legacy_irq_domain;
 	struct device_node *np = ks_pcie->np;
+	struct irq_domain *parent_domain;
+	struct device_node *parent_node;
 	struct device_node *intc_np;
-	int irq_count, irq, ret = 0, i;
+	int irq_count, ret = 0;
 
 	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
 	if (!intc_np) {
 		dev_warn(dev, "legacy-interrupt-controller node is absent\n");
 		return -EINVAL;
 	}
+	ks_pcie->legacy_intc_np = intc_np;
+
+	parent_node = of_irq_find_parent(intc_np);
+	if (!parent_node) {
+		dev_err(dev, "unable to obtain parent node\n");
+		ret = -ENXIO;
+		goto err;
+	}
+
+	parent_domain = irq_find_host(parent_node);
+	if (!parent_domain) {
+		dev_err(dev, "unable to obtain parent domain\n");
+		ret = -ENXIO;
+		goto err;
+	}
+
+	of_node_put(parent_node);
 
 	irq_count = of_irq_count(intc_np);
 	if (!irq_count) {
@@ -671,31 +718,15 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 		goto err;
 	}
 
-	for (i = 0; i < irq_count; i++) {
-		irq = irq_of_parse_and_map(intc_np, i);
-		if (!irq) {
-			ret = -EINVAL;
-			goto err;
-		}
-		ks_pcie->legacy_host_irqs[i] = irq;
-
-		irq_set_chained_handler_and_data(irq,
-						 ks_pcie_legacy_irq_handler,
-						 ks_pcie);
-	}
-
 	legacy_irq_domain =
-		irq_domain_add_linear(intc_np, PCI_NUM_INTX,
-				      &ks_pcie_legacy_irq_domain_ops, NULL);
+		irq_domain_add_hierarchy(parent_domain, 0, PCI_NUM_INTX,
+					 intc_np,
+					 &ks_pcie_legacy_irq_domain_ops,
+					 ks_pcie);
 	if (!legacy_irq_domain) {
 		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
 		ret = -EINVAL;
-		goto err;
 	}
-	ks_pcie->legacy_irq_domain = legacy_irq_domain;
-
-	for (i = 0; i < PCI_NUM_INTX; i++)
-		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), INTx_EN);
 
 err:
 	of_node_put(intc_np);
-- 
2.17.1

