Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588829;
	b=p4+cD616F4UXa1yGH8hy23NZzBn4bRMOQ6WaXxZ8Lj7SQrBGFuWgJ1Q8eHIEm7dPGLAO
	 xdlg0WDsXEddnIqH5RBpeW9/19d/JaLCfAgNRwbdhBIG+0MFweitfnoaZFitV5xohQbvw
	 WElhKEzoTr7C6JRrOTm6nhm9WIs/61UB5bLJzGCodGEmzpTNQudcc6n5iUSoN70dmitX/
	 9RRO52Ma/5RSPd5UNaUL5NEdTHBglw4yzEmMT0fCtO7UTq/oQs4NYQB0W8pY4re1B+oR1
	 /Xv2Lh4FuwgPBoxves7gxEnYkGMvzunBG3gm+hxyk/mY1njixqTP1GVdAOmxKdp2OMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588829;
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
	bh=wfTn2eTIUgaV04J/FYAIFP4TuZyB2hsnkivZZPzx8Pc=;
	b=Y5P2dquhswgVuvx7ZUcaORPTuUgLlYsRiu5+BJQmEkTx9Hv761OKPXIt9OgSfnYzto6b
	 68xB5kLqXnPUkQSGxESDRUBqFM6C8jbPuc3DZphtoztRsm5uBuc+s4vooYyN5V6xkneMa
	 0MBCCDxOaoH+vPbedqwhx+EpfHZHbRjIUF2Obr1ZZ+9NToxoZG2XqEMl57s2rSF8NOzbh
	 R5mmTNJ/kS3aGy7KERys2AvIO0V4caTRBxEegvglw0pht/vkdn0OPBvSdnwe51otOhN6E
	 AwyndaQ3fMNldtUeuumHjhugUeGq0hKpHJQM+s0GZI3NWGJq3XSHTzzp7Bb/b9f9/UQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="Fsi9ql/Q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.49
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DD9606A887;
	Fri, 13 Nov 2026 16:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70DD9606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Fsi9ql/Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zI6GGW6ns7oeQ+UXUEEHGECcG+n5k+JFlsV1DB5+O0rfVDHAUWY2ePZCYR1Szkv2n528V/3Q1NO5uFpCIB29R5wRstO7kJPg0fnZYDgmrhu1vFRY4kMKQsu6SF7e3+mMAZvk8eVNruyF04QA3m93y/BsajMaZfzXcovoG77ocNEon/ulj52/JtaPYvReGxcyd0gKliykqHcTJ8+1hW2VWVcKnw5s24nHVJv7bB0OW/Kk9UuPhVDIrwF8aPGbFicBHnCF19JeeRbv/lNXCwLmgZCUxLgTUtqWjvfZU/R20oEX8YZqIAtLp196Dop9FlAo/eF9rnKZjyHiC/9uUlmFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfTn2eTIUgaV04J/FYAIFP4TuZyB2hsnkivZZPzx8Pc=;
 b=ZZ3dptgbQ9BH8EKUHh8SHOzJ58bnn17T/gRpByUb2zimpHd0ApK5gKQ8zT8JDY090T5aSXGSfBENeklBQQpGY1d/T3GNadbU+OGtPt+IdpfQ4mbWoc4LbUklGdrVi0GwyYayFwgahw/ilT2BfezGsBQyg57XlLUIfHJ9/ShKd+24McIIRxEn3rv7r2XXnIpXYf2AUZYyQK1aCT7EHKbCglHfmo/6Y1gdEmDNC7xz+h9UocCa+yA9zNARhqUfi6virYtsIiFtQ0OW5/PDr4/X7DztKJpd17gPqYzhjksyArmsVadnNnl5TiSS6r3NQj6ntPyzo9iumPDAXQmdoKoEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfTn2eTIUgaV04J/FYAIFP4TuZyB2hsnkivZZPzx8Pc=;
 b=Fsi9ql/Qlj+RvcStYbHVWn96AmWIfTaKl5BCVrVs2m/tplYAxM6VaL+WLW71XTW1icmIlqvWIXlzHzShAEwTlkmQUwvXsQaZaxnTW+5Nc5MY1hny4q98xTnzMu6xFEo4/9hXPoaN5kjoFG+14cTWpWhBoLxhp8xpdelBdeABNPU+2S+I/NGGXkZG+wTPfx0Qrp+KDnHWSWHjBI2bTE5DERebQvadoRAuO6LT15v/BQU00loqYcVlRAosjFjKHHIqWjiGxRxwA9mW0R0BkZ0+HINbwcTiZcaqQ0lH69kwh9ExPPA3S5H+4JmLbxm64L+1skffKVceK8itm+Os8p86pg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DBBPR04MB7689.eurprd04.prod.outlook.com (2603:10a6:10:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:53:45 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:53:45 +0000
Date: Fri, 13 Nov 2026 11:53:37 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
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
Subject: Re: [PATCH v4 14/25] dmaengine: sdxi: Add unit tests for descriptor
 ring reservations
Message-ID: <avdAkdDahD6nmzUp@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-14-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-14-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS7PR03CA0323.namprd03.prod.outlook.com
 (2603:10b6:8:2b::12) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DBBPR04MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ea9c33-4ae0-4bf4-d314-08df41a6ae3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|23010399003|1800799024|18002099003|22082099003|6133799003|56012099006|261021121427099003|11063799006|4143699003|261102130727099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|261102123227099003|261009223027099003|10067099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	PLpdMItINFcTJvP2wXvi5f56e2+yVXnD6JYKMlF9nE9CkYIT5F0rhhkzZVIDafhDt41ZVjX9Q4JMPTNRZHirLJOLCqEpksvzcnlOVFNSpgfYF1KSYgXFXLFNa+rHzjNE2gjEVZtj9FsUX7qLi+tlW1yQSAiZMT/BiWPcSDhfsBB9axCoNYTbi4SRsqX/EUgngWn4tnPZhQh9ouGC7KXYb+DCSs7L5ELtX4I5TN6FaFYKxfVZRcOnYECYZGTAtexOPtAtfCqCz81UF9aJkH2dUeAMPCEhWH43yqZsDP152e2ZUmU3FkaDhHaCmECUJJcV0ms7uyiiC7ubz4sQjnQqTrIBrah3HKkGSIK4lt4zhSHRpG9+mQvRlhVg96+aPrGDkXWx+UdNqdDZrQtDWQGdd89wmGUyNzL7VvVhgttXUFjlLkvdQUtW1g1eIypVJhVms0j2MKwds7jhPst7oPngWbnkot8bnxYbF3EVft9UDz4eI/TT187h8ORtbuIWMBhcp4p0kVEGoeBsybRmsQlUhT5J8zIrJCwQwuqDpgiFWt+b3vCRZNVxmL0SGwIexYOw1666YzNPfeqsKh7kkqv9xQxMbMuoL3LvGxJyvCJwM0Tu1M5VuWLZaBWgTZgHDBf92Umd0SMKDi4ZlvobZ37K3Vatt7Du4gNsTf4fAIJbyyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(261021121427099003)(11063799006)(4143699003)(261102130727099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261102123227099003)(261009223027099003)(10067099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LPqlN+oy2bEq5vRdo+SkJLiOnawO9eOpXRQseGJu8wY7LUeVDJb7iVFCAERK?=
 =?us-ascii?Q?Sk5SNxtCHRI0ROnZtyA733QItyjZvVA37bgf9gbgV6OnmdFT6FA7g8d8lAtC?=
 =?us-ascii?Q?xEbVUCXDwTkUxpWZLh9dgTm6Ov6s13USRVIvu+Mf65Yc+hpVxTlF0KMbBs8H?=
 =?us-ascii?Q?cfQri8EkTYe+eqbltWwzdqpSxf8b+FDWSZczHC8CuENu3qF2zklQrrMnzsJG?=
 =?us-ascii?Q?ZgVFJG/ZhU4icUTYpQZG2qCFfhMig5DAyCJHpKWN/aw5HStXbo/l7kF74xzN?=
 =?us-ascii?Q?WiR+cL7WlX7TUMEIoQBCb7+KIKHHi2wLx5qofdcLg96M97Nhgog/nJw4QSBb?=
 =?us-ascii?Q?EdbSwUD8UWHBur4gmQf6JLCYxE+hu1/ISttB/6Q6Tom6jhWVEN1J/uQ5xXDl?=
 =?us-ascii?Q?5hm9XggcMZ36NzWA1UFg8YhgQDhOtHv3vBG1q4UNQx1YNaqSa6Ql5VW0/XL5?=
 =?us-ascii?Q?MlGDRL7clzsflHN55qHsNbaUbEwj61xSp/7EYl4UbNAZVME+5gplBANkV2KT?=
 =?us-ascii?Q?mQyW4YExWIsbVS0G186c1AtuRa04lLTfMi5AOjm5Mjhjek7sXatMaQ7UCZW8?=
 =?us-ascii?Q?y+DX66iTm4ZgG4rOyoykzL7DOqlrN8Z04AFMpeJ6Apm66NhrUiKRQa97s01n?=
 =?us-ascii?Q?ZCa09ma6ddFrfskjaC2ws79RgJrX6mcXq0mAaA2aL8DDXJpepkGDSVaTAuWy?=
 =?us-ascii?Q?4bWmqprk7r81ZUymWsGSN+uEQ89bRFblJxKlSm4UtX6UPIQsjNRSnjAuC/Nr?=
 =?us-ascii?Q?BE6+HKvZFizkazPysBsqqJ/GsIJB+xLz0FB2KSvK39UiG2ILnXGlha+kfliw?=
 =?us-ascii?Q?qqMHDNyuIX4tZsapufhyS99XCvDq7ciDtj4ugBrE6Lf0ooH+iHM+JYAi/1kH?=
 =?us-ascii?Q?8PFzQskt5ve1a23blPr1JJJzDNDgSSX0MprCwJW1vkAGLV/IeLcmneDY5zPc?=
 =?us-ascii?Q?heh0cvVgFSjo48xyGDxy4R+YUaJtkLY3znT1pTUBxdF04cc6RuMxW0Nk/fDf?=
 =?us-ascii?Q?eK7v6DUOinLzYCK6cLM3/VFRetagBitCQ2H8xTSQDrZKyaVzr80E4rCUZPqZ?=
 =?us-ascii?Q?+TeSTABnBxeV+jkD43A5cCH8e9MBfJNAjlZltScLVPT675p3bW2bOfTGUzBY?=
 =?us-ascii?Q?DLgCYgHUtkC7D2xU3JmCOGKCoGzOuWtbzvQE3ZhRBf80Bfn+RVOO7r8+cvY6?=
 =?us-ascii?Q?vPNa4zwl6NKV4ct5YyrUAaK6gjcSRv3cK+dBssptm1HQOHGDQiiIiRNXEy7F?=
 =?us-ascii?Q?kpvBlI9EgTeYEYNCUFG/RRo2zF5bqkd7w9m54LtICbPxwDAtEOiPQ++b7e2L?=
 =?us-ascii?Q?50AwhC9iURjjwA+NtUkf0O02nqVHjOgfCdYOhN4BcDWM7Z04L5LM8zdqV/X5?=
 =?us-ascii?Q?DEUqwEQ8+1NoP8ODT+DFIGXfWqui+E/bv152qDDmhYK/NM9vJaRygnButzCV?=
 =?us-ascii?Q?9aO0tjX7KcO4gZ+wGdqGoJaSRA4tceBzvbFIaHK9T4Ak+oCJgLcccNscPcLc?=
 =?us-ascii?Q?Vlwxm1KKnGgSQkKL6i/VwA9yZoDBUCZIu7f1ROnF/cOveNyzFQNTYw3eD5tW?=
 =?us-ascii?Q?Cy5NF7plNmkqdmUA4Zaub9yindHu267LJwndp7cD02uMVBvbHr1eFuJZo6IY?=
 =?us-ascii?Q?HLA3Wyq4w5W0037a95WzEgpj7W5xi+oB0KEgkwBCYNcq9DDWvhvnatk95FVk?=
 =?us-ascii?Q?2ZOi8fWziFl9G1p0J8ribPJKGsmqnBgleH7vBXBkFzra7sQhXU649lq7W4ZI?=
 =?us-ascii?Q?+H/thxCc8Z1kZHgAV3+5YAQKKrkG2amDM6Jv5GiZ7Rc3oZYH6YwB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ea9c33-4ae0-4bf4-d314-08df41a6ae3b
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:53:45.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yp1/KU6v2SUvGAp1TfAypnm9GFgWHU5gya11c3hrj0XcIiolnS4MPRKivSnHSP4z40156kCqpJWLw4hiFPkxfVCb3R7aLiyZTaebenODS0UkrE7ryoFxkZh7hDSgZ62q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7689

On Tue, Nov 03, 2026 at 08:49:55PM -0600, Nathan Lynch wrote:
> Add hardware-independent KUnit tests for full-ring and single-slot
> reservations, invalid counts, inconsistent indices, insufficient space,
> and bounded reservations and descriptor access after ring wrap.
>
> Include the SDXI KUnit configuration and test build support. Run with:
>
>   tools/testing/kunit/kunit.py run \
>     --kunitconfig=drivers/dma/sdxi/.kunitconfig
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/.kunitconfig |   4 ++
>  drivers/dma/sdxi/Kconfig      |  10 +++
>  drivers/dma/sdxi/Makefile     |   3 +
>  drivers/dma/sdxi/ring_kunit.c | 147 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 164 insertions(+)
>
> diff --git a/drivers/dma/sdxi/.kunitconfig b/drivers/dma/sdxi/.kunitconfig
> new file mode 100644
> index 000000000000..16a1ae04b156
> --- /dev/null
> +++ b/drivers/dma/sdxi/.kunitconfig
> @@ -0,0 +1,4 @@
> +CONFIG_KUNIT=y
> +CONFIG_DMADEVICES=y
> +CONFIG_SDXI_CORE=y
> +CONFIG_SDXI_KUNIT_TEST=y
> diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
> index b91b44231a04..7217375c9216 100644
> --- a/drivers/dma/sdxi/Kconfig
> +++ b/drivers/dma/sdxi/Kconfig
> @@ -26,3 +26,13 @@ config SDXI_PCI
>
>  	  To compile this driver as a module, choose M here: the module
>  	  will be named "sdxi-pci".
> +
> +config SDXI_KUNIT_TEST
> +	tristate "SDXI unit tests" if !KUNIT_ALL_TESTS
> +	depends on SDXI_CORE && KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  KUnit tests for parts of the SDXI driver. Does not require
> +	  SDXI hardware.
> +
> +	  If unsure, say N.
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> index bfcb443f1e64..00e3f1cb0808 100644
> --- a/drivers/dma/sdxi/Makefile
> +++ b/drivers/dma/sdxi/Makefile
> @@ -7,3 +7,6 @@ sdxi-core-y := \
>
>  obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
>  sdxi-pci-y := pci.o
> +
> +obj-$(CONFIG_SDXI_KUNIT_TEST) += \
> +	ring_kunit.o
> diff --git a/drivers/dma/sdxi/ring_kunit.c b/drivers/dma/sdxi/ring_kunit.c
> new file mode 100644
> index 000000000000..7df85fc5549c
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring_kunit.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI descriptor ring management tests.
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +#include <kunit/device.h>
> +#include <kunit/test-bug.h>
> +#include <kunit/test.h>
> +#include <linux/container_of.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/packing.h>
> +#include <linux/string.h>
> +
> +#include "ring.h"
> +#include "submission.h"
> +
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> +
> +/* A submission queue backed by plain memory; no device or DMA required. */
> +static struct sdxi_sq *alloc_sq(struct kunit *t, u32 count)
> +{
> +	struct sdxi_sq *sq;
> +
> +	sq = kunit_kmalloc(t, struct_size(sq, ring, count),
> +			   GFP_KERNEL | __GFP_ZERO);
> +	if (sq)
> +		sq->count = count;
> +	return sq;
> +}
> +
> +static void valid(struct kunit *t)
> +{
> +	struct sdxi_ring_state r;
> +	struct sdxi_ring_resv resv;
> +	struct sdxi_sq *sq;
> +
> +	sq = alloc_sq(t, SZ_1K);
> +	KUNIT_ASSERT_NOT_NULL(t, sq);
> +
> +	sdxi_ring_state_init(&r, sq);
> +
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&r, sq->count, &resv), 0);
> +	KUNIT_EXPECT_EQ(t, resv.range.start, 0);
> +	KUNIT_EXPECT_EQ(t, resv.range.end, sq->count - 1);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_resv_count(&resv), sq->count);
> +	KUNIT_EXPECT_EQ(t, le64_to_cpu(sq->write_index), sq->count);
> +
> +	/* A ring-sized reservation maps slot i onto ring entry i. */
> +	for (unsigned int i = 0; i < sq->count; i++) {
> +		KUNIT_EXPECT_EQ(t, sdxi_ring_resv_index(&resv, i), i);
> +		KUNIT_EXPECT_PTR_EQ(t, sdxi_ring_desc(&r, i), &sq->ring[i]);
> +	}
> +
> +	sq->cxt_sts.read_index = cpu_to_le64(1);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&r, 1, &resv), 0);
> +	KUNIT_EXPECT_EQ(t, le64_to_cpu(sq->write_index), sq->count + 1);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_resv_count(&resv), 1);
> +
> +	/* The index space is unwrapped: index sq->count is entry 0. */
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_resv_index(&resv, 0), sq->count);
> +	KUNIT_EXPECT_PTR_EQ(t, sdxi_ring_desc(&r, sq->count), &sq->ring[0]);
> +}
> +
> +static void invalid(struct kunit *t)
> +{
> +	struct sdxi_ring_state rs;
> +	struct sdxi_ring_resv resv;
> +	struct sdxi_sq *sq;
> +
> +	sq = alloc_sq(t, SZ_1K);
> +	KUNIT_ASSERT_NOT_NULL(t, sq);
> +
> +	sdxi_ring_state_init(&rs, sq);
> +
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, 0, &resv), -EINVAL);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, sq->count + 1, &resv), -EINVAL);
> +
> +	sq->cxt_sts.read_index = cpu_to_le64(1);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, 1, &resv), -EIO);
> +
> +	sq->cxt_sts.read_index = 0;
> +	sq->write_index = cpu_to_le64(sq->count);
> +	sdxi_ring_state_init(&rs, sq);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, 1, &resv), -EBUSY);
> +
> +	sq->cxt_sts.read_index = cpu_to_le64(sq->count);
> +	sq->write_index = cpu_to_le64(sq->count + 1);
> +	sdxi_ring_state_init(&rs, sq);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, sq->count, &resv), -EBUSY);
> +}
> +
> +static void bounded_reservations(struct kunit *t)
> +{
> +	struct sdxi_ring_state rs;
> +	struct sdxi_ring_resv resv;
> +	struct sdxi_sq *sq = alloc_sq(t, SZ_1K);
> +
> +	KUNIT_ASSERT_NOT_NULL(t, sq);
> +	sdxi_ring_state_init(&rs, sq);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve_range(&rs, 0, 2, &resv), -EINVAL);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve_range(&rs, 3, 2, &resv), -EINVAL);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve_range(&rs, 2, sq->count + 1, &resv),
> +			-EINVAL);
> +
> +	sq->write_index = cpu_to_le64(sq->count - 2);
> +	KUNIT_ASSERT_EQ(t, sdxi_ring_try_reserve_range(&rs, 2, 10, &resv), 0);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_resv_count(&resv), 2);
> +	KUNIT_EXPECT_EQ(t, resv.range.start, sq->count - 2);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve_range(&rs, 2, 10, &resv), -EBUSY);
> +	sq->cxt_sts.read_index = cpu_to_le64(1);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve_range(&rs, 2, 10, &resv), -EBUSY);
> +	sq->cxt_sts.read_index = cpu_to_le64(5);
> +	KUNIT_ASSERT_EQ(t, sdxi_ring_try_reserve_range(&rs, 2, 10, &resv), 0);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_resv_count(&resv), 5);
> +	KUNIT_EXPECT_PTR_EQ(t, sdxi_slot_desc(sdxi_ring_resv_slot(&resv, 0)),
> +			    &sq->ring[0]);
> +}
> +
> +static struct kunit_case testcases[] = {
> +	KUNIT_CASE(valid),
> +	KUNIT_CASE(invalid),
> +	KUNIT_CASE(bounded_reservations),
> +	{}
> +};
> +
> +static int setup_device(struct kunit *t)
> +{
> +	struct device *dev = kunit_device_register(t, "sdxi-mock-device");
> +
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(t, dev);
> +	t->priv = dev;
> +	return 0;
> +}
> +
> +static struct kunit_suite generic_desc_ts = {
> +	.name = "SDXI descriptor ring management",
> +	.test_cases = testcases,
> +	.init = setup_device,
> +};
> +kunit_test_suite(generic_desc_ts);
> +
> +MODULE_DESCRIPTION("SDXI descriptor ring tests");
> +MODULE_AUTHOR("Nathan Lynch");
> +MODULE_LICENSE("GPL");
>
> --
> 2.56.0
>
