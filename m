Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:48891 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbdEEOL6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2017 10:11:58 -0400
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: kishon@ti.com, bhelgaas@google.com, jingoohan1@gmail.com,
        marc.zyngier@arm.com
Cc: linux-pci@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [RFC] pci: using new interrupt API to enable MSI and MSI-X
Date: Fri,  5 May 2017 15:11:53 +0100
Message-Id: <806903036508ae5246084cbc3b796083d76f8917.1493992929.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,
I am currently adding the support for both MSI and MSI-x in pcie-designware and
I am now facing a dificulty.

My test endpoint is a USB 3.1 MSI / MSI-X capable and I tested that with
the changes introduced by this patch we are able to enable MSI and MSI-X
in this endpoint (depends on the usage of the MSI_FLAG_PCI_MSIX flag).

The problem I am facing now is that Intc for the USB 3.1 Endpoint is completely
bogus (524288) when it should be 1, and so I am not receiving any interrupts
from the endpoint.

I would apreciate that more experienced people in this interrupt subject could
give me an hint.

I send you the "lspci -v" results and /proc/interrupts.

Thank you so much for your help.

# cat /proc/interrupts
           CPU0
  3:        755  ARC In-core Intc   3  Timer0 (per-cpu-tick)
  4:          0  dw-apb-ictl   4  eth0
  8:          1  dw-apb-ictl   8  ehci_hcd:usb1, ohci_hcd:usb2
  9:         37  dw-apb-ictl   7  dw-mci
 14:          0  dw-apb-ictl  14  e001d000.i2c
 16:          0  dw-apb-ictl  16  e001f000.i2c
 19:        145  dw-apb-ictl  19  serial
 45:          0   PCI-MSI   0  aerdrv
 46:          0   PCI-MSI 524288  xhci_hcd

# lspci -v
00:00.0 PCI bridge: Synopsys, Inc. Device eddc (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 45
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d0400000-d04fffff
        [virtual] Expansion ROM at d0500000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Root Port (Slot-), MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] #19
        Capabilities: [158] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
        Kernel driver in use: pcieport

01:00.0 USB controller: ASMedia Technology Inc. ASM1142 USB 3.1 Host Controller (prog-if 30 [XHCI])
        Subsystem: ASMedia Technology Inc. ASM1142 USB 3.1 Host Controller
        Flags: bus master, fast devsel, latency 0, IRQ 46
        Memory at d0400000 (64-bit, non-prefetchable) [size=32K]
        Capabilities: [50] MSI: Enable+ Count=1/8 Maskable- 64bit+
        Capabilities: [68] MSI-X: Enable- Count=8 Masked-
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Endpoint, MSI 00
        Capabilities: [100] Virtual Channel
        Capabilities: [200] Advanced Error Reporting
        Capabilities: [280] #19
        Capabilities: [300] Latency Tolerance Reporting
        Kernel driver in use: xhci_hcd

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
 .../devicetree/bindings/pci/designware-pcie.txt    |   2 +
 drivers/pci/dwc/pcie-designware-host.c             | 292 ++++++++-------------
 drivers/pci/dwc/pcie-designware-plat.c             |  35 +--
 drivers/pci/dwc/pcie-designware.h                  |   7 +-
 4 files changed, 143 insertions(+), 193 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index b2480dd..41803ea 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -34,6 +34,8 @@ Optional properties:
 RC mode:
 - num-viewport: number of view ports configured in
   hardware. If a platform does not specify it, the driver assumes 2.
+- num-vectors: number of available interrupt vectors. If a platform does not
+  specify it, the driver assumes 1.
 - bus-range: PCI bus numbers covered (it is recommended
   for new devicetrees to specify this property, to keep backwards
   compatibility a range of 0x00-0xff is assumed if not present)
diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 28ed32b..96a5fb3 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -11,6 +11,9 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/interrupt.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/msi.h>
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -53,32 +56,43 @@ static struct irq_chip dw_msi_irq_chip = {
 	.irq_unmask = pci_msi_unmask_irq,
 };
 
+static struct msi_domain_info dw_pcie_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX),
+	.chip	= &dw_msi_irq_chip,
+};
+
 /* MSI int handler */
-irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
+void dw_handle_msi_irq(struct irq_desc *desc)
 {
-	u32 val;
-	int i, pos, irq;
-	irqreturn_t ret = IRQ_NONE;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct pcie_port *pp;
+	struct dw_pcie *pci;
+	int i, pos, virq;
+	u32 status;
+
+	chained_irq_enter(chip, desc);
+	pci = irq_desc_get_handler_data(desc);
+	pp = &pci->pp;
 
 	for (i = 0; i < MAX_MSI_CTRLS; i++) {
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
-				    &val);
-		if (!val)
+				    &status);
+		if (!status)
 			continue;
 
