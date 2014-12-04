Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:56105 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbaLDFy6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Dec 2014 00:54:58 -0500
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Dec 2014 11:24:56 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9E396394004E
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2014 11:24:52 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sB45v0ow000334
	for <linux-pci@vger.kernel.org>; Thu, 4 Dec 2014 11:27:00 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sB45spk5004666
	for <linux-pci@vger.kernel.org>; Thu, 4 Dec 2014 11:24:51 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/5] powerpc/pci: Move pcibios_find_pci_bus() around
Date: Thu,  4 Dec 2014 16:54:44 +1100
Message-Id: <1417672488-27341-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1417672488-27341-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1417672488-27341-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch moves pcibios_find_pci_bus() to PPC kerenl directory so
that it can be reused by hotplug code for pSeries and PowerNV
platform at the same time.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/pci-hotplug.c          | 36 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pci_dlpar.c | 32 --------------------------
 2 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 5b78917..6e2b4e3 100644
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
index 89e2381..98c50bc 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -32,38 +32,6 @@
 #include <asm/firmware.h>
 #include <asm/eeh.h>
 
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
1.8.3.2

