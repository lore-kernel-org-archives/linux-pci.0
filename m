Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1023B7779;
	Thu,  7 May 2026 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160304; cv=fail; b=KrkNOHkrOj6Mel1sHf0HuCzbIuWAVdClwDxm8SlyXSJGq2XYAcjM4xk2B5mrMM/ZnWlRDcmAUPs9xFgLCW8PjRrVx9CQaichK/5coy6PtaZEbfHgQh818c43WOyVnUD3oapMy7B0CexZk0vfk05ETBeEOcIZ2zMlq1ktFf66u3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160304; c=relaxed/simple;
	bh=liIOX5r3sdb5R9mO+vqMe3VeA+OFdlgsuLj65iW6ZrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FFRSeWvhY8IgzWPm+4pBGtT8TiLb4GrKe+m2wH8UkC39vJInsrfThZavxP+M5LXiGJyk7LWjJiW0NGc01uLA4C+rsPt7rgpNcN46Bh+d77W7zwZW801LGn53p30y5EWfztJC3y5NE6GGvc+9LYyMJC7AJ4a/KKcDaOd0xTu7ccY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HcpwqF4b; arc=fail smtp.client-ip=40.93.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HcpwqF4b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRYbgT4lJ/1oZXAY6Rxa4fo4zuFe1b75dinQtlFgKvtXMzv/a6KNNO3KNbxBVtnI3fhVoVmDBpONKeOtvuI1S5TU0UWDnxg5QGkj9ctJIg9NcIF0XbNSE2HsvLT2s1WN5roRAS6aw1T5EDk3svFi9F/v64hB7abr/Cl5cRR5ZAiOSO+2blVYSlMWGNTn+OTLtd1XgPeWPT9xhZtZ1bEAEgSc9Rw8H6BMoxTZYKo+VIuz+eL9aqHbVKTZ6374VaHPxr51XBaw3p1dMXc9O5/LuHf784Q13qSlYxIP6mhzBMB/z1daV6VaVKxs3cTPNxPH9hwGwSo1cD6F+MfZfDQgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEtHwCxikqjtueXSmJmqq7dlYH4xc1Avg75aelOpIcI=;
 b=dbiDKKF3/VWt43T2MV6q0ZhhkHUCAIjM0LfStnGcTCV86mAgOSeVLI+/5K+5Kr5ynZhgL8/VtWvfoLWotdwtC6hn4uWwMNLXdx/RyUUs5zQEHSO+XtvKJ5/AvUdZWEspkCmCz5x9tUuQnInvt17Vg4Ch6oyzmY2yX35NYI/8WydKB05kS2RyvYoo575lwJftfv9XUOkB8Ng/sa50/xpDm+dUBUxc3/jOsZ2MTMBvfoleTRvVXUlHlNwnsvM46FLNb5+sOacxUdwoAlPkVLqSJt49EZlosrmDDkVqY7rSWCwZXTYdyPt8gU5k0mPE4Gv1k/GMX/SLYSYcMyxHnnxntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEtHwCxikqjtueXSmJmqq7dlYH4xc1Avg75aelOpIcI=;
 b=HcpwqF4bAfdlol0XLqoQ2o3SXxu6tvlqCXk/02UVvUFjw3urlYW/S19DgMJg8Nd5a9IcNpeB1FYDPTIxwetuLn/lym8BNfFkwflh3XAGF47yTCNwJwODr0DpUIhUAuxG/3qAB89fiAaYBtp0QbKIzfLZLC7PiM+e4ZOC0OjGuP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 13:24:59 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 13:24:59 +0000
Message-ID: <d1132b52-153f-4451-9aff-ab2545e1a3d0@amd.com>
Date: Thu, 7 May 2026 08:24:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: add initial support for AMD PROM21 xHCI
 temperature sensor
