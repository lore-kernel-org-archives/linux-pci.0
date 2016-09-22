Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtpbgsg2.qq.com ([54.254.200.128]:40788 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751635AbcIVBGR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Sep 2016 21:06:17 -0400
From: Wang Sheng-Hui <shhuiw@foxmail.com>
To: yu.zhao@intel.com, jbarnes@virtuousgeek.org,
        alex.williamson@redhat.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: move cfg space size (256/4096) macros to pci_regs.h
Date: Thu, 22 Sep 2016 09:05:46 +0800
Message-Id: <1474506346-20873-1-git-send-email-shhuiw@foxmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a cleanup that moves PCI configuration space size
macros (PCI_CFG_SPACE_SIZE and PCI_CFG_SPACE_EXP_SIZE) from
drivers/pci/pci.h to include/uapi/linux/pci_regs.h

So that the macros can be used by more drivers and eliminate
potential duplicate definition.

Signed-off-by: Wang Sheng-Hui <shhuiw@foxmail.com>
---
 drivers/pci/pci.h                  | 3 ---
 drivers/vfio/pci/vfio_pci_config.c | 2 --
 include/uapi/linux/pci_regs.h      | 7 +++++++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9730c47..12d651a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1,9 +1,6 @@
 #ifndef DRIVERS_PCI_H
 #define DRIVERS_PCI_H
 
-#define PCI_CFG_SPACE_SIZE	256
-#define PCI_CFG_SPACE_EXP_SIZE	4096
-
 #define PCI_FIND_CAP_TTL	48
 
 extern const unsigned char pcie_link_speed[];
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 688691d..8dc8a5a 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -31,8 +31,6 @@
 
 #include "vfio_pci_private.h"
 
-#define PCI_CFG_SPACE_SIZE	256
-
 /* Fake capability ID for standard config space */
 #define PCI_CAP_ID_BASIC	0
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4040951..a07c53c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -23,6 +23,13 @@
 #define LINUX_PCI_REGS_H
 
 /*
+ * Under PCI, each device has 256 bytes of configuration address space.
+ * Under PCIe, each device has 4096 bytes of configuration address space.
+ */
+#define PCI_CFG_SPACE_SIZE	256
+#define PCI_CFG_SPACE_EXP_SIZE	4096
+
+/*
  * Under PCI, each device has 256 bytes of configuration address space,
  * of which the first 64 bytes are standardized as follows:
  */
-- 
2.7.4



