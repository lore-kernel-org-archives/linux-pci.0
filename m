Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:16823 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbbIKAJN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 20:09:13 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 09/11] kernel:irq: Implement msi match function
Date: Fri, 11 Sep 2015 00:01:08 +0000
Message-Id: <1441929670-10058-10-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

Previous patches in this series introduced the concept of ranked matches of
IRQ domains, where a default implementation ranks low and a specific
implementation might rank higher, overriding the default.

This patch supplies a match function for use by any IRQ domain derived from
the default MSI IRQ domain.  It returns a rank of '1' when the IRQ domain
does not ask for a match based on PCI domain and a rank of '2' if the IRQ
domain does set the flag indicating that it wants a more specific match.

At this point in the patch series, there is no implementation of an MSI IRQ
domain which asks for a more specific match.  That's found in the final patch,
introducing a new driver.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 include/linux/msi.h |  2 ++
 kernel/irq/msi.c    | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7370225..a8ee7a1 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -259,6 +259,8 @@ enum {
 	MSI_FLAG_MULTI_PCI_MSI		= (1 << 3),
 	/* Support PCI MSIX interrupts */
 	MSI_FLAG_PCI_MSIX		= (1 << 4),
+	/* Require exact match for PCI domain */
+	MSI_FLAG_PCI_DOMAIN_MATCH	= (1 << 5),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 7e6512b..5fcd68c 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -141,11 +141,35 @@ static void msi_domain_free(struct irq_domain *domain, unsigned int virq,
 	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
 
+/*
+ * Return a higher rank for exact matches against PCI domain (segment)
+ * so that generic MSI IRQ domains can be overridden by more specific
+ * implementations.
+ */
+static int msi_domain_match(struct irq_domain *d, struct device_node *node,
+			    enum irq_domain_bus_token bus_token,
+			    void *bus_data)
+{
+	struct msi_domain_info *info = d->host_data;
+
+	if (bus_token != d->bus_token)
+		return 0;
+
+	if (bus_token == DOMAIN_BUS_PCI_MSI) {
+		if (!(info->flags & MSI_FLAG_PCI_DOMAIN_MATCH))
+			return 1;
+		if (bus_data && (info->pci_domain == *(int *)bus_data))
+			return 2;
+	}
+	return 0;
+}
+
 static const struct irq_domain_ops msi_domain_ops = {
 	.alloc		= msi_domain_alloc,
 	.free		= msi_domain_free,
 	.activate	= msi_domain_activate,
 	.deactivate	= msi_domain_deactivate,
+	.match		= msi_domain_match,
 };
 
 #ifdef GENERIC_MSI_DOMAIN_OPS
-- 
1.9.1

