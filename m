Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012059.outbound.protection.outlook.com [52.103.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151893BB9F9;
	Thu, 12 Mar 2026 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313162; cv=fail; b=sspPyfh186a/irr56AGywk1+LucPwnwuQ6PKNa9FBTiTNCYhugl8M/vYwdLY1JcM74sHwmWx0VZhmBN+BKHvAJIVxiAAPBwIgazNvLMZr0AuZfw7jr/5o1mMlJeOjnYQ+Ph04wJjmkVRhaJIHGzic/rWRsyEoVTC4AqeNuL+PuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313162; c=relaxed/simple;
	bh=gjoasJaAGjZOr8/xgEZRT4sy7sex6rIykMSSe+otp9U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kEPRMG1TcUnKgoedYuPs2GAFFvKC3P1AgJJK157sCUFB38k5y/5zSX3AYmcpNClPN5KMvs6w0hy6Qu8QFzQa/JepZhm0J8GYsMISliVC1BwDUEURMnCtPaAtV9nD34IH9cJUgN8R8T587MshaWNTQ1MQPJccY2YV252CEOktwhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=FdZ549/j; arc=fail smtp.client-ip=52.103.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="FdZ549/j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVyW26IsS0gBytJhzSCfgwFKoYQAwa8bhdP+3owc1uJPXGcvRynO7comAVtaJqD7KIUV5NUdzMKDPMj9PMoDzeCjtmonhtXxwLZBxRIY7XuaIjxW+5lEHkbvRn8uGcPN5FraalYwiMu39al/pPZUHddUaUiazT7wC2f9A8nE5S5nOAK7Vkr6VgYESn77aslSET9c9t2WDuvwhVqQupp2yFStniBVDmogVloMVKOwd/dOUMUGVs2j4lUTNrS4b5Kx/rMx6n/Emmw3I2SZy39LibQFt4XO7f0OWt4GG1XfFfcL0X89zraw8TuqNpUS0oKDH/Q+9eyK4hNgWA/CVvXYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTlodyEPvHw8A9AYuF03tOiM0u6JIrfR8M6uCqzwqWM=;
 b=oCozW8qpPGRVsLO+OAQiIcpvFRtDNqz4WnUZUGNR4fCtZsRPSTmjN0y64PzZ4I/Kh6ifMKx8lgOo1A64R0brjGyDzSyvJXGjfCGFJuAeW9TOIDcL5KmendEtW96wG7Vb2TCzP0bKEglAh8AhwHQytYR7/7wQji6RGkaEiU2/KHSDGAW0uWnLRCB2/4hqzlXeBS33uifLupd0H/IW5RdAG5LOgWQHw8PJiuDNExXXsyxokQtWIWiEk27GP7fVaoBgihBlvUbMbSuuIi+2+OpwG4oBUNCHdMagovqmApuHD9bs8vgdFeFuhnBN/N3/7uNtECwjDty8HqaYMC1VxVwI7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTlodyEPvHw8A9AYuF03tOiM0u6JIrfR8M6uCqzwqWM=;
 b=FdZ549/jIqpP9nrroZqGQKGuARa9PmQ2quY5/tSQSErt1dQufgeIF16QLeC9WnnXyLdbnluvOaVUUPU3JF5wfXQEsnMmkts1xiIHLDSJSxIM3nz1iNT3FZOCBc+mE8X2KKf3R1cxsiNd947SY8gqacJGGQZ4stdzMUEGuytn4ccDRZR0OMMN45sFB0Zqtvj07gTn+VNAFT7Du3HwK/x17Zr/CZrY7Q9o1jw0/LLGeD6meq4V+oZ3nLFy/U99eRByY/g/tesDcxFVs3wYnHMF8KJPjQ14pgLyo15BTveMnMfm3hDhQXX7iw4XmZC5iiKSP4LCP3Xs6Oy4a1LD4digAg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB6019.apcprd01.prod.exchangelabs.com
 (2603:1096:101:20d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 10:59:01 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 10:59:08 +0000
Message-ID:
 <SI2PR01MB4393D3A8C4188838CC133284DC44A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Thu, 12 Mar 2026 18:59:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] PCI: Add support for ACS Enhanced Capability
To: bhelgaas@google.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 dan.carpenter@linaro.org, akpm@linux-foundation.org, bp@alien8.de,
 rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0010.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::12) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <05f3b38f-5ac3-4537-b938-96ca16378dfd@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: c3dc7de9-50e1-495d-cc12-08de80266061
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|37102599003|5072599009|6090799003|12121999013|19110799012|8060799015|23021999003|8022599003|15080799012|461199028|41001999006|1602099012|4302099013|440099028|10035399007|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1Ayc0V0RDNzdnJxVjN6d3E5NlU3cndnN0pXVVRJVnBlbFlvaEpwR2xISVJJ?=
 =?utf-8?B?ajFIb0loUG50OXJ4NlFMZG1jOUMxcEc3emJqVlpSdFRmdmZGTFdxa3o0dTli?=
 =?utf-8?B?NHBOOGxaNjF0WDI4S2Jrak85aURCWWtGQnU4dkx0TERBK092bnNvVnFzZnVR?=
 =?utf-8?B?UXpjS3pVWUlQTzR1ZloxNGg1anBhYVU0cUpaKzJFa0xCS0ZlcktLUXRVanR1?=
 =?utf-8?B?MmN0dFp3WnExdWRxM2MzYm9kL1JaOVFISTVFTU12cGJKd0ZveklxbFlBYWVF?=
 =?utf-8?B?R1VMWi9DOHIwaHkydDZDWXY1VUhtWEZlc0VlUTdvc2hXK2F0Y3VBU0JvU0Vu?=
 =?utf-8?B?TGNhdkNsMkhKQW5GYm5pVEVFRVIydnVCbGJJTjY2QndjYmMxYldjNnJ5NVds?=
 =?utf-8?B?ZTdFcnJBaVpSeWVmRmRPcWllMmFTMFR0c2lDV2xOM0hCQmNIZzJGd28xZ2hS?=
 =?utf-8?B?UGwzbnU4NjlUWVRVVTlKT1plOUtGVGoyTHY3dXM0UStRb3VvNkF5YUt2eUVM?=
 =?utf-8?B?c2FHaG94eDllZHRKUHN3VW52OFFFVVhNY2lzM2taNzJPWjc2dHpYRjFhM2s0?=
 =?utf-8?B?akx0eStVNGZVWjNhMjZRRWI5L3djMTlabjNjTlBRSDc3OE8yTUlIdzdwSzEr?=
 =?utf-8?B?OUpNd0lITnFNQkkzS0ErWkUzSFZ4ZnF4a2ZyaVphblU3U1VJZ0UzMXUxY2ZT?=
 =?utf-8?B?QXM0cVAwNUFSRXhCUGhScHJlSW1ic2ZtbFhUekdEekUyOGQ2VVljdEJ2RE9l?=
 =?utf-8?B?dUpuVzFxaVRsZ1pYU3draEtsWkNEc2Y4bGZtTHdmeU5nazVLZFo4ZkhsaytP?=
 =?utf-8?B?MCswTFluMUh1UmlVOEw3LzRYOHVsaTF2TFBPeGRSSy95M3lYQ1NocktjNk9q?=
 =?utf-8?B?QzlkNHBSMThyaVJaaENvVDdudzQ2NC9VUE15L2FoTWNRcjhxN3JsczVOeGVn?=
 =?utf-8?B?UndBTU5kOFNySVlSdXpHemJvclRIQ0k3OFZzN1JITklTZktqQU9XOEdWMzNF?=
 =?utf-8?B?NEhsb0hlR3kwRm1XdkU4T2w1emJ0V2FoTi9udkZwdklZUTZLZnBoNFVnWVJy?=
 =?utf-8?B?T1pQRWwvNm82WVZOOTc1NStOSjg4dFRmV3ZRUlEwUENPTHkvUnY4WkhZa2Jj?=
 =?utf-8?B?LzZTMVpxVFovbWYrWUExVXFSRjZTNU5lc1dRbzZqOS9xS2pDVER5Z0UybVlo?=
 =?utf-8?B?Wm95MDNkRzdORFBuZGRCbTI4dXpiNTZUYTl2bnBsRU1VeW5ZSEF2L3NmcHJ1?=
 =?utf-8?B?LzBWM2FhUzE5TGVWcmlSOThWSjd3NHFWc0RSaFo0eVFremVtVFNOTE5tN2d3?=
 =?utf-8?B?aUZLQWp2eFFhNzBMbkV5bndWTFh4NnEvUWtTdDdpUTFoNmI3MzZsQmJ2SU9B?=
 =?utf-8?B?U3VLN1VNMGUzUUcveWNKcWVCT1JEOWpyTVdVQksrblhMUWRPV3BTV0tVWkp2?=
 =?utf-8?B?akl0QUE1TjVVQUorSXFsb0xjSDRqdStzbkpHRE9KQ3pkRy9ZdFpYcWZlcHhF?=
 =?utf-8?Q?cZ3V1o=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTlBajdHUHZPemZKd01qOE9maEttSHdVN2g1Z1J5TkRjcHBqcm16UUVRT0JW?=
 =?utf-8?B?UUxOUjAyV0V3a0NwQ3FzZVRWaGc4dmduWDZ6YnNsVHdEU0tOUngvTE5hSTBw?=
 =?utf-8?B?UUpnaHlZNWJ6L0tGYlpxbGkwRm45WndzYzExVUR4OWZaUS94UEswa25NazRS?=
 =?utf-8?B?VHJvejFvL3JEWDVVYm5KYk0wVWlJTDVaMklVWTVsQ3lKeW1iRExZRk5SV2dx?=
 =?utf-8?B?TXBqUXdwN29xNjJReEdhelBaZ2FNdUx4dHQwV05GeXpDWjFKeEJLeDhVTHZ2?=
 =?utf-8?B?Y21rcnVyU2padGRlRERkZCtPZW12d3RwY1BLK1pTcW9BaEpTL043TXB6SzN4?=
 =?utf-8?B?QWFqQTBrZjY2MU1YdEdaaHhLNzBaNXo5UlJjcnNTdkJqcmJpM1hkZ0F0eVpV?=
 =?utf-8?B?RkQybCsxUmtIV2hITzZreHJwSFl3ZDl5amdtQ2pXTkoxQ25MZGM3NytxS2tW?=
 =?utf-8?B?WkptM0NIZnlqd01jMGdFM2taOUdlYkpEbjlpN3EwR21EcGdQWGF6eU92SGl3?=
 =?utf-8?B?RU44ZWFkRmlzMWw5VTg3ZElwYTRoWTlsRWdlVUtmcHp5dWxIcUNQajNsSUZN?=
 =?utf-8?B?Q1lnWC9YRlp0N1JucVZpYjdtTjh3VlVRN2VHSnh2SDhpMVkvTy9YK0ZlZmQx?=
 =?utf-8?B?SFpDYi9YWkg1WDVoelIzWlM1MndDZUxiU21SVDBBdW8rb0gwWW0yTWdLVGFU?=
 =?utf-8?B?UUl0akZIdGRvM3NVdU5pU2J1REVreGlKamJNSWxwZHJJTWc0MVRUY2dXay9m?=
 =?utf-8?B?bS9MR0lFWnlleG12Z2s5SWJobXhGWlUyQVgvU3E5blRsWjhQZlRVVWVMWU9R?=
 =?utf-8?B?ZERmY0xDeVJGdUM5TnpLYzhEUkxoZ1d4aUlvL3dobytsQ2hRYXA5cG9lRnFa?=
 =?utf-8?B?UEpSY3pIek9oNXJ1VlpxZUYwbTdiYVNZbGlMdGcweFFnTEZIbWo1VDVNKzho?=
 =?utf-8?B?SFFseVk0bkJkSzRxMEJYWmJadW5ldFBtT2kxZ0wrbFpyaTdkT3BRMTlNNk81?=
 =?utf-8?B?YURnSkRaSTBiVjgxaitZekZVck01QmU2YUExT3ZmYmdLak00c1VDZDFPNnp2?=
 =?utf-8?B?YWxtZG9IaVF6UEJiUzJMYllqTVZnK1ljTzA0VXlxVE5SbEl0ZitEYjdQeUFH?=
 =?utf-8?B?TC8zZFNLR0hQMzUvZXFHZWZoclN1T3FiOG5hZnFMOUk1M1ZoNmZWb2ZHam43?=
 =?utf-8?B?cUNXM0FlRU1yanY3VXZzKzl3TkJHdk9zSU5tdUYxbm50Z201NkJJQXJzYTZB?=
 =?utf-8?B?eCtLZFN0cndEeTZWenFub0Y2ZzBMZDFCMUs4cHFiODNIRnl5R3ZzUnQxM1F1?=
 =?utf-8?B?WWpIcEl5TElkMU1CL3R4TTE3cVFHTlBzc0lKL2xNNHZvMEFBYnJjTHhUaHIx?=
 =?utf-8?B?WUFINVk3RDlFVUNVY3A3YW1sSXBzcGZoczcrQXEveU9CNVV6dkdYYlV5Um9H?=
 =?utf-8?B?Rm41dllYL1hoa3JEdWpFcXVTL0dQZVVjdmxIbUF4ekdQYlZKYU1zOVUyM0tq?=
 =?utf-8?B?ZU1CdWNVVFNFWHFuanB6MEtCa1ZNSmpZQlpCSE1QOGJjU05BRGpYc2F6Z3JI?=
 =?utf-8?B?RDRxaCtKVk1qL0ZZNHcxc2t3VHRNbmJwNm5rNTR5Zy93MEN0aHk5cVU4SUJH?=
 =?utf-8?B?WUhyc0JucEhRZEYxdUs1NE5FVXhwaUw1NUovWFdNQVZHakJCbmZBT1RNWCtZ?=
 =?utf-8?B?V0UwSUZoSE9WZUk4ZWJ2RUMwZ0hqT2ZDTWtpa0VwUmpBbU1tV0pRdTJzaDFO?=
 =?utf-8?B?TnVaTk0yYmY2KzdOL0RWK3hqdFU5eXVyT05MSHlxa0ZxcTI2ZElJNy81Q01w?=
 =?utf-8?B?OWZGNXF6TCtsUmRLZzFFSW5HV0ptUGxwVDJtTGFDTG1oeGxqVUxUa3o1cU1h?=
 =?utf-8?B?MzJibTVFQUt4b2thTmRPVzhRQW9wSVBUTHlRbGM5M24ydzllaHp0V0tpaVdZ?=
 =?utf-8?Q?xqfxfHFr3uuiCYEuUTbyZ/fVmcMt9nCH?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dc7de9-50e1-495d-cc12-08de80266061
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:59:08.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB6019

