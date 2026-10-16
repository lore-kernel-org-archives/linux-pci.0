Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A2531AE5;
	Fri, 16 Oct 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167862; cv=fail; b=KsLfs00N7Lq5+kFdHS8ZelY0soJQrjY7e5UGU6TUySdW52pZmXBHntONnJqHYwSJBNog/TAUo15VRo24wOfE10Y5VkjyXArJo3HxhpIukMOaSg8eVDnfwAD4BMu0LpDc2dUTrpYQEe1kVhbgy18GLhnNfxE0poh1krKoluzFows=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167862; c=relaxed/simple;
	bh=upHXtwXTSfrZRuMXHiWKv3IRC2rFWnZFud1hs/XsPdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O20RTCgbzfXvCnfXpc1BHS5BqG8aGsitFgM4ciEZ7PPyw37UF4HvVTDLI2/ydzh7ZMFJ1fgUXGFNLTc9tJJ11emc4ZeP22j7oDJ5ygHYYNZ6bdnpozqdASPgG2SOc7jIic7wyPq91Z/xMiYKqIeHpuua3lZusENs5/EBPcy8bRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XaFGEFrx; arc=fail smtp.client-ip=52.101.56.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XaFGEFrx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgj7j8RTCNgPZsLliGIE+9gnD8sqnOzdkQDI+8sr9OHuoDyQllpQm+tMRavnMxrAo3La9mziVVsboyndgmpNQdtmzoSUOb2Pp5Ys5IN4BXcwzlXfHDGktWtwDZnE5X7gcXpDf/iOhuJlht5K+fOeW7QNYOuxfvs7+opRLBISJMKh9SJ33SKBSIJJQkSzHgcjSCRMHgUcU58vWGkWI40tQbsodkjpUYIgYkz522juo0LbkQYL5Ukj/161Cqjj0K6AHinOvNheFfrSrLwOaueh2HdzhA4MByz+f0o2YCsdvkbWpdFckY4DV7e2DSm0iUoJIm16QlXttvoSMigHaZjHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xkomix6sgLg1wWfXsuX3zX7EcJStU+4H3l318ZUmtK8=;
 b=rDuyz+/6dX3i5A2A7dpq/ow1uoVhiRM2mLHr+jZkYJg0E0q8m4PNjJTPQ5moAOEr7zP5U0H7ORLc6RxS/pYyese6sE3hUUMlBGJrqS4Y/tNXOSwEmwej0gAsBb3DDK5HPbT+Ay8ZU57Eq6YdrpPKqoN9KqmQhcGcLq+j7wfME8TyORelUqtL/SfGqFMnIpc9KJZOr36yzd1gTd0tBSdmntiQHDVTitRkKj9W9CxjDALH87+n00qxE83YxQCr8zH9BXqwqY96deYlAzgbmu9A0qz9x9APJbujzFxJU9d22WE3TMUiL/3n2trftcQFJTrAT/eAMRhMnJNF2cgjuSK4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xkomix6sgLg1wWfXsuX3zX7EcJStU+4H3l318ZUmtK8=;
 b=XaFGEFrxugQcSEQWm5SleIpANm19JYlUheZb5plrTLysNUy+6AibXUFN6mKo22k3gO77IhY1/PkBENw2gCAbrF30THRAOO8t8X2y2nMvdSLfLJbJL/u4kvcQNEKIU5s12AaepUveYxv7tnDILrkeQlY2q+L59G9KLkJX0Mi485p4UPeqLPkXGkE6epBiZAGH39cPhu8hCo+ePtyjs+ps11kd82CxoETdlp5n49BySoj9+chKgbA9fOgCqoHLA/8YCcBaKqkW2JWAG9NnRsi395dIFm8IMJ+do5AppgCgpEnJLfE85T0pJBn7k5OD+OwIyx3FPoaICtjWoiropU1Tow==
Received: from DS7PR03CA0341.namprd03.prod.outlook.com (2603:10b6:8:55::23) by
 PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 16:23:46 +0000
