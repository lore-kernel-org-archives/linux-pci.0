Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630121A238F;
	Wed, 23 Sep 2026 00:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121758; cv=fail; b=NUd7qrzFFcpWSLWqYed5Zba7+mUqj1xv7xBPbawus0UUbYj5ac3EeSyF3ea0i9CH1qLzZfMgd1ABja2SJJprYv9okVDy9bh5Dc/lsfvrGeMeo0rczaUPpE8Jg4LIodoWe9WUACb5v3eIvFvyOmjz+Z6gzl3DVzyOTkjxsEJ77Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121758; c=relaxed/simple;
	bh=ArkHlJyVyNA44fUv3QNb+Jl8TbFDOSH6fZDJWy0VFCg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MtDq8yoMYx+HhU6IRTlUwPzdCpmwvreuZbA6haQ+YFocJvChbLuOqeWtSvGSmkRB4RD2nLMMT8jF1N4cDMvRiyCfxb5nsm7o2/efplvQ5jvOIhQCjobjXSX0kuO4TSALXmCRvrk48uyutzlfUp58naa/qs1ww33OvmA3nBlvMIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GJSTh4JV; arc=fail smtp.client-ip=52.101.48.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GJSTh4JV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eu3JIIBiFIlP5aZVpmozsngDolrtCCnxs70PWm6dxuTzptOuUBOtJbRfVx01u6tdkg0yARbun1dVwyUFZScmI4zSB8PmsFXrAGFCtG9O8BbIpIhQ4lSbuGaSWGG68cVrehpt8zMqUv74u/Kt7LoW/hJOyVOS7RZfx8sPjz1iVEwXuosolTuOJb3oiEM+tw5BSU8/vBIztXCG3DIpwdSWwYR/AfRSseGBDyUcD7biWrFUj2ghQCi5AhBaImDcGbSCGo179Z93DgTyJrQT+Kr9D0o5lodBA+DTfvRghBxKKKKdygguEPW55mGz8RP1eAVg5U2QQZZCwmDJ5GcgRI53ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfZ83t5/2BeewAxFGcb1yJfLewYVFkbnGBV9tC2p6Y8=;
 b=lRiBiM7xedLrEbiOh/4UFco12SADiavET4WFyKZHzz+ziFWRn1gQbGJL6M/8dlk/mx0tTEFEDJ0zIavHWcm5ek0lI6wcDatwZ7m1M94wa+glc/O3h/xyd9opzbmtXz7pcUrG7Fh4W+SeLfNaJ3Yek5gkspSR73NrtND3zALpYs2KurSTq+j2bPY39Z3vcOH6Ho3LY6BM0uJve/OOoPTrxUqff1OyiXlqyp/JzkKLCdFHQf80EaJJcsirDH+pb7s9TlBDKYQBKe4VeNXcHgaBR9+qW0933w+q0ojtSJXbfebrRtOS0Eb+UDIuEGdNqqj1qxasvUgAMpfCZYHR4u8zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfZ83t5/2BeewAxFGcb1yJfLewYVFkbnGBV9tC2p6Y8=;
 b=GJSTh4JVnA5ScTLokFRhSfmlel+FKVOJ1dtMe3vQSpbuHffl2eg624UJcdd9kP3tneY4+Zn20rI0OeJi550cssaMGXm6KnOaWkJD/hS/c3T0NwnN4Er4/4847eDifLUr9/BuB7YBnsgaxpYElJzYB3CdOQbfviSitMZ8DWBmiPrTti+Ln8ZPjk3t8QK7pcXxDRcm56Vwe3YLRXtTRTuv4HKEeKNSKD993cHHRqeqo45sGKR1WeKU88yv8nrWeTC8VM12U15NbCdZVIErwUN9OEZ4TXn3b5VdM3rxhf8FpTqIn1PJt/0lCGTyGh/t5R7YueMQdD5oUmIWtThMxkTJHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DSVPR12MB827618.namprd12.prod.outlook.com (2603:10b6:8:3e5::24)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 00:02:31 +0000
