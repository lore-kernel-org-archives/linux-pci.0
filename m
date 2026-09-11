Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014838DC6C;
	Fri, 11 Sep 2026 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148711; cv=none; b=XXj0ubYEM0RkiZyHms75QG5cdzbg3N6I+7w1Tl85TWPz2/3PNlG9vil/CqyCojXyPfIWanx++6EXKDWbGalva89rECjrQNzHBWyNNZLYQtSCmDGW6yNeq29Y6fuvXY+/TYDF7MHZl/6cAWXXjudwIq+WRkFuCMdverun2j6FE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148711; c=relaxed/simple;
	bh=u5AI544MjmW3ixW1cudPQM3iDWgpRHlEHxhYxBli50k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoOHVb6JsFAmbpZkiENYgF7caXWAPK2Fcv5Vi0NKkw8ppF88C7AN6fyDlmiVLUgs6//jyy0TmBPtwjAhCLBqslk/ZGe14Jb+MT7T7Zy0Q+HHb0k2GYMatbhVE0bGQSpkyWeg3oRChDD+PXXQKw8m9EaiK6e5qnbS+PFzJdONOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=DuqyauPP; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="DuqyauPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789148700; x=1820684700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yflPJiaY48xoge6J7Zyps37Hewsbf2B/H30hL8plHtw=;
  b=DuqyauPPSLBHPfRZJbvdWl/OxPthk1m57voIwrqspDi7ZxD8z9uXMn3+
   +8A7UH6IWBTkJ2OW/JhVhPQxW1FnBKxh6nran/GJ5T7QGiLMD4GDEyO9H
   UmMKsaQfgBSKD/42lksSbBCwhwhSq215K8QX/nNTuYb8CrNjMmeipEwfr
   tUh66NrGLOa47zHoa6Xx0VN53Npphtv2yr58gVk0mXHOM4iGkBZz+iB47
   vHfxWx4WL3xyUOfE3KWxxAnM+D0zh43KSVI56oRuXFMO74ElZjrmU7qtW
   zrFN91ZpntMkwn1DRSxG8zAFgLjKeHx2Y7X/cpvwDPl9nvF94W01HL1lE
   Q==;
X-CSE-ConnectionGUID: pxu7p6JGSg2BJMYZ2wnrbg==
X-CSE-MsgGUID: lybOeRnSQWu2yp+vXMdnkQ==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28450836"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 17:44:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:10763]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.113:2525] with esmtp (Farcaster)
 id 9ab215f7-0d7b-41d1-9ccb-0792ab733d75; Fri, 11 Sep 2026 17:44:52 +0000 (UTC)
X-Farcaster-Flow-ID: 9ab215f7-0d7b-41d1-9ccb-0792ab733d75
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 17:44:52 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 17:44:49 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo
	<tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alex Williamson
	<alex@shazbot.org>, <kvm@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 2/8] kernfs: add staged directory creation and publication
Date: Fri, 11 Sep 2026 19:43:34 +0200
Message-ID: <20260911174414.97060-2-sakacpav@amazon.de>
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
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Each sysfs node creation takes the root's kernfs_rwsem for write to link
the node into its parent's children rbtree and activate it, so mass
registration against the single sysfs root serializes all of them on one
lock. KERNFS_ROOT_CREATE_DEACTIVATED already flips a finished subtree
visible atomically, but its nodes are still linked under the root
write-lock as they are created, so the per-node traffic that is the
actual cost remains.

Add a staged mode that removes it. A staged directory is fully
initialized but neither linked into its parent's children rbtree nor
activated, so only the creator's saved pointer (for sysfs, kobj->sd)
reaches it, and the kernfs children-collection operations that can reach
one take a per-staged-subtree mutex hashed by the staged-top node address
in place of the per-root rwsems. kernfs_publish() then performs the
single staged-to-visible transition under kernfs_rwsem, dropping
per-device root-lock cost from one write acquisition per node to one
write hold for the whole subtree. struct kernfs_node does not grow:
the mutex array reuses the existing kernfs_global_locks node_mutex
idiom.

