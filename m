Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012062.outbound.protection.outlook.com [52.103.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9762BE031;
	Mon, 16 Feb 2026 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771208847; cv=fail; b=cAOAPnzic4GfYYYBSC+PbK5wsx8Y7bpUD3nK+xv74aKZtLCHaB1wzdKlpHV1B5IyCphSYv6xHU6KTgoDSocVPU9s9Y5lLrTCtcHC+3HfMehY5bZzybiyqCMJ+X5zsleBmBrlK7aYfvygxEeMnN0UQw+gWRECWWShgptXv8TEOT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771208847; c=relaxed/simple;
	bh=t/1H7w8Z7pw99PEf+rK39GtO5uNurvp6jvbx1TodJV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kBN8Ux5nb57I5e4DoCGUDdU4HLD82kJs8mNRmbLkcVRX9fedIS15xOi/Ex1aa3j3jvAXhegAO9flRuOIxD8zSaO3NVQJQJnggW9L24ILUv8EDVVVPAdTfXrFFzVr6UL4sX3ImkR9bajk5DRbqbhxUZ3NGu1BY5ttn2kSUMPpRZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Q/EWBt+Y; arc=fail smtp.client-ip=52.103.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Q/EWBt+Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Em5dxMdJwwVu/ZKAr1IWmXyH8okN52GGH/dPk+0MB//OAXnGUwM0JrnzHELqrJ8tLKAHkRufUegCTG6yMv9QFYZ/h0woOSf9XU36ELBePmff2wm00NHhZiCc9f4eY/WL7FgJfkqqX8G06U7CcOOhFoHkckJcvi4rHppBwJ6uatFhIt4xvDMMjZK/KhA4tSURmLvb0q1YZA15KWJnGElVJkwN9R0n1nf8UzHQXSl6JU4hWKlNvZVi8IsGKbGp+n1HFHKzBjVpCChPz46txSAm0+tHLBk2vgBKsZSbKDFqVt1MUyyiCMyOF7mGqnd25SxCA4KnjC+WrOKcxe0vCG2U5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQgQDje11x4CY1m8FzCEvKIFyyYvnuH1+VQ9TXCRuT8=;
 b=K7i1wcMUBQ+IJLUB/j3WQOfh4QyMq0wlLd8DDA17F5J7VmUJrG2xYYidHoXCMPtcmDcSIKVarEzrTKm0YJkT1X2D3+TaDWDiu65moBPPbMsU+qoWGqDNRlfIFDOnWe/JlM+2fiBXizhSW68yKvEm7qv76w8HmJ8cIQlzGFsgo1tnbrwyT8ofhoctmFfASl23sssFEgqrAMYvPIqT6qTNKjxjNKqAihMH3p+fqklhZnfoKmbhFzwrxiN3RdamljzwOlRW4tTs9JEUKLcuLchfDGNhHLfFAafcyLIol4TWZMqBmFi7rI2Mn9WdpDt8tHBNw9AJ4BzBr0S6JhuHVhRaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQgQDje11x4CY1m8FzCEvKIFyyYvnuH1+VQ9TXCRuT8=;
 b=Q/EWBt+YUsXcy71lPIRApppvtvPqmFajqad54WEBG+EU5IqNJvRdz5RbNYZLIrjyyDvtSwsW/UlISeE+Wk3oXc2zUH22fiGAbmDuijHwJsnDKUgZvAQncH4V2jJXBm4m3BFNLQZBZal33fROlJ7JgekxQ6Z/y48ykXytelrZmfBrCqKGWaMkvaOT4ZDiVIUjvp6qD1cNhTsAgdnyB+5S490OICa5voCuREBIOIi9uvkBWaFH5/ay+mp2TDn3hJCsGy0adyg8mmZ3pvKXzGR/QSTrmY+bWu7ZvwL4DuohbI1XbKnjLjCUiLtGPiL+BrgcXH2Aj364UT8cN0iqn4EECw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5340.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 02:27:21 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 02:27:21 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v5 4/6] PCI: Refactor disable_acs_redir and config_acs param handling
