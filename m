Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39B1EE7C6
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774849690; cv=fail; b=mFmcHGjbdzrpZHaH8jtQSpwzNMoPjB6GmUGqjuy3ESQ0pDlUkEEn73jnKunC2OMdqkmVfpy7Rx8WJEzK3Y/Ch93kpOQdznSfAyKMNFGX7Bb1xD8Q03+ntoihRLX+x5liLcDCdjAUmHtIJW/cL0P2YzS7NPHaJM/GhoG7wfaw9LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774849690; c=relaxed/simple;
	bh=24P9zK9hdhaHnRmG3nb9PtNwyPld7f8IElA8gkNndUs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=txXO1KCpBwR3x2e9cEmFFaPqV70lnxe0YXgCY+GLrONAmO0KNEdlfGffQlwDtTdttQPoV5HkxVvibI0gfmkz7LdlP9NIN3n26EttrAQfIr94XYorEiLruUDy3O4qTTNzdLqyi0Ch3jzo7Op9spNcY4zdPThmOMZF98HhKPeM9OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YhnCMSW7; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YhnCMSW7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZG630EojqTi1ku100aWpbJfcSQQgabmK6FWRh/eniVZbWRIQdrPgJMffXJnUUxK5R0RZt5Tw1iIDGnpIsYDjyZOecqvWnesdNK6xeYPexwlZOmXKVp87CU1Re12NTZoejEh1gdpshRl7FtcmskAAbEK2sRLoBndi6BA3tgiCzWhDzzrvO6cSJIZ+/O9IURzSdMd7eGrJXb6lIfflyFTtLwLJhMN0Jyau+1dKp+oqN6u4fEHs3zEip4k/CWjxHVQaYWQAHDgy9GcESMvYU+0dAIVWzSFh+Kfu8jWCOmWm2BGHWepqFu2qCQpNO9001PdBxpEOljcoVYXY4xE7pDcJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkUQZIexnNy2gqyYqWpoHy8vDvnWHAIJPPUczmTBwxk=;
 b=xruogTwjPjpC06b489DDJ6WFMRG3QB3oMmFWcFJ9ypRLY1mwzY/leoWYpnXA3zCJOwDtQIVI6Mo/ZUTS+Xm4Yzv6LFb6T8R/sgZRjFc3a3jY27VpSSn7LaePDmskc6/QlIVCn4nq3j4InsEQT2hxV2yC/Ya+8adYpvxM5N/1sVGotxp+MeQWRJ0WgGH9pFdGO63ZCMkccTzr99O83CxZAsCJidU+YRNdJ2OeSaAvlumfcsTvCZaxmLeFoYiXMfWAvdvjpfo/JTAWeXcVReAzgl0LhSoECoLirJYBsGKWqPM5BESphjp9pSYAxEi9IxW5piWUGZzCntld+xqtcijjyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkUQZIexnNy2gqyYqWpoHy8vDvnWHAIJPPUczmTBwxk=;
 b=YhnCMSW7W4GhpFFJnmzf7e/qiKhKqAhhBQT57NnnHO/lRPb+Qmcm/h6QQxNpHcyZz3MMxIIgj/8Sctr7eh873hGJvroJQlSSelHxYo6HDPmo2dsHl9xQchIForNUWxhV178jTwvENwHm5BWnwb1/7+4oNBkhXGLQkN2jDCgpAMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 05:48:04 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 05:48:04 +0000
