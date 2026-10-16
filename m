Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3433E531AF3;
	Fri, 16 Oct 2026 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167669; cv=fail; b=ZRMrx0Iv0g8WnCmwE7o5SkXZPG0VttjHaB0GMnL5Cgj3Rk3TebluKUBIpjTphV3R/+LfgG2Z9A/01KoRiORdrB4RF2IKnsx/FOawfclYGw0/egeaxxDoCgnKndWOkdtW+ogPn/QsCyQ/k88z1MGWrxXz4IvRVEIy788TSB4LUxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167669; c=relaxed/simple;
	bh=Iwr35sogNloFP23PdJf5CmRSD5/pbqcMNNKRJe4Jn+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKbqbz/rGUYx9l8VGoDWFSplwGg9w8gsP5GZZodkfw8t23UjBWO3JbqSqcoGJdbjc4ABWM/O66Yj96IvV2nOkbPIk7M4Jb/wNoe7GkWtyOMYIipluUJOZhX0s2O9rgXI/1uesc7iLiFcG+x97QHT/6OMK6uXLJE7CE5rYoKLlHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fdTUC+kl; arc=fail smtp.client-ip=52.101.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fdTUC+kl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9bTFhhGltfV5/JN318prOMZVd6GlAIlmUoli3zV3wKjacVvCXrsxTtnX1KXh7nkDCmUhB4jIZnyTKJeKP1KoGp39rW/kLoZQmdkpCyxdfUntBgVBiJuDHupLxCS2+Z5WgPIuurwJJmFepWy7evOjADKBSqeJh+T2xuDxxGUCy/kB4CAMRPiLGvx55P/aHQkuAz2wEK8uL77zroTKfZKostfw3f9VQr179GhNmunhehfGLhCleuOVGegbwmKL8aIlLkOJjPyv/ICBdyn5tMOmSuo+7NiePNtSUrFHEV2xTCuRT2pSEnjSrJQGeeFTJUZZj5aA5gzS/Bb/dRrmYqEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2diCuBstz3Qh87ldsh4eQND7WEF6/CM7QKm2OtIged8=;
 b=clCnM3JpgpSv6DSSReajG5UklxTzNREutM2wIPxVokUnnKBThBARuZIGTudb5jCqtdzLc7G6oWsKyYAtbQLFg3m+wpOsqWJJ8VQ+zGi/cwpOAznJdnJqj9tfvI7oIQgu0DnG7tRnIfxLE3eDruOUNoy9uGNsy/P/B8hLMEZywL/sfDXOPh5aDH989UcxFiJvexal4W0AHv9Xo+lgJH7TmtO/2m83YPUt90CcZNMxErhfkN/4LQl1GhmSkCTsEE7poPjVZf02W6nmytqDv1pDU7ncl+USk3vPihHFMLJvJwbFC4YpPQ991eMdydwux63w0/2+u29lpfmIkAv+Pu0KFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2diCuBstz3Qh87ldsh4eQND7WEF6/CM7QKm2OtIged8=;
 b=fdTUC+klUxb1UVPXxZKrZOLshaLV1207BrO5wcXRm9EeXsJIfngocJZMVTFMEf9E4SMqo3IasKa0SLh6YZNIG954od2Jj2ob0lj9ay6sYGGdoxByj9lJ+UoyFx76vMK7ket8sJxiuWjmNmhLATBZ1V84kvXCOC7SThNBvYUS2muWUOxSbUAU3pQ43dHnUWn0oYKydA2qj2AhWoreGSPYuVHam9xG1Dt4Sd2OdLDwsl/YbWwCvFPU+4Yu6yUWKq1dRR4ZRSWE6UQ4btFXpHwF/aaqXJbst6Lki/epjZWircZmuUg4bO45yqYrdP/SeZcQ8upo8jnDaRqe/kh80/4Mjw==
