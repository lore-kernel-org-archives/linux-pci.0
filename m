Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9DD39CEF2;
	Thu, 22 Jan 2026 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099382; cv=fail; b=oasAv2tKNob3Lr17Xq5fMk4ujAmKq6St712JvEDY0+P+s8vZijNNLArVtw5x3GdRCFcV2h1XjT4PfMhxmRssUSvdyiN6MhuLRgFVlJJj5VHtv1ipGcxRrkecDp+Zbsou/GymMRnAtAs1aL//xZqal72v3k1tZ3qRgKjl70sulP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099382; c=relaxed/simple;
	bh=GHzJdWUtY9UVxNEX30SHiCe3t1y5IuSndofJm1O7L8M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaqRDYc8WCkYQmg0gmYgCEqDhfAJ0C6Xaf3ChPUpVwcArHBymU9kpVvXMZkbUA4VZmZx54+S8C7neg5meItxk79MJbTYps6id4F69jy345lySur3eMZ1QcDY7fzfQ/sXE/yNAgsVY8IxvKEgJrB0Vllc2/xofvj+NW+hjfOSll4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IHOlGbBM; arc=fail smtp.client-ip=40.107.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IHOlGbBM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRHL7Tn/zdEzdem1ROJvnoGLDImvGqjm2I/C1y7ooup3PLcDCO7X/6t9a4p3doiMYudGjy3htcmJQafiKkxIlzZE3D9toOcjqZZ5318+EmsvAb77flgK2WMeve47H0Jn221S7Ghp1ltgtSyOVvOQFONLaHIP385oIfLMRbSgjX2qi0mzPXljpMFQR4swMkGq29olb/Y1o19wrViDpzmDlNR/VeY/VG21l+rRoYDt9lqpuZ47ATemGaLJ/ExpNisQmTqOS20S+nBiVJpmTkJM0hkCNqNUvzIr+EGgdR0d963kkeHudApGldiQzyqpWg/JFiEc47U+Ecva5pWsriCX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msBPQcKa9Pi82skiLurLLBBE1pPfHvZLFHZhZk+T5i4=;
 b=InpTsNpkUHpCzQrKvC3+avtDs/k2xrqmaWg6vEKx/XMoYYzZD1FNX1VdKlwOZVeHvfY5jtokSK7idMiIcqdIna1qXCUVa/cFaCbQxS1Z1BpJJ3LCpmyxu6TPg6MGe3JimFI0MiuRDVb7eFc/2dzBRyH361rpzjVCTcCR2rJc2rFvANOvgy7jaAxGPwLdSRgn8kdMHlLZmmOFZlZhjp1J+71E0h7jOFowXJxitO/2ACZJNCermlKGcuSrrW53gka/2Z96Fj5k4QBXYdEQ0J8zp6lxKLvbjmpt5ggBEMEiMia7gJAZJ/0SQrMvxuAjDDcaC04wBajiHX1Kc4in5x/kiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msBPQcKa9Pi82skiLurLLBBE1pPfHvZLFHZhZk+T5i4=;
 b=IHOlGbBMdiSC7MEJf681e8A1Qe8EZlSK5RRtjnHWKBiDvbVRA5EWC2jlD6cGCWelM7DpDDZYCSRQueDMsfJNA6NQTVmEH8tB87NZHSG9W3psyryfdkLcGPrMQDC47ZokiNMACF3RexKK4pwzkE95OjrGaMyybjspOfUi0daRv6Wz+iseLbssuK+MQbCc3cLqVFfsq+TBZpI8G6mCvQEB4TlVJw5j7KhjbztjO8l8Se66omZ9GNn1ShQJCEwk8PhnCcJ54PhLUvXayZ5nDk+tDa7jR9DPBWiFNolAF3rG53mROfW5xHeELL1wUR0fIcGpkDRd76H5fgjhQMM0tqTwvw==
