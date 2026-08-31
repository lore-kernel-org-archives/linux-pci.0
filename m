Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012016.outbound.protection.outlook.com [40.107.200.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704A42CAF6;
	Mon, 31 Aug 2026 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200384; cv=fail; b=CWPRN+JW+OjAGH1kPmQMCAz997MHf/DLV+BrGoz+DvGLzKJU6CK4rvY9jG9qDqUcGvb/OsCeskJ18M0Xal9vYUSmXP+S8A0zdSK3v7ypHvGMrPuTbhcZ+TdlmZb/G1c+nt/pfbTsKlWZd27kZcO4qre8IRbnVh7+UgsBAtrwDQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200384; c=relaxed/simple;
	bh=+usLcs88iwAVBh6jyeWd9MCDEhiUYlX9S0VfTsY65wU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qTijFaewosazoJtSdUQa7bHxrd+zGL3jtFew3Q7Z3agjFbWOevYGnfRlSFdMc1321qljm7N+BQtpCBNEjx1g2XcWf/Zw1YqOYnaFRy59cEd6naGZMxxtH0w3oD80foG46vuQ2WPT2h/49DuRugsXNUSgA/0eY30sJvvp5uX1SWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QKBvaXkH; arc=fail smtp.client-ip=40.107.200.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QKBvaXkH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpBqshU083Jjsboh/LQjhuh08X5AO9P5brRFS7DS6eZXkYDwk1QeZ5FBs5KtAQbQi33VJdkXv5KvmKDSoUlsVESGSgoZ2+mRXBVFVfKbozAEzrOSGmGcU7kNG4lCQW9BTenEXwJMYkPMKswvuZLKt2nLfG1a1DK6JxGWFHrei6J+p+tJZA1ol7/PsiN4BlB5EUQjuM3tSCR1I+R8eEv7tvjjSyD3rlK/wT222ixJXB7wNdDOZwmzDrI36lJ2kye+I2p78IwuWRLXG93bQbOcl9M/2wzziPiMcAk7LBt5HIVXht+oY7caVxp9nsBseklOVlJ8J0LIjkNW4TjNnfnVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o76u1jEDSTXyBAJvIKFrUZiYbcMnCGylsiaZDLBPZiY=;
 b=zMsiZ5DxS8en3YlXaKyePsallY16Lya33u6UNJ+9pXp5ZLTkmKgcYcO8ssSZbGeUu6Zr3V6vxL0bsSctFip2JHkdPda1p+Y9xPf2Sd8uK7BjbBCYPofhpjErBAyeE/U8rBDY7gek2oFBAP/yFusvnYJExuMMaVAEXN0JkDb4yZSRBthjEkHenOm0WyW8p3xAgjTdlNECIhhSHGhWBqhlNXB/tvgm/eQwRFNIiah5EoxR/JzzweZIVNNbGLmh3+oiHu6H6PYbfSV2M3BTrrrUyZa8xFmhWKimPzufm04g9J9GkcStiisG1us+UjvyTrq3UY4ehpb7kbdyWF/bIx7AaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o76u1jEDSTXyBAJvIKFrUZiYbcMnCGylsiaZDLBPZiY=;
 b=QKBvaXkHMf3F0Ad+vmb7yWGhED/TuhbfaduatfpqY7k95L/fC/wVAR43ueM45vYQwBCOWzR1AgTSMiG4zF30YpuuYFy2jxXPF++zYjcntJ1k5v1HDIvYwTFpiSqp8bbMx4w/9a6B6T37alrlpwKNpeCd7hnLkwWOg4QFmSAdiVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:19:39 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 18:19:39 +0000
Message-ID: <b26f1c71-6780-49e6-b8b0-018b6b135cfd@amd.com>
Date: Mon, 31 Aug 2026 13:19:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Reserve prefetchable window headroom for Resizable
 BARs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Geramy Loveless <gloveless@jqluv.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, nra3088@gmail.com,
 meiling.leung@embeddedllm.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com>
 <d4c3ea40-d92a-49c4-ab2c-925fc70c4bb9@amd.com>
 <d6c56ff3-0b83-4d2e-7e6f-f3e65a284341@linux.intel.com>
 <1eb85efc-43f4-4929-8390-467308522236@jqluv.com>
 <b8cdbf77-0149-4805-8e41-d4db36579679@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b8cdbf77-0149-4805-8e41-d4db36579679@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0171.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::8) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f2616a-55a1-487a-ef91-08df078c6b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7WB3L5/myip6nzIrLQM59Ayp7EZRYLg5u8beN3NBkoAPxANQwuS1JCSkjL4qA33VdcE0fcsQ2qy3XOu1RZep6ujdYrv662urGmkBUNZ7vk8smMGlDrW6KMPTm6LZ6IS0VzGWwmZs3e9NuXLT8Y5vrlZsSjy7xU23J10+8MenkIpou9xB5P4soowshaj/wDzlPkdgeKyoJt0fOwFf80K0YJNoKqhgmAgxl0JforTTfftBs1SB7iL176VcSm8LDpD2OI87CG2qW5m0OmYmqhSacjPDw/A1x/qWfSm8RxmXaiGyYL7Ozw49yHHfa3OlHwzmWcPF2lm7hfWEHq8QAGGQbaVUzTcssU5w1/2ePfpASp2w5op6dO2RXqxs71+MwqhYkMb9QW3htczbXoJpPIrhuKNT67dcrwBv38L8onqMgrbeeHsOcCve0Do/mDR+088bXDOhFEvawihl7+VKiRCK4BokoyDrIZrA0pNjMIOniAbDxMN6IsFInZG200DyFAao1eep6WOrA9SXZH+J4TyQZ+DBzL14NuNOIo2hplcPk4KZkH7oMQIpINKXtDVgxTHPhDBGKhMpCG6Iwe45h8TQsZ8mV+oj370O7Rl/YAv2Bgcr0DDkTj6d40BMAUkGGKaosM8kt4jITRCB1tUKwp5b6labSc85Wra//otpQcYidkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUovcllpa2kzSGlxZzNZL290OEZieG9oaVIrZGxrcnZ4dkthNWpaNGF3eWtm?=
 =?utf-8?B?VEYyeVZpYnJOS2RrR2NSbi9yRVRXUmhYZWc4eTRXQnBkbjVKVDZ6OFhZclQw?=
 =?utf-8?B?dWIwV2FhMlJwVm0zTXZINm9OUk5HUENiS0FhMElUMS8xMXhnOWtoNThwVkF3?=
 =?utf-8?B?UnRkTzI5SnhtUXluZ09ycEFaL2VvVXRMbUlXRlM0MS9Qd1ZFT2owaXB5MEw5?=
 =?utf-8?B?N0VMMFg3TS84L3lPKzU1Q1ZhQmlsUXpOMFdrSUh0d0JNdGQzM2poakFteXZl?=
 =?utf-8?B?RUdFcGtONDN6Y05DT05EdVhMdklKZmdTTUZjY1NrUldLdER2eHFFSGhzZDNw?=
 =?utf-8?B?NjdZRUIzSTZJbmZvODFhb3FIZVFLeS9MUDNMbUl4NDZncWxrWEZKTFhyTGdZ?=
 =?utf-8?B?Z1h3YlhIZVBReFZib0RIS1JaaHRmemhXdTQwbjFNLzhjUU5ScDUwQjN6WWJo?=
 =?utf-8?B?aHRjdTdmUUpRWmE2UUlhalRFWlNZaFo2eUs0NW1vamtpLzBIVjFLWnJUUXdk?=
 =?utf-8?B?ZGcvcU92STJxaXN4UUNmanhZSFJLTTJ5Q2svanZ6MU9WWTZyUXoyUHNYMmdL?=
 =?utf-8?B?M01pMHNzajFLNU9tRENBODNqYTdUUi9mcXgyZ0V4ZUx5QytzZHRTazY5THVj?=
 =?utf-8?B?Y1VjcWpHNXZieEdvU0Qyd05FdXg1elV1YkVSR2xqT2RuOTA1OVJBZzVDTFVY?=
 =?utf-8?B?ekx4VGw3SE4zQ2FtL1o2UndYaGYwcGRXRUd6N2xaczR2QnU1VHJDL0FRZ0g1?=
 =?utf-8?B?bkFETEdQNFZYa0ZsTDVHa3orSnpBbmZyK21rbk9vRjgvQmFiTVRyUkRic3Jh?=
 =?utf-8?B?aFNYTUg0ckN5M3hEeUVvVDFtNEI1bmx2SitLMFpwTWhLM1RlRGVhbGg1Vmk2?=
 =?utf-8?B?RWtIc0lQa1dISGRxM2tuaFN6L2hEOVdVa1orT0J4TGhQQjZLU1IyZDBBNlFz?=
 =?utf-8?B?RFlVUktwbEFyYlV3VGk4M2U5dFZ5a0FmQnV0SG9xVUhIYzkwd25sQ05aT1h0?=
 =?utf-8?B?dnczLzZpZ2hoYmdtR0dZSjJkS1hUWCtINzVsWmVuMkhJYW9MTk42a0xSTjJy?=
 =?utf-8?B?QmgzL2w0aVdVOHM1a3U2MnFqZTI4V2c2MEVWckZTWHdVamRSZzBZaiswU1kr?=
 =?utf-8?B?ZDZBSDhBbjdtQ0tzaVRDQzVWWHVDczR6OVFDL01LZU9DdFB6aTZERFZ3L0Ux?=
 =?utf-8?B?eHBPRTZKbmJRUGtHVVEyVVVRdm1zckJPY2hYMUV4eFN6U3RUbTJ0TWEzd0kw?=
 =?utf-8?B?WGlneVNVdjJSdEorM2JPbi91a29YTTNVVWRzY3liV1hjVTY3cEpxSVFGRlBE?=
 =?utf-8?B?OUtLNmI1NGk4YnJXZnBMMk5FVm5odkZKaDlZUjFadlE2MmU0K3FhVTgxNkkv?=
 =?utf-8?B?Z1Z3dHNtdzhZTzNOdWZSVFFPNlhNRnpFSTlHWVpjZkRreU5kcVM5VUU1M0lp?=
 =?utf-8?B?eGFPM0x1VE5XZTltUDIya1pmcW5tZk92cUlvTnlKYVNCVXNLWXdvVUR3cnVH?=
 =?utf-8?B?Ukk1b3R6eENpWU1TOTUzdTFLZWtEMzZBdFc3T2VCQWFFaHpneFhaanZtaURo?=
 =?utf-8?B?YTlXVWoxalBaV040SE9PZ0loRDNkaHRVZDBZYkJja0hyUVMxR01sRDN0SE00?=
 =?utf-8?B?L1NzVHNtNjU0RWlBWStFZ3ZTMmlpNW1Ldmwza1hWS1VqVzlYMENsc214SU9U?=
 =?utf-8?B?SGdHQXNkeXdnaWQ5ZENseW1UTVpGS1hQVzMwTGtqSzhVN3ZSbU9uSG1XcnZo?=
 =?utf-8?B?ZWxjRmhwZHpVMzdqUFB1Q3c2eVpSNUdXS1J2UGpFb2NGVisxMEdKSzBIM1ZV?=
 =?utf-8?B?ZXJTRE94V3Y2b3lWRnhFVE9mS2VwRmhPWTVDelRocVRpUU0yeGZFM2xKcUVZ?=
 =?utf-8?B?SmwyLzh3MXI5WUlpa2kwMnc2MlVjRERKRGV2MHc2M3Y0a3Ria1F3NVI0SkJz?=
 =?utf-8?B?c3ExMng5eEpFOU4xMmsrTHFJaWRZWi9Tay9qZXVpeGZUYmludHcyRS9xdDR2?=
 =?utf-8?B?ZUE0Ly9NdG04aW8yditFb05NOVIrZDVaVjUraFFnbHdHZ1Ixa2NNb29GTmEy?=
 =?utf-8?B?UXI0ejRBTkQ1dVF1ZTg3RmlHb1AxdzBGRFM2OU52QVBISkttYjFId1pPNWFT?=
 =?utf-8?B?T2JsUjhOczFWZzZzeTMxMUpzTlJVU1dPWUxIYVZTL3EybjR6Z3FjbzNOdzRx?=
 =?utf-8?B?NkVUeUxQMjVmbUR4Q3pUOSt0clVKSEIrQVAzRmYxdHBHY1h3cFdGUGFPNGRx?=
 =?utf-8?B?emxQcXNSNVY5Y1FwcWQvMklWeDE5SjVxUnZlc1RvbkZ2OFNWaHBkU0w0NzZP?=
 =?utf-8?B?NjhpdzBDRDFTUU9zdEo0L09lZmIyUFBqellYbUMzOWo5ejgrdTdMdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f2616a-55a1-487a-ef91-08df078c6b68
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:19:39.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiXcE+fWpzw6MLEHozMJVD4wA1pDBd6viVYONEa3xtkCUQCJcz7cav6UUY4Y/2eXExkKdzRlqKjr2h98byBIXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509



