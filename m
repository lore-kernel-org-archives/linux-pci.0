Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5E3D5C12;
	Thu, 13 Aug 2026 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613970; cv=fail; b=gvdyRnTAvLnGtErC2O8IfUwn64wgdYFWiPj4kb+/KcZj0TKC4aWMnXh6SaAEX3j2Gn/cmoj9d1PWcUqWI7Jy1UatiRdUGQvTwCLznsRqLJ5KJI9q1uG6utNHVME7Luv4gEh/EpRoEuomhky/0nPJwXPbFd7phoaOXVA1cypDU3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613970; c=relaxed/simple;
	bh=YRV1kkmg7R+5X0z7UUUOx2r1naPI/3b7e/gwIDCZqDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PO0QVQVmetOg2/M0cEKROPYf0nhYQdTcB5DoKTyBZO8nT3sIyEZg+HIQ+jjuyi6cwetC6FMVFbEmaeQcKR339n+RYF/r60B6KgqIOADcfqkuigq0ff0lw0yoVllYWNG9OiJ9emL5/rZy2zSAZMP6i2URlZpkSCWbfXeuxTckHVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CszFfz/e; arc=fail smtp.client-ip=40.93.194.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CszFfz/e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Et14cnpFvy79DCoRfgariH3yixD8XwryDR3XI8nFb6AlWPF2pFFe0PTWpyMCEa5sOyqyOYAjSD7RtTSihFhBpm47hSoYptRuS6Pn3cejvB39WDf/iE5orS8tFaDQch9yNXh9MSv94L8fLq9FpCLIOq6bD3+pNoNhhicfuEGDFlDG+B+QLpX7uUTO9Ebz9QKZhccEqhdT+oSR0zCidN6LsQtrhyor3lak8PzkArGFEvohKro+NiabXiZG2pgYJExwuiyH+VQxicH3bhMrl3zKNYFqNiVhlK5tw27Vv5ZBia7JTpnSOj8Ca41iJktiPkys6avduw88W0dy3IJPS2Dz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ircHi2mA/Gr/W73laA4cli+A86meov8xAEKBUAVClaI=;
 b=JpCV7ceDD6iJvoavQlI1Ca7LqAnOHVZzrEETZmyneH3rCYr7Ya6FOfaI+AUqdjbKRAsj4catUr8vwU9U43TSCl1marb/cONnLne9V5sykFas7Tjr6eWITmSiFieLjUnTZrRLLcdq/xQ9+q7a4K8nI7RJfjfNGzoFdPUlpBFJEdX+3EWrKuqggu0oOzoT0U+We5waJLyIHGeoS3HIsT12hk0tBpDMdIQY5fQwWaf0Ui3KlyNzLx6yjTckmws8iGysYH4XKOiAhV9ZFqqBV54nnuXl/9ucYZmmSAjhLmCduaWsm1qYhliYJZ+sfAQD6iw8wEidMSZ7XUBVbe0aRARvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ircHi2mA/Gr/W73laA4cli+A86meov8xAEKBUAVClaI=;
 b=CszFfz/eXf88Mju+kiNga+j6dJCe1ABYspZm5hmP/Ov16lXOcp6y7u6G4j5eyHof9FsokuP2m3MGmasOKSJEAcQazzgbJtrEImCp3cIosrkJSssuE+C8k1aLKdx/9btha64k3tQYlo8+R4dQMw4zbWtTwaqLCdSKHkXOOEL2eOjwJKVvsLJJvnUEu127ieiqLVRCUOb5rCfdZNgqQbuPrZF0qBwc58W1zQYvQ1EiyUvPLRN1Gm+gLif2l8OHZ1/mNlDpoTXHvceJiHqbCoAf935q764cWbQTJDp0f6ioUxI5uJPVaGZZuvjH5dgn27wrrNFaq7EW1L0AwekFqemWIQ==
