Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4CA3C1412;
	Fri, 11 Sep 2026 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148732; cv=none; b=XTFsGSzqErN15PI0lUUV3pYBafZ7wD3YBHYk9ueacNpoRBqpKBnDV+KM8axud4peEYd3llBlRE51l46oV9jit0DEiP0NggabHrVtsoj7S3qadq6ekdJaDw0axppgD9v2fyFaDf67farsamZSQtEdf1b9sx1g6ixcvtzhIfi8gPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148732; c=relaxed/simple;
	bh=N0xMLmQWTfo32a7EoonV5A+AHDG36d/UGOK+UwGgnus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLaYRRnTjB87OcvhJ+/f4m3YrhuOI1+aOCCzonfUrW6t2TIAFPMZbDb37E6BJr8VJZN0qvmQc6gNSPYWFlXxnFy+A4ECmr7Jpx6KVnTrolia9KMCqUdBI5vtqWER7wAJNHJDvJzdYUKqHaFtIXjDp499uDDrs98TCiuQg0IPqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=a2c795US; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="a2c795US"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789148729; x=1820684729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=asf+3vYzEZL5yRPty1Oajrmz0lrx99bnZzGiGsft6Lo=;
  b=a2c795USGgaVQzkOpUoZLzds+MwEMc0eNWfSk8oSB6O86WnGx6AoU+59
   w2L52eWlDuFXolB/u96l73cQ8/aAIFORERMDjXc5LGJSuGdZYDI42KUUA
   0UY16jXS2SUTA8RY5dy26LuOXMe1zMVpSTUkJO449VmJh561kiKgsFpmx
   GKVh+T4Jn6l3+vzSQSws4pIifrQKFCuPjS8UAtlqQw7F5Kj3GCyEQNhS1
   6NKaGBar8TWOdEVPaHKQ1yJaJJUOllNiodrJqs9ViHonhhKWqyaQ2jJeV
   26tSIACtUwzxc15/dZXLuB+J/1JK/BMDaqV3AydtdkLIBnMMq+THXNK49
   g==;
X-CSE-ConnectionGUID: P13SAVyuQE2ytQPa9TSm4w==
X-CSE-MsgGUID: h4qo6XZUQdqa3N6FPu4lDg==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28450871"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 17:45:26 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:18050]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.34:2525] with esmtp (Farcaster)
 id 60b44e65-d9c1-4d2f-8af6-1b829b845994; Fri, 11 Sep 2026 17:45:26 +0000 (UTC)
X-Farcaster-Flow-ID: 60b44e65-d9c1-4d2f-8af6-1b829b845994
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 17:45:26 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 17:45:23 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo
	<tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alex Williamson
	<alex@shazbot.org>, <kvm@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 3/8] sysfs: add opt-in staged directory creation and publication
Date: Fri, 11 Sep 2026 19:43:35 +0200
Message-ID: <20260911174414.97060-3-sakacpav@amazon.de>
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
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Wire the kernfs staged mechanism into sysfs without touching a single
population entry point. struct kobject gains one opt-in bit, sd_staged,
in the existing state bitfield hole, so no struct grows. When it is set,
sysfs_create_dir_ns() builds the directory with
kernfs_create_dir_ns_staged(); because kobj->sd is valid throughout the
window, every existing population path runs verbatim and staging lives
entirely below them in kernfs. The kobj->sd store becomes
smp_store_release() for every kobject, eager paths included, ordering
the node's initialisation before the pointer's publication.

sysfs_publish_dir() performs the staged-to-visible transition via
kernfs_publish(). It is __must_check like its sibling directory
creators, because an ignored publication failure leaves a permanently
invisible directory. The only modular caller anticipated is the KUnit
suite a later patch in this series adds, so the export is scoped with
EXPORT_SYMBOL_IF_KUNIT().

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 fs/sysfs/dir.c          | 52 ++++++++++++++++++++++++++++++++++++++---
 include/linux/kobject.h | 25 ++++++++++++++++++++
 include/linux/sysfs.h   |  6 +++++
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index ffdcd4153c58..1694c01e8b84 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt)	"sysfs: " fmt
 
+#include <kunit/visibility.h>
 #include <linux/fs.h>
 #include <linux/kobject.h>
 #include <linux/slab.h>
@@ -56,18 +57,63 @@ int sysfs_create_dir_ns(struct kobject *kobj, const struct ns_common *ns)
 
 	kobject_get_ownership(kobj, &uid, &gid);
 
