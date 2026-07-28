Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E93CCFB0
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265856; cv=fail; b=JdDEYonhgWj7axfy+DBjNmoZoyItKcI8MW4n2A7uDS48ZQOARm5UhnsQ6wUmnmajdL+PNopwZPSR72ljOR0kh6CF9WwgslV6lvubDXq+NUJGK7J2z/zwv4mqFjt3cA0o4XUFWYQXsr6MJ7w2LJS9yC0g53h5uXCoAMqc6SClqqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265856; c=relaxed/simple;
	bh=iTyyX61jk78yFSSf0r8NL2BRI+bWcn+WHLP1ENseL3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fVnAL4F46iGi4wuHcTI4vwakWx/PRMJYY9yPPSObkSGnpSMJVZ+PXea87J8VbhcaeIMOU6Oo8J5wYIoJpqUOH+tNoS7ERtsyqViYgkqYEDWdBoPJ5vfrfPJOgNly8kTw7yXsdFLZS9PblM0ZiPm+kYjzdH028v+JOQ2TK2p3Tqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qJ2sKriU; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qJ2sKriU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0H0Oc2hCsFRJXE+FiHwJIUiwJmYZsGqrO6Lh+e4wE4UdY1UB0wpx0KgRhpmSZoz9arD3jDLP0dDa1OlrZOIs41yR9vTQx1USLV3LIx62x67TVCMcN/bcnJLgWlJ4bVy2PHuZbuzpJdpFi9ObKqMq9yQC2t0oBtMWQKIWAAi9T8JYYd845SlH0Sm+nJzjZwDu5kt9dI+oXrhWWbW9zLsBT1gmzsksCcguQIvprbcDPYI3Yx4ePl3LJrFkXcicmPRPO683iMNGcE3gzRHU28rEqs2i7ZtR9tzFrWrftf4/EPgT5gXJVlD57HnNiiuXX9bhU0EIU1D6wuAkGlyXowWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY8mPwG4oHP9vJ2+A9m1aL1J0G01O7+fqNQOu/6+h4w=;
 b=QJUilt3fc+KLk8yUlP9XHa7o2vTM7yKrV8c6nVfxgiIyOnzktwdkQm2jifdysoz/5DpoOF7+I10YRUPY22V7FGUUT69nWw7OPMz9W9ThX2J/0UJZpzqxxFUFAt3XcJvRAl0Sf+LpHb5K3MVk/2iyNZwcXCEneVXuBZvZbXQlg4MRDdrgfZsN/tXfB24tvyTrh3nlQL8SAKZd4gQKOgLZEjYUxtM4zvYLA+bTfm3CmP9s0vWR6VyK/H1N8FMC+4nzs60UfJpWbfnabfyFKWkDVOI5T5zUqeNRhm3AVQoKJFWnyKeZD3v+MQ6/vTvzIzC6Sqz1wKwQ8LJSLz+qlZkGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY8mPwG4oHP9vJ2+A9m1aL1J0G01O7+fqNQOu/6+h4w=;
 b=qJ2sKriUaKHpnBY1H7ArLfv2UxR5cQh/7qlOl79J2lBLEOUSdFtEawjF/8Leryfld1laeDPCoIcHLZ3t33kZw0SLwCjHGeYBfkab2ZSaEttYTsw0cyImI7id4Mt0cbalkC3nr2Dm6kvSWn3j5HJ7ihR16ZZUmFfC5lq+p20n1kk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DM4PR12MB6011.namprd12.prod.outlook.com
 (2603:10b6:8:6b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 19:10:51 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0223.017; Tue, 28 Jul 2026
 19:10:49 +0000
Message-ID: <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
Date: Tue, 28 Jul 2026 15:10:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
To: Mario Limonciello <mario.limonciello@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0504.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::26) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7720e6-7fda-4cca-ef08-08deecdbef43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|4143699003|10067099003|10063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZpCYCVEoRT3S8OVXxNI+PxvgiCzn0FqGOGDBzT2E2eYrPHQwyLobmtTfzREiMrcOHtMrX8bWHcgOIirfcDg3+xVIp21VpC9GqZW2RUZj6hWHWD4BaJzzVouIn8WQSz4SgSuQN+Vuz599kdBTGHTT2GBnHhdzDOs2uVpj35BnINnJszGBPFVZMOaFHKPfe8Rim8uOf2OUYcB3f7HYeYbgg0fFlVS+VkOhQQjTI9p2U1Bavv1ICdg6c2PVEae8VIo68ibEvZh9owPm3x3BeA/8o+OTBrOv2tx5HMJAw7x+MrxVTXZzq+U/f9AlB0d+IlI9J+xtALlV5gohNszQdTpbkqapfkEnhW3X1jJ4GOTiAtW+/DEqhl59cvPBBvjiJkjSlH9/+jtN3eztGx2KiP2yIXowfBzYRWOwIpl9e2ZCIIVmDnbavVfxbUh98fq8VQMJupN3A1bc6WEcTBV0RPS19z+UlUilNdPBx05TTnxSHKJYoQrb3HIm4ud8Vwgsge28/PhknMT37fZS9gk1eNMxtZDzI5DnOtubY4QgbR3GLSbUwnl1le2E5P+lvcRWIhO//Hoq+xVzmr4RYSo8+6k6a6JDCf9UBuKAQeimYIB5SCl+fq2742Me06Zm33ftT6ndLCe2kIEAchkBoBYj4K302Sq6gz7gmbGc1s1HgSS+Nj4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(10063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3VQMExETHUxK0JXeHB6ejBmOUUwRUxBYTdyblN5ajNIZ1lOMHBjd25NazV4?=
 =?utf-8?B?bTBQMGtFWmxob2FiQTF6QTVGcXl1d3I5R2xYdktGeGRxL05FSHE2VWFvTi9E?=
 =?utf-8?B?S2pYZFlnYXg5R2ZzUVNoSlFIQkZtVG1oSWRKSmNZd2VvQ0luWVlXU3haNzg0?=
 =?utf-8?B?Zk5CYW56SjdTTEhZZ29jTFFrWnZlMzVjSkJXdlZubHB3aGRkaHV3MFAyTFhW?=
 =?utf-8?B?Znd2V1VBQ0Zka01FVVRIMWxDY1d3Z29uL3FkeXd0VUphQzlVcGZCajFSYnJS?=
 =?utf-8?B?R2xNVmZneFRLOEhCa1JXOS9FZTA0TStVTCtHTFZRNXNJYzhVZmU2M2FUTHR2?=
 =?utf-8?B?ZEtGdzAvb1c1cU5vSWxkek82Y3dNTUdzNXNHQ3h5ZDhRYXFPOUIyOGR1SGo1?=
 =?utf-8?B?ZHIydEZTelVkaUNGaTZzcTd0amlLYkNpcjhjNy80T21aQnpYK01BSmNiZSt0?=
 =?utf-8?B?Vk5wUUlkUmo4ejRJL1MwOXhQWGJ5c0t2SUNJTzZOOFAvMGRQVmU2WXJoUkda?=
 =?utf-8?B?VUlReDdOcTdRdnNlT0RLd3FvaG9QeDRWN3lSREpuSWkxNDhtZ01yRHhYdXNZ?=
 =?utf-8?B?UkdwVElHM3dnTXRaMzFFYmhhL0RueklHb0dBeGdPV1l2azV6a3lSNFRndkpp?=
 =?utf-8?B?Z1NvNUFKUUdSS1RRMDFWc1JIWGladkg4Z1ZXR3RoV2w0MGRWeHFNb3pqRlYw?=
 =?utf-8?B?SjI3cDBmOWJ5bnZ5UEJ4d3V3WklqWjBtWmlUKzlSSTN4VmFNVUF4TXVwdDM2?=
 =?utf-8?B?a1ZCNTJPemVZek9lcWk1OVZ3a2N3dVI4K1M2amdpQlFnclIwNFV4M25EdzI3?=
 =?utf-8?B?OVhUd1daT2ZNOXJ5bXRwV0FBQ2VwQjJyWjMvb3ptQVp0NDBPZlMvQ0RNeTlI?=
 =?utf-8?B?Z1BIbk1MM2FZODVwdW15UVE3UXJ3ZDNFY1dVQkZuMHh3OCt4SlRyWW9md21D?=
 =?utf-8?B?MEpvUXYzUTBaam9mdG5DNi82UDlrT3RxQjh2dnBodVpvRFR6Z1M3TXZEUi93?=
 =?utf-8?B?UjN4QzFabmJaVXQyTkRJemJHbitCSVJzaEFrV0tmeEhtVmljWU1VS01pWDdS?=
 =?utf-8?B?T29jQTFkSVViWExjS2hGMnRWYjMzdmRWaWdtOHJUcUs5ZXVYRVhRZThTMC9u?=
 =?utf-8?B?bTE3MjlLYXczMUpnRFNNaFE1OGFRMG5hSXNVYmcwY0lwUHJST203bzI2Y0Zx?=
 =?utf-8?B?VlJ3VkhvblRXbXBQcmFXaG55YnFGck83bXhBbldCTHBJb1QwU2V4TjY1Z1NI?=
 =?utf-8?B?UFBaTnBoKzcyQ1YrODVCVzVFdDdJcVhUdm1OV3p2b1RvcXpBNTdVcGRNSEdr?=
 =?utf-8?B?RVM5TzJ6Tll1REpvaW1Xak81d2Naa0pCWS9QQmR4d0hEL3Jmc1ZDM1JrMnhL?=
 =?utf-8?B?RENCTzB3Q0FVQzdjcEhZa1dLZjA2VjE1R21udDhZclI1aWJjQVJodE01YTlj?=
 =?utf-8?B?a2xHVjdXMVBGbkIxMndlZkdNS0hoTnJ4YTlSRlJIOGdxMjdhWmdRa3JYN29H?=
 =?utf-8?B?MjFuR2ZMNUN0ejJJcjQ5aFBGQ08xSTNBQW1saHNhcm51aDFZQUk1SzN5ckdY?=
 =?utf-8?B?ZUhJRlN0cHNnZ3hNdHErZ1JIVUgvZDdpWlF3YmlleFNRd2Y1cDRuODlGa1Ni?=
 =?utf-8?B?ejhGNms1bENWWDNTM2ZuZktIY0pEcDBrd2tUY05sQ1NUVHhGUnp5b0l0R0ZK?=
 =?utf-8?B?czg0dWNmV2JGWlZ2T2QrdXY2ekU3N2hFNlM3YnVRYThYM3pLTnF1Rk1FY1dG?=
 =?utf-8?B?dmxuazB5U2ZmMTFvM242L1hvSXFWTzFPZmw1M0dkSGFtUnlpL0JsOVljNGlE?=
 =?utf-8?B?T2JpOWcybk1CQmlKUVFtZklGT0p2aVAzQXZCZDliRjhkbmhFRCtRZEFFODVa?=
 =?utf-8?B?YS9iTmpIeVdxbEVFMUFMVkxNa0RhS1plNndDMkVCWlI4L3VBOElLR0NjZUI0?=
 =?utf-8?B?WGxRNnVENWd3NzFjRmpaV1VjMHE3bTZ3UkJYVWs3SC9NL2tjQm5OOTRXM3BW?=
 =?utf-8?B?MDREa1FhbUFtYTdUdkV1U1NuYVR6SFJLRXN5N0p6VkE0NERzZXJpV1ViR0sx?=
 =?utf-8?B?TG9LQ1ZJVnVsREVhQWhPWXlXNGtqSk93UHFhaGtidG9Zc1J1bUpCNXpYN0N3?=
 =?utf-8?B?a2ZLMm9HRHpCZitKRmNCUDdIMlQ1bkpsQWp2UzJFcEtnd01QQnRqcU02d09y?=
 =?utf-8?B?TEd4Zlo2VGswZW5WU0hpRFJacHZDTVRpU0dsUWpwV2NMQU1WcFhXbVNjczNQ?=
 =?utf-8?B?MytuQm5Hb0NlTzVBcUxpMGlwZXdvOExYdlU4dDNBNUpqRjdINzVrRm9CVWwz?=
 =?utf-8?B?MUJYcmtRT2s2RlBTWEpnaG9HQ2E1WkQ2ZWp2TXhpT0JWRlh6cUlDdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7720e6-7fda-4cca-ef08-08deecdbef43
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:10:49.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwwqlcP3pRHVcWfZbw2U63gcTjAjTDz406t3UvFN0jk5FMyADfc/rWL2fQ7xGNkaZU7AGxzJj+MM8E21OyZUvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011

