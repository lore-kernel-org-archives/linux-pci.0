Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607AE23EAAF
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216675; cv=fail; b=DfchNTq0hkIV8JryQ1m/dhAImo2WNWOd+W/08x+VX1kYPnHmp84tp6AaOGHhkwFPFjc6QG4MgESS4d3dmbz3PFIUYVsk8wyOWfX7Itu7zc42b/WIB/5rM+nxtiE8b8Im4JvXGiN+0imHIMXVsAa4rmrqyr8/jFCenToM/NqgFxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216675; c=relaxed/simple;
	bh=HXp19tehskBIxX5rdnWjk70GVYN5iLTmPtK6/O2CUxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HcMYy/nUSYWpkSjeldtqlXpPUJOMyDP53/+AIEDDFL9yziojaZyUmp076uH9HBrNOsD/hYfgtShWSZkravyttNrMKqdGCHaOcxQIZWzeTAFrFj/iu13MRtKgtFtK6nMXQPUlXLijwgpC8S85mbYVSmQxfsLZgw+i9sfNyltXwOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jI3+hE+X; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jI3+hE+X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKrBS82t4mHjUJ7665K19NQY+4AB1/b+TIxnWAvZG5j11BK2782O+qEstQ9OXOUmA1+IYAqaqeY8tBiIQc6KAw7cJcI6uVVyyWMdHzCKrCuNtVdr/Dq6AcUUr1xANplQgKv9cgbI4TnTEk3B2aQHYUQDmlhS6jBeXOhWuj4iuNY4CyZf83h9VPpBpURvwpBWA+VFmqQpQDPCu4+HjBtOkGf6Wa7T9fytuPZ0S8FvA8/iaMKfXShZMdTO09nQd0icGmiMwVm++PcjlOXkAYwmuPI6NzeeiZP6pGfQF2gwPGi1GTTUqqk/ktK5uXS8w0B+JGrE470BCyERVJDPpDWR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VneF6esbU6gSbw3OQS0YhNlWtesy1gmk7Dr9m6TtUDM=;
 b=FKGZKD+bEVRuCRT+WA7kuXYAqsZ6PAYdI0JZaXHFXwckpZ4hGDtiSlEsgFslh5CZO5mzCSA/SIibOm/xYIuU9wgd5Yv0boaC3uHd/c/6nOnmmRjhtGEFBzBrbFRvQnknpk8t5bPBtUUO/hkHNww4zir/AYp9663t7Dp+92xGTDlWCB5Zwzdx44pb9beYf+deDz3o/y3ZnDVCNETKtlAedflTYUHWJhPy1XJlusJZQWnx2GnE75ih1pRIocsCnx8GjIvQfqL9BAeqS/usJRLWlM8mhmcEOfTG9ABHrlYKbeaeWMnuH3/QPul/cCVKRVIujeSebksgUNmb/66g9AQRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VneF6esbU6gSbw3OQS0YhNlWtesy1gmk7Dr9m6TtUDM=;
 b=jI3+hE+X+KUh2kPArzFm4L59jT8TmSGdQPdP7LNCDs49CU4nyYsJb7QzV6WFWqg4WXnY1SdGZjRyc+lSWmZ1duVJlQA4FNE3Z6+Iv3LQyGz4T3WeK6IqP7x5Ws8uSW2C8Z4z3IkfgtLMr9F0nfKiDyIz8vO90FmMuQkGC1uvZDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 05:31:08 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 05:31:08 +0000
