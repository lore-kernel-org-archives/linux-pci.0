Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457EA37E5F3;
	Wed, 12 Aug 2026 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564116; cv=none; b=HgzaQmbOOUdY7o3/1fKy/Vlp8CPuJHxJ5S/fPS6QsoFE0N6TEcH1DU5fmiAvAW6x8Sk1+N13wlPwKzhDF/VrBsHLDs4E8HA3ZDUI2M+4cU48VqMV8bz+9lkyssl+93TyxMzPDrLc4ohf5+F4vxDnxr78Ofqpe8e0e99u1BoC9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564116; c=relaxed/simple;
	bh=Xn3BHUbFeDliXn0HA3Ojms95yrXnmIM+N1GKT1Q/gB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GII+Vu4ci5NBETxK7qNNWAF5fGtymG/WEs2Mpv/kBLv2alhnLxKAUKYL2/x252jxmjDM5lSjWoUKJmIo5gqugNl4r+TY4oNerNBujYoX2K3cFfHxvCjMbtjKMiNJewJUi222kinoSYZBuZ3NnOQYQFi7Xjm/82CKWF7gyD8dDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXBZTCJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXBZTCJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F3C1F00A3F;
	Wed, 12 Aug 2026 19:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564113;
	bh=AXZdG7M0VrErwh7NZPRJ8Bs/LnfE9o7nQ0Rnvb44ZOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TXBZTCJVDi9C7CxurPy/Po97diHZ1jBQDLmV+YFigXOnfEqTE2wzW3cBDa019/4ZQ
	 9jhKIwtCgRD7//0QVoJ6R0+Z0II6H38YGQOpqZ0G4oMdpIhD4xipZw+97parJ0ICrs
	 Ez9GWX82o7UQMo+o/638kW+QM95ZQjRpeDZ7L7Ore4BvJW7WP8+pNziPRSbGcdsH0Y
	 6zuzO5nPKP1wFqzduY2kmhLcpF6NBAJm7cIcb9fNIKkceI7tjCeyVnKdVNS8XUbF+V
	 nf3WKFywy4s98Ca4br5vMEtwzMMWIUo5FFaCaRnRhiTL2fBJc5Ve8y4GigHKDMQ/KU
	 ir74FJn3Aiyqg==
From: Leon Romanovsky <leon@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: [PATCH RFC 5/7] ACPI: HMAT: Add KUnit tests for PCIe P2P matrix semantics
Date: Wed, 12 Aug 2026 22:47:42 +0300
Message-ID: <20260812-hmat-p2p-v1-5-75ac41380585@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
References: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

HMAT P2P matrices are directional and merge independent records for ordered
and UIO traffic. An indexing, normalization, or merge regression could turn
an unreachable entry into another host bridge's usable path and corrupt
P2PDMA policy.

Protect this firmware trust boundary with coverage for matrix direction,
normalization, traffic-class merging, malformed tables, missing pairs, and
unreachable paths.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/acpi/numa/Kconfig     |  13 +++
 drivers/acpi/numa/Makefile    |   1 +
 drivers/acpi/numa/hmat.c      |  95 ++++++++++++------
 drivers/acpi/numa/hmat_test.c | 223 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/numa/hmat_test.h |  17 ++++
 5 files changed, 317 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
index f33194d1e43f..fed47ae67a38 100644
--- a/drivers/acpi/numa/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -13,3 +13,16 @@ config ACPI_HMAT
 	 register memory initiators with their targets, and export
 	 performance attributes through the node's sysfs device if
 	 provided.