Date: Mon, 16 Feb 2026 10:26:40 +0800
Message-ID:
 <SI2PR01MB43934E720AED2013EF55B423DC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260216022642.112923-5-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 94614ee3-64e4-446e-c5cd-08de6d02e9e3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|6090799003|5072599009|461199028|41001999006|8060799015|19110799012|37102599003|15080799012|23021999003|12121999013|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHdzdk5nYittTkYyTlVWT055TExhSkNoZE9LYTdmNGFTK3YyMk04Q1N2bzQz?=
 =?utf-8?B?bHVEc1RndHFmR1VGUVZzUjhHUVU4Ky84RTFtR0NFbGc3YVdEcE9MT3ZHOEJS?=
 =?utf-8?B?TE10RWhveGFuR0JtS0hudFl2VjFPM3IrMTVaQXhDSU42UkRWdE9BNEdjT0Rx?=
 =?utf-8?B?d25uakFCT3Jra1FKc1cvVHlRbXBhbkpnWTFwNXNNVGh3d0E2bXhTeDVETnVO?=
 =?utf-8?B?SWFIWGc4ZW1VRUtIS2RhZTZyRTVSaTVXOVJUZkRsbFNNK0VtNWZRVUZvaTZD?=
 =?utf-8?B?YjJYNVlTRE1pMGhIOUx6a21SMGI3K3czamFKRkdXalRJazhNUjZaVUpaMml1?=
 =?utf-8?B?UVVPWGhEUVJZU1dHZDZHZ1FXaEt3S3hvNGVpUXUrQWlsUFlQWjJZanBhWlJR?=
 =?utf-8?B?aG1YVS9Ka1FEVnpndlBZMFh2QXB4WGlMQnJDUmh0cExuKzNIa1lNenZJYjd0?=
 =?utf-8?B?STM2Y2tnZ1FxTGNzckdGQWN0SVl0bHI2VjVpUFVCUjJNVXM1U20wazZ1aUdX?=
 =?utf-8?B?YzJSQ2VPL1Q5aW8xcEsrUVFDcmRDa3BLaTRqRmtLZ0VFY2NjcEdkUFN2MXpP?=
 =?utf-8?B?Rk9sa1k2Q0hNdndod3RoZC9WM2VScnMxUXQyL0x3QUgwUCtFckRXSlVndkF6?=
 =?utf-8?B?SiszRDlNSWdqU1VxVGIzRlZOVVNMMzhxejgxT3Z1VmY5bFhDTENCU1BOc0Z4?=
 =?utf-8?B?bnZNdGxpcEpOOUl0ZFhwNkRCNm9xT21MMUE0NE9ZeGtqaGp5RWNKdUNtR2lV?=
 =?utf-8?B?SEVZVGJSN0FaWVArNE5CSi9WZ0FrNHRRNnh1cjE4ZUxld1QxcHVKRkFObStI?=
 =?utf-8?B?aHhZODIvdTlMVHVsckZQNTBZZnpKTi9ha1JQcHRhUEVqa0NiZDJteTlsRnNu?=
 =?utf-8?B?bVdoNXJyZm1DT3dnT2JqZTR3Rm1UVHJxc0ExMnprazZleEFGZ0tyUnc1QVlB?=
 =?utf-8?B?MnhFb1B5Z2IzTEtHUjUxRWYrMVpjaUxDV3JBc2o1czE2WUJ2cCtZc0VrMFVo?=
 =?utf-8?B?c1NUYm1SRzg2QmRsZG5lQ3JSdVNialk1aHp2d011VHRJbFNKU2llNW1UOFR6?=
 =?utf-8?B?OG9mTXpMT3FSajRMLzhOL21hKzFzRFBrcnVLa2hmSk5qRmRuVUxERllTN3BV?=
 =?utf-8?B?VXl2RTV0TGR6Z1pwNHBvUTl5THd5Y3ZLYW1neCtQU1lGd1JuWGZwS3YrMkVk?=
 =?utf-8?B?cXduUSszNC8rc0hqUEZpcFVBc25TNUYyNFprVHlOOUhDd1B2VU9lWG4zUWZN?=
 =?utf-8?B?a29qL2dhWVN5T1FNZDRhWXNOSk1VMnRVTmh3bitvQThtcFVPT2w5WW5sQm1K?=
 =?utf-8?B?dmIwVk45aVdaQkZBSmI0Tk45bUpkWGdxT0FmVzI4VEY5anNhSHZPcGJjU0l1?=
 =?utf-8?B?ejhYdmxVMVEvK3hYMEdlMnA5bUZvTXBQT3dCTjZRamdtbjlaUEtNOEcwWFFD?=
 =?utf-8?B?WDRycHV4K2Z6MWZBMW5rL21ZV0VrdzdsaUF2ZWpqcHJzbjhtY0JyZ0dXNTVt?=
 =?utf-8?B?alJMbzhVWjUrOVVPaUFURlo5YzFjOUcxUFMyNm9aWXo5Y2ZMaVdCUndVSTd6?=
 =?utf-8?B?Wjl2eGlpNTgyU1RSWS95WE1SM3o2Mm1hVDRUTTYvdHFMbnd2T2pLQ1hLMEVu?=
 =?utf-8?B?WnNBc1hzQmdtaWxrVGpKVENtR2czdnRKQVRHN2ZxWkpRQ2tPSTZ1VnI5bWxD?=
 =?utf-8?B?Ymhpck5rOWl4N2t3RlpOaCt0RkxpN0NEc3RIQWFqTmsxTVZjbGgrZVZiM0gw?=
 =?utf-8?B?V1MzUnY3THpudzRhOHlyUjk3OU9yRDR6VEtVV1Uzdjk5M2R1Y0xkQlhqTkF3?=
 =?utf-8?B?c2NuSHoxOFNrMTIwcXJxZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1FneVRNYk1FRGlucTFBWk9tZUJiNnROR1J1QlJPaDdqcWt2eW1uemwyOWs1?=
 =?utf-8?B?dVIrNW5oNElOWDRwL1hrbVBpMmk1VDlxbFZvWi94UkFjOUJWUzdIc1JmNWVS?=
 =?utf-8?B?WWdpMWJKVjA4V3R6Wmd5dXlvMWY3dkRyQ0tPUEFzeGs2RmZhc3JKUVpaUjFG?=
 =?utf-8?B?aDV4b3BMOEloMUxYMklLalJsajc1cDNkcDdaaG1EaER0Um0xU1VMMTZyeGM3?=
 =?utf-8?B?dWh0aktRZFdQQUIrNGRLazBKYno5Tm9xR2hxVFdOSXdVNTFqOEFBNVpoaHg0?=
 =?utf-8?B?NndvRXZiaytPNVowMFNxOWIyWlhWdGdHSFN3WEMrRUt2UGM3d0VzYjRwRWZ3?=
 =?utf-8?B?VUpjSlE5azhId3gzUUxiTTVLZndZZ1piUkpDKzhjSXRFM015ZkhGVWFudnFz?=
 =?utf-8?B?eWF2Q25Hc0xhaktwaWtBTE5rd0ZtalJ2TFJRK1dkUGRaczNUTkluczl3Sm1U?=
 =?utf-8?B?OVEyV1M1TGIzeThhOEs2WWdiK0IwMXpMRG4wRVFVaWNMbjlDV3k1bFdKVS9R?=
 =?utf-8?B?bkZaMElLU2RMM21BQkNqMG5zQTRGTWVZNWJZV0dHS2Q3Nk81K2JMdnFLNXVD?=
 =?utf-8?B?emlOYlU5MHc1OS9mczhHR1BSTEEyc2FkSlUxNVJlUWZFMkJFYmZCSjNLV0Vo?=
 =?utf-8?B?eVh1OWlNMC9CTjNEM3RDNW1RYlZwdThkcUFueFB1YkUrZldnb1JNeFdqV054?=
 =?utf-8?B?cWxpSWxYNWpHMGZCZmxLbHNSS0tOelBaZEMvYkJkYmttOVR6L29FZjlNV1cy?=
 =?utf-8?B?RkRXS0pENWF3VlIzbkZNaFhGQVBiZnYxWDBzM2ZOYmVYRVllb2FsMXZqS1RY?=
 =?utf-8?B?RmFsb2Iya25yQWg4OFUwL2h4QUhheWJyUGkycllQRXllWTNPOGx3TUJvUnZv?=
 =?utf-8?B?aVdWZ21saDJUcHlHeGRlNGJsOFVSTWZYUmxQWTN6bm5BK1lYSlZGcE04dGpN?=
 =?utf-8?B?UUcwQ09ITWxtNklpRHBYbVN3K0VPcDVUUldSbEhLbHNqM0d3Rmp0Tk4yR0hL?=
 =?utf-8?B?MnVSRWU2aGVleE5Ib0k5aVdyRmFaU2NOM3BHRURueHJYVXVvalRRTDF6aSs2?=
 =?utf-8?B?MHBsanhHOVRiWERlb2owR3V4cm9wTE9VNDVhV2d2cUd5VDVWVEkvTVladjFH?=
 =?utf-8?B?M2hsejB1cDcraU43cU1zWE0zZ05PMXE3aHpnd1BTaUw1TktYbVJCUmMraEYr?=
 =?utf-8?B?MWRCMVo0NG91d1FWZ0tuc3Y2ajJtdUZ0RzQ0L1BMc3FyYnNXUG9sbkhvTDRl?=
 =?utf-8?B?emc1UFVqUUNFOXlPZWJvMTBxUFp5TE1SWEZpYW9JZDhxRkw1Rk44eDI4dU9K?=
 =?utf-8?B?TXpCa2RGcHp6SEdrb1BaMmtEeGtRY24xcXFoamJhMGRCNUhwVnp0UThhK1Bz?=
 =?utf-8?B?NU5lckUxaXkzVkVhZlBSaFFOUWJNOUhQV3Q0c09VYy82d1BqZHYrY2tCakxj?=
 =?utf-8?B?QVBtNU51M1dlUFVTMWhobWZ2L29IVVc0eUVNMXk1OWx4aE9OcWNrbUtGWUpJ?=
 =?utf-8?B?RHM4WjBnL2I5OGk2Q3VWZWVscDZjVDlLaG5RaUQzT2w0eDZPQ3dGT2VuYVVX?=
 =?utf-8?B?cmdHQzYvbUc5cUZhWDlRenFLQzMwQlNGcnNEeS9YbWlUcGtrWkRJZVh1aEp3?=
 =?utf-8?B?dDJidmpOK081WTZ5SUMyUlJ6dXVqeHcxOFlGZFE1cGQvQ0ZhM2FvVGRhb0p4?=
 =?utf-8?B?QVhhRExpYTI5Uk5DUkpBaHpkazd4dVNiY25yN0llNXZnQ0xRWFcycmFxYk1v?=
 =?utf-8?B?eFltVEMranJ2cXI5R3BGN3F3T0FoejhPYWpSMzZ4cjdaVWFGanladVQ5c25T?=
 =?utf-8?B?bUN6dWtsUmNtd0tjNWsyR3oxWHFiU0MxT2RibmRub1REc3R1RHRTNTBmRzlx?=
 =?utf-8?Q?fdKY2/NHNZCJy?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 94614ee3-64e4-446e-c5cd-08de6d02e9e3
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 02:27:21.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5340

