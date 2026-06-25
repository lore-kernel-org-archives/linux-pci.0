Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E06320E023;
	Thu, 25 Jun 2026 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782428332; cv=fail; b=hnhWGe1/QmddZY05LnFRD7l5CHz12xdDdaiWxcTVsU9njZd3iQHmOpvaxkVI6xamDv0I/lfUxt5b0HsF+8BfuD35DhzuG04key4IxvS9nxaprqLy8DNi7exT/1C/bCUOmpaSE44uqEvz5OW4U85v2FgA39JzJIvrvsGgPgmeauA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782428332; c=relaxed/simple;
	bh=s0hfclDZpQiPLLDqNgWI8Ffij+DJN9Ekj0MEklcJ6/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WJoLxyPgA2OqkurTXgltnjlOnGkVEKmHvYqN5+hAaAAhN4lPmksqP6sLbrCNHlJfCSZxyry6fwam0GEShDGFs299bxEwdEm6ykvNjO/YafNVznI1mVtm0kMzPl1WlQG27PxkMVzCRm+B0h8WVdNDr3DOYMYy0y00AHjiM7/5RLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kz9e4c1V; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kz9e4c1V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZICNKm6XmVvtmZMtMkMg4/Qn0N3wEYL+1VLCIBBIHfekw3NQyRMg7lKA9Qy/crugCeFhbzKKurYXcM6ckk1aBN8DHDgFcvg32iPuteJAsbXinXJ3hICWN2oHzgxgqmFXxzdspvC/1aQtK99xki39pgQ6OzdXFf0mjy1ZO2SeYT3o/+WNT7GJVON7q5PctjtZVO5OMsc+SeywpErqpoh8RLRDOS2JePbAt3z+rp40vvuRRICmawusmg0/KB/GNuBdCO6FoKJHN3rqrh3eN2bAcrSWqWeL2C8hUEgpydshrbSdzuO9LC+tbMZxuEx9IHO7aUcog2cDaQQOPUJk95aziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EQrm1TbuOHyStU1RowByPLFsKvXnQ/gjpuwQjidnF4=;
 b=AsPrfgHY3UAWYaCjcKhB5qSKA+EDPnM0zuXJsCuM7/HQx8O+s/doVsRj/zU07uXusJwTT76+56q+gMbGedf1bfm/z3pPXFiYUyhOPA18PaR8fPfNvCYemfnJuQBl65lobIjolDt0OWImsRVqo4qHC6GAVx8m/vGMd/g9RH8HavUbkDJJRy5hwgJeso/GIjBUD43vtSfsDVeLjv5ZLl8Qvmmj3jOfw+sE1IoEcC2AW3W2stpN6EyiQb1cpGRy6b020F0MTUcD4zy6cKu0piyPcCfhUiPGp14bHAluJYr+hV9/Cuu50XUzr4gYJRSnp8dFW+dIWGP/dMDQZjRof77+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EQrm1TbuOHyStU1RowByPLFsKvXnQ/gjpuwQjidnF4=;
 b=Kz9e4c1VcQTXYnDyZOo8FVq0LupZl7+Bpqj+//emdKqe7r/p81n2NsKJ3onXamwkTIPBRubHvKih/XovCJpFnL9L6fblfxKz1MJKwhKb6T7M+wUi3JK84Elkg0DJct7EZ7R+t7rOjIGJYXCH3U2UeD1QmBy/Cq4GqRLH2v1YnQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 22:58:47 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 22:58:47 +0000
