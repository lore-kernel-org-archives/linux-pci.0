Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:36612 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbdGQKjL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jul 2017 06:39:11 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] xen/pci: Use acpi_noirq_set() helper
Date: Mon, 17 Jul 2017 13:39:07 +0300
Message-Id: <20170717103907.77308-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No need to keep an #ifdef since we have a helper (in x86 world).
Use it instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/pci/xen.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index c4b3646bd04c..9542a746dc50 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -409,10 +409,8 @@ int __init pci_xen_init(void)
 	pcibios_enable_irq = xen_pcifront_enable_irq;
 	pcibios_disable_irq = NULL;
 
-#ifdef CONFIG_ACPI
 	/* Keep ACPI out of the picture */
-	acpi_noirq = 1;
-#endif
+	acpi_noirq_set();
 
 #ifdef CONFIG_PCI_MSI
 	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
-- 
2.11.0
