Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86343B637A
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940689; cv=fail; b=XsiOQM74kzTIgG+jfh16H0geUYM3U5mm81Yoiubxvv0vgiVwSRJice0GRygRh+Ol1mj1RD6Sk+0svJxQmbqus6Yaws/37cFFqt9gLjgnA8eOmVl1xW0SBtnD0SRYVaDNrqYvG15nI78DdegSKFyTpcNfffylYX5O5jFOC7uGliI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940689; c=relaxed/simple;
	bh=df1t0hYE7X+OCKovcvGFrcI0lHdqRbnup0WHuM8zyuM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JkkKdNEpT8tPy77CTC9veKUDxtfw7Mpy2i5T2NvSQ4iiejovz32noWEqMczoDEmM4S6trE0rnmmhphsXeTXCUj3m+hQPTtH0N1EKOPJw1d1racwqX+o1hWP1DH1kbSMfMrr5Jfr7mBOz2rsEU9gKlmwcbsqraox2kdYb0zHTnto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vq+0PE+F; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vq+0PE+F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJfFGvK5/RoVUwsraahNi3JLr9T6kM8zsXCxnIdyxTgaZV+/SAhOxo4waNMry9gmQ2bmGB2k0eK+vDB3x7D4UHbiinBIVnRoNnVcbeU9zNnoADa+nqeC5jeA4wm0l4G7XGsCmF8kBiamDZK+SIWAU8+2cSf+xLVlp0dfwsaGZTtqPkFPjBEuWrW85HjH8jn9EHzEejmpdFYo2fFHp0LbBJ4nW1YCqcBeFTsnNb7GWBNrA4H/SX4kcf1fys7VEkSDP5LKwtITVmogccSE9WnzHe2JWtmcfK/3YTp+ZiHKFH5MBW5NXf5PWW8QzE+P25M+vgTtf4bpfhp9q3DsFGbfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy/tT8AW5bLf6B0KGBkC9iszuBbdUSABlWI1rrAYTEw=;
 b=oBQt10yYOJ9TLqGS/Ht9vjzifnP2+XNC3vV7df2vlSUlP1syMu85mRk57wDr1mXyiPqxPBZIgFFZTPM4Pz/9eocBAFD/cdwlh4Ig81JcWrXfPJPckgVEab5JhMakHM2CudtZMaU3gx0MDRBY0BWNptr3+O2kbNtQMZOjr5TCBqDEPVSsEclFQfijttLeUOAYRvPHUqNnCsEWVXyLcVsb3MLk15OkxuZ0TfbvNWEs8SQH4SLoPKrgIKPBl2HU8GAIbssdvihtSf5YRbnfREkx1yhvaJteyCkJb1lERad5m4Lm0ySd6r6V+fCyLHytJW3r7zKozs+JlTKDIBsKGRhTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy/tT8AW5bLf6B0KGBkC9iszuBbdUSABlWI1rrAYTEw=;
 b=vq+0PE+FTsNLBC+hxPikfjm6oPERCNlkKPzLHxtOWcHEGAjmgV8OheuOMq9IfdDhhfcROxlzi3igGShsSfaUMeM+0T+R4VbA9OhIaBFKuZOxQ2PJ8q69fhsGxTICdW1b13bXafBD3aBIIcldH3+ueTIUuSqlx7j9zMilRm1V2EA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7SPRMB0047.namprd12.prod.outlook.com (2603:10b6:510:1f6::14)
 by PH0PR12MB999114.namprd12.prod.outlook.com (2603:10b6:510:390::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 14:37:58 +0000
Received: from PH7SPRMB0047.namprd12.prod.outlook.com
 ([fe80::b54e:e6eb:405a:218c]) by PH7SPRMB0047.namprd12.prod.outlook.com
 ([fe80::b54e:e6eb:405a:218c%3]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 14:37:57 +0000
Message-ID: <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
Date: Wed, 5 Aug 2026 20:07:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Kuehling, Felix" <felix.kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org, linux-pci@vger.kernel.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, bhelgaas@google.com,
 Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com> <amOBkJ4BaZ4qnkpc@ziepe.ca>
 <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
 <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260805010706.GC28508@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::18) To PH7SPRMB0047.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0047:EE_|PH0PR12MB999114:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3b27a4-7220-4f80-15eb-08def2ff2478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|4143699003|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q5sTNTqa9uWGu0kTqKhcLwTyUy7ly9at/EIzuqkD5o+Onl7NyoQuO6P7R+25Xep7MO8Vl7XKlDaaZcQPZrtwZX56M8NAjS5y7MzzcxE7Qvb3qlgr/dNoQ5yZtlvW4cylffeexnyHj69BxZzsSb8fRy0jfLz+NPTpOxt5cyTAeF0Sxr/rmI5WXyURRAz4F/JyNmBok6F8bPeD0u3edToypxiajZqZmgvsyCRxUTXIlrGykDxCmXnLjAc6px7m+tjcJaCSJPO2uYFUWXGV10OdbD+H2gVRDGN8HE4BqmYAjZ2lNMTHvGRFPlEnDLtKfMix5kcNnkbFo2aU4UBn1cZXg8YjEFuXvdbSRE9UYYiWGOKBEMkIX2Zck+gm3mBxZzoa3VtvBUMIrREBFtzEECc2oUsQ7EDgWg/PdZc141aZ75/MpzJ8OB74b1d7xbWvAFL0QnemMgwZLkbbC5iqMSwh5LrGFGH5bYFZceisBBPbHPG5+2ytf2hTVv8lkwXa2uQ/1tmIZgtMUG0ybR8257d4jJZ6T6xIC5boV1mJRey/qja/WzsMjJOSrrnq7ANzP7SC43O3dwNPzRQmD/FWKZEWC9xbv1ZjYDor1j5479XRKpyrGc0gsMCSrfiE7Pb93gn/Mrx134NkYsNV9koJYFJ15uMs7vXKuM1hEv3Mev7/hKU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0047.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eldhQi9XVjFmK2tQajlpak15OFpCd0xhZlpuOGpxL2FOdWxwaGY3djI3Rzd5?=
 =?utf-8?B?YlpIQnhpWGRHRWd1WjJGM2FPOUR3T1p0a2krMW9lT09oNnI5WDdhOGdlZUJi?=
 =?utf-8?B?ZmtKRVFZQmFFampvZ3JhdzBtZ2tjMjVaS3FOYzAyd3ZibDhYNkJ6eUdTQ2Na?=
 =?utf-8?B?aVlIemNnTWRDUU50Sit2cnpucnZCQWd6YXU4M1Q5RXd3cHY0VjhkQkZJeTVL?=
 =?utf-8?B?Q1ZLMXBUdUwyaW9veElzQmVOcXdKM0xqTmczZG95N2F3WTFPYUEwK0J2aFBq?=
 =?utf-8?B?VENhbHFaZU8remtzTklHMlZEcmh1aFFadWRpa3NScHZZSmdvYWw3TjVpUmRi?=
 =?utf-8?B?ckE3dEFyUWk0NTU1VHRlZTVhUVlxc1pGSVVsaUF4S1dKYlNvUjRhVWEyYnFE?=
 =?utf-8?B?YUNadmFxQmsxM2ZaY3g2TTZxY1oxVEFVRWFYZnJ2RXhUbkRYV3p3Zmt6Z3Jz?=
 =?utf-8?B?alJ6T1dJWWs2bm5reFQ3QndQN0tIWjVpZDZqbEpPQlR6eFhkWU8wUDBmOVdC?=
 =?utf-8?B?NWlGKzhwcU00ekpEajNOV2NCNmVRSkhvTUJ1Q0VYaVdyNWlmQk52d1h0L2g3?=
 =?utf-8?B?dCt0TkVqRmVzTXgxMmpQYTZDazlwMFMzL3czVytPWEJVSGdoa3B2Q3ZjTjFI?=
 =?utf-8?B?OXNqb0NWMzI4OFIrMm9iM1JneTdvOGc5KzBNcnZST2hVNTdVSW8rQW93dkZT?=
 =?utf-8?B?MXJ0cUhHeWtFYWZSL3UzNjRVVDNkYlhwTWUrbHhYc2pmZFFQTmhXSCtSUUE1?=
 =?utf-8?B?RllFaDJ1VjR0OU5zYmFlSi9ZU090NFNZSERpQ1hFZUJLU3FpRm5wSElic0JV?=
 =?utf-8?B?cVpBNkJaSDIvOWpHekp6NzVTcDVRb280TUppblpjMWhaalpZN2ZGdWxpbkJC?=
 =?utf-8?B?bXVlNVpmbjJvOSs2S2pYUW5kK2VNaVF1YmtKL3lXT2tJRU55U211OXl4RUlL?=
 =?utf-8?B?eXZBenNTd1VreXRhdlNVVTE5Q25mbDhESWEwRFB5a1d2dGo2dElKOGM3N1dl?=
 =?utf-8?B?NVBYUVZleWVQOUlqTk8zbU1TbDR1L1BSTzFEbTZNL21PYnNjcEMyY25VMjd3?=
 =?utf-8?B?YmFMano4YktQUjhWTFY0ZXFlaFJwMUdHYlZmMERwUlh1MGs3SVZ3bTVkcXJY?=
 =?utf-8?B?N211ZGY0M1dvV1ZLNUYrVngyOHRMZUJacVZUci9BK0tVaENXejVuVUpmZE1a?=
 =?utf-8?B?QnBYZ3Vzb01ZWDFxZ0ROMWJRaU9XNmg1ZVpaK0RVWW5RbUVZdXZqeE1Ldk5L?=
 =?utf-8?B?WmVnSHZzWUNtK3NZcURGc3hXdnhYL2hLN1gvN3lta3ZBeE94dTE5SS93Tmdv?=
 =?utf-8?B?WlFMK1RDYVZWWDdXdjh1cVdKdWVhZit6aVhNZGxWSmluRFdrWE13dHl6QVJZ?=
 =?utf-8?B?N3JFSEpqTFZYalk0VUd4OGJrQVFpOFdZRHVYdzlMdkk1aGZkSzZYeXpSTG0r?=
 =?utf-8?B?QzNkd3BHZWJreTVBMjRyVlU1R1NrVHRZd25Yd0tqTGRwUlVyemhmTmRTaUNF?=
 =?utf-8?B?ekZPamo0VENITUlZaFlGZk1uVWIxV2pSd3JFQ2YwLzJIYytzbSt5MndRL1pO?=
 =?utf-8?B?dEh5VkVHTU5xbXdpOUpkb0syWkNlK0dTUjFTWTMreHhCSTgvRGMyZnhjREJS?=
 =?utf-8?B?aHFsQlhrWCs2UWtLOC8xZk4vdHFIQzdqYjZIODlMZnVFbUZ5bkdTb2Y0WlJy?=
 =?utf-8?B?THB3cnJkNkRESmhGMjdOemFjL1VvdlZ0ZGtpWHNnL3ZXaUUvY0NFTnA3RnVo?=
 =?utf-8?B?M1BLczAwRVdMYkl3NUliK2ZQT0xheWhqbktNNUtaeDdQcU9xRkMzVk1UUzM5?=
 =?utf-8?B?bnlQTk1WaVN0S3R4QlgzL2FEUkkwNzduWXJzVTN6N1d2V01aTDVEdVV5d0E1?=
 =?utf-8?B?NEFlUEQyNmRsSGk0eFhjcnFJQkRWUDF6bjVMK0NNMnNod29XTHRxVjZyS3ll?=
 =?utf-8?B?VU1RWDdiQ0NSbmp1VUZURWZrdHN5bnRwSVp4cDdiL1RMWWZWWjhQT1hFS2xa?=
 =?utf-8?B?YmNkeWZnbjN5MklUd2dXbzN4YXBXaGtENzNCVzdaLzUyTldpK2xGV2FTdUVx?=
 =?utf-8?B?SmlXa1FuMW9zSFZzMGpUL3ArbXF5TlVQZno3enMwTzNzcG12M2VET2xpWTd6?=
 =?utf-8?B?TVVWejJoVmVUSFRVZkswQ1lsdFVrS29RaEU4dDVMWGw5bW1XRUMrWnlxUCtO?=
 =?utf-8?B?bk1QRVgrYjVidEhDYi9FSmlmWE1kUmM2M2YzRnNEdUNDOXN5TS80TEZtQ0Iz?=
 =?utf-8?B?K00ycEZIaURzdXpldldmd2w1OWh3YnloWU1aQkpKRmY3UFhESHpJdURDdzM4?=
 =?utf-8?B?aWxudlUvMmVXQU1IcVFuMGp2VXhBS3BBRHVoSG9iUzJWQWxiV2RjZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3b27a4-7220-4f80-15eb-08def2ff2478
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0047.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 14:37:57.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8d/S0YDEOvhc/bx2ZoAE076OWQnc70zSiSSsr8zEbkTryUGXGZ2GnKEs/RpDIKjy7X/XEwLgYDyPmE41S3Id8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999114

Jason,


On 8/5/2026 6:37 AM, Jason Gunthorpe wrote:
> On Thu, Jul 30, 2026 at 04:56:37PM +0530, Vasant Hegde wrote:
> 
>> Based on discussion so far in this thread and the link Mario shared earlier [1]:
>>   - We still need identity mapping for APUs. I will fine tune the patch based on
>> the discussion in this thread.
> 
> IMHO if certain HW has broken support for PAGING (eg because it can't
> handle the isochronous needs) then it should be quirked and blocked
> properly.
> 
> I thought the issue here was the PASID check forcing identity and
> accidently capturing these raven chips too? It should just be moved
> out to a normal quirk..
> 
>>   - Its fine to drop SNP check
>>   - I am still not sure its safe to drop SME check (CC_ATTR_MEM_ENCRYPT)
>>     Because here were are putting all APUs in identity mode.
>>     Commit ea68573d408f explicitly error out for RAVEN and some of the older APU
>> platform didn't support SME. But not sure about newer ones.
> 
> That's quite a hacky check to make in that commit..
> 
>> So I am inclined to keep SME check for now. Once this patch stabilized we can
>> revisit the SME check?
> 
> The SME check makes no sense either, but if you want to stage things
> I'm OK with it.

Right. Eventually it should remove SME as well. But I am concerned about any
regression. Also I don't have all these devices to test it. Hence for now I will
limit to APUs, keep SME check and drop SNP check. Once it settle, we can go with
next step.

I will respin the patch later this week.

-Vasant

