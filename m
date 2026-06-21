Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6487E42050
	for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782065114; cv=fail; b=CbA8lQ94v3ocCRrfffjhh6WoHxp/YaIQHTpEHXrTZt9KDnYSKB/NlZcvwebnkynjfGHt9B1ZqQvlHqjHhcb6EFPmUoTZITYXFz2Jidtjx57ETOx090yZsD1CvO8wyoxFagcVPFx918BJ7ZvDbiVH+478maBZXWi3/Ht9aNE6jDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782065114; c=relaxed/simple;
	bh=/Sm/wWsu8DbJ/2D1QBUKCXIZw1gkSmFiBYuwCQoAnmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y70mTzqAhylNNFCImFznvwjqI1cSrXv/GsdOPix1vyiZAxaES1faQPfNBGWn8YFt6rCCJIDTTLrBXzjIS3X1eC7/Gy98knak9g2azC3J1lVwH/RkMbpueaL6W+8XmTFa+MumfuU+J39sLVAgDewM3/7Rk+uGMMkceuz1QrsaWwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TO01BJe5; arc=fail smtp.client-ip=52.101.52.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TO01BJe5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCrNuwne4yyzREW3K5qQOcFJL8ckEVaiEupKV0gse/y1zA+krUFSPUvQVrLQoV/mVAm74U1/mfL3oPHEbQTF7b/nEdeKMHmkH38HA3P4ayDUepb2QrMpCGONgKIOnL6/aZ+meSijhqyRQYTCLzLWPp1qOX0lzEQFpPk6vqSOj41ShPtdS62o45XxI2mZrxyJFCqOFQwmVxr6LQQ0FavYtyQYnKPaYxq+1dOsZB2Oy03iDuze/PYinH1CvHvOlR4yfLvCZMVXUkbg323SzPORsjCBREacsxw/Ujv0IK/VmoV7o1uUzz4fTFxpa0YlleX0/QOj2oVIPPFzDxZzfRKfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA0SKiGxQiANH+wx4A7HD7zZRATsrzL1Fso9j9sMEsk=;
 b=bA+oxBH84aMhubGkl8LYVYWR87KgnQRbLrBFvnyX4fVCob9MUe7XSgaNGBdP0dcImQawOP2SJEapw5l56Q96UuvtNiq+59yWk9eU6k3Ufv8yurWNlkbiIxyQTz/pJXZGZjoBDqzJwQpmTD742vmTY49QXoHe1fttOGA3aFWcSjDgUcnBDeclKKoeT7f5nDROnULrT08fRQQcsjrGW4iYSo2GDGtmlcWgiC+Vu0cOYvDnGWlbCm0ZebHoiC21L50FVOsAtYh/sug3tC0JkBJQClBzxq8x7pvQST7oowdjKZ6k4aT8YvPJMcY81JJ37RGX38DsjvcXo/SJVpbL7UA0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RA0SKiGxQiANH+wx4A7HD7zZRATsrzL1Fso9j9sMEsk=;
 b=TO01BJe5E9CDocXkZ/FQGo/pBVot6IVgOzHsELap/F0qsNmVpbn+hYLL1MM+WYQilJ/iU3cWTrGCTIEZOLjkJIMtpfbIEbqGTNHj/cQNMpXDCEA55ZJ+WviKf4w2ZpWzwR/QxIgf8qwG4cHozFtzokUrgqyVj/3L6E6I3uvC9pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 18:05:10 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 18:05:10 +0000
