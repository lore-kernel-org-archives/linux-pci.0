Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FBC2ECE93;
	Mon,  6 Jul 2026 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360071; cv=fail; b=LagHydqKHfkiE3hqe2lS5rey6gz5S8B1O3b+tXojj9zlaER9niM6yWJTeXkBUS3H8FrcyzKGnvjWWbbxb53/IlqPZ2mhsMVloaWIs1j9Z76z2D9MNyAESGNkVif3Tbs5IXxqos8b/JPLyeTxZHQ2V1+yf7TkYnPqH4KH0IX36kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360071; c=relaxed/simple;
	bh=DQC30KGMqSLzhHFHPeNB7f52tdJlLmYAUMIxQzNI4Ko=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fas6j+aJYEsA4+BYIj0g6UUxba3PoqOut1FV61l8GI+hMlj5HiNtfeeryOSe3mVgDkZXnTmac/M2AZ7IOI1mX22Gq6VFe5Q1iPLCl81/dPTGzlrqZMW7XVv+m4AD5xuDxbjXSjn+qAQvP5bLRnkRTY63YEWVvIFrTUB4r2CA6Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TouO49EI; arc=fail smtp.client-ip=52.101.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TouO49EI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idUZwbAIPCA2wvcbATWDlZhQMKEaCchNl5hHIqtlItjJNOFx1aA3g0WOVMMiJhzhSqW62N5DXE8/xYWL0RfvKsZF6yWmAngWr6hbUM6guO/qDS1LBae7/PVeKsVORUwnjUbJi4stgwEo6ASZpUl6Byp4GJ51281n+ZJ2SDQWLM/eZ+KqxKCvNuKDkuqukUWoPgeV0obrBwir/DRQEkyILomv2lGsGXdWg1upItjOga4RAML/oL1GJt8Ng6VljU9ULD+or2T/k6fUhZzqpr0nmSVVLVIbeBeR1W+2zap3DtKkvMZ5NQoiWxXiXHZWHhHOtycj+Brpx17PJYQgaxxU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxruBamjwC2e5LYUEGmT45FjOBKGW4X2MogyL9mjEHE=;
 b=tXBYzdzKmGedmVXMW6EEDCr/cThVK6PG4HGb/MnyR6WW6C0wHPTPfyhGj267i6jYUZQMwo9Gb80mICkfaVslOIN5VF/PRIiuPPi5tRXeVh7XoPIWtQu+Owfb+UvJrptYuCXq+P+hLsIB2Xr7wPDiikoPyOFXLHHYhRZljFhh3Ai2LIPgJSL9tGA8tBCdyKmCtLrNYWQLbW8ZkxtxZwUUDSBLeS3Dh1I9c+rYESIqxbLr+06y6MqjbRphVC0f+3x8WY4B6Ajc+JaYeRxfJxjCZacxeKS+8C7s89t5Jy7NPrmfrTOMY4qrWyUfgnPCmVRgKaiz9WLtqJpK89WfCXKBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxruBamjwC2e5LYUEGmT45FjOBKGW4X2MogyL9mjEHE=;
 b=TouO49EI2ZumzWxb80wOuOUigMrwlihLSItuACAqbdPl5xJGS2UzphzcRDkE6g0zaxP23qW3XivTMZAV9oyJ/xGtgkEa4ZxXAm3bEsK3Rdje/jyGPmQ2EH8TiWjUQkHqvbWSsxOuJU+2qBSJuIfKlFZdFxgLC7rpOG0UzxenAtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ0PR12MB6944.namprd12.prod.outlook.com (2603:10b6:a03:47b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 17:47:42 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 17:47:42 +0000
Message-ID: <a23f2003-4ceb-4307-a469-dc683e6eb0f0@amd.com>
Date: Mon, 6 Jul 2026 12:47:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/video: Only fall back to vga_default_device()
 without screen info
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
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
 <5ef1c84d-729e-4b9d-a3e4-dc20d8242982@amd.com>
In-Reply-To: <5ef1c84d-729e-4b9d-a3e4-dc20d8242982@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::19) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ0PR12MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eebfc2c-5d94-4ddd-a792-08dedb86ad8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	v2ePxzmL91W1Yx+RtHLOBvHXIOlRusfTEl+Hs7zAe5TIwQ8rShtNT0T0ImU4Zd8w5nLmOZf51xV0yYbJ2j9AagL3CrvJcYa9KMYC+ikArlzomoWGetMhmQkGmDhWx9PpNUo0GASIsWm10vipJRQUYyThi5BFUBs7lRr2sL+Zj7kgCprPm3ydO0jE0jw4O8U9jfvW2c97kle/L2R69GIT2MFhaXI02GIEi6HQL1H0tZj8+Q7XuG3RUgG9kFO7pu0VxGS4tRBMTBGqk2PP5q/wFVFtQkaS2AUwmXLSpxwsKY8MOk+rg1rBBJllPuUY042xjGv628tfV+AIXOwlNF8phkwi4RRieks7+Pgz2PS12GruRFbsHxJyTQE0Q1LlyKR1CHXG1fLcrGKU4RZljVaFeG3D3oau5PDsKIj+8tQ64yGN9JEzyN5VUmY/TvFSUxoqwVFXHZEFNIWP6kPbY61OzWltfN8gSx+d8EK3ulg1tr/MavhLRo8R2vA341HU0bBJI4X2Fpn8OggWLtqfUOgmRwlhzt+fwdqNJ+OlQK11gfZCXOvdIASqr/2QN00lx6iSbfdc1eAxqp4jyr2Or7/jTX38aWi03vc2+MSclBvcW0/QLqoSqYEp02yIfd9rXgRDoJEzDmS4YPgG20XC1ZenMomzipAion8O7SZrV4ftDOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1dFalU3WXZ0Rm1USHZybEt6L3BlZkdLVWFReWxsQ0o4WEtqOVk4aFdxVzRO?=
 =?utf-8?B?NnNxcTJZanRvR0JKZTAydTRUeUx4d3JrUVNBM1lZTGRHeW5LT2JZNVVXWXVm?=
 =?utf-8?B?NlpsanpWK3hZdHJ6dzFjOXE0RVRreUdhMGlZNEtBZGNFVE9jcDAvYmhmczQ3?=
 =?utf-8?B?WTdRNlJnL1Nxd2g1WXFwbVRnOGl3WkNraUZ3YjZQOTBsdkF0U3E1SzBJZHpF?=
 =?utf-8?B?aFJQUE4xYTJLdnNSaDdaWXd1NHdsUTR1emtobHFVd2pnWWpnNDFnN1h1UjF5?=
 =?utf-8?B?UDhYRFFUSUFNMUR2ZzZTcUJTamswanJRc1BqdnBsck9mTFJjN1l0amt1bGV6?=
 =?utf-8?B?TDhjUDFTN2VDODhOWmZZWEhKbERKcWFkWEhhZVo1QzY5RXYzSldnMk4reE5q?=
 =?utf-8?B?dkdTOW1GYlptMjhMUXRlR0tZTXhDQWUxbzlSZGVYeTJTTjNCWmNJdDk3VzVw?=
 =?utf-8?B?ZldhREFVaFliRHNWVU1saURNZ2JCbXVjQWdvU0JhWUUrSnM0empLTEIvNno1?=
 =?utf-8?B?T1NrTWNMSHNHYlBtWFc2T2Q1QlRJanJPSzk1djI0aEhrTFRaakxWRGxjQUhL?=
 =?utf-8?B?REQyNHN4UWVYdVBrd2hDM0hqdTkxcjUxNXF3SzhyYWUySWlrbVRtNHlFd2xm?=
 =?utf-8?B?OUNVZ2ZWTW5lTVZBRHRmYloyRmF4eU0rd0JJb05reDVxbUNqNDd6R2l1bXdJ?=
 =?utf-8?B?Z0RVWERraFhoOW16dkJIaEJBOWhQaGZyNGFDSk9tSWhPM2QzMFk2dUJIREpt?=
 =?utf-8?B?YUJmTlVmS1kwZkdXRTVGT1Y5d1dHUDFkVVR4YmtVYktKMVBQMEJTWjBoZkRj?=
 =?utf-8?B?b3ZTRER0ZVROaVBsRjA2Yjl5MFhVK3JWRlVNcloxQmNJZzA1WEMyWTNlSERQ?=
 =?utf-8?B?dU5lNk5xWjh1UTBLM1pHUk80ZHlaTTRnbi9FeEtsQnlQdkZabENJdS85aVV5?=
 =?utf-8?B?dlI3ZlpVdDJNZkgyY1VBMit1WitvRXpNSHhjMTFzdzJSQUVFeFJ0WFliYXNU?=
 =?utf-8?B?aGVqVVpSM29nc3hrZkYxd01FR1RJbFhVbUdOb0s0VDFBV0V3TFlDcGxaMEEr?=
 =?utf-8?B?YWZhMnlUY0EwNHBvaUJzSktFN3JIZE1qek9jaFRacXFmdFZKTmpZeXRLb2tT?=
 =?utf-8?B?N1RaL2s4V0c0Wi9iekorK1pzODZsQ1prQnFiUi9Cb2p1cDhIWTVIeXNrWlc0?=
 =?utf-8?B?RVQ4MG1XRFZtaloxcTh3OXRFc3g0UHRISlhBQkpGRnQrRTY3Qy8xQnJrSUlN?=
 =?utf-8?B?MGF5ZXVETTh1SjhhZ0t1VGZPZWR4SzFPZ3ZvTVYveWFJblYxQ0RUWDdVQUZw?=
 =?utf-8?B?UnJZclhDd2xEQmdNV2pyZU5CUmpMa3dIQkF5RjY3NlZCdnRua3dua0lGUjFB?=
 =?utf-8?B?SGROSzdlSHpEbXRpbU5NcHFBb2ZPbWszbWJicHd6S1IzYkRHTGdyTE5NZHZk?=
 =?utf-8?B?YzhLRSsva2FzeWY0Z0RLUW8rYkJITUhYVkFHaTRjbzllNHJXZm14eFBMUW1W?=
 =?utf-8?B?eHpkN0hhc3luaE9hdWFWa3o2dFJJbDhmdGExSzZ4bVRpaHBHNEorKy92NGln?=
 =?utf-8?B?TWxjTkdyUmF3UVZTenVnL1hBKysvdDhJeHRKSG4wcExMOTZuVUIxOEpFeVhG?=
 =?utf-8?B?NktmMlRjVzE4Smp2UURKU0dpTjE4Z041bWlsY1dkSnZiY0F1azFBY0lTUHBX?=
 =?utf-8?B?QnFsWGxPekgrRnh0eFVDaDFhRmdzcVJJZnZHQ3plZS9MVUVJWW1ZS016alZT?=
 =?utf-8?B?d2dBcWhHN2tNUjZsWEQ4TDdrNnhST1BOZ0tmSjExTHZLMktSaC9VRThZejNU?=
 =?utf-8?B?R242cE9yU01iNkgzYkk3NkhUWWV0bERTZ1MxS2ZkZUVXejlkQXdZZzRSSjR4?=
 =?utf-8?B?Y2lIUzNpcmxLWG5HNmhrY1c0NXNmbmU1L3dhODRJK1FyRFlOVk1MRWJOcC93?=
 =?utf-8?B?aVIyM2lwbVcyZGwvL1I2TloxODJZY2FmL2c1dG1ZYjhWcHV4WUR1Q01UL1Z3?=
 =?utf-8?B?OWxvcGtpRXp5eTlXK3lXL0tSYTJhbXBBVEVpQ0Mzd0lVQmJhdXpJZjUvd1Ra?=
 =?utf-8?B?VWIyNERVcHp6Rndnb1NqdENuU25mMWJTdENpT0JJakRNM0RIQ2tGZkNtUEFF?=
 =?utf-8?B?WDhQNjZNMnMyMmxqTE9Zc1oybzJsZWoyWnVzUE02ekhhMFZaOE5icGdJcHhh?=
 =?utf-8?B?MVhNVWk3eFBxSDF6QVZDVk14eFhSdnpVMnJYSkdVMGhUR3EwSnJDTWMxblA3?=
 =?utf-8?B?c2JqTFVCdXpKdGFQVU5oU3d1a0xQZzF2KzB4U3FDN3VnbVlvSTE0ZWZaeDJr?=
 =?utf-8?Q?deYAlJ/xJ9hWFnF/Kk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eebfc2c-5d94-4ddd-a792-08dedb86ad8b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 17:47:41.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2qtvurzrnDH5aEqGpbPuDqCc2q/LSLvAiGMSYiS8gks++ONkUxlOOzZOvGLSgwCleaIvmFKAU+yXEOwFdyiQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6944



On 6/25/26 17:58, Mario Limonciello wrote:
> On 6/24/26 01:45, Aaron Ma wrote:
>> Hi Mario,
>>
>> Tested your v2 patch + Xorg MR !2242 on the hybrid system
>> (AMD 0x0380 + NVIDIA 0x030000, EFI framebuffer on AMD).
>>
>> Result:
>>
>>    AMD:    boot_display=1, boot_vga absent
>>    NVIDIA: boot_display absent, boot_vga=1
>>
>> Xorg now picks AMD correctly. boot_display is fixed.
>>
>> Tested-by: Aaron Ma <aaron.ma@canonical.com>
>>
> 
> Great news, thanks for checking it.
> 
> Bjorn, can you pick this up?  Or do you want this to go through tip?  I 
> can see arguments for both ways.
> 

Boris or Bjron,

Can you pick this up for fixes?  Here is the lore link.

https://lore.kernel.org/linux-pci/20260623141505.1816786-1-mario.limonciello@amd.com/