On 3/12/26 5:06 PM, Wei Wang wrote:
> This patchset improves the core ACS implementation and adds support for
> the Access Control Services (ACS) Enhanced Capability, introduced with
> PCIe Gen 5.
> 
> Improvements to the core ACS implementation include:
> - Validating ACS enable flags against device-specific capabilities rather
>    than generic kernel masks. This ensures only supported features are
>    enabled while safely ignoring attempts to disable unsupported bits.
> 
> - Consolidating delimiter parsing into pci_dev_str_match() and returning
>    -ENODEV when no further entries can be parsed. This removes duplicated
>    logic in callers.
> 
> - Refactoring ACS parameter handling by splitting the intertwined
>    disable_acs_redir and config_acs param logic into dedicated functions.
>    This improves maintainability and robustness while optimizing parsing
>    with better validation and readability.
> 
> - Updating the config_acs kernel parameter documentation to include an
>    example of multi-device configuration with distinct settings and
>    advising users to quote the parameter to avoid bootloader parsing
>    issues with the semicolon separator.
> 
> Support for the ACS Enhanced Capability is built on top of this improved
> implementation. This capability provides additional access control
> features that improve device isolation — particularly important in
> virtualization scenarios where devices are passed through to different
> virtual machines (VMs). Strong isolation is critical to ensure security
> between devices assigned to different VMs and the host.
> 
> In Linux, device grouping assumes that devices in separate IOMMU groups
> are properly isolated. To uphold this assumption, the enhanced ACS
> controls are enabled by default on hardware that supports the PCI_ACS_ECAP
> capability. As with other basic ACS access controls, these new controls
> can be configured via the config_acs= boot parameter.
> 
> Support for checking the enhanced ACS controls on Root and Downstream
> Ports has been added to pci_acs_enabled(). On devices that support
> PCI_ACS_ECAP, these controls must be properly enabled. To maintain
> compatibility with legacy devices that lack PCI_ACS_ECAP support,
> pci_acs_enabled() simply skips the check.

