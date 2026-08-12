Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89036896D;
	Wed, 12 Aug 2026 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564111; cv=none; b=PQaSlSxIHGTAv2oPOKc7p7LeWsB73BlikAzVBTQemjZ0jkqLoryyu3RH+zM/hUb4F4oE9lulPplE41TGS1JmFyuXBWgB7hCDBPcJcN+Y6+bJTnRe7xXj02UtzkQbms8OkISOx00xE45o0+9HnFtW5dlNm1pf3Buc+ibCFf7Qnjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564111; c=relaxed/simple;
	bh=fEtgMtkcQxa2uu2wrLhm/TD6VH8teU39GMQrAUjUteA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAq14c3q+2hDQQwjEYytra1LD0sUBLqq38SECDaZmLsZl+QXPcHHEOj6Hsf/VPGe2ya2UWrhlMh+tOvazJuCmDjFXp9SQXoUwmNBZIqJNygukBUT50dVNHCn3MIeq1vG+qW5IE1sItNB7NeCjmsRxK6ufcZCNnxwotDNQ5jRYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKYiWHIV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKYiWHIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF13D1F000E9;
	Wed, 12 Aug 2026 19:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564108;
	bh=ZVWghNNfMlbJ1t03M2/ZDMCqImXxQpSEwZp796JKiBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jKYiWHIVlnHarP9reQd6VyjuHSj8RM0EiwPRoLl2xI3kDs+MQs06fiHN45g9kbXpj
	 2yc6n8A4jCEtNz7x6xG0CGJwopGjKZdbcJd6tYGXanX0LBSk/OrZz9SWLzhqTtTXml
	 I8ZjvMyoHjBn74rtLV9GkpefZT8yF01+czAk7/UCYPpCiVJAfue6F6N4D0PmDWkzTN
	 pyENmq78//Edtc1YA5kEJqUhDfGeV1f+LexPXRnjljn1BinjXkSqyYK689s6D4nEEp
	 3uvwxjnbV2NfL0aMTwCXD2NGvheyhHuubGNgBHJT/HYS5Mm3Sz64YciIxHY/pLWaRj
	 NNY4/8d7UVOhg==
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
Subject: [PATCH RFC 4/7] PCI/P2PDMA: Prefer providers with better HMAT performance
Date: Wed, 12 Aug 2026 22:47:41 +0300
Message-ID: <20260812-hmat-p2p-v1-4-75ac41380585@nvidia.com>
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

Provider selection uses PCI hop count as a performance proxy. That can
choose a slower cross-host-bridge path when another reachable provider is
topologically farther but offers more bandwidth or lower latency.

Rank providers reachable entirely through direct routing ahead of any
host-bridge path, then compare host-bridge paths by their worst
ordered-traffic bandwidth and latency across all clients. Hop distance
orders providers within a rank and breaks the remaining ties. Selection
therefore also changes where firmware publishes nothing, because direct
routing now outranks a shorter host-bridge path.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 254 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 190 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index dd300d2e9887..88119620890f 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -69,6 +69,22 @@ struct pci_p2pdma_pagemap {
 	struct p2pdma_provider *mem;
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
 static struct pci_p2pdma_pagemap *to_p2p_pgmap(struct dev_pagemap *pgmap)
 {
 	return container_of(pgmap, struct pci_p2pdma_pagemap, pgmap);
@@ -770,10 +786,14 @@ static int pci_host_bridge_pxm(struct pci_dev *pdev)
  * completer, so the client's host bridge is the HMAT initiator and the
  * provider's host bridge is the HMAT target. UIO-only paths are described by
  * firmware but are not (yet) used to authorize ordered DMA.
+ *
+ * @coord may be NULL when only the authorization answer is needed.
  */
-static bool host_bridge_hmat_p2p(struct pci_dev *provider, struct pci_dev *client)
+static bool host_bridge_hmat_p2p(struct pci_dev *provider,
+				 struct pci_dev *client,
+				 struct access_coordinate *coord)
 {
-	struct access_coordinate coord;
+	struct access_coordinate unused;
 	int init_pxm, targ_pxm;
 
 	init_pxm = pci_host_bridge_pxm(client);
@@ -782,7 +802,7 @@ static bool host_bridge_hmat_p2p(struct pci_dev *provider, struct pci_dev *clien
 		return false;
 
 	return acpi_get_p2p_coordinates(init_pxm, targ_pxm, HMAT_P2P_NON_UIO,
-					&coord) == 0;
+					coord ? coord : &unused) == 0;
 }
 
 static unsigned long map_types_idx(struct pci_dev *client)
@@ -790,6 +810,10 @@ static unsigned long map_types_idx(struct pci_dev *client)
 	return (pci_domain_nr(client->bus) << 16) | pci_dev_id(client);
 }
 
+static enum pci_p2pdma_map_type
+__calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
+		int *dist, bool verbose, struct access_coordinate *hmat_coord);
+
 /*
  * Calculate the P2PDMA mapping type and distance between two PCI devices.
  *
@@ -820,21 +844,29 @@ static unsigned long map_types_idx(struct pci_dev *client)
  * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE. Otherwise, return
  * PCI_P2PDMA_MAP_BUS_ADDR.
  *
- * Any two devices that have a data path that goes through the host bridge
- * will consult a whitelist. If the host bridge is in the whitelist, return
- * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE with the distance set to the number of
- * ports per above. If the device is not in the whitelist, return
- * PCI_P2PDMA_MAP_NOT_SUPPORTED.
+ * Any two devices that have a data path through a host bridge require
+ * platform support from the CPU, the host bridge whitelist, or a reachable
+ * ordered HMAT path. Return PCI_P2PDMA_MAP_NOT_SUPPORTED when none of those
+ * sources permits the path.
  */
 VISIBLE_IF_KUNIT enum pci_p2pdma_map_type
 calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool verbose)