Received: from BN9PR03CA0887.namprd03.prod.outlook.com (2603:10b6:408:13c::22)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 16:20:53 +0000
Received: from BN7PEPF000000AB.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::83) by BN9PR03CA0887.outlook.office365.com
 (2603:10b6:408:13c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 16:20:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000AB.mail.protection.outlook.com (10.167.245.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:20:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:20:24 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:20:16 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v6 09/31] vfio/pci: Advertise the mmap areas around excluded ranges
Date: Fri, 16 Oct 2026 21:48:16 +0530
Message-ID: <20261016161839.2765592-10-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AB:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 06803f95-0416-414a-7275-08df2ba1730c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	uuQjril3ADG0hcDpBUQXGYu8+Yupx0YOek6pezGf0jluf787FWN8DoI28XMXCAvwaFG+DEwxPfz8gj5r0ose0lxBY8k2k9CIQIFO82N+woE+f22zFhb/rLoQympKt9L8aNtK3Pq8612O6YLIAF192XlTq8RA/LgbkGTDY2zBeOn9oE58Yg/PzI5nfsPglHK8KkHgzqL8B+9uCcMu62DPs0J7+S96Qd0QOakqwtHSssKd83NIwPFt/3DVc6FjBdeQh4z+L/L6sl6Mhs4biA9SqKr7YucljawcTjr+0nAUijgQZ51wcRZp76zaI20wRJGQo4EqvyPTsYuy5lCPb536NFJ4cWWCg7kCVkUnv10Fu3C4kgW7XnS+z8JKj2ro68YwozcuHKBmeZjL9JETqbdaKqSz0jF6FyVMEDPIXD+GsUShOzF7TAwDxhPlqCvxw/RJPBCFq0JxTM1AKFDEw5giBRuj8j8dOl2yM8vbmlO+OCNn4Etd6UXq1rF8za6yY1A8JG+h1GViW5qiPoqVlFVJZSyLvFX06FMCT/8dVfRg62DROk0TT0YVmAb37S8gRBzCPQPWZBfB7ciDK+hL3sDELDdUM2DnfTLfZXBmuOsmMpDnJXYyakkSId5Q2NHzIGiByMqyg+wSR5sOY7DD8/9iBe6BND8ujhFefBJKBJ3i9n9zwe/8dvITL11+JEqmd48PQiSNdDPz8dlN2qzJKeZ8P32blRDpUbnz51l/3zfGg83Ykj/WvSMC4SAhGXaJPK/j
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q5SBqJ0FeFgTrQWCZwyp1rW+Yk3LrnL78CUam3xOeYPpWV0d4J1nzd/piqV/fWalSoGw5zvYAk82E2ylLqB8OednKEFGseg6IfvJFLB5ozSWEJnUqLZWx8bX8ZZ1t7It1NpsqbpdkcZT4DfvYD2Oz7a6qENILeiCzxjPYxjzjLvFUhyg1QEdMZVFxdc+2GN66HJviPE2aAcXGAs/odmV86ifMxq8mzxtT5y5m88ltL/C179fp9Vp1tCfX2oEl1HNK6aAPL/goczHIVNel33K8gJAK1MGRWBFtl0ixCzQgwZPJseNrKktUIp4mclFLjXvBmY/GQTd/mbEpOpQlct3tPL6Il8/9mvpn26x98VeOl6hy3SAUtrN16FFvE2UAgzCaWfDrUal1493vFJtZ4zp7zp8LXeLdcIrktllD8SRus9vYJjyfxdB+jZYN5aYX/43
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:20:52.7956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06803f95-0416-414a-7275-08df2ba1730c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000AB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558

From: Manish Honap <mhonap@nvidia.com>

A range excluded from mmap must not be reachable through an mmap of its
BAR. Refuse an mmap that overlaps such a range, and advertise the BAR
with a sparse mmap capability that lists the areas between the excluded
ranges, so a VMM maps those and traps the rest.

mmap is page granular, so each range is rounded out to whole pages, and
ranges that meet after rounding form one hole. The sorted list gives the
areas in two walks: the first counts them and the second fills them.

A BAR without mmap-excluded ranges gets no new capability. The MSI-X
table is excluded from read and write only, so the MSI-X BAR is
unchanged.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 91 ++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index bee3d1b4d8d2..f099a294af34 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1106,6 +1106,88 @@ static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev)
 	}
 }
 
