Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96AC43B3FD;
	Fri, 21 Aug 2026 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341359; cv=none; b=cj0BsgZ0UNYwwuCnOEsemZLItx5PwueRsqWaunbG6eLvoatVHiOa2SEN/ceIIH1GePyPx1HxYENIGKjwTBRJUEyGORioL0LvH9nWYgbOJj72i5p2hapWTVISwJnBVF56Vs1TAc36aKSf6MWT7JzZmrPpl/Y9bhlJkG8L++X5hVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341359; c=relaxed/simple;
	bh=BVE390WE1G/J4lo03CelSOAT+p2HFody7n5jO7TR1EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLxav7+t25xalhBnWpSvuOr/88mvfuvi0feqB7R/nG9csy5c4vIRlY8SVcNECcJk1z6VQluJNXg5xhlCZRKWE/NbCtOOYnppvvqEZdb06B8cAFcRHog6H9VkDQG8npbBlaCs+QPrmzIbe4r8aqR+REtv9D3FrqEKdBnDfzmh/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIx+LVjR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIx+LVjR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859791F000E9;
	Fri, 21 Aug 2026 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341357;
	bh=7ZiUzRM2SF3TKMzKpLWBveNQMfK8OM/U2pfzGCmgLcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SIx+LVjRWIzFMpxBuFn6pbtjD+Td4VCC7JktDwMTsuCGb9ZgOfYkRCrVaqz9FvfyO
	 wnLc7zIA1vrVa8alzu/IaRe30P3Iprgx9TFschNQz7yR77HJMKZrr1DE91GAUm57aY
	 1o0xTvbZfEIsQkHq6Dg3LxGur3rop6GTWfMIKlZMx1Fgg8oToefVyT8e2Pzg8qBjQZ
	 T1QF5N7uwXZ/Gc8ZUcD6Lbq+bl8ZNK+DdhYBNnWJXJOaRkFYa9AePOAlEqnxZylTQ9
	 7sCv2+K/P4u4Ym9tprCm1tTtK0uocbX+/zGhLfF0eAsT9Vh8nkRQfveaic+8kcjJax
	 vRtajSwbG4qSQ==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>
Subject: [PATCH v4 18/18] PCI/P2PDMA: Log detailed ACS routing diagnostics
Date: Fri, 21 Aug 2026 22:38:49 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-18-94426b96de73@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
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

When a platform rejects a P2PDMA mapping, existing warnings identify only
the final ACS blocker and host bridge result. They do not expose the
complete topology, live ACS settings, divergence ports, cache state, or
intermediate decisions needed to distinguish routing and policy failures.

Emit info-level diagnostics for verbose calculations and cache lookups.
Report both paths, bridge bus ranges, raw and decoded ACS controls, Egress
Control vectors, selected Request and Completion states, host fallback, and
the final mapping. Keep non-verbose distance and KUnit paths quiet.

Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 273 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 259 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index e54901d21d8a..b79eb4ce09f4 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -572,26 +572,200 @@ pci_acs_p2pdma_decision(u16 ctrl, enum pci_acs_p2pdma_tlp tlp,
 }
 EXPORT_SYMBOL_IF_KUNIT(pci_acs_p2pdma_decision);
 