+{
+	return __calc_map_type_and_dist(provider, client, dist, verbose, NULL);
+}
+
+static enum pci_p2pdma_map_type
+__calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
+		int *dist, bool verbose, struct access_coordinate *hmat_coord)
 {
 	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
 	struct pci_dev *a = provider, *b = client, *bb, *target;
 	struct pci_dev *a_child = NULL, *b_child = NULL;
 	struct pci_dev *acs_unsupported = NULL;
 	enum pci_acs_p2pdma_state state;
+	bool host_bridge_allowed;
+	bool hmat_p2p = false;
 	struct pci_p2pdma *p2pdma;
 	struct seq_buf acs_list;
 	int acs_redirect_cnt = 0;
@@ -842,6 +874,9 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	int dist_b = 0;
 	char buf[128];
 
+	if (hmat_coord)
+		*hmat_coord = (struct access_coordinate) {};
+
 	seq_buf_init(&acs_list, buf, sizeof(buf));
 
 	/*
@@ -941,12 +976,22 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	}
 
 map_through_host_bridge:
-	if (!cpu_supports_p2pdma() &&
-	    !host_bridge_hmat_p2p(provider, client) &&
-	    !host_bridge_whitelist(provider, client, verbose)) {
-		if (verbose)
+	host_bridge_allowed = cpu_supports_p2pdma() ||
+			      host_bridge_whitelist(provider, client,
+						    false);
+	/*
+	 * The coordinates are only used to rank providers, which happens in
+	 * process context. Skip the firmware lookup on the mapping path once
+	 * the CPU or the whitelist has already permitted the path.
+	 */
+	if (hmat_coord || !host_bridge_allowed)
+		hmat_p2p = host_bridge_hmat_p2p(provider, client, hmat_coord);
+	if (!host_bridge_allowed && !hmat_p2p) {
+		if (verbose) {
+			host_bridge_whitelist(provider, client, true);
 			pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge, whitelisted host bridge, or HMAT-described P2P path\n",
 				 pci_name(provider));
+		}
 		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}
 done:
@@ -966,32 +1011,53 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 }
 EXPORT_SYMBOL_IF_KUNIT(calc_map_type_and_dist);
 
