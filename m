Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0C3D6477;
	Fri,  3 Apr 2026 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775250344; cv=fail; b=N/QDOI28t6pNEj+JNRg2mCCpIRKhBmDpcUBaf4ish+haloq3vXBfvEmSwnKo5p1nd6B+eIG8DfGH8xXFcAJ/fIq3RLzuUPkvgdYRfoh3lOBnJUUHIKV3XgoQ4hQtRZgPbo149ZlDAOlwhaOcf2byB5a1s4RWzz3xvyFgQaFRk3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775250344; c=relaxed/simple;
	bh=H39BHukFHxNqdVpRk2hB+dXtPDT9gBxMqeDoqNVOGtY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SlEP9lAzXvaDvpuMUq4t2OPviSLvgQsDLo0o5+dDHYEBemsKG/rxJgwg5c0afjcxC0ZIKu/yMJym8h7fsYcfMDCGGGOKjPiDdyVzX2Etfgp0qz1BslTNVlN7WIolV2JIfr4vSIWrB7s2oQ5RzLnTl1HF6J/1YeET1OwmfFpdehc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M8E+q2dD; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M8E+q2dD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBgb2UWWj4NNDXhNyvJR2iyL2R4sZvdORx0oBFkO6ILkNJjkUvgKraMRzLVylJ4fifcfg9uSXKGm7tEKFZPkEhUg1vu+p3Q880GglH3iam7E5LiQH83h+xwuzxLz6WsFqNBPwChLT7F2OL58ivqeZAjXBFxcCk7u+OyKFxR6fReWWtA9xJZYxgb1xZeGDQeY4MtBMAY8tpvKGZVIVrSkbKsXTDp9wqwUJevW8TU0PZPyvRySZJXXBq4cDVsNaE4jn0+vfp1pYe3kCmMmHZDAD9lL2ZZxm8YuvmiCIWG25/s9sUaAQJPArg6RtRrj4ZEL7gy8343UAZr154bdzDritw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NK9pp+933VdatiYJIjlA1WHFGVNpZZ4uIf3mf72CaHk=;
 b=I+yDuSReOOvZm76vHEqT36rcbKN4d3sg+zoM4d4FAK+7Ub4FmLMd45PqUyeVNfwMBwZ0ULn7oKIla71zyIxSjuuX4yzKW3EJ0EI7q0Q96Q1fvR3jDwumIi6hZ1xou1OaBGCWF5Y8OmmPbO+tsfn6uhTcYiPQPoBTd5s49AzVxX8K+SFwZ3tjYBoT0M5jvgnRfHG0+D4ivOtqPkXyAPQesV02maMqJaM0+j2I6hav0Uc15WsIu+oYRd1iUzJUm122MBvzr8hCnrwlCVGIYGwmtKSHbHKaLV49XsqA2Yw0Mz+BKvwpdy83u2RkyabbWOXNbd06Y80T9Doj96UVDLivUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NK9pp+933VdatiYJIjlA1WHFGVNpZZ4uIf3mf72CaHk=;
 b=M8E+q2dDTSFufx4AI11tBp+Gw8/wSNkIsHS9mOoV2YvfFRixAH6GoGXVDdi6QgqjfWUfbdeDPKqpOfZ9lwWEcH5F6WStUedRxijpAYE/8aZq7MWS2xrdMhJnxMb+Im76WK/I9FCMf9QcGjbsn+NAkSZnWAliRkG2SUZ86q0FZyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 21:05:38 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 21:05:38 +0000
Message-ID: <024bce0e-5bc7-40ca-be01-278ef9935531@amd.com>
Date: Fri, 3 Apr 2026 16:05:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts AMD
 1022:150b root port, NVIDIA dGPU returns header type 7f
