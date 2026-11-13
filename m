Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794590976;
	b=KezlUatvwyr1mg+MCQy2shDHfso7Rly+Q4+n+E0XU2pNfgop0nknZhFm4u5A2w+BfyPP
	 4VUdYCCr2GWKFgl4qZihBaYsrMMJO4VZyf77gJkAc9s7x+uiAMdYKKt5pnyD4f0FJoBNG
	 Cm0GMIjZ/MQ5FNHbHRfh/xR0H8l78wgaaJKnJ1gJXksVY2D+Lj/8zklMVlezAeUmOzt62
	 kHgBZsM6tP0PjYMHOs9JtJhusnasgk7Wbz3dzTl8oET3w2O6GLVstBFuVbQPyKlkq3U6a
	 GDtq38T2azgAKINWV1rPbRmbrtpNH+meDPXIDpF+m2ks58XhLDT8PegkJPDSyfOPl9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590976;
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
	bh=LPAlSmpiJIH5WL+uwTuexjAm0Mux+KchJrNkq2KmvAY=;
	b=V1/QTq/Awf/oqgEHawUzjX+4s+CzIiqS3U9FCKqCEhYOumKnqEoBSJGa0RDSThkOylY2
	 CgdL88KAD5ZWuzWmulkBwgZQ0qB8SaOZVnNoXAhdVorrSjA4/j3bTMuvbKkhqYVazBF7q
	 Sue5QuQ7vYW8n9k3YF6JYw9xfB1X5nl1fdKOl0P3dZGRK33qsYr2rcQuMy3EqihLQbD/J
	 KRdO+uFf/8pp8TPsxbNB1D7LWTRAP49/BVXb/OJHeo7VH+5h/gso8ZGqnZW0/5YxclalQ
	 B5gAF2HLkjr5ZboDQVosiKE8/XFSpPuzgkYEFyuP9JlIXPwCJ7Rlfap10NqhXHt5Izg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=x7SKeLHK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.60
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BEA606E65E;
	Fri, 13 Nov 2026 17:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49BEA606E65E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=x7SKeLHK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSRZHOEYKi8MemNm5W/zHEbuVfc/7kuDj7QoIx+o/UOQFpABGEJpjYpun6AaFYwQ8jGkRt7U8zfLO8xvywf1xtprbjdAkPIjsqrRo9F4YcSqvTFEljHTiqN0/xz0HLUuR9dlGQnu0YZMuDhj8BjBBBQXdnODIlUu4BUFYnctgdHlBlH7KniPpBS8DjnnmsUQKEPnUje3B8U8SSOonJrWpDwagtjPfCiM0ZofsFTBOfs5wzzqaY3kNhzGRi6Dm/GAUUWFmv57CqVRwFzmX6LopfLwzzxReCaeFBTO6c9Cej6c0NVTNW4SxsRZWyS/If/E/DohShQlOhbzurPJ3PPBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPAlSmpiJIH5WL+uwTuexjAm0Mux+KchJrNkq2KmvAY=;
 b=gumix+bmquNtSU3s2UpiciBUewbETtKw26a8EXd/trnQnbJFrSRyTeQI09Roh7amFijEX74BZFufvYCsOBmf6IR7iQDvV9myhMq4IXvqpBIGg8MJrIhPw3I4mGnKlmt4e8t21EXQ9Z9RMmXFj9y/3G3DtxLJ/sJZy6sHot+xj2JnKFhKK9RRtnDM58cyTW/0r7em9USVUky1cPhESAD9vmSMQDTHoHHOCTp6X6XxWdsIiB/MIr/ALEpbLY8yjMYska60KyEj5Ku1wY3ZvZ7d42kK+WCvKIIw+iOPQ258iYmYCoJ+xQCyTjPQXOxhOxj6bKNGgI+9bxxUIxp0D8FG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPAlSmpiJIH5WL+uwTuexjAm0Mux+KchJrNkq2KmvAY=;
 b=x7SKeLHKcD4hQyltjL+fG3RQrDD2SyVzyZTr70SWjdNyVB659DT9ZkEqRCxP7dC7TeL+mI7XkmZPpR7hJPsa2Jc8WeHwDGAFo/8Lhwl/fniTXZ5UYMBznvAqWPNHlFRzCjjao6uHvqyj95O6URNuOpw/TCGXkOBisPqpSZfskQlaV5Nx/CdXz43mxRN6xuau90ioEIf72bz6rNYQgvBUIkd8EY36+4JnMuk0xuBhUCjcAbQiHkOxEfARwbbXS0Gw4WG9UtPQ3n660RHMsx0Buq9YFj5IITQ5tmgGjzbTgnwLetxlFbvBOWhye5Xedvt6WXPWXkdid8zXe59q6b5GsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8700.eurprd04.prod.outlook.com (2603:10a6:20b:43f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:29:32 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:29:32 +0000
Date: Fri, 13 Nov 2026 12:29:23 -0500
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
Subject: Re: [PATCH v4 23/25] dmaengine: sdxi: Add unit tests for descriptor
 encoding
Message-ID: <avdI8zzC5b4JTw6v@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-23-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-23-3668ccc7aab8@amd.com>
X-ClientProxiedBy: CY5PR22CA0071.namprd22.prod.outlook.com
 (2603:10b6:930:80::16) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cf9ab0-24f4-4523-4f73-08df41abada5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|19092799006|10067099003|11063799006|4143699003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261102130727099003|261026140227099003|56012099006|261102123227099003|261028144727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/lPwEAFwS1qDOHThHFBSCEEFnTwjdRjc0Zwk6RdO+dN6RRNMYk4Q8eTnk5cYizRaR8jJ4QsDLVmdpqcidjNKuWUOAw4gPeLknMgZ5gTkCklAd34rdKnW7qWST37t4g4y5RL9nq7Ovn5qgYnIegyGWWt5hWyS+ImPdYFI4EGkKhveFg4kXNJY3ZSq21nk9wgrazEQexwDy9EOreSOziJddy/SWUqJyXvNn3BQ7shUBkpPow8HldqXYVW5YuTOPiSNZn7O/BsSFjDYWrhklTXsDvx7IvnbPysITYiypzHEl0LspRB1YFbKw3P4tl9tx0+hT3HBpr2vgUjJNkWr84CVi/V+rWTE/f+xpVcaKTLFN/gYSJ5pxO/bBTvbG5Heej9uftLco5NCcdoBQJKwPTZihIGID2B7sj4fVCkNzo3se6x6R5BtBrXDTMnap2Yc+IUHy4Hyp2SE6/ZRhA3T8y183HB1KT1jhyyf0jdE6GLpleHjODBdiBo7QDVof+qbKIt3cp+qtkI+0JTdnWcZ2SyZzZM5MXvwYsAb0YEb0d1y4l3vhUpwEB+5u0svLGby75FGRjdf9iZjonNkTT4CcRICfDtKALtGS99MkLprd6OI2e93nbPqWOgOGRvowdEsCw0eY84D+0X16XAyah79UnLh/As9TFv8P/VFHm3RYJC2C8U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(19092799006)(10067099003)(11063799006)(4143699003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261102130727099003)(261026140227099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XtiEphF2jTdSidAl0yyz6B/W1uxkf4qrpL8Ayz2t6d6RyGaJHdUIFagOZFeo?=
 =?us-ascii?Q?ZcXwVPeJitUTXu3e8KEoRJJSiJSPfaSb4cQpFU34flsrMWuC4uOcMfSUhNjh?=
 =?us-ascii?Q?D0+inZO2Hgjn0KjNnayXw+7kYYCAaMrsS8POanaWI5jVCA8HFPluE0W0t8c3?=
 =?us-ascii?Q?C8JpBQB0A62esAw/HMfaXFenIjsuIlvC0borA9ZTx/TuSUMfszKxY5atlQPb?=
 =?us-ascii?Q?u3A3MYC03gEjUUiJaT8TrZx/UhgwTC5FvFv1xsFU/si+OZsHbDmZM3wkDdZB?=
 =?us-ascii?Q?bu1FNugdPp+R7im/r3dYJRImBK4hQvX8ayjxbM0YzyQ7+XLBLvZOyfORVlUV?=
 =?us-ascii?Q?9eAgp5KiJccruNd4WXt/9QtTHoYS0KrfOylVw7WkIyiZh8RnDfCVIzevAC0/?=
 =?us-ascii?Q?WLKcIh5nV/NA2qX6Onn4X/romBm3uCPy67DxxZvakHUlBm1AHmUbV61BAAsx?=
 =?us-ascii?Q?Sz4IOplf4eIinxlxTMNtxx89fLC7CJEfthpwcY5+HCq5KrgvEDlrVtlq366N?=
 =?us-ascii?Q?9/Mn6cVp1KYNWoiRcaU1HnS2J38f6/Nx6ouuXI55XM+TKAARXB7mM/BP/jCL?=
 =?us-ascii?Q?OBjLumg0HI/LX3b2kyLgoSF7OVeRqPFS0XsYJt+PU+9S9L8RwbCK65HLSckY?=
 =?us-ascii?Q?yQUNOw7obgXrCoV8nmV9sdzfN6l1Ehdflz1usmb0RsKjoVVGzSAu0lgJP52p?=
 =?us-ascii?Q?UC+d8OSM6AkFz7hzyYNVHzkK0EbxdJ8sGyk/pKlNALA6Xbb1lb8gjFgV/WaI?=
 =?us-ascii?Q?PPt4nHKuLTyMmaMP2i3xMAdDm5Eh6YTbKJRx1urX4s1RDUpDNg8IYm4ufYUf?=
 =?us-ascii?Q?TghvIzgdi+bgnjEB5Z0+aKQiE77c+7QpRct8JCsZ3xHALJiaP47oe/4HK4ql?=
 =?us-ascii?Q?2bpch/3Sisi4BnkjRhY7st5eJ5PrTb40Ghyfk+invvi9xpIMjbvqzKRec4e9?=
 =?us-ascii?Q?Yd+AmRlcgdLaIIOK41WqB7zOB0L4imw35LXdt3deOteNz+wqjtzaKwZBqtgL?=
 =?us-ascii?Q?vYkw9t6oSBOxRzv5wZ+9qJA5gQxUuYW7zjOWKIUj/lOobGhOhYecu+j8Ow55?=
 =?us-ascii?Q?jL4+OMzbQ2YYiYNLJs89b2vsujy5KaVP6kNB5E7GSwcro1uThYFxf/+sNRr2?=
 =?us-ascii?Q?Ndkst0d3BUHRjBYHJL2Vw+eY9IVzRDP4nOg266bdPWcCzYpPjSd8mSSUaNza?=
 =?us-ascii?Q?8lf3vklTI3TPjhFU2fQcGjtxisLZA1VFJLbNnNiNwpf1hLYPfOQFw/SxXOK7?=
 =?us-ascii?Q?uC2im0W/G+mLpgcctsOfKDcDUqlG8CkSX5OaNkCGMUIov6iq/bASxbUYEQj3?=
 =?us-ascii?Q?SmIXh10kBHrgCtD83UjGrnAqh+tvbKKtAv6or1wXO6FdSznNikGLfOuPYf2d?=
 =?us-ascii?Q?DdxZBZViQCk2SEp2ECqsDPsLrt65s1hMPEXeBoK2MzKPfn4SSk1Z2/spjK4X?=
 =?us-ascii?Q?wtdxPzP2x+HjIM5RAgvmczHesG8B8+QTyhC9yhZqLw81F0dxD5l3m0OcZJms?=
 =?us-ascii?Q?qdN8EdHGJr9Qdj+4ZUZgPzbFCLCB2snB843paqIAipcVdrX7SBwlX/AelV0P?=
 =?us-ascii?Q?gkduDOGibr6p/Uv/rOB82aa23xbDDcbbdH8QQ6463EdtO+D0FblteWv8hcgb?=
 =?us-ascii?Q?io2imsr2CUNd9GQ+FZLj2pH8X9qdQR+AxqL8r3h9YGQ17wSf+2vJKmu6u70I?=
 =?us-ascii?Q?VOVMYKQnN+cTe7e/jJ2FOspx3rvW7oYYpNfaRCwVwwVUbC/aaKM3RYdDZRxV?=
 =?us-ascii?Q?vbWPGHwMwSr6WR85h2lBTJoOKj7m7gn/FnHump91d8T6YAnenGDM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cf9ab0-24f4-4523-4f73-08df41abada5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:29:31.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqVVmF7fBMLbloV2+Jby6ugMGLh/mfUHfh03YwTT4nuVV0HRwGU+3oCuXtNLKe3BByydcn9qklKVmStSegolxT8H5g9+ONlDuVBc7imnxRvOmQkD+z2QGF70FqCjjD/s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8700

On Tue, Nov 03, 2026 at 08:50:04PM -0600, Nathan Lynch wrote:
> Test the encoder function for each descriptor type the driver encodes.
>
> Decode descriptors with the packing API using independently specified
> bit offsets, so errors in the production bitfield masks can be detected.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/Kconfig            |   1 +
>  drivers/dma/sdxi/Makefile           |   1 +
>  drivers/dma/sdxi/descriptor_kunit.c | 537 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 539 insertions(+)
>
> diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
> index 7217375c9216..314b3e725ccb 100644
> --- a/drivers/dma/sdxi/Kconfig
> +++ b/drivers/dma/sdxi/Kconfig
> @@ -31,6 +31,7 @@ config SDXI_KUNIT_TEST
>  	tristate "SDXI unit tests" if !KUNIT_ALL_TESTS
>  	depends on SDXI_CORE && KUNIT
>  	default KUNIT_ALL_TESTS
> +	select PACKING
>  	help
>  	  KUnit tests for parts of the SDXI driver. Does not require
>  	  SDXI hardware.
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> index e9c180ea6fa4..1e261fb03225 100644
> --- a/drivers/dma/sdxi/Makefile
> +++ b/drivers/dma/sdxi/Makefile
> @@ -12,4 +12,5 @@ sdxi-pci-y := pci.o
>
>  obj-$(CONFIG_SDXI_KUNIT_TEST) += \
>  	completion_kunit.o    \
> +	descriptor_kunit.o    \
>  	ring_kunit.o
> diff --git a/drivers/dma/sdxi/descriptor_kunit.c b/drivers/dma/sdxi/descriptor_kunit.c
> new file mode 100644
> index 000000000000..fdca024e3e31
> --- /dev/null
> +++ b/drivers/dma/sdxi/descriptor_kunit.c
> @@ -0,0 +1,537 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI descriptor encoding tests.
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + *
> + * Decode descriptors using packing layouts specified independently of the
> + * production bitfield masks, allowing the tests to detect incorrect field
> + * definitions.
> + *
> + * Defining SKIP_PACKING_CHECKS bypasses compile-time packing-layout validation
> + * to reduce build time.
> + */
> +#include <kunit/device.h>
> +#include <kunit/test-bug.h>
> +#include <kunit/test.h>
> +#include <linux/container_of.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/packing.h>
> +#include <linux/stddef.h>
> +#include <linux/string.h>
> +
> +#include "descriptor.h"
> +
> +/* #define SKIP_PACKING_CHECKS */
> +
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> +
> +enum {
> +	SDXI_PACKING_QUIRKS = QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST,
> +};
> +
> +
> +#define desc_field(_high, _low, _target_struct, _member) \
> +	PACKED_FIELD(_high, _low, _target_struct, _member)
> +#define desc_flag(_bit, _target_struct, _member) \
> +	desc_field(_bit, _bit, _target_struct, _member)
> +
> +/* DMAB_COPY */
> +struct unpacked__copy {
> +	u32 size;
> +	u8 attr_src;
> +	u8 attr_dst;
> +	u16 akey0;
> +	u16 akey1;
> +	u64 addr0;
> +	u64 addr1;
> +};
> +
> +#define copy_field(_high, _low, _member) \
> +	desc_field(_high, _low, struct unpacked__copy, _member)
> +
> +static const struct packed_field_u16 copy_subfields[] = {
> +	copy_field(63, 32, size),
> +	copy_field(67, 64, attr_src),
> +	copy_field(71, 68, attr_dst),
> +	copy_field(111, 96, akey0),
> +	copy_field(127, 112, akey1),
> +	copy_field(191, 128, addr0),
> +	copy_field(255, 192, addr1),
> +};
> +
> +/* DSC_INTR */
> +struct unpacked__intr {
> +	u16 akey;
> +};
> +
> +#define intr_field(_high, _low, _member) \
> +	desc_field(_high, _low, struct unpacked__intr, _member)
> +
> +static const struct packed_field_u16 intr_subfields[] = {
> +	intr_field(111, 96, akey),
> +};
> +
> +/* DSC_SYNC */
> +struct unpacked__sync {
> +	u8 flt;
> +	bool vf;
> +	u16 vf_num;
> +	u16 cxt_start;
> +	u16 cxt_end;
> +	u16 key_start;
> +	u16 key_end;
> +};
> +
> +#define sync_field(_high, _low, _member) \
> +	desc_field(_high, _low, struct unpacked__sync, _member)
> +#define sync_flag(_bit, _member) sync_field(_bit, _bit, _member)
> +
> +static const struct packed_field_u16 sync_subfields[] = {
> +	sync_field(34, 32, flt),
> +	sync_flag(47, vf),
> +	sync_field(63, 48, vf_num),
> +	sync_field(79, 64, cxt_start),
> +	sync_field(95, 80, cxt_end),
> +	sync_field(111, 96, key_start),
> +	sync_field(127, 112, key_end),
> +};
> +
> +/* DSC_CXT_START */
> +struct unpacked__cxt_start {
> +	bool dv;
> +	bool vf;
> +	u16 vf_num;
> +	u16 cxt_start;
> +	u16 cxt_end;
> +	u64 db_value;
> +};
> +
> +#define cxt_start_field(_high, _low, _member) \
> +	desc_field(_high, _low, struct unpacked__cxt_start, _member)
> +#define cxt_start_flag(_bit, _member) cxt_start_field(_bit, _bit, _member)
> +
> +static const struct packed_field_u16 cxt_start_subfields[] = {
> +	cxt_start_flag(46, dv),
> +	cxt_start_flag(47, vf),
> +	cxt_start_field(63, 48, vf_num),
> +	cxt_start_field(79, 64, cxt_start),
> +	cxt_start_field(95, 80, cxt_end),
> +	cxt_start_field(191, 128, db_value),
> +};
> +
> +/* DSC_CXT_STOP */
> +struct unpacked__cxt_stop {
> +	bool hs;
> +	bool vf;
> +	u16 vf_num;
> +	u16 cxt_start;
> +	u16 cxt_end;
> +};
> +
> +#define cxt_stop_field(_high, _low, _member) \
> +	desc_field(_high, _low, struct unpacked__cxt_stop, _member)
> +#define cxt_stop_flag(_bit, _member) cxt_stop_field(_bit, _bit, _member)
> +
> +static const struct packed_field_u16 cxt_stop_subfields[] = {
> +	cxt_stop_flag(45, hs),
> +	cxt_stop_flag(47, vf),
> +	cxt_stop_field(63, 48, vf_num),
> +	cxt_stop_field(79, 64, cxt_start),
> +	cxt_stop_field(95, 80, cxt_end),
> +};
> +
> +/* DSC_CXT_UPD */
> +struct unpacked__cxt_upd {
> +	u8 pcd;
> +	bool vf;
> +	u16 vf_num;
> +	u16 cxt_start;
> +	u16 cxt_end;
> +};
> +
> +#define cxt_upd_field(_high, _low, _member) \
> +	desc_field(_high, _low, struct unpacked__cxt_upd, _member)
> +#define cxt_upd_flag(_bit, _member) cxt_upd_field(_bit, _bit, _member)
> +
> +static const struct packed_field_u16 cxt_upd_subfields[] = {
> +	cxt_upd_field(34, 32, pcd),
> +	cxt_upd_flag(47, vf),
> +	cxt_upd_field(63, 48, vf_num),
> +	cxt_upd_field(79, 64, cxt_start),
> +	cxt_upd_field(95, 80, cxt_end),
> +};
> +
> +/* DSC_GENERIC */
> +struct unpacked_desc {
> +	u64 csb_ptr;
> +	u16 type;
> +	u8 subtype;
> +	bool vl;
> +	bool se;
> +	bool fe;
> +	bool ch;
> +	bool csr;
> +	bool rb;
> +	bool np;
> +	union {
> +		struct unpacked__copy copy;
> +		struct unpacked__intr intr;
> +		struct unpacked__sync sync;
> +		struct unpacked__cxt_start cxt_start;
> +		struct unpacked__cxt_stop cxt_stop;
> +		struct unpacked__cxt_upd cxt_upd;
> +	};
> +};
> +
> +#define generic_field(_high, _low, _member)			\
> +	desc_field(_high, _low, struct unpacked_desc, _member)
> +#define generic_flag(_bit, _member) generic_field(_bit, _bit, _member)
> +
> +static const struct packed_field_u16 generic_subfields[] = {
> +	generic_flag(0, vl),
> +	generic_flag(1, se),
> +	generic_flag(2, fe),
> +	generic_flag(3, ch),
> +	generic_flag(4, csr),
> +	generic_flag(5, rb),
> +	generic_field(15, 8, subtype),
> +	generic_field(26, 16, type),
> +	generic_flag(448, np),
> +	generic_field(511, 453, csb_ptr),
> +};
> +
> +#ifndef SKIP_PACKING_CHECKS
> +#define define_unpack_fn(_T)						\
> +	static void unpack_ ## _T(struct unpacked_desc *to,		\
> +				  const struct sdxi_desc *from)		\
> +	{								\
> +		unpack_fields(from, sizeof(*from), to,	\
> +			      generic_subfields, SDXI_PACKING_QUIRKS);	\
> +		unpack_fields(from, sizeof(*from), &to->_T,		\
> +			      _T ## _subfields, SDXI_PACKING_QUIRKS);	\
> +	}
> +#else
> +#define define_unpack_fn(_T)						\
> +	static void unpack_ ## _T(struct unpacked_desc *to,		\
> +				  const struct sdxi_desc *from)		\
> +	{								\
> +		unpack_fields_u16(from, sizeof(*from), to,		\
> +				  generic_subfields,			\
> +				  ARRAY_SIZE(generic_subfields),	\
> +				  SDXI_PACKING_QUIRKS);			\
> +		unpack_fields_u16(from, sizeof(*from), &to->_T,		\
> +				  _T ## _subfields,			\
> +				  ARRAY_SIZE(_T ## _subfields),		\
> +				  SDXI_PACKING_QUIRKS);			\
> +	}
> +#endif	/* SKIP_PACKING_CHECKS */
> +
> +define_unpack_fn(intr)
> +define_unpack_fn(copy)
> +define_unpack_fn(sync)
> +define_unpack_fn(cxt_start)
> +define_unpack_fn(cxt_stop)
> +define_unpack_fn(cxt_upd)
> +
> +static void desc_poison(struct sdxi_desc *d)
> +{
> +	memset(d, 0xff, sizeof(*d));
> +}
> +
> +static void encode_size32(struct kunit *t)
> +{
> +	__le32 res = cpu_to_le32(U32_MAX);
> +
> +	/* Valid sizes. */
> +	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(1, &res));
> +	KUNIT_EXPECT_EQ(t, 0, le32_to_cpu(res));
> +
> +	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(SZ_4K, &res));
> +	KUNIT_EXPECT_EQ(t, SZ_4K - 1, le32_to_cpu(res));
> +
> +	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(SZ_4M, &res));
> +	KUNIT_EXPECT_EQ(t, SZ_4M - 1, le32_to_cpu(res));
> +
> +	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(SZ_4G - 1, &res));
> +	KUNIT_EXPECT_EQ(t, SZ_4G - 2, le32_to_cpu(res));
> +
> +	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(SZ_4G, &res));
> +	KUNIT_EXPECT_EQ(t, SZ_4G - 1, le32_to_cpu(res));
> +
> +	/* Invalid sizes. Ensure the out parameter is unmodified. */
> +#define RES_VAL 0x843829
> +	res = cpu_to_le32(RES_VAL);
> +
> +	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_size32(0, &res));
> +	KUNIT_EXPECT_EQ(t, RES_VAL, le32_to_cpu(res));
> +
> +	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_size32(SZ_4G + 1, &res));
> +	KUNIT_EXPECT_EQ(t, RES_VAL, le32_to_cpu(res));
> +
> +	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_size32(SZ_8G, &res));
> +	KUNIT_EXPECT_EQ(t, RES_VAL, le32_to_cpu(res));
> +
> +	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_size32(U64_MAX, &res));
> +	KUNIT_EXPECT_EQ(t, RES_VAL, le32_to_cpu(res));
> +
> +#undef RES_VAL
> +}
> +
> +static void copy(struct kunit *t)
> +{
> +	struct unpacked_desc unpacked;
> +	struct sdxi_desc desc = {};
> +	struct sdxi_copy copy = {
> +		.src = 0x1000,
> +		.dst = 0x2000,
> +		.len = 4096,
> +		.src_akey = 0,
> +		.dst_akey = 0,
> +	};
> +
> +	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_copy(&desc, &copy));
> +
> +	unpack_copy(&unpacked, &desc);
> +	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_COPY);
> +	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_DMAB);
> +	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
> +
> +	KUNIT_EXPECT_EQ(t, unpacked.copy.size, copy.len - 1);
> +
> +	/* Size boundaries. */
> +	desc_poison(&desc);
> +	copy.len = 0;
> +	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_copy(&desc, &copy));
> +
> +	desc_poison(&desc);
> +	copy.len = 1;
> +	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_copy(&desc, &copy));
> +	unpack_copy(&unpacked, &desc);
> +	KUNIT_EXPECT_EQ(t, unpacked.copy.size, copy.len - 1);
> +
> +	/* SDXI forbids overlapping source and destination. */
> +	desc_poison(&desc);
> +	copy.len = 4097;
> +	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_copy(&desc, &copy));
> +	copy = (typeof(copy)) {
> +		.src = 0x4000,
> +		.dst = 0x4000,
> +		.len = 1,
> +		.src_akey = 0,
> +		.dst_akey = 0,
> +	};
> +	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_copy(&desc, &copy));
> +
> +	desc_poison(&desc);
> +	KUNIT_EXPECT_EQ(t, 0,
> +			sdxi_encode_copy(&desc,
> +					 &(struct sdxi_copy) {
> +						 .src = 0x1000,
> +						 .dst = 0x2000,
> +						 .len = 0x100,
> +						 .src_akey = 1,
> +						 .dst_akey = 2,
> +					 }));
> +	KUNIT_EXPECT_EQ(t, 0x1000, le64_to_cpu(desc.copy.addr0));
> +	KUNIT_EXPECT_EQ(t, 0x2000, le64_to_cpu(desc.copy.addr1));
> +	KUNIT_EXPECT_EQ(t, 0x100, 1 + le32_to_cpu(desc.copy.size));
> +	KUNIT_EXPECT_EQ(t, 1, le16_to_cpu(desc.copy.akey0));
> +	KUNIT_EXPECT_EQ(t, 2, le16_to_cpu(desc.copy.akey1));
> +
> +	unpack_copy(&unpacked, &desc);
> +	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_COPY);
> +	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_DMAB);
> +	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
> +
> +	KUNIT_EXPECT_EQ(t, unpacked.copy.size, 0x100 - 1);
> +}
> +
> +static void intr(struct kunit *t)
> +{
> +	struct unpacked_desc unpacked;
> +	struct sdxi_intr intr = {
> +		.akey = 1234,
> +	};
> +	struct sdxi_desc desc;
> +
> +	desc_poison(&desc);
> +	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_intr(&desc, &intr));
> +
> +	unpack_intr(&unpacked, &desc);
> +	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_INTR);
> +	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_INTR);
> +	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
> +
> +	KUNIT_EXPECT_EQ(t, unpacked.intr.akey, 1234);
> +}
> +
> +static void cxt_start(struct kunit *t)
> +{
> +	struct unpacked_desc unpacked;
> +	struct sdxi_cxt_start start = {
> +		.range = sdxi_cxt_range_single(2),
> +	};
> +	struct sdxi_desc desc;
> +
> +	desc_poison(&desc);
> +	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_start(&desc, &start));
> +
> +	unpack_cxt_start(&unpacked, &desc);
> +
> +	KUNIT_EXPECT_EQ(t, 0, desc.cxt_start.vflags);
> +
> +	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
> +	/* Context start requires FE=1 and SE=0. */
> +	KUNIT_EXPECT_EQ(t, unpacked.se, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.fe, 1);
> +	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_CXT_START_NM);
> +	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
> +	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
> +
> +	KUNIT_EXPECT_FALSE(t, unpacked.cxt_start.dv);
> +	KUNIT_EXPECT_FALSE(t, unpacked.cxt_start.vf);
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_start.cxt_start, 2);
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_start.cxt_end, 2);
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_start.vf_num, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_start.db_value, 0);
> +}
> +
> +static void cxt_stop(struct kunit *t)
> +{
> +	struct unpacked_desc unpacked;
> +	struct sdxi_cxt_stop stop = {
> +		.range = sdxi_cxt_range_single(2),
> +	};
> +	struct sdxi_desc desc;
> +
> +	desc_poison(&desc);
> +	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_stop(&desc, &stop));
> +
> +	unpack_cxt_stop(&unpacked, &desc);
> +
> +	KUNIT_EXPECT_EQ(t, 0, desc.cxt_stop.vflags);
> +
> +	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.se, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.fe, 1);
> +	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_CXT_STOP);
> +	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
> +	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
> +
> +	KUNIT_EXPECT_FALSE(t, unpacked.cxt_stop.hs);
> +	KUNIT_EXPECT_FALSE(t, unpacked.cxt_stop.vf);
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_stop.cxt_start, 2);
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_stop.cxt_end, 2);
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_stop.vf_num, 0);
> +}
> +
> +static void cxt_upd(struct kunit *t)
> +{
> +	struct unpacked_desc unpacked;
> +	struct sdxi_cxt_upd upd = {
> +		.level = SDXI_CXT_UPD_LVL_L2,
> +		.range = sdxi_cxt_range(128, 255),
> +	};
> +	struct sdxi_desc desc;
> +
> +	desc_poison(&desc);
> +	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_upd(&desc, &upd));
> +
> +	unpack_cxt_upd(&unpacked, &desc);
> +
> +	KUNIT_EXPECT_EQ(t, 0, desc.cxt_upd.vflags);
> +
> +	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.se, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_CXT_UPD);
> +	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
> +	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
> +
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_upd.pcd, SDXI_CXT_UPD_LVL_L2);
> +	KUNIT_EXPECT_FALSE(t, unpacked.cxt_upd.vf);
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_upd.vf_num, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_upd.cxt_start, 128);
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_upd.cxt_end, 255);
> +
> +	/* The other defined levels encode into the tgt_pcd subfield. */
> +	desc_poison(&desc);
> +	upd.level = SDXI_CXT_UPD_LVL_CTL;
> +	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_upd(&desc, &upd));
> +	unpack_cxt_upd(&unpacked, &desc);
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_upd.pcd, SDXI_CXT_UPD_LVL_CTL);
> +
> +	desc_poison(&desc);
> +	upd.level = SDXI_CXT_UPD_LVL_L1;
> +	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_upd(&desc, &upd));
> +	unpack_cxt_upd(&unpacked, &desc);
> +	KUNIT_EXPECT_EQ(t, unpacked.cxt_upd.pcd, SDXI_CXT_UPD_LVL_L1);
> +}
> +
> +static void sync(struct kunit *t)
> +{
> +	struct sdxi_sync sync = {
> +		.filter = SDXI_SYNC_FLT_STOP,
> +		.range = sdxi_cxt_range(1, U16_MAX),
> +	};
> +	struct sdxi_desc desc;
> +	struct unpacked_desc unpacked;
> +
> +	desc_poison(&desc);
> +	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_sync(&desc, &sync));
> +	unpack_sync(&unpacked, &desc);
> +
> +	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
> +	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_SYNC);
> +	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
> +	KUNIT_EXPECT_EQ(t, unpacked.sync.flt, SDXI_SYNC_FLT_STOP);
> +	KUNIT_EXPECT_EQ(t, unpacked.sync.cxt_start, 1);
> +	KUNIT_EXPECT_EQ(t, unpacked.sync.cxt_end, U16_MAX);
> +}
> +
> +static struct kunit_case generic_desc_tcs[] = {
> +	KUNIT_CASE(encode_size32),
> +	KUNIT_CASE(copy),
> +	KUNIT_CASE(intr),
> +	KUNIT_CASE(cxt_start),
> +	KUNIT_CASE(cxt_stop),
> +	KUNIT_CASE(cxt_upd),
> +	KUNIT_CASE(sync),
> +	{}
> +};
> +
> +static int generic_desc_setup_device(struct kunit *t)
> +{
> +	struct device *dev = kunit_device_register(t, "sdxi-mock-device");
> +
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(t, dev);
> +	t->priv = dev;
> +	return 0;
> +}
> +
> +static struct kunit_suite generic_desc_ts = {
> +	.name = "Generic SDXI descriptor encoding",
> +	.test_cases = generic_desc_tcs,
> +	.init = generic_desc_setup_device,
> +};
> +kunit_test_suite(generic_desc_ts);
> +
> +MODULE_DESCRIPTION("SDXI descriptor encoding tests");
> +MODULE_AUTHOR("Nathan Lynch");
> +MODULE_LICENSE("GPL");
>
> --
> 2.56.0
>
