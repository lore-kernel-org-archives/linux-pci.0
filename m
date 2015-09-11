Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 04/12] drivers:pci: Add IRQ domain lookup by PCI domain
Date: Fri, 11 Sep 2015 00:01:03 +0000
Message-Id: <1441929670-10058-5-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

The PCI driver currently looks up IRQ domains for root PCI buses by walking
up the Open Firmware tree looking for any that cover this particular PCI root.
Since x86 PCs don't implement Open Firmware, this patch offers an alternative
lookup by the PCI domain ID (known as "segment" in the PCI and ACPI specs.)

I could have tried to build a (fake) Open Firmware tree and leverage the old
code, but I rejected that possibility both because it would have required
changes in lots of other places and because most distributions don't even
compile in the OF infrastructure when targeting PCs.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/pci/probe.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0b2be17..e7e5ff3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/pci-aspm.h>
+#include <linux/irqdomain.h>
 #include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
@@ -663,12 +664,22 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 {
 	struct irq_domain *d;
+	int pci_domain;
 
 	/*
 	 * Any firmware interface that can resolve the msi_domain
 	 * should be called from here.
 	 */
 	d = pci_host_bridge_of_msi_domain(bus);
+	if (d)
+		return d;
+
+	/*
+	 * If firmware couldn't help find, it try looking it up by PCI
+	 * domain/segment.
+	 */
+	pci_domain = pci_domain_nr(bus);
+	d = irq_find_matching_host(NULL, DOMAIN_BUS_PCI_MSI, &pci_domain);
 
 	return d;
 }
-- 
1.9.1

