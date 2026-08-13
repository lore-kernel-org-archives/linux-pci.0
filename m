Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017E443312;
	Thu, 13 Aug 2026 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614031; cv=fail; b=GvKjrLSIjWo32fTiX37YQc9EwQUHDMjgS5xEGoY8SuZlI3sE/DhXNlVEJVrWchpC6RtRQM3k4RW1UIW2DDkTvUyGzrKqTX3v0ZTKPWBjWoDA48fpvdeWhaCtuNPBSpRIGtwVSQDVEHRBNx3vf/ft0tzWcEsnOZLe+JHwo2TPSIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614031; c=relaxed/simple;
	bh=/iCFDsCoO1dTJo0LdRvXy83D3jEU8O8G0Nwc/jWcrRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbmHMPt5dKzNoge0q+PWtvahJqL2YuDHATFxeHYj5kQNQV5UneCEayF7GZ0EK/s4TR7z5K6u3+gDTzxlJrRM9CdX/QOmb44I5MfwDWRSBaACatLkUvt7geZHdIZSnv6fJ1gZkXh7Q+Gh0e25cMnNWFGQb6d1uac0r2XpTnzvOzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K3X6Rb3m; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K3X6Rb3m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj+B08GvgyqFeGAi+9n6xmo8qxvbTMHV7s3gMab2TkBZ42b1+Ff5i5wlGL3PFAMmU2kB0+FMrvkaY4j9Yyj5H32/FoYBKSPfCX/vbfCtF7x0F/GMtLe12+dC2Q0KzXFfUpsuhsQYgBb/yfdb2eJ3fB4bLf6QdpXx+48o/INlEpbBlcK1dj3PGFtkT6OeAy+6dz8vCsBY07qej6Qg5vPyAe/wV5iBkOcKdwDEHnVB03TzHnt5SDDnflRIZh2Zn7GJpZFV8U/IEMzx7bGDo1YS+NGmmGzVsOzYC/INXkCUL10by+BeI/MqlMJTAOZcAyeCsKSbp4zsFgoZ5DD6NzFA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fbLxsB6YlVcswhQrayh18Hh+GMX+xBFdqDcOtcU6gg=;
 b=BaXtjtz+VsytMi8negs13hkRkldiCQKZz0u29lAXaxqHIByw0/C7jspuh5fGUJZtvyGe/exe/97x0iYVm2nnjYkvVCmyM58aSJOe59NT2ov4C3HLsHTOZAXt4AsNmZ2dyjvduc8qt2CFGgkSRDu14zGDKG9dFFjQGWkeJMqPltoHQebJ3lb78AXQrdabOYU+xjY3V+wWpOUBAbe10dXyYw8Y9Q5dd57plKDtcLWWzCKnoEXXp483NnYrrLdCsI1tJBPohVe4TLjVNIi80PPIbzIs055bNNvAY685lvrzg3XQhK8jOAPA4fZTSZd0im3XQCZXkVSkbFOUsglAx9tJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fbLxsB6YlVcswhQrayh18Hh+GMX+xBFdqDcOtcU6gg=;
 b=K3X6Rb3mIrd6SfOr7WNdHH97oTimjug1tPj3fs3ZCoyZcIWQ1CqOVU0czuLRNTfty5Q/flJyFSQXz6Zd/Kcd+A37oxRD1iKV4qCBZLnMwZCBdS8TuzDWAKZTQA+B6kuq1Z6bxwdTSk7P41SiNDeOGSBqhwMg/7WgCm2JNWtQkz8BjA82DVl3RyO16fyMxgJ0yBdtxFb6DwIgHKSuMBm0WeG8UdSjcYVpBq6zAI/1S2sHRkfrhvaHa4FZVQJB/RIRJi+kAiJ/tybOAbAJT1a/fu0qzv62Qn65Fqi6QYDEpmdI2QTT87ev/UtwQoAgPTm0+95HigwR94IrT/ObJl+Ckw==
