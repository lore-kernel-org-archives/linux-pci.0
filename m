Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C8288D0
	for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815229; cv=fail; b=saF69FwvaA4SLv71WqNB8V81BY36s1LiKA0gE2fvKwW+tpZuu2THXUTMnMrsC/jT3n8Tji4dYtLAZlK0LE501BVoDXoKQBtcOQfxB6MvF+kKnkGIM9FV0/hhpPDia7FCd0kSAYLt+qwjxvkWmMIAS5Iu4YtGfUzBLK3RxZI5gu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815229; c=relaxed/simple;
	bh=21MNlzlXuh3IUwq5WG4tAYsvvsZurtvogLrCDOn3WOw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=keeqtET1YBdZ49JpfNCIMLr1qrBhxmoWqO30ieIbOUwkG6NQ7q5dxAfXohhoggS9HGEknCn9kAYcEgdiCgUMOoeEnl49upLewTzIx2rvqFc7pfeXezH53e1Z0WW324dC3KgLATzzq3/N+mtb8mwsj1dgWNDWaLG8C8jYrgv9/4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l1V6iF2a; arc=fail smtp.client-ip=52.101.52.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l1V6iF2a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yL6SzPxhee7pBCLDSkoPNZo6xEjhP/pc0aFpdZnk4LhpWIme90amTTJe4usBKisY2pQrtPS6lcjwz4bJATLEZ0IeEKBlgIQV6XDKB4Q401qDQSnYM0vdrKWU0iiQgSV0GHR9EIEf50twczwqNTJjFGBJK95n7RGlZR3aNo38Yi2JWHF8CSw9qKJkhJOVdGvBj9VGVsaTpVV5iOTkpjb05hjP5Db9o+b9UAZa2KFNYfvd0WJ8ww+JPGrdbIIWnXk36UvN/1eLqFfjltH87oNqeY8iRPzrXEBhDXv0+CFCZYKHzdhyGno3wZIl6gEm/66Jh30vbPFAAkGeG6Lq2HfuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9quD9Ti+R+Q7NQDSmp+mwgUCMW5tbtKqDK9P46U4/T0=;
 b=oP7gm1j1yb7VYwmgQ8jQjQxVKMVOGUZtCoXTV272X5GvAL4EgrAVYPQ/U91NlzkOT2OJhiqNsy4fR9+hrCVS3rORvh2zm1J9VJfj0TwBnBUe6RQrAM30aWf+/Ep0TqYv9351ywO4CG77m9rr9toYNdRUYbERn0rK5nGzeFrqBwZZln/FfCuioZ/+E/ysQwS5o84izKmFgOPgL6JnQKViO5lMmIRbLYzV94RYT8Pt5dMa8+LUBDgaEAO2DdO/Q50lBQiWEm10GxBldcgI5FqbyN61267GrI4pOzIxONYwgUFjDn3vNvzBwiWebMVtMY4/N7ciTPHQbJGvo/fRovFGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9quD9Ti+R+Q7NQDSmp+mwgUCMW5tbtKqDK9P46U4/T0=;
 b=l1V6iF2a12892JN6KS6lRBAV9uh5ytdbQIK+BAYfxL8sNwLl0W7YGjcxk0IRpmcUxVIaCcUa+1ZDPgHvxzUMryG2nmUVTAPPOYZMnsjPKdbrstF7vdC8hY9293x0/kpHIXm+sODv6dWYu96X92+a1qEbhhIO8ywyPaZ3yiMp3E8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 07:20:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Thu, 27 Aug 2026
 07:20:14 +0000
Message-ID: <e980712c-75e0-46a6-a616-dc1ec6ecab8e@amd.com>
Date: Thu, 27 Aug 2026 09:20:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: How to correctly reserve prefetchable bridge windows for large,
 resizable BARs behind PCIe switches (8x GPU, PEX890xx) - seeking guidance on
 upstreamable approach.
To: Geramy Loveless <gloveless@jqluv.com>, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alexander.deucher@amd.com,
 ilpo.jarvinen@linux.intel.com, amd-gfx@lists.freedesktop.org,
 mario.limonciello@amd.com, nra3088@gmail.com
