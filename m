Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24171 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbbG0Xld (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2015 19:41:33 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 33/51] resources: Make allocate_resource return just fit resource
Date: Mon, 27 Jul 2015 16:29:51 -0700
Message-Id: <1438039809-24957-34-git-send-email-yinghai@kernel.org>
In-Reply-To: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Find all suitable empty slots and pick one just fit, so we could save
the big slot for needed ones later when we have several pcie switches
and some bridges get assigned bios and we need to assign others in kernel.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kernel/resource.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 13 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 67b58a5..697b8ca 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -48,6 +48,7 @@ struct resource_constraint {
 	resource_size_t (*alignf)(void *, const struct resource *,
 			resource_size_t, resource_size_t);
 	void *alignf_data;
+	bool fit;
 };
 
 static DEFINE_RWLOCK(resource_lock);
@@ -554,12 +555,15 @@ static void resource_clip(struct resource *res, resource_size_t min,
  * alignment constraints
  */
 static int __find_resource(struct resource *root, struct resource *old,
-			 struct resource *new,
+			 struct resource *new, struct resource *avail,
 			 resource_size_t  size,
 			 struct resource_constraint *constraint)
 {
 	struct resource *this = root->child;
-	struct resource tmp = *new, avail, alloc;
+	struct resource tmp = *new, availx, alloc;
+
+	if (!avail || avail == new)
+		avail = &availx;
 
 	tmp.start = root->start;
 	/*
@@ -583,15 +587,16 @@ static int __find_resource(struct resource *root, struct resource *old,
 		arch_remove_reservations(&tmp);
 
 		/* Check for overflow after ALIGN() */
-		avail.start = ALIGN(tmp.start, constraint->align);
-		avail.end = tmp.end;
-		avail.flags = new->flags & ~IORESOURCE_UNSET;
-		if (avail.start >= tmp.start) {
-			alloc.flags = avail.flags;
-			alloc.start = constraint->alignf(constraint->alignf_data, &avail,
+		avail->start = ALIGN(tmp.start, constraint->align);
+		avail->end = tmp.end;
+		avail->flags = new->flags & ~IORESOURCE_UNSET;
+		if (avail->start >= tmp.start) {
+			alloc.flags = avail->flags;
+			alloc.start = constraint->alignf(
+					constraint->alignf_data, avail,
 					size, constraint->align);
 			alloc.end = alloc.start + size - 1;
-			if (resource_contains(&avail, &alloc)) {
+			if (resource_contains(avail, &alloc)) {
 				new->start = alloc.start;
 				new->end = alloc.end;
 				return 0;
@@ -608,6 +613,11 @@ next:		if (!this || this->end == root->end)
 	return -EBUSY;
 }
 
+struct good_resource {
+	struct list_head list;
+	struct resource avail;
+	struct resource new;
+};
 /*
  * Find empty slot in the resource tree given range and alignment.
  */
@@ -615,7 +625,49 @@ static int find_resource(struct resource *root, struct resource *new,
 			resource_size_t size,
 			struct resource_constraint  *constraint)
 {
-	return  __find_resource(root, NULL, new, size, constraint);
+	int ret = -1;
+	LIST_HEAD(head);
+	struct good_resource *good, *tmp;
+	resource_size_t avail_size = (resource_size_t)-1ULL;
+
+	if (!constraint->fit)
+		return __find_resource(root, NULL, new, NULL, size,
+					constraint);
+
+	/* find all suitable ones and add to the list */
+	for (;;) {
+		good = kzalloc(sizeof(*good), GFP_KERNEL);
+		if (!good)
+			break;
+
+		good->new.start = new->start;
+		good->new.end = new->end;
+		good->new.flags = new->flags;
+		ret = __find_resource(root, NULL, &good->new, &good->avail,
+					size, constraint);
+		if (ret || __request_resource(root, &good->avail)) {
+			ret = -EBUSY;
+			kfree(good);
+			break;
+		}
+
+		list_add(&good->list, &head);
+	}
+
+	/* pick up the smallest one and delete the list */
+	list_for_each_entry_safe(good, tmp, &head, list) {
+		if (resource_size(&good->avail) < avail_size) {
+			avail_size = resource_size(&good->avail);
+			new->start = good->new.start;
+			new->end = good->new.end;
+			ret = 0;
+		}
+		list_del(&good->list);
+		__release_resource(&good->avail);
+		kfree(good);
+	}
+
+	return ret;
 }
 
 /**
@@ -636,7 +688,8 @@ static int __reallocate_resource(struct resource *root, struct resource *old,
 	struct resource new = *old;
 	struct resource *conflict;
 
-	if ((err = __find_resource(root, old, &new, newsize, constraint)))
+	err = __find_resource(root, old, &new, NULL, newsize, constraint);
+	if (err)
 		goto out;
 
 	if (resource_contains(&new, old)) {
@@ -675,6 +728,7 @@ out:
  * @align: alignment requested, in bytes
  * @alignf: alignment function, optional, called if not NULL
  * @alignf_data: arbitrary data to pass to the @alignf function
+ * @fit: only allocate fit range.
  *
  * Caller need to hold resource_lock if needed.
  */
@@ -685,7 +739,7 @@ static int __allocate_resource(struct resource *root, struct resource *new,
 						  const struct resource *,
 						  resource_size_t,
 						  resource_size_t),
-				void *alignf_data)
+				void *alignf_data, bool fit)
 {
 	int err;
 	struct resource_constraint constraint;
@@ -698,6 +752,7 @@ static int __allocate_resource(struct resource *root, struct resource *new,
 	constraint.align = align;
 	constraint.alignf = alignf;
 	constraint.alignf_data = alignf_data;
+	constraint.fit = fit;
 
 	if (new->parent) {
 		/* resource is already allocated, try reallocating with
@@ -738,7 +793,7 @@ int allocate_resource(struct resource *root, struct resource *new,
 
 	write_lock(&resource_lock);
 	ret = __allocate_resource(root, new, size, min, max, align,
-				   alignf, alignf_data);
+				   alignf, alignf_data, true);
 	write_unlock(&resource_lock);
 
 	return ret;
-- 
1.8.4.5

