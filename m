Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/3] x86/pci/intel_mid_pci: propagate actual return code
Date: Wed, 29 Jul 2015 12:16:48 +0300
Message-Id: <1438161409-4671-3-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1438161409-4671-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1438161409-4671-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

mp_map_gsi_to_irq() returns different codes if it fails.
intel_mid_pci_irq_enable() hides this under -EBUSY. The patch replaces it by
what is actually returned.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 7553921..3361f0a 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -213,6 +213,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 {
 	struct irq_alloc_info info;
 	int polarity;
+	int ret;
 
 	if (dev->irq_managed && dev->irq > 0)
 		return 0;
@@ -244,8 +245,9 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 	 * MRST only have IOAPIC, the PCI irq lines are 1:1 mapped to
 	 * IOAPIC RTE entries, so we just enable RTE for the device.
 	 */
-	if (mp_map_gsi_to_irq(dev->irq, IOAPIC_MAP_ALLOC, &info) < 0)
-		return -EBUSY;
+	ret = mp_map_gsi_to_irq(dev->irq, IOAPIC_MAP_ALLOC, &info);
+	if (ret < 0)
+		return ret;
 
 	dev->irq_managed = 1;
 
-- 
2.4.6

