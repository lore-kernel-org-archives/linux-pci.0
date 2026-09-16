Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F73A4E1C72;
	Wed, 16 Sep 2026 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584086; cv=fail; b=UeslIzYrfX63++p1aAlfxi7wX4vUFGV4uKGwrFhLCrB/kOW2qJuPoKrr+TiKeMkQ+AF8A71Msd/G/jUe3yEh7Y1/+zrP6POhSkVe4rKddkR8NFJQvRh7i5Qwek/BchtiwMcnGzrKchVR5CoA2BH3g4wNc/UIccy1ujWyU9wDL3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584086; c=relaxed/simple;
	bh=lsdNQKJfbwUwL3fcyINU0BikERYGm0oFAVUkleFVRvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcNZoq4g7yLoxF5TmJUN0IhrGysj04r6Y1wGTJSnbzxznAWFzu0sb7C5YdG7nGwZcUSZ34RM/Zloe/NqJ4v45eRNsyPS7oqTPBP1Wn81NHHm2YAGSc8nk5RaLjA5w/BeXVyuTF6tW4smwv+SWJtJsy0Ea9mCDJl+BaKzFGnur4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qWpp7SZ8; arc=fail smtp.client-ip=52.101.56.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qWpp7SZ8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUEFNh152YfEudW4Le/a/CjMy+2LZTnXwl/WvIFhTuGAy2skR8mqv5A16TAVZ2xQU6Vn+8aXPvVRyV3ww2dl8K8rVZzAaU5gezJZfWXmOUM/D6xgkdtzKT9rW+6/rEZ61bE4zU9E8UKW9DwiqU6vGPENs5h5Bsj+nXagm+cmUOkKS3dKlaq4npLwWM301A2fOqlbhwdKZyP6AssoUfhZEsPgAGIAE6IaMTcGpYNJecBw+VLFBpM243iTNjL1uGdnW9fqdZp0ihqVLruItraGLCqTYbQ01D6UueDCXwNLkIUuMmNQmNc8VSSDEPz9e+DtIITIHQA18zI70YgeXUcnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBd7Xeie+dCzyEwlKftOgnwdT2uEYBBw1finbr1c7Ag=;
 b=Yj8UPwbPKHzlLTfU18rtRDxCkKa4l4n+wT1gI1XsB6PGd6oLJTx2msvhXHtPzTI+YtaYxB7UGKXFSiSmCKBIuycSkafDmPWkdgn3X3rEQ4qlQQK69UcLPV7yZNZukKv5lrheY41p9PVfSz1lxKoQRjEnSDNFzfwb0AJdl/wuKqjV90Lnhkm+jtlIpwhQddNH/8e+dI6jq/mk3VcfCAAnTBeWCWUHdd+KJE8CXmPtAEIGycB2LvukGQAoXMmKnxV121WeKnuJDyQ/BGboF4IkiNA8mBy9bfPsJsKTOyAh7bzHhy5anjBN5sYoBU/Dvh1jd9C908gQ5xWSRFC6OSp6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBd7Xeie+dCzyEwlKftOgnwdT2uEYBBw1finbr1c7Ag=;
 b=qWpp7SZ8aEJsbBKkAf/b/VgIqUzvOe+ht+GOXagL0lTQ9QPxI8JWt/vBax8wMb/Hqsfv3ijbYkasTbxdCxRNGbl3z+a3239AO+GEIrirYFMJMOG4hkpgsnEQedVEplL9Ho736LccghBTZVO6wo744wO8ym7tqcwQxo78vniuTazCHzcW7E+wb+6mH5Kdb9PDF4P4Dv1t62xSDxUUfa5LkHSJdgfZLKG8jTcA/Gzu8hVd0cU4MdY9p4rUtNgd2hjOoylMrn/9gZNQ59Y3sNam8lxl2yR0na/7Oxd2SoKHSp5leJ6CqrZ0bhnBOnvM5sV0NYAnDlV8cCQOo1Adz+nq0A==
