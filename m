Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2DD41D651
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163544; cv=fail; b=Ih9smcuQDT3idSALLkzqLsuG9fao1AGD1O4zAKGC5Ifkp705r7X6W9j5ZTmdwp/j1QDRh6/jE+ixTWp5hXJqmUssTIzmPfyBXeTiBuT26xloVmz/35XwK63ziJuEytOflmBqxpMb/YqW5S7VpBYOVmJDNsMcu8CadVXDc2EAwCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163544; c=relaxed/simple;
	bh=K1JGik9qhHrZ4klCEItZfX329Dct6cKzvfpSqJf8ABw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t49o2ucnpzU5Sy040lNTwPf6KhR2IEzhiB3QyZ6E1/tDfI9YuTpSVbaak23zI/SYIpRDxx/3qCYA85IBo1HW+ZkxfSTyeqlm2sGpLg58tgOqYKVfL83D4YNy0bMz5zzS2wJ21Ggc6Q0g/9s/D74NNcAW9rVBC4MyKNfhS7/SQLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cBPScNi/; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cBPScNi/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOMvNMNnF9tjD5r0ULRjySaPU4fHUNpIzuN/GfkVcnlEkPYCSlSfS33SlflFWlukrP8BHbJbcl/o1ELgszSWNIbN61u8Q397DH4uPphs+EMOahtcI+AxCyH0/JwGRq1paaWZhIGSZ7UT5Fvi9fHhWRspYarj9euRvuo+YYufZx2A2vN99lN2gUwd+0T/C152xiGD4WZVtdtHn9tv+8ixEfihJSsQKuj8nFWUxxJrpdJBRHWjZTD1HNqoKzCunP/nFYUrXReKEDzsCY3rkp+OkDsZ4W48Rm6SoQU/oxMYwXIGvZ8jF2Ejck4G8sqahd3sef1+Cn9f+7ghHrQKtGTuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcYQm9qaKKWNfj3kXp9uejgXSe5bnex7DYBnOlGkheM=;
 b=peF9DcsosdBjyfnRpxKaOCh5vBn1WHeVAjiP9BJ77tQPceHO5VwK2hQnnJqsZgN77u+u2GOPAbutuy85m6Ul+VSwih/ZZGL9d//4e6n/F51CZbyBXNCYVnRo0ENwFNAR9rG9Var/C7RuuA4f79plWCEGpsnjdmPL0C8k95W2MjAvvccC9vazMfkmlAl7cB7Dq+N56aoxDfAjd6ouJHiJRjvOuDTFbnHEWNYMle2wQ3waCf8hFMxz1aGOnuinyLMA4bDpkQh9lidztFK2zmlj8r74cn5088Gy3ESIVvRhKha1fgCUW66ksO7/HV5BENGf4i/0nTwZnamehdgU12CwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcYQm9qaKKWNfj3kXp9uejgXSe5bnex7DYBnOlGkheM=;
 b=cBPScNi/NMuLsVlMFdDUUl4ThvoP2XdK8G6Z1AsXxZBUgwbnS51UUAqS2ZXjcdWE8301edoD9omfDj3NmI7OWuJq3RiRTY4K/m1bSgF+tonn+qHu1uZ6mha7Vx7ZOl1vNMG+i/A7aaRvC/GHkEx6e77OC1TiIEed9Do2tPhPwDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:45:39 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:45:38 +0000