Received: from BN9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::13)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 09:40:19 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::a0) by BN9P223CA0008.outlook.office365.com
 (2603:10b6:408:10b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:40:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:40:03 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:39:53 -0700
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
Subject: [PATCH v4 18/27] vfio/cxl: Expose the HDM memory and trap the decoder registers
Date: Thu, 13 Aug 2026 15:06:22 +0530
Message-ID: <20260813093631.2288172-19-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d66d0f4-c986-4ee7-225d-08def91ee353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|23010399003|376014|18002099003|22082099003|56012099006|11063799006|10067099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	mVTRvheEEOktHlyZ9NmMg6sxp5Ce5r/VlMWOEfPaBdvVJxmmVNZmNJLfgDHZAK5NSlnf/SoyUaOTHABHjHO8QWcuhkx/SnsxbhLXRSbOaaSt4rSUFbsT91n0azCYZ8iH5aebqMClQwHW56yRnl1hOxFUCr9+qK3iiWS/FVySVgJgnYrQ1uHLGKgtKP2pzwX47UKpi9bDzNTZzrlF8I8vFTBflIFHHR8nNoRmXM6BKAs30qgtrPHtx5+JdTpA57dHxwiYhyvZWPL0x8GF/wGr59VP4ItHWpInz2BQyIVG9bVe44i1ognBmbDCUsdvmPpptpBTmm2K2Uf9mH/L5MCfcZ8esOnj2tPuO5MzXShDM4jZmMuJSVsgTlswLzcnRiSqOjCsQeDgYDuqzPM2uz23Va+B8Z9Y80WRzLqRgE/hRZ+IPrBgc+/FCBuu+oXJaRsKYmbnU7fByGlf9sDf5CGhEiwEkoUWaouP36ku662EICcca8uAPqEA9o1youVGIjpe0THFEg7BpSkuRk+5Dyb627VuJtb3fUjnnoo5D7okb5f0SqZAvDsGlBi3t84NPYwWxoRlP2sjOZYaR7Q7ZJJ3VPXxT+lzergb4c4YkAyJZVeZbe0eOcGkwTViWlO+zHZEskXYvzPGq8BuIXCM29Z19Chi2B4gJFJ7/RFKDwWCGdvCnppGeVk523aL2gtZ8t5xuwlmMT4gFwnKdBCS9Qk7r4TVGGu7IcFOQ5KUZ97ZJjNmDzuwW6lcXTfRnlTTshXu
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rwDe1FCbXIhrqFytWyLnnRDLEL9UrRAjCD8gjhMKHWbhxvF7KLjNGZFSCLrm0kpL8c6C5bW2TwpYzFPzYZMF848+qgUydIEQU2dkBKaSjBX65lKZ5Wnnt0AHA9VkfCnYW953/JVqkFt2HuyLaXojwBiGGVuMH5/9A3nWwxYma1S3GsYOQwirilHU4BeSOhzi5F5cROlTt8VbSRhhheUAaVUEtguDQzy0YJzOiyJooZ8WN5Qus9WnozTJYS3DIis3raH9y4zIlNCIemR1/rnqWExQWYeYO5SmtyZjkfBmN9+ZR8nUsJwI3IkCCiQ/Pm+sibMu+qi7FYsfk1vZO9R8W0GdR5/x7a4KEsj+UsTMfPydvpW2F/DGpzRmtS1sw7LnjrJWJ1uxIVTFJiYTP3/yZPPqHA1uzWLOHewygENicFgyk+PrsVP66spw75EwRFsT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:40:18.9657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d66d0f4-c986-4ee7-225d-08def91ee353
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040

From: Manish Honap <mhonap@nvidia.com>

Register the HDM region as a CXL VFIO region so the guest can map
the device memory.

CXL.mem is coherent memory, so the guest and KVM need a write-back
mapping. Claim the host physical range exclusively at bind so a
firmware-owned cacheable alias cannot fault the host once the range is
mapped write-back.

The region is advertised mmap-able, so a fd holder can fault its
struct-page-less device memory in from the host CPU. A memory error on
that range would otherwise escalate to a host SError. Register the range
with memory_failure() via register_pfn_address_space() so such an error
is contained to unmapping the range and a SIGBUS to the fd holder.
register_pfn_address_space() returns -EOPNOTSUPP when
CONFIG_MEMORY_FAILURE is off, in which case the region is exposed
without containment.

A CXL Type-2 guest also reads the HDM decoder registers to learn the
HDM region it was handed. Those registers live in the component BAR that
vfio-pci owns, so map the decoder block at bind and copy it into a
per-open shadow, then expose a read-only region backed by that shadow.
The block location comes from the pdev->hdm enumeration cache rather
than the CXL core register map.

The guest programs a GPA into the decoder while the host resolves the
HPA, so it must never reach the physical registers. Serving reads from
the shadow keeps the two apart; write emulation follows in a later
change.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 347 ++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_core.c     |  17 ++
 include/linux/vfio_pci_core.h        |   1 +
 include/uapi/linux/vfio.h            |   3 +
 4 files changed, 367 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 9fed909cb9d3..07047646edde 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -5,10 +5,14 @@
  * Copyright (c) 2026 NVIDIA Corporation & Affiliates
  */
 
+#include <linux/cleanup.h>
+#include <linux/memory-failure.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/range.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 #include <linux/vfio_pci_core.h>
 #include <cxl/cxl.h>
 #include <cxl/pci.h>
@@ -18,21 +22,250 @@
  * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create()
  * @cxlmd: memory device joined to the CXL topology at bind
  * @hpa_range: host physical range of the HDM region
+ * @dpa_pfn_space: HDM-region pfn range registered with memory_failure()
  * @dvsec: CXL device DVSEC config-space offset
  * @dvsec_len: length of the DVSEC body
  * @dvsec_dwords: dword count of @dvsec_shadow
  * @dvsec_shadow: guest view of the CXL DVSEC body, sampled at open
+ * @hdm_regs: mapped HDM decoder registers, source for the open-time snapshot
+ * @hdm_len: length of the HDM decoder register block
+ * @hdm_shadow: guest view of the HDM decoder registers, sampled at open
+ * @hdm_region_idx: vdev->region[] index of the HDM region
+ * @hdm_valid: true when the decoder is in a known-good restored state and host
+ *	       CPU access to the HDM range is safe; gated under memory_lock
  */
 struct vfio_cxl_state {
 	struct cxl_dev_state cxlds;
 	struct cxl_memdev *cxlmd;
 	struct range hpa_range;
+	struct pfn_address_space dpa_pfn_space;
 	u16 dvsec;
 	u32 dvsec_len;
 	u32 dvsec_dwords;
+
 	u32 *dvsec_shadow __counted_by_ptr(dvsec_dwords);
+	void __iomem *hdm_regs;
+	u32 hdm_len;
+	u32 hdm_dwords;
+
+	__le32 *hdm_shadow __counted_by_ptr(hdm_dwords);
+	int hdm_region_idx;
+	bool hdm_valid;
+};
+
+static unsigned long vfio_cxl_mem_pgoff(struct vm_area_struct *vma,
+					unsigned long addr)
+{
+	unsigned long mask = (1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1;
+
+	return (vma->vm_pgoff & mask) + ((addr - vma->vm_start) >> PAGE_SHIFT);
+}
+
+static vm_fault_t vfio_cxl_mem_huge_fault(struct vm_fault *vmf,
+					  unsigned int order)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct vfio_pci_core_device *vdev = vma->vm_private_data;
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	unsigned long addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
+	unsigned long pfn = PHYS_PFN(cxl->hpa_range.start) +
+			    vfio_cxl_mem_pgoff(vma, addr);
+	vm_fault_t ret = VM_FAULT_FALLBACK;
+
+	if (is_aligned_for_order(vma, addr, pfn, order)) {
+		scoped_guard(rwsem_read, &vdev->memory_lock) {
+			/*
+			 * A reset or D3 transition takes memory_lock for write,
+			 * revokes this mapping and clears the decoder. Do not
+			 * insert a PFN for a decoder that is not in a known-good
+			 * state, or the host CPU could reach a disabled decoder.
+			 * vfio_pci_vmf_insert_pfn() adds the Memory-Space gate:
+			 * an HDM access while the device has Memory-Space disabled
+			 * aborts on the fabric as a fatal host SError, so it must
+			 * not be faulted in until the guest re-enables it.
+			 */
+			if (cxl->hdm_valid)
+				ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn,
+							      order);
+			else
+				ret = VM_FAULT_SIGBUS;
+		}
+	}
+
+	return ret;
+}
+
+static vm_fault_t vfio_cxl_mem_fault(struct vm_fault *vmf)
+{
+	return vfio_cxl_mem_huge_fault(vmf, 0);
+}
+
+static const struct vm_operations_struct vfio_cxl_mem_vm_ops = {
+	.fault = vfio_cxl_mem_fault,
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+	.huge_fault = vfio_cxl_mem_huge_fault,
+#endif
+};
+
+static int vfio_cxl_mem_mmap(struct vfio_pci_core_device *vdev,
+			     struct vfio_pci_region *region,
+			     struct vm_area_struct *vma)
+{
+	unsigned long mask = (1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1;
+	u64 req_start = (vma->vm_pgoff & mask) << PAGE_SHIFT;
+	u64 req_len = vma->vm_end - vma->vm_start;
+
+	if (req_start + req_len > region->size)
+		return -EINVAL;
+
+	/*
+	 * CXL.mem is coherent memory, so leave the mapping write-back cacheable;
+	 * a device or non-cached mapping would break the coherence the guest and
+	 * KVM depend on. The host physical range is claimed exclusively at bind,
+	 * so no conflicting cacheable alias remains.
+	 */
+	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+	vma->vm_ops = &vfio_cxl_mem_vm_ops;
+	vma->vm_private_data = vdev;
+
+	return 0;
+}
+
+static ssize_t vfio_cxl_mem_rw(struct vfio_pci_core_device *vdev,
+			       char __user *buf, size_t count, loff_t *ppos,
+			       bool iswrite)
+{
+	/*
+	 * The HDM region advertises READ and WRITE so a VMM can derive an
+	 * accessible mmap protection for it, but fd read/write is not supported.
+	 * The only host-side way to reach the range for a copy is a kernel
+	 * mapping of the CXL.mem host physical address (memremap, which reuses
+	 * the linear map for this RAM-backed range), and a CPU access through
+	 * that mapping aborts on the fabric as a fatal host SError, unlike the
+	 * guest-facing mmap fault path which maps the pfn directly. Reject the
+	 * transfer rather than fault the host; a consumer mmaps the region and
+	 * accesses it that way.
+	 */
+	return -EIO;
+}
+
+/*
+ * The CXL regions carry no per-region state (region->data is the shared,
+ * devm-managed vfio_cxl_state), so releasing a region is a no-op. The hook is
+ * still required: vfio_pci_core_disable() calls region->ops->release() for
+ * every region without a NULL check.
+ */
+static void vfio_cxl_region_release(struct vfio_pci_core_device *vdev,
+				    struct vfio_pci_region *region)
+{
+}
+
+static const struct vfio_pci_regops vfio_cxl_mem_regops = {
+	.rw = vfio_cxl_mem_rw,
+	.mmap = vfio_cxl_mem_mmap,
+	.release = vfio_cxl_region_release,
+};
+
+/*
+ * Map a poisoned HDM-region pfn back to the file offset of each user mapping so
+ * memory_failure() can unmap it and signal the fd holder. The region is a
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
+ * memory_failure() so such an error is contained to unmapping the range and a
+ * SIGBUS to the fd holder instead of escalating to a host SError.
+ */
+static int vfio_cxl_register_pfn_space(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	unsigned long start_pfn = PHYS_PFN(cxl->hpa_range.start);
+
+	cxl->dpa_pfn_space.node.start = start_pfn;
+	cxl->dpa_pfn_space.node.last =
+		start_pfn + (range_len(&cxl->hpa_range) >> PAGE_SHIFT) - 1;
+	cxl->dpa_pfn_space.mapping = vdev->vdev.inode->i_mapping;
+	cxl->dpa_pfn_space.pfn_to_vma_pgoff = vfio_cxl_pfn_to_vma_pgoff;
+
+	return register_pfn_address_space(&cxl->dpa_pfn_space);
+}
+
+static ssize_t vfio_cxl_comp_rw(struct vfio_pci_core_device *vdev,
+				char __user *buf, size_t count, loff_t *ppos,
+				bool iswrite)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+
+	/*
+	 * The guest programs a GPA into this decoder and the host resolves the
+	 * HPA, so the guest never drives the physical decoder. Reads come from
+	 * the open-time snapshot; write emulation lands in a later change.
+	 */
+	if (iswrite)
+		return -EINVAL;
+
+	if (pos >= cxl->hdm_len)
+		return -EINVAL;
+
+	count = min_t(size_t, count, cxl->hdm_len - pos);
+	/*
+	 * The shadow mirrors the physical decoder, so BASE_LOW/HIGH carry the
+	 * host HPA. That is visible only to the trusted VMM holding the fd; the
+	 * VMM virtualizes the base so the guest sees its own GPA and never the
+	 * host address.
+	 */
+	if (copy_to_user(buf, (u8 *)cxl->hdm_shadow + pos, count))
+		return -EFAULT;
+
+	*ppos += count;
+	return count;
+}
+
+static const struct vfio_pci_regops vfio_cxl_comp_regops = {
+	.rw = vfio_cxl_comp_rw,
+	.release = vfio_cxl_region_release,
 };
 
