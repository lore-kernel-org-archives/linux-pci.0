Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8226B3B531A;
	Wed,  9 Sep 2026 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980775; cv=fail; b=ZLacpT1zSrycNM/QxPx+NHYGYfLYCfZJSw4Ldbdd3iwA5zEmxVe8FaQ7jjSqgMlxq/Gtp98npd7fM2650lMhXFgBuxBE/g5+VsZlRBGkwmZWIyY/EZvsd4iBdhka0h1pNPqiv3/DnkoMc4Y1j3e+cV/59PBScrqFuIV0Rm/1fCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980775; c=relaxed/simple;
	bh=8TTuDhFiMTJaf09YEi5jd1gpHWXXVWbSF1AYlWp8rY0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h051fxH4K2YEEGUNg+VllgbSDCf9xakYHPXl65ufZSAzS//cVmvWYq1tcpEj3mGFozjw6n7FBYVB1Vb49/wleMt3pTrDmaNohh9zd1JFZFlEJlDGdGHqFsGAhrUtA2WfXumLmr/Ro4XHUTBs6zIShZRv+0CnXI4y/oJV/To0sp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fTEXVLmu; arc=fail smtp.client-ip=52.101.62.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTEXVLmu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IN58BzxGiX/w8bu64ZSQP9ofVgvG70csEfVAXXxHgkHFZMO3Fv2X5D8lfucSPUwbA+JKb6ULC+75gllZacznQnC+sv+ltYecH3vLR87OHA/HJHxhiFxnEgw+ivg1K5eM6w167TdB1uFRZxtn+3NvKXk4xiStLtZuMe8AEaiILRpHIkzZ9X83UWxpMEwV3FHzMuRQKmqA/zFt/0Zai1FL1Bpi3VC+5rYdc46YQL243v8fRTeQauTBaFV8B66J7vLOPRJrFq5dBk/gF84SNqrrq86E8U8Tpjd+WVj7FvqcItlCP3g/CaYYVhIgxgZ+4BBZ1/gWd7z8VFmTiOt7CVrgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZtznNTeR+z/qMMsm+g6mCwuNZImaVVc18iFQ+Gugts=;
 b=R3zCiqC455rAuQtEHzYdQdtfFiIs87uppM0KCd6t7yQgf0+NGIqjf/TWvNuip4Gz5zPQni43JEFkYoN8GXCVsgXl/efioMbRNQEiMbBoNMFtcjz5C7m4bDgT9JmdmpTH99tpM3T07EjBNuXB7UybXLRZuKR4TeDZZ0HRL+zWLFo9qXEWTN77ZBL5zalV7sfikg7t15tDpH5NY/JBJ250C80PqEHn51c6yRhuNVPZ8tR0CyK8maq+qC+k+DZkg6IWOk7MQyphxevl/8ZNVvUnBN9KUpCmUaWWbeHgJpseGA4g9S3Gb0yWPzIs46jRLNc+1SaLIDYHui3EG81bOy3DwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZtznNTeR+z/qMMsm+g6mCwuNZImaVVc18iFQ+Gugts=;
 b=fTEXVLmua+RQhswHm5Iz/l+hYyP5mMAiZ/0dHqzKWKmOUt4HkehYVXVd+ztMgLicIfdVAhw7k4QMCuAI80Zd/xWCnbi8/wSPS8F2HaymJTiCLaXecpUspqCdRlbG337zpKvYNS8FKDU6oY7x9ad3PqPlirWIRgttuYWcaf8QGl5Oe0btQAe0TNrt7cAdo18TMdgFLnX/XSMvB8qSNvnUxDKD0PP/kt9yPu2kIO41F6knamUn4YxfYusUYP640TJoUa39T2r2WxXU4K1JatXboG5SQbGRlt3XlFTWJvYScbWHKfWeZmuhqWnhYEZ4vkwwj2ew12kLWVr4648WOk5RzA==
