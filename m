Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Len Brown <lenb@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v3 2/4] PCI, x86: Allocate PCI IRQ on demand and free it when not used anymore
Date: Wed, 10 Jun 2015 16:54:59 +0800
Message-Id: <1433926501-22956-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433926501-22956-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433926501-22956-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To support IOAPIC hotplug, we need to correctly manage IOAPIC pin usage,
which is to allocate IRQs on demand and free them when not used anymore.
So use pcibios_alloc_irq() and pcibios_free_irq() to dynamically allocate
and free PCI IRQs.

Also remove obseleted code mp_should_keep_irq().

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/include/asm/pci_x86.h |    2 --
 arch/x86/pci/common.c          |   20 +++++++++-----------
 arch/x86/pci/intel_mid_pci.c   |    7 +++++--
 arch/x86/pci/irq.c             |   15 +--------------
 drivers/acpi/pci_irq.c         |    9 +--------
 5 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 164e3f8d3c3d..fa1195dae425 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -93,8 +93,6 @@ extern raw_spinlock_t pci_config_lock;
 extern int (*pcibios_enable_irq)(struct pci_dev *dev);
 extern void (*pcibios_disable_irq)(struct pci_dev *dev);
 
-extern bool mp_should_keep_irq(struct device *dev);
-
 struct pci_raw_ops {
 	int (*read)(unsigned int domain, unsigned int bus, unsigned int devfn,
 						int reg, int len, u32 *val);
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 8fd6f44aee83..dc78a4a9a466 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -673,24 +673,22 @@ int pcibios_add_device(struct pci_dev *dev)
 	return 0;
 }
 
-int pcibios_enable_device(struct pci_dev *dev, int mask)
+int pcibios_alloc_irq(struct pci_dev *dev)
 {
-	int err;
-
-	if ((err = pci_enable_resources(dev, mask)) < 0)
-		return err;
-
-	if (!pci_dev_msi_enabled(dev))
-		return pcibios_enable_irq(dev);
-	return 0;
+	return pcibios_enable_irq(dev);
 }
 
-void pcibios_disable_device (struct pci_dev *dev)
+void pcibios_free_irq(struct pci_dev *dev)
 {
-	if (!pci_dev_msi_enabled(dev) && pcibios_disable_irq)
+	if (pcibios_disable_irq)
 		pcibios_disable_irq(dev);
 }
 
+int pcibios_enable_device(struct pci_dev *dev, int mask)
+{
+	return pci_enable_resources(dev, mask);
+}
+
 int pci_ext_cfg_avail(void)
 {
 	if (raw_pci_ext_ops)
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 27062303c881..fb7a1f96d80c 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -234,10 +234,13 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 
 static void intel_mid_pci_irq_disable(struct pci_dev *dev)
 {
-	if (!mp_should_keep_irq(&dev->dev) && dev->irq_managed &&
-	    dev->irq > 0) {
+	if (dev->irq_managed && dev->irq > 0) {
 		mp_unmap_irq(dev->irq);
 		dev->irq_managed = 0;
+		/*
+		 * Don't reset dev->irq here, otherwise
+		 * intel_mid_pci_irq_enable() will fail on next call.
+		 */
 	}
 }
 
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 9bd115484745..72108f0b66b1 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1257,22 +1257,9 @@ static int pirq_enable_irq(struct pci_dev *dev)
 	return 0;
 }
 
-bool mp_should_keep_irq(struct device *dev)
-{
-	if (dev->power.is_prepared)
-		return true;
-#ifdef CONFIG_PM
-	if (dev->power.runtime_status == RPM_SUSPENDING)
-		return true;
-#endif
-
-	return false;
-}
-
 static void pirq_disable_irq(struct pci_dev *dev)
 {
-	if (io_apic_assign_pci_irqs && !mp_should_keep_irq(&dev->dev) &&
-	    dev->irq_managed && dev->irq) {
+	if (io_apic_assign_pci_irqs && dev->irq_managed && dev->irq) {
 		mp_unmap_irq(dev->irq);
 		dev->irq = 0;
 		dev->irq_managed = 0;
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index b1def411c0b8..e7f718d6918a 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -485,14 +485,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	if (!pin || !dev->irq_managed || dev->irq <= 0)
 		return;
 
-	/* Keep IOAPIC pin configuration when suspending */
-	if (dev->dev.power.is_prepared)
-		return;
-#ifdef	CONFIG_PM
-	if (dev->dev.power.runtime_status == RPM_SUSPENDING)
-		return;
-#endif
-
 	entry = acpi_pci_irq_lookup(dev, pin);
 	if (!entry)
 		return;
@@ -513,5 +505,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	if (gsi >= 0) {
 		acpi_unregister_gsi(gsi);
 		dev->irq_managed = 0;
+		dev->irq = 0;
 	}
 }
-- 
1.7.10.4

