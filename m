Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4238C2A0;
	Wed, 12 Aug 2026 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564122; cv=none; b=rw7KI/3AU3zso6gGMCw1Ujtre8xraveIN6fh3t1DQcv8YZ7up1K7Q2DMvMWDKF+8aBB0Oit7Yw/4ZJlYR5A1ASsvwTDn2CSWLAQnkChKooaDCbcvNfm2RZlL68MwjL5ZHIicfsrzVh2mm0zxEevVL5RGjEeVkFUC1iJGpKGyktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564122; c=relaxed/simple;
	bh=IqkbhDYVxi4XRyFWLlh0UkIZAig09Qd5urtlS0t1fL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRhKjA2YtV0ZrxADPGtZwng1SNux9K+cFQz73aq7uEU6S1xySUGfx1O+ywUIjlIGEmV+TzRQpT52TqCbId2Nn0vj+myLvNzfHvsQHERmpR4Y3m8wF9siGUtX5Mymsw3trZjASsU2Pdor0slaaLDBjUimFQJAL+iQQLQRi52xwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewgC4cfK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewgC4cfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F501F000E9;
	Wed, 12 Aug 2026 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564118;
	bh=wisKwVPEElrvONf5rRtr8KM+Nr29VeD4HMledrPRMPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ewgC4cfKYscyrYLJ0naOZtl3UAq0OWRx80mQLjvkCtVTeCXaMkmJBRJ8XOeeUu5Jn
	 ofPQB/ScZLmCddK9hUSw5S6on/cVH+VrwPJkVxzUQF3/IyLiMVNwnJ2UUFdT7+Myv5
	 jlx3amjRWuopkcSsdkY/6RzdXC6DNy1qcsjswNnrHKtCxA6nyBi+xXuTOGkqB853ba
	 Wr1w5MCCr8DI/6ZSOxTwX9ui4rZteSzPywPlDhhFvsffXiaZliV3dljtEO3g2yRGjG
	 4N8NciYrdxT0jlvV74FUTi974mw6MDAkTcbzfzmWqyajuPDcApzangGJmAbNqVo3lD
	 GSU3POOhaA4bw==
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
Subject: [PATCH RFC 6/7] PCI/P2PDMA: Add KUnit tests for HMAT policy boundaries
Date: Wed, 12 Aug 2026 22:47:43 +0300
Message-ID: <20260812-hmat-p2p-v1-6-75ac41380585@nvidia.com>
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

HMAT becomes an authorization input for cross-host-bridge DMA. Reversing
the requester and completer or accepting UIO-only data for ordered traffic
could permit unsafe DMA.

Protect the directional lookup and the ordered-traffic requirement. A
missing proximity domain or a missing, unreachable, or UIO-only path must
produce PCI_P2PDMA_MAP_NOT_SUPPORTED, and a path the CPU already permits
must not consult firmware at all.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/acpi/numa/hmat.c  |   4 +
 drivers/pci/Kconfig       |  13 +++
 drivers/pci/Makefile      |   1 +
 drivers/pci/p2pdma.c      |  33 ++++----
 drivers/pci/p2pdma_test.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h         |   2 +
 6 files changed, 249 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index d2964548aaaf..4593cccf9b9e 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "acpi/hmat: " fmt
 
+#include <kunit/static_stub.h>
 #include <kunit/visibility.h>
 #include <linux/acpi.h>
 #include <linux/bitops.h>
@@ -290,6 +291,9 @@ int acpi_get_p2p_coordinates(int initiator_pxm, int target_pxm,
 			     enum hmat_p2p_class class,
 			     struct access_coordinate *coord)
 {
+	KUNIT_STATIC_STUB_REDIRECT(acpi_get_p2p_coordinates, initiator_pxm,
+				   target_pxm, class, coord);
+
 	return hmat_get_p2p_coordinates(&p2p_localities, initiator_pxm,
 					 target_pxm, class, coord);
 }
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 30ad7f407c6f..47b92b289faf 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -241,6 +241,19 @@ config PCI_ACS_KUNIT_TEST
 
 	  If unsure, say N.
 