On 8/31/26 13:07, Christian König wrote:
> On 8/31/26 19:49, Geramy Loveless wrote:
>> On 8/31/26 9:58 AM, Ilpo Järvinen wrote:
>>> On Mon, 31 Aug 2026, Christian König wrote:
>>>
>>>> On 8/28/26 23:37, Geramy Loveless wrote:
>>>>> Firmware typically sizes prefetchable bridge windows for the boot-time
>>>>> BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is then
>>>>> no room for a driver to grow a Resizable BAR afterwards: every window
>>>>> from the leaf up to the root is sized for the small BAR, so
>>>>> pci_resize_resource() fails with -ENOSPC.
>>>>>
>>>>> Furthermore, a small prefetchable BAR (e.g., a 2 MiB doorbell) sharing a
>>>>> bridge's single prefetchable window with a much larger one (e.g., a 32 GiB
>>>>> VRAM BAR) pushes the required window size past the large BAR's alignment.
>>>>> Because bridge windows round up to a power of two, this forces a massive
>>>>> alignment waste (e.g., 32 GiB + 2 MiB rounds up to a 64 GiB window,
>>>>> wasting ~32 GiB per GPU).
>>>>>
>>>>> This patch solves both issues to enable ReBAR on cascaded switch fabrics:
>>>>>
>>>>> 1. Reserve Headroom:
>>>>> Reserve prefetchable window headroom for the maximum size of each
>>>>> downstream Resizable BAR during the bridge sizing pass. The device BAR
>>>>> and hardware ReBAR are left at their boot size to prevent tearing down
>>>>> firmware-loaded state (e.g., AMD R9700 PSP) before the driver binds.
>>>> Yeah that was suggested before but that is clearly not something you can
>>>> do in common code.
>>>>
>>>> The ReBAR fields often doesn't reflect the actual needed space but
>>>> rather the maximum the HW address logic can resolve.
>>>>
>>>> So what you end up with is allocating multiple TiB for a window which
>>>> just needs few GiB, sometimes even completely overflowing the 64bit
>>>> address space made available by the root complex.
>>
>> Yeah I could imagine that would be bad, hence I tried to compact the 64-bit space as well. As far as I understand PCI/PCIe standards its making this patch difficult.
>> Christian I'm not sure if you could share these reference documents but that probably would be a better start for me to look at before I update the patch or make changes, also I need to wait for a review on the last patch I submitted too, so that leaves me with some time to review some standards if you know specifically where to look, if not thats fine too.
>>
>>> Yes. A naive approach to (only) go to the max ReBAR allows just doesn't
>>> work well enough to be usable in general case.
>> I did not know the max would report above the amount is actually needed because of vendors decisions in the cards, that's interesting.
> 
> Yeah as I said before to actually figure out how large your BAR needs to be for an AMD GPU you have to load quite a bit of FW and probe the connected RAM chips.
> 
> If the GPU is your initial display device that is not much of a problem because that happens quite early with the VBIOS load, but if you have non display HW the driver actually needs to do this ASIC init/reset.
> 
> The bus interface just gives out the possible BAR sizes which could potentially make sense on the board.
> 
> At least AMD has also produced quite a number of GPUs with bugs in the ReBAR registers, so for example Navi 1x reports possible BAR sizes of only between 1 - 4 MiB while it should be 8GiB at least.
> 
> I clearly don't recommend using that register as source for the resource estimation for upstream bridges.
> 
> Regards,
> Christian.

Generally speaking besides eGPUs people don't "frequently" change PCIe 
topologies.

Another way to approach this could be to cache some of this information 
somewhere stateful the kernel can optionally get.  Something like this:

1. Add a new sysfs knob to "snapshot" the topology layout and the ideal 
size of specific devices connected.
2. This would be saved to an EFI variable.
3. During the next bootup the EFI variable can be fetched and compare if 
the topology layout changed.
4. If the topology is identical take into account the requested size for 
specific devices.
5. If the topology is different, ignore the EFI variable.

There would be a lot of discussion on the nuts and bolts of how to judge 
it's identical (is VID/DID/RID and BDF enough?).

Both at runtime and boot time I think it would have to exclude anything 
that deemed external too.

Thoughts on the idea otherwise?