The funnel covers the operations that reach a staged subtree through the
kernfs creation and removal APIs. kernfs_setattr() takes
kernfs_iattr_rwsem and is not serialized against them, so a staged
node's attributes must be mutated only through the funnel.

kernfs_node::flags is an unsigned short whose plain bits are exhausted,
and widening it would grow every node by 8 bytes, so the
KERNFS_STAGED_TOP marker aliases the FILE-only KERNFS_HAS_MMAP under a
DIR-only discipline: staged code touches the bit only on directories,
and the parent-chain climb that locates a top checks the node type
before reading it, so a staged mmap file's HAS_MMAP is never disturbed.
The pre-existing flags updates a linked node can receive (activation,
visibility toggling) become marked writes for the same reason.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 fs/kernfs/dir.c        | 447 +++++++++++++++++++++++++++++++++++++++--
 fs/kernfs/mount.c      |   4 +-
 include/linux/kernfs.h |  46 +++++
 3 files changed, 474 insertions(+), 23 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index a6290f94139c..a0f0db82ef3f 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -479,7 +479,9 @@ static void kernfs_update_parent_times(struct kernfs_node *parent)
  *	that under whichever lock protects the parent's children collection.
  *
  *	Locking:
- *	kernfs_rwsem held exclusive
+ *	kernfs_rwsem held exclusive, or -- for a staged @kn -- the staged
+ *	subtree mutex inside an RCU read section, which is what the ->__parent
+ *	and ->name dereferences below require (see kernfs_staged_lock()).
  *
  *	Return:
  *	%0 on success, -EEXIST on failure.
@@ -573,6 +575,171 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 	return true;
 }
 