The current implementation mixes disable_acs_redir and config_acs param
processing inside __pci_config_acs(), using acs_mask==0 as an implicit
signal to switch into config_acs_param mode. The intertwined logic is
hard to follow and easy to break:

  - The acs_mask==0 special case is non-obvious and obscures which code
    paths apply to which parameter.
  - The interleaved logic is fragile; changes intended for one parameter
    can unintentionally affect the other. For example,
    pci_dev_specific_disable_acs_redir() is invoked on the common path
    even though it should apply only to disable_acs_redir.

Split the two behaviors into dedicated functions,
pci_param_disable_acs_redir() and pci_param_config_acs(), making the
control flow explicit and easier to maintain.

The new pci_param_config_acs() implementation also improves on the
original logic:

  - It searches for the matching device first and parses ACS flags only
    for the matched device, avoiding unnecessary work.
  - A switch statement replaces multiple if/else blocks, improving
    readability.
  - Bounds checking (max_shift) prevents overrunning the device’s ACS
    capability bits.
  - Variable names (enabled_bits, disabled_bits) more clearly express
    their roles compared to the previous mask/flags pair.
  - Error messages are simplified to reduce dmesg noise.

This refactor separates concerns, improves robustness, and makes future
extensions to ACS parameter handling safer and easier to review.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 168 +++++++++++++++++++++++++++-------------------
 1 file changed, 98 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0f0b384e782f..4b32fbbcacb6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -907,87 +907,117 @@ struct pci_acs {
 	u16 fw_ctrl;
 };
 
