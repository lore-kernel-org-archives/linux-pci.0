Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493139;
	b=Kf8LiMZhPIfF+BLCzTN5HmzsSrnRpAJOFCjAsLuehGayiUt/weVvS8UCFHUT6vKe3E0g
	 qIOhhRgf45bdqki/cs1tWGskHZL3tNx30mdtcVkNm8Ih0k0qVUiPKgJcWRq0lBr7VvU/8
	 7kQ9dzmSChLGUMRBREimgibm+mgjYMPC6nNfTbuWtycdl8egXwTyen3KNBzLoPr+u/Xm4
	 gyeeljttTC1cTjeOnkOvjuOvFX7TLA8/C+dEpN+Mz/LNHUw7y64wpBYinzM6C4d7I7yzk
	 8jhk3sRCJZnSD1wud+8RsvRIXh+wpxNPAG7lP1Bz4B1O2sB96iMzUYBAMCH/vvSphjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493139;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0/OZ+GfsHLp6O65AJGBvR3rhF97dKhoVy53LHWAStS4=;
	b=UMItMibUMhSde4whVX5WdBKaeC0dBpUsEDoAK9b09DO2gA7XxlXNQbPK6/JnTpzxZNUX
	 lHk0uA7qg7rb5ZvUPoJSJ2gANM4SaDxc5+v1xeMskda3/lH8yVfoTVS4HOzE+LVYKb4jC
	 9WHiv/VjZTz9bsorvREU7aJV4lFXEZwNS8wfMNkL52BZRf3Nt6zNU0ue29Ji1eli1z9et
	 uToweLuUMrC9mLpXU0N2zdQXVWN0DpFqskQX2QBSqLqkJeV4VPgffrTFV97VUoMfSjyn6
	 mAQuH5sEjGItJgUj7VHWdIxt7CbZJ7W/dYOMe9ZX+u8+Ev/vAabwt/uDzPSs5EEMtWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q4BKzY48;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.66
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE9606D54D;
	Thu, 12 Nov 2026 14:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04FE9606D54D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q4BKzY48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwQOh6yo1zaasbZrtX9oDv6yxTSTz4XTl5OPD3Ezgugtuspx7PI+nsaZytFmLrkg+EQKqfOaoC8OBi5tjm2PcTxLLEAYcWcUNrQ04+1wcQ1WDTCQAwrEq413OwIyVMYJ6QdS7049i/vzVARuGaoLkNciZ1SmjjYZI79N8UwL0yyGffgZn2j3bVvtjGwMjQSeLc4B1NHJZM5IT9CU6GBrjvCGf0r4aqZZdQQk+Hlhwzexss+ndpiXogwmo7v5IH3ScL8KSY5ZClnEHZTPEfSCpIZAQB9KGciOViDTfhPHP3Nr+dT6rZR/jqoCydX4Vde2kRbLjmUgF3XaWmD3vGcCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/OZ+GfsHLp6O65AJGBvR3rhF97dKhoVy53LHWAStS4=;
 b=iVXhQ5VIWIyPPd7xGxrdI+bYBq59/8zFOpGDFmmBi/KWCwuh7HUCokCMqBFG7tJ0r0Sr3I4dojXgS8xv0SWXNKNRLukm3CjEf1QGl0msFuUcZrkiGWzza1VvIX7c4xx8PKMrAZEGwxXkIxt8sbgJqc9gWl3jXPgDSHLOJRbvwuQ6sxVRsgnDlBfV2rfYh63p8o096FArvkXQ0sW9tMie7waQggdRI2uvUOwYKb3SJQ0P3KPMt77gS9Y84dC1ylT1oKhfxJAVeA7+ejBQ8QTguq6UrmvfFVYdrt/LtLHg0TY0HjnQ26nclNYIbNHGdH0hnFnUFp4nvkGZqxXRGVFiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/OZ+GfsHLp6O65AJGBvR3rhF97dKhoVy53LHWAStS4=;
 b=q4BKzY48xvoFzGvwEVnkmFolv/Xak5Py+v1QQgHjOtWU8GvtqWUZkJJ4quDlenEkKLm8cgsuhvD0nn3qY1ppn+J7N3CBFb9KLR+fbpltJ3kTTfkuLI0qhEAb01cbAwStsNg35c83ethlMHroqz/ltlHC4FPbyXIOjfsDNpooHjEr8LVoSZaLr9xV5AcCOrot+QuUUFMn0XiLjubGK87dQ5MPhVUde28j04kHgfRV3A0DxuS82mC7KGMdBZrqLtoRRpwAB/6vJiwdqTU7KZ4/OEyegE1p9MZOFWdfhEymzZy78HvFDAZ7VUAhZGJSWBrRR3ZjVOa5Tcu+ApCK2609ew==
