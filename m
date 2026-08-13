Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88B442B35;
	Thu, 13 Aug 2026 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613957; cv=fail; b=ZkDNkSTk9BeiYpyExsQXst9s4ES1OIlGScf23E8kdq7vcCJ+twiPTOvNnvS7xtSfKRw5hh72Fnh04nctKosGABj0Us57XPss1iOs5TLjdaaHLTAnCZzv0i7xHJs/9Qlzk/lwzDzCJoCDtLkve4QWFkqRL9KI/XgdvVqkKJNCzXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613957; c=relaxed/simple;
	bh=UwVyGPEWnJmqtESU8aTiyT69/KTvgzAZVVH7ARZ9O4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1EH0hpTo93OvETsrigheFlVj8ZZC0/x2qLPCHVqvgjTgxGgb6o+QgUKC/YNumLSizqo6tkcSO9OQeaXBuyufC9q7bWLeDiyNwQkH/VLSw1X4jiwHO04P6udpx4Idq+KibHzC42eHuryP4FMOlxQLRL55oQz1dTBqVZ95pf2x9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qn9zUqx5; arc=fail smtp.client-ip=52.101.61.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qn9zUqx5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8FOjmsocLAHz2jeEguZkMImzanKviuS2eeDRk6d9QYalk69ieFZEfQxc8GXyNu/8zR9iBhZh4v1hU0DqQ3mMy1C0V9S/ttWy8L5+TG7og7Lb2+zo1h3t2dE5nyQVs9P9RNbbNBOJS/NHbCsM2t2wNoqLB5kpBSTi5IjpKOWEL1tqKUNBOhBtRHZoBG2Ff+XXRMVxLSIuuNGsZL4QRZbM9O78lqo2MP4Ud/3OMU1r1ZeT6KjFIHtLrhCy8rkvDLuYlFeuyxc26H7QwPnIZzsHbOCQKwid/80sQV9eaFoqS8smVGantznVAQwconXKkA2q6Au7Q2/lGT2eEFUhk/YbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGPq5kaNAlXsa+HQeqzUbQhWAcOcWwNYdQ6W5ee1Sts=;
 b=dmByjucKisMyJqkpyX401vPCKOJKYP/K9Qynkhrq5v1rU4DEGUSwtbJB8sBJfeHk4rGNb9VXq/AP1coXqOajtezXRDGnzEMwpUlOQl7koZHVGzcbSTiFgf88P5ZyfSpsvk5IaSlf9kARAZas8gpxaPLZJgdg0VUlUS4tS9pAh3ge0Bs3558bJ9eY4KEhyS1vyCiIhohx96aaEq7ED5FidS9Lozr+epGS2MVzlmM9UkPBrCQEFjRAcUxUV+WvJQTl8F+5ppzHIKgseqxooAR87++MKUH4b5xwqL1vt2mGgis4rrL+rogAUswOffpxmbegbDvBZQT4UPk4aPjMLk5vxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGPq5kaNAlXsa+HQeqzUbQhWAcOcWwNYdQ6W5ee1Sts=;
 b=qn9zUqx5gL5nJOTQlSUi9xwRfammAafHVDFfQ4AlkywMKWeJFtLqGSpTRb/jOuE5d3C0W4Ly6bMwjWM1nH2D5Lc4n8/EVi+O/1ptk3/zNZIJo3F2g/+4O6HSyo8sBvoIm7SEU7udowP6Kc/qr7Q2HhGYdZkxxmENDydU8PI800fQwxnXandCMfhFvAZ47Srq4rLLQF743jkvX6UiZ3HyFiXDfGxi2hrYFy0r2EHjT8uUq299BgpVXXfoEpi68eapg6ucsKP7fxKcq/tbCPcwNQaY+jbqIC6T8dwnUkua9btwDXa491B0Y+BFOAdPNNSiNg+l0v22SYMV/rTjh/6RMg==