-static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
-			     const char *p, const u16 acs_mask, const u16 acs_flags)
+static bool pci_dev_match_disable_acs_redir(struct pci_dev *dev, const char *p)
 {
-	u16 flags = acs_flags;
-	u16 mask = acs_mask;
-	char *delimit;
 	int ret = 0;
 
-	if (!p)
-		return;
-
 	while (*p) {
-		if (!acs_mask) {
-			/* Check for ACS flags */
-			delimit = strstr(p, "@");
-			if (delimit) {
-				int end;
-				u32 shift = 0;
-
-				end = delimit - p - 1;
-				mask = 0;
-				flags = 0;
-
-				while (end > -1) {
-					if (*(p + end) == '0') {
-						mask |= 1 << shift;
-						shift++;
-						end--;
-					} else if (*(p + end) == '1') {
-						mask |= 1 << shift;
-						flags |= 1 << shift;
-						shift++;
-						end--;
-					} else if ((*(p + end) == 'x') || (*(p + end) == 'X')) {
-						shift++;
-						end--;
-					} else {
-						pci_err(dev, "Invalid ACS flags... Ignoring\n");
-						return;
-					}
-				}
-				p = delimit + 1;
-			} else {
-				pci_err(dev, "ACS Flags missing\n");
-				return;
-			}
-		}
-
 		ret = pci_dev_str_match(dev, p, &p);
-		if (ret < 0) {
+		if (ret == 1)
+			return true;
+		else if (ret < 0)
 			break;
-		} else if (ret == 1) {
-			/* Found a match */
-			break;
-		}
 	}
 
-	if (ret != 1)
+	return false;
+}
+
+static void pci_param_disable_acs_redir(struct pci_dev *dev,
+					struct pci_acs *caps)
+{
+	u16 acs_redir_mask = PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC;
+
+	if (!disable_acs_redir_param ||
+	    !pci_dev_match_disable_acs_redir(dev, disable_acs_redir_param) ||
+	    !pci_dev_specific_disable_acs_redir(dev))
 		return;
 
-	if (!pci_dev_specific_disable_acs_redir(dev))
-		return;
+	caps->ctrl = caps->fw_ctrl & ~acs_redir_mask;
+}
 
