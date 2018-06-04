Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36902 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeFDPsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jun 2018 11:48:11 -0400
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: access.c: Piggyback user config access on pci_read/write_*()
Date: Mon,  4 Jun 2018 10:48:02 -0500
Message-Id: <20180604154803.14185-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_read/write_config*() functions have several safeguards to prevent
stallling accesses when a device is removed. However, their "_user_"
counterparts use a different code path.

To make sure that safeguards are used for userspace PCI config
accesses, piggyback the "_user_" functions on the in-kernel
pci_read/write_config*().

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/access.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index a3ad2fe185b9..6db2a8713c85 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -223,16 +223,9 @@ int pci_user_read_config_##size						\
 	(struct pci_dev *dev, int pos, type *val)			\
 {									\
 	int ret = PCIBIOS_SUCCESSFUL;					\
-	u32 data = -1;							\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
-	raw_spin_lock_irq(&pci_lock);				\
-	if (unlikely(dev->block_cfg_access))				\
-		pci_wait_cfg(dev);					\
-	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
-					pos, sizeof(type), &data);	\
-	raw_spin_unlock_irq(&pci_lock);				\
-	*val = (type)data;						\
+	ret = pci_read_config_##size(dev, pos, val);			\
 	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
@@ -245,12 +238,7 @@ int pci_user_write_config_##size					\
 	int ret = PCIBIOS_SUCCESSFUL;					\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
-	raw_spin_lock_irq(&pci_lock);				\
-	if (unlikely(dev->block_cfg_access))				\
-		pci_wait_cfg(dev);					\
-	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
-					pos, sizeof(type), val);	\
-	raw_spin_unlock_irq(&pci_lock);				\
+	ret = pci_write_config_##size(dev, pos, val);			\
 	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
-- 
2.14.4