Received: from SJ0PR13CA0230.namprd13.prod.outlook.com (2603:10b6:a03:2c1::25)
 by DS4PR12MB9563.namprd12.prod.outlook.com (2603:10b6:8:282::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 16:29:22 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::9d) by SJ0PR13CA0230.outlook.office365.com
 (2603:10b6:a03:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Thu,
 22 Jan 2026 16:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 16:29:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 08:29:13 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 22 Jan 2026 08:29:12 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 08:29:11 -0800
Date: Thu, 22 Jan 2026 08:29:10 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <aXJQVprkiMCWxDyp@Asurada-Nvidia>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com>
 <20260121130315.GE1134360@nvidia.com>
 <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122131432.GJ1134360@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DS4PR12MB9563:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cea509-d37b-4140-3176-08de59d3667e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4lo0yMN7ccUpuqL0Dp11LkLiL75M3pW+bmp0jPTVl6qdvaJYCVmcTOcy84gq?=
 =?us-ascii?Q?z/tBq7tV27mAnoZAFTBfq0mN+/gY+MpvoOrE5OW11ENGU0Hxo0hCrzdfU3/4?=
 =?us-ascii?Q?EDT3fo1Y89YG30+Qw4OaANliV5pr10gi4XbHv7FWErAJohLf3Jorr7tqpl5y?=
 =?us-ascii?Q?yoC1d1fhafWF3tLGAg/v1ooiutfaSltaWmKvT09ECjnT+/lifTcrW3M9lF13?=
 =?us-ascii?Q?TSpFEXsITu8VYEmton8fRsWUUtXCv5BZNNiW2N+yaQighEh1WAT0x4S1kHvc?=
 =?us-ascii?Q?VkxU4AyTvksbOkR3yUu/97u1Z7woyKxjF3bBqsR7xyY1oBO77e+7aeun0Rid?=
 =?us-ascii?Q?DQ8GycYDTvKVZni3CLFESbU86m01T/mKixt0RHg/+qwbzXMzvdNU30y4uz11?=
 =?us-ascii?Q?sZ3u2zEmS+jsX5xlbZGfa++uTUXEKFl2XFLH1jbM8iEApzcmR2gyPiqm6SGR?=
 =?us-ascii?Q?OhFxTMrboXwiAefvMwq+c/lifPd/cQt9+Re1m3dprVV9O9TOS+waPqDVJrqc?=
 =?us-ascii?Q?3HmOCu9TjclchHje4E/y1Loz1kOT+/TYk5Urlqnagyl8aR7D1lcglj2fPyxj?=
 =?us-ascii?Q?6rQWXeCEjZ2l8Bit33rlUinkIuK07R4i055pbtCC1dxhO/Mgq7uwjs46mfpn?=
 =?us-ascii?Q?yrGmYpnMb+0mSeybOavADo87fDTSwNAzao7/E5vwV9DSWOC0crbvUSr04NqZ?=
 =?us-ascii?Q?JLQkX3LiRh/jtzatI5eEZtErfjjkIUiQPCHXa8R/cY+MZbgLp14AKGPcVcV7?=
 =?us-ascii?Q?CRAcFyeByO88P2bwoxXbZTkaMOgfH4XWvcVFS8G1tyOin7U/q2A0cZxwfMMF?=
 =?us-ascii?Q?FRL2qsIKgTHDmj5YsSKehvIhPLNRmKqMobPNr11DtVZpy7m/arM3MNOwZFjj?=
 =?us-ascii?Q?z5PEwuSdZrejBcw4QzBW/0aLYLfOEuqx3n0gnMk+vu29uANQ5vBXsOkVcd7v?=
 =?us-ascii?Q?gPv32TysJkKVY7UzBGAzXNCyUvtH/wVD6jOskXBK3pUjjg7jC9t7y9DR42O9?=
 =?us-ascii?Q?Wj33vFgIQEiaoGQpjFz8g81+L2lWY9yLzlvteB1t6eikM8VUolc0Zc0NC06S?=
 =?us-ascii?Q?N7CZRnALykLR59yqnNbllHvYtA4mABIy6En45UlZ2DMb+z/LnCNouV8rgpRP?=
 =?us-ascii?Q?g6gDjHgmC2dGxj8jn0l6lBJWAO2IdArbCeCJVrw3ramJ+0sav85AYTrKp2+0?=
 =?us-ascii?Q?5lDxEXfP8FSsg+GfYaOhcp+SesRJx3ATMt4CJE1+dEcDSMbXBMWkJrpMdPwe?=
 =?us-ascii?Q?R3MVOS3rJmpd0jI9IGKk0VevO0HC2nswdnbEzXheAfXAWza3B4iJqC0QrbOT?=
 =?us-ascii?Q?JBjJqUnxF+2WwBSW1SBxo3zPEtPiDVPQmOjE8Dbs/38B4oOkJ4v1BR80+Pwm?=
 =?us-ascii?Q?di0AdvONhzUI1XhhZacJsr5v2aaZY+7pRhkeGgUskaaDUnWDVGA+R2AVVEqt?=
 =?us-ascii?Q?gqdoaSmqTVvLX8dwcgVyD4V3RUQG4RDwjFb1OZp7SMCN8tUxjEEKFUb60xxQ?=
 =?us-ascii?Q?cpWSqP+F1UfhcxvTxHyD8jO/K913GcYVfc39NlBynWpjw7iuYbELi3iKj0KX?=
 =?us-ascii?Q?2ZcNjipqMiEsov4yRn82HrJpSMsrxSI7XXdJMrLHnwtckxPNSknG52HyVj3H?=
 =?us-ascii?Q?i/eJp39SzFzjkyx8Yye+Q0o6WjBFfWymH6FARmn20kSY6EI3fEkFPxTJQWmZ?=
 =?us-ascii?Q?O1uxKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:29:22.5480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cea509-d37b-4140-3176-08de59d3667e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9563

On Thu, Jan 22, 2026 at 09:14:32AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 09:44:32PM -0800, dan.j.williams@intel.com wrote:
> > "We have a less than perfect legacy way (PCI untrusted flag) to nod at
> >  ATS security problems. Let us ignore even that for a new class of
> >  devices that advertise they can trigger all the old security problems
> >  plus new ones."
> 
> Ah, I missed that we are already force disabling ATS in this untrusted
> case, so we should ensure that continues to be the case here
> too. Nicolin does it need a change?

pci_ats_always_on() validates against !pci_ats_supported(pdev), so
we ensured that untrusted devices would not be always on.

Perhaps we should highlight in the commit message, as it's a topic?

Nicolin
