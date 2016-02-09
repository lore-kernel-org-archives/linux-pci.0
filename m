Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:27137 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbcBITZL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 14:25:11 -0500
From: jakeo@microsoft.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH RESEND v2 2/3] PCI: irqdomain: Look up IRQ domain by fwnode_handle
Date: Tue,  9 Feb 2016 19:24:27 +0000
Message-Id: <1455045869-38341-3-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1455045869-38341-1-git-send-email-jakeo@microsoft.com>
References: <1455045869-38341-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch adds a second way of finding an IRQ domain associated with
a root PCI bus.  After looking to see if one can be found through
the OF tree, it attempts to look up the IRQ domain through an
fwnode_handle stored in the pci_sysdata struct.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/pci/probe.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d7ab9b..1e34d21 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -15,6 +15,7 @@
 #include <linux/pci-aspm.h>
 #include <linux/aer.h>
 #include <linux/acpi.h>
+#include <linux/irqdomain.h>
 #include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
@@ -675,6 +676,20 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 	if (!d)
 		d = pci_host_bridge_acpi_msi_domain(bus);
 
+#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+	/*
+	 * If no IRQ domain was found via the OF tree, try looking it up
+	 * directly through the fwnode_handle.
+	 */
+	if (!d) {
+		struct fwnode_handle *fwnode = pci_root_bus_fwnode(bus);
+
+		if (fwnode)
+			d = irq_find_matching_fwnode(fwnode,
+						     DOMAIN_BUS_PCI_MSI);
+	}
+#endif
+
 	return d;
 }
 
-- 
1.9.1

