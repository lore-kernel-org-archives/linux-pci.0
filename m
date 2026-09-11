Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AB6356754;
	Fri, 11 Sep 2026 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148672; cv=none; b=Al/WTmuLhMzdvRAtX47wKeZOPwChmP+RWDQICY/66akbsjK9TyXBfgsVn7jXH9zwJQlAyIzvHo38lSlOXOVAiF1I14Y7klN3UD5LfEtbs55olXrlRPCSl6twDmuY1t9tz8QeU4fbSp2bcOs9oJa2V8z34yEfwFx0YRe89P/sZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148672; c=relaxed/simple;
	bh=8r4gc3xKoWIXaeHEbv2OHiJwyaQA1NKjsYvm9JZrpKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQ/QxDpGjh6DXTDfQH7JdGj8FMLKT6O/e7DC1F5pgz+UhgUJA96Zu0ln7hjcNqem67GVWUZUplUjV1LMvTALFwSCU+qjDuQ32ZfWGGNO6p9sV5UPY8WDgffgOPYWZJSTamm39Uwf9bulewniLezW2BiEgxgRMa7gAPAxlzBlvtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=pqiqPXC7; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="pqiqPXC7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789148667; x=1820684667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6iOtJLCOMaVu1u7N9u6FCZ3yXZzuE0TLkNT/UH0NMLg=;
  b=pqiqPXC7pojfsduBDyeGRYIfzCrnODduaNceQknsHQRdO5qLv11DnCdR
   6F/mnGUaI0Pw4f05b19DAQaWRkmhyzqUbzPsBUWphWPAVYm6qT02LX7FY
   qiy+wGB6Anu9lQJrsJFLGCoBa2JOQ+17NX5Kl4a1GHJiPLcLjGK3SSdbK
   poPJMfDW4WhVvnXe/fVA7UKEZURXVQyQIPUxS4mm7siTozsGs4sFyo/Z9
   sCIUeKmLneZWeoEs8CeDd3FbI4sIKqRUj4mn5sGHMAt7CJwjYZvHdrAUy
   f6qZaAhBVvc/YCbYdle/tLBZ2QOV3+79NkZHD6L8wbWcbeUQsNxbjO6T+
   Q==;
X-CSE-ConnectionGUID: d9ta3Z/UTFish95eKkRVXA==
X-CSE-MsgGUID: 38T1FJ6wQVmiXLKH9NcH2w==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28317879"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 17:44:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:6341]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.93:2525] with esmtp (Farcaster)
 id 9b6f30e1-fa4b-42b7-8f8b-344e3e7b0c22; Fri, 11 Sep 2026 17:44:18 +0000 (UTC)
X-Farcaster-Flow-ID: 9b6f30e1-fa4b-42b7-8f8b-344e3e7b0c22
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 17:44:18 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 17:44:15 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo
	<tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alex Williamson
	<alex@shazbot.org>, <kvm@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 1/8] kernfs: factor out reusable directory helpers
Date: Fri, 11 Sep 2026 19:43:33 +0200
Message-ID: <20260911174414.97060-1-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
References: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

An upcoming change adds staged directories whose children collections are
protected by a per-subtree mutex instead of kernfs_rwsem, so it needs the
pure rbtree and directory-creation operations without the rwsem assertions
and accounting wrapped around them.

Split those out: __kernfs_link_sibling() and __kernfs_find_ns() for the
children-rbtree work, __kernfs_create_dir() for the sequence both directory
creators repeat, and kernfs_update_parent_times() for the parent timestamp
bump open-coded at each link and unlink site. The existing names stay as
locked wrappers carrying the lockdep assertions, the link-side wrapper
gaining the write-side assertion it lacked. No functional change intended.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 fs/kernfs/dir.c | 128 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 41 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 1938edd39eff..a6290f94139c 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -459,12 +459,24 @@ static int kernfs_sd_compare(const struct kernfs_node *left,
 	return kernfs_name_compare(left->hash, kernfs_rcu_name(left), left->ns, right);
 }
 
+/* Bump @parent's ctime/mtime; caller holds whichever lock covers @parent. */
+static void kernfs_update_parent_times(struct kernfs_node *parent)
+{
+	struct kernfs_iattrs *ps_iattr = parent ? parent->iattr : NULL;
+
+	if (ps_iattr) {
+		ktime_get_real_ts64(&ps_iattr->ia_ctime);
+		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
+	}
+}
+
 /**
- *	kernfs_link_sibling - link kernfs_node into sibling rbtree
+ *	__kernfs_link_sibling - link kernfs_node into sibling rbtree
  *	@kn: kernfs_node of interest
  *
- *	Link @kn into its sibling rbtree which starts from
- *	@kn->parent->dir.children.
+ *	Link @kn into its parent's children rbtree.  This is the pure rbtree
+ *	insertion, without the subdir/revision accounting; the caller performs
+ *	that under whichever lock protects the parent's children collection.
  *
  *	Locking:
  *	kernfs_rwsem held exclusive
@@ -472,7 +484,7 @@ static int kernfs_sd_compare(const struct kernfs_node *left,
  *	Return:
  *	%0 on success, -EEXIST on failure.
  */
