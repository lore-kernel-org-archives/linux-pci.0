Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD96A36B915;
	Fri, 11 Sep 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148800; cv=none; b=O0ylRXQ0+lNTt8lDpXANFg+gZDnaJ3oVrD8n2GQ7KxuWNT+nRkRoSQcPHuNPD+G/wzjjwQWeYoacCBq2jen2CiO3qGp2X6l4difE40ajZ2OqAriYGZI1DRgAM7/oz2onNBkrq1Bmtg7PeVQoLPq7cN6rZwDv8dYYvQ+MhiVwduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148800; c=relaxed/simple;
	bh=tYEEM+pqTIMxcUpu4QB6yzFG3Y9a5nUHZSyCWIQI0Ns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTyecAi4735/WuTeJPBuFWE6l2j1ac0yVYE+MEW/ow0zdib1egwCQhth4Bg/BqPVzG9ennaGBG6TgIji58HV4Uc9PsPfKlLcx0yWUNhd01off51+SgGsZftFJEKPOWF/JSlWggHMKEwq0v+X139fYj5AqwOjXN9xrgPkSNGgsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=V6xTqt6m; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="V6xTqt6m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789148797; x=1820684797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sKZ64wdWH+BmLrf29VVwFVMXgrosaMvFB76d7QnCB1I=;
  b=V6xTqt6mGHPv2Wi1s96NxuCjTJfZ/6ryMHMGrnaPu7DjwvywdgaLdAXt
   hl1XKNTtz3+9Qf3nfxDhpnzL5DKjgGj+UrnJL1lP89Ybzm5X5k/gAea+/
   Sgpi92nbRFMv6wuMDI9akHHTomp7lTUNgi6jJ5JDL9IRBYVlYtIvwkxfx
   vE+TmnT18tuP9ISPj/ZOiVrE6JkrZ3gwgSbfKaUiRjacDOdeuJUlpa8N7
   HzKCH+T9OcIntFMBZBbzbYcpXXBFTrtLY0Mqry4X3SaaF3S3GIsJrVreS
   e6Cw9OKDimfoXNv4qdmqbP06GgWYMUwu8ykL6rmP9VVDDqDquN9/0OVNU
   Q==;
X-CSE-ConnectionGUID: ikbIdqU5SNSCAo0oKN0PlQ==
X-CSE-MsgGUID: CWTblsGiRCuunVM3KEfvxQ==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28437819"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 17:46:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:13077]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.27:2525] with esmtp (Farcaster)
 id 8ce50a3e-98ee-478b-89d7-fda118f60ff4; Fri, 11 Sep 2026 17:46:34 +0000 (UTC)
X-Farcaster-Flow-ID: 8ce50a3e-98ee-478b-89d7-fda118f60ff4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 17:46:34 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 17:46:31 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo
	<tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alex Williamson
	<alex@shazbot.org>, <kvm@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 5/8] drivers: base: test: Add KUnit suite for staged sysfs registration
Date: Fri, 11 Sep 2026 19:43:37 +0200
Message-ID: <20260911174414.97060-5-sakacpav@amazon.de>
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

Add a staged_device KUnit suite under its own
CONFIG_STAGED_DEVICE_KUNIT_TEST symbol exercising the staged mechanism.
kobject_add() on a kobject with ->sd_staged builds the directory staged
but does not publish it, since only device_add() does, so the tests
drive the window directly: stage, then populate and observe, then
sysfs_publish_dir(). The cases cover publication of plain, named-group
and merged-group content, the failure modes of publication itself, abort
without publication, foreign-thread access, concurrent windows including
two that share one hashed staged mutex, glue-directory sharing, and
bus-klist membership by the time device_add() returns. The suite also
covers the KERNFS_STAGED_TOP/KERNFS_HAS_MMAP aliasing on a staged
mmap-capable bin file.

The publication-misuse cases intentionally trigger the publication
guards' WARN backtraces, and the duplicate-name cases trigger
sysfs_warn_dup() splats: those backtraces are expected output of a
passing run, not failures. The suite is therefore unsuitable for
runners that set panic_on_warn, which turns the first intentional splat
into a panic, and does not follow KUNIT_ALL_TESTS: it runs only when its
symbol is enabled explicitly.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/base/test/.kunitconfig         |    1 +
 drivers/base/test/Kconfig              |   12 +
 drivers/base/test/Makefile             |    1 +
 drivers/base/test/staged-device-test.c | 1042 ++++++++++++++++++++++++
 4 files changed, 1056 insertions(+)
 create mode 100644 drivers/base/test/staged-device-test.c

diff --git a/drivers/base/test/.kunitconfig b/drivers/base/test/.kunitconfig
index 28322bad39a7..3766972a2e84 100644
--- a/drivers/base/test/.kunitconfig
+++ b/drivers/base/test/.kunitconfig
@@ -1,3 +1,4 @@
 CONFIG_KUNIT=y
 CONFIG_DM_KUNIT_TEST=y
 CONFIG_GLUE_DIR_KUNIT_TEST=y
+CONFIG_STAGED_DEVICE_KUNIT_TEST=y
diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 253b5bd96aff..0b32e6ca2e12 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -36,3 +36,15 @@ config GLUE_DIR_KUNIT_TEST
 	  not a glue directory is never mistaken for one.
 
 	  If unsure say N.
+
+config STAGED_DEVICE_KUNIT_TEST
+	tristate "KUnit Tests for staged device registration" if !KUNIT_ALL_TESTS
+	depends on KUNIT && SYSFS
+	help
+	  Enable this option to test staged sysfs device registration and
+	  publication.
+
+	  Some cases intentionally exercise warning and duplicate-name paths;
+	  do not run this suite with panic_on_warn.
+
+	  If unsure, say N.
diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index f13f0c399bea..2e6dbb56fb7b 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
 
 obj-$(CONFIG_DM_KUNIT_TEST)	+= root-device-test.o
 obj-$(CONFIG_DM_KUNIT_TEST)	+= platform-device-test.o
