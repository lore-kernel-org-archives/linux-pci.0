Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62911 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbbG2JQx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Jul 2015 05:16:53 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/3] x86/pci/intel_mid_pci: work around for IRQ0 assignment
Date: Wed, 29 Jul 2015 12:16:47 +0300
Message-Id: <1438161409-4671-2-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1438161409-4671-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1438161409-4671-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Intel Tangier the MMC host controller is wired up to irq 0. But several
other devices have irq 0 associated as well due to a bogus PCI configuration.

The first initialized driver will acquire irq 0 and make it unavailable for
other devices. If the sdhci driver is not the first one it will fail to acquire
the interrupt and therefor be non functional.

Add a quirk to the pci irq enable function which denies irq 0 to anything else
than the MMC host controller driver on Tangier platforms.

Fixes: 90b9aacf912a (serial: 8250_pci: add Intel Tangier support)
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 2706230..7553921 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -35,6 +35,9 @@
 
 #define PCIE_CAP_OFFSET	0x100
 
+/* Quirks for the listed devices */
+#define PCI_DEVICE_ID_INTEL_MRFL_MMC	0x1190
+
 /* Fixed BAR fields */
 #define PCIE_VNDR_CAP_ID_FIXED_BAR 0x00	/* Fixed BAR (TBD) */
 #define PCI_FIXED_BAR_0_SIZE	0x04
@@ -214,10 +217,27 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 	if (dev->irq_managed && dev->irq > 0)
 		return 0;
 
-	if (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_TANGIER)
+	switch (intel_mid_identify_cpu()) {
+	case INTEL_MID_CPU_CHIP_TANGIER:
 		polarity = 0; /* active high */
-	else
+
+		/* Special treatment for IRQ0 */
+		if (dev->irq == 0) {
+			/*
+			 * TNG has IRQ0 assigned to eMMC controller. But there
+			 * are also other devices with bogus PCI configuration
+			 * that have IRQ0 assigned. This check ensures that
+			 * eMMC gets it.
+			 */
+			if (dev->device != PCI_DEVICE_ID_INTEL_MRFL_MMC)
+				return -EBUSY;
+		}
+		break;
+	default:
 		polarity = 1; /* active low */
+		break;
+	}
+
 	ioapic_set_alloc_attr(&info, dev_to_node(&dev->dev), 1, polarity);
 
 	/*
-- 
2.4.6

