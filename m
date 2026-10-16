Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30948488D;
	Fri, 16 Oct 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167795; cv=fail; b=awHLLex/gGxroga6d1wpnEnMjO+lLXZS57VbGQW9aP1AKO+c9iPmDAW2ixOVzexeNZDzjYP5A78OV619YcJqg4hv709tqpYy++iKJx4uoAksmS4yocMy/gsC6ryNsNx0J0yEC90P3CZGj4oVG7W9UmUSXSlQzQBMgzCQghGBWIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167795; c=relaxed/simple;
	bh=J2EsODocr6sAIV4LyvmaPy4kBbpY8OaFJI0Cowos51k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0dZxkNTwSd4jiOf/CTURV2yXUYyOj5Pipp5QB5qfgWPjopeJGDAoFQgnj2/4AXr8tUQ+NSZc7PWXqu6/rxZAjTROwQ8rLslOfS9GzRZs0ULi+7vU7zw1WE5a+VQgIRrAJQjYPPKmt8h3CwGYt5bo6FVBXm+IVhCXE0OkUzTHYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bMY2wn/N; arc=fail smtp.client-ip=52.101.56.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bMY2wn/N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQDqRf8/nunPejFvBmvlYATg6ckfcRPZPR042S5dEt4kalKKiKF8ihwk63qKYcUdmOenq1+o6KHJYpqn5FD5zrpuA/W9+/FIkuS2LZSWX8V1uW3sQitZ9xAZI6CfZBuVb9Uoa1EbAz8BH7wjCOLxqdoued+Rv9h7Oa3UqVGN1LO/UUsqf3Sn/6bVh3hYw1L1CRzVxsg68ZeRxmWfbnR4NxKSHEhVx3SZOV2P/KomK5pYl1cLqWbTvGlIM0fPENeqnYgxkg6P3yxFgAph6Xg182RgX/B8w+HIlURONRDGI7wIS0qWcgB8cg8iJykVZbT02PIVDhv31Fxq8reWxmY9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4sOsoITAm65Uo3RxNHBGvOEvuzEy3LKCwKxoecGv6k=;
 b=tdPjCEtadgkzCZYk4gtjxiq3bplkzMQrMkQqqJv111ZvtfVrNFpDNWZlgU2QldAEBwqz6q0fj3fPzgXzaTPuR462SjK+Qkxcr8Kn5aGNE74yoUPowh/FtG3H7eKviO9eYSCJfOFDWbXKNGEAO9ID3gq5kkibac1ElNDKQwcRF8YLQxDYYpufz8vK+YL9NlQ7aiqLc/3QlsiVE9tvhknw2YIGEk4RFTNHxTPBWOAEW9l0GNkbO4tFZEwLoHfcjf1gBZXbm8rNF5m98rSRKld02HY6Xkk3dXN2rwo2J6VrrTzJwYgwPRHh7OCBAGU7ARgk9EM7EgtXKHo0xSrjOF//lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4sOsoITAm65Uo3RxNHBGvOEvuzEy3LKCwKxoecGv6k=;
 b=bMY2wn/NskI5ufWTmqSChmfvgYdLlcI3NbeIynI5rwF5p2VedBeh3vXSvDVY7Epw525+t5kChr02mom9OtVnRk/932NvA7nTagYfYTSzT3D8QmBwj8Yt7eJtF/RrAzbNl/eUupXkzmidLv4SQsC/cBEjsixCcT4D+8icWaY0GOLcnvJIgki+h53eE14zX9dZV4L4t/IM72fkRwvHvOzNL9aWf30Be7/5XM9cL8/grfFWvz+bi/o0x/H3o1r8/iM/yXiXafYBwDegL7sRWwivy6W/5hythdTNixI0pgXWavh5N+OfF9E5zGQDYznvzxelfif5Ju/jdKtvez9PeIFRbQ==
