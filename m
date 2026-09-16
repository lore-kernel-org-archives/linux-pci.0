Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071BC4FECFE;
	Wed, 16 Sep 2026 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584004; cv=fail; b=u/FYuQWswKf1QLlHqG4RvQB3fDNGjgowedcw0C10SZDB977peh/R3e9zgsV9UFSBkDfkHDNo92i8DF7EofcF1k11FFDPrR/84dZyXE3hYCZAk5xUVAVWg0Q/KmI1dja3TrS0HWSQQla15+lTaNAryq1eJbHe3DZApIKYQGlpIXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584004; c=relaxed/simple;
	bh=icMCR47ozCjvzN7eRpaqsLLACv8HU7cAMslXnGLbiCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=em65rr0yq77RXMR5xefusvHZjNkEXeGnuotKIPMzBMqy/EhAKbDmO6J4Mbmg8bUbylDc312u13fI5/DPZEvUuTocLfMjJ1Yabx5nLPBBZSsqDvrOXTE8RJpTLQtGcPMeqgDQtPLfnBcDRnEaY/Hak46legWPtwnA3j7VLy6kqQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I2i3eO02; arc=fail smtp.client-ip=52.101.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I2i3eO02"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzRGEZi/eu4BDT2elZsdR+xo6CCKNQNRk89MGQ0uVpHsDxohBVHvUlqDuqHNopwU+bak6RFV+mD+R5LbDuE3KvCW/dntfTu3tqpk8Ow1P0glEq2SPtuMCzsCpsCQj9+lL48LowXLE7pcUmwJBtwghqqWC2/rdf1/NccoyFettIwrOGG0mD+d+gU2qsw3iDWtvxVn5zjmox7nn3MsTPAUxy9rRW8c0UfO5+JmzGfWhUHhJKEyDGnZVbxgVfo604B8ijLeeqV/S2eT5+ajHQQo/SFgHZ5TU5doDOkKmGtPDaEk6Wk2iQVWTE67qNj3/skDmjGqs9qwqPo3plVl/RHQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuxZwkpIQBMDWjfYILx6/3B1r8j/xgcKzTwAio7Nkdc=;
 b=u2C62yRYSiEltG7QySjA3CPBm+JxkFdeUw5PTSVrXZvRu/mQf8buBZ/IiAEWWFBv+Hc3HSQc9CdtCBZrI8ommHu7EFu1W5Sasf7iLmNa5G6jSWySTTwsdtFKA7Nk95Wn0NzDu/NyGTwxBaD8A2KHsoqvooX5wH6hd1WvAWqpBSJ5jHJrrqvb4EhALCixiLAzm/rNyCwYebQeceJLSfa58nvXVSqmL1Yek6nO/M/iA3xVX1Rn434Gh942JOrGcikTOTSTuKdq2xSIsaQBEAxPXp4Yzu/oZdx6HMSl8x8rXLdzqSuWCS1aIokgxaVdZJn6MPruZ94X3twsrr5r2b7+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuxZwkpIQBMDWjfYILx6/3B1r8j/xgcKzTwAio7Nkdc=;
 b=I2i3eO02PfbZPzyM8GvJdtZ3jOuIrIpcEv7cm8sbhs8XZ3T6LVp04TJLyUvY9pR7sfjTxNjOcKoyF8zqlQDcyluj3gzUi1qe1XBcVygw21W3kpNB67xLe8qqznxHRFepk9S8NztLj27zrydwG9o5Lz35mzsHGAfXTC8gT61XGwXIwSqxiJJlC2j7OvHjGNvdkeu62JywWjyo3Y9TIoERFfk2Yj/Un0GIgbIzsXE0IAfSUXYetD5qOiE33GhAknWj3G7NTP5evBK64G9VwbDDP2k82jI3voUNUCwKqrvJRsjFGhpEIi2B2xsngSx+nyX/yEY+fC4pRA9WyxXU8LnZSQ==
