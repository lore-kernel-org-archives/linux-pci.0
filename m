Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50857 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbbFQTDz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Jun 2015 15:03:55 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] x86: intel_mid_pci: propagate actual return code
Date: Wed, 17 Jun 2015 22:03:49 +0300
Message-Id: <1434567830-237840-2-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1434567830-237840-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1434567830-237840-1-git-send-email-andriy.shevchenko@linux.intel.com>
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
index 2706230..0af2e78 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -210,10 +210,12 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 {
 	struct irq_alloc_info info;
 	int polarity;
+	int ret;
 
 	if (dev->irq_managed && dev->irq > 0)
 		return 0;
 
+	/* Set IRQ polarity */
 	if (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_TANGIER)
 		polarity = 0; /* active high */
 	else
@@ -224,8 +226,9 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
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