+static const char *pci_acs_p2pdma_state_name(enum pci_acs_p2pdma_state state)
+{
+	switch (state) {
+	case PCI_ACS_P2PDMA_DIRECT:
+		return "direct";
+	case PCI_ACS_P2PDMA_REDIRECT:
+		return "redirect";
+	case PCI_ACS_P2PDMA_NOT_SUPPORTED:
+		return "not-supported";
+	}
+
+	return "invalid";
+}
+
+static const char *pci_p2pdma_map_type_name(enum pci_p2pdma_map_type type)
+{
+	switch (type) {
+	case PCI_P2PDMA_MAP_UNKNOWN:
+		return "unknown";
+	case PCI_P2PDMA_MAP_NONE:
+		return "none";
+	case PCI_P2PDMA_MAP_NOT_SUPPORTED:
+		return "not-supported";
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		return "bus-address";
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		return "through-host-bridge";
+	}
+
+	return "invalid";
+}
+
+static const char *pci_acs_p2pdma_tlp_name(enum pci_acs_p2pdma_tlp tlp)
+{
+	return tlp == PCI_ACS_P2PDMA_TLP_REQUEST ? "request" : "completion";
+}
+
+static int pci_p2pdma_port_number(struct pci_dev *pdev)
+{
+	u32 lnkcap;
+	int ret;
+
+	if (!pci_is_pcie(pdev))
+		return -EOPNOTSUPP;
+
+	ret = pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &lnkcap);
+	if (ret)
+		return pcibios_err_to_errno(ret);
+
+	return FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+}
+
+static void pci_p2pdma_log_egress_vector(struct pci_dev *pdev,
+					 int target_port)
+{
+	unsigned int offset;
+	u32 vector, mask;
+	int ret;
+
+	if (target_port < 0 || target_port > U8_MAX)
+		return;
+
+	offset = pdev->acs_cap + PCI_ACS_EGRESS_CTL_V +
+		 (target_port / 32) * sizeof(vector);
+	mask = BIT(target_port % 32);
+	ret = pci_read_config_dword(pdev, offset, &vector);
+	if (ret) {
+		pci_info(pdev,
+			 "P2PDMA ACS debug: Egress Control Vector read at %#x failed: %#x\n",
+			 offset, ret);
+		return;
+	}
+
+	pci_info(pdev,
+		 "P2PDMA ACS debug: Egress Control Vector offset=%#x value=%#010x bit=%d mask=%#010x set=%u\n",
+		 offset, vector, target_port, mask, !!(vector & mask));
+}
+
 static enum pci_acs_p2pdma_state
 pci_acs_p2pdma_state(struct pci_dev *pdev, struct pci_dev *target,
-		     enum pci_acs_p2pdma_tlp tlp)
+		     enum pci_acs_p2pdma_tlp tlp, bool verbose)
 {
-	int pos, egress = 0;
+	enum pci_acs_p2pdma_state state;
+	bool egress_checked = false;
+	int pos, ret, egress = 0;
+	int target_port = -1;
 	u16 ctrl;
 
 	pos = pdev->acs_cap;
-	if (!pos)
+	if (!pos) {
+		if (verbose)
+			pci_info(pdev,
+				 "P2PDMA ACS debug: %s target=%s has no ACS capability; result=direct\n",
+				 pci_acs_p2pdma_tlp_name(tlp),
+				 target ? pci_name(target) : "<none>");
 		return PCI_ACS_P2PDMA_DIRECT;
+	}
 
-	if (pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl))
+	ret = pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+	if (ret) {
+		if (verbose)
+			pci_info(pdev,
+				 "P2PDMA ACS debug: %s target=%s ACS Control read failed at %#x: %#x; result=not-supported\n",
+				 pci_acs_p2pdma_tlp_name(tlp),
+				 target ? pci_name(target) : "<none>",
+				 pos + PCI_ACS_CTRL, ret);
 		return PCI_ACS_P2PDMA_NOT_SUPPORTED;
+	}
 
 	/* Egress Control applies only to Requests with a known target. */
 	if (tlp == PCI_ACS_P2PDMA_TLP_REQUEST && target &&
-	    (ctrl & PCI_ACS_EC))
+	    (ctrl & PCI_ACS_EC)) {
+		egress_checked = true;
 		egress = pci_acs_egress_ctrl_is_set(pdev, target);
+	}
+
+	state = pci_acs_p2pdma_decision(ctrl, tlp, !!target, egress);
+	if (!verbose)
+		return state;
+
+	if (target)
+		target_port = pci_p2pdma_port_number(target);
+
+	pci_info(pdev,
+		 "P2PDMA ACS debug: %s target=%s target-port=%d same-bus=%u cap=%#x caps=%#06x ctrl=%#06x result=%s\n",
+		 pci_acs_p2pdma_tlp_name(tlp),
+		 target ? pci_name(target) : "<none>", target_port,
+		 target && pdev->bus == target->bus, pos,
+		 pdev->acs_capabilities, ctrl, pci_acs_p2pdma_state_name(state));
+	pci_info(pdev,
+		 "P2PDMA ACS debug: control bits SV=%u TB=%u RR=%u CR=%u UF=%u EC=%u DT=%u\n",
+		 !!(ctrl & PCI_ACS_SV), !!(ctrl & PCI_ACS_TB),
+		 !!(ctrl & PCI_ACS_RR), !!(ctrl & PCI_ACS_CR),
+		 !!(ctrl & PCI_ACS_UF), !!(ctrl & PCI_ACS_EC),
+		 !!(ctrl & PCI_ACS_DT));
+	if (egress_checked)
+		pci_info(pdev,
+			 "P2PDMA ACS debug: Egress Control target=%s port=%d vector-size=%u lookup=%d\n",
+			 pci_name(target), target_port,
+			 pdev->acs_capabilities >> 8, egress);
+	else
+		pci_info(pdev,
+			 "P2PDMA ACS debug: Egress Control vector not consulted for this TLP\n");
+	if (egress_checked && egress >= 0)
+		pci_p2pdma_log_egress_vector(pdev, target_port);
+
+	return state;
+}
+
+static void pci_p2pdma_log_path(const char *name, struct pci_dev *start,
+				struct pci_dev *common)
+{
+	struct pci_dev *pdev, *upstream;
+	int hop = 0, ret, type;
+	u16 ctrl;
+
+	for (pdev = start; pdev; pdev = upstream, hop++) {
+		upstream = pci_upstream_bridge(pdev);
+		type = pci_is_pcie(pdev) ? pci_pcie_type(pdev) : -1;
+		pci_info(pdev,
+			 "P2PDMA ACS debug: %s path hop=%d common=%u pcie=%u type=%d class=%#08x vendor=%04x device=%04x upstream=%s\n",
+			 name, hop, pdev == common, pci_is_pcie(pdev), type,
+			 pdev->class, pdev->vendor, pdev->device,
+			 upstream ? pci_name(upstream) : "<none>");
+
+		if (pdev->subordinate)
+			pci_info(pdev,
+				 "P2PDMA ACS debug: bridge bus range=%02llx-%02llx\n",
+				 (unsigned long long)pdev->subordinate->busn_res.start,
+				 (unsigned long long)pdev->subordinate->busn_res.end);
+
+		if (!pdev->acs_cap) {
+			pci_info(pdev,
+				 "P2PDMA ACS debug: ACS capability absent\n");
+			continue;
+		}
+
+		ret = pci_read_config_word(pdev, pdev->acs_cap + PCI_ACS_CTRL,
+					   &ctrl);
+		if (ret) {
+			pci_info(pdev,
+				 "P2PDMA ACS debug: ACS cap=%#x caps=%#06x Control read failed: %#x\n",
+				 pdev->acs_cap, pdev->acs_capabilities, ret);
+			continue;
+		}
 
-	return pci_acs_p2pdma_decision(ctrl, tlp, !!target, egress);
+		pci_info(pdev,
+			 "P2PDMA ACS debug: ACS cap=%#x caps=%#06x ctrl=%#06x SV=%u TB=%u RR=%u CR=%u UF=%u EC=%u DT=%u\n",
+			 pdev->acs_cap, pdev->acs_capabilities, ctrl,
+			 !!(ctrl & PCI_ACS_SV), !!(ctrl & PCI_ACS_TB),
+			 !!(ctrl & PCI_ACS_RR), !!(ctrl & PCI_ACS_CR),
+			 !!(ctrl & PCI_ACS_UF), !!(ctrl & PCI_ACS_EC),
+			 !!(ctrl & PCI_ACS_DT));
+	}
 }
 
 static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