Message-ID: <5a7117b6-3e2b-4bf9-bf8e-5a873b4e7b76@amd.com>
Date: Sun, 21 Jun 2026 11:05:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbcon: Drop vga_default_device() check from
 video_is_primary_device()
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260621175230.1453114-1-mario.limonciello@amd.com>
 <20260621180138.011DC1F000E9@smtp.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260621180138.011DC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 31820af7-f625-4697-c471-08decfbfa268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	rHrBk5BLDeruOI6KQxoD/33N+hxWhF6ig4x3JBTbIRV6WL8N7JO6PGjbwB/FQw/nOXgu6Uy3chgS6mEOTTColv7loWHyC20tk0bHHJhPMmujtXUIqjFruzB20kQHW/EvHw0K6E75mnXFCNoLuIViFdb+WDxi1Od7tarV3HANV958sSrRdeooJHb95aH71K1KN7EUM8jXhjI+xqDGSONpRWdIOhxt7WE4czbYxlEKsrZnpaNGGEwuT+tCexNWQ2nr36hA/WPTqLnM3mcnPXb0zMlcQSrNtCG6FvcRDvNwi/CB6S/6vC91dc6urjRTyEp8y9IldlAexVjARQZuFrIeOV6sUtdjrSLfYi29zbKf6Gop/5HqC3njFuqmplEwIaiNZWAgH6wMFLlWTZZiOvsjAOYTFDO37etteYCeocgqIygyL2OiIUb9oJxDOI7xpbhX20lX3cWCOIu2ttsf5I3U6yepFBrypZ1PdCi2p0zpEp4Yl4tDtMtB8NiNQEW5w5N73XljRVrgh7Nl+rLl4M26/MtqGnr/VwF4tRHIN/5auctG3h9CuNGzBaZXYXRHO2pmSXKdZAUXNM6qIYdlva83SDzVe9BLwYJO4PicLoUsr/ptmKi4rUDodw4Ae4QW1YS0vLSIC+suUazRGewBlppl7IqU9EWsrs1D3z3O3ORbwYI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3BoMnlXL1EzRldUSEhnVEhiQWtNeThUcnpJT3hFajFoa3B4VzhNRXVPM09j?=
 =?utf-8?B?TXFpbG9Oall5S0w1aUhKb25qeWFBVUFUSDR0ZWVUYlZSOE9NalZpRXJPejYr?=
 =?utf-8?B?a2pwZkordk5nZURYVVFGcTh4VzFkMWg5ZUJYQnpTVlRuVWp5N3hSUFBXNlEz?=
 =?utf-8?B?WkFlaHdFSHY0Q1BjaUwySE5rcDZQRXRPSU9QT2NSWFFUcFZvWGJ6YUVWVDlo?=
 =?utf-8?B?Wm5nSUd3ZVBrSWFUdGNmOTg2ekYyTytvZDhVNkJLTVU1dDcxNU1YOVNFdVAz?=
 =?utf-8?B?WlAwVDQxbEt2QlVFL0RYdFJ0cjI1TmFUMDArVTZKRVdTTlJkbzVkY3RzN0ZR?=
 =?utf-8?B?OXdxdjdFejFqK0FqQlZwbzB5S0c4cnh3SGNRYk9hbEpkMDNvWkJSa04xbHJL?=
 =?utf-8?B?U1JBOUhqVHM0Q0NqQWxMWEFLQlN4TmswOFhxaHlPZkEvYzAvdWdpbnRCSlUz?=
 =?utf-8?B?Yi9aRTVzSVFQNE9KMTVlVnZnYTR6djdZMWJWcmtoQVZobVpaVHFmVW9kWnRi?=
 =?utf-8?B?WGRYUWYvTnA5OFRKMHlKL1RGVmk5RHhtQUR4WjhQeWtuUGo3ck1Dd3NSRGcw?=
 =?utf-8?B?RVhHMXJzTnFKMkJsL3ZKR0FEZDh4Q3l6S2pGL3RDNko4bjdpTFNlekxlVnlu?=
 =?utf-8?B?MmpUdGxYV0xrM1R4ZU5keEFLRUlQbkZZdUJ4ajdqbmZ4b0dGUlk3bUxWWDNs?=
 =?utf-8?B?czNXdUlyMTUydlVTUkJPN0FncDlHWVhoN3l6d3BEY3lhZkRQeWs4NkpRWTYv?=
 =?utf-8?B?QlNhU3oxQ0YwL1dEK2l0WitEQnoweTIzNmsySjFTTVM2Sk9qbWZOeE9ONU8x?=
 =?utf-8?B?czFLRXpnK0ZDWTI2d1J4WHNnVzBVc0p6UElFQmNyYXdEY0xmam9za2owS0ZQ?=
 =?utf-8?B?VzNTSERLOUtnVHA0SGdjQi96T1QrTk1GOHN3T3h3V1Z5dGt6N3hzVnRPRUM4?=
 =?utf-8?B?RjdUQ1ZxY042TjgydHRDdW5QVktXNFBFTFNaVmFvdXFSOFNjVTZ3alg1WkNW?=
 =?utf-8?B?UStVdTV3RDVYcHdiQitrZFhocWFBZHluR0MwT09QNWJ5czdsUzU1VkNqeGpW?=
 =?utf-8?B?T0lzTDBGTCs4cnFSOXRLSkQyL2xrV0x0UmV5Sk1PQU9EQjdSOHRPODhQK0tZ?=
 =?utf-8?B?cE9WTVRJakpwWmx1eCtBNW9Fc1NWVW8xdmxTTnhZR0ZwMmlhaHNsR3hsZmNw?=
 =?utf-8?B?MWRBR0dXd1lNZjF4S240bmR0THM3VDVHSGRkR3F5UGQ2WlB2YllnN240QjVB?=
 =?utf-8?B?Z1djQU40Y1lCa04xbWNsZlhWL1o4ZlloZ2h5cFpQdlNlR1dmMmhjaVRkTzN4?=
 =?utf-8?B?R2pLRll0aWEwS0FENms2UDd4WkVJREc4dHI2NVlGZ2pFN1dVRVNrTUUxYlpm?=
 =?utf-8?B?b3ZSSUZjQ2lNOFJjSjdYeVJuMW1RUExGQ1FObmlOZUlVM1FmQnJ2VTF5R2t0?=
 =?utf-8?B?TWtHamJ0aWtCb3hDVlpWOHhMMmlqYXd5cTJvUW5kU0VFL3MxZWZPcFJxNmRB?=
 =?utf-8?B?anB5Mk1Sc1B1TERPZmtzU1E3cHhRVFlDVVI5Q0JjOGxjOHJQMVRSRThtNlBS?=
 =?utf-8?B?MVpUT1FhdzRCVXNTNnk3NjFRWDk5T1V0VDUwTVhuUEwxLzIxTDFCdlpWSUxN?=
 =?utf-8?B?VExSTlFBWlVCbkJ5WmJoWW9ZOGVwdFhrb3BJSTY5L0JIMUlObStPWTVNaTVa?=
 =?utf-8?B?Sng2bEhJcVlLTUw1Y0NwVjNQTnhQV2ZKdjNPMlV4cHZNYjB5c0pNS21XOFhE?=
 =?utf-8?B?djhFa2tXRDkvejkrVm94R243eGJFbGNFMVBjeDRLR20xbXZyMk11dW1SdXNo?=
 =?utf-8?B?eWNGQkppOHdGUXh0aFlNTDlhVmcySjBXNjF0VTFFU0kxZkgzN0xDa3NWTmEr?=
 =?utf-8?B?M0U1NGdrUm9HanlxdlVnY2NwTnVINEVFS1J3OWlxbHo0eDRIaE9IOUJUOFFz?=
 =?utf-8?B?T1NJM2RnaUVxNE1qYUFLcUhyeGkrUjFveEZVN01iMkNNRWFkN3lHRk9KUWdl?=
 =?utf-8?B?Znp6RnliNmtvUFE0MnNPV0RTR0NJUXhTYWxyT1VWZzVWdmNnUjFXb1k0Ym9I?=
 =?utf-8?B?UlVGWkkxVFFvb1M0NEQySzZRTWVITjg3WE52ZzU2ejkzYW03MjJTTE5IYzNI?=
 =?utf-8?B?Y0lTZ1hVMnNxOTU3N0hmQzg2K1FrTTQ0SjMrK1J4NWlYMGZNTEFxWG5zcjBM?=
 =?utf-8?B?M1FTS20yYmdWdVJwMnVybDJObFdjVlU2bzRRT0NCNzlyYWVWTjZESytuU0Nk?=
 =?utf-8?B?WVJ2T01Vc1A4bFA5Y0gvTUlmYzllUG1CWWdzKzdDNjg5QkhQZFBBMDMyYkN4?=
 =?utf-8?Q?wkP50jO31nTKv+CQPk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31820af7-f625-4697-c471-08decfbfa268
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 18:05:10.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JrkQGvwcXLwyvOM36XE5jJsm/YZ8uL8u9d4Pdon7gThjMwLYgd43BwEQLgcMyNjyoMW9Dz9vPQcyR/gu0U+PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514



