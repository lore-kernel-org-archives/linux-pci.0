Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 12/37] PCI: Make pci_rescan_bus_bridge_resize() use pci_scan_bridge instead
Date: Fri,  9 Mar 2012 23:00:12 -0800
Message-Id: <1331362837-10740-13-git-send-email-yinghai@kernel.org>
In-Reply-To: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So after remove all children and then using setpci change bus register and rescan
bridge could use new set bus number.

Otherwise need to rescan parent bus, it would have too much overhead.

also need to use pci_bus_add_single_device to make sure new change bus have directory
 /sys/../.../pci_bus.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2f5f728..8512e0d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2043,14 +2043,16 @@ EXPORT_SYMBOL(pci_scan_bus);
  */
 unsigned int __ref pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 {
-	unsigned int max;
-	struct pci_bus *bus = bridge->subordinate;
+	unsigned int max = 0;
+	int pass;
+	struct pci_bus *bus = bridge->bus;
 
-	max = pci_scan_child_bus(bus);
+	for (pass = 0; pass < 2; pass++)
+		max = pci_scan_bridge(bus, bridge, max, pass);
 
 	pci_assign_unassigned_bridge_resources(bridge);
 
-	pci_bus_add_devices(bus);
+	pci_bus_add_single_device(bridge);
 
 	return max;
 }
-- 
1.7.7

