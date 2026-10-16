Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010018.outbound.protection.outlook.com [52.101.193.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8466542EC5;
	Fri, 16 Oct 2026 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167829; cv=fail; b=e8GntRwxJdW6umiQEaKHza1kUpnnFWzkDvFQCWAjF/iaZWddt3YS3NwnunU937veoxTR/eYiidUVHQA1XBDrVeeB8NBl590F7cVz4X4c09Xm5QpWjR3ttL0+NggikkeyBqC8yDNUwvdL6IxtmDhEBRIpuVdY/wlA0tItPk6Rm64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167829; c=relaxed/simple;
	bh=hRb5rxvX/X5Wbh1bBbsClAj5vWDQwEXzsKT/tMOjKmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOewHFEi/GKiTRKO74Qr9HXOVnJxjVySldGHXDrD5E8oPE+XMrFhB+tmesggKcdRNqAvW+TvYuqmTDCOr72RXx9UF1LAm7j6rnt6hqg+nxYnk5GDTb4UvXw8tE6UCtaiQZZ5tAgGhirCmfXlxekmztS55+DMBSkDswNPDMkYro0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VAbPS0Tj; arc=fail smtp.client-ip=52.101.193.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VAbPS0Tj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nccNvDIC6BqvUyebGvAEawOWhN9COyN2lKdgm77NY3sunCkwmlD1ofGD06FR8EaZ5PjXrH9Mq01Z9LyTDAg7NwyvPHIRoLGSARbAzPbIXyb76cLYr5hU3Of9y3PUgZMrh/tW+pcmZpJKuO/Ipt5BjhJcUuKncSZdAoJoDVmCrD6MgmXORdEmQMf/N4s1ooOMBHOaf0XnCUTUeH2DxhMFXvgroE+NIAdZVPmccK3NR3k1MB1Iok3fH/RKbnKcwcAC4B43bLzyyTtqAgCCcYoUtHqu051pKxwqvv1zw7NfNQ3ws6kE3F9Ex48wI73U7tspoT0TGlYDMWFEAKGa9vKtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUFVLuogs0jQqdn5y85ElIHumIpqUqnIh7FOnr026HI=;
 b=aeYvzcMOsMj7v85YITmwNE4rINHV9Wjrrl5yaGV8JV/yXLriXNR3lwsIfuNDQWyPPxWafa+TgnAM2XwMLjVQg4udnLne5tWM0Wn9DMEWHx+pe40nBY9Z1nmVW7yvLcZ7f57gRidK95dEiJnHiMjaCcmjCZXalO/zrHJ0/0mbtbgfXImFF4KNMwzjnJfvKDUpnxdT8+M8RL0aCVyKTWjHsZk2Y7SgTwk0yKxasAnZfJV3xTOGTmVvXH2af0NJT87bwZ5f3LbFZTutxHWtkjhfdCUuRvWDZ6P178xd4plIlVZ5l91HYOFbtRCNxH5wJ0rh0MDcyjTRxFozMUh7ecNynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUFVLuogs0jQqdn5y85ElIHumIpqUqnIh7FOnr026HI=;
 b=VAbPS0Tjo+mtnXJqU4gkLD84akSOtWNdTgEag83euTglbufvxRLGcRpI6dJJYNh44SDHFrsOvQXuBqiAoXoAtQdRU9pHgMl5lvpn1S0/Cb9ACKLrktdzfZaiLaF64WDBp057w4hGb0NQkffNPFwXOUH5FfyY1ihAXGuvTeSupdrkIzZCU0WcjNomAwiawUfpbzsvVlDgtRa2P4r0q2xwb8pReR9mkzQ92zutju/54Hne3sSDzluu9InVJloi/AZy4u2fb2B3a/hnOgKvC/NTMfF2UO0gr7r/qLKgT3GyVO+zLAaD0FvCupSQxMGt+ORXpoHy5RgQ2xVvSqGTQ/vrKA==
Received: from CH2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:610:4f::34)
 by CHBPR12MB732828.namprd12.prod.outlook.com (2603:10b6:610:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 16:23:30 +0000
Received: from CH01EPF000BE948.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::72) by CH2PR18CA0024.outlook.office365.com
 (2603:10b6:610:4f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:23:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE948.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:23:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:23:04 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:22:55 -0700
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
Subject: [PATCH v6 27/31] vfio/cxl: Describe the CXL device and decoder geometry to userspace
Date: Fri, 16 Oct 2026 21:48:34 +0530
Message-ID: <20261016161839.2765592-28-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE948:EE_|CHBPR12MB732828:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8b1ad8-dc83-4f7d-38d0-08df2ba1d0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|23010399003|36860700016|1800799024|921020|56012099006|11063799006|10067099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	zo04g3yL7Bn1Yy1OuM9RM19t2d76wxQBQRyZ89mee0r1/cp7s9GZZFNPFiyGGme7wODl3FwY/L8XSdN7IQZojcLwR2N3CwHmRiRXVic7DAiK2/iZ68Ldphz5w9EmHaIK136KEF0jcz2Y2Wgv4hUcXdkWDP5X6QQKeS01GSonSV100CySU5Pa6TA+p36coIbfsZWetpV0kq7Ht0nXGhizL1wRUZ6DvtEjxTm20CeC7Vk2ZPT8/gdEaOWUDceSzLikYiUVTxirddpdXqGxLpRDAszbvxuUwCrNpMMVPjg40WIHBp/vCZaKaTGJhIjFvfbS4JaNDOn1+MufqWhEC5R7WtoI/dmn7J/m+qq2l0fcrXP/A4d48Kl3wPVk5HyrVKANYAVb6sm+1P8g7Qloal9FkdXiOypzFiZ4y4ABWX3dqyozsCir7vbBRD3tWmI9iaWgip9eMK4tDsa5isPxUlwLvg8rhRI9vYpuOeI0OC5GDVXtS4iCx3DBkwQVbYw7crGKor/mrkTtK5PQ7gKrDK3CXzcWlPeb0zw/HX0QwOhM1r5Led1KriVoku2eYwY2u5iF3qZF8AnCWycj8/JsyJ5uHF3L0dXxQdw2aS7o6m4tEHG8wqf8a3hfZOkvOGxn/8+eDcPTTncOqabwY3vIcnH4d3Rf8roqLDKh5TZ8YtQkfjjfJX8Adu6z+fkjI68HV6GKi++g+9idBXSl6Aasi81NLmPkD6JGx65Lz2Yg5GKHOY35zRpqA7W8vjF1O9RGmH+t
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(23010399003)(36860700016)(1800799024)(921020)(56012099006)(11063799006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gM5NZEPu9XN80DiAaE+Ea+X00R9idWLieWIhclSVCrdfMa8f+603zTAkqh7/hl16t1NqFZNbDjyzO3qt9DlQY8UKFhPNAbfNKeRkj6Edr67MdnKjOQssp20pqBdtkVd8WyJ1cMWwgiBcXWkEbW38/8ihy7W1jaXvOIk+NFeTTjDQjjQguX2ATpWqXuRnCkIBpZlIyi4VedyKbFfkXd867XjUDn2eikXHubb9HkcJIoCtlaHuMcwXFrhpKInVRaU0UEuUpV6kreeJLvTnRNLH0/3dGA2DjJ1BnyE822AS3fOSFGxYzXVNI5bf2c0XC7fDpxODN7hf61oG5ZnFSfo4Vr20UNKpnAb7l0oRTq8q7vV/WGZThGQVt3oDkNLfu+9fv+GDY3BvxLkp/fuepcSyMYwHLGcAYOkGEz9iy4rfQdNve4sKRhTYJ7B6BHtqcKdS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:23:29.8504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8b1ad8-dc83-4f7d-38d0-08df2ba1d0a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE948.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB732828

From: Manish Honap <mhonap@nvidia.com>

Advertise the assignment with a device-info flag so a VMM can tell a CXL
Type-2 device apart from a device bound without the CXL extensions.

On the trapped decoder register region, add a capability carrying the BAR
and offset of the HDM decoder block so the VMM can place the trapped
window where the guest expects to find it.

The size of the guest's memory window comes from the HDM memory region.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 16 ++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c     |  3 +++
 include/uapi/linux/vfio.h            | 18 ++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 3cbb9fbc8328..9ef052a3745e 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -286,9 +286,25 @@ static ssize_t vfio_cxl_comp_rw(struct vfio_pci_core_device *vdev,
 	return count;
 }
 
+static int vfio_cxl_comp_add_capability(struct vfio_pci_core_device *vdev,
+					struct vfio_pci_region *region,
+					struct vfio_info_cap *caps)
+{
+	struct cxl_hdm_info *hdm = vdev->cxl->hdm;
+	struct vfio_region_info_cap_cxl_comp_regs cap = {
+		.header.id = VFIO_REGION_INFO_CAP_CXL_COMP_REGS,
+		.header.version = 1,
+		.bar = hdm->hdm_bar,
+		.offset = hdm->hdm_offset,
+	};
+
+	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
+}
+
 static const struct vfio_pci_regops vfio_cxl_comp_regops = {
 	.rw = vfio_cxl_comp_rw,
 	.release = vfio_cxl_region_release,
+	.add_capability = vfio_cxl_comp_add_capability,
 };
 
 /*
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index be2acab625c0..0c4a3637619f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1391,6 +1391,9 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 	if (vdev->reset_works)
 		info.flags |= VFIO_DEVICE_FLAGS_RESET;
 
+	if (vdev->cxl_ops)
+		info.flags |= VFIO_DEVICE_FLAGS_CXL;
+
 	info.num_regions = VFIO_PCI_NUM_REGIONS + vdev->num_regions;
 	info.num_irqs = VFIO_PCI_NUM_IRQS;
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 6cba3284b21e..81985e68166a 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -215,6 +215,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
 #define VFIO_DEVICE_FLAGS_CAPS	(1 << 7)	/* Info supports caps */
 #define VFIO_DEVICE_FLAGS_CDX	(1 << 8)	/* vfio-cdx device */
+#define VFIO_DEVICE_FLAGS_CXL	(1 << 9)	/* vfio-cxl device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 	__u32   cap_offset;	/* Offset within info struct of first cap */
@@ -503,6 +504,23 @@ struct vfio_region_info_cap_nvlink2_lnkspd {
 	__u32 __pad;
 };
 
+/*
+ * Geometry of a CXL Type-2 device's HDM decoder registers, so a VMM can place
+ * the trapped component register window where the guest expects it. The trapped
+ * region spans the whole HDM decoder block (every decoder), not just decoder 0:
+ * a VMM reads the decoder count and each decoder's committed base from the block
+ * itself. Additional trapped component capabilities, such as CXL RAS, are
+ * exposed as their own region subtypes rather than by extending this cap.
+ */
+#define VFIO_REGION_INFO_CAP_CXL_COMP_REGS	6
+
+struct vfio_region_info_cap_cxl_comp_regs {
+	struct vfio_info_cap_header header;
+	__u32 bar;
+	__u32 __resv;
+	__aligned_u64 offset;
+};
+
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
  *				    struct vfio_irq_info)
-- 
2.53.0