+static void vfio_cxl_release_hpa(void *data)
+{
+	struct vfio_cxl_state *cxl = data;
+
+	release_mem_region(cxl->hpa_range.start, range_len(&cxl->hpa_range));
+}
+
 static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -92,6 +325,20 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Map the HDM decoder registers to sample their programming at open.
+	 * The block location comes from the enumeration cache in pdev->hdm, so
+	 * this does not reach into the CXL core register map. vfio-pci owns the
+	 * BAR, so map without claiming the sub-block.
+	 */
+	cxl->hdm_regs = devm_ioremap(&pdev->dev,
+				     pci_resource_start(pdev, pdev->hdm->hdm_bar) +
+				     pdev->hdm->hdm_offset, pdev->hdm->hdm_size);
+	if (!cxl->hdm_regs)
+		return -ENOMEM;
+
+	cxl->hdm_len = pdev->hdm->hdm_size;
+
 	ret = cxl_set_capacity(&cxl->cxlds, hdm_size);
 	if (ret)
 		return ret;
@@ -100,9 +347,30 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	/*
+	 * Own the resolved host physical range outright, and exclusively: mark
+	 * it IORESOURCE_EXCLUSIVE so /dev/mem cannot map a conflicting alias even
+	 * on an IO_STRICT_DEVMEM=n kernel. Firmware that left it as System RAM
+	 * would otherwise keep a cacheable alias that faults the host once the
+	 * guest maps the range write-back. There is no devm form of the exclusive
+	 * request, so pair it with a devm release action.
+	 */
+	if (!request_mem_region_exclusive(cxl->hpa_range.start,
+					  range_len(&cxl->hpa_range),
+					  "vfio-cxl-hdm"))
+		return -EBUSY;
+	ret = devm_add_action_or_reset(&pdev->dev, vfio_cxl_release_hpa, cxl);
+	if (ret)
+		return ret;
+
 	cxl->cxlmd = cxlmd;
 	vdev->cxl = cxl;
 
