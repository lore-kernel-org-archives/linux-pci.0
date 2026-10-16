Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F753F6AE;
	Fri, 16 Oct 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167797; cv=fail; b=jhK3R9vosERV66Utx1ahGzGqgRnE6Mpva/i4xC1Kj/H2bzo8HsJ3nqZ2oiWtV4ecL1ayRm0vBLXiZcjwFvdyFcaC/ufoLF8ml7vPjoV2SvrVWfdinNQVq/TjuBACflRFcH+dTBVKFNasRDLjp9Q+rr7CW+L/YHpOhFvZwEHWFd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167797; c=relaxed/simple;
	bh=PGgljUVXzsbZYI3+cyhSWSCNpCkys2gMhe4Zcsi4ZDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AACX9SOD4Wf9++uqdd4xrlh23GIzaBy/fvlXDBOSA2mJYtZ0sJskIiSLIhQDBpdTsZ4e9Mm/B27w3x2MOgEVe0lOGaUqP+qnF3PWjHEDE7lEziQRrI01AT7oZG2OFwCmMYO1iyhfPgJJ9AQ+jTT0rT8zk2zKWyuXECLi2o0Qi6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l/XE8yIv; arc=fail smtp.client-ip=52.101.53.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l/XE8yIv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaCIuJ5TvggbKm7hIl74xocp2WOQv96BsDPvvTgFXp8nez8wZ27LHM86V1U2QsBJT475Obj4UFvWewDzyCFMooPU1NJnOxH5Q1HccjkV98HceR/QDSunOJ+V8jv6S6KHr89bVRSev0NZu0UM/ABYzGojtYzNRk6LO9t0Yu7Gmf3XApfeFi6Wi6fFmoGDvmRO0ElfQp7MCgNlEOJa8ez4xw+uxNazqXvB3S4wjtH6/tbfXREUUGoQbLsQPe18YMXv93vPZhPG5K6JRquAOCi+OUT5XPQiK8/SpNBLcoHU4MpUVZIySAKSG2Z9/d0FODZMV89XvEJ7p9liMGDVh1+WXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjK+JWlM4vXw+Zk29nlP8Me/nFboA/gDr3RGjpMlkto=;
 b=jkcCSxT03AVLgLvxFxtMEvjmlCbGTL8nFirRrCkLBM9n5DUAn0GFA9UOGhcCwkBqiC3ng8kSym1bTq1eTypoDzNy9uSQ4iH9qlIY/twNVC0elDwodwQqZ5EnAJlEpMq4FCdUKtGGnNKBqsqrDwF8d6lwcLKmORDRqpAr4m0aAHFstz139aTAnKMI6/KDYLnCvCSYoe9uodMTfDtOROk9xolyyC5DXSgh7oTLWK4LM4fYxjm2tsuoFgsfdjdw1fa8czGx8+Yl/fSVBjNgc1ICS/BgNZmhzB6iazN1RpgxE4yh5QKFxjxNS+nxcIxCJf/QBmRM6Wvnxj3QmvA0mv5A8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjK+JWlM4vXw+Zk29nlP8Me/nFboA/gDr3RGjpMlkto=;
 b=l/XE8yIv/K1Z2fN8gOzT0Tyil7yg4OlyNvPIpjz0/PO9uZHYvhibMkj5koqPZjiFXxQNQZeIlVgFJ3BGj9dtVuNBU91439mpopROavbdmrnuQKbk68V1p8lHvLl16z/TO7pFZGJ8VpVanCslgK/LhIq0knKCVU1J44gfXPW6OGF2ZGEh+3uHAmTWJXh37496N8XRlcxxYrvGIv9cq9gtpTXmhxWSkda2V3iNj9Gx0qh6MwO94M02dKmvwUsiOSnhQw9GP5tuSqLWuE4F0jgJf41ggqLU72keKfFZEmbQfxMZ15oZDxjciJbLDhU2C0wAfHHJwYtEZZcnGf2H0gkHUQ==
Received: from DS7PR06CA0052.namprd06.prod.outlook.com (2603:10b6:8:54::30) by
 BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.14; Fri, 16 Oct 2026 16:22:58 +0000
