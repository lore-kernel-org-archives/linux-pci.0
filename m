Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD18ECE562
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E18921531
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z8S3Hx4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E18921531
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389890AbeIUQMN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:13 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51358 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389869AbeIUQMM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:12:12 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LAMvFs033042;
        Fri, 21 Sep 2018 05:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525377;
        bh=RAY/p4oOkC6V/1l6SSQG5SB78+sX5ZfL9TNvvxFSdpw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Z8S3Hx4ql4IxTGZNJH/SL8n5acJzxuJld3AnSwTvoNMYnrFltxw28zMFNNZPS2UVx
         nmpMm6WRpDkzeE0Fxwa5mryl4K39LSHMjEJuaTiTi3NGK9VyxPRnAuFxhGdrfGAVoD
         xlFjKreb762WmGW0quUZ3MlktolonE40jVlcCEyE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMvbL017826;
        Fri, 21 Sep 2018 05:22:57 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:22:56 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:22:56 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtC032280;
        Fri, 21 Sep 2018 05:22:52 -0500
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
Subject: [RFC PATCH 08/40] PCI: keystone: Cleanup MSI/legacy interrupt configuration and handling
Date:   Fri, 21 Sep 2018 15:51:23 +0530
Message-ID: <20180921102155.22839-9-kishon@ti.com>
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

Now that all PCI keystone functionality has been moved to pci-keystone.c,
cleanup MSI/legacy interrupt configuration and handling.
 *) Cleanup macros
 *) Remove unnecessary structure variables (required when 2 files are
    used)
 *) Remove ks_dw_pcie_legacy_irq_chip and use dummy_irq_chip
 *) Move request_irq of error irq from ks_add_pcie_port to ks_pcie_probe
    as error_irq is common to both host mode and device mode

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 392 +++++++++-------------
 1 file changed, 150 insertions(+), 242 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 65ff7a5566b4..4554fdc6cce1 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -50,17 +50,16 @@
 
 /* IRQ register defines */
 #define IRQ_EOI				0x050
-#define IRQ_STATUS			0x184
-#define IRQ_ENABLE_SET			0x188
-#define IRQ_ENABLE_CLR			0x18c
-
 #define MSI_IRQ				0x054
-#define MSI0_IRQ_STATUS			0x104
-#define MSI0_IRQ_ENABLE_SET		0x108
-#define MSI0_IRQ_ENABLE_CLR		0x10c
-#define IRQ_STATUS			0x184
+#define MSI_IRQ_STATUS(n)		(0x104 + ((n) << 4))
+#define MSI_IRQ_ENABLE_SET(n)		(0x108 + ((n) << 4))
+#define MSI_IRQ_ENABLE_CLR(n)		(0x10c + ((n) << 4))
 #define MSI_IRQ_OFFSET			4
 
+#define IRQ_STATUS(n)			(0x184 + ((n) << 4))
+#define IRQ_ENABLE_SET(n)		(0x188 + ((n) << 4))
+#define INTx_EN				BIT(0)
+
 /* Error IRQ bits */
 #define ERR_AER		BIT(5)	/* ECRC error */
 #define ERR_AXI		BIT(4)	/* AXI tag lookup fatal error */
@@ -79,8 +78,6 @@
 /* Config space registers */
 #define DEBUG0				0x728
 
-#define MAX_MSI_HOST_IRQS		8
-
 /* PCIE controller device IDs */
 #define PCIE_RC_K2HK		0xb008
 #define PCIE_RC_K2E		0xb009
@@ -97,30 +94,16 @@ struct keystone_pcie {
 	struct	clk		*clk;
 	/* PCI Device ID */
 	u32			device_id;
-	int			num_legacy_host_irqs;
-	int			legacy_host_irqs[PCI_NUM_INTX];
-	struct			device_node *legacy_intc_np;
-
-	int			num_msi_host_irqs;
-	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
+	int			msi_host_irq;
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*legacy_irq_domain;
 	struct device_node	*np;
 
-	int error_irq;
-
 	/* Application register space */
 	void __iomem		*va_app_base;	/* DT 1st resource */
 	struct resource		app;
 };
 