+	/*
+	 * The VFIO regions and the poison-containment pfn space are set up in
+	 * open_device(): vfio_pci_core_disable() tears down all dynamic regions on
+	 * close, so they must be created per open rather than once at bind.
+	 */
 	return 0;
 }
 
@@ -114,9 +382,11 @@ static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
 static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct vfio_cxl_state *cxl = vdev->cxl;
+	void __iomem *hdm = cxl->hdm_regs;
 	struct pci_dev *pdev = vdev->pdev;
+	__le32 *hdm_shadow;
 	u32 hdr, *shadow;
-	int i, dwords;
+	int i, dwords, ret;
 
 	/*
 	 * Sample the DVSEC body now rather than at bind: a low-power
@@ -137,13 +407,88 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 	cxl->dvsec_dwords = dwords;
 	cxl->dvsec_shadow = shadow;
 
+	dwords = cxl->hdm_len / sizeof(u32);
+	hdm_shadow = kcalloc(dwords, sizeof(__le32), GFP_KERNEL);
+	if (!hdm_shadow) {
+		kfree(shadow);
+		cxl->dvsec_shadow = NULL;
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < dwords; i++)
+		hdm_shadow[i] = cpu_to_le32(readl(hdm + i * sizeof(u32)));
+
+	cxl->hdm_dwords = dwords;
+	cxl->hdm_shadow = hdm_shadow;
+
+	/*
+	 * vfio_pci_core_disable() frees all dynamic regions on close, so register
+	 * them here (per open) rather than at bind. A failed first-open never
+	 * reaches close_device(), so unwind on error.
+	 *
+	 * Advertise READ and WRITE alongside MMAP: a VMM derives the mmap
+	 * protection from these flags, so without them the HDM memory is mapped
+	 * PROT_NONE and a guest access faults (KVM cannot back the mapping). The
+	 * flags describe the mmap protection only; fd read/write returns -EIO,
+	 * because a host CPU read through a kernel mapping of the coherent
+	 * CXL.mem range aborts on the fabric (see vfio_cxl_mem_rw()).
+	 */
+	ret = vfio_pci_core_register_dev_region(vdev, VFIO_REGION_TYPE_CXL,
+						VFIO_REGION_SUBTYPE_CXL_MEM,
+						&vfio_cxl_mem_regops,
+						range_len(&cxl->hpa_range),
+						VFIO_REGION_INFO_FLAG_READ |
+						VFIO_REGION_INFO_FLAG_WRITE |
+						VFIO_REGION_INFO_FLAG_MMAP, cxl);
+	if (ret)
+		goto err_free_shadows;
+
+	ret = vfio_pci_core_register_dev_region(vdev, VFIO_REGION_TYPE_CXL,
+						VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
+						&vfio_cxl_comp_regops, cxl->hdm_len,
+						VFIO_REGION_INFO_FLAG_READ, cxl);
+	if (ret)
+		goto err_unregister_hdm;
+
+	/*
+	 * The HDM region is advertised mmap-able, so a fd holder can fault its
+	 * struct-page-less device memory in from the host CPU. Register it with
+	 * memory_failure() to contain a memory error. -EOPNOTSUPP means
+	 * CONFIG_MEMORY_FAILURE is off, so run without containment.
+	 */
+	ret = vfio_cxl_register_pfn_space(vdev);
+	if (ret && ret != -EOPNOTSUPP)
+		goto err_unregister_comp;
+
+	/*
+	 * The decoder is firmware-committed and the shadow now mirrors it, so
+	 * host access to the HDM range is safe. Open the access gate; reset and
+	 * power transitions clear it until the decoder is restored.
+	 */
+	cxl->hdm_valid = true;
+
 	return 0;
