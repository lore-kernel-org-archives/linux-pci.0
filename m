Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49568 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212AbbGFXkt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2015 19:40:49 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 09/36] PCI: Treat ROM resource as optional during realloc
Date: Mon,  6 Jul 2015 16:38:59 -0700
Message-Id: <1436225966-27247-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So will try to allocate them together with must-have ones, if can
not assign them, could go with must-have one only, and just skip
ROM resources.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e976aa2..405eb1d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -367,18 +367,10 @@ static void assign_requested_resources_sorted(struct list_head *head,
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
@@ -1138,6 +1130,19 @@ out:
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
@@ -1189,10 +1194,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
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
@@ -1202,7 +1205,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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