-static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
-					     u32 *bit_pos)
-{
-	*reg_offset = offset % 8;
-	*bit_pos = offset >> 3;
-}
-
 static phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -139,31 +122,6 @@ static void ks_dw_app_writel(struct keystone_pcie *ks_pcie, u32 offset, u32 val)
 	writel(val, ks_pcie->va_app_base + offset);
 }
 
-static void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	struct device *dev = pci->dev;
-	u32 pending, vector;
-	int src, virq;
-
-	pending = ks_dw_app_readl(ks_pcie, MSI0_IRQ_STATUS + (offset << 4));
-
-	/*
-	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
-	 * shows 1, 9, 17, 25 and so forth
-	 */
-	for (src = 0; src < 4; src++) {
-		if (BIT(src) & pending) {
-			vector = offset + (src << 3);
-			virq = irq_linear_revmap(pp->irq_domain, vector);
-			dev_dbg(dev, "irq: bit %d, vector %d, virq %d\n",
-				src, vector, virq);
-			generic_handle_irq(virq);
-		}
-	}
-}
-
 static void ks_dw_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 {
 	u32 reg_offset, bit_pos;
@@ -172,11 +130,11 @@ static void ks_dw_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 
 	pci = to_dw_pcie_from_pp(pp);
 	ks_pcie = to_keystone_pcie(pci);
-	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
 
-	ks_dw_app_writel(ks_pcie, MSI0_IRQ_STATUS + (reg_offset << 4),
-			 BIT(bit_pos));
-	ks_dw_app_writel(ks_pcie, IRQ_EOI, reg_offset + MSI_IRQ_OFFSET);
+	reg_offset = irq % 8;
+	bit_pos = irq >> 3;
+	ks_dw_app_writel(ks_pcie, MSI_IRQ_STATUS(reg_offset), BIT(bit_pos));
+	ks_dw_app_writel(ks_pcie, IRQ_EOI, MSI_IRQ_OFFSET + reg_offset);
 }
 
 static void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
@@ -185,8 +143,9 @@ static void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
-	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
-	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_SET + (reg_offset << 4),
+	reg_offset = irq % 8;
+	bit_pos = irq >> 3;
+	ks_dw_app_writel(ks_pcie, MSI_IRQ_ENABLE_SET(reg_offset),
 			 BIT(bit_pos));
 }
 
@@ -196,8 +155,9 @@ static void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
-	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
-	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_CLR + (reg_offset << 4),
+	reg_offset = irq % 8;
+	bit_pos = irq >> 3;
+	ks_dw_app_writel(ks_pcie, MSI_IRQ_ENABLE_CLR(reg_offset),
 			 BIT(bit_pos));
 }
 
@@ -206,34 +166,6 @@ static int ks_dw_pcie_msi_host_init(struct pcie_port *pp)
 	return dw_pcie_allocate_domains(pp);
 }
 
-static void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
-{
-	int i;
-
-	for (i = 0; i < PCI_NUM_INTX; i++)
-		ks_dw_app_writel(ks_pcie, IRQ_ENABLE_SET + (i << 4), 0x1);
-}
-
-static void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
-					 int offset)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct device *dev = pci->dev;
-	u32 pending;
-	int virq;
-
-	pending = ks_dw_app_readl(ks_pcie, IRQ_STATUS + (offset << 4));
-
-	if (BIT(0) & pending) {
-		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
-		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
-		generic_handle_irq(virq);
-	}
-
-	/* EOI the INTx interrupt */
-	ks_dw_app_writel(ks_pcie, IRQ_EOI, offset);
-}
-
 static void ks_dw_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 {
 	ks_dw_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
@@ -256,40 +188,6 @@ static irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 	return IRQ_HANDLED;
 }
 