Received: from SJ0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:2c0::25)
 by IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:18:50 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::92) by SJ0PR13CA0020.outlook.office365.com
 (2603:10b6:a03:2c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Thu, 12
 Nov 2026 14:18:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:28 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:25 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 12/20] vfio/pci: Use access ops for DMA-BUF export and restoration
Date: Thu, 12 Nov 2026 14:16:24 +0000
Message-ID: <20261112141632.918954-13-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112141632.918954-1-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|IA1PR12MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 66223634-a1fc-410f-578c-08df40c7df8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003|261102123227099003|261102130727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZnBPY4Pvplo86Mo3oFk3AmTB1HIpIpnxaTC841emHn+xbU5+z1x9dL54jGFIX8ZiSP/dzxl6k1zE4ilKiAiAZeFIg4Iq98Ck5SNBR86/yj8M2yMrHnwNmPdp19dJypYvYt4Xmn45Y/Yco2g43NKgbFFqzA+rjyfIUyIDKScRhSD+8WJvxIi+OTVNcksWt670mey4iVZNT7HjKwx/rHkKhlw+36DMPwknKziwUQ3SgPSiegEI8ViTd1tdMtCP2N920EGza5ySJCBzsN3FE1GU7+X8RKjW9Xf01yNXW+ia0fhPkiAQmNl/9+CIzcIPSiraI/PawDm9HwyZsURzHQVXfHo+ImxmcJKw5nXpoL+VWlzv+VW/psj5OBlqqKFUKxlDQlGh9kf5GeOQ5hPYSNy3pW3ICRu12Z28r2+fchQR+pOYo9/CxEv5xeX5fnxOdlWe5xeHt44AVLmzyJuOhnE+UnEBzuoHMNLz5pmYgiEH8l//H7f8feuOO+u1EuhOB82qw+7Ge8GhZARTd8gSYQWXcYmYCMQ40yJ++4GRu4HiO5Cd0n53Est7ti0X35i6UIz9TsjF5Ym2sZIAT4clRwcGVDE+o1RILTR5Z1rIlZ3ZE3tzrrnMEhGOIlap0c5D26XpKcR+WMGxlaS/8Gmler+5LX1pHFQVJpgaJ1eoIFLH8uRPPPOPORnhpSSN5q7QjVBnAk1XnHN8bsFp+/o0YuCHbg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003)(261102123227099003)(261102130727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gZnfg/X05pwvBiPkNxwd2eavYf+vHsJDaiCSJCCyaFmVNu83UrOrEYRQ/WCR7quIlbUtykWGq/zdzJKHljU6AQbnOd2FdGe30RUI75iDtpoabGLFUBInghDZ0v/JtdsZEoJjnKwZdjv+hQ+xV9UEakd29me2u2aqifxZ6zvvQVPd1AatDjwhcjcxaMxMHPjg9Y08X4h9iPDqTcT+w2FISHd6Oc7BiLtKHftZrQXOpi9WkJkxTbkpmoCOLgJkStBcUG8JCaeIs8unxBzAHHTSFPrM9A4xOoFxfH/mcUS6xzNuZ/sbViviKGGcRnw296eUuq3WhD/K7m+A5fvOyUUvT/0+LatZuLSO+xUQzewkPu8vWi6fyuIFpcdcPFsYYcEFKMJdn+uGCS6l4gvO2R9qopePToh/RleBSgZFDw8ZaxGhiQpCMN1uKPCts1lRsK6S
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:50.2887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66223634-a1fc-410f-578c-08df40c7df8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222

