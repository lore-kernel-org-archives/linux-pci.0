Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36671 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932714AbcDHAWb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:22:31 -0400
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
Subject: [PATCH v11 54/60] resources: Make allocate_resource() return best fit resource
Date: Thu,  7 Apr 2016 17:16:07 -0700
Message-Id: <1460074573-7481-55-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
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
-v4: fix the warning found by Huang Ying.


Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kernel/resource.c | 76 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index c5dbe02..d91ebc5 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -611,7 +611,7 @@ static void resource_clip(struct resource *res, resource_size_t min,
  * alignment constraints
  */
 static int __find_resource(struct resource *root, struct resource *old,
-			 struct resource *new,
+			 struct resource *new, struct resource *availx,
 			 resource_size_t  size,
 			 struct resource_constraint *constraint)
 {
@@ -651,6 +651,11 @@ static int __find_resource(struct resource *root, struct resource *old,
 			if (resource_contains(&avail, &alloc)) {
 				new->start = alloc.start;
 				new->end = alloc.end;
+				if (availx) {
+					availx->start = avail.start;
+					availx->end = avail.end;
+					availx->flags = avail.flags;
+				}
 				return 0;
 			}
 		}
@@ -665,16 +670,6 @@ next:		if (!this || this->end == root->end)
 	return -EBUSY;
 }
 
-/*
- * Find empty slot in the resource tree given range and alignment.
- */
-static int find_resource(struct resource *root, struct resource *new,
-			resource_size_t size,
-			struct resource_constraint  *constraint)
-{
-	return  __find_resource(root, NULL, new, size, constraint);
-}
-
 /**
  * reallocate_resource - allocate a slot in the resource tree given range & alignment.
  *	The resource will be relocated if the new size cannot be reallocated in the
@@ -694,8 +689,8 @@ static int reallocate_resource(struct resource *root, struct resource *old,
 	struct resource *conflict;
 
 	write_lock(&resource_lock);
-
-	if ((err = __find_resource(root, old, &new, newsize, constraint)))
+	err = __find_resource(root, old, &new, NULL, newsize, constraint);
+	if (err)
 		goto out;
 
 	if (resource_contains(&new, old)) {
@@ -723,10 +718,16 @@ out:
 	return err;
 }
 
+struct good_resource {
+	struct list_head list;
+	struct resource avail;
+	struct resource new;
+};
 
 /**
  * allocate_resource - allocate empty slot in the resource tree given range & alignment.
- * 	The resource will be reallocated with a new size if it was already allocated
+ *	The resource will be reallocated with a new size if it was already
+ *	allocated
  * @root: root resource descriptor
  * @new: resource descriptor desired by caller
  * @size: requested resource region size
@@ -747,6 +748,9 @@ int allocate_resource(struct resource *root, struct resource *new,
 {
 	int err;
 	struct resource_constraint constraint;
+	LIST_HEAD(head);
+	struct good_resource *good, *tmp;
+	resource_size_t avail_size = (resource_size_t)-1ULL;
 
 	if (!alignf)
 		alignf = simple_align_resource;
@@ -763,11 +767,53 @@ int allocate_resource(struct resource *root, struct resource *new,
 		return reallocate_resource(root, new, size, &constraint);
 	}
 
+	/* find all suitable ones and add to the list */
+	for (;;) {
+		good = kzalloc(sizeof(*good), GFP_KERNEL);
+		if (!good) {
+			err = -ENOMEM;
+			break;
+		}
+
+		good->new.start = new->start;
+		good->new.end = new->end;
+		good->new.flags = new->flags;
+
+		write_lock(&resource_lock);
+		err = __find_resource(root, NULL, &good->new, &good->avail,
+					size, &constraint);
+		if (err || __request_resource(root, &good->avail)) {
+			err = -EBUSY;
+			kfree(good);
+			write_unlock(&resource_lock);
+			break;
+		}
+		write_unlock(&resource_lock);
+
+		list_add(&good->list, &head);
+	}
+
+	/* pick up the smallest one */
 	write_lock(&resource_lock);
-	err = find_resource(root, new, size, &constraint);
+	list_for_each_entry(good, &head, list) {
+		if (resource_size(&good->avail) < avail_size) {
+			avail_size = resource_size(&good->avail);
+			new->start = good->new.start;
+			new->end = good->new.end;
+			err = 0;
+		}
+		__release_resource(&good->avail, false);
+	}
 	if (err >= 0 && __request_resource(root, new))
 		err = -EBUSY;
 	write_unlock(&resource_lock);
+
+	/* delete the list */
+	list_for_each_entry_safe(good, tmp, &head, list) {
+		list_del(&good->list);
+		kfree(good);
+	}
+
 	return err;
 }
 
-- 
1.8.4.5

