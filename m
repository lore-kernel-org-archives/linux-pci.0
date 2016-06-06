Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22354 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbcFFNGr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 09:06:47 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/4] PCI / PCIe: Introduce module_pci_port_service()
Date: Mon,  6 Jun 2016 16:06:05 +0300
Message-Id: <1465218368-36494-2-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As used elsewhere in the kernel already. This will reduce amount of
boilerblate code PCIe port service drivers otherwise need to open-code.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 include/linux/pcieport_if.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/pcieport_if.h b/include/linux/pcieport_if.h
index afcd130ab3a9..9276a85bffde 100644
--- a/include/linux/pcieport_if.h
+++ b/include/linux/pcieport_if.h
@@ -67,4 +67,17 @@ struct pcie_port_service_driver {
 int pcie_port_service_register(struct pcie_port_service_driver *new);
 void pcie_port_service_unregister(struct pcie_port_service_driver *new);
 
+/**
+ * module_pcie_port_service() - Helper macro for registering a PCI driver
+ * @__port_service: pcie_port_service struct
+ *
+ * Helper macro for PCIe port service drivers which do not do anything
+ * special in module init/exit. This eliminates a lot of boilerplate. Each
+ * module may only use this macro once, and calling it replaces
+ * module_init() and module_exit()
+ */
+#define module_pcie_port_service(__port_service) \
+	module_driver(__port_service, pcie_port_service_register, \
+		      pcie_port_service_unregister)
+
 #endif /* _PCIEPORT_IF_H_ */
-- 
2.8.1

