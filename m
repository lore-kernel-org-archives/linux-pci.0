Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793030022;
	b=j58c0PiT29zXFclpbXcRhyPTHBYGeZih07SIBp7pVLusMBeYDWTl1vzBeRCMHm8xqAXs
	 iLkk+MDnPYOuij2znu0w4wOs+P/6SM+9gv5bKdHaF2sg9FraxfiMIZD5M9aygRvAtr/fH
	 yoyJ41L+5X3ZQbw2ZYaAWZT8Id7skZ6o/LC1SL/yKsL4sphYcNRgQGrJJtW8f6CxhT/OD
	 MX04GOiRIIAT1OB+fvBKEpVLv3NXAFp8Pl5LzZDVBYpK0eOdw8fCmu+rKe2QUMzpTXIz/
	 Xok2l7XNmO8smf2Sgwg5eGXs9TUAVurnipnJqyXH9Rstb998InetsW0j0DNxyoy9qDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030022;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tqDermz00NYVkmWMzGmow7OFPIITkZfjkIE87nljr/E=;
	b=3c6CjGDJ02CjRfkpLev8sjM2RvRVDgwQ/0h+bB2PFkobRt4+6d4YHUTMb3tiQj6dO8FK
	 IjWICSABd+B6Jc4fQgjg4OH4QRJIGjqVHbNengFIgdobNACNjFhA1m/FYmKL9S/jXWYPK
	 6haci+YYMQbL4C1GXA9RwfHCIlU7ew7uciSqLvGRW2U0AygJFYkf4OZY8Ms4aIK8QbDGl
	 16WYUvVo4wUMWBnjUUCAGH+wTAazYgjC+lsB7plrec39uRe2mylq3vW3EqwI4FRr5i76v
	 EAj1Uz2cKNX6Q35urCRT/cSwVk/UKsXXhQs8ZFqN8CRRLd0y5Nh1+sgrAettRpjRv5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n01ePfcb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.71
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E7606A31F;
	Mon, 26 Oct 2026 15:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B7E7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n01ePfcb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMvi+cmhP4wx8DGV8snzdrBh8/pnPA7uwE1Fr5+HXrRFCX4zzoUzOEdJRO/e3MRtTPX0ioC7uR2wmA0HpggiAd3VuUMCD0C0SLsO1mGLPOO8CZYFyRPqgMhrleXMzEWufjBft24uy3ug6yr4Z8UwTTZhXveaIE6GlHbwrFdebFFYTdq5ZpSAfW7e1jt08Trsra1zg+9na9BP3MXRfTpvcKnb/Ou7NFj1n7ie9nb9iHXm64R4g8FxJh4J7A1AUiw2YK9jmEwtAwbIO0913nD9mj4IBZ6BKDK+i73fvmxzQp61zRIF6K/NweXrX6y83kpgrGz9XKKBtgJ65zGjjdLAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqDermz00NYVkmWMzGmow7OFPIITkZfjkIE87nljr/E=;
 b=nXuaNV4QbVkB6LAeKgqBePc8X4Y2FKgb+a4/dOB6HU2NCrmnmJsogPsKp1ukT6HWT7QVllRP8Bu1GSrc7MU6sckIhfxB503wuWqjgyLaxoCchpcvZzh8BKuML+JBvIAi43kHqRV9hH3431luIaklhXu57G3iFiTyUTAeuYPpjgnVMjJVIxlq2ZHo/Ia4vtpHlMn+4uuXx9IADBjtEZgzHdkkakNhWPsv0aDLAVmmUltFK+8kXI7LDdR6FtsxqNA/71ON2zOHTyJqWzAYnb+y+Qp2xZAtbcZvK1T8RLLJL+MAd326yO37hrWnLclU2rSBKgsYxVhxBCcxFLM6oBpblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqDermz00NYVkmWMzGmow7OFPIITkZfjkIE87nljr/E=;
 b=n01ePfcb24R/TaggYjeJPhSx6EK8K2pwA43IcmNjyrjDT9rm/2pR10aHuXW4HjXHvSZw34eiFNQYiO5e8daBZ/Mesiy/XPzYZTFg5GtI6sNMZ+RCTeM1psPMOwvwq/vCSNa9u58NaVcUfxFk0hQtZMi5nZMiENGGpgdZ/jCZwIs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 15:51:33 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 15:51:33 +0000
