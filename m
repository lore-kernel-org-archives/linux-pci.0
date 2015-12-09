Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:13515 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbbLIWz0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2015 17:55:26 -0500
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v9 4/7] PCI: Add fwnode_handle to pci_sysdata
Date: Wed,  9 Dec 2015 22:54:54 +0000
Message-Id: <1449701697-6366-5-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1449701697-6366-1-git-send-email-jakeo@microsoft.com>
References: <1449701697-6366-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch adds an fwnode_handle to struct pci_sysdata, which is
used by the next patch in the series when trying to locate an
IRQ domain associated with a root PCI bus.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 arch/x86/include/asm/pci.h | 15 +++++++++++++++
 drivers/pci/probe.c        |  1 +
 include/linux/pci.h        |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 4625943..6fc3c7c 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -20,6 +20,9 @@ struct pci_sysdata {
 #ifdef CONFIG_X86_64
 	void		*iommu;		/* IOMMU private data */
 #endif
+#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+	void		*fwnode;	/* IRQ domain for MSI assignment */
+#endif
 };
 
 extern int pci_routeirq;
@@ -32,6 +35,7 @@ extern int noioapicreroute;
 static inline int pci_domain_nr(struct pci_bus *bus)
 {
 	struct pci_sysdata *sd = bus->sysdata;
+
 	return sd->domain;
 }
 
@@ -41,6 +45,17 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 }
 #endif
 
+#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
+{
+	struct pci_sysdata *sd = bus->sysdata;
+
+	return sd->fwnode;
+}
+
+#define pci_root_bus_fwnode	_pci_root_bus_fwnode
+#endif
+
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index edb1984..750f907 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -15,6 +15,7 @@
 #include <linux/pci-aspm.h>
 #include <linux/aer.h>
 #include <linux/acpi.h>
+#include <linux/irqdomain.h>
 #include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6ae25aa..b414422 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1517,6 +1517,10 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 
 #include <asm/pci.h>
 
+#ifndef pci_root_bus_fwnode
+#define pci_root_bus_fwnode(bus)	((void)(bus), NULL)
+#endif
+
 /* these helpers provide future and backwards compatibility
  * for accessing popular PCI BAR info */
 #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
-- 
1.9.1

