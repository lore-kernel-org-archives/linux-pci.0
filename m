Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ABE37E5E9;
	Wed, 12 Aug 2026 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564126; cv=none; b=D5jMmXnyG9tNkv885JRQAwG7vQFhKkIg5o78QYXOHBCqbuygXM1cB7EvLXIWWJaA//Z9y4K3G97JR6wSCoI033qLnJRJYU8p1lU2ox714q7yleoZ+dwRLKoIgtkpDY8JQPYXlXhKNhV9YOgHYsqpDbsnofYu4A3L28vWzoY868A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564126; c=relaxed/simple;
	bh=/y3g8yc9wrJoWKsqZg94UfUwE8UbBG0EhDb7qCBJ5Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtfM7sb/19XKGn88KtCPSz1/Zxw+xv2a1aOjuKXP5RomKGyqYftXD3w/gIs+Nx9hbvD1d8yQcujxcGM66CaJ4HEVcNSz4sbB4v6ar6iuRqUy6tbMtD56VKBpilIfkYzlsAAd80+VOXzN/Y0uQdj69lgXtyPxIuyV7XD4Iage5Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTnIZokk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTnIZokk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACEB1F00A3F;
	Wed, 12 Aug 2026 19:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564123;
	bh=Swv0qTwUxqjnKm1DzZxH8mB1Uno+7IXpRoUvwmAiRHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eTnIZokkV7ecQByGvzB5sJvDTGlEa8LAGZFODj2wXdVOf9cO4cJmiV6SwnEWoBcjA
	 TdKuurZ+IPkRbudPzOHop4EH4ENzAyNa08Pbq0k63N32f5DEIYWlfRNubzAysFtRFf
	 Eo3nj19jwltAN65W3K3WeYP+ql5MfRvMcYx1PJ43Z3fTnV9dcFgwLNF/gNweXnM54x
	 iUvsMyBZvs/grsENwHriWT2hi0z9xjqotve0sI4PlP9wjIphwcS2jBj1hyeCtfcZP3
	 1ZXPZ54lzen2ZLk+F5hCoNj5oUmpueXRy1cxMh05tPpFGfC/iyoA38tFvrlMg/N1zE
	 HPrZBbtlp7XxA==
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
Subject: [PATCH RFC 7/7] PCI/P2PDMA: Add KUnit tests for HMAT provider ranking
Date: Wed, 12 Aug 2026 22:47:44 +0300
Message-ID: <20260812-hmat-p2p-v1-7-75ac41380585@nvidia.com>
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

HMAT provider selection combines directional coordinates across every
client. A regression in metric completeness, worst-path aggregation, or
precedence could select a slower provider or change the distance fallback.

Protect the ranking contract across complete, partial, direct, and
platform-authorized paths, including its ordering and distance tie-break.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/Kconfig       |   3 +-
 drivers/pci/p2pdma.c      |  22 +---
 drivers/pci/p2pdma_test.c | 267 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h         |  21 ++++
 4 files changed, 294 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 47b92b289faf..b46833ff10e1 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -247,7 +247,8 @@ config PCI_P2PDMA_HMAT_KUNIT_TEST
 	default KUNIT_ALL_TESTS
 	help
 	  Enable KUnit coverage for authorizing cross-host-bridge P2P DMA
-	  through ordered HMAT paths.
+	  through ordered HMAT paths and ranking providers by their
+	  ordered-path performance.
 
 	  For more information on KUnit and unit tests in general, refer to
 	  the KUnit documentation in Documentation/dev-tools/kunit/.
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index fe3e7ea0776c..ca822f60e9d3 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -70,22 +70,6 @@ struct pci_p2pdma_pagemap {
 	struct p2pdma_provider *mem;
 };
 
-/* Provider rank classes, ordered from most to least preferable. */
-enum pci_p2pdma_rank_type {
-	PCI_P2PDMA_RANK_DIRECT,
-	PCI_P2PDMA_RANK_HMAT_BANDWIDTH,
-	PCI_P2PDMA_RANK_HMAT_LATENCY,
-	PCI_P2PDMA_RANK_DISTANCE,
-};
-
-struct pci_p2pdma_rank {
-	enum pci_p2pdma_rank_type type;
-	u32 bandwidth;
-	u32 latency;
-	int distance;
-	bool latency_valid;
-};
-
 static struct pci_p2pdma_pagemap *to_p2p_pgmap(struct dev_pagemap *pgmap)
 {
 	return container_of(pgmap, struct pci_p2pdma_pagemap, pgmap);
@@ -1016,7 +1000,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 }
 EXPORT_SYMBOL_IF_KUNIT(calc_map_type_and_dist);
 
