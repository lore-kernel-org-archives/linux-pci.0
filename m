Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4E4B1D1E;
	Wed, 16 Sep 2026 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584027; cv=fail; b=ghFmCtQWGod1X12343CeUAAGUMh6ZcYE+TOBl24Itfn5/ViGyaupuL2YbD5jxZLHknXgYiBtB9D2z2iekaGqwXhuD2k7DHAev1fnCRTDXDl3yt0cNySepsiEYBoZHEnMab7FPoBZchA5JgkQqii5Lqhn1oRUfqQrVO4knK6vrLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584027; c=relaxed/simple;
	bh=S9qVxypZMu5oIqWVsce2Uk9h9sA3J2gR8Ju4U+ik1YI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ioOyN+rAgdKjCFOmMihrpnbIPcBJsH5wIf+7g7jjze4FzXWuHwhvx1I2u3+gH+kZ3B4kCNtzYV8ognjaGMA1iOPNFWeJ6WXPowACarnbdn8wCo0BSv2hu02jyBIofhWcgSojdRRR8OTXdQ7SmPP6BbaWrjb/H6xwHF9iZ5BiGog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KF8nZlBw; arc=fail smtp.client-ip=40.93.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KF8nZlBw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk1JObt/HUSC0/f+RpLHbvfTpGEV30F7/Xttp5t9UWPjYOT21ND6hOOLoZkhAhQ0sa0KYcfNEhAkbyfXlL2LYvPv4jeD4F3TvW7Llv/dnKIGR3MSrWRtrhuk1ucWABIu/hMYKfqpLcNNBdHWN78Slb9LQslOadaecNq0L/4dU+vBz2DXmdR4lMBPm8nxPrAfyp+vb0LZkK15VFxPp+UvUNeZmnacu0ihoLeMJ+31CP4qPL14AhbE7N49lwU6zMI1E4q684IIu+x/7t6EVK3TqAG4jLTvYf2WkWpnpc2JOuEA4pHRLnR7dGmDjYwXHk02ZTOuGWRSxTjnk1Ckv5Wzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j94aZJCqpkNfoDuaNXY3OTZGtRig6n+A1Ni5DOsfMI=;
 b=dAbB8IXkyxOvoZXpmh4uDnhzmgvjSJ3SaHusyBVwDmWB2ccNelg3F5lglv8kVPTzA+HvdZVDYo7s5IkmagYMheZHZGwShwKC9lpgIfLWuq9YNw8v+pwRCHiuBYUcmq7Q4hAAipnwMXw3MGUIRi2A9NenK0o/DEzQJbLgYXdrYjLHLHrU7rTlWl/ZUgW53KYdYcIG9ZzAQiu91sx89sVeTk8AvTb36fYWcbOB1eqFWCENTX/j6RjXN+vGezmN6hlU4YloewAzufwKRiWH8OI8a8INFSRWc1d1UN8h4vWhNWyfyGq3dsASp18h5R1I8pNruqBxGzfBKdees5qME0dXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j94aZJCqpkNfoDuaNXY3OTZGtRig6n+A1Ni5DOsfMI=;
 b=KF8nZlBwHJodJ690o9uiRsgMVCtQQ1lKGNrPPVj+6RZFSbHGw9BggKKTUT5AMR7ehFPfiR7SPPQJu4N8K6GdbeANxxDaFbNMCv3LnB763rzW7TK4ptGalnnX0l1fmxmgrw1ias2E+9StibDdlkvxoBGwWRNYW06opO2znjHaQJIZn4f77Huxaa/rTayB9fcVFvMHF9n46pQ+Zw6edjXGGXvreONricFNYxKh10CM+ZydAMhhzI8jtXrmEj4m68w9rGHrKBOLpWkASd7x3ID1MTFmYJaQrNHGzZLj7nhu3KG6dqsJtObUITZE3le4GKfGVnUyAYhTnWz4B8UAs0sY6g==
