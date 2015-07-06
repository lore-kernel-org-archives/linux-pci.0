Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17496 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441AbbGFXli (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2015 19:41:38 -0400
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
Subject: [PATCH 19/36] resources: Split out __allocate_resource()
Date: Mon,  6 Jul 2015 16:39:09 -0700
Message-Id: <1436225966-27247-20-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It will not hold lock, so we could use it in other functions that
hold the resource lock already.

-v2: according to Linus, using "bool lock" as parameter
     aka "conditionally take lock" is *wrong*.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 kernel/resource.c | 70 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 90552aa..830cc11 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -619,7 +619,7 @@ static int find_resource(struct resource *root, struct resource *new,
 }
 
 /**
- * reallocate_resource - allocate a slot in the resource tree given range & alignment.
+ * __reallocate_resource - allocate a slot in the resource tree given range & alignment.
  *	The resource will be relocated if the new size cannot be reallocated in the
  *	current location.
  *
@@ -628,7 +628,7 @@ static int find_resource(struct resource *root, struct resource *new,
  * @newsize: new size of the resource descriptor
  * @constraint: the size and alignment constraints to be met.
  */
-static int reallocate_resource(struct resource *root, struct resource *old,
+static int __reallocate_resource(struct resource *root, struct resource *old,
 			resource_size_t newsize,
 			struct resource_constraint  *constraint)
 {
@@ -636,8 +636,6 @@ static int reallocate_resource(struct resource *root, struct resource *old,
 	struct resource new = *old;
 	struct resource *conflict;
 
-	write_lock(&resource_lock);
-
 	if ((err = __find_resource(root, old, &new, newsize, constraint)))
 		goto out;
 
@@ -662,14 +660,13 @@ static int reallocate_resource(struct resource *root, struct resource *old,
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
@@ -678,15 +675,17 @@ out:
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
@@ -700,20 +699,51 @@ int allocate_resource(struct resource *root, struct resource *new,
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

