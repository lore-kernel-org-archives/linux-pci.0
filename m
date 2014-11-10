Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:55448 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbaKJM0R (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Nov 2014 07:26:17 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH] drivers: of: move PCI domain assignment to generic OF code
Date: Mon, 10 Nov 2014 12:26:08 +0000
Message-Id: <1415622368-14612-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current logic used for PCI domain assignment in arm64
pci_bus_assign_domain_nr() is flawed in that, depending on the host
controllers configuration for a platform and the respective initialization
sequence, core code may end up allocating PCI domain numbers from both DT and
the core code generic domain counter, which would result in PCI domain
allocation aliases/errors.

This patch fixes the logic behind the PCI domain number assignment and
move the resulting code to the generic OF layer so that other archs can
reuse the same domain allocation logic instead of resorting to an arch
specific implementation that might end up duplicating the PCI domain
assignment logic wrongly.

If OF is not configured for a platform, the code falls back to the
generic domain numbering implementation through the pci_get_new_domain_nr()
API.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/pci.c | 14 +++--------
 drivers/of/of_pci.c     | 66 +++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/of_pci.h  |  7 +++---
 3 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index ce5836c..5e21c1c 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -49,20 +49,14 @@ int pcibios_add_device(struct pci_dev *dev)
 
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-static bool dt_domain_found = false;
 
 void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 {
-	int domain = of_get_pci_domain_nr(parent->of_node);
+	int domain = of_assign_pci_domain_nr(parent->of_node);
 
-	if (domain >= 0) {
-		dt_domain_found = true;
-	} else if (dt_domain_found == true) {
-		dev_err(parent, "Node %s is missing \"linux,pci-domain\" property in DT\n",
-			parent->of_node->full_name);
-		return;
-	} else {
-		domain = pci_get_new_domain_nr();
+	if (domain < 0) {
+		dev_err(parent, "PCI domain assignment failed\n");
+		domain = -1;
 	}
 
 	bus->domain_nr = domain;
diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 8882b46..43bf591 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -100,7 +100,7 @@ EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
  * Returns the associated domain number from DT in the range [0-0xffff], or
  * a negative value if the required property is not found.
  */
-int of_get_pci_domain_nr(struct device_node *node)
+static int of_get_pci_domain_nr(struct device_node *node)
 {
 	const __be32 *value;
 	int len;
@@ -114,7 +114,69 @@ int of_get_pci_domain_nr(struct device_node *node)
 
 	return domain;
 }
-EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
+
+/**
+ * of_assign_pci_domain_nr() - Assign a PCI domain number
+ *
+ * @node: device tree node with the domain information
+ *
+ * This function assigns and returns the host bridge domain number by
+ * first parsing the device tree node to find the linux,pci-domain
+ * property and falling back to the generic domain number API if DT
+ * property is not present/valid. The function implements logic that prevents
+ * code from mixing domain numbers assignments from both DT and the
+ * generic domain number implementation and returns an error if such
+ * cases are detected at run-time.
+ *
+ * Returns the assigned domain number, or a negative value to signal an error
+ */
+int of_assign_pci_domain_nr(struct device_node *node)
+{
+	static int use_dt_domains = -1;
+	int domain = of_get_pci_domain_nr(node);
+
+	/*
+	 * Check DT domain and use_dt_domains values.
+	 *
+	 * If DT domain property is valid (domain >= 0) and
+	 * use_dt_domains != 0, the DT assignment is valid since this means
+	 * we have not previously allocated a domain number by using
+	 * pci_get_new_domain_nr().
+	 *
+	 * If use_dt_domains value is == 0 and the DT property provides a
+	 * valid domain number (>=0), this means that we are assigning a
+	 * domain number from DT but we have previously allocated a domain
+	 * number by using pci_get_new_domain_nr() so we should bail out with
+	 * an error.
+	 *
+	 * If DT domain property value is not valid, and we have not previously
+	 * assigned a domain number from DT (use_dt_domains != 1) we
+	 * should assign a domain number by using the
+	 *
+	 * pci_get_new_domain_nr()
+	 *
+	 * API and update the use_dt_domains value to keep track of method we
+	 * are using to assign domain numbers (use_dt_domains = 0).
+	 *
+	 * All other combinations imply we have a platform that is trying
+	 * to mix DT and generic domain number assignments, which is a recipe
+	 * for domain mishandling and it is prevented by returning an error
+	 * value to the caller.
+	 */
+	if (domain >= 0 && use_dt_domains) {
+		use_dt_domains = 1;
+	} else if (domain < 0 && use_dt_domains != 1) {
+		use_dt_domains = 0;
+		domain = pci_get_new_domain_nr();
+	} else {
+		pr_err("Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
+			node->full_name);
+		return -EINVAL;
+	}
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(of_assign_pci_domain_nr);
 
 #if defined(CONFIG_OF_ADDRESS)
 /**
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 1fd207e..fbba966 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -15,7 +15,7 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 int of_pci_get_devfn(struct device_node *np);
 int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
-int of_get_pci_domain_nr(struct device_node *node);
+int of_assign_pci_domain_nr(struct device_node *node);
 #else
 static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
 {
@@ -45,10 +45,9 @@ of_pci_parse_bus_range(struct device_node *node, struct resource *res)
 	return -EINVAL;
 }
 
-static inline int
-of_get_pci_domain_nr(struct device_node *node)
+static inline int of_assign_pci_domain_nr(struct device_node *node)
 {
-	return -1;
+	return pci_get_new_domain_nr();
 }
 #endif
 
-- 
2.1.2