To: Joyful Lee <joy@joyfullee.me>
Cc: Bjorn Helgaas <helgaas@kernel.org>, platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>
References: <84268751-a128-4cfc-94ae-588de5d98ec8@amd.com>
 <20260403180422.GA341023@bhelgaas>
 <CADj6jrg4YWx+iR0o=JSh23uP0Mb2Mvs-ngCJXGUAwCCUQGHM4A@mail.gmail.com>
 <d0994dad-4506-4b5a-b44d-3bb68aae4517@amd.com>
 <CADj6jrgEwySW_A=-0o947aGg+CmaZD+qR4NnopVFoQptdHz=bQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADj6jrgEwySW_A=-0o947aGg+CmaZD+qR4NnopVFoQptdHz=bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:610:118::15) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 219075e9-f2ec-402e-b195-08de91c4c1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	trEIMvmc9bRql2RKVwPbjlYvme6QEh/qHUMBLjUSqhQC0OUuySqdroDB7E8d38e/4K1+aL2dU2uEMy/OZts9bzhTmskN2A1NXDNUn5+k6HqhSGaDyX4rhYm3JlPzpdobFtjg9mshWHOTMfsVYR+m9G4S6DITCegWF00wXvEFAT0w4k9Z0tsg/JYZ9j3JzrvG6OJl47FWQj37C3ykvg8CtO8D+mDR6yyfDew9lhP4LHzekPJ1ig3CQvQwAT/6+p8ZHn2X3zxD1O+6kf+uXrBCWzw0jGQg3qhIJfm2lzGgy5YI54cknz9I/CMZEWAEQyKOM2rSBRzs+98H41eZ6Z78qbYaG7ZeqfL9p5qpGK2nL9PWpunLj/sq0V1psJpQmDti5Or+74nC0Lj1+edPpecNfNLZXLB/e562ry3U0h9pOxxidnlt9s/pwHxjv4PoHxFDM96Jof3A2eEGiIl0u9j8Tw1Cfzo2MFVIcZnY0lQcqjEYinVHhUA9Ee7ch37Z2i1BRFQFTsGAOoYHgFo4qCODXs9nDsQsr8JxwAVTTypIOPNl8nbGpJRBnN7U5h1/qYb8SGK4r+fq6cTWGd4Hh1hHKgqPI9a3bRZTHSiDM7sZeZK765Ixo73zHbSgw3vxi6TS4JDYDtu+0w4ZDeRhqkFc7Ih4VGm4vrRpiY6kG/p/dlGoOiooammZm0G6CHbPvx/axq/HFARJAZfUigQyYajLSJ2hy3PBMHWc+OwiAMpvMRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkRNNzZFaHdieTNVNW1yVnBSNlNxeG16QnNqZnV0NG9wNTVTdm1vSWRvM3VK?=
 =?utf-8?B?bW9VN3QzOTBlMUtGKy9VZnNCK2R0dkZIcUNHNTFObUJvSGFKOUNaUjVuTnFS?=
 =?utf-8?B?ZEQzMnl1NENXUWd6czJFM3gvTmsxVG9QNlpEbXdzS3NSekRCYXFmcFI1MDUw?=
 =?utf-8?B?YStnVy9zZUlZYldBQit4bDY4SjVhQ3dZVFduRTBON1hOUXpVY0tyUmNKOGQw?=
 =?utf-8?B?eGNjMTVYM2JrMTFCbmVuSitTYStPeGp0cnRiTHRwSzhPajMvR21RSkEyMUJZ?=
 =?utf-8?B?NDVJWGxpN2FjMGtFbnBzRTN0RzE3L2YzUjAyOFc5UzJmOFhPeDZMMHV0YVJP?=
 =?utf-8?B?V3doV2ZvblJCVGU2ZGgvT0M2NEhpUE5TTzFZb3kvZXZtOTZXWXR2OVRqRWdV?=
 =?utf-8?B?RlFvcmJETnF1T2J1cjZ3YW9VN3NIeUU0NFFUdHR3OFNlZnNiYk9aSlBVVU5O?=
 =?utf-8?B?TDYwVjlTWk4yb0VCRkNFdXBaYTUybzRJU2hOK0FoMDRONkdvLzFwcTVGUFZq?=
 =?utf-8?B?eTZOam1ZMGhlZVJ1cFVhTFlIcUxPanBwczhmVWM5QkUrcC9IMDBlRFBwSU5Y?=
 =?utf-8?B?TWFLOGxqbytkRnVNKzlzWit2TFJ0d1NQNmJRR0t4bnNIVTR0c1c4NUk4S0hu?=
 =?utf-8?B?WmxoVFd0cXlFekFyS0lRKzFjRVdEWVI4L05QVWVwVS9WY0RsNlNpb0dMSmxJ?=
 =?utf-8?B?TVBqTmtOT25ONFRnS1g0RHdINStTSkdCTHppQXVlUFVhQitzN2tlTVFrbzdY?=
 =?utf-8?B?VDQ5Mi9CY1RjazdFVzBiSXJ5NVZKVnBwVWF6NWdTaHk4Mmo3eXE1d0w1STI2?=
 =?utf-8?B?emxwZnpWM0JFdC9ndUhLS3I1RmtLdk5pV1p5ZVdZUTFmWjhNNFFGMDRQL0ZJ?=
 =?utf-8?B?NGZva29uWDloeHN3N000VFR3bCs2MFlzSjJGRVJVSUFWRFJWcWVlZHEyL3h1?=
 =?utf-8?B?eDc4bkdxYzZXN3FtM0g1emI1aER2L3ZnSEdqdy9hdklxRjg3MUJ6dlhCNEZm?=
 =?utf-8?B?QWZmQ0lEdnhMQlNwTDNoc0EwcnZhdnFUb0xKNndlWFRvYmZVNmFWZ3hGb3N3?=
 =?utf-8?B?aC9ITUFSME1pWk1tdUI1NGFmSDFYbTcxRlh4eE1VdzdOWUFobTkva2R5Y2dY?=
 =?utf-8?B?cXJqSWVVYmh6cjdDaDgxNVdZNnhJSmhnbnc4cnJtQmFxdDRpNlJkQWtmZWxR?=
 =?utf-8?B?TGx5QldDUm1HVFkvK1ptVzNOa2YrUStiZXc3RlhFK2FldERkYndaQVNwNThY?=
 =?utf-8?B?R09zYjJuSGk2bHVJZ2plWGlWTlZsOE5HNmk2c0FPdERPckVnWk5oenJHNHc3?=
 =?utf-8?B?aWQvYy8wYW1yTzVxOWFaVWVmMVhYL0EvbC9CMDJhZEE1UmNzQkZOMW5SSzFY?=
 =?utf-8?B?U21RRGU2TFJRcUdSd0FPWnQ3dE1MRllNdnhOZHNndTdoT0dtMVlsVTJRL3hk?=
 =?utf-8?B?a3NjR3FEUE1zRGYyVGRNQS9zVkllZDJyWUwybGVyZFNyc0xiSEs4aCs5WDVp?=
 =?utf-8?B?ZUVMZWNnVm5ic1l2WU9PenRTemNwb2Q2SjRkS1c1VUszL0FMTnkxMGw5QTIv?=
 =?utf-8?B?Q2xLb2FvWTFlMFZ4QVY1OHdpWVJHOFpWTk5vb2RhczhKa3kyZ2RhUWpmSjB5?=
 =?utf-8?B?dHNTaFRjb2ZCMDkzdWd6WG56UFlZZUpQMjIrY05mVWJIakVxdTltbml4aDFP?=
 =?utf-8?B?c0lpRzJHK245K1d4bytnVG9XZjFPOEo5MVZad2NYNXBFT1RIWFJRN2hEVmhZ?=
 =?utf-8?B?WGFPbkJQVzF3VENkcU1hTU0wTDJOZmpsZmJVQVMrTGN4MC8yMkxFSENvQUVH?=
 =?utf-8?B?RzVlUThMQXpHcmpzYWE2ZUZaNlBnN21TbWxyQzBrbzRyby9KbGx4SVpLU3lO?=
 =?utf-8?B?TXdLZnFuNWJub1JBTzhURWFYTW52TjAvYmRnbHFWN3ZOUk1DNDJnNHlFNGd2?=
 =?utf-8?B?TWdzd241OVdkZ1dnQUpjc3FVN3BzT2VwbHVzaUErUVQwUmw5QVBxbGRLNWdr?=
 =?utf-8?B?WkNORFdGNUkvZnVkV3lCZm4yQTIxYWVmdE9jdlN5aWNVTEMrWXp3WmVUdVJQ?=
 =?utf-8?B?L2tmSnovWDlaVTJRaEZVbWpSaVFiUUlIUmswS3p5Q3NBLytaS1RnbFhiK1Q1?=
 =?utf-8?B?YVE2OTNFK0NhOFpQR0RGOXo1RCtsUC94aEdvR2MvWGEvVDJ0Y1gvL3pXaE1X?=
 =?utf-8?B?V1NpVnRvLy9xRktYcWlqRlBrdSsyVVl5aHF4R29vbjExS3l3RndrZUEyY21V?=
 =?utf-8?B?UkF5M2pWM3IzM3pLZWIrZ3FjZFA2akVvYlZ2aGIrNmVWSFZxSnpIMktOMVo2?=
 =?utf-8?B?K2d0Q29sT3FDTitPSjMwTGk1SUtZUlNiT2RMcW5xRFRtbnRiNEJLQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219075e9-f2ec-402e-b195-08de91c4c1b5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 21:05:38.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLn7A5SCKvoXIkjZzfgSZFAZ0t/4A2l+N2qtZ5oOz9GEDNJDq4oh3DvxB7bWy3ZErnLJP+Iq7fDpVApsTS0yaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473