-	kn = kernfs_create_dir_ns(parent, kobject_name(kobj), 0755, uid, gid,
-				  kobj, ns);
+	if (kobject_sd_staged(kobj))
+		kn = kernfs_create_dir_ns_staged(parent, kobject_name(kobj),
+						 0755, uid, gid, kobj, ns);
+	else
+		kn = kernfs_create_dir_ns(parent, kobject_name(kobj), 0755,
+					  uid, gid, kobj, ns);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, kobject_name(kobj));
 		return PTR_ERR(kn);
 	}
 
-	kobj->sd = kn;
+	/*
+	 * Publish the node with release semantics: every initialisation of
+	 * @kn above is ordered before the pointer store, so a task that
+	 * learns of @kobj through a synchronising handoff (registration
+	 * locks, a uevent, a notifier) observes a fully initialised node.
+	 * The kernfs staged funnel re-verifies the flags it routes on under
+	 * its mutex, so its pre-lock advisory reads decide nothing.
+	 */
+	smp_store_release(&kobj->sd, kn);
 	return 0;
 }
 
+/**
+ * sysfs_publish_dir - make a staged kobject directory visible
+ * @kobj: object whose staged directory is to be published
+ *
+ * Completes the staged creation begun by sysfs_create_dir_ns() when
+ * kobject_set_sd_staged() armed it: links the directory and everything
+ * populated beneath it into the parent and activates it in a single step.
+ * On a name collision the standard duplicate-name warning is emitted,
+ * matching sysfs_create_dir_ns().
+ *
+ * Return: 0 on success, -EEXIST on a name collision, -ENOENT if the parent
+ * went away, or -EINVAL on misuse (WARN).  On failure the subtree stays staged
+ * and is removed by the caller's normal error unwind
+ * (kobject_del()/sysfs_remove_dir()).
+ */
+int sysfs_publish_dir(struct kobject *kobj)
+{
+	int ret;
+
+	if (WARN_ON(!kobj || !kobj->sd))
+		return -EINVAL;
+
+	ret = kernfs_publish(kobj->sd);
+	if (ret == -EEXIST) {
+		struct kernfs_node *parent = kernfs_get_parent(kobj->sd);
+
+		sysfs_warn_dup(parent, kobject_name(kobj));
+		kernfs_put(parent);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_IF_KUNIT(sysfs_publish_dir);
+
 /**
  *	sysfs_remove_dir - remove an object's directory.
  *	@kobj:	object.
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 55e37a5d405e..938ff5ff747e 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -75,12 +75,37 @@ struct kobject {
 	unsigned int state_add_uevent_sent:1;
 	unsigned int state_remove_uevent_sent:1;
 	unsigned int uevent_suppress:1;
+	/* see kobject_set_sd_staged() */
+	unsigned int sd_staged:1;
 
 #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
 	struct delayed_work	release;
 #endif
 };
 
+/**
+ * kobject_set_sd_staged - arm staged sysfs directory creation
+ * @kobj: object whose directory creation mode is being set
+ * @staged: true to create the directory staged (invisible)
+ *
+ * Set before kobject_add(); read by sysfs_create_dir_ns() at add time and
+ * by the caller's publish path afterwards.  The bit is the snapshot of
+ * what sysfs honored at add time; publish paths must read it, not
+ * whatever live state armed it, so the query cannot race the
+ * registration.  The bit is never cleared: a kobject re-added after
+ * kobject_del() is staged again and requires another sysfs_publish_dir().
+ */
+static inline void kobject_set_sd_staged(struct kobject *kobj, bool staged)
+{
+	kobj->sd_staged = staged;
+}
+
+/* see kobject_set_sd_staged() */
+static inline bool kobject_sd_staged(const struct kobject *kobj)
+{
+	return kobj->sd_staged;
+}
+
 __printf(2, 3) int kobject_set_name(struct kobject *kobj, const char *name, ...);
 __printf(2, 0) int kobject_set_name_vargs(struct kobject *kobj, const char *fmt, va_list vargs);
 
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index b1a3a1e6ad09..b537a5b52e1a 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -397,6 +397,7 @@ struct sysfs_ops {
 #ifdef CONFIG_SYSFS
 
 int __must_check sysfs_create_dir_ns(struct kobject *kobj, const struct ns_common *ns);
+int __must_check sysfs_publish_dir(struct kobject *kobj);
 void sysfs_remove_dir(struct kobject *kobj);
 int __must_check sysfs_rename_dir_ns(struct kobject *kobj, const char *new_name,
 				     const struct ns_common *new_ns);
@@ -507,6 +508,11 @@ static inline int sysfs_create_dir_ns(struct kobject *kobj, const struct ns_comm
 	return 0;
 }
 
+static inline int sysfs_publish_dir(struct kobject *kobj)
+{
+	return 0;
+}
+
 static inline void sysfs_remove_dir(struct kobject *kobj)
 {
 }
-- 
2.47.3