References: <a2292dfb-2ee5-4988-ac67-c75dd3e97a4c@jqluv.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a2292dfb-2ee5-4988-ac67-c75dd3e97a4c@jqluv.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: b461fd1c-54e2-4d03-1179-08df040ba389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|3023799007|6133799003|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zGOzaYwSibAFOJZTAMuh28+KMGFdgrVa+V73pHM8Lk6po514VT1ZQL0vJR7OwDYHCtApb6lHoG614VoLP930JjgbnucPouJ6drW1sB5b3GwpSz/slD/CeCliv8kYNSqcvJLBSywQwBcjOems48lrW0UlwSAcqcg/BQC19JoMJ/pgNLyHJY36KYKLVsGrDmi29n9PIGTA9qBEXqj4Fo6z1lRT5gXudUZSYKkYcd3BsHvpSM65CBhnPkDsUL/Mf6pViOPjEp/ejd6nXk/WVgbIhY4phqY4s3XhlWr6wyj8+8781S6ubBrxgaAO0j/yxnn/pVQOhw/1SK41F7tL5sTkoOgrxwwDCV/idFWoX9Lui1mR+ee5Ot61LLkycE+DbiIidyqkVnxjphEIeG3Bpa3RokOYtBK+R8tu+E+pcv2WRN30IZWTOoIV1lHZpAD5vTo3Da9TdLfM4fg7zBkxpfpvvxE5LXb4rLa/NLmcqvnBfhM0bd+IjWGHU+7rtLEZ34TnC3qTAvKs+C8TuNFqbI0kVU1laX/3X7YCpXW5PLmCCX+AUyvtTFyMXy3QaM3WMM2uFnTQ0xqfGOU2NNQ7DSCY45lg/3UC6xay8XaFobviojFrKYxAbLIyXiW8Y7lvmfoZYPzAC8fgwf6sPB7BF2+LUXNLS2XaLK1bTIT8OF4wdrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVRJV1B0VUUyTHVmcTFTbS9WVFlBeFBoTHpNcUd6bFdyLzlOb3VGY1UraVBR?=
 =?utf-8?B?RlhMR3I5SXlZazhsaDdhbDFuUlhLZVpkSFFSdFFIK0JVZ0JPUWc0WHVGaWV4?=
 =?utf-8?B?Vk10cGxvd1ZsMUVjaWlVRWM1ZDdlWkNtekhkWWdGZW1uMDkwUms2T0tiQW9x?=
 =?utf-8?B?d3lkRjRzdVBjend1VGlPSEFtVEZ0Z25FVXZHcDZFMGVJMDdhL0gzWFNJcVFB?=
 =?utf-8?B?bXNmNWpEa2NjMExtdWZnWW1HNGkvUXJFNHp4KzNIWmZ5TEdYQ3ZLNDFNSGFU?=
 =?utf-8?B?WjROUDVSVkxETUJTVWVEWHZZYzV4ZDA2TFRzZ2t1THgwME9HWkxPYzlmOGNK?=
 =?utf-8?B?T3V3ejQzZys4bURYWWFGeE0xdy8wRUl6SWY5Z25RNVQvRVBzV0ZZeldHbDhT?=
 =?utf-8?B?VWYyWmJGMWlLbEhPa2ZCZC93VWNiZFlHd0xqRXZ3enp1ekJyeFhlVDZybDhs?=
 =?utf-8?B?U1FySTRXdTdlWGp0K0orYWVKdGJYU2Q3akNydyt6OHRkVXg4MHI4bUF4ejho?=
 =?utf-8?B?NVZxWnExT2t4SFpKdmIrZHAyMDd2cWhObTFSOWIrcTBFQ1JINGlwWGlvY1ZN?=
 =?utf-8?B?ZUtMc3J4akZzSnpaZk1yb0hybHp0aGJtNkRqeWp5Q2p2REVlK2E1VFJwTy9I?=
 =?utf-8?B?ajBrTVVZdCtFMWI3ejBDa2NmdXBJd3FPVE1aNEVtKzNJclNFclN0UldSZXlJ?=
 =?utf-8?B?djkranduUWx1cnI0QkhLY3lTeG81U1pnZFZ6eEx0a3Y2RzhiR0JjdHYzNkQy?=
 =?utf-8?B?U3VhZFFsUnhwbEhuVkRIalN2c0FjbFJ5dVI0T3FDWHl6SzVXVktCMSs1TlFN?=
 =?utf-8?B?aElTY292ZWFPMlBEaDNYRXBZR2cwb1ZXKzhoZGVOeHFtRE51ajNRWDVmYjkv?=
 =?utf-8?B?UUxleGlVN0VjWmI1bjVvN1ZlcjJMTFJRbnBQWm1oV2FFbWk2VE1SbVZDVXFF?=
 =?utf-8?B?MWJNai8yVjdFa1NVUGt4TFl4dFJjd3FpdGdZaDhjaVdlYkVUWUdtSWVMYTAz?=
 =?utf-8?B?cFJiNDRmcDNoSHgvNGR4aFRkeXpxc2xKaXJoR1ZZcVk5RlJvdEJpb3lzMllC?=
 =?utf-8?B?UkhxVUN5NWJsN0tQV3dPaGNSeHh2RkJlWnhTSGZJS3pjT2ZDMjhkTitiUnRF?=
 =?utf-8?B?QlVJNHdaMUNXS1NuMGlxekxjeXdtOWdaZGpBT1hTbTdpOGlsTm5VQm12dEpY?=
 =?utf-8?B?aVF0K3pLcG9EQ3doVVE5Y1N5WER0MlhqOGdlbmZDNU1hb1pmckNualphSWo4?=
 =?utf-8?B?a1J1RFRSc0s2bXRWUHF3RWN6Slo1QVZEeDBNSTF2eXk3RmtzaTJwU2Rxakl2?=
 =?utf-8?B?VitoQWhtalRFOGVvSUswYjBza1BtQzU0MmwwZ1RMWG9zL0N3MENoZW4vd3BX?=
 =?utf-8?B?akx1aTh1RWIxNExwaEhxNFpseUcrVS9aZ1JYazlFNVo5SDFvcWJDMGR0S0Vl?=
 =?utf-8?B?RmJPQ0R5cTJQcTFnb2lJNTlibWN4Rk9ERysyZndYcXJzbWU4V0dPM2hqbm1w?=
 =?utf-8?B?dFJZQUwxYy9nbUE2NUo0bGVwbGtySmZhS245WFBjNTFXS0QzYjBWdzVmbHdD?=
 =?utf-8?B?c0ovb3RMTWVQL3RKajFCM1RoTHplK21zbEhZa1ZTSkdhWEVwOG83UlFkRTFz?=
 =?utf-8?B?YmsrSWQ4VEhvM0ZmdzVsOGcxMm9hVXlZTTJpcmF4d01qYmY1Qm1taUdiK2l3?=
 =?utf-8?B?Mi8rWUJqeWZ2VkNoUFphZGJQRVJmK1dNK1k5YmYxNThYVE1IY0J0V2dBYU5o?=
 =?utf-8?B?ZTJNNFpBZSswZG05dERtVzdjcVFtVW1oMjg3d213SlQxTkQxM3NWWEZaYjI0?=
 =?utf-8?B?VzhyeUkxSDVtZ2psanNvaWdCbDIxQWlGbklqd2tIOVhXcHNMUStOaWFyU0c1?=
 =?utf-8?B?TkZxVEZCaC9saXZYV3pXemVkZ2NUVnVoYlpKYzNCLzRHcFVGSC9MbEowVS81?=
 =?utf-8?B?ZEVQZ08zWGRZQVQ2amZPNit1OGhENjd1TTcvWmlnZi9CNUsrbmIxeGVvaktw?=
 =?utf-8?B?dDEyaWhzSU9kVUR2N1laSGM0RzM3ZDFLMUFHREFUYTZGTFJzZ3NRalBHYUZD?=
 =?utf-8?B?azZDVnFxemtScmZvRE1qUVhOVmFib1A4bGlMTjhKWEF4b0xKNnhsQnFrTGJR?=
 =?utf-8?B?Y3UxUDVJRVhXdVFZMVQveUhGMUNyQnhjRDdYTityZEEwcVVVRWN6c0pzbCtG?=
 =?utf-8?B?Z2M1Wkc2QW5uR1BxNDhEYkRVWW1CbENkWGRHM2JtR2xzY0pNc0tJSVhaa2cy?=
 =?utf-8?B?N2g2MExIQXF2WGVSaVE2V3pWdXk4QlkzYVZsUSsvSUltcSsrZmJTeGFkcHFu?=
 =?utf-8?Q?KfL5zWMgmG9T8quZLG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b461fd1c-54e2-4d03-1179-08df040ba389
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:20:14.7409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gH2OYlesR0TzoeIko2RLB9/QYUM8l5HuUlKUIcpm69kMYkgEd2vBotJDLr+CgST
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258