-static int kernfs_link_sibling(struct kernfs_node *kn)
+static int __kernfs_link_sibling(struct kernfs_node *kn)
 {
 	struct rb_node *parent = NULL;
 	struct kernfs_node *kn_parent;
@@ -500,7 +512,26 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
 	rb_link_node(&kn->rb, parent, node);
 	rb_insert_color(&kn->rb, &kn_parent->dir.children);
 
+	return 0;
+}
+
+/*
+ * Locked variant of __kernfs_link_sibling(): kernfs_rwsem held exclusive; also
+ * performs the subdir count and directory-revision accounting.
+ */
+static int kernfs_link_sibling(struct kernfs_node *kn)
+{
+	struct kernfs_node *kn_parent;
+	int ret;
+
+	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
+
+	ret = __kernfs_link_sibling(kn);
+	if (ret)
+		return ret;
+
 	/* successfully added, account subdir number */
+	kn_parent = kernfs_parent(kn);
 	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn_parent->dir.subdirs++;
@@ -934,7 +965,6 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 int kernfs_add_one(struct kernfs_node *kn)
 {
 	struct kernfs_root *root = kernfs_root(kn);
-	struct kernfs_iattrs *ps_iattr;
 	struct kernfs_node *parent;
 	bool has_ns;
 	int ret;
@@ -964,13 +994,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 
 	/* Update timestamps on the parent */
 	down_write(&root->kernfs_iattr_rwsem);
-
-	ps_iattr = parent->iattr;
-	if (ps_iattr) {
-		ktime_get_real_ts64(&ps_iattr->ia_ctime);
-		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
-	}
-
+	kernfs_update_parent_times(parent);
 	up_write(&root->kernfs_iattr_rwsem);
 
 	/*
@@ -990,25 +1014,24 @@ int kernfs_add_one(struct kernfs_node *kn)
 }
 
 /**
- * kernfs_find_ns - find kernfs_node with the given name
+ * __kernfs_find_ns - find kernfs_node with the given name
  * @parent: kernfs_node to search under
  * @name: name to look for
  * @ns: the namespace tag to use
  *
- * Look for kernfs_node with name @name under @parent.
+ * Caller must hold a lock covering @parent's children collection:
+ * kernfs_rwsem.
  *
  * Return: pointer to the found kernfs_node on success, %NULL on failure.
  */
-static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
-					  const unsigned char *name,
-					  const struct ns_common *ns)
+static struct kernfs_node *__kernfs_find_ns(struct kernfs_node *parent,
+					    const unsigned char *name,
+					    const struct ns_common *ns)
 {
 	struct rb_node *node = parent->dir.children.rb_node;
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem);
-
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
 		     has_ns ? "required" : "invalid", kernfs_rcu_name(parent), name);
@@ -1032,6 +1055,18 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	return NULL;
 }
 
+/*
+ * The asserted kernfs_rwsem hold (write or read) also covers the RCU-managed
+ * name dereferences in __kernfs_find_ns()'s walk.
+ */
+static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
+					  const unsigned char *name,
+					  const struct ns_common *ns)
+{
+	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem);
+	return __kernfs_find_ns(parent, name, ns);
+}
+
 static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 					  const unsigned char *path,
 					  const struct ns_common *ns)
@@ -1218,6 +1253,31 @@ struct kernfs_node *kernfs_root_to_node(struct kernfs_root *root)
 	return root->kn;
 }
 
+/*
+ * Allocate and initialize a directory node with @extra_flags OR'd into its
+ * type flags, without linking it anywhere.
+ */
+static struct kernfs_node *__kernfs_create_dir(struct kernfs_node *parent,
+					       const char *name, umode_t mode,
+					       kuid_t uid, kgid_t gid,
+					       void *priv,
+					       const struct ns_common *ns,
+					       unsigned int extra_flags)
+{
+	struct kernfs_node *kn;
+
+	kn = kernfs_new_node(parent, name, mode | S_IFDIR, uid, gid,
+			     KERNFS_DIR | extra_flags);
+	if (!kn)
+		return ERR_PTR(-ENOMEM);
+
+	kn->dir.root = parent->dir.root;
+	kn->ns = ns;
+	kn->priv = priv;
+
+	return kn;
+}
+
 /**
  * kernfs_create_dir_ns - create a directory
  * @parent: parent in which to create a new directory
@@ -1240,14 +1300,9 @@ struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 	int rc;
 
 	/* allocate */
-	kn = kernfs_new_node(parent, name, mode | S_IFDIR,
-			     uid, gid, KERNFS_DIR);
-	if (!kn)
-		return ERR_PTR(-ENOMEM);
-
-	kn->dir.root = parent->dir.root;
-	kn->ns = ns;
-	kn->priv = priv;
+	kn = __kernfs_create_dir(parent, name, mode, uid, gid, priv, ns, 0);
+	if (IS_ERR(kn))
+		return kn;
 
 	/* link in */
 	rc = kernfs_add_one(kn);
@@ -1272,15 +1327,12 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 	int rc;
 
 	/* allocate */
-	kn = kernfs_new_node(parent, name, S_IRUGO|S_IXUGO|S_IFDIR,
-			     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, KERNFS_DIR);
-	if (!kn)
-		return ERR_PTR(-ENOMEM);
+	kn = __kernfs_create_dir(parent, name, 0555,
+				 GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, NULL, NULL, 0);
+	if (IS_ERR(kn))
+		return kn;
 
 	kn->flags |= KERNFS_EMPTY_DIR;
-	kn->dir.root = parent->dir.root;
-	kn->ns = NULL;
-	kn->priv = NULL;
 
 	/* link in */
 	rc = kernfs_add_one(kn);
@@ -1706,18 +1758,12 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		 * to decide who's responsible for cleanups.
 		 */
 		if (!parent || kernfs_unlink_sibling(pos)) {
-			struct kernfs_iattrs *ps_iattr =
-				parent ? parent->iattr : NULL;
-
 			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
 			kernfs_clear_inode_nlink(pos);
 
 			/* update timestamps on the parent */
-			if (ps_iattr) {
-				ktime_get_real_ts64(&ps_iattr->ia_ctime);
-				ps_iattr->ia_mtime = ps_iattr->ia_ctime;
-			}
+			kernfs_update_parent_times(parent);
 
 			up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 			kernfs_put(pos);
-- 
2.47.3

