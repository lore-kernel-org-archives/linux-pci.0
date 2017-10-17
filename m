Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54926 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbdJQH43 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 03:56:29 -0400
Message-Id: <20171017075600.527569354@linutronix.de>
Date: Tue, 17 Oct 2017 09:54:59 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-pci@vger.kernel.org, devel@linuxdriverproject.org,
        Josh Poulson <jopoulso@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [patch 3/3] x86/vector/msi: Select CONFIG_GENERIC_IRQ_RESERVATION_MODE
References: <20171017075456.694047687@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Select CONFIG_GENERIC_IRQ_RESERVATION_MODE so PCI/MSI domains get the
MSI_FLAG_MUST_REACTIVATE flag set in pci_msi_create_irq_domain().

Remove the explicit setters of this flag in the apic/msi code as they are
not longer required.

Fixes: 4900be83602b ("x86/vector/msi: Switch to global reservation mode")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig           |    2 +-
 arch/x86/kernel/apic/msi.c |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -95,7 +95,7 @@ config X86
 	select GENERIC_IRQ_MATRIX_ALLOCATOR	if X86_LOCAL_APIC
 	select GENERIC_IRQ_MIGRATION		if SMP
 	select GENERIC_IRQ_PROBE
-	select GENERIC_IRQ_SHOW
+	select GENERIC_IRQ_RESERVATION_MODE
 	select GENERIC_PENDING_IRQ		if SMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -129,7 +129,7 @@ static struct msi_domain_ops pci_msi_dom
 
 static struct msi_domain_info pci_msi_domain_info = {
 	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_PCI_MSIX | MSI_FLAG_MUST_REACTIVATE,
+			  MSI_FLAG_PCI_MSIX,
 	.ops		= &pci_msi_domain_ops,
 	.chip		= &pci_msi_controller,
 	.handler	= handle_edge_irq,
@@ -167,8 +167,7 @@ static struct irq_chip pci_msi_ir_contro
 
 static struct msi_domain_info pci_msi_ir_domain_info = {
 	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX |
-			  MSI_FLAG_MUST_REACTIVATE,
+			  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
 	.ops		= &pci_msi_domain_ops,
 	.chip		= &pci_msi_ir_controller,
 	.handler	= handle_edge_irq,
