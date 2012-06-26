Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v12 13/15] PCI, pciehp: Remove not needed bus number range checking
Date: Tue, 26 Jun 2012 11:54:07 -0700
Message-Id: <1340736849-14875-14-git-send-email-yinghai@kernel.org>
In-Reply-To: <1340736849-14875-1-git-send-email-yinghai@kernel.org>
References: <1340736849-14875-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Found hotplug adding one EM with bridge fail, bios only leave one bus range
 for slot.

[ 1169.621444] pciehp: No bus number available for hot-added bridge 0000:55:00.0
[ 1169.633277] pcieport 0000:40:03.0: PCI bridge to [bus 55-55]

With busn_res tracking and allocating, we don't need that checking anymore.

Parent bridges' bus number will be extended safely.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug-pci.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/hotplug-pci.c b/drivers/pci/hotplug-pci.c
index 6258dc2..2221a27 100644
--- a/drivers/pci/hotplug-pci.c
+++ b/drivers/pci/hotplug-pci.c
@@ -7,18 +7,8 @@
 int __ref pci_hp_add_bridge(struct pci_dev *dev)
 {
 	struct pci_bus *parent = dev->bus;
-	int pass, busnr, start = parent->busn_res.start;
-	int end = parent->busn_res.end;
+	int pass, busnr = parent->busn_res.start;
 
-	for (busnr = start; busnr <= end; busnr++) {
-		if (!pci_find_bus(pci_domain_nr(parent), busnr))
-			break;
-	}
-	if (busnr-- > end) {
-		printk(KERN_ERR "No bus number available for hot-added bridge %s\n",
-				pci_name(dev));
-		return -1;
-	}
 	for (pass = 0; pass < 2; pass++)
 		busnr = pci_scan_bridge(parent, dev, busnr, pass);
 	if (!dev->subordinate)
-- 
1.7.7