Received: from BN0PR03CA0041.namprd03.prod.outlook.com (2603:10b6:408:e7::16)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:39:25 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::45) by BN0PR03CA0041.outlook.office365.com
 (2603:10b6:408:e7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:39:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:38:54 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:38:44 -0700
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
Subject: [PATCH v5 18/27] vfio/cxl: Expose the HDM memory region to the guest
Date: Thu, 17 Sep 2026 00:05:31 +0530
Message-ID: <20260916183540.3813685-19-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd0aca3-0c83-4f1e-e528-08df1421d4c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|7416014|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006|5023799004|921020;
X-Microsoft-Antispam-Message-Info:
	icDI7oXIqBMPQ2bacwsj3dxxXx+xEXFsaMCF11dlmrcttUq103CHOz0Zlx9t/OJ7TIT1nn8IEORGXJpthjay0Js8RtWyy4ONVGX1lQc9b3CMnQeyIQY1X/c0heW2gisKvoxjRZmBQYFEccAcSqLdgmBDYxaTjh+fwZzhUdVpE3W+9tjfilDU3v5Uo50bia3q5iWm1dLcaTb1Ya28z9dVlcY8jTKCvqIV1QYBmJerQyUVEle2PbZeBiEdl9YR550Azg5PyzporVxOTyO0xUmK+mBRlF2G+v6k4CpZtD4GYpRbNuLxAbnVGTFadAoF4eMo5iIW6TP511KR+BtNqxJsf56FE941b+4zeqx79sAKheO82PzNEbL2JM0QqE5HFzH7y1qFCZXTsLe+1v3tVDJn0bMuYZYVuRlF5NHFGwV1n7YxniirGq6MykzrqIT9fydEaRBJSPUBr8yWsFPiWqpRVk4S5OZp/0RvZt5gJ10UuZgIB4fw8eXG3k6DV/B9m0Fp83Qisbt/gZVZsRU5mE86wPtk+iknD7iLLWb3zWP0Oa3As2pYWD2m7TYvT1cmHAXuhLX1qVnUB4DgbJgdyVl9iMlevUI46D3LRHJ+BJLLWy+oBHdlnV9Smopu9I7IeI+WxfMJtNxDPKuEJN6I55XrzXNpiazVBHBwaNBrmWq63PBrJTG3s891BBpg5hxH0GwDGdDI8kORFj3AWexEt3h+JTRlX4cvzjkGVgAlavALFNkMihJVTmZ/4npwo0CkY8bg
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(7416014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AXPJPDoIW+EWzFZV4jYTEpMXhoriZVwH6FhBmI3sPka/o12x20ToZ5rmDM9F9qiQyZ4UfSGom2r1SagkhuNYWAxLsz+FoJMfy6l/w9R6DChQHRppKnJ1r+pUbQxO6F9Zdkon+idpRY+szY4CO/wlfH0OF1we5C1W3uXAOdau8H9Uga7Yf38BlHbfULqANaj1ovq0XL1j2CDKTd1mq89oclrnZ8+ogG/PPKfvABJEKTZsIvR/r0+dIZB9HMoZeHdyc9Dj8luUuEewLL5ll0eMRD/TtK+qaXoApMo50C+Z1F8P5CFmgK1HeaIJ5RxgtFlzqMk4CsObO0i5Y684G3TEfZcHdkwwOIn7F5aTs2WwbmXPXP7jf2ZPxrYHDYlmAgdqEjV2En5gwihsKgBY/cK6FYWAPTmwFzwHqFLb/5mEZZ2NKakQX6rHML83+pS3J9dr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:39:24.4125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd0aca3-0c83-4f1e-e528-08df1421d4c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 guest maps the device HDM memory to use its coherent
CXL.mem. The HDM memory is a host physical range with no struct page,
so the guest and KVM need a write-back mapping of it.

Register the range as an mmap-able region under
VFIO_REGION_TYPE_PCI_VENDOR_TYPE with the CXL vendor id rather than a
bespoke region type, per open because vfio_pci_core_disable() tears
down all dynamic regions on close.

Own the resolved host physical range exclusively (IORESOURCE_EXCLUSIVE)
so nothing, /dev/mem included, can map a conflicting cacheable alias
that would fault the host once the range is mapped write-back.  There
is no devm form of the exclusive request, so pair it with a devm
release action.

vfio_pci_zap_bars() only unmaps the fixed PCI BAR range, so revoke
mmap-capable device-specific regions there too.  Otherwise a
Memory-Space disable, a D3 transition, or a reset would leave the guest
a live mapping into quiesced device memory; the fault handler re-gates
on device state before it inserts a pfn again.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 186 +++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c     |  37 ++++++
 include/linux/vfio_pci_core.h        |   1 +
 include/uapi/linux/vfio.h            |   4 +
 4 files changed, 228 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 5c8a63833a43..5b65cac30aba 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -5,9 +5,13 @@
  * Copyright (c) 2026 NVIDIA Corporation & Affiliates
  */
 
+#include <linux/cleanup.h>
+#include <linux/io.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/range.h>
+#include <linux/uaccess.h>
 #include <linux/vfio_pci_core.h>
 #include <cxl/cxl.h>
 #include <cxl/pci.h>
@@ -17,13 +21,144 @@
  * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create()
  * @cxlmd: memory device joined to the CXL topology at bind
  * @hpa_range: host physical range of the HDM region
+ * @hdm_valid: true when host CPU access to the HDM range is safe; under memory_lock
  */
 struct vfio_cxl_state {
 	struct cxl_dev_state cxlds;
 	struct cxl_memdev *cxlmd;
 	struct range hpa_range;
+	bool hdm_valid;
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
+			 * media is ready and whose Memory-Space is enabled.
+			 */
+			if (__vfio_pci_memory_enabled(vdev) &&
+			    cxl->hdm_valid && cxl->cxlds.media_ready)
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
+	 * CXL.mem is coherent memory, so leave the mapping write-back cacheable.
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
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	u64 pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	void *mem;
+	ssize_t done;
+
+	if (pos >= range_len(&cxl->hpa_range))
+		return -EINVAL;
+	count = min_t(size_t, count, range_len(&cxl->hpa_range) - pos);
+
+	scoped_guard(rwsem_read, &vdev->memory_lock) {
+		/*
+		 * Same gate as the fault path: only touch the HDM range with
+		 * the decoder in a known-good state AND Memory-Space enabled,
+		 * or a host CPU access aborts as a fatal SError.
+		 */
+		if (!cxl->hdm_valid || !__vfio_pci_memory_enabled(vdev))
+			return -EIO;
+
+		mem = memremap(cxl->hpa_range.start + pos, count, MEMREMAP_WB);
+		if (!mem)
+			return -ENOMEM;
+		if (iswrite)
+			done = copy_from_user(mem, buf, count) ? -EFAULT : count;
+		else
+			done = copy_to_user(buf, mem, count) ? -EFAULT : count;
+		memunmap(mem);
+	}
+	if (done > 0)
+		*ppos += done;
+
+	return done;
+}
+
+/*
+ * The CXL regions carry no per-region state (region->data is the shared,
+ * devm-managed vfio_cxl_state), so releasing a region is a no-op.
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
@@ -120,6 +255,21 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 		goto err;
 	}
 
+	/*
+	 * Claim the range IORESOURCE_EXCLUSIVE so no conflicting cacheable
+	 * alias can fault the host once it is mapped write-back; there is no
+	 * devm form, so pair it with a devm release action.
+	 */
+	if (!request_mem_region_exclusive(cxl->hpa_range.start,
+					  range_len(&cxl->hpa_range),
+					  "vfio-cxl-hdm")) {
+		ret = -EBUSY;
+		goto err;
+	}
+	ret = devm_add_action_or_reset(&pdev->dev, vfio_cxl_release_hpa, cxl);
+	if (ret)
+		goto err;
+
 	cxl->cxlmd = cxlmd;
 	devres_close_group(&pdev->dev, NULL);
 
@@ -143,13 +293,49 @@ static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
 	vdev->cxl = NULL;
 }
 
+static int vfio_cxl_add_region(struct vfio_pci_core_device *vdev, u32 subtype,
+			       const struct vfio_pci_regops *ops, size_t size,
+			       u32 flags)
+{
+	u32 type = VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_CXL;
+
+	return vfio_pci_core_register_dev_region(vdev, type, subtype, ops,
+						 size, flags, vdev->cxl);
+}
+
 static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 {
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	int ret;
+
+	/*
+	 * vfio_pci_core_disable() frees all dynamic regions on close, so register
+	 * them here per open rather than at bind. A failed first open never
+	 * reaches close_device(), so unwind on error.
+	 */
+	ret = vfio_cxl_add_region(vdev, VFIO_REGION_SUBTYPE_CXL_MEM,
+				  &vfio_cxl_mem_regops, range_len(&cxl->hpa_range),
+				  VFIO_REGION_INFO_FLAG_READ |
+				  VFIO_REGION_INFO_FLAG_WRITE |
+				  VFIO_REGION_INFO_FLAG_MMAP);
+	if (ret)
+		return ret;
+
+	/*
+	 * The decoder is firmware-committed, so host access to the HDM range is
+	 * safe. Open the access gate; reset and power transitions clear it until
+	 * the decoder is restored.
+	 */
+	cxl->hdm_valid = true;
+
 	return 0;
 }
 
 static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
 {
+	struct vfio_cxl_state *cxl = vdev->cxl;
+
+	cxl->hdm_valid = false;
 }
 
 static void vfio_cxl_reset_prepare(struct vfio_pci_core_device *vdev)
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index ddd6807893fd..8913a9e24302 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1295,6 +1295,23 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
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
@@ -1972,8 +1989,28 @@ static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 	loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
 	loff_t end = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX);
 	loff_t len = end - start;