@@ -792,15 +966,23 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	struct pci_dev *a = provider, *b = client, *bb;
 	struct pci_dev *a_child = NULL, *b_child = NULL;
 	struct pci_dev *acs_unsupported = NULL;
+	struct pci_host_bridge *provider_host, *client_host;
 	enum pci_acs_p2pdma_state state;
 	struct pci_p2pdma *p2pdma;
 	struct seq_buf acs_list;
+	bool cpu_p2pdma, host_whitelisted = false;
+	bool cache_store = false;
 	int acs_redirect_cnt = 0;
 	int dist_a = 0;
 	int dist_b = 0;
 	char buf[128];
 
 	seq_buf_init(&acs_list, buf, sizeof(buf));
+	if (verbose)
+		pci_info(client,
+			 "P2PDMA ACS debug: begin provider=%s client=%s cache-index=%#lx\n",
+			 pci_name(provider), pci_name(client),
+			 map_types_idx(client));
 
 	/*
 	 * Note, we don't need to take references to devices returned by
@@ -832,10 +1014,27 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	 * request can only get to the peer through the host bridge.
 	 */
 	*dist = dist_a + dist_b;
+	if (verbose) {
+		pci_info(client,
+			 "P2PDMA ACS debug: no common upstream bridge provider-distance=%d client-distance=%d total=%d\n",
+			 dist_a, dist_b, *dist);
+		pci_p2pdma_log_path("provider", provider, NULL);
+		pci_p2pdma_log_path("client", client, NULL);
+	}
 	goto map_through_host_bridge;
 
 check_paths_acs:
 	*dist = dist_a + dist_b;
