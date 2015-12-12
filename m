Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36395 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbLLNdK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 12 Dec 2015 08:33:10 -0500
From: Bogicevic Sasa <brutallesale@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bogicevic Sasa <brutallesale@gmail.com>
Subject: [PATCH] drivers:pci Fix small spacing warnings
Date: Sat, 12 Dec 2015 05:33:05 -0800
Message-Id: <1449927185-109665-1-git-send-email-brutallesale@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch fixes a few spacing warnings like "missing space after..."
"space prohibited at the start of the line" etc. I recorded objects with
objdiff and diff didn't give no output between my working branch and
staging-testing so all is good

Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
---
 drivers/pci/access.c    | 12 ++++++------
 drivers/pci/pci.c       |  2 +-
 drivers/pci/setup-bus.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 59ac36f..69b4572 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -25,9 +25,9 @@ DEFINE_RAW_SPINLOCK(pci_lock);
 #define PCI_word_BAD (pos & 1)
 #define PCI_dword_BAD (pos & 3)
 
-#define PCI_OP_READ(size,type,len) \
+#define PCI_OP_READ(size, type, len) \
 int pci_bus_read_config_##size \
-	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
+	(struct pci_bus *bus, unsigned int devfn, int pos, type * value)	\
 {									\
 	int res;							\
 	unsigned long flags;						\
@@ -40,7 +40,7 @@ int pci_bus_read_config_##size \
 	return res;							\
 }
 
-#define PCI_OP_WRITE(size,type,len) \
+#define PCI_OP_WRITE(size, type, len) \
 int pci_bus_write_config_##size \
 	(struct pci_bus *bus, unsigned int devfn, int pos, type value)	\
 {									\
@@ -231,9 +231,9 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
 }
 
 /* Returns 0 on success, negative values indicate error. */
-#define PCI_USER_READ_CONFIG(size,type)					\
+#define PCI_USER_READ_CONFIG(size, type)					\
 int pci_user_read_config_##size						\
-	(struct pci_dev *dev, int pos, type *val)			\
+	(struct pci_dev *dev, int pos, type * val)			\
 {									\
 	int ret = PCIBIOS_SUCCESSFUL;					\
 	u32 data = -1;							\
@@ -251,7 +251,7 @@ int pci_user_read_config_##size						\
 EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
 
 /* Returns 0 on success, negative values indicate error. */
-#define PCI_USER_WRITE_CONFIG(size,type)				\
+#define PCI_USER_WRITE_CONFIG(size, type)				\
 int pci_user_write_config_##size					\
 	(struct pci_dev *dev, int pos, type val)			\
 {									\
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 314db8c..db2e227 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1534,7 +1534,7 @@ void __weak pcibios_release_device(struct pci_dev *dev) {}
  * is the default implementation. Architecture implementations can
  * override this.
  */
-void __weak pcibios_disable_device (struct pci_dev *dev) {}
+void __weak pcibios_disable_device(struct pci_dev *dev) {}
 
 /**
  * pcibios_penalize_isa_irq - penalize an ISA IRQ
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1723ac1..7796d0a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -442,7 +442,7 @@ static void __assign_resources_sorted(struct list_head *head,
 					break;
 				}
 			}
-               }
+		}
 
 	}
 
-- 
2.5.0

