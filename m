Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C5511E8D;
	Wed, 16 Sep 2026 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584072; cv=fail; b=Dj/yu3UfyndjVu0HqEHGfYv6JI4B/zWkJS+9W2Q8XzThLRJdJs7eRoxBzEFMrE4suFIE3aNRgBxWKZ8m4bBuLs1YMsm7DZ4VSr9PtAmSLySAHgzB4TgY4NJs+l5XntF4MVGFXzGPALYxj++15ovhzowpnEZWPtRklczDXAR51Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584072; c=relaxed/simple;
	bh=dasyKItFr5AzKzNRrcMTELGv+2hPlAylGIuOLYiauRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOUsR6DkN5t3SrS2vMuEJCeXXisRHTmnRF0iWWUYrFyiRlNGVB7v4HOeIySSAHin1PCSxiTLGsiSfssk8HLAsZBsEBzbzNesfXzs8TsOUM6cw8vKPrH9/qOXTAUb/0+8rsqFm08ZAXCXbQY7HpW0QMHMbrgd3EqIG/vKSiy6RCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mGZqQ75z; arc=fail smtp.client-ip=52.101.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mGZqQ75z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaA36pxF5nQlTOzrfwhIbt4jvWbWwl1yWtngRnixXQU6bzbH8aiDE8jjmzhePNNT/dRyUW8OXASDefa8dd/srpAop0/QZZXDXh9XgV24Ml3noAR6lGMJ5z17BxsvhisxrF6Mb78vlyEKdRN4TACC7x7Ayykc5oX7vKp9SPizrvFfSfMhmJg7a69/PIkxQ4dS7RCJOhj/ouBBa/kNDsR1iNw08vFt9cgyfOrYjcBJduZiiVlCG/wHdpWMcqNwEcKYLziWvJ0UYIcLbWnTHHODyULfStw7EL73P5tJ5HEzg0SH/csZ6uuvweX0LnRh5jd86qgkjmhvfLcLAO2rxfuxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxKBWgEBRY33++fYkaQcn2yRwjjDMXmvT5tP3jeSIjI=;
 b=dMse6+3++QX28qdrgUDmy2RcDPcUOLnWrmKhcroXh1fmlFSnogs72tNggJcLAIGVds7gw3gI0ENbThLmE0UirLToMWIw5mPpBd2ve4BNKzqXtMWOIeAZyX6vNOSPmRO3NoxOpllgv0179TT3c+ssQCqKMRSWRkHNpZvuiwM0qBOFL8APvJYzLr40TkoO5mBHZHjZgBa62n26uuLg+5KsUxY9r8QE6dJC2bhdWFiDGtBAf9yjtBTW6mRYw/d+CGAdq+6/PxmVLTdS9OuPq8JqiY/3c+0krNL+6w6FKPg1CShl2O5Z/0mODA/YVzYb7Q7G3mttgxYUAyK9DhqiPItA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxKBWgEBRY33++fYkaQcn2yRwjjDMXmvT5tP3jeSIjI=;
 b=mGZqQ75zAQxRlX8a5xP6hphhh3PfDnIqREgWdAgZwGxHMnSDhmSTBsWA1sJGlQ5hEmO9rMfcd1A2nkD3cbIpPQNn8zSwwYKewTuAwJQ2nEIhmehokw6StgnGzLBlO+p+Xf5dCe0tnGtjBwLwuJ0ExOOQBnt/bCexjY9Ln6O65zZQWTvUZR0zpODaFe0Eqqp+yPfApF+Tea4b39P598ljHdfbmN2i4xMxw06Z/MCBmE0lGVVtmq69JbNTnGIaMQZYnAc8MNvr7P/vxrTAh6K6tM8nBcDBdzFBZ49PhcRV9uX3KM5fP2K5JQPg/1ApEf27c9aC1ootRa5++VPwHSGpDA==
