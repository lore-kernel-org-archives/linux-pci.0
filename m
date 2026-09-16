Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1374DA9A3;
	Wed, 16 Sep 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584037; cv=fail; b=MIF4hgNSDWzvkUUu6fY2vKUF64KRfHithq6IVj219XiO/Mek+qp+iK6/pZ+/tX8IfFZGSYBWQeVy72vWzEH5lVim202U7au5bAMpNWRyCNfKoTH/MxzFLxlQuT008j8AZ6SVK6vY1ZIP+xjihTYGdVcV9IvflCx5nltNUYnBDew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584037; c=relaxed/simple;
	bh=e4vFf+RfOUbiZnHmpI510UCsOC6IeLXV+PxZZM9zmiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8CjapVnu5oipAHnw/7QeOQJZ5l07UZMQc/8dIzyEF56vDzZu2T+XkMgHHgmOHQAzY78kTrjr62B5frnBzAEsghxkR5XRlQAD411l8i7PsX/8HDl1M9C7PVtz/Flm1cGLt9GzYckb0pOWSHeFmTSdHFNunauqpwB+otd1JuyN20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bz3qTUQk; arc=fail smtp.client-ip=52.101.48.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bz3qTUQk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHcVZXeZ2JEQGQ/VoITrNBmpPI3iUZvgFrXRcV6b/ihZMwmV+Bzi5MZMYt0lEFnBO16zXyIXZdoPrD5K0BFPWlfOuK+HdFC1c5i0D4Q5MZ6CQ/5Z5/UlelubSWBkVRHXvpHTz/XpZSqrQLr3igt46gau2xWT5hIM5MOqyGdqPbow0OstS3XyhB5xWZ2oBoTYF5SKivjJCVVDZtpeBAn4zdgY0XvDICTPyCEVMDMXj2j6Yt/StsAh/H0g57dIcrsZfvdm0ZRnKwIzw237xqx86Wx9CNYcKg+Y5nuM5b7fiyERVtwweNnPqU6OwITUHO5rzKv/ymTC+0lBZssJnLL7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg3xIkb2nnm4LVzwL1pIoA3t/kVOkG/kv5FPBj1KBzc=;
 b=UtFz8xNGpOplcIFuza/nmj+fYCEoqKy93yEiuOx7lUiZhDSvBbVyxLGwLVgtft0R/2Z8GVbIKEDhb4Hwt1CAREohgMB832u518icNA9Hne1BFF5y8kKFt1rs8zNEdLVwnuWBDtA2m+FDKAAHaIeKCMSYZtBBg6IwHus0qc+ZjQV1aaSyuqlw2jQU0luAzlRCrPq/AOOdHLbPO3gNni/XtLTcWd2oE+fk1W9FpYvzm4AWDSakV4ijk4/rQYxC1A9b6lRUd4OAhUyFOGVjwVnBQtTghCuSC4dO+iVR6jYzlHMYf/WuiHdlJFsWs1X64ElZNoFvaK2NSz4NNqK2e3swyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg3xIkb2nnm4LVzwL1pIoA3t/kVOkG/kv5FPBj1KBzc=;
 b=bz3qTUQkb2KzcG+/XRCysDpAbe27/2OZENyy0cQe2uDk71nQgg2q3jS+tagUpqD1SHEpuuk0GQDbkTI6CNKK86Gq0A2K/W6k2WrKLwDFbEH/wPpjlnBF7YYDzccJNDlwOaxJvcuP9Su64lT6sxHlLEqioAglEZ5TxguWi67THw93TpshCe/LKjcCYhdvUF1k+HAydgMAxhxDE9inVWsb1M4Lr1z5RUeWxz/zI4hxrUqIWtF71fp+6v8pd/DDju5VP9MBU8UfxHmh2Y4tNpk5VorqCdFVNjc3DQuSYNa/RYhaQHNYpbbWi5wAQ6sqwU3prPwaZGNgeCUy3Z2Fs85uhA==
