Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E193E4915B8;
	Thu, 10 Sep 2026 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049714; cv=fail; b=tpG3BtTByiIw8b/WULMxlnRYMm6CCYhttuB3zC0BEYyqbotHnCLP7zthAbl+lZY2mVD/kRnulVAVykEfIc8KKs5dmCLYwMoMeHEn+QaYn4r1mjLXj0A7+zlj2ie046juLDaqb9i9ZDYvlWUnLKl14Xaf/YNuGgBa2VC4lgvrVA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049714; c=relaxed/simple;
	bh=v9jPjxQatNLJoS9qqBb7/rWKV0znrelZv11tIyWjiJo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AvZUQwCfYoFkg9fAt2EX2UBAfOqybCSAWREBTAgO5NGYmc0xpYmze9O6E2Ru2hnrM2unwR24mXamYnzVt0hHq8jIIarXAqgSRnUNfKtA/x054FVYCsAVlclTsFHqwoiFSpGySdwHLCu/MJbBBn2sWkOkzlJNaSQtvWhw98P5vxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3ev0Osnk; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3ev0Osnk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojHqwgd6+2NacQUpc8uD9ywiiC8IxG1haIMw/FPwqVuUGywrmusSytac+sBJv8dVR9cMcxdnhR4xQAZwfEIdP94k+m+00lmRFerCVFvOTpvcIQUM+pnhIkPGfBWFyLPMWnCFMpP8UaevnyTcCDTYyM0vRis3/gNiDI6suuMaOWHq6l/Yhtos2FwdfuuXJGtGnKHKjCZQ2jzU9ak5rMuXzmmwGNqk/OergJdujXnz8UhR4d0MCbivE8On7clk8zfadLlSXUOPY8Nscc4Izm71Lk84KXsJDjlVF7o6HA6801VoAwMIXCElHxLidvH9hoXiCSe03hJLuq7bOcOxWbizFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSFmjN9Mu8MyP/TvcWCYtvWHMdG/SefIBzbDNQn3IpM=;
 b=aKOv6WNA768EWYmFza0Z7NxxpC3VzSWfSRz3kPeLaJuEAEJGMJVPndWBGZZPnFl/OnYvGX96A8bjuDyw96/T+uhmMTT6WzX2wYHf7gOBYGj5UFQxgV6xqS/58KHNIoLsIV9CjuJLEZW8oUiI0CSSCnZPUGnAHWsOUAfcjDNDirTfljO3IblLG/EdJ0dAvwa9BYhk3JL4Dv72eIEFEL93rHvaijQIkVXp9GxZ/3gx41Iix+7KKWinOfcaC+6xgUUYwNFrdvVxzgvu7UCxhr71NMf1EiWw0taC4kstlLPdYPvIitGI40TwozmOQkDs8IRagR87jiv/jbD7g/cBw4Vu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSFmjN9Mu8MyP/TvcWCYtvWHMdG/SefIBzbDNQn3IpM=;
 b=3ev0OsnkvYpNZr0wtPbDJkY6F2bIQOuUfm4MPcCG3J0N/cZknyoEEQJFZ5+d7gjEbzxN5MeRjGokMnBITUecYo2pK4dj0qBjXe/6flX4X6PV+02cIAp7Z6LQn8FMfW1LDbcclT3Nptp1ZGSPcb4kUpED20MbIf7Pd8sTqi0UDow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 14:15:09 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 14:15:09 +0000