-/**
- * pci_p2pdma_distance_many - Determine the cumulative distance between
- *	a p2pdma provider and the clients in use.
- * @provider: p2pdma provider to check against the client list
- * @clients: array of devices to check (NULL-terminated)
- * @num_clients: number of clients in the array
- * @verbose: if true, print warnings for devices when we return -1
- *
- * Returns -1 if any of the clients are not compatible, otherwise returns a
- * positive number where a lower number is the preferable choice. (If there's
- * one client that's the same as the provider it will return 0, which is best
- * choice).
- *
- * "compatible" means the provider and the clients are either all behind
- * the same PCI root port or the host bridges connected to each of the devices
- * are listed in the 'pci_p2pdma_whitelist'.
+static int
+pci_p2pdma_rank_cmp(const struct pci_p2pdma_rank *a,
+		    const struct pci_p2pdma_rank *b)
+{
+	if (a->type != b->type)
+		return a->type < b->type ? -1 : 1;
+
+	if (a->type == PCI_P2PDMA_RANK_HMAT_BANDWIDTH) {
+		if (a->bandwidth != b->bandwidth)
+			return a->bandwidth > b->bandwidth ? -1 : 1;
+		if (a->latency_valid != b->latency_valid)
+			return a->latency_valid ? -1 : 1;
+	}
+
+	if ((a->type == PCI_P2PDMA_RANK_HMAT_LATENCY ||
+	     a->latency_valid) && a->latency != b->latency)
+		return a->latency < b->latency ? -1 : 1;
+
+	if (a->distance != b->distance)
+		return a->distance < b->distance ? -1 : 1;
+
+	return 0;
+}
+
+/*
+ * P2P bandwidth is limited by the slowest direction and client path, while
+ * the largest latency bounds the worst path. Only compare a metric when every
+ * host-bridge path supplies both its read and write values.
  */
-int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
-			     int num_clients, bool verbose)
+static int
+pci_p2pdma_rank_many(struct pci_dev *provider, struct device **clients,
+		     int num_clients, bool verbose,
+		     struct pci_p2pdma_rank *rank)
 {
 	enum pci_p2pdma_map_type map;
+	struct access_coordinate coord;
+	bool bandwidth_valid = true;
+	bool latency_valid = true;
+	bool through_host_bridge = false;
 	bool not_supported = false;
 	struct pci_dev *pci_client;
-	int total_dist = 0;
 	int i, distance;
 
+	*rank = (struct pci_p2pdma_rank) {
+		.bandwidth = UINT_MAX,
+	};
+
 	if (num_clients == 0)
 		return -1;
 
@@ -1004,24 +1070,81 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 			return -1;
 		}
 
-		map = calc_map_type_and_dist(provider, pci_client, &distance,
-					     verbose);
+		map = __calc_map_type_and_dist(provider, pci_client, &distance,
+					       verbose, &coord);
 
 		pci_dev_put(pci_client);
 
 		if (map == PCI_P2PDMA_MAP_NOT_SUPPORTED)
 			not_supported = true;
+		else if (map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
+			through_host_bridge = true;
+			if (!coord.read_bandwidth || !coord.write_bandwidth) {
+				bandwidth_valid = false;
+			} else {
+				rank->bandwidth = min(rank->bandwidth,
+					min(coord.read_bandwidth,
+					    coord.write_bandwidth));
+			}
+
+			if (!coord.read_latency || !coord.write_latency) {
+				latency_valid = false;
+			} else {
+				rank->latency = max(rank->latency,
+					max(coord.read_latency,
+					    coord.write_latency));
+			}
+		}
 
 		if (not_supported && !verbose)
 			break;
 
-		total_dist += distance;
+		rank->distance += distance;
 	}
 
 	if (not_supported)
 		return -1;
 
-	return total_dist;
+	if (!through_host_bridge) {
+		rank->type = PCI_P2PDMA_RANK_DIRECT;
+	} else if (bandwidth_valid) {
+		rank->type = PCI_P2PDMA_RANK_HMAT_BANDWIDTH;
+		rank->latency_valid = latency_valid;
+	} else if (latency_valid) {
+		rank->type = PCI_P2PDMA_RANK_HMAT_LATENCY;
+		rank->latency_valid = true;
+	} else {
+		rank->type = PCI_P2PDMA_RANK_DISTANCE;
+	}
+
+	return 0;
+}
+
+/**
+ * pci_p2pdma_distance_many - Determine the cumulative distance between
+ *	a p2pdma provider and the clients in use.
+ * @provider: p2pdma provider to check against the client list
+ * @clients: array of devices to check (NULL-terminated)
+ * @num_clients: number of clients in the array
+ * @verbose: if true, print warnings for devices when we return -1
+ *
+ * Returns -1 if any of the clients are not compatible, otherwise returns a
+ * positive number where a lower number is the preferable choice. (If there's
+ * one client that's the same as the provider it will return 0, which is best
+ * choice).
+ *
+ * "compatible" means the provider and the clients have a direct PCI path or
+ * the platform permits the transaction through the host bridge.
+ */
+int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
+			     int num_clients, bool verbose)
+{
+	struct pci_p2pdma_rank rank;
+
+	if (pci_p2pdma_rank_many(provider, clients, num_clients, verbose, &rank))
+		return -1;
+
+	return rank.distance;
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_distance_many);
 