-		ret = IRQ_HANDLED;
 		pos = 0;
-		while ((pos = find_next_bit((unsigned long *) &val, 32,
+		while ((pos = find_next_bit((unsigned long *) &status, 32,
 					    pos)) != 32) {
-			irq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
+			virq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
 			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12,
 					    4, 1 << pos);
-			generic_handle_irq(irq);
+			generic_handle_irq(virq);
 			pos++;
 		}
 	}
 
-	return ret;
+	chained_irq_exit(chip, desc);
 }
 
 void dw_pcie_msi_init(struct pcie_port *pp)
@@ -95,93 +110,10 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 			    (u32)(msi_target >> 32 & 0xffffffff));
 }
 
-static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
-{
-	unsigned int res, bit, val;
-
-	res = (irq / 32) * 12;
-	bit = irq % 32;
-	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
-	val &= ~(1 << bit);
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
-}
-
-static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
-			    unsigned int nvec, unsigned int pos)
-{
-	unsigned int i;
-
-	for (i = 0; i < nvec; i++) {
-		irq_set_msi_desc_off(irq_base, i, NULL);
-		/* Disable corresponding interrupt on MSI controller */
-		if (pp->ops->msi_clear_irq)
-			pp->ops->msi_clear_irq(pp, pos + i);
-		else
-			dw_pcie_msi_clear_irq(pp, pos + i);
-	}
-
-	bitmap_release_region(pp->msi_irq_in_use, pos, order_base_2(nvec));
-}
-
-static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
-{
-	unsigned int res, bit, val;
-
-	res = (irq / 32) * 12;
-	bit = irq % 32;
-	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
-	val |= 1 << bit;
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
-}
-
-static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
-{
-	int irq, pos0, i;
-	struct pcie_port *pp;
-
-	pp = (struct pcie_port *)msi_desc_to_pci_sysdata(desc);
-	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
-				       order_base_2(no_irqs));
-	if (pos0 < 0)
-		goto no_valid_irq;
-
-	irq = irq_find_mapping(pp->irq_domain, pos0);
-	if (!irq)
-		goto no_valid_irq;
-
-	/*
-	 * irq_create_mapping (called from dw_pcie_host_init) pre-allocates
-	 * descs so there is no need to allocate descs here. We can therefore
-	 * assume that if irq_find_mapping above returns non-zero, then the
-	 * descs are also successfully allocated.
-	 */
-
-	for (i = 0; i < no_irqs; i++) {
-		if (irq_set_msi_desc_off(irq, i, desc) != 0) {
-			clear_irq_range(pp, irq, i, pos0);
-			goto no_valid_irq;
-		}
-		/*Enable corresponding interrupt in MSI interrupt controller */
-		if (pp->ops->msi_set_irq)
-			pp->ops->msi_set_irq(pp, pos0 + i);
-		else
-			dw_pcie_msi_set_irq(pp, pos0 + i);
-	}
-
-	*pos = pos0;
-	desc->nvec_used = no_irqs;
-	desc->msi_attrib.multiple = order_base_2(no_irqs);
-
-	return irq;
-
-no_valid_irq:
-	*pos = pos0;
-	return -ENOSPC;
-}
-
-static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
+static void dw_pci_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct msi_msg msg;
+	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
+	struct pcie_port *pp = &pci->pp;
 	u64 msi_target;
 
 	if (pp->ops->get_msi_addr)
@@ -189,89 +121,105 @@ static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
 	else
 		msi_target = virt_to_phys((void *)pp->msi_data);
 
-	msg.address_lo = (u32)(msi_target & 0xffffffff);
-	msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
+	msg->address_lo = (u32)(msi_target & 0xffffffff);
+	msg->address_hi = (u32)(msi_target >> 32 & 0xffffffff);
 
 	if (pp->ops->get_msi_data)
-		msg.data = pp->ops->get_msi_data(pp, pos);
+		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
 	else
-		msg.data = pos;
+		msg->data = data->hwirq;
 
-	pci_write_msi_msg(irq, &msg);
+	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
+		(int)data->hwirq, msg->address_hi, msg->address_lo);
 }
 
-static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
-			    struct msi_desc *desc)
+static int dw_pci_msi_set_affinity(struct irq_data *irq_data,
+				   const struct cpumask *mask, bool force)
 {
-	int irq, pos;
-	struct pcie_port *pp = pdev->bus->sysdata;
-
-	if (desc->msi_attrib.is_msix)
-		return -EINVAL;
-
-	irq = assign_irq(1, desc, &pos);
-	if (irq < 0)
-		return irq;
-
-	dw_msi_setup_msg(pp, irq, pos);
-
-	return 0;
+	return -EINVAL;
 }
 