Received: from PH3PEPF000040A4.namprd05.prod.outlook.com (2603:10b6:518:1::53)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 18:40:22 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::2) by PH3PEPF000040A4.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8 via Frontend Transport; Wed, 16
 Sep 2026 18:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:40:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:39:49 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:39:40 -0700
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
Subject: [PATCH v5 24/27] vfio/cxl: Export the HDM memory region as a dma-buf
Date: Thu, 17 Sep 2026 00:05:37 +0530
Message-ID: <20260916183540.3813685-25-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 72777572-dd3f-4408-1350-08df1421f6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|82310400026|36860700016|18002099003|22082099003|3023799007|921020|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	vcFpkKOJKbVTgB3L0oGZPTZ19ZTH8qrbbRj1+sQz2crVDaGCkkSBoh5xX5D8By6S8VKgGitndqo1ji44F9E2aVE5mdcFyPfxzczAZGZpm5suh89s1QL9bPR+WX/knBu8A08QAF6Rav3emmg+Kz0/enuCiHN/WSL5Xpdrzq1zLfLKx6jnPkmlgM8VLbC+kmlr24YSH+SZTPCvSCVojpEJBTd6E/DgVix2KzIAV6SFE4mFuc2+cL5bOtpQ6gQdWyDohgFf+7CS1d+hkd9dcoy8huiMjB7M2I43rVe88Cx0pyybPcVc1NpUI/QR9KAlvjHz5mZw6wxZStKL25biGQQAUWMqOMU6hZrgXakGMI9/qihw45s7uWhwWN9Q/yypQh/YT3VDWpcZd9yp0lIzFftILUcUn8OA9CZBbJG1gdqAAqw792Twu94yN2d7uGnNN8OwP/55bY8UuOZjSydq26ivwVQWpmB/K8wW63hloQAgydRvlaX9+6HT+Y6L2nrarVmB8s9qF10iyjjOBWIw3+AAiHyYODNz0MHHVNaSJtW56oYfJmZtO1ckUwKxUzUUXztWvUiE7u9qYat+u6HjuXRY1fhB98bc0ZaAhdAboZvz9b6yZ3EbBRO4zwiwrFHQvKOfvK6etjl8noq56WdxCJ66N5nSNHG0NuyJ5cIG8PpLruxZjqheiwCzreyVLI38bokMkF84VXOI13QgvJmykrOEQv8mDaQn6slyMWBs8/t4vMI1ygRGXfQVDa5W8eAfuKxC
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(3023799007)(921020)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fan/g/pbVK0YnNjh13ejoOpAmxA4AQj1TBSkzF4Hm8wx3VHdWp0HBzsb/3yDKgXRQekQOstLcrg+rWqlUC29407NBcB7tGW5um9PN5O3VoUpdUuvO1pa82Z/85j/ALr6UVLdTWzNwdGTDbpVcRPG7f7qW8P9dROit363lF8q+z0lrzH84TPnTX8WncQqeFmXSb83vkMdS9LjP/XI/tuROW0/rGxXtNeIcoKNCPeo0J/B4PSuhIjGazoZmwpe8H2vtAx0+GKNCxS8wGgbQ2cURFQcwfex2s7dH8jqFegTkHYP3zDhnIOIdzp56INUJE2AJ3YqfH9SZrbWTa9Z9NkMju1eFJmHzgmWPlH+NXoSIB5BfMZtafCu4H71ok26mBrdNxd3gphg4hZEkefezy5JubR+x0x1IXaSdWZPQAy///Xfli+N91OMoVjmckg8gOpY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:40:21.8112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72777572-dd3f-4408-1350-08df1421f6f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117

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
upstream grows a negotiated interconnect for coherent CXL memory.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 60 ++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_dmabuf.c   | 27 +++++++++++--
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 5fe8e35c63c4..55fa1f86850d 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci-p2pdma.h>
 #include <linux/range.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -27,6 +28,7 @@
  * @hdm_regs: mapped HDM decoder registers, read live by the decoder region
  * @hdm_len: length of the HDM decoder register block
  * @hdm_valid: true when host CPU access to the HDM range is safe; under memory_lock
+ * @mem_region_index: vfio region index of the mmap-able HDM memory region
  */
 struct vfio_cxl_state {
 	struct cxl_dev_state cxlds;
@@ -36,6 +38,7 @@ struct vfio_cxl_state {
 	void __iomem *hdm_regs;
 	u32 hdm_len;
 	bool hdm_valid;
+	unsigned int mem_region_index;
 };
 
 static unsigned long vfio_cxl_mem_pgoff(struct vm_area_struct *vma,
@@ -289,6 +292,50 @@ static void vfio_cxl_release_hpa(void *data)
 	release_mem_region(cxl->hpa_range.start, range_len(&cxl->hpa_range));
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
 static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -483,6 +530,19 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 	if (ret)
 		return ret;
 
+	/* Record where the HDM memory region landed for the dma-buf export. */
+	cxl->mem_region_index = VFIO_PCI_NUM_REGIONS + vdev->num_regions - 1;
+
+	/*
+	 * Override the device ops so a dma-buf export of the HDM memory region
+	 * resolves to the coherent host range. This is done at open, not init:
+	 * vfio_pci_probe() resets pci_ops after vfio_alloc_device() returns, so
+	 * an override installed during init would be clobbered. Only a CXL device
+	 * reaches this hook (cxl_ops is set on init success), so a fallback to
+	 * plain vfio-pci keeps the core ops.
+	 */
+	vdev->pci_ops = &vfio_cxl_pci_dev_ops;
+
 	ret = vfio_cxl_add_region(vdev, VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
 				  &vfio_cxl_comp_regops, cxl->hdm_len,
 				  VFIO_REGION_INFO_FLAG_READ |
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..436c616d5b66 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -178,6 +178,15 @@ int vfio_pci_core_get_dmabuf_phys(struct vfio_pci_core_device *vdev,
 {
 	struct pci_dev *pdev = vdev->pdev;
 
+	/*
+	 * This resolver only handles PCI BARs. A device-specific region index
+	 * (>= PCI_STD_NUM_BARS) would index pdev->resource[] out of bounds via
+	 * pcim_p2pdma_provider(), so reject it; a driver that exports such a
+	 * region installs its own get_dmabuf_phys.
+	 */
+	if (region_index >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+
 	*provider = pcim_p2pdma_provider(pdev, region_index);
 	if (!*provider)
 		return -EINVAL;
@@ -227,6 +236,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct vfio_pci_dma_buf *priv;
 	size_t length;
+	u32 index;
 	int ret;
 
 	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
@@ -243,13 +253,22 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
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
-- 
2.25.1

