Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C83B6363;
	Mon, 30 Mar 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875122; cv=fail; b=Jjvaut9bgaD/FZnn8Q2o7L66Sb8aCHPuchfHC/t40vK2g6ewSQf+aKo6XbGhG3+7nuez7HiiqvEB27zXtjla4XbDo6u+J6HAXRpWqpnq0DWwDvyzxJVhTX9D3DkCFp6p1flFvPKgltl6N7pkgGr15uFmGjbE38nt4VhkIdmysqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875122; c=relaxed/simple;
	bh=T0KPEqPdQRwz+V9facpT7harqmAQhJCHmSPSTUgCcgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYr0zhNrcsjpemzYv5xOH/p/+/eh/gr/sY8oI5F8c5iI638/t0JLiALVAv5X9FYg36/X2IIsD59xRdSvsImxjos00efMICPHUnUcOq6SRzk0lvAFl+hdKKGebsXSZSd4ll5eFU+rnoGboh/JO+zUPLf4jT7Mbw0a8Xc8+EmsBKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=inopS0NB; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="inopS0NB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB9geyfBJ3M4u2EQpGpS3AsEakZ5Vo0ysVwg3hL1gjaYNuuwjf9llandyxgAEzXLMUyQMJndeDsD2NX/2KvdAYJk16mHEQIaK8ZgydujoxxZX4wWjvWhZxuaWSiYxvRoTGtoLlk4pv247L3K3/QcD7oPXM8PfShsnmW1ZFOmGRV46bB1SQuer93u87U4FVfXoX3HhdmS5Y1EWvV+u1xS3aL6olHNSM30kyREd+U1Y5TIKs1a+TswX1qxhjadWXOLiCHyHuci8ax94gMAreFd0p2cF4v2dIk8eNvhUS3zbwVO1nmVHONHps18KuIh7yHUzTsiPk26+1keOAImqK0SFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALHChNwOXJFZFqHmcs9mk9q6bOiNEpVDdSzmOyH14CE=;
 b=FNYUWHF+Fhnhda39LhdHXKdl6NHHMdr1pMDHkoIgG5NiI7V2YBxZA3OIZnP9W6tSTn+AY8/zU42rzYHvgY9+EOcSSdo2SzBQGdxrI3fa66K1FuIL/DbLppkuI3IWZi+25pYiP32oR1JquPUbLIeIBqiwNClWKilLZIDL6paBI1avtKqmo+iHeMRg2NslVL82R/kwhZCCCnoM3dzEOZ8y+YO90A7OE4S9FB1bsuhkNXXnjghTpgkCDVvGdtqJMnZ68sacNLPEANqbWB0uGohVioBftAvWk6bsALf/7fKXDonHq47IR/e0JbH1Xn3cOuxqASGH6OCcad+/ZEArxXT8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALHChNwOXJFZFqHmcs9mk9q6bOiNEpVDdSzmOyH14CE=;
 b=inopS0NBTKPXlzD1t6UfaVz54DbFlHryvC5FjYeRfZrFu6g7qpKyLBRYWhiDXExBx0k4KxAKeUXdnib7x3FK+mjBXvKlpHtJuVmv+LsjcXGL3/JQJJMrVE9z6cf1O+LwBYIaWYrdybryYilPbf/3O/KvabBb+ZWhd0/DT13+N1nWHvhbW5K5lNFsur40ISiTaskN+t6bCVKAGdVzO4FiHVNRzcoMpdTyzQXQiH9KcKts5iLkpPzSDVj5LX90u29DBeObJ3Wmznkpohbikmpx6hKq3lPaUhDi6fjbVNnS6KgREN06PsqqfKNh7HiPEZbWYhyN/VVjfdUpBS4cvfc8Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9667.namprd12.prod.outlook.com (2603:10b6:408:297::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 12:51:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 12:51:53 +0000
Date: Mon, 30 Mar 2026 09:51:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
	joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	vsethi@nvidia.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <20260330125151.GK310919@nvidia.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <0e8d1ee1557c54943dd15ff836576de4c3aa58b6.1772833963.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e8d1ee1557c54943dd15ff836576de4c3aa58b6.1772833963.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0060.namprd16.prod.outlook.com
 (2603:10b6:208:234::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d4ee9c-a506-4d8c-6995-08de8e5b1e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	E4x81oDCES0JI7JWNOqe3FZXgru02pt+whRkMH9EAAgpAU61m2WAqG1CP4WPG5a+SF5hpJ6AkscofnvgkWNTHiHOmtz8VXM3ATwnf+ZyPNfhGu7BXL2op4rbBKlRJq44tbHz8KRBxZuO/2cS6VaDXJ0A6k42Gi1PYOi4H6w5L0bezxkaO3S2vUp9GNIRuVP8GjluYrFtWClY3c1m6oLVcaPYSH2GtZhaQkPehvq8rlxSkbyaEcnvcKTpXFhbPOUieB2kNLzwVuTot3pLhdsA0nievOI25jdSRW6hUph5rBIIRaO+hrk1s4pPKaNZwC1mt/850qOODNgBJG8nVqfIBhMX7a4jssrNscrX4y78SL1klpcBBr3BWp/Swgp5DPK6JUCDa8qUX/kMNfCdQtdSvTZL8MqAQRyJA92b0OzgP1qxfhAwknbNFAt48UuFNVxAmtW7PA55nPm1hM6xjxZoz8D+TeEJ7zY2sSQawp4IOyf67LFkBX/eefxBp7O7VFLnEMTx/RIb/A2ZHdN68Jrdo3HoyggqXvid8jI+UmWGC0dID1vo7Tg8pB9eWHbM2Aoh9GpBtVOBnot/Ddeuh4+gFPp4eY6Q2BXrbYrnqUOoLHktGtCEOgtPuRwGUdHaiRo/FugQ/IXPaJYjlAFVp8ceepxAP/vCBTW/XL44TO+iDGtUvmEeUmDj0zykjWd8r+2rj7YMnc6cNAeWr6ut1I8QJhOBylnTtR54dIaUF+y1DWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?20e/mG6WE1RtSkT+QBQMiwSm2UiLP0CTy/+Jl+Wm463M+ZKJ2D5MIoYZS4yW?=
 =?us-ascii?Q?L/B47fAiLAVdEpBFddwH4qtS2SD+opLc+ynX8ZQZ6J0dLxEVIHQVHEDo09Id?=
 =?us-ascii?Q?46OUDfQqpbEXPY5XG67ZDkhw8tl8oGR+FdWtF3uB3Zg0f+Ows9V73NwYBABE?=
 =?us-ascii?Q?ZxL5fplTdeAA40C8+SUHmb5CULAS5aLo96brFPis9dNp0jknJVa4qq1zGIfa?=
 =?us-ascii?Q?WA3Q5QPFc+ZMwh4G3PYAPln1yjReQkCeTzWObGfQJCvoapP5Q4RPhyNDLE1A?=
 =?us-ascii?Q?/P9trT3+T0OkkSISJf1Z3JW48cBaiuXWJr4fwxEIQ0RXXKD96PEqOwypWp0U?=
 =?us-ascii?Q?wQzt+dG2t7cf3uVtnkgHipXyVHMPTb6HI9wVRn8ckASULCbq4ubVFqDzZVmq?=
 =?us-ascii?Q?s4/Oib0NdhZHCobEcjbCbLVR/UkAyhOnoAryC3WV9ITaKX072uWgJRUX/9oQ?=
 =?us-ascii?Q?oZb/ziMfarCXrLvDfOPsZ8MvtGCZBnQuiN4l5U43r8uONqTyc/WPE+YLqgXZ?=
 =?us-ascii?Q?PLI+qN3fRofQXQdt7mGQ10/U6q828Maox54DV7H8kzHiaQ/YJjdmfJsW5X08?=
 =?us-ascii?Q?XaDQ/SUqky7ElPxeKnQJlaQq4Nuozw7vKwV1ADUj97fXVn/FStFIPpCs2p/F?=
 =?us-ascii?Q?7nxELp1HldG7uNfSU64mQZTQP0Y70afhADoyiauzR70+jBmKO3Rc/+ZP3Y3q?=
 =?us-ascii?Q?Th1SGgmcUVfpoT9QCo0Ik96GvDOAheoibZ6eslVGC4JjqaOzUtFtZSGf4UbL?=
 =?us-ascii?Q?WYgbevh6sHTN98Yg6Rx3anniEDStxz84NzunU6JguyGTyoA+WYRYmdqwXK0Q?=
 =?us-ascii?Q?NxsvoSpqDnFmzbekpihlGieTCrCBIt9A5FYznZk1aSqLW5QiPx/ovEqVAWP6?=
 =?us-ascii?Q?qEukG07S4Z/fkm83lkkwGWzyzWXFmbjj+8SX39TuVYg14Cqmp0H29Icj77fV?=
 =?us-ascii?Q?KGeWRDIQ2XezTQ4OQ9z4ZZLFZdTTRcp2blk5O/VjvI9iOvxiQNNswKq/a9NB?=
 =?us-ascii?Q?jDYMulhY88wGENm53LIc16euvy19Aoyf+xXEQreHvmXg8Qakdm+xjVO7uVji?=
 =?us-ascii?Q?abPQ73+uUYvn7vxc7UDnppmXYktGoUYaLaLKZOokffpMxOPmrJnmkjX1vkxr?=
 =?us-ascii?Q?2XeYsUhSR4PFymos32qEb4O/GOboawhR6swjgwHytC0cs42OGt0gecnun/rm?=
 =?us-ascii?Q?16NesZ2Ai24D2fuJ1dNgFFrc4b9/XGPT8fWis1aU4ACPugyj2QLpPjPur+h4?=
 =?us-ascii?Q?VTMdwG3XCs0LCguHgwkc4AUAj4yLq/7mte1XzdxtyI1X2CutXkXTCFBEg5Ki?=
 =?us-ascii?Q?gLBomMDNpbUGsI5JjaBlGgSHfIxxf5DM+sWW24exP04xj4v/ifczGgcI/sZk?=
 =?us-ascii?Q?q3Jzp0f/PWCAzyjsdXVAqrFvVsJB5qNi9NY249OWCrrVvil6kDomyBXceRXl?=
 =?us-ascii?Q?71jUnjmz+t8n4q8RtgkHU5JaqUCa72pY0LZUjpcx49VpH6w5dgqMF2FtrQzY?=
 =?us-ascii?Q?h3DncJD1cXWwUWB+Pu4M8pny0XGn2eDlHYf4ZBKlYy1KWg3lHaIclw0p1uxz?=
 =?us-ascii?Q?vRwm6WPzFuZNI3ghlkkY9PUPOMe58S+JlEs6L3uZN6KPeXCA7giZ3FBT0FuO?=
 =?us-ascii?Q?9+dLTS0Il3l6TFeVfcghQnDat0ohhV2NGOmLIAtzNvURsx0KviNNunxWhKR7?=
 =?us-ascii?Q?Tp4PyVhfC0cXX6p5PLVeWzMp6MG+vxHoQEww0LmViBR83wh9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d4ee9c-a506-4d8c-6995-08de8e5b1e02
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:51:53.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5Uzzgi8qa9zSP7V0KpuB1W+60Fz/mtq7qmepmlKEyIErtBKktTYfk+S6+q/H1K1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9667

On Fri, Mar 06, 2026 at 03:41:17PM -0800, Nicolin Chen wrote:
> When a device's default substream attaches to an identity domain, the SMMU
> driver currently sets the device's STE between two modes:
> 
>   Mode 1: Cfg=Translate, S1DSS=Bypass, EATS=1
>   Mode 2: Cfg=bypass (EATS is ignored by HW)
> 
> When there is an active PASID (non-default substream), mode 1 is used. And
> when there is no PASID support or no active PASID, mode 2 is used.
> 
> The driver will also downgrade an STE from mode 1 to mode 2, when the last
> active substream becomes inactive.
> 
> However, there are PCIe devices that demand ATS to be always on. For these
> devices, their STEs have to use the mode 1 as HW ignores EATS with mode 2.
> 
> Change the driver accordingly:
>   - always use the mode 1
>   - never downgrade to mode 2
>   - allocate and retain a CD table (see note below)
> 
> Note that these devices might not support PASID, i.e. doing non-PASID ATS.
> In such a case, the ssid_bits is set to 0. However, s1cdmax must be set to
> a !0 value in order to keep the S1DSS field effective. Thus, when a master
> requires ats_always_on, set its s1cdmax to minimal 1, meaning the CD table
> will have a dummy entry (SSID=1) that will be never used.
> 
> Now, for these device, arm_smmu_cdtab_allocated() will always return true,
> v.s. false prior to this change. When its default substream is attached to
> an IDENTITY domain, its first CD is NULL in the table, which is a totally
> valid case. Thus, add "!master->ats_always_on" to the condition.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 72 ++++++++++++++++++---
>  2 files changed, 65 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