DMA-BUF export can race with recovery revoking device mappings.

Keep the range lookup, export and list insertion inside SRCU so recovery
waits for admitted exports before revoking mappings. Keep userspace
copies and file descriptor installation outside SRCU.

Select ordinary mapping restoration through access ops under
memory_lock. Skip restoration while access is blocked. Provide an
internal helper so recovery can restore mappings before allowing access
again. Revocation remains available while access is blocked.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_priv.h   |   8 ++
 drivers/vfio/pci/vfio_pci_core.c   |   6 ++
 drivers/vfio/pci/vfio_pci_dmabuf.c | 113 +++++++++++++++++++----------
 3 files changed, 89 insertions(+), 38 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 0ea7c710dc38..b02fd1fbcd31 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -90,6 +90,8 @@ struct vfio_pci_access_ops {
 			vfio_pci_access_fn fn, void *data);
 	/* Caller holds memory_lock. */
 	int (*set_power_state)(struct vfio_pci_core_device *vdev, pci_power_t state);
+	/* Caller holds memory_lock. */
+	void (*restore_dmabufs)(struct vfio_pci_core_device *vdev);
 };
 
 const struct vfio_pci_access_ops *
@@ -151,6 +153,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  size_t argsz);
 void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
+void vfio_pci_dma_buf_restore(struct vfio_pci_core_device *vdev);
 #else
 static inline int
 vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
@@ -162,6 +165,11 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 {
 }
+
+static inline void vfio_pci_dma_buf_restore(struct vfio_pci_core_device *vdev)
+{
+}
+
 static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
 					 bool revoked)
 {
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index da7166669dc7..0299f5afca91 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -330,14 +330,20 @@ static int vfio_pci_power_blocked(struct vfio_pci_core_device *vdev,
 	return -EIO;
 }
 
+static void vfio_pci_restore_dmabufs_blocked(struct vfio_pci_core_device *vdev)
+{
+}
+
 static const struct vfio_pci_access_ops vfio_pci_live_ops = {
 	.execute = vfio_pci_access_live,
 	.set_power_state = vfio_pci_try_set_power_state,
+	.restore_dmabufs = vfio_pci_dma_buf_restore,
 };
 
 static const struct vfio_pci_access_ops vfio_pci_blocked_ops = {
 	.execute = vfio_pci_access_blocked,
 	.set_power_state = vfio_pci_power_blocked,
+	.restore_dmabufs = vfio_pci_restore_dmabufs_blocked,
 };
 
 /*
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..a9db011f0c06 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -218,14 +218,67 @@ static int validate_dmabuf_input(struct vfio_device_feature_dma_buf *dma_buf,
 	return 0;
 }
 
+struct vfio_pci_dmabuf_access {
+	struct vfio_pci_dma_buf *priv;
+	struct vfio_device_feature_dma_buf *get_dma_buf;
+	struct vfio_region_dma_range *dma_ranges;
+};
+
+static long vfio_pci_access_dmabuf(struct vfio_pci_core_device *vdev, void *data)
+{
+	struct vfio_pci_dmabuf_access *access = data;
+	struct vfio_pci_dma_buf *priv = access->priv;
+	struct vfio_region_dma_range *dma_ranges = access->dma_ranges;
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	int ret;
+
+	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
+					     access->get_dma_buf->region_index,
+					     priv->phys_vec, dma_ranges,
+					     priv->nr_ranges);
+	if (ret)
+		return ret;
+
+	if (!vfio_device_try_get_registration(&vdev->vdev))
+		return -ENODEV;
+
+	exp_info.ops = &vfio_pci_dmabuf_ops;
+	exp_info.size = priv->size;
+	exp_info.flags = access->get_dma_buf->open_flags;
+	exp_info.priv = priv;
+
+	priv->dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(priv->dmabuf)) {
+		ret = PTR_ERR(priv->dmabuf);
+		goto err_dev_put;
+	}
+
+	kref_init(&priv->kref);
+	init_completion(&priv->comp);
+
+	/* dma_buf_put() now frees priv */
+	INIT_LIST_HEAD(&priv->dmabufs_elm);
+	down_write(&vdev->memory_lock);
+	dma_resv_lock(priv->dmabuf->resv, NULL);
+	priv->revoked = !__vfio_pci_memory_enabled(vdev);
+	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
+	dma_resv_unlock(priv->dmabuf->resv);
+	up_write(&vdev->memory_lock);
+	return 0;
+
+err_dev_put:
+	vfio_device_put_registration(&vdev->vdev);
+	return ret;
+}
+
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
 				  size_t argsz)
 {
 	struct vfio_device_feature_dma_buf get_dma_buf = {};
 	struct vfio_region_dma_range *dma_ranges;
-	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct vfio_pci_dma_buf *priv;
+	struct vfio_pci_dmabuf_access access;
 	size_t length;
 	int ret;
 
@@ -274,43 +327,14 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	priv->vdev = vdev;
 	priv->nr_ranges = get_dma_buf.nr_ranges;
 	priv->size = length;
-	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
-					     get_dma_buf.region_index,
-					     priv->phys_vec, dma_ranges,
-					     priv->nr_ranges);
+
+	access.priv = priv;
+	access.get_dma_buf = &get_dma_buf;
+	access.dma_ranges = dma_ranges;
+	ret = vfio_pci_core_access(vdev, vfio_pci_access_dmabuf, &access);
 	if (ret)
 		goto err_free_phys;