+	if (verbose) {
+		pci_info(client,
+			 "P2PDMA ACS debug: common=%s provider-divergence=%s client-divergence=%s provider-distance=%d client-distance=%d total=%d\n",
+			 pci_name(a),
+			 a_child ? pci_name(a_child) : "<none>",
+			 b_child ? pci_name(b_child) : "<none>",
+			 dist_a, dist_b, *dist);
+		pci_p2pdma_log_path("provider", provider, a);
+		pci_p2pdma_log_path("client", client, a);
+	}
 
 	/*
 	 * ACS P2P routing controls apply where a TLP can route toward the peer
@@ -844,7 +1043,8 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	 */
 	if (a_child && b_child) {
 		state = pci_acs_p2pdma_state(a_child, NULL,
-					     PCI_ACS_P2PDMA_TLP_COMPLETION);
+					     PCI_ACS_P2PDMA_TLP_COMPLETION,
+					     verbose);
 		if (state != PCI_ACS_P2PDMA_DIRECT) {
 			seq_buf_print_bus_devfn(&acs_list, a_child);
 			if (state == PCI_ACS_P2PDMA_REDIRECT)
@@ -854,7 +1054,8 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		}
 
 		state = pci_acs_p2pdma_state(b_child, a_child,
-					     PCI_ACS_P2PDMA_TLP_REQUEST);
+					     PCI_ACS_P2PDMA_TLP_REQUEST,
+					     verbose);
 		if (state != PCI_ACS_P2PDMA_DIRECT) {
 			seq_buf_print_bus_devfn(&acs_list, b_child);
 			if (state == PCI_ACS_P2PDMA_REDIRECT)
@@ -862,6 +1063,9 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 			else if (!acs_unsupported)
 				acs_unsupported = b_child;
 		}