Message-ID: <cb98a268-c709-4489-981a-07d662a1f4da@amd.com>
Date: Thu, 10 Sep 2026 19:45:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
To: Pranjal Shrivastava <praan@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
References: <ao3RF0w_AXo5EXxv@google.com>
 <20260825175315.GD3325090@nvidia.com> <ao3oHn8HiXIx5Wrl@google.com>
 <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
 <20260826122147.GA3666382@nvidia.com>
 <bfb7be5b-2da3-4bd3-8146-9bd079011a75@amd.com>
 <20260828115331.GC3922654@nvidia.com>
 <399db967-050d-48dc-afb5-5c77ee9cce65@amd.com>
 <20260904142547.GU4157646@nvidia.com>
 <9be08ef1-7ae0-483a-938e-17e606b5d214@amd.com> <aqK04hq575iwY5BR@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aqK04hq575iwY5BR@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::12) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: d37a1e85-ff90-4270-214b-08df0f45ebd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|4143699003|6133799003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	p4c2ohItO57Y4pg1mz6dWKMJ9ADShgb8/2Tk/qQ7lntcwmVrgaLf/XpKy3gETk/cTIZuJ75fx3BCTQYK6d+hmLst9eGrZ4tExcgUHE2CWnDpoFCtRJGkDstQZMgiZvFxCswBfp++ahRwSBon7wf0Upi97RUs3luTmbbNDmdzPFKxJ/sJIBJvj7QahgWyvCZtYu66Ml4bMStAln0DSyxNYo/3Fyfr7blFsoOba7MMcDQ889ioMkNJsetVTA3BnVbY1J6BysQg0QExzvG7q6zUSSVfeDYkSI5s4bop9L/VPCyoXWvHEOYJM/5wfSgscT9XHEF05Nv8pPHoVRhU17GtBMxQMR3z9GJpx33CaOqKE/VumUrFjvBVIg4ljLjItpwenCNnTitfJfaHaAM9xdMeyURAMcHvCNnZHr00c6Q2CiWOSCobRKi5Od1vZsvET7QOCRh5Auz8NiEXJ0zFbLBTqqWYFattXbt5DGkC397DWMUoFN6ZEkPEhvn6pMXKjFPHRI6c3Ri6OLrNt1hm10Cz8EnHyX69k5DS222Q7NQsfrTvquLwDBULhFN5ZiEqblyeTyfMG5HJ56MnX9F+xiFJr1NCK3IPxN/f/dh5KuF5fBwppZZc9fnLyMqdhmPVbOWGTw3CxF0GbJBW00ITTMcI2uGAfKI7mZtDRE7kfM2ekS4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(6133799003)(22082099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUxwdmJyMnp1cDVkQ2U0Y0ZKSmhzOEN3ZDBBU2M5RmJPTFJPUHc0VUMxeTJq?=
 =?utf-8?B?RG9kZU5aTVpzYjhndEo2dkorUkgyKzdYd01EYzNCWjh6RTR1MEwvc1RHZUJZ?=
 =?utf-8?B?bkpnYkJmcldKaktoSis3TVZFWWloOE9IRUhQeGliK1lLOXRZdlNLVjZEMmRx?=
 =?utf-8?B?RndvT3VYajVIbjFvN0V5RHoxa041RVM0Zk0vTlR4dFNWUUtwQlNkcXRQZ2la?=
 =?utf-8?B?RjlxUGlkb0JNU2EyUUR0MnMyeHRkQWowZWhGdWxQdTIwNnJjYk8wVUhLQk1h?=
 =?utf-8?B?RW1XOTVPdG15RTN3UVprc2lBMG9LbEdoSEdYUmFiUHFueGtlSlBiaFhpKzRP?=
 =?utf-8?B?S3BkbjluaHB5c2xYY1pWYTkvYjluc210bUtYQ0pldUZxYUtCcG0wWFQ2ajAr?=
 =?utf-8?B?RGdQd1FOZE1IT09odVBsVEJOZzhHUGorRWZaOXM0VUJqc3lHVzAwVmlVLzk5?=
 =?utf-8?B?eW8rcnQ4MTlDM0VxZ2dmYy95dTBKcVVYQ2F0M3dXK0RBSE1VQjB0OGlzTUk0?=
 =?utf-8?B?Z0U5dU9DWXhOMTBOcllmSmF0QUlEbHA1SE11aUZBTHZyU2xDbC9CQ2FBNElZ?=
 =?utf-8?B?QU9lMDVOVmlUSXFtdUE0bW1uOUx2aUZGS29XSUNibGJmT2VJVzNyVWhqb09t?=
 =?utf-8?B?cy9UeTA0SVZmV21EblQzeUl1SlFsWjNOenZIL0UreE12Y0RHYnR4bGVSZ2dQ?=
 =?utf-8?B?VzFxSVBlakI5by9Dd3E2Y2JWNGVlTHZENUV3SG5Nb1VCUTVTaTd3Nm5tdlB4?=
 =?utf-8?B?ZnpOZWpuTTRqc3g1ZktUd3dRY25KTDc2Vlg1NU94UllyUTM0dENxMG1QZjlM?=
 =?utf-8?B?N24wdWF2dlRXNXJBWkUwV0hiZTU2R1ExRVVBN1FhNm9VUnNDdE5QV0dhVFpi?=
 =?utf-8?B?Z29wV3pXcTRtSHVHWXBqVTJjZnFFa3JtcHlUYUFrb1pRWnJIQXJvc0VWNnJG?=
 =?utf-8?B?OGt3MWgrdVhJNUN2QVlRSis4ZDVkZE1kajk1Z0JRQlhIY2ErMDhUVkExUzc5?=
 =?utf-8?B?MkxETzNHMVhRS1JYUkNQZnhyS0VlTnVGV0s3azkwWjFJN3o4dkwrZitNNFll?=
 =?utf-8?B?QkszNmtyTmsvMmxxRUJVcWxGYXB4aEtxaldRV2w2OTd6WlpIaCtTTlpBVTNR?=
 =?utf-8?B?YXU2VndVSlZCbGg5aGRmRHRwQjhNZXFYUUF4Q2VJQXJpNjRldjFOTjJrR2VF?=
 =?utf-8?B?cUs3VTlFN1R5R29ldCtYTFpUS0k5eFJnSVgzN0NrNmlqYTlVY1RNMHBBa3Q5?=
 =?utf-8?B?MFFncXlDNzZtbFpYNmpyVEhlS1VSdlIzdkZmbkIzN21iODJ2REF5aGRKa1g4?=
 =?utf-8?B?LzRBR3lzdjIvc3ZJS0gxUlR5cUd6c0pqTWhJcnI0REh0VjVuMk5yNDNid0p4?=
 =?utf-8?B?YkpaRFNqNEJzRzdQVkI1Q1VwMS9aMGs1MzVCVWhXY1NoWTNKTFRHRVd6REQv?=
 =?utf-8?B?Z2dNS2Vjdk5WcHRNQ09wUktDK09LS0FHN21TajF4NlF1bG4wSlpvdkVLQVN2?=
 =?utf-8?B?SStHYTR4dGFsTkMvcEVJSnB1SU5rbDVYOHVXVTdnV1ppbmdKY2dBZDlkKzM4?=
 =?utf-8?B?MlNiWXFHSVlGL3NlcVFlVHJZZDRORHNJMGFDMnJxai8vVUt5NCtSa3RwMVo5?=
 =?utf-8?B?WHJQa3dGdTRJUGlLbi9VbDB4d2QvR2gyU1YwTTVlYkwva1lCcThqUHUxZW80?=
 =?utf-8?B?aWxEdnowZ1RjNlRyU3lzdy9ianozeHVlbzVzZlJEc1RHaHRPSVVPbFZrenB3?=
 =?utf-8?B?RkxCUnVQMFNjZFVDc1JLOVE0K2gyZXlpbElvTVZOUUJ0Y2lWN1VNOUs1ZTlp?=
 =?utf-8?B?MzIzem1iTmhSNmRRN21xVWd2cDMrOHQ5c2tUb1haT0FuQjMyejRWcVZTVTNX?=
 =?utf-8?B?cms5SXdBQ3BOKzVGUVRrRTBXOTJJanNuRzUxN0Z6S08yQzlmbXk0MzZaVGxL?=
 =?utf-8?B?VUc5STM3bCtOQmo2cDdRTDN2RmU1VkV5ZDFYN0ltT1ZQQjMxOVcvOWpIUVpN?=
 =?utf-8?B?b1lSS3NLTllPVnBlWE5YNFNpc21rNXFvR1c4ck1GVy9TUWJTTzkwK1BGVjJI?=
 =?utf-8?B?eXBvUVF6dWFaSklqTW1PR0ZnTm1SVTBPVkV6Y29XZmc2SnRxZTNJcmVod0VG?=
 =?utf-8?B?dEZFZDBVRTIwZW1SQWVpREZFWXVQUncrK2s2bURBOG9Hc1hELzBPMzZXeG5o?=
 =?utf-8?B?elVybGk3WGVvUXd3T0k4TnAvbUxjOEUyaTVaQ2ZVb2F0cG1EQ0dDaGJKQnk2?=
 =?utf-8?B?Z2twcTdTemRWUERBV1U3cWk2WkVJS0s0QUxCeWJSMVNITUo4L1BseXZTQmhL?=
 =?utf-8?B?bFhCbU05OUd5M3o1S0hlRHFxYTcrdlpLYmwwNHJLOGZjeitLSFNJZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37a1e85-ff90-4270-214b-08df0f45ebd2
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 14:15:09.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heSQ0pBBsdGu7C2fO4vtWRHIcgYyAYVmT8YNuo4A4lQUrU2E8JWDdmCYcBDbb4hLlb7U70WpO4AgBRpLkm8O1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219



On 9/10/2026 7:17 PM, Pranjal Shrivastava wrote:
> On Thu, Sep 10, 2026 at 05:25:25PM +0530, Vasant Hegde wrote:
>>
>>
>> On 9/4/2026 7:55 PM, Jason Gunthorpe wrote:
>>> On Fri, Sep 04, 2026 at 03:43:01PM +0530, Vasant Hegde wrote:
>>>> Jason,
>>>>
>>>>
>>>> On 8/28/2026 5:23 PM, Jason Gunthorpe wrote:
>>>>> On Fri, Aug 28, 2026 at 10:46:48AM +0530, Vasant Hegde wrote:
>>>>>>> Having the driver boot up with all DTEs programmed to identity (eg
>>>>>>> 0'd) and then try to fix them to blocking after the iommu probes
>>>>>>> devices is security backwards.
>>>>>>
>>>>>> During boot, it only sets dte.v bit.
>>>>>
>>>>> First it clears it to fully 0, what does 0 do in HW?
>>>>
>>>> IF DTE is fully zero, then all requests are blocked for that devid.
>>>>
>>>>>
>>>>> It doesn't make sense that you'd pass over the DTEs after
>>>>> probing if the original 0'd DTE was actually blocking?
>>>>
>>>> During boot, it sets certain default values includ dte.v. It doesn't
>>>> clear everything.
>>>
>>> ?? It starts out with a 0 DTE table? There is no inherited DTE table
>>> except for kdump.
>>>
>>>> May be we should just remove ignore_device() completely? as
>>>>   - normal boot, its not yet configured, so no DMA is allowed
>>>>   - kdump boot, old DTE is still valid and let it continue?
>>>
>>> Yes, that makes alot more sense to me.
>>
>> Ack. @Pranjal, Can you fixup and send v4?
>>
> 
> Ack. I'll remove ignore_device entirely and drop patch 3 for v4.

Thanks.

> 
>>>
>>> But this comment is also wrong:
>>
>> Yeah. One of the cleanup patch missed to update below comment.
>>
>>>
>>>         /*
>>>          * Order is important here to make sure any unity map requirements are
>>>          * fulfilled. The unity mappings are created and written to the device
>>>          * table during the iommu_init_pci() call.
>>>          *
>>>          * After that we call init_device_table_dma() to make sure any
>>>          * uninitialized DTE will block DMA, and in the end we flush the caches
>>>          * of all IOMMUs to make sure the changes to the device table are
>>>          * active.
>>>          */
>>>         for_each_pci_segment(pci_seg)
>>>                 init_device_table_dma(pci_seg);
>>>
>>> The DTE starts out with blocking because it starts out as 0. This
>>> isn't making the DTE blocking, it is doing something else. And it is
>>> very suspicious and racey looking to me.
>>
>> IIRC there were some requirement to keep V bit ON. Otherwise I don't see why we
>> should set and flush the dte here. Let me dig the details.
>>
> 
> Should I also update the comment in this series? (It seems less relevant
> to the ATS stuff)

I'd say lets do that as separate patch. For now lets get this series finalized.

-Vasant

