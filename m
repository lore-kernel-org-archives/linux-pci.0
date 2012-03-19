Return-Path: <linux-arch-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v11 24/30] PCI: Kill pci_fixup_parent_subordinate_busnr()
Date: Sun, 18 Mar 2012 22:42:55 -0700
Message-Id: <1332135781-13695-25-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we can safely extend parent top and shrink them by probing them.

Don't need that anymore.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |   32 --------------------------------
 1 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5710411..6577105 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -654,22 +654,6 @@ struct pci_bus *__ref pci_add_new_bus(struct pci_bus *parent, struct pci_dev *de
 	return child;
 }
 
-static void pci_fixup_parent_subordinate_busnr(struct pci_bus *child, int max)
-{
-	struct pci_bus *parent = child->parent;
-
-	/* Attempts to fix that up are really dangerous unless
-	   we're going to re-assign all bus numbers. */
-	if (!pcibios_assign_all_busses())
-		return;
-
-	while (parent->parent && parent->subordinate < max) {
-		parent->subordinate = max;
-		pci_write_config_byte(parent->self, PCI_SUBORDINATE_BUS, max);
-		parent = parent->parent;
-	}
-}
-
 static void __devinit pci_bus_update_top(struct pci_bus *parent,
 		 long size, struct resource *parent_res)
 {
@@ -917,23 +901,7 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 		if (!is_cardbus) {
 			child->bridge_ctl = bctl;
-			/*
-			 * Adjust subordinate busnr in parent buses.
-			 * We do this before scanning for children because
-			 * some devices may not be detected if the bios
-			 * was lazy.
-			 */
-			pci_fixup_parent_subordinate_busnr(child, max);
-			/* Now we can scan all subordinate buses... */
 			max = pci_scan_child_bus(child);
-			/*
-			 * now fix it up again since we have found
-			 * the real value of max.
-			 */
-			pci_fixup_parent_subordinate_busnr(child, max);
-
-		} else {
-			pci_fixup_parent_subordinate_busnr(child, max);
 		}
 		/*
 		 * Set the subordinate bus number to its real value.
-- 
1.7.7

