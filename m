Return-Path: <linux-arch-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 04/18] PCI: Add busn_res tracking in core
Date: Mon, 27 Feb 2012 18:09:55 -0800
Message-Id: <1330395009-29260-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330395009-29260-1-git-send-email-yinghai@kernel.org>
References: <1330395009-29260-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

update pci_scan_root_bus, and pci_scan_bus to insert root bus busn into
iobusn_resource tree.

-v2: not add pci_scan_root_bus_max...

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c  |   11 +++++++++--
 drivers/pci/remove.c |    1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3c0eecb..e09f9b2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1734,7 +1734,9 @@ struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, int bus,
 	if (!b)
 		return NULL;
 
+	pci_bus_insert_busn_res(b, bus, 255);
 	b->subordinate = pci_scan_child_bus(b);
+	pci_bus_update_busn_res_end(b, b->subordinate);
 	pci_bus_add_devices(b);
 	return b;
 }
@@ -1750,9 +1752,11 @@ struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
 	pci_add_resource(&resources, &ioport_resource);
 	pci_add_resource(&resources, &iomem_resource);
 	b = pci_create_root_bus(parent, bus, ops, sysdata, &resources);
-	if (b)
+	if (b) {
+		pci_bus_insert_busn_res(b, bus, 255);
 		b->subordinate = pci_scan_child_bus(b);
-	else
+		pci_bus_update_busn_res_end(b, b->subordinate);
+	} else
 		pci_free_resource_list(&resources);
 	return b;
 }
@@ -1768,7 +1772,10 @@ struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops,
 	pci_add_resource(&resources, &iomem_resource);
 	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources);
 	if (b) {
+		pci_bus_insert_busn_res(b, bus, 255);
 		b->subordinate = pci_scan_child_bus(b);
+		pci_bus_update_busn_res_end(b, b->subordinate);
+
 		pci_bus_add_devices(b);
 	} else {
 		pci_free_resource_list(&resources);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index fd77e2b..04a4861 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -68,6 +68,7 @@ void pci_remove_bus(struct pci_bus *pci_bus)
 
 	down_write(&pci_bus_sem);
 	list_del(&pci_bus->node);
+	pci_bus_release_busn_res(pci_bus);
 	up_write(&pci_bus_sem);
 	if (!pci_bus->is_added)
 		return;
-- 
1.7.7

