Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH v2 2/3] Revert "PCI: Add helpers to manage pci_dev->irq and
 pci_dev->irq_managed"
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?utf-8?b?0J7Qu9C10LM=?= =?utf-8?b?0JzQvtGA0L7Qtw==?=
	<oleg.moroz@mcc.vniiem.ru>, Joerg Roedel <jroedel@suse.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Date: Wed, 17 Feb 2016 12:37:14 -0600
Message-ID: <20160217183714.302.80092.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160217182718.302.10272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160217182718.302.10272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Revert 811a4e6fce09 ("PCI: Add helpers to manage pci_dev->irq and
pci_dev->irq_managed").

This is part of reverting 991de2e59090 ("PCI, x86: Implement
pcibios_alloc_irq() and pcibios_free_irq()") to fix regressions it
introduced.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=111211
Fixes: 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c |    4 ++--
 arch/x86/pci/irq.c           |   10 ++++++----
 drivers/acpi/pci_irq.c       |   10 ++++++----
 include/linux/pci.h          |   17 -----------------
 4 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 0d24e7c..8826ff5 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -215,7 +215,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 	int polarity;
 	int ret;
 
-	if (pci_has_managed_irq(dev))
+	if (dev->irq_managed && dev->irq > 0)
 		return 0;
 
 	switch (intel_mid_identify_cpu()) {
@@ -256,7 +256,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 
 static void intel_mid_pci_irq_disable(struct pci_dev *dev)
 {
-	if (pci_has_managed_irq(dev)) {
+	if (dev->irq_managed && dev->irq > 0) {
 		mp_unmap_irq(dev->irq);
 		dev->irq_managed = 0;
 		/*
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 32e7034..72108f0 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1202,7 +1202,7 @@ static int pirq_enable_irq(struct pci_dev *dev)
 			struct pci_dev *temp_dev;
 			int irq;
 
-			if (pci_has_managed_irq(dev))
+			if (dev->irq_managed && dev->irq > 0)
 				return 0;
 
 			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number,
@@ -1230,7 +1230,8 @@ static int pirq_enable_irq(struct pci_dev *dev)
 			}
 			dev = temp_dev;
 			if (irq >= 0) {
-				pci_set_managed_irq(dev, irq);
+				dev->irq_managed = 1;
+				dev->irq = irq;
 				dev_info(&dev->dev, "PCI->APIC IRQ transform: "
 					 "INT %c -> IRQ %d\n", 'A' + pin - 1, irq);
 				return 0;
@@ -1258,8 +1259,9 @@ static int pirq_enable_irq(struct pci_dev *dev)
 
 static void pirq_disable_irq(struct pci_dev *dev)
 {
-	if (io_apic_assign_pci_irqs && pci_has_managed_irq(dev)) {
+	if (io_apic_assign_pci_irqs && dev->irq_managed && dev->irq) {
 		mp_unmap_irq(dev->irq);
-		pci_reset_managed_irq(dev);
+		dev->irq = 0;
+		dev->irq_managed = 0;
 	}
 }
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index d30184c..9032db7 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -406,7 +406,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		return 0;
 	}
 
-	if (pci_has_managed_irq(dev))
+	if (dev->irq_managed && dev->irq > 0)
 		return 0;
 
 	entry = acpi_pci_irq_lookup(dev, pin);
@@ -451,7 +451,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		kfree(entry);
 		return rc;
 	}
-	pci_set_managed_irq(dev, rc);
+	dev->irq = rc;
+	dev->irq_managed = 1;
 
 	if (link)
 		snprintf(link_desc, sizeof(link_desc), " -> Link[%s]", link);
@@ -474,7 +475,7 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	u8 pin;
 
 	pin = dev->pin;
-	if (!pin || !pci_has_managed_irq(dev))
+	if (!pin || !dev->irq_managed || dev->irq <= 0)
 		return;
 
 	entry = acpi_pci_irq_lookup(dev, pin);
@@ -496,6 +497,7 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	dev_dbg(&dev->dev, "PCI INT %c disabled\n", pin_name(pin));
 	if (gsi >= 0) {
 		acpi_unregister_gsi(gsi);
-		pci_reset_managed_irq(dev);
+		dev->irq_managed = 0;
+		dev->irq = 0;
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27df4a6..2771625 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -988,23 +988,6 @@ static inline int pci_is_managed(struct pci_dev *pdev)
 	return pdev->is_managed;
 }
 
-static inline void pci_set_managed_irq(struct pci_dev *pdev, unsigned int irq)
-{
-	pdev->irq = irq;
-	pdev->irq_managed = 1;
-}
-
-static inline void pci_reset_managed_irq(struct pci_dev *pdev)
-{
-	pdev->irq = 0;
-	pdev->irq_managed = 0;
-}
-
-static inline bool pci_has_managed_irq(struct pci_dev *pdev)
-{
-	return pdev->irq_managed && pdev->irq > 0;
-}
-
 void pci_disable_device(struct pci_dev *dev);
 
 extern unsigned int pcibios_max_latency;