Content-Language: en-US
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506032939.92351-1-hurryman2212@gmail.com>
 <cover.1778099627.git.hurryman2212@gmail.com>
 <2e2ea249b30168a2eab62fc110c226a511f21bf2.1778099627.git.hurryman2212@gmail.com>
 <20260506233332.664f220c.michal.pecio@gmail.com>
 <424c4dc4-1810-4ffb-ae93-7ec9f880ec1e@amd.com>
 <20260507110821.07480da8.michal.pecio@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260507110821.07480da8.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:610:54::39) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f9e01d-962c-425e-e695-08deac3c0936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EXyl4e8WafoyYf7ezHLdIzcPyJ7/BIstuhPfdPRF1rGl67fihdpTRIK0HNp5dy1U6T5L28gmJzGgUTLdGlTEN9lYnFpOqNx+9aP0aal7g0liOTcE0WDVM6qIDRCTSJ0T0ZdUl1OgpS1UFLgnSbLgmUGzVLSbIkuwCyd21EvR0Hdf+BOiWrHORcR26+ESRacgpoFALqklu8xOmDRtBPYQNNUwzd6CHpLIf67qttYQlmyH4Ox1yP9yLTzlsBoTlbcdBBULv+yrKaSARV8x7GLVupgG7y2VSOL4/lzNoMTeBrxkcpvGp3w/qSvO906uMOA+BVLAKhWKQkcT4Uv8IDaSB5vIEd1AjH/uLDRbpfiq64/QA038Ph8iL60PQv4KQpSLuQ/cWSHapaks0n6FBhJi1JI7heE63ckspkBoSxbCiT6sTLR0Ex8Ut06ngOhPpRQ/asFIKbJE4PK/nJaKATpBuXFQ3HmeEsSAbpBG4ktlgw7ZjYx9kC5/MUK8bb9hai4O4ZV+Uaa3L4GhkxD+9g1TbeisbvVA1Xj8BWO/WtsXyJ+wlbrqn+zEy9j7naXBvrqP9j2R5BTGHauYpsn+UxNYBgkNCUcPSAf0CQglaFU9rREyVaK0sxTI+cpE8HAhkpjaS36CxiXFpN/C2RKtt2QfYzzSQwWQEC3Rmss/DLYFENTgTihVL8O6ktQ8IT915EUO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUlkNzhwN3N1UFRiNnlmdjl5aWtVOWxJYzlLVkNrajNVTStiVjIvSTRVd2tQ?=
 =?utf-8?B?Zkg0b2hRNGpRWkdFOVhaaWJtNmhCdGx2TFZrdDMxZkoxZTdCbVViQXlhQkdR?=
 =?utf-8?B?SEZ4UDZTL2JoZ3lMM2xOd3RCUmpoT1kzS1pyOVNBeG9HL2MxYWRCc0pab3pQ?=
 =?utf-8?B?clR3a1pXbzdMS2dQTEFKcEZ5N3ZGSWFoWDJMTWF2b2R2dWVJOXZCbW5nWEZi?=
 =?utf-8?B?UHdYSGxGNUNFdlFrR2p5VFBOakVxMjdQUEp2VWZNVEtYb0ovWHJTNmg3a2VZ?=
 =?utf-8?B?ZDFqWDdaNFVYQ2tNVDhkZVdMSXdHb0lrVVRvN3ZvdjloL3B6cnQ0RkowZDBY?=
 =?utf-8?B?M01vSFZOTFlUdTZkZEtBOEZyNHQrNW9sbzQ0NU1ZTjZIeUJQdXZqRDFidXBG?=
 =?utf-8?B?WGFQZWFDTUY4cUMyR29sZjIvZXV3S1RYWUo0NkoyMEtzcHdQaXNCQlVib2Zq?=
 =?utf-8?B?czd1c1dDYWw2ekRoV2s0MzZIdjRrbExoWlQ1NXFFcG9tNnUrU0NxVk05dTN5?=
 =?utf-8?B?MjlnNk5VOC9Ia3kxRmdzeHBCVnkreS9ybDA0cDJUbjNaeFhmSkxKQnBzZVZO?=
 =?utf-8?B?US82Vk1kZXBRbHlFQU45QWY2ZUJJaGJWQjVqdGcvY1U4c2tFai9GekJoZnlB?=
 =?utf-8?B?dmtyUktkb0NPRGk2eXdOeHMyRTJDeW5yb3p3UlFNTzM3V2V2T0hzajVNTkJL?=
 =?utf-8?B?U2J4bnFIY05ycndEM3Q5TGdUSnNQMERvSFFLeFNYQTZuam8xclNnOStHY1FQ?=
 =?utf-8?B?eXVCTk84NEttREVOTElaMDE2SFNsOWVBdFl4WWpZU1NZa3dNUUJXeTB3Skor?=
 =?utf-8?B?amlGRFQ3MHlkbmR2U1hUQnRLbWYvejgrdkZuSFJGeXdDcEJFMXppR3dJSGd6?=
 =?utf-8?B?a2ZpSkszZUUzZTlQdmcrYVR2dU9SVEF5MTZOUVR5VTdiSnhoTkUxV1NXeHk1?=
 =?utf-8?B?THBmeXhYZ01LaE1kaUNHRkU5UEhjNGkraDlwQ3JyWGpTa3V2ckJlOEw1TmI5?=
 =?utf-8?B?RE96eHVRU3MzYndCblpjUVE3WDh5RmZYNmE1WVZ5bmpFbEZDQlNhRWVEUytw?=
 =?utf-8?B?UGNJT0x2cFNscUhLZWdZSHVqNkozeThrQnIxS3N1UVlpczZkQkRCQ2R6eHVD?=
 =?utf-8?B?c25FdU5WcXFFb0VSVDJqTGEvcXNlckM5WnRtQStuNzFNN1dqek9SY2ZEZENl?=
 =?utf-8?B?M1g0YVltcCs3bkc2T3N2WGFkL3FkZVVKNFJLME5OdTV3OW9GaVI3MjFoZ2NI?=
 =?utf-8?B?Zkc4K2hTRmt0a1RYd3B5VWh6MHBRRVd0YWdMQ3N3NFJqRVNqZy9XSEhrQnhn?=
 =?utf-8?B?MjREOU9jcW9LUnNKemZVVzI1NE9XOUxqVXp0U3pkUVJoTHh6VWlKK0w2ZlFs?=
 =?utf-8?B?YkhlMnFiQXZsaHY2bGtvdTRFN1FaUHVDODlaOWxla0VHdUw5MSswMXpVc1Zz?=
 =?utf-8?B?MW5pU2lRK2ZSU0tDRjMyQmJQeU1vM2x0eU1Pd20zVDd4Z3I5Vnp1MDZ2T1RV?=
 =?utf-8?B?R2thTUVYWE5kTFJFUHpiaGVXclFvVWl1TmJIR1RsbUhPS081bE5RZWdLcXdE?=
 =?utf-8?B?dm9GekkxNXZ0WWNmNnhpaTl1Mks3Y004S2gyMXNVZ0NvTUZuL3dWbUZRY3p1?=
 =?utf-8?B?MFRVN2R5M250Ri9HSFFEdkZQTUJtakNpTCtHbWsyTW5MRG51cXlJQ0dXZFV4?=
 =?utf-8?B?WlJQR2JodnkvMmZoTE11SVdVSHF4K2hIdGVuV2oxeUgvdTh3S1RLSStOQVg1?=
 =?utf-8?B?Zk5NY3g4aU1BWTZPYVA0TEtXTjhqZWtmVFBZckhCM29Bbm9BLy9EcnZGVS92?=
 =?utf-8?B?M2tBblpXQWhScWdLZmRVclFON0l4K3k5dDVvTmxnYzRoWTJnQzVTL0drWWJB?=
 =?utf-8?B?NG1vTWd5L2FsUXU1M3pXWHRmTllic08xR21QSkJxamFvdkVIK28xbmZuaHAr?=
 =?utf-8?B?aURSY2FiajJsNGFQcGpHQjhYSnVzeHVPSHhWM1VpK2ljeFdjYXI0ZGtrVVlK?=
 =?utf-8?B?ZXVhMFNvRlNHQkwwbVpxZmV3RW0wSmlLZit1L1M1Sng3NDBJUXo2SVdUOXEr?=
 =?utf-8?B?VDhSbjhxdW55bGFqYUh3bXVvTThSZTZmT2NJSm1SM0VHTUdKQUdPRzB1b25V?=
 =?utf-8?B?bUlocExETndNZ0JvSFp5eWg4bzlJMHdsRlBEbXlPY1pIWTV6Um0yRHlqY3E0?=
 =?utf-8?B?aHBmYThTbk5Zci9WQms5Q3VueEp5eWR1aDVpTW03bDRUeU13VWlQR21idmt5?=
 =?utf-8?B?dHI3YmtiSkd0MXU0Sy9yNGF0TjR2WE1sZ3NPRnkvL0NYdWFQV3VhR2Z4MTZj?=
 =?utf-8?B?c1oxVkZMREVnQ3haajB1S2hTcFBnaFV2djVoR1lkVlR0bUxEcVVuZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f9e01d-962c-425e-e695-08deac3c0936
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:24:59.2391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pc465BlAHeN0wJfILPlXUw4jz/5J5oV5FDpJGOq6KJYVdeJ36eSs9rsbxA993kub7fqigHte7qyEA13T0V4ICg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286



