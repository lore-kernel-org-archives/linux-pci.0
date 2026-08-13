Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6E44477FE;
	Thu, 13 Aug 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614069; cv=fail; b=poLoc4FQOHPWDogcH4r987CydgmAHSSweCks5BcEfk1sxzuKRt9kNywEdZDG6303e8/BuUv7waj0UULPEnXAovE5oUn722sIZ9ZG4sSh5xIr3ZG6HBZUSUtG/Bp0KvBt2n4JkE0Cbq/DUUmUfFaKYtQnt5LwPFl+gbe2RvWkrsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614069; c=relaxed/simple;
	bh=maBfY+Yl1dFVumfL8hRO/iFqK4Xh+DKvVvZzlJiBBsw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MykC66A33f7kVJ3yaVqtUyUxls38or+BYXlqZDGPGUQM3xXiEj3TtasUHTPXV4mUqVmGoQxJ7FvH+1r+RXaKtQuAb1kT5PJihfLAozAaG6k0yzBm530bzwWq1wYsxR2CSgIAI/WEa9kieEA57Wsj9YDdX9UP2Iii4nicMjDCczM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NDMrpAgK; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NDMrpAgK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mb7BbM+bsl4IQ4jubjycBH9rkyhoK9AmlJs/OTnZdd88aJ0T3FV84HQHqgR4elvjxMestrbe77ufpPIT1dA5Fa3goN7+t5r+KDYdxVbTwxjWkRS1TYO6CpEPjRtlMgiDwJbSuy7FeOnpLKMgbNpmst2QMyRmeD74iUUk5F8WHFOsj1ZfRJ0SR9xGTrm17IPIWvwae+O+SBgkieKP2gysOB9lBfGH09uWGY6uX/MNoMcRXELwJ0mmiJ1UkElnz+SO5h4yJOqKHjiYrGf8dEFdFLrFAlPG/cWY1qC/jFxjBz6WgMkf5uYfpqJHv9erNweaI4pfGO6RGLREpiBn/K8pRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiDn2TFa00zJzDnk+S5zCiAxbNRCBs8+2pacQ4+3tHY=;
 b=AJLUgar6Ew09Pp4Xy4O+fedJu+CAWs7FBXU6cfZm1b7FOxfZtQ+iZ/WB0kcngTxxnhM6oPW82o+JQEwKm34SL2GXogxTR/r3ZVkOq53MosEz2aNI8+7uzDK5oBlg+YZhLZMN696qrIu9BPBpFuLCWt3A3o1f5MgQRki2HsVPhSayTnI4vYUSSryWhq7gFlK7BUFq+v6JBYTwBYmBPQMQlxxA4K0xaoSUsvuGgMSpLEqNtGABsbOLd8bl3tm9u9/eMozHmWiS28OCFK/eTxiC0Q/A+0evyMvfnEl/PqhOqzG3/Ac5QUd39udgx+jEIurUHBimYKFKGVSTGJgiuXgE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiDn2TFa00zJzDnk+S5zCiAxbNRCBs8+2pacQ4+3tHY=;
 b=NDMrpAgKOZTWoOINtYvrQDfSdpzMUWl10liFdmNUgLRTwvRwYSUcynHrd02AMa/x4/bZIl3YJuKVJunmvzyeRPX1Yr9oEJvgwKpnENZj1tMP/wkVAt5U0n5PYJjnP6l/+bM9uJvalgQQT5LG6hCLEeh9Pb638tFQ/dt09vf5GJHdhkbm020fasdK6aBWwBZW1hA81FsN5tUaXlfP/TXGRsj0vwEAoNvSdcYhYPIVtWBc/4l6HKI45KJikS4/G0qYLAbFoY/Jn/Zcd6cGtf8accd1dDs1ogiLu/JOu8M7AyigzBB1q8KQ6ewfBMR0JAHln04U63+kokBGk5vdnf6/cQ==