Received: from DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f]) by DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 00:02:31 +0000
Message-ID: <23266146-f92c-4b97-bf1b-99e4973b7dfc@nvidia.com>
Date: Tue, 22 Sep 2026 17:02:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/12] cxl: Cache endpoint decoder settings during PCI
 enumeration
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-6-smadhavan@nvidia.com>
 <20260912020305.64278c3e@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260912020305.64278c3e@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::28) To DSVPR12MB827618.namprd12.prod.outlook.com
 (2603:10b6:8:3e5::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB827618:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a68ef84-d3e7-441a-dc6e-08df1905f6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|4143699003|22082099003|18002099003|5023799004|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	k34iLmLOkXUMR9FgBSq5XQhZ+iVyS90Z9aCsWrdq2YTVElycxI/ZLCGFboAc4nnWBJQNDQsHgOl4sUwyF+Ce3weDoSPWi73Pbk2kXZhLLPGj9s6avNsZ0QM0sG4rizx9Sf06wTnQxCj/oG10VUuZNtcYUtasjtUytkUDgF7W1BCu2GTNKVjeF0qjOgN9rU6jf+3V/CH59lTnZIobE/YM7vA3AFGAjjqgKOS0KFO+E4WF6TAUOxNEl1eycc3s2N2fYEnofsQAIv2iL3ja4Q5eC4+6wAjnAZgED4iA13Xx36tUiabF5+CrzAOQEfcgGGVVv/NUSRpQ9wlz9RaLeihE71dWFp0iPMFdZ2tcN0KX0BnvO3ygBVW/56glrPYqAuMuwRcY8obmaSTcEgNZ7KGnF1eM8kO5omyelbzStoOhEpDJTBPpqJdo+wgr9U+uV5VYusCOLHbIbW5oEzVmHR9DQYZD5DeM6sU2EBumSkThbaXkF8APRjeKMvLsdoe+v7if/2rarGKyjMThrzmQJW9C0ZZAftvbCKpwRsNtM3r6KHwOnPjeLdIg4lUHBG7TDsOqxumXnmAh4uN+yOQUvqvNipsQpvBWsZES00fwEBHSvyExGvxebOqnNm3lHsbLj0wy5FhTHNjjmouswNwjFB8og83fE/BM8VwRG/piJTMzOxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB827618.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(4143699003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGcxZnd0TzBncFRZRjBLTmdLUUNXM01qMFZOKzhwdCsvNzI3Z0V2THhhMGZR?=
 =?utf-8?B?SUNicmpldDEwL3VwTkxrS1Z0Q1ozMmhxK2NRWmZDM2srQ3I1Q0pKcE95VDhJ?=
 =?utf-8?B?RGR4OG8zMlp2bTlDOEVqZzZHaC9TeCtSelBSb0RwNVM2TG55d1JxSy9Ma3Zj?=
 =?utf-8?B?S1F2VG9Sa0Eyc0NTTmpxV3JGS3RtMFRjN28rYkovZFpBaS84V2k0T0NnVFI3?=
 =?utf-8?B?aUsvcVExSjNFblA5M1RmakptWkl6c2tha0lJT2UxVVFtSEVpYXcybFF3eTJC?=
 =?utf-8?B?N0NkNUFOMlpNNFd1QktSUjhhdWlzYUlvU1ZnSjl6UldSNWwwQVlJdUQ5WEZy?=
 =?utf-8?B?V1gwVU1BSTZZQkVSQXZSN2FsaEFib0pid09JOEovM3h4U2g3aTZoL1JBVGRQ?=
 =?utf-8?B?MXZQSDd2LzR4aHlLUncvZlBWTDl2QjBCOURydlhnZnhOdlhtWFk2b2hTV29R?=
 =?utf-8?B?M1I5NDgvcnJCUmE0N2grTExoQTBOTHB5cThJV21UMS9oR0NXdlVwRUNBcW5v?=
 =?utf-8?B?YWd3TW9NcWR0aUFLT3RpZHZ5NFBrTGVGQ05oMWVyYTZuMkNQbzA5bFQ5Z3dS?=
 =?utf-8?B?ZEd2OUxOS0FEYVhHbElicTBiMjBTM254djgxTWwyOERzWndQbjllaVVOOVV2?=
 =?utf-8?B?bmxzRm9jdDZ1cTJ3OU42ejdoL2tGS3ZDNHM5UlBjemRCVTZYVWJGZ3dJZ0pt?=
 =?utf-8?B?SEhPR3J3cGZWMnhncE1PSlp0NlVsKzlhZkVGRTFCZnNqbCsvVHdyRFBXcmVw?=
 =?utf-8?B?bjVsUWUvN3RuMXd2MmZROW8xcENIUmpvbHg4emM2YXB2aE42WnBSc2lHNnMy?=
 =?utf-8?B?RXJpcXJOWG9IUFpneUNZMnRPcEJxcEFNeEFjZWQyOHBYcXFJbmNIaWUzSjM1?=
 =?utf-8?B?WTd3NlAwSkxOZHFrQ0R1dDVnNzlBalFIaWlOaTFkNGZQWCtNVkE1ai9FVmFt?=
 =?utf-8?B?MUZOSHhEOUZ6Z1ZvOUJoMEdBcVpEU21OUU9kV2VlTDVyaGxLZHpidWJ1aW1X?=
 =?utf-8?B?WmJHcUdZZzNCcnUzWFpqeVNBN0NuNHJON0Y0cFVtMUZDYmFpaGFKdjJIS2hN?=
 =?utf-8?B?YnhDZE1RWnQwSS93emV3S2ZGd2VzUUFnRHMwM0QyYndPS0hGSlF6d21Fam11?=
 =?utf-8?B?a2d3b2d6M081c2RESTc4UzFIN3JGTzV2d281ZUtPY1U4cHdneDRSSWIxVnda?=
 =?utf-8?B?QlVvQWRINENnUVFsMTdXUUhLUUJHYURMZjUyU0ZTTDFxTGtjbktQZFgwNWFq?=
 =?utf-8?B?WW5Gb0J2T1k5cjV4MEdhb3JxaHpKWHVOOFJyQ01QQ2d0L3FKNCsyQ2liU2t5?=
 =?utf-8?B?K205dlpPQzUyenBFMEU4a1JERE51L0pEdlR1ODRubklsSkJyMjBHZGdsTjFJ?=
 =?utf-8?B?R0xCSGQ3QytQUW10VVFlZENYWDZ4UVU4Mk9mbHpHZUR6SDd1U3R5NUs4cXF1?=
 =?utf-8?B?ZXBvNGF2L3lLNG03c2FrQTA2UU5TOTF0dG5uS21oRHJLNG5IbDhCSkJsMmtI?=
 =?utf-8?B?ZElTckVVWmlWb29TNnZmSGNPVGdBVjlNWExPS3k4SExGYXBYRGk5Zml3aURs?=
 =?utf-8?B?WjkvTjBHTXNDMGVkcWRFNGYwUGhVbzR2bWROcTJldDRuVEJKQkRrdEhPbmkw?=
 =?utf-8?B?NG9WL2prTGxiL3p0cUY3Y3lNQW56aFh5azFmZ0Z4ZUs5dzJaR0pKV3BWdUtT?=
 =?utf-8?B?UnhSNXZmOXBpTTIreGZWYUFzenRoWE1Eb1ViM1RhUFQxMGxrRlJGZTZ0ejk5?=
 =?utf-8?B?aXZ1M2hXdHpNL2lRbktLdStuOUhJV2JoVDZ2Z0dwaXRFNmhJb2NGTWxudnNs?=
 =?utf-8?B?K0FCUlg0YlpPTHlpT3pNS2xScVFUWFJ4aDNoTzg0S0RBSEhhUzFJVXQ4amh3?=
 =?utf-8?B?TXVEaHJYcDZoRkZBL3ZmWThRYmhGREFuSE9tMjBzR0h6bW43eUVNZmRFTXJB?=
 =?utf-8?B?YnVBK0RQNmZQOEtOWUY3Z2JZMnBFcGJKNmtPKzRZRTF6NVBvODZoUFBEQzc0?=
 =?utf-8?B?Y2xIVVcyQVdmMWEwMk5hMmszN3ZkNzF3UEMySlduenhsdm1MakJia2gzL0c5?=
 =?utf-8?B?U1JXdmlrd2ZGMkxlOWxsalU0SXNXVG8vd1Z4K2ttYWUxS2doQkJ5ZGxGUDQx?=
 =?utf-8?B?UnNnWm5LdlVkUG1XZDdrRDluK3JiOEtNU3VZd3ZxRU5pRnRMMS8reWJ0cCt0?=
 =?utf-8?B?SUVNbXA2N1JQVEJTY1NGSWt6SWtScHhjT2VTb3Z5Z2hsOVRUYXl0dFZVU0ZV?=
 =?utf-8?B?U09RdUVCUmhlTkVWZmp2ekx4MGtQOEkwZTU1eEU0NzBNVVI5eVdyV0UzZHJp?=
 =?utf-8?B?Umd2b0M0b2pTREl0clV6OS9sUnFKUXdXU0NnL1RaS3BKRDFxNC91dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a68ef84-d3e7-441a-dc6e-08df1905f6d2
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB827618.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 00:02:31.7577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grEb3NLVkYyhwO845DbozMOmBfIZ8sGatjPXQDYIcTTH9N4Kx8pU1KhmSj2d40nptjKRoC8EyicI0ozoHkdsaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083

On 9/11/26 6:03 PM, Jonathan Cameron wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, 10 Sep 2026 07:08:01 +0000
> Srirangan Madhavan <smadhavan@nvidia.com> wrote:
> 
>> Populate pci_dev->hdm for CXL.mem functions from pci_bus_add_device(),
>> after final PCI fixups and state save but before driver binding. This
>> gives driver-free reset paths an early HDM snapshot while avoiding the
>> pre-resource-assignment window in PCI capability initialization.
>>
>> Use the CXL Register Locator BAR Indicator to find the component register
>> BAR, reject unassigned, disabled, or zero memory BAR resources before
>> temporarily enabling Memory Space, and restore the original PCI_COMMAND
>> value before returning. Cache the CXL Device DVSEC control register with
>> the HDM state for reset recovery before a driver can alter it.
>>
>> CXL core refreshes the cache as decoders are committed or reset, and keeps
>> the cached DVSEC control synchronized when CXL.mem is enabled or disabled.
>> Move the register helpers into the built-in CONFIG_CXL_RESET set so the
>> early cache path is available without cxl_core, and keep the cxl-test mock
>> core from building a duplicate regs.o.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Hi Srirangan,
> 
> Unless I'm reading this wrong, this has evolved to the point that it
> needs a step back and a rethink.  There is complexity in here I
> don't think you need at all.  I may well be missing something
> though given it's Friday evening!
> 
> Jonathan
> 
> 
>> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
>> index e6aa55079c76..6d9f8fe14b16 100644
>> --- a/drivers/cxl/core/resource.c
>> +++ b/drivers/cxl/core/resource.c
>> @@ -2,9 +2,17 @@
>>   /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>>   #include <linux/delay.h>
>>   #include <linux/bug.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/cleanup.h>
>>   #include <linux/errno.h>
>>   #include <linux/export.h>
>> +#include <linux/io.h>
>> +#include <linux/ioport.h>
>>   #include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +#include <linux/slab.h>
>> +
>> +#include <cxl/pci.h>
>>
>>   #include "cxl.h"
>>   #include "core.h"
>> @@ -156,3 +164,331 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
>>                                  &settings->interleave_granularity);
>>   }
>>   EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
>> +
>> +struct cxl_hdm_decoder_state {
>> +     u32 ctrl;
>> +     u32 base_low;
>> +     u32 base_high;
>> +     u32 size_low;
>> +     u32 size_high;
>> +     u32 target_low;
>> +     u32 target_high;
>> +};
>> +
>> +static void cxl_pci_hdm_info_free(struct cxl_hdm_info *info)
>> +{
>> +     if (!info)
>> +             return;
>> +
>> +     kfree(info->decoder_state);
>> +     kfree(info);
>> +}
>> +
>> +DEFINE_FREE(cxl_pci_hdm_info, struct cxl_hdm_info *,
>> +         cxl_pci_hdm_info_free(_T))
>> +
>> +void pci_cxl_hdm_release(struct pci_dev *pdev)
>> +{
>> +     struct cxl_hdm_info *info = pdev->hdm;
>> +
>> +     pdev->hdm = NULL;
> 
> If the order here matters, you need a barrier or WRITE_ONCE() might
> do it.
> 
>> +     cxl_pci_hdm_info_free(info);
>> +}
>> +
>> +static bool cxl_pci_bar_usable(struct pci_dev *pdev, int bar)
> 
> This doesn't seem to have anything CXL specific about it.  Maybe
> give it a more generic name and move it to pci.c?
> However, see later - I'm not sure you need this.
> 
>> +{
>> +     struct resource *res = &pdev->resource[bar];
>> +
>> +     if (!pci_resource_len(pdev, bar))
>> +             return false;
>> +     if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
>> +             return false;
>> +     if (resource_type(res) != IORESOURCE_MEM)
>> +             return false;
>> +     if (!res->start || !res->end)
>> +             return false;
>> +
>> +     return true;
>> +}
>> +
>> +static int cxl_pci_hdm_find_bar(struct pci_dev *pdev, resource_size_t hdm_start,
>> +                             resource_size_t hdm_size, int *bar,
>> +                             resource_size_t *offset)
>> +{
>> +     resource_size_t hdm_end;
>> +
>> +     if (!hdm_size)
>> +             return -EINVAL;
>> +
>> +     hdm_end = hdm_start + hdm_size - 1;
>> +     if (hdm_end < hdm_start)
>> +             return -EINVAL;
>> +
>> +     for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
> 
> This feels unduly painful and overly specific to this case.
> It is just looking for a resource to bar and offset.
> 
> It is not CXL specific so maybe ask Bjorn if such a helper might go
> in pci.c (assuming not discussed and dismissed in earlier rounds of
> review!)  I'd still like it to mention hdm or anything even if
> local to here.
> static int cxl_pci_find_resource_bar(struct pci_dev *pdev,
>                                       resource_size_t start, resource_size_t size,
>                                       int *bar, resource_size_t *offset)
> 
> Noted later, you can skip this entirely as this is going in a circle.
> 
>> +             struct resource *res = &pdev->resource[i];
>> +
>> +             if (!cxl_pci_bar_usable(pdev, i))
>> +                     continue;
>> +             if (hdm_start < res->start || hdm_end > res->end)
>> +                     continue;
>> +
>> +             if (bar)
>> +                     *bar = i;
>> +             if (offset)
>> +                     *offset = hdm_start - res->start;
>> +             return 0;
>> +     }
>> +
>> +     return -ENODEV;
>> +}
> 
>> +
>> +static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
>> +                                        void __iomem *hdm, int id)
>> +{
>> +     state->ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>> +     state->base_low = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>> +     state->base_high = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
>> +     state->size_low = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
>> +     state->size_high = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
>> +     state->target_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
>> +     state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
>> +}
>> +
>> +static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
>> +                                 struct cxl_hdm_decoder_state *state,
>> +                                 struct cxl_decoder_settings *settings,
>> +                                 void __iomem *hdm, int id)
>> +{
>> +     u64 target_or_skip, base, size;
>> +     int rc;
>> +
>> +     cxl_pci_hdm_read_decoder_state(state, hdm, id);
>> +
>> +     base = ((u64)state->base_high << 32) | state->base_low;
>> +     size = ((u64)state->size_high << 32) | state->size_low;
>> +     target_or_skip = ((u64)state->target_high << 32) | state->target_low;
> 
> I'm not sure I get why we cache the registers and the stuff derived from them.
> Why isn't one source of info enough? Or do the have different lifetimes?
> If they do then add a comment to structure definition on that.
> 
>> +
>> +     rc = cxl_hdm_decode_decoder(settings, id, state->ctrl, base, size,
>> +                                 target_or_skip, NULL);
>> +     if (rc) {
>> +             pci_err(pdev, "CXL HDM decoder %d has invalid configuration: %d\n",
>> +                     id, rc);
>> +             return rc;
>> +     }
>> +     return 0;
>> +}
> 
>> +
>> +static int __cxl_pci_hdm_read_info(struct pci_dev *pdev,
>> +                                struct cxl_register_map *map,
>> +                                struct cxl_hdm_info *info)
>> +{
>> +     struct cxl_decoder_settings *settings;
>> +     int decoder_count;
>> +     int rc;
>> +
>> +     rc = cxl_setup_regs(map);
>> +     if (rc)
>> +             return rc;
>> +
>> +     if (!map->component_map.hdm_decoder.valid)
>> +             return -ENODEV;
>> +
>> +     void __iomem *hdm __free(cxl_hdm_iounmap) =
>> +             cxl_pci_hdm_map(pdev, map, info);
>> +     if (IS_ERR(hdm))
>> +             return PTR_ERR(no_free_ptr(hdm));
>> +
>> +     decoder_count = cxl_hdm_decoder_count(readl(hdm +
>> +                                                 CXL_HDM_DECODER_CAP_OFFSET));
> 
> Go long on lines like this.  As long as you stay only a bit over 80 no one will
> mind.
> 
>> +     if (decoder_count < 0)
>> +             return decoder_count;
>> +
>> +     if (decoder_count > ARRAY_SIZE(info->settings))
>> +             return -ENXIO;
>> +
>> +     if (CXL_HDM_DECODER0_CTRL_OFFSET(decoder_count - 1) + 0x10 >
> 
> That 0x10 needs to be a define or other useful code. I have no idea what
> it is...
> 
>> +         info->hdm_size) {
>> +             pci_err(pdev,
>> +                     "CXL HDM decoder count exceeds mapped register block\n");
>> +             return -ENXIO;
>> +     }
>> +
>> +     info->decoder_count = decoder_count;
>> +     info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>> +     info->decoder_state = kcalloc(decoder_count,
>> +                                   sizeof(*info->decoder_state),
>> +                                   GFP_KERNEL);
> 
> That's same size as settings, so put the two of them a struct at the end of
> cxl_hdm_info with a short name (e.g. decoder[].state, decoder[].settings) and
> use a struct_size() allocation for them both.
> 
>> +     if (!info->decoder_state)
>> +             return -ENOMEM;
>> +
>> +     settings = info->settings;
>> +     for (int i = 0; i < info->decoder_count; i++) {
>> +             rc = cxl_pci_hdm_read_decoder(pdev, &info->decoder_state[i],
>> +                                           &settings[i], hdm, i);
>> +             if (rc)
>> +                     return rc;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
>> +                              struct cxl_register_map *map,
>> +                              struct cxl_hdm_info *info)
>> +{
>> +     bool restore_command;
>> +     u16 command;
>> +     int rc, rc2;
>> +
>> +     guard(pci_dev)(pdev);
>> +
>> +     rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
>> +     if (rc)
>> +             return pcibios_err_to_errno(rc);
>> +
>> +     restore_command = !(command & PCI_COMMAND_MEMORY);
>> +     if (restore_command) {
>> +             rc = pci_write_config_word(pdev, PCI_COMMAND,
>> +                                        command | PCI_COMMAND_MEMORY);
>> +             if (rc)
>> +                     return pcibios_err_to_errno(rc);
>> +     }
>> +
>> +     rc = __cxl_pci_hdm_read_info(pdev, map, info);
>> +
>> +     if (!restore_command)
>> +             return rc;
>> +
>> +     rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
>> +     if (rc2) {
>> +             rc2 = pcibios_err_to_errno(rc2);
>> +             pci_err(pdev,
>> +                     "failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
>> +                     rc2);
> 
>> +             if (!rc)
>> +                     rc = rc2;
>> +     }
> Dance is more complex to read than just duplicating a little.
> 
>          if (rc)
>                  goto reset_command_reg
> 
>          return pci_write_config_word(pdev, PCI_COMMAND, command);
> 
> reset_command_reg:
>          if (pci_write_config_word(pdev, PCI_COMMAND, command) !=
>              PCIBIOS_SUCCESSFUL)
>                  pci_err(pdev, ...);
> 
> I doubt we care about what return of that is given we are on fire.
> 
>          return rc;
> 
>> +
>> +     return rc;
>> +}
>> +
>> +static int __pci_cxl_hdm_init(struct pci_dev *pdev)
>> +{
>> +     struct cxl_register_map map = { 0 };
> 
> The 0 doesn't add anything = { };
> 
>> +     int dvsec;
>> +     int rc;
>> +
>> +     if (!cxl_pci_hdm_capable(pdev))
>> +             return -ENOTTY;
>> +
>> +     rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>> +     if (rc)
>> +             return rc;
> So this reads the regblock locator to get where the component regs are
> by decodeing the bar and offset then finding the resource form that...
>> +
>> +     rc = cxl_pci_hdm_find_bar(pdev, map.resource, map.max_size, NULL, NULL);
>> +     if (rc)
>> +             return rc;
> This takes the resource and finds the bar and offset?
> 
> Going in circles. Can't you pull a helper out of the start of
> cxl_decode_regblock() and get the bar and offset directly.
> Even if you need the sanity checks along the way, I think you can
> do them more directly and only go in one direction.
> 
>> +
>> +     struct cxl_hdm_info *info __free(cxl_pci_hdm_info) =
>> +             kzalloc_obj(*info, GFP_KERNEL);
>> +     if (!info)
>> +             return -ENOMEM;
> 
> Why allocate here when so much can still fail?  We don't need
> it for a few more calls.
> 
>> +
>> +     dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +                                       PCI_DVSEC_CXL_DEVICE);
>> +     if (!dvsec)
>> +             return -ENOTTY;
>> +
>> +     rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
>> +                               &info->dvsec_ctrl);
>> +     if (rc)
>> +             return pcibios_err_to_errno(rc);
>> +     info->dvsec_ctrl_valid = true;
>> +
> 
> I'd make this read and allocate - having found the size so we don't
> allocate more than necessary.  If any crazy device changes number of
> decoders on reset then we can just clamp it and print a rude message.
> 
>> +     rc = cxl_pci_hdm_read_info(pdev, &map, info);
>> +     if (rc)
>> +             return rc;
>> +
>> +     pdev->hdm = no_free_ptr(info);
>> +
>> +     return 0;
>> +}
>> +
>> +void pci_cxl_hdm_init(struct pci_dev *pdev)
>> +{
>> +     int rc;
>> +
>> +     rc = __pci_cxl_hdm_init(pdev);
>> +     if (rc && rc != -ENOTTY && rc != -ENODEV)
>> +             pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
>> +}
> 

These are now getting addressed in v13 patch 9:

   - removed the resource-to-BAR reverse lookup and now obtain the BAR 
and offset directly from the Register Locator path;
   - removed the duplicate raw-register decoder cache and retain one 
decoded settings representation;
   - combined the per-decoder state into the flexible array and allocate 
it with struct_size() after discovering the decoder count;
   - replaced the unexplained 0x10 size check.
   - protect cache publication and removal with cxl_rwsem.dpa; and
   - simplified PCI_COMMAND restoration and its error path.

I chose to reject a changed decoder count rather than clamp it because a 
partial snapshot would not describe all current hardware state. Added a 
comment for this.

https://lore.kernel.org/linux-cxl/20260922083924.2451158-10-smadhavan@nvidia.com/

-- 
Regards,
Srirangan
