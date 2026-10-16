Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DAE5452BD;
	Fri, 16 Oct 2026 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167810; cv=fail; b=K32vqPh5pecijbdnyEvRbLpg7VUAas6CelhfRIkKgyfKPRA9ZzzFYn6NXM7F1bp+51cNGyBYVkdmDO3355tyVaCfABe7bhorb/Qvq026Q0NRIYxz5kT37hGU70hDbmp44K1L5HmFrlVeS2EYOT2WFwOZSRszYK7LR3sIit5eQSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167810; c=relaxed/simple;
	bh=FHUXVn+60q2nZXA2NHEV8QRzoEojWlh2qc0/I5iXpSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRY24SMLcfAqTXMzDrbAt8BslFHCPnjdLFGxkJuZcRzJV1ozde8uJ2qQ/QzppMfTO5ib10aRK3fwa9rkkZ7Yytn/AD9GMmoIJbNH2L69amAO/qDZvtfUiAOkEwtjVwxuxEkaHhdse8PFnZjI8mQdRK4EVIN72bBEIQLDdfTeOi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EMoNE5a9; arc=fail smtp.client-ip=52.101.46.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EMoNE5a9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfrx9JFDVunmR8Cuo9xJayblifvbvxjzscDWOPlgnrwiDEB6dNB1FjS1hvHJbJHRHuNGxiZCZdL+qfsEVI0dMwte3U0510NVAlzp7jzfOs5aC/kbfNvdbmVRC9unoSFcGK1a+UlcX0T/T2HYsRlXrw5ih+e3uGbFyvjsAV0qC8T06ka97hZifXE/6SA6ZV7WbEqFWt9cdIVN1m6j6b9yu/28OtOSy2nbtQSHezcKeDkHNvPQLUnbHf4593lb7Tzv6EhGlfp7GNUIgjh8qaO+D29n6Q7HiCTRBUB4xlArNqk9oRlh1zhkN7EM4RbOkv84CLGPM/ggErRNZH+rjoEvFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70jA7K/4SoxqP1FG+b1gtxPrDKliaUtaWXXRBhBdyBo=;
 b=Y5CjwhN89vuqqI+Wn3mt6MQBZidYpAQcJi7nMW/SYWQ+JvupCOjKZswIRotxj0VOat3Lvp7Cmf3zdcDORKWMv6GEfXX6c9XRmMduew8E2qn5YUxoJgqeT4rydjBNFqkL3L6rsYC63l7ElP/0AJ8vYWcfQIPCsdLgqHfQi3VtU/krrEET2LFLqwJp3ITFW88KeiYHS28yGl7mr5JS+iYLvm7LyiG7cCIzrg97AtUg9VX5UgfYlLALuo1imCRySRT7oAKC1p15VchqfHfgx/BgqVMzA+HCPiL6buF8somKZHhn3JnAX0vlHSiiJZEzh2cz2BB8BnC+eq84tLZ+0olo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70jA7K/4SoxqP1FG+b1gtxPrDKliaUtaWXXRBhBdyBo=;
 b=EMoNE5a9F1tHv4G4a+QcgSCo4HjCvS9528T07xvEN6wqWPwxeVb1pSAwYKmQHzfxU881M47XizSe6dnuDnCeB2IlGH2YjZwk5Pbo41jS8Dca1NQmZZyu32n08EFVo5GLmga1Xe9io8rxqqpMphKsrnk0wAz6FKd1bBoMdmKvjWVY++GHdkDFMnnqA9h3Eldf8OptSvUtWteyRHFu1XAb7oT/OAgWw90hF+L+rBDs4IRIT/cgXh04BPSgnPWweATxIb3OSqe6DP0I6d/XCyepEOqTJ6d9f42npx1ir0Pq0nZZln4JaWFUusc++I0Ybb7GBmFlp5QkpfIzaa3/pQKdKg==
Received: from DS7P220CA0053.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::31) by
 PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Fri, 16 Oct 2026 16:23:11 +0000