Message-ID: <d5059386-1ed1-4110-8283-16e3a8407760@amd.com>
Date: Mon, 30 Mar 2026 16:47:44 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com,
 alistair23@gmail.com, lukas@wunner.de, Arnd Bergmann <arnd@arndb.de>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org> <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <228298b7-76bc-4ffb-bec0-0c35fd487c4c@amd.com>
 <20260323182014.GR7340@nvidia.com>
 <fa1c6e1e-068c-46d7-a623-58c225bb03f4@amd.com>
 <20260327114921.GL67624@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260327114921.GL67624@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0086.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:248::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e72e7a3-d7e8-4153-8946-08de8e1fe912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DfWztIeQjwtLhtmdncRXruqa28KwA8ehiFojLQ63KVB8EtcgUcKmeudDG28T8YEh6Hxibonxs8RCT1xXomRBtMJ6WpCxxADhnpCk07ahz9qrzqAODUfvVmIGWxMuK7gzQ3bx55HMuTRdRjlFZvWQ/haC0YtSA6ar7UnqIXMEJ+UYDErPKRNNuEm4P9kaLHldn+ZwbaMKlMTG7AqzNr0L4X58M5SK1ctXow2xrNoWX4ulxFiB0Suds61+9H6n4ikMyh0ica126TpPaPnX9NFfGKbOozUqfxxbVI3ibtXaXeYBzNyQuTTqCzOUPwBDFajQlctDhBzEdhmj3eaIzS8q69Mn2Gr+P4pF82ubrbYx5LtlABsMAXK/m5nT+cnOuFSgegLKFAr8TsrPOpc+z7jNE2fhHZzzF1208wOntRQ18ubW9yNCkfDPzFQZ8ga8prwm8Mccys7n6Nf2gxRj0W8k/1RwHZGbPzZG3FZHJXa9e6CEkraie3Wn+jzdwOgjRcYLnnPEa/roX0RFnHqOawIgJ7WVz4eueB4Ye2DzsNw+9UT0s7EYNBXjLbu3KOg/rQXAAsLNcOfkRwatJm2lS1bmq4EkTGZ42P9myfZRGgP/UpJmqsoDR24o5FCa4H24jAzAZI4drJdya/g/kU7uKSEIwJmn50UKnGeqpked8TwIf1m8hDM7DvS523Gb4Uq4MqB9VMvAZsyQL6eIPysW21lV7+qEHe4HL3R/vmwhcrL41wM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3Q1d0JiRGN0aUt3M1BXNFVpcnFrNG1UY1R2TEJOL1MxS3Q5K2hHWHNZZkth?=
 =?utf-8?B?MU5XdGd1QmtrWHh4QkhndW04RFIxSElGVC82NDlrbW9NVkNkYUkwc0pMTVhm?=
 =?utf-8?B?dGFmOGJqLzZyZWtjVnp3eStOYjhwM0lRY1JVbGI3WnNoQ09leWg4SE9YejZX?=
 =?utf-8?B?bzVBSGpCL2RSK3R6VVlBNXFldlBqVzBEdmZTa0I4cVdTVG5zUGJhVzE0RS9R?=
 =?utf-8?B?WGFUUVA3QXVKQWxqM2NOQ3dsdnFkNnRwbkQwVkd5dWJPaGZqaStKV2kzMHVp?=
 =?utf-8?B?MXVWaTFUbmZ0aWZoNE92cEhZaGVSRy91NmNWOFFsNU1OeTRKRjVLZTFHdlBo?=
 =?utf-8?B?b1dLenZ4VTRuYlpuanYzTjR4M2p1Z05RSjdlRW9pT0taZ3JaYjYyRGJwdm1I?=
 =?utf-8?B?NUQ4ZC9acE05RXEyeVFsbnNhSEUxVWg5K0NOUHlVeEs5M3dFZnF4L1hkVG05?=
 =?utf-8?B?aHduRmNCQjRWcnA3L3F5U0hsQUM5ZUc2MlYzV1Jaa1pFWCs5bWZESjFObG1J?=
 =?utf-8?B?NGUrcFFxZmRDaEFFNlpDUzlweXBMTWRCTHFMaTRHWURSY1Z1eU9GSUIzY3NH?=
 =?utf-8?B?bVQvamdINzllN1pJclhjVzlvbC9OdFdGd0ZLMkdHZ0lQRE40QzVUS2wybDFn?=
 =?utf-8?B?TzlqSHErOUhyV2psZmhTd1dQUTJpTUtJR05VVWIza1piWW9yeVpzZ0xSbGRM?=
 =?utf-8?B?dkNFRnB4NjNsNVB5L2drQTRiNHU2QU5PWGR3cWFqSFZqWExYTGZoTDA4REJP?=
 =?utf-8?B?c0wvanVrbUJLRE9jSFVwOHRZOHJxYTcvS0FaYUd3YUVMQU5RcFYyK0F3Vmpw?=
 =?utf-8?B?ZExZaXB5SkxZMm52bGczWXlIQThKYlh2VGY1Y2tPSnRyU3ltTE1kV0dYVVV5?=
 =?utf-8?B?dFRuRkxyYlpsMm9JSkhjNGRwZk1semk0MGpwRmVpWnBPRDdTVzJmZFNJV1py?=
 =?utf-8?B?QnlRUUNCMlJuaFMxWWo5V2V0c3hYUnRGNGdiOWdub2Y4d1FGTnlydEpOa3lX?=
 =?utf-8?B?RWEwd1pnK0NlRXNvMmVTSTYwM0ZWS05taGtSNWUxU3RhQzZ6RlQ5WTdSMTJv?=
 =?utf-8?B?bTk5QWhTeGExdzJXQ3R2OXNMbjc4WWdnaitQdGcxOFZURTBCbUI2dklXckpk?=
 =?utf-8?B?S2ROTXBvU24veWNDNnZKb29Td1U4K3VzbmhoenJCbUdXUm5HcTZhN3FZb1dU?=
 =?utf-8?B?UWMwTTAxYUl5VEMxMG9nL25LZTJtOGdKVGlZRk43MW1xejVrRU1LbWRRTjAx?=
 =?utf-8?B?Q3NDRlNWeUFqNHc4bk5nZDdFb0dKSDFaWlNUVVdXVmpQcFF3QVV2YXBFL3Bp?=
 =?utf-8?B?V1hJUzdCck1mZEtCZ3NFUGZISkNmbU50MWVidFR6TFVESUlHU2ZNZ0Z4YzZS?=
 =?utf-8?B?V3l3V0lVVjBCRFlxQVJRTC96c0lRZ2lMaFQ1dzBCKzN0THJHd2s2RFI3NGRW?=
 =?utf-8?B?alp5OURRMUUvSzlLTjBkWTlQUGhnQ3hqOWRtbVNxa2MyVzRDVHNZTXdSQUpK?=
 =?utf-8?B?SHlKcGM1ZFltd0VKcVRUNUpscEZpdGNxenBTd1ZVR2pGeCszNlF2dzhmTTZo?=
 =?utf-8?B?cW1JSlV2UytNMy9KeVUzMm0vOEt0dzNJVTJ4d0QxL0oyd2JlZUlHNXNqWkFk?=
 =?utf-8?B?VzF3SWVnUG8rQy9qem1VenAwKzV2b25CeFZrcHBUZ0JYUUE1VUV6NXp1b2or?=
 =?utf-8?B?OXJRa1VCaEh5cVpYTkw0cVBoczZobWloY1RzWlcwRkpKMUhNZVVpNlRYUmFC?=
 =?utf-8?B?cXdsUGNLK25adm1uYm9iOFpBRlBydlc1ampzUTFRdXBSazA0SUJ4dGVtUk1N?=
 =?utf-8?B?U3FrYm1nVzVLTTVpQm9hR3lFTFRGM3BWSUo0T25PZWlmeHpDVDBWZ3ZhVDdj?=
 =?utf-8?B?a0FYWVBUSXRoNjMrei9ScXpzR256MEpmN2NxUEVjUlVTVWdFclkvQndpU09y?=
 =?utf-8?B?MXE1M2VHbzhOR2s4dWdpcDBwRkIzcHVlaElndFV0MWt5YStEa0xsVjdUOFV5?=
 =?utf-8?B?WmtjZTJETlFMV0ZpZUU0djFXNG1lSnBhcWRqZngrSlNGV01qUmhpT1hwVTBo?=
 =?utf-8?B?bkJzYnFFYVpRZEpSbXV3S1huMEdzd2F4SHlYRmtqME5ieTBadG9vMDRRSVFi?=
 =?utf-8?B?UngxVWdPaGhrWVYvS1huRnpkVEJMRTdyTlY4YVhhMVBlVzZ6aThPTnhSQ0Jk?=
 =?utf-8?B?cjhKTVZhY0s3cmFUTW1ZeElKaVFLMWlYWTNKaDVZb2E3czl3SjdQajdxd1gv?=
 =?utf-8?B?YllsMGVORE8wNXBaUTFZd01JODNaRGJHUkllQmp2Y2hVV2NWaU5XWlRVOW1m?=
 =?utf-8?B?VnZRSVRjZjdleDk3dElpS1NPN2FyT1BvcTlBQkZScml5WU91MlZOZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e72e7a3-d7e8-4153-8946-08de8e1fe912
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 05:48:04.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+XPPebDu1dBmcBY6/A+TzehGNQv5HjTy+bkQ8sEjY6OWeBDDjcU+Ci1xM4podeuWrMiWl+iez3Xa8w2p/oNZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782