Received: from MN2PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:23a::26)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 16:22:49 +0000
Received: from BN7PEPF000000A4.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::7d) by MN2PR03CA0021.outlook.office365.com
 (2603:10b6:208:23a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:22:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A4.mail.protection.outlook.com (10.167.245.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:22:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:22:20 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:22:11 -0700
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
Subject: [PATCH v6 22/31] vfio/cxl: Allow mmap of the HDM memory region
Date: Fri, 16 Oct 2026 21:48:29 +0530
Message-ID: <20261016161839.2765592-23-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A4:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe617a1-a132-4f9f-699e-08df2ba1b6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|23010399003|6133799003|18002099003|22082099003|10067099003|11063799006|261009223027099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	qRgl3r0HNscFgFqybKzNWw+eytXE1//6WrPHJ2ncm1foREhhQo0LzDNqBEpxl13hkxoQNp0vOU7vLJ2En9gg0QpikxwHNN3iQ7E1VnfMbKGGm8wC+RLBGwk5eGSdwcueGXqbgeORbAqdWeEHetemv6uOwnGPaS6kZrMBUsjhRG/sVEyB1HcyQWYnW/ovyEIO1dJtB0voPXl/jNxpnz9cPQKeex6ZMFdPGuL4DrXo4Vq5j+brmrOzNQ81D2vOKDebZi+mqAykePJiE+h6ga5IbC0ozj6HsZccX6LsJjRdKD7by0ehv5NqSKR4stfXmSdDe6xwZMSVU/2mgy/taPBrpj5a8e9FGx2tPO4Tpj1X3YNFteAOaAWB9VQVxlZUpcdPmyI8Ft4RSlQ6q4KcIRmmj3UbV6m6aRVAnnhFjSoeqguOEweePPKprv26fBCqfIJ/IfyZveCn01D/hyA1O+LcrT9WEcWVznPWGaxhXPV3V2ktIPQX5WwI6HfMVdMKZ+F83nolIj4fUZbPhRNM4yUVDKxQFnzQPkT3t2e07SSMmku0oH7iD9DQcSI5JxCWZWupjq2QX8N/8u4WJ/umMz2XQcy5oHG0OsU8WHDaC1CpdrOdefwlRyaqiFxhPco7xA8DQNLL5cRquGezGwAurKH/8ACvwshDevixFwnt9GNw1vtvj1HpF03DyS2v3P6CeQtzhKmmG6/9/g2p1xayIb9xckjJHP3+ofiX/HIPsOm48cz4AnyEyPROqBTIVw3PbgW5
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cXWCPWvHUd2QNHqpA+9HDq6LyYsWlymQRciUDGPTuXRdTOxtfvHl4G434RyXM1C22O2XV/tPGKIe0Sn9MSRfI2FjZ/xOep5xbmgnqkVrbOIeD/g3NSwfhteuXxT3pAuKhxN51KZNmYsZnYd02tNNuy8xCSbv2megSpPawE/M1Wrwpgb2Y7c3dE4B29W3dP1EsdB+m9hV8dKIU6kuwYm63jrZe9U0aDm/thZXWZtfLlVFyue7o+nGFZgVCal8VIFEh63m3glqq6ZZRLIwbbvqGCU52glR56E7kZahzw8nZeJJ3e5VieGINu/RocIBHGQ2sZG2MAYe4BwgccFJV2/+sFPmsO8Aea9Lg3LGDkYQ6jK6TVlPFqv+rOhmYyN6J/fhzNm7otuyv5XSocBcejm+BrY6stcGYipvWVWfd2b4gamLckg/+CPZ/1o7hhHGtAYl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:22:46.7595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe617a1-a132-4f9f-699e-08df2ba1b6f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 guest maps the device HDM memory to use its coherent
CXL.mem, so the guest and KVM need a write-back mapping of the HDM
memory region. Make the region mmap-able. The range has no struct page,
so the mapping is VM_PFNMAP and its fault handler inserts the pfn, at
huge-page order where the alignment allows.

The fault handler inserts a pfn only while the decoder is known good and
the media is ready, and returns SIGBUS otherwise. It inserts with
__vfio_pci_vmf_insert_pfn(), so a fault does not depend on memory
enable; low power already closes the gate through power_down. When the
gate closes, in low power and later in reset and bus reset, revoke the
region with vfio_pci_core_revoke_region() so no live mapping outlives
the decoder, and re-arm it once the decoder is restored. The BARs keep
following the memory enable bit; this region does not.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 131 +++++++++++++++++++++++++--
 include/uapi/linux/vfio.h            |   2 +-
 2 files changed, 123 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index e6e633902ecd..977d0c9c747a 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -9,6 +9,7 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/range.h>
@@ -29,6 +30,7 @@
  * @hdm_valid: true when host CPU access to the HDM range is safe; under memory_lock
  * @await_mem_active: the device reported its memory active at bind, so wait
  *	for Memory_Active before host access reopens after a reset or low power
+ * @mem_region_index: vfio region index of the HDM memory region while open, else 0
  */
 struct vfio_cxl_state {
 	struct cxl_dev_state cxlds;
@@ -38,8 +40,82 @@ struct vfio_cxl_state {
 	struct cxl_hdm_info *hdm;
 	bool hdm_valid;
 	bool await_mem_active;
+	unsigned int mem_region_index;
 };
 
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
+			 * Insert a PFN only for a known-good decoder whose
+			 * media is ready. CXL.mem decode follows the committed
+			 * decoder and Mem_Enable, not Memory Space Enable (CXL
+			 * r4.0 sec 8.2.4.20.2, 8.1.3.2), so skip the BAR memory
+			 * enable check; low power closes hdm_valid through
+			 * power_down.
+			 */
+			if (cxl->hdm_valid && cxl->cxlds.media_ready)
+				ret = __vfio_pci_vmf_insert_pfn(vdev, vmf, pfn,
+								order);
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
+	 * CXL.mem is coherent memory, so leave the mapping write-back cacheable.
+	 */
+	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+	vma->vm_ops = &vfio_cxl_mem_vm_ops;
+	vma->vm_private_data = vdev;
+
+	return 0;
+}
+
 /*
  * Copy one chunk between the bounce buffer and the HDM range under
  * memory_lock. The user copy stays outside the lock: a user buffer that is
@@ -131,6 +207,7 @@ static void vfio_cxl_region_release(struct vfio_pci_core_device *vdev,
 
 static const struct vfio_pci_regops vfio_cxl_mem_regops = {
 	.rw = vfio_cxl_mem_rw,
+	.mmap = vfio_cxl_mem_mmap,
 	.release = vfio_cxl_region_release,
 };
 
@@ -387,20 +464,31 @@ static int vfio_cxl_add_region(struct vfio_pci_core_device *vdev, u32 subtype,
 static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct vfio_cxl_state *cxl = vdev->cxl;
+	int ret;
 
 	/*
 	 * vfio-pci-core frees all dynamic regions on close and on a failed
 	 * open, so register them here per open rather than at bind.
 	 */
-	return vfio_cxl_add_region(vdev, VFIO_REGION_SUBTYPE_CXL_MEM,
-				   &vfio_cxl_mem_regops,
-				   range_len(&cxl->hpa_range),
-				   VFIO_REGION_INFO_FLAG_READ |
-				   VFIO_REGION_INFO_FLAG_WRITE);
+	ret = vfio_cxl_add_region(vdev, VFIO_REGION_SUBTYPE_CXL_MEM,
+				  &vfio_cxl_mem_regops,
+				  range_len(&cxl->hpa_range),
+				  VFIO_REGION_INFO_FLAG_READ |
+				  VFIO_REGION_INFO_FLAG_WRITE |
+				  VFIO_REGION_INFO_FLAG_MMAP);
+	if (ret)
+		return ret;
+
+	/* Record where the HDM memory region landed, to revoke it later. */
+	cxl->mem_region_index = VFIO_PCI_NUM_REGIONS + vdev->num_regions - 1;
+
+	return 0;
 }
 
 static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
 {
+	/* vfio-pci-core frees the regions after this returns. */
+	vdev->cxl->mem_region_index = 0;
 }
 
 static void vfio_cxl_reset_prepare(struct vfio_pci_core_device *vdev)
@@ -412,6 +500,33 @@ static int vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)
 	return 0;
 }
 
