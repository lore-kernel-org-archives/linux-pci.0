Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v4 10/29] PCI, acpiphp: Use for_each_pci_resource() helper
Date: Fri, 12 Apr 2013 15:44:24 -0700
Message-Id: <1365806683-26717-11-git-send-email-yinghai@kernel.org>
In-Reply-To: <1365806683-26717-1-git-send-email-yinghai@kernel.org>
References: <1365806683-26717-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 270fdba..c35b2b1 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -1085,10 +1085,10 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus)
 	struct pci_dev *dev;
 	int i;
 	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
+	struct resource *res;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		for (i=0; i<PCI_BRIDGE_RESOURCES; i++) {
-			struct resource *res = &dev->resource[i];
+		for_each_pci_resource(dev, res, i, PCI_STD_ROM_IOV_RES) {
 			if ((res->flags & type_mask) && !res->start &&
 					res->end) {
 				/* Could not assign a required resources
-- 
1.8.1.4

