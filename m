Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18CD28488F;
	Mon, 31 Aug 2026 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162588; cv=fail; b=etJMWd1AgvCruSSjf3vLVQF42H9T25aSJmaTy2xkO3Q9lctAdMZ+YFf3SocLgG7FYcg/Yb2dKzSvXISOh8oO4waxhXQdJe0hm4aMzI+Ii0M+isAQBZhXI3X8Hu3bZWHJsSsS+wV/Akra/DmFb7BHv8KBdgeHVZdRWoEILsAGIjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162588; c=relaxed/simple;
	bh=7Ct7D9cUFELK6OxpcQtnhlsLfJhMPB3f/nNgSt73dkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mwdQ20QBkL5M1oeo6K3NOX7r7ShMK4MvJ6C11LYJllxN2m8PHbRglHiFtRTX2FqCR0QKKkxwQJk+K2+TE1Q6zNRqAshr1g/iIQaAMLgUIuQ/eNUapZK7lYkRy3ZDLnCpP3KLD9IkDIQYZ1wxnTZ4saMcKjwvWKQjxumz+k+lDlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v8hZtRJt; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v8hZtRJt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4obetpSTBnM0UwWQRvwzL4yHb/dGjCcGlMa4w3XbKMw+LLI1TXpuklBWlawPuGz87VUzsxp1eOhOH0CmsAENptRauWpTgYkpGoForPo5iYgsFsFupiLGOWiMYCE2A54tne6pIQSEQabkse+EITmS75VFpN/VgT8OSjmx0AK+uoarL50I16hbttQEk3NjGG3WSEROcAz73sYQkM6nQ5zmhI9hBlKarWZfCn0UUiQMlqP5nrEai3/CF4SyUNxDL4IUBP9KAg8l/v7JNXHNB4CINXYNMb9GbEyV2kZsxmkobsd1HTBG9cTT6Noydgysq4430ld1K/KGOfjZeL8VKSeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBdKIKO6z/9LVS5qwiSAAH6hFSfChMd6t83X9CKwleI=;
 b=HTJ5WAru270Gt3CJ7r/FYqpZmKiCtxKkW8Sc2qafsDTzslfDwjCLuULL3qQDzsqgDOjSuo2N37RHU9ht4Kxkj1gR82ABkExqf/5V2H2fcvitavoNs6PwEGSsgMLWqGj11Dtvdnf7o71AzZgFRzYz710bi86Jte2RC47R+/QFyQEJnXiMyamd0izQqijaDEDPN/GZSB1xLCQrhnQsX5l8Qe5XLf6EI1jtUHErIkZLLHqZW7pNe/kpkoZbPcibs54WNWHPZeRjBwA75oswT4pnpSLyJaTG6GGfT6GmbHYgAMGP9I5Sx3N6i6TwJhrfekilMk5myZLWZUkz5AQDokCduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBdKIKO6z/9LVS5qwiSAAH6hFSfChMd6t83X9CKwleI=;
 b=v8hZtRJtGmD5CEO4cpQ9KsqSkjtt1MilJhJV/Pjp/OQNwcK7EcGCRReeL9M9NQVPlwr8CgC0WaWhUk522Ktac3YP5iABTlGd4d4lqh5mpSIEieMNO9FjpdRSnIuNMvkWG7ux+knVRoee9gwuiS2qTYpV22x14+n6tHXsChRKHlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:49:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 31 Aug 2026
 07:49:44 +0000
Message-ID: <d4c3ea40-d92a-49c4-ab2c-925fc70c4bb9@amd.com>
Date: Mon, 31 Aug 2026 09:49:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Reserve prefetchable window headroom for Resizable
 BARs
