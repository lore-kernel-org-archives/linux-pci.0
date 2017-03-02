Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32163 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751227AbdCBX7P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Mar 2017 18:59:15 -0500
From: Andi Kleen <andi@firstfloor.org>
To: bhelgaas@google.com
Cc: x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/4] x86, pci: Add interface to force mmconfig
Date: Thu,  2 Mar 2017 15:21:03 -0800
Message-Id: <20170302232104.10136-3-andi@firstfloor.org>
In-Reply-To: <20170302232104.10136-1-andi@firstfloor.org>
References: <20170302232104.10136-1-andi@firstfloor.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Andi Kleen <ak@linux.intel.com>

This fills in the pci_bus_force_mmconfig interface that was
added earlier for x86 to allow drivers to optimize config
space accesses. The implementation is straight forward
and uses the existing mmconfig access functions, just forcing
mmconfig access.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/pci/mmconfig-shared.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index dd30b7e08bc2..bb56533290aa 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -816,3 +816,31 @@ int pci_mmconfig_delete(u16 seg, u8 start, u8 end)
 
 	return -ENOENT;
 }
+
+static int pci_mmconfig_read(struct pci_bus *bus, unsigned int devfn,
+			     int where, int size, u32 *value)
+{
+	return raw_pci_ext_ops->read(pci_domain_nr(bus), bus->number,
+				     devfn, where, size, value);
+}
+
+static int pci_mmconfig_write(struct pci_bus *bus, unsigned int devfn,
+			      int where, int size, u32 value)
+{
+	return raw_pci_ext_ops->write(pci_domain_nr(bus), bus->number,
+				      devfn, where, size, value);
+}
+
+struct pci_ops pci_mmconfig_ops = {
+	.read = pci_mmconfig_read,
+	.write = pci_mmconfig_write,
+};
+
+/* Force all config accesses to go through mmconfig. */
+int pci_bus_force_mmconfig(struct pci_bus *bus)
+{
+	if (!raw_pci_ext_ops)
+		return -1;
+	bus->ops = &pci_mmconfig_ops;
+	return 0;
+}
-- 
2.9.3