On 6/21/26 11:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the `vga_default_device()` fallback breaks primary device detection for systems booting in legacy VGA modes (e.g., BIOS/CSM).
> --
> 
> commit ae22bd27658973af445cda4ac9c68bb0a550097b
> Author: Mario Limonciello <mario.limonciello@amd.com>
> 
> fbcon: Drop vga_default_device() check from video_is_primary_device()
> 
> This commit removes the vga_default_device() fallback from
> video_is_primary_device() to prevent multiple devices from erroneously
> showing the boot_display attribute on multi-GPU systems. It updates the
> function to rely entirely on screen info to find the primary display device.
> 
> Link: https://lore.kernel.org/linux-pci/20260618081803.2790848-1-aaron.ma@canonical.com/#t
> 
>> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
>> index e0aeee99bc99e..eb584d9e55f1c 100644
>> --- a/arch/x86/video/video-common.c
>> +++ b/arch/x86/video/video-common.c
>> @@ -43,9 +43,6 @@ bool video_is_primary_device(struct device *dev)
>>   	if (!pci_is_display(pdev))
>>   		return false;
>>   
>> -	if (pdev == vga_default_device())
>> -		return true;
>> -
> 
> [Severity: High]
> Does removing this fallback break primary device detection for systems
> booting in legacy VGA modes?
> 
> When a system boots in legacy VGA mode (e.g., BIOS/CSM text mode),
> screen_info_resources() provides memory resources representing the legacy
> VGA window (such as 0xa0000 or 0xb8000). The subsequent code relies on
> pci_find_resource() to match this resource against the device's PCI BARs.
> 
> However, legacy VGA memory is implicitly decoded by the hardware and enabled
> via the PCI command register and bridge controls. It is never explicitly
> represented as a standard PCI Base Address Register (BAR).
> 
> Since pci_find_resource() only iterates over the standard BARs, won't it
> always return NULL for these legacy VGA resources? This appears like it
> would cause video_is_primary_device() to unconditionally return false and
> break the boot_display attribute for legacy boot systems.
> 

To this Sashiko feedback - I believe this is OK because we still have 
the boot_vga attribute that userspace can look at which covers this case.

Basically:

* Legacy system:
   - boot_vga only

* New system, 2 GPUs
   - 1 GPU gets boot_vga
   - 1 GPU gets boot_display
   - Same GPU might not have both

* New system, 1 GPU
   - Same GPU will have both attributes

Userspace already knows how to handle boot_vga only as this is how it's 
been for many many years.

>>   #ifdef CONFIG_SCREEN_INFO
>>   	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
>>   	for (i = 0; i < numres; ++i) {
> 

