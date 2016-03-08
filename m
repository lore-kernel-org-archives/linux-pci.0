Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:49843 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751040AbcCHWkz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Mar 2016 17:40:55 -0500
From: Michael Auchter <michael.auchter@ni.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Auchter <michael.auchter@ni.com>
Subject: [PATCH] pci: add pci_clear_master() stub for !CONFIG_PCI
Date: Tue, 8 Mar 2016 16:34:41 -0600
Message-Id: <1457476481-13654-1-git-send-email-michael.auchter@ni.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a stub for pci_clear_master() for when CONFIG_PCI is not set,
similar to what's done for pci_set_master().

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2771625..5f684d0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1425,6 +1425,7 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
 #define pci_dev_put(dev)	do { } while (0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }
+static inline void pci_clear_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
-- 
2.1.4