Message-ID: <acc1ab58-d9b1-48fb-9437-cd0fa9e3609b@amd.com>
Date: Mon, 26 Oct 2026 10:51:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/radeon: Match VFCT using initial PCI bus
 number
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
 <20261026-vfct-regression-v3-3-fe9586ed6978@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261026-vfct-regression-v3-3-fe9586ed6978@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:806:125::24) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc37741-1550-443b-2285-08df3379026b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|261026140227099003|11063799006|56012099006|4143699003|261021121427099003|10067099003|261021123027099003|261009223027099003|261022075727099003|261022115727099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	hHFIVT951MbUyMqnQKxa+iZ0z7wBRgdVjciNOOXtDkbJ4kQDmanAwPjLwkXKy8og91H/PkS6ORSPn6L9swZL3GdCwwW1y8wvBRNHOAH2UTcG5MeZ862+N2ZvCdSAyP/sOJ3o2AIeGbkE8LbFvEzXMlI78F0Vg0jvC+MZfeq2o3ALPPvZXX8QZlwU/1+gDbAx5qGvI1nNAftCovP/WcN3jAsESJLvTrONTVldhNbdR09Gf2lynWFAasIGUSsLmefycCh4qJ6pN7fMAbm3IGifR/Ae1TKhcXfngocJcb1MfSXNypCvWiTCajJuNDeyJ+xcCUBOrr0uvYHVy/sEjl2iM3cYxKHgaqQljDwnRM6O9xO2LUmTkkGbIlBUxkuwGGCtnxCX3jGHuFxkMHtaJlt9vUFbaaNJdKUO71BtCJBOVkKLacpoTZyyEjFRdJH69bSNDfQjBwxtSytlc2WGJ5Pz5TDsqcWCUlubYSuJ2L6sfgMYZsEDetGdromX2dtGACH6T8NsIlceQgmAlOWUSN8orZGIL5+LrjmtVhyixKBqModxkPt/+x5jvn6y/wKwoGurcWpIoUOeti/5AWpxzwWw7n9yjq1ppGYbAvsKx3GtTDMxLBH4EX/ujNv7qAm9aqKPt/NVJykO6jsde3KuMBrY/xhqlZBE8A5jB+t6Go0QuBk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(261026140227099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261022075727099003)(261022115727099003)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHhOVHdtSFFWNU1LQWdlcEcrOGhNZ01qRFJKUWlyTjdXV2ZWM2J0ZmFXTUhW?=
 =?utf-8?B?N0loNXpEcVl2ZVN3M3lGb25tTWF5c2NsbnBybmhJNHBOZmZYd1FPMW1MQmFl?=
 =?utf-8?B?dnlJN3NHQldhS0R4cFk2RWhBSkxRVnpVYTBRYnZ1VUZaS2JDc2paWEU4WVFH?=
 =?utf-8?B?dzFPbi85bEtaNjY4TE5SZUh6eEluTDJuczRaUWNKUzJicWpseVR6cVdML25Y?=
 =?utf-8?B?MUNHTkR3MzhGKzdkTXljbDBpSW9rbStsRFhZN1V5dlh2K3RBbGZvcXdhNVRL?=
 =?utf-8?B?dGpZVHl3aXd6dFdMR0plaXdvNTNTTGE3aVZWaThiM3Vrc0puclR0RmNtWFhR?=
 =?utf-8?B?RTRyQUtuRkZDd2pmcVpqeDI3dzhNbmEwK2RIUFNDdEV4R0xrSDJJMzdpNDFm?=
 =?utf-8?B?dnN3RGJySVZPL0w4cEpiNzRMNm5IK0F4c1JuM3VvMmM3ekVkWlVXWGhRd2dE?=
 =?utf-8?B?d3VFQWZiNmdFa2hCOUZsM1JyTldlSjlOdEZHUWkzYkMrTWxYYUdTUGgvb2o5?=
 =?utf-8?B?NElTblY0TlJyMkVWVDZiRWJDTzJteFhqWlczZ2srVHBqUXNVdGNDa040Y0gz?=
 =?utf-8?B?NlpnZmFlLytpZHRpNkNVWmMxM2R1WE9aVGNPb3ZQd3VQRDhmWU4zZkFCazRv?=
 =?utf-8?B?a09NaHJDa0M0SWk2ZitkcVh0d2U3MVYyWGs5SnRzMFl6bDIxRUhvK1lrbkM0?=
 =?utf-8?B?ODEwQm5ndWt3MUtxOUM2ZGlWbnZYSlAxYlc1RjEvalkxL0luQm51ekRBbnNQ?=
 =?utf-8?B?VGl4c0gyeHB0cW9aNit0M2ljODFPV3RTSFJ4b2laNnB0cUw5ZDQzSmwzTjIy?=
 =?utf-8?B?ZWFEWHo0QU5LTkJFTkxGUmMvUHlGc1cweWtnVCtNUG0yTjRON2x1R1d5b1pJ?=
 =?utf-8?B?c3haY3RNNzVVL3YzZVhnajdRWVdmbDJvRjJ1NnM1NWNLNVBJd1pGOXloVlh4?=
 =?utf-8?B?a3huSDRWOG14TElEaXFDVG0yb3RsRVJ0UWhTQWwzQjlkV1QzTWNwczYxMjE1?=
 =?utf-8?B?elNmS2lQNGZTMUZyNXI4ckNrSm1NbzB6RmNSdTkwR29iOWxjMm53Tmswc2hU?=
 =?utf-8?B?c1MyeEc4UTgrNFF4NE9Xem5iRG1DRW1pUWRGazk1dWQ5NEJMTTZIeUJPUWZC?=
 =?utf-8?B?dHZLSzd6YWtqVTZhTVpwSXhaajVYWDVwdktpNG90dlNuSllRR3RwbG9DOUZt?=
 =?utf-8?B?Y1prdW9Ldm5YSXJUZ1VoZnVZckNOcVl0L1RQZWVzbWdBekRMWTg5SjQzMEV2?=
 =?utf-8?B?L0E1dE5aZ3E1Zkd4cm9ZT0YrU1owM255TXBpUWd2VzhWS2pMRG9HalNVUEhD?=
 =?utf-8?B?ZmN2TEYyYU03QVA4QzRueFloRnFJNmhNN1djTXNEL2RYYW0xTWJQMURwRGNl?=
 =?utf-8?B?aHhoU2MzcWtSVCtHaDNjVDlzZ2FrOVRoaldxTndnY1dVclorSkwrRTB6Sk1R?=
 =?utf-8?B?b0ZQekhtMytSVFIwR01LRXhGMWpvNm9acGUzS0MrRDJKTjltUDVvQklLbmRL?=
 =?utf-8?B?RnhLT1EwSWoxcjRaNlBraFJhVmhoNGJlMlM0dktYVFFxTGRBb3FJTVRXRmJl?=
 =?utf-8?B?Vk1WU3ZaWVUwc1lUQk11Q0o4T05wUlZGT0xmRkJoQzJtbkg5bjJENHowRmRr?=
 =?utf-8?B?cEgrQXpjeWhkR1lnM1dlRWdvM2x2bkl5UTd4TWZIc3BTRC9jNC9MNmZ4bU5n?=
 =?utf-8?B?WXZOR0hvd21USzZKS3A0M1NDdmVlaUhFaVF4U0xWNGU1bzVHWTFFeHdsMWRo?=
 =?utf-8?B?cC9qRnJCZEl0ZDM2QWhzK2o1ak1wWEl4d0dnc3FGWDhEZnBZMm5HUzU1Y3dE?=
 =?utf-8?B?N2JzeUZUUTZ0Z1RRUXRlNWNCNlZKaXE1TzZDSExSK3ZRbm9iNit4NnBERzlu?=
 =?utf-8?B?eHdyWjRBNG5Ody94TThaeHpSNjJlRmlZV2VmZ05XU3l6WU8va2t0M3pOUHdi?=
 =?utf-8?B?TVM4VzRPMHVwQ0xNa09FZ1dHUjNFOTY5MHo0Y1NJaHBsV2FtRC85SncyK29B?=
 =?utf-8?B?dE9FUXhTWVJCRGlEYnJDTVg4UnFwOEtmck1FRU1MaUl4K1A3bTdKYU9GZGtZ?=
 =?utf-8?B?RWNrVWxvTFhRdkc2SGJkV0lIVTlra2JjbFc4TGovRWxsVWNCZ0wrWHhTUzlT?=
 =?utf-8?B?dlZ4V2kyQVdFVHN6RGxhYXYzV2ptR1hNOHp1TUNzNHQ1dnVLVjFpY0V0ZWxK?=
 =?utf-8?B?a3hCV0JLQklYSTZJSzRpb09aWDh1S3Z5WGZaNVJoWWdsMUtaVW9IU3RrMURC?=
 =?utf-8?B?TnE0eGx6NzdzT2xzTEYrcjF0ZXlMT0NodnA5TS9YVUxaS2YvUVdUeEx6R21I?=
 =?utf-8?Q?UlwaV0NYj9c/JCxTjr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc37741-1550-443b-2285-08df3379026b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 15:51:33.5627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Art7UM+KwNMNIqgpOcFmGX876nC8+g7vyf/xf1HuBgcezBBh9qCFhNl3AtdeaXxakarT/6zNI1n/xiJcxsIb+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754