On 5/7/26 04:08, Michal Pecio wrote:
> On Wed, 6 May 2026 16:36:49 -0500, Mario Limonciello wrote:
>>>> The temperature register did not return a valid value while the
>>>> xHCI PCI function was suspended in testing. Keep the existing
>>>> behavior by default and allow temperature reads to wake the xHCI
>>>> PCI device. Add an allow_pm_switch module parameter so users can
>>>> disable that behavior; when disabled, reads do not wake the
>>>> device and return -EAGAIN if it is suspended.
>>>
>>> Is such behavior useful?
>>>
>>> Maybe the driver could just disable runtime PM while it's loaded.
>>
>> I'd encourage what we do in amdgpu for dGPUs. The hwmon files will
>> return an error code (I forget which code) when the device is in
>> runtime PM when called.  Don't explicitly wake it otherwise.
>>
>> This prevents someone installing a sensor monitoring application and
>> that application "being the only thing" keeping the dGPU awake.  If
>> it's awake already for other reasons (like being used) then return
>> valid data to the applications
> 
> Well, that's not a dGPU but an xHCI controller embedded in the chipset,
> which chipset is more or less active all the time (includes bridges to
> PCIe ports, some SATA controllers and mabe other things I forgot).
> Is the saving from disabling xHCI significant for a desktop system?
> 
> Users may be interested in monitoring chipset temperature even while
> not actively using USB.
> 
> I don't know what are the conditions to put GPUs into runtime suspend,
> but a USB HC will be going in and out quite randomly, depending on
> connected devices and their workload. You may end up needing to answer
> people why their sensor only works when they turn on a webcam :)

Heh.  You have a good point here.  The reason for this policy in dGPUs 
came from a lot of people using them "headless" (for example plugging in 
a display to the iGPU on the board) and wondering why randomly their 
power shot up and fans spun up on the GPU.  It took a while to narrow 
down that it was specifically sensor software doing it.

For a sensor accessed through registers on XHCI this is a lot less of a 
big deal for all the reasons you point out.

> 
> Alternatively, would it be possible to bring a suspendend HC into D0,
> read the temperature register and then put it back into D3hot without
> bothering the USB layer to fully resume and suspend xHCI logic?
> 
This sounds better to me if it's feasible.
