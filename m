Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A3C3EF0BB;
	Thu, 22 Jan 2026 05:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769058358; cv=fail; b=kDVo7pWgnVYLfye3xWC8J0DxJy/El73WtCaPtHFYzG6ZElfUTly6TnUI49e9hAlalIbD7xtKzHCM1+Ta+E7ZOW2bUve3bIOX48kg5mig0s1uwCLlQ2Q6kaFPk+UOJPze4eKKkukp2tNXpC8oIq/lGon7d89c6wW3jf2U6IjvyE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769058358; c=relaxed/simple;
	bh=psN2bxL6UAvMae5QVNuOFPeX75Ugr3lBhI1lwidLkag=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JAn2oH8hyqrHwGDe3Yt3HbCZTVm5aKzzsq74WU10QqPV/N5tB3jdWHu/RTr2LjYZL/kU/sWiayonx7kYGB4YiJf4xif0WayBwHB3jREwTAZ9VpLuUoyQNf4TIXwM5dzsXTMKhTjaIp/I4UuBgX8k3qRcvxvDZt20KpVIyVPoTWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gdNhB1xU; arc=fail smtp.client-ip=52.101.62.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gdNhB1xU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhT5rePHV/foQ/+ERlsNYQCG+nGp5+hmnY5I12v/pkO4NKT3IptTv2TPrsGLBDi4oA1iMs8ybP3p6pMwsszDu/MDpCOltwtdH+IOCpP0lUkHACjVb0NzEW/DPPo5DEfcp7ekBGzprbs6LNfLRXBc8aN9AcePtKIQQaJpmLH6cs+eUYW93flHbVi2SnTDoh5/80NkIqCg2+/4gl/w6i2iIc0ODNzGfm26DfJODIZK6qJ9R0/PucHG9J3kLRCg0m1VadQgCevDVBOICJ2ccAsz1CrC4EFRQmXwAIdVB3X++v2OmAxCCNsuKvLjn/Te+mdBZWXD4C3pv4vmNFjwtuUZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyb31K08nK+gjlqBVsyVbk5wzGiCqyVfv2sHM2XE3dg=;
 b=ghTQOxYEPrNxJ2vCIIywy7CxhgtQ9hO1Zd4ndLFl66MIa1LJwA9IoYxIVnqVCvQRtgE+ZluukNmEAEY8X42ujHhOYZiuqgv19YxId1l/tUwVvAQezViGS+zBywn5Vf1NDLBWtaZIM1iszOpUMZOmGKkYlfViUFNdjf7KHp+J6NJ8y6vKSQ4t94WqV62cR773Gdw+ZL/9poRJdMFXXzbWCI3Kd4EHbFX7QwT6pPac1F+WnHtu62Fbbh20bJaLCr1uw3Tco/Xzc55+2ce+S6bZyo7nM9SDToMxZQdABG6nlKmEXOncOuS4ddQCLIgzhwes3+He5bsQyINjte+hhoHWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyb31K08nK+gjlqBVsyVbk5wzGiCqyVfv2sHM2XE3dg=;
 b=gdNhB1xUypRTtosZI/OBQX0CLTjrhxD+PBwkcs2p+IyEWQ1Bv7bMIXlxeXa+OBz8bRRPcs5IBnEajJbf9n5lkJn1hgkgORx98CGF2rjMWvfnfCWaG6enM1dle/U7G4pivZcRhzYZiK7lL9sd0KIeZ42UOxIYsDjTYDbS6SupVJ0=