+	} else if (verbose) {
+		pci_info(client,
+			 "P2PDMA ACS debug: peer divergence is incomplete; no ACS peer-routing controls evaluated\n");
 	}
 
 	/*
@@ -894,8 +1098,25 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	}
 
 map_through_host_bridge:
-	if (!cpu_supports_p2pdma() &&
-	    !host_bridge_whitelist(provider, client, verbose)) {
+	cpu_p2pdma = cpu_supports_p2pdma();
+	if (!cpu_p2pdma)
+		host_whitelisted = host_bridge_whitelist(provider, client,
+							  verbose);
+
+	if (verbose) {
+		provider_host = pci_find_host_bridge(provider->bus);
+		client_host = pci_find_host_bridge(client->bus);
+		pci_info(client,
+			 "P2PDMA ACS debug: host fallback cpu-support=%u whitelist=%s provider-host=%s client-host=%s same-host=%u\n",
+			 cpu_p2pdma,
+			 cpu_p2pdma ? "not-consulted" :
+					(host_whitelisted ? "yes" : "no"),
+			 provider_host ? dev_name(&provider_host->dev) : "<none>",
+			 client_host ? dev_name(&client_host->dev) : "<none>",
+			 provider_host && provider_host == client_host);
+	}
+
+	if (!cpu_p2pdma && !host_whitelisted) {
 		if (verbose)
 			pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge or whitelisted host bridge\n",
 				 pci_name(provider));
@@ -910,10 +1131,19 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	 */
 	rcu_read_lock();
 	p2pdma = rcu_dereference(provider->p2pdma);
-	if (p2pdma)
+	if (p2pdma) {
 		xa_store(&p2pdma->map_types, map_types_idx(client),
 			 xa_mk_value(map_type), GFP_ATOMIC);
+		cache_store = true;
+	}
 	rcu_read_unlock();
+	if (verbose)
+		pci_info(client,
+			 "P2PDMA ACS debug: final provider=%s result=%s(%d) distance=%d redirects=%d unsupported=%s cache-store=%u index=%#lx\n",
+			 pci_name(provider), pci_p2pdma_map_type_name(map_type),
+			 map_type, *dist, acs_redirect_cnt,
+			 acs_unsupported ? pci_name(acs_unsupported) : "<none>",
+			 cache_store, map_types_idx(client));
 	return map_type;
 }
 EXPORT_SYMBOL_IF_KUNIT(calc_map_type_and_dist);
@@ -1237,23 +1467,38 @@ enum pci_p2pdma_map_type pci_p2pdma_map_type(struct p2pdma_provider *provider,
 	struct pci_dev *pdev = to_pci_dev(provider->owner);
 	struct pci_dev *client;
 	struct pci_p2pdma *p2pdma;
+	unsigned long cache_index;
+	bool provider_state;
 	int dist;
 
-	if (!pdev->p2pdma)
+	if (!pdev->p2pdma) {
+		pci_info(pdev,
+			 "P2PDMA ACS debug: map lookup rejected; provider state is absent\n");
 		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+	}
 
-	if (!dev_is_pci(dev))
+	if (!dev_is_pci(dev)) {
+		dev_info(dev,
+			 "P2PDMA ACS debug: provider=%s map lookup rejected; client is not PCI\n",
+			 pci_name(pdev));
 		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+	}
 
 	client = to_pci_dev(dev);
+	cache_index = map_types_idx(client);
 
 	rcu_read_lock();
 	p2pdma = rcu_dereference(pdev->p2pdma);
 
 	if (p2pdma)
 		type = xa_to_value(xa_load(&p2pdma->map_types,
-					   map_types_idx(client)));
+					   cache_index));
+	provider_state = !!p2pdma;
 	rcu_read_unlock();
+	pci_info(client,
+		 "P2PDMA ACS debug: map lookup provider=%s index=%#lx cached=%s(%d) provider-state=%u\n",
+		 pci_name(pdev), cache_index, pci_p2pdma_map_type_name(type),
+		 type, provider_state);
 
 	if (type == PCI_P2PDMA_MAP_UNKNOWN)
 		return calc_map_type_and_dist(pdev, client, &dist, true);

-- 
2.55.0

