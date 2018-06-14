Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:52232 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935710AbeFNBe4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2018 21:34:56 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 01/10] PCI: Add pci_host_alloc_intx_irqd() for allocating IRQ domain
Date: Thu, 14 Jun 2018 09:34:17 +0800
Message-Id: <1528940057-183252-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1528939995-183203-1-git-send-email-shawn.lin@rock-chips.com>
References: <1528939995-183203-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It seems host drivers which allocate IRQ domain for INTx
and the related code block looks highly similar to each other.
Add a new helper, pci_alloc_intx_irqd(), to avoid code duplication
as much as possible.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v4:
- fix another compile warning reported by Kbuild Robot

Changes in v3:
- rename to pci_host_alloc_intx_irqd and move to probe.c
- fix compile error reported by Kbuild Robot

Changes in v2:
- fix typo and move the code to C file.

 drivers/pci/probe.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  7 +++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e3..d37b879 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3139,3 +3139,77 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_hp_add_bridge);
+
+static int pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			 irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+/**
+ * pci_host_alloc_intx_irqd() - Allocate INTx IRQ domain
+ * @dev: device associated with the PCI controller.
+ * @host: pointer to host specific data struct
+ * @general_xlate: flag for whether use pci_irqd_intx_xlate() helper
+ * @intx_domain_ops: pointer to driver specific struct irq_domain_ops
+ * @local_intc: pointer to driver specific interrupt controller node
+ *
+ * A simple helper for drivers to allocate IRQ domain for INTx. If
+ * intx_domain_ops is NULL, use pci_intx_domain_ops by default. And if
+ * local_intc is present, then use it firstly, otherwise, fallback to get
+ * interrupt controller node from @dev.
+ *
+ * Returns valid pointer of struct irq_domain on success, or PTR_ERR(-EINVAL)
+ * if failure occurred.
+ */
+struct irq_domain *pci_host_alloc_intx_irqd(struct device *dev, void *host,
+	bool general_xlate, const struct irq_domain_ops *intx_domain_ops,
+	struct device_node *local_intc)
+{
+	struct device_node *intc = local_intc;
+	struct irq_domain *domain = NULL;
+	struct irq_domain_ops *irqd_ops;
+	bool need_put = false;
+	int err = -EINVAL;
+
+	if (!intc) {
+		intc = of_get_next_child(dev->of_node, NULL);
+		if (!intc) {
+			dev_err(dev, "missing child interrupt-controller node\n");
+			goto err_out;
+		}
+		need_put = true;
+	}
+
+	if (!intx_domain_ops) {
+		irqd_ops = (struct irq_domain_ops *)devm_kmalloc(dev,
+				sizeof(struct irq_domain_ops), GFP_KERNEL);
+		if (!irqd_ops) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+
+		irqd_ops->map = &pcie_intx_map;
+		if (general_xlate)
+			irqd_ops->xlate = &pci_irqd_intx_xlate;
+		intx_domain_ops = irqd_ops;
+	}
+#ifdef CONFIG_IRQ_DOMAIN
+	domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
+				       intx_domain_ops, host);
+#endif
+	if (!domain) {
+		dev_err(dev, "failed to get a INTx IRQ domain\n");
+		goto err_out;
+	}
+
+	return domain;
+err_out:
+	if (need_put)
+		of_node_put(intc);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(pci_host_alloc_intx_irqd);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b..8360972 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -31,6 +31,9 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
 #include <linux/resource_ext.h>
 #include <uapi/linux/pci.h>
 
@@ -1453,6 +1456,10 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 	return 0;
 }
 
+struct irq_domain *pci_host_alloc_intx_irqd(struct device *dev,
+				void *host, bool general_xlate,
+				const struct irq_domain_ops *intx_domain_ops,
+				struct device_node *local_intc);
 #ifdef CONFIG_PCIEPORTBUS
 extern bool pcie_ports_disabled;
 extern bool pcie_ports_native;
-- 
1.9.1