+
+config ACPI_HMAT_KUNIT_TEST
+	bool "KUnit tests for ACPI HMAT P2P matrices" if !KUNIT_ALL_TESTS
+	depends on ACPI_HMAT && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit coverage for parsing and querying the PCIe P2P
+	  Latency and Bandwidth Information Structure, including directional
+	  matrix indexing, traffic classes, normalization, and unreachable
+	  entries.
+
+	  For more information on KUnit and unit tests in general, refer to
+	  the KUnit documentation in Documentation/dev-tools/kunit/.
diff --git a/drivers/acpi/numa/Makefile b/drivers/acpi/numa/Makefile
index 517a6c689a94..3c1a35be85bf 100644
--- a/drivers/acpi/numa/Makefile
+++ b/drivers/acpi/numa/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ACPI_NUMA) += srat.o
 obj-$(CONFIG_ACPI_HMAT) += hmat.o
+obj-$(CONFIG_ACPI_HMAT_KUNIT_TEST) += hmat_test.o
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index d06a62b38fff..d2964548aaaf 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "acpi/hmat: " fmt
 
+#include <kunit/visibility.h>
 #include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
@@ -26,6 +27,8 @@
 #include <linux/dax.h>
 #include <linux/memory-tiers.h>
 
+#include "hmat_test.h"
+
 static u8 hmat_revision;
 static int hmat_disable __initdata;
 
@@ -238,11 +241,12 @@ EXPORT_SYMBOL_GPL(acpi_get_genport_proximity_domain);
  * boot and is never modified afterwards, so runtime readers below walk it
  * without holding target_lock.
  */
-static struct memory_p2p_locality *find_p2p_locality(int initiator, int target)
+static struct memory_p2p_locality *
+find_p2p_locality(struct list_head *localities, int initiator, int target)
 {
 	struct memory_p2p_locality *loc;
 
-	list_for_each_entry(loc, &p2p_localities, node)
+	list_for_each_entry(loc, localities, node)
 		if (loc->initiator == initiator && loc->target == target)
 			return loc;
 	return NULL;
@@ -254,6 +258,23 @@ static bool p2p_coord_populated(const struct access_coordinate *coord)
 	       coord->read_latency || coord->write_latency;
 }
 
+VISIBLE_IF_KUNIT int
+hmat_get_p2p_coordinates(struct list_head *localities, int initiator_pxm,
+			 int target_pxm, enum hmat_p2p_class class,
+			 struct access_coordinate *coord)
+{
+	struct memory_p2p_locality *loc;
+
+	loc = find_p2p_locality(localities, initiator_pxm, target_pxm);
+	if (!loc)
+		return -ENOENT;
+	if (!(loc->valid & BIT(class)) || !p2p_coord_populated(&loc->coord[class]))
+		return -ENODATA;
+
+	*coord = loc->coord[class];
+	return 0;
+}
+
 /**
  * acpi_get_p2p_coordinates - Retrieve the P2P access coordinates between two
  *			      generic ports (PCIe host bridges)
@@ -269,19 +290,10 @@ int acpi_get_p2p_coordinates(int initiator_pxm, int target_pxm,
 			     enum hmat_p2p_class class,
 			     struct access_coordinate *coord)
 {
-	struct memory_p2p_locality *loc;
-
-	loc = find_p2p_locality(initiator_pxm, target_pxm);
-	if (!loc)
-		return -ENOENT;
-	if (!(loc->valid & BIT(class)) || !p2p_coord_populated(&loc->coord[class]))
-		return -ENODATA;
-
-	*coord = loc->coord[class];
-	return 0;
+	return hmat_get_p2p_coordinates(&p2p_localities, initiator_pxm,
+					 target_pxm, class, coord);
 }
 EXPORT_SYMBOL_GPL(acpi_get_p2p_coordinates);
-
 static __init void alloc_memory_initiator(unsigned int cpu_pxm)
 {
 	struct memory_initiator *initiator;
@@ -394,7 +406,7 @@ static __init const char *hmat_data_type_suffix(u8 type)
 	}
 }
 
-static u32 hmat_normalize(u16 entry, u64 base, u8 type)
+static u32 hmat_normalize_revision(u16 entry, u64 base, u8 type, u8 revision)
 {
 	u32 value;
 
@@ -411,11 +423,11 @@ static u32 hmat_normalize(u16 entry, u64 base, u8 type)
 	 * picosenonds to nanoseconds if revision 2.
 	 */
 	value = entry * base;