-	if (flags & ~dev->acs_capabilities) {
-		pci_err(dev, "Invalid ACS enable flags specified: %#06x\n",
-			(u16)(flags & ~dev->acs_capabilities));
-		return;
-	}
-
-	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
-	pci_dbg(dev, "ACS flags = %#06x\n", flags);
-	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
-	pci_dbg(dev, "ACS fw_ctrl = %#06x\n", caps->fw_ctrl);
+static const char *pci_dev_match_config_acs(struct pci_dev *dev, const char *p)
+{
+	const char *seg;
+	int ret;
 
 	/*
-	 * For mask bits that are 0, copy them from the firmware setting
-	 * and apply flags for all the mask bits that are 1.
+	 * Example: 11101010x@0000:01:00.0;101x@0000:02:00.0;1@0000:03:00.0
+	 * Three segments delimited via ';'. @seg always points to the start
+	 * of a segment and p advances to the start of the device id (BDF)
+	 * after '@'. Upon match, return the start of the matching segment.
 	 */
-	caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);
+	while (*p) {
+		seg = p;
+		p = strchr(seg, '@');
+		/* If malformed string, stop parsing. */
+		if (!p || p == seg)
+			break;
 
-	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
+		p++;
+		/* pci_dev_str_match() updates p to the next segment. */
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret == 1)
+			return seg;
+		else if (ret < 0)
+			break;
+	}
+
+	return NULL;
+}
+
+static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
+{
+	u16 shift = 0, max_shift = fls(dev->acs_capabilities) - 1;
+	u16 enabled_bits = 0, disabled_bits = 0;
+	const char *p, *seg;
+
+	if (!config_acs_param)
+		return;
+
+	seg = pci_dev_match_config_acs(dev, config_acs_param);
+	if (!seg)
+		return;
+
+	p = strchr(seg, '@');
+	/* Parse bitstring backwards from '@' */
+	while (p > seg) {
+		if (shift > max_shift) {
+			pci_err(dev, "ACS flag bit %d exceed range %d\n",
+				shift, max_shift);
+			return;
+		}
+
+		switch (*--p) {
+		case '1':
+			enabled_bits |= BIT(shift);
+			break;
+		case '0':
+			disabled_bits |= BIT(shift);
+			break;
+		case 'x':
+		case 'X':
+			/* Skip this bit */
+			break;
+		default:
+			pci_err(dev, "Invalid ACS flag character '%c'\n", *p);
+			return;
+		}
+		shift++;
+	}
+
+	if (enabled_bits & ~dev->acs_capabilities) {
+		pci_err(dev, "Invalid ACS enable flags specified: %#06x\n",
+			(u16)(enabled_bits & ~dev->acs_capabilities));
+		return;
+	}
+
+	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
+		enabled_bits, disabled_bits);
+
+	caps->ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
+
+	pci_info(dev, "Configured ACS to %#06x (FW default: %#06x)\n",
+		 caps->ctrl, caps->fw_ctrl);
 }
 
 /**
@@ -1044,10 +1074,8 @@ void pci_enable_acs(struct pci_dev *dev)
 	 * Always apply caps from the command line, even if there is no iommu.
 	 * Trust that the admin has a reason to change the ACS settings.
 	 */
-	__pci_config_acs(dev, &caps, disable_acs_redir_param,
-			 PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC,
-			 ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC));
-	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
+	pci_param_disable_acs_redir(dev, &caps);
+	pci_param_config_acs(dev, &caps);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
 }
-- 
2.51.0

