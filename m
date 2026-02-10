Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013085.outbound.protection.outlook.com [52.103.74.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076D31A545;
	Tue, 10 Feb 2026 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735741; cv=fail; b=dZcgWnpu2wdSf/IcRreK6+d+xPEt8bHGhFsQew0Xf8QRW3fM5ydJGnjzr/XqkyHBAorpC4pNFS9pufBxRC5HzuaVn8QdWVYDivmqX83lFn/lZ+50tjS9inNzc3tOXN/JAudtH6+2yuqYBLCsWikjC1K/rBwtRevTSAPLKatWFQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735741; c=relaxed/simple;
	bh=CIWVzp/3Gx2Pxu6FMDKwRyrDfYiJDk82Sgxxre3Ggqg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f6ds0h9fQ7C9Tme0OH4Ij83P6gNsD2o8F6ep/z0O8nmPxXSC6ydeRmuwgJ8ZQnr9fe+1+7xS+sWvRgNaZO1J2rir/XHQm/VQINfPfm4Vzv4HFOsoPz9yrVUQq6t+ueaTM9tUyodLg07SOqqt44PdwsNMHr+Sah1xXNEyvhOPK8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=d+VVzGWx; arc=fail smtp.client-ip=52.103.74.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="d+VVzGWx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYWcvPLHJI+U5DwYQyC5yjw37y3J/XNjKsuyBJa8FXKy6RpjutGfj9hLYdZlFVjuDFjrAfwlQLunidNOdBS7ItvM11BGY+MBNMxgbAxDkAzbqgVxSyNCRsb68ke9vc7NHz4oWB2makXoqsS/8/JR4VAF8dN5eRemwaPa5zxwlHFxLk/gzZFSh+Aa4aoDkC9gQ7jCQmQnwyjts6LO7n+7gCjgoz9EfJt42qHNplJVXuPrb2uKuFoWK7gT+P72L1dZSmiQyiG7uPOIavqO/jaH3NsjefiFq53vfhbMEX1MyH+ToDQEdiyOPULBplQt2OQuul7ctgwZGcE4AbZLqlLiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJBABoPWfkNynTR2EKFYYir1OnKQ/3NSE5kgJleCpUM=;
 b=O8lyYbUB0TxI/MZ0vq6rAQC3Yt3llmHSrRkvB+/YCqM4Zjzc+VcJjxcy9ANncpb4Pvm0dLqdSnXya6OtBr1RGVyfL/3R4DaRnuOC0hkrh7SwAJKq+zl4lxrwvhiuKoUS6MEpY4/Z+/LiselfpMpksZ4E9qLXIHbQSVkDQxLOGK4NM/JXQ0iYye7ozaf2lDuV9+BJS10br1NP4khvP83llioFxG8rAVzD82rg/uzZbIFsKPyLN1Za6jNUmaGckFjfTO6BsAbZa4AB8+UYB0kIJB8V1znBvNYErxvAt+IobM9X4H1pFT9bmbsma5FSrHZnUgI5u0W++vDST+v8JC7N/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJBABoPWfkNynTR2EKFYYir1OnKQ/3NSE5kgJleCpUM=;
 b=d+VVzGWxHXAwKjRuR8quUlMlxyFBOrl7L0Q4Ddo1sWHWRoQC2g8j9Ln5DuNzELewmE8ixTs71+5+RKScIwUgM6pFtpyDyai3Ib0kCznvKWL/kMZoFVnBcn/0P8rS1L8AFxLm9bbx9VGvEpyOPr55xFyDkBRwuTnijMUt20kP6VafY9P18qIFoBQ4+iI0B/zVw2Ytl4mq827LuyLPK/pbwXCZoqRLWjARqPIrHGrYwtbf0Fbag7S43zA9YYw3jdwI0CgLAgjbBvTbHrRU5Gor3d8QAWie+MApQfc7OEbZGoIQy+gOrh9MmAJfal8XGjJPLNZg4f53q0W4JV9GPJ9A1Q==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SI2PR01MB4476.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1bf::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 15:02:12 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 15:02:12 +0000
Message-ID:
 <SI2PR01MB4393F2E837009717A766DF0CDC62A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Tue, 10 Feb 2026 23:02:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] PCI: Enable the enhanced ACS controls introduced
 by PCI_ACS_ECAP
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: bhelgaas@google.com, jgg@nvidia.com, akpm@linux-foundation.org,
 bp@alien8.de, rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439394223FDDF3F405B40926DC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260209164349.00003e41@huawei.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <20260209164349.00003e41@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::6) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <51c5b4f8-cf34-4a25-b3e3-04b6816daa09@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SI2PR01MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: c35068fe-502d-47b0-c8c7-08de68b55e27
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|8060799015|15080799012|461199028|41001999006|6090799003|37102599003|5072599009|51005399006|12121999013|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW94Z1dUbzg4aVNjbXpSeUoxVGhEZVNqRjNhdW50WGQ0bVNrL2hqc0tIbnZB?=
 =?utf-8?B?bEhSaFNJcnhEZDVudHlIQjcyRDViRXFpRXR6cVFsSGY3bTNDaXB2YVBkZDlQ?=
 =?utf-8?B?akV0b0NxeHNCQytxaXltNXpLSWRUbHYvSW8xYitxUTlrU001V2NLVitMakJU?=
 =?utf-8?B?UlpOVENkWlZzYVNrdWhhWWNwYThNTWNxcm4xV3hGRHl0eVA2bTZZK21ZR2JS?=
 =?utf-8?B?c0JXTnh4N3pPWWl1WUNKeXRldjFmbGtnem8reWJrQ3dWcXJySDlyeG4vYU14?=
 =?utf-8?B?TnlYb1FzbG1tYVl1L0dhejRjVlgzWlljT09wM1Rld0V4VFRrUHh5Z2ZMUEVX?=
 =?utf-8?B?MVJJbGZxRnR3M2xQRW0rOFFUM3hZdVhYSll4djRKRFNlSXl2U1ljckRoc1hQ?=
 =?utf-8?B?RVhxby96dmc0WmdDbVRhNk9XWEVLOE1TcUpZT3BBNkxJWmMyUGl5UXJES0J2?=
 =?utf-8?B?NHBSK1phbmZDQWdOOVphRTBiVzRhSHI1dkJxamVxMTZnQUdLNnM2ZmMrMWNY?=
 =?utf-8?B?YWhEYVRRWHRGMXlCTFZKdGFIMUZyd0E0MkRoczNNS3pjRUZranN4U0ZKN1Fo?=
 =?utf-8?B?bjNjYVdTRmsrdlIxdXFNM1pyUWxpVm9xUll6YzFaZGhSNEtIVXZKNklUcHpC?=
 =?utf-8?B?WTExWVY1d1k2bFJPOENtalJwQis0Tk9UZ1FEQjV0NndFMDhnT0h3azQ1djBB?=
 =?utf-8?B?MzV2dUYwY1NST1NxVkhuZHBTdU56dXQ1akMvcVJ4TlV1NzhleTk3ZHVMM2VH?=
 =?utf-8?B?UjRBTE05U3BLd2RJWE5YU213eEF3a3RucWxRekYrT1hscmhJOENSdXp3M3Zs?=
 =?utf-8?B?ZzBHZ2lBMGNNTHc5dE1uaFNXVG9lUVNPaU1NRzV2UFVRQkNKTDVoKzBENkZG?=
 =?utf-8?B?YWFKbkZyaFFaZG01QmNvQjFJWTRRMVY2NEdDd1ZteXlFcURyMVUyN05NR1gw?=
 =?utf-8?B?ZU4wQyt3bHVNYnZ1b1RpMFFubXd5eUJoY3ZSaHBmWVdiWmx4TFYrVFc2bm5j?=
 =?utf-8?B?SXkvYzYrWm5PQUV1WG94MllPTU9XbWgwTkJrZnNKZlpkRndpQnRhMGxWZnJM?=
 =?utf-8?B?eGYydDd4TDZaN3hMVGRiVXcvVW4zQ0FrMTZSSXl0NEl4V1BibjNFczRpRDdu?=
 =?utf-8?B?VHUwQldia1NDOVNoVHNXOEkwbDFPUTVweWVlZ2J5V2FKa01zQUZnc205dlhh?=
 =?utf-8?B?SWoyZ09XczZUa1pmZDJzOW9QNmpnaXNlalROZ0RKMytoa2U0d3hSKzk2WjJq?=
 =?utf-8?B?SDU1YklsMjR6VmF6Yk5xaEZkOWhFVVNkL0NVWitWSmdBSHMxbXRvNmlEY1FE?=
 =?utf-8?B?KzFKYmp3QUxjR0hUY0YxUnZjQ0lyMVl6Z0VwYkl3V3B2R3ZiZ24zZFJkNUVr?=
 =?utf-8?B?QmZSdUh6TWpUekxnNlFKMUhHTUp6YmNXTFlSNkE0eUFmT3pCbzk0NU1UUmZV?=
 =?utf-8?B?cm0ySGIvVUw2THE1VmgySHo3Wnp1YkRpSDU5NWs5dHo1bWJYeVl5Q1FjSk9M?=
 =?utf-8?B?WHRBN0VyWGdubml1czFFMGJtWElVellxRzFSRGdCYzFGci9sK29NREV4dm93?=
 =?utf-8?B?VjA3TE8xNTEvNi9KOEdITkd1R29VcnJHYWxvS0IwWHlMdW9GRG5xRnpsenMz?=
 =?utf-8?B?T2JaU3kxS0djak9UcGEvRFZKRDZ0WlVDc0RBdTE5aWcyM2VrMS9QNlRGblo5?=
 =?utf-8?B?VGdSZW13TGVKbURuZjNmMnBoSXBBdFZUekwxbjhkWGtXaXNIUFJuWkJKVE1y?=
 =?utf-8?Q?fnEmGhtLhA9b6uB4EE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTg3MWtkK2M0YWxNWHZYdlhEbEhqKzdqRjRPQTZrallqd2s5dmhBMmdEejIv?=
 =?utf-8?B?Z3hOTkJnM1ZWOHVZZWo5SG51T0hkbVRFRkQ4bFVhMDAxSjVxdzhjUUEyenpO?=
 =?utf-8?B?RER4S2lqR1dBcUxuQXRta0l1VHYvRkRENkVMNy9CQnZ5UDRaalcvWXZ4MTBi?=
 =?utf-8?B?NW5veGFHa0l2alB0Z2RlcHdtM1JCU1JiOWZUODVPVktqTnU3VGtEVWlzbFNv?=
 =?utf-8?B?M0RpM3QxTG9PSHNQVitPOTdaT2ovM0VGR05ra3YvWkJMOUlPNnNXN1hYemlu?=
 =?utf-8?B?YzBlSS8wK0RhcE1xTlovU0VuNjB5VmROSlpNZkl4V2R1WTR4amFYdUtEV0t1?=
 =?utf-8?B?anVqN0g3MDl2NlpDUnA5VXBkcXBvQjJJNmxDMmVSU1l2dnpVeUwvbjJ0WDl2?=
 =?utf-8?B?NU5lN1VEUVF0MmhVNHZWUWN6eUw1elpSOHhuUmpuMWttekRIL09ycTlkcTAx?=
 =?utf-8?B?a3BVZHVISmcvd1ZWRlkxaGx0WVM2OXZVNGtqdmRoQ2dtdHFzUktrUFM2VVZM?=
 =?utf-8?B?NSt6dUloZ2FkeHM2SE5RN1BtRGFoZnQ4anZoRGNudDRhRGdtT1NFUGMwQVMv?=
 =?utf-8?B?Yzc1Z21IVmV0M0Z6YWFVS2RZa3h3UndBVEl5OHgxU3ZRZmZ3V2ZtUGk4NjlZ?=
 =?utf-8?B?V1V4aE1VaWxWaVNkeEdFTWtYQklnaDNNby9ueDNFSnM1czUxcFNDRmFOK2to?=
 =?utf-8?B?VHpKdE1ERFh5K2pFTzVQL243ZklCaEFyZ3JFQU1VMGZsSlc2R1c5UVBJN1VJ?=
 =?utf-8?B?WHIzYWtaK3NlVWpYUGpuMmc4MzFmNkhZS2Y0dHFKNmEvNzM1a2dXQkc5Unl5?=
 =?utf-8?B?SWZNUG5wZTNSaTFva2VkRk80VjM0TTBOOFJBN2hWZ0NRMzlHbm9kNTkwMjVO?=
 =?utf-8?B?ZWxqM2ZmVzVqelp3OXcxbGJHREpZZXN4VWRaWG9qcmE4S2w0b0cyd0VKVm9K?=
 =?utf-8?B?dW1oZC8xMHJkWHZ5WkVxWGEwTFBPUkRZQ0huSVVNazFqbERVU3VRTnltSFha?=
 =?utf-8?B?a1hyUDNXUWIwTkpOY0pJNUNjTWoybUhreTM5ZWh3VndMRXpmeGF1V2EvUVNo?=
 =?utf-8?B?ei9oMnArZHR3TUcxT1NJUDI2aVVjNnFlN0RsSGNtZW9pQVFRWW56UzdvQkUz?=
 =?utf-8?B?empxUWlKYndlK1J6elRwTlcvMmdPNUhFVllLLy84VmZxa2xrNU15R05jbnJ4?=
 =?utf-8?B?UXFmUlR3U0xkQUFKSTJZZnRhdkRSQUZ2VVVLL1U0Vjgzd3N6bnptdzU5Rkxi?=
 =?utf-8?B?SUdGOFBGVVpZRXVFMFhWL2E4a01rM0EvSGNlR3BhZWVneWt4b1FHNWQyd3Ji?=
 =?utf-8?B?amlVeFBkRlQ4TWpVcmpqalIra2pBNHBMWjh1R0h2K3BHZm1BTEh6OEVjdGVw?=
 =?utf-8?B?VDJET2I5WUtSdWppSTdaSHVVRjJJQmtBVVZYS0VuclppbGNtUW1UOXMwdEJH?=
 =?utf-8?B?cklrT2pmN2RGdGNWeHI1ek01MXNwb1NncHhxT1hiUHBVTVB2UHNNRTZsYXBV?=
 =?utf-8?B?L2JpZWlhYy9CanprWVhIM0hUOE94SUdTek1LT1FCSXpWYlUvQnFUZlhOYWgx?=
 =?utf-8?B?MnJVcnJjaVh6aW5meWwybyt5d2N1Nkw2M3FrNUVJZGlWeGIyU3J0Q3VSUUF4?=
 =?utf-8?B?dHNDRVJwczFSSnpnS1pWWXdGakRXei8zOUFQL1ZvS2k3bXVTL2cvUzJhWGlP?=
 =?utf-8?B?OXpPRGZsV0o4U0xmQmtKRFJybjJib2tnOGd0b3RERnJjNGlQMnJza05xRDQw?=
 =?utf-8?B?MTdHZWxnZzVXNWV2SzU5cmwra2RIa2dEQjlSamk5SDZiS0s2Wmk0NTFkM0dn?=
 =?utf-8?B?VEF2a2QxNmZ2alZiY05Tem9zM2QwZFhJdmtKT2hlckJ2TTd6eFJrK29rYll0?=
 =?utf-8?Q?1zVu7CZuBdWVt?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c35068fe-502d-47b0-c8c7-08de68b55e27
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 15:02:11.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4476

