Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CAB28E0;
	Wed,  2 Sep 2026 02:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317334; cv=fail; b=ew6he9gnxKd0HQxaM+eMF+blSNO6M6MDQIxTwouNZGmqB5j5+nXpYEkkOb4R0aD0NkFhHzcUECqwIN051e8IFOVsoYOTbEZmkAXfwNtMJ3APcmrxP8d5mTlFwgttEXQ/rvNwdRQeJC4L71XCKmoIntlYl3pMPj/Vfx+/8zm4Ttw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317334; c=relaxed/simple;
	bh=ulWe6/oyFPTKEBZ60IIM17QvTSvhwMT+BDgTEbe7n5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HoH0ACNw728H7Qvl2i0o+wft5uhNdM4OPnZn6+/xQEqvgoiGQ0U6mGTrRCAlHvEtNkTLvAm6IQU/R1pzYa+uPsRrv/cGyiGoMryZoUDWksamsDMD0w6e9Dr9q3gPgwTEjwwkdyK34sikNC2hD7XM9BLh0Hu2PnWmBjn3+6P+Ofs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J5WC8a50; arc=fail smtp.client-ip=52.101.61.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J5WC8a50"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GI5ldqTk05LRbeaMupgpyBqBGz10cIsbDNLNeONWWQVWwooX6YYtBEKcyZvFM9AB3bA9vPB6Hg3VyzkN12AQUCze/85ytnFYhMF10rvW8awykPnn11hePP2v7q3e7goapgrhFIlVREVSFjq5VHtMy39DJei09sd5iX9hL2u7fGZhUB0T5iUDg303K62EkYCp3hD0vXJLbKXlEuF2NZlqStjkEEdsHfJVbSAIQuFGwsRKTwx7opJq/AG7Zv0aF0exk5Y2L1jNZMiwpqxcB7OVHHRj/QeuoDOJijjaKaOeB7oSTCo8wUQ3Qveitxpvq5U3r+/Tt78fe9pzCGlDpX8aVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTIPq0IxQHsEWbyHbH4L9r+u8IjRlFq2kCE1gTk+L0A=;
 b=QvkJH/cPidWVArMKe0QVdV6pQRb/bdSFuutJvL7w+FehGTllPHocgaIBD3mLb9F0+9E+cLhN7YxJEIImuamETh6gzzuoHg63FpBUTvBSexfZ2dFBmYDJ65Sg1N8Vv8WDlZpwB337Ue6nFAChDj5mxLonUhrEZPiX463HQZMx4E7IWbRO/BZf5yx7GHGERwvmuUGHW2mUbvMpul/0+PID4D2vb+ZqOYDaJyEWGi3e8SRy86Awniy1l8ge1rguyWYSiKMttKwmVarfOBevyjvT7XjX444JMLMPM+4Su03XE0bgKJVuWmwP2CA+d1vM5jX4HGA6d4yZa7sGfNfTzdz82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTIPq0IxQHsEWbyHbH4L9r+u8IjRlFq2kCE1gTk+L0A=;
 b=J5WC8a50fhiS6LYasckMQJLHuCBwKZb5KRXUEBjCoRx2BK4zqvKvcpN0gbIR2Q6JQ96TlaIByiqT9rbQdFrPFnOoPqEAgd7HQK8Z7UldooObQ1K0/pV5PxLti8u+RgIo6ofR2YJyEUfDBvRezPXX1c37GtEBITgV9jhYntZ/HIJZbnRhZnicQWWawoH8wZfZ4T4brsubosNxCOIJJk7eQJQuR96/D89CSmd9yKScTQ544I6/G15e1wRxQm29TuvKywfiXWTcn/+Yz38+P7vU0LgmNTR5Ml0+29ysOA4WIyMXD/wQ7PS8nAh0fBWNX9g1+oCQTaTKz1W0liA9WypGoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:48:45 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:48:45 +0000
Message-ID: <e487528e-042b-4f3c-800f-31468f39afc4@nvidia.com>
Date: Tue, 1 Sep 2026 19:48:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/12] cxl: Cache endpoint decoder settings during PCI
 enumeration
