Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] xen/pci: Use acpi_noirq_set() helper
Date: Fri, 10 Nov 2017 20:08:19 +0200
Message-Id: <20171110180819.83868-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No need to keep an #ifdef since we have a helper (in x86 world).
Use it instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- resend as v2 with slightly longer Cc list, i.e. +Rafael and ACPI ML
- in v1 Bjorn told he is okay with patch, but assumed it goes not via PCI tree
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
2.14.2

