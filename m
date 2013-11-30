Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 09/12] PCI: Kill PCIBIOS_MAX_MEM_32
Date: Sat, 30 Nov 2013 14:40:35 -0800
Message-Id: <1385851238-21085-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1385851238-21085-1-git-send-email-yinghai@kernel.org>
References: <1385851238-21085-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No user anymore.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/include/asm/pci.h | 1 -
 include/linux/pci.h        | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 947b5c4..122c299 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -125,7 +125,6 @@ int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 
 /* generic pci stuff */
 #include <asm-generic/pci.h>
-#define PCIBIOS_MAX_MEM_32 0xffffffff
 
 #ifdef CONFIG_NUMA
 /* Returns the node based on pci bus */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a51b343..46bf01c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1491,10 +1491,6 @@ static inline struct pci_dev *pci_dev_get(struct pci_dev *dev)
 
 #include <asm/pci.h>
 
-#ifndef PCIBIOS_MAX_MEM_32
-#define PCIBIOS_MAX_MEM_32 (-1)
-#endif
-
 /* these helpers provide future and backwards compatibility
  * for accessing popular PCI BAR info */
 #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
-- 
1.8.1.4