To: Li Ming <ming.li@zohomail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-6-smadhavan@nvidia.com>
 <e7c9cfe2-674f-4ba5-ba21-dc22b9e635f3@zohomail.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <e7c9cfe2-674f-4ba5-ba21-dc22b9e635f3@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::34) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a75545-a8e5-485f-90ca-08df089cb4f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|22082099003|18002099003|56012099006|6133799003|5023799004|4143699003|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	HEBln+tiQkr594Y+CSZdAN6y2wQrHkOB2MOdD8NbFofL20sBgIOJ8sbqn2AzMe739zVOJvDkbbEuQcGDUHQMP1h1DzYiHTPVF+HsMbHKDfHSXQknoyqUrTv/eTUvZP1QAitbVyudJ99NuGhsBSdfaY3b7MG8ne1Lg9FGTG3fjUh2w4ObILyrne3JI08u0UZkBvAIPgrvPukcQmkPR/CjmTeKXHanZ8NYHPbecenwsRKTy1+sTm/pNtJ6X/lNGIhbFb5OKnkFAva9L054k9EJ/A8XzvndbgtfQwfWrvyvNFGxl09Y4Ggv/JtrD92SzaZE62IzgaER0wkK8wo+oRHgWAzVWB751/Tk9IrnRIgQwqIaaJaivdPUuojnbuxmcmZtgQ7pcgmOx0nog6Y8wGVl2OSh/YpUcPZaNzN8UVXHG8JIHn5IZMqXqTIoBNOjlsexxBd60x9fy7+ELRUD6TB3W7WpzJ8Z3Ayg4zWodNK6oP16fxfmo2ZorNYReqeeFs6xg0WqR3Rl4/e7M+28Kdmd6wKp74+W62a/fE1K9lbToP3IVO8ZG2BmEPEKi1N6QL4ooF3gyM/D9LVb7iIqXnTaffd+8SSlKyf8Kw9D7i+F+U7s8E3dq90RWk4HEiQPoVEAw0tqQLn2i2ujwwpOwKGjH24Pf7UKsL41TMdZZxqfrfp/JK+4/fvcArOsSu8e9oo/vpVxy2Eyzkag6IoH9+Q3Eg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(5023799004)(4143699003)(11063799006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW5KOEFOK1M2NXlOeXhIZ0dVUG4zMWNrWmhCZWZxWG1QT2IxRU9KTWpXMi9T?=
 =?utf-8?B?ejY4U1pnYjduU1prZm1kdHNDMnpXdnJBN3N2S3EzRjRiRDRVQXMyb2szZU5z?=
 =?utf-8?B?OSt1Vk1UWHBGdHQxTG5lZWJPSEhHd3Z4RTlZZFFCTElMa1cwOU1Fa1hSem02?=
 =?utf-8?B?OGNlSmY2dDkwYm5WeW52YUVRaFZhOWlRZzUyOXJSNEhvOG5Ub0VHelFBZGNa?=
 =?utf-8?B?ZFFaTFdiZEpDa1VrYzBPdzJFWEpCMmZKaUZLaFpjS0REWUZxWWVVWlc4NWJK?=
 =?utf-8?B?eWJSdHlXMi9WWHZrZTllR1VJd01XQ082SFYzSklaUitwVUVva3YxMFpaZ0Z3?=
 =?utf-8?B?N1lCWkRWak1LWjlEb1NNQWJYdDRwbzNoK3NvejljaTEzVkNwYzZOMVlhUWNw?=
 =?utf-8?B?UjRzMk9JUEh3ZHpSSCs0a0RjejRMZE0vcHFkUElCR1hySWlSSWtpVzlYVnZ5?=
 =?utf-8?B?cE8rV2RIeHJyV0swS3hkUDdwVFNpdy8yNlhNb1NYS29Vb05VSGR5YytrdGor?=
 =?utf-8?B?bDNMTUJyeVVBTS8wYjVENGxlclhaRnpDM0h6QmRxZ1dJYS92Ym5oalR2dEl2?=
 =?utf-8?B?NzdSWFYrWFpBZGk2Nm1KU0JvYVNvL1FmNkJWZVZoZ1ZSUEZHOHg5bWFKbVhs?=
 =?utf-8?B?TS9ZSmM1NDMrOFVhSjIzNHZUSUkwVzI5TFFXbUR4OXdJd01rbWhYMWk0QzB0?=
 =?utf-8?B?dHA5RHBBaXpuZGNKaTRuK3JlQnpkNzZES2s5ZExUdEVaeWJUT1RLWFpBSDRl?=
 =?utf-8?B?djdlRHZ2bjJVdWlNUXpDRGFoOFlrVTZOeFczME1uZ2FIZ1NNNmovcGxwQUdS?=
 =?utf-8?B?SGJidGJMM2FKWDVLS2M4SHVwNDhTaldONzdaajhrQnVxVnd0N2tuYmltN2dF?=
 =?utf-8?B?cHpHV3VWbkZnS05XSmFYQUFXc09BbEo5NW0zSjdML0tvTVNvUzhFMXhoMFAv?=
 =?utf-8?B?d2dFOWc2RXA4VHh1eml6NHM2Q3N0dlhLOWFTUldCV2ZSNUtKa2lEUjNTS3Jv?=
 =?utf-8?B?cHZtOGQwb2lGMDFnVlRRb3VRRHcrbnZVemlBVDJKd2s4TzFiYk9FVExDeXk3?=
 =?utf-8?B?SXBVR1QyOW9sMDZHaElYR2pPUXd2V2FGWnN6a2M3amxqOFBtZVk4NUpKS3dj?=
 =?utf-8?B?RDY5cHQ4d2V6by9PazQ5a0pQVXJJUGx0WGlyZ3VnNk1OU1FJVEFDbDFTalNN?=
 =?utf-8?B?em11dncxbTJPQ21aTHlxYVFHYmY3ejNnNng1MUEwY1NsVmxRekViNVJCRGFn?=
 =?utf-8?B?SFVrekw4YVUycDIxQWlibzRIdE1Pd0hiWGhHaU91VjVhSXFESTlZY1Z0dmR1?=
 =?utf-8?B?Sm9HVnFWNGl0SDhaNlQvMnBVdXpobWtNNEJFL29Ic1FndzNrS2R6cVoxSGhZ?=
 =?utf-8?B?bTVnSURrSFA1SkN6SUxpUHRNTkptSmozYzEyZ2NGVUVBMmJxZytLZ0Y1TmdO?=
 =?utf-8?B?WHJrZXBCcFlSSWwybkhKU2RzM2xsVllKak82WndoQkhESHRFMTMwdXQ2ci9v?=
 =?utf-8?B?emt5UWRRT3BkRXhNV2VUWkxtbUZmZEhORWszZ09Ea2VSdnJXWFZNdzlDSlNn?=
 =?utf-8?B?SS91NzNiNkJPQWY0ZStzRGNoV2NxdHF0aXhyc3hyUndmbmNxTmhpYmVnNWt4?=
 =?utf-8?B?cXhtWDFoU2Rtc2JkVVRRTzVFVkZEZG50WS9ZbGd1UWM1SHk4ZkRHTFBpZTFr?=
 =?utf-8?B?TU5PMVh2aGEvaE1sNkNFYlh5OE1WTlZZVkJUcFJPQlc3K1JPYmxmK1lDYTJF?=
 =?utf-8?B?MWt5WlRCZ1hKNFZpUnYwUEs3VUFrRjlLMTl5d3QxOWd5cDFObjFkcFd3Yjdm?=
 =?utf-8?B?RklVaXRFU1hxdWx4cm9FbGYxTWpSUk80dDBrbFpPdk53Q0dYeFJJcVdLcVg4?=
 =?utf-8?B?dzFiUSs0Zlo0K2lCaG52eXZUMDFBcmtCUGgwQ2o1WWthMFJmL1ViRlcxYmV2?=
 =?utf-8?B?Vmp5bmNvZjZBTmhLRmk3YTBic3RDdnZyd2g3azQ4MXNKZ29kNDlsdkVWY2JJ?=
 =?utf-8?B?SytqV0VaZFVCTWxEQysvVERZY2hGTlJrWHBpcXRLUXJEcitrNDRFOWY1aE95?=
 =?utf-8?B?cHFDMjFEMzFpUjF4R045THBlejhnM1JwK213ZmFzZFlpT09QVmtiSmN1TDlp?=
 =?utf-8?B?K0IxcWYyM3dRc004TkgrT1hOOHllYUw2dnlEUGpVVDZqa1d6QkE0QUYxOUx6?=
 =?utf-8?B?OVUxOThMTEphMXNVVi96bzdwRzdoMzRrWXBNRjVjam1UQlVEU1lObjZ6TGxr?=
 =?utf-8?B?UEtBbFJXdk1pdW8wYjRaaXpyZEYwZ0lQY1JMeE12anord00vbEJWZFg5L0N5?=
 =?utf-8?B?S3hMQzhUemZWKzZEd04ralcvalpJTUxrVUhpcElNeUM3eC9qWERBQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a75545-a8e5-485f-90ca-08df089cb4f3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:48:45.4950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7jcPIZoQWHQE50Sr25UpFzvAkwzLbP4k0Or/jhHHDT9f5eXtEzs/S0NwTH22xi+BuadKIXfyYAxnH8swVQ66Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290

On 8/24/26 11:58 PM, Li Ming wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 8/5/2026 3:29 AM, Srirangan Madhavan wrote:
>> Populate pci_dev->hdm for CXL.mem functions from pci_bus_add_device(),
>> after final PCI fixups and state save but before driver binding. This
>> gives driver-free reset paths an early HDM snapshot while avoiding the
>> pre-resource-assignment window in PCI capability initialization.
>>
>> Use the CXL Register Locator BAR Indicator to find the component register
>> BAR, reject unassigned, disabled, or zero memory BAR resources before
>> temporarily enabling Memory Space, and restore the original PCI_COMMAND
>> value before returning.
>>
>> CXL core reuses and refreshes the same cache as decoders are committed or
>> reset, and retries cache setup during CXL HDM enumeration if the PCI
>> bus-add attempt did not publish a cache. Move the register helpers into
>> the built-in CONFIG_CXL_HDM set so the early cache path is available
>> without cxl_core, and keep the cxl-test mock core from building a
>> duplicate regs.o.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
>> ---
>>   drivers/cxl/core/Makefile   |   3 +-
>>   drivers/cxl/core/hdm.c      |  13 +-
>>   drivers/cxl/core/regs.c     |   4 +
>>   drivers/cxl/core/resource.c | 313 ++++++++++++++++++++++++++++++++++++
>>   drivers/pci/bus.c           |   2 +
>>   drivers/pci/probe.c         |   2 +
>>   include/cxl/cxl.h           |  26 +++
>>   tools/testing/cxl/Kbuild    |   1 -
>>   8 files changed, 360 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 0df4178bbbaa..e22f05d83c39 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-$(CONFIG_CXL_BUS) += cxl_core.o
>> -obj-$(CONFIG_CXL_HDM) += resource.o
>> +obj-$(CONFIG_CXL_HDM) += regs.o resource.o
>>   obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>>
>>   ccflags-y += -I$(srctree)/drivers/cxl
>> @@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>>
>>   cxl_core-y := port.o
>>   cxl_core-y += pmem.o
>> -cxl_core-y += regs.o
>>   cxl_core-y += memdev.o
>>   cxl_core-y += mbox.o
>>   cxl_core-y += pci.o
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index ec988e7b7c0c..b47701fc5315 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -112,10 +112,17 @@ static int cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
>>        struct pci_dev *pdev __free(pci_dev_put) =
>>                cxl_port_get_uport_pci_dev(cxlhdm->port);
>>        bool present;
>> +     int rc;
>>
>>        if (!pdev)
>>                return 0;
>>
>> +     rc = cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
>> +     if (rc || present)
>> +             return rc;
>> +
>> +     pci_cxl_hdm_init(pdev);
>> +
>>        return cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
>>   }
>>
>> @@ -180,6 +187,10 @@ static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
>>        if (!info || cxld->id >= info->decoder_count)
>>                return;
>>
>> +     if (cxlhdm->regs.hdm_decoder)
>> +             info->global_ctrl = readl(cxlhdm->regs.hdm_decoder +
>> +                                       CXL_HDM_DECODER_CTRL_OFFSET);
>> +
>>        if (cxld->flags & CXL_DECODER_F_ENABLE)
>>                cxl_decoder_snapshot(cxld, &info->settings[cxld->id]);
>>        else
>> @@ -1002,11 +1013,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>   {
>>        struct cxl_endpoint_decoder *cxled = NULL;
>>        u64 size, base, skip, dpa_size, lo, hi;
>> +     struct cxl_decoder_settings settings;
>>        bool committed;
>>        u32 remainder;
>>        int i, rc;
>>        u32 ctrl, tl_low, tl_high;
>> -     struct cxl_decoder_settings settings;
>>
>>        if (should_emulate_decoders(info))
>>                return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 93710cf4f0a6..040b0304f63c 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>>
>>        return ret_val;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>>
>>   int cxl_map_component_regs(const struct cxl_register_map *map,
>>                           struct cxl_component_regs *regs,
>> @@ -517,6 +518,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>>
>>        return offset;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
>>
>>   static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
>>   {
>> @@ -633,6 +635,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>>
>>        return component_reg_phys;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
>>
>>   resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>                                           struct cxl_dport *dport)
>> @@ -641,3 +644,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>                return CXL_RESOURCE_NONE;
>>        return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
>> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
>> index 97cb136cb2ae..7f5946d3f2c4 100644
>> --- a/drivers/cxl/core/resource.c
>> +++ b/drivers/cxl/core/resource.c
>> @@ -2,9 +2,16 @@
>>   /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>>   #include <linux/delay.h>
>>   #include <linux/bug.h>
>> +#include <linux/bitfield.h>
>>   #include <linux/errno.h>
>>   #include <linux/export.h>
>> +#include <linux/io.h>
>> +#include <linux/ioport.h>
>>   #include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +#include <linux/slab.h>
>> +
>> +#include <cxlpci.h>
>>
>>   #include "cxl.h"
>>   #include "core.h"
>> @@ -170,3 +177,309 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
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
>> +void pci_cxl_hdm_release(struct pci_dev *pdev)
>> +{
>> +     struct cxl_hdm_info *info;
>> +
>> +     scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
>> +             info = pdev->hdm;
>> +             pdev->hdm = NULL;
>> +     }
>> +
>> +     cxl_pci_hdm_info_free(info);
>> +}
>> +
>> +static bool cxl_pci_bar_usable(struct pci_dev *pdev, int bar)
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
>> +
>> +static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
>> +                                  struct cxl_register_map *map,
>> +                                  struct cxl_hdm_info *info)
>> +{
>> +     struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
>> +     resource_size_t hdm_start;
>> +     void __iomem *hdm;
>> +     int rc;
>> +
>> +     hdm_start = map->resource + hdm_map->offset;
>> +     info->hdm_size = hdm_map->size;
>> +
>> +     rc = cxl_pci_hdm_find_bar(pdev, hdm_start, info->hdm_size,
>> +                               &info->hdm_bar, &info->hdm_offset);
>> +     if (rc)
>> +             return ERR_PTR(rc);
>> +
>> +     hdm = ioremap(hdm_start, info->hdm_size);
>> +     if (!hdm) {
>> +             pci_err(pdev, "failed to map CXL HDM decoder registers\n");
>> +             return ERR_PTR(-ENOMEM);
>> +     }
>> +
>> +     return hdm;
>> +}
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
>> +
>> +static int cxl_pci_hdm_capable(struct pci_dev *pdev)
>> +{
>> +     u16 cap;
>> +     int dvsec;
>> +     int rc;
>> +
>> +     dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +                                       PCI_DVSEC_CXL_DEVICE);
>> +     if (!dvsec)
>> +             return -ENOTTY;
>> +
>> +     rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
>> +     if (rc)
>> +             return pcibios_err_to_errno(rc);
>> +
>> +     if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
>> +             return -ENOTTY;
>> +
>> +     return 0;
>> +}
>> +
>> +static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
>> +                              struct cxl_register_map *map,
>> +                              struct cxl_hdm_info *info)
>> +{
>> +     struct cxl_decoder_settings *settings;
>> +     void __iomem *hdm;
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
>> +     hdm = cxl_pci_hdm_map(pdev, map, info);
>> +     if (IS_ERR(hdm))
>> +             return PTR_ERR(hdm);
>> +
>> +     decoder_count = cxl_hdm_decoder_count(readl(hdm +
>> +                                                 CXL_HDM_DECODER_CAP_OFFSET));
>> +     if (decoder_count < 0) {
>> +             rc = decoder_count;
>> +             goto out_unmap;
>> +     }
>> +
>> +     if (decoder_count > CXL_HDM_DECODER_MAX_COUNT) {
>> +             rc = -ENXIO;
>> +             goto out_unmap;
>> +     }
>> +
>> +     info->decoder_count = decoder_count;
>> +     info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>> +     info->decoder_state = kcalloc(decoder_count,
>> +                                   sizeof(*info->decoder_state),
>> +                                   GFP_KERNEL);
>> +     if (!info->decoder_state) {
>> +             rc = -ENOMEM;
>> +             goto out_unmap;
>> +     }
>> +
>> +     settings = info->settings;
>> +     for (int i = 0; i < info->decoder_count; i++) {
>> +             rc = cxl_pci_hdm_read_decoder(pdev, &info->decoder_state[i],
>> +                                           &settings[i], hdm, i);
>> +             if (rc)
>> +                     goto out_unmap;
>> +     }
>> +
>> +     rc = 0;
>> +out_unmap:
>> +     iounmap(hdm);
>> +     return rc;
>> +}
>> +
>> +static int __pci_cxl_hdm_init(struct pci_dev *pdev)
>> +{
>> +     struct cxl_register_map map = { 0 };
>> +     struct cxl_hdm_info *info;
>> +     bool restore_command;
>> +     u16 command;
>> +     int rc;
>> +
>> +     down_read(&cxl_rwsem.dpa);
>> +     if (pdev->hdm) {
>> +             up_read(&cxl_rwsem.dpa);
>> +             return 0;
>> +     }
>> +     up_read(&cxl_rwsem.dpa);
> 
> Could use a scoped_guard() here.
> 
> 
>> +
>> +     rc = cxl_pci_hdm_capable(pdev);
>> +     if (rc)
>> +             return rc;
>> +
>> +     rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>> +     if (rc)
>> +             return rc;
>> +
>> +     rc = cxl_pci_hdm_find_bar(pdev, map.resource, map.max_size, NULL, NULL);
>> +     if (rc)
>> +             return rc;
>> +
>> +     info = kzalloc_obj(*info, GFP_KERNEL);
>> +     if (!info)
>> +             return -ENOMEM;
>> +
>> +     rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
>> +     if (rc) {
>> +             rc = pcibios_err_to_errno(rc);
>> +             goto out_free_info;
>> +     }
>> +
>> +     restore_command = !(command & PCI_COMMAND_MEMORY);
>> +     if (restore_command) {
>> +             rc = pci_write_config_word(pdev, PCI_COMMAND,
>> +                                        command | PCI_COMMAND_MEMORY);
>> +             if (rc) {
>> +                     rc = pcibios_err_to_errno(rc);
>> +                     goto out_free_info;
>> +             }
>> +     }
>> +
>> +     rc = cxl_pci_hdm_read_info(pdev, &map, info);
>> +
>> +     if (restore_command) {
>> +             int rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
>> +
>> +             if (rc2) {
>> +                     rc2 = pcibios_err_to_errno(rc2);
>> +                     pci_err(pdev,
>> +                             "failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
>> +                             rc2);
>> +                     if (!rc)
>> +                             rc = rc2;
>> +             }
>> +     }
> 
> How about moving PCI_COMMAND programming and restoring into cxl_pci_hdm_read_info(), and rename current cxl_pci_hdm_read_info() to __cxl_pci_hdm_read_info()?
> 
> 
>> +
>> +     if (rc)
>> +             goto out_free_info;
>> +
>> +     down_write(&cxl_rwsem.dpa);
>> +     if (!pdev->hdm) {
>> +             pdev->hdm = info;
>> +             info = NULL;
>> +     }
>> +     up_write(&cxl_rwsem.dpa);
> 
> Same as above, can be replaced by a scoped_guard().
> 
> 
>> +
>> +     cxl_pci_hdm_info_free(info);
>> +     return 0;
>> +
>> +out_free_info:
>> +     cxl_pci_hdm_info_free(info);
>> +     return rc;
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
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index 655ed53436d3..5fd7bae8e786 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/proc_fs.h>
>>   #include <linux/slab.h>
>> +#include <cxl/cxl.h>
>>
>>   #include "pci.h"
>>
>> @@ -359,6 +360,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>>
>>        /* Save config space for error recoverability */
>>        pci_save_state(dev);
>> +     pci_cxl_hdm_init(dev);
>>
>>        /*
>>         * Enable runtime PM, which potentially allows the device to
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index dd0abbc63e18..0bed5638d6da 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/bitfield.h>
>>   #include <trace/events/pci.h>
>> +#include <cxl/cxl.h>
>>   #include "pci.h"
>>
>>   static struct resource busn_resource = {
>> @@ -2484,6 +2485,7 @@ static void pci_release_dev(struct device *dev)
>>        struct pci_dev *pci_dev;
>>
>>        pci_dev = to_pci_dev(dev);
>> +     pci_cxl_hdm_release(pci_dev);
>>        pci_release_capabilities(pci_dev);
>>        pci_release_of_node(pci_dev);
>>        pcibios_release_device(pci_dev);
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 703285966946..a1fe8949f3f7 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -26,6 +26,7 @@ enum cxl_devtype {
>>   };
>>
>>   struct cxl_region;
>> +struct pci_dev;
>>
>>   enum cxl_decoder_type {
>>        CXL_DECODER_DEVMEM = 2,
>> @@ -135,16 +136,41 @@ struct cxl_regs {
>>
>>   #define CXL_HDM_DECODER_MAX_COUNT 32
>>
>> +struct cxl_hdm_decoder_state;
>> +
>>   /**
>>    * struct cxl_hdm_info - PCI device HDM decoder programming cache
>>    * @decoder_count: number of decoder settings entries
>> + * @hdm_bar: BAR containing the HDM decoder registers
>> + * @hdm_offset: HDM decoder register offset relative to @hdm_bar
>> + * @hdm_size: HDM decoder register resource size
>> + * @global_ctrl: cached HDM decoder global control register
>> + * @decoder_state: cached raw per-decoder register state
>>    * @settings: cached per-decoder programming state
>>    */
>>   struct cxl_hdm_info {
>>        int decoder_count;
>> +     int hdm_bar;
>> +     resource_size_t hdm_offset;
>> +     resource_size_t hdm_size;
>> +     u32 global_ctrl;
>> +     struct cxl_hdm_decoder_state *decoder_state;
>>        struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
>>   };
>>
>> +#ifdef CONFIG_CXL_HDM
>> +void pci_cxl_hdm_init(struct pci_dev *pdev);
>> +void pci_cxl_hdm_release(struct pci_dev *pdev);
>> +#else
>> +static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
>> +{
>> +}
>> +#endif
>> +
>>   struct cxl_reg_map {
>>        bool valid;
>>        int id;
>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
>> index 6c09932587ce..2eb61812a8e7 100644
>> --- a/tools/testing/cxl/Kbuild
>> +++ b/tools/testing/cxl/Kbuild
>> @@ -55,7 +55,6 @@ obj-m += cxl_core.o
>>
>>   cxl_core-y := $(CXL_CORE_SRC)/port.o
>>   cxl_core-y += $(CXL_CORE_SRC)/pmem.o
>> -cxl_core-y += $(CXL_CORE_SRC)/regs.o
>>   cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>>   cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>>   cxl_core-y += $(CXL_CORE_SRC)/pci.o
> 

Thanks you. Addressed this in v11. I replaced both manual rwsem 
lock/unlock pairs with scoped guards. I also moved PCI_COMMAND 
enablement and restoration into cxl_pci_hdm_read_info()

-- 
Regards,
Srirangan