Received: from BN9PR03CA0138.namprd03.prod.outlook.com (2603:10b6:408:fe::23)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 19:06:07 +0000
Received: from BN7PEPF00000097.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::71) by BN9PR03CA0138.outlook.office365.com
 (2603:10b6:408:fe::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Wed, 9
 Sep 2026 19:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN7PEPF00000097.mail.protection.outlook.com (10.167.245.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 19:06:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 12:05:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 12:05:39 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 12:05:36 -0700
Date: Wed, 9 Sep 2026 12:05:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <kees@kernel.org>,
	<smostafa@google.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
	<bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 08/13] iommu/arm-smmu-v3: Disable PRI when no IRQ
 handler is registered
Message-ID: <aqGt/l6L5BeidQ8g@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <0b5282c7e850f1a1c650e43670899b4ef5335efd.1788222486.git.nicolinc@nvidia.com>
 <178846311318.1308030.4956293524348641228.b4-review@b4>
 <20260904141525.GT4157646@nvidia.com>
 <20260909105954.00002181@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260909105954.00002181@oss.qualcomm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000097:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 81bf4bde-d7d1-4319-7146-08df0ea56734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|82310400026|36860700016|4143699003|5023799004|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	L4XZ9Fa+Dcd11zWbtlsNOvNGen+V/X+qpWXWDjX5X8CR0cZjMqtuBjXaQDg50Wa/Z2N5R87AzOpxaDdsCrfSrUldER24Ph2DcLW2kmMUHRmrngiEuwQ8Pcfe75Z2wP/MYElVeJOYMZ4zaCoAM0AnujipcW/EmUzRJ79zSePBvVPTioyRBUKb0kHX9TCEE2vDPxAcbItrvh29Tk4G7nbEEHQZPoK0uJMyPiFQVjPc24TNsDhKEdL7Zz8ROjuQ7/+nutNFIREkt2PAxpkrs7leZLCH2kKwJaDWs3ckY87zlK3Cfjj0DSPOXQIb7J6IBG1wgQHiRDWGkX8cENC6s8Pi+YSXO+tR/g+KyzE/TGzvTtvTdJha2K0I25yEdFCeQhh7mXEjJj7/WL2adTs2GIc58fkIFdhF66TP2X3UyhZ6ka+0s+QbxBUN/krEMMcqiecZpTTAJzVIHbzbyLFeDqzn20KUvevFLd5WC5rLhIF9YJvUb+0eJ9ECjf9URZpw3Qe0rKoHUzhn2GnzQFPC39GshEAju2yFC5y5B78cwff1JTi5IVU5qwXKAGWF/YMH9WJ2m+lYWCH6tTeIXGtcUBc8j8p+Xv4iUpu9965MKuv8nZuuTcrHHK29Kwbrettc0/XZfaROK3Cbq/MD5kHPAZKGRcTA13est7VInD4UBaPdnDkHFmYeN/lwlsWmeOBUzRbTtxRAaOQpE4Kh69T1OTQrmQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(82310400026)(36860700016)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hgCvy1NpL6ihxvQiZDvdrp+yBMb18Ig9hUMxovZ7dT2rRwhKD70Z2dxklz3dNtRu87kic794EQMiEp2rG70KHyzyzhzqClJu3DBCQLM7ektZiE5Bz2NDqNjCtfKTP6k70J+nndiuxyI+XgL6nowKt+YO3S4DoG6HIlsfoztlE6/2Xvg8OktvkyniWQ0/IdRuRgN8MPjtDapVS6rmHQOs6yqt3TtIbG8cL2IU167eD9YgUv0n9GbnA62fIL0WeflEO4WEhbv/YIFz2SmIm/+WPDVUWeJt1b9lz/PdndkOzNZ9EzSo3mTufLp7/q9vNmDwaQlhbdWE4fuXLBF7IOFKkLpfbuoM+6ex0CMsufBSVsv9I18aJ/cFe2+79gzDb0UTynEZA+avgPkqA4L/wDIm8/EsCHH3YNVw/lt7yaMIzeU5uC6KlckmUusajXzRSCBl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 19:06:07.1919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bf4bde-d7d1-4319-7146-08df0ea56734
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000097.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

On Wed, Sep 09, 2026 at 10:59:54AM -0700, Jonathan Cameron wrote:
> On Fri, 4 Sep 2026 11:15:25 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > > arm_smmu_setup_irqs() has three failure paths that leave the priq without
> > > > a handler: a missing priq IRQ line, devm_request_threaded_irq() failure on
> > > > the priq IRQ, and devm_request_threaded_irq() failure on the combined IRQ.
> > > > Each path warned but kept ARM_SMMU_FEAT_PRI set in smmu->features.
> > > > 
> > > > With FEAT_PRI still set, arm_smmu_setup_irqs() enables IRQ_CTRL_PRIQ_IRQEN
> > > > against a handler that does not exist, and a later change would then have
> > > > arm_smmu_probe_device() call pci_enable_pri() on PCIe endpoints, allowing
> > > > them to issue PRI Page Requests that pile up in the priq with no drainer.
> > > > Separately, arm_smmu_device_reset() has already enabled CR0_PRIQEN before
> > > > it invoked arm_smmu_setup_irqs(), so the hardware queue would stay enabled
> > > > regardless of what setup_irqs decides.
> > > > 
> > > > Clear ARM_SMMU_FEAT_PRI in all three failure paths, so that subsequent code
> > > > treats PRI as unavailable. And disable CR0_PRIQEN after the setup function
> > > > returns.
> > > > 
> > > > A kdump kernel cannot service page requests: strip FEAT_PRI when detecting
> > > > features, so downstream PRI setup is skipped.  
> > > 
> > > Dumb question - why can't a kdump kernel service page requests?
> > > I'm nowhere near familiar enough with that stuff and I suspect I'm not
> > > the only one who might be in that state and reading this series.
> > > Configuration choice, or a fundamental thing?  
> > 
> > The initial issue is the streams are left in whatever state the crash
> > kernel had them in, so it can be generating a bunch of PRIs with no
> > place to put them.
> > 
> > Though eventually we may find a device where dropping them is not good
> > and they need to be NAK'd promptly..
> > 
> > But I think the real motivation here is to save memory in the kdump
> > kernel..
> 
> Got it, so design decision rather than fundamental.  Maybe tweak that text
> to say 
> "A kdump kernel doesn't service page request" ?

Sure. Fixed.

Thanks
Nicolin
