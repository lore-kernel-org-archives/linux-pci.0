Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE8C26AC3;
	Wed,  6 May 2026 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778038610; cv=fail; b=iYX4mGO6x1eQiEDTkOREkMjnNXnZFsWwbtL+eMFXSsvTBEju8qvFlIN+alPoleqbQl+qxLM6UyWU5CAYMSV6gmRgtvuhYp/9OJop841MZ0xcimRXUrudXNDCxfssmBWyfvJU8nu5yFY3PCSyhdtb2VxzXapMgPlceZwOoYybvu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778038610; c=relaxed/simple;
	bh=Oq1kMTQG4EfOmAOdDR/dxm8k8wfyMEx6R7ZUV2y+8U0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E/fTGndIW+nRX2NmTHTAgC21p2L5dVJ/C0LIFaJo5ia2Q/Zgv/+juNGLlpKF3L8sqV1B/ZqQHzt/lmRgMahATj4+tZ+Rqli6z2rSM+kP06o8QV0GYlhJc6fj0FSR6HKTt5fLdPxv5QZu13KH8XlxEGkZf8dIiL3OxL2ejrbqGvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FYfN5ba+; arc=fail smtp.client-ip=52.101.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FYfN5ba+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXevtmpTT87PvVx+LxTHgcHLM2URRMFFjSzIV2nza2/rWTr7c3fluZLpfeS5Upq86DOfbg/b2oUVn6QTStbzFAuOglG70FNWl6UhYB5xTs+um1J+LluSKpfHoS44Te5jcAAf9/0lCxEyyQqDwRcGh8qYxC+70Fht89TnoCchyYp+e8ONX8EDURjMAHicfpZHJzKVCQTChL+9EoZdYf9lGiUIJ9fjvEsTcd8HciwvzT06A0HRUNf75D5AUzYj4k91SZ+t3rrxxEFXov8j132nbcyt7V5jl4O9bB9jYk51utRBlUg8f3VRl8iqE+PkHM3LsWwpx9u1oa5T+ilEBD+GKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/0hgw+WQAUtDoZh7IJZierQDeXuyHargX8UxCmaJ7U=;
 b=aO2g8GTFKmZiyOVrIec1f8tlb9+VeMgRbJsfZo0gVbHeVFb056Fe+GrerEfmv2k1VE8myniAA0ZsBkb8TDpxb4Tt+vTJOupPQa/Pp7rGSxz8DV3QwoK8TT3NzH/hnPbLaZuK/y1jsBkmsldpMbXBIPadRahewUnknNt85wcB4mD6zC5G7q84ZFZRL1GkVTyeE4qbGUNn3b17sz+BNu2HchX5cE3AZXaKZ15urfBqFXclLQ/26XaawTLNL8AE6wggFvdp1HdipmLPPllZYLPONj03psyfqM4dhIeutqMJRkX0DJDf2jIFmCZpqI/uvDOeZeMqlJ+Iz9zEzelyIVwA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/0hgw+WQAUtDoZh7IJZierQDeXuyHargX8UxCmaJ7U=;
 b=FYfN5ba+uDZ6fe/EOkadtiKDVW/talkkBrvfcuxvplbeOWyej8Dr1admST3Zp2dTEdEuAIeLBFFDAz8raCayT1KcDgSaiaLnGlfqGJW8YXoZBj6C2kcjCzzVJ1qu+oAzy8xkcySaicIHZE/Hcxm5DJHvn4FzGcMabp2U2O/ugwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CH1PR12MB9648.namprd12.prod.outlook.com (2603:10b6:610:2b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 03:36:44 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 03:36:43 +0000
Message-ID: <72546706-78bc-4fb9-8676-768a71cb226a@amd.com>
Date: Tue, 5 May 2026 22:36:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ASPM: Enable L0s/L1 for removable devices when BIOS
 didn't configure ASPM
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 linux-pm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20260505214234.GA751157@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260505214234.GA751157@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::21) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CH1PR12MB9648:EE_
X-MS-Office365-Filtering-Correlation-Id: 381d25ff-a62d-4258-b172-08deab20b0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+I3UMkC+f04pN+nSHUiglMZnmi1dr5VVX6V4UgCvoZe16zMuHFM34wA4oFe4aOJNQBGrJM/NeXpQ8J9TLGpAK4E6V8EkbJOctWIZXeJqH26c31Se9OGv6iEOQxyyaIbhrV8O8bcK7BrQYjAgQolfS+8U+WxS7vUFkWaIaGuLEkh3BgikTW1zWLamcuyTvLlNebtawuoy0csLd4+PZUWMI45EDpPhahmCjA4vjctQtNib2aVH8dv1tDEIrfxFYUiHyQJhDNHB81PWkpyHCFXzkCSybWq+Rvw9+PsbfQpuMMelwRkMuyhLDF6OQouP7cFPMDwoRLWBaW6ZPNKBdJJxrm03l68ahGppI3AmdyWG2nLB9tEoIKlzgUVYGaxmuShC8qIoj+GTrQnIdTLQgNhSNUVuXTN5bhBzi9YtTs2uT5MxH1tuzQsoqxcI5dM8BRv/a8vP2Vd3vtcy86/Cj3PMbyOmqhpOo2iOlVRtXIh6tLtxH8yzWqxrOHRRhVsQ9CPc/yw/0R1ejIXA0D4EB7OuPIaQPJYOA8pO1lAtrUZF1JWP7rFZP6o21gicKIKXuJqKZjYMbiZTDvBRuw9UAvYX6G87gCvTuzAJcW8vofpCMh0XXqL5w0zJecwUNILSYovt+VAoIixyZ82oc7do0NPHSJ/wbm+MSt6nlAnePLIOjm2GgjNxAeerldsMyzyG1HJe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU5YYkx6c2NqVE40V254WHZQbTFvcUZJMUtWY2g1RkwxSUhiaU1ERkpXUnhB?=
 =?utf-8?B?R044R2FEQ2d6M2ZlZjZ4RFlCUXY4M25vSWxpak43MElZZjFWMUtwSmxZSmxw?=
 =?utf-8?B?dlRXZnFGWnVMMkkwdGtQT2R6QVVBdUE0dFdtSmovNFBqVTlUNUlIWWFqVkhD?=
 =?utf-8?B?b1JHVWgvM0Q4YmZUL2R6UWRsNnlHekx3bUJ0SkhPUGxUR2ZsNjcwcVpnUnQw?=
 =?utf-8?B?Uk1vMW16THpGeW1aRzdDSXY4WkdGSEdyTjZzVVFFTDZHQVh0WkhweE1zRkRK?=
 =?utf-8?B?ai94eE1KZ2d2TlZTc3RFam9sUDBYTXN6OU1kNEpZeXNkVGlCRUpkZ240cXIv?=
 =?utf-8?B?ckwzcTVoV3E3QTRiMk1oN3M5dEoyWUp2Sm1VWjJrVDVMVVl2MTVxT1BtK0tn?=
 =?utf-8?B?SmEzNkNhbTFRVGxpcmF5Mm9PTVpsaXZVQ3JhdVhNRXl6bENPbTdpNGNEbWRQ?=
 =?utf-8?B?SUZmS3h5Z0FYellaTkJibkMxUE1WMTlQbjNSQWR5RUd0ZVpCQVYvcW1Qd2Rq?=
 =?utf-8?B?WjdsRmlCVVM1YU11ZVBNSVF5VnY4T0NkS1BWQnJVdzFJZGJSdzZVMlJFc3Bh?=
 =?utf-8?B?WngrQ09HQXA5NnQ2S1VQZ2V2ODNaUVZ1MXFFT0FEOElzeGJ3V1pCa2Y2L1FZ?=
 =?utf-8?B?UEJCaUgzWUU4QlFVMUhGNGdJUmpYMithRk5KaFRvWFpjN2h3Q2NvSU96cWwy?=
 =?utf-8?B?WCtvQ2Y5WU5CTmI4STVRTXdMRXpoaEZsUWplclczb0FIK2szbk9xdXNGZHNK?=
 =?utf-8?B?aUR5Y00zYnhia3dISlcyWC9OYTFUcDd1Nm5Sc2RnMy9QS29yNnZOcWwvWWVU?=
 =?utf-8?B?RGZZcDBkTTJVQVd2c3JRN1RtckxZR2x4WVRGY2VqYmJoZERBaEZGaDNjb0FE?=
 =?utf-8?B?aE1LTjRSL3NCeEgwZmg4T1N0cllVS21nNFZuSGJSL1d3YVNXNTVWZ1hvQysz?=
 =?utf-8?B?U095RjFWaVYvdmNST3JaOER1citkQ2ZzNVpaQUY5cnRTbDI2ekIrVjNaa2xJ?=
 =?utf-8?B?Znl5dFVvRVh5VWVpelk4RUNLR1NtTlNWQ3ZUNkl4UWE2TTNSZytkK2RvL3V3?=
 =?utf-8?B?UVlnVkNNWTFSdklLZW9pSWtDVURQNElQeVR6cGR1dS8vc3gxSmc0SzQvMEFH?=
 =?utf-8?B?KzIyZlZmM09JVmx6bUF6dGhBOURGV0ZvVFoyRzF3TVRnNFhkVVpXSDhrM0FK?=
 =?utf-8?B?UlI4TS9PNmNGQVUvVE4vc2ZLL3c0Rk5lNEVCVGJ4Sk5MbGdYQUptMWNhajNa?=
 =?utf-8?B?cjk2TUxGSmhsSDgrSTJTbjBPZWpVbDNTem1SY3IydWVYajJMQ0hINnJWZkxS?=
 =?utf-8?B?L0hURTYzL0srZ2hZTmRIaTgvSGM2S1RFb3VjMlc0aFNGWjRSMGE4MUU1NnFZ?=
 =?utf-8?B?WmR1VDJoY0g3cE5ncUgrUVRZeFFVWHdyWTBHc2x0LzdsV0JFVEVBbks0MHk4?=
 =?utf-8?B?QWpRVDV0T1d0blBLZWdBSWhlVTR6V2RCbGhkc1d1V2p6aXJmRERiWnJjNjBH?=
 =?utf-8?B?MU1rem9NaTdhVm80SUp4aVdRTGY4Yyt0NlY1OURrclpQQkJ3MVhNS3ZWREZw?=
 =?utf-8?B?VitTbitWS0Y0cytCK01PcG1nemZNOEZKajNiTytZRE9td2RLQ1ZqcURXcE9Z?=
 =?utf-8?B?UmVaOEUxZ2Vqb2U0UXI0UW5JcmpoWVRNM2sxN2c5VEZqTHZtTHFiOHpTS3dx?=
 =?utf-8?B?am90U2toVVZ5ekJKWGxYK00xdUYwRUo4QjRyUDZEVWx6elVSbVhVNXo3ZDdU?=
 =?utf-8?B?UHY5VWhNOXNlR3Y2V0Z6UHZ3cmRCNW9zTGhNR3ROL3N5Ry9SYkJJbTlqZ0dW?=
 =?utf-8?B?c0RMWS9qYkRhUVozSXdFaXlobXM4c3haMm5aUkVPQ2p0MFU0ZVZWaDdPTVBM?=
 =?utf-8?B?dWlOV0ZwOHg5MFZ3TGJoZUhWUG1aMVRHV3AzMTFLNUFTVHJFdXowTnpHczZW?=
 =?utf-8?B?WjZlSDhld3J0L1MyVWlZT3NTZ3F4WVNKZElVZFpGTzhpUTl4c1RkR2VTdXY3?=
 =?utf-8?B?RVpkZ1BBbDN4M3RQKzJJQzBaOTdYR0orOUV2eWl2bHBiYXZGMlUwcGdyalcz?=
 =?utf-8?B?dXVWSWVWdmZ2SUE2ZkdCMERsVUw5a3NZVkl0dVgxcUtGMWhLQVZoS1FncHcr?=
 =?utf-8?B?aTZFeDczK1c4L2RWV1FLR0xBZ3lpc05KdExGWWUveFlaa1p0TURyMk8vUjdq?=
 =?utf-8?B?RXVhNFFPQWVaSFpwbG9IWElvZW0rOExjZCtjb3N5bTYySnU1MzJLZ0dIT2NB?=
 =?utf-8?B?TnRVd2oyanlVUklrQWJmWjNJTmEzUHdkZ0tDV0lHSGVsQ1hjYUVBbjQzVWQz?=
 =?utf-8?B?QmRleFVTM3Vkc292SURONjhIRzdaZXlGZ2QvRjZ6ZzBRTFlqMWV6dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381d25ff-a62d-4258-b172-08deab20b0f5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:36:43.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZmjFh4qukNRNw4F4MqgXDT5DTIUepfzWKY4KzOeuGIbGWfId+qAeHfrytsxBDBYC3XZBMkB10g4JODZd/lKZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9648