On 2026-07-28 01:31, Mario Limonciello wrote:
> +Felix
>
> On 7/27/26 23:52, Vasant Hegde wrote:
>> Mario,
>>
>>
>> On 7/27/2026 8:15 PM, Mario Limonciello wrote:
>>>
>>>
>>> On 7/26/26 23:19, Vasant Hegde wrote:
>>>>
>>>>
>>
>> .../...
>>
>>>>>
>>>>> I think this can probably be dropped now? There is no intersection of
>>>>> this old broken embedded GPU and a CPU that supports CC right?
>>>>
>>>>
>>>> I did consider dropping these two checks, but I was not entirely 
>>>> sure. So I kept
>>>> as is for now. Once these series settles and I can go with next 
>>>> step of dropping
>>>> these two checks.
>>>>
>>>> @Alex, @Mario, Any suggestions ?
>>>>
>>>
>>> The background comes from this series:
>>>
>>> https://lore.kernel.org/all/20200824105415.21000-1-joro@8bytes.org/
>>
>>
>> Thanks for old link. So it looks like we are good to drop SME check?
>
> Yeah I think so.
>
>>
>> Also is it safe to assume SNP is not enabled on these platform and 
>> drop that
>> check? Anyway SNP requirement (which doesn't support identity 
>> mapping) and APU
>> requirement (needs identity mapping) is conflicting.
>>
>
> The current platforms I think this is a safe assumption.
>
> Felix,
>
> Can we revisit the requirement of identity mapping for APU?  Does it 
> still hold with the current hardware and software?

I'm not sure what this means. Is Identity mode something like 
pass-through? I don't know why this is required on APUs. If it's related 
to IOMMUv2 support, then it's probably no longer needed. We're not using 
IOMMUv2 on our APUs any more. Support for that was removed from the 
amdgpu driver a few years ago.

Regards,
   Felix



>
> I'm wondering if we can just apply it to Raven and loosen up elsewhere 
> and what gives if we do that.