+/* see staged_mutex in struct kernfs_global_locks */
+static inline struct mutex *kernfs_staged_mutex_ptr(struct kernfs_node *kn)
+{
+	return &kernfs_locks->staged_mutex[hash_ptr(kn, NR_KERNFS_LOCK_BITS)];
+}
+
+/* STAGED_TOP aliases a FILE-only bit; clear it only on directories */
+static unsigned short kernfs_staged_clear_mask(struct kernfs_node *kn)
+{
+	return KERNFS_STAGED |
+	       (kernfs_type(kn) == KERNFS_DIR ? KERNFS_STAGED_TOP : 0);
+}
+
+/*
+ * kernfs_parent()'s lockdep conditions cannot express the runtime-selected
+ * staged subtree mutex, so the RCU read section is what makes the
+ * ->__parent dereference legal.
+ *
+ * The value is stable, not merely valid: __kernfs_new_node() holds a
+ * counted parent reference that lives as long as @kn, and a staged node is
+ * never activated, so kernfs_rename_ns() rejects it with -ENOENT before it
+ * can reach the ->__parent reassignment.
+ */
+static struct kernfs_node *kernfs_staged_parent(const struct kernfs_node *kn)
+{
+	struct kernfs_node *parent;
+
+	rcu_read_lock();
+	parent = rcu_dereference(kn->__parent);
+	rcu_read_unlock();
+
+	return parent;
+}
+
+/**
+ * kernfs_staged_lock - find and lock the subtree mutex for a staged node
+ * @parent: a node believed to be in a staged subtree
+ *
+ * Return the locked subtree mutex L(top) of @parent's staged top, or NULL if
+ * the subtree is (or became) published, in which case the caller uses the
+ * kernfs_rwsem path.
+ *
+ * Top-ness is one flag, KERNFS_STAGED_TOP: set once at staged creation,
+ * mutated only under L(top) at publish/teardown.  The climb is lock-free
+ * and advisory; the re-verify under L(top) is a single read of STAGED_TOP,
+ * fresh because the bit is mutated only under the lock now held, so a
+ * stale walk cannot confirm a published or wrong-subtree node.  Publication
+ * and teardown are one-way, so retries terminate.  The climb needs no lock:
+ * the caller's reference on @parent pins its ancestors and staged nodes
+ * never move (see kernfs_staged_parent()).
+ *
+ * Context: May sleep.  Returns with the returned mutex HELD; the caller
+ * releases it with mutex_unlock().  Not sparse-annotated: the acquisition is
+ * conditional and the lock runtime-selected, which __acquires() cannot say.
+ */
+static struct mutex *kernfs_staged_lock(struct kernfs_node *parent)
+{
+	for (;;) {
+		struct kernfs_node *top = parent;
+		struct mutex *lock;
+
+		for (;;) {
+			/* advisory; authoritative re-check under L(top) */
+			unsigned short flags = READ_ONCE(top->flags);
+
+			if (!(flags & KERNFS_STAGED))
+				return NULL;
+			/* STAGED_TOP is DIR-only (see its definition) */
+			if ((flags & KERNFS_TYPE_MASK) == KERNFS_DIR &&
+			    (flags & KERNFS_STAGED_TOP))
+				break;
+			/* staged interior: climb */
+			top = kernfs_staged_parent(top);
+		}
+
+		lock = kernfs_staged_mutex_ptr(top);
+		mutex_lock(lock);
+		/*
+		 * READ_ONCE: after publication the eager path writes other
+		 * bits of this word.
+		 */
+		if (READ_ONCE(top->flags) & KERNFS_STAGED_TOP)
+			return lock;	/* still staged; L(top) is correct */
+		mutex_unlock(lock);
+		/* published or torn down under us; retry from @parent */
+	}
+}
+
+/*
+ * Caller holds the lock covering @parent's children collection:
+ * kernfs_rwsem or the staged subtree mutex.
+ */
+static int kernfs_add_precheck(struct kernfs_node *parent,
+			       struct kernfs_node *kn)
+{
+	bool has_ns = kernfs_ns_enabled(parent);
+
+	if (has_ns != (bool)kn->ns) {
+		rcu_read_lock();
+		WARN(1, "kernfs: ns %s in '%s' for '%s'\n",
+		     has_ns ? "required" : "invalid",
+		     kernfs_rcu_name(parent), kernfs_rcu_name(kn));
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+
+	if (kernfs_type(parent) != KERNFS_DIR)
+		return -EINVAL;
+
+	if (parent->flags & (KERNFS_REMOVING | KERNFS_EMPTY_DIR))
+		return -ENOENT;
+
+	return 0;
+}
+
+/**
+ * kernfs_add_one_staged - add @kn under a staged parent
+ * @kn: kernfs_node to add (parent already set and staged)
+ * @lock: the staged subtree mutex returned by kernfs_staged_lock(), held
+ *
+ * Links @kn into the staged parent without the per-root rwsems.  @kn is
+ * marked staged so its own children funnel here too, and is left inactive;
+ * publication activates the whole subtree at once.
+ *
+ * Return: %0 on success, -errno on failure.
+ */
+static int kernfs_add_one_staged(struct kernfs_node *kn, struct mutex *lock)
+{
+	struct kernfs_node *parent = kernfs_staged_parent(kn);
+	int ret;
+
+	lockdep_assert_held(lock);
+
+	ret = kernfs_add_precheck(parent, kn);
+	if (ret)
+		return ret;
+
+	/*
+	 * The RCU read section covers the RCU-managed name and parent
+	 * dereferences here and inside the rbtree walk; the caller's subtree
+	 * mutex is what serializes them.  Neither can change under it: a
+	 * staged node is unreachable, so it cannot be renamed or reparented.
+	 */
+	rcu_read_lock();
+	kn->hash = kernfs_name_hash(kernfs_rcu_name(kn), kn->ns);
+	ret = __kernfs_link_sibling(kn);
+	rcu_read_unlock();
+	if (ret)
+		return ret;
+
+	/*
+	 * The caller's subtree mutex serializes this parent's children, so
+	 * the subdir/revision/timestamp accounting eager kernfs_add_one()
+	 * does under kernfs_iattr_rwsem is done here without it.
+	 */
+	if (kernfs_type(kn) == KERNFS_DIR)
+		parent->dir.subdirs++;
+	kernfs_inc_rev(parent);
+	kernfs_update_parent_times(parent);
+
+	/* marked store: racing advisory reads in kernfs_staged_lock() */
+	WRITE_ONCE(kn->flags, kn->flags | KERNFS_STAGED);
+	return 0;
+}
+
 /**
  *	kernfs_get_active - get an active reference to kernfs_node
  *	@kn: kernfs_node to get an active reference to
@@ -966,24 +1133,25 @@ int kernfs_add_one(struct kernfs_node *kn)
 {
 	struct kernfs_root *root = kernfs_root(kn);
 	struct kernfs_node *parent;
-	bool has_ns;
+	struct mutex *lock;
 	int ret;
 
+	/*
+	 * Staged parent: link under its subtree mutex, off the per-root
+	 * rwsems.  NULL once published, then the locked path below runs.
+	 */
+	lock = kernfs_staged_lock(kernfs_staged_parent(kn));
+	if (lock) {
+		ret = kernfs_add_one_staged(kn, lock);
+		mutex_unlock(lock);
+		return ret;
+	}
+
 	down_write(&root->kernfs_rwsem);
 	parent = kernfs_parent(kn);
 
-	ret = -EINVAL;
-	has_ns = kernfs_ns_enabled(parent);
-	if (WARN(has_ns != (bool)kn->ns, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
-		 has_ns ? "required" : "invalid",
-		 kernfs_rcu_name(parent), kernfs_rcu_name(kn)))
-		goto out_unlock;
-
-	if (kernfs_type(parent) != KERNFS_DIR)
-		goto out_unlock;
-
-	ret = -ENOENT;
-	if (parent->flags & (KERNFS_REMOVING | KERNFS_EMPTY_DIR))
+	ret = kernfs_add_precheck(parent, kn);
+	if (ret)
 		goto out_unlock;
 
 	kn->hash = kernfs_name_hash(kernfs_rcu_name(kn), kn->ns);
@@ -1020,7 +1188,8 @@ int kernfs_add_one(struct kernfs_node *kn)
  * @ns: the namespace tag to use
  *
  * Caller must hold a lock covering @parent's children collection:
- * kernfs_rwsem.
+ * kernfs_rwsem, or -- for a staged @parent -- the staged subtree mutex inside
+ * an RCU read section (the rbtree walk dereferences RCU-managed names).
  *
  * Return: pointer to the found kernfs_node on success, %NULL on failure.
  */
@@ -1114,8 +1283,21 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const struct ns_common *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct kernfs_root *root;
+	struct mutex *lock;
+
+	/* staged parent: serialize on its subtree mutex; NULL once published */
+	lock = kernfs_staged_lock(parent);
+	if (lock) {
+		rcu_read_lock();
+		kn = __kernfs_find_ns(parent, name, ns);
+		rcu_read_unlock();
+		kernfs_get(kn);
+		mutex_unlock(lock);
+		return kn;
+	}
 
+	root = kernfs_root(parent);
 	down_read(&root->kernfs_rwsem);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
@@ -1313,6 +1495,41 @@ struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 	return ERR_PTR(rc);
 }
 