Received: from BN0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:e7::10)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 18:40:48 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::78) by BN0PR03CA0035.outlook.office365.com
 (2603:10b6:408:e7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:40:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:40:17 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:40:07 -0700
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
Subject: [PATCH v5 27/27] selftests/vfio: Add CXL Type-2 passthrough tests
Date: Thu, 17 Sep 2026 00:05:40 +0530
Message-ID: <20260916183540.3813685-28-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|IA1PR12MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 17dde075-0ab7-46a4-9489-08df142206c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|36860700016|82310400026|921020|18002099003|6133799003|10067099003|22082099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	aBof4FXyfMLQzNQMBuzob4vcDY6aTE6rh8utVpCKJZXMAgaaeyshitesOZRza0b4fq0rFX3tPkQc1Ekvg95fuutnveqGuqynUIqegWEliIzwKh3SpXCwVhny6MFJdoUkT0c/u5CVL577IEFryLUL2y/WwFCmjKtw0r8E+ojT3oi1U6Be0N2PmJIg3UC7XEJ1TcPYfi4a5NtDAaxvfscpQ7F4z3VX8sd+7mwJhMNxz5EoulHEBf1QctzKBYhilDvGpEWQ/0OoLXs5N88Wfl85Lh6fEWGJRgS7kCF2omzecZhLh+q4JpqH3WEjx1SHUsszLnoOayK61BDg4rIBM2qsVv5DkILSL8bhGK1rgBdd6it1xj4hlQPKEeAK9r1OJQpskdCIv6H8FpTwLTt33AIZOn7cNgVnJunx6Wxp4ie6Qj1sehkBoGl5YoddkHJn+SIIEGf1zE9+4JDki9tnXWjNorv+S8G8nYv6/N1apIStDaL81sHR1Yn2g48HEv45+hHwltRh5hUxyWmk3dAW/eYege6tx0xrEg7yse52pQQYnqiEBtu9sWrL6C3AizAUvsRPB+44pmTGEzRgCPxgbrnfiKXO9YB3HwaXL59uRKOd87ikgOMGPAtySTJMTegOHWaYq6CuT0OzSDkXqfAwJq76Fd07ICzlaywEEgxzEIDhPFw6NImIuXhhUXrL8E/3U+YSrzink4gzhvLV1XqcIRoSJSyeg78KHRzAMKycQBSIfxRI1+XpxSQ57ptGLS94oYBd
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(36860700016)(82310400026)(921020)(18002099003)(6133799003)(10067099003)(22082099003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dlLtjH8bDdGSJkjYXYNb4lFLV0J/fw4GXeFljauWvcJuC0Ilu1rrUrz7ekNM37nsH5/5XnuaLDK+hvEl3yECSTC5DiTONn0SOzFdtbaNTU3yKE9CDevG+T7Zq04Z5Ygab8tyDEx/7l4GWJq/90Ht3PfOchMyJSUlhq5R6EZCM6RXl3I9qxMmWx/lztct4eCk3Fxbn56xlKcBSzDNy195tmKO0g9N4crO1nWxvcIAa2mKfUYSLzMBODXSx/X3D87j3vjrhVl5yW6mT/mZXCWQJrhwEjqkOuh9m2qp/+JU0yy6Lt/umdrclw1p+cD9W58Fc4+GK2M1LSObCJPjUYFL7GYun9p62lJmQUSMoV5qKyWy9oRhrxMTKxcWn+icUdV95jlAI84M3cVVZqsp0CFw+Kg/vLq6HvbZQJFYIz3l+viQZYZWa8GZIBNf/9I4Q3Ch
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:40:48.2948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17dde075-0ab7-46a4-9489-08df142206c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614

From: Manish Honap <mhonap@nvidia.com>

Exercise the vfio-cxl contract on a bound Type-2 device: the CXL
device-info flag and the two vendor-type regions, the HDM memory mmap
(including a 2 MB huge fault) and its survival across a Memory Space
toggle, the read-only trapped decoder region against the live
host-committed decoder, and the guest's DVSEC reset doorbell and manual
HDM discovery.

Map the HDM memory the way a VMM does: export it as a dma-buf with
VFIO_DEVICE_FEATURE_DMA_BUF and map the fd into the IOAS with
IOMMU_IOAS_MAP_FILE. The struct-page-less range cannot be pinned through a
userspace VA, so the by-fd path is the one that works. Skip when the
kernel has no CXL dma-buf exporter, so the test becomes a real pass once
that support is present.

Add a partial-mmap path to the vfio selftest library so the trapped
component BAR maps its sparse ranges, and an __iommu_map_file() helper for
the dma-buf mapping.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/lib/include/libvfio/iommu.h          |   3 +
 tools/testing/selftests/vfio/lib/iommu.c      |  29 +
 .../selftests/vfio/lib/vfio_pci_device.c      |  57 +-
 .../selftests/vfio/vfio_cxl_type2_test.c      | 780 ++++++++++++++++++
 6 files changed, 868 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ab099b523054..a65dc71ada5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28646,6 +28646,7 @@ L:	linux-cxl@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/vfio-pci-cxl.rst
 F:	drivers/vfio/pci/cxl/
+F:	tools/testing/selftests/vfio/vfio_cxl_type2_test.c
 
 VFIO DRIVER
 M:	Alex Williamson <alex@shazbot.org>
diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..08f88e88cb4d 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
+TEST_GEN_PROGS += vfio_cxl_type2_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..77040fdb8848 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -42,6 +42,9 @@ static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
 	VFIO_ASSERT_EQ(__iommu_map(iommu, region), 0);
 }
 
+int __iommu_map_file(struct iommu *iommu, int fd, u64 start, u64 length,
+		     iova_t iova);
+
 int __iommu_unmap(struct iommu *iommu, struct dma_region *region, u64 *unmapped);
 
 static inline void iommu_unmap(struct iommu *iommu, struct dma_region *region)
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index b6f3c5c84e01..9109cedd734c 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -149,6 +149,35 @@ int __iommu_map(struct iommu *iommu, struct dma_region *region)
 	return 0;
 }
 
