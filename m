Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:43778 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbcECOeO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2016 10:34:14 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 3 May 2016 23:23:54 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
	alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 02/22] powerpc/pci: Override pcibios_setup_bridge()
Date: Tue,  3 May 2016 23:22:33 +1000
Message-Id: <1462281773-26438-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This overrides pcibios_setup_bridge() that is called to update PCI
bridge windows when PCI resource assignment is completed, to assign
PE and setup various (resource) mapping for the PE in subsequent
patches.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/pci-bridge.h | 2 ++
 arch/powerpc/kernel/pci-common.c      | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 467c0b0..b5e88e4 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -33,6 +33,8 @@ struct pci_controller_ops {
 	/* Called during PCI resource reassignment */
 	resource_size_t (*window_alignment)(struct pci_bus *bus,
 					    unsigned long type);
+	void		(*setup_bridge)(struct pci_bus *bus,
+					unsigned long type);
 	void		(*reset_secondary_bus)(struct pci_dev *pdev);
 
 #ifdef CONFIG_PCI_MSI
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0f7a60f..40df3a5 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -124,6 +124,14 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 	return 1;
 }
 
+void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+
+	if (hose->controller_ops.setup_bridge)
+		hose->controller_ops.setup_bridge(bus, type);
+}
+
 void pcibios_reset_secondary_bus(struct pci_dev *dev)
 {
 	struct pci_controller *phb = pci_bus_to_host(dev->bus);
-- 
2.1.0