+/**
+ * kernfs_create_dir_ns_staged - create a staged directory
+ * @parent: live parent in which the directory will eventually appear
+ * @name: name of the new directory
+ * @mode: mode of the new directory
+ * @uid: uid of the new directory
+ * @gid: gid of the new directory
+ * @priv: opaque data associated with the new directory
+ * @ns: optional namespace tag of the directory
+ *
+ * Create a directory node that is fully initialized, with @parent set and a
+ * parent reference taken, but NOT linked into @parent's children collection
+ * and NOT activated: it is invisible to lookup, readdir and the dcache.  The
+ * KERNFS_STAGED bit is set here, before the node is reachable.  A caller
+ * that exposes the returned pointer to lock-free readers must publish it
+ * with release semantics so these init stores are visible first.  While
+ * staged, the subtree is mutated only through the kernfs creation and
+ * removal APIs, which serialize on the subtree mutex; kernfs_setattr()
+ * and other per-root-lock paths are not serialized against them.  The
+ * subtree built beneath it through the unchanged creation APIs stays staged
+ * until kernfs_publish() links it into @parent in one transaction; see
+ * there for the activation policy.
+ *
+ * Return: the created node on success, ERR_PTR() value on failure.
+ */
+struct kernfs_node *kernfs_create_dir_ns_staged(struct kernfs_node *parent,
+						const char *name, umode_t mode,
+						kuid_t uid, kgid_t gid,
+						void *priv,
+						const struct ns_common *ns)
+{
+	return __kernfs_create_dir(parent, name, mode, uid, gid, priv, ns,
+				   KERNFS_STAGED | KERNFS_STAGED_TOP);
+}
+
 /**
  * kernfs_create_empty_dir - create an always empty directory
  * @parent: parent in which to create a new directory
@@ -1605,7 +1822,8 @@ static void kernfs_activate_one(struct kernfs_node *kn)
 {
 	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
 
-	kn->flags |= KERNFS_ACTIVATED;
+	/* flags is read locklessly by the staged funnel; mark its racers */
+	WRITE_ONCE(kn->flags, kn->flags | KERNFS_ACTIVATED);
 
 	if (kernfs_active(kn) || (kn->flags & (KERNFS_HIDDEN | KERNFS_REMOVING)))
 		return;
