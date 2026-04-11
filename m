Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E619C546
	for <linux-pci@vger.kernel.org>; Sat, 11 Apr 2026 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775878100; cv=fail; b=ZeK1f+PRdABT2bvB2Vu0EXKe6Mx7BjkD/0PAl+lkjVMh7lpoRdx0ox0Ly6/5GwI4Lm+P5o4DrYpq9w7/+owzK1TCd4erP12bsQxH0+RHYlNOQ8RXU9mX+QgsmXzT1XiB67YSQ/e/lt9aGapU1G0wlxdMyKweLstRaew330IeciU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775878100; c=relaxed/simple;
	bh=fPd+7SEbFDTTkEZArEDOXO6V6dZJlJcidX3+aJ6c1Ik=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S1wir1Q7CDSNlxTVZJYDqY3AhPp0JwWerszPcl2g04XxpsMDRjt5yoiKbsUK69AwkJth1PBziWO/nviHMT4b1L1lSeRt6lVlwMM6ipsiPkyLVr6Xl67ynpOY+DuZAi8kKyuPiMUAbvT/JqHUov+4iZYYPPBs4qCxJWckAJOLSSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kpWU89Ao; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kpWU89Ao"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhJBs34uqpkxT1k3QyeUJf4k81l7TKqWgA8aCpU/lYxaPflg7mRWId1qeDadsjGFVVVAU8XfMBnmxsAGsKB0AzhL7vjcpg0DKgp/LbrNmT1OR11GrE1vbf6H3hkW2Yb9TZAMqDNjHl7U9ziwQXWVWEYvxuBUqtlgElsAEg0R3I4XgcqUKobSPymO3IWMTcU9kKMbEYWYO7jJxDjxAScPIDX5M8gdV8sV6qBDvj5RBZ1wQih69Iu5P2/IUwSGSrBsePs7LD/LVZJYiPZOi9RfxX8Cs00eGqipmoGkmEunyNW9NHiv17WdQjqNFvAPC4Cis12THbHHLZw4ynTFMlZ9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZy5hgkh+I+kGeWmgH7gHf8WXmeLcqIaxDvMVhwTPs0=;
 b=n/KXMdCLxKdB5HSPTzKWVLqauTICy3ti0t2v2BS92atufgjz2sAeuAvkcW3qIrjDSMfYb84puSYg7609IHMU5BzuZ0XMHAX6RRROvH/jX0lVLx46nRHm2TV5ABl3CmmTCaQjHbMKeVBsNopiBJF9fDM3NphqyWBdvDW05arHP8dGKJJNMjgaDGyACIkY0m0sS2tHZTo/JkldGrbE74RMd/N/QZr0i/7V3qn0Az4ie16vE34SOD8N7Quegnk18UDpGh+e8M4J6FuQzYWSLNpplmbVnIaoOMkdyXpD27FO0P9/YubMiqOpdN5SZR4B3TDvwihvMb5EcZs1xRB11swuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZy5hgkh+I+kGeWmgH7gHf8WXmeLcqIaxDvMVhwTPs0=;
 b=kpWU89AosxVndDQFE193lTnINos+ilZPsPGRLmt5wb32R17Lo9h+DOq+qYOrqDxr40WkO+Ae1G3M4sbm5VkQCwQ/MT3emRYmP90Zip3gqQQ6svEVU2T/nZpZUzjmZE0h+J1N1GcPcZQYk9xLosjxL0iVgbL4GgEAhF9KjamIx6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.46; Sat, 11 Apr 2026 03:28:16 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.041; Sat, 11 Apr 2026
 03:28:16 +0000
Message-ID: <2fe254c2-38f2-4213-9055-43b810502ccd@amd.com>
Date: Fri, 10 Apr 2026 22:28:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: release empty sibling bridge windows during rebar
 expansion