On 4/3/26 3:47 PM, Joyful Lee wrote:
> On Fri, Apr 3, 2026 at 4:03 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> Can you do the exact same on the same branch/commit but without pciehp
>> enabled?  It will make comparison of all the impacts (not just this root
>> port) a lot easier.
> 
> Here you go. Unfortunately it's not *exactly* the same because I had to
> disable the nvidia driver to get a result.

Thanks - the most obvious observation is what you already noted - 
without hotplug support the root port skips PM all together.

[24.575705] pcieport 0000:00:01.2: PCI PM: Suspend power state: D0
[24.575707] pcieport 0000:00:01.2: PCI PM: Skipped
[24.575709] pcieport 0000:00:01.1: PCI PM: Suspend power state: D0
[24.575709] pcieport 0000:00:01.1: PCI PM: Skipped

vs

[29.279987] pcieport 0000:00:01.1: power state changed by ACPI to D3cold
[29.279991] pcieport 0000:00:01.1: PCI PM: Suspend power state: D3cold
[29.280214] pcieport 0000:00:01.2: power state changed by ACPI to D3cold
[29.280219] pcieport 0000:00:01.2: PCI PM: Suspend power state: D3cold

The hotplug support seems to apply to 3 ports.

   0000:00:01.1 (Bus 01):
   - Slot Capabilities: 0x00040060
   - Flags: HotPlug+ Surprise+ LLActRep+

   0000:00:01.2 (Bus 61):
   - Slot Capabilities: 0x00040060
   - Flags: HotPlug+ Surprise+ LLActRep+

   0000:00:03.1 (Bus c4):
   - Slot Capabilities: 0x000425e0
   - Flags: HotPlug+ Surprise+ LLActRep+
   - This port also has bandwidth control enabled: bwctrl: enabled with 
IRQ 38

The port stays in D0 because the child (the GPU) stays in D0 for suspend.

   [24.599889] pcieport 0000:00:03.1: PCI PM: Suspend power state: D0 
  
  

   [24.599890] pcieport 0000:00:03.1: PCI PM: Skipped

So I would say we should look at what the GPU isn't going to D3 for 
suspend for the next clue.