+config PCI_P2PDMA_HMAT_KUNIT_TEST
+	tristate "KUnit tests for PCI P2PDMA HMAT routing" if !KUNIT_ALL_TESTS
+	depends on PCI_P2PDMA && ACPI_HMAT && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit coverage for authorizing cross-host-bridge P2P DMA
+	  through ordered HMAT paths.
+
+	  For more information on KUnit and unit tests in general, refer to
+	  the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config PCI_LABEL
 	def_bool y if (DMI || ACPI)
 	select NLS
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 6305d128d3df..b0c392d5c8a3 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
 obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_PCI_ACS_KUNIT_TEST) += pci_acs_test.o
+obj-$(CONFIG_PCI_P2PDMA_HMAT_KUNIT_TEST) += p2pdma_test.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 88119620890f..fe3e7ea0776c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -9,6 +9,7 @@
  */
 
 #define pr_fmt(fmt) "pci-p2pdma: " fmt
+#include <kunit/static_stub.h>
 #include <linux/acpi.h>
 #include <linux/ctype.h>
 #include <linux/dma-map-ops.h>
@@ -613,8 +614,10 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
 }
 
-static bool cpu_supports_p2pdma(void)
+VISIBLE_IF_KUNIT bool cpu_supports_p2pdma(void)
 {
+	KUNIT_STATIC_STUB_REDIRECT(cpu_supports_p2pdma);
+
 #ifdef CONFIG_X86
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
@@ -625,6 +628,7 @@ static bool cpu_supports_p2pdma(void)
 
 	return false;
 }
+EXPORT_SYMBOL_IF_KUNIT(cpu_supports_p2pdma);
 
 static const struct pci_p2pdma_whitelist_entry {
 	unsigned short vendor;
@@ -751,13 +755,15 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b,
 }
 
 #ifdef CONFIG_ACPI
-static int pci_host_bridge_pxm(struct pci_dev *pdev)
+VISIBLE_IF_KUNIT int pci_host_bridge_pxm(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
 	struct acpi_device *adev;
 	const char *uid_str;
 	u32 uid;
 
+	KUNIT_STATIC_STUB_REDIRECT(pci_host_bridge_pxm, pdev);
+
 	adev = to_acpi_device_node(host->dev.fwnode);
 	if (!adev)
 		return -ENODEV;
@@ -769,11 +775,14 @@ static int pci_host_bridge_pxm(struct pci_dev *pdev)
 	return acpi_get_genport_proximity_domain(uid);
 }
 #else
-static int pci_host_bridge_pxm(struct pci_dev *pdev)
+VISIBLE_IF_KUNIT int pci_host_bridge_pxm(struct pci_dev *pdev)
 {
+	KUNIT_STATIC_STUB_REDIRECT(pci_host_bridge_pxm, pdev);
+
 	return -ENODEV;
 }
 #endif
+EXPORT_SYMBOL_IF_KUNIT(pci_host_bridge_pxm);
 
 /*
  * Check whether platform firmware describes, via an HMAT PCIe P2P Latency and
@@ -810,10 +819,6 @@ static unsigned long map_types_idx(struct pci_dev *client)
 	return (pci_domain_nr(client->bus) << 16) | pci_dev_id(client);
 }
 
-static enum pci_p2pdma_map_type
-__calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
-		int *dist, bool verbose, struct access_coordinate *hmat_coord);
-
 /*
  * Calculate the P2PDMA mapping type and distance between two PCI devices.
  *
@@ -849,13 +854,6 @@ __calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
  * ordered HMAT path. Return PCI_P2PDMA_MAP_NOT_SUPPORTED when none of those
  * sources permits the path.
  */
-VISIBLE_IF_KUNIT enum pci_p2pdma_map_type
-calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
-		int *dist, bool verbose)
-{
-	return __calc_map_type_and_dist(provider, client, dist, verbose, NULL);
-}
-
 static enum pci_p2pdma_map_type
 __calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool verbose, struct access_coordinate *hmat_coord)
@@ -1009,6 +1007,13 @@ __calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	rcu_read_unlock();
 	return map_type;
 }
