Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0249620;
	Fri, 28 Aug 2026 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875377; cv=fail; b=TBLscNmF7DTEPgx71IoF376A/ci09QKiGSNzkcBpLAGB/477WlXptcmOclq9oop3iDuFXqVB0yMkmu95KA+ZFCapSj8SaGvcXL1VjWE4U4vQ+NLQHsJv45jIHiZkVdh4rLfQC4P714GdCTp3HdPezjcdAxvQIXIoUB+kAbOrV6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875377; c=relaxed/simple;
	bh=SwQYFS+ZsnQhJVf6k8w+i88rzPB709pbNqdxy0UoP0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BnFJ62SV/T6DUznObocgsD2FHceff9dE8nMgX7DpdmHjx/ic+73FfRll5GTmVdUmafOOO0Fpy/16ab8pTIETS/aZrSBwuk6DxQQCtadg/ilZArP0RmunhQe+HyqlqW6OAgMW7SeoYVl1ymGkG4mV1UApfWDCFATMDgkhbXVaxFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qChbIXmN; arc=fail smtp.client-ip=40.93.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qChbIXmN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qoyd3lMONkWoe7FqrG3bKm3cy8qDNqur0V5ao98F0jjTmhoVdNgtsrrkYM91W2K3oTnLrn1Z+16YTxXai+Ivq2j1of7CEZysqVw8+uA8Feb+px60ULh67h54URukgZQOZouDmTr447pQ9AxQHzb2xEZjOt35EuRfEGvUSJxqqEKZJUt60E5eulLdAlcRFNyaTUCDdwF1vhYM3nVYA2G3w6FwfLlncw4xxe1d9+A8KZx0hh6U9PUU52cZOQammebShTpocB/q+2USsEGUM3gtjlcjMT/nE8hk7Q+mxTmbNPU+6ZalXCPlBMGOTIqWvul4aawuNWYg0Wa46PDXfEQh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8n2XnZEXJ+Zx3fSe59Mfpk8b2gJC/sov33G6M/+4tfU=;
 b=dUQJYvu4TuqPSOnIjgJRZEbX6f+ydC3WoZMgobnUNm9wNot2gnJy6t0rmaNq+mFqA8SU6fpVBm12agL63NbSdrTATeRlLeg9MOa+iibByIxpt8O3oljDCvGLVGleJDUa2Tn9pp9XtAZ3+qk4KYDEdbRwwkkbuBbJr4fDIWznanx9a3VS5UAoE1QeSqL0rSI0Id3RQLz8U5wUGHeIOAEsNWfcFPYU0Kd25Xk59X2jJQVJuQOKj23MIV6EkXIBPugtLaPqUR+LZc2tGqUFLu6TgrJpNYyQkMTPvTKrAo/sTtkUlynDNMXdf8dE6tC+hKLB222dyV+UI/m+UzzuDX/v4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n2XnZEXJ+Zx3fSe59Mfpk8b2gJC/sov33G6M/+4tfU=;
 b=qChbIXmN/0KtJ0256KfmPQQzEeZiETcoMsf1LVuzdESFEu6pCz8860rxkBSx0R6aD7nwHkuO3bT8kppURFrKjveBx1TyyK2QMRZMW9oOdBueSedpNn6AAV5c9isKdIfbDXuZxS1h4RLCiMKWL7ER0vCyPxvYwpMFD3JWN9R9kdUI25CUuEBeK41J/Y3Pft/tiEmGnHkYeC/IQrtvWKO7YyOpD5hoXDim94MYrJ+4PmHwb4WlAmLuhhWExuQpsT6Ha1Idp+ekwEz+DSHhuNGaVwzQMNTutxF5dzs5ccxC2tHt+V25A9ugovPwCuL8ut+WUrwmciFE6sUESJ4LhyeorA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 00:02:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 00:02:53 +0000