Received: from DM3PEPF000265B1.namprd02.prod.outlook.com
 (2603:10b6:8:54:cafe::a2) by DS7PR06CA0052.outlook.office365.com
 (2603:10b6:8:54::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:22:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM3PEPF000265B1.mail.protection.outlook.com (10.167.23.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:22:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:22:29 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:22:20 -0700
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
Subject: [PATCH v6 23/31] vfio/cxl: Contain HDM memory errors with memory_failure()
Date: Fri, 16 Oct 2026 21:48:30 +0530
Message-ID: <20261016161839.2765592-24-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B1:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c4caad-2591-417f-f0c7-08df2ba1bdbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|6133799003|10067099003|22082099003|18002099003|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LSNSnMDmJ7ro75mzomcyNuC6qr6gcy0GE1E21gdvC+BzLR6lEb7TPEOprFJOzWBZzgOofX7mqcRnpd4FsCXPR7Fw231U6Twbp9JzMHk7digYcxay9KT/hxhp/FSVoHLh3uajy0Hlf4UJDxVwLIEibXbC0tlMckbl0Rv+AoMu+mzkT7IWk+SextxsG1llkbnFr9uwiX2lKA6Tq5gpuEaRL3e+I8XDskoZV4C1uaok6yJlRcgX2rWntVn9rVRfNvHinUPE8wM4wlBZWdNRlkMktkrDSyn6oaB6jVqrZch5sPim+WQBCQVhKxEsefUDIwMeipSApUPqB9StLOmlYNyJ+7HNka4Ef8pJrgdVHfQ0LBgVMQvxqbr3GR6E4Xv+KAlp/effT0WFLaoS06BKdl4bmZ/l2pZsRfez82kZP98ZwzGH3AxY/e4h6G49RnhG6t4+raPVgXexLEb+7VpOGBfSTbXMgSJSLJTQxyuhvp3nttjfKk6gZM14jSshfQkxk8XSpqvHb22HFt8JFqd3VF7wkWr0NPrMS5HVRtD8g60wr4GNYaVn+rw8kc3LIJxPmkerKeUMIu179Y/gI4LhqtJq680Bvt3cwGz9zIk3hzCoBytgKiY5fQbPd/fxvekFTEF0o1PilzUeKCbqzB1YmVCcUsTyuebfCNJgXQnU81cW5H3jwJOGw4bhIMhCf1KjefH6g0W7jrnCEGPtXja9/Ti6yEJFWQcWn5wQwCtLGqpXOZmNA5qHRMUau5zoRaV/F7Jx
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lEqVvtHJzzlpqiZ8J+ieTC9Jnc5DVgHd6YHmXUNm+pL2g5KTX0c8IAw1ml4YJ3Qzy1mF4moxfMSGsxx3i55p+1kBTQIN2SRRrmMHHhWKAwvO16oWFYB8egj7O75Hm8UdFHPPYtNHvdDPHjymfoKIJ5XfNNXcsrSKAumnPoT6T/N3KBEM8gLSAH3fXNlEOkvqvOrA2v38nx9ZORRH2vJvOVVGPBfVm5zeABNdOSr3adlB/mn6JtMeflz3NRpPtTY4wxPW7dmVNkDhXQ7ds/NDqlKOkpoTisr5rh/5I+2NW9VWR7NNaOE1sxCxQLhkCi+x20ly6e00IAjuullYY3A05g0X5r+nRxmSx/ZAg586V3GEDMDG9YJL/YxLRZTTkrMEJ8g/rzo7Oa0CN2hZFCWem14oZex5nW3M+nVAcJ3inJWs5WnSG1lcuIjPn0tK3D6o
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:22:58.1473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c4caad-2591-417f-f0c7-08df2ba1bdbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730

From: Manish Honap <mhonap@nvidia.com>

The HDM memory region is mmap-able, so an fd holder can fault its
struct-page-less device memory in from the host CPU. A memory error on
that range cannot be routed through the normal struct-page path and
would otherwise escalate to a fatal host SError.

Register the range with memory_failure() via
register_pfn_address_space() so such an error is instead contained to a
SIGBUS to each process that maps the poisoned page. Provide a
pfn-to-vma-offset callback so memory_failure() can map a poisoned pfn
back to the file offset of each user mapping; the region is a single
linear range at hpa_range.start, so recover the offset the same way the
fault handler derived the pfn.

register_pfn_address_space() returns -EOPNOTSUPP when
CONFIG_MEMORY_FAILURE is off, in which case expose the region without
containment.  Unregister the range on close.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 84 +++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 977d0c9c747a..f2f7ddfc80bb 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -9,6 +9,7 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/memory-failure.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -27,6 +28,7 @@
  * @hpa_range: host physical range of the HDM region
  * @hpa_res: exclusive reservation of @hpa_range, held for the bind
  * @hdm: copy of the HDM state cached at PCI enumeration, taken at bind
+ * @hdm_pfn_space: HDM-region pfn range registered with memory_failure()
  * @hdm_valid: true when host CPU access to the HDM range is safe; under memory_lock
  * @await_mem_active: the device reported its memory active at bind, so wait
  *	for Memory_Active before host access reopens after a reset or low power
@@ -38,6 +40,7 @@ struct vfio_cxl_state {
 	struct range hpa_range;
 	struct resource *hpa_res;
 	struct cxl_hdm_info *hdm;
+	struct pfn_address_space hdm_pfn_space;
 	bool hdm_valid;
 	bool await_mem_active;
 	unsigned int mem_region_index;
@@ -211,6 +214,63 @@ static const struct vfio_pci_regops vfio_cxl_mem_regops = {
 	.release = vfio_cxl_region_release,
 };
 
+/*
+ * Map a poisoned HDM-region pfn back to the file offset of each user mapping so
+ * memory_failure() can find the mapping and signal its owner. The region is a
+ * single linear range at hpa_range.start; recover the per-vma file offset the
+ * same way the fault handler derived the pfn.
+ */
+static int vfio_cxl_pfn_to_vma_pgoff(struct vm_area_struct *vma,
+				     unsigned long pfn, pgoff_t *pgoff)
+{
+	struct vfio_pci_core_device *vdev;
+	struct vfio_cxl_state *cxl;
+	pgoff_t vma_off, pfn_off;
+	unsigned long start_pfn;
+
+	if (vma->vm_ops != &vfio_cxl_mem_vm_ops)
+		return -ENOENT;
+
+	vdev = vma->vm_private_data;
+	cxl = vdev->cxl;
+
+	start_pfn = PHYS_PFN(cxl->hpa_range.start);
+	if (pfn < start_pfn ||
+	    pfn >= start_pfn + (range_len(&cxl->hpa_range) >> PAGE_SHIFT))
+		return -EFAULT;
+
+	pfn_off = pfn - start_pfn;
+	vma_off = vma->vm_pgoff &
+		  ((1UL << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+	/* Skip VMAs that do not map the pfn, e.g. a partial mmap of the region. */
+	if (pfn_off < vma_off || pfn_off - vma_off >= vma_pages(vma))
+		return -EFAULT;
+
+	*pgoff = vma->vm_pgoff + (pfn_off - vma_off);
+	return 0;
+}
+
+/*
+ * The HDM region is struct-page-less device memory, so a memory error on it
+ * cannot be routed through the normal page path. Register the range with
+ * memory_failure() so such an error is contained to a SIGBUS to each process
+ * that maps the poisoned page, instead of escalating to a host SError. The
+ * mapping itself is not torn down.
+ */
+static int vfio_cxl_register_pfn_space(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	unsigned long start_pfn = PHYS_PFN(cxl->hpa_range.start);
+
+	cxl->hdm_pfn_space.node.start = start_pfn;
+	cxl->hdm_pfn_space.node.last =
+		start_pfn + (range_len(&cxl->hpa_range) >> PAGE_SHIFT) - 1;
+	cxl->hdm_pfn_space.mapping = vdev->vdev.inode->i_mapping;
+	cxl->hdm_pfn_space.pfn_to_vma_pgoff = vfio_cxl_pfn_to_vma_pgoff;
+
+	return register_pfn_address_space(&cxl->hdm_pfn_space);
+}
+
 /*
  * Create the CXL device state and join the device to the CXL topology. The
  * caller groups these devres allocations, so return on the first error.
@@ -482,13 +542,35 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 	/* Record where the HDM memory region landed, to revoke it later. */
 	cxl->mem_region_index = VFIO_PCI_NUM_REGIONS + vdev->num_regions - 1;
 
+	/*
+	 * The HDM region is advertised mmap-able, so a fd holder can fault its
+	 * struct-page-less device memory in from the host CPU. Register it with
+	 * memory_failure() to contain a memory error. -EOPNOTSUPP means
+	 * CONFIG_MEMORY_FAILURE is off, so run without containment.
+	 */
+	ret = vfio_cxl_register_pfn_space(vdev);
+	if (ret && ret != -EOPNOTSUPP)
+		goto err_index;
+
 	return 0;
+
+err_index:
+	/*
+	 * A failed open never reaches close_device, and vfio-pci-core frees
+	 * the regions: forget the index, or a later revoke of the HDM gate
+	 * (runtime suspend of the closed device) names a region that is gone.
+	 */
+	cxl->mem_region_index = 0;
+	return ret;
 }
 
 static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
 {
+	struct vfio_cxl_state *cxl = vdev->cxl;
+
+	unregister_pfn_address_space(&cxl->hdm_pfn_space);
 	/* vfio-pci-core frees the regions after this returns. */
-	vdev->cxl->mem_region_index = 0;
+	cxl->mem_region_index = 0;
 }
 
 static void vfio_cxl_reset_prepare(struct vfio_pci_core_device *vdev)
-- 
2.53.0

