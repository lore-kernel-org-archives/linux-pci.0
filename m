Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50857 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758018AbbFQTD4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Jun 2015 15:03:56 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] x86: intel_mid_pci: work around for IRQ0 assignment
Date: Wed, 17 Jun 2015 22:03:50 +0300
Message-Id: <1434567830-237840-3-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1434567830-237840-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1434567830-237840-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A few devices on Intel Edison board (Intel Tangier) has IRQ0 as an IRQ line in
the PCI configuration. The actual one which is using that is a first eMMC host
controller.

In case we compile sdhci-pci as a module and leave serial driver built-in,
first serial device not in use and has IRQ0 assigned as well, the latter takes
the interrupt allocation. The result of such behaviour is impossibility to
allocate the interrupt by sdhci-pci driver.

This patch introduces a quirk inside intel_mid_pci_irq_enable() to avoid
described behaviour.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 0af2e78..66e215d 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -206,15 +206,33 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 			       where, size, value);
 }
 
+#define PCI_DEVICE_ID_INTEL_MRFL_MMC	0x1190
+
 static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 {
 	struct irq_alloc_info info;
 	int polarity;
 	int ret;
 
-	if (dev->irq_managed && dev->irq > 0)
+	if (dev->irq_managed && dev->irq >= 0)
 		return 0;
 
+	/* Special treatment for IRQ0 */
+	if (dev->irq == 0) {
+		switch (intel_mid_identify_cpu()) {
+		case INTEL_MID_CPU_CHIP_TANGIER:
+			/*
+			 * TNG has IRQ0 assigned to eMMC controller. This makes
+			 * it happy to get an interrupt.
+			 */
+			if (dev->device != PCI_DEVICE_ID_INTEL_MRFL_MMC)
+				return -EBUSY;
+			break;
+		default:
+			break;
+		}
+	}
+
 	/* Set IRQ polarity */
 	if (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_TANGIER)
 		polarity = 0; /* active high */
-- 
2.1.4