Date: Thu, 27 Aug 2026 21:02:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 03/18] PCI: Propagate FLR return values to callers
Message-ID: <20260828000251.GB3922654@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <b00acbe0755fa5999491368eaac26a78d522e2ed.1783044582.git.nicolinc@nvidia.com>
 <178786269177.3808739.6763094519382046767.b4-review@b4>
 <apCpkJaysSLVY4mr@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apCpkJaysSLVY4mr@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 711d64dd-bfce-4548-b6c8-08df0497b4b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|4143699003|22082099003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	iOsoZq9KFUmS7nveY2nQJvR1mqACYVnK7v5bXINXu+j2uEqevGDhAm4+1x9lP7Cjj7jduvenNivbRXt1BKbFS2MWcpfSDwkv9M6mkYbLInwRk6wergSaeVsJO7C4mxOq6jyilcMHwzxp7yVobL9y2QRLBV/4audblUuYEZLyjbX7ugQc/M9uYDfiB42TgFqwoOq8oG3FvE3LiV99yqpTCwO2dFlIG9xf1m+F/TiGULr6AfVIPAoJHkKoPQscq4fPWSiiEeiC5KB4YlBoWmk2Bd3OVPK4AF3dB6wzNCcEe/DDN6ZWOyJgagP8DsMHWOF/A6UXJ+ZILI/D8gM24cQTBzVIL02Dj8G1yrF06jCFEgdboDS7owHx/8zzUvhRosoqcNLOfW1hl8YZzW4yMRszeTMRwZdKgeaLXJi9ewKkYTzD0/vwWCCacKMUxkIfamSDda5S56OhgJ/55lpVkcB7QhPO4fxvNlW/9VBDiWjP8QDHWwPLjbjpgC52LBB1HRggvMV8Ickj+2nPFhcgDmGmAfbmtmCalZ2j7aqgJBgrfxCBlgrz6OPEwZg8zZoxIJL0G0NZJ3wF6u/WwbBNZLgq2RKLLsao3fhDxGN4fMIuPdk374g/dNaGj9/Cig+BiQ5wXWPfrw4N4VLOcH7l4Q/kYvQF1qIkNODTWgnzWbY+B1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(4143699003)(22082099003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oWSYvEhsR8dxcPPkOSN9lPJfBY4S6bMw4TSUroeMdZVw86RIItJs5wyp5m/j?=
 =?us-ascii?Q?mAOd5lmsiCE+JhQuyhVgS6R477NBAJ70GPkXCuzMuHNVOQx+NGqo2BuvZwrn?=
 =?us-ascii?Q?y6Bw1h8TrH8OSC9P2GrzhbN8fSqjtJ0zUCrwHPvO/H6n49L46fBSfu/a9Qj2?=
 =?us-ascii?Q?b6JRTLbhfVLsTug6PlpTtZC7RtARq3x6FwVo6A/yU8pp881tErgCNr8uexJX?=
 =?us-ascii?Q?z5KLVDm37ThMQ2pmqh/pzdT5DP+/91V8YXhx2k3uOouKlv6tSm8F3W9xRwPB?=
 =?us-ascii?Q?xOM1+jJpXpEaBKVuHyNVgC2tIaOJrTAEnI5T3NxUO1bVis0BhTlWwqZoYs8A?=
 =?us-ascii?Q?j5yAl+mYYOmsEFlN1k23lmxOPoCC6eEa8ecgIrZERKyNe/qXs403XAeIRZ4u?=
 =?us-ascii?Q?TbshAjo3s0x8DqWiX7/eVMSfB7yJcZSH9hZo/I7Nd12dzviks4IlR8N/p03i?=
 =?us-ascii?Q?JZRQFnD9eylnNiq5RwwglFzb2iL5KEgtS4Q9DC+JB07HtXgnSQoOicf+vS78?=
 =?us-ascii?Q?nwGHPDGzCuiyb0rLESudjKayjBO92ksqdAAZpEN46Qp53e2AQr6y+JJJumaT?=
 =?us-ascii?Q?gqLcDP06SMQQnzw2guZ26OU90YrxYXa06KYtROES0v2rDA0OafFv8iUQNq/c?=
 =?us-ascii?Q?+DZ3G6h4XKSvJKMhkyWL2FG46ReseoILYT693VeNIJNDuk063jyttrQw2q5V?=
 =?us-ascii?Q?WeJ4m1X6s0CDfamYGf0cscTMelZGdah59PCMl5yUEFrXnQ+8nuSOr2+6xL+w?=
 =?us-ascii?Q?LB0gqfub04kp+YO2uttt0Udz3B+2XkyOCVaqNVBdxODZUP98I2T4QFtQIxDM?=
 =?us-ascii?Q?yVDOeyQAw9ImQeIphJBcCmM/ZDbWjfqPOENtyGkH1AS+vr7o1/WNFpAMkMEe?=
 =?us-ascii?Q?d1ru+LBEKeXXGJMnNtmecqJ5D5kS5TTEnIOqbnqAOJdJK8hW8i6jk8My3Vs9?=
 =?us-ascii?Q?w95eooNuNFZm1izM8iS6MmIfu5MwP++jn805D9VrGWf2AKax2RxYozkXEPNG?=
 =?us-ascii?Q?1v+NaGDVxIKDShmfdM4VHrZX63zsJB+8/rVoJOcCmZb2gACdgIB5H2NEpqzP?=
 =?us-ascii?Q?eiU329PwF31mDc+LUkswHmCwrvaor4emwEHTRsvhiYNycfL5u02eCCpM3vky?=
 =?us-ascii?Q?YR3c7eS61hMb00vLu1oUqmXGMvNpHXAx36/L0v9bLVYKrZrL+9rYrfMwiw8d?=
 =?us-ascii?Q?vJSy4rZ+yjrwjLoNVeJ4e426ykGTSMLFc2iNy0hyo9ZPAqdZe98aF0iWGUPd?=
 =?us-ascii?Q?0tDL/sLWS3usgHb8gzYcZJkiPVyrIRsxuM3W29BthfTRsHuIaBQgcJRgODwz?=
 =?us-ascii?Q?TwFumiK4xOxNqpLfx6GPY6uwX2tC9r7fOQ41wTErhfUBBpbsOKIQWi/2+Ypy?=
 =?us-ascii?Q?wlLJeroLxeJVhXrlB4VIyfH1mn1Q2EpV28n9FZ2YNPLiIOp5Mh542hWsbsAG?=
 =?us-ascii?Q?6rBtyHae9srSParzVsuty+oEsY+tGr9yxKmOLSemE+Yrt3BbtgBsLubWTXPY?=
 =?us-ascii?Q?M0uO2F8YsVDObIBrupmHOT6Ieeaybam4DnHhNO33zaxgcGIYxOtNtv3IUoKs?=
 =?us-ascii?Q?GxW1RSafHv8t6dZUWrQfxkVya3XNmkSeslgTdrrZV7VNTh0LxxtUZLpwXaIC?=
 =?us-ascii?Q?bjw0I6Nr5SnJxErMt2ImGNWJOY26jsaPGrQI2UyO3VWvQ6I0zUyDv1frZEPf?=
 =?us-ascii?Q?1Hbb8/ko12mv8FrWeO/VV/ypWWnzO9SkSMcSM1ilz7S6kqzX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711d64dd-bfce-4548-b6c8-08df0497b4b8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 00:02:53.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9m205DedBxOyFZy7r+6xYUJHXANT5U4EbWtGfxxUaIfbRXTLw2b8XMnHUAPi7st0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

On Thu, Aug 27, 2026 at 02:18:08PM -0700, Nicolin Chen wrote:
> On Thu, Aug 27, 2026 at 05:31:31PM -0300, Jason Gunthorpe wrote:
> > > [ ... 24 lines skipped ... ]
> > > Since these quirks have always returned success, escalating
> > > would be a new and harmful behavior: the next method is typically the plain
> > > "flr" method, which would re-run the same FLR without the extra steps the
> > > quirk wraps around its pcie_flr() call. Add quirk_flr_err() converting that
> > > -ENOTTY to -ETIMEDOUT, so the cascade still stops at the quirk as before.
> > > The early "not applicable" -ENOTTY returns are left intact, and they still
> > > ask the caller to try the next method.
> > 
> > This seems like a very suspect AI conclusion to me.
> > 
> > I think I'd drop this patch
> > 
> > > Convert it at the quirk level rather than in pcie_flr() or pci_dev_wait(),
> > > because those also serve the native "flr"/"af_flr"/"pm" methods, where the
> > > -ENOTTY on timeout is deliberate per commit 91295d79d658 ("PCI: Handle FLR
> > > failure and allow other reset types"): a timed-out native FLR escalates to
> > > a stronger reset (e.g. bus reset), which skips no workaround there and may
> > > recover the device. Converting in the core would also change the value seen
> > > by every direct pcie_flr() caller.
> > > 
> > > This is not a bug fix, since these functions have always returned success
> > > and the propagated values are only consumed by incoming work.
> > 
> > In what way? The quirks flows always succeed and it can keep always
> > succeeding. If anyone finds this problematic they can properly
> > propogate the error.
> > 
> > Squashing the error just for quirks makes little sense.
> 
> PATCH-5 forwards the return values to pci_dev_reset_iommu_done(),
> so IOMMU can keep a device blocked on a nonzero result. Dropping
> this patch would leave the three VF quirks here always reporting
> success, reopening the stale-ATC issue this series is fixing for
> them.

Sure its fine, I bet this HW doesn't even have ATC and if it does
someone can properly fix the quirk and test it that way if they ever
hit a problem.

It doesn't make sense to touch this code and make it worse, the right
answer is to propagate the error code directly.

Jason