Message-ID: <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
Date: Tue, 28 Jul 2026 00:31:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com> <amOBkJ4BaZ4qnkpc@ziepe.ca>
 <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
 <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0158.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::18) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df080d7-40f5-4992-084e-08deec696d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tFQk83DA++zqgjFq4L4mrK561eRXTc14vRPu6OS4Vruyk/OhvFrZXA9z/f7z1AvAjeDoKBLIKp/JWIiv4CETQOMouPZoa2vzGHHJRP7ym3/kbq0ir0tDNK41T2eGK6SyzDzGYr9dpSZoXWlTSbtSNdGhqNNmDpGQsXB1VlM1mq2c25DCjGcxc5MoSiZ4nU34AN8zE7FHcKlZVCkFwNq46TmBGg0AjN7AGX/TxEDah4N2BxASeclx7q1t8f6euIGh2NLcf2vvSB+jqRFO7eCH96VKKzIMs0RHXGE24GzpiJM1AnwVth80TtTzx9i4mQzuvw61PtA3t13XIiuPa0zdr9ifHaM7LOP5w5jV8LldFq9oEmBeZHsXDYq9Vx2lHxlWoFUl/CZbDKll5iKkI4cTSYSH4qtrwq8VP6TcsHKJY77oPBJuidIWgehOHWX6oGhDuvwvp4wKdDgU7DVop4MLpnGNJRQXbWJwsxSUu5ypLOaqlj4j7i9j9+vRxHhEF9g2LWgqc2r0+xq0+LnhadT4/2WACNH/h+tGE4/CeHxwl95nFwnEca0CxvApjv5TSxoA38H0cHgG/Y+T8SEImiIJ8f2Ie9cMEomt475Z7LfR6ejSMNWI3izRd6j98rM6BbKHzc123szq6b2EiUnIIo7jPbnYL2C8dq+7U3NsLxaTzmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3BaNmZxL1VYR0hzaGxXOUNPQ05uTlNNaU82ZDdMSkY5TkJCSDRzT25GbVJI?=
 =?utf-8?B?NjVYUXZabHplQnZVSDlGWEVtQWtwbVNWQ0VWR2VHa1BRQXM2cS82b1NNdllQ?=
 =?utf-8?B?dFlHaFFQMlZmSlYrbHRPQ2NDQmR6bGtaVU11UzBOUkU5YlBxdWErRTZHYjlL?=
 =?utf-8?B?Lzhza0Z6QVh4dmMwTHBCRUhNWklUZ2FYSkJUUGJtQWMxZ3RlWE1YWEJYbCs3?=
 =?utf-8?B?QTlxa3lhNmhFZzgvVXBZN2dqL01ld0dTYmdROFdRdUJFbm9kamJIWDFPMXdN?=
 =?utf-8?B?R2hIaFQvck45YTBoNGgzM3dkNWVIVUVyV29xSDl1enZEakd4MGpOM3dCeFlQ?=
 =?utf-8?B?cmpxd2c0Q2oxRVk3bUxtby9wRnpKSVNnQ3VMdkE5cFZjVHkvTjNaVUFsR3F2?=
 =?utf-8?B?N2FqdW5iRW9WMThvSzZHT3pITjhCRmQvODgxY2d4UFBuM0h4bDZYbXdrSUV4?=
 =?utf-8?B?RjMrTEoyTFJOcUg1emFHM0dGb1ViZEI0dEExLzFadzNFUmllUkhZMHBCK1FT?=
 =?utf-8?B?MjM0OGZaNnhQemZHb1A4eVhmdjZrZkxKQ2pjRlYvMEJtWmFoYy94QWJaMWRH?=
 =?utf-8?B?THdDYjdKK2lNKzZmZHBUay9DdGlSQ2lxMGpSaTU4eVVyTTZqSjBBNDc1Q2pD?=
 =?utf-8?B?Zkovamc2L2lsVVRvc1V3akFYTk9KOTE4SW1DWVBmYTJ4VFJmcGNwNFYwdWVN?=
 =?utf-8?B?OGJQTDdiaE5TM1ZDMTRBSmdKRC91NTFwYkkzYmgzTHkzaHp6cWROYlFxTXJ6?=
 =?utf-8?B?NWVUQ2NWMzFNWk4zREZQNlFpMWZYbHFKTExrWGtNRVZ6UVNKK0NsOWZXV0Fv?=
 =?utf-8?B?KzV1UmFhKzcwTTFPYjBPaUJJVTBuREFyTFp6blJ3SEc2UUlRWi9uTXIyQ2Ey?=
 =?utf-8?B?TDFrczBUR21FbHhjdFl6QXdVVUgrVmpjeXVuRjUzbFFtdDQ5c0IvWXp0dmI3?=
 =?utf-8?B?SHEyU3k2bGlPL0IvYWh6UVMwL1RrTDlPdDc3Y05ncGdYYmo5OFFWY0RNU2hH?=
 =?utf-8?B?dFBBWWhhcWZ3S3RST21hUWdtVG1vQktoRkdOa1UyN0Qzd1pobDk0UkVheHBw?=
 =?utf-8?B?eHdGOVd6ZjNlQ3hvMUlIbG1zK0pWUk9oRThSdjNkRXBzR25JTi9OWHI3a2hW?=
 =?utf-8?B?TGJuY1Y3T1lwbFJMakNLYnVLTnpac01XVCtOcS83T244ZXE5NUFLdzZvSC9q?=
 =?utf-8?B?TlZnSkNWbVNwQkpyWjhBazgyS241Ny9iWUFKbzcvOHVxN21mTWZ2OWVyWHJU?=
 =?utf-8?B?ZnY5b2YvNVpiNnYrYmpmcjRRYzdNZHNYSFZabFhiNUNjSnhlQXIxaGJKaGRk?=
 =?utf-8?B?d0t3cUxjMVB6ekUyZHlOS1hINVMyeERRd29XcDd4bkVvdGdEOHFFb3FpVHY5?=
 =?utf-8?B?U1k4cU5MYW5lNFVWcGQyNGxOZTFSQ1lLdFE1dkhZRFoxUVBkck1FbHlVb3lY?=
 =?utf-8?B?d2dCS1pKWHJsc0ZoRnNqOHlwWnVlVEhTaG9KbnlGOUFGZHJEaEVMU1Z6L2oz?=
 =?utf-8?B?Smt6Z3JnRjhGNDk5NzZyQ3V6UHhQQzg2RDFJQ3lnZmgxVitBeENveEZvOUwv?=
 =?utf-8?B?SHQ0ckhyTVZ6UWtOaFBmNk90NmliZVpGVUtHblVRam8zQmZhaW13SWhBa3Ja?=
 =?utf-8?B?SWlzeEZqZ2hUbzFKVFBzR3NUekRKeG1qejluS3NOb2hzVFNzaTZsNkh0aUpk?=
 =?utf-8?B?aEdQQ0Q5OXVxbm4rYWdBSXhxbzJvNDQxQlNqR2JCb1RPUWpyTEMrQTFxa0Jx?=
 =?utf-8?B?Nzl3Z2M4cXFNRnhJSTVpMnhWOVZjWGhHZ3VWczNJZlpPd1ZVenZHUDRIK1JJ?=
 =?utf-8?B?OWJiUlRKZTJTQ243S0JKYWRPMGhtRDN6QUdCWnV6bm1aSkpsMVoycGFCWVAv?=
 =?utf-8?B?NHNNTmlwSEI5NnpyOFdxWWszai9uVjRRVzNOTjVBNDdxUys3ZXdtb1N1Y29Z?=
 =?utf-8?B?UlhvRU9qakhidlJ4NFNOSi9sTG5DMFExTFM2T2RuTnRlVkQ5NXB0NjBIVElm?=
 =?utf-8?B?N3pyTDl4aXVib0F0UDhrbXl6ZUVJdGM4THNUaWxzSklGTlhGeXhpc1Y2MCti?=
 =?utf-8?B?V0p5N3BTSHVHZzNNa2IxWWlYcnF3N2ZtUlQrbklGcVIyZVJmVDUyZmkyOTYr?=
 =?utf-8?B?ekF1S254UytpQWdJSnl3OTQ1TUhWTVU2SzkwOEJZRUNyZ0hzV0Vyb0lYbUJY?=
 =?utf-8?B?cWduYTdtT1REK0pPa1QySVo4VzJGZGFtaGp2eWJBTDBMcEY5OG5Hdnp0c051?=
 =?utf-8?B?N2dHOTVkckhqOXltSnduVFR4RmhmMlRuTE5sb3htZTVpdkNYcmRVRGZ1cGY2?=
 =?utf-8?Q?xsem9fFn8JxKsDJQX2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df080d7-40f5-4992-084e-08deec696d22
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:31:08.1480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ym5iLdKbLTAUXQvCU+kqCaUywoyb/e/VmqryFAEwZA1s2XrTMOR0H8PHA4Ly9F9DwITnH9kS3NZF/iOtSU8gIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733

