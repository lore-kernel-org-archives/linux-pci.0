Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:38381 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932721AbcBYCNy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 21:13:54 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v10 56/59] PCI, x86: Add pci=assign_pref_bars to reallocate pref BARs
Date: Wed, 24 Feb 2016 18:12:47 -0800
Message-Id: <1456366370-28995-57-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now some BIOS tend to allocate pref MMIO under non-pref MMIO, or allocate
64bit pref MMIO under 4G.

Add pci=assign_pref_bars to clear and allocate resource to pref BARS.
So could reallocate pref mmio64 above 4G and pref under bridges pref BARs.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/include/asm/pci_x86.h |  1 +
 arch/x86/pci/common.c          |  3 +++
 arch/x86/pci/i386.c            | 56 ++++++++++++++++++++++++++----------------
 3 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 3f9ba17..717e1be 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -34,6 +34,7 @@ do {						\
 #define PCI_NOASSIGN_ROMS	0x80000
 #define PCI_ROOT_NO_CRS		0x100000
 #define PCI_NOASSIGN_BARS	0x200000
+#define PCI_ASSIGN_PREF_BARS	0x400000
 
 extern unsigned int pci_probe;
 extern unsigned long pirq_table_addr;
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 77a450e..478db0b 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -606,6 +606,9 @@ char *__init pcibios_setup(char *str)
 	} else if (!strcmp(str, "assign-busses")) {
 		pci_probe |= PCI_ASSIGN_ALL_BUSSES;
 		return NULL;
+	} else if (!strcmp(str, "assign_pref_bars")) {
+		pci_probe |= PCI_ASSIGN_PREF_BARS;
+		return NULL;
 	} else if (!strcmp(str, "use_crs")) {
 		pci_probe |= PCI_USE__CRS;
 		return NULL;
diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 6121ef3..2df7723 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -227,16 +227,25 @@ static void pcibios_allocate_bridge_resources(struct pci_dev *dev)
 			continue;
 		if (r->parent)	/* Already allocated */
 			continue;
-		if (!r->start || pci_claim_bridge_resource(dev, idx) < 0) {
-			/*
-			 * Something is wrong with the region.
-			 * Invalidate the resource to prevent
-			 * child resource allocations in this
-			 * range.
-			 */
-			r->start = r->end = 0;
-			r->flags = 0;
-		}
+
+		if ((r->flags & IORESOURCE_PREFETCH) &&
+		    (pci_probe & PCI_ASSIGN_PREF_BARS))
+			goto clear;
+
+		if (!r->start)
+			goto clear;
+
+		if (pci_claim_bridge_resource(dev, idx) == 0)
+			continue;
+
+clear:
+		/*
+		 * Something is wrong with the region.
+		 * Invalidate the resource to prevent
+		 * child resource allocations in this range.
+		 */
+		r->start = r->end = 0;
+		r->flags = 0;
 	}
 }
 
@@ -282,21 +291,26 @@ static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
 			else
 				disabled = !(command & PCI_COMMAND_MEMORY);
 			if (pass == disabled) {
+				if ((r->flags & IORESOURCE_PREFETCH) &&
+				    (pci_probe & PCI_ASSIGN_PREF_BARS))
+					goto clear;
+
 				dev_dbg(&dev->dev,
 					"BAR %d: reserving %pr (d=%d, p=%d)\n",
 					idx, r, disabled, pass);
-				if (pci_claim_resource(dev, idx) < 0) {
-					if (r->flags & IORESOURCE_PCI_FIXED) {
-						dev_info(&dev->dev, "BAR %d %pR is immovable\n",
-							 idx, r);
-					} else {
-						/* We'll assign a new address later */
-						pcibios_save_fw_addr(dev,
-								idx, r->start);
-						r->end -= r->start;
-						r->start = 0;
-					}
+				if (pci_claim_resource(dev, idx) == 0)
+					continue;
+				if (r->flags & IORESOURCE_PCI_FIXED) {
+					dev_info(&dev->dev, "BAR %d %pR is immovable\n",
+						 idx, r);
+					continue;
 				}
+
+clear:
+				/* We'll assign a new address later */
+				pcibios_save_fw_addr(dev, idx, r->start);
+				r->end -= r->start;
+				r->start = 0;
 			}
 		}
 	if (!pass) {
-- 
1.8.4.5

