Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 10/52] PCI: Treat ROM resource as optional during realloc
Date: Thu, 20 Aug 2015 23:20:25 -0700
Message-Id: <1440138067-4314-11-git-send-email-yinghai@kernel.org>
In-Reply-To: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Treat ROM resources as optional resources.
will try to allocate them together with required ones, if can
not assign them, could go with other required resources only, and just skip
ROM resources.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1fd0b8d..eca319e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -371,18 +371,10 @@ static void assign_requested_resources_sorted(struct list_head *head,
 		idx = res - &dev_res->dev->resource[0];
 		if (resource_size(res) &&
 		    pci_assign_resource(dev_res->dev, idx)) {
-			if (fail_head) {
-				/*
-				 * if the failed res is for ROM BAR, and it will
-				 * be enabled later, don't add it to the list
-				 */
-				if (!((idx == PCI_ROM_RESOURCE) &&
-				      (!(res->flags & IORESOURCE_ROM_ENABLE))))
-					add_to_list(fail_head,
-						    dev_res->dev, res,
-						    0 /* don't care */,
-						    0 /* don't care */);
-			}
+			if (fail_head)
+				add_to_list(fail_head, dev_res->dev, res,
+					    0 /* don't care */,
+					    0 /* don't care */);
 			reset_resource(res);
 		}
 	}
@@ -1142,6 +1134,19 @@ out:
 	return good_align;
 }
 
+static inline bool is_optional(int i)
+{
+
+	if (i == PCI_ROM_RESOURCE)
+		return true;
+
+#ifdef CONFIG_PCI_IOV
+	if (i >= PCI_IOV_RESOURCES && i <= PCI_IOV_RESOURCE_END)
+		return true;
+#endif
+
+	return false;
+}
 /**
  * pbus_size_mem() - size the memory window of a given bus
  *
@@ -1198,10 +1203,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 			r_size = resource_size(r);
 			align = pci_resource_alignment(dev, r);
-#ifdef CONFIG_PCI_IOV
-			/* put SRIOV requested res to the optional list */
-			if (realloc_head && i >= PCI_IOV_RESOURCES &&
-					i <= PCI_IOV_RESOURCE_END) {
+			/* put SRIOV/ROM res to realloc list */
+			if (realloc_head && is_optional(i)) {
 				add_to_align_test_list(&align_test_add_list,
 							align, r_size);
 				r->end = r->start - 1;
@@ -1211,7 +1214,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 					max_add_align = align;
 				continue;
 			}
-#endif
+
 			if (align > (1ULL<<37)) { /*128 Gb*/
 				dev_warn(&dev->dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
 					i, r, (unsigned long long) align);
-- 
1.8.4.5

