Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D983DA5C1;
	Thu, 13 Aug 2026 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613957; cv=fail; b=YNZcdHcRaJ/PvjPw+CB0/z65XwqiEO9ffwuarFCkuFzh/60+JW3t0BWbjKW2ArKekGp/6UEgbwht+EBNgIaxfx1sFkx0319lMOjl56CXVvJDLp6HUzqNmByk+fW03xyheG2c2rUFLdSUgU1wAS+sOBiqYPHplcJhI3bvXxtSCf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613957; c=relaxed/simple;
	bh=rLk2OctYEz9tbs998QrGBDd3JL1RbqfEvNnMiK2miHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8vGO73XsodbUfKfQcnamywoMa1FwHqeXbucAT9ho/hGMsXqSpHTUcL2m2jZTD/WQ38emBnwe5pSMLDeHc+3zfcsN+UZPenKeYu82olNNeRYroltYeOvs1XLg/hUCK+TgUUeKnEOu4S8PTL7qXvl/bDQs20uYT4cKwzR0cTaoRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=selv4374; arc=fail smtp.client-ip=40.93.195.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="selv4374"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvjuxFamTQuE2KkJS4t/VG88JutKM3dqHh3X70DE3CRjwNYIGiQ+rHl8BJFxShT0fyKNDfN8B7fgNu2TUtfxO+HM2aasgZj6DBgitu5sLN6uKE4gaIxhjP6OSiwqvpObAlN03ROnAIendGdwqRCpjt0wERvIJwOHiCNHBOQGISY/BWT3ZqLcWwO+FzYEfkvY8pBFCTQ3Xy2nz/WZzW3VSLFBpD4T4hVEuStfNsF7XitqpSU2F95wK8MdZEXSCvCjRBKpXFTACVEPxnFzfviABq0Naz1r4i7imyzftFRymjgm/K2EAI2bqvpERZA5Fj8s1wawJiYnNxv0eAthg1tcNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x21QTB7SbteWe6komegEp3VCF3F16ZHDMGykYw1bfnE=;
 b=wxbEF2JZxjv5wvKlZL0wG0q0doX+noNbSlJ3/wQakuNZElxaqNhGrTRPXWutfZZK2exZo5BJyujWhV2Yox7KZL2UHLdHB/R6Yua2AJ4NoMz8vTLt4KuzGR3RUh5FpcqAXwbHfd6WuGBJf4/g1BvZLh3vKq0S4NPp8KvgUYJkMKUixTj0FZOyMPg2u0Mpe6pHus6QG04roIDjKwOlS5UfkHTIVGPOJdBszzsng3La5WUEd/6kGjl92SpKxiA9F+hK17z8bstgN0gqL2KgPfDE8lzdz05OdLR5GtCHCyAoXXAYn6QsW1qC6MIGoA6tZIGjkXtHhsHGbIH+j6XBUdq5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x21QTB7SbteWe6komegEp3VCF3F16ZHDMGykYw1bfnE=;
 b=selv4374pozaBBd9CbVGLCZMETIsMFXNn7WZzKtjmNOapSpaaiqSPjL1ch2h5kfw9klqagLYAUGH4HmPv2/MDGKuUeB4ZoyFzn4i0GVGTuFCTbajA42jHimzTaR871QjSbyFP7U/ei+tz+omprefjb7i2zgViQN3UAmG6JSfGAyR6hAYC0p7m2ZIPn8vQInR5NP3aPXFqkpKow9Ptypib9NgHLeFOn+RG3C8tjbrBDD4b+2RaNXHafApUrM6LO4CSx8fskQv75snd1Ku04crepHrWPtLtAv0KNa7ZxXRU2ntKKNk7aycppSWu8aCP6oncz6U+xVJdhSYJvRQwpIi0Q==