Received: from BN0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:408:e7::24)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:39:57 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::5) by BN0PR03CA0049.outlook.office365.com
 (2603:10b6:408:e7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:39:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:39:21 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:39:12 -0700
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
Subject: [PATCH v5 21/27] vfio/cxl: Exclude the HDM decoder registers from direct BAR access
Date: Thu, 17 Sep 2026 00:05:34 +0530
Message-ID: <20260916183540.3813685-22-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 21805d9f-38f2-490e-20ab-08df1421e7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|11063799006|56012099006|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s6bgOpCpYhbzjZKV/TvG+cOeGgDe9Em3bTEHMRhaqxcfmab9ucmiNJSHkoEvGjQnaXePsinYjiRb9CJFJIN2Y3KS78q21CxSws496Qkluyc3/SCRvBX9UB0aksEKZv5wVE6+OUe7ehCwNmFGmG//wfWfnEmFq/QnGfpE79rZCzWeywbDpAAN7txTq5uCly2pOYdsU/8FWQT+3RMf5ALA+DvMohRIpXigea9iTHhAbQovBSGRTDTepJh7hQLRg81coLucQBelyuDSwceVR5NkLRLXw8vkDgO11wL520vtOWtZqDvtYXeUoiqwDpy3e8f5XBYwiH2yVKHTQ0xxl+/zecUwoK5EM5J3WaMh4uXhB1k/4e958ZEty/I/OYh53zM2K3jD1AhjvyKWdWmh0bc4bXj2OfP/ZJBhyKOPVcjhNtfNzisljBJRiwhvz+IIj1ZaX1iUO+6AvM1xxhqV0bwhaNayB4HPZB3speP7Hhd4Q1GEYgHWggmEK7ApBazmmkflJmOOFhyROw+ylGrzIG+TqzhJ3uRsFYROULiuvEBUOLtdseA7Bs4M42bBKqoeICaKPZo0TiQzlgGDImS+q7uB+HQA4cHcZs0Oey6MZ3sEDOVgMeymhpuT2xvBDP+u8D+1My/H+9g+dzJ+1VV4bqjVgwrLF9WVha8IElLSzJZO9D/3ShjpR7Wqar748/jWLnzw60jqncFiA5XXEUwG5TdxTYR9VtHZEapB4z7Ik92SJPovaW/hALXUrk/dRDAR4Ugd
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YDRUhhLGSGfYXFF/MCK2Wep9Ztd6qPuXBOJ0lskKsoVKY7kgTa6S3WYo86V1w+Qnl4Hpoy8DVGazQHpUERQT7PUHV/680nb7F7t9lo8zRuA7K9g3zcTVPKS8pZQ+2G++HxNMCjMIzmT87v3uFk8+GoeCASdZhj77iRbVWgKJYsuRAGHT9QYb6nFYxsUTWQTXNAkQNQF2fMvNGKYp2gJSrCaA9CS5M41ArF6SmB+Hn9sTPakV8lYDCRqdO8tokZHa8B3IqNeWFfilXfCzwvs/cjw4HYFHH79Dngl/kOFKYtEocXKyBTvtSo83/u95ATnZ0fRxHAUrXblhN8kH2F2ocTjaqioCqYd3NljqdlMMzIk2fFc3FWmmm85Fxijgk/ZNTkw+KzfKoNE/2a3KJGutptiTV/3ow0vxzrQGfW1Ur2iis8jgPa8jf6WwUlCOCBe0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:39:56.5777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21805d9f-38f2-490e-20ab-08df1421e7f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661

From: Manish Honap <mhonap@nvidia.com>

The HDM decoder register block lives in the component BAR that vfio-pci
owns. The guest reads the decoder only through the trapped, read-only
decoder region; it must not reach the physical registers through the BAR
directly, and a host read of the range through a kernel mapping could
abort as a fatal host SError.

Add the block to the generic excluded-range list with
VFIO_PCI_EXCLUDE_MMAP | VFIO_PCI_EXCLUDE_READ | VFIO_PCI_EXCLUDE_WRITE
similar to the MSI-X exclusion.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index da04776356e4..37e8a3b54cfb 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -435,8 +435,25 @@ static int vfio_cxl_add_region(struct vfio_pci_core_device *vdev, u32 subtype,
 static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct vfio_cxl_state *cxl = vdev->cxl;
+	struct pci_dev *pdev = vdev->pdev;
 	int ret;
 
+	/*
+	 * Keep the HDM decoder block out of the guest's direct BAR access: the
+	 * guest reaches it only through the trapped decoder region, and a host
+	 * read of the range through a kernel mapping could abort as an SError.
+	 * Exclude it from mmap, fill reads with -1 and drop writes. The list is
+	 * cleared on close, so re-add it per open.
+	 */
+	ret = vfio_pci_core_add_excluded_range(vdev, pdev->hdm->hdm_bar,
+					       pdev->hdm->hdm_offset,
+					       cxl->hdm_len,
+					       VFIO_PCI_EXCLUDE_MMAP |
+					       VFIO_PCI_EXCLUDE_READ |
+					       VFIO_PCI_EXCLUDE_WRITE);
+	if (ret)
+		return ret;
+
 	/*
 	 * vfio_pci_core_disable() frees all dynamic regions on close, so register
 	 * them here per open rather than at bind. A failed first open never
-- 
2.25.1