Hi Geramy,

well I have some bad news for you: This can't work correctly easily.


What happens is that the BIOS or Linux PCIe subsystem initializes the intermediate bridges without knowing how much BAR size they actually need.

Background is that you need the PSP started, the ASIC initialized and driver at least partially loaded to figure out how much VRAM/local memory is connected to the board.

But as you have found out as well after the PSP is started you need to make sure that the device is idle/stopped to move the BARs around or you migth run into problems. The workaround you came up with is basically just the tip of the iceberg here.

So what happens is that each GPU starts and detects that it has 32GiB VRAM and tries to resize it's own BAR0, but fails because it is under a common upstream bridge with other the GPUs which would need to be made idle/stopped at the same time to do this.

In the end you run into a really nice chicken and egg problem where you need the driver loaded to detect how much you need, but you need the driver unloaded to actually do the resize....


There are a few possibilities to get you out of this situation:

1. A patch set to dynamically allow stopping/starting PCI devices and their drivers to allow BAR resize on upstream bridge windows.

This patch set came up a couple of years ago and looked like the right direction to solve this problem, but unfortunately it means that you need to change every PCI driver involved to support this starting/stopping.

This was so intrusive that as far as I know the patch set was never merged. @Bjorn please correct me if that info is outdated.


2. You can use the pci=resource_alignment=[<order of align>@]<pci_dev>[; ...] on the kernel command line.