Received: from DM3PEPF000265AD.namprd02.prod.outlook.com
 (2603:10b6:8:224:cafe::83) by DS7P220CA0053.outlook.office365.com
 (2603:10b6:8:224::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 16:23:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM3PEPF000265AD.mail.protection.outlook.com (10.167.23.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:23:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:22:37 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:22:28 -0700
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
Subject: [PATCH v6 24/31] vfio/cxl: Expose the HDM decoder registers read-only to the guest
Date: Fri, 16 Oct 2026 21:48:31 +0530
Message-ID: <20261016161839.2765592-25-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265AD:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 551b3ff4-509a-4ece-5c45-08df2ba1c25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|11063799006|921020|18002099003|56012099006|22082099003|6133799003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	gMUvsH85OS4YwjYZNUhNr+rKfIlbZ04Nelv7ME1/edm9OkqjdPL8cmlCy7urUeo5iw3eTdgcgZZ9l0IXI2dNd5lBqpXKtbjjXGBywYRkYojmRntFoc4PJ9u/1OGreupOzxbfjw1c9JsmdCF0kLu2Fd1OmgNWficn8kG8AgR0JcJYXu0MGGILgEGRbfJeSBkj6uQTKT54NG7lv8oVuhmxaTW0RvtN2wApxhPXwWfZj5bl5Pv7d56G2isNWGgybWDOGRMt+BjdP/s10zEOek+HeoMAUjUTkogvBDBuYQB44uy0ADpdh2d0Um8vEVJKkSCZKT9hoCTrFf0Qp/v9ymzia/p8K/5bylaIpIaNv8hVtxmMrsV2lyEu4Ys6lvNwFjekvTRFtbceTtobwLhSpXFgwzRy2q5Wpvik1JUT0GJB2Su2/atq5eh0r473JhWs4WAy7tXyk01s1TxWjOXCAD+wCKXgoe/EqmXww6G35dacUJWLTNg+9pGq97a7WjsvslbddKgL4rYwb4Wype0/wba8ZI3jU6ceDZeXJ7/lrvDxn3e7SGvdcRUOUjuEq267sC+fYhrPDShZYAxIiq4BNoy8tc62zMCFaJVM8kpF0+s3krH4CKxgno+/aJEyktf9AsFH16+EccXkkNdl6n0kyqiH8Z1oLJH3o80DI6i5+5+V4I4zjbvGsj2Q1rZ3LjTjQ7goBDCidlZxcL2cALnL5JhbNeXXeKcWNpVXQMLWJjDmLNys2ff8DB6ivaCMkwHqWYQC
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(11063799006)(921020)(18002099003)(56012099006)(22082099003)(6133799003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mPV/6pXY4x3CYwpjjxK5NIwhLp3bjO3pmtpPzLQz2GkckSaq3/guuFw+zU2WB74JmAnGBehjBGhKY9j9AO6qvgs0nwfN4ek2NU6TksLo9+vuQ7rqCK+jeVm1jkI+BfszvFaxfaynjL0lAqCdCqY9FH6RRlxVWoOSopocnTNpHlIPu1xOxmTO2YJRzuhf5qXA1tpKjcqDGZk4a5TtwQJKlSqh7W/SxoocuWov2wmTbFNBPpLQGz54ks9UnGkShTqsf44pGDMH/i1iZh8ykeCucGu00L96iYADbTVGjaN13ED/Lw92l/QPVXjof457AbcHqe/nIc4g+9Hrxmld5sGKvcjVsiqpK7eALK6WFAytF7HeNeUIPzINC0eA5apFqZs3Om+A9RtDW+nEL5sholE4gvEDXMXlHEUgwg+94AtKuUSVK6teTfgKG5v31jjKJ6n1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:23:05.8947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551b3ff4-509a-4ece-5c45-08df2ba1c25a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265AD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 guest reads the HDM decoder registers to learn the HDM
region it was handed. Those registers live in the component BAR that
vfio-pci owns.

Map the decoder block at bind: its location comes from the pdev->hdm
enumeration cache, and vfio-pci owns the BAR, so map it without
claiming the block and expose it as a second, read-only region under
VFIO_REGION_TYPE_PCI_VENDOR_TYPE with the CXL vendor id, registered per
open like the HDM memory region.

Serve reads live from the mapped block and absorb writes without
forwarding them to hardware. The block is BAR MMIO, so it decodes only
with Memory Space enabled: serve reads under memory_lock and fail them
with -EIO while memory is disabled, as vfio_pci_bar_rw() does. A failed
decoder restore leaves Memory Space off; clear vfio's record to match.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 123 ++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h            |   2 +
 2 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index f2f7ddfc80bb..4a8aaa765a98 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -29,6 +29,8 @@
  * @hpa_res: exclusive reservation of @hpa_range, held for the bind
  * @hdm: copy of the HDM state cached at PCI enumeration, taken at bind
  * @hdm_pfn_space: HDM-region pfn range registered with memory_failure()
+ * @hdm_regs: mapped HDM decoder registers, read live by the decoder region
+ * @hdm_len: length of the HDM decoder register block
  * @hdm_valid: true when host CPU access to the HDM range is safe; under memory_lock
  * @await_mem_active: the device reported its memory active at bind, so wait
  *	for Memory_Active before host access reopens after a reset or low power
@@ -41,6 +43,8 @@ struct vfio_cxl_state {
 	struct resource *hpa_res;
 	struct cxl_hdm_info *hdm;
 	struct pfn_address_space hdm_pfn_space;
+	void __iomem *hdm_regs;
+	u32 hdm_len;
 	bool hdm_valid;
 	bool await_mem_active;
 	unsigned int mem_region_index;
@@ -214,6 +218,76 @@ static const struct vfio_pci_regops vfio_cxl_mem_regops = {
 	.release = vfio_cxl_region_release,
 };
 
+static ssize_t vfio_cxl_comp_rw(struct vfio_pci_core_device *vdev,
+				char __user *buf, size_t count, loff_t *ppos,
+				bool iswrite)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	__le32 *tmp;
+
+	if (pos >= cxl->hdm_len)
+		return -EINVAL;
+
+	/*
+	 * Component registers allow only full-width accesses: a 32-bit
+	 * register as one 4-byte read or write (CXL r4.0 sec 8.2.3).
+	 */
+	if (pos % sizeof(u32) || count % sizeof(u32))
+		return -EINVAL;
+
+	count = min_t(size_t, count, cxl->hdm_len - pos);
+
+	/*
+	 * The physical decoder was committed before the guest saw the device
+	 * (firmware may also have locked it), so the guest never drives it:
+	 * absorb writes without forwarding them to hardware. The guest programs
+	 * a GPA that the VMM virtualizes; reads return the live registers, which
+	 * already report the decoder committed. BASE_LOW and BASE_HIGH carry the
+	 * host HPA, visible only to the trusted VMM that virtualizes it away from
+	 * the guest.
+	 */
+	if (iswrite) {
+		*ppos += count;
+		return count;
+	}
+
+	tmp = kmalloc(count, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	/* The block is BAR MMIO, so it decodes only with memory enabled. */
+	scoped_guard(rwsem_read, &vdev->memory_lock) {
+		if (!__vfio_pci_memory_enabled(vdev)) {
+			kfree(tmp);
+			return -EIO;
+		}
+		/*
+		 * One readl() per register: memcpy_fromio() may split the
+		 * copy into byte or qword reads, and the decoder registers
+		 * take only aligned dword accesses. Return them in the
+		 * register byte order, as a raw copy would.
+		 */
+		for (size_t i = 0; i < count / sizeof(u32); i++)
+			tmp[i] = cpu_to_le32(readl(cxl->hdm_regs + pos +
+						   i * sizeof(u32)));
+	}
+
+	if (copy_to_user(buf, tmp, count)) {
+		kfree(tmp);
+		return -EFAULT;
+	}
+	kfree(tmp);
+
+	*ppos += count;
+	return count;
+}
+
+static const struct vfio_pci_regops vfio_cxl_comp_regops = {
+	.rw = vfio_cxl_comp_rw,
+	.release = vfio_cxl_region_release,
+};
+
 /*
  * Map a poisoned HDM-region pfn back to the file offset of each user mapping so
  * memory_failure() can find the mapping and signal its owner. The region is a
@@ -318,6 +392,20 @@ vfio_cxl_create_memdev(struct pci_dev *pdev, const struct cxl_hdm_info *hdm,
 		return ERR_PTR(-ENODEV);
 	}
 
+	/*
+	 * Map the HDM decoder registers so the decoder region can read them
+	 * live. The block location comes from the enumeration cache in
+	 * pdev->hdm, read through the copy in hdm; vfio-pci owns the BAR, so map
+	 * without claiming the block.
+	 */
+	cxl->hdm_regs = devm_ioremap(&pdev->dev,
+				     pci_resource_start(pdev, hdm->hdm_bar) +
+				     hdm->hdm_offset, hdm->hdm_size);
+	if (!cxl->hdm_regs)
+		return ERR_PTR(-ENOMEM);
+
+	cxl->hdm_len = hdm->hdm_size;
+
 	/*
 	 * A Type-2 accelerator has no mailbox and no media-ready register, so
 	 * set media ready directly.
@@ -542,6 +630,13 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 	/* Record where the HDM memory region landed, to revoke it later. */
 	cxl->mem_region_index = VFIO_PCI_NUM_REGIONS + vdev->num_regions - 1;
 
+	ret = vfio_cxl_add_region(vdev, VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
+				  &vfio_cxl_comp_regops, cxl->hdm_len,
+				  VFIO_REGION_INFO_FLAG_READ |
+				  VFIO_REGION_INFO_FLAG_WRITE);
+	if (ret)
+		goto err_index;
+
 	/*
 	 * The HDM region is advertised mmap-able, so a fd holder can fault its
 	 * struct-page-less device memory in from the host CPU. Register it with
@@ -609,6 +704,28 @@ static void vfio_cxl_rearm_hdm(struct vfio_pci_core_device *vdev)
 		vfio_pci_core_rearm_region(vdev, cxl->mem_region_index);
 }
 
+/*
+ * A CXL Reset or decoder restore that fails leaves Memory Space and Bus
+ * Master disabled (cxl_reset_save_disabled_state()). The user reads Command
+ * from the device, but vfio-pci-core gates BAR access, BAR mmap faults, BAR
+ * dma-bufs and the decoder register region on its own record of Memory
+ * Space. Match that record to the device, zapping the BAR mmaps and
+ * revoking the BAR dma-bufs as a user clear would; the user's next Memory
+ * Space write sets it again.
+ */
+static void vfio_cxl_sync_mem_enable(struct vfio_pci_core_device *vdev)
+{
+	u16 cmd;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (!pci_read_config_word(vdev->pdev, PCI_COMMAND, &cmd) &&
+	    !PCI_POSSIBLE_ERROR(cmd) && (cmd & PCI_COMMAND_MEMORY))
+		return;
+
+	vfio_pci_core_clear_memory_enable(vdev);
+}
+
 /*
  * vfio-cxl holds the HDM range, so the PCI core's cxl_reset method would
  * fail to request it. Run the same CXL Reset with that claim.
@@ -652,10 +769,12 @@ static void vfio_cxl_power_up(struct vfio_pci_core_device *vdev)
 		ret = cxl_restore_state_after_pci_reset(pdev, cxl->hdm);
 	pci_dev_unlock(pdev);
 
-	if (ret)
+	if (ret) {
 		pci_warn(pdev, "vfio-cxl: HDM decoder restore failed: %d\n", ret);
-	else if (!vfio_cxl_await_mem_active(vdev))
+		vfio_cxl_sync_mem_enable(vdev);
+	} else if (!vfio_cxl_await_mem_active(vdev)) {
 		vfio_cxl_rearm_hdm(vdev);
+	}
 }
 
 static const struct vfio_cxl_ops vfio_cxl_ops = {
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 359fed40eb1b..6cba3284b21e 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -373,6 +373,8 @@ struct vfio_region_info_cap_type {
 /* CXL Type-2 device (0x1e98) sub-types for VFIO_REGION_TYPE_PCI_VENDOR_TYPE */
 /* CXL.mem HDM region of a Type-2 device, read, write and mmap */
 #define VFIO_REGION_SUBTYPE_CXL_MEM		(1)
+/* CXL HDM decoder registers: read live, guest writes are absorbed */
+#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS	(2)
 
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
-- 
2.53.0