Content-Language: en-US
To: Cristian Cocos <cristi@ieee.org>, Geramy Loveless <gloveless@jqluv.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
References: <29a5ee31baf8be7d07617beea016c3f6d03934bf.camel@ieee.org>
 <20260410052918.5556-2-gloveless@jqluv.com>
 <efcba31b-4c5f-d4ec-e2e5-d01254c8256c@linux.intel.com>
 <CAGpo2mdZ6Ge9ZSYK4kKYJ7etBu5JqoVR-_G7jnxfZYhfQxxryA@mail.gmail.com>
 <ec0d287c884cbdd5131e1b09147b9b3cd56faf1d.camel@ieee.org>
 <CAGpo2meYZ+JmBo5veqF3tAexu+RevMMRmPgB5QjfZKncntYGZg@mail.gmail.com>
 <CAGpo2mfVV-UcTg2ST9jHC-irUDYEb=rk4yvf2AQc2Gw9EgyFuw@mail.gmail.com>
 <58b240e489d3a4d41e7dbbe5720b80c310700582.camel@ieee.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <58b240e489d3a4d41e7dbbe5720b80c310700582.camel@ieee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:806:120::29) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 41115a77-d428-482e-ec07-08de977a5e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9RD0/85i6xEjSJBF3xOxp9hdo8y65AUMFnLK4lSl1dWCf1NYhF1CgWWw9IXszqCHkoTUWY5jhHVzNA5L0RxqC8lYjia6MUkqs2Gja2oikA9f0Azr8FPqQV3Rx+Q+uy9Z7Idqhd1e4UvIQdZO12voUU3EWsSA2u2g6I4N+mLU5pBfBsow2Q/wgH0FE4/LDqwYDVzoqkl422k7OIo/BkagjULlG4PLZyTTnYyzk8Be7PPQ0+HNDVgnuinmfDp1TaoN1hNuHVrFR6OKbMcK0QJqi2LBP1s7zWpAlELJ6GM37JkcWNI8sS9kht2LkJeeCKlStCitebciP3zyeq+u7DGvQUswPqpI4Evf/01B/DFUMLf0/BrldX6qqyWYAdIfkBRQkeLkzLisKEna4w7Z1VhuSJXNw3omHh4IEBRdhjq/t4G5Zy39mqn7SdAi3au0+qJnEPdY5VU9qfJTBJgzJaSmXRChU8fP9xGt20joGrcR//Fc4dsgoLq0iZ2FMrQ10I4UDKWHt0PRJlSfiFZM0ORKhh0C1/6sR0q9pTewoza+4WzYMaoO3d8Tsn+VYubaupp3muQW+ppKQnxzrqbNBxypvcWIA6wYZZy2AXDpeJpIRYPDmJABJdU/mR+Mq0ZCEGqx3ZzHo6pTLV6j1dmXwaUozr/fLxh09hVmoecTf29g4g8rCXyr7Nn4lS4vmtjXKZ/LXfr5f0i+ZQL9w/YJ8OPfgRZvZS1ZWnedCtNy1fgf0lTgaSreM5/uxz9q9yK90EfP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTdUc01ESGpqckpoTmRsU3FmeEppRWppMTc2a0JVQ3pGQ01ncUEwa29sV0JJ?=
 =?utf-8?B?U0QvcGVyZGlHQ09NeUlQR0hSL1o1aG01dzg0bGpjbmVFaWYyOGxBYWVMSGpO?=
 =?utf-8?B?Z3R5MTNwNGRzN2RsNG5keW1sSzR2SzV3M01KLzA0NGlmdWd1NnNIemxTOHp2?=
 =?utf-8?B?VFR2OCsvcDNManZpSUJoS0hQaXcwQVdlclgrZWJyL3NJRGpnK3Z1M2hNSHow?=
 =?utf-8?B?RmFJdXViV05vbExjTzU4WkhzY1UveW9PU3pMT1NTZzQ3a24xUnBYSmMwVUxx?=
 =?utf-8?B?MjVOcU4zeHJkNG9udEtOZXVkK3JvWnlNVTgxT3ZnV3BOVHpqNE1IZFNHRGhJ?=
 =?utf-8?B?ZmZJbC9wVVNLUmQxRURnNUlvWkgvRmUvc0JCMklYdWprNVJaMkdrR05zb3pn?=
 =?utf-8?B?WE1XZVVtSHdqZmE0UkRMNG9YeFpLL2JrRnQzcVZqaWlmU051RVdmalloeGRu?=
 =?utf-8?B?UkRobjRxbUhNODZERFN5Zmt2SWNxZUVqTlBZMjBEL3NWTk5UUWxBTkI4UzhP?=
 =?utf-8?B?NlEvNWY3RzhtMVBmZVJ6L09jK01DcjcyVDF6OVhyVVBMZWZBQ1Jac3NCZmRR?=
 =?utf-8?B?QXpwRnRHMzhlTUVydGZjbUh3M3ovZVhFVmkwYWQzMzlqanMyTURlK1k1c1RT?=
 =?utf-8?B?QmdISHNDK0JLSkdZeDVjaHN1ZS94eG9ITEZWcWNSUUs4RUxDZTVKVFdMVVlr?=
 =?utf-8?B?VlBlOVhqQVJvdFlTM2V6VTBud2FLenlkNmx4Y29mOVZpaWhnaEhrWnRXT0xC?=
 =?utf-8?B?MVVlZFY4cXgwY3N1RlZrR3RWUDdoTXhPd25TVmtvVzY1QUVwMVdQeFlaYUV1?=
 =?utf-8?B?YzRSRXU2bFVlUjRrNHVacVc3TmRCWFhYOUxqdHFya2kvMnBlUU9KNmprWGlu?=
 =?utf-8?B?R1JaNkw1ZXBNa2lxdis3a0ZhWlVsTldtZzNmQTFjNGZiaUk3MWhsRXdLaWtY?=
 =?utf-8?B?OGFZT2VQTVcyRG01OHVTR2dUTCt5dTJVUXlaelUwWnMzSmExOXIwSFRwakZy?=
 =?utf-8?B?N093R0JzN09XMmwxdmF6NjM0MjlIQ051NUhiZ1ljMjdwclM4NHRWY2xzRzFH?=
 =?utf-8?B?Qko5b1pLZVVGM1drd2xBeTFpc0I2ZCt0c3R1QUVWVmJjbWI4amdQc21PTTBG?=
 =?utf-8?B?dmhaWnJnUlhMSEFESWY1RTJFOUQwTitoa2hRV0R0RXB1aUNkRlhHVGZNaHBB?=
 =?utf-8?B?SnRJMWpPOURkb1dHekR4MTRNNnFTa1RFUEMyR3loRFlkL0dab2RJNkFtZ2xs?=
 =?utf-8?B?bDBRQWhNK0xqMVdlMm5hSWtJZDZYS0FubnhtV2l6UUx2MkFuZUp4VThMRUhn?=
 =?utf-8?B?VjV3eGM5eTBMb2NOdSs0ai9IeGJCT29iUDNES2hzY3RHWVc5UGNRYzY4a2tH?=
 =?utf-8?B?Vi95Ky84RHFjbFJQMFY5Mm0yZUNzZTlielpqMVNSV1RQeVNHSTNFYnplV3Rw?=
 =?utf-8?B?dXR5ckRxWHBUN3VmM1RSKzlKWjE1dkxiaDdXcG1xYmZ1ZHNjSnJJaWZJRE52?=
 =?utf-8?B?ekhYZWpYb1dqZXJiTkFPdUF0bmhlczJPa1UzNkd1UHlYZFNGamxOT1lQYVRC?=
 =?utf-8?B?VHplQjU0WFI2TlRpSmJrVVBlaGx3QVBWaW92MnNmYmdFVkRKSG5wRmgwVlc0?=
 =?utf-8?B?UHozaUlnV2kzbys3QUtOWExwNldGZS9zQkVYOVpxek0ybmRDbTk0WkNsb0s2?=
 =?utf-8?B?akNjWDRhN1crNXJPUXJHRjVtbHE4aWsvYnRXK1h2eG44Mzh4UUpwZFdPenVu?=
 =?utf-8?B?dmJPaEJjVi9pU2JJVFRsazRlRXZBeS9leGxtQjVGa0laTTJLZGJYZVNFTFFw?=
 =?utf-8?B?ZGE5WDN4azVZeElDS2JHbDFZY0wyY0haTzluN0NGSDRyVGk2eWFnY0lYSnRO?=
 =?utf-8?B?TVhpV3o3OXhvU0Z0ZXNMWjNhRDR6M2p5WVgxR3VtMUxoSVoyWkIrb014Tzhz?=
 =?utf-8?B?K2RYQkVxRDR1TmVCS05QV3NTQ1FMVkpNaGxsUVowc3hmYWttTHJZWjRRR2Rt?=
 =?utf-8?B?NExwYXJvZlNiTnRJNm8rL2ticytTTHd6cFMwUVZ6dDd3MmdYdkdCaHRGQ3lX?=
 =?utf-8?B?LzFyR0RrK0R3Vm43YzV1NmVhME93Vm5jM01xcVRJRi9XWCs2YmZHWGsvVHJi?=
 =?utf-8?B?QlRpbE44WFJBV0ZaQmRuREpYa2ZUNy9PY1hWcncrR0ZsU2VVNHJoUUg1R1Qx?=
 =?utf-8?B?L0tCL0loMlNaUStjMEEyUEdMK2FVYW9rNGZOaGNHTGp4MmcrT0MwYkliTkhD?=
 =?utf-8?B?RjkycWxlLzNzVFc1bEY0UGlENTVCRDJsL0pUK3AycXFkbStyMXBnM3JtRUF0?=
 =?utf-8?Q?v9p+7kd39La5RYkMth?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41115a77-d428-482e-ec07-08de977a5e56
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 03:28:15.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +v3EsqSnp/jm30/OuxujlPPtrOKsXWlIYmYXNlu8P9hDNWuBwksaUcYc7Tn4Gc1pbvWLpYnwpIIjw7H654KzqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304