On 10/26/26 10:48, Mario Limonciello wrote:
> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present. Compare against the bus number captured
> from the firmware bus assignment before bridge renumbering.
> 
> Fixes: 4059e2f02c8a ("drm/radeon: Fix VFCT bus number matching with soft filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Lost alex's tag on the rebase.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/radeon/radeon_bios.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
> index 1da6bf1c17ff3..bdbca4fad6b8c 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -609,10 +609,8 @@ static bool radeon_read_disabled_bios(struct radeon_device *rdev)
>    * VFCT entries contain the PCI bus number as recorded during BIOS POST.
>    * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
>    * resource conflicts), the runtime bus number may differ from the POST
> - * value.  Match by device identity (vendor + device + function) and use
> - * the bus number as a preference: exact bus match is preferred, but when
> - * the bus numbers disagree we accept the entry if the device identity
> - * matches.
> + * value.  Match using the bus number captured when the device was
> + * discovered, before any bus renumbering.
>    *
>    * Returns: 0 on match, -ENODEV on no match
>    */
> @@ -628,16 +626,7 @@ static int radeon_acpi_vfct_match(struct radeon_device *rdev,
>   	    vhdr->PCIFunction != PCI_FUNC(rdev->pdev->devfn))
>   		return -ENODEV;
>   
> -	/* Exact bus number match - preferred */
> -	if (vhdr->PCIBus == rdev->pdev->bus->number)
> -		return 0;
> -
> -	/* Bus mismatch but device identity matches (PCI renumbering case) */
> -	dev_notice(&rdev->pdev->dev,
> -		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
> -		   vhdr->PCIBus, rdev->pdev->bus->number,
> -		   rdev->pdev->vendor, rdev->pdev->device);
> -	return 0;
> +	return vhdr->PCIBus == rdev->pdev->bus->number_initial ? 0 : -ENODEV;
>   }
>   
>   static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
> 

