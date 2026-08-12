Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D080351C27;
	Wed, 12 Aug 2026 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564100; cv=none; b=hKsfs0lA28mnIDclfEEGNVCRxgkdWq7xykjTLrCKblTd4EazEIziCZlS20BvAPmfLNE4i0Tx1oxD5kGsOaStj152FKhBC5EvN8+wPHZK+li/8bq1dbk0lWNhcR4HL/KthxarN1s8R2RVjQhU8gmEORWk9hFkdQ+uhM5hvK8huPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564100; c=relaxed/simple;
	bh=UkuHIxK4JzyvXLRO1RgsScr6AkV1h0bdZwGopMCDE3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvyHGV6WtmqUBJUHOodA2cUsWYbe6FMOsJWZ/o9uueCyELLXBwmJtxAomH1vGzDiO/8oYdFWReVmXgx+5e5O4pyPOoJKdfv6PANbLqK+mXUiV0Vatsu/PRmSaBS04mhcGiYmQj44HZH1W6cytJhacSBwFbSAcDuPSV4hWw6A1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az55mce1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az55mce1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3961F000E9;
	Wed, 12 Aug 2026 19:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564098;
	bh=4iTSyGgndBWruLqbKNgcq2CSPM7U/z4qzLP7GhyYcWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Az55mce18xdGRkz3prmpBgVHWR7QDeoSKhIHNKvh6kww05tseynnDPZKpsVFbap2E
	 lIShl+DRdZt/V2KpH9Cgc1m61IDgZksOeZ9cyGe4G4mBzBtTq3EWviye9ZbFGHA7cZ
	 o5fVgGQSViz1hNgfnKNNcU0int2z6QPbRrdbPUwBPZR4wMNs3N1hBBGnrernOxQbbd
	 TAXmPusSUqvRrYgbAWtdDfXaWsRNuICjRtnDyZV3l/w1B1F//k4b7HS/TV4+Y+UVj8
	 v6CPuinyujFHykYlTGbrXr9lzeM9B05PJC/oSxUVaN5X8KNCffPsAd2d6cRbfbhN36
	 WQdkJWDOKrnOQ==
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
Subject: [PATCH RFC 2/7] ACPI: HMAT: Make PCIe P2P paths available to consumers
Date: Wed, 12 Aug 2026 22:47:39 +0300
Message-ID: <20260812-hmat-p2p-v1-2-75ac41380585@nvidia.com>
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

P2PDMA policy must preserve the direction, ordering requirements, and
reachability described by HMAT Type 3. A path may work in only one
direction or only with Unordered I/O, and a path the platform does not
describe must never authorize ordinary DMA.

Record each Generic Port pair and traffic class independently, reporting a
pair firmware never mentions separately from a pair it describes without a
usable value. Entries that normalize to zero, whether the platform encodes
no path or publishes no number, both mean no path, so consumers fail
closed.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/acpi/numa/hmat.c | 204 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |  26 ++++++
 2 files changed, 230 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 9792dc394756..d06a62b38fff 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -37,6 +37,7 @@ void __init disable_hmat(void)
 static LIST_HEAD(targets);
 static LIST_HEAD(initiators);
 static LIST_HEAD(localities);
+static LIST_HEAD(p2p_localities);
 
 static DEFINE_MUTEX(target_lock);
 
@@ -87,6 +88,21 @@ struct memory_locality {
 	struct acpi_hmat_locality *hmat_loc;
 };
 