To: Geramy Loveless <gloveless@jqluv.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: alexander.deucher@amd.com, ilpo.jarvinen@linux.intel.com,
 amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com, nra3088@gmail.com,
 meiling.leung@embeddedllm.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 1927b06b-cfa6-4c64-5866-08df07346bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|11063799006|5023799004|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YJhOLFOMr+qe+oFjEGpnB5Ko6B5Hxw/rlblf75TJ19tJ9rWnSLS1Zp8lDGFCCGRDLaJck/A/Gy+5v1qYSoVCO4lezAPyGB/nSvPw8ePZ3KulcVnI1hkU/azKwc6fY7CGLnJODLISqFZ6DoajRlztY80ErT2Bxm+nlJurg/vI3KwpamtVTUT4voOesJwzyz4zjEIxhIDXNfiuAuynz0N/Cw3g0RbCfGNRgFdbcM2WD9ncnip5DuRy9KMS2S8rU/X1WZbJvrJ/SeUVKRLFUpVufV57CO4FXzwNweqJ2QIxArS7DHiA5jpvF0BoQxY+BNkUZOMzej70N9xQ6KCcE3hZ7BfgZMaKCOL7EE22JlDpATRbhyyfMb2BkUqFGd9WB7+ZmTVFN8GPhhnNvTqGOVk1RbRTcWeGmOZF8JujRsRnAlrsqODeSkF0ixucEVUdhUk49tGJZvzHUXUYDlCiSi2q3k1gvInRpEYwpS42FPldAoZnqIyJCBfFJoWQvEl5zx4uBmAT9p+PmEalj61AnYdJKiOxazkn/7NvPoxdv73znzDZMt0xfUsdKrDTnbb/ObiywQmNbqJfI+lnOaBxkT3X4XEtox3PrCOqSQD+sLSx1/WWX1ehAm/crWUsOIfAtax4UjvQg0KSV34xBdGCFxDzrkAPwffDqbWiyG3WZvmrLyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(5023799004)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDNWK0F2dTZpNkd4ajRQeE4rWlZXTVVzSmtSMVZGdDlhdDNlUWpseEVET1J5?=
 =?utf-8?B?d3FYNXk3b1A4MmsvZzRZa05iWUdGN1M0NjVUOHpCMFdjcFlFTEJvSkU5cVFt?=
 =?utf-8?B?bGx0UU1hdmtpK25kdi9FZTllZmU1THR0RHdGcEYxKzhScHQxc2Z6MGhZN3p3?=
 =?utf-8?B?N2tqRFVSaXhKQ0Jib0pTNnBWWFp6QzJKdThaRmthWjJZN1pnRTBNQjlHNSs3?=
 =?utf-8?B?MXhzUzdDN3BiNU9peE9xY0p3OGJSbCs2eGxnN3lBRUVWSjU5TUwwbElUMXZj?=
 =?utf-8?B?U2J2ZENieElGR1JuVWpTUDlmbnQ0R3VnRGVvY1orQW5sSEVDeFNBVkcycEJz?=
 =?utf-8?B?Q3RWa0NUbkhNVG0wOWUzV3dpNm5DUTFHczE2a1V1aGpjc1RjMmJOZHd3aUtn?=
 =?utf-8?B?cmx0NkxZUERqUWRzaUNlQldGUkx0aDFVTW16dHE1M0NXYTdtQU0zaFRacUha?=
 =?utf-8?B?WWVJRExDRitZZ1VTbjhzcDd2dTRyM2dzZlRpSmlPVllIeURKVUhlRThSWW44?=
 =?utf-8?B?eXpBUDVyKytzY1RhWHJKOVZVTm9pQWZ0VUpRb1hYTndEWXFQRTlOMXpNNk5p?=
 =?utf-8?B?WVpaTEJzbEh5V2JJVzhiN1A4cTc0c1R2TEhxSjQ1b3lVOThBUFhKZHdVSXUy?=
 =?utf-8?B?OHE3UmxkMkpnZmNUbGJMdWcwNnE4QjBnZ1ZNV1AzdFdjTnQ3NThrZGxVQUNM?=
 =?utf-8?B?SWNXdXMxUWxRSnErK2VIUCsvUjR4bW5ENDBZdHJUNFBSVUxsL08xVUhvVzJS?=
 =?utf-8?B?SEhIQzE0dFRJaXRVcmhVdUxXWXJzQlNqNVJnODl3dVRkRUExd01UL2djYXNp?=
 =?utf-8?B?bFBaM3p0V3hxTzJreUFKVk5UeWJZemJYQU9ZUzhtUkZsOFViaHRWazBBcHZo?=
 =?utf-8?B?RW94RGpyZEdsQWZlc21XNWlpQmNmVzlyUW1HSWRpY3Q1RXhrMUtRMUNaR25Y?=
 =?utf-8?B?bFZmZGw3QmpKYVlVTmRQZHFJazdDVWYybXJJclQ4RFNwWVhrRGQyTmd3MnFX?=
 =?utf-8?B?Q2ZDeFh6V1V4MVJQSmRXWVVsUE04RTM0ckNYd3FrZW1XLzNSdjlPc3lvZ2cx?=
 =?utf-8?B?WnBkTjA4NHFrdHVhLzUzVVVLSTBwUnpjTU82WWY2cWhaYmwvTW1GVW9zay82?=
 =?utf-8?B?RkVZLytmRUp0L3lvbFJUTEZtYmpQaDF6N0R5NGY2b3pBMUtzVC9qeldCVUZD?=
 =?utf-8?B?K3JKMG13MWJ6L1hya2dxSHhDcXhHSnhCU3RCN0dyRlpDcG41MEU2UzJtcmxU?=
 =?utf-8?B?MnhwaVg2d1VkSkhyd0M4QzJ6Y01xRThhM2ZmMS9VNTdEa21RcXVPWGRTUHFp?=
 =?utf-8?B?Y0lKWWxIeHVtSXhvNVloU0hUQ1llQ0IydjdTNnhPSWw2Tk02TFhwa2xWYWF2?=
 =?utf-8?B?eWw1QmFlSEpQcS9OZGtZVzI3R2k0aTl6Mlh1Q2FSaHhuWDMyb2R5NDkrNlAv?=
 =?utf-8?B?RFd0SzlBYlNFckJFeG1pcnlTSGwxK0Rpc2lud0FWbEU0UGhKN01vRVd5YXlj?=
 =?utf-8?B?Mnh0bWxFeUtuTnpCSjBWQmxxZlNlektyZWVxbXlZTEhUdGhycnBiNU8rN1pV?=
 =?utf-8?B?STJkaUljN0p5TEdoRWQ2ZUExdTJ1MFNIUDRTM1BXbDJpL1prY2dVNnliNm1s?=
 =?utf-8?B?N0h0cWNXekM2WnRoUC9sRmptS2ZHSDh1S1RwaVFaZW9WUkgxK0JGa0lGRmM4?=
 =?utf-8?B?TEErTUdDMWVHT1ZHVHA3bk5hdTFQZWprV0MvK2NQUld0TjN1OG9OQ0V4MzRV?=
 =?utf-8?B?bWZEN1FhUTVuVU4xSUV0NkFuZS9nVUdCSnNyQllPTC9HVytlWlB0K2dSQWky?=
 =?utf-8?B?cHptT2s1bnV1OEpMYys1ZzlxdXRUeXJHQ0tBMitHdGxka0wwSkxMRUdtcytJ?=
 =?utf-8?B?c1N2LzlxTGNIQ2VVSW00ZVcyNEZMK1FyMlFMc051T0hndVI2ZmJlczlrS2Fh?=
 =?utf-8?B?WXZZelVJdnRYbko0NDc0TjFDbUh6bUp6VjNJQ1k5bkNBSkNsbzR3cmZjd1dw?=
 =?utf-8?B?ZlZVQjZwVlF0L2E1dTRVY3pYdXlPYVhaYWxoYUVDWDdUb0lVQU03ZFRwS25K?=
 =?utf-8?B?VGFEbmsvbnFtSGtWOGM1UGFtRnNxOWw4Ukd3UDdsOXhaekdkYUdkWXRIajJp?=
 =?utf-8?B?NWxZUUVLMDF3dVFUVDMwemZMUW9Vdko4c3dhZ3dZSUNrWjZsUFdQTHRiYWI3?=
 =?utf-8?B?NE1PSk80RkFNOEtvSzVGMU00aTVyRlBXT3U5OUFoN1doQU1tNXhQd2h0Tlgr?=
 =?utf-8?B?QUpZdDJSSWpxTDJ0Q1lkaFlqSUQ2OTcxK3dvYThMdUVvNWxDV1I3Z1JGOWJv?=
 =?utf-8?Q?F6kBztbhjfDTFDHPiN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1927b06b-cfa6-4c64-5866-08df07346bd1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:49:43.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr8wBFLcbyQxDlK1n2UOXg3HmSVBoFXklS6R4R88yMM9C+piVOLfSMJvp0O1ow3u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945