+	unsigned int i;
 
 	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
+
+	/*
+	 * The unmap above covers the PCI BARs; mmap-capable device-specific
+	 * regions (e.g. a vfio-cxl HDM window) sit above that range, so revoke
+	 * them here too, or a Memory-Space disable, D3/PM transition, or reset
+	 * would leave the guest a live mapping into quiesced device memory.
+	 * Callers hold memory_lock, so the region array is stable.
+	 */
+	for (i = 0; i < vdev->num_regions; i++) {
+		struct vfio_pci_region *region = &vdev->region[i];
+		loff_t roff;
+
+		if (!(region->flags & VFIO_REGION_INFO_FLAG_MMAP))
+			continue;
+
+		roff = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_NUM_REGIONS + i);
+		unmap_mapping_range(core_vdev->inode->i_mapping, roff,
+				    region->size, true);
+	}
 }
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 475a0ecf9e4f..39a28cc6ae8c 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -198,6 +198,7 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      unsigned int type, unsigned int subtype,
 				      const struct vfio_pci_regops *ops,
 				      size_t size, u32 flags, void *data);
+void vfio_pci_core_unregister_dev_region(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_close_device(struct vfio_device *core_vdev);
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
 void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index e41437fa17ad..1bf86763c0f7 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -370,6 +370,10 @@ struct vfio_region_info_cap_type {
  */
 #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
 
+/* CXL Type-2 device (0x1e98) sub-types for VFIO_REGION_TYPE_PCI_VENDOR_TYPE */
+/* CXL.mem HDM region of a Type-2 device, mmap-able */
+#define VFIO_REGION_SUBTYPE_CXL_MEM		(1)
+
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
 
-- 
2.25.1

