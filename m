Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52440DFA8;
	Fri, 10 Apr 2026 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779513; cv=fail; b=ZjynFJA965tIvrgShnwEhX7ptkVv6Izk46aYexFm0KPfrSGIJExOTUuRIcmChjBA6Kc/v2GUL73nO+j0zWRXOD4emT05DoX8eouRHxd9t+IzeYNGXjo4l3yUyG3coIcB2cfiBQ15Luxoi0LPjCmC+ihzPdAZklDjnrSxecl//Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779513; c=relaxed/simple;
	bh=8ImDwhOxlCRxNAjma11B4edqwl8Idch7Eqb8/I7QxPQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsCJ5uRiEX3Qn9F4BlsVLm2hULgQ55QXpyj5dQLYtiMitknazKqYTybTlSgFskqgjAVJ+vH+qnjZJgamX0HKfSr10LGIFo9h1qkXeKwmC1cUvDRz5OmxnSD/9YxGLkZpBNsgdW4fv3+JrLn0oB3SIiQSTLA3U0B2mkSW+RxdLdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qjGWa/ft; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qjGWa/ft"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHvknIJRJQdQqDDIyqwWYTOLKbDY5pK0zvTObH5Illf3yN9rQm1E4z/AUgrggOWavKY48kUkPPoex70EchOD4n1Ua7FUlTa0N0fOywSlbww+We1qc8cSqjiLUw1OdjexK8k/rBnQ3jDtzm6+LNfVu3Rrr2mzMrEHcon1ZimOPIGJqPNp/JnWZGeyPUKRPb+hr6UCzyknLmuhe5tgnB5kl/hwg0AfG0UvrrxWlI2yTrPx+N796USfdaIt8SC9y5ugKUQk8EuulyXImxoT3OJ7Y45tG4SM/OCcBo5dEEjk+hdWjPC3Lcxd4Xgh48N8umLWchsCP7XhdqQfQWujNZbsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkY9qsV+fcaQNIraPAgrgREF0/R4OYf17eX/BbrEZvY=;
 b=pk9OaecWBxC6/oXLL2iKwRUA7+JGZkJr1SGMcIoe70rkddGWTcZ1Vp47g7a27w0vQWh8y40c+EzBInJmv0Hge4wKLyIWbAz6h963LkYOjslCsBoFUtAvT+nEeOVHsO3L3iJfM1kcCiF+eNt2Clop51EYugUcszSAHwCLXu234fvV7Tj37Z0YnZApIzCSS/fcNfjHX2Og2uUnNLEFFe2w1xuuWq22Gp+L5DZSOnXpgROkbUd1CKl4+iCKTrMJHgvra+k7mvaVvmN8+5nzC2BCSUF4pvcsYATQOd3sbAB/b/4MyaIzsJ8E1cH/p2b1dnYBOj3XKIdfuiLB9U/W/VOdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkY9qsV+fcaQNIraPAgrgREF0/R4OYf17eX/BbrEZvY=;
 b=qjGWa/ftUw7BYRa+kJT8AOCP7zXenjHwKrFhXse9ej/52giy55R3RU+nkboctTEtxfGKLhyp/9K2rnW5dkq2DqLpYT5mNuoECJZfJnmbB3aXI34rN9IrWxlAyLMmxFauNxIo+gs3ioQ8Em9GbwoMvqFbJge+cAvRsUwcdNHShTi9UJ70qIn102r7krL30rgY/+XwsSEnItivnHSzCIF1peOyBwnQTM8WIIhezP3jYwNTgTbiUg41xuzit8NehFBQUxeghZ7ouCnSD7Hp6EheCfLw6HKp6szI0nY5oMxxVpXDuZFm5EAeJtRFvAFDhl8bTD6IN8UjHJ2fvi+IosO0rw==
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.41; Fri, 10 Apr
 2026 00:05:08 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::b7) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.42 via Frontend Transport; Fri,
 10 Apr 2026 00:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 00:05:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 17:04:49 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 17:04:49 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 17:04:47 -0700