Received: from DM3PEPF000265B4.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::2c) by DS7PR03CA0341.outlook.office365.com
 (2603:10b6:8:55::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:23:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM3PEPF000265B4.mail.protection.outlook.com (10.167.23.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:23:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:23:13 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:23:05 -0700
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
Subject: [PATCH v6 28/31] vfio/cxl: Export the HDM memory region as a dma-buf
Date: Fri, 16 Oct 2026 21:48:35 +0530
Message-ID: <20261016161839.2765592-29-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B4:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f9f8ab-0e75-4575-d978-08df2ba1da20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700016|23010399003|921020|56012099006|11063799006|261009223027099003|18002099003|10067099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3M9cV9NFyaPQsCh84SrpQyZqYZnz8PXdsTtkSOPWw/3dV9iyU6f81hvzlmz3ernyvDrbcDWMtSKEHyGbT+d02UYNW9cxeezctWgkVcfgd0rBE9P2aMMzsnBPYRRxbZZM0fLkKACE6+AWG7lPX4GLZwtHo5e72ZNhoNVfO0idHJnk2cWlUZkRTVVetlAEEg2LRoaTtChotEc0dQTEgW0a0xUsP9dsI731YJNGh5GKVQLzqfUuaYLqJ7GtkVEPjbzpXQLohZaBoXCkzd8I8l4LT5ER3QI/d8vrmBrLDuWfMpIwEmTp8PwEMGlNJ0SprDYzctsPCc0acSQv8aPsye0GRsqhIgvH4DDpglzEKoVd8uTCq2UmXeWLaPjKP86o0cmRbqGNinW69IcE81q3TQiDIctIUkr6yQnKo7iEJbIF5QLL9IMeKqj9cPnniM8jt4dHSXXUtm4WN9WuQ5u0H5/Cu0MycefG40AaeKp6piDk0GRz8T5eyspPb1v74VoBNH0zdqi3fIaBxlY6Y7pi/LXdsGxhlOJhxo22dKSzd++Lk6birsd3VrCIOM7TGlrrxM/Y0M1g95OBT9KOHvgY2J+FBgN/wBWlUGGpKfLFs/qCFZB3Ax54cNAlVPwJEddQFUiSGYO/cw2eEz0y1+UufWb5Cq1aWgLwwWJXOLaaRv6bcaFcgsGu9JwsAcbqgyrsBH03RFlSIwXolACD7NiMEwb7iH1ahppRbrk83XSe7MUl33X8Fa9PCIsPN7GdYeu5GDq+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(921020)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rWMGVrJAvhj8TAULWuUOL4zKP4g/24/jHyN4Np8pbTeWU9ooXWW8K53Nx8X78HiRO5G2/huKzxakDwQGsh50cWFopQLuYNt9fWLQcGtmS9ruNg3hHD9xAIWuExZoVZTQ/Gs8vEGwBWpY0PMCXXxecUj5AjkExu3m/eNsODRDbUUvALZqn+yfs9fz4YFOjM9FA4d9jhXVfxn1Y/rp++S8JEpL7ujBmZdCP7owIXjCAN7WThkljwYD7i5I5jz7uMWfOXVHAszIk/6I9D73lJSQDzDqkxCSihTQm1lrqByay+quIlkOFbLaETZzyQrXpJZOQJdTRft62LTAti9ZW7NcJ5GB+y33lGKtuQfntcpy+sU3W07wg5ElKEsf4uj/txDx8FD02eesOJhgiHNZte5jr/uscg4C82lWvx8SwDKSYKzfivJjfwQlnNoZjZm1XSHj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:23:45.7841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f9f8ab-0e75-4575-d978-08df2ba1da20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

From: Manish Honap <mhonap@nvidia.com>

A Type-2 accelerator issues ATS-translated DMA to addresses inside its
own HDM window, so that coherent host range must be present in the
guest's IOAS (the iommufd IOAS backing the nested SMMU stage-2). iommufd
maps a struct-page-less range only by fd, via IOMMU_IOAS_MAP_FILE over a
dma-buf; a userspace-VA IOMMU_IOAS_MAP of the HDM mmap is rejected
because the VMA is VM_IO | VM_PFNMAP. Without a dma-buf the range could
only be mapped through an out-of-tree PFNMAP work-around.

vfio-pci already exports BAR memory as a P2P dma-buf, but the exporter
is BAR-only: vfio_pci_core_feature_dma_buf() rejects any region index at
or above the ROM index, and vfio_pci_core_get_dmabuf_phys() resolves the
physical range from a PCI BAR. The HDM memory region is a dynamic
device-specific region, not a BAR.

Let a device-specific region reach the device's get_dmabuf_phys(): a
region index at or above VFIO_PCI_NUM_REGIONS skips the BAR-resource
check and is validated by the driver instead, bounded to the regions
that exist. Install a CXL-aware get_dmabuf_phys() in the vfio-cxl
provider that returns cxl->hpa_range for the HDM memory region and
delegates real BARs to the core, keeping the BAR path unchanged and the
core free of CXL knowledge.

The HDM window is coherent host memory with no p2pdma provider of its
own, so borrow BAR 0's, matching nvgrace-gpu's handling of its non-BAR
device memory. The iommufd importer does not consume the provider; the
scatterlist map path (real peer DMA) is left to a follow-up once
upstream grows a negotiated interconnect for coherent CXL memory. Mark a
device-specific dma-buf so vfio_pci_dma_buf_map() refuses that path,
which would translate the range with the borrowed provider's bus offset.

The HDM dma-buf belongs to its region, not to the BARs: a memory enable
change leaves it alone, and vfio-cxl revokes and re-arms it with the
region when the decoder state changes. A new dma-buf of a
device-specific region starts in the state its region reports through a
new optional revoked() region op, so an HDM export made with memory
disabled starts armed, and one made after a failed reset starts revoked.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 76 +++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_dmabuf.c   | 73 +++++++++++++++++++++++---
 include/linux/vfio_pci_core.h        |  9 ++++
 3 files changed, 151 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 9ef052a3745e..518f0b093652 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci-p2pdma.h>
 #include <linux/range.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -206,6 +207,21 @@ static ssize_t vfio_cxl_mem_rw(struct vfio_pci_core_device *vdev,
 	return done;
 }
 
+/*
+ * The HDM region follows hdm_valid, not Memory Space Enable, so a dma-buf
+ * exported from it starts revoked while host access is unsafe and is
+ * re-armed with the region in vfio_cxl_rearm_hdm().
+ */
+static bool vfio_cxl_mem_revoked(struct vfio_pci_core_device *vdev,
+				 struct vfio_pci_region *region)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	return !cxl->hdm_valid || !cxl->cxlds.media_ready;
+}
+
 /*
  * The CXL regions carry no per-region state (region->data is the shared,
  * devm-managed vfio_cxl_state), so releasing a region is a no-op.
@@ -219,6 +235,7 @@ static const struct vfio_pci_regops vfio_cxl_mem_regops = {
 	.rw = vfio_cxl_mem_rw,
 	.mmap = vfio_cxl_mem_mmap,
 	.release = vfio_cxl_region_release,
+	.revoked = vfio_cxl_mem_revoked,
 };
 
 static ssize_t vfio_cxl_comp_rw(struct vfio_pci_core_device *vdev,
@@ -443,6 +460,50 @@ vfio_cxl_create_memdev(struct pci_dev *pdev, const struct cxl_hdm_info *hdm,
 	return cxl;
 }
 
+/*
+ * Resolve the physical range that backs a dma-buf export. The core exporter
+ * only knows BARs; teach it the HDM memory region so a guest IOAS can map the
+ * coherent window by fd (IOMMU_IOAS_MAP_FILE) instead of the removed PFNMAP
+ * work-around. Real BARs stay on the byte-identical core path.
+ */
+static int vfio_cxl_get_dmabuf_phys(struct vfio_pci_core_device *vdev,
+				    struct p2pdma_provider **provider,
+				    unsigned int region_index,
+				    struct phys_vec *phys_vec,
+				    struct vfio_region_dma_range *dma_ranges,
+				    size_t nr_ranges)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+
+	/* Real BARs go through the core P2P exporter unchanged. */
+	if (region_index < VFIO_PCI_NUM_REGIONS)
+		return vfio_pci_core_get_dmabuf_phys(vdev, provider,
+						     region_index, phys_vec,
+						     dma_ranges, nr_ranges);
+
+	/* Of the device regions, only the HDM memory window is exportable. */
+	if (region_index != cxl->mem_region_index)
+		return -EINVAL;
+
+	/*
+	 * The HDM window is coherent host memory, not BAR MMIO, so it has no
+	 * p2pdma provider of its own. Borrow BAR 0's: the P2P properties match
+	 * and the iommufd importer does not consume the provider. The sgt map
+	 * path (real peer DMA) is not supported for the HDM window.
+	 */
+	*provider = pcim_p2pdma_provider(vdev->pdev, 0);
+	if (!*provider)
+		return -EINVAL;
+
+	return vfio_pci_core_fill_phys_vec(phys_vec, dma_ranges, nr_ranges,
+					  cxl->hpa_range.start,
+					  range_len(&cxl->hpa_range));
+}
+
+static const struct vfio_pci_device_ops vfio_cxl_pci_dev_ops = {
+	.get_dmabuf_phys = vfio_cxl_get_dmabuf_phys,
+};
+
 /* CXL r4.0 sec 8.1.3.8.2: Range 1 Size Low Memory_Active_Timeout encodings */
 static const unsigned int vfio_cxl_mem_active_timeout_s[] = { 1, 4, 16, 64, 256 };
 