-	if (hmat_revision == 1) {
+	if (revision == 1) {
 		if (value < 10)
 			return 0;
 		value = DIV_ROUND_UP(value, 10);
-	} else if (hmat_revision == 2) {
+	} else if (revision == 2) {
 		switch (type) {
 		case ACPI_HMAT_ACCESS_LATENCY:
 		case ACPI_HMAT_READ_LATENCY:
@@ -429,6 +441,11 @@ static u32 hmat_normalize(u16 entry, u64 base, u8 type)
 	return value;
 }
 
+static u32 hmat_normalize(u16 entry, u64 base, u8 type)
+{
+	return hmat_normalize_revision(entry, base, type, hmat_revision);
+}
+
 static void hmat_update_target_access(struct memory_target *target,
 				      u8 type, u32 value, int access)
 {
@@ -599,20 +616,20 @@ static void hmat_update_p2p_access(struct access_coordinate *coord,
 	}
 }
 
-static __init void hmat_update_p2p(int initiator, int target, u8 flags,
-				   u8 type, u32 value)
+static __init void hmat_update_p2p(struct list_head *localities, int initiator,
+				   int target, u8 flags, u8 type, u32 value)
 {
 	struct memory_p2p_locality *loc;
 	enum hmat_p2p_class class;
 
-	loc = find_p2p_locality(initiator, target);
+	loc = find_p2p_locality(localities, initiator, target);
 	if (!loc) {
 		loc = kzalloc_obj(*loc);
 		if (!loc)
 			return;
 		loc->initiator = initiator;
 		loc->target = target;
-		list_add_tail(&loc->node, &p2p_localities);
+		list_add_tail(&loc->node, localities);
 	}
 
 	for (class = 0; class < HMAT_P2P_MAX; class++) {
@@ -625,10 +642,10 @@ static __init void hmat_update_p2p(int initiator, int target, u8 flags,
 	}
 }
 
-static __init int hmat_parse_p2p_latency(union acpi_subtable_headers *header,
-					 const unsigned long end)
+VISIBLE_IF_KUNIT int __init
+hmat_parse_p2p(struct acpi_hmat_p2p_latency *p2p, u8 revision,
+	       struct list_head *localities)
 {
-	struct acpi_hmat_p2p_latency *p2p = (void *)header;
 	unsigned int init, targ, total_size, ipds, tpds;
 	u32 *inits, *targs, value;
 	u16 *entries;
@@ -661,20 +678,27 @@ static __init int hmat_parse_p2p_latency(union acpi_subtable_headers *header,
 	entries = (u16 *)(targs + tpds);
 	for (init = 0; init < ipds; init++) {
 		for (targ = 0; targ < tpds; targ++) {
-			value = hmat_normalize(entries[init * tpds + targ],
-					       p2p->entry_base_unit, type);
+			value = hmat_normalize_revision(entries[init * tpds + targ],
+						p2p->entry_base_unit, type,
+						revision);
 			pr_debug("  Initiator-Target[%u-%u]:%u%s\n",
 				 inits[init], targs[targ], value,
 				 hmat_data_type_suffix(type));
 
-			hmat_update_p2p(inits[init], targs[targ], flags,
-					type, value);
+			hmat_update_p2p(localities, inits[init], targs[targ],
+					flags, type, value);
 		}
 	}
 
 	return 0;
 }
 
+static __init int hmat_parse_p2p_latency(union acpi_subtable_headers *header,
+					 const unsigned long end)
+{
+	return hmat_parse_p2p((void *)header, hmat_revision, &p2p_localities);
+}
+
 static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 				   const unsigned long end)
 {
@@ -1198,11 +1222,21 @@ static struct notifier_block hmat_adist_nb __meminitdata = {
 	.priority = 100,
 };
 
+VISIBLE_IF_KUNIT void __init
+hmat_free_p2p_localities(struct list_head *localities)
+{
+	struct memory_p2p_locality *loc, *next;
+
+	list_for_each_entry_safe(loc, next, localities, node) {
+		list_del(&loc->node);
+		kfree(loc);
+	}
+}
+
 static __init void hmat_free_structures(void)
 {
 	struct memory_target *target, *tnext;
 	struct memory_locality *loc, *lnext;
-	struct memory_p2p_locality *ploc, *pnext;
 	struct memory_initiator *initiator, *inext;
 	struct target_cache *tcache, *cnext;
 
@@ -1235,10 +1269,7 @@ static __init void hmat_free_structures(void)
 		kfree(loc);
 	}
 
-	list_for_each_entry_safe(ploc, pnext, &p2p_localities, node) {
-		list_del(&ploc->node);
-		kfree(ploc);
-	}
+	hmat_free_p2p_localities(&p2p_localities);
 }
 
 static __init int hmat_init(void)
diff --git a/drivers/acpi/numa/hmat_test.c b/drivers/acpi/numa/hmat_test.c
new file mode 100644
index 000000000000..3da1678feb15
--- /dev/null
+++ b/drivers/acpi/numa/hmat_test.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for ACPI HMAT PCIe peer-to-peer matrices.
+ */
+
+#include <kunit/test.h>
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include "hmat_test.h"
+
+struct hmat_test_ctx {
+	struct list_head localities;
+};
+
+static int __init hmat_test_init(struct kunit *test)
+{
+	struct hmat_test_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ctx->localities);
+	test->priv = ctx;
+	return 0;
+}
+
+static void __init hmat_test_exit(struct kunit *test)
+{
+	struct hmat_test_ctx *ctx = test->priv;
+
+	hmat_free_p2p_localities(&ctx->localities);
+}
+
+static struct acpi_hmat_p2p_latency * __init
+hmat_test_alloc_table(struct kunit *test, u32 initiators, u32 targets)
+{
+	struct acpi_hmat_p2p_latency *p2p;
+	size_t length;
+
+	length = sizeof(*p2p) + sizeof(u32) * (initiators + targets) +
+		 sizeof(u16) * initiators * targets;
+	p2p = kunit_kzalloc(test, length, GFP_KERNEL);
+	if (!p2p)
+		return NULL;
+
+	p2p->header.type = ACPI_HMAT_TYPE_P2P_LATENCY;
+	p2p->header.length = length;
+	p2p->number_of_initiator_Pds = initiators;
+	p2p->number_of_target_Pds = targets;
+	return p2p;
+}
+
+static u32 * __init hmat_test_initiators(struct acpi_hmat_p2p_latency *p2p)
+{
+	return (u32 *)(p2p + 1);
+}
+
+static u32 * __init hmat_test_targets(struct acpi_hmat_p2p_latency *p2p)
+{
+	return hmat_test_initiators(p2p) + p2p->number_of_initiator_Pds;
+}
+
+static u16 * __init hmat_test_entries(struct acpi_hmat_p2p_latency *p2p)
+{
+	return (u16 *)(hmat_test_targets(p2p) + p2p->number_of_target_Pds);
+}
+
+static void __init
+hmat_test_expect_coord(struct kunit *test, int initiator, int target,
+		       enum hmat_p2p_class class, u32 read_bandwidth,
+		       u32 write_bandwidth, u32 read_latency,
+		       u32 write_latency)
+{
+	struct hmat_test_ctx *ctx = test->priv;
+	struct access_coordinate coord;
+
+	KUNIT_ASSERT_EQ(test,
+			hmat_get_p2p_coordinates(&ctx->localities, initiator,
+						 target, class, &coord),
+			0);
+	KUNIT_EXPECT_EQ(test, coord.read_bandwidth, read_bandwidth);
+	KUNIT_EXPECT_EQ(test, coord.write_bandwidth, write_bandwidth);
+	KUNIT_EXPECT_EQ(test, coord.read_latency, read_latency);
+	KUNIT_EXPECT_EQ(test, coord.write_latency, write_latency);
+}
+
+static void __init hmat_p2p_matrix_test(struct kunit *test)
+{
+	struct hmat_test_ctx *ctx = test->priv;
+	struct acpi_hmat_p2p_latency *p2p;
+	struct access_coordinate coord;
+	u32 *initiators, *targets;
+	u16 *entries;
+
+	p2p = hmat_test_alloc_table(test, 2, 2);
+	KUNIT_ASSERT_NOT_NULL(test, p2p);
+	p2p->flags = ACPI_HMAT_P2P_NON_UIO | ACPI_HMAT_P2P_UIO;
+	p2p->data_type = ACPI_HMAT_ACCESS_LATENCY;
+	p2p->entry_base_unit = 1000;
+
+	initiators = hmat_test_initiators(p2p);
+	targets = hmat_test_targets(p2p);
+	entries = hmat_test_entries(p2p);
+	initiators[0] = 11;
+	initiators[1] = 22;
+	targets[0] = 33;
+	targets[1] = 44;
+	entries[0] = 5;
+	entries[1] = 10;
+	entries[2] = 0xffff;
+	entries[3] = 20;
+
+	KUNIT_ASSERT_EQ(test, hmat_parse_p2p(p2p, 2, &ctx->localities), 0);
+	hmat_test_expect_coord(test, 11, 33, HMAT_P2P_NON_UIO, 0, 0, 5, 5);
+	hmat_test_expect_coord(test, 11, 44, HMAT_P2P_UIO, 0, 0, 10, 10);
+	hmat_test_expect_coord(test, 22, 44, HMAT_P2P_NON_UIO, 0, 0, 20, 20);
+
+	KUNIT_EXPECT_EQ(test,
+			hmat_get_p2p_coordinates(&ctx->localities, 22, 33,
+						 HMAT_P2P_NON_UIO, &coord),
+			-ENODATA);
+	KUNIT_EXPECT_EQ(test,
+			hmat_get_p2p_coordinates(&ctx->localities, 33, 11,
+						 HMAT_P2P_NON_UIO, &coord),
+			-ENOENT);
+}
+
+static int __init hmat_test_add_coordinate(struct kunit *test, u8 flags,
+					   u8 type, u64 base, u16 entry)
+{
+	struct hmat_test_ctx *ctx = test->priv;
+	struct acpi_hmat_p2p_latency *p2p;
+
+	p2p = hmat_test_alloc_table(test, 1, 1);
+	if (!p2p)
+		return -ENOMEM;
+
+	p2p->flags = flags;
+	p2p->data_type = type;
+	p2p->entry_base_unit = base;
+	hmat_test_initiators(p2p)[0] = 1;
+	hmat_test_targets(p2p)[0] = 2;
+	hmat_test_entries(p2p)[0] = entry;
+	return hmat_parse_p2p(p2p, 2, &ctx->localities);
+}
+
+static void __init hmat_p2p_coordinate_merge_test(struct kunit *test)
+{
+	KUNIT_ASSERT_EQ(test,
+			hmat_test_add_coordinate(test, ACPI_HMAT_P2P_NON_UIO,
+				ACPI_HMAT_ACCESS_BANDWIDTH, 1, 400),
+			0);
+	KUNIT_ASSERT_EQ(test,
+			hmat_test_add_coordinate(test, ACPI_HMAT_P2P_NON_UIO,
+				ACPI_HMAT_READ_LATENCY, 1000, 7),
+			0);
+	KUNIT_ASSERT_EQ(test,
+			hmat_test_add_coordinate(test, ACPI_HMAT_P2P_NON_UIO,
+				ACPI_HMAT_WRITE_LATENCY, 1000, 9),
+			0);
+	KUNIT_ASSERT_EQ(test,
+			hmat_test_add_coordinate(test, ACPI_HMAT_P2P_UIO,
+				ACPI_HMAT_READ_BANDWIDTH, 1, 200),
+			0);
+	KUNIT_ASSERT_EQ(test,
+			hmat_test_add_coordinate(test, ACPI_HMAT_P2P_UIO,
+				ACPI_HMAT_WRITE_BANDWIDTH, 1, 300),
+			0);
+	KUNIT_ASSERT_EQ(test,
+			hmat_test_add_coordinate(test, ACPI_HMAT_P2P_UIO,
+				ACPI_HMAT_ACCESS_LATENCY, 1000, 11),
+			0);
+
+	hmat_test_expect_coord(test, 1, 2, HMAT_P2P_NON_UIO,
+			       400, 400, 7, 9);
+	hmat_test_expect_coord(test, 1, 2, HMAT_P2P_UIO,
+			       200, 300, 11, 11);
+}
+
+static void __init hmat_p2p_invalid_length_test(struct kunit *test)
+{
+	struct hmat_test_ctx *ctx = test->priv;
+	struct acpi_hmat_p2p_latency *p2p;
+	struct access_coordinate coord;
+
+	p2p = hmat_test_alloc_table(test, 1, 1);
+	KUNIT_ASSERT_NOT_NULL(test, p2p);
+	p2p->header.length = sizeof(*p2p) - 1;
+	KUNIT_EXPECT_EQ(test, hmat_parse_p2p(p2p, 2, &ctx->localities),
+			-EINVAL);
+
+	p2p = hmat_test_alloc_table(test, 1, 1);
+	KUNIT_ASSERT_NOT_NULL(test, p2p);
+	p2p->header.length = sizeof(*p2p);
+	KUNIT_EXPECT_EQ(test, hmat_parse_p2p(p2p, 2, &ctx->localities),
+			-EINVAL);
+	KUNIT_EXPECT_EQ(test,
+			hmat_get_p2p_coordinates(&ctx->localities, 0, 0,
+						 HMAT_P2P_NON_UIO, &coord),
+			-ENOENT);
+}
+
+static struct kunit_case __refdata hmat_p2p_test_cases[] = {
+	KUNIT_CASE(hmat_p2p_matrix_test),
+	KUNIT_CASE(hmat_p2p_coordinate_merge_test),
+	KUNIT_CASE(hmat_p2p_invalid_length_test),
+	{}
+};
+
+static struct kunit_suite __refdata hmat_p2p_test_suite = {
+	.name = "acpi_hmat_p2p",
+	.init = hmat_test_init,
+	.exit = hmat_test_exit,
+	.test_cases = hmat_p2p_test_cases,
+};
+kunit_test_init_section_suite(hmat_p2p_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for ACPI HMAT PCIe P2P matrices");
diff --git a/drivers/acpi/numa/hmat_test.h b/drivers/acpi/numa/hmat_test.h
new file mode 100644
index 000000000000..f53a395c6f8e
--- /dev/null
+++ b/drivers/acpi/numa/hmat_test.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ACPI_NUMA_HMAT_TEST_H
+#define __ACPI_NUMA_HMAT_TEST_H
+
+#include <linux/acpi.h>
+#include <linux/list.h>
+
+#if IS_ENABLED(CONFIG_KUNIT)
+int hmat_parse_p2p(struct acpi_hmat_p2p_latency *p2p, u8 revision,
+		   struct list_head *localities);
+int hmat_get_p2p_coordinates(struct list_head *localities, int initiator_pxm,
+			     int target_pxm, enum hmat_p2p_class class,
+			     struct access_coordinate *coord);
+void hmat_free_p2p_localities(struct list_head *localities);
+#endif
+
+#endif /* __ACPI_NUMA_HMAT_TEST_H */

-- 
2.55.0

