Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195543F0B5;
	Thu, 13 Aug 2026 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614002; cv=fail; b=hi56/0mr4ylNkI4fC5f5P69P/T3+hJopRyWgfKOZQYQwV0r9z7kACknRlYuW5tzhwa4RuIKGApGwfFY1MOIJrmdg7AY9LMgbN3OLYNNMk18DYdLD0Ld4cBge3PpwomNBfugbtYcfPtYygTJZE2xP/bNt7AfjS/O48DKV1V+bk8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614002; c=relaxed/simple;
	bh=mm2VWS5DXtr0P2C8VcenJNuLACNFZ5LMuv+fCtFCD2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRXp9Dpfmu98W4FG/jovUkEGUE+iduGJ7Cp3fsewSx79tqG1Z28WvjUGiX9TR5NYagmxRA4li1g0PUXVnsQUFTvowSwAjx3HeG4BodTWbAlnroG6iAjLftnoic2Dh9RizZMMYBIoxRS0A2NR+wZiPxYc0tovBgzG2kwL6rxI8VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H9wwZZL1; arc=fail smtp.client-ip=52.101.57.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H9wwZZL1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcS6z0tGinlxLdc4Ypr/0v/BiFR3BxGyPzJa32s+xP9GT2l0Sz3K0NRWbn2ob8H4BaBTmVv9LXzq2E+HgNGlbH0KhmSbP8nAYBlNMbgczFW3HuDhJgq3SnfymazVCrOA1fndUJJ79woOe8FkFFYesk6TN64umbZGRvf0ffXbqwYufGlXFE/cnD1NHr1r/r9R7Ia9w++MKAg3Ty9vx4rJFNuhObOZ5EZr9bbg0NJyR3EQniNo+J0UEM+anKdSgV/avQ3elKJ2Bpz+OXGH1qG/VOh4IO6EaoX2QIJbSSMjDfD822wldJVhvOYh0PonBgQP0RI3bGZgYTCCMFsyfRoVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECkVWUDSUIjnU1ntdoDVRsoQNc7suvUpPtNkhm4AimU=;
 b=oPcDLR8U2SegAwhnIXdKkIwmapqwYoDSHFjl/8N7mC0o4dzkBH2fF/QfFj6dvOBbi6190Pg24k777dwlYa12vdasg7rB5W9ej0wTR/9Tuvbmse1RYnkcDAo5sR28yix/D4i8qIE36XKHQ5AjP0F6kIPjg/1STUwfUK9kjfpdOkrkkMEDfWky4kki5VDDsIBI7MvTkSl7r8zgL7kpw8Z1d4t/hxGtz7XZJ1ixMRz4Hhk+QhHeaHQuckamysAsFF+b1dJBYLtEo/qPJjUwSazojRVyrdW74YL6vJPFiQ4E03fHsqGohAUpPnzEFXkoLz+mI68e4sO2xF6gYYOmXdbhAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECkVWUDSUIjnU1ntdoDVRsoQNc7suvUpPtNkhm4AimU=;
 b=H9wwZZL1UGDR/B4b3n7gCH4X+JpXxCKdxdS9sLMttAaySEXR+P0iOUg9ky9PmhsoiVk2wqmrlI3fEjNfqQbCchD4ToHJTR9RvHTWDVELYllzmfAJ+A7Y9U58ttCLSd0IrLxuK/XMMiuBZ8XkHb0xiHUlo2aqLGX5sbMC1JTGiMmpoog0d7/k4Qs/Zkr/RdH/nbvI4fIM4/Xj8Y6vNfsDJjXJVgjKtEGjrmkDZedXWp4858crD9wbLUmvFFKJPfI7VaBP3BJCf1urG07O243F/Ji28BzsZg0vZz/xrSOSqN5P39UnOMH06TZ8YOC4CXO4Xq4b7nj5hj6BpUBb732IaA==
