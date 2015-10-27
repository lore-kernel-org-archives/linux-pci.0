Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v8 55/61] resources: Make allocate_resource() return best fit resource
Date: Tue, 27 Oct 2015 13:55:47 -0700
Message-Id: <1445979353-1728-56-git-send-email-yinghai@kernel.org>
In-Reply-To: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current code just allocate from first avail window.

We can find all suitable empty slots and pick one with smallest size, so
we could save the big slot for needed ones later when we have several pci
bridges under parent bridge and some bridges get assigned from bios and we
need to assign others in kernel.

For examples: we have window
[0xc0000000, 0xd0000000), and [0xe0000000,0xe1000000)

and we try allocate 0x200000 size resource.

in this patch will reserve [0xc0000000, 0xd0000000) and
[0xe0000000,0xe1000000) at first, then pick [0xe0000000,0xe1000000)
to allocate 0x200000 size.

-v2: updated after __allocate_resource change, and add field in constraint
	instead of passing it directly.
-v3: Use best fit instead of just fit according to Bjorn.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kernel/resource.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 13 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 62321b0..c468875 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -48,6 +48,7 @@ struct resource_constraint {
 	resource_size_t (*alignf)(void *, const struct resource *,
 			resource_size_t, resource_size_t);
 	void *alignf_data;
+	bool fit;
 };
 
 static DEFINE_RWLOCK(resource_lock);
@@ -589,12 +590,15 @@ static void resource_clip(struct resource *res, resource_size_t min,
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
@@ -618,15 +622,16 @@ static int __find_resource(struct resource *root, struct resource *old,
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
@@ -643,6 +648,11 @@ next:		if (!this || this->end == root->end)
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
@@ -650,7 +660,49 @@ static int find_resource(struct resource *root, struct resource *new,
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
@@ -671,7 +723,8 @@ static int __reallocate_resource(struct resource *root, struct resource *old,
 	struct resource new = *old;
 	struct resource *conflict;
 
-	if ((err = __find_resource(root, old, &new, newsize, constraint)))
+	err = __find_resource(root, old, &new, NULL, newsize, constraint);
+	if (err)
 		goto out;
 
 	if (resource_contains(&new, old)) {
@@ -710,6 +763,7 @@ out:
  * @align: alignment requested, in bytes
  * @alignf: alignment function, optional, called if not NULL
  * @alignf_data: arbitrary data to pass to the @alignf function
+ * @fit: only allocate fit range.
  *
  * Caller need to hold resource_lock if needed.
  */
@@ -720,7 +774,7 @@ static int __allocate_resource(struct resource *root, struct resource *new,
 						  const struct resource *,
 						  resource_size_t,
 						  resource_size_t),
-				void *alignf_data)
+				void *alignf_data, bool fit)
 {
 	int err;
 	struct resource_constraint constraint;
@@ -733,6 +787,7 @@ static int __allocate_resource(struct resource *root, struct resource *new,
 	constraint.align = align;
 	constraint.alignf = alignf;
 	constraint.alignf_data = alignf_data;
+	constraint.fit = fit;
 
 	if (new->parent) {
 		/* resource is already allocated, try reallocating with
@@ -773,7 +828,7 @@ int allocate_resource(struct resource *root, struct resource *new,
 
 	write_lock(&resource_lock);
 	ret = __allocate_resource(root, new, size, min, max, align,
-				   alignf, alignf_data);
+				   alignf, alignf_data, true);
 	write_unlock(&resource_lock);
 
 	return ret;
-- 
1.8.4.5

