Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7740DFDE
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410814; cv=fail; b=ZfGa0Rx4pagpynbQ2qcHMYpYN9SNLsxbGpmsC8JmP2ksOnx4bhLHGzeOcSV6EdBU3txpDV21+vGdrAYdvirzSmc7EffMP6ZjwB/tl0yJnMO8ehnFSkJzSNn1ixTDBoZ4+T/wVcyf9ewwZAlULXbWONFNLOpBHqzAk8qVH8suIMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410814; c=relaxed/simple;
	bh=i6mBSYO7/NBZJWdb2mf68FmF5aCfnErDTdvXY0iz+f8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YIXD7/KphAlefY/tqPf1JbY8ZF+4y1KvRDmXTtT75oHz3ckunX9pBAX2GvJubRZM46guL5mrwArDfeVbtZ5WFLlABO5GSkO6+HaotDpMVXP7l9+i1CeASw3luMI+ODCbwbXAirTKRiAxkBVdae3h5NQBTp70rrJ5cCJgkOdzX20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z1qRNk42; arc=fail smtp.client-ip=52.101.56.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z1qRNk42"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmLmnDYqpSeXcyEJI5Z+xrVBJ2kta6u6WWKUOdovi4lYUrnOiajpKMjQR/aELLk0r9wu/hBCuc/V8fZBaa8c9okNLkm0xNqtNI5EgnwXUmNXUH+tQ/uMoIvuBSSxRvK7gGiiRfDWDT1A5SpCYjSo3SHVTFkrxyNPXCzXWxwUMtDODWpsEVxlK6OJfp0VAomLOmK9f9XrQp7cx+F8aGkXVNNFAJ0tlvxLa5OeKVoWGuGd7lmu4V4c/CiQl1KZ/lDGsum7qAO1FU5P+0yrReZWT/PG+idAhVefBzcxAV3L8avNGZpwtCLxPJrnbK9zkm8YWc+aAdpyrJHS5OtIbE6jzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T6BGghxBoxn6nKIQdlWQT5eV17RvmZWSc/l/StRXgE=;
 b=grhTaQ8lKhQya6AMXgddAEj228SHUo7ReC13LShXiHvojrmA194juxA5P1nq6quQfZGxnmYyaPglStMtply5pT/Kn0slBompyRxmmONLsm6PLqiEi/CX0mh2eVt/3y1s5gmh4XpBWOq1yuAy3VsEjtQsyFNL/oh40kQ+zWzSW3hErpw5mmg3ywZEu4ewSnVYAnQzRMKDoCK/xrWMNUiXxZomRgDwTrMHWIjYIImv8NVvfZogm9p8ccARBoZwKo4zA19rNEypIlO6zJTNOp3jSmuFTPLONT5nTglfXVFt41Y59dJEM3I8yrMoTMo/ZaRWmQ6811eqwIsndPrAO3/M+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T6BGghxBoxn6nKIQdlWQT5eV17RvmZWSc/l/StRXgE=;
 b=z1qRNk42ff0gBEy4zYlErQa/u4Cv7mCx6wGIYQaWnScSGEhT75whOwhXI75KpbZzEi/ytgmuWqPs4gnsXtwlCrEYg69BYL2kCx3RDNdW8/huUC9ARcGsG21Q/OqG8a6SK6l/zyn74ka1OEjLxb8Dgd66NdcYSmIIDbB1dRWZckQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.15; Thu, 30 Jul 2026 11:26:45 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 11:26:45 +0000