Received: from BN9P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::14)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Thu, 13 Aug
 2026 09:39:10 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::7) by BN9P220CA0009.outlook.office365.com
 (2603:10b6:408:13e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:39:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:38:56 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:38:46 -0700
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
Subject: [PATCH v4 11/27] vfio/cxl: Own the whole component register BAR
Date: Thu, 13 Aug 2026 15:06:15 +0530
Message-ID: <20260813093631.2288172-12-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 6486c23e-143c-45ba-dbd1-08def91eba84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|11063799006|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	0OQXAhUGfYLwGATyfg2IuTfYUGjHTvk0Gwqr2lRTEuoYSDEKm8KCEAaaQDVktLUif5fHV32UpdfdeK6m7IsnKn2ZHziOmLihl1wUG4yuf9zTo5MldIT3E3wWGUtPC8hTpPjuWzQCsCNmfTKLguPJxnJ9BkOqJfPF8F/MBb1tI5r5s6vLARoJTVX0damExrkjsrgW2itmaFYm/2KmSQVOySz714g6XhFBFqAkSP5YmdDGWovf0l8tBNle0v22spUK+xXKFNxM82Pf6BFk1k4kqoOm6HC1yvE9IrH4Lb2aLl2gL9H/pLrmv7e3q/crYVw4XwqVDaY6HUGVEoQZjFHgRPdby2h8NDpfXLR+1tn8aStMHNwbsMOTc2exCndJDulo0d7AViYg2+v0XxDNgQyRYZxX2lqR80QTFK7VIhhj1yo+lc7y/+7zco7fq1IPiTpONDAxZjei6vzRvwDXJzpMSAwdaLc9HlADF1gtThCaVlnb8Fgiey5Kijd1g+TE8/DKmHNdVPlHIBaHNdxlujaQ75FG4TpnqLSE7j0uiWE9e7GpFGb9MKLajsppxY/x0MfzN10YGpcV2GWosdg1o+GDfkHg2XaCx9d2mcvWujyPYo25R0rSopJcenUQiP4J6dj6pAiG2HVljtzs7h9lsC2ItwTx/E6LMgIWXSV3X9IwUsy6w6+SiwNAc8kxjeLNb0u7nEgEEdqTaiUh2c1W3acLuRRzMa74wJDT+mIeJ1cDKTD65yaPwd7nic5kzjTLlAFK
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Qcwz6DxvdLoj4O5GNVa6rSRuTRe5rDQg9WkPVRdJqgsrE171orZzzo5DWrZ3jJxIkgBbcEMLl81ccRgNkvsCQJGaZ5Qb5QGED0Hw81EFDf7UcupGwuvEwPGRzWKbx9GP/8ffaO9eQmonMBtvC3VMCntsm0dejW6k7vtLktnCF6K5a3GKLWXKvTVp972KBOSQSEuUVtK23K4F4kfUSLEwD8+P0ncjVi2Vov2cv6HOtGQtfWSei0Jis46+ptXQ8KEtXn6rSDLygL3OA8BUpJrw9ou3XMQVgdNDhhKbFnOAIw+NXZzQ0o96zcd7C+/LKtcmcgMIIpuBJcpcTYNnrtGy9HzQlEJLKM/j9rKX9FeXHGcGjhAQ8/PLg1QK7YMp8whit1M4L2+6pNgW1R82nJc1tZ3M13neqh/Qeafz/WSrwDimzj7fECEDoKngXqUddRzN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:39:10.4820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6486c23e-143c-45ba-dbd1-08def91eba84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332

From: Manish Honap <mhonap@nvidia.com>

devm_cxl_probe_mem() maps the component registers through the CXL core.
By default the core claims each HDM/RAS sub-block, which then collides
with the full-BAR request that vfio-pci makes when the guest opens the
device.

Discover the component registers into the device reg_map and pass
bar_owned to cxl_pci_setup_regs(), so the core maps the sub-blocks
without claiming them and vfio-pci owns the whole BAR.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 7edc53b25576..966b7c22a6ac 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -10,6 +10,7 @@
 #include <linux/range.h>
 #include <linux/vfio_pci_core.h>
 #include <cxl/cxl.h>
+#include <cxl/pci.h>
 
 /**
  * struct vfio_cxl_state - per-device state for a vfio-cxl device
@@ -70,6 +71,16 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 	if (!cxl)
 		return -ENOMEM;
 
+	/*
+	 * vfio-pci requests the whole component BAR when the guest opens the
+	 * device. Declare the BAR owned so the CXL core maps the HDM/RAS
+	 * sub-blocks without claiming them and that request does not collide.
+	 */
+	ret = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				 &cxl->cxlds.reg_map, true);
+	if (ret)
+		return ret;
+
 	ret = cxl_set_capacity(&cxl->cxlds, hdm_size);
 	if (ret)
 		return ret;
-- 
2.25.1