-static void ks_dw_pcie_ack_legacy_irq(struct irq_data *d)
-{
-}
-
-static void ks_dw_pcie_mask_legacy_irq(struct irq_data *d)
-{
-}
-
-static void ks_dw_pcie_unmask_legacy_irq(struct irq_data *d)
-{
-}
-
-static struct irq_chip ks_dw_pcie_legacy_irq_chip = {
-	.name = "Keystone-PCI-Legacy-IRQ",
-	.irq_ack = ks_dw_pcie_ack_legacy_irq,
-	.irq_mask = ks_dw_pcie_mask_legacy_irq,
-	.irq_unmask = ks_dw_pcie_unmask_legacy_irq,
-};
-
-static int ks_dw_pcie_init_legacy_irq_map(struct irq_domain *d,
-				unsigned int irq, irq_hw_number_t hw_irq)
-{
-	irq_set_chip_and_handler(irq, &ks_dw_pcie_legacy_irq_chip,
-				 handle_level_irq);
-	irq_set_chip_data(irq, d->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops ks_dw_pcie_legacy_irq_domain_ops = {
-	.map = ks_dw_pcie_init_legacy_irq_map,
-	.xlate = irq_domain_xlate_onetwocell,
-};
-
 /**
  * ks_dw_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask
  * registers
@@ -520,17 +418,6 @@ static int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie)
 
 	ks_pcie->app = *res;
 
-	/* Create legacy IRQ domain */
-	ks_pcie->legacy_irq_domain =
-			irq_domain_add_linear(ks_pcie->legacy_intc_np,
-					PCI_NUM_INTX,
-					&ks_dw_pcie_legacy_irq_domain_ops,
-					NULL);
-	if (!ks_pcie->legacy_irq_domain) {
-		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
-		return -EINVAL;
-	}
-
 	return dw_pcie_host_init(pp);
 }
 
@@ -579,22 +466,32 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
 
 static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 {
+	u32 reg;
+	u32 vector;
+	int pos;
+	int virq;
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
-	u32 offset = irq - ks_pcie->msi_host_irqs[0];
+	u32 offset = irq - ks_pcie->msi_host_irq;
 	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 	struct device *dev = pci->dev;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	dev_dbg(dev, "%s, irq %d\n", __func__, irq);
-
-	/*
-	 * The chained irq handler installation would have replaced normal
-	 * interrupt driver handler so we need to take care of mask/unmask and
-	 * ack operation.
-	 */
 	chained_irq_enter(chip, desc);
-	ks_dw_pcie_handle_msi_irq(ks_pcie, offset);
+
+	reg = ks_dw_app_readl(ks_pcie, MSI_IRQ_STATUS(offset));
+	for (pos = 0; pos < 4; pos++) {
+		if (!(reg & BIT(pos)))
+			continue;
+
+		vector = offset + (pos << 3);
+		virq = irq_linear_revmap(pp->irq_domain, vector);
+		dev_dbg(dev, "irq: bit %d, vector %d, virq %d\n", pos, vector,
+			virq);
+		generic_handle_irq(virq);
+	}
+
 	chained_irq_exit(chip, desc);
 }
 
@@ -608,106 +505,124 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
  */
 static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 {
-	unsigned int irq = irq_desc_get_irq(desc);
+	int i;
+	u32 reg;
+	int virq;
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct device *dev = pci->dev;
-	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
-
-	/*
-	 * The chained irq handler installation would have replaced normal
-	 * interrupt driver handler so we need to take care of mask/unmask and
-	 * ack operation.
-	 */
 	chained_irq_enter(chip, desc);
-	ks_dw_pcie_handle_legacy_irq(ks_pcie, irq_offset);
+
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		reg = ks_dw_app_readl(ks_pcie, IRQ_STATUS(i));
+		if (!(reg & INTx_EN))
+			continue;
+
+		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, i);
+		generic_handle_irq(virq);
+		ks_dw_app_writel(ks_pcie, IRQ_STATUS(i), INTx_EN);
+		ks_dw_app_writel(ks_pcie, IRQ_EOI, i);
+	}
+
 	chained_irq_exit(chip, desc);
 }
 