On 8/28/26 23:37, Geramy Loveless wrote:
> Firmware typically sizes prefetchable bridge windows for the boot-time
> BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is then
> no room for a driver to grow a Resizable BAR afterwards: every window
> from the leaf up to the root is sized for the small BAR, so
> pci_resize_resource() fails with -ENOSPC. 
> 
> Furthermore, a small prefetchable BAR (e.g., a 2 MiB doorbell) sharing a 
> bridge's single prefetchable window with a much larger one (e.g., a 32 GiB 
> VRAM BAR) pushes the required window size past the large BAR's alignment. 
> Because bridge windows round up to a power of two, this forces a massive 
> alignment waste (e.g., 32 GiB + 2 MiB rounds up to a 64 GiB window, 
> wasting ~32 GiB per GPU).
> 
> This patch solves both issues to enable ReBAR on cascaded switch fabrics:
> 
> 1. Reserve Headroom: 
> Reserve prefetchable window headroom for the maximum size of each 
> downstream Resizable BAR during the bridge sizing pass. The device BAR 
> and hardware ReBAR are left at their boot size to prevent tearing down 
> firmware-loaded state (e.g., AMD R9700 PSP) before the driver binds.

Yeah that was suggested before but that is clearly not something you can do in common code.

The ReBAR fields often doesn't reflect the actual needed space but rather the maximum the HW address logic can resolve.

