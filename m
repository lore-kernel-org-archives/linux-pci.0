Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:54433 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757750AbeD0Ial (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2018 04:30:41 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/9] PCI: Add new helper for allocating irq domain for INTx
Date: Fri, 27 Apr 2018 16:22:47 +0800
Message-Id: <1524817367-239076-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1524817322-239028-1-git-send-email-shawn.lin@rock-chips.com>
References: <1524817322-239028-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It seems host drivers which allocate irq domain for INTx
and the related code block looks highly similar to each other.
Add a new helper, pci_alloc_intx_irqd(), to avoid code duplication
as much as possible.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 include/linux/pci.h | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 73178a2..68a1994 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -31,6 +31,8 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/of_irq.h>
 #include <linux/resource_ext.h>
 #include <uapi/linux/pci.h>
 
@@ -1449,6 +1451,74 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 	return 0;
 }
 
+static int pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+				  irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static struct irq_domain_ops pci_intx_domain_ops = {
+	.map = pcie_intx_map,
+};
+
+/**
+ * pci_alloc_intx_irqd() - PCI helper for allocating INTx irq domain
+ * @dev: device associated with the PCI controller.
+ * @host: pointer to host specific data struct
+ * @general_xlate: flag for whether use pci_irqd_intx_xlate() helper
+ * @intx_domain_ops: pointer to driver specific struct irq_domain_ops
+ * @local_intc: pointer to driver specific interrupt controller node
+ *
+ * A simple helper for drivers to allocate irq domain for INTx. If
+ * intx_domain_ops is NULL, use pci_intx_domain_ops by defalut. And if
+ * local_intc is present, then use it firstly, otherwise, fallback to get
+ * interrupt controller node from @dev.
+ *
+ * Returns valid pointer of struct irq_domain on success, or PTR_ERR(-EINVAL)
+ * if failure occurred.
+ */
+static __maybe_unused struct irq_domain *pci_alloc_intx_irqd(struct device *dev,
+				void *host, bool general_xlate,
+				const struct irq_domain_ops *intx_domain_ops,
+				struct device_node *local_intc)
+{
+	struct device_node *intc = local_intc;
+	struct irq_domain *domain;
+	const struct irq_domain_ops *irqd_ops;
+	bool need_put = false;
+
+	if (!intc) {
+		intc = of_get_next_child(dev->of_node, NULL);
+		if (!intc) {
+			dev_err(dev, "missing child interrupt-controller node\n");
+			return ERR_PTR(-EINVAL);
+		}
+		need_put = true;
+	}
+
+	if (intx_domain_ops) {
+		irqd_ops = intx_domain_ops;
+	} else {
+		if (general_xlate)
+			pci_intx_domain_ops.xlate = &pci_irqd_intx_xlate;
+		irqd_ops = &pci_intx_domain_ops;
+	}
+
+	domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
+				       irqd_ops, host);
+	if (!domain) {
+		dev_err(dev, "failed to get a INTx IRQ domain\n");
+		if (need_put)
+			of_node_put(intc);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return domain;
+}
+
 #ifdef CONFIG_PCIEPORTBUS
 extern bool pcie_ports_disabled;
 #else
@@ -1683,6 +1753,10 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 				      unsigned long *out_hwirq,
 				      unsigned int *out_type)
 { return -EINVAL; }
+
+static __maybe_unused struct irq_domain *pci_alloc_intx_irqd(struct device *dev,
+	void *host, bool general_xlate, const struct irq_domain_ops *ops)
+{ return ERR_PTR(-EINVAL); }
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
-- 
1.9.1
