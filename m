Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:36319 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbbFDGoE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 02:44:04 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 16:44:02 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
	panto@antoniou-consulting.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 31/42] powerpc/pci: Move pcibios_find_pci_bus() around
Date: Thu,  4 Jun 2015 16:42:00 +1000
Message-Id: <1433400131-18429-32-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch moves pcibios_find_pci_bus() to PPC kerenl directory so
that it can be reused by hotplug code for pSeries and PowerNV
platform at the same time.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
v5:
  * Derived from PATCH[v4 12/21]
---
 arch/powerpc/kernel/pci-hotplug.c          | 36 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pci_dlpar.c | 32 --------------------------
 2 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index ca392fc..1482bc1 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -21,6 +21,42 @@
 #include <asm/firmware.h>
 #include <asm/eeh.h>
 
+static struct pci_bus *find_pci_bus(struct pci_bus *bus,
+				    struct device_node *dn)
+{
+	struct pci_bus *tmp, *child = NULL;
+	struct device_node *busdn;
+
+	busdn = pci_bus_to_OF_node(bus);
+	if (busdn == dn)
+		return bus;
+
+	list_for_each_entry(tmp, &bus->children, node) {
+		child = find_pci_bus(tmp, dn);
+		if (child)
+			break;
+	}
+
+	return child;
+}
+
+/**
+ * pcibios_find_pci_bus - find PCI bus according to the given device node
+ * @dn: Device node
+ *
+ * Find the corresponding PCI bus according to the given device node.
+ */
+struct pci_bus *pcibios_find_pci_bus(struct device_node *dn)
+{
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	if (!pdn  || !pdn->phb || !pdn->phb->bus)
+		return NULL;
+
+	return find_pci_bus(pdn->phb->bus, dn);
+}
+EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
+
 /**
  * pcibios_release_device - release PCI device
  * @dev: PCI device
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 5d4a3df..906dbaa 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -34,38 +34,6 @@
 
 #include "pseries.h"
 
-static struct pci_bus *
-find_bus_among_children(struct pci_bus *bus,
-                        struct device_node *dn)
-{
-	struct pci_bus *child = NULL;
-	struct pci_bus *tmp;
-	struct device_node *busdn;
-
-	busdn = pci_bus_to_OF_node(bus);
-	if (busdn == dn)
-		return bus;
-
-	list_for_each_entry(tmp, &bus->children, node) {
-		child = find_bus_among_children(tmp, dn);
-		if (child)
-			break;
-	};
-	return child;
-}
-
-struct pci_bus *
-pcibios_find_pci_bus(struct device_node *dn)
-{
-	struct pci_dn *pdn = dn->data;
-
-	if (!pdn  || !pdn->phb || !pdn->phb->bus)
-		return NULL;
-
-	return find_bus_among_children(pdn->phb->bus, dn);
-}
-EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
-
 struct pci_controller *init_phb_dynamic(struct device_node *dn)
 {
 	struct pci_controller *phb;
-- 
2.1.0

