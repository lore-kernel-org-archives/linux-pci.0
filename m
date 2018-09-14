Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mta-01.yadro.com ([89.207.88.251]:60246 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbeINVgo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Sep 2018 17:36:44 -0400
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC 3/4] PCI: Invalidate the released BAR resources
Date: Fri, 14 Sep 2018 19:14:03 +0300
Message-ID: <20180914161404.4685-4-s.miroshnichenko@yadro.com>
In-Reply-To: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Otherwise after release_child_resources() there can be resources
with the IORESOURCE_STARTALIGN flag remaining, but with start
dropped to zero, that makes them not valid for re-assigning.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index fd5675bb501f..ec88461462b8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1521,7 +1521,7 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 static void pci_bridge_release_resources(struct pci_bus *bus,
 					  unsigned long type)
 {
-	struct pci_dev *dev = bus->self;
+	struct pci_dev *dev = bus->self, *child_dev;
 	struct resource *r;
 	unsigned old_flags = 0;
 	struct resource *b_res;
@@ -1564,6 +1564,25 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	 *  all
 	 */
 	release_child_resources(r);
+	list_for_each_entry(child_dev, &bus->devices, bus_list) {
+		int i;
+
+		if (child_dev->subordinate)
+			continue;
+
+		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+			struct resource *res = &child_dev->resource[i];
+			resource_size_t size = resource_size(res);
+
+			if (!res->flags)
+				continue;
+
+			res->end = size - 1;
+			res->start = 0;
+			res->flags &= ~IORESOURCE_STARTALIGN;
+			res->flags |= IORESOURCE_SIZEALIGN;
+		}
+	}
 	if (!release_resource(r)) {
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
 		pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
-- 
2.17.1