Message-ID: <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
Date: Mon, 27 Jul 2026 09:45:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com> <amOBkJ4BaZ4qnkpc@ziepe.ca>
 <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0111.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::8) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 3733bad0-a1a2-4964-3af7-08deebedb97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|5023799004|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZQ2fcLijrI0mvKMgidOrWl+kB58sQtZGJWwmH/TTmoh3BjX4VPC3npWHfBZH4vd977ZYc8rzfpWX4N+I+YILMbNZeIwM98Bh2wLhbKLkrIfxo/SGKRx1QVjNxAI14fMkYmuAgmRa4uSmrmXQpD4nQsSX0I7DhXS2FIyK4F8kHYyoUcdnnOqBM1tib50puuAI1NP5Nk6M3UuKxZTJ8NexZa/5v6p9wbnpwupuvMsTftrFfcBaDbjaWHYbMs0DcipWdg5rbHJlhEILiH7pfovhuY/90MmFcXc6zwyMFavOVvgFqetywfH6/tPoaSUIY+4UsVw1GpxtM4RqhxrzIBxpnTHohcaQZOJF8Seen+SoEImP/vcEWpGk3N65/HkCAXdD9nwU+fU0jcnkqsxHDAmI1sW5KM/e5hZ611dlfyobvWRjC9SB3762vqQJrbJao9IeNxBU4o+ypBwYEtA+sIToFL6C5fAw3L3oqTOUCLAq9z1iPNqNnhlE3HNugfMOjUJHKHytRmZB3D1f48o0cdLv3mcWMcrFGFyjjZxvKF9SsaGgkI/vuh2FEjXpWwVzmYMNj78srlxiZpe8zSnvBdA7pq9SWa/rtfTyVaEuaf43VwCr3Q2Exl8jhV2kxiOaZBVZ2RYZpym1ZP4ceHuMu3pQ1UCllpgkCtSjlB9dKXUWKxs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dktBTm5zcEp0dlRGeVVCaDlzVjhBS3RBdEhpbElNQ0R1V2VhSnNYaEJxMlBG?=
 =?utf-8?B?bmFJeTBjb2VpbmsvVnkvbzNoWTExc2VXVkJMQ2dYQ1lpZEFSeHl5ZWRZUFNy?=
 =?utf-8?B?UlBzQ3dFYUM5SWM4S2sva0RaRlc0MHgwQ1pPc1FpWFgwL0lUQTB1b1g4SFpD?=
 =?utf-8?B?TlZyS3NjY1N1WVJPOGN1QnM4dS9QK3FmaVZWOEJ1aTRSb0V0eWpnRFdkeXN1?=
 =?utf-8?B?TTlvY0dySU9WMEE5eGJrUG4rNEdPbVB5TkR4RGgrV0Izc2ZaT0xmcjF0NU5k?=
 =?utf-8?B?eTI2K0l0b2VTUlJwWWdNanhIUVVHYnZ0TmUydnJlVmM2R2w2dVFhTUhXYWJ3?=
 =?utf-8?B?LzA5WGFQd2pPdVFSdjdkbzQ0ZGlVZ0xud0RmcXQzeGhpTlB0aHFXOWZDeUVF?=
 =?utf-8?B?MTBIUmYyNHBna2gxWVY2elZUd0IrazQrQitQZ0Z0UzlMamhtMjAzQXNhcXRJ?=
 =?utf-8?B?YmVyTnRZblpabnF4dEMzNHJoUDFpZjVZTEo4RzBkVWpudnh3UHo4VTVndnNV?=
 =?utf-8?B?THJxUHFwTnRCNjIxV2pjNVpTMmdtSmZaQk9ZdHRtTm90aWdlcXlISzhxUkZw?=
 =?utf-8?B?ZDRXYVJWeUFHUkhMZ0p0VXlyUDFXZkVCVU45dFhKV0FIQ043Z0ppTUpweWk0?=
 =?utf-8?B?SDRmcmJOUFRjTGhXOG1EZ0pWS3dqaWxhOEx0aTNiaFdiQm95d09VeFpvR0h0?=
 =?utf-8?B?WlJtWWlkSDgzT0I3ekxFUHAzYzRwWTdFQ0xPSkNFYTg5VThwZ3o2VWdLbmFj?=
 =?utf-8?B?VE9wdzYvRDdsYlYzdUdsVnphakZSNWU5ZEYya3p0VURLK0xWVUZueTI5QzMw?=
 =?utf-8?B?YlhvRTR4RkNyRWNGN0t0eEtZWGpGOUxmdGtYYlYyei9MeXRHKzJSOGM5MVo4?=
 =?utf-8?B?b1ZjcytyMmMrVXRxVUJQQ28xUGZSQmV0OEZaNzhJMGkvZkxHeWZJT3FnL1Bt?=
 =?utf-8?B?Q0pDSzRJQmF5SVNFNzNaZncxdUc1cUZIRWlIcVc4YXpwcU9pYS9PV1NCMG81?=
 =?utf-8?B?dVVEZ0tlblpzbXpQUVVRcDhSNENuNm5sNStvK2hQWDBRamIyYXlnOXVSMTRu?=
 =?utf-8?B?UjBvaVNCQkJRYnl6WndiQk01OCtyejFON0dvU2t3bFpUbEZxaHduN09DQllF?=
 =?utf-8?B?QmxxN0J3Vmp6NXRWQmlHWGRtK1gwTjVmTnlWekJDUVdKQmtPVG4rWmtBWHha?=
 =?utf-8?B?RDE3NkordjdlbGYrN3JpMjNyZENOMDJlUXRWWnUyRTEzQWdKa1M5ZVJWRHR0?=
 =?utf-8?B?Y3RqSzA1M3BGbHBzTEd6YUM4UTFlL0dsSkFxSTdqaG1IcHJaZG41UFNpdlhH?=
 =?utf-8?B?ei9udnpoZ29vbE1wM1lnSzFKRUtaTHMwQWpYUUcxaythRmhGRDFoMjIrcXoz?=
 =?utf-8?B?aFhuM25Vb3VjZmxSQUFYQW9xS0xDVnFvbnI0QlJnYWxKRlZ5TC91Rng2L3NM?=
 =?utf-8?B?d2lnelZlbXFlcytnU0NyaDZkTTdkbi84bUY2VWY4S2c5aGMzd3ZpZWFoNVgv?=
 =?utf-8?B?QlJod05OR09rUUFnRll0d1RUTWpzdmpaNHZhZnFpNS9pT3RtNUxMc1E3Vzk1?=
 =?utf-8?B?UVFQK0c3UG9sOEkxbWFRR21HVm95ckgyUFdya01WMXF1RHYrQ3ZLV2ZMS3Ra?=
 =?utf-8?B?MTY5QWgwaGJsbDlLRzRzY1lVN3BROFloV3hPZ0pkQ2l0TThraXdLSEJ0QjRk?=
 =?utf-8?B?ck5vNk9walhPNUNtWWRWTHc3OGFyNnRPK2dUUm8xSE5VUERtRkp0aWg3cWUw?=
 =?utf-8?B?QjFiQXZ6eDRNLzhXYXpEYnpWNFBiNjF1b1d0MFlyb2J5N1o1LzQrQWpDc1R6?=
 =?utf-8?B?KzM4b0owWnhQNkMwM2o1UmhpeUJnUCttM1N5Y1hMZ1NyS2xUQVc2Uk1hU0Jl?=
 =?utf-8?B?TWtNTzVWeHQycFhpQVRub0dRUjAyVHEvbUVxb1kwdk1sS1FFR2JTTVdRNDMv?=
 =?utf-8?B?cWM1WGU2elpGSnRBZWNTYi9KdEowRUJyUG9iWHR3RytPQXZ2SXBieVpyN2t5?=
 =?utf-8?B?dEorQmR4Ny9YbXZaUjZSWlZFNE0ySGFGMnNmVTJHT1B3ZkdrdmcvaTdoMDdl?=
 =?utf-8?B?QUxRdlJsSnpVdDBqWXo2dG5hQUFERldqZVdzaGlFeXIyVFU5b1o5MzBMVDFN?=
 =?utf-8?B?WkZrR1V1S05FbkkwdFhoRlVRY1VpNlNJR2hzSVBvTDNsUndVcEd1bzRtK3hh?=
 =?utf-8?B?a0d0MHY5UUI4V2YwMWJwUVNVL0tqckU0NlMyc3NLQkVPK3VOTW9CM0NxQ0lU?=
 =?utf-8?B?YmtBaUlDSUQ1cndDOFV4K1l0bUhqQTMwNU9TNTdmNXZXSXo0eDVGaHZiV1BJ?=
 =?utf-8?Q?InkCpNvHDaIRhUs90i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3733bad0-a1a2-4964-3af7-08deebedb97a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:45:38.7056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ky2tFYIqlcgMCy0A8kwZtGg/BY8IJd9hugZOBVkGTYLsLCHF9yF1mldNnb+dTtyzGf8pTh0d9zY7UmS4bDs8sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973