On 5/5/26 16:42, Bjorn Helgaas wrote:
> [+cc Mika]
> 
> On Tue, May 05, 2026 at 11:08:14AM -0500, Mario Limonciello wrote:
>> On 5/5/26 11:05, Bjorn Helgaas wrote:
>>> On Mon, May 04, 2026 at 05:52:46PM -0500, Mario Limonciello wrote:
>>>> When comparing lspci output between Windows and Linux for hotplugged
>>>> Thunderbolt 5 eGPU devices, Windows enables ASPM L1 but Linux doesn't:
>>>>
>>>>     Windows: LnkCtl: ASPM L1 Enabled
>>>>     Linux:   LnkCtl: ASPM Disabled
>>>>
>>>> This difference in ASPM configuration can cause behavioral differences
>>>> between the two operating systems for the same hardware.
>>>
>>> A tangent, not a comment on the patch itself, but what sort of
>>> behavioral differences are these?  If ASPM is working correctly, the
>>> only differences *should* be in power consumption and performance.
>>
>> This originally stemmed from a significant performance difference that was
>> observed between Windows and Linux with eGPUs.  The link in the patch points
>> at that bug if you want to look more closely at it.
> 
> Hmm.  The bug (https://bugzilla.kernel.org/show_bug.cgi?id=221319)
> reports "instant reboot", which is definitely a behavioral difference.
> But AFAICS this patch would just fix something noticed along the way
> but not the reboot itself.
> 
> To avoid confusion, I would use "performance difference" or "power
> difference" when describing this patch.

There is a lot of traffic in that bug and similar eGPU bugs; but some 
people have narrowed down that using NVIDIA's GSP "causes the instant 
reboot" but the performance difference is tangential to the reboot (or 
maybe it's part of the cause - I don't actually know).

The reboots /seem/ to be caused by sync floods which I originally 
hypothesized to be caused by Linux using AER and Windows not using it 
(potentially leading to a flood of errors in Linux), but turning off AER 
from kernel command line didn't change that.

> 
>> I was hopeful that aligning ASPM would align the behavior, but alas this
>> didn't.
>>
>> It was still a difference that I figured we should discuss whether it should
>> be changed to be consistent.
> 
> Definitely.  I hope we can at least enable L1.1.  L1.2 is a whole
> 'nother issue.

Yup.