Received: from SJ0PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:33f::18)
 by SJ5PPFA5F0E981D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 13 Aug
 2026 09:41:03 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::9b) by SJ0PR05CA0043.outlook.office365.com
 (2603:10b6:a03:33f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Thu, 13
 Aug 2026 09:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:41:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:40:41 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:40:31 -0700
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
Subject: [PATCH v4 22/27] vfio/cxl: Revoke the HDM mapping on reset and power transitions
Date: Thu, 13 Aug 2026 15:06:26 +0530
Message-ID: <20260813093631.2288172-23-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|SJ5PPFA5F0E981D:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adfbc0a-1652-485c-dd9e-08def91efd8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|7416014|1800799024|82310400026|921020|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	+vkYFp5NBDXVafaof2j0VSFmg3clBhIOJfFa/HXIrH3Hmxpsyj5t+WMY4F9rk52lWjh4Hl1O3SGmYlqTPbMt7KbRjrp+5YC5PMK8Nr//6te8jUxtBhZfmkRZ28sGuILYZn8WI/3DLTNswdiB5VX0dpILM1Di74X/yxe9PVcmXXcGg9S212AoZnClcIEBqtImwwCWh1qEfctXqxaUSMNqpUUlbaHfK2CK9ny5HuI3cwDiXPW/Xtf1Z/SpFoOlcVpHyOLz0nv4jPaZqqh0F6yIsfDQ5inoUSxpi7QTMBW/0PZBy2jwjBXqMH7RcvebxKxXLUjx5YbNClWLt8FA9PgypsKScx1keja6MZp+fL1M1noYrA+mMdO9reOL5KIPJaCgYezNwI39Vga5kciCuHkm94u8UqkW8NQ0Z2uZLF5CMsRlLpk20WMr6Y1DH6rZrpuQAW38KvABPth4i/CsBWcYksF7SxPnzzGuTftKdDFe18SLP5Ff2q2YhpYIdRx9sUKRcinUXSLY6eKohwsq0WXs6T2NNqqUdrHQjr07fCuCD1RYwb7yjI3CKyXxefxt+fIjsrtVA9i4lbiZ0B5F4ZehWZSdu3cI12pBXR+cJHM6w2g35qRRUSMx9n/gYfSE0L2XFaz7smz4MDUwPiiqktR9X5vNtJuik1fsw1OvDbQJd0dVZVEr3qxICgm57vhwUS4Aqwnuib6lpZfE44+HMxHimINp6fN6p0PA2+UX0iSslmDRLWlZf+WRYzaWEOKEPizA
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(7416014)(1800799024)(82310400026)(921020)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iNnzvg+PQU1hAdrv4WrOnz2LnqNvIf4i9ZEV+LgJGRfF5wGq4DKioTQiwpdAG2alDM3Tywh1LAiavR80rZ+BsknOQw+iHr0BAllODM+QHt01I5FTpBqNmOL0d3YBEbdQOibsqoqo1YuTMlRZ4woijpNgWKriLr6p1BHKXcQGy5YypmZwaWHF3IqFpeNLBmZXBGUML01QOv9kwRmJi+IXplRK/ZY61JvbfsaOyP0o9lc6ykOPY+MEvklEXOoL8jpXaSQJQf5O3vnCKeilEgVgMnZMpFOk9m/m974zJq53XuZsvThxEpJc2AmgD+pRp9SjRckvSqVc1f+lKcpis3yFcP4Fp8RaHMaNnkt48siQ0bUP7/bwoykh6oMF8wD6k67LUtsQvtrHt16tWEz9upEj76HAGl+ktwSrRBGtkatA0ecjF/+Tc7HGRniU7svpHQZv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:41:02.9925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adfbc0a-1652-485c-dd9e-08def91efd8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA5F0E981D

From: Manish Honap <mhonap@nvidia.com>

The HDM region is a device region, not a BAR, so vfio_pci_zap_bars()
leaves its PTEs in place. A runtime-PM entry, a D3 transition, or a reset
would then leave the guest with live mappings into a quiesced device.

Add a zap hook, called alongside the BAR zap under memory_lock, that
unmaps the window. The fault path already refuses to re-insert PFNs while
the device is suspended or its Memory Space is disabled.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 29 ++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c     |  8 ++++++++
 include/linux/vfio_pci_core.h        |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 0fb5ed5d86b7..f1c6bf06c408 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -530,6 +530,31 @@ static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
 	vdev->cxl = NULL;
 }
 
+static void vfio_cxl_zap(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (!cxl)
+		return;
+
+	/*
+	 * Revoke the mapping so a later access re-faults. Do not touch hdm_valid
+	 * here: zap also runs on a plain PCI Memory-Space disable, across which
+	 * the committed HDM decoder stays valid (CXL.mem is not gated by PCI
+	 * Memory-Space). hdm_valid tracks decoder validity and is cleared only by
+	 * the paths that can leave the decoder unrestored (a failed reset or PM
+	 * restore). A reset or D3 transition holds memory_lock for write while it
+	 * runs, so no fault races the revoke, and a runtime-suspended device is
+	 * caught by the pm_runtime_engaged check on the insert path.
+	 */
+	unmap_mapping_range(vdev->vdev.inode->i_mapping,
+			    VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_NUM_REGIONS +
+						     cxl->hdm_region_idx),
+			    range_len(&cxl->hpa_range), true);
+}
+
 static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct vfio_cxl_state *cxl = vdev->cxl;
@@ -594,6 +619,9 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto err_free_shadows;
 
+	/* Remember where the HDM region landed so it can be zapped by index. */
+	cxl->hdm_region_idx = vdev->num_regions - 1;
+
 	ret = vfio_pci_core_register_dev_region(vdev, VFIO_REGION_TYPE_CXL,
 						VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
 						&vfio_cxl_comp_regops, cxl->hdm_len,
@@ -738,6 +766,7 @@ static const struct vfio_cxl_ops vfio_cxl_ops = {
 	.close_device	= vfio_cxl_close_device,
 	.config_read	= vfio_cxl_config_read,
 	.config_write	= vfio_cxl_config_write,
+	.zap		= vfio_cxl_zap,
 	.owner		= THIS_MODULE,
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 77f8f39dd670..1a54f15d1c2c 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1832,6 +1832,14 @@ void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
 {
 	down_write(&vdev->memory_lock);
 	vfio_pci_zap_bars(vdev);
+	/*
+	 * The HDM region lives in the device-region offset range that
+	 * vfio_pci_zap_bars() does not cover, so revoke it here too. Otherwise
+	 * a runtime-PM entry, D3 transition, or reset would leave the guest
+	 * with live mappings into a quiesced device.
+	 */
+	if (vdev->cxl_ops && vdev->cxl_ops->zap)
+		vdev->cxl_ops->zap(vdev);
 }
 
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 294e95b5e881..8b93949d4484 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -76,6 +76,8 @@ struct vfio_cxl_ops {
 			       int count, __le32 *val);
 	int     (*config_write)(struct vfio_pci_core_device *vdev, int pos,
 				int count, __le32 val);
+	/* Revoke the HDM mapping; paired with the BAR zap */
+	void    (*zap)(struct vfio_pci_core_device *vdev);
 
 	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
 	struct module *owner;
-- 
2.25.1