On 27/3/26 22:49, Jason Gunthorpe wrote:
> On Fri, Mar 27, 2026 at 10:38:15AM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 24/3/26 05:20, Jason Gunthorpe wrote:
>>> On Mon, Mar 16, 2026 at 04:19:30PM +1100, Alexey Kardashevskiy wrote:
>>>
>>>> and btw this only works if the entity generating the MMIO reporting
>>>> offset (==TSM) knows about BARs sizes, which is not the case for AMD
>>>> - the FW has no access to the config space (so the HV needs to feed
>>>> this to the FW? may be). Thanks,
>>>
>>> Then your platform just shouldn't use the mmio offset feature. Set it
>>> to 0 always.
>>
>> pcie r7, Table 11-16 TDI Report Structure, MMIO_RANGE:
>>
>> "Each MMIO Range of the TDI is reported with the MMIO reporting offset added."
>>
>> My english struggles here - can the above be interpreted as "Each reported MMIO Range ..."?
>>
>> as if it is each (except msix), then I know where msix is and can
>> amend the report inside the VM if msix is not locked. Thanks,
> 
> To do this you must be convert between the offset'd and phys_addr_t
> versions otherwise you have no idea where the translated ones fall
> within the BAR, so you can't figure out if msix is covered or not.

I know if MSIX is covered because I know (from the PSP) if it is locked so it must be reported, with specific MSIX/PBA flags. If it is not locked, then skipped in the report but I still know where it is. For other ranges, if the device is not skipping them randomly, then, with a preserved order (as PCIe mandates), it can be reconstructed.

PCIe:
===
MMIO ranges assigned via BAR(s) must be reported in ascending order starting with the lowest numbered BAR such that
the first range corresponds to the first BAR and so on. The range ID reports the BAR equivalent Indicator (BEI). Values 0-7
of the Range ID are reserved to indicate the BEI. The device must report the BAR equivalent Indicator (BEI) for ranges
associated with a PCIe BAR.
When reporting the MMIO range for a TDI, the MMIO ranges must be reported in the logical order in which the TDI MMIO
range is configured such that the first range reported corresponds to first range of pages in the TDI and so on.
===

What do I miss? Thanks,

-- 
Alexey