Message-ID: <5ef1c84d-729e-4b9d-a3e4-dc20d8242982@amd.com>
Date: Thu, 25 Jun 2026 15:58:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/video: Only fall back to vga_default_device()
 without screen info
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 Aaron Ma <aaron.ma@canonical.com>
References: <20260623141505.1816786-1-mario.limonciello@amd.com>
 <CAJ6xRxWBtaPZZ=SVff2WVE+B2c+fMJ6vTTracHU4BqH16ROXeA@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJ6xRxWBtaPZZ=SVff2WVE+B2c+fMJ6vTTracHU4BqH16ROXeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::13) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cd3dbd-3517-4e65-741c-08ded30d508f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|56012099006|4143699003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	sK3TLBjXzquLRg0r6fdGiyGzbWgZTwZ4V/95DJHVgdj6rxOOdVvoYNe44ywi7XZqpEtoR6cjLasXkhJMnD05ZjlEJd56Gij9YxER0t8sADkRS5GxDk139qfDhQAaEPhCRPuvdgh+RLQBRVoOyv4V45iEKMrktKbyK30NtnNZlbpUym5Nx7EWEKy7LmmlJ4Ybhn3ciKXo6OPzKkBSyltJq5iAwFOYcje6zZBqKpWgQil6wF3qppuuWHk1BqKsIFmRJloKeqiY8yZQXif9QTTGA3mYRJh02m03h6cr/gfztRfR4XkXZu4cPPU3wuWL9J6u+yq33RUcMzqL4CrTz1OvNAAFLFjtCHq9bKgAO9Z4n+JJGKamMEK6x4bta+TvGk+8MRHS0F505lj0E6giFm/Qw/ABVVM/nChpDjnWDfln+UBmbTMM1zzRwohBFvOE5cC40H+8LnMOu9SDpeNAltGdSzH1z2YiHbg1Ws5hjZmTddWsbxREgHzUv74E4uQ7pz63Q56hPCGXEKyWxEgcow0Wa4g4t3SubkSDTAQD1B8vBMDXv0TY9vdGWEUDnrrW5mtehCrLX+J2Tta0U/hAvBHHujlRk5IsKd5CRZNFjZ5kSXcDMzJfXmR+jhUhsHEViOPYvkVkBCnOnBrDyH785/j/lS48z/zAYoGu4I28IMm7t8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(56012099006)(4143699003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2l3eTBNemtTalcwQnZZa2JFMnNDZ3BFeW1vS2xUWjBvK0ZUS3FwL1BtY213?=
 =?utf-8?B?aW9tSzM4THludlBBS2JtSWFRenViRVJQcTJsMm5xbVZoRytrSStGN0F6azl5?=
 =?utf-8?B?NStXVGYxbkoxWTNvbnQwOUs5RE5CTVFjcUIzSHV5K3VvRVZsMTVGL1N2ZURl?=
 =?utf-8?B?c0diUnpBMEsrYnhOZzNSWEcrM3g4K2d5TmxUazViZWVsM09HNW5CN3NVdHpC?=
 =?utf-8?B?WDJhSm9HRzBXdFF1M3VKNWNjQzFwcmg5RjkrNTlSeTVDL1A3blVwMG9GL0Nh?=
 =?utf-8?B?d3hOMkZGT0ZBMTZmNmtMNFY0bVg5SGtUVDF5VzArNWlGNVZkRlNzbGRUR1dy?=
 =?utf-8?B?Rk5rSXl0a2RMZnVQWC9BN3JDT2F4cUtJWTdIci93VTFINnhKdS9nQitEeUxL?=
 =?utf-8?B?bjRLVzNPMVdkbzJNSU50ZXFMT2lNd1h2V2gwdnh4dGRDaVkzTCtaY1dXYVhY?=
 =?utf-8?B?WkVoVFdPTi9GaGFzeGcxTmZGMU5iZkJFUDhGK2tJUHcxR21KRnpZVSs2bDBT?=
 =?utf-8?B?cDhmQ1A3bUg1OUE4RTd5S04xWERkT2tocWNGWEkwWk9PT0cralhseVV5QnFF?=
 =?utf-8?B?MER3dTRTYThabkFsOU5aZXNTQVRDSVhqT3AycnRsR2xrYWIrWlIxYkd5MVU1?=
 =?utf-8?B?cnhrL081ZTl6QWJTQVNRM3ZuZW00cUordjN5cVJ5eVV4cVpKaUJZcll1N2Z3?=
 =?utf-8?B?YVdLT0IrY01FK0ptYlkvVllLcVlkc0tmOUF6NktVcFVLOWFOY0hQVVBOcWxV?=
 =?utf-8?B?RXg0Q0RpS2RQOGZqOEdpbjllQ1g5d1JaQ0tWZkJzRzRFUmFmNWR2NndsdGFY?=
 =?utf-8?B?ZVQ2bUFUTXRBS1R3R2R4cWRLT1l6OWd1U3VZazBGZ3VWclg0ditvakxRcHZq?=
 =?utf-8?B?YlBEMjJPMk5CZVJFQXFNVTN0RmN3d3IybXNkNHIwN0NBMHVEdkk3QjIzV3dq?=
 =?utf-8?B?b1dUQjlSOEhMR2tMckdMUDJ3cjdndG1BWTRQR1dURXlFeWY3ZEt6akxFaW1s?=
 =?utf-8?B?cDd2V0puY1IydW5vZnNvNTdCeUswZjV1QlRHZVhVWWRjeWxieXNjN0Fud2xt?=
 =?utf-8?B?MU5ONHhMa0ExQ20vejkrU0VGb1I3ZTR5MkVwbU12Q3p1L0k2MzVrbTIvaDBW?=
 =?utf-8?B?bjFGelVDNDJFd3F5eHhFT1c1SUFROUhXV3UvY0ZnWXNENnIzdGE2UExLT1NV?=
 =?utf-8?B?ZXlndStQTjR5RUVNNkZWa3lYZFZOako2bjI0c0w1T1BwRVVhZ1QrTGwwRVBX?=
 =?utf-8?B?L1lhYnlxRW9MNElkUnc2azAycktFUGx1SU16SHJNcEU4Z3Y1ZlZBUVJqQ3lV?=
 =?utf-8?B?M0Y3WVZ2MWZuRVZXNEVUSnJqaFlSRCt5bStMTnQ5ZXF4OXdvL01LSjY2SkZF?=
 =?utf-8?B?em15VldINGdPZ1B0TENLWGx4M1dtYVNFb212Wk5Ucmh0Qy9LS0hodzRXYmx3?=
 =?utf-8?B?SWQyVFA3QWtWcVZYQ0MxTXQ5SE1ZV2MydGNTbG1NUHNaeWFKa2grV2VuSHNF?=
 =?utf-8?B?ZjNoSUpoSTNWbzQzcEg2bXVtbnFqdldMQkNqcUM1WlZSZVZSeVdVYU8rUi9L?=
 =?utf-8?B?dENXUXVod0xTMkhYUmhyYzZWd0FwQ056UHFndnlyUGx2Rzk5eG0vV3R4dU90?=
 =?utf-8?B?aWJzSlh6dU1ialhmdkROb3pTY2I2ZHhUQ2JnWU9SOFVYblZqdFdkRzNKaUZn?=
 =?utf-8?B?SU1JU29BQnlLVFBnckRCaWZDYzFiK3hHQ1h6T2lhS3F0NzdXS2pyVXBqY2tt?=
 =?utf-8?B?QTBySXpTQ0FDdjZuOGFpdVlFOFlnUytaNHEraityYklWL3RZVzk5QXZqM1lu?=
 =?utf-8?B?dU5WYjFwUEVFRm91eUlCK3AvL044WTBiRGk2dHEvaGZmV1I4Q2VSSUNQODZt?=
 =?utf-8?B?OVlQQTJLUWlOUkI1TExQR3ppQWtKL05mTWwvOE9CNTF3NHE5Wkc1TkxtNFpF?=
 =?utf-8?B?SHhBSDZwUFdFM2tmVjhka2lBbEs2QkFaMlFlck5tdDBzbGdmS2tJTi9wdUR4?=
 =?utf-8?B?OWR1SHhLbmlELzFKeFRwZ3RscTVjM1oxYVRLUVlOOHFGZXR1YVhuZU9JeWZT?=
 =?utf-8?B?NGNQZ3VXQTJYYmJXb2xkYXhsUVVDanI5TDl2N2lpSW5vWEFJOWlXQ3UwUWhB?=
 =?utf-8?B?ZmVIN2pWOXJZVk5zZlJjRHFLajErMHAxM0Zlb3l5cXRBRzRpY0pXMzhnSlBu?=
 =?utf-8?B?bXdzSWxpQ2hXTkNLakJvTlZnYkxIUlM4eVRhQldDcXN3dUt1Vlk3WU5LOFVr?=
 =?utf-8?B?UEsyN0Z5NTE0enhHSUt0R1BNU2JJWk9ENHFvcGtoTzFJUHBmSHlrZDd6RC94?=
 =?utf-8?B?dERlVGV1a1JKc01Ld09lcHlXUU1IY3p6Z1FBaXU4dlI3SlhlQ20rZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cd3dbd-3517-4e65-741c-08ded30d508f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 22:58:47.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BIswv7gjwpQ/vOTF3GwQfw15h2hHfYrUOaZUNZE+Fc3Zk5vUqkIQ33stDP4q7eNRlaVue4w/FbKRpCeXrcuZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728

On 6/24/26 01:45, Aaron Ma wrote:
> Hi Mario,
> 
> Tested your v2 patch + Xorg MR !2242 on the hybrid system
> (AMD 0x0380 + NVIDIA 0x030000, EFI framebuffer on AMD).
> 
> Result:
> 
>    AMD:    boot_display=1, boot_vga absent
>    NVIDIA: boot_display absent, boot_vga=1
> 
> Xorg now picks AMD correctly. boot_display is fixed.
> 
> Tested-by: Aaron Ma <aaron.ma@canonical.com>
> 

Great news, thanks for checking it.

Bjorn, can you pick this up?  Or do you want this to go through tip?  I 
can see arguments for both ways.
