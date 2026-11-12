Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794518385;
	b=UaelqCCBDWgRrl4wvgLr+lFuYf1j2eBddFz1t2JEU/iJwHtITYSclu3MCP/uawt4MaIJ
	 Tna1OObcZ6h4MtvrGaHpHRjoJ/ZG5ckfTCOYPmEG7ottAFZVk6EOJco7P9Se0pLWY8HXf
	 JW3QvbXWte4SYNb/gBKcrIDSv5qIgXueC2PGwFu47BHsJainjCSijEHL9vEWtQHljf2vk
	 cRVsRk5bqC7/e0N/8p5DNf2PHydpfmn2TFKO4/64xEsQ2XUBVKUc136UAj3J++xalwNl5
	 wZmmUnoXs619NKPTHwO296pcWPE8ABOsMbp/+08goGnWrLRb42PEfyctYfxFTsHqsXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518385;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TrRRiSF+AZzYz0xr90lVyNL4O2wR3MDC60r5RoKg+AA=;
	b=JN5kmdJM4+WWh8G81jk7Oc0MH6FyOD6xIsF4mqdW9j4H9Q+xlihFtBU+5Q0UTdMEiEm1
	 a6tUqqjokMznI3EaRIK/RepJCAYV6kt5NDbkJiStUx36iSmAOWb8NQ1qz1UOyHOZw1Eqw
	 HKkFyV3SRVULFj4A33qN0SJG2pumAt82IU/0N77H5JLxRpWtxWbQeTReUkmWtAyJa/kqJ
	 2OqNRHuB5VjE5oasj8UC1Y4Dh6ovVFYXnr/G58J0sNA6zCdKmCW5mGLG0M2pVACg7MwLM
	 XetaImMK3InyO/30toKeGFtD8u66zykb2+ZzkhSCryGAMtMNQytUX+r7+Y2CQnB2aCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MlbsmXow;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.50
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF2606A31C;
	Thu, 12 Nov 2026 21:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CF2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MlbsmXow
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yx32dZgg3moTK+pVZxFngXFoSIrB4AQLAcg65n9tESZwKckoQyhD28OV9HcyhKjNlgOX/Ep82cX1a3yuJVesmeBBnnMuInEqU94ewCi7W0aipR5PvxawHWTmQ0QtEY8EpVoC253EKz6Bmqa7HeYbY4fdZYrvlysxPp2So0dqcGkKrKt2gjbIDcKBgF6hRQm0ILpgCsFNtBlL7mTpVaqZSIXQsHWtKqQ91S1/G+gIzAeEyVnnMFU4NDhyahEYvvHwRgX4VpTdM3rXh9MaTRd4xhx4nOxXlSK7IGAPxJe+YCw/uFPcy5lOCQZqdB9BJq4GYl2hs8RlZDV+rsyz6lmkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrRRiSF+AZzYz0xr90lVyNL4O2wR3MDC60r5RoKg+AA=;
 b=Olyq06xKakiA6LSyZEY/Dmu2MXGv1pA16AlEpSjA3NNwE1X9rTjIoqkrp8Au3WdmZhRMN1p7OOZOBaunE5MnyWlGQ21kyDuqlJ9d6ISk8I24ANOGstDHaUc264J2ut2IrLahZmfJoV2kLbMRAY6Om6bAF8w8p3PGygFH0XPA4xl7s97aDB0xF+ZHIj4MAwbRPERxvVUxYFhiWD9f8kdsB6MHiF/2ugtc8qoxSlYwG7DZ1S0+Dx7CBc6R9NuQjCgMJLLCwTzlG31OzD3b6cN1cLdmmjSWNRf50Ybl4diBlXNizx3NL9xSmD8LcoetN7YLOUz7tEZevS7t/kF/wXhomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrRRiSF+AZzYz0xr90lVyNL4O2wR3MDC60r5RoKg+AA=;
 b=MlbsmXowpuz9ujDpau+azzLwJY8X1dnzVKE15v5db4jBYJRIstHUy4I/Gm4Vf4BRsI3Y7POItkhAFmnTiKcGDcbc7kEBQu4g9TIzanE+xySqWUmefjJ8/QE5cU4Q8fsOB41SnvtVKyPoTczsMxHyF3qe0egbHQ3jbzFIJc47OlOmiAYLahId9ko0HoF3+LBtUphqXannEL+HEkSUy7EElNRpY+fWFAd1i6ymZGfsWvv0r82jQYGK1UxuNtMdOzqI/UkAvINh7Oc7HNsLh1dh+bKPJErEz2i1YfSYkqHU/ZMK4GyO1I4hPDndfphvt0w9a7kdlxufKfpRFkIBD53UTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVSPR04MB157375.eurprd04.prod.outlook.com (2603:10a6:150:71d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 21:19:37 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 21:19:37 +0000
Date: Thu, 12 Nov 2026 15:19:29 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: nathan.lynch@amd.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Jonathan Cameron <jic23@kernel.org>,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Tycho Andersen <tycho@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 02/25] MAINTAINERS: Add entry for SDXI driver
Message-ID: <avYtV0gj44kVhru1@SMW015318>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-2-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-2-3668ccc7aab8@amd.com>
X-ClientProxiedBy: VI1PR0102CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::25) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVSPR04MB157375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe02111-a139-43fc-de12-08df4102a825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|56012099006|10067099003|4143699003|261102123227099003|261022105027099003|261028144727099003|261021121427099003|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	S1Ftp4BF3p1VwwJ5Ys2MkjvjNfnXNcrQIDFRalf9tNBcrQqpncQSkbykRLj5uSVY5GK5CKVf6QlyAW9QRLcdUr3bKGCDGoXW66t0FYKApSLbzQRPka3ELj0iQzPzMIReJHshhfT2jHdGRUiRXfwOn4AWTYXjHoOdmnjGlSexC94+6SNokMPaIt3D7nojN64dzIeYfyd0Dr7G/g9D0S6g5X/upP3eaTxpVgLdlnB6tcR06GYI44aOba2w92B/EFaR4jWMGh00Hb4iCyONnxPGvE0A5jg77PCOvw9Vd4/2fNJyUHLlg5Ug3YzF0pAnnBlJYxd/nwUBG8M8/gtBVOWpfitilPxWDBIw6St1N1LmWwc17/PU5vwmig+/TGM2nAOlA1MtmuXZ/WfzeTwik11eq8tQylkR54rMsns+RKBm/WaDWsl1UXOeqAbbeBz40hjcwgtfl49mSpb53lBmoqTpy9JRawoQscV9sunFS8iEildeVdt5PVq83/3Wq0YDFYea7YPtDSN7ZKfkqC8NeyKcRZrvmyB2cINi8BkGG/GhXJaHrXNw/LDETsJ66dluNmovmSWfgK1eY8k5nYNFYuRLX38IyrznIWx6wckqMGLEiTgkBzAa76JmwZQzZSF32FUN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(56012099006)(10067099003)(4143699003)(261102123227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261026140227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0JGVhLkhqgo/ofsVHNDS/b++w9O6whMABWdorh9xg2TiF7cAZf7HFR/iuZqt?=
 =?us-ascii?Q?V3bHUzXmm9cu8IVcIvucoccJajc1E+7ygCKDmzbfB0EyMnaX9IxU9Z3wvnls?=
 =?us-ascii?Q?EDmTa/Dvwf2tAYsA+Hqs0gEEA0D2ChPAUeCWF97H97lSRZXwpowLuPL6odiy?=
 =?us-ascii?Q?HFYeSpYkA8hZURgmynJ/qJWiKE5vsr8HK4emiqJ8vJBiypy/wV+onZPYpU0f?=
 =?us-ascii?Q?LKs3Gk+fN7UXv2pd9JYXpFOWHIKlojyM2NtiMVvuMJrsoTJ/e/mRouwkeF83?=
 =?us-ascii?Q?ehyJvx9fk1EarDkev6npfs9KvODLHV15E2ErWIW1xn+rc9jNPTPA9F2DwHaQ?=
 =?us-ascii?Q?Fsysgnx9ZrUQHGYhopCA5EQC9kNuFiu4HgAiBi5C1hEjae6WX4sy7EKIPh7m?=
 =?us-ascii?Q?kDB3wreli8bKe9mDEocio3/9zkULMi/ETlDlB4EVKagnmYVFjM1xYs2Rq/iN?=
 =?us-ascii?Q?YQpkt8tLhDJP+9Z/tr5tDuoe7yQ8viO+k7wcwIi11yaJjWXNMLrjsMcTx9AE?=
 =?us-ascii?Q?W5jDVaQc4b7V8OPxM00vPZ4cKX9dBA0zbQLKL3VDwMOcup4kpWf1XzKg/LGl?=
 =?us-ascii?Q?fyOPtzTTLLEls6vJVZYDDoE7eCKQt9X9C0ARc0SqDSGy85d0W8dnj5CZaauK?=
 =?us-ascii?Q?0Fm1DNnLUwBeKCANxM4z6+ojtDnrdSZpP9lWjmFonKQXU34gFB1anXXRh+wj?=
 =?us-ascii?Q?O4rQJPraSwaKjeIyXAJKTG/NzIvoc8HSEq10FLr1/Y4cY6ByIFCrpr3W5EUL?=
 =?us-ascii?Q?XNoQmqulm7I6UGGhWz2h1oVjKomxelx/6sfklZoLJNm/WyfAaiMab0TSupWZ?=
 =?us-ascii?Q?WzHbIcaC435sE4pZZpJUr3lUYJ88uESrQuKnTxCqbqvlxSyc4OoeBD4xdZLb?=
 =?us-ascii?Q?88CT0JJzgpBrKJsIabw5LazG3hxEavNKf5rmUgq/ProRJIp1NBPyhlepGhY5?=
 =?us-ascii?Q?FDU2FzDKQ/rOuFCU1IfahjJR1cD+ibeKUSSISBt2ePkQyNsp+HTqU1Z3AVQU?=
 =?us-ascii?Q?keIpiQrOlrh1g8c13JL27BqxQqJTcUg/kEz0apK22k/Pq98I56fZE8yGWg/B?=
 =?us-ascii?Q?X9tq89mrs6OOmmrO+kW5R3ULMxHl1koYeSh4Y5sJczTyMEwBwmR2BouDqMoB?=
 =?us-ascii?Q?9m68y75mgc+xC2iw9KhsvkTpRyaXjC6H4Njv2GlzTIv6SOL0p29GjMz+O3bM?=
 =?us-ascii?Q?R69uHTOEvvZrtYMxyJUuVLt+jGIbFxeBE9yplkPfuOjn0umKBlLXPLPGEZeL?=
 =?us-ascii?Q?Y6aN3seBnKTqtYqoSk1A5U0+XyMnKKx5g7q2KFLFbqHCf3sJEXilQUjif787?=
 =?us-ascii?Q?NoOF/0S/lHz828/WqBjeo6qgOFJ0pkxMuu+HyCC0+Fc68CsbFNf5rc4wNdEJ?=
 =?us-ascii?Q?I09tIVPnX5PGEdvPsh1dOAXkGgYirmnrZRGlekX9oGixG47+c3G435s4rEgQ?=
 =?us-ascii?Q?Fu3eDTTDw44ZSuUksEJRyvjldNO2Y/wa1CgAsbRz/m+OEYtjS121hwrDiiGH?=
 =?us-ascii?Q?QwtJ25YJ+sOdd1q17o+8V6B3OYbHpboG3yHoGkggSb8N9eZWfVrg57STunVz?=
 =?us-ascii?Q?+eLcIb7qjmUnj4EKC7KL+kCT3h/+Yqe9uUjqITkSvilCWn6s1IefznQB4VqD?=
 =?us-ascii?Q?nSCrfUpz1Emk3anbKpyljrJcgXtwJjW+ZjlTUE9/UI6E6XMKkNcw6PmstF5L?=
 =?us-ascii?Q?bHA5lhLhqDG02NjnDk1ZpnaR7gQkfDNycDqe1gOmt3Spa8F6y08kN+AszGzW?=
 =?us-ascii?Q?RtiWZFSD0OdbmBHqsYd2WBe7DVFwdprG5uv9A2x2AFDmZiYS//U3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe02111-a139-43fc-de12-08df4102a825
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 21:19:37.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHrU1UE4RE3xcCpDbl6YTzsekYqZX62vPGUhWp8IKUxlFCEhG0irJhwWNryI7xBU0nwDE5dY5ZFlSs+NYMjFq/a0P8l5jQKqqmQhKs8ZzlnqVs7eFtZl8W1a8yGOFMur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVSPR04MB157375

On Tue, Nov 03, 2026 at 08:49:43PM -0600, Nathan Lynch via B4 Relay wrote:

subject

 Add entry for Smart Data Accelerator Interface (SDXI) driver

> From: Nathan Lynch <nathan.lynch@amd.com>
>
> Add an entry for the SDXI driver to MAINTAINERS. Wei and I will

Wei Huang and Nathan Lynch will ...

Frank

> maintain the driver.
>
> The SDXI specification and other materials may be found at:
>
>   https://www.snia.org/sdxi
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93abbb315065..721f06446435 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25281,6 +25281,13 @@ L:	sdricohcs-devel@lists.sourceforge.net (subscribers-only)
>  S:	Maintained
>  F:	drivers/mmc/host/sdricoh_cs.c
>
> +SDXI (Smart Data Accelerator Interface) DRIVER
> +M:	Nathan Lynch <nathan.lynch@amd.com>
> +M:	Wei Huang <wei.huang2@amd.com>
> +L:	dmaengine@vger.kernel.org
> +S:	Supported
> +F:	drivers/dma/sdxi/
> +
>  SECO BOARDS CEC DRIVER
>  M:	Ettore Chimenti <ek5.chimenti@gmail.com>
>  S:	Maintained
>
> --
> 2.56.0
>
>
