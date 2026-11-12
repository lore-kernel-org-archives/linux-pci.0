Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493129;
	b=3ohBUAQJgsM7c16sDPeDdkCcZTfK4HJeK6CilXQjAzlZyr1pshBCRihRaZtMne86mpiB
	 IZcvnQwFAKeVumOFRWj4exiI9J31E6ISPPxwJKG4W+qfDRQMwlABCHTfibFNMvPuRsRZn
	 6oe91uFdxB+taagURfKVSkLWXHmUU4Z/YMkOhRmneQ7MFW05iLmYhuFWuPZYrdZUbStS2
	 BHgRKra7dvA3R0g2SEPH1+rNfr4j1TI3CUIMC3faK6xxm+oIYGX3c2wPjab3ftHmfcpOQ
	 BISO+Rts94Nwsn2qmjuDCMyh4zUfJMdW51MGxb1CgJYiDFwbwQVmu//4VORRfxLhBjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493129;
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
	bh=67Fq/5L7ge1CUV7dGt9buYrXwDE18g0h7QAERm2fteE=;
	b=JCU92WDX4peVnXoYVWlu7wQ7fzHKQxSPfxciRKV/i6YZ6J3N6aftNMOsvNGugB2v+Px4
	 akx0alMao+B6pzmq27r8NwBjH30de6dUOsS53j73xQt7LNnyBqELlJJ6AuPp23/qV0CkL
	 y2Kj3rhiTFxSJjYbu0V9pvbjU/y1wWfttaoAmCzcq2oJTrtZ0wKna7Szih9HyX4cOvTfc
	 VNKfGbHs8O8jAHIey8/lEk398SvAu4twmGTKs8WWlzmL6Q8Z0tFSP7znFCenVEP8zqdI6
	 1AKnUbIXG35z93hMxshVzHHy893A06HXcL9d5cdWa+kCcqpvCwZc0KKwkkiiFkp1EEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z+oXeAmn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.27
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC84606D54D;
	Thu, 12 Nov 2026 14:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CC84606D54D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z+oXeAmn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJujA5eZMxD5raBcTWmzrlZddx5kWZhr+RQiqytajN8za8kdjbC37xGHrIbB6VNIjnaxa//rd/uPodKxYviJTXDMEu/9eQrFcouwJUHGbQRQqmMgU1LhJJtyENHYIn0RHe6Vq8R2G2GnrdAMLAe4n1BalfJbjRnz9yPZUrYk6NbnuDiCEz7ggwLRJhAvL6gcka+43cI6EX1IwvR1bDcopMnK52BJ/ci9IwHR8UPLQn4BrHU1Y7a4NaFaUooBqhOEXMRVo7gXY45JAF58xv9Zx4uR7ZXTRvlaVWAz2/6qEqHjJvdjHYSXigbDvbN0HvxNzkstM1kXaa5IuTgDMmVvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67Fq/5L7ge1CUV7dGt9buYrXwDE18g0h7QAERm2fteE=;
 b=ivaIUSzFM41P4J2XeNK7hHwjvaP1ioopP5tBvED6/Kpdle9Fvwjk5J2l7tF0VClD2pjQw9d8ildkGDX+xzcxUADX87lloguHPATFXwNohvIW85tCV/hIVRGmRYwSRTSY7q1VoXOt+lQzVG6/THM0RzzTkBhJ4W5XxapAnjkcpGvNWUb14XaEpFOBbkxNqdheV1kAY/ro9fF6NKdkgJVF/YeLrQpKlLustsKjg/lcrHmi7PNYOT47Ce9wYMT+wCXAR0WTg7h1Sb+6oXeeN7wUzI9C7ld/xwHwjqw+DmH6P/ICZwTjkDnzzK+zbLgwkaF1r+70UGmtXgiAiWwZ8Y7zFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67Fq/5L7ge1CUV7dGt9buYrXwDE18g0h7QAERm2fteE=;
 b=Z+oXeAmnKyBwd0SM5xUmAA3PH373wdPnADoFeqKKHaDlGkY8wfHWe4O3+xakpwRxwRnyQ0pH7mI+8hvUgByjEWTzrlLvzKKRHHr+6YPTvuiyBPSkQCTNsFu75Lpi34Kz2g7jiAP5rCbiLfBequ4o0xNGMD9TaBcxOiy2NhcWn7h5jJbpfa/cc9MbNwy/LDe8rIzQRAADQarJ9OrikZA/JtFmH880A+vBF0yqYPtRvGCp/kRCf5wFWdkqSzbItJ7+oE7V53F+XS+6aQHh/yzEvFOI4VZ3gu/UpFjgzO/Q1a9vD2ohionY3K2aLaX+nNrWGJ0c7InNCfXcFoZhiX9w/A==
Received: from PH7P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::22)
 by LV1PR12MB028288.namprd12.prod.outlook.com (2603:10b6:408:515::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:18:45 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:510:326:cafe::61) by PH7P220CA0005.outlook.office365.com
 (2603:10b6:510:326::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 14:18:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:20 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:17 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 10/20] vfio/pci: Use access ops for runtime-PM requests