Received: from BN9PR03CA0893.namprd03.prod.outlook.com (2603:10b6:408:13c::28)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.14; Thu, 13 Aug 2026 09:39:21 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::53) by BN9PR03CA0893.outlook.office365.com
 (2603:10b6:408:13c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Thu,
 13 Aug 2026 09:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:39:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:39:05 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:38:56 -0700
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
Subject: [PATCH v4 12/27] vfio/pci: Let a provider exclude a BAR sub-range from mmap
Date: Thu, 13 Aug 2026 15:06:16 +0530
Message-ID: <20260813093631.2288172-13-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093631.2288172-1-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 78819fbc-eeb0-4440-032b-08def91ec07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|921020|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	8UXa0U3SwG4bx/bQRSyfuoNLm6BF42n5EXsPqPR5DC2Gu1S4ojrlF6SG0LKpiC/sIvVELExiBfe4RGd0dd+afWDZPc1A+cvdh8S5iHN4MH32lS++1aL+3fFlW9gi60yjghpnhXhanbYdId7cZ1mS+ziucqEB+7WabQDZx3J7XijHgtkrYFW8rhgUkszD9bcic1gZwuCxteJhNI7H3YAkUAOq/jO0lvUACvGZ+kvJpOPP8vkVGHwcde1f/uEQHmvX2PSWdj6wtqN0hKe+YSFz3ty7uaD/FesgNLzm07X8ANgHEdRuuQfGW25bkP6zLlAF4DXSd8OjMTfKXB9U0e/k4nyoNNwVDOqNH7upgkg/QbUVUaOG9mKibhDTclMh87UszxOaTQ62vvkfNTwiEkkR1pFiM41DrSmYcm5ns/t8An8whc5fKEo0RYWjlZqqmZc1rjH9zXwOFDmb7g8l2696R7MKGtoATiZdI1eRU6Q0V2/PCN9VEjcUVxNAL6XoIFFeUPHQ2TUEPXqS25Y6eTlV8wlp57uh1Hpe5MlByj4e0SgRrj/kOugrPI60MVYUX4ua7a/RVQWWMpzL8eSJKGs3IMKR4ObkZhY2umBfcTdQ9Nj9gy4I5REhn3LV4acJzIKbNW7veHFh1UfRoHXr5UNBrox8gC5iZI0nUGEd8llygLi2A9S+fQPNTfmNHtHeLtKpY+AzAJaIfglPmI1PUg82NNbMvvh7X5rcNZQVr2+7oct5I63z0ml4TZEQZBMcp569
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(921020)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	myN7745ErLD0sUsgPLoj9ILzU6cLCr7fKMj/oz1A1G8ZNnIEeEBh2GmHQGzTMr10UpizhdtlmXbtL4drXN6ETFhbL5IB0Tt2Ycvu/TNpu0Pc08AZ+0eFVcuoi92DHtL9JA1RzRHG6YG9Z4gYPrszCwt8e9A7/0xta8sZz1q1ZOcevMQn0xY60VXAgDgAvotXnoUKzw8/PrlqITTVk/0za8poqnRIBPrAY/7YAU6NvDpONOyfvqmjXhLTJ/VtqYx8p5KNf7fgs9dbz7v+Yw2ai796pRVs9mbISGQHDV5UeM9nTsuOlV/J5gmSqqGF6V5RBGCW5wUIMgIZpQX3vG+PoWY1+JF5ERX+jd3v0RYQWjQUvgJ3oTsP37ZEYst1lZSqSH0hL/ncOeSav0nKvq2Fa+MWi5uMQxXIB3mhHrRT2GFguEInMfTdSA2yg/KP0MGG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:39:20.4656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78819fbc-eeb0-4440-032b-08def91ec07a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336

From: Manish Honap <mhonap@nvidia.com>

Some devices expose registers in a BAR that must be reached only through
a trap, not a direct guest mapping. A CXL Type-2 device's HDM decoder
block is one: mapping it would let userspace reprogram the physical
decoder that governs host memory decode. Give a provider a way to mark a
BAR sub-range off-limits to mmap; it is advertised as a sparse-mmap
region and refused in the mmap path, while the provider's own region
still serves it.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c   | 72 ++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_dmabuf.c | 13 ++++++
 drivers/vfio/pci/vfio_pci_priv.h   | 13 ++++++
 include/linux/vfio_pci_core.h      |  6 +++
 4 files changed, 104 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 0f9b5dfeea66..49dfbdaf3f05 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1009,6 +1009,67 @@ static int msix_mmappable_cap(struct vfio_pci_core_device *vdev,
 	return vfio_info_add_capability(caps, &header, sizeof(header));
 }
 
+/*
+ * A provider can keep a BAR sub-range off mmap (for example a CXL device's
+ * trapped HDM decoder block). Callers hold the resource so /dev/mem is already
+ * blocked; this only governs the vfio mmap path.
+ */
+void vfio_pci_core_set_mmap_exclude(struct vfio_pci_core_device *vdev, int bar,
+				    u64 start, u64 len)
+{
+	vdev->mmap_exclude_bar = bar;
+	vdev->mmap_exclude_start = start;
+	vdev->mmap_exclude_len = len;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_set_mmap_exclude);
+
+/* Advertise the BAR as mmappable minus the excluded sub-range. */
+static int vfio_pci_mmap_exclude_cap(struct vfio_pci_core_device *vdev,
+				     int index, struct vfio_info_cap *caps)
+{
+	u64 bar_len = pci_resource_len(vdev->pdev, index);
+	u64 excl_start = ALIGN_DOWN(vdev->mmap_exclude_start, PAGE_SIZE);
+	u64 excl_end = ALIGN(vdev->mmap_exclude_start + vdev->mmap_exclude_len,
+			     PAGE_SIZE);
+	struct vfio_region_info_cap_sparse_mmap *sparse;
+	int nr_areas = 0, i = 0, ret;
+	size_t size;
+
+	/*
+	 * mmap is page granular, so the mmappable areas must stop at the page
+	 * boundaries enclosing the excluded sub-range. The byte-granular
+	 * exclusion still governs the fault and read/write paths; only the
+	 * advertised mmap areas round out to whole pages.
+	 */
+	if (excl_start > 0)
+		nr_areas++;
+	if (excl_end < bar_len)
+		nr_areas++;
+
+	size = struct_size(sparse, areas, nr_areas);
+	sparse = kzalloc(size, GFP_KERNEL);
+	if (!sparse)
+		return -ENOMEM;
+
+	sparse->header.id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
+	sparse->header.version = 1;
+	sparse->nr_areas = nr_areas;
+
+	if (excl_start > 0) {
+		sparse->areas[i].offset = 0;
+		sparse->areas[i].size = excl_start;
+		i++;
+	}
+	if (excl_end < bar_len) {
+		sparse->areas[i].offset = excl_end;
+		sparse->areas[i].size = bar_len - excl_end;
+	}
+
+	ret = vfio_info_add_capability(caps, &sparse->header, size);
+	kfree(sparse);
+	return ret;
+}
+
 int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      unsigned int type, unsigned int subtype,
 				      const struct vfio_pci_regops *ops,
@@ -1157,6 +1218,13 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 				if (ret)
 					return ret;
 			}