Received: from SJ0PR03CA0228.namprd03.prod.outlook.com (2603:10b6:a03:39f::23)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 09:39:05 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::54) by SJ0PR03CA0228.outlook.office365.com
 (2603:10b6:a03:39f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:39:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:38:46 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:38:37 -0700
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
Subject: [PATCH v4 10/27] vfio/cxl: Reject unsupported decoder topologies at bind
Date: Thu, 13 Aug 2026 15:06:14 +0530
Message-ID: <20260813093631.2288172-11-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: eda7ff5f-a05f-41e4-3c01-08def91eb78c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|82310400026|1800799024|56012099006|10067099003|18002099003|22082099003|11063799006|5023799004|921020;
X-Microsoft-Antispam-Message-Info:
	/QYaafvywdx3gWLMuMIyA1OSlKabiAxaya5Wl+lNYPSJuu6/t9E1MnuQoIgc7/pJtXXzvKZrRRF0rcAbVToU4aliTZb+fUJ6NCfqQVTs+qvkYDdvTKyjyLrOAEXuvrE2IVbOfYTbotHEts8sNk2qgWEN3RXQJnz4eKzLcO8QJ8lm4jPQVkEnVsoK6QQiK++1BoEq2VNsIZTfTs0ZcGtSFSx+IMn9vij18Ht3Rq+vujO8ZGdem6yOmHBUzcnyc0PBNlRPfka+HOp/LrgWYk3o4i2+4yMKCaQ+EOdJD87n9Vqu556dos0XYBI5w65ps84GC27JTF89KsPrypKQiWALaxCCb1daHNASKRSTS2gqaCz3c5X1zKxZeZDEphIeb9ck1DZS+GngMnyZUfmsn6ICQo5T0KGzjJlQSWmYlvRJBg/8D2ZwlM8F7rLA9yEjwj0Px4TASTOk+0zLY3+jZUAyAI3cHY1xrZVT5Sb3aeXAo5xVa1n9LYPwQkMkty9T03iG+iUAvTVExK2IyiB04lC1KQHk/ilYvJfkKSYEPddoGbapdG7u5R3v9G11KyLlfZjqTNgu7+lLhVhPwOUOaKyov2PLiuwhX077v64enGoxVhqEfeKm6+gMKjSBOptlsDGmZa3P80TYB2xcAr7DZzRUXZLaNC98px8R6Jjjxr/tv3r12XUwF0wexLVL5EmTeAKn6sy8uineomlCc4QLuGBE0cATtrlPbfy+zQzm2rOZIRjdWKoXIopy7YsW3BEelPTK
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(5023799004)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uUAK7NJaUcuRuIvsJyg7iniNWR+aUCsWAsuMoXeFgSu751ZbNVmjEMYeT12tZhIi38GgUtrFywWv3Y03QUn01f4ogK6k1oRGfKPsDZX5yx94FLjpUNCQDDOI1JaKsjvdKkDyqCSIqE30st2N599u8qzD7x8HSWrSaaEhoFEjUEbYRgcIrShr72DmzwAj/a8Mvp/4cggxDIBYOKQcHs1A1MRKqPYYJzWo86ToU4BGV41jk6dDL/cTMVgkln0B7GPjsvuxtvX1X7JakIzAlEbMUrIlwq87vwOt8KLbZyBi39N9+3IIm/rE3VXi2yaD3lBAJnD/mSBfEjb3qJK4qzY+AuTsD5Co0Ifhp04QqZuj+e2NULnzWNJAFCGgoNhopgIoB2vnAuOTP+HZeVom4Q1MPMOtHs3sTx50jufVXK37jeVTryPL76f0uSvQW4aMhiTw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:39:05.5417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda7ff5f-a05f-41e4-3c01-08def91eb78c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949

From: Manish Honap <mhonap@nvidia.com>

The guest drives a single virtual decoder whose memory maps 1:1, so a
device with more than one HDM decoder, or an interleaved one, cannot be
represented. Turn that assumption into an explicit refusal at bind rather
than a silent misprogramming later.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 125e11354a46..7edc53b25576 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -36,10 +36,30 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 	if (!pdev->hdm)
 		return -EPROBE_DEFER;
 
+	/* The guest drives one virtual decoder; multiple are unsupported. */
+	if (pdev->hdm->decoder_count != 1)
+		return -EOPNOTSUPP;
+
 	hdm_size = range_len(&pdev->hdm->settings[0].hpa_range);
 	if (!hdm_size)
 		return -ENXIO;
 
+	/* Interleaved decoders are unsupported. */
+	if (pdev->hdm->settings[0].interleave_ways != 1)
+		return -EOPNOTSUPP;
+
+	/*
+	 * The guest drives resets through the CXL Device DVSEC and polls the
+	 * shadow for completion. If the host cannot service a function-scoped
+	 * CXL reset (no reset DVSEC, a multifunction device, or no HDM reset
+	 * support), that guest request could never complete, so refuse the
+	 * device rather than advertise a reset the guest would poll on forever.
+	 */
+	if (!cxl_reset_capable(pdev)) {
+		pci_err(pdev, "vfio-cxl: Unsupported device: host cannot service a CXL reset request\n");
+		return -EOPNOTSUPP;
+	}
+
 	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
 					  PCI_DVSEC_CXL_DEVICE);
 	serial = pci_get_dsn(pdev);
-- 
2.25.1

