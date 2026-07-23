Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012010.outbound.protection.outlook.com [40.93.195.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7438E5D7
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825479; cv=fail; b=LCKYs9+NP0q/c0IAWlR9+Zw/WaX2MpBoxVckodt5onC1aUxiTqSkFOZnUEcJ0Fb86Ox6JHYsDhlav4Oxwr0LOzK0FzmWfHAHg9FRdkwtRZ3picLpGO/lD0SXuJADtxef2CgJBkYj+4TpHIM7pD3bx0Rc7sUcwORPgnA/dN0lOk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825479; c=relaxed/simple;
	bh=qYAf3FEFKqPiHFDa7KLaR9uxEphREhCw/R5MTDPNmR8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aihm3FmTZVz8EsNOHXkaCRypfEXzxFKwcZakYiRmTTQr1GX/4WFi7Ecbj++9p3AfcQfd1F7RDEKT/RM80S9s6tcdvRdMi3E9dTOB4oxUODQI+xPX1U97uuY6szFiecdwEXmVmEUttkoLeQfItHZ3hoNt/MaFk23qgNGaXZ2OonM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iv9TeAzo; arc=fail smtp.client-ip=40.93.195.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iv9TeAzo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvmIh6bsHBA74Q0JWkDLDXqyQEGOgmXDavd4u+gZzcv+kTiWEGoBU1sp6AEZg4S4oXrt4X7DJUe2OeLy8Rc/HJlpe7EXzvlzqW4C9qW8BbnYMxtFgZceHVKUEuQilz8JMHVC4qaTT08Pk94MrSaP8KND+PCZzIhRirNUpLZz8apx3SojHriiEAu/PBfDoTy0/qOd/x1KASPYrqmZksfQNHx82piOa0t4zmvu8HgkSwknTcsEy/MAXftbmnBYPdJpCmS8SOwF7cxrQorcd/B2mZEI7jS49AQ8SDgPsDcCfu+455S0k971kKxDtWanno2SnfEtsSBL2SU8Li4PnKy3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQyvVcFdh3XWGjugkZepk656rV1Kg1CdaATNy7sPJdk=;
 b=Kq7Iw38Yl5iCS+aQvP/Q/AhbJ8U62wRupfbvKH8tnWLvhi9bIO84I5RSPdv510tkgIqm9XLWxDPWUMsZi4R13EFjhdV9DIbs/v3w6H9r9TKodTgm729IgDJj0ZFr9ki47ib+56ouoilHkFviyWuTY8t3J3q+fuj9mA6be7BoRRuGsOUsOq2wzQr3DQk0Lv3pe5abT0JpZPoy+2UiuaUy1IhG8gihRvCxs5WeOm1lsKtK9MRHu/KLYHmCCGvyI5/TO4ObAyCXKNHcc8d0z5jZLjU9vrt9tEB6gAT/86tjcU+znySJQnoTrmbhiU/Mn2R4JYRCODLy5MzwfpN88kRwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQyvVcFdh3XWGjugkZepk656rV1Kg1CdaATNy7sPJdk=;
 b=iv9TeAzopgFiFlcu8eqrHopVleM4iFFldNJ0GQ6t5Ajmqc2tBAID/5Ea7gYdUd8d6AaPBIZyp4IDEMvELa42fypeeWNarcy1kvnhBFLfwBVdKK3q5+X6PYhIidD1RSB8Gx/h8ISQQFAfgI8S+mmzrk5yHdck3SE+ueiLim/M1hg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 16:51:14 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Thu, 23 Jul 2026
 16:51:14 +0000
Message-ID: <f801bd33-1af5-41c9-aeee-bba8096414e5@amd.com>
Date: Thu, 23 Jul 2026 22:21:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: Mark Radeon Pro WX 4100 ATS as broken
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, alexander.deucher@amd.com, jgg@ziepe.ca
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-2-vasant.hegde@amd.com>
 <20260723154259.GA836122@bhelgaas>
 <2a9f85b9-7fa3-41ab-9383-ffa1f44bbfd8@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <2a9f85b9-7fa3-41ab-9383-ffa1f44bbfd8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::15) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbf4554-4dbd-49cd-dbda-08dee8da9b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	BgAE2nbSpvjd3WPzwlM/6u/ab0P7i8bCjtYGRFE9QT3dlieQ1NnCDe1JyOB0K2xF0Jn3iDQ/lXHz/tXuqFCHh5mq5l+WJURWGCS1eeDUEMTKg+h+ERIeMjpcJpt+E9VMCwVfImaNSg6ZX06iNiNnvYABdHbFKsW+ijP2ztT6TxHJiPW4yVv7ozf8hKsdfHMpg5LFxbkCLsGTGB4JQ3uAx58v2i7S+yoyAO8T1vNqD4spZTNpwcL6KZXEIqf3nAGKbaedLY4DVNfwOoy4S3qiX0B35o/ALRlcThbLN5GEtMcYztv5IQZM9IRdAA3PyxQPWqgXBnujMjwNNIW3apB8ql1EBMjKs8FaKpRppzPOHIzve2RBsHni0vub19JNiWzBRu6zzkfSfZHL+TmYo5fPHCPO0atskACs8vdU6ZxgMYgjmIyTMfDycJi08+BQmkssVYfXhccUgsi5Yk5hDASFLzXQJDh8+6nnUaCs8nnUz1wqO6TD/BH0haRe+JoQGDtQ4NviyFKxYRLUgVEAqMqAw87iYkkd3fyTR/frarbaxijMcYiZL7/RWG+JuBBt5baWVTc/bCWcBwwiCmNCUhM9gKSnNep/8OUxdAqddHSsnSReyL3xEchPvI8Vr0csfP0vPMlnHTBOcSKi9ct6hYhVm5oEyw/zT46Lybr6htctlKo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnhCUzhxMHRnb0JqM1RCUlBrbzRSQ3l6UU0wV2lva3VFb1BYczVJK09heHNQ?=
 =?utf-8?B?MlhhNFBQZnBqWEJxQ2Z6cGVEL0RHLzdIZDZFRHFkaE1pT25YWGtVN0dVNWdh?=
 =?utf-8?B?UGJiNldVaTd4cXEyK1BPa3AvN1lZMkNaMVVGeTBBRmxVTjh6amZSVkNmTEdw?=
 =?utf-8?B?VDRxUGpOWDVDUmZsU2t4b2xGN1R5RlgraGEzRXVHQk1mcjc5RTJiUkpzVnQr?=
 =?utf-8?B?ZWpOdHN6L2d3VVF1d2hGMFNqOXF4ZVFNb29xazR3aXdJTFZINFFDazhlcEFu?=
 =?utf-8?B?emJucEFDOXZ1bGNqSWQvYVVhZ2N0dDBjMEFhQm95dFVaR2ZYR3gvRzJZUmRN?=
 =?utf-8?B?Qk1WNjgzekZmVkdPVjYzN0tST0RPN0hxN3BYYXV5MTM4R3VaUmY5V0hmSndm?=
 =?utf-8?B?cmk0M09OZDVQRjNoVWFtOWJuVGFzRmUxajBodGs3aTl3YTZ1WWljTWFyZVFQ?=
 =?utf-8?B?VnM5eVU4Z29iTzQrV094ZEZSOXZBeitwbHNvZ3ZYaHRxcGgrOU4xN21ENk92?=
 =?utf-8?B?cVlJQ3R2dnRBRnVHZVpscnMzeXY1bFY1SGxOTS9MMmVLdzZIc1p4U0c4VEJJ?=
 =?utf-8?B?Tkx5SXl1d1dpRDBqenc4WGl6NWtRNXFhbXVTcFEzM2ZoS000Mmk2M21GS0NT?=
 =?utf-8?B?bWNZQUN0MjdhaTRhNUR0c0FDOFF6dlVydWJGRzhEdUsyeE5rdTc4cFZ2L1Ni?=
 =?utf-8?B?TFBqZFp6WndIL3NCSTFqaGNMV1cvS2JjdXFwc0FTWWpXU3FDTGxvNk5peERG?=
 =?utf-8?B?THhHWTVRRFNTVTdaUlBQT0ZwRUdXL05LODc3am5KQjc1czhJeGhJR3RtYm5i?=
 =?utf-8?B?ZjlxQVJOMW1MQlpSMHVrK2MrbzFHNFRVVzRZMytKOXlJSkFCYVNtQW1FdXln?=
 =?utf-8?B?RVNvV1JkaFh6VnVLMDUxTWNUeS80M3pwcURzcGhnbThrOXlPU1Bsc1VVMDN0?=
 =?utf-8?B?MGhnWnFsUE5DR202VmlOY3g4bFBCQ1dibTB3dEhzMXlicHFKNmQwSWpCd3U3?=
 =?utf-8?B?TjN3NmMrN0VJck16ZlpvSDY5ZklEOEJkaENjUktNOVhnc1E1MEFENy9OK2Ix?=
 =?utf-8?B?ZXJUSUp2OFo0SStsNFRBK284SldwVFFpSHh3REpQUE9aSWk0a1lsbDVqMlI2?=
 =?utf-8?B?UEw2VzM3djdnUmZXeWs3L3ZIcWplTlRNNElDbnFKZjE0Nk1GTzVDc21FZ2Jj?=
 =?utf-8?B?OHNkLzhWYmRzUVQ2dzBLb1lNdTFESXNuaTR5ajgzN2dWNlhIRGwxWjQwSEtV?=
 =?utf-8?B?OGlsWDFmaWl3SVZxWDZQOE9iOU1DbzYwdTJzNnNYRm8wTWVFZ2doQVlIUU9N?=
 =?utf-8?B?Mllnc3RnZUkzMXE5OUNSamRqUnUwUDNoV251MjRib3JTajVpeCtpSjBYZ21L?=
 =?utf-8?B?RVZqb0QvNXc3N2RKWGxLeTM0QmRTNmV2d0xEZE1Xb2U4SDNJQlRZMGZQNG8w?=
 =?utf-8?B?cGlrRHdhTU13WXowUlg3SDhPd0VlMUtJbmQvSzFPbkF2NEhzOCt2ZUo1SEVp?=
 =?utf-8?B?UmxxbTIzQzNpNk9HL3pENTJvMDJob3UvYlk0cjFkSWVuSlR6S2FVWEx4M1JL?=
 =?utf-8?B?WWhQd2hTQjJYK1M3ZXpiU2dkQnFCREVrZHN4OEhaLy9SUTdvSnVMdGdROVB3?=
 =?utf-8?B?VHlzWStjQlh6ZHNhY0JLWFU5RVRNVHRDV29YZzdSbk9xdDFieldqbzdpL0NN?=
 =?utf-8?B?TklteW9WdGRKZlZSSjdzQ3pMTGdDWjVEbGFhdmZzRUFUdm0xbjVseFdMK0hH?=
 =?utf-8?B?c21RZ2FZTGI0YWFZWXB0SmZ3MFFjQldRZVBTMWhsdkJhTFBZTk9TZ3VoT2Uw?=
 =?utf-8?B?ZzNsZDlxSmg3Zm5OZThSaVJWQlFDUDY0cWl0a2FEV1VNMWo2VzVwTEpjUE1I?=
 =?utf-8?B?WGk3T3cvMjdZWDRST3gwVGlVcUxWZitBazdVOFRHa3FGanowOWdseTZIOENE?=
 =?utf-8?B?K20ybk9abE1FUXQrVW1kajF1dkxKNXBuL2cxU1dsWlRLUHd3dlMwenNMRGpp?=
 =?utf-8?B?cXl4SDMxcERhb3NBOXdHL01GQ3dOMU14NnRRVmJJUFFSVDJsaVhaMXEwMlBM?=
 =?utf-8?B?UE4zNzhFWUNPWjEyYlBBb2NCaWJZMFR5a3JkaitLUFZvSm1QaGs4cGljR3oy?=
 =?utf-8?B?RmhEUTJXb3d4YWljZ3JSQlowclk2RjZhTUdYYm9rNkZsd0ZsZ1Y3Nk9UUFhD?=
 =?utf-8?B?Vms1eWhLdzZYazdsc2pUeWp2eHlGcHVpQmltbVdTb1M4aHZndmV2RUtReDQr?=
 =?utf-8?B?QUR6ZHRXNmhLcjhMbk9qakFRZC9iQ3owSDdqRCtjOXNkeDFocFJHTXZEZzZS?=
 =?utf-8?B?K3R6eXBuSy8yMlZVRjIybUY0Z0hTVStuQVU0dWd4N1MxNE91OEJQZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbf4554-4dbd-49cd-dbda-08dee8da9b49
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:51:14.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNZCiG7lZ8ftx6wd33GW2w++nBgRt9xdLVb5SyR602u0Db0s8xYyLcOzS0Ejj40hCAQbAVJZWWt2J2d76TfylA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876



On 7/23/2026 9:15 PM, Mario Limonciello wrote:
> 
> 
> On 7/23/26 10:42, Bjorn Helgaas wrote:
>> On Thu, Jul 23, 2026 at 06:15:47AM +0000, Vasant Hegde wrote:
>>> If ATS is enabled then IOMMU logs below error and GPU fails to
>>> initialize.
>>>
>>> [  103.687137] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
>>> device=0000:c4:00.0 address=0x1080006060]
>>
>> Is this a published erratum?
>>
>> Is there enough benefit to using ATS to make it worthwhile?  It would have
>> to be a pretty substantial benefit to outweigh the end-user frustration of
>> defects like this.
>>
>> If ATS isn't going to be validated by vendors, maybe we should disable it
>> on all AMD/ATI devices?  Or maybe only the GPUs?
> 
> Isn't that a pretty big performance impact to have ATS disabled?
> 
> At least I don't think I would want a blanket policy without data supporting
> it's a good idea.

Ack. I will find this GPU internally and will run some more experiement and get
back to you.


-Vasant