+obj-$(CONFIG_STAGED_DEVICE_KUNIT_TEST)	+= staged-device-test.o
 
 obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
 CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/base/test/staged-device-test.c b/drivers/base/test/staged-device-test.c
new file mode 100644
index 000000000000..d32f00214a8b
--- /dev/null
+++ b/drivers/base/test/staged-device-test.c
@@ -0,0 +1,1042 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for staged sysfs directory registration.
+ *
+ * The mechanism lives below the sysfs population layer: a kobject opted in
+ * with ->sd_staged has its directory built staged (invisible, off the sysfs
+ * root lock) and published in one step.  kobject_add() creates the staged
+ * directory but does NOT publish it (only device_add() does), which gives
+ * these tests direct control over the window: stage -> populate/observe ->
+ * sysfs_publish_dir().
+ */
+
+#include <kunit/resource.h>
+#include <kunit/test.h>
+
+#include <linux/device.h>
+#include <linux/hash.h>
+#include <linux/kobject.h>
+#include <linux/kernfs.h>
+#include <linux/kthread.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+/* A minimal kobject type usable as a staged directory. */
+
+struct staged_kobj {
+	struct kobject kobj;
+};
+
+static ssize_t staged_attr_show(struct kobject *kobj, struct attribute *attr,
+				char *buf)
+{
+	return 0;
+}
+
+static const struct sysfs_ops staged_sysfs_ops = {
+	.show = staged_attr_show,
+};
+
+static void staged_kobj_release(struct kobject *kobj)
+{
+	/* frees the container; no caller frees a kobject-embedding struct */
+	kfree(container_of(kobj, struct staged_kobj, kobj));
+}
+
+static const struct kobj_type staged_ktype = {
+	.sysfs_ops = &staged_sysfs_ops,
+	.release = staged_kobj_release,
+};
+
+struct staged_test_priv {
+	struct kobject *parent;		/* published parent for staged kids */
+};
+
+/* Is @parent's staged bit set on its kernfs node? */
+static bool sd_is_staged(struct kobject *kobj)
+{
+	return kobj->sd && (kobj->sd->flags & KERNFS_STAGED);
+}
+
+/* subdir count of a kobject's kernfs directory (parent accounting) */
+static unsigned long sd_subdirs(struct kobject *kobj)
+{
+	return kobj->sd ? kobj->sd->dir.subdirs : 0;
+}
+
+/* Does a visible child @name exist under @parent (goes through the funnel)? */
+static bool child_visible(struct kobject *parent, const char *name)
+{
+	struct kernfs_node *kn = kernfs_find_and_get(parent->sd, name);
+	bool found = !!kn;
+
+	kernfs_put(kn);
+	return found;
+}
+
+/*
+ * Allocate a staged child kobject.  It is freed by staged_kobj_release() when
+ * its last reference is dropped (kobject_put()); nothing frees it directly, so
+ * the deferred release under CONFIG_DEBUG_KOBJECT_RELEASE is safe.
+ */
+static struct kobject *staged_child_alloc(struct kunit *test)
+{
+	struct staged_kobj *sk;
+
+	sk = kzalloc_obj(*sk);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sk);
+
+	kobject_init(&sk->kobj, &staged_ktype);
+	kobject_set_sd_staged(&sk->kobj, true);
+	return &sk->kobj;
+}
+
+/* Add @n plain attribute files to a (staged) kobject; names attr0..attrN-1. */
+static int staged_add_files(struct kunit *test, struct kobject *kobj, int n)
+{
+	int i, ret;
+
+	for (i = 0; i < n; i++) {
+		struct attribute *a = kunit_kzalloc(test, sizeof(*a), GFP_KERNEL);
+		char *nm;
+
+		if (!a)
+			return -ENOMEM;
+		sysfs_attr_init(a);
+		nm = kunit_kmalloc(test, 16, GFP_KERNEL);
+		if (!nm)
+			return -ENOMEM;
+		snprintf(nm, 16, "attr%d", i);
+		a->name = nm;
+		a->mode = 0644;
+		ret = sysfs_create_file(kobj, a);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int staged_test_init(struct kunit *test)
+{
+	struct staged_test_priv *priv;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	priv->parent = kobject_create_and_add("staged_kunit", kernel_kobj);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->parent);
+
+	test->priv = priv;
+	return 0;
+}
+
+static void staged_test_exit(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+
+	if (priv && priv->parent)
+		kobject_put(priv->parent);
+}
+
+/*
+ * End-to-end publish; the merged group is the sysfs_merge_group() case,
+ * which dereferences kobj->sd while the directory is still staged.
+ */
+static struct attribute grp_attr = { .name = "grp_attr", .mode = 0644 };
+static struct attribute *named_grp_attrs[] = { &grp_attr, NULL };
+static const struct attribute_group named_grp = {
+	.name = "ngroup",
+	.attrs = named_grp_attrs,
+};
+
+static struct attribute merge_attr = { .name = "merged", .mode = 0644 };
+static struct attribute *merge_attrs[] = { &merge_attr, NULL };
+static const struct attribute_group merge_grp = {
+	.name = "ngroup",
+	.attrs = merge_attrs,
+};
+
+static void staged_test_publish_end_to_end(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+	struct kobject *kobj = staged_child_alloc(test);
+	unsigned long parent_subdirs = sd_subdirs(priv->parent);
+	struct kernfs_node *ngroup_kn, *merged_kn;
+	int ret;
+
+	ret = kobject_add(kobj, priv->parent, "end_to_end");
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_TRUE(test, sd_is_staged(kobj));
+	KUNIT_EXPECT_FALSE(test, child_visible(priv->parent, "end_to_end"));
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), parent_subdirs);
+
+	ret = sysfs_create_file(kobj, &grp_attr);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	ret = sysfs_create_group(kobj, &named_grp);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	ret = sysfs_merge_group(kobj, &merge_grp);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret = sysfs_publish_dir(kobj);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_FALSE(test, sd_is_staged(kobj));
+	KUNIT_EXPECT_TRUE(test, child_visible(priv->parent, "end_to_end"));
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), parent_subdirs + 1);
+	KUNIT_EXPECT_TRUE(test, child_visible(kobj, "grp_attr"));
+	KUNIT_EXPECT_TRUE(test, child_visible(kobj, "ngroup"));
+
+	/* the merged attr lives under ngroup/, not at the top level */
+	ngroup_kn = kernfs_find_and_get(kobj->sd, "ngroup");
+	KUNIT_ASSERT_NOT_NULL(test, ngroup_kn);
+	merged_kn = kernfs_find_and_get(ngroup_kn, "merged");
+	KUNIT_EXPECT_NOT_NULL(test, merged_kn);
+	kernfs_put(merged_kn);
+	kernfs_put(ngroup_kn);
+
+	sysfs_unmerge_group(kobj, &merge_grp);
+	sysfs_remove_group(kobj, &named_grp);
+	sysfs_remove_file(kobj, &grp_attr);
+	kobject_del(kobj);
+	kobject_put(kobj);
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), parent_subdirs);
+}
+
+/*
+ * Duplicate name: two staged children with the same name.  The first
+ * publishes; the second fails -EEXIST at publication and tears down cleanly,
+ * leaving the winner and the parent undisturbed.
+ */
+static void staged_test_duplicate_name(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+	struct kobject *win = staged_child_alloc(test);
+	struct kobject *lose = staged_child_alloc(test);
+	unsigned long base = sd_subdirs(priv->parent);
+	int ret;
+
+	KUNIT_ASSERT_EQ(test, kobject_add(win, priv->parent, "dup"), 0);
+	KUNIT_ASSERT_EQ(test, sysfs_publish_dir(win), 0);
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), base + 1);
+
+	/* second staged dir, same name, only fails at publish */
+	KUNIT_ASSERT_EQ(test, kobject_add(lose, priv->parent, "dup"), 0);
+	ret = sysfs_publish_dir(lose);
+	KUNIT_EXPECT_EQ(test, ret, -EEXIST);
+
+	/* winner undisturbed; parent gained exactly one child */
+	KUNIT_EXPECT_TRUE(test, child_visible(priv->parent, "dup"));
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), base + 1);
+
+	kobject_del(lose);		/* tear down the staged loser */
+	kobject_put(lose);
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), base + 1);
+
+	kobject_del(win);
+	kobject_put(win);
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), base);
+}
+
+/*
+ * kernfs_publish() rejects (WARN, -EINVAL) a staged top whose parent is
+ * itself still staged: a staged parent's children are serialized by a
+ * different subtree mutex, so publication into it is misuse.  Outside-in
+ * order -- the parent first, then the child -- publishes both.
+ */
+static void staged_test_publish_staged_parent(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+	struct kobject *outer = staged_child_alloc(test);
+	struct kobject *inner = staged_child_alloc(test);
+
+	KUNIT_ASSERT_EQ(test, kobject_add(outer, priv->parent, "outer"), 0);
+
+	/* a staged top of its own, under the still-staged outer */
+	KUNIT_ASSERT_EQ(test, kobject_add(inner, outer, "inner"), 0);
+
+	KUNIT_EXPECT_EQ(test, sysfs_publish_dir(inner), -EINVAL);
+
+	/* outside-in publication order works */
+	KUNIT_EXPECT_EQ(test, sysfs_publish_dir(outer), 0);
+	KUNIT_EXPECT_EQ(test, sysfs_publish_dir(inner), 0);
+	KUNIT_EXPECT_TRUE(test, child_visible(outer, "inner"));
+
+	kobject_del(inner);
+	kobject_put(inner);
+	kobject_del(outer);
+	kobject_put(outer);
+}
+
+/*
+ * kernfs_publish() rejects (WARN, -EINVAL) a node that is no longer staged:
+ * a second publication of an already-published directory fails and leaves
+ * the published directory undisturbed.
+ */
+static void staged_test_publish_twice(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+	struct kobject *kobj = staged_child_alloc(test);
+
+	KUNIT_ASSERT_EQ(test, kobject_add(kobj, priv->parent, "twice"), 0);
+	KUNIT_ASSERT_EQ(test, staged_add_files(test, kobj, 2), 0);
+	KUNIT_ASSERT_EQ(test, sysfs_publish_dir(kobj), 0);
+
+	/* no longer staged: a second publication is misuse */
+	KUNIT_EXPECT_EQ(test, sysfs_publish_dir(kobj), -EINVAL);
+
+	/* the published directory is undisturbed */
+	KUNIT_EXPECT_FALSE(test, sd_is_staged(kobj));
+	KUNIT_EXPECT_TRUE(test, child_visible(priv->parent, "twice"));
+	KUNIT_EXPECT_TRUE(test, child_visible(kobj, "attr0"));
+
+	kobject_del(kobj);
+	kobject_put(kobj);
+}
+
+/*
+ * Never called: a staged file cannot be opened, and the case never mmaps
+ * the file after publication either.
+ */
+static int staged_mmap_stub(struct file *file, struct kobject *kobj,
+			    const struct bin_attribute *attr,
+			    struct vm_area_struct *vma)
+{
+	return -ENODEV;
+}
+
+static const struct bin_attribute mmap_file_attr = {
+	.attr	= { .name = "mmap_file", .mode = 0444 },
+	.size	= PAGE_SIZE,
+	.mmap	= staged_mmap_stub,
+};
+
+/*
+ * KERNFS_STAGED_TOP aliases KERNFS_HAS_MMAP in one flag bit, and publication
+ * and teardown clear KERNFS_STAGED_TOP only on directories -- so a FILE's
+ * aliased HAS_MMAP must never be disturbed.  A staged mmap-capable bin file
+ * carries KERNFS_HAS_MMAP from creation, and publication's DIR-gated clear
+ * mask strips KERNFS_STAGED from it while leaving KERNFS_HAS_MMAP intact.
+ */
+static void staged_test_mmap_file_alias(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+	struct kobject *kobj = staged_child_alloc(test);
+	struct kernfs_node *kn, *fresh;
+
+	KUNIT_ASSERT_EQ(test, kobject_add(kobj, priv->parent, "mmap_alias"), 0);
+	KUNIT_ASSERT_EQ(test, sysfs_create_bin_file(kobj, &mmap_file_attr), 0);
+
+	/* in the window: HAS_MMAP from creation, STAGED from the subtree */
+	kn = kernfs_find_and_get(kobj->sd, "mmap_file");
+	KUNIT_ASSERT_NOT_NULL(test, kn);
+	KUNIT_EXPECT_EQ(test, kernfs_type(kn), KERNFS_FILE);
+	KUNIT_EXPECT_TRUE(test, kn->flags & KERNFS_HAS_MMAP);
+	KUNIT_EXPECT_TRUE(test, kn->flags & KERNFS_STAGED);
+
+	KUNIT_ASSERT_EQ(test, sysfs_publish_dir(kobj), 0);
+
+	/* same node: STAGED stripped, aliased HAS_MMAP survived the clear */
+	KUNIT_EXPECT_TRUE(test, kn->flags & KERNFS_HAS_MMAP);
+	KUNIT_EXPECT_FALSE(test, kn->flags & KERNFS_STAGED);
+
+	/* and the file is reachable post-publish */
+	fresh = kernfs_find_and_get(kobj->sd, "mmap_file");
+	KUNIT_EXPECT_PTR_EQ(test, fresh, kn);
+	kernfs_put(fresh);
+	kernfs_put(kn);
+
+	sysfs_remove_bin_file(kobj, &mmap_file_attr);
+	kobject_del(kobj);
+	kobject_put(kobj);
+}
+
+/* A foreign task acts on the staged directory. */
+
+struct foreign_ctx {
+	struct kobject *kobj;
+	struct attribute *new_attr;	/* file the foreign task creates */
+	struct attribute *rm_attr;	/* file (we created) it removes */
+	const char *notify_name;	/* a live staged attr to notify */
+	int create_ret;			/* sysfs_create_file() return */
+	bool notify_target_present;	/* the notified attr was findable */
+	struct completion done;
+};
+
+static int foreign_fn(void *data)
+{
+	struct foreign_ctx *c = data;
+	struct kernfs_node *kn;
+
+	c->create_ret = sysfs_create_file(c->kobj, c->new_attr);
+	sysfs_remove_file(c->kobj, c->rm_attr);
+
+	/*
+	 * Notify a LIVE staged attribute (the one just created) so
+	 * kernfs_notify actually runs against a staged node; record that it
+	 * was findable.
+	 */
+	kn = kernfs_find_and_get(c->kobj->sd, c->notify_name);
+	c->notify_target_present = !!kn;
+	kernfs_put(kn);
+	sysfs_notify(c->kobj, NULL, c->notify_name);
+
+	complete(&c->done);
+	return 0;
+}
+
+static void staged_test_foreign_task(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+	struct kobject *kobj = staged_child_alloc(test);
+	struct task_struct *t;
+	struct foreign_ctx c = {};
+	long rc;
+
+	c.kobj = kobj;
+	c.new_attr = kunit_kzalloc(test, sizeof(*c.new_attr), GFP_KERNEL);
+	c.rm_attr = kunit_kzalloc(test, sizeof(*c.rm_attr), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, c.new_attr);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, c.rm_attr);
+	sysfs_attr_init(c.new_attr);
+	sysfs_attr_init(c.rm_attr);
+	c.new_attr->name = "foreign_new";
+	c.new_attr->mode = 0644;
+	c.rm_attr->name = "to_remove";
+	c.rm_attr->mode = 0644;
+	c.notify_name = "foreign_new";
+	init_completion(&c.done);
+
+	KUNIT_ASSERT_EQ(test, kobject_add(kobj, priv->parent, "foreign"), 0);
+	/* we create the file the foreign task will remove */
+	KUNIT_ASSERT_EQ(test, sysfs_create_file(kobj, c.rm_attr), 0);
+
+	t = kthread_run(foreign_fn, &c, "staged_foreign");
+	KUNIT_ASSERT_FALSE(test, IS_ERR(t));
+
+	rc = wait_for_completion_timeout(&c.done, msecs_to_jiffies(10000));
+	if (!rc)
+		wait_for_completion(&c.done);	/* join before reading ctx */
+	KUNIT_EXPECT_GT(test, rc, 0);
+
+	/* foreign create succeeded; the notified attribute was a live node */
+	KUNIT_EXPECT_EQ(test, c.create_ret, 0);
+	KUNIT_EXPECT_TRUE(test, c.notify_target_present);
+
+	KUNIT_ASSERT_EQ(test, sysfs_publish_dir(kobj), 0);
+
+	/* after publish: created file present, removed file absent */
+	KUNIT_EXPECT_TRUE(test, child_visible(kobj, "foreign_new"));
+	KUNIT_EXPECT_FALSE(test, child_visible(kobj, "to_remove"));
+
+	sysfs_remove_file(kobj, c.new_attr);
+	kobject_del(kobj);
+	kobject_put(kobj);
+}
+
+/*
+ * Abort without publication, twice in a row.  Leak-observable: the parent
+ * kernfs node's subdir count and its base refcount return to their
+ * pre-registration values after each aborted, torn-down window.
+ */
+static void staged_test_abort_twice(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+	unsigned long base_subdirs = sd_subdirs(priv->parent);
+	int base_count = atomic_read(&priv->parent->sd->count);
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct kobject *kobj = staged_child_alloc(test);
+
+		KUNIT_ASSERT_EQ(test, kobject_add(kobj, priv->parent, "abort"), 0);
+		KUNIT_ASSERT_EQ(test, staged_add_files(test, kobj, 10), 0);
+		KUNIT_EXPECT_TRUE(test, sd_is_staged(kobj));
+
+		/* abort: tear down without publishing */
+		kobject_del(kobj);
+		kobject_put(kobj);
+
+		/* leak-observable: parent fully restored */
+		KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), base_subdirs);
+		KUNIT_EXPECT_EQ(test, atomic_read(&priv->parent->sd->count),
+				base_count);
+	}
+}
+
+/*
+ * Partial abort: create then remove a named group inside the window; publish;
+ * the removed group is absent, other content present.
+ */
+static void staged_test_partial_group_abort(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+	struct kobject *kobj = staged_child_alloc(test);
+
+	KUNIT_ASSERT_EQ(test, kobject_add(kobj, priv->parent, "partial"), 0);
+	KUNIT_ASSERT_EQ(test, sysfs_create_group(kobj, &named_grp), 0);
+	KUNIT_ASSERT_EQ(test, sysfs_create_file(kobj, &grp_attr), 0);
+
+	/* remove the group again, still in the window */
+	sysfs_remove_group(kobj, &named_grp);
+
+	KUNIT_ASSERT_EQ(test, sysfs_publish_dir(kobj), 0);
+	KUNIT_EXPECT_FALSE(test, child_visible(kobj, "ngroup"));
+	KUNIT_EXPECT_TRUE(test, child_visible(kobj, "grp_attr"));
+
+	sysfs_remove_file(kobj, &grp_attr);
+	kobject_del(kobj);
+	kobject_put(kobj);
+}
+
+/*
+ * Parent removed during the window: publication fails -ENOENT and the orphan
+ * tears down cleanly.
+ */
+static void staged_test_parent_removed(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+	struct kobject *mid, *kobj;
+	int ret;
+
+	/* an intermediate published parent we can remove mid-window */
+	mid = kobject_create_and_add("mid", priv->parent);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mid);
+
+	kobj = staged_child_alloc(test);
+	KUNIT_ASSERT_EQ(test, kobject_add(kobj, mid, "orphan"), 0);
+	KUNIT_ASSERT_EQ(test, staged_add_files(test, kobj, 4), 0);
+
+	/* remove the parent while the child is still staged */
+	kobject_del(mid);
+
+	ret = sysfs_publish_dir(kobj);
+	KUNIT_EXPECT_EQ(test, ret, -ENOENT);
+
+	/* orphan tears down cleanly */
+	kobject_del(kobj);
+	kobject_put(kobj);
+	kobject_put(mid);
+}
+
+/*
+ * O(1) shared-parent cost: a staged directory with >= 20 nodes is built
+ * without a single link into the parent's children collection: the parent's
+ * subdir count is unchanged across the whole population and rises by exactly
+ * one at publish, independent of node count.
+ */
+static void staged_test_o1_root_cost(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+	struct kobject *kobj = staged_child_alloc(test);
+	unsigned long base = sd_subdirs(priv->parent);
+
+	KUNIT_ASSERT_EQ(test, kobject_add(kobj, priv->parent, "o1cost"), 0);
+	KUNIT_ASSERT_EQ(test, staged_add_files(test, kobj, 25), 0);
+
+	/* 25 nodes added, zero links into the shared parent */
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), base);
+	KUNIT_EXPECT_FALSE(test, child_visible(priv->parent, "o1cost"));
+
+	KUNIT_ASSERT_EQ(test, sysfs_publish_dir(kobj), 0);
+	/* exactly one link at publish, regardless of the 25 nodes */
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), base + 1);
+	KUNIT_EXPECT_TRUE(test, child_visible(kobj, "attr0"));
+	KUNIT_EXPECT_TRUE(test, child_visible(kobj, "attr24"));
+
+	kobject_del(kobj);
+	kobject_put(kobj);
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), base);
+}
+
+/* Two concurrent windows. */
+
+#define WINDOW_NODES 50
+
+struct window_ctx {
+	struct kobject *parent;
+	const char *name;
+	int add_ret;
+	int publish_ret;
+	struct completion done;
+};
+
+static int window_fn(void *data)
+{
+	struct window_ctx *w = data;
+	struct attribute *attrs[WINDOW_NODES] = {};
+	struct staged_kobj *sk;
+	struct kobject *kobj;
+	int i;
+
+	sk = kzalloc_obj(*sk);
+	if (!sk) {
+		w->add_ret = -ENOMEM;
+		complete(&w->done);
+		return 0;
+	}
+	kobject_init(&sk->kobj, &staged_ktype);
+	kobject_set_sd_staged(&sk->kobj, true);
+	kobj = &sk->kobj;
+
+	w->add_ret = kobject_add(kobj, w->parent, "%s", w->name);
+	if (w->add_ret) {
+		kobject_put(kobj);	/* release frees the container */
+		complete(&w->done);
+		return 0;
+	}
+
+	for (i = 0; i < WINDOW_NODES; i++) {
+		struct attribute *a = kzalloc_obj(*a);
+
+		if (!a)
+			break;
+		sysfs_attr_init(a);
+		a->name = kasprintf(GFP_KERNEL, "attr%d", i);
+		a->mode = 0644;
+		if (sysfs_create_file(kobj, a)) {
+			kfree((void *)a->name);
+			kfree(a);
+			break;
+		}
+		attrs[i] = a;
+	}
+
+	w->publish_ret = sysfs_publish_dir(kobj);
+
+	kobject_del(kobj);
+	kobject_put(kobj);		/* release frees the container */
+
+	/* attributes outlive their files; free them after teardown */
+	for (i = 0; i < WINDOW_NODES; i++) {
+		if (!attrs[i])
+			continue;
+		kfree((void *)attrs[i]->name);
+		kfree(attrs[i]);
+	}
+
+	complete(&w->done);
+	return 0;
+}
+
+static void staged_test_two_windows(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+	struct window_ctx w1 = { .parent = priv->parent, .name = "winA" };
+	struct window_ctx w2 = { .parent = priv->parent, .name = "winB" };
+	struct task_struct *t1, *t2;
+	long r1, r2;
+
+	init_completion(&w1.done);
+	init_completion(&w2.done);
+
+	t1 = kthread_run(window_fn, &w1, "staged_winA");
+	/* nothing spawned yet if this aborts */
+	KUNIT_ASSERT_FALSE(test, IS_ERR(t1));
+	t2 = kthread_run(window_fn, &w2, "staged_winB");
+	KUNIT_EXPECT_FALSE(test, IS_ERR(t2));
+	if (IS_ERR(t2)) {
+		/* t1 writes on-stack w1: join it before returning */
+		wait_for_completion(&w1.done);
+		return;
+	}
+
+	/* no deadlock within the timeout */
+	r1 = wait_for_completion_timeout(&w1.done, msecs_to_jiffies(10000));
+	r2 = wait_for_completion_timeout(&w2.done, msecs_to_jiffies(10000));
+	/* join both before touching the on-stack contexts they write to */
+	if (!r1)
+		wait_for_completion(&w1.done);
+	if (!r2)
+		wait_for_completion(&w2.done);
+	KUNIT_EXPECT_GT(test, r1, 0);
+	KUNIT_EXPECT_GT(test, r2, 0);
+
+	KUNIT_EXPECT_EQ(test, w1.add_ret, 0);
+	KUNIT_EXPECT_EQ(test, w2.add_ret, 0);
+	KUNIT_EXPECT_EQ(test, w1.publish_ret, 0);
+	KUNIT_EXPECT_EQ(test, w2.publish_ret, 0);
+}
+
+/* Staged registration through device_add(). */
+
+static void staged_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static void staged_dev_unregister(void *data)
+{
+	device_unregister(data);
+}
+
+static void staged_root_unregister(void *data)
+{
+	root_device_unregister(data);
+}
+
+/*
+ * Allocate and initialize a device for device_add(); @staged opts it in to the
+ * staged path.  Freed by staged_dev_release() when the last reference drops;
+ * nothing frees it directly.
+ */
+static struct device *staged_dev_alloc(struct kunit *test,
+				       struct device *parent,
+				       const struct bus_type *bus,
+				       const char *name, bool staged)
+{
+	struct device *dev;
+	int ret;
+
+	dev = kzalloc_obj(*dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	device_initialize(dev);
+	dev->parent = parent;
+	dev->bus = bus;
+	dev->release = staged_dev_release;
+	if (staged)
+		dev_set_sysfs_staged(dev);
+
+	ret = dev_set_name(dev, "%s", name);
+	if (ret)
+		put_device(dev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	return dev;
+}
+
+/* Staged registration under a class glue directory. */
+
+static void staged_class_destroy(void *data)
+{
+	class_destroy(data);
+}
+
+/*
+ * Register a staged class device with a NULL parent; it lands under the
+ * class glue directory in /sys/devices/virtual/.  Unregistered by a deferred
+ * kunit action (released early where a test removes it mid-flight).
+ */
+static struct device *staged_class_dev_add(struct kunit *test,
+					   const struct class *class,
+					   const char *name)
+{
+	struct device *dev;
+	int ret;
+
+	dev = staged_dev_alloc(test, NULL, NULL, name, true);
+	dev->class = class;
+
+	ret = device_add(dev);
+	if (ret)
+		put_device(dev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_dev_unregister,
+							dev), 0);
+	return dev;
+}
+
+/*
+ * Staged registration under a class glue directory.  Two staged class
+ * devices share one glue dir; removing one sibling must not reap the
+ * shared glue dir under the other (cleanup_glue_dir() sees the survivor's
+ * glue-dir reference, kref >= 2), and once the last child is gone the
+ * reaped glue dir must be recreatable by a further staged registration.
+ */
+static struct attribute glue_attr = { .name = "glue_attr", .mode = 0644 };
+
+static void staged_test_glue_dir(struct kunit *test)
+{
+	struct device *dev_a, *dev_b, *dev_a2;
+	struct class *class;
+
+	class = class_create("staged_kunit_class");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, class);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_class_destroy,
+							class), 0);
+
+	/* two staged children of the same (new) glue directory */
+	dev_a = staged_class_dev_add(test, class, "glueA");
+	dev_b = staged_class_dev_add(test, class, "glueB");
+	KUNIT_ASSERT_NOT_NULL(test, dev_a->kobj.sd);
+	KUNIT_ASSERT_NOT_NULL(test, dev_b->kobj.sd);
+	KUNIT_EXPECT_PTR_EQ(test, dev_a->kobj.parent, dev_b->kobj.parent);
+
+	/*
+	 * The glue dir itself is not staged: glue dirs are created eagerly.
+	 * This case cannot observe the inside of the window -- device_add()
+	 * opens and closes it internally; the kobject-level cases above
+	 * cover the window itself.
+	 */
+	KUNIT_EXPECT_TRUE(test, kobject_sd_staged(&dev_a->kobj));
+	KUNIT_EXPECT_TRUE(test, kobject_sd_staged(&dev_b->kobj));
+	KUNIT_EXPECT_FALSE(test, sd_is_staged(&dev_a->kobj));
+	KUNIT_EXPECT_FALSE(test, sd_is_staged(&dev_b->kobj));
+	KUNIT_EXPECT_FALSE(test, sd_is_staged(dev_a->kobj.parent));
+	KUNIT_EXPECT_TRUE(test, child_visible(dev_a->kobj.parent, "glueA"));
+	KUNIT_EXPECT_TRUE(test, child_visible(dev_b->kobj.parent, "glueB"));
+
+	/* sibling removal must not reap the glue dir under dev_b */
+	kunit_release_action(test, staged_dev_unregister, dev_a);
+	KUNIT_ASSERT_NOT_NULL(test, dev_b->kobj.sd);
+	KUNIT_EXPECT_TRUE(test, child_visible(dev_b->kobj.parent, "glueB"));
+	KUNIT_EXPECT_EQ(test, sysfs_create_file(&dev_b->kobj, &glue_attr), 0);
+	KUNIT_EXPECT_TRUE(test, child_visible(&dev_b->kobj, "glue_attr"));
+	sysfs_remove_file(&dev_b->kobj, &glue_attr);
+
+	/* last child gone: the glue dir is reaped ... */
+	kunit_release_action(test, staged_dev_unregister, dev_b);
+
+	/* ... and a staged re-registration under A's name recreates it */
+	dev_a2 = staged_class_dev_add(test, class, "glueA");
+	KUNIT_EXPECT_NOT_NULL(test, dev_a2->kobj.sd);
+	KUNIT_EXPECT_FALSE(test, sd_is_staged(&dev_a2->kobj));
+}
+
+/*
+ * device_add() staged bracket, error unwind.  A staged device whose name
+ * collides with a live sibling only fails at publication, deep inside
+ * device_add().  The failure must unwind the whole bracket: the caller sees the
+ * error, the failed device keeps no kernfs node, the collision winner and the
+ * parent are undisturbed, the last reference frees the device, and a fresh
+ * staged registration under a free name still succeeds afterwards.
+ */
+static void staged_test_device_add_unwind(struct kunit *test)
+{
+	struct device *root, *eager, *staged, *retry;
+	struct kernfs_node *kn;
+	unsigned long base;
+	int ret;
+
+	root = root_device_register("staged_kunit_unwind");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, root);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_root_unregister,
+							root), 0);
+
+	/* the collision winner, registered eagerly */
+	eager = staged_dev_alloc(test, root, NULL, "collide", false);
+	KUNIT_ASSERT_EQ(test, device_add(eager), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_dev_unregister,
+							eager), 0);
+	base = sd_subdirs(&root->kobj);
+
+	/* same name, staged: the directory is built, publication collides */
+	staged = staged_dev_alloc(test, root, NULL, "collide", true);
+	ret = device_add(staged);
+	KUNIT_ASSERT_EQ(test, ret, -EEXIST);
+
+	/* unwound: no kernfs node left on the failed device */
+	KUNIT_EXPECT_NULL(test, staged->kobj.sd);
+
+	/* no residue under the parent; the winner is what remains */
+	KUNIT_EXPECT_EQ(test, sd_subdirs(&root->kobj), base);
+	kn = kernfs_find_and_get(root->kobj.sd, "collide");
+	KUNIT_EXPECT_PTR_EQ(test, kn, eager->kobj.sd);
+	kernfs_put(kn);
+
+	/* the failed device's last reference frees it */
+	put_device(staged);
+
+	/* a fresh staged registration under a free name still succeeds */
+	retry = staged_dev_alloc(test, root, NULL, "retry", true);
+	KUNIT_ASSERT_EQ(test, device_add(retry), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_dev_unregister,
+							retry), 0);
+	KUNIT_EXPECT_FALSE(test, sd_is_staged(&retry->kobj));
+	KUNIT_EXPECT_TRUE(test, child_visible(&root->kobj, "retry"));
+	KUNIT_EXPECT_EQ(test, sd_subdirs(&root->kobj), base + 1);
+}
+
+/* Deferred bus-klist insertion, on a real bus with a real driver. */
+
+static const struct bus_type staged_test_bus = {
+	.name = "staged_kunit_bus",
+};
+
+static int staged_test_driver_probe(struct device *dev)
+{
+	return 0;
+}
+
+static struct device_driver staged_test_driver = {
+	.name = "staged_kunit_drv",
+	.bus = &staged_test_bus,
+	.owner = THIS_MODULE,
+	.probe = staged_test_driver_probe,
+};
+
+static void staged_bus_unregister(void *data)
+{
+	bus_unregister(data);
+}
+
+static void staged_driver_unregister(void *data)
+{
+	driver_unregister(data);
+}
+
+struct staged_bus_scan {
+	struct device *want;
+	unsigned int seen;
+	bool found;
+};
+
+static int staged_bus_scan_fn(struct device *dev, void *data)
+{
+	struct staged_bus_scan *scan = data;
+
+	scan->seen++;
+	if (dev == scan->want)
+		scan->found = true;
+	return 0;
+}
+
+/*
+ * bus_add_device() keeps a staged device off the bus klist -- the one
+ * driver_attach() walks -- until publication, and device_add() inserts it via
+ * bus_add_device_publish() before anything can observe the device.  Assert the
+ * outcome that a regression in that gating would destroy: once device_add()
+ * returns, the device is on the klist that bus_for_each_dev() walks, and the
+ * driver has actually bound to it.
+ */
+static void staged_test_bus_klist(struct kunit *test)
+{
+	struct staged_bus_scan scan = {};
+	struct device *dev;
+
+	KUNIT_ASSERT_EQ(test, bus_register(&staged_test_bus), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_bus_unregister,
+							(void *)&staged_test_bus), 0);
+
+	KUNIT_ASSERT_EQ(test, driver_register(&staged_test_driver), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_driver_unregister,
+							&staged_test_driver), 0);
+
+	dev = staged_dev_alloc(test, NULL, &staged_test_bus, "busdev", true);
+	KUNIT_ASSERT_EQ(test, device_add(dev), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_dev_unregister,
+							dev), 0);
+
+	/* opted in, and published by the time device_add() returned */
+	KUNIT_EXPECT_TRUE(test, kobject_sd_staged(&dev->kobj));
+	KUNIT_EXPECT_FALSE(test, sd_is_staged(&dev->kobj));
+
+	/* the deferred klist insertion happened: the bus walkers see it */
+	scan.want = dev;
+	KUNIT_ASSERT_EQ(test, bus_for_each_dev(&staged_test_bus, NULL, &scan,
+					       staged_bus_scan_fn), 0);
+	KUNIT_EXPECT_TRUE(test, scan.found);
+	KUNIT_EXPECT_EQ(test, scan.seen, 1u);
+
+	/* ... and driver binding actually ran against it */
+	KUNIT_EXPECT_PTR_EQ(test, dev->driver, &staged_test_driver);
+}
+
+/*
+ * Hashed staged-mutex slot aliasing.  Open one more coexisting staged window
+ * than the hashed mutex array has slots, so by pigeonhole at least two staged
+ * tops share one mutex.  Aliasing must not confuse kernfs_staged_lock()'s
+ * owning-subtree identification: every window must populate, publish and come
+ * out complete.  The collision is asserted rather than assumed -- the slot
+ * index is the same pure function of the node address that
+ * kernfs_staged_mutex_ptr() uses.
+ */
+#define STAGED_SLOT_WINDOWS	(NR_KERNFS_LOCKS + 1)
+
+static void staged_test_hashed_slot_collision(struct kunit *test)
+{
+	struct staged_test_priv *priv = test->priv;
+	unsigned long base = sd_subdirs(priv->parent);
+	struct kobject **kids;
+	unsigned int *slots;
+	bool collided = false;
+	int i, j;
+
+	kids = kunit_kcalloc(test, STAGED_SLOT_WINDOWS, sizeof(*kids), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kids);
+	slots = kunit_kcalloc(test, STAGED_SLOT_WINDOWS, sizeof(*slots), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, slots);
+
+	for (i = 0; i < STAGED_SLOT_WINDOWS; i++) {
+		kids[i] = staged_child_alloc(test);
+		KUNIT_ASSERT_EQ(test, kobject_add(kids[i], priv->parent,
+						  "slot%d", i), 0);
+		KUNIT_ASSERT_TRUE(test, sd_is_staged(kids[i]));
+		KUNIT_ASSERT_EQ(test, staged_add_files(test, kids[i], 2), 0);
+		slots[i] = hash_ptr(kids[i]->sd, NR_KERNFS_LOCK_BITS);
+	}
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), base);
+
+	/* pigeonhole: NR_KERNFS_LOCKS + 1 tops over NR_KERNFS_LOCKS slots */
+	for (i = 0; i < STAGED_SLOT_WINDOWS && !collided; i++)
+		for (j = i + 1; j < STAGED_SLOT_WINDOWS; j++)
+			if (slots[i] == slots[j]) {
+				collided = true;
+				break;
+			}
+	KUNIT_EXPECT_TRUE(test, collided);
+
+	for (i = 0; i < STAGED_SLOT_WINDOWS; i++)
+		KUNIT_ASSERT_EQ(test, sysfs_publish_dir(kids[i]), 0);
+
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent),
+			base + STAGED_SLOT_WINDOWS);
+	for (i = 0; i < STAGED_SLOT_WINDOWS; i++) {
+		char name[16];
+
+		snprintf(name, sizeof(name), "slot%d", i);
+		KUNIT_EXPECT_FALSE(test, sd_is_staged(kids[i]));
+		KUNIT_EXPECT_TRUE(test, child_visible(priv->parent, name));
+		KUNIT_EXPECT_TRUE(test, child_visible(kids[i], "attr0"));
+		KUNIT_EXPECT_TRUE(test, child_visible(kids[i], "attr1"));
+	}
+
+	for (i = 0; i < STAGED_SLOT_WINDOWS; i++) {
+		kobject_del(kids[i]);
+		kobject_put(kids[i]);
+	}
+	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), base);
+}
+
+static struct kunit_case staged_device_tests[] = {
+	KUNIT_CASE(staged_test_publish_end_to_end),
+	KUNIT_CASE(staged_test_duplicate_name),
+	KUNIT_CASE(staged_test_publish_staged_parent),
+	KUNIT_CASE(staged_test_publish_twice),
+	KUNIT_CASE(staged_test_mmap_file_alias),
+	KUNIT_CASE(staged_test_foreign_task),
+	KUNIT_CASE(staged_test_abort_twice),
+	KUNIT_CASE(staged_test_partial_group_abort),
+	KUNIT_CASE(staged_test_parent_removed),
+	KUNIT_CASE(staged_test_o1_root_cost),
+	KUNIT_CASE(staged_test_two_windows),
+	KUNIT_CASE(staged_test_glue_dir),
+	KUNIT_CASE(staged_test_device_add_unwind),
+	KUNIT_CASE(staged_test_bus_klist),
+	KUNIT_CASE(staged_test_hashed_slot_collision),
+	{}
+};
+
+static struct kunit_suite staged_device_test_suite = {
+	.name = "staged_device",
+	.init = staged_test_init,
+	.exit = staged_test_exit,
+	.test_cases = staged_device_tests,
+};
+
+kunit_test_suite(staged_device_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for staged sysfs directory registration");
+MODULE_LICENSE("GPL");
-- 
2.47.3