See Documentation/admin-guide/kernel-parameters.txt for details.

IIRC this explicitely allows resizing upstream bridge BARs before any drivers are loaded/started.


3. You can manually resize things using sysfs before the driver loads.

Basic idea is that you blacklist amdgpu and prevent it from automatically loading. Then go into /sys/devices, resize BAR0 to 32GiB and then simulate a hot remove by doing "echo 1 > remove".

When you then trigger a rescan on the upstream bridge the devices will be detected with a 32GiB BAR and upstream bridge sized accordingly.


I hope that somehow helps, but yeah that is a well known problem without any easy solution.

Regards,
Christian.


On 8/26/26 22:22, Geramy Loveless wrote:
> Hi all,
> 
> We have an 8-GPU host where each GPU wants a 32 GiB resizable BAR, but the GPUs sit behind a multi-level Broadcom PEX890xx PCIe switch fabric whose prefetchable bridge windows are sized by firmware for the default 256 MiB BAR. The kernel/driver never grows those windows, so every BAR stays a 256 MiB and the cards run in small-BAR mode.
> 
> We have an out-of-tree patch that makes it work (full patch inline below as PATCH 1), but we're not confident it's the right shape for upstream, and we've hit a nasty interaction with the GPU firmware (PSP) that suggests we're doing it at the wrong layer. We'd really appreciate guidance on the correct approach before we try to submit anything.
> 
> Background / history
> --------------------
> We first developed this reservation logic for Thunderbolt 5 / USB4-attached GPUs, where the tunneled PCIe hierarchy has the identical problem: firmware sizes the bridge windows for the boot-time BAR, and there's no room for the driver to grow a resizable BAR afterward. We found the exact same problem applies to GPUs behind on-board PCIe switches, so we adapted the same idea here.
> 
> Software versions (both inline patches are "git apply --check" clean on
> these exact bases)
> ----------------------------------------------------------------------
> - Kernel base:   torvalds 45c13f3f9 (Makefile VERSION 7.2.0;
>                  "Merge tag 'hwlock-v7.3' ...")
> - amdgpu:        amd-staging-drm-next @ 75a5e1b6b
>                  ("drm/amdkfd: guard against NULL restore_mqd in CRIU queue
>                   restore")
> - PATCH 1 (inline below): our out-of-tree PCI window reservation.
> - PATCH 2 (inline below): Mario Limonciello, commit 63b2896378d,
>                  "drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs only",
>                  Fixes: ea8ac194077d.
> 
> Note on the two amdgpu issues our PCI patch exposes: pre-sizing the fb BAR resource causes the *hardware* BAR to be large by the time amdgpu binds, which triggers two separate problems on the R9700 - (1) the early BAR0-aperture read added in ea8ac194077d returns ~0 for the IP-discovery table (PATCH 2 restricts that read to SR-IOV VFs and is what gets us pas
> discovery today), and (2) the PSP teardown described below. Both disappear if the child BAR is left at its boot size and the driver performs the resize - which is the core of our question.
> 
> Hardware
> --------
> - Chassis/board:  ASUSTeK K14PG-D24 Series, BIOS 2001 (2024-08-02)
> - CPU:            2x AMD EPYC 9354 (Genoa, 32C/socket, 2 NUMA nodes)
> - Root complex:   AMD Genoa/Bergamo Root Complex [1022:14a4]
> - PCIe switches:  Broadcom/LSI PEX890xx PCIe Gen5 Switch [1000:c030] (rev b0),
>                   cascaded (upstream port -> multiple downstream ports ->
>                   further PEX890xx stages -> one GPU per leaf)
> - GPUs:           8x AMD Navi 48 [Radeon AI PRO R9700] [1002:7551] rev c0,
>                   subsystem ASRock [.. :5413], 32 GiB VRAM each (gfx1201/RDNA4)
> - GPU BDFs:       07:00.0 0a:00.0 68:00.0 6d:00.0 87:00.0 8a:00.0 e8:00.0 ed:00.0
> - Boot cmdline:   iommu.passthrough=0 pci=realloc (+ disable_acs_redir on the
>                   eight switch downstream ports)
> 
> Topology (abridged; one leg shown, all eight are symmetric):
> 
>   [EPYC RC] -> PEX890xx up -> PEX890xx dn(62:00.0) -> PEX890xx(63:00.0) -> GPU(68:00.0)
> 
> Every prefetchable window in that chain is firmware-sized at 258 MiB
> (256 MiB fb BAR + 2 MiB doorbell BAR), e.g.:
> 
>   62:00.0  Prefetchable memory behind bridge: ...  [size=258M]
>   63:00.0  Prefetchable memory behind bridge: ...  [size=258M]
> 
> To resize a single GPU BAR to 32 GiB, every bridge window from the leaf up to the root must be enlarged, and windows feeding two GPUs need >= 64 GiB in my specific use case but this needs to be generally acceptable for all use cases of course.
> 
> What we observe without any patch
> ---------------------------------
> amdgpu_device_resize_fb_bar() runs and calls pci_resize_resource(pdev, 0, <32G>), which returns -ENOSPC ("Not enough PCI address space for a large BAR") because the parent switch windows have no room, and nothing grows them. All eight BARs stay at 256 MiB.
> 
> (This is with current mainline/amd-staging; the recent removal of the driver-side re-assignment in db92e3fef53e2 does not change this outcome on our topology - we tested a revert and still got 256 MiB, because re-assigning unassigned resources does not grow already-assigned switch windows.)
> 
> Our current out-of-tree patch (PATCH 1, inline below)
> -----------------------------------------------------
> At pci_assign_unassigned_root_bus_resources() time we (a) bump each display device's fb BAR resource to its max ReBAR size, (b) release the prefetchable BARs/windows so the assignment pass re-sizes the whole prefetchable hierarchy large enough to hold the enlarged BARs, plus a small setup-res.c tweak so multiple max-size BARs can share one window with correct alignment. With this, all eight windows get sized for 32 GiB and the resize succeeds.
> 
> The problem with our approach
> -------------------------------------------------------
> Bumping the fb BAR *resource* to max causes the assignment pass to program the hardware ReBAR to 32 GiB at enumeration time (before amdgpu binds). On these R9700s that early hardware BAR resize tears down the firmware-loaded PSP "sign of life" (sOS), and amdgpu's later PSP bring-up then fails to reload it:
> 
>     amdgpu ...: PSP load kdb failed!
>     amdgpu ...: psp reg (0x16080) wait timed out ... read: 30000 exp: 80000000
>     amdgpu ...: hw_init of IP block <psp> failed -22
> 
> If instead the hardware BAR is left at its BIOS size and amdgpu performs the resize itself (which is what happens when firmware pre-enabled a large BAR), the PSP stays alive and the GPU comes up fine. So what we actually want is to reserve/size the prefetchable *windows* for 32 GiB while leaving the child BAR at its boot size, and let the driver do the hardware resize into the pre-sized window. Our current patch conflates the two.
> 
> Questions
> ---------
> 1. Is there an existing/preferred mechanism for reserving prefetchable bridge-window space for large resizable BARs across a switch hierarchy that we should be using (something analogous to the hotplug hpmemprefsize reservation, but for fixed switch fabrics)? We'd rather use it than carry this.
> 
> 2. If a new mechanism is needed, where should it live? Our instinct is that the window sizing wants to happen in pci_bus_size_bridges()/the realloc (add_size) path so the child BAR resource is never grown - i.e. reserve the window, not the BAR. Is that the right direction, and is there a sanctioned way to request "N bytes of extra prefetchable window on this bridge" during the sizing pass?
> 
> 3. Given the PSP interaction, is the expectation that the *driver* always owns the hardware BAR resize (so core should only ever arrange windows, never program the device ReBAR)? If so, is the resource-size bump we do simply the wrong tool?
> 
> 4. We're happy to write this properly and carry the testing - we have the 8x R9700 / PEX890xx box and can iterate quickly. We can also share the full lspci -tvvv, dmesg, and the Thunderbolt/USB4 variant of the patch if useful.
> 
> Thanks a lot for any pointers,
> Geramy Loveless
> 
> The two patches follow inline below.
> 
> ==============================================================================
> PATCH 1/2 - PCI: reserve prefetchable bridge windows for resizable BARs
>             (our out-of-tree patch; git apply --check clean on 45c13f3f9)
> ==============================================================================
> From: Geramy Loveless <gloveless@jqluv.com>
> Date: Wed, 26 Aug 2026 00:00:00 +0000
> Subject: [PATCH] PCI: reserve prefetchable bridge windows for multi-child resizable BARs
> 
> Out-of-tree patch we carry to make 8x resizable-BAR GPUs behind a cascaded PCIe switch fabric usable. Firmware sizes every prefetchable bridge window for the boot-time (256 MiB) BAR, so a driver's later resize to 32 GiB fails with -ENOSPC because no window in the chain has room.
> 
> Before sizing the bridge windows, bump each display device's fb BAR resource to its max ReBAR size and release the prefetchable BARs/windows so the assignment pass re-sizes the prefetchable hierarchy large enough. A small pci_align_resource() tweak lets several max-size BARs share one window.
> 
> NOTE (seeking review): bumping the BAR *resource* also programs the hardware ReBAR at enumeration time, which on AMD R9700 tears down firmware PSP state and breaks GPU init. The correct shape is likely to size the *window* only and leave the child BAR at boot size for the driver to resize.
> 
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> ---
>  drivers/pci/rebar.c     |  1 +
>  drivers/pci/setup-bus.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/setup-res.c |  7 ++++++
>  include/linux/pci.h     |  1 +
>  4 files changed, 71 insertions(+)
> 
> diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
> index 5bbdc9470..3b621fa3c 100644
> --- a/drivers/pci/rebar.c
> +++ b/drivers/pci/rebar.c
> @@ -190,6 +190,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
>      pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>      return FIELD_GET(PCI_REBAR_CTRL_BAR_SIZE, ctrl);
>  }
> +EXPORT_SYMBOL_GPL(pci_rebar_get_current_size);
> 
>  /**
>   * pci_rebar_set_size - set a new size for a Resizable BAR
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e8c94aa1d..1bb018e3a 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2179,6 +2179,59 @@ static void pci_prepare_next_assign_round(struct list_head *fail_head,
>   * Second and later try will clear small leaf bridge res.
>   * Will stop till to the max depth if can not find good one.
>   */
> +static int pci_reserve_rebar_cb(struct pci_dev *dev, void *data)
> +{
> +    struct resource *r;
> +    unsigned int i;
> +    int max, cur;
> +
> +    if ((dev->class >> 16) != PCI_BASE_CLASS_DISPLAY)
> +        return 0;
> +    max = pci_rebar_get_max_size(dev, 0);
> +    if (max < 0)
> +        return 0;
> +    cur = pci_rebar_get_current_size(dev, 0);
> +    if (cur < 0 || cur >= max)
> +        return 0;
> +    pci_resize_resource_set_size(dev, 0, max);
> +
> +    /*
> +     * Release every prefetchable BAR so the 64-bit prefetchable window
> +     * enclosing them empties and can be re-sized for the enlarged BAR0.
> +     * The hardware BAR is left untouched for the driver to resize.
> +     */
> +    pci_dev_for_each_resource(dev, r, i) {
> +        if (i >= PCI_BRIDGE_RESOURCES)
> +            break;
> +        if (r->parent && (r->flags & IORESOURCE_MEM_64) &&
> +            (r->flags & IORESOURCE_PREFETCH))
> +            pci_release_resource(dev, i);
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Release the prefetchable bridge windows emptied by pci_reserve_rebar_cb() so
> + * the assignment pass re-sizes them to fit the reserved BARs. Recurse first so
> + * windows are released bottom-up; the !child test skips windows that still hold
> + * other devices' resources.
> + */
> +static void pci_release_rebar_windows(struct pci_bus *bus)
> +{
> +    struct pci_dev *dev;
> +    struct resource *w;
> +
> +    list_for_each_entry(dev, &bus->devices, bus_list)
> +        if (dev->subordinate)
> +            pci_release_rebar_windows(dev->subordinate);
> +
> +    if (!bus->self)
> +        return;
> +    w = &bus->self->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> +    if (w->parent && (w->flags & IORESOURCE_MEM_64) && !w->child)
> +        pci_release_resource(bus->self, PCI_BRIDGE_PREF_MEM_WINDOW);
> +}
> +
>  void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>  {
>      LIST_HEAD(realloc_head);
> @@ -2190,6 +2243,15 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>      int pci_try_num = 1;
>      enum enable_type enable_local;
> 
> +    /*
> +     * Reserve window space for resizable device BARs at their maximum
> +     * size before sizing the bridge windows, so the windows fit the BARs
> +     * a driver will later grow. Only the resource size is set here; the
> +     * hardware BAR is left untouched for the driver to resize.
> +     */
> +    pci_walk_bus(bus, pci_reserve_rebar_cb, NULL);
> +    pci_release_rebar_windows(bus);
> +
>      /* Don't realloc if asked to do so */
>      enable_local = pci_realloc_detect(bus, pci_realloc_enable);
>      if (pci_realloc_enabled(enable_local)) {
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 376f09630..db12092e1 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -280,6 +280,13 @@ resource_size_t pci_align_resource(struct pci_dev *dev,
>          return res->start;
> 
>      remainder = size - ALIGN_DOWN(size, align);
> +    /*
> +     * A window holding several align-sized resources has one tail per
> +     * resource, but only the lowest can tuck below the first aligned
> +     * boundary; the rest sit above it. Relocate a single tail's worth.
> +     */
> +    if (ALIGN_DOWN(size, align) > align)
> +        remainder /= ALIGN_DOWN(size, align) / align;
>      /* Don't mess with size that doesn't align with window size granularity */
>      if (!IS_ALIGNED(remainder, pci_min_window_alignment(dev->bus, res->flags)))
>          return res->start;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107..e15d78a31 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1500,6 +1500,7 @@ resource_size_t pci_rebar_size_to_bytes(int size);
>  u64 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
>  bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size);
>  int pci_rebar_get_max_size(struct pci_dev *pdev, int bar);
> +int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
>  int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,
>                       int exclude_bars);
> 
> 
> ==============================================================================
> PATCH 2/2 - drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs only
>             (Mario Limonciello, commit 63b2896378d; verified applies to 75a5e1b6b)
> ==============================================================================
> 
> From 63b2896378d284e2043b44b81a0c044aef0e95fe Mon Sep 17 00:00:00 2001
> From: Mario Limonciello <mario.limonciello@amd.com>
> Date: Wed, 26 Aug 2026 12:02:53 -0500
> Subject: [PATCH] drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs only
> 
> The BAR0 fallback read path in amdgpu_device_read_fb_via_bar0() was
> introduced as a workaround for SR-IOV virtual functions where the VRAM
> aperture (adev->mman.aper_base_kaddr) is not available during early init.
> 
> However, the function currently allows any device (VF, PF, or bare metal)
> to use this fallback path, which is unnecessary overhead for non-VF
> configurations.
> 
> Since amdgpu_virt_init() runs during early initialization and sets
> adev->virt.caps before any runtime framebuffer access occurs, we can
> safely check amdgpu_sriov_vf() to restrict this workaround to only
> SR-IOV VFs where it's actually needed.
> 
> Fixes: ea8ac194077d ("drm/amdgpu: reduce early full GPU access during SR-IOV init")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -774,6 +774,10 @@
>      u64 end;
> 
>      if (!buf || !size)
> +        return -EINVAL;
> +
> +    /* BAR0 workaround only needed for SR-IOV VFs */
> +    if (!amdgpu_sriov_vf(adev))
>          return -EINVAL;
> 
>      flags = pci_resource_flags(adev->pdev, 0);

