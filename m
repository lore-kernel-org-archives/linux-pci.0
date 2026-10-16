Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0244F7CAF;
	Fri, 16 Oct 2026 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167699; cv=fail; b=pWFUMrHSu2Z5n2og75UJBawiVVp+y/3vYtrbr1XebkwTXTf3Bxmz/L97sVEjCTfbBeY/Pxbjh2V3Y+zg7PVs9I13g8BKAVF6HKVFyPmC1ykqm725EPUh8n0LIbZIr3suw0WnjsBv5i3KU2TbSogd14DKCeewXYv8C72WrvLbEUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167699; c=relaxed/simple;
	bh=mv8F9meHpYRGTfiBgzz4i6VGu4Ke+PL57IXy76d8Ojc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bs8yqNg2A4Et/2X0lXDDn4u+Auiyd9fWS+CLcKsUSAE4dgMEfwZBijtXr2Jxx1uRWvN/ekMPk34eSprBLkLCzu3QcvZ/6DRxbIAFU4iJQ2se+fNk0avnhLIvJOxDWkVPx5H3WKl7XB2HA8WyjK484DhDqhKbul+hxQhdXCGWAz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ek94hiYA; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ek94hiYA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEOy6lQLXXKoLe6uwCgww+BjP4cFioPWjjDbkZ1O57VDgpA99xp8csLjhPxf2zdm+oAM7MIFVh4rUuxGgLZCu76perqGT192J/mk5nBVTjJr6dc8DLB0fHQcJTz5AUvvsntDiK1jgErjIEVR+Yctfn8NxGy7ogOnwo5ZkYJ8G3hdg94C4ABPgzFA8846ApRpUkQTyI+5epCb18Hu3smw2VP5AC2gWgmyR6/ymVLGUVoUhYW+TZUwKmRl7+KBjSx3t8lsLo3uwwGiyxx3AYRsu0rzrZNoj7fKTRwffvoXzQr8LMqvrtHjhhwyKU2EKfA4Pe/w6wKUpUa6TW/+8K8LDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLpUrx2isLb7Rt+CHlT5Gi/ZHAjiEzItcZvQiJbMYU4=;
 b=TAiL5QRPPG12PNWeBUsVstdDizSMj7Ta/SF4gyDXuMgISdMTmLThjY30QQC6uSvnLyodmQ8EVKhghX4gxohrdWS/VUThJ4Q4Plys0+kxVOO6KsH8dQEhoR9nSpFvuT7g5BiAd4GnXkrQRlniVt+NgGFw/GxPRT0XNq075pY2EM3GsJl7ZYi8ujuNJsuVFbCF0ZISR///6aFUDWMd7E95UMAWRXmf80Q8UuxvJ1Nt1632tGIuZENJ41yiNx02xCTUuAlrq0VqgXDhB4/ktX+h8vVVzQSEah9SDduIjVMVKPwCHIH9bpoLmSdt+2z6gJeYUyq6JlJzWVxHQehWUN1w0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLpUrx2isLb7Rt+CHlT5Gi/ZHAjiEzItcZvQiJbMYU4=;
 b=ek94hiYA6LuwdlYWEvS06Kfq9NSTyl1CUpVUimH3EV2FVhtX4lnAjPAR1DMP8tjsUe7paCDzQKQqtdhCJRafTXlvAQOXZGB+gBKcDouOSmg6k/Phy3+nBMSVvFo1hr0IrbCfjFpfNOhNJkXOvfnweQzo4ZsGBRjSZXKLe+033mUM7HGghRfRfZxBF/KYmjny37LLQqBKeeIplpBCPe7PG0IUTB+C/HnmaH5OjVSEKX1xycJ1cI7fQMEWCQ9sBJX2T2T8aU8XCLt8TE+aNkhYQX0+zzvN9+bzxelomxdr+zDa4QPvRTWlI4yrFhyiYxCAu2SEPRhivKyH/RtcrKJkrw==