+/*
+ * Map a range of a file (a memfd or a supported dma-buf, such as a VFIO PCI
+ * dma-buf from VFIO_DEVICE_FEATURE_DMA_BUF) into the IOAS by fd. This is an
+ * iommufd-only ioctl; the legacy VFIO container has no equivalent.
+ */
+int __iommu_map_file(struct iommu *iommu, int fd, u64 start, u64 length,
+		     iova_t iova)
+{
+	struct iommu_ioas_map_file args = {
+		.size = sizeof(args),
+		.flags = IOMMU_IOAS_MAP_READABLE |
+			 IOMMU_IOAS_MAP_WRITEABLE |
+			 IOMMU_IOAS_MAP_FIXED_IOVA,
+		.ioas_id = iommu->ioas_id,
+		.fd = fd,
+		.start = start,
+		.length = length,
+		.iova = iova,
+	};
+
+	if (!iommu->iommufd)
+		return -EINVAL;
+
+	if (ioctl(iommu->iommufd, IOMMU_IOAS_MAP_FILE, &args))
+		return -errno;
+
+	return 0;
+}
+
 static int __vfio_iommu_unmap(int fd, u64 iova, u64 size, u32 flags, u64 *unmapped)
 {
 	struct vfio_iommu_type1_dma_unmap args = {
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 4063a0e2b3df..5f5ec3a70bd8 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -187,9 +187,31 @@ static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
 	ioctl_assert(device->fd, VFIO_DEVICE_GET_REGION_INFO, info);
 }
 
+/* Return the sparse-mmap capability in @info, or NULL if the region has none. */
+static struct vfio_region_info_cap_sparse_mmap *
+vfio_pci_sparse_mmap_cap(struct vfio_region_info *info)
+{
+	struct vfio_info_cap_header *hdr;
+	u32 offset;
+
+	if (!(info->flags & VFIO_REGION_INFO_FLAG_CAPS))
+		return NULL;
+
+	for (offset = info->cap_offset; offset; offset = hdr->next) {
+		hdr = (void *)info + offset;
+		if (hdr->id == VFIO_REGION_INFO_CAP_SPARSE_MMAP)
+			return (struct vfio_region_info_cap_sparse_mmap *)hdr;
+	}
+
+	return NULL;
+}
+
 static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
 {
 	struct vfio_pci_bar *bar = &device->bars[index];
+	struct vfio_region_info_cap_sparse_mmap *sparse;
+	u8 infobuf[1024] = {};
+	struct vfio_region_info *info = (void *)infobuf;
 	size_t align, size;
 	int prot = 0;
 	void *vaddr;
@@ -217,9 +239,38 @@ static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
 	align = min_t(size_t, size, SZ_1G);
 
 	vaddr = mmap_reserve(size, align, 0);
-	bar->vaddr = mmap(vaddr, size, prot, MAP_SHARED | MAP_FIXED,
-			  device->fd, bar->info.offset);
-	VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
+
+	/*
+	 * A BAR that is only partially mmappable, such as a CXL Type-2 component
+	 * BAR with the HDM decoder block trapped, advertises the mmappable
+	 * ranges through a sparse-mmap capability. Map each area within the
+	 * reservation and leave the excluded ranges unmapped; mapping the whole
+	 * BAR would be rejected.
+	 */
+	info->argsz = sizeof(infobuf);
+	info->index = index;
+	ioctl_assert(device->fd, VFIO_DEVICE_GET_REGION_INFO, info);
+	sparse = vfio_pci_sparse_mmap_cap(info);
+	if (sparse) {
+		u32 i;
+
+		bar->vaddr = vaddr;
+		for (i = 0; i < sparse->nr_areas; i++) {
+			void *p;
+
+			if (!sparse->areas[i].size)
+				continue;
+			p = mmap(vaddr + sparse->areas[i].offset,
+				 sparse->areas[i].size, prot,
+				 MAP_SHARED | MAP_FIXED, device->fd,
+				 bar->info.offset + sparse->areas[i].offset);
+			VFIO_ASSERT_NE(p, MAP_FAILED);
+		}
+	} else {
+		bar->vaddr = mmap(vaddr, size, prot, MAP_SHARED | MAP_FIXED,
+				  device->fd, bar->info.offset);
+		VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
+	}
 
 	madvise(bar->vaddr, size, MADV_HUGEPAGE);
 }
diff --git a/tools/testing/selftests/vfio/vfio_cxl_type2_test.c b/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
new file mode 100644
index 000000000000..78468abd2201
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
@@ -0,0 +1,780 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vfio_cxl_type2_test - corner-case tests for the vfio-cxl kernel contract.
+ *
+ * Exercises the user-visible surface the vfio-cxl module adds to a CXL Type-2
+ * device: the two VFIO regions (HDM memory and the trapped HDM decoder block),
+ * the component-register geometry capability, the dma-buf export of the HDM
+ * memory, and the guest decoder view.
+ *
+ * The host commits and locks the physical decoder before the guest sees the
+ * device, so the trapped block is served by a live read and a guest write is
+ * absorbed.
+ *
+ * Usage: ./vfio_cxl_type2_test <BDF>  (or export VFIO_SELFTESTS_BDF=<BDF>).
+ * The device must be bound to vfio-pci with the vfio-cxl module available.
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/pci_regs.h>
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <cxl/cxl_regs.h>
+
+#include <libvfio.h>
+
+#include "kselftest_harness.h"
+
+#define PCI_DVSEC_VENDOR_ID_CXL		0x1e98
+#define PCI_DVSEC_ID_CXL_DEVICE		0x0000
+
+/* CXL r3.1 8.1.9.1: Register Block Identifier for the component registers. */
+#define CXL_REGLOC_RBI_COMPONENT	1
+
+/* Register Locator DVSEC block-1 field masks. */
+#define REG_LOCATOR_BIR_MASK		0x00000007
+#define REG_LOCATOR_BLOCK_ID_MASK	0x0000ff00
+#define REG_LOCATOR_BLOCK_OFF_LOW_MASK	0xffff0000
+
+/* vfio-pci region-offset packing is kernel-internal, not UAPI; define locally. */
+#ifndef VFIO_PCI_OFFSET_SHIFT
+#define VFIO_PCI_OFFSET_SHIFT		40
+#endif
+#ifndef VFIO_PCI_INDEX_TO_OFFSET
+#define VFIO_PCI_INDEX_TO_OFFSET(i)	((uint64_t)(i) << VFIO_PCI_OFFSET_SHIFT)
+#endif
+
+static const char *device_bdf;
+
+/* Locate a region-info capability by id inside a GET_REGION_INFO buffer. */
+static const struct vfio_info_cap_header *
+find_region_cap(const void *buf, size_t bufsz, uint16_t id)
+{
+	const struct vfio_region_info *ri = buf;
+	const struct vfio_info_cap_header *cap;
+	size_t off = ri->cap_offset;
+
+	while (off && off + sizeof(*cap) <= bufsz) {
+		cap = (const void *)((const char *)buf + off);
+		if (cap->id == id)
+			return cap;
+		off = cap->next;
+	}
+	return NULL;
+}
+
+/* Find a CXL region by subtype; returns the region index or -1, @buf left holding its info. */
+static int find_cxl_region(int fd, uint32_t nregions, uint32_t subtype,
+			   void *buf, size_t bufsz)
+{
+	uint32_t i;
+
+	for (i = 0; i < nregions; i++) {
+		struct vfio_region_info *ri = buf;
+		const struct vfio_region_info_cap_type *t;
+		const struct vfio_info_cap_header *hdr;
+
+		memset(buf, 0, bufsz);
+		ri->argsz = bufsz;
+		ri->index = i;
+		if (ioctl(fd, VFIO_DEVICE_GET_REGION_INFO, ri))
+			continue;
+		if (!(ri->flags & VFIO_REGION_INFO_FLAG_CAPS))
+			continue;
+
+		hdr = find_region_cap(buf, bufsz, VFIO_REGION_INFO_CAP_TYPE);
+		if (!hdr)
+			continue;
+		t = (const void *)hdr;
+		if (t->type == (VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
+				PCI_DVSEC_VENDOR_ID_CXL) &&
+		    t->subtype == subtype)
+			return i;
+	}
+	return -1;
+}
+
+/* Walk the PCI extended capability list for the CXL Device DVSEC. */
+static uint16_t find_cxl_dvsec(struct vfio_pci_device *dev)
+{
+	uint16_t pos = PCI_CFG_SPACE_SIZE;
+	int iter = 0;
+
+	while (pos && iter++ < 64) {
+		uint32_t hdr = vfio_pci_config_readl(dev, pos);
+		uint16_t cap_id = hdr & 0xffff;
+		uint16_t next = (hdr >> 20) & 0xffc;
+		uint32_t h1, h2;
+
+		if (cap_id == PCI_EXT_CAP_ID_DVSEC) {
+			h1 = vfio_pci_config_readl(dev, pos + 4);
+			h2 = vfio_pci_config_readl(dev, pos + 8);
+			if ((h1 & 0xffff) == PCI_DVSEC_VENDOR_ID_CXL &&
+			    (h2 & 0xffff) == PCI_DVSEC_ID_CXL_DEVICE)
+				return pos;
+		}
+		pos = next;
+	}
+	return 0;
+}
+
+FIXTURE(vfio_cxl) {
+	struct iommu *iommu;
+	struct vfio_pci_device *dev;
+
+	int mem_idx;
+	uint64_t mem_size;
+	uint32_t mem_flags;
+	int comp_idx;
+	uint64_t comp_size;
+	uint32_t comp_bar;
+	uint64_t comp_offset;	/* HDM block offset within comp_bar */
+	uint64_t comp_off;	/* mmap/rw base offset of the comp region */
+	uint16_t dvsec;
+};
+
+FIXTURE_SETUP(vfio_cxl)
+{
+	uint8_t infobuf[512] = {};
+	struct vfio_device_info *info = (void *)infobuf;
+	const struct vfio_region_info_cap_cxl_comp_regs *geo;
+	const struct vfio_info_cap_header *hdr;
+	uint8_t rbuf[1024];
+	uint16_t cmd;
+
+	self->iommu = iommu_init(default_iommu_mode);
+	self->dev = vfio_pci_device_init(device_bdf, self->iommu);
+
+	info->argsz = sizeof(infobuf);
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_INFO, info));
+
+	if (!(info->flags & VFIO_DEVICE_FLAGS_CXL))
+		SKIP(return, "not a CXL Type-2 device");
+
+	self->mem_idx = find_cxl_region(self->dev->fd, info->num_regions,
+					VFIO_REGION_SUBTYPE_CXL_MEM,
+					rbuf, sizeof(rbuf));
+	ASSERT_GE(self->mem_idx, 0);
+	self->mem_size = ((struct vfio_region_info *)rbuf)->size;
+	self->mem_flags = ((struct vfio_region_info *)rbuf)->flags;
+
+	self->comp_idx = find_cxl_region(self->dev->fd, info->num_regions,
+					 VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
+					 rbuf, sizeof(rbuf));
+	ASSERT_GE(self->comp_idx, 0);
+	self->comp_size = ((struct vfio_region_info *)rbuf)->size;
+
+	/* The geometry cap rides on the component-register region. */
+	hdr = find_region_cap(rbuf, sizeof(rbuf),
+			      VFIO_REGION_INFO_CAP_CXL_COMP_REGS);
+	ASSERT_NE(NULL, hdr);
+	geo = (const void *)hdr;
+	self->comp_bar = geo->bar;
+	self->comp_offset = geo->offset;
+
+	self->comp_off = VFIO_PCI_INDEX_TO_OFFSET(self->comp_idx);
+	self->dvsec = find_cxl_dvsec(self->dev);
+
+	/* Enable PCI Memory-Space so the HDM mmap tests can touch the mapping. */
+	cmd = vfio_pci_config_readw(self->dev, PCI_COMMAND);
+	vfio_pci_config_writew(self->dev, PCI_COMMAND,
+			       cmd | PCI_COMMAND_MEMORY);
+}
+
+FIXTURE_TEARDOWN(vfio_cxl)
+{
+	vfio_pci_device_cleanup(self->dev);
+	iommu_cleanup(self->iommu);
+}
+
+/* GET_INFO advertises the flag and both CXL regions with a sane geometry cap. */
+TEST_F(vfio_cxl, device_is_cxl)
+{
+	ASSERT_NE(self->mem_idx, self->comp_idx);
+	ASSERT_GT(self->mem_size, 0);
+	ASSERT_GT(self->comp_size, 0);
+	ASSERT_LT(self->comp_bar, PCI_STD_NUM_BARS);
+	/* The HDM memory must advertise mmap; a VMM needs it for stage-2. */
+	ASSERT_NE(0, self->mem_flags & VFIO_REGION_INFO_FLAG_MMAP);
+}
+
+/*
+ * The component BAR carries the physical HDM decoder block, which vfio traps
+ * and excludes from mmap so the guest cannot reprogram it. The whole-BAR map
+ * must fail; the ranges around the excluded block must map.
+ */
+TEST_F(vfio_cxl, comp_bar_sparse_mmap)
+{
+	size_t page_size = getpagesize();
+	uint8_t rbuf[1024] = {};
+	struct vfio_region_info *ri = (void *)rbuf;
+	const struct vfio_region_info_cap_sparse_mmap *sm;
+	const struct vfio_info_cap_header *hdr;
+	uint64_t bar_off, decoder_page;
+	void *map;
+	uint32_t i;
+
+	ri->argsz = sizeof(rbuf);
+	ri->index = self->comp_bar;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, ri));
+	ASSERT_NE(0, ri->flags & VFIO_REGION_INFO_FLAG_MMAP);
+	bar_off = ri->offset;
+
+	/* The trapped decoder block splits the BAR, so it must be sparse. */
+	hdr = find_region_cap(rbuf, sizeof(rbuf),
+			      VFIO_REGION_INFO_CAP_SPARSE_MMAP);
+	ASSERT_NE(NULL, hdr);
+	sm = (const void *)hdr;
+	ASSERT_GT(sm->nr_areas, 0);
+
+	/* Mapping the whole BAR must fail: it covers the excluded block. */
+	map = mmap(NULL, ri->size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, bar_off);
+	ASSERT_EQ(MAP_FAILED, map);
+
+	/* Every advertised area is page aligned and must map. */
+	for (i = 0; i < sm->nr_areas; i++) {
+		uint64_t ao = sm->areas[i].offset;
+		uint64_t as = sm->areas[i].size;
+
+		if (!as)
+			continue;
+		ASSERT_EQ(0, ao & (page_size - 1));
+		ASSERT_EQ(0, as & (page_size - 1));
+
+		map = mmap(NULL, as, PROT_READ | PROT_WRITE, MAP_SHARED,
+			   self->dev->fd, bar_off + ao);
+		ASSERT_NE(MAP_FAILED, map);
+		ASSERT_EQ(0, munmap(map, as));
+	}
+
+	/* The page holding the decoder block must never be mmappable. */
+	decoder_page = self->comp_offset & ~(uint64_t)(page_size - 1);
+	map = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, bar_off + decoder_page);
+	ASSERT_EQ(MAP_FAILED, map);
+}
+
+/* Basic HDM memory mmap read/write round-trip. */
+TEST_F(vfio_cxl, hdm_mem_mmap_rw)
+{
+	uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
+	uint32_t pattern = 0xdeadbeefU, readback = 0;
+	void *map;
+
+	if (self->mem_size < SZ_4K)
+		SKIP(return, "HDM memory < 4K");
+
+	map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, off);
+	ASSERT_NE(MAP_FAILED, map);
+
+	memcpy(map, &pattern, sizeof(pattern));
+	memcpy(&readback, map, sizeof(readback));
+	ASSERT_EQ(pattern, readback);
+
+	ASSERT_EQ(0, munmap(map, SZ_4K));
+}
+
+/* A 2 MB-aligned HDM window mapped as a huge (PMD) fault. */
+TEST_F(vfio_cxl, hdm_mem_huge_mmap)
+{
+	uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
+	uint32_t pattern = 0x5a5a5a5aU, readback = 0;
+	void *map, *last;
+
+	if (self->mem_size < SZ_2M)
+		SKIP(return, "HDM memory < 2M");
+
+	map = mmap(NULL, SZ_2M, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, off);
+	ASSERT_NE(MAP_FAILED, map);
+
+	last = (char *)map + SZ_2M - sizeof(pattern);
+	memcpy(last, &pattern, sizeof(pattern));
+	memcpy(&readback, last, sizeof(readback));
+	ASSERT_EQ(pattern, readback);
+
+	ASSERT_EQ(0, munmap(map, SZ_2M));
+}
+
+/*
+ * A VMM maps the HDM range into the guest IOAS by fd (the struct-page-less
+ * range cannot be pinned through a VA): export it as a dma-buf and map that fd
+ * with IOMMU_IOAS_MAP_FILE.
+ */
+TEST_F(vfio_cxl, hdm_mem_ioas_map)
+{
+	uint8_t buf[sizeof(struct vfio_device_feature) +
+		    sizeof(struct vfio_device_feature_dma_buf) +
+		    sizeof(struct vfio_region_dma_range)] = {};
+	struct vfio_device_feature *feat = (void *)buf;
+	struct vfio_device_feature_dma_buf *db = (void *)feat->data;
+	struct iova_allocator *iova_alloc;
+	int dmabuf_fd;
+	iova_t iova;
+	int ret;
+
+	if (!self->iommu->iommufd)
+		SKIP(return, "IOMMU_IOAS_MAP_FILE needs the iommufd backend");
+	if (self->mem_size < SZ_2M)
+		SKIP(return, "HDM memory < 2M");
+
+	feat->argsz = sizeof(buf);
+	feat->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF;
+	db->region_index = self->mem_idx;
+	db->nr_ranges = 1;
+	db->dma_ranges[0].offset = 0;
+	db->dma_ranges[0].length = SZ_2M;
+
+	ret = ioctl(self->dev->fd, VFIO_DEVICE_FEATURE, feat);
+	if (ret < 0 && (errno == EINVAL || errno == EOPNOTSUPP))
+		SKIP(return, "kernel has no CXL dma-buf exporter");
+	ASSERT_GE(ret, 0);
+	dmabuf_fd = ret;
+
+	iova_alloc = iova_allocator_init(self->iommu);
+	iova = iova_allocator_alloc(iova_alloc, SZ_2M);
+
+	ASSERT_EQ(0, __iommu_map_file(self->iommu, dmabuf_fd, 0, SZ_2M, iova));
+	iommu_unmap_all(self->iommu);
+
+	iova_allocator_cleanup(iova_alloc);
+	ASSERT_EQ(0, close(dmabuf_fd));
+}
+
+/* The trapped block starts at the HDM decoder registers; CTRL 0 reads back. */
+TEST_F(vfio_cxl, comp_regs_hdm_read)
+{
+	uint64_t ctrl = self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0);
+	uint32_t val = 0;
+
+	ASSERT_GE(self->comp_size, CXL_HDM_DECODER0_CTRL_OFFSET(0) + 4);
+	ASSERT_EQ((ssize_t)sizeof(val),
+		  pread(self->dev->fd, &val, sizeof(val), ctrl));
+}
+
+/* The decoder registers only take aligned dword accesses. */
+TEST_F(vfio_cxl, comp_regs_reject_unaligned)
+{
+	uint32_t val = 0;
+	uint16_t half = 0;
+
+	ASSERT_EQ(-1, pread(self->dev->fd, &val, sizeof(val),
+			    self->comp_off + 1));
+	ASSERT_EQ(-1, pread(self->dev->fd, &half, sizeof(half),
+			    self->comp_off));
+}
+
+/* Accesses past the region end are rejected. */
+TEST_F(vfio_cxl, comp_regs_reject_out_of_range)
+{
+	uint32_t val = 0;
+
+	ASSERT_EQ(-1, pread(self->dev->fd, &val, sizeof(val),
+			    self->comp_off + self->comp_size));
+}
+
+/*
+ * Commit handshake: the host committed and locked the physical decoder, so the
+ * trapped block reads back COMMITTED and a guest decommit request is absorbed.
+ */
+TEST_F(vfio_cxl, hdm_commit_fsm)
+{
+	uint64_t ctrl = self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0);
+	uint32_t v, orig;
+
+	ASSERT_EQ((ssize_t)sizeof(orig),
+		  pread(self->dev->fd, &orig, sizeof(orig), ctrl));
+
+	if (!(orig & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		SKIP(return, "HDM decoder 0 not committed by firmware");
+
+	/* A decommit request is absorbed; the decoder stays committed. */
+	v = orig & ~CXL_HDM_DECODER0_CTRL_COMMIT;
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pwrite(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pread(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_TRUE(v & CXL_HDM_DECODER0_CTRL_COMMITTED);
+}
+
+/*
+ * Lock on commit: the host committed the decoder with LOCK set, so a guest
+ * write is absorbed and it stays committed and locked.
+ */
+TEST_F(vfio_cxl, hdm_lock_on_commit)
+{
+	uint64_t ctrl = self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0);
+	uint32_t v;
+
+	v = CXL_HDM_DECODER0_CTRL_COMMIT | CXL_HDM_DECODER0_CTRL_LOCK;
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pwrite(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pread(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_TRUE(v & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	ASSERT_TRUE(v & CXL_HDM_DECODER0_CTRL_LOCK);
+
+	/* Attempt to decommit the locked decoder; it must stay committed. */
+	v = 0;
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pwrite(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pread(self->dev->fd, &v, sizeof(v), ctrl));
+	ASSERT_TRUE(v & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	ASSERT_TRUE(v & CXL_HDM_DECODER0_CTRL_LOCK);
+}
+
+/*
+ * The committed decoder holds its base read-only: a guest write to the base is
+ * absorbed and reads back the host-committed value.
+ */
+TEST_F(vfio_cxl, hdm_base_write_absorbed)
+{
+	uint64_t lo_off = self->comp_off + CXL_HDM_DECODER0_BASE_LOW_OFFSET(0);
+	uint64_t ctrl_off = self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0);
+	uint32_t v = 0x30000000U;	/* 256 MB-aligned low base bits */
+	uint32_t rb = 0, orig = 0, ctrl = 0;
+
+	ASSERT_GE(self->comp_size, CXL_HDM_DECODER0_BASE_LOW_OFFSET(0) + 4);
+	ASSERT_EQ((ssize_t)sizeof(ctrl),
+		  pread(self->dev->fd, &ctrl, sizeof(ctrl), ctrl_off));
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		SKIP(return, "HDM decoder 0 not committed by firmware");
+
+	ASSERT_EQ((ssize_t)sizeof(orig),
+		  pread(self->dev->fd, &orig, sizeof(orig), lo_off));
+
+	/* The write is absorbed; the base reads back unchanged. */
+	ASSERT_EQ((ssize_t)sizeof(v),
+		  pwrite(self->dev->fd, &v, sizeof(v), lo_off));
+	ASSERT_EQ((ssize_t)sizeof(rb),
+		  pread(self->dev->fd, &rb, sizeof(rb), lo_off));
+	ASSERT_EQ(orig, rb);
+}
+
+/*
+ * The CXL Device DVSEC body is virtualized by the kernel; a config read is
+ * served from the shadow.
+ */
+TEST_F(vfio_cxl, dvsec_body_read)
+{
+	uint32_t v;
+
+	if (!self->dvsec)
+		SKIP(return, "CXL Device DVSEC not found");
+
+	v = vfio_pci_config_readl(self->dev, self->dvsec + PCI_DVSEC_HEADER1);
+	ASSERT_NE(0xffffffffU, v);
+}
+
+/*
+ * Guest-initiated CXL reset: the DVSEC Initiate_CXL_Reset write self-clears and
+ * STATUS2 reports completion, synthesized in the shadow; the real reset runs at
+ * the vfio reset points.
+ */
+TEST_F(vfio_cxl, guest_cxl_reset)
+{
+	uint16_t cap, ctrl2, status2;
+
+	if (!self->dvsec)
+		SKIP(return, "CXL Device DVSEC not found");
+
+	cap = vfio_pci_config_readw(self->dev, self->dvsec + PCI_DVSEC_CXL_CAP);
+	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
+		SKIP(return, "device does not support CXL reset");
+
+	ctrl2 = vfio_pci_config_readw(self->dev,
+				      self->dvsec + PCI_DVSEC_CXL_CTRL2);
+	vfio_pci_config_writew(self->dev, self->dvsec + PCI_DVSEC_CXL_CTRL2,
+			       ctrl2 | PCI_DVSEC_CXL_INIT_CXL_RST);
+
+	/* Initiate_CXL_Reset self-clears once the sequence has run. */
+	ctrl2 = vfio_pci_config_readw(self->dev,
+				      self->dvsec + PCI_DVSEC_CXL_CTRL2);
+	ASSERT_FALSE(ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST);
+
+	/* STATUS2 reports the outcome; a completed reset sets RESET_COMPLETE. */
+	status2 = vfio_pci_config_readw(self->dev,
+					self->dvsec + PCI_DVSEC_CXL_STATUS2);
+	ASSERT_TRUE(status2 & PCI_DVSEC_CXL_RST_DONE);
+	ASSERT_FALSE(status2 & PCI_DVSEC_CXL_RST_ERR);
+}
+
+/*
+ * A real reset must run end to end, not just the shadow DVSEC path
+ * guest_cxl_reset covers: a CXL Type-2 device must advertise
+ * VFIO_DEVICE_FLAGS_RESET and complete a real VFIO_DEVICE_RESET.
+ */
+TEST_F(vfio_cxl, device_reset)
+{
+	uint8_t infobuf[512] = {};
+	struct vfio_device_info *info = (void *)infobuf;
+	int ret, retries = 20;
+
+	info->argsz = sizeof(infobuf);
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_INFO, info));
+
+	ASSERT_NE(0, info->flags & VFIO_DEVICE_FLAGS_RESET);
+
+	/* Drive the real reset, retrying the transient device-lock contention. */
+	do {
+		ret = __vfio_pci_device_reset(self->dev);
+		if (ret == -EAGAIN)
+			usleep(10000);
+	} while (ret == -EAGAIN && retries-- > 0);
+	ASSERT_EQ(0, ret);
+}
+
+/*
+ * The component BAR is reachable by fd read except the trapped decoder block,
+ * which is served only through the comp-regs region; a VMM relies on this split.
+ */
+TEST_F(vfio_cxl, comp_bar_rdwr_split)
+{
+	uint64_t bar_off = VFIO_PCI_INDEX_TO_OFFSET(self->comp_bar);
+	uint32_t val;
+
+	/* A non-decoder dword of the BAR reads back through the fd. */
+	ASSERT_EQ((ssize_t)sizeof(val),
+		  pread(self->dev->fd, &val, sizeof(val), bar_off));
+
+	/*
+	 * The trapped decoder block is off-limits to raw BAR fd access: the read
+	 * returns all-ones, not the real decoder contents.
+	 */
+	val = 0;
+	ASSERT_EQ((ssize_t)sizeof(val),
+		  pread(self->dev->fd, &val, sizeof(val),
+			bar_off + self->comp_offset));
+	ASSERT_EQ(0xffffffffU, val);
+}
+
+/*
+ * Mirror the guest's HDM discovery, which does not use VFIO's geometry cap: it
+ * finds the range by walking the config-space DVSECs and the component-register
+ * array to the HDM decoder itself.
+ */
+TEST_F(vfio_cxl, guest_hdm_discovery)
+{
+	uint64_t bar_off = VFIO_PCI_INDEX_TO_OFFSET(self->comp_bar);
+	uint32_t reg_lo, reg_hi, cap_array, cap_count, hdr;
+	uint32_t bl, bh, sl, sh, ctrl;
+	uint64_t block_off, cm, hdm_off = 0, base, size;
+	uint16_t pos = PCI_CFG_SPACE_SIZE, regloc = 0, block1;
+	int iter = 0, bar, i;
+
+	/* 1. Find the CXL Register Locator DVSEC in config space. */
+	while (pos && iter++ < 64) {
+		uint32_t h = vfio_pci_config_readl(self->dev, pos);
+
+		if ((h & 0xffff) == PCI_EXT_CAP_ID_DVSEC) {
+			uint32_t h1 = vfio_pci_config_readl(self->dev, pos + 4);
+			uint32_t h2 = vfio_pci_config_readl(self->dev, pos + 8);
+
+			if ((h1 & 0xffff) == PCI_DVSEC_VENDOR_ID_CXL &&
+			    (h2 & 0xffff) == PCI_DVSEC_CXL_REG_LOCATOR) {
+				regloc = pos;
+				break;
+			}
+		}
+		pos = (h >> 20) & 0xffc;
+	}
+	ASSERT_NE(0, regloc);
+
+	/* 2. Take the component register block BAR and offset from block 1. */
+	block1 = regloc + PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1;
+	reg_lo = vfio_pci_config_readl(self->dev, block1);
+	reg_hi = vfio_pci_config_readl(self->dev, block1 + 4);
+
+	ASSERT_EQ(CXL_REGLOC_RBI_COMPONENT,
+		  (reg_lo & REG_LOCATOR_BLOCK_ID_MASK) >> 8);
+	bar = reg_lo & REG_LOCATOR_BIR_MASK;
+	block_off = ((uint64_t)reg_hi << 32) |
+		    (reg_lo & REG_LOCATOR_BLOCK_OFF_LOW_MASK);
+
+	/* The DVSEC must name the same BAR the geometry cap reported. */
+	ASSERT_EQ(self->comp_bar, bar);
+
+	/* 3. Walk the CM capability array over the BAR to find the HDM cap. */
+	cm = block_off + CXL_CM_OFFSET;
+	ASSERT_EQ((ssize_t)sizeof(cap_array),
+		  pread(self->dev->fd, &cap_array, sizeof(cap_array),
+			bar_off + cm + CXL_CM_CAP_HDR_OFFSET));
+	ASSERT_EQ(CM_CAP_HDR_CAP_ID, cap_array & CXL_CM_CAP_HDR_ID_MASK);
+
+	cap_count = (cap_array & CXL_CM_CAP_HDR_ARRAY_SIZE_MASK) >> 24;
+	for (i = 1; i <= (int)cap_count; i++) {
+		ASSERT_EQ((ssize_t)sizeof(hdr),
+			  pread(self->dev->fd, &hdr, sizeof(hdr),
+				bar_off + cm + i * 4));
+		if ((hdr & CXL_CM_CAP_HDR_ID_MASK) == CXL_CM_CAP_CAP_ID_HDM) {
+			hdm_off = cm + ((hdr & CXL_CM_CAP_PTR_MASK) >> 20);
+			break;
+		}
+	}
+	ASSERT_NE(0, hdm_off);
+
+	/* The guest's manual walk must land on the decoder the kernel traps. */
+	ASSERT_EQ(self->comp_offset, hdm_off);
+
+	/* 4. Read decoder 0 through the trapped region and derive base/size. */
+	ASSERT_EQ((ssize_t)sizeof(bl),
+		  pread(self->dev->fd, &bl, sizeof(bl),
+			self->comp_off + CXL_HDM_DECODER0_BASE_LOW_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(bh),
+		  pread(self->dev->fd, &bh, sizeof(bh),
+			self->comp_off + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(sl),
+		  pread(self->dev->fd, &sl, sizeof(sl),
+			self->comp_off + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(sh),
+		  pread(self->dev->fd, &sh, sizeof(sh),
+			self->comp_off + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(ctrl),
+		  pread(self->dev->fd, &ctrl, sizeof(ctrl),
+			self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0)));
+
+	base = ((uint64_t)bh << 32) | bl;
+	size = ((uint64_t)sh << 32) | sl;
+
+	/* A guest only accepts a committed decoder; the derived range must be non-empty. */
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		SKIP(return, "HDM decoder 0 not committed by firmware");
+
+	ASSERT_GT(size, 0);
+	ASSERT_LT(base, base + size);
+}
+
+/*
+ * Tie the committed decoder's geometry to the HDM memory region a VMM hands the
+ * guest: confirm the mmap-able region covers exactly the decoder's range, then
+ * map the advertised base and touch it.
+ */
+TEST_F(vfio_cxl, hdm_mem_touch_committed_base)
+{
+	uint64_t mem_off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
+	uint32_t pattern = 0xc0ffee11U, readback = 0;
+	uint32_t bl, bh, sl, sh, ctrl;
+	uint64_t base, size;
+	void *map;
+
+	ASSERT_EQ((ssize_t)sizeof(ctrl),
+		  pread(self->dev->fd, &ctrl, sizeof(ctrl),
+			self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0)));
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		SKIP(return, "HDM decoder 0 not committed by firmware");
+
+	ASSERT_EQ((ssize_t)sizeof(bl),
+		  pread(self->dev->fd, &bl, sizeof(bl),
+			self->comp_off + CXL_HDM_DECODER0_BASE_LOW_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(bh),
+		  pread(self->dev->fd, &bh, sizeof(bh),
+			self->comp_off + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(sl),
+		  pread(self->dev->fd, &sl, sizeof(sl),
+			self->comp_off + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(0)));
+	ASSERT_EQ((ssize_t)sizeof(sh),
+		  pread(self->dev->fd, &sh, sizeof(sh),
+			self->comp_off + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(0)));
+
+	base = ((uint64_t)bh << 32) | bl;
+	size = ((uint64_t)sh << 32) | sl;
+
+	ASSERT_GT(size, 0);
+	ASSERT_LT(base, base + size);
+	/* The mmap-able HDM region must cover exactly the committed decoder. */
+	ASSERT_EQ(size, self->mem_size);
+
+	if (self->mem_size < SZ_4K)
+		SKIP(return, "HDM memory < 4K");
+
+	/* Region offset 0 is the decoder's advertised base; map it and touch it. */
+	map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, mem_off);
+	ASSERT_NE(MAP_FAILED, map);
+
+	memcpy(map, &pattern, sizeof(pattern));
+	memcpy(&readback, map, sizeof(readback));
+	ASSERT_EQ(pattern, readback);
+
+	ASSERT_EQ(0, munmap(map, SZ_4K));
+}
+
+/*
+ * The CXL Device DVSEC is served from a shadow: Control is guest-programmable
+ * but Capability keeps its firmware snapshot, so a guest cannot reprogram the
+ * device through the DVSEC.
+ */
+TEST_F(vfio_cxl, dvsec_write_virtualized)
+{
+	uint16_t cap, ctrl, v;
+
+	if (!self->dvsec)
+		SKIP(return, "CXL Device DVSEC not found");
+
+	/* A write to the read-only Capability register is absorbed. */
+	cap = vfio_pci_config_readw(self->dev, self->dvsec + PCI_DVSEC_CXL_CAP);
+	vfio_pci_config_writew(self->dev, self->dvsec + PCI_DVSEC_CXL_CAP,
+			       cap ^ 0xffff);
+	v = vfio_pci_config_readw(self->dev, self->dvsec + PCI_DVSEC_CXL_CAP);
+	ASSERT_EQ(cap, v);
+
+	/* Control is guest-programmable; a write reads back from the shadow. */
+	ctrl = vfio_pci_config_readw(self->dev, self->dvsec + PCI_DVSEC_CXL_CTRL);
+	vfio_pci_config_writew(self->dev, self->dvsec + PCI_DVSEC_CXL_CTRL,
+			       ctrl ^ 0x1);
+	v = vfio_pci_config_readw(self->dev, self->dvsec + PCI_DVSEC_CXL_CTRL);
+	ASSERT_EQ((uint16_t)(ctrl ^ 0x1), v);
+	vfio_pci_config_writew(self->dev, self->dvsec + PCI_DVSEC_CXL_CTRL, ctrl);
+}
+
+/*
+ * Region-info contract: the HDM memory region is readable, writable and
+ * mmappable; the trapped comp-regs region is fd-only and carries the geometry
+ * capability.
+ */
+TEST_F(vfio_cxl, region_flags)
+{
+	const uint32_t rw = VFIO_REGION_INFO_FLAG_READ |
+			    VFIO_REGION_INFO_FLAG_WRITE;
+	const struct vfio_info_cap_header *geo;
+	uint8_t rbuf[1024] = {};
+	struct vfio_region_info *ri = (void *)rbuf;
+
+	ri->argsz = sizeof(rbuf);
+	ri->index = self->mem_idx;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, ri));
+	ASSERT_EQ(rw | VFIO_REGION_INFO_FLAG_MMAP,
+		  ri->flags & (rw | VFIO_REGION_INFO_FLAG_MMAP));
+
+	memset(rbuf, 0, sizeof(rbuf));
+	ri->argsz = sizeof(rbuf);
+	ri->index = self->comp_idx;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, ri));
+	ASSERT_EQ(rw, ri->flags & rw);
+	ASSERT_EQ(0, ri->flags & VFIO_REGION_INFO_FLAG_MMAP);
+	geo = find_region_cap(rbuf, sizeof(rbuf),
+			      VFIO_REGION_INFO_CAP_CXL_COMP_REGS);
+	ASSERT_NE(NULL, geo);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.25.1