@@ -1049,15 +1172,15 @@ static bool pci_has_p2pmem(struct pci_dev *pdev)
 
 /**
  * pci_p2pmem_find_many - find a peer-to-peer DMA memory device compatible with
- *	the specified list of clients and shortest distance
+ *	the specified list of clients
  * @clients: array of devices to check (NULL-terminated)
  * @num_clients: number of client devices in the list
  *
- * If multiple devices are behind the same switch, the one "closest" to the
- * client devices in use will be chosen first. (So if one of the providers is
- * the same as one of the clients, that provider will be used ahead of any
- * other providers that are unrelated). If multiple providers are an equal
- * distance away, one will be chosen at random.
+ * A provider with direct paths to all clients is preferred. For paths through
+ * host bridges, complete ordered HMAT bandwidth is ranked before latency-only
+ * data, using the worst client path for each metric. Topology distance breaks
+ * performance ties and remains the fallback when HMAT data is incomplete. If
+ * multiple providers have an equal rank, one is chosen at random.
  *
  * Returns a pointer to the PCI device with a reference taken (use pci_dev_put
  * to return the reference) or NULL if no compatible device is found. The
@@ -1066,47 +1189,50 @@ static bool pci_has_p2pmem(struct pci_dev *pdev)
 struct pci_dev *pci_p2pmem_find_many(struct device **clients, int num_clients)
 {
 	struct pci_dev *pdev = NULL;
-	int distance;
-	int closest_distance = INT_MAX;
-	struct pci_dev **closest_pdevs;
+	struct pci_p2pdma_rank rank, best_rank;
+	struct pci_dev **best_pdevs;
+	bool have_best = false;
 	int dev_cnt = 0;
-	const int max_devs = PAGE_SIZE / sizeof(*closest_pdevs);
-	int i;
+	const int max_devs = PAGE_SIZE / sizeof(*best_pdevs);
+	int cmp, i;
 
-	closest_pdevs = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!closest_pdevs)
+	best_pdevs = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!best_pdevs)
 		return NULL;
 
 	for_each_pci_dev(pdev) {
 		if (!pci_has_p2pmem(pdev))
 			continue;
 
-		distance = pci_p2pdma_distance_many(pdev, clients,
-						    num_clients, false);
-		if (distance < 0 || distance > closest_distance)
-			continue;
-
-		if (distance == closest_distance && dev_cnt >= max_devs)
+		if (pci_p2pdma_rank_many(pdev, clients, num_clients, false,
+					  &rank))
 			continue;
 
-		if (distance < closest_distance) {
-			for (i = 0; i < dev_cnt; i++)
-				pci_dev_put(closest_pdevs[i]);
-
-			dev_cnt = 0;
-			closest_distance = distance;
+		if (have_best) {
+			cmp = pci_p2pdma_rank_cmp(&rank, &best_rank);
+			if (cmp > 0 || (!cmp && dev_cnt >= max_devs))
+				continue;
+			if (cmp < 0) {
+				for (i = 0; i < dev_cnt; i++)
+					pci_dev_put(best_pdevs[i]);
+				dev_cnt = 0;
+				best_rank = rank;
+			}
+		} else {
+			best_rank = rank;
+			have_best = true;
 		}
 
-		closest_pdevs[dev_cnt++] = pci_dev_get(pdev);
+		best_pdevs[dev_cnt++] = pci_dev_get(pdev);
 	}
 
 	if (dev_cnt)
-		pdev = pci_dev_get(closest_pdevs[get_random_u32_below(dev_cnt)]);
+		pdev = pci_dev_get(best_pdevs[get_random_u32_below(dev_cnt)]);
 
 	for (i = 0; i < dev_cnt; i++)
-		pci_dev_put(closest_pdevs[i]);
+		pci_dev_put(best_pdevs[i]);
 
-	kfree(closest_pdevs);
+	kfree(best_pdevs);
 	return pdev;
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_find_many);

-- 
2.55.0

