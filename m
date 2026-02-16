Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013080.outbound.protection.outlook.com [52.103.43.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A351220F2A;
	Mon, 16 Feb 2026 02:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771209304; cv=fail; b=HRRCmk2FxQ8uqV5zCguJO8ciixDYBeDeIN8pvXDPhgjrCrB1Oddf54gR84KykSAg2P2trCCZQE5auItw+Xlb5LtG82rzvRuIx+ae76/YeCdwIzZWlXrRsIX8Sy2VGvTYNTpRsZLXdvQcLL9kqDq5oFBLQ4Dpk/i7wpelA12X/qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771209304; c=relaxed/simple;
	bh=H8k3pU0PptSVg6ew7wX8dYqa8qJ0qZ298KMgNT/QEUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tuYjaS+rbAULG5I6bPTz63/T2jk/IwlWyjhppisODonCAe8I0e06AQ5+kqCL1GR1L9SueFapgKjaB8cNsgvDWgMFVijGZc0JWo+EJxaO3MX8r8Z7AhJjRT55SFj6oLRyrOxytL0Jc5fnPV5tLJjYvIpG6keekd6V4Lji6yeYNcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=r8vtsP3o; arc=fail smtp.client-ip=52.103.43.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="r8vtsP3o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wO8iN3K94ZGDLRHry5viO19e2liAOIfXpqKtGSrIGeKzIhEbZ2D0g52KBBB+I7gOd8aKBbJ5W1a3d4QhreyMfEVT7/4cA6YD+0sSbrQBM9xPvG7TsLqazBq4sgE0bNYTqPtDv94t+frFLx5ZXimszwsKXaTFWyTgGO8AViweRE/UTUQkjNOICUeSQUjqsiVZT+Yn85yYSrTRLnQ4FgDhsSRGF4+tgR8P9RWi1OkLGmCEc0+E6a307PtbyQGlmmVAOt2jZPAsxGpXIl+JfTROUNhKRxnhrrsVM96kjNPfKIb7zi+dmXvwbPjLviTIh7KUzKYRbDyTZkl0PPLvvBDdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0nhux9YkY2+hdiX5NxhzNmu8QbC7HZFG7adL1puiPI=;
 b=cRGvr4kcnkEGDp1zpLUw2e8ZpjUBkUHVykww8rniJUzXb18OAVl6ZU66f/si1l5O1JOo/p+PYlIEFmbbM/jI3SrVO9kB1YUAzUYFmDdd+xP5uguPzQRXDJ852/XoPa3t1vOFL003etlrom81wut83RpDAdXlYog6TbnF6fQE5Fvxqr8j2E7x5pkE480rvlNvwQzAzMcMLSDj2J9lmRorPntd4JWXdZi7dgvebWaVSWVA9PvvYdkRdhtrav66sA7DQrRpA35+RlsI2vfdmDi/hNsqn38MnrkhXbkYQ2XANfMmjgmI4S88k5Wcy4dGqcj3fKA7+VvXRSU1vPTi9PERBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0nhux9YkY2+hdiX5NxhzNmu8QbC7HZFG7adL1puiPI=;
 b=r8vtsP3owpkcbj/1ipwEdX/VNvo8O96jwOzQPFqScoDVgAOOABiZSDmUxsYRLe5YQhGOdHuEYemkZUKy0iX0mhcW5A7e+vAVkSxRWA/TMdLncAAESdsCsALMPh0Ij3WtoBjn/QXi8v4LoWmq9IW59+oV/dU+f2TPg5TmTG455TeBPKL0bcyDWz6Lc4CQs5D1x0UeYyJDLKm/L2UTkurez0gayoeikbFwVcHgv3j1xae0NPzKmB6So5PE+rCHTeZYNh0HbOzRwnXSz3BHrsWXk98nWoI4zq0J5KEOl0JCKB+gs0G+XmWhzj4RiG7g3cvku7RHECrJcdAOQm/z5xfXRQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by PUZPR01MB4834.apcprd01.prod.exchangelabs.com
 (2603:1096:301:fd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 02:34:58 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 02:34:57 +0000
Message-ID:
 <SI2PR01MB4393FFC6F4AF517BAA0F3589DC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Mon, 16 Feb 2026 10:34:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] PCI: Enable the enhanced ACS controls introduced
 by PCI_ACS_ECAP
To: bhelgaas@google.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 akpm@linux-foundation.org, bp@alien8.de, rdunlap@infradead.org,
 alex@shazbot.org, kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB43934A39792A32D5058876E5DC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <SI2PR01MB43934A39792A32D5058876E5DC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0046.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::9)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <54ebf622-40c9-45f3-a2b5-eafecdabc3af@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|PUZPR01MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: bc38ea12-2981-4d93-1d9c-08de6d03f967
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37102599003|19110799012|15080799012|8060799015|12121999013|23021999003|461199028|5072599009|41001999006|51005399006|6090799003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SSsrNjRWNmh5bmJ2VWN4QjJMaWFvOEMyQ1lVa1RaZWFpaDN6WW85dXhqWXdx?=
 =?utf-8?B?U1J6Q0RQY2Y3MmtJeGIwUEF4K1VjUjdOS2xFUnFPV2xsNVp1Zld0K2RRMUJK?=
 =?utf-8?B?aVd3U3hvcEdVUUlUem5BSERSZTgvMTVncGk5ZUtMdXVkcWFpU0ZaVkVvY1NP?=
 =?utf-8?B?WjJOaTFTS0tZL21TTmp4cHkwWVBsNHdidm1pVjFLYnhDbG5RL2RWUVJISnEz?=
 =?utf-8?B?SFQ3Q0tZckZYY2E3UVIyOTY3dXptNE1GWWxtSndKb3NlYzJpY0hBQXJIY0Zn?=
 =?utf-8?B?eGxDRjJKYmw2aUVhN00rZUtMVlFvQWtLdWhLenRObENETSt1R1JPQU5YeUlE?=
 =?utf-8?B?Sjg0ZmI4MHNGNWJBKzVOSkFnSHU3M3lSRzVmK0laY01jenNSUUx2U2o3VEZQ?=
 =?utf-8?B?eEl6NUxVbFA0VGJMbDZMcUJBUklwakJuZEd3dUN3VngyN1Q4QjhrUlFXVDhT?=
 =?utf-8?B?K05UQkczeFJYMy82RVd3Ymk0cnNEeHlNalNLMmJ5bUkzT1piRlp3OW5jNU1U?=
 =?utf-8?B?SHBYVlNPdjVCMHdHaW1wb01idzBTeldDNjMwSEFLWjlqbXV5VHlFNDRjZDJY?=
 =?utf-8?B?Z2MxTGUvTU1sblJDL2h1TjBwNkxVY3BzdlRyRStGL0pESStBUFhiZjdEOHA3?=
 =?utf-8?B?TDVrYTNXeEI3bjNEOVRzdGtlTGxtMjlEciswZit6enl5enpzVVk2cEVQWWUv?=
 =?utf-8?B?QSs1MlpMQytRUUQ5ZkpEYXdtNHJqdU1XeThQc3NmYmJIZmx3QWZZbG9CZjJo?=
 =?utf-8?B?VUtKNGYyUGd0Tk04REFOQzhiVDdPTWJKOUF1V1RTZ0pzY3BqTDZ6aEVPakxR?=
 =?utf-8?B?TUFXSldTVmFqNE4xOG40VHdFb0x4NGU2WGFjeGlIdkhmUHZCdnlsNFJVUFFN?=
 =?utf-8?B?UXBxRjNnREJ5anNhdDdZYjZIeld3QW5ZWURPL0l3WDRoTnhPMnltenNyN0Fy?=
 =?utf-8?B?dDVzaVZ5d25kSmsvWURkc0duM0s5QkdsODNxVzF4YUdOdzdCQ1lYVjBpRlkv?=
 =?utf-8?B?eEswU0N6OStGTzNNaHBYOUYxb2F5UzRZTzFUOWZGZWFQK2J2c3AxdVZ1STg1?=
 =?utf-8?B?ZFl4SUp6a3pRcS8zWitKVzNHRTUydnI3MTFCNElJcDYwSjdTU0tJYUlTWldP?=
 =?utf-8?B?QWF3dmd6T0VTQnJId1hIRjF3aTlnTktyYUxkenRVRTF5NVNVZkxLVTQvWk4w?=
 =?utf-8?B?ZWJPeXFJRkY1U1RESDY5R3FTejIyR3RSQ0YyWXhMVDZNbmdjeEhmdGFvV09H?=
 =?utf-8?B?RmppM1lGNWUzQ1lLK0tDYVZFR2lLNG5iR0w5eFJ3Tis4SVRlUytEWTZhK3kx?=
 =?utf-8?B?ajArdUUyc2dTK0Znd0ZRTnZFWjJjMkM4bC9oWFAvUHVTMllhcnd2SlB5d3RX?=
 =?utf-8?B?R0U4WTRaZi9UQzhkamc4NGtEMzRRZ0lSWU9GRm5ueXJ4bkNiaVZwcXZXYXdy?=
 =?utf-8?B?VmhmcUkvMmZ2d2RtSlkzQVp1M3M1c21MdC81em1uVmZKN2FDTnlYVHR1UzZU?=
 =?utf-8?B?TDkybzBRNlpjK1dVNU01U1dRcDJ3QU9SMjgzWlgvTUJ2eGFQZ0dpd0J5NTUr?=
 =?utf-8?B?dXFtc3BTQzh4aGJUZkM3OFYwUzlKRUdXOU1mRWszV0ErRHZSNEh3OVo4Z0xW?=
 =?utf-8?B?VU1OKzNCVWJSQzlYdm9UQnhFMi9IYzcvc1hadVp1cWRLZXplZ1AyUWl2Q1dj?=
 =?utf-8?B?VEluZWdXdGlzS3VKaU9hVmZLM0FWVVNzbUM5QU4wSmUzbFR1ck5iYWhkbWEx?=
 =?utf-8?Q?4N+T97Qc9wXWsLxXIE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTBrTk5YRXJhS2NZU2pRdmFtMjA2ZFNzeHNxK2VrTGxDdStoMW5WWTE5QnY1?=
 =?utf-8?B?T3gvdmpRUGRWLzVQQk9QM0tNOFkrZ2F2U2NtdEtIdHVvSVRFTkp1VXEwODA1?=
 =?utf-8?B?c3dzU3RML3VqbTg4cDhGSzNIQnNQaVR4cEREdzlLRVZUSUExRW8vak5WQjB6?=
 =?utf-8?B?b05wRzZWYkZ4MG9nVWlEYkFtVUxZNmJESmI2aW1BaExMWndEdFp4c0RlQmFJ?=
 =?utf-8?B?Z3c0eGxRZUhIVTRndzhLdTlvdTNlOEd6dFVUMkRQb2UrYVo1ajFrRWZjcFAr?=
 =?utf-8?B?Q2MzcEF1YjAwR3VvNkY1RW90MmUvdkdNNzdleHhmRXBROGpLK2EzWk04NVlE?=
 =?utf-8?B?Zi82RXFVSG9pSXJnUVdtMDBqT3VqbWNDYXVIWjJDSzFJMkMzSk5vZlcrQ0Rt?=
 =?utf-8?B?ZkRaTlVhaXVQMVZkL1h5YzljbS9GQ29PYzdaeE9ReGQ2QXpPRVZKaGNxSkFB?=
 =?utf-8?B?T2pnSU1SOVNsN2srZWFxZ0lLNi9Dd3ExZ0NoeUJYMjF5VytOSVhjcGpnaWg3?=
 =?utf-8?B?YU9aZzFXRlFDc1o3OTQyY1kzTS82MFA5bVdqM3MxdHBwWnNVOVF2a09yNlFF?=
 =?utf-8?B?ZXFBOWJRbER6NGxMR3MrU2dwbVdxMHY4SUVPRTJ3M1VnMHEzZW5hZXhaejJo?=
 =?utf-8?B?T1hzUWxpMlVFTytORHUwWGwvdlM0eVpSSk1JYUtkL1ZtdUI4dXVRMW91VlJC?=
 =?utf-8?B?ME43S0ZSTFJvekVweG5ubkZCcTdNM3pVeFp0WXNlZER5aDdtTTFvbWJhem5T?=
 =?utf-8?B?bUVqVjdoZFgrTFhEVmE1WWRlckxja1ZHY2R5QlB2SFJwdXVnSTJPNFArNXdn?=
 =?utf-8?B?Uldta0g4RWxTNDRKdFAwYytKZjJVajRvVUcwWERQZU1PNHhRQi9JRUZIbWlr?=
 =?utf-8?B?cDMwMFY4VmkveWxoNU1qZGZ2eVFGVU9McmFuUUhNaDZLNW15b1picVJPMUpq?=
 =?utf-8?B?b280NTNBOGhrNE5lQ2t6Q1I1anN1aHRQVVF5KzRXRXdqb1U2OHl1YlJpclpF?=
 =?utf-8?B?Q2tzYTRvNGZTQmxBbTlMUjRyMnRUeHg2NVNUTDh4WTlSRzhoL3BVbEwzczdX?=
 =?utf-8?B?Z3NjKzQvRXlQL0tXTHQ1eUFMVFRDOTRnektFSkxKNWVGdjR6NWo2QS91UnJq?=
 =?utf-8?B?ZFpldTRkeFhPTlpQRHFGNDhmRmlCL0QwQk5QdUpvOEJRdU5xY3JiL1A0c2E3?=
 =?utf-8?B?cEpvWFpqb0hWWmNkOGlpakU1QTBRMDg3dUk3NWwreWtnNjJ2dC90R0YwMG9q?=
 =?utf-8?B?QktGTFoxbWdUN3c0NDloekJxclZLdUJoSnAyTmlMNlpjdU1IZG5kUmZnT2ti?=
 =?utf-8?B?RDY1RlVlMndlL1Z5V2JPMTdMUmpVT3B3eXdENnRhTkZ5QnRIQ09Xa2FrekJl?=
 =?utf-8?B?SFYySnpIZms2SVNwdWlNUGtGemRFMjhSYnVoVG45YXY5RHpNRTNVVGRCUERr?=
 =?utf-8?B?UG1KVTVNT29NaDloNDZxYVFjVzU2bUhqR3BzTkRRTHVCMnBUYmQ3R3lta3k3?=
 =?utf-8?B?Z3RWbklRN1B5dFlPQmZXL29LdVRrUzZjRHp1MFFwaXo3L05uenFRLzlvcmRl?=
 =?utf-8?B?djVHdlc4SjU1UVNpYmpXRnhEQUZPczZtSHNiQ1o5aWVWY0xGOWZLaVo4eVY1?=
 =?utf-8?B?N0hnVWx3ZktOclJTK0RoTmxvM1RjMzh4RkxwQWcrV3FtbEppaDU0SFZiMTcv?=
 =?utf-8?B?TkJtdXp5MUlvbDkycGl0MmR6a01ZLytHeVArOTZMMHk3Mk9WdjhKSDhyQlJR?=
 =?utf-8?B?enpoWDROVk8yUDBsWTE5a2h5a1dUMjcrallLODNOcjNUc2dxa0RlOUxTVDds?=
 =?utf-8?B?eUpkMER0UW4rdERqWjM4QXh5RGhteWdEUVB6c0VFRTMyMmwxRGwvVDZEeE1j?=
 =?utf-8?Q?iB5woDnM/aYGA?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bc38ea12-2981-4d93-1d9c-08de6d03f967
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 02:34:57.8598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB4834