Received: from CH0PR03CA0413.namprd03.prod.outlook.com (2603:10b6:610:11b::11)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 16:21:17 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::37) by CH0PR03CA0413.outlook.office365.com
 (2603:10b6:610:11b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:21:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94F.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:21:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:20:51 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:20:42 -0700
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
Subject: [PATCH v6 12/31] vfio/pci: Call the CXL open and close hooks around device use
Date: Fri, 16 Oct 2026 21:48:19 +0530
Message-ID: <20261016161839.2765592-13-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|SA1PR12MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f39bc9-8eba-4fbe-caae-08df2ba1814e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|82310400026|36860700016|376014|10067099003|22082099003|18002099003|11063799006|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NzWthvE/5p1IQ38faLDrQfIfdt1VjOjcbNS5z/CuKnLM9QmZ+JuHjnnhXc788e2fbnHqjCj7bOdCHY+cxE19Vx4H9IpQGq2ezfdH7G/NTvg1CD+l2kilmi310pcEqEycNLOrzqpJt54rQzENUII60ny/U/NZdyl5pb2RJt9s9ojhDOFvLvNjtaPT5ZxkE24R3yR9XN0nWITN+NAKtVPtDP5KpiSDoCk5zXZ69dN/DK3wmmAaJ1ZrmcRrCMNAysKyXr/5761S9rh7jI+w6b3bFXcdtQ2R08E+w/hg9O01LglxhR2ZvZtg9G2QlrGp3m3gUd8dDa4l/TopEnoakU/66ul3KVB9nthXzFs+q4ELfKVG6+8GY2I2OAg/9paVQzh0oILVqpYBM4ueuNjAi29xyY+n07GUKHrMbO8aaZQGCHRtyIjLa0bYbtwfB37VB3HHngNt65G6aqqHrmtRgXF85r1ntT1eX3vyWUOC4XgRw3UqIZkV3N3w/AVglOgyOHiDFKvzAZHWCBbKJgvY7qJrrYv3aaPmveixn7qsU2QhiQJZMSCtJc/d1g6nVAT315DGJDOmAZl2ZiLXKmqxClvw64XqrFBVp1AugsjQ8vOV5Ai9n/6NUG94pJ0L+rEIDw8gM6WouO5lqcVSD1UJ3zKf+5jy/q5TCXjXYqQx1sW60/cCciTZRHNv+bom7y+ZPxre+TtynZ0uc/8OiEDQkdil1vdjoJdq4p7lLny8THHh6dyR+x1zF6JimsZv6D293njX
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S2thsX3rYSPARwbcLwskfqlhFc+6U03s8dYDCoYqI3E7ZPCcinHAZrBzLbxS96+0CXwWwT8s0/VGjpMzddcMrnG++gRx78OEcwg6QdyIaHa+j6CKO0NOJNZX0Mr1+t+IAgUi7LS3Mq4xWSB1b308F8Nvslb9GaZCtOhlEMSoPsdyQQLflAaO4sjfalPl+B6pQmdf6lQoqyxIerKbwgq5WEkMuxuNbofxy4YMI4jqWUDmRz2yPBn7CJYmlc0sd+KoD1rUUGf/T/T1rpxJBaevqpjPeVlSVC05+mKTaNJM8DQjuNECyoAeZ0VNk5LT7J/WEOm+kX9bnu3hxM/lDur3cGDEDO6ZmkDOnytnARJWH/HEfZhq3awI9seOhHOQzPStO6aaFb5jkKH7WJzQiKHrM09GfLcYAZFxMndk6jsVCcsx6Diu7AonusmNuuP8mgXQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:21:16.7129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f39bc9-8eba-4fbe-caae-08df2ba1814e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600

From: Manish Honap <mhonap@nvidia.com>

vfio-pci-core frees device regions and excluded ranges on close and on a
failed open, so a CXL provider must set them up at each open.

Add open and close to the CXL ops and call them from the common enable
and close paths. A failed open unwinds the enable in reverse order:
release the device regions, unmap the BARs, drop the excluded ranges,
then free the virtual config.

Factor the device region release and the BAR unmap out of
vfio_pci_core_disable() into helpers so the enable failure path and the
disable path share them.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 57 +++++++++++++++++++++++---------
 include/linux/vfio_pci_core.h    |  2 ++
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 211fff6045e2..3d4e01eea7b1 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -590,6 +590,31 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
 
 static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev);
 
+static void vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+
+	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
+		int bar = i + PCI_STD_RESOURCES;
+
+		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
+			continue;
+		pci_iounmap(pdev, vdev->barmap[bar]);
+		pci_release_selected_regions(pdev, 1 << bar);
+		vdev->barmap[bar] = NULL;
+	}
+}
+
+static void vfio_pci_core_free_dev_regions(struct vfio_pci_core_device *vdev)
+{
+	for (int i = 0; i < vdev->num_regions; i++)
+		vdev->region[i].ops->release(vdev, &vdev->region[i]);
+
+	vdev->num_regions = 0;
+	kfree(vdev->region);
+	vdev->region = NULL; /* don't krealloc a freed pointer */
+}
+
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -691,8 +716,20 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 
 	vfio_pci_core_map_bars(vdev);
 
+	if (vdev->cxl_ops) {
+		ret = vdev->cxl_ops->open_device(vdev);
+		if (ret)
+			goto out_free_config;
+	}
+
 	return 0;
 
+out_free_config:
+	/* A failed first open never reaches vfio_pci_core_disable(). */
+	vfio_pci_core_free_dev_regions(vdev);
+	vfio_pci_core_unmap_bars(vdev);
+	vfio_pci_free_excluded_ranges(vdev);
+	vfio_config_free(vdev);
 out_free_zdev:
 	vfio_pci_zdev_close_device(vdev);
 out_free_state:
@@ -713,7 +750,6 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_dummy_resource *dummy_res, *tmp;
 	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
-	int i, bar;
 
 	/* For needs_reset */
 	lockdep_assert_held(&vdev->vdev.dev_set->lock);
@@ -759,24 +795,12 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 
 	vdev->virq_disabled = false;
 
-	for (i = 0; i < vdev->num_regions; i++)
-		vdev->region[i].ops->release(vdev, &vdev->region[i]);
-
-	vdev->num_regions = 0;
-	kfree(vdev->region);
-	vdev->region = NULL; /* don't krealloc a freed pointer */
+	vfio_pci_core_free_dev_regions(vdev);
 
 	vfio_config_free(vdev);
 	vfio_pci_free_excluded_ranges(vdev);
 
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
@@ -859,6 +883,9 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 #endif
 	vfio_pci_dma_buf_cleanup(vdev);
 
+	if (vdev->cxl_ops)
+		vdev->cxl_ops->close_device(vdev);
+
 	vfio_pci_core_disable(vdev);
 
 	mutex_lock(&vdev->igate);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index fd1ad0baf470..6520a2dcfd4a 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -70,6 +70,8 @@ struct vfio_pci_device_ops {
 struct vfio_cxl_ops {
 	int	(*init)(struct vfio_pci_core_device *vdev);
 	void	(*release)(struct vfio_pci_core_device *vdev);
+	int	(*open_device)(struct vfio_pci_core_device *vdev);
+	void	(*close_device)(struct vfio_pci_core_device *vdev);
 	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
 	struct module *owner;
 };
-- 
2.53.0

