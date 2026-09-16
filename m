Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908C4D9F67;
	Wed, 16 Sep 2026 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584007; cv=fail; b=AVGMw7hXEXVhf9pX/q28rlsb+LfcRZlO4DybdsPfH20kZSmP0jKO6RBAiBq6cTy7CumXY8N+Hg9uJ513yVXOYksNmdqfqF5IBgs7sb2WgEthpq/uG7LIEF1/SadPJerlpDSMBWC44L2yYDhwPEW0kwtYMxuFC+lzOzBjFXv7laI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584007; c=relaxed/simple;
	bh=ECqw2SjCzrHNlctWJ2xmjDyfRoISCgwFOEkahGKt7O4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTL2ryPpMUNQMz49OCalahJnrmHMzoYk9Ix9jQie45JWc8rUHP2chRd2ufuacZ8UVSZCMzZYQBeqIX1xfBo3Q6r+SwL24Jc9urz1EgvKlzqkU7L+4pCZ907a8V5wynDTusJpAWhHim5/MSHtvj95Bz/mMXZfZVtm739mL1wbi1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I0n+E0GJ; arc=fail smtp.client-ip=52.101.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I0n+E0GJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2leg5h/tcehqEKO+nI/8PFwvNDEYVEHG6xRQDluWsPlJAoaGmSGaR4IIB4+MfWr7nsEDKx+r4NPOEDWVw+hDvJGZ4yBRSBwmpVk2eOxTwxr56SbqxTaGt9b+vHD7M5gUUMoiWB6z7vB4Py5gPs3w1tuyppxoRaikWxmR+0nDFRiYWuUGE2jdyiJRA74/pIYHtwChFvRk0ymNPLX5iH7kZmE2h5oVDhgnoITBakrQt8Qvo/3jbvCBdDxTMhRyrYkElMDGQw/iSnKnXSFbjyeWMKue4TvoURUy9m9PdgO4b/bDg0cxIFK/T3PGTCiHjS7S1RQiVz68h2thyrCU8WXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPIw7Aq/fKNT7iSMgR/V0fa0BCb7+I3t3/FTvuLsvZw=;
 b=dA+3ETqlaL3CccP5BwjCc18xs4a+o3YFCZ4lFp5TAOJc5gmu6QTEI4UwcoJRx3DBpreUpCwl5z55CXA/+i0/45Fd1B9Z3TiLEybUXazbVMF3/CF/0KHPj+CHIHFjHRNOCu78lCGCmSmjVFxlzxbIfstjv1hgFZt8VVAw8HNMAI087Yht5aFa9SaNLBNuS8T04M9eWVcOct3C/wzXLe3XQMwtg+/Prnbh9tDHe4St5aiP1aYPi8I2XKbZOIKJdKpKjseYDIDjVSEy1t+1t7GQOxJJHqkSuUs2zT8KGa2OQuTZBIxNf+cmb1cjCCriwXZewF6R2VhINe5MMJI+vf+GCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPIw7Aq/fKNT7iSMgR/V0fa0BCb7+I3t3/FTvuLsvZw=;
 b=I0n+E0GJrt3c3LKP7DOD8FnrrbDyx43ZhNPvi1WpyOw3NgFbf3n4dgWrZhjHCXsateoPYDyhF8zgZVia+/bi8D9+sG7z+K2bSRfouXdQ6cwN9nTxLm875utSCt1036iO3dXmsqvDYV6QxCbzrXYtoQ3lLrm10kB5ndoCgEYijXMnOiBI/8yar41e9Vy/mI+IFMhbsrDh1fSOGKhNIaFSUcFXw3+cDDNKFpRWuGoOAm+Jm29/7NFbgm3WS6I+qla8izdCw+9r+mzbBnTRcEoOOdQjziErY8LjVwkmsrq/UhV9Yz2armrArcabUEu7ApuaL4bTCFEdP+HZ2ilVkpw3Ug==