+/* True when [start, start + len) on @bar overlaps a range with any of @flags. */
+static bool vfio_pci_bar_range_excluded(struct vfio_pci_core_device *vdev,
+					int bar, u64 start, u64 len, u32 flags)
+{
+	struct vfio_pci_excluded_range *range;
+
+	/* Only BARs have excluded ranges; a device-specific region has none. */
+	if (bar >= PCI_STD_NUM_BARS)
+		return false;
+
+	list_for_each_entry(range, &vdev->excluded_ranges[bar], entry) {
+		if (range->start >= start + len)
+			break;
+		if ((range->flags & flags) &&
+		    start < range->start + range->size)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Advertise a BAR with mmap-excluded ranges as the mmap-able areas between
+ * them. mmap is page granular, so each range is rounded out to whole pages;
+ * ranges that meet after rounding merge into one hole. The first walk counts
+ * the areas and the second fills them.
+ */
+static int vfio_pci_excluded_sparse_cap(struct vfio_pci_core_device *vdev,
+					int bar, struct vfio_info_cap *caps)
+{
+	struct vfio_region_info_cap_sparse_mmap *sparse __free(kfree) = NULL;
+	u64 bar_len = pci_resource_len(vdev->pdev, bar);
+	struct vfio_pci_excluded_range *range;
+	u32 nr_areas = 0;
+	bool holes = false;
+	u64 pos = 0;
+	u32 i = 0;
+
+	list_for_each_entry(range, &vdev->excluded_ranges[bar], entry) {
+		if (!(range->flags & VFIO_PCI_EXCLUDE_MMAP))
+			continue;
+		holes = true;
+		if (ALIGN_DOWN(range->start, PAGE_SIZE) > pos)
+			nr_areas++;
+		pos = max(pos, ALIGN(range->start + range->size, PAGE_SIZE));
+	}
+	if (!holes)
+		return 0;
+	if (pos < bar_len)
+		nr_areas++;
+
+	sparse = kzalloc_flex(*sparse, areas, nr_areas);
+	if (!sparse)
+		return -ENOMEM;
+
+	sparse->header.id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
+	sparse->header.version = 1;
+	sparse->nr_areas = nr_areas;
+
+	pos = 0;
+	list_for_each_entry(range, &vdev->excluded_ranges[bar], entry) {
+		u64 hole = ALIGN_DOWN(range->start, PAGE_SIZE);
+
+		if (!(range->flags & VFIO_PCI_EXCLUDE_MMAP))
+			continue;
+		if (hole > pos)
+			sparse->areas[i++] = (struct vfio_region_sparse_mmap_area) {
+				.offset = pos,
+				.size = hole - pos,
+			};
+		pos = max(pos, ALIGN(range->start + range->size, PAGE_SIZE));
+	}
+	if (pos < bar_len)
+		sparse->areas[i] = (struct vfio_region_sparse_mmap_area) {
+			.offset = pos,
+			.size = bar_len - pos,
+		};
+
+	return vfio_info_add_capability(caps, &sparse->header,
+					struct_size(sparse, areas, nr_areas));
+}
+
 int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      unsigned int type, unsigned int subtype,
 				      const struct vfio_pci_regops *ops,
@@ -1254,6 +1336,10 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 				if (ret)
 					return ret;
 			}
+			ret = vfio_pci_excluded_sparse_cap(vdev, info->index,
+							   caps);
+			if (ret)
+				return ret;
 		}
 
 		break;
@@ -1947,6 +2033,11 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	if (req_start + req_len > phys_len)
 		return -EINVAL;
 
+	/* An excluded sub-range is reachable only through its trap, not mmap. */
+	if (vfio_pci_bar_range_excluded(vdev, index, req_start, req_len,
+					VFIO_PCI_EXCLUDE_MMAP))
+		return -EINVAL;
+
 	/*
 	 * Ensure the BAR resource region is reserved for use.
 	 */
-- 
2.53.0