+
+VISIBLE_IF_KUNIT enum pci_p2pdma_map_type
+calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
+		int *dist, bool verbose)
+{
+	return __calc_map_type_and_dist(provider, client, dist, verbose, NULL);
+}
 EXPORT_SYMBOL_IF_KUNIT(calc_map_type_and_dist);
 
 static int
diff --git a/drivers/pci/p2pdma_test.c b/drivers/pci/p2pdma_test.c
new file mode 100644
index 000000000000..1430185f69b7
--- /dev/null
+++ b/drivers/pci/p2pdma_test.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for HMAT-described PCI peer-to-peer routing.
+ */
+
+#include <kunit/static_stub.h>
+#include <kunit/test.h>
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci-p2pdma.h>
+
+#include "pci.h"
+
+struct hmat_route_case {
+	const char *desc;
+	bool cpu_p2pdma;
+	int client_pxm;
+	int provider_pxm;
+	int lookup_ret;
+	int lookup_calls;
+	enum pci_p2pdma_map_type expected;
+};
+
+static const struct hmat_route_case hmat_route_cases[] = {
+	{
+		.desc = "ordered_path",
+		.client_pxm = 11,
+		.provider_pxm = 22,
+		.lookup_ret = 0,
+		.lookup_calls = 1,
+		.expected = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
+	},
+	{
+		.desc = "missing_path",
+		.client_pxm = 11,
+		.provider_pxm = 22,
+		.lookup_ret = -ENOENT,
+		.lookup_calls = 1,
+		.expected = PCI_P2PDMA_MAP_NOT_SUPPORTED,
+	},
+	{
+		.desc = "uio_only_path",
+		.client_pxm = 11,
+		.provider_pxm = 22,
+		.lookup_ret = -ENODATA,
+		.lookup_calls = 1,
+		.expected = PCI_P2PDMA_MAP_NOT_SUPPORTED,
+	},
+	{
+		.desc = "missing_client_pxm",
+		.client_pxm = -ENODEV,
+		.provider_pxm = 22,
+		.lookup_ret = 0,
+		.lookup_calls = 0,
+		.expected = PCI_P2PDMA_MAP_NOT_SUPPORTED,
+	},
+	{
+		.desc = "missing_provider_pxm",
+		.client_pxm = 11,
+		.provider_pxm = -ENODEV,
+		.lookup_ret = 0,
+		.lookup_calls = 0,
+		.expected = PCI_P2PDMA_MAP_NOT_SUPPORTED,
+	},
+	{
+		.desc = "platform_authorized",
+		.cpu_p2pdma = true,
+		.client_pxm = 11,
+		.provider_pxm = 22,
+		.lookup_calls = 0,
+		.expected = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
+	},
+};
+
+static void hmat_route_case_desc(const struct hmat_route_case *c, char *desc)
+{
+	strscpy(desc, c->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(hmat_route, hmat_route_cases, hmat_route_case_desc);
+
+struct hmat_route_ctx {
+	const struct hmat_route_case *test_case;
+	struct pci_dev *provider;
+	struct pci_dev *client;
+	int lookup_calls;
+	int lookup_initiator;
+	int lookup_target;
+	enum hmat_p2p_class lookup_class;
+	bool unexpected_device;
+};
+
+static struct pci_dev *hmat_add_root_device(struct kunit *test, u8 busnr)
+{
+	struct pci_host_bridge *host;
+	struct pci_bus *bus;
+	struct pci_dev *pdev;
+
+	host = kunit_kzalloc(test, sizeof(*host), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, host);
+	bus = kunit_kzalloc(test, sizeof(*bus), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, bus);
+	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pdev);
+
+	bus->number = busnr;
+	bus->bridge = &host->dev;
+	INIT_LIST_HEAD(&bus->devices);
+	host->bus = bus;
+
+	pdev->bus = bus;
+	pdev->devfn = PCI_DEVFN(0, 0);
+	pdev->vendor = 0xffff;
+	pdev->device = 0xffff;
+	list_add_tail(&pdev->bus_list, &bus->devices);
+	return pdev;
+}
+
+static bool cpu_supports_p2pdma_stub(void)
+{
+	return false;
+}
+
+static bool cpu_supports_p2pdma_true_stub(void)
+{
+	return true;
+}
+
+static int pci_host_bridge_pxm_stub(struct pci_dev *pdev)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct hmat_route_ctx *ctx = test->priv;
+
+	if (pdev == ctx->client)
+		return ctx->test_case->client_pxm;
+	if (pdev == ctx->provider)
+		return ctx->test_case->provider_pxm;
+
+	ctx->unexpected_device = true;
+	return -ENODEV;
+}
+
+static int acpi_get_p2p_coordinates_stub(int initiator, int target,
+					 enum hmat_p2p_class class,
+					 struct access_coordinate *coord)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct hmat_route_ctx *ctx = test->priv;
+
+	ctx->lookup_calls++;
+	ctx->lookup_initiator = initiator;
+	ctx->lookup_target = target;
+	ctx->lookup_class = class;
+	if (!ctx->test_case->lookup_ret)
+		coord->read_bandwidth = 1;
+	return ctx->test_case->lookup_ret;
+}
+
+static void pci_p2pdma_hmat_route_test(struct kunit *test)
+{
+	const struct hmat_route_case *test_case = test->param_value;
+	struct hmat_route_ctx ctx = { .test_case = test_case };
+	enum pci_p2pdma_map_type map;
+	int distance;
+
+	ctx.provider = hmat_add_root_device(test, 0);
+	ctx.client = hmat_add_root_device(test, 1);
+	test->priv = &ctx;
+
+	if (test_case->cpu_p2pdma)
+		kunit_activate_static_stub(test, cpu_supports_p2pdma,
+					   cpu_supports_p2pdma_true_stub);
+	else
+		kunit_activate_static_stub(test, cpu_supports_p2pdma,
+					   cpu_supports_p2pdma_stub);
+	kunit_activate_static_stub(test, pci_host_bridge_pxm,
+				   pci_host_bridge_pxm_stub);
+	kunit_activate_static_stub(test, acpi_get_p2p_coordinates,
+				   acpi_get_p2p_coordinates_stub);
+
+	map = calc_map_type_and_dist(ctx.provider, ctx.client, &distance, false);
+	KUNIT_EXPECT_EQ(test, map, test_case->expected);
+	KUNIT_EXPECT_EQ(test, distance, 2);
+	KUNIT_EXPECT_EQ(test, ctx.lookup_calls, test_case->lookup_calls);
+	KUNIT_EXPECT_FALSE(test, ctx.unexpected_device);
+	if (ctx.lookup_calls) {
+		KUNIT_EXPECT_EQ(test, ctx.lookup_initiator,
+				test_case->client_pxm);
+		KUNIT_EXPECT_EQ(test, ctx.lookup_target,
+				test_case->provider_pxm);
+		KUNIT_EXPECT_EQ(test, ctx.lookup_class, HMAT_P2P_NON_UIO);
+	}
+}
+
+static struct kunit_case pci_p2pdma_hmat_test_cases[] = {
+	KUNIT_CASE_PARAM(pci_p2pdma_hmat_route_test, hmat_route_gen_params),
+	{}
+};
+
+static struct kunit_suite pci_p2pdma_hmat_test_suite = {
+	.name = "pci_p2pdma_hmat",
+	.test_cases = pci_p2pdma_hmat_test_cases,
+};
+kunit_test_suite(pci_p2pdma_hmat_test_suite);
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for HMAT-described PCI P2P routing");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f8f9a15e411a..7a44158fdbd0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1101,6 +1101,8 @@ enum pci_acs_p2pdma_state pci_acs_p2pdma_decision(u16 ctrl, bool has_target,
 enum pci_p2pdma_map_type calc_map_type_and_dist(struct pci_dev *provider,
 						struct pci_dev *client,
 						int *dist, bool verbose);
+int pci_host_bridge_pxm(struct pci_dev *pdev);
+bool cpu_supports_p2pdma(void);
 #endif
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags,

-- 
2.55.0