On 4/10/26 18:21, Cristian Cocos wrote:
> [You don't often get email from cristi@ieee.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> In *Windows*, yes, GPUs have indeed been supported in eGPU
> configuration, though not so much in Linux(!). The troubles we are
> currently experiencing, esp. concerning hot-plugging, have not been
> reported simply because eGPUs in Linux has, so far, been a very niche,
> limited application. In other words, it's not that these issues have
> not been around, it's just that they have not been REPORTED due to a
> very limited pool of users running Linux in eGPU configuration. GPU
> manufacturers have thus focused on patching up bugs in Windows, while
> hot-plugging-Thunderbolt-eGPUs-in-Linux has fallen onto the back burner
> due to its small market share. As such, I doubt that TB5 has anything
> to do with all this.
> 
> On Fri, 2026-04-10 at 16:01 -0700, Geramy Loveless wrote:
>> So after a while of doing investigations I keep thinking, gpus have
>> supported hotplug or so i would believe for a while ever since at
>> least thunderbolt 4 and possibly older styles too of hotplug as well
>> as dual gpu machines like laptops that have a dedicated and
>> integrated. I would think all of these problems we are seeing is most
>> likely due to something very specific to thunderbolt 5. So here is a
>> theory.
>>
>> Root port ACPI device: \_SB_.PCI0.GP10 at address 0x00030002 = PCI
>> 00:03.2
>> Its _DSD (Device-Specific Data) contains only:
>> "FundamentalDeviceResetTriggeredOnD3ToD0" = 1
>>
>> No ExternalFacingPort property. The firmware gives it a D3-to-D0
>> reset
>> hint but never declares it as external-facing.
>> For comparison, a properly configured system would have:
>>
>> Package {"ExternalFacingPort", 1},
>> Package {"DmaProperty", 1},
>>
>> The complete proof chain:
>>
>> DSDT (/tmp/dsdt.dsl:4194-4205): GP10 (00:03.2) _DSD has no
>> ExternalFacingPort
>> pci_acpi_set_external_facing() (pci-acpi.c:1422):
>> device_property_read_u8("ExternalFacingPort") fails → external_facing
>> stays 0
>> pci_set_removable() (probe.c:1780): parent not removable → falls
>> through
>> arch_pci_dev_is_removable() (arch/x86/pci/acpi.c:353):
>> !root->external_facing → returns false
>> Result: dev->removable never set to DEVICE_REMOVABLE on any device in
>> the chain
>>
>> Sysfs proof:
>>    00:03.2: removable=N/A, external_facing=N/A
>>    65:00.0: removable=N/A
>>    66:03.0: removable=N/A  (TB bridge with HotPlug+ Surprise+)
>>    93:00.0: removable=N/A
>>    97:00.0: removable=N/A  (eGPU — dev_is_removable() returns false)
>>
>> I'm not sure its correct so much but I have patched up the amdgpu
>> driver myself to use what its using now and "||
>> pci_is_thunderbolt_attached"
>> This might be entirely completely wrong :D but I figured I would see
>> what happens.
>>

I would say it's wrong.  We explicitly moved away from this because it's 
only indicating there is an Intel VSEC:

commit 7b1c6263eaf4f ("drm/amdgpu: don't use pci_is_thunderbolt_attached()")

Isn't what you point out a BIOS bug?

If the BIOS has an externally facing port without ExternalFacingPort or 
DmaProperty it's going to cause problems in Windows too.

https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports

Now granted; in Linux we might be using this a little bit differently.

If we were going to do /anything/ in Linux - I would say adding 
pci_is_thunderbolt_attached() as another criteria that marks devices as 
removable is what makes sense.