+Felix

On 7/27/26 23:52, Vasant Hegde wrote:
> Mario,
> 
> 
> On 7/27/2026 8:15 PM, Mario Limonciello wrote:
>>
>>
>> On 7/26/26 23:19, Vasant Hegde wrote:
>>>
>>>
> 
> .../...
> 
>>>>
>>>> I think this can probably be dropped now? There is no intersection of
>>>> this old broken embedded GPU and a CPU that supports CC right?
>>>
>>>
>>> I did consider dropping these two checks, but I was not entirely sure. So I kept
>>> as is for now. Once these series settles and I can go with next step of dropping
>>> these two checks.
>>>
>>> @Alex, @Mario, Any suggestions ?
>>>
>>
>> The background comes from this series:
>>
>> https://lore.kernel.org/all/20200824105415.21000-1-joro@8bytes.org/
> 
> 
> Thanks for old link. So it looks like we are good to drop SME check?

Yeah I think so.

> 
> Also is it safe to assume SNP is not enabled on these platform and drop that
> check? Anyway SNP requirement (which doesn't support identity mapping) and APU
> requirement (needs identity mapping) is conflicting.
> 

The current platforms I think this is a safe assumption.

Felix,

Can we revisit the requirement of identity mapping for APU?  Does it 
still hold with the current hardware and software?

I'm wondering if we can just apply it to Raven and loosen up elsewhere 
and what gives if we do that.
