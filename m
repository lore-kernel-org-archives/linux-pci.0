Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:6001 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbdCBXgZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Mar 2017 18:36:25 -0500
From: Andi Kleen <andi@firstfloor.org>
To: bhelgaas@google.com
Cc: x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/4] pci: Allow lockless access path to PCI mmconfig
Date: Thu,  2 Mar 2017 15:21:01 -0800
Message-Id: <20170302232104.10136-1-andi@firstfloor.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Andi Kleen <ak@linux.intel.com>

The Intel uncore driver can do a lot of PCI config accesses to read
performance counters. I had a situation on a 4S system where it
was spending 40+% of CPU time grabbing the pci_cfg_lock due to that.

For 64bit x86 with MMCONFIG there isn't really any reason to take
a lock. The access is directly mapped to an underlying MMIO area,
which can fully operate lockless.

Add a new flag that allows the PCI mid layer to skip the lock
and set it for the 64bit mmconfig code.

There's a small risk that someone relies on this lock for synchronization,
but I think that's unlikely because there isn't really any useful
synchronization at this individual operation level. Any useful
synchronization would likely need to protect at least a
read-modify-write or similar.  So I made it unconditional without opt-in.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/pci/mmconfig_64.c |  1 +
 drivers/pci/access.c       | 14 ++++++++++----
 include/linux/pci.h        |  2 ++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index bea52496aea6..8bf10f41e626 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -121,6 +121,7 @@ int __init pci_mmcfg_arch_init(void)
 		}
 
 	raw_pci_ext_ops = &pci_mmcfg;
+	pci_root_ops.ll_allowed = true;
 
 	return 1;
 }
diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index db239547fefd..22552c6606c1 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -32,11 +32,14 @@ int pci_bus_read_config_##size \
 	int res;							\
 	unsigned long flags;						\
 	u32 data = 0;							\
+	bool ll_allowed = bus->ops->ll_allowed;				\
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
-	raw_spin_lock_irqsave(&pci_lock, flags);			\
+	if (!ll_allowed)						\
+		raw_spin_lock_irqsave(&pci_lock, flags);		\
 	res = bus->ops->read(bus, devfn, pos, len, &data);		\
 	*value = (type)data;						\
-	raw_spin_unlock_irqrestore(&pci_lock, flags);		\
+	if (!ll_allowed)						\
+		raw_spin_unlock_irqrestore(&pci_lock, flags);		\
 	return res;							\
 }
 
@@ -46,10 +49,13 @@ int pci_bus_write_config_##size \
 {									\
 	int res;							\
 	unsigned long flags;						\
+	bool ll_allowed = bus->ops->ll_allowed;				\
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
-	raw_spin_lock_irqsave(&pci_lock, flags);			\
+	if (!ll_allowed)						\
+		raw_spin_lock_irqsave(&pci_lock, flags);		\
 	res = bus->ops->write(bus, devfn, pos, len, value);		\
-	raw_spin_unlock_irqrestore(&pci_lock, flags);		\
+	if (!ll_allowed)						\
+		raw_spin_unlock_irqrestore(&pci_lock, flags);		\
 	return res;							\
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2d1a124216a..9b234cbc7ae1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -612,6 +612,8 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	/* Set to true when pci_lock is not needed for read/write */
+	bool ll_allowed;
 };
 
 /*
-- 
2.9.3