Received: from SN7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::17)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.9; Wed, 16 Sep 2026 18:39:40 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::19) by SN7P222CA0007.outlook.office365.com
 (2603:10b6:806:124::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:39:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:39:12 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:39:02 -0700
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
Subject: [PATCH v5 20/27] vfio/cxl: Expose the HDM decoder registers read-only to the guest
Date: Thu, 17 Sep 2026 00:05:33 +0530
Message-ID: <20260916183540.3813685-21-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 3def1d4e-d048-446b-2e93-08df1421dda0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|7416014|36860700016|1800799024|921020|11063799006|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	85MER9hm1YWuEInCRtVA/uvq77HHwH33gusb7vLk1e3Cjs5tUXgDX0e3eYJS9elVesJV4KTHIXE6r+17icjs2ggAUpPDWX3RZvuGCzkhK36Gaylr4D4KOJVZk9G7LlBzW1DkoPGSFdQVGE0ULH1B74rizT8dvNU8QpCcXx7Y3ycbB8MKbzalSrmbKkR7E7AoegboLUSY7n4nD1FGdaTDNRoTIJjp2AT5nIp/jFYHclr5p1ixgdxmiYTRJYbdoap2MC687zxX0gd68eqNvnA2C2i8g6IL85l+JuMeVd4zLGT/Lc/qBqBAfZGyuDmXvlGIfna1FWVxUMYuaVFu2QR/EOkENQb5RCZzGzLzQMRRN5nljrcGmyIKk9cirRSqd7AeZ0R+bETHBrUbzy8aT6fO1WbKWcWQ9Ahe0VoqxtxTeDsgjy8oFykMVHxCw7zjztK0OV1yahhjjKWd3G1jChzj4bzI8/XcVpVHaDeZ100Di6jaqQg87mfl1LJXfwDlwKLOvIPKsFS3pxbWZ9ooSKzwC4U8m82iwYG4vtESKc2PgMKMFZt+LxDTktcwQFufITl2e67cJBVDtf62G86Pycb6UJpi+1sV5a7Vsgp/6Cl/URDboJ4bpFLa/8YMWdBOcMulbRnhBQ/505cowa61M0qWTwK47T5cc5WbrXiHf9QNvD75vyihWyTvUQvhTAhC47C03rpIbOyg7lBXlDxMeDo3tj5wSMkPnysMYInWAqvpwz9I+Zaa63dSsTBIJ/Uf0uh4
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(7416014)(36860700016)(1800799024)(921020)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9HY/k4GL5v6/AEdzYfg1tdLZnAWKcuWIjdSG+Sdx6+DXYvRX4Q0AFrP21WfS7jEiiNSpqW4NzClPeqQuoTDwIuawF6KxE8PTuVOTCOs8sXmlso+QdoXqycLb9537bDv68NKqvrQ79LZuTiDoy4X3U5WgiBxGwGZW1Rv2XPzlZQgO0sLkBtU+WIc7M836CLVRrlBKFXYwQi2UuE5rf8KQ1unEjZjiC+CzD1o7IDrDuUt0xz0diRBTyLWXgJXrbD5eZchtIkKKOleMQoDodLPBefPh0rhbHFx4Dc6miEwKw0y6iAuqEF+OzehtppP0OV8K3SWXRgAfAhrxuLKilaczsYf0rC/oslG/Osd9m4ULVUkual7gYJcyxgMiWswawKuL8IbDuyV1AP7s3IYgHWm/2vJujKHIGivv6mjVsDi70JTp2qgPTtEtyI17CphdTa2r
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:39:39.2858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3def1d4e-d048-446b-2e93-08df1421dda0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062

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
forwarding them to hardware.

Registering a second region is the first point at which an open-time
failure must unwind an already-registered region, so add
vfio_pci_core_unregister_dev_region() to drop the most recently
registered region, and use it to unwind the HDM memory region if the
decoder region fails to register.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 81 +++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h            |  2 +
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index e099e9a70a5a..da04776356e4 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -24,6 +24,8 @@
  * @cxlmd: memory device joined to the CXL topology at bind
  * @hpa_range: host physical range of the HDM region
  * @hdm_pfn_space: HDM-region pfn range registered with memory_failure()
+ * @hdm_regs: mapped HDM decoder registers, read live by the decoder region
+ * @hdm_len: length of the HDM decoder register block
  * @hdm_valid: true when host CPU access to the HDM range is safe; under memory_lock
  */
 struct vfio_cxl_state {
@@ -31,6 +33,8 @@ struct vfio_cxl_state {
 	struct cxl_memdev *cxlmd;
 	struct range hpa_range;
 	struct pfn_address_space hdm_pfn_space;
+	void __iomem *hdm_regs;
+	u32 hdm_len;
 	bool hdm_valid;
 };
 
@@ -212,6 +216,56 @@ static int vfio_cxl_register_pfn_space(struct vfio_pci_core_device *vdev)
 	return register_pfn_address_space(&cxl->hdm_pfn_space);
 }
 
+static ssize_t vfio_cxl_comp_rw(struct vfio_pci_core_device *vdev,
+				char __user *buf, size_t count, loff_t *ppos,
+				bool iswrite)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	void *tmp;
+
+	if (pos >= cxl->hdm_len)
+		return -EINVAL;
+
+	/* The decoder registers take only aligned dword accesses. */
+	if (pos % sizeof(u32) || count % sizeof(u32))
+		return -EINVAL;
+
+	count = min_t(size_t, count, cxl->hdm_len - pos);
+
+	/*
+	 * The host committed and locked the physical decoder before the guest
+	 * saw the device, so the guest never drives it: absorb writes without
+	 * forwarding them to hardware. The guest programs a GPA that the VMM
+	 * virtualizes; reads return the live registers, which already report the
+	 * decoder committed. BASE_LOW and BASE_HIGH carry the host HPA, visible
+	 * only to the trusted VMM that virtualizes it away from the guest.
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
+	memcpy_fromio(tmp, cxl->hdm_regs + pos, count);
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
 static void vfio_cxl_release_hpa(void *data)
 {
 	struct vfio_cxl_state *cxl = data;
@@ -299,6 +353,21 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 		goto err;
 	}
 
+	/*
+	 * Map the HDM decoder registers so the decoder region can read them
+	 * live. The block location comes from the enumeration cache in
+	 * pdev->hdm; vfio-pci owns the BAR, so map without claiming the block.
+	 */
+	cxl->hdm_regs = devm_ioremap(&pdev->dev,
+				     pci_resource_start(pdev, pdev->hdm->hdm_bar) +
+				     pdev->hdm->hdm_offset, pdev->hdm->hdm_size);
+	if (!cxl->hdm_regs) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	cxl->hdm_len = pdev->hdm->hdm_size;
+
 	/*
 	 * A Type-2 accelerator has no mailbox and no media-ready register, so
 	 * set media ready directly.
@@ -381,6 +450,13 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 	if (ret)
 		return ret;
 
+	ret = vfio_cxl_add_region(vdev, VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
+				  &vfio_cxl_comp_regops, cxl->hdm_len,
+				  VFIO_REGION_INFO_FLAG_READ |
+				  VFIO_REGION_INFO_FLAG_WRITE);
+	if (ret)
+		goto err_unregister_mem;
+
 	/*
 	 * The HDM region is advertised mmap-able, so a fd holder can fault its
 	 * struct-page-less device memory in from the host CPU. Register it with
@@ -389,7 +465,7 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 	 */
 	ret = vfio_cxl_register_pfn_space(vdev);
 	if (ret && ret != -EOPNOTSUPP)
-		goto err_unregister_mem;
+		goto err_unregister_comp;
 
 	/*
 	 * The decoder is firmware-committed, so host access to the HDM range is
@@ -400,6 +476,9 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 
 	return 0;
 
+err_unregister_comp:
+	vfio_pci_core_unregister_dev_region(vdev);
+
 err_unregister_mem:
 	vfio_pci_core_unregister_dev_region(vdev);
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 1bf86763c0f7..8927a7a4e8e4 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -373,6 +373,8 @@ struct vfio_region_info_cap_type {
 /* CXL Type-2 device (0x1e98) sub-types for VFIO_REGION_TYPE_PCI_VENDOR_TYPE */
 /* CXL.mem HDM region of a Type-2 device, mmap-able */
 #define VFIO_REGION_SUBTYPE_CXL_MEM		(1)
+/* CXL HDM decoder registers: read live, guest writes are absorbed */
+#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS	(2)
 
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
-- 
2.25.1