-
 	kfree(dma_ranges);
-	dma_ranges = NULL;
-
-	if (!vfio_device_try_get_registration(&vdev->vdev)) {
-		ret = -ENODEV;
-		goto err_free_phys;
-	}
-
-	exp_info.ops = &vfio_pci_dmabuf_ops;
-	exp_info.size = priv->size;
-	exp_info.flags = get_dma_buf.open_flags;
-	exp_info.priv = priv;
-
-	priv->dmabuf = dma_buf_export(&exp_info);
-	if (IS_ERR(priv->dmabuf)) {
-		ret = PTR_ERR(priv->dmabuf);
-		goto err_dev_put;
-	}
-
-	kref_init(&priv->kref);
-	init_completion(&priv->comp);
-
-	/* dma_buf_put() now frees priv */
-	INIT_LIST_HEAD(&priv->dmabufs_elm);
-	down_write(&vdev->memory_lock);
-	dma_resv_lock(priv->dmabuf->resv, NULL);
-	priv->revoked = !__vfio_pci_memory_enabled(vdev);
-	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
-	dma_resv_unlock(priv->dmabuf->resv);
-	up_write(&vdev->memory_lock);
 
 	/*
 	 * dma_buf_fd() consumes the reference, when the file closes the dmabuf
@@ -322,8 +346,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 
 	return ret;
 
-err_dev_put:
-	vfio_device_put_registration(&vdev->vdev);
 err_free_phys:
 	kfree(priv->phys_vec);
 err_free_priv:
@@ -333,7 +355,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	return ret;
 }
 
-void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
+static void __vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 {
 	struct vfio_pci_dma_buf *priv;
 	struct vfio_pci_dma_buf *tmp;
@@ -404,3 +426,18 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 	}
 	up_write(&vdev->memory_lock);
 }
+
+/* Recovery may restore mappings while ordinary access is blocked. */
+void vfio_pci_dma_buf_restore(struct vfio_pci_core_device *vdev)
+{
+	__vfio_pci_dma_buf_move(vdev, false);
+}
+
+void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
+{
+	lockdep_assert_held_write(&vdev->memory_lock);
+	if (revoked)
+		__vfio_pci_dma_buf_move(vdev, true);
+	else
+		vfio_pci_access_ops(vdev)->restore_dmabufs(vdev);
+}
-- 
2.43.0

