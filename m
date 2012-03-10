Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 32/37] x86, PCI: add __pcibios_scan_specific_bus that can skip bus_add
Date: Fri,  9 Mar 2012 23:00:32 -0800
Message-Id: <1331362837-10740-33-git-send-email-yinghai@kernel.org>
In-Reply-To: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So could insert pci_assign_unassigned_bus_resources() before do bus_add.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/pci/legacy.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
index a1df191..aab0e41 100644
--- a/arch/x86/pci/legacy.c
+++ b/arch/x86/pci/legacy.c
@@ -34,25 +34,32 @@ int __init pci_legacy_init(void)
 	return 0;
 }
 
-void __devinit pcibios_scan_specific_bus(int busn)
+static __devinit struct pci_bus *__pcibios_scan_specific_bus(int busn,
+					 bool bus_add)
 {
 	int devfn;
 	long node;
 	u32 l;
 
-	if (pci_find_bus(0, busn))
-		return;
-
 	node = get_mp_bus_to_node(busn);
 	for (devfn = 0; devfn < 256; devfn += 8) {
 		if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) &&
 		    l != 0x0000 && l != 0xffff) {
 			DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
 			printk(KERN_INFO "PCI: Discovered peer bus %02x\n", busn);
-			pci_scan_bus_on_node(busn, &pci_root_ops, node);
-			return;
+			return __pci_scan_bus_on_node(busn, &pci_root_ops, node,
+					 bus_add);
 		}
 	}
+
+	return NULL;
+}
+void __devinit pcibios_scan_specific_bus(int busn)
+{
+	if (pci_find_bus(0, busn))
+		return;
+
+	__pcibios_scan_specific_bus(busn, true);
 }
 EXPORT_SYMBOL_GPL(pcibios_scan_specific_bus);
 
-- 
1.7.7