@@ -1643,6 +1861,99 @@ void kernfs_activate(struct kernfs_node *kn)
 	up_write(&root->kernfs_rwsem);
 }
 
+/**
+ * kernfs_publish - make a staged subtree visible
+ * @kn: staged top (as returned by kernfs_create_dir_ns_staged())
+ *
+ * Under the per-root kernfs_rwsem (held write) and the subtree mutex, in
+ * this order: verify the parent is still live and the name does not collide
+ * with a live sibling, link @kn into the parent's children collection
+ * (bumping the directory revision that invalidates negative dentries), then
+ * walk the subtree clearing KERNFS_STAGED and activating every node.
+ *
+ * Readers see the transition via lock pairing -- kernfs_rwsem for VFS readers,
+ * L(top) re-verification for funnel entrants; see kernfs_staged_lock().  On
+ * success the directory is indistinguishable from one built eagerly.
+ *
+ * On a %KERNFS_ROOT_CREATE_DEACTIVATED root the subtree is linked and no longer
+ * staged, but left deactivated, matching kernfs_add_one(); the caller makes it
+ * visible with kernfs_activate().
+ *
+ * @kn must still be staged, and its parent must not itself be staged (a staged
+ * parent's children are serialized by a different subtree mutex); no in-tree
+ * caller does either.
+ *
+ * Return: %0 on success, -EEXIST on a name collision, -ENOENT if the parent is
+ * gone, or -EINVAL on misuse (WARN), including publishing a node that is not
+ * staged (already published or torn down).  On failure the subtree stays staged
+ * and tear-downable.
+ */
+int kernfs_publish(struct kernfs_node *kn)
+{
+	struct kernfs_node *parent = kernfs_staged_parent(kn);
+	struct kernfs_root *root = kernfs_root(kn);
+	struct kernfs_node *pos;
+	struct mutex *lock;
+	bool activate;
+	int ret;
+
+	/* Unlocked pre-check; the locked re-check below is authoritative. */
+	if (WARN_ON_ONCE(!parent || (data_race(parent->flags) & KERNFS_STAGED)))
+		return -EINVAL;
+
+	/* Unlocked pre-check, as above. */
+	if (WARN_ON_ONCE(!(data_race(kn->flags) & KERNFS_STAGED)))
+		return -EINVAL;
+
+	activate = !(root->flags & KERNFS_ROOT_CREATE_DEACTIVATED);
+	lock = kernfs_staged_mutex_ptr(kn);
+
+	down_write(&root->kernfs_rwsem);
+	mutex_lock(lock);
+
+	/* authoritative re-check: the advisory reads above can race */
+	ret = -EINVAL;
+	if (WARN_ON_ONCE(!(READ_ONCE(kn->flags) & KERNFS_STAGED)))
+		goto out;
+
+	ret = -ENOENT;
+	if (parent->flags & (KERNFS_REMOVING | KERNFS_EMPTY_DIR))
+		goto out;
+
+	/* the write hold covers the RCU-managed name from here on */
+	kn->hash = kernfs_name_hash(kernfs_rcu_name(kn), kn->ns);
+
+	ret = kernfs_link_sibling(kn);
+	if (ret)		/* -EEXIST on a live-sibling name collision */
+		goto out;
+
+	/* mirror kernfs_add_one(): bump the parent's timestamps */
+	down_write(&root->kernfs_iattr_rwsem);
+	kernfs_update_parent_times(parent);
+	up_write(&root->kernfs_iattr_rwsem);
+
+	/*
+	 * @kn is now linked; clear staged and activate every node.  A walker
+	 * that observes a cleared bit therefore finds the tree already linked,
+	 * so its rwsem fallback is correct.  WRITE_ONCE: races advisory reads.
+	 * Clearing is unconditional -- the funnel in kernfs_staged_lock() must
+	 * terminate here whatever the root's activation policy is -- while
+	 * activation follows that policy, as in kernfs_add_one().
+	 */
+	pos = NULL;
+	while ((pos = kernfs_next_descendant_post(pos, kn))) {
+		WRITE_ONCE(pos->flags,
+			   pos->flags & ~kernfs_staged_clear_mask(pos));
+		if (activate)
+			kernfs_activate_one(pos);
+	}
+	ret = 0;
+out:
+	mutex_unlock(lock);
+	up_write(&root->kernfs_rwsem);
+	return ret;
+}
+
 /**
  * kernfs_show - show or hide a node
  * @kn: kernfs_node to show or hide
@@ -1665,11 +1976,11 @@ void kernfs_show(struct kernfs_node *kn, bool show)
 	down_write(&root->kernfs_rwsem);
 
 	if (show) {
-		kn->flags &= ~KERNFS_HIDDEN;
+		WRITE_ONCE(kn->flags, kn->flags & ~KERNFS_HIDDEN);
 		if (kn->flags & KERNFS_ACTIVATED)
 			kernfs_activate_one(kn);
 	} else {
-		kn->flags |= KERNFS_HIDDEN;
+		WRITE_ONCE(kn->flags, kn->flags | KERNFS_HIDDEN);
 		if (kernfs_active(kn))
 			atomic_add(KN_DEACTIVATED_BIAS, &kn->active);
 		kernfs_drain(kn, false);
@@ -1709,6 +2020,70 @@ static void kernfs_clear_inode_nlink(struct kernfs_node *kn)
 	}
 }
 
+/**
+ * kernfs_remove_staged - tear down a staged subtree rooted at @kn
+ * @kn: staged node (a staged top, or an interior node being removed
+ *      individually during the window)
+ * @lock: the staged-subtree mutex the caller holds
+ *
+ * Every node in a staged subtree is inactive (KN_DEACTIVATED_BIAS) and
+ * unreachable by userspace, so there is nothing to drain and kernfs_rwsem is
+ * not required.  For the same reason no inode can exist for any of these
+ * nodes -- an inode is instantiated only through a lookup, which cannot reach
+ * an unlinked, inactive node -- so unlike __kernfs_remove() this needs
+ * neither kernfs_supers_rwsem nor kernfs_clear_inode_nlink().
+ *
+ * This mirrors __kernfs_remove()'s per-node reference drop for eager parity,
+ * and additionally drops the base reference of a never-linked staged top,
+ * which the eager path would leak: __kernfs_remove() short-circuits on an
+ * unlinked node with a parent, and kernfs_unlink_sibling() returns false
+ * for it.
+ */
+static void kernfs_remove_staged(struct kernfs_node *kn, struct mutex *lock)
+{
+	struct kernfs_node *pos;
+
+	lockdep_assert_held(lock);
+
+	do {
+		struct kernfs_node *parent;
+
+		pos = kernfs_leftmost_descendant(kn);
+		kernfs_get(pos);
+		parent = kernfs_staged_parent(pos);
+
+		/*
+		 * Clear STAGED and set REMOVING; a funnel entrant that lost
+		 * the L(top) race then hits kernfs_add_one()'s REMOVING
+		 * check on the rwsem path instead of leaking into this dead
+		 * subtree.  The mask clears STAGED_TOP only on directories
+		 * (see its definition).  WRITE_ONCE: the store races the
+		 * advisory reads in kernfs_staged_lock().
+		 */
+		WRITE_ONCE(pos->flags,
+			   (pos->flags & ~kernfs_staged_clear_mask(pos)) |
+			   KERNFS_REMOVING);
+
+		/* linked node: unlink from its staged parent's rbtree */
+		if (parent && !RB_EMPTY_NODE(&pos->rb)) {
+			if (kernfs_type(pos) == KERNFS_DIR)
+				parent->dir.subdirs--;
+			kernfs_inc_rev(parent);
+			/*
+			 * Parent time parity with eager __kernfs_remove();
+			 * owner-serialized by the subtree mutex, so no
+			 * kernfs_iattr_rwsem (as on the staged add side).
+			 */
+			kernfs_update_parent_times(parent);
+			rb_erase(&pos->rb, &parent->dir.children);
+			RB_CLEAR_NODE(&pos->rb);
+		}
+
+		kernfs_put(pos);	/* base ref (__kernfs_remove parity) */
+		kernfs_put(pos);	/* protective ref; free drops parent */
+	} while (pos != kn);
+}
+
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos, *parent;
@@ -1733,7 +2108,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
-		pos->flags |= KERNFS_REMOVING;
+		WRITE_ONCE(pos->flags, pos->flags | KERNFS_REMOVING);
 		if (kernfs_active(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
 	}
@@ -1782,10 +2157,19 @@ static void __kernfs_remove(struct kernfs_node *kn)
 void kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_root *root;
+	struct mutex *lock;
 
 	if (!kn)
 		return;
 
+	/* staged subtree: tear down under its mutex; NULL once published */
+	lock = kernfs_staged_lock(kn);
+	if (lock) {
+		kernfs_remove_staged(kn, lock);
+		mutex_unlock(lock);
+		return;
+	}
+
 	root = kernfs_root(kn);
 
 	down_read(&root->kernfs_supers_rwsem);
@@ -1897,9 +2281,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 * instance of kernfs_remove_self() finished.
 	 */
 	if (!(kn->flags & KERNFS_SUICIDAL)) {
-		kn->flags |= KERNFS_SUICIDAL;
+		WRITE_ONCE(kn->flags, kn->flags | KERNFS_SUICIDAL);
 		__kernfs_remove(kn);
-		kn->flags |= KERNFS_SUICIDED;
+		WRITE_ONCE(kn->flags, kn->flags | KERNFS_SUICIDED);
 		ret = true;
 	} else {
 		wait_queue_head_t *waitq = &kernfs_root(kn)->deactivate_waitq;
@@ -1949,6 +2333,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 {
 	struct kernfs_node *kn;
 	struct kernfs_root *root;
+	struct mutex *lock;
 
 	if (!parent) {
 		WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",
@@ -1956,6 +2341,24 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		return -ENOENT;
 	}
 
+	/* staged parent: serialize on its subtree mutex; NULL once published */
+	lock = kernfs_staged_lock(parent);
+	if (lock) {
+		bool found;
+
+		rcu_read_lock();
+		kn = __kernfs_find_ns(parent, name, ns);
+		rcu_read_unlock();
+		found = kn;
+		if (kn) {
+			kernfs_get(kn);
+			kernfs_remove_staged(kn, lock);
+			kernfs_put(kn);
+		}
+		mutex_unlock(lock);
+		return found ? 0 : -ENOENT;
+	}
+
 	root = kernfs_root(parent);
 	down_read(&root->kernfs_supers_rwsem);
 	down_write(&root->kernfs_rwsem);
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index f183a96778b9..19b1d52ab966 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -445,8 +445,10 @@ static void __init kernfs_mutex_init(void)
 {
 	int count;
 
-	for (count = 0; count < NR_KERNFS_LOCKS; count++)
+	for (count = 0; count < NR_KERNFS_LOCKS; count++) {
 		mutex_init(&kernfs_locks->node_mutex[count]);
+		mutex_init(&kernfs_locks->staged_mutex[count]);
+	}
 }
 
 static void __init kernfs_lock_init(void)
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 6440882b7d58..b3e574047a90 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -95,6 +95,15 @@ struct kernfs_iattrs;
  */
 struct kernfs_global_locks {
 	struct mutex node_mutex[NR_KERNFS_LOCKS];
+
+	/*
+	 * Hashed by the staged-top kernfs_node address.  kernfs operations on
+	 * a staged directory's children collection take the matching mutex in
+	 * place of the per-root kernfs_rwsem / kernfs_iattr_rwsem, so mass
+	 * creation of staged subtrees does not serialize on one root's locks.
+	 * This is a second instance of the node_mutex idiom above.
+	 */
+	struct mutex staged_mutex[NR_KERNFS_LOCKS];
 };
 
 enum kernfs_node_type {
@@ -118,6 +127,28 @@ enum kernfs_node_flag {
 	KERNFS_EMPTY_DIR	= 0x1000,
 	KERNFS_HAS_RELEASE	= 0x2000,
 	KERNFS_REMOVING		= 0x4000,
+	/*
+	 * Under-construction directory subtree: initialized and reachable
+	 * only via the creator's saved pointer, not linked into its parent
+	 * and not activated, so it is invisible to lookup/readdir/dcache.
+	 * Set at staged creation, cleared at kernfs_publish()/teardown.
+	 * Set on every node of the subtree.
+	 */
+	KERNFS_STAGED		= 0x8000,
+	/*
+	 * Marks the single top of a staged subtree (never an interior), so
+	 * kernfs_staged_lock() identifies the owning subtree mutex from one
+	 * location, and its re-verify under L(top) is fresh (the bit is
+	 * mutated only there).
+	 *
+	 * kernfs_node::flags is an unsigned short with its plain bits
+	 * exhausted at 0x8000, so this aliases KERNFS_HAS_MMAP under a
+	 * DIR-only discipline: on a KERNFS_FILE node the bit always means
+	 * HAS_MMAP; staged code sets, clears and tests STAGED_TOP only on
+	 * KERNFS_DIR nodes (a staged top is always a directory), so a staged
+	 * mmap file's HAS_MMAP is never disturbed.
+	 */
+	KERNFS_STAGED_TOP	= KERNFS_HAS_MMAP,
 };
 
 /* @flags for kernfs_create_root() */
@@ -447,6 +478,12 @@ struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 					 kuid_t uid, kgid_t gid,
 					 void *priv,
 					 const struct ns_common *ns);
+struct kernfs_node *kernfs_create_dir_ns_staged(struct kernfs_node *parent,
+						const char *name, umode_t mode,
+						kuid_t uid, kgid_t gid,
+						void *priv,
+						const struct ns_common *ns);
+int kernfs_publish(struct kernfs_node *kn);
 struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 					    const char *name);
 struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
@@ -550,6 +587,15 @@ kernfs_create_dir_ns(struct kernfs_node *parent, const char *name,
 		     void *priv, const struct ns_common *ns)
 { return ERR_PTR(-ENOSYS); }
 
+static inline struct kernfs_node *
+kernfs_create_dir_ns_staged(struct kernfs_node *parent, const char *name,
+			    umode_t mode, kuid_t uid, kgid_t gid,
+			    void *priv, const struct ns_common *ns)
+{ return ERR_PTR(-ENOSYS); }
+
+static inline int kernfs_publish(struct kernfs_node *kn)
+{ return -ENOSYS; }
+
 static inline struct kernfs_node *
 __kernfs_create_file(struct kernfs_node *parent, const char *name,
 		     umode_t mode, kuid_t uid, kgid_t gid,
-- 
2.47.3