@@ -662,9 +723,22 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 	if (ret)
 		return ret;
 
-	/* Record where the HDM memory region landed, to revoke it later. */
+	/*
+	 * Record where the HDM memory region landed, to revoke it and to
+	 * resolve its dma-buf export.
+	 */
 	cxl->mem_region_index = VFIO_PCI_NUM_REGIONS + vdev->num_regions - 1;
 
+	/*
+	 * Override the device ops so a dma-buf export of the HDM memory region
+	 * resolves to the coherent host range. This is done at open, not init:
+	 * vfio_pci_probe() resets pci_ops after vfio_alloc_device() returns, so
+	 * an override installed during init would be clobbered. Only a CXL device
+	 * reaches this hook (cxl_ops is set on init success), so a device bound
+	 * without CXL support keeps the core ops.
+	 */
+	vdev->pci_ops = &vfio_cxl_pci_dev_ops;
+
 	ret = vfio_cxl_add_region(vdev, VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
 				  &vfio_cxl_comp_regops, cxl->hdm_len,
 				  VFIO_REGION_INFO_FLAG_READ |
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index d0f7ec5487de..237f7e055dd8 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -21,6 +21,13 @@ struct vfio_pci_dma_buf {
 	struct completion comp;
 	u32 region_index;
 	u8 revoked : 1;
+	/*
+	 * Set for a device-specific region (e.g. the CXL HDM window) that
+	 * borrows a BAR's p2pdma provider: mapping by physical address through
+	 * iommufd is safe, but a peer-DMA sgt map would translate with the
+	 * wrong provider bus offset.
+	 */
+	u8 no_peer2peer : 1;
 };
 
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
@@ -60,6 +67,15 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
 	if (priv->revoked)
 		return ERR_PTR(-ENODEV);
 
+	/*
+	 * A borrowed-provider export can only be mapped by physical address
+	 * through iommufd, not as a peer-DMA sgt: dma_buf_phys_vec_to_sgt()
+	 * would translate the physical range with the borrowed provider's bus
+	 * offset and hand the peer a wrong address. Refuse it.
+	 */
+	if (priv->no_peer2peer)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	ret = dma_buf_phys_vec_to_sgt(attachment, priv->provider,
 				      priv->phys_vec, priv->nr_ranges,
 				      priv->size, dir);
@@ -179,6 +195,15 @@ int vfio_pci_core_get_dmabuf_phys(struct vfio_pci_core_device *vdev,
 {
 	struct pci_dev *pdev = vdev->pdev;
 
+	/*
+	 * This resolver only handles PCI BARs. A device-specific region index
+	 * (>= PCI_STD_NUM_BARS) would index the per-BAR provider array
+	 * (p2p->mem[]) out of bounds in pcim_p2pdma_provider(), so reject it; a
+	 * driver that exports such a region installs its own get_dmabuf_phys.
+	 */
+	if (region_index >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+
 	*provider = pcim_p2pdma_provider(pdev, region_index);
 	if (!*provider)
 		return -EINVAL;
@@ -219,6 +244,26 @@ static int validate_dmabuf_input(struct vfio_device_feature_dma_buf *dma_buf,
 	return 0;
 }
 
+/*
+ * A BAR dma-buf follows the memory enable bit. A device-specific region
+ * follows its own state, which its provider moves with
+ * vfio_pci_core_revoke_region() and vfio_pci_core_rearm_region(); start a
+ * new dma-buf in that state, since a memory enable change never moves it.
+ */
+static bool vfio_pci_dma_buf_start_revoked(struct vfio_pci_core_device *vdev,
+					   u32 index)
+{
+	struct vfio_pci_region *region;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (index < VFIO_PCI_NUM_REGIONS)
+		return !__vfio_pci_memory_enabled(vdev);
+
+	region = &vdev->region[index - VFIO_PCI_NUM_REGIONS];
+	return region->ops->revoked && region->ops->revoked(vdev, region);
+}
+
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
 				  size_t argsz)
@@ -228,6 +273,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct vfio_pci_dma_buf *priv;
 	size_t length;
+	u32 index;
 	int ret;
 
 	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
@@ -244,13 +290,22 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
 		return -EINVAL;
 
+	index = get_dma_buf.region_index;
+
 	/*
-	 * For PCI the region_index is the BAR number like everything
-	 * else.  Check that PCI resources have been claimed for it.
+	 * A fixed region index is the BAR number; only a BAR can be exported
+	 * and its PCI resource must be claimed. A device-specific region (index
+	 * >= VFIO_PCI_NUM_REGIONS) has no BAR resource and is validated by the
+	 * device's get_dmabuf_phys instead, but the index must name a region
+	 * that exists.
 	 */
-	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX ||
-	    IS_ERR(vfio_pci_core_get_iomap(vdev, get_dma_buf.region_index)))
+	if (index < VFIO_PCI_NUM_REGIONS) {
+		if (index >= VFIO_PCI_ROM_REGION_INDEX ||
+		    IS_ERR(vfio_pci_core_get_iomap(vdev, index)))
+			return -ENODEV;
+	} else if (index - VFIO_PCI_NUM_REGIONS >= vdev->num_regions) {
 		return -ENODEV;
+	}
 
 	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
 				       sizeof(*dma_ranges));
@@ -266,7 +321,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	 * BAR keeps off mmap, so refuse such a range here as mmap does.
 	 */
 	for (u32 i = 0; i < get_dma_buf.nr_ranges; i++) {
-		if (vfio_pci_bar_range_excluded(vdev, get_dma_buf.region_index,
+		if (vfio_pci_bar_range_excluded(vdev, index,
 						dma_ranges[i].offset,
 						dma_ranges[i].length,
 						VFIO_PCI_EXCLUDE_MMAP)) {
@@ -290,6 +345,12 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	priv->nr_ranges = get_dma_buf.nr_ranges;
 	priv->size = length;
 	priv->region_index = get_dma_buf.region_index;
+	/*
+	 * A device-specific region borrows a BAR's p2pdma provider, so it can
+	 * only be mapped by physical address (iommufd), never as a peer-DMA
+	 * sgt. See vfio_pci_dma_buf_map().
+	 */
+	priv->no_peer2peer = index >= VFIO_PCI_NUM_REGIONS;
 	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
 					     get_dma_buf.region_index,
 					     priv->phys_vec, dma_ranges,
@@ -323,7 +384,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	INIT_LIST_HEAD(&priv->dmabufs_elm);
 	down_write(&vdev->memory_lock);
 	dma_resv_lock(priv->dmabuf->resv, NULL);
-	priv->revoked = !__vfio_pci_memory_enabled(vdev);
+	priv->revoked = vfio_pci_dma_buf_start_revoked(vdev, index);
 	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
 	dma_resv_unlock(priv->dmabuf->resv);
 	up_write(&vdev->memory_lock);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index ec1660e0d6d2..6069a2db5dd6 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -47,6 +47,15 @@ struct vfio_pci_regops {
 	int	(*add_capability)(struct vfio_pci_core_device *vdev,
 				  struct vfio_pci_region *region,
 				  struct vfio_info_cap *caps);
+	/*
+	 * Optional, for a device-specific region exported as a dma-buf.
+	 * Called with memory_lock held for write; returns true while the
+	 * region is revoked, so a new dma-buf starts in the state that
+	 * vfio_pci_core_revoke_region() and vfio_pci_core_rearm_region()
+	 * maintain. Without it, the dma-buf starts armed.
+	 */
+	bool	(*revoked)(struct vfio_pci_core_device *vdev,
+			   struct vfio_pci_region *region);
 };
 
 struct vfio_pci_region {
-- 
2.53.0