Received: from BN9PR03CA0333.namprd03.prod.outlook.com (2603:10b6:408:f6::8)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 09:39:51 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::45) by BN9PR03CA0333.outlook.office365.com
 (2603:10b6:408:f6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:39:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:39:34 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:39:25 -0700
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
Subject: [PATCH v4 15/27] vfio/pci: Call CXL open and close hooks around device use
Date: Thu, 13 Aug 2026 15:06:19 +0530
Message-ID: <20260813093631.2288172-16-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b03fa83-e25f-44c6-3fd0-08def91ed2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|921020|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SKZKas/Mz+mvVLWX54Lc68TRuwx9t8wHJjj9ul88iVEUdMEHSVAeHDzAjT+LbHh7V5cpI2U9p4kR2PdMpvEzH50ACtH5TJ0zjEF+6tNua5m3mLznoapjLrLFjEN0y4fdiH4EfWE3GXjM/3guXiv6dWC98DLPf5aDC3WYZIW+STe7Dc0w33WBdPct4HOumDdsVER7fvItjfx+dU+r/Curlv98hk5AD1K8GaAYiunBYjY77nmV7CuNajDl6nZCRIP7NitxJcNClRYEkNscgIV7C7AM1F/eIX/NJ/B8QWbbDJszF6qiOaUOKllgUgUyqhauW0nU+Hwfc1CSegDrd3Lq4CgKsf+6Vn/1xEJq6f/jEqFa4IKUckDmhyqIhOvYqSvoX4Hg+nPahONoqxGcyqwHrM0jT2AzaBxL/5McZFC/mWhH1S4TJ9pDLqmXVwqn0MBq4U1uMofhFB4rPLx3SSHAcA7gzQckLKDAkvYvtbtZeMqZEX35gf961WRK9OA2tPJzIroKAt8bCgoxE5J4nvFFmubQkotm4Y3mqKsENJB331ePBAA9VoCSW0871I4JzDHB1cvtl+S7MuPMA1F1GXHuKezddW5ZI7RrebkwGXt0GS6AbBWxE+GGtQ62oLtEHkMl+jDQvMgPgtU3F8rxjCZLbaoQbkQeq7HzEmjaxN4vtN2c1mPDIsnHFFZCEl5fEn+/IIEe0bNJJlY3IMhZRnD0sqWyzx/6Cgify6VFoEPoInJvfXoNoi2Xl1L63DMzSs58
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(921020)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hIR3ZlUsfR2ruN4FSi5exZRvcOBJpitYgShwAY+82lxTooanYNK6qz1hAnwUxJKUTrpIP/w77BQrSDi47yxdEeVok5xCA9JkKntECwxKBCJmqc1q6ev4J+OtfmXXRliHQkd9Mk8FN5qA5jgq0VS6yl30xBAtpMAvIxUTsUhvtMG7gC9dMl8znK4bLVdadROa814iaNGFsu/63heke2v3tlasyAvVhna0DbR95VVvXue4YS2xw1TqKGSLMrmooUmr0xTSjz34RUbFZDPfvWcxhhIb5qPZpVTe8a5DEtF+iN6gtFp+itdhmUfkfHrB3y3Rrn71FnDFCjPztXG6iFcfHMmALr3NSndkWK2XsgVW46Ljo8c92IWUJtu4atuW5eOjeCiDxVgorQ4Qv2vSfXsWhHAf3EYnHQAWX+ywcTSxCGnD/4TjRJI/m68X7lt2alaM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:39:51.0872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b03fa83-e25f-44c6-3fd0-08def91ed2b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647

From: Manish Honap <mhonap@nvidia.com>

Volatile CXL register state must be sampled from live hardware when the
guest opens the device, not at bind, because a low-power transition
between bind and open can leave bind-time values stale.

Add open_device and close_device to the CXL ops and call them from the
common enable and close paths. A failed open unwinds the enable like any
other error. The callbacks are stubs here and are filled in next.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 11 +++++++
 drivers/vfio/pci/vfio_pci_core.c     | 44 ++++++++++++++++++++++------
 include/linux/vfio_pci_core.h        |  2 ++
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 966b7c22a6ac..d19fd638f538 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -100,9 +100,20 @@ static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
 	vdev->cxl = NULL;
 }
 
+static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
+{
+	return 0;
+}
+
+static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
+{
+}
+
 static const struct vfio_cxl_ops vfio_cxl_ops = {
 	.init_device	= vfio_cxl_init_device,
 	.release_device	= vfio_cxl_release_device,
+	.open_device	= vfio_cxl_open_device,
+	.close_device	= vfio_cxl_close_device,
 	.owner		= THIS_MODULE,
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 49dfbdaf3f05..470730cdc88b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -584,6 +584,21 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
 			   NULL)
 };
 
+static void vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int i, bar;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		bar = i + PCI_STD_RESOURCES;
+		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
+			continue;
+		pci_iounmap(pdev, vdev->barmap[bar]);
+		pci_release_selected_regions(pdev, 1 << bar);
+		vdev->barmap[bar] = NULL;
+	}
+}
+
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -660,8 +675,23 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 
 	vfio_pci_core_map_bars(vdev);
 
+	if (vdev->cxl_ops) {
+		ret = vdev->cxl_ops->open_device(vdev);
+		if (ret)
+			goto out_free_config;
+	}
+
 	return 0;
 
+out_free_config:
+	/*
+	 * open_device() runs after vfio_config_init() and map_bars() have
+	 * succeeded, but a failed first open never reaches vfio_pci_core_disable().
+	 * Unwind the common vconfig and BAR state here so the allocations and BAR
+	 * requests are not leaked for a later open to overwrite.
+	 */
+	vfio_config_free(vdev);
+	vfio_pci_core_unmap_bars(vdev);
 out_free_zdev:
 	vfio_pci_zdev_close_device(vdev);
 out_free_state:
@@ -682,7 +712,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_dummy_resource *dummy_res, *tmp;
 	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
-	int i, bar;
+	int i;
 
 	/* For needs_reset */
 	lockdep_assert_held(&vdev->vdev.dev_set->lock);
@@ -737,14 +767,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 
 	vfio_config_free(vdev);
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		bar = i + PCI_STD_RESOURCES;
-		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
-			continue;
-		pci_iounmap(pdev, vdev->barmap[bar]);
-		pci_release_selected_regions(pdev, 1 << bar);
-		vdev->barmap[bar] = NULL;
-	}
+	vfio_pci_core_unmap_bars(vdev);
 
 	list_for_each_entry_safe(dummy_res, tmp,
 				 &vdev->dummy_resources_list, res_next) {
@@ -827,6 +850,9 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 #endif
 	vfio_pci_dma_buf_cleanup(vdev);
 
+	if (vdev->cxl_ops)
+		vdev->cxl_ops->close_device(vdev);
+
 	vfio_pci_core_disable(vdev);
 
 	mutex_lock(&vdev->igate);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 43755b91880f..7354dae1dd85 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -70,6 +70,8 @@ struct vfio_pci_device_ops {
 struct vfio_cxl_ops {
 	int	(*init_device)(struct vfio_pci_core_device *vdev);
 	void	(*release_device)(struct vfio_pci_core_device *vdev);
+	int     (*open_device)(struct vfio_pci_core_device *vdev);
+	void    (*close_device)(struct vfio_pci_core_device *vdev);
 	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
 	struct module *owner;
 };
-- 
2.25.1

