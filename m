Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbeIHJAx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Sep 2018 05:00:53 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/4] PCI: Expose reset_type to users of pci_reset_function_locked()
Date: Sat,  8 Sep 2018 04:16:25 +0000
Message-Id: <20180908041632.22252-2-okaya@kernel.org>
In-Reply-To: <20180908041632.22252-1-okaya@kernel.org>
References: <20180908041632.22252-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looking to have more control between the users of the API vs. what the API
can do internally. The new reset_type tells the PCI core about the bounds
of the request.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/pci.c   | 4 ++--
 include/linux/pci.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a6295f85a1bd..89c45effb4f4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4828,7 +4828,7 @@ EXPORT_SYMBOL_GPL(pci_reset_function);
  * Returns 0 if the device function was successfully reset or negative if the
  * device doesn't support resetting a single function.
  */
-int pci_reset_function_locked(struct pci_dev *dev)
+int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type)
 {
 	int rc;
 
@@ -4837,7 +4837,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 
 	pci_dev_save_and_disable(dev);
 
-	rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
+	rc = __pci_reset_function_locked(dev, reset_type);
 
 	pci_dev_restore(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 43d00e9e54f7..fa852ebdf197 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1124,7 +1124,7 @@ bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_reset_function(struct pci_dev *dev, u32 reset_type);
-int pci_reset_function_locked(struct pci_dev *dev);
+int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
-- 
2.18.0