-static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
-			     int nvec, int type)
+static struct irq_chip dw_pci_msi_bottom_irq_chip = {
+	.name			= "DW MSI",
+	.irq_compose_msi_msg	= dw_pci_compose_msi_msg,
+	.irq_set_affinity	= dw_pci_msi_set_affinity,
+};
+
+static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
+				    unsigned int virq, unsigned int nr_irqs,
+				    void *args)
 {
-#ifdef CONFIG_PCI_MSI
-	int irq, pos;
-	struct msi_desc *desc;
-	struct pcie_port *pp = pdev->bus->sysdata;
+	struct dw_pcie *pci = domain->host_data;
+	struct pcie_port *pp = &pci->pp;
+	unsigned long bit;
 
-	/* MSI-X interrupts are not supported */
-	if (type == PCI_CAP_ID_MSIX)
-		return -EINVAL;
+	WARN_ON(nr_irqs != 1);
 
-	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
-	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
+	bit = find_first_zero_bit(pp->msi_irq_in_use, pp->num_vectors);
+	if (bit >= pp->num_vectors) {
+		return -ENOSPC;
+	}
 
-	irq = assign_irq(nvec, desc, &pos);
-	if (irq < 0)
-		return irq;
+	set_bit(bit, pp->msi_irq_in_use);
 
-	dw_msi_setup_msg(pp, irq, pos);
+	irq_domain_set_info(domain, virq, bit, &dw_pci_msi_bottom_irq_chip,
+			    domain->host_data, handle_simple_irq,
+			    NULL, NULL);
 
 	return 0;
-#else
-	return -EINVAL;
-#endif
 }
 
-static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
+static void dw_pcie_irq_domain_free(struct irq_domain *domain,
+				    unsigned int virq, unsigned int nr_irqs)
 {
-	struct irq_data *data = irq_get_irq_data(irq);
-	struct msi_desc *msi = irq_data_get_msi_desc(data);
-	struct pcie_port *pp = (struct pcie_port *)msi_desc_to_pci_sysdata(msi);
+	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
+	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
+	struct pcie_port *pp = &pci->pp;
 
-	clear_irq_range(pp, irq, 1, data->hwirq);
+	if (!test_bit(data->hwirq, pp->msi_irq_in_use))
+		dev_err(pci->dev, "trying to free unused MSI#%lu\n",
+			data->hwirq);
+	else
+		__clear_bit(data->hwirq, pp->msi_irq_in_use);
 }
 
-static struct msi_controller dw_pcie_msi_chip = {
-	.setup_irq = dw_msi_setup_irq,
-	.setup_irqs = dw_msi_setup_irqs,
-	.teardown_irq = dw_msi_teardown_irq,
+static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
+	.alloc	= dw_pcie_irq_domain_alloc,
+	.free	= dw_pcie_irq_domain_free,
 };
 
