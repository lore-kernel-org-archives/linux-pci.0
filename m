Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:45797 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933005AbcBYCaL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 21:30:11 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v10 16/59] PCI: Don't release fixed resource for realloc
Date: Wed, 24 Feb 2016 18:12:07 -0800
Message-Id: <1456366370-28995-17-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We should not release bridge resource if there is fixed resources
under it, otherwise the children firmware would stop working.

Reported-by: Paul Johnson <pjay@nwtrail.com>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=92351
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/setup-bus.c |  6 ++++--
 include/linux/ioport.h  |  2 +-
 kernel/resource.c       | 28 ++++++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7a758e8..05769c4 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1541,14 +1541,16 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 
 	r = &b_res[idx];
 
-	if (!r->parent)
+	if (!r->parent || r->flags & IORESOURCE_PCI_FIXED)
 		return;
 
 	/*
 	 * if there are children under that, we should release them
 	 *  all
 	 */
-	release_child_resources(r);
+	if (!release_child_resources(r))
+		return;
+
 	if (!release_resource(r)) {
 		type = old_flags = r->flags & type_mask;
 		dev_printk(KERN_DEBUG, &dev->dev, "resource %d %pR released\n",
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 24bea08..26b0a08 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -142,7 +142,7 @@ extern struct resource iomem_resource;
 extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
 extern int request_resource(struct resource *root, struct resource *new);
 extern int release_resource(struct resource *new);
-void release_child_resources(struct resource *new);
+bool release_child_resources(struct resource *new);
 extern void reserve_region_with_split(struct resource *root,
 			     resource_size_t start, resource_size_t end,
 			     const char *name);
diff --git a/kernel/resource.c b/kernel/resource.c
index 3669d1b..3d7cf0b 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -275,11 +275,35 @@ static void __release_child_resources(struct resource *r)
 	}
 }
 
-void release_child_resources(struct resource *r)
+static bool __has_fixed_child_resources(struct resource *r)
 {
+	struct resource *p;
+
+	p = r->child;
+	while (p) {
+		if (p->flags & IORESOURCE_PCI_FIXED)
+			return true;
+
+		if (__has_fixed_child_resources(p))
+			return true;
+
+		p = p->sibling;
+	}
+
+	return false;
+}
+
+bool release_child_resources(struct resource *r)
+{
+	bool fixed;
+
 	write_lock(&resource_lock);
-	__release_child_resources(r);
+	fixed = __has_fixed_child_resources(r);
+	if (!fixed)
+		__release_child_resources(r);
 	write_unlock(&resource_lock);
+
+	return !fixed;
 }
 
 /**
-- 
1.8.4.5