Message-ID: <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
Date: Thu, 30 Jul 2026 16:56:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Kuehling, Felix" <felix.kuehling@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com> <amOBkJ4BaZ4qnkpc@ziepe.ca>
 <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
 <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::13) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 614b32a4-114a-4478-7097-08deee2d7013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|4143699003|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RtXiwZzvzIjOxotuZ7jnAtvbHlraB0bgG/S27m9x9blvILvucfS9x6QbBs44hk7K9UnkA5JxxPW8UrYpfjR4+IXhyTtDe1aquJ3iUgocsCfPewe63gDfm6FwfiQcVl7cb+X7Zudf8YZjyUAIxQDziQ+15gVvVE5+zvJIWdggaCTYAaoLrg1k8AnDSrQQKHqqWRbdFojysDR6uJEmzGFTZHBos4runYnt2oUqn/7ZDcDXYDayfvSNAxztq7i8P7GK08nNF+W0C3+ZnjTvXGBGyzepSyEzfp0Mxj0VWSv6cIAc164RL5B+drVkzZ2BfOvWVkdxYQqDadtmh6lS6WEh6/INm616kvkaj9prdRgkl+LYFtK5nnfl3T4zYHf0vbLW/Rcc9ZHVs0kpju51SAuwjoI+gj69rdFvQQJrh0LMvB+4YqHBaFwVxsAUy74CPNc3oemyiYBlfn7OuCo4taXagIJFg7BQ2uklNVDMzy60gQx3IRE4wSB7oODSIbh9BuBoWIUgjVQP4oMwzoHB4XAI0BtaQvENzkycYbV53D3uCbBW6JglGB6xs5ZY8h5PGzEeW+MkqxWMJ0ftSe4mBzxJJ+ONb1CLXQg/fWmaR88UtWBl8fJurIxnFrHg2GYzRLE7ncZY3tZsrX9MtFJ9cmkhzMcE1k1BiLvCF7Ii3bU5/rE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blZ3ZTErS2tGeGxBQUdoRHQ0dGt5cks2NXNhVnk5Ylh6VmQ2Yk80SHZqVWZL?=
 =?utf-8?B?K1lZUXFEOHB2OVhITERHdWs0WWVFeHlKUVhHTzg1OEx6cFYvcG0wdUtrdktN?=
 =?utf-8?B?WmNGdGNJdGRTZGxqbDlmMU5ZZmNNRUlPRGE4bEp1MWxmZTFGYWtsZ1Z3bks0?=
 =?utf-8?B?WWpyYVRnQ0tQQTVPZ0tUTlVUWEVrMWxRVjh6bzQrSENSd21UTWZwc09XZWti?=
 =?utf-8?B?STJoRVV3Ukt2eWFlTnMzaVpLQzZGd1MyOFBHdHhvQ2xtcGM5ZFY0d25JVjha?=
 =?utf-8?B?aHpBMnZCbVFLK1BhbWs2dWF5ZEtKMFFiTzljRmE5aFhvSkZkNVpkT3lUUHB0?=
 =?utf-8?B?TmtDNWFMcTRKSksvMEdIelZ2OGd4NFR6cTlSYzZjZG1DYXlTemVFL01ZYU9V?=
 =?utf-8?B?WTFnMUJIdm5NWDBuS25WSEZkZnlDRzQ3bnNvb3NtRm03L3NyQzc5MjVQMlYy?=
 =?utf-8?B?NDVQOW5yN0NvVjRJNENvajd0TWtzLzhybVZhZkFhTDh3eHVyNis2S0J5d0ds?=
 =?utf-8?B?SzFlZEtpbGk3VGxTTjA5WXhpK21tZVUzNkJSZFQ1d0tONjUwdEsyME5TUTho?=
 =?utf-8?B?amhIdlFlc0ZRakpCSHZxRGlGS2ZGTWk5WGNKRmxWanJ4eHAzVTBLTE82YVQy?=
 =?utf-8?B?RFU4QVFEempDci9SU051Z1Y5N2MvTHRrcUdCQnpURTNqTkNhYy9nbklLMm1o?=
 =?utf-8?B?ZHpIOERrMzQ5cysrbTk1SEZMbUJNYUtMd3VRSzlzcGFOVEJuNWl4MVRRNzBx?=
 =?utf-8?B?NERSY1lFOHplR0JUc0RaTGsyclkyNTJJMTJCSm1VWm5JVFdqbGp0cXBDZko3?=
 =?utf-8?B?ZlN3dDA4cEZvNmttcFRSWnhpRHU5UkR2NmdhOS9OL0Z6V0dRRDhLQnc5VDJp?=
 =?utf-8?B?TDBZSk9zUjR6S01TSmwxWHdKNzFlUzJ0Y2lSdzRCZlFFOURSWE5zY0N2NGUz?=
 =?utf-8?B?QVVzRHgxbEhPSURpREJLTU5uUTRUK094MFRIMU0wRWwzSjBqOWdUUjFEL3lL?=
 =?utf-8?B?WktzSHg0Z1JUUmRQTWJobTdoU3V1YVh5NStiZE9VM0U0UkoyaUxQcENjTEsw?=
 =?utf-8?B?VHNGNXpZNkxGeTg2WFdMR21PaEl5eEZVb0F3OXRvMHV4MFFJM0dPakdwSW8z?=
 =?utf-8?B?Qnpmc20wYUJ3azQ1dWJzQk5sZUdHd0JBR2F3d3JJYU0xeGZ6MHJiL3hEMm9k?=
 =?utf-8?B?a3VZT2hzYytsem9iQjA0QlU0RWhJK1VPd2xKc0lpM3E2dXFOZ0l1cGYvVUlw?=
 =?utf-8?B?bndSaGoremlPY3RKVmQxSEk4OFNYOVF4RVY0ZVJZUFhHcmRQUUdHN1VRMHJH?=
 =?utf-8?B?ajdYMVdBQWNJNDVKdlc3R0xzOEFCaWtQNzd0WklnQVRQSmV6ZkVQcUY2UUxs?=
 =?utf-8?B?RkhaTFBXZW5LdlFJdDhxcXc3eXBxVGFDZXF1NjdmUFNlTTFpbkJUS0pGcmIr?=
 =?utf-8?B?VFpmRGRCc3FOb2VKL1BNWFI5QXpybjJKUHRTeklIaXZ2dFZpVHhib2RjTGcv?=
 =?utf-8?B?eGVzenM5cVZKV2JOdkhFam16U1VKU0tUOHNmZnplR3hRdzd5emRyeUdOTG5o?=
 =?utf-8?B?ajkrKzdQRENEcWZuWXZvZWQ5ODREeVFETUZCZE1xcTB1OXBQckpsaE10N0Ji?=
 =?utf-8?B?MmJNU2pMS0JvbW1UeDdMdytaSWl3bjFtczJRaXdaVENENlBqWXNaRXcxWnZm?=
 =?utf-8?B?Wmt5TFZkVVJrM3p0SFQwRXF0U2VOZmE4dEM1QVdDbnFjNDVDdzNoRm0zRjVR?=
 =?utf-8?B?VjFxZ2QrVU5ObUpiMHFDK2k3WWRNcDhJY2JicXIwNTd5REpQQ2dYaE5qY2ZO?=
 =?utf-8?B?NXB3NHVDQmIrMXQydXBmSitRMnJtSHhBaDNoVEZ6L3JTbnY1bklBTVQ3aVJL?=
 =?utf-8?B?R3VwVWllZkRUbFlOV0J4cHE2UjRTWktzQzk1YnBDUjgxUGlTRmFLWXhqcHJ6?=
 =?utf-8?B?cU5ZaWNucFlleVZuQ2NSMXkza2RGMzdwM21TNForSlpnMm5QVGh1YnJFd0p3?=
 =?utf-8?B?ekkyMU1jSC9wTU1QWnltZmNqTXZ5a1VMU2oxVGhvckdxNFZma3hDOU9XWlhH?=
 =?utf-8?B?RGh0YjUwaFZja0xBY1N3TTBZNUNQMFBvSUpnWlZLRlp3UmQvclM4NDI3ZmFj?=
 =?utf-8?B?RDI0eEJHd0JtM0pIcCt2MjI0aW1vYXFMb29VVGV2alBwRm9jMlI0bHVtb3Rp?=
 =?utf-8?B?V00xdXFFVXpPL25Ca08vQWdINytOL0dsOWQ2emxwNGtCaHNhTVE3Z3VIbHdq?=
 =?utf-8?B?OU9zV3IreEU1Qy93NEZhVThyVENub2tDVnJOOS9zQS9WaDZxdzRBc05JeGFH?=
 =?utf-8?B?OGs2WVNrL0hrYjdwWWdTTFV1a292NkNacURHeVJRRTZmaWloeHY2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614b32a4-114a-4478-7097-08deee2d7013
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 11:26:45.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSIz/1Fj08qJ8bKOZvd362h+1iAvLfxEM4obqgGSbi4koJ8wpSsbZwHfLb/EGvx31Ao/ofgMQ8rkLaWwBWU+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119