Forgot to add the changelog here..

v5->v6 changes:
- Patch 3: In pci_dev_str_match(), explicitly set `ret = 0` when no
   matching string is found. This resolves a smatch warning that `ret`
   returned from sscanf() may be 2 or 4 even though no matching string
   is found later comparison.
   v5 Link: 
https://lore.kernel.org/all/SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

> 
> v4->v5 changes:
> - Added significant refactoring of the core ACS implementation (Patches
>    1-4) to improve validation, safety, and readability;
> - For USP and DSP Memory Target Access Control, added masks and enum
>    values for the encodings and explicitly rejected the reserved encoding
>    (0b11);
> - In pci_acs_ecap_enabled(), removed the use of 'is_dsp' variable.
>    v4 Link: https://lore.kernel.org/all/SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/
> 
> v3->v4 changes:
> - In pci_acs_ecap_enabled(): Check the pcie type for
>    PCI_EXP_TYPE_DOWNSTREAM explicitly.
>    v3 Link: https://lore.kernel.org/all/SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/
> 
> v2->v3 changes:
> - Drop the warning when a device has no support for the enhanced
>    capability.
>    v2 Link: https://lore.kernel.org/all/SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/
> 
> v1->v2 changes:
> - Enabled all enhanced ACS controls by default, rather than just Unclaimed
>    Request Redirect (which addressed the primary issue we encountered).
> - Added checks for enhanced ACS controls on Root and Downstream Ports in
>    pci_acs_enabled() to ensure proper enablement when grouping devices or
>    enabling features such as IOMMU PASID.
>    v1 Link: https://lore.kernel.org/all/SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/
> 
> Thanks to Jason Gunthorpe, Jonathan Cameron and Dan Carpenter for reviewing the patchset.
> 
> Patches on github: https://github.com/wei-w-wang/linux/tree/v6-acs-enhanced-cap-and-refactor
> 
> Wei Wang (6):
>    PCI: Validate ACS enable flags against device-specific ACS
>      capabilities
>    Documentation/kernel-parameters: Add multi-device config_acs example
>    PCI: Consolidate delimiter handling into pci_dev_str_match()
>    PCI: Refactor disable_acs_redir and config_acs param handling
>    PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
>    PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()
> 
>   .../admin-guide/kernel-parameters.txt         |  32 +-
>   drivers/pci/pci.c                             | 274 ++++++++++++------
>   include/uapi/linux/pci_regs.h                 |  13 +
>   3 files changed, 224 insertions(+), 95 deletions(-)
> 
> 
> base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8