Date: Thu, 9 Apr 2026 17:04:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "miko.lenczewski@arm.com"
	<miko.lenczewski@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, Vikram Sethi
	<vsethi@nvidia.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <adg+nrNAZAJx7JiV@Asurada-Nvidia>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A6B1B103C4B0201458348C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <adgsBgXYy68GmxAf@Asurada-Nvidia>
 <20260409225252.GU3357077@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260409225252.GU3357077@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|CY1PR12MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c627250-c6f6-43bf-0732-08de9694d285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	K5xBoyHk+Sk61SxMtW85mDU56VpC15+wHaNTeUHr3a/WLrcgCsYprQBok+j/AwM2hZ5Hj0iihV7gOjBJkurWy2v9PiuKC9ICNNpMrxOD80Ix+ikw1mqP5F53HvuUSFGhPWYhDXFE8mYQZ83cMqCYaSQHa4LTm7MnjPOlscwi2eqbiSDk8sRWZOJtdsAOuDGsfkWMjpvjIpprJfUWVSrrhUPbRSmS8UDCxIMVf9TyvGFaz3T3JVeTT8HD1ZVcmEnbyoBbG3aoRrrbnbL1WAX/xzuaPl5ctzBJDrAhwROpiBQv8EykRyNFHGuTFKxC9FFrVeTn19ueTXSiJmuP1ghJyKCBJi3r3ZXyiWQhXLiHNkMoocmK97L9N5VqlKMlI7N3Z++fVha0AiIzoP0AmZdxYys3imzaeCIlZNaPv+6t3yH1VDn2ey8Cxv+j4t4iGA4ym+84r3DkREYXy9VTWMkTeamY5TtG2tu+mZjjafUYDxatWFoujaGVHjJVka0xmmUJ0RttCknkrAKmc6a+MZjhhB8JpzyIb7K+IPKB9QPZu7TKNqj9OB3KjbH3wNFdvCiiz0uh/2gpihpZ7T3ex3HcYYHxxbbruyq6OlkKX7y2gkZB8rDSsmhAx9/76V4atM0m09hi9YDAWPOmiA3fI6F30XoJ+lQHlR3EgnFmy/pZApKBoJ2p4qNI2Y1j82nh6Os0Zr9FuzpW6DFrA6HPbtqIPIsAJnkzewjGbweXF4HXFrxNHQ8kmSAfy4VmZfPTfC3z0iFr/lH95EZPLIwyd3fw+w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W4/PHzH13j0NB7Nu1Ss4Q/DOUMEaWz6o/kWpL5K8NTsGwxWRnf/KfGYagAdWExN0e0MpWGilXm9VWnXPCnDxtBT+oYeAueXW4SdyQRuz5ekfZnyGSAeQMjvsOV5leyGk5JpQhKfI+zky8h5T62TiLialG4QIZaLvShVTSVBe+dPlYMZrhCcPH1vnrE7sU89eubyViYTT5D8c4F0qy3Pr2gZn1Q+AEqTRNh/j1MGM2iQ8jn3fPm2tEFsV+RT9rDY2GrK0voZeTJ4e8f/nEVKUkJAk6ANd5ZfjtrXEJsAa/x9Zc7FLSkMQx6uzDQVdgImLRetpq0Xm2qjNT4AGYBji8sq3/XrDHz9toNhQrIqftybPPnY8H3yA7KoSgijb7g8UCEbCd963GaOjybRT4y/bu+HisXEDMlNQiuPcHetMlFdYLDCUZWUy0s9kTJmuLRS8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 00:05:06.2560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c627250-c6f6-43bf-0732-08de9694d285
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560

On Thu, Apr 09, 2026 at 07:52:52PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 09, 2026 at 03:45:26PM -0700, Nicolin Chen wrote:
> 
> > One question regarding VM case: if a device is ats_always_on, while
> > VM somehow doesn't set nested_domain->enable_ats. Should the kernel
> > at least spit a warning, given that it would surely fail the device?
> 
> No, just let break, the resulting failure has to be contained to the
> VM or the platform is broken..
> 
> The HV can't turn on ATS because we it can't know what invalidations
> to push so not much other choice.

I see. Thanks

Nicolin
