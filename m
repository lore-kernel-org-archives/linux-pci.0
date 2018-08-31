Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14103 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeIABev (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:51 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 16/16] PCI: Unify device inaccessible
Date: Fri, 31 Aug 2018 15:26:39 -0600
Message-Id: <20180831212639.10196-17-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch brings surprise removals and permanent failures together so
no longer need separate flags.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ed2965ee6779..20cadf91cd9c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -294,21 +294,20 @@ struct pci_sriov {
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
-/* pci_dev priv_flags */
-#define PCI_DEV_DISCONNECTED 0
-#define PCI_DEV_ADDED 1
-
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 {
-	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
+	dev->error_state = pci_channel_io_perm_failure;
 	return 0;
 }
 
 static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 {
-	return test_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
+	return dev->error_state == pci_channel_io_perm_failure;
 }
 
+/* pci_dev priv_flags */
+#define PCI_DEV_ADDED 0
+
 static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
 {
 	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
-- 
2.14.4
