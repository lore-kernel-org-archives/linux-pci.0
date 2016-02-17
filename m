Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:59569 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933709AbcBQDpj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 22:45:39 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 17 Feb 2016 13:45:36 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 02/45] powerpc/pci: Override pcibios_setup_bridge()
Date: Wed, 17 Feb 2016 14:43:45 +1100
Message-Id: <1455680668-23298-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This overrides pcibios_setup_bridge() that is called to update PCI
bridge windows when PCI resource assignment is completed, to assign
PE and setup various (resource) mapping for the PE in subsequent
patches.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h | 2 ++
 arch/powerpc/kernel/pci-common.c      | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 9f165e8..b688d04 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -33,6 +33,8 @@ struct pci_controller_ops {
 
 	/* Called during PCI resource reassignment */
 	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
+	void		(*setup_bridge)(struct pci_bus *bus,
+					unsigned long type);
 	void		(*reset_secondary_bus)(struct pci_dev *dev);
 
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

