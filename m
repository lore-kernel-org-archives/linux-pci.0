Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53140 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751365AbdCBXXw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Mar 2017 18:23:52 -0500
From: Andi Kleen <andi@firstfloor.org>
To: bhelgaas@google.com
Cc: x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/4] pci: Add generic pci_bus_force_mmconfig interface
Date: Thu,  2 Mar 2017 15:21:02 -0800
Message-Id: <20170302232104.10136-2-andi@firstfloor.org>
In-Reply-To: <20170302232104.10136-1-andi@firstfloor.org>
References: <20170302232104.10136-1-andi@firstfloor.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Andi Kleen <ak@linux.intel.com>

x86 traditionally used mmconfig only for extended config space accesses
with offsets larger than 256. For lower offsets it uses the classic
Type 1 IO port access. This is quite slow and also requires taking
a global spin lock to protect the Type 1 IO port mailbox.

IIRC (I added it originally) it was merely to be conservative;
I don't remember any actual cases where mmconfig did not work
after passing the other sanity checks. But most devices
don't use extended config space, so most devices were never
tested with MMCONFIG. Starting to use MMCONFIG everywhere
unconditionally seems somewhat risky as we never tested this

Also for most drivers it doesn't really matter because they only
use config accesses during driver initialization, which is
not performance critical.

But some drivers can do a lot of config bus accesses < 256.
I ran into this problem with the Intel uncore PMU drivers
when sampling uncore counters in many PMUs at a high frequency
on a 4S system. This showed significant spin lock contention
and also large overhead in accessing the IO port.

For drivers like this is useful to be able to force MMCONFIG
access. The interface is intended for devices integrated on a SOC,
so there is no concern that some strange PCI bridges may
incorrectly handle mmconfig.

This patch adds a new function pci_bus_force_mmconfig() where
a driver can force MMCONFIG for all accesses on the bus.

This is a stub implementation, but the next patch will
fill it in for x86.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/pci/pci.c   | 15 +++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02ffdb9..af68f1d9eed7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5236,6 +5236,21 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 #endif
 
 /**
+ * pci_bus_force_mmconfig - enable mmconfig for all config accesses on bus.
+ *
+ * Allow mmconfig for all accesses to devices. This is mainly a performance
+ * optimization, and should be only used if the driver "knows" all the bridges
+ * involved (e.g. SOC on chip devices)
+ *
+ * Default implementation. Architectures can override this.
+ */
+__weak int pci_bus_force_mmconfig(struct pci_bus *bus)
+{
+	return 0;
+}
+EXPORT_SYMBOL(pci_bus_force_mmconfig);
+
+/**
  * pci_ext_cfg_avail - can we access extended PCI config space?
  *
  * Returns 1 if we can access PCI extended config space (offsets
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9b234cbc7ae1..61b4437dc8e5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -891,6 +891,8 @@ void pci_sort_breadthfirst(void);
 
 /* Generic PCI functions exported to card drivers */
 
+int pci_bus_force_mmconfig(struct pci_bus *bus);
+
 enum pci_lost_interrupt_reason {
 	PCI_LOST_IRQ_NO_INFORMATION = 0,
 	PCI_LOST_IRQ_DISABLE_MSI,
-- 
2.9.3
