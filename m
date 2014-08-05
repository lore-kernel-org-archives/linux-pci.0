Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35922 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710AbaHEQMG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:06 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so8234293wiw.3
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:05 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 10/22] Added (untested) support to cris architecture to accomodate new irq init code
Date: Tue,  5 Aug 2014 17:11:11 +0100
Message-Id: <1407255083-9356-11-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 arch/cris/arch-v32/drivers/pci/bios.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
index 64a5fb9..d04ecc8 100644
--- a/arch/cris/arch-v32/drivers/pci/bios.c
+++ b/arch/cris/arch-v32/drivers/pci/bios.c
@@ -80,20 +80,16 @@ int pcibios_enable_resources(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-int pcibios_enable_irq(struct pci_dev *dev)
+int pcibios_enable_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	dev->irq = EXT_INTR_VECT;
 	return 0;
 }
 
-int pcibios_enable_device(struct pci_dev *dev, int mask)
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
-	int err;
-
-	if ((err = pcibios_enable_resources(dev, mask)) < 0)
-		return err;
-
-	if (!dev->msi_enabled)
-		pcibios_enable_irq(dev);
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = pcibios_enable_irq;
 	return 0;
 }
+
-- 
2.0.4