-static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
-					   char *controller, int *num_irqs)
+static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 {
-	int temp, max_host_irqs, legacy = 1, *host_irqs;
 	struct device *dev = ks_pcie->pci->dev;
-	struct device_node *np_pcie = dev->of_node, **np_temp;
-
-	if (!strcmp(controller, "msi-interrupt-controller"))
-		legacy = 0;
-
-	if (legacy) {
-		np_temp = &ks_pcie->legacy_intc_np;
-		max_host_irqs = PCI_NUM_INTX;
-		host_irqs = &ks_pcie->legacy_host_irqs[0];
-	} else {
-		np_temp = &ks_pcie->msi_intc_np;
-		max_host_irqs = MAX_MSI_HOST_IRQS;
-		host_irqs =  &ks_pcie->msi_host_irqs[0];
-	}
+	struct device_node *np = ks_pcie->np;
+	struct device_node *intc_np;
+	int irq_count;
+	int irq;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_PCI_MSI))
+		return 0;
 
-	/* interrupt controller is in a child node */
-	*np_temp = of_get_child_by_name(np_pcie, controller);
-	if (!(*np_temp)) {
-		dev_err(dev, "Node for %s is absent\n", controller);
+	intc_np = of_get_child_by_name(np, "msi-interrupt-controller");
+	if (!intc_np) {
+		dev_WARN(dev, "msi-interrupt-controller node is absent\n");
 		return -EINVAL;
 	}
 
-	temp = of_irq_count(*np_temp);
-	if (!temp) {
-		dev_err(dev, "No IRQ entries in %s\n", controller);
-		of_node_put(*np_temp);
+	irq_count = of_irq_count(intc_np);
+	if (!irq_count) {
+		dev_err(dev, "No IRQ entries in msi-interrupt-controller\n");
 		return -EINVAL;
 	}
 
-	if (temp > max_host_irqs)
-		dev_warn(dev, "Too many %s interrupts defined %u\n",
-			(legacy ? "legacy" : "MSI"), temp);
+	for (i = 0; i < irq_count; i++) {
+		irq = irq_of_parse_and_map(intc_np, i);
+		if (!irq)
+			return -EINVAL;
 
-	/*
-	 * support upto max_host_irqs. In dt from index 0 to 3 (legacy) or 0 to
-	 * 7 (MSI)
-	 */
-	for (temp = 0; temp < max_host_irqs; temp++) {
-		host_irqs[temp] = irq_of_parse_and_map(*np_temp, temp);
-		if (!host_irqs[temp])
-			break;
+		if (!ks_pcie->msi_host_irq)
+			ks_pcie->msi_host_irq = irq;
+
+		irq_set_chained_handler_and_data(irq, ks_pcie_msi_irq_handler,
+						 ks_pcie);
 	}
 
-	of_node_put(*np_temp);
+	return 0;
+}
 
-	if (temp) {
-		*num_irqs = temp;
-		return 0;
-	}
+static int ks_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			    irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
 
-	return -EINVAL;
+	return 0;
 }
 
-static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
+static const struct irq_domain_ops ks_pcie_intx_domain_ops = {
+	.map = ks_pcie_intx_map,
+};
+
+static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 {
+	struct device *dev = ks_pcie->pci->dev;
+	struct irq_domain *legacy_irq_domain;
+	struct device_node *np = ks_pcie->np;
+	struct device_node *intc_np;
+	int irq_count;
+	int irq;
 	int i;
 
-	/* Legacy IRQ */
-	for (i = 0; i < ks_pcie->num_legacy_host_irqs; i++) {
-		irq_set_chained_handler_and_data(ks_pcie->legacy_host_irqs[i],
+	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
+	if (!intc_np) {
+		dev_WARN(dev, "legacy-interrupt-controller node is absent\n");
+		return -EINVAL;
+	}
+
+	irq_count = of_irq_count(intc_np);
+	if (!irq_count) {
+		dev_err(dev, "No IRQ entries in legacy-interrupt-controller\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < irq_count; i++) {
+		irq = irq_of_parse_and_map(intc_np, i);
+		if (!irq)
+			return -EINVAL;
+		irq_set_chained_handler_and_data(irq,
 						 ks_pcie_legacy_irq_handler,
 						 ks_pcie);
 	}
-	ks_dw_pcie_enable_legacy_irqs(ks_pcie);
-
-	/* MSI IRQ */
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		for (i = 0; i < ks_pcie->num_msi_host_irqs; i++) {
-			irq_set_chained_handler_and_data(ks_pcie->msi_host_irqs[i],
-							 ks_pcie_msi_irq_handler,
-							 ks_pcie);
-		}
+
+	legacy_irq_domain = irq_domain_add_linear(intc_np,  PCI_NUM_INTX,
+						  &ks_pcie_intx_domain_ops,
+						  NULL);
+	if (!legacy_irq_domain) {
+		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
+		return -EINVAL;
 	}
+	ks_pcie->legacy_irq_domain = legacy_irq_domain;
 
-	if (ks_pcie->error_irq > 0)
-		ks_dw_pcie_enable_error_irq(ks_pcie);
+	for (i = 0; i < PCI_NUM_INTX; i++)
+		ks_dw_app_writel(ks_pcie, IRQ_ENABLE_SET(i), INTx_EN);
+
+	return 0;
 }
 
 /*
@@ -734,11 +649,19 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+	int ret;
+
+	ret = ks_pcie_config_legacy_irq(ks_pcie);
+	if (ret)
+		return ret;
+
+	ret = ks_pcie_config_msi_irq(ks_pcie);
+	if (ret)
+		return ret;
 
 	dw_pcie_setup_rc(pp);
 
 	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
-	ks_pcie_setup_interrupts(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
 			pci->dbi_base + PCI_IO_BASE);
 
@@ -783,44 +706,12 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	ret = ks_pcie_get_irq_controller_info(ks_pcie,
-					"legacy-interrupt-controller",
-					&ks_pcie->num_legacy_host_irqs);
-	if (ret)
-		return ret;
-
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		ret = ks_pcie_get_irq_controller_info(ks_pcie,
-						"msi-interrupt-controller",
-						&ks_pcie->num_msi_host_irqs);
-		if (ret)
-			return ret;
-	}
-
-	/*
-	 * Index 0 is the platform interrupt for error interrupt
-	 * from RC.  This is optional.
-	 */
-	ks_pcie->error_irq = irq_of_parse_and_map(ks_pcie->np, 0);
-	if (ks_pcie->error_irq <= 0)
-		dev_info(dev, "no error IRQ defined\n");
-	else {
-		ret = request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
-				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
-		if (ret < 0) {
-			dev_err(dev, "failed to request error IRQ %d\n",
-				ks_pcie->error_irq);
-			return ret;
-		}
-	}
-
 	pp->ops = &keystone_pcie_host_ops;
 	ret = ks_dw_pcie_host_init(ks_pcie);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
-
 	return 0;
 }
 
@@ -878,6 +769,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	void __iomem *reg_p;
 	struct phy *phy;
 	int ret;
+	int irq;
 
 	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
 	if (!ks_pcie)
@@ -913,6 +805,20 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	devm_release_mem_region(dev, res->start, resource_size(res));
 
 	ks_pcie->np = dev->of_node;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "missing IRQ resource: %d\n", irq);
+		return irq;
+	}
+
+	ret = devm_request_irq(dev, irq, pcie_err_irq_handler, IRQF_SHARED,
+			       "ks-pcie-error-irq", ks_pcie);
+	if (ret < 0) {
+		dev_err(dev, "failed to request error IRQ %d\n", irq);
+		return ret;
+	}
+
 	platform_set_drvdata(pdev, ks_pcie);
 	ks_pcie->clk = devm_clk_get(dev, "pcie");
 	if (IS_ERR(ks_pcie->clk)) {
@@ -929,6 +835,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto fail_clk;
 
+	ks_dw_pcie_enable_error_irq(ks_pcie);
+
 	return 0;
 fail_clk:
 	clk_disable_unprepare(ks_pcie->clk);
-- 
2.17.1