+
+err_unregister_comp:
+	vfio_pci_core_unregister_dev_region(vdev);
+err_unregister_hdm:
+	vfio_pci_core_unregister_dev_region(vdev);
+err_free_shadows:
+	kfree(cxl->hdm_shadow);
+	cxl->hdm_shadow = NULL;
+	kfree(cxl->dvsec_shadow);
+	cxl->dvsec_shadow = NULL;
+	return ret;
 }
 
 static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
 {
 	struct vfio_cxl_state *cxl = vdev->cxl;
 
+	cxl->hdm_valid = false;
+	unregister_pfn_address_space(&cxl->dpa_pfn_space);
+	kfree(cxl->hdm_shadow);
+	cxl->hdm_shadow = NULL;
 	kfree(cxl->dvsec_shadow);
 	cxl->dvsec_shadow = NULL;
 }
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 470730cdc88b..6f6ebcce86a1 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1123,6 +1123,23 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_register_dev_region);
 
+/*
+ * Unregister the most recently registered dynamic region. Used to unwind a
+ * partially built region set on an open-time error; regions are otherwise
+ * released together in vfio_pci_core_disable().
+ */
+void vfio_pci_core_unregister_dev_region(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_region *region;
+
+	if (WARN_ON(!vdev->num_regions))
+		return;
+
+	region = &vdev->region[--vdev->num_regions];
+	region->ops->release(vdev, region);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_dev_region);
+
 static int vfio_pci_info_atomic_cap(struct vfio_pci_core_device *vdev,
 				    struct vfio_info_cap *caps)
 {
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index b9202cb29d96..294e95b5e881 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -187,6 +187,7 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      unsigned int type, unsigned int subtype,
 				      const struct vfio_pci_regops *ops,
 				      size_t size, u32 flags, void *data);
+void vfio_pci_core_unregister_dev_region(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_set_mmap_exclude(struct vfio_pci_core_device *vdev, int bar,
 				    u64 start, u64 len);
 void vfio_pci_core_close_device(struct vfio_device *core_vdev);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 540e62312671..d5b8106625bf 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -377,6 +377,9 @@ struct vfio_region_info_cap_type {
 /* sub-types for VFIO_REGION_TYPE_CXL */
 /* CXL.mem HDM region of a Type-2 device, mmap-able */
 #define VFIO_REGION_SUBTYPE_CXL_MEM		(1)
+/* CXL HDM decoder registers, trapped so the guest programs a GPA it never owns */
+#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS	(2)
+/* Subtypes 3+ are reserved for future trapped CXL surfaces, e.g. RAS. */
 
 /**
  * struct vfio_region_gfx_edid - EDID region layout.
-- 
2.25.1