-static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
-			   irq_hw_number_t hwirq)
+static int dw_pcie_allocate_domains(struct dw_pcie *pci)
 {
-	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
+	struct pcie_port *pp = &pci->pp;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
+
+	pp->irq_domain = irq_domain_add_linear(NULL, pp->num_vectors,
+					       &dw_pcie_msi_domain_ops, pci);
+	if (!pp->irq_domain) {
+		dev_err(pci->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	pp->msi_domain = pci_msi_create_irq_domain(fwnode,
+						   &dw_pcie_msi_domain_info,
+						   pp->irq_domain);
+	if (!pp->msi_domain) {
+		dev_err(pci->dev, "failed to create MSI domain\n");
+		irq_domain_remove(pp->irq_domain);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
 
-static const struct irq_domain_ops msi_domain_ops = {
-	.map = dw_pcie_msi_map,
-};
+void dw_pcie_free_msi(struct pcie_port *pp)
+{
+	irq_set_chained_handler(pp->msi_irq, NULL);
+	irq_set_handler_data(pp->msi_irq, NULL);
+
+	irq_domain_remove(pp->msi_domain);
+	irq_domain_remove(pp->irq_domain);
+}
 
 int dw_pcie_host_init(struct pcie_port *pp)
 {
@@ -281,7 +229,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pci_bus *bus, *child;
 	struct resource *cfg_res;
-	int i, ret;
+	int ret;
 	LIST_HEAD(res);
 	struct resource_entry *win, *tmp;
 
@@ -377,37 +325,29 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pci->num_viewport = 2;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		if (!pp->ops->msi_host_init) {
-			pp->irq_domain = irq_domain_add_linear(dev->of_node,
-						MAX_MSI_IRQS, &msi_domain_ops,
-						&dw_pcie_msi_chip);
-			if (!pp->irq_domain) {
-				dev_err(dev, "irq domain init failed\n");
-				ret = -ENXIO;
-				goto error;
-			}
 
-			for (i = 0; i < MAX_MSI_IRQS; i++)
-				irq_create_mapping(pp->irq_domain, i);
-		} else {
-			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
-			if (ret < 0)
-				goto error;
-		}
+		ret = of_property_read_u32(np, "num-vectors",
+					   &pp->num_vectors);
+		if (ret)
+			pp->num_vectors = 1;
+
+		ret = dw_pcie_allocate_domains(pci);
+		if (ret)
+			goto error;
+
+		if (!pp->ops->msi_host_init)
+			goto error;
+		else
+			pp->ops->msi_host_init(pci);
 	}
 
 	if (pp->ops->host_init)
 		pp->ops->host_init(pp);
 
 	pp->root_bus_nr = pp->busn->start;
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		bus = pci_scan_root_bus_msi(dev, pp->root_bus_nr,
-					    &dw_pcie_ops, pp, &res,
-					    &dw_pcie_msi_chip);
-		dw_pcie_msi_chip.dev = dev;
-	} else
-		bus = pci_scan_root_bus(dev, pp->root_bus_nr, &dw_pcie_ops,
-					pp, &res);
+
+	bus = pci_scan_root_bus(dev, pp->root_bus_nr, &dw_pcie_ops,
+				pp, &res);
 	if (!bus) {
 		ret = -ENOMEM;
 		goto error;
diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index 32091b3..4360fc6 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -28,13 +28,6 @@ struct dw_plat_pcie {
 	struct dw_pcie		*pci;
 };
 
-static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
-{
-	struct pcie_port *pp = arg;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static void dw_plat_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -46,8 +39,15 @@ static void dw_plat_pcie_host_init(struct pcie_port *pp)
 		dw_pcie_msi_init(pp);
 }
 
+static void dw_plat_msi_host_init (struct dw_pcie *pci)
+{
+	struct pcie_port *pp = &pci->pp;
+	irq_set_chained_handler_and_data(pp->msi_irq, dw_handle_msi_irq, pci);
+}
+
 static struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
 	.host_init = dw_plat_pcie_host_init,
+	.msi_host_init = dw_plat_msi_host_init,
 };
 
 static int dw_plat_add_pcie_port(struct pcie_port *pp,
@@ -64,14 +64,6 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
 		pp->msi_irq = platform_get_irq(pdev, 0);
 		if (pp->msi_irq < 0)
 			return pp->msi_irq;
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-					dw_plat_pcie_msi_irq_handler,
-					IRQF_SHARED, "dw-plat-pcie-msi", pp);
-		if (ret) {
-			dev_err(dev, "failed to request MSI IRQ\n");
-			return ret;
-		}
 	}
 
 	pp->root_bus_nr = -1;
@@ -86,6 +78,18 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
 	return 0;
 }
 
+static int dw_plat_pcie_remove(struct platform_device *pdev)
+{
+	struct dw_plat_pcie *dw_plat_pcie = platform_get_drvdata(pdev);
+	struct dw_pcie *pci = dw_plat_pcie->pci;
+
+	dw_pcie_free_msi(&pci->pp);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 };
 
@@ -136,5 +140,6 @@ static struct platform_driver dw_plat_pcie_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = dw_plat_pcie_probe,
+	.remove = dw_plat_pcie_remove,
 };
 builtin_platform_driver(dw_plat_pcie_driver);
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index c6a8405..cd3b3cc7 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -140,7 +140,7 @@ struct dw_pcie_host_ops {
 	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
 	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 	void (*scan_bus)(struct pcie_port *pp);
-	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
+	void (*msi_host_init)(struct dw_pcie *pci);
 };
 
 struct pcie_port {
@@ -165,7 +165,9 @@ struct pcie_port {
 	struct dw_pcie_host_ops	*ops;
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
+	struct irq_domain	*msi_domain;
 	unsigned long		msi_data;
+	u32			num_vectors;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
@@ -280,7 +282,8 @@ static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
 }
 
 #ifdef CONFIG_PCIE_DW_HOST
-irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
+void dw_handle_msi_irq(struct irq_desc *desc);
+void dw_pcie_free_msi(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
-- 
2.9.3