+			if (vdev->mmap_exclude_len &&
+			    info->index == vdev->mmap_exclude_bar) {
+				ret = vfio_pci_mmap_exclude_cap(vdev, info->index,
+								caps);
+				if (ret)
+					return ret;
+			}
 		}
 
 		break;
@@ -1851,6 +1919,10 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	if (req_start + req_len > phys_len)
 		return -EINVAL;
 
+	/* An excluded sub-range is reachable only through its trap, not mmap. */
+	if (vfio_pci_bar_is_excluded(vdev, index, req_start, req_len))
+		return -EINVAL;
+
 	/*
 	 * Ensure the BAR resource region is reserved for use.
 	 */
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..51983105d38b 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -177,11 +177,24 @@ int vfio_pci_core_get_dmabuf_phys(struct vfio_pci_core_device *vdev,
 				  size_t nr_ranges)
 {
 	struct pci_dev *pdev = vdev->pdev;
+	unsigned int i;
 
 	*provider = pcim_p2pdma_provider(pdev, region_index);
 	if (!*provider)
 		return -EINVAL;
 
+	/*
+	 * A provider (e.g. vfio-cxl) can exclude a BAR sub-range that must be
+	 * reached only through its trap. The mmap and read/write paths already
+	 * refuse it; reject a DMA-BUF export overlapping it too, so a device fd
+	 * holder cannot map the excluded registers to a peer and bypass the trap.
+	 */
+	for (i = 0; i < nr_ranges; i++)
+		if (vfio_pci_bar_is_excluded(vdev, region_index,
+					     dma_ranges[i].offset,
+					     dma_ranges[i].length))
+			return -EINVAL;
+
 	return vfio_pci_core_fill_phys_vec(
 		phys_vec, dma_ranges, nr_ranges,
 		pci_resource_start(pdev, region_index),
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..902d17815ab6 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -44,6 +44,19 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 
+/*
+ * A provider (e.g. vfio-cxl) can carve a sub-range out of a BAR that must be
+ * reached only through its trap, never the direct BAR.  Returns true when
+ * [start, start + len) on this BAR overlaps that excluded range.
+ */
+static inline bool vfio_pci_bar_is_excluded(struct vfio_pci_core_device *vdev,
+					    int bar, u64 start, u64 len)
+{
+	return vdev->mmap_exclude_len && bar == vdev->mmap_exclude_bar &&
+	       start < vdev->mmap_exclude_start + vdev->mmap_exclude_len &&
+	       start + len > vdev->mmap_exclude_start;
+}
+
 #ifdef CONFIG_VFIO_PCI_VGA
 ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 117cd67995d8..43755b91880f 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -162,6 +162,10 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	/* BAR sub-range a provider keeps off mmap, reached only through a trap */
+	int			mmap_exclude_bar;
+	u64			mmap_exclude_start;
+	u64			mmap_exclude_len;
 };
 
 enum vfio_pci_io_width {
@@ -176,6 +180,8 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      unsigned int type, unsigned int subtype,
 				      const struct vfio_pci_regops *ops,
 				      size_t size, u32 flags, void *data);
+void vfio_pci_core_set_mmap_exclude(struct vfio_pci_core_device *vdev, int bar,
+				    u64 start, u64 len);
 void vfio_pci_core_close_device(struct vfio_device *core_vdev);
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
 void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
-- 
2.25.1