So what you end up with is allocating multiple TiB for a window which just needs few GiB, sometimes even completely overflowing the 64bit address space made available by the root complex.
> 2. Pack Oversized Windows (BAR Demotion): 
> The PCI-to-PCI Bridge spec (r1.2, sec 3.2.5) permits a prefetchable BAR 
> to be assigned from the non-prefetchable window. By clearing the PREFETCH 
> flag on small control BARs during enumeration, they are placed below 4 GiB. 
> The prefetchable window is then cleanly sized to the large BAR alone.

Interesting hack, shouldn't really matter for AMD GPUs but that is something more on the heuristic side.

A perfectly valid trick which is done by BIOS implementations but what the Linux PCI subsystem still hasn't learned are back to back allocations, e.g. something like this:

BAR0 32 GiB of GPU #1
BAR1 2	MiB of GPU #1

BAR1 2	MiB of GPU #2
BAR0 32 GiB of GPU #2

BAR0 32 GiB of GPU #3
...

I strongly suggest to implement that one first and see if it helps with your use case.

Regards,
Christian.

> 
> Why this is safe for 32-bit (< 4G) MMIO space:
> To prevent exhausting legacy < 4G space, demotion is strictly bounded. It 
> only triggers beside a massive prefetchable BAR (>= 64 MiB), and the demoted 
> BAR is strictly capped at 16 MiB (PCI_BAR_PACK_CAP). Even on an 8x GPU 
> system, this consumes at most 128 MiB of < 4G space. 
> 
> Fallback / Alignment logic:
> If the 32-bit space is exhausted, small BARs remain in the prefetchable 
> window. The alignment logic gracefully handles this by rounding the bridge 
> window up to the next power of two (e.g., growing to 64 GiB to fit a 32 GiB 
> BAR + BAR2) to maintain PCIe compatibility, ensuring sibling GPUs land in 
> properly aligned slots.
> 
> Reserving is safe by default: __assign_resources_sorted() satisfies all
> required resources first. Use pci=no_rebar_reserve and pci=no_bar_demote 
> to restore previous behaviours.
> 
> Testing Context:
> - ASUS K14PG-D24
> - 2x EPYC 9354
> - 8x Radeon AI PRO R9700 (Navi 48, 1002:7551)
> - Broadcom PEX890xx switches
> - Kernel base: 45c13f3f9e3b (tested with SEV-SNP passthrough=1)
> 
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   8 ++
>  drivers/pci/pci.c                             |  10 ++
>  drivers/pci/pci.h                             |   1 +
>  drivers/pci/setup-bus.c                       | 118 ++++++++++++++++++
>  4 files changed, 137 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 37006fc3eac3..82d2b340fb98 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5246,6 +5246,14 @@ Kernel parameters
>  		hpbussize=nn	The minimum amount of additional bus numbers
>  				reserved for buses below a hotplug bridge.
>  				Default is 1.
> +		no_rebar_reserve	Do not reserve prefetchable bridge-window
> +				space for the maximum size of downstream Resizable
> +				BARs. By default such space is reserved so a driver
> +				can grow a BAR later (e.g. GPU VRAM BAR) even behind
> +				fixed PCIe switch fabrics that firmware sized for the
> +				boot-time BAR; the device BAR is left at its boot size
> +				for the driver to resize and only bridge windows are
> +				enlarged. Use this to restore the old behaviour.
>  		realloc=	Enable/disable reallocating PCI bridge resources
>  				if allocations done by BIOS are too small to
>  				accommodate resources required by all child
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..c9901b15432a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -120,6 +120,14 @@ unsigned long pci_hotplug_mmio_pref_size =
> DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
>  #define DEFAULT_HOTPLUG_BUS_SIZE	1
>  unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
> 
> +/*
> + * Prefetchable bridge-window headroom is reserved for the maximum size of
> + * downstream Resizable BARs by default, so a driver can grow one later
> + * (e.g. amdgpu VRAM BAR) even behind fixed PCIe switch fabrics.
> + * pci=no_rebar_reserve disables this.
> + */
> +bool pci_rebar_no_reserve;
> +
> 
>  /* PCIe MPS/MRRS strategy; can be overridden by kernel command-line
> param */
>  enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
> @@ -6840,6 +6848,8 @@ static int __init pci_setup(char *str)
>  					simple_strtoul(str + 10, &str, 0);
>  				if (pci_hotplug_bus_size > 0xff)
>  					pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
> +			} else if (!strncmp(str, "no_rebar_reserve", 16)) {
> +				pci_rebar_no_reserve = true;
>  			} else if (!strncmp(str, "pcie_bus_tune_off", 17)) {
>  				pcie_bus_config = PCIE_BUS_TUNE_OFF;
>  			} else if (!strncmp(str, "pcie_bus_safe", 13)) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..6eddcb492425 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -409,6 +409,7 @@ extern unsigned long pci_hotplug_io_size;
>  extern unsigned long pci_hotplug_mmio_size;
>  extern unsigned long pci_hotplug_mmio_pref_size;
>  extern unsigned long pci_hotplug_bus_size;
> +extern bool pci_rebar_no_reserve;
> 
>  static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e8c94aa1d3c1..aa02b8454269 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -19,6 +19,7 @@
>  #include <linux/bug.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/log2.h>
>  #include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -1258,6 +1259,53 @@ static bool pbus_size_mem_optional(struct pci_dev
> *dev, int resno,
>  	return true;
>  }
> 
> +/*
> + * pci_rebar_reserve_size - prefetchable window headroom to reserve for
> a BAR
> + *
> + * Reserve enough prefetchable window space to later grow @resno of @dev to
> + * its maximum Resizable BAR size. This is done for every ReBAR-capable
> device
> + * by default (disable with pci=no_rebar_reserve). Only the optional
> (add_size)
> + * part of the enclosing window is inflated here; the device BAR
> resource and
> + * the hardware ReBAR are left at their boot size, so the driver still
> performs
> + * the actual resize into the reserved window. Reserving the window up
> front
> + * avoids -ENOSPC in pci_resize_resource() on fixed switch fabrics, where a
> + * window shared with a sibling's still-assigned BAR cannot be released and
> + * regrown at resize time.
> + *
> + * The reservation is strictly optional: __assign_resources_sorted()
> satisfies
> + * all required resources first and only then places add_size on leftover
> + * space, so reserving by default cannot make a required BAR or window
> fail.
> + *
> + * Return the extra bytes to reserve and raise *add_align to the BAR's
> + * alignment so the reserved space can actually hold the grown BAR.
> + */
> +static resource_size_t pci_rebar_reserve_size(struct pci_dev *dev, int
> resno,
> +					      resource_size_t *add_align)
> +{
> +	struct resource *res = pci_resource_n(dev, resno);
> +	resource_size_t max_size, cur_size;
> +	int max;
> +
> +	if (pci_rebar_no_reserve || resno >= PCI_STD_NUM_BARS)
> +		return 0;
> +
> +	if ((res->flags & (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH)) !=
> +	    (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH))
> +		return 0;
> +
> +	max = pci_rebar_get_max_size(dev, resno);
> +	if (max < 0)
> +		return 0;
> +
> +	max_size = pci_rebar_size_to_bytes(max);
> +	cur_size = resource_size(res);
> +	if (max_size <= cur_size)
> +		return 0;
> +
> +	*add_align = max(*add_align, max_size);
> +	return max_size - cur_size;
> +}
> +
>  /**
>   * pbus_size_mem() - Size the memory window of a given bus
>   *
> @@ -1285,6 +1333,7 @@ static void pbus_size_mem(struct pci_bus *bus,
> struct resource *b_res,
>  	int order, max_order;
>  	resource_size_t children_add_size = 0;
>  	resource_size_t add_align = 0;
> +	resource_size_t rebar_align = 0;
> 
>  	if (!b_res)
>  		return;
> @@ -1343,15 +1392,29 @@ static void pbus_size_mem(struct pci_bus *bus,
> struct resource *b_res,
>  				aligns[order] += align;
>  			if (order > max_order)
>  				max_order = order;
> +
> +			size += pci_rebar_reserve_size(dev, i, &rebar_align);
>  		}
>  	}
> 
>  	win_align = pci_min_window_alignment(bus, b_res->flags);
>  	min_align = calculate_head_align(aligns, max_order);
>  	min_align = max(min_align, win_align);
> +	min_align = max(min_align, rebar_align);
>  	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
>  				  0, win_align);
> 
> +	/*
> +	 * A window that reserves ReBAR headroom is larger than its own
> +	 * alignment (e.g. 32 GiB BAR + doorbell => 33 GiB > 32 GiB). The
> +	 * parent only reserves alignment padding for a child window when
> +	 * its size <= its alignment, so round such a window's alignment up
> +	 * to a power of two >= its size; sibling 32 GiB BARs behind one
> +	 * switch then each land in a properly aligned slot.
> +	 */
> +	if (rebar_align && size0)
> +		min_align = max(min_align, roundup_pow_of_two(size0));
> +
>  	if (size0) {
>  		resource_set_range(b_res, min_align, size0);
>  		b_res->flags &= ~IORESOURCE_DISABLED;
> @@ -2179,6 +2242,52 @@ static void pci_prepare_next_assign_round(struct
> list_head *fail_head,
>   * Second and later try will clear small leaf bridge res.
>   * Will stop till to the max depth if can not find good one.
>   */
> +/*
> + * Release the 64-bit prefetchable BARs of resizable-BAR display
> devices so the
> + * windows enclosing them empty out and can be re-sized. The BAR *size*
> is left
> + * untouched (only released and re-placed), so the hardware ReBAR is never
> + * programmed here - the driver still owns the actual resize.
> + */
> +static int pci_release_rebar_bars_cb(struct pci_dev *dev, void *data)
> +{
> +	struct resource *r;
> +	unsigned int i;
> +
> +	if ((dev->class >> 16) != PCI_BASE_CLASS_DISPLAY)
> +		return 0;
> +	if (pci_rebar_get_max_size(dev, 0) <= pci_rebar_get_current_size(dev, 0))
> +		return 0;
> +	pci_dev_for_each_resource(dev, r, i) {
> +		if (i >= PCI_BRIDGE_RESOURCES)
> +			break;
> +		if (r->parent && (r->flags & IORESOURCE_MEM_64) &&
> +		    (r->flags & IORESOURCE_PREFETCH))
> +			pci_release_resource(dev, i);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Release the now-empty prefetchable bridge windows bottom-up so the
> sizing
> + * pass re-sizes them (with pci_rebar_pref_reserve() reservation) to
> fit the
> + * BARs a driver will later grow.
> + */
> +static void pci_release_rebar_windows(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +	struct resource *w;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list)
> +		if (dev->subordinate)
> +			pci_release_rebar_windows(dev->subordinate);
> +
> +	if (!bus->self)
> +		return;
> +	w = &bus->self->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> +	if (w->parent && (w->flags & IORESOURCE_MEM_64) && !w->child)
> +		pci_release_resource(bus->self, PCI_BRIDGE_PREF_MEM_WINDOW);
> +}
> +
>  void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>  {
>  	LIST_HEAD(realloc_head);
> @@ -2190,6 +2299,15 @@ void
> pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>  	int pci_try_num = 1;
>  	enum enable_type enable_local;
> 
> +	/*
> +	 * Release resizable device BARs and their prefetchable windows so the
> +	 * sizing pass re-sizes those windows large enough
> (pci_rebar_pref_reserve)
> +	 * for the BARs a driver will later grow. Only released and re-placed
> - the
> +	 * BAR size is left untouched, so the hardware ReBAR is never programmed.
> +	 */
> +	pci_walk_bus(bus, pci_release_rebar_bars_cb, NULL);
> +	pci_release_rebar_windows(bus);
> +
>  	/* Don't realloc if asked to do so */
>  	enable_local = pci_realloc_detect(bus, pci_realloc_enable);
>  	if (pci_realloc_enabled(enable_local)) {
> 
> base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229