On 2/10/26 12:43 AM, Jonathan Cameron wrote:
> On Sat,  7 Feb 2026 19:30:58 +0800
> Wei Wang <wei.w.wang@hotmail.com> wrote:
> 
>> The ACS Enhanced Capability introduces several new access controls to
>> improve device isolation. These new controls are particularly important
>> for device passthrough in virtualization scenarios.
>>
>> For example, a DMA transaction from a device may target a guest physical
>> address that lies within the memory aperture of the switch's upstream
>> port, but not within any memory aperture or BAR space of a downstream
>> port. In such cases, the switch would generate an Unsupported Request (UR)
>> response to the device, which is undesirable. Enabling Unclaimed Request
>> Redirect Control ensures that these DMA requests are forwarded upstream
>> instead of being rejected.
>>
>> The ACS DSP and USP Memory Target Access Control and ACS I/O Request
>> Blocking features similarly enhance device isolation. Device grouping in
>> Linux assumes that devices are properly isolated. Therefore, enable these
>> controls by default if PCI_ACS_ECAP is supported by the hardware. As with
>> other basic ACS access controls, these new controls can be configured via
>> the "config_acs = " boot parameter.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Hi Wei Wang,
> 
> I'm late to the game here and may be missing something but
> I think the validation and defines for the 2 bit fields are both
> misleading and not sufficiently careful to reject values that
> are not allowed.  Maybe we do want to allow the reserved value
> but if so use a 2 bit mask to validate, not two specific
> values that the filed can take.
> 