On 2/16/26 10:26 AM, Wei Wang wrote:
> The ACS Enhanced Capability introduces several new access controls to
> improve device isolation. These new controls are particularly important
> for device passthrough in virtualization scenarios.
> 
> For example, a DMA transaction from a device may target a guest physical
> address that lies within the memory aperture of the switch's upstream
> port, but not within any memory aperture or BAR space of a downstream
> port. In such cases, the switch would generate an Unsupported Request (UR)
> response to the device, which is undesirable. Enabling Unclaimed Request
> Redirect Control ensures that these DMA requests are forwarded upstream
> instead of being rejected.
> 
> The ACS DSP and USP Memory Target Access Control and ACS I/O Request
> Blocking features similarly enhance device isolation. Device grouping in
> Linux assumes that devices are properly isolated. Therefore, enable these
> controls by default if PCI_ACS_ECAP is supported by the hardware. As with
> other basic ACS access controls, these new controls can be configured via
> the "config_acs=" boot parameter.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Hi Jason,

I kept your Reviewed-by, but this version includes some changes
(added masks and enum values for the encodings) after your review.
Please let me know if you have any comments on the updates, thanks.

> ---
>   .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++------
>   drivers/pci/pci.c                             | 10 ++++++++
>   include/uapi/linux/pci_regs.h                 | 13 +++++++++++
>   3 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bfd13197658f..f8444fea9914 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5281,13 +5281,22 @@ Kernel parameters
>   				flags.
>   
>   				ACS Flags is defined as follows:
> -				  bit-0 : ACS Source Validation
> -				  bit-1 : ACS Translation Blocking
> -				  bit-2 : ACS P2P Request Redirect
> -				  bit-3 : ACS P2P Completion Redirect
> -				  bit-4 : ACS Upstream Forwarding
> -				  bit-5 : ACS P2P Egress Control
> -				  bit-6 : ACS Direct Translated P2P
> +				  bit-0     : ACS Source Validation
> +				  bit-1     : ACS Translation Blocking
> +				  bit-2     : ACS P2P Request Redirect
> +				  bit-3     : ACS P2P Completion Redirect
> +				  bit-4     : ACS Upstream Forwarding
> +				  bit-5     : ACS P2P Egress Control
> +				  bit-6     : ACS Direct Translated P2P
> +				  bit-7     : ACS I/O Request Blocking
> +				  bit-9:8   : ACS DSP Memory Target Access Ctrl
> +				      00    : Direct Request access enabled
> +				      01    : Request blocking enabled
> +				      10    : Request redirect enabled
> +				      11    : Reserved
> +				  bit-11:10 : ACS USP Memory Target Access Ctrl
> +				              Same encoding as bit-9:8
> +				  bit-12    : ACS Unclaimed Request Redirect Ctrl
>   				Each bit can be marked as:
>   				  '0' – force disabled
>   				  '1' – force enabled
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4b32fbbcacb6..c34780a5f886 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1039,6 +1039,16 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
>   	/* Upstream Forwarding */
>   	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
>   
> +	/*
> +	 * Redirect Unclaimed Request Redirect Control, I/O Request Blocking,
> +	 * and Downstream and Upstream Port Memory Target Access Redirect.
> +	 */
> +	if (dev->acs_capabilities & PCI_ACS_ECAP) {
> +		caps->ctrl |= PCI_ACS_URRC | PCI_ACS_IB;
> +		FIELD_MODIFY(PCI_ACS_DMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
> +		FIELD_MODIFY(PCI_ACS_UMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
> +	}
> +
>   	/* Enable Translation Blocking for external devices and noats */
>   	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
>   		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ec1c54b5a310..dcff29eb839b 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1016,6 +1016,7 @@
>   
>   /* Access Control Service */
>   #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
> +#define  PCI_ACS_ECAP		0x0080  /* ACS Enhanced Capability */
>   #define  PCI_ACS_SV		0x0001	/* Source Validation */
>   #define  PCI_ACS_TB		0x0002	/* Translation Blocking */
>   #define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
> @@ -1023,10 +1024,22 @@
>   #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
>   #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
>   #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
> +#define  PCI_ACS_IB		0x0080	/* I/O Request Blocking */
> +#define  PCI_ACS_DMAC_MASK	0x0300  /* DSP Memory Target Access Control */
> +#define  PCI_ACS_UMAC_MASK	0x0C00  /* USP Memory Target Access Control */
> +#define  PCI_ACS_URRC		0x1000	/* Unclaimed Request Redirect Ctrl */
>   #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
>   #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
>   #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
>   
> +/* Encodings for DSP and USP Memory Target Access Control */
> +enum {
> +	PCI_ACS_MAC_DA   = 0x0,		/* Direct request access */
> +	PCI_ACS_MAC_RB   = 0x1,		/* Request blocking */
> +	PCI_ACS_MAC_RR   = 0x2,		/* Request redirect */
> +	PCI_ACS_MAC_RSVD = 0x3,		/* Reserved */
> +};
> +
>   /* SATA capability */
>   #define PCI_SATA_REGS		4	/* SATA REGs specifier */
>   #define  PCI_SATA_REGS_MASK	0xF	/* location - BAR#/inline */

