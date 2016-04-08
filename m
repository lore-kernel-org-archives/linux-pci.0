Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v11 33/60] PCI: Treat ROM resource as optional during realloc
Date: Thu,  7 Apr 2016 17:15:46 -0700
Message-Id: <1460074573-7481-34-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current on realloc path, we just ignore ROM resource if we can not assign
them in first try.

Treat ROM resources as optional resources,so try to allocate them together
with required ones, if can not assign them, could go with other required
resources only, and try to allocate them second time in expand path.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9cd0411..f9e6a00 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -376,18 +376,10 @@ static void assign_requested_resources_sorted(struct list_head *head,
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
@@ -1185,6 +1177,19 @@ out:
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
@@ -1243,10 +1248,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
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
@@ -1256,7 +1259,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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