+/*
+ * Take the HDM memory region out of use: zap its mmaps and revoke its
+ * dma-bufs. A fault then gets SIGBUS from vfio_cxl_mem_huge_fault() until
+ * hdm_valid is set again.
+ */
+static void vfio_cxl_revoke_hdm(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	cxl->hdm_valid = false;
+	if (cxl->mem_region_index)
+		vfio_pci_core_revoke_region(vdev, cxl->mem_region_index);
+}
+
+static void vfio_cxl_rearm_hdm(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	cxl->hdm_valid = true;
+	if (cxl->mem_region_index)
+		vfio_pci_core_rearm_region(vdev, cxl->mem_region_index);
+}
+
 /*
  * vfio-cxl holds the HDM range, so the PCI core's cxl_reset method would
  * fail to request it. Run the same CXL Reset with that claim.
@@ -429,9 +544,7 @@ static int vfio_cxl_reset(struct vfio_pci_core_device *vdev)
 /* Low power loses the committed decoder: close host access until restored. */
 static void vfio_cxl_power_down(struct vfio_pci_core_device *vdev)
 {
-	lockdep_assert_held_write(&vdev->memory_lock);
-
-	vdev->cxl->hdm_valid = false;
+	vfio_cxl_revoke_hdm(vdev);
 }
 
 static void vfio_cxl_power_up(struct vfio_pci_core_device *vdev)
@@ -460,7 +573,7 @@ static void vfio_cxl_power_up(struct vfio_pci_core_device *vdev)
 	if (ret)
 		pci_warn(pdev, "vfio-cxl: HDM decoder restore failed: %d\n", ret);
 	else if (!vfio_cxl_await_mem_active(vdev))
-		cxl->hdm_valid = true;
+		vfio_cxl_rearm_hdm(vdev);
 }
 
 static const struct vfio_cxl_ops vfio_cxl_ops = {
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 883b51521e6a..359fed40eb1b 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -371,7 +371,7 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
 
 /* CXL Type-2 device (0x1e98) sub-types for VFIO_REGION_TYPE_PCI_VENDOR_TYPE */
-/* CXL.mem HDM region of a Type-2 device, read and write */
+/* CXL.mem HDM region of a Type-2 device, read, write and mmap */
 #define VFIO_REGION_SUBTYPE_CXL_MEM		(1)
 
 /* sub-types for VFIO_REGION_TYPE_GFX */
-- 
2.53.0