Mario, Alex, Felix,


On 7/29/2026 1:27 AM, Mario Limonciello wrote:
> 
> 
> On 7/28/26 14:10, Kuehling, Felix wrote:
>> On 2026-07-28 01:31, Mario Limonciello wrote:
>>> +Felix
>>>
>>> On 7/27/26 23:52, Vasant Hegde wrote:
>>>> Mario,


.../...

> 
> Hmm, I just had a try with this on a few years old APU (PHX).  It's flicker
> central with this (7.2-rc5~ish tree):
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 29dc18d3d22e5..1e792cee7f4cd 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3134,19 +3134,6 @@ static int amd_iommu_def_domain_type(struct device *dev)
>         if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
>                 return IOMMU_DOMAIN_DMA;
> 
> -       /*
> -        * Do not identity map IOMMUv2 capable devices when:
> -        *  - memory encryption is active, because some of those devices
> -        *    (AMD GPUs) don't have the encryption bit in their DMA-mask
> -        *    and require remapping.
> -        *  - SNP is enabled, because it prohibits DTE[Mode]=0.
> -        */
> -       if (pdev_pasid_supported(dev_data) &&
> -           !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
> -           !amd_iommu_snp_en) {
> -               return IOMMU_DOMAIN_IDENTITY;
> -       }
> -
>         return 0;
>  }
> 
> The flicking is reminencent of issues moving BOs between VRAM and GTT from a few
> years ago.
> 
> So I don't think it can be dropped (just) yet.

Based on discussion so far in this thread and the link Mario shared earlier [1]:
  - We still need identity mapping for APUs. I will fine tune the patch based on
the discussion in this thread.
  - Its fine to drop SNP check
  - I am still not sure its safe to drop SME check (CC_ATTR_MEM_ENCRYPT)
    Because here were are putting all APUs in identity mode.
    Commit ea68573d408f explicitly error out for RAVEN and some of the older APU
platform didn't support SME. But not sure about newer ones.


So I am inclined to keep SME check for now. Once this patch stabilized we can
revisit the SME check?


[1] https://lore.kernel.org/all/20200824105415.21000-1-joro@8bytes.org/

-Vasant