Date: Thu, 12 Nov 2026 14:16:22 +0000
Message-ID: <20261112141632.918954-11-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|LV1PR12MB028288:EE_
X-MS-Office365-Filtering-Correlation-Id: cd257e8a-ebef-4e76-7e43-08df40c7dc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eYU1UHsvW1sAs1LkvMT5oAz1Yui2qi/3TO+3/1UCxxqjBj22nS3gRZR8Kq/u84DG2aBbhjB/5tV8DPOA1qU00lCBxC/n3NYjp7iD5SUITKSkne4XyR2iTptId7ZaSeTRvez6DO0rUhFi8uc0SYNiU1ykViTecz+AM2rdeNzKKkkJ/5I2hNZ+Jgn44Y+rXHYMDc+ms5VBJ12lSWjX6jSknvaZvgKBFS1gYKgGzIXOiZHJUgVfhF/tR3gzVyXaZOPxtnMg+UItOisre6H2dluVVlNA/xKLBaVLl/uHcJ8z6aF2zaWT93YQOkhep7JE0OT7GrexfI8xFYSbPwnEMtIaHwZEgu9YOSFc8WZU1oZTEOKUbL5azeZfJ6I9l/LiJvprrEIxkX0LPW5bBr08L3KBfk9hBBGgDGchxRG5CL7T5Mrn4UWsJ/2waw9S8AkMqYN2MFurz7O4khGoKBRFMHRkmkl1fu+jz7/DliO/+5jypLbeAMVaeldsskdq2jrHS6yk5OdHRjxqM55rmu96aXSBx+7W0C6J42Qb45XVAv9eDrlXyw/7swC9SVSZrE9yXYhCMIqIWa2aNl5UFADZbPwxSqNE5Db6BCSqmAl8Wlh0PQ+jiCqipbjVrmUmJSs/NnGo92ejzyYBbw5FaswAWfobHB98xq4L4UoOgZZrkPi6X86w8wS5/fXzAg7fhy1zK6eenbfUsAEGRnrI+abBi/2DZQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AFgGOnyuQhH0uSlQ/MsK6ihdigp8P9H/puLZUBPSgRI2xnR7If631PgG9zA87k1Ik132Ncnn+6p0g5Kmwf8wrjwN8I+3vCC+12AtsYDYxeCzPFEuHEo9Rv1QEJV+dgL+x51Os83OWg5j3NDzetH41+6h5IjYsoSD1jlEg2qU/5YmKWE/8gasP+s0XwYZVsIxMw8EQ+cST/Jeea4soS3wrU+CCZiOTCa1XbmV8zys1gG88rLVHfxwAqyAx/bmrIF6JZAezayVRhNB8formi6ZATY0QJ/LofpK6R8Ql1v1UkiRiYmwreQiyDfjDc9E63ZTONmqBm8VR52/vF/UEiqdAuTAitLAXYMeeHvt/js6pIMo01/7zcWsnKwitcp0q8L6dAG9yFXwi5fYmMgKt4n8MHqOhe0MAQcbGbWMc48giyRPF7Ol3Q3xic3dxd0sXibo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:44.4662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd257e8a-ebef-4e76-7e43-08df40c7dc16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB028288

Userspace low-power requests change PM references and device mappings.
Run these requests through access ops so recovery can reject new
requests and drain admitted operations.

Validate userspace arguments and obtain the eventfd reference before
entering SRCU. Release the reference if entry fails. Keep the existing
memory_lock protection and PM reference handling.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fb7f46c2ca36..fc6b2673be88 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -454,9 +454,11 @@ int vfio_pci_try_set_power_state(struct vfio_pci_core_device *vdev,
 					pci_set_power_state);
 }
 
-static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
-				     struct eventfd_ctx *efdctx)
+static long vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
+				      void *data)
 {
+	struct eventfd_ctx *efdctx = data;
+
 	/*
 	 * The vdev power related flags are protected with 'memory_lock'
 	 * semaphore.
@@ -492,7 +494,7 @@ static int vfio_pci_core_pm_entry(struct vfio_pci_core_device *vdev, u32 flags,
 	 * while returning from the ioctl and then the device can go into
 	 * runtime suspended state.
 	 */
-	return vfio_pci_runtime_pm_entry(vdev, NULL);
+	return vfio_pci_core_access(vdev, vfio_pci_runtime_pm_entry, NULL);
 }
 
 static int vfio_pci_core_pm_entry_with_wakeup(
@@ -519,7 +521,7 @@ static int vfio_pci_core_pm_entry_with_wakeup(
 	if (IS_ERR(efdctx))
 		return PTR_ERR(efdctx);
 
-	ret = vfio_pci_runtime_pm_entry(vdev, efdctx);
+	ret = vfio_pci_core_access(vdev, vfio_pci_runtime_pm_entry, efdctx);
 	if (ret)
 		eventfd_ctx_put(efdctx);
 
@@ -552,6 +554,13 @@ static void vfio_pci_runtime_pm_exit(struct vfio_pci_core_device *vdev)
 	up_write(&vdev->memory_lock);
 }
 
+static long vfio_pci_access_pm_exit(struct vfio_pci_core_device *vdev,
+				    void *data)
+{
+	vfio_pci_runtime_pm_exit(vdev);
+	return 0;
+}
+
 static int vfio_pci_core_pm_exit(struct vfio_pci_core_device *vdev, u32 flags,
 				 void __user *arg, size_t argsz)
 {
@@ -568,8 +577,7 @@ static int vfio_pci_core_pm_exit(struct vfio_pci_core_device *vdev, u32 flags,
 	 * already signaled the eventfd and exited low power mode itself.
 	 * pm_runtime_engaged protects the redundant call here.
 	 */
-	vfio_pci_runtime_pm_exit(vdev);
-	return 0;
+	return vfio_pci_core_access(vdev, vfio_pci_access_pm_exit, NULL);
 }
 
 #ifdef CONFIG_PM
-- 
2.43.0