On 7/26/26 23:19, Vasant Hegde wrote:
> 
> 
> On 7/24/2026 8:45 PM, Jason Gunthorpe wrote:
>> On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
>>> @@ -3120,20 +3146,28 @@ static int amd_iommu_def_domain_type(struct device *dev)
>>>   	if (!dev_data)
>>>   		return 0;
>>>   
>>> +	if (!dev_is_pci(dev))
>>> +		return 0;
>>> +
>>>   	/* Always use DMA domain for untrusted device */
>>> -	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
>>> +	if (to_pci_dev(dev)->untrusted)
>>>   		return IOMMU_DOMAIN_DMA;
>>
>> The core code does this, it shouldn't be in a driver?
> 
> Right. I didn't realized core has this check. I will drop this check in next
> version.
> 
>>
>>> -	/*
>>> -	 * Do not identity map IOMMUv2 capable devices when:
>>> -	 *  - memory encryption is active, because some of those devices
>>> -	 *    (AMD GPUs) don't have the encryption bit in their DMA-mask
>>> -	 *    and require remapping.
>>> -	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
>>> -	 */
>>> -	if (pdev_pasid_supported(dev_data) &&
>>> -	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
>>> -	    !amd_iommu_snp_en) {
>>> +	/* Apply device specific quirks */
>>> +	if (quirks_force_identity_mapping(to_pci_dev(dev))) {
>>> +
>>> +		/*
>>> +		 * When memory encryption is active, some of these devices
>>> +		 * don't have the encryption bit in their DMA-mask and
>>> +		 * require remapping.
>>> +		 */
>>> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>>> +			return 0;
>>
>> I think this can probably be dropped now? There is no intersection of
>> this old broken embedded GPU and a CPU that supports CC right?
> 
> 
> I did consider dropping these two checks, but I was not entirely sure. So I kept
> as is for now. Once these series settles and I can go with next step of dropping
> these two checks.
> 
> @Alex, @Mario, Any suggestions ?
> 

The background comes from this series:

https://lore.kernel.org/all/20200824105415.21000-1-joro@8bytes.org/

> -Vasant
> 
>>
>>> +
>>> +		/* DTE[Mode]=0 is prohibited when SNP is enabled */
>>> +		if (amd_iommu_snp_en)
>>> +			return 0;
>>
>> Ditto?
>>
>> Jason
> 