+/*
+ * PCIe peer-to-peer access coordinates between two generic ports (PCIe host
+ * bridges), keyed by their initiator and target proximity domains. A separate
+ * set of coordinates is kept for ordered (non-UIO) and Unordered I/O (UIO)
+ * traffic, as described by the HMAT PCIe P2P Latency and Bandwidth Information
+ * Structure.
+ */
+struct memory_p2p_locality {
+	struct list_head node;
+	int initiator;
+	int target;
+	unsigned int valid;	/* bitmap of populated enum hmat_p2p_class */
+	struct access_coordinate coord[HMAT_P2P_MAX];
+};
+
 static struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
 {
 	struct memory_initiator *initiator;
@@ -191,6 +207,81 @@ int acpi_get_genport_coordinates(u32 uid,
 }
 EXPORT_SYMBOL_NS_GPL(acpi_get_genport_coordinates, "CXL");
 
+/**
+ * acpi_get_genport_proximity_domain - Retrieve the proximity domain of a
+ *				       generic port
+ * @uid: ACPI unique id of the generic port (typically a PCIe host bridge)
+ *
+ * The targets list is built while parsing SRAT during boot and is never
+ * modified afterwards, and both gen_port_device_handle and memory_pxm are
+ * written once by alloc_genport_target() and alloc_target(). So this
+ * takes no target_lock, unlike acpi_get_genport_coordinates() which reads
+ * target->coord[] that hmat_calculate_adistance() updates at runtime. PCI
+ * P2PDMA calls this from the DMA mapping path, which must not sleep.
+ *
+ * Return: the proximity domain on success, negative errno on failure.
+ */
+int acpi_get_genport_proximity_domain(u32 uid)
+{
+	struct memory_target *target;
+
+	target = acpi_find_genport_target(uid);
+	if (!target)
+		return -ENOENT;
+
+	return target->memory_pxm;
+}
+EXPORT_SYMBOL_GPL(acpi_get_genport_proximity_domain);
+
+/*
+ * The p2p_localities list is fully populated while parsing the HMAT during
+ * boot and is never modified afterwards, so runtime readers below walk it
+ * without holding target_lock.
+ */
+static struct memory_p2p_locality *find_p2p_locality(int initiator, int target)
+{
+	struct memory_p2p_locality *loc;
+
+	list_for_each_entry(loc, &p2p_localities, node)
+		if (loc->initiator == initiator && loc->target == target)
+			return loc;
+	return NULL;
+}
+
+static bool p2p_coord_populated(const struct access_coordinate *coord)
+{
+	return coord->read_bandwidth || coord->write_bandwidth ||
+	       coord->read_latency || coord->write_latency;
+}
+
+/**
+ * acpi_get_p2p_coordinates - Retrieve the P2P access coordinates between two
+ *			      generic ports (PCIe host bridges)
+ * @initiator_pxm: proximity domain of the initiating generic port
+ * @target_pxm: proximity domain of the target generic port
+ * @class: traffic class (ordered/non-UIO or UIO)
+ * @coord: the access coordinates written back on success
+ *
+ * Return: 0 on success, -ENOENT if the firmware describes no entry for the
+ * pair, or -ENODATA if the described path is unreachable for @class.
+ */
+int acpi_get_p2p_coordinates(int initiator_pxm, int target_pxm,
+			     enum hmat_p2p_class class,
+			     struct access_coordinate *coord)
+{
+	struct memory_p2p_locality *loc;
+
+	loc = find_p2p_locality(initiator_pxm, target_pxm);
+	if (!loc)
+		return -ENOENT;
+	if (!(loc->valid & BIT(class)) || !p2p_coord_populated(&loc->coord[class]))
+		return -ENODATA;
+
+	*coord = loc->coord[class];
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_get_p2p_coordinates);
+
 static __init void alloc_memory_initiator(unsigned int cpu_pxm)
 {
 	struct memory_initiator *initiator;
@@ -479,6 +570,111 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 	return 0;
 }
 
+static void hmat_update_p2p_access(struct access_coordinate *coord,
+				   u8 type, u32 value)
+{
+	switch (type) {
+	case ACPI_HMAT_ACCESS_LATENCY:
+		coord->read_latency = value;
+		coord->write_latency = value;
+		break;
+	case ACPI_HMAT_READ_LATENCY:
+		coord->read_latency = value;
+		break;
+	case ACPI_HMAT_WRITE_LATENCY:
+		coord->write_latency = value;
+		break;
+	case ACPI_HMAT_ACCESS_BANDWIDTH:
+		coord->read_bandwidth = value;
+		coord->write_bandwidth = value;
+		break;
+	case ACPI_HMAT_READ_BANDWIDTH:
+		coord->read_bandwidth = value;
+		break;
+	case ACPI_HMAT_WRITE_BANDWIDTH:
+		coord->write_bandwidth = value;
+		break;
+	default:
+		break;
+	}
+}
+
+static __init void hmat_update_p2p(int initiator, int target, u8 flags,
+				   u8 type, u32 value)
+{
+	struct memory_p2p_locality *loc;
+	enum hmat_p2p_class class;
+
+	loc = find_p2p_locality(initiator, target);
+	if (!loc) {
+		loc = kzalloc_obj(*loc);
+		if (!loc)
+			return;
+		loc->initiator = initiator;
+		loc->target = target;
+		list_add_tail(&loc->node, &p2p_localities);
+	}
+
+	for (class = 0; class < HMAT_P2P_MAX; class++) {
+		if (class == HMAT_P2P_NON_UIO && !(flags & ACPI_HMAT_P2P_NON_UIO))
+			continue;
+		if (class == HMAT_P2P_UIO && !(flags & ACPI_HMAT_P2P_UIO))
+			continue;
+		hmat_update_p2p_access(&loc->coord[class], type, value);
+		loc->valid |= BIT(class);
+	}
+}
+
+static __init int hmat_parse_p2p_latency(union acpi_subtable_headers *header,
+					 const unsigned long end)
+{
+	struct acpi_hmat_p2p_latency *p2p = (void *)header;
+	unsigned int init, targ, total_size, ipds, tpds;
+	u32 *inits, *targs, value;
+	u16 *entries;
+	u8 type, flags;
+
+	if (p2p->header.length < sizeof(*p2p)) {
+		pr_notice("Unexpected P2P header length: %u\n",
+			  p2p->header.length);
+		return -EINVAL;
+	}
+
+	type = p2p->data_type;
+	flags = p2p->flags;
+	ipds = p2p->number_of_initiator_Pds;
+	tpds = p2p->number_of_target_Pds;
+	total_size = sizeof(*p2p) + sizeof(*entries) * ipds * tpds +
+		     sizeof(*inits) * ipds + sizeof(*targs) * tpds;
+	if (p2p->header.length < total_size) {
+		pr_notice("Unexpected P2P header length:%u, minimum required:%u\n",
+			  p2p->header.length, total_size);
+		return -EINVAL;
+	}
+
+	pr_debug("P2P: Flags:%02x Type:%s Initiator Ports:%u Target Ports:%u Base:%lld\n",
+		 p2p->flags, hmat_data_type(type), ipds, tpds,
+		 p2p->entry_base_unit);
+
+	inits = (u32 *)(p2p + 1);
+	targs = inits + ipds;
+	entries = (u16 *)(targs + tpds);
+	for (init = 0; init < ipds; init++) {
+		for (targ = 0; targ < tpds; targ++) {
+			value = hmat_normalize(entries[init * tpds + targ],
+					       p2p->entry_base_unit, type);
+			pr_debug("  Initiator-Target[%u-%u]:%u%s\n",
+				 inits[init], targs[targ], value,
+				 hmat_data_type_suffix(type));
+
+			hmat_update_p2p(inits[init], targs[targ], flags,
+					type, value);
+		}
+	}
+
+	return 0;
+}
+
 static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 				   const unsigned long end)
 {
@@ -603,6 +799,8 @@ static int __init hmat_parse_subtable(union acpi_subtable_headers *header,
 		return hmat_parse_locality(header, end);
 	case ACPI_HMAT_TYPE_CACHE:
 		return hmat_parse_cache(header, end);
+	case ACPI_HMAT_TYPE_P2P_LATENCY:
+		return hmat_parse_p2p_latency(header, end);
 	default:
 		return -EINVAL;
 	}
@@ -1004,6 +1202,7 @@ static __init void hmat_free_structures(void)
 {
 	struct memory_target *target, *tnext;
 	struct memory_locality *loc, *lnext;
+	struct memory_p2p_locality *ploc, *pnext;
 	struct memory_initiator *initiator, *inext;
 	struct target_cache *tcache, *cnext;
 
@@ -1035,6 +1234,11 @@ static __init void hmat_free_structures(void)
 		list_del(&loc->node);
 		kfree(loc);
 	}
+
+	list_for_each_entry_safe(ploc, pnext, &p2p_localities, node) {
+		list_del(&ploc->node);
+		kfree(ploc);
+	}
 }
 
 static __init int hmat_init(void)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 60ab50cb8930..3d1f564213f1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1152,15 +1152,41 @@ static inline int acpi_mrrm_max_mem_region(void)
 
 #endif	/* !CONFIG_ACPI */
 
+/*
+ * PCIe peer-to-peer traffic classes described by an HMAT PCIe P2P Latency
+ * and Bandwidth Information Structure (ACPI_HMAT_TYPE_P2P_LATENCY).
+ */
+enum hmat_p2p_class {
+	HMAT_P2P_NON_UIO,	/* Ordered (non-UIO) P2P traffic */
+	HMAT_P2P_UIO,		/* PCIe Unordered I/O (UIO) P2P traffic */
+	HMAT_P2P_MAX,
+};
+
 #ifdef CONFIG_ACPI_HMAT
 int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
 					resource_size_t *size);
+int acpi_get_genport_proximity_domain(u32 uid);
+int acpi_get_p2p_coordinates(int initiator_pxm, int target_pxm,
+			     enum hmat_p2p_class class,
+			     struct access_coordinate *coord);
 #else
 static inline int hmat_get_extended_linear_cache_size(struct resource *backing_res,
 						      int nid, resource_size_t *size)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int acpi_get_genport_proximity_domain(u32 uid)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int acpi_get_p2p_coordinates(int initiator_pxm, int target_pxm,
+					   enum hmat_p2p_class class,
+					   struct access_coordinate *coord)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 extern void arch_post_acpi_subsys_init(void);

-- 
2.55.0