Received: from SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17)
 by SJ5PPFCC6481C4C.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Thu, 22 Jan
 2026 05:05:53 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::a1) by SJ0PR03CA0222.outlook.office365.com
 (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 05:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 05:05:53 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 23:05:52 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 23:05:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 23:05:51 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60M55mx34060636;
	Wed, 21 Jan 2026 23:05:49 -0600
Message-ID: <5f83a07a-ef35-47e9-b40f-fc7617a4488c@ti.com>
Date: Thu, 22 Jan 2026 10:35:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix resizable BAR support for multi-PF
 configurations
To: Niklas Cassel <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>
References: <20260121054214.274429-1-a-garg7@ti.com>
 <20260121054214.274429-2-a-garg7@ti.com> <aXCjP8KZw1ig8i-W@ryzen>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aXCjP8KZw1ig8i-W@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|SJ5PPFCC6481C4C:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1b9085-51f9-4953-36d9-08de5973eb27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3VGam9BTzBrMGo2VEt6TVNJUFA3Z3dMc3ZDYU5OTHFYL0c0cXdDZExwNXo1?=
 =?utf-8?B?dm1mWW43R3FFTWxxSXVNM0dseGlpdE1lVThTQ3JacXhWTTFtNFZSRkY0a09S?=
 =?utf-8?B?NmNLYk9nclg1djI1VUtKU1RGMFRSTVdneWVwYWxTc1lGNEdBRWVBMFZMSlB1?=
 =?utf-8?B?M0hwNUNRK084YjYvUTF0R0NrSDd5eXVGTEZRRURTdjJNOFJOTXE2TmFHdUZ4?=
 =?utf-8?B?T21NMHpIZlNCbXdidDY4eUIvUFk1M0s5eU11SlV3MGx1TEZBbjZNQVZRRFh3?=
 =?utf-8?B?WnFzMmp2SHNwK3FFS0dZR1daNHF3ZlNSNzYwNFgybzF2UnppS20veEpISGVw?=
 =?utf-8?B?eEVmdjFOOStRMUN3WEdxOEJ0UG1KM29HRlUya0tKcm50M0kraml5U3kvNm5o?=
 =?utf-8?B?eDNKRmVFY1c3bXhPajVSWUFYQ3VJT1N0NWtrcFNVbHJ1NDhsTWNoRUpNVzQ3?=
 =?utf-8?B?S0owWm9INEJURmg3ak10ZWVseDhlMTlRcUZVQ2RCaTVOaGs3MUVtbi8yMExt?=
 =?utf-8?B?dGJuT01SeGFScER2c21jZ3pURFE1TzhFblYvUjFJa2NoL0VzOGdQaUdpdFFR?=
 =?utf-8?B?SjNaTEQ5MW1oUXVFWXlSNjlkazV3UE90dG9tNlZoL2xUbmtVRnV2eEFVWmNo?=
 =?utf-8?B?RjhVMkxRcUlIL1VSZHI1NVdmbzR4OHluQndrd2ViSXA1bjdEYVBPTDZ3TTBo?=
 =?utf-8?B?bEo2ODNBc2owKzNoWk1GOUtxT0VNTlVXTmU5N3JRMFhPNzhZQ2pMQnhLcnU1?=
 =?utf-8?B?RmZFRklDbFc3VEowQnFvcnlQcGFKTC9hV04rRUp1VGpDQkh2Tzh1TVVoaUJC?=
 =?utf-8?B?TDNXYjRTWC9qVkhQbG1kQXZhZ2FodTdNajNjL0hleldiWG1QM2c4M2JlQWNt?=
 =?utf-8?B?R0VKUnFtQ0Vaa3R6UTBtSm5GUTcxQ0M4Q2RaMGszZnVOc0tjMFk4M0EvSWNS?=
 =?utf-8?B?SXJiZmxOWkRFZ2puVnZObXRZdFdnaEJTQkMySWpJT1JxYm9ocmVnVWxkTFVQ?=
 =?utf-8?B?L1dRZ3ZkdXRwUWdwYnZXcExRQ1E1RndZeFVYS1NxZS9UWjIybW9UWFpkRnI1?=
 =?utf-8?B?SWpqNXprazBUMHpnRHRoQ0VUNUVoSURrV1ptekc2ZnJUNDEyK211dUFYaC83?=
 =?utf-8?B?WEtMRnVwMDdTOXZQSHN5ek5KODNNL3J5T0JZMXlZM0VyS3R1NkRhcENuZy9p?=
 =?utf-8?B?Y1RoZHRiYWZ2RjBNMmZZUXlTLzI1TGppN1pNQmdRYWtVNVNOYlcrbTFCdFQ1?=
 =?utf-8?B?L2ZnMVdKOEdiYStvMVp2ay83K25pMktadHh2YVNQdm5wejlBQS82WG5ZeFE5?=
 =?utf-8?B?ZDczU3ZYRlZEcmJjZlpkS1lJN0NJS2pFbkdBSHpHdm1kZ2JFZjdrZU1WVkhw?=
 =?utf-8?B?Z0taWEJqWWplQXdBUE9HSnF4MXQxL3ozcGxkRTAxcldtL09MTUhGRENRRm9u?=
 =?utf-8?B?VXFYRTNsWXZMT2pvUUNVNE9CSnZBMkJYVExrS2N3MUNhaUJ0Q1hJQ0hKL0pa?=
 =?utf-8?B?SlFUOGNqU3lmVml1Mk1pVlkzbzVYcVU1enFOYmpLWEVTMVVWY0doOEI2aGJl?=
 =?utf-8?B?dDlYRlVnRUdQZXF6dFlkYmh6bTRtWHJ0ajFnVCtPSTRiZUtrUzRyeVN6SWt2?=
 =?utf-8?B?TjVaNzk4TDRlV3JJWWlMNlppaitoKzYwSlVmL2dGVVpFWUhzbzFzL2lweEdp?=
 =?utf-8?B?MkFoOWdwVHdMVkNYcHExNGhxaEdNS2wwSU5BdWIyTENGcGFiaWV5cFdPcVU0?=
 =?utf-8?B?QW9WV3MvQ3FxMi94QzYycE02b0ZUSDd2cktIZjRzTlVFR25vSHF1V2J0aDlJ?=
 =?utf-8?B?R3VzRFRRaHJ0TGhDQkp2c0JLVHhrWmdpR2xYZU1mKysrNE92SExyUkt1NmY3?=
 =?utf-8?B?L0RzaWtyMFFsVWFDRm9vVDlOUkVidnZjcllsRm01Z25zRDJVRkg1dkdJdVJT?=
 =?utf-8?B?RGNhWUVKR2tsalRqWHpMYjVaWEt6dG1YTmRseW5FZXR1cHM4cWl6OVdtSkhu?=
 =?utf-8?B?Nmh6QXFCSWlZdThUMnhuL05xcVdiNVZXTzEwd2VJSGJaVUh6RTdRYlNlK2cx?=
 =?utf-8?B?NUlObDVBcE5iOFVrSDFTanRjbk5LWkc1Q0o0eTQ3LzF4bUR6NElsaEh3YUk4?=
 =?utf-8?B?Z21mOVpKTEpFUGZtV1o3WlNrdzg3YUEvQ0ExVWRZUVZ4d3YwUDFUQUhBS2hl?=
 =?utf-8?B?cEM4dmtBeXVNUmxrcHNsenBKeDh4RWFFcHNsa0MwVGZYcHF6ZWlLR0xUMmw3?=
 =?utf-8?B?TEpJQ2xzZERzcjd6c012WGg3b21RPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 05:05:53.3282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1b9085-51f9-4953-36d9-08de5973eb27
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCC6481C4C

>> -- 
>> 2.34.1
>> 
> 
> 
> Thank you for fixing this!
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> 
> You do need another patch in this series though, that fixes:
> https://github.com/torvalds/linux/blob/v6.19-rc6/drivers/pci/controller/dwc/pcie-designware-ep.c#L972-L986
> 
> As currently, ptm_cap_base is fetched using dw_pcie_find_ext_capability()
> instead of your new dw_pcie_ep_find_ext_capability() which takes a func_no.
> 

I examined the register spaces across different PFs to check whether all 
the PFs have the PTM capability registers, and confirmed that PTM 
capability registers exist only in PF0. PCIe r6.0 section 7.9.15 
'Precision Time Management Extended Capability (PTM Capability)' states 
that " For Endpoints and Switch Upstream Ports that support PTM, this 
Capability is required in exactly one Function of the Upstream Port and 
that Capability controls the PTM behavior of all PTM capable Functions 
associated with that Upstream Port". This indicates that PTM 
capabilities are controller-level registers rather than per-function 
registers. Hence, in my opinion, ptm_cap_base does not require 
modification, since dw_pcie_find_ext_capability() and dw_pcie_*_dbi() 
already correctly access PF0's register space, which is the expected 
behavior for controller-level PTM management.

> 
> Kind regards,
> Niklas
> 

