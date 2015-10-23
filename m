Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36212 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFFt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:49 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 07/29] x86/pci: Move pcibios_root_bridge_prepare from acpi.c to irq.c
Date: Fri, 23 Oct 2015 06:03:40 +0100
Message-Id: <1445576642-29624-8-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is always safe to run ACPI_COMPANION_SET even if we are using
a non acpi system. Therefore we move pcibios_root_bridge_prepare
into irq.c.

This should make no difference to behaviour at this time but
prepares for additional changes to pcibios_root_bridge_prepare
which must apply both to acpi and non acpi systems.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/x86/pci/acpi.c | 15 ---------------
 arch/x86/pci/irq.c  | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index ff99117..9b2f170 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -493,21 +493,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	return bus;
 }
 
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-{
-	/*
-	 * We pass NULL as parent to pci_create_root_bus(), so if it is not NULL
-	 * here, pci_create_root_bus() has been called by someone else and
-	 * sysdata is likely to be different from what we expect.  Let it go in
-	 * that case.
-	 */
-	if (!bridge->dev.parent) {
-		struct pci_sysdata *sd = bridge->bus->sysdata;
-		ACPI_COMPANION_SET(&bridge->dev, sd->companion);
-	}
-	return 0;
-}
-
 int __init pci_acpi_init(void)
 {
 	struct pci_dev *dev = NULL;
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 32e7034..350e785 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1162,6 +1162,21 @@ void __init pcibios_irq_init(void)
 	}
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	/*
+	 * We pass NULL as parent to pci_create_root_bus(), so if it is not NULL
+	 * here, pci_create_root_bus() has been called by someone else and
+	 * sysdata is likely to be different from what we expect.  Let it go in
+	 * that case.
+	 */
+	if (!bridge->dev.parent) {
+		struct pci_sysdata *sd = bridge->bus->sysdata;
+		ACPI_COMPANION_SET(&bridge->dev, sd->companion);
+	}
+	return 0;
+}
+
 static void pirq_penalize_isa_irq(int irq, int active)
 {
 	/*
-- 
2.6.2

