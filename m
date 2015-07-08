Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30312 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758064AbbGHLOo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Jul 2015 07:14:44 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] x86/pci/intel_mid_pci: propagate actual return code
Date: Wed,  8 Jul 2015 14:14:18 +0300
Message-Id: <1436354059-130135-3-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1436354059-130135-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1436354059-130135-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

mp_map_gsi_to_irq() returns different codes if it fails.
intel_mid_pci_irq_enable() hides this under -EBUSY. The patch replaces it by
what is actually returned.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 5d7f4afe..4739834 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -212,6 +212,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 {
 	struct irq_alloc_info info;
 	int polarity;
+	int ret;
 
 	if (dev->irq_managed && dev->irq > 0)
 		return 0;
@@ -232,6 +233,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		}
 	}
 
+	/* Set IRQ polarity */
 	if (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_TANGIER)
 		polarity = 0; /* active high */
 	else
@@ -242,8 +244,9 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
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
2.1.4

