Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/3] x86/pci/intel_mid_pci: work around for IRQ0 assignment
Date: Wed,  8 Jul 2015 14:14:17 +0300
Message-Id: <1436354059-130135-2-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1436354059-130135-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1436354059-130135-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
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

Fixes: 90b9aacf912a (serial: 8250_pci: add Intel Tangier support)
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 2706230..5d7f4afe 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -206,6 +206,8 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 			       where, size, value);
 }
 
+#define PCI_DEVICE_ID_INTEL_MRFL_MMC	0x1190
+
 static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 {
 	struct irq_alloc_info info;
@@ -214,6 +216,22 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 	if (dev->irq_managed && dev->irq > 0)
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
 	if (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_TANGIER)
 		polarity = 0; /* active high */
 	else
-- 
2.1.4