Hi Jonathan,
Thanks for your comments. Yes, I think it's better to reject the 
reserved encoding (0b11). I'll add masks and enum values for the 
encodings, and validate that the value is not 0b11.


#define PCI_ACS_DMAC_MASK   0x0300
#define PCI_ACS_UMAC_MASK   0x0C00

enum {
     PCI_ACS_MAC_DA   = 0x0,
     PCI_ACS_MAC_RB   = 0x1,
     PCI_ACS_MAC_RR   = 0x2,
     PCI_ACS_MAC_RSVD = 0x3,
};



> Thanks,
> 
> Jonathan
> 
>> ---
>>   .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++------
>>   drivers/pci/pci.c                             | 13 ++++++++++-
>>   include/uapi/linux/pci_regs.h                 |  7 ++++++
>>   3 files changed, 35 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 7cfbf1102152..fd895716b07d 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5301,13 +5301,22 @@ Kernel parameters
>>   				flags.
>>   
>>   				ACS Flags is defined as follows:
>> -				  bit-0 : ACS Source Validation
>> -				  bit-1 : ACS Translation Blocking
>> -				  bit-2 : ACS P2P Request Redirect
>> -				  bit-3 : ACS P2P Completion Redirect
>> -				  bit-4 : ACS Upstream Forwarding
>> -				  bit-5 : ACS P2P Egress Control
>> -				  bit-6 : ACS Direct Translated P2P
>> +				  bit-0     : ACS Source Validation
>> +				  bit-1     : ACS Translation Blocking
>> +				  bit-2     : ACS P2P Request Redirect
>> +				  bit-3     : ACS P2P Completion Redirect
>> +				  bit-4     : ACS Upstream Forwarding
>> +				  bit-5     : ACS P2P Egress Control
>> +				  bit-6     : ACS Direct Translated P2P
>> +				  bit-7     : ACS I/O Request Blocking
>> +				  bit-9:8   : ACS DSP Memory Target Access Ctrl
>> +				      00    : Direct Request access enabled
>> +				      01    : Request blocking enabled
>> +				      10    : Request redirect enabled
>> +				      11    : Reserved
>> +				  bit-11:10 : ACS USP Memory Target Access Ctrl
>> +				              Same encoding as bit-9:8
>> +				  bit-12    : ACS Unclaimed Request Redirect Ctrl
>>   				Each bit can be marked as:
>>   				  '0' – force disabled
>>   				  '1' – force enabled
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index d2810eb97bda..1714e29ce099 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -942,7 +942,10 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>>   		}
>>   
>>   		if (mask & ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
>> -			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)) {
>> +			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT | PCI_ACS_IB |
>> +			    PCI_ACS_DMAC_RB | PCI_ACS_DMAC_RR |
>> +			    PCI_ACS_UMAC_RB | PCI_ACS_UMAC_RR |
>> +			    PCI_ACS_URRC)) {
> This used of the RB and RR Bits seems misleading to me as they form parts
> of 2 bit field that can only take values 0, 1 and 2.
> 
> So if the command line set PCI_ACS_UMAC_RB and PCI_ACS_UMAC_RR it
> would have hit the reserved value and that should be detected.
> 
> Hence I think you need to do this sort of masking + additional checks that these
> 2 bit fields have valid content.

Yes, will do.

> 
>>   			pci_err(dev, "Invalid ACS flags specified\n");
>>   			return;
>>   		}
>> @@ -1002,6 +1005,14 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
>>   	/* Upstream Forwarding */
>>   	caps->ctrl |= (caps->cap & PCI_ACS_UF);
>>   
>> +	/*
>> +	 * Downstream and Upstream Port Memory Target Access Redirect,
>> +	 * Redirect Unclaimed Request Redirect Control
>> +	 */
>> +	if (caps->cap & PCI_ACS_ECAP)
>> +		caps->ctrl |= PCI_ACS_DMAC_RR | PCI_ACS_UMAC_RR |
>> +			      PCI_ACS_URRC | PCI_ACS_IB;
>> +
>>   	/* Enable Translation Blocking for external devices and noats */
>>   	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
>>   		caps->ctrl |= (caps->cap & PCI_ACS_TB);
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index ec1c54b5a310..593ef522d2ba 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1016,6 +1016,7 @@
>>   
>>   /* Access Control Service */
>>   #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
>> +#define  PCI_ACS_ECAP		0x0080  /* ACS Enhanced Capability */
>>   #define  PCI_ACS_SV		0x0001	/* Source Validation */
>>   #define  PCI_ACS_TB		0x0002	/* Translation Blocking */
>>   #define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
>> @@ -1023,6 +1024,12 @@
>>   #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
>>   #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
>>   #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
>> +#define  PCI_ACS_IB		0x0080	/* I/O Request Blocking */
>> +#define  PCI_ACS_DMAC_RB	0x0100  /* DSP Memory Target Access Blocking */
>> +#define  PCI_ACS_DMAC_RR	0x0200  /* DSP Memory Target Access Redirect */
>> +#define  PCI_ACS_UMAC_RB	0x0400  /* USP Memory Target Access Blocking */
> 
> If I'm reading this write, those are specific values in the
> ACS USP Memory Target Access Control, not what they appear to be here
> which is bits that can be combined.
> I think you need a _MASK and separate definitions for the 3 values that
> are allowed.

Yes.

> 
>> +#define  PCI_ACS_UMAC_RR	0x0800  /* USP Memory Target Access Redirect */
>> +#define  PCI_ACS_URRC		0x1000	/* Unclaimed Request Redirect Ctrl */
>>   #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
>>   #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
>>   #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
> 

