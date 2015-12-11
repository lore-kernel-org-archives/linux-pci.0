Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49585 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbbLKFSW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2015 00:18:22 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v9 53/60] resources: Split out __allocate_resource()
Date: Thu, 10 Dec 2015 21:06:49 -0800
Message-Id: <1449810416-2950-54-git-send-email-yinghai@kernel.org>
In-Reply-To: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
References: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This one is separated from next patch for best fit allocation.

Split out __allocate_resource(), and it will not hold lock, so we could use it
in other functions that hold the resource lock already.

-v2: according to Linus, using "bool lock" as parameter
     aka "conditionally take lock" is *wrong*.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 kernel/resource.c | 70 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 6927298..62321b0 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -654,7 +654,7 @@ static int find_resource(struct resource *root, struct resource *new,
 }
 
 /**
- * reallocate_resource - allocate a slot in the resource tree given range & alignment.
+ * __reallocate_resource - allocate a slot in the resource tree given range & alignment.
  *	The resource will be relocated if the new size cannot be reallocated in the
  *	current location.
  *
@@ -663,7 +663,7 @@ static int find_resource(struct resource *root, struct resource *new,
  * @newsize: new size of the resource descriptor
  * @constraint: the size and alignment constraints to be met.
  */
-static int reallocate_resource(struct resource *root, struct resource *old,
+static int __reallocate_resource(struct resource *root, struct resource *old,
 			resource_size_t newsize,
 			struct resource_constraint  *constraint)
 {
@@ -671,8 +671,6 @@ static int reallocate_resource(struct resource *root, struct resource *old,
 	struct resource new = *old;
 	struct resource *conflict;
 
-	write_lock(&resource_lock);
-
 	if ((err = __find_resource(root, old, &new, newsize, constraint)))
 		goto out;
 
@@ -697,14 +695,13 @@ static int reallocate_resource(struct resource *root, struct resource *old,
 		BUG_ON(conflict);
 	}
 out:
-	write_unlock(&resource_lock);
 	return err;
 }
 
-
 /**
- * allocate_resource - allocate empty slot in the resource tree given range & alignment.
- * 	The resource will be reallocated with a new size if it was already allocated
+ * __allocate_resource - allocate empty slot in the resource tree given range & alignment.
+ *	The resource will be reallocated with a new size if it was already
+ *	allocated
  * @root: root resource descriptor
  * @new: resource descriptor desired by caller
  * @size: requested resource region size
@@ -713,15 +710,17 @@ out:
  * @align: alignment requested, in bytes
  * @alignf: alignment function, optional, called if not NULL
  * @alignf_data: arbitrary data to pass to the @alignf function
+ *
+ * Caller need to hold resource_lock if needed.
  */
-int allocate_resource(struct resource *root, struct resource *new,
-		      resource_size_t size, resource_size_t min,
-		      resource_size_t max, resource_size_t align,
-		      resource_size_t (*alignf)(void *,
-						const struct resource *,
-						resource_size_t,
-						resource_size_t),
-		      void *alignf_data)
+static int __allocate_resource(struct resource *root, struct resource *new,
+				resource_size_t size, resource_size_t min,
+				resource_size_t max, resource_size_t align,
+				resource_size_t (*alignf)(void *,
+						  const struct resource *,
+						  resource_size_t,
+						  resource_size_t),
+				void *alignf_data)
 {
 	int err;
 	struct resource_constraint constraint;
@@ -735,20 +734,51 @@ int allocate_resource(struct resource *root, struct resource *new,
 	constraint.alignf = alignf;
 	constraint.alignf_data = alignf_data;
 
-	if ( new->parent ) {
+	if (new->parent) {
 		/* resource is already allocated, try reallocating with
 		   the new constraints */
-		return reallocate_resource(root, new, size, &constraint);
+		return __reallocate_resource(root, new, size, &constraint);
 	}
 
-	write_lock(&resource_lock);
 	err = find_resource(root, new, size, &constraint);
 	if (err >= 0 && __request_resource(root, new))
 		err = -EBUSY;
-	write_unlock(&resource_lock);
+
 	return err;
 }
 
+/**
+ * allocate_resource - allocate empty slot in the resource tree given range & alignment.
+ *	The resource will be reallocated with a new size if it was already
+ *	allocated
+ * @root: root resource descriptor
+ * @new: resource descriptor desired by caller
+ * @size: requested resource region size
+ * @min: minimum boundary to allocate
+ * @max: maximum boundary to allocate
+ * @align: alignment requested, in bytes
+ * @alignf: alignment function, optional, called if not NULL
+ * @alignf_data: arbitrary data to pass to the @alignf function
+ */
+int allocate_resource(struct resource *root, struct resource *new,
+		      resource_size_t size, resource_size_t min,
+		      resource_size_t max, resource_size_t align,
+		      resource_size_t (*alignf)(void *,
+						const struct resource *,
+						resource_size_t,
+						resource_size_t),
+		      void *alignf_data)
+{
+	int ret;
+
+	write_lock(&resource_lock);
+	ret = __allocate_resource(root, new, size, min, max, align,
+				   alignf, alignf_data);
+	write_unlock(&resource_lock);
+
+	return ret;
+}
+
 EXPORT_SYMBOL(allocate_resource);
 
 /**
-- 
1.8.4.5

