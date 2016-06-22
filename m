Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:34899 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbcFVCUI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2016 22:20:08 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI/MSI: Simplify the return value of arch_setup_msi_irqs
Date: Wed, 22 Jun 2016 10:18:35 +0800
Message-Id: <1466561915-25929-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No any callers do care whether arch_setup_msi_irqs returns
-ENOSPC or other error numbers. That means they treat the
negative numbers in the same way. So there shouldn't make any
difference to directly return -ENOSPC if finding it's non-zero.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/msi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a080f44..4a40b72 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -108,7 +108,7 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct msi_controller *chip = dev->bus->msi;
 	struct msi_desc *entry;
-	int ret;
+	int ret = 0;
 
 	if (chip && chip->setup_irqs)
 		return chip->setup_irqs(chip, dev, nvec, type);
@@ -119,13 +119,10 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
 
-	for_each_pci_msi_entry(entry, dev) {
+	for_each_pci_msi_entry(entry, dev)
 		ret = arch_setup_msi_irq(dev, entry);
-		if (ret < 0)
-			return ret;
-		if (ret > 0)
+		if (ret)
 			return -ENOSPC;
-	}
 
 	return 0;
 }
-- 
2.3.7