Received: from SA1P222CA0081.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::7)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:39:27 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::76) by SA1P222CA0081.outlook.office365.com
 (2603:10b6:806:35e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:39:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:39:03 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:38:53 -0700
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
Subject: [PATCH v5 19/27] vfio/cxl: Contain HDM memory errors with memory_failure()
Date: Thu, 17 Sep 2026 00:05:32 +0530
Message-ID: <20260916183540.3813685-20-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 5042cc15-4152-4fa9-dc3d-08df1421d692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|7416014|1800799024|921020|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	DD6aLYt4680QhXrhv9MdtJuI11h3UM8T7akyNoZZD2cn4tK0jy2tvuLYgICvUGGaf6M+STqCNXy0rom/XlKfnkCTw9nule7Ewa1Y9DyUrZK9vORNcC+K7sgx2ZaSpgiit1zDLIARhNm7npbxByjnacO7FvRFYfeDnFj3PWWSkT6ATkkPBJ/Ie0WU9HI1u8abkIk9O5j8Nsd8DilIGNPLimYPKOytzjRvD2PMNzXiCNYeXFrH4zBZHo2cw+Ev0m8z/mqPQ9jZcr9HuT9Bj9oLTi30hgrMV0AVsvnwxtGgKShrlL30cF1vOTMxhha/Rd0f1RMGrwh+RzvZje7hlyPl7zgyQ45zhCjBGIdSFNwAe2EYvv/ZyjWbvdG70b82afLyR7O3aue+/2PLnDQ8eTFYfjKcThutos4YueEC/m6EIokLgziWUINqgGvRcoEenkmZRp65tzpCkHWi7HKhJCsEC9O5HNGmm66G6CifZ/Lmob+GbKTguJitiWw9SrIha9AGIYaC+7Z2aHiLUTPRCsxVmzIQusMxDZrK7xZbFPzZDCDih2mc8QMtWeyBog2ULT3RNUozQ6dSZ0rikoAXcKrGa9DWez3tObyL7lHVY2LveD0kT9QB/5u5itGuIzZdSsHnR9dVNStEngBd0Tl0g18WYYfPe0Dg7wDhJH7dLfgbhmaHxB1eIvc3C6+5qmOXLVfDBubogXjK/jsjZQM2l3xhS2smvFVsbLoV8zK40LTcF9+aQoezURDupv9NkfSPqdh2
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(7416014)(1800799024)(921020)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	COTZcxD0oDS7iohXuxyJAH4jI0o7faJG8okhXpdvMOCrZhvxE754BvHWieKh06hkCT+QQ4+I7U2I29L+mRY+rfmrrJuL35dnt6yADB9WeRtfJPjv2ucNnPRMf7AeDfhYXV+EMJeWY6XT6qenb20A3xlA+2Edu/3YqK9L1j/MGNMcu1AixoqjQbHQwkHyYsl5I80KjIWkwAk9nPH7VTXKOA9RjPctDv89d4fN52wa5qAcRaezvLWinLzzs/KlCyaJNWXi1+nQLCsxNF++T7eM/FXlCxcvgZF5V+Z5dY9q6qHM/MctQ0Bgrru1JFDS9JfidkIPCik1EW01bElUo/BdKjLj2qD9N9BNYujcM/pbDjJYsEdUke+4pVRgiGrLkvm7Cks6zUcXt0tHuYvCqxduhvTxwCAkeoCJNwmW8QuVXt/Wh8IpwOxWNdvwL5cDOBe5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:39:27.4897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5042cc15-4152-4fa9-dc3d-08df1421d692
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189

From: Manish Honap <mhonap@nvidia.com>

The HDM memory region is mmap-able, so an fd holder can fault its
struct-page-less device memory in from the host CPU. A memory error on
that range cannot be routed through the normal struct-page path and
would otherwise escalate to a fatal host SError.

Register the range with memory_failure() via
register_pfn_address_space() so such an error is instead contained to
unmapping the range and delivering a SIGBUS to the fd holder. Provide a
pfn-to-vma-offset callback so memory_failure() can map a poisoned pfn
back to the file offset of each user mapping and unmap it; the region is
a single linear range at hpa_range.start, so recover the offset the same
way the fault handler derived the pfn.

register_pfn_address_space() returns -EOPNOTSUPP when
CONFIG_MEMORY_FAILURE is off, in which case expose the region without
containment.  Unregister the range on close.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 76 ++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 5b65cac30aba..e099e9a70a5a 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -7,10 +7,12 @@
 
 #include <linux/cleanup.h>
 #include <linux/io.h>
+#include <linux/memory-failure.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/range.h>
+#include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/vfio_pci_core.h>
 #include <cxl/cxl.h>
@@ -21,12 +23,14 @@
  * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create()
  * @cxlmd: memory device joined to the CXL topology at bind
  * @hpa_range: host physical range of the HDM region
+ * @hdm_pfn_space: HDM-region pfn range registered with memory_failure()
  * @hdm_valid: true when host CPU access to the HDM range is safe; under memory_lock
  */
 struct vfio_cxl_state {
 	struct cxl_dev_state cxlds;
 	struct cxl_memdev *cxlmd;
 	struct range hpa_range;
+	struct pfn_address_space hdm_pfn_space;
 	bool hdm_valid;
 };
 
@@ -152,6 +156,62 @@ static const struct vfio_pci_regops vfio_cxl_mem_regops = {
 	.release = vfio_cxl_region_release,
 };
 
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
+	cxl->hdm_pfn_space.node.start = start_pfn;
+	cxl->hdm_pfn_space.node.last =
+		start_pfn + (range_len(&cxl->hpa_range) >> PAGE_SHIFT) - 1;
+	cxl->hdm_pfn_space.mapping = vdev->vdev.inode->i_mapping;
+	cxl->hdm_pfn_space.pfn_to_vma_pgoff = vfio_cxl_pfn_to_vma_pgoff;
+
+	return register_pfn_address_space(&cxl->hdm_pfn_space);
+}
+
 static void vfio_cxl_release_hpa(void *data)
 {
 	struct vfio_cxl_state *cxl = data;
@@ -321,6 +381,16 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * The HDM region is advertised mmap-able, so a fd holder can fault its
+	 * struct-page-less device memory in from the host CPU. Register it with
+	 * memory_failure() to contain a memory error. -EOPNOTSUPP means
+	 * CONFIG_MEMORY_FAILURE is off, so run without containment.
+	 */
+	ret = vfio_cxl_register_pfn_space(vdev);
+	if (ret && ret != -EOPNOTSUPP)
+		goto err_unregister_mem;
+
 	/*
 	 * The decoder is firmware-committed, so host access to the HDM range is
 	 * safe. Open the access gate; reset and power transitions clear it until
@@ -329,6 +399,11 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 	cxl->hdm_valid = true;
 
 	return 0;
+
+err_unregister_mem:
+	vfio_pci_core_unregister_dev_region(vdev);
+
+	return ret;
 }
 
 static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
@@ -336,6 +411,7 @@ static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
 	struct vfio_cxl_state *cxl = vdev->cxl;
 
 	cxl->hdm_valid = false;
+	unregister_pfn_address_space(&cxl->hdm_pfn_space);
 }
 
 static void vfio_cxl_reset_prepare(struct vfio_pci_core_device *vdev)
-- 
2.25.1

