Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v2 3/4] PCI: Introduce helpers to manage pci_dev->irq and pci_dev->irq_managed
Date: Tue,  2 Jun 2015 10:49:18 +0800
Message-Id: <1433213360-3700-4-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433213360-3700-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433213360-3700-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce three helpers to manage pci_dev->irq and pci_dev->irq_managed,
which helps to improve maintenance.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c |    4 ++--
 arch/x86/pci/irq.c           |   10 ++++------
 drivers/acpi/pci_irq.c       |   10 ++++------
 include/linux/pci.h          |   17 +++++++++++++++++
 4 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index fb7a1f96d80c..22aaefb4f1ca 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -211,7 +211,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 	struct irq_alloc_info info;
 	int polarity;
 
-	if (dev->irq_managed && dev->irq > 0)
+	if (pci_has_managed_irq(dev))
 		return 0;
 
 	if (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_TANGIER)
@@ -234,7 +234,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 
 static void intel_mid_pci_irq_disable(struct pci_dev *dev)
 {
-	if (dev->irq_managed && dev->irq > 0) {
+	if (pci_has_managed_irq(dev)) {
 		mp_unmap_irq(dev->irq);
 		dev->irq_managed = 0;
 		/*
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 72108f0b66b1..32e70343e6fd 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1202,7 +1202,7 @@ static int pirq_enable_irq(struct pci_dev *dev)
 			struct pci_dev *temp_dev;
 			int irq;
 
-			if (dev->irq_managed && dev->irq > 0)
+			if (pci_has_managed_irq(dev))
 				return 0;
 
 			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number,
@@ -1230,8 +1230,7 @@ static int pirq_enable_irq(struct pci_dev *dev)
 			}
 			dev = temp_dev;
 			if (irq >= 0) {
-				dev->irq_managed = 1;
-				dev->irq = irq;
+				pci_set_managed_irq(dev, irq);
 				dev_info(&dev->dev, "PCI->APIC IRQ transform: "
 					 "INT %c -> IRQ %d\n", 'A' + pin - 1, irq);
 				return 0;
@@ -1259,9 +1258,8 @@ static int pirq_enable_irq(struct pci_dev *dev)
 
 static void pirq_disable_irq(struct pci_dev *dev)
 {
-	if (io_apic_assign_pci_irqs && dev->irq_managed && dev->irq) {
+	if (io_apic_assign_pci_irqs && pci_has_managed_irq(dev)) {
 		mp_unmap_irq(dev->irq);
-		dev->irq = 0;
-		dev->irq_managed = 0;
+		pci_reset_managed_irq(dev);
 	}
 }
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index e7f718d6918a..9d6343d02f7e 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -413,7 +413,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		return 0;
 	}
 
-	if (dev->irq_managed && dev->irq > 0)
+	if (pci_has_managed_irq(dev))
 		return 0;
 
 	entry = acpi_pci_irq_lookup(dev, pin);
@@ -458,8 +458,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		kfree(entry);
 		return rc;
 	}
-	dev->irq = rc;
-	dev->irq_managed = 1;
+	pci_set_managed_irq(dev, rc);
 
 	if (link)
 		snprintf(link_desc, sizeof(link_desc), " -> Link[%s]", link);
@@ -482,7 +481,7 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	u8 pin;
 
 	pin = dev->pin;
-	if (!pin || !dev->irq_managed || dev->irq <= 0)
+	if (!pin || !pci_has_managed_irq(dev))
 		return;
 
 	entry = acpi_pci_irq_lookup(dev, pin);
@@ -504,7 +503,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	dev_dbg(&dev->dev, "PCI INT %c disabled\n", pin_name(pin));
 	if (gsi >= 0) {
 		acpi_unregister_gsi(gsi);
-		dev->irq_managed = 0;
-		dev->irq = 0;
+		pci_reset_managed_irq(dev);
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f50d16a04abc..4bc640eef76f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -958,6 +958,23 @@ static inline int pci_is_managed(struct pci_dev *pdev)
 	return pdev->is_managed;
 }
 
+static inline void pci_set_managed_irq(struct pci_dev *pdev, unsigned int irq)
+{
+	pdev->irq = irq;
+	pdev->irq_managed = 1;
+}
+
+static inline void pci_reset_managed_irq(struct pci_dev *pdev)
+{
+	pdev->irq = 0;
+	pdev->irq_managed = 0;
+}
+
+static inline bool pci_has_managed_irq(struct pci_dev *pdev)
+{
+	return pdev->irq_managed && pdev->irq > 0;
+}
+
 void pci_disable_device(struct pci_dev *dev);
 
 extern unsigned int pcibios_max_latency;
-- 
1.7.10.4