-static int
+VISIBLE_IF_KUNIT int
 pci_p2pdma_rank_cmp(const struct pci_p2pdma_rank *a,
 		    const struct pci_p2pdma_rank *b)
 {
@@ -1039,13 +1023,14 @@ pci_p2pdma_rank_cmp(const struct pci_p2pdma_rank *a,
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(pci_p2pdma_rank_cmp);
 
 /*
  * P2P bandwidth is limited by the slowest direction and client path, while
  * the largest latency bounds the worst path. Only compare a metric when every
  * host-bridge path supplies both its read and write values.
  */
-static int
+VISIBLE_IF_KUNIT int
 pci_p2pdma_rank_many(struct pci_dev *provider, struct device **clients,
 		     int num_clients, bool verbose,
 		     struct pci_p2pdma_rank *rank)
@@ -1124,6 +1109,7 @@ pci_p2pdma_rank_many(struct pci_dev *provider, struct device **clients,
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(pci_p2pdma_rank_many);
 
 /**
  * pci_p2pdma_distance_many - Determine the cumulative distance between
diff --git a/drivers/pci/p2pdma_test.c b/drivers/pci/p2pdma_test.c
index 1430185f69b7..8475c40c0eaf 100644
--- a/drivers/pci/p2pdma_test.c
+++ b/drivers/pci/p2pdma_test.c
@@ -92,6 +92,15 @@ struct hmat_route_ctx {
 	bool unexpected_device;
 };
 
+static void hmat_test_device_release(struct device *dev)
+{
+}
+
+static void hmat_test_put_device(void *data)
+{
+	put_device(data);
+}
+
 static struct pci_dev *hmat_add_root_device(struct kunit *test, u8 busnr)
 {
 	struct pci_host_bridge *host;
@@ -104,6 +113,13 @@ static struct pci_dev *hmat_add_root_device(struct kunit *test, u8 busnr)
 	KUNIT_ASSERT_NOT_NULL(test, bus);
 	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, pdev);
+	device_initialize(&pdev->dev);
+	pdev->dev.bus = &pci_bus_type;
+	pdev->dev.release = hmat_test_device_release;
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, hmat_test_put_device,
+						  &pdev->dev),
+			0);
 
 	bus->number = busnr;
 	bus->bridge = &host->dev;
@@ -194,8 +210,259 @@ static void pci_p2pdma_hmat_route_test(struct kunit *test)
 	}
 }
 
+struct hmat_rank_case {
+	const char *desc;
+	struct access_coordinate coord[2];
+	enum pci_p2pdma_rank_type expected_type;
+	u32 expected_bandwidth;
+	u32 expected_latency;
+	bool expected_latency_valid;
+};
+
+static const struct hmat_rank_case hmat_rank_cases[] = {
+	{
+		.desc = "bandwidth_and_latency",
+		.coord = {
+			{
+				.read_bandwidth = 100,
+				.write_bandwidth = 90,
+				.read_latency = 7,
+				.write_latency = 8,
+			},
+			{
+				.read_bandwidth = 75,
+				.write_bandwidth = 80,
+				.read_latency = 10,
+				.write_latency = 9,
+			},
+		},
+		.expected_type = PCI_P2PDMA_RANK_HMAT_BANDWIDTH,
+		.expected_bandwidth = 75,
+		.expected_latency = 10,
+		.expected_latency_valid = true,
+	},
+	{
+		.desc = "bandwidth_only",
+		.coord = {
+			{
+				.read_bandwidth = 100,
+				.write_bandwidth = 90,
+			},
+			{
+				.read_bandwidth = 75,
+				.write_bandwidth = 80,
+			},
+		},
+		.expected_type = PCI_P2PDMA_RANK_HMAT_BANDWIDTH,
+		.expected_bandwidth = 75,
+	},
+	{
+		.desc = "latency_only",
+		.coord = {
+			{
+				.read_latency = 7,
+				.write_latency = 8,
+			},
+			{
+				.read_latency = 10,
+				.write_latency = 9,
+			},
+		},
+		.expected_type = PCI_P2PDMA_RANK_HMAT_LATENCY,
+		.expected_latency = 10,
+		.expected_latency_valid = true,
+	},
+	{
+		.desc = "incomplete_coordinates",
+		.coord = {
+			{
+				.read_bandwidth = 100,
+				.write_bandwidth = 90,
+				.read_latency = 7,
+				.write_latency = 8,
+			},
+			{
+				.read_bandwidth = 75,
+				.read_latency = 10,
+			},
+		},
+		.expected_type = PCI_P2PDMA_RANK_DISTANCE,
+	},
+};
+
+static void hmat_rank_case_desc(const struct hmat_rank_case *c, char *desc)
+{
+	strscpy(desc, c->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(hmat_rank, hmat_rank_cases, hmat_rank_case_desc);
+
+struct hmat_rank_ctx {
+	const struct hmat_rank_case *test_case;
+	struct pci_dev *provider;
+	struct pci_dev *client[2];
+	int lookup_calls;
+	bool unexpected_lookup;
+};
+
+static int pci_host_bridge_rank_pxm_stub(struct pci_dev *pdev)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct hmat_rank_ctx *ctx = test->priv;
+	unsigned int i;
+
+	if (pdev == ctx->provider)
+		return 22;
+	for (i = 0; i < ARRAY_SIZE(ctx->client); i++)
+		if (pdev == ctx->client[i])
+			return 11 + i;
+
+	ctx->unexpected_lookup = true;
+	return -ENODEV;
+}
+
+static int acpi_get_p2p_rank_coordinates_stub(int initiator, int target,
+					      enum hmat_p2p_class class,
+					      struct access_coordinate *coord)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct hmat_rank_ctx *ctx = test->priv;
+	int index = initiator - 11;
+
+	ctx->lookup_calls++;
+	if (index < 0 || index >= (int)ARRAY_SIZE(ctx->client) || target != 22 ||
+	    class != HMAT_P2P_NON_UIO) {
+		ctx->unexpected_lookup = true;
+		return -ENOENT;
+	}
+
+	*coord = ctx->test_case->coord[index];
+	return 0;
+}
+
+static void pci_p2pdma_hmat_rank_many_test(struct kunit *test)
+{
+	const struct hmat_rank_case *test_case = test->param_value;
+	struct hmat_rank_ctx ctx = { .test_case = test_case };
+	struct device *clients[ARRAY_SIZE(ctx.client)];
+	struct pci_p2pdma_rank rank;
+	unsigned int i;
+
+	ctx.provider = hmat_add_root_device(test, 0);
+	for (i = 0; i < ARRAY_SIZE(ctx.client); i++) {
+		ctx.client[i] = hmat_add_root_device(test, i + 1);
+		clients[i] = &ctx.client[i]->dev;
+	}
+	test->priv = &ctx;
+
+	kunit_activate_static_stub(test, cpu_supports_p2pdma,
+				   cpu_supports_p2pdma_stub);
+	kunit_activate_static_stub(test, pci_host_bridge_pxm,
+				   pci_host_bridge_rank_pxm_stub);
+	kunit_activate_static_stub(test, acpi_get_p2p_coordinates,
+				   acpi_get_p2p_rank_coordinates_stub);
+
+	KUNIT_ASSERT_EQ(test,
+			pci_p2pdma_rank_many(ctx.provider, clients,
+					       ARRAY_SIZE(clients), false, &rank),
+			0);
+	KUNIT_EXPECT_EQ(test, rank.type, test_case->expected_type);
+	KUNIT_EXPECT_EQ(test, rank.distance, 4);
+	KUNIT_EXPECT_EQ(test, ctx.lookup_calls, 2);
+	KUNIT_EXPECT_FALSE(test, ctx.unexpected_lookup);
+	if (rank.type == PCI_P2PDMA_RANK_HMAT_BANDWIDTH)
+		KUNIT_EXPECT_EQ(test, rank.bandwidth,
+				test_case->expected_bandwidth);
+	if (rank.latency_valid)
+		KUNIT_EXPECT_EQ(test, rank.latency,
+				test_case->expected_latency);
+	KUNIT_EXPECT_EQ(test, rank.latency_valid,
+			test_case->expected_latency_valid);
+}
+
+static void pci_p2pdma_hmat_rank_compare_test(struct kunit *test)
+{
+	struct pci_p2pdma_rank direct = {
+		.type = PCI_P2PDMA_RANK_DIRECT,
+		.distance = 8,
+	};
+	struct pci_p2pdma_rank bandwidth = {
+		.type = PCI_P2PDMA_RANK_HMAT_BANDWIDTH,
+		.bandwidth = 100,
+		.latency = 20,
+		.distance = 4,
+		.latency_valid = true,
+	};
+	struct pci_p2pdma_rank other = bandwidth;
+
+	KUNIT_EXPECT_LT(test, pci_p2pdma_rank_cmp(&direct, &bandwidth), 0);
+
+	other.bandwidth = 90;
+	KUNIT_EXPECT_LT(test, pci_p2pdma_rank_cmp(&bandwidth, &other), 0);
+	other = bandwidth;
+	other.latency = 30;
+	KUNIT_EXPECT_LT(test, pci_p2pdma_rank_cmp(&bandwidth, &other), 0);
+	other = bandwidth;
+	other.latency_valid = false;
+	KUNIT_EXPECT_LT(test, pci_p2pdma_rank_cmp(&bandwidth, &other), 0);
+	other = bandwidth;
+	other.distance = 5;
+	KUNIT_EXPECT_LT(test, pci_p2pdma_rank_cmp(&bandwidth, &other), 0);
+	KUNIT_EXPECT_EQ(test, pci_p2pdma_rank_cmp(&bandwidth, &bandwidth), 0);
+
+	bandwidth.type = PCI_P2PDMA_RANK_HMAT_LATENCY;
+	other = bandwidth;
+	other.type = PCI_P2PDMA_RANK_DISTANCE;
+	KUNIT_EXPECT_LT(test, pci_p2pdma_rank_cmp(&bandwidth, &other), 0);
+	other = bandwidth;
+	other.latency = 30;
+	KUNIT_EXPECT_LT(test, pci_p2pdma_rank_cmp(&bandwidth, &other), 0);
+
+	bandwidth.type = PCI_P2PDMA_RANK_DISTANCE;
+	bandwidth.distance = 4;
+	other = bandwidth;
+	other.distance = 5;
+	KUNIT_EXPECT_LT(test, pci_p2pdma_rank_cmp(&bandwidth, &other), 0);
+}
+
+static void pci_p2pdma_direct_rank_test(struct kunit *test)
+{
+	struct pci_dev *provider = hmat_add_root_device(test, 0);
+	struct device *clients[] = { &provider->dev };
+	struct pci_p2pdma_rank rank;
+
+	KUNIT_ASSERT_EQ(test,
+			pci_p2pdma_rank_many(provider, clients,
+					       ARRAY_SIZE(clients), false, &rank),
+			0);
+	KUNIT_EXPECT_EQ(test, rank.type, PCI_P2PDMA_RANK_DIRECT);
+	KUNIT_EXPECT_EQ(test, rank.distance, 0);
+}
+
+static void pci_p2pdma_distance_rank_fallback_test(struct kunit *test)
+{
+	struct pci_dev *provider = hmat_add_root_device(test, 0);
+	struct pci_dev *client = hmat_add_root_device(test, 1);
+	struct device *clients[] = { &client->dev };
+	struct pci_p2pdma_rank rank;
+
+	kunit_activate_static_stub(test, cpu_supports_p2pdma,
+				   cpu_supports_p2pdma_true_stub);
+
+	KUNIT_ASSERT_EQ(test,
+			pci_p2pdma_rank_many(provider, clients,
+					       ARRAY_SIZE(clients), false, &rank),
+			0);
+	KUNIT_EXPECT_EQ(test, rank.type, PCI_P2PDMA_RANK_DISTANCE);
+	KUNIT_EXPECT_EQ(test, rank.distance, 2);
+}
+
 static struct kunit_case pci_p2pdma_hmat_test_cases[] = {
 	KUNIT_CASE_PARAM(pci_p2pdma_hmat_route_test, hmat_route_gen_params),
+	KUNIT_CASE_PARAM(pci_p2pdma_hmat_rank_many_test, hmat_rank_gen_params),
+	KUNIT_CASE(pci_p2pdma_hmat_rank_compare_test),
+	KUNIT_CASE(pci_p2pdma_direct_rank_test),
+	KUNIT_CASE(pci_p2pdma_distance_rank_fallback_test),
 	{}
 };
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7a44158fdbd0..9872e081ec07 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1092,6 +1092,22 @@ enum pci_acs_p2pdma_state {
 	PCI_ACS_P2PDMA_NOT_SUPPORTED,	/* no usable peer-to-peer route */
 };
 
+/* Provider rank classes, ordered from most to least preferable. */
+enum pci_p2pdma_rank_type {
+	PCI_P2PDMA_RANK_DIRECT,
+	PCI_P2PDMA_RANK_HMAT_BANDWIDTH,
+	PCI_P2PDMA_RANK_HMAT_LATENCY,
+	PCI_P2PDMA_RANK_DISTANCE,
+};
+
+struct pci_p2pdma_rank {
+	enum pci_p2pdma_rank_type type;
+	u32 bandwidth;
+	u32 latency;
+	int distance;
+	bool latency_valid;
+};
+
 #if IS_ENABLED(CONFIG_KUNIT)
 bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags,
 			   enum pci_acs_scope scope);
@@ -1103,6 +1119,11 @@ enum pci_p2pdma_map_type calc_map_type_and_dist(struct pci_dev *provider,
 						int *dist, bool verbose);
 int pci_host_bridge_pxm(struct pci_dev *pdev);
 bool cpu_supports_p2pdma(void);
+int pci_p2pdma_rank_many(struct pci_dev *provider, struct device **clients,
+			 int num_clients, bool verbose,
+			 struct pci_p2pdma_rank *rank);
+int pci_p2pdma_rank_cmp(const struct pci_p2pdma_rank *a,
+			const struct pci_p2pdma_rank *b);
 #endif
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags,

-- 
2.55.0

