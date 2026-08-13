Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013055.outbound.protection.outlook.com [40.93.196.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E113446847;
	Thu, 13 Aug 2026 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613975; cv=fail; b=gko57uiFFUWUwGKiV0jU7mTZXY0wkIcCNRiEv1HvZ6nHUQJFK20iWXgROFczGO/5fYGwP+AO2NlPinU0gopZa11Essp431vyHeCinIXXBjXOFOc+jrjWUykhqQkSxvo4kNd+uv8dPq4BGXQufmVWknVnUZPlW3YJbfLnkZUnP8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613975; c=relaxed/simple;
	bh=7kqSm/2fm1urrO7TM4t3occCmfDLgifzlLI4OteR+T0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3NTYjjuY8RP2saBx4PJj8goqLiYtaHCu1M7Rm/YlzBYq536NRNkQmsErkVR6az4kyZGhqY15V3Ah2vjQrVZ2hvLtf0hziqmMMzOoZdLDfA+/cvEhrf8UgbmZX/j6iE4G9kaPnT7dmRYoXgi9DrGzM8xjOOi8GWdcgYNJZJ0iAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OhmM3RFx; arc=fail smtp.client-ip=40.93.196.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OhmM3RFx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMYDu37uZH2iHQk6OOGxrFDhyERiFohogoc9i7WXQ7nKozjiKWOeYQg6U8SHBabcIaVAJ2/Z6kR3AzQEpwusPapIsbHTCMkmUeZ6yKhBrpX1dtvVcyvawcyxfkUDUjt8ruOsMGRLWph/GH46f9J0RsSvQoZE0dKYZvs3KDjvNy9nSrxTJYHnqolqAbkazRIZQB9V0ISmXVHklDJvrO0Y15ShIBX4AW7TDHuiKuCODktN7XDslXdfG+OQjTgXQm1cdJB6e5jVsRn5bfKT3lu64A2dptWp6avevdqa1Z1eG3DqlDxjk3/NzxDmtoaUXy9UnNGMfELGg8i2/cmlXDLM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPxiQDxjErGzOPtCI05mFsdD8iSa8dnC3JQL7Btja2Y=;
 b=w+cmxuXweZY7fLdeyhChxB2aOswFdrz2f2AbDf0NXRm0B33j2VC3KILlpiF7pV9sBuFnbhly0czIhbK+aaSvgSG/Vl8/AwA/Ynj2ehfvy+atSg6WSBv4Oo+kQW6SRQnPivXrxrNecokjwtwYL01horaVdvWVh1PD1K+kqGzk+Zw+I3of4iRTCAvngA84aWkEA8i7vztey6/7ZIcsewZFJOVHTcTV4grvE5Bdzg4dkDK5xdR1Hl7dGKbBUs6EOFsnRZwtIUZIC6zWkvJHUt0Kf2gsWanmlH5Z6AuNEtzbZ4oLnjB/T5AgddYyWzCEWeN03s9d9uJWjxl1ym9LnF2VXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPxiQDxjErGzOPtCI05mFsdD8iSa8dnC3JQL7Btja2Y=;
 b=OhmM3RFxFnC1DByht54au++2E1yPKK9Apd/tX+xI8hKrZw/6t1Z9pJkWjq+JwmfCwMr5BlrT1alZ1si/X37mzL4yYA9QQDIX+ZVOUEijwhb+hrcrWb8NNdHRCsuCj8hjOIMJyw9pFPrtbB8xpohpHulCOg5Tjzcg1eXEQdLxgb5nzUpSrHIYoO9jXurBebGIFlMtR7q+0np4Z4ZJ1KutBw/37rqJ6sCy9PsSkqfKapn6m5mclgmvUWH4YWlqXd747HUESGzLg7gnJzpwS7rsAC4lBT/B9KglNoBmFRQeKyRIIG5pjxdVtxnprsZvIVx14IwuWHk6k+Y41F9RMbfeOw==
Received: from BN9P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::10)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 09:39:27 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::59) by BN9P220CA0005.outlook.office365.com
 (2603:10b6:408:13e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:39:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:39:15 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:39:06 -0700
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
Subject: [PATCH v4 13/27] vfio/pci: Refuse read/write to an excluded BAR sub-range
Date: Thu, 13 Aug 2026 15:06:17 +0530
Message-ID: <20260813093631.2288172-14-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 478363b2-a809-414e-b931-08def91ec41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|56012099006|10067099003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	QN3XGbUv5QSeMAlnVUkzpLUu/sbhKI430lcvBflZ+05IbavH/Gx+FRKriAJPK5ktR34iJy+6MwkU1xP/wVKWXpwaadFZeR7vFWpIo7IJgCsZaveNO0Q8G69I1VKpBrnYKW16RwgxgqU3MTmZXxup+zwjOVtR2ssYP2ZsP1bvxyPHMVBh/2uxhOFGfwfPgp2ZyATK9Ef802XhXiayS1ptLt7Xtjq4szlWGoA0UyTjoWZO4bgNOnGLCOpF5PThvYXZ9s2Jof438/h+mLc5oyKIVqyfQydtS9RFZhKpbJ3/4GksDLdB4VSBwGcfDUTwvf90LsqqhXD+S1jjy2vSL+uNfIb0i4L36u8z7fAADaI/hu2L5TIabezV3yixf6/SRqLP9Lg0+RMeYxCQjDTRTerPE8PBfJdV9vjauvCLwhy8Sy05zYg79jUkGywa3ETcKPWuvsfQoLqVVQfA9HkBzmJK0RZQn2zjOf0ZBlKfJmk7uc3SO2U7xemrd1UK7qHpukaJSgJRw7EZHKDJqYMwHY4sxgZNHbQ56YmlHBPUZMN5egNqhpKo1VuE74LODeImhwVnZJvSatdgL6+f5LxVH3GiGDmpE3ijNmpKIjmvYdl1OsAc3Q1wlYDzQhmCbsln6lOiIhtCKaLmDRBLqbpstuWzESyypw+F5TvlLuSeP1ot6V5rFjV7omEagV4X/m8LWVeOARv8k6Wek5Xs433nBA/QYLnoVjsKT0IfnI095DGx8oHDUDCFnGtTjfGH97NIymMD
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yBaKRsUuybn8V28Q5FtEh04QlncjvQekRqkH2gHweLVRYV+II1d7tu0u5Mr0dihHNFvCKpTARoxZ3AagVBkKh8xDNlzAR+Udd77un2xwh+XmNjnR/KMbe9iIx+LgHyMnn2CYlkujuhq47KOTOaTXChIfPbZ+baWny82kvrRJR2T9VXMWeh07Qx9WZ5SAuzQ5SudpvHDbH7VlO1ilHSLsLuKnGqb1A+8vgeWh+h1pRtBfgqrv+LTTjepIyePxD1w3tGDqpLrkGy566HSQp/rMNA+UD+Wk4mgbp1UHitfDNdIIGEQkYVnlLoblj/MBUF5zA5sGmfMb+LJGAG+gZkuthjwy+i1yIGWGH+Zi3ES/JTh7wC7hnzzkl7ykyAgKGaGYtMf8HcaS47mTRY0hbH52NnLFqcYXT67B2byWmY9RgPkY2FGJz8cfW5XquhB0nlm5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:39:26.5924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478363b2-a809-414e-b931-08def91ec41c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613

From: Manish Honap <mhonap@nvidia.com>

Excluding a BAR sub-range from mmap is not enough on its own: the region
read/write path still reaches the underlying registers. Refuse an access
that overlaps the excluded range there too, so the only way in is the
provider's trap.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_rdwr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 7f14dd46de17..2ce18e75a5ae 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -223,6 +223,10 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 
 	count = min(count, (size_t)(end - pos));
 
+	/* An excluded sub-range is reached only through its trap. */
+	if (vfio_pci_bar_is_excluded(vdev, bar, pos, count))
+		return -EINVAL;
+
 	if (bar == PCI_ROM_RESOURCE) {
 		/*
 		 * The ROM can fill less space than the BAR, so we start the
@@ -423,6 +427,10 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	      pos >= vdev->msix_offset + vdev->msix_size))
 		return -EINVAL;
 
+	/* An excluded sub-range is reached only through its trap. */
+	if (vfio_pci_bar_is_excluded(vdev, bar, pos, count))
+		return -EINVAL;
+
 	if (count == 8)
 		return -EINVAL;
 
-- 
2.25.1

