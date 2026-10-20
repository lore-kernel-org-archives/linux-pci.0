Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792515651;
	b=jg776FAjnAMIQYvttZB8WUyh5ujMPFNZRiXI9HV6+96BY5xCXVnZqS0NwbsUch5Sm7Wb
	 Ng8q98MdPin3QjEBdO906JNRICzZ6s3xU2NCxbyqeXJ7/HdAvzEvOfZmO5+upz7ms+npQ
	 z5+/vS6BZWO/gO4+3UhnT/sDqvcWB9I/zOn5MLlsNQzQN5jI4hgMpQwR74keEaPNJatzy
	 LET3ayO3BYN1rLqbp18bVwEd7rHMm5jXK9k0TQC/mALsDgTvwdl1sWQikneUIMW/SlK82
	 FCMo1Yg/J+xGLMRN6BYoMTIyNESYY73yQECfeytIIznx3Vs4GukK7a7mTGyictFPoMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515651;
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
	bh=44Nz+ELHMD4Vrv76NuRRaHX79J5Rc7MyyHbc8DEw7Lo=;
	b=rH918bvflCdBbS/e81O8iju30XmkY6hkyyDsGj3dN6XxI38bMpjGG+jCSgVQ4iafNxFq
	 fXN4JfZ2BHpnl4MhKuoZNDHTYflk6piL+/gIWNNJptR03fDwNQjcMAIPXEANQiZf2ymG8
	 sphbWTX0q3HxptlnXQjCznmevl9kilkdNXWdBiPfJmz7Hiul517B11vZtKH4WX0q+JFd5
	 al676VNkUaftYlnDM01/eT0Lq9PSQYTlY17PamhRAZDKDul0U1RqqKVBdSVmHUYq7qRZm
	 +62sYRgFrgbB93l1FE5yFNugKKU7oEJVgsqs0CHggXTPL+lDn+AwNddDSC0iom+VXNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tKFwsgV4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.14
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD0606A322;
	Tue, 20 Oct 2026 17:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00FD0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tKFwsgV4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwSExO7lartr3NkZuSwW8wgCyTYZkWtpVipxX2oEtNaldU/xKpxjFU5eWRwhLs5vje+7H2uI8/ij2mD0aQ9oD5QomlC5yTzmmBa4GSNmxvdymlDvx6qvvJHJ8RQJO+AxocbACuLRxNjX7LtPtc2kDBrn96ZVBZ6tRlgmUAr+v453i5okpAW4N4iABR69wACRmoQCARYR8upHx+8MxnwSyx6o2JZDPnmpLft/u4/yd4e+LNrgkecZgKfB0dFAP7/8wuO/3Gb9CON4DzbWHExjpYjyv2J4td0/cBjxWPwTAV2mEsPi+uKBcl0G/rU17jva8/VwSFqiG8Y5PUMIypEWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44Nz+ELHMD4Vrv76NuRRaHX79J5Rc7MyyHbc8DEw7Lo=;
 b=uiGEzmBeym1yZU6WdiKTosEMIqec9siMl7RMylIf+3OlQdJSn23q60s1Y0yCSnWGuE0Ek06sYMUONWQvwZiPuNNLUq3ttGDCQS6XP5sY0aqqlcP2HCz6JEzUHc5dE3zgynjJSYbB+GtQ9gtHi637K22d++x278q5J0NFAwsm3BKhtqfTFGHgcdSJaGTq668gKLmI6R7thuH/4LApEfo9FlnQpKxWzlcY9M+U+gEB26jVY3kLqZ0bWacAqocF69gw1lSjTttMzybViZLZpb9zyCbG29KT4IChWJtGM6Jj7ANzPnHwgavXAkCiefODrfhj4sHGuQNPi9Ns/wqPzBkqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44Nz+ELHMD4Vrv76NuRRaHX79J5Rc7MyyHbc8DEw7Lo=;
 b=tKFwsgV4s4epG43jU6kte9VbM56mRLpQTvnOvYqsSugRG85BdbCi9SdQNhKWuU16nb2/RylnpzXh6xQqKCl8fcpBySSmCM19HQvNMGMj4YORD/tQIDduSTca+Ub41YtR4Zm23OyzhXoJY6OibRAI0DQb4GcpWXMn8vCZ+k8KEFZs9vXsJuKWUUxPkRurj6vo622qQ4YNLDEyWfIWlw28UIWVEibTNSjKBt5najjujaCfyv2jmYU46JvEAhHUaYRi8gZM0+hHGzmSZpay/9fSuHXoKD8Tm9Det5xXDXP7du7/CA3LI0nT5qBveFyRivIeRy+/GuO9/zagkWdDIf80BA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by BESPR04MB687020.eurprd04.prod.outlook.com (2603:10a6:b10:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 17:00:47 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 17:00:47 +0000
Date: Tue, 20 Oct 2026 12:00:37 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v6 5/8] PCI: endpoint: pci-epf-vntb: Export endpoint DMA
 channels
Message-ID: <ateeNWaYttaCRN4g@SMW015318>
References: <20261020054948.1218370-1-den@valinux.co.jp>
 <20261020054948.1218370-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020054948.1218370-6-den@valinux.co.jp>
X-ClientProxiedBy: DS7P220CA0124.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::8)
 To MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|BESPR04MB687020:EE_
X-MS-Office365-Filtering-Correlation-Id: d0041583-e5dd-43e2-92a1-08df2ecbaf94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|56012099006|4143699003|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	pAqbfTXA3AgGxY/Imag9Ye+I3a+o+MSlOzij2yUwxc6b9+sLG6fdCUAz7+/UeQM7ZMPeNqcbc+N5TTz8iRo5vXlwMBuDxdpuhy5PvPyPHMNv7H4AIrASJuOqisR5QByH2ukKynyESo3VwP5F7455iHaO7+RMhg9JZsgrexf7hg7hKJVXMDxYKL7aHXRGi1sr36dM/QKm+hm2HHg7CMxqrIS9c5hRCHB4PCajGsNHyx5fcAKPw1b6PDj5QqXHRmDiW5l4CNLiIw+5bLaDaZCvcOhOSN0/7AZFGv9VKtBd9IO4VkQRhrC/xdV7WC2KuU/VoYS/M19PukEgwt88x+BLaX0QLRp+4BkzcDb37sVVAqZUE+1YcNwSqYyBrSpEZ0c7gZiI8qnILfjnfd2lIHlfJb5WpkOJWVfpPJAB4a7sHPqziBMUQ2t5/L+FGCvRn4lBrKO8NXTWmQ23c+Jtmii9B4nNy3rfJp+t81WsXThkwAy7pcbp+P/6QiroW5VKr+r2c7qb6bz1bEgN/ZL1VAgkqwX+PJW+pYFuxroYl7ArSf4Ykv2zbrYuRpjvprmTm+85yABkRfMc25jFj7nVmwrdXaaUPtNwifg2VDWNXF7qcoW32HJF9t/nBQrgtESkzDe0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(56012099006)(4143699003)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+32CtP+fojplHdQNbo7woMoQTcH0DGa3iNIEtOdzn0rgPKvYL9+2UPTERsfC?=
 =?us-ascii?Q?t7/4H7RvsSSY9frxSeo09LZWpAJv1NiCe8v1OLRz32+KHvBD+tsRfs62Hdme?=
 =?us-ascii?Q?F/219T56d7GCEANMg5R6rgNA8DdkcYw/qdenfFIq+xVholBjn53Co3Be67oj?=
 =?us-ascii?Q?JkHTjelvTlHrLGVIcJ/SKcjslXQQaEb6WfEw9QRtYumdhEMlkwx/xyg4MfIQ?=
 =?us-ascii?Q?TYkNOw7SpU8y5ulbiBjfgbEfENBNGS+hvU90u6ue+WX+Builp9G7ELdUj7RC?=
 =?us-ascii?Q?xBehOCg0yCdxKLaXSLdKYzl+BFdOdzJydbTBrDcC7gmWpYijaWEgC2IVfbvn?=
 =?us-ascii?Q?M1m2d+2+QyaIIr9leXoXgBNNaiS7VHuIEUyKuBYMKrJap2hlPtIHnTk+9tFp?=
 =?us-ascii?Q?/QlyWERlTbvwVOVBq5D80InBUD3LOm/nSmVk4XQOv4jVJRbPyDXOOQG+wNWU?=
 =?us-ascii?Q?aPJUsPonuGdfbUCO07iTw39qIbQFjYlNFxfbyIEAW6i+TEbuXa5sdxDXu2RC?=
 =?us-ascii?Q?cy4iSMhCLpgIGY7W4oodve9Xh3FsMx0cPYZbqj0/pcCBFiJyCqQ3xLU+udWD?=
 =?us-ascii?Q?YYZGi+3mZgpDkxS9S3NJ7UeENqknTwI771tpJ4Q1MG+o9AGYIjvgb5hfw0Vf?=
 =?us-ascii?Q?+gtW5hvsjqurd7SMP3ymwNR1XkjrtjSxXvywSO5OVlFn4dOdXTf5uARx1w7l?=
 =?us-ascii?Q?zFnynQPsIwuMjfZMV7Z5B/xtfm+bMbfsoHwzYFHF7MaSh6fSCAN11yPc0qt/?=
 =?us-ascii?Q?Tim9UXjmx4j/zA7aRQS/hswMNR7eAfeS+R7uPvMYJj76HJ2Iri/AZlNL8oFc?=
 =?us-ascii?Q?OJ9Tad6Z9aoXLykRRu+6fkm7NIO6axLHQLbnEAvFnJSRvBjYq3/T3c2S3/y0?=
 =?us-ascii?Q?o2paJmKutrTT9TGnfUYwV5G0lRNzXwNjX27dt1WpcW3lWY/CnAP5VfzLLALw?=
 =?us-ascii?Q?fekdYINjHGVsH1cjv/IrX8MINMTio45s7jcUUHxFNQbiZmM78bgol28eCNSK?=
 =?us-ascii?Q?FEK+bRHLPzp09vNkkCSYTCn3/1ssdP9SdVHpC62k/vQBlRGJa8e+uPuomg9d?=
 =?us-ascii?Q?6DY+7YJx0Uigxi4YuBvQ3jlG1t8C5ENrdqGfJFOlaD9zNWqQL/uEjfRVBV4d?=
 =?us-ascii?Q?CBnED0mkOLHD/4Dn99pc7nMC8QY+4S0b2XKFAJyuvjFUDZ0SBMe0G69PmweA?=
 =?us-ascii?Q?vdBi5SytOA4LqFsRYlmJYr/ldSyxRU2Obu0NsWHvi1hHrfnpqgvhQQkwlGJi?=
 =?us-ascii?Q?uBAgvHm1jvHmgFVDWPjJ67LBIcA5xTQ0YmZIq6BQmGHP3eTWUWFMk2F8mdy5?=
 =?us-ascii?Q?DxkYoAMC2JFRA2Id53+vKT8/8tEnlhyZz7TMnlUa9FzF7H6/FpCCfApau+Ha?=
 =?us-ascii?Q?vpCFnNH57KgmwOcgGXaN0KHCi4RukaWiJRyP8ONS5GnstNJriQ7ogRONuZTM?=
 =?us-ascii?Q?+3z8HXjdx7CVT6dtkv59xLEEFFTS1bz7fqz9y5aKeXmkGwRhTeZ9PTx+bN3y?=
 =?us-ascii?Q?XZCZVsCVloHAe9UCrb5bgx1GZH2ea4ddGml2JIy7ylSGsddm78+M63kizLm0?=
 =?us-ascii?Q?J8v6uMJYJ6pa9PuHKCtXDbTx0DI5GW+AAQwwqSXVncWMMFNYnZ8PaLOLt5aM?=
 =?us-ascii?Q?bSqqzAU6/wqzzDRRwme24TIriik4Oh/bUnzBxsR+dHsZM96zDIeMjJ34EJYh?=
 =?us-ascii?Q?+M1Bs8SR0fkpbSiYsbST/pFLImIGyfor/8mfmTx93frCiK7c3/EyUU6Zaqcn?=
 =?us-ascii?Q?Gi/U7nekTPlaAXzGNPJC0Vn13VtPutab0CsPhLln6uE4gAF1CvPl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0041583-e5dd-43e2-92a1-08df2ecbaf94
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 17:00:46.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRMp23JfVfKfG+pt+k318Xtm21gQBO5tOjew4Qcp8sQDbFGspDMjRzM3WMr3bNHe7v5rB7lYpuQoS2MzAlQ44TgBEby9X2CiYMC2kqxJFkmEHXbuTGGI3CKrGLdiPdem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB687020

On Tue, Oct 20, 2026 at 02:49:45PM +0900, Koichiro Den wrote:
> An RC may use endpoint-local DMA read channels to transfer data directly
> to an endpoint DMA address once both sides agree to use them. Quiescing
> an unrolled eDMA channel disables its whole direction, so reserve the
> complete read direction and route its interrupts to the RC when dma_bar
> is configured.
>
> Describe the controller and per-channel descriptor memory in a private
> control-region extension.
>
> Add a dma_bar configfs attribute. An explicit BAR selection enables DMA
> export. Leaving it unassigned keeps the feature disabled.
>
> Keep resources already assigned to a BAR in place, and map the rest
> through the selected dma_bar.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v5:
>   - Move the DMA extension layout to include/linux/pci-epf-ntb.h and
>     place it right after struct epf_ntb_ctrl instead of embedding it,
>     since pci-epf-ntb now shares the structure. (Frank)
>   - Small refactorings:
>     * Minimize the kernel-doc change in epf_ntb_config_spad_bar_alloc().
>     * Group DMA BAR init and clear with the common DMA helpers.
>   - Link to v5: https://lore.kernel.org/r/20261009045949.1109871-5-den@valinux.co.jp/
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 487 +++++++++++++++++-
>  include/linux/pci-epf-ntb.h                   |  39 ++
>  2 files changed, 517 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 3adbaa9d85db..ac83af54122f 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -39,9 +39,13 @@
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/dma/edma.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/overflow.h>
>  #include <linux/slab.h>
>
>  #include <linux/pci-ep-msi.h>
> @@ -67,6 +71,7 @@ enum epf_ntb_bar {
>  	BAR_MW2,
>  	BAR_MW3,
>  	BAR_MW4,
> +	BAR_DMA,
>  	VNTB_BAR_NUM,
>  };
>
> @@ -78,6 +83,18 @@ enum epf_irq_slot {
>
>  #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
>
> +struct epf_ntb_dma {
> +	struct epf_ntb_dma_ctrl ctrl;
> +	struct dma_chan *dchan[EDMA_MAX_RD_CH];
> +	void *bar_scratch;
> +	dma_addr_t bar_scratch_phys;
> +	size_t bar_scratch_size;
> +	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
> +	struct pci_epf_bar_submap *reg_submap;
> +	unsigned int num_submap;
> +	u16 rd_ch_cnt;
> +};
> +
>  struct epf_ntb {
>  	struct ntb_dev *ntb;
>  	struct pci_epf *epf;
> @@ -111,6 +128,7 @@ struct epf_ntb {
>  	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
>
>  	struct epf_ntb_ctrl *reg;
> +	struct epf_ntb_dma *dma;
>
>  	u32 *epf_db;
>
> @@ -202,7 +220,8 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
>  {
>  	int i;
>
> -	for (i = 0; i < VNTB_BAR_NUM; i++) {
> +	/* BAR_DMA is checked separately because it may share an MW BAR. */
> +	for (i = 0; i < BAR_DMA; i++) {
>  		if (ntb->epf_ntb_bar[i] == barno)
>  			return true;
>  	}
> @@ -210,6 +229,419 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
>  	return false;
>  }
>
> +struct epf_ntb_dma_filter {
> +	struct device *dev;
> +	int chan_id;
> +};
> +
> +static bool epf_ntb_dma_filter(struct dma_chan *chan, void *data)
> +{
> +	struct epf_ntb_dma_filter *filter = data;
> +
> +	return chan->device->dev == filter->dev &&
> +	       chan->chan_id == filter->chan_id;
> +}
> +
> +static int epf_ntb_dma_add_region(struct epf_ntb_dma *dma,
> +				  const struct pci_epc_aux_resource *resource,
> +				  dma_addr_t target_addr,
> +				  enum pci_barno barno, size_t align, u32 *next,
> +				  struct epf_ntb_dma_region_ctrl *region)
> +{
> +	resource_size_t delta, map_size, size;
> +	struct pci_epf_bar_submap *submap;
> +	dma_addr_t base;
> +
> +	if (!resource->size || resource->size > U32_MAX)
> +		return -EINVAL;
> +
> +	region->size = resource->size;
> +	if (resource->bar != NO_BAR) {
> +		if (resource->bar < BAR_0 || resource->bar > BAR_5 ||
> +		    resource->bar_offset > U32_MAX)
> +			return -EINVAL;
> +
> +		region->bar = resource->bar;
> +		region->offset = resource->bar_offset;
> +		return 0;
> +	}
> +	submap = &dma->submap[dma->num_submap];
> +
> +	/*
> +	 * The RC is trusted with endpoint-local DMA. Map the aligned span
> +	 * required by the EPC, but advertise only the resource itself.
> +	 */
> +	base = ALIGN_DOWN(target_addr, align);
> +	delta = target_addr - base;
> +	if (check_add_overflow(delta, resource->size, &size))
> +		return -EOVERFLOW;
> +	map_size = ALIGN(size, align);
> +	if (map_size < size || map_size > U32_MAX - *next)
> +		return -EOVERFLOW;
> +
> +	submap->phys_addr = base;
> +	submap->size = map_size;
> +	region->bar = barno;
> +	region->offset = *next + delta;
> +	*next += map_size;
> +	dma->num_submap++;
> +
> +	return 0;
> +}
> +
> +/* DW eDMA */
> +
> +static int epf_ntb_dw_edma_claim(struct device *dev, int chan_id,
> +				 struct dma_chan **dchan)
> +{
> +	struct epf_ntb_dma_filter filter = {
> +		.dev = dev,
> +		.chan_id = chan_id,
> +	};
> +	dma_cap_mask_t mask;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +	*dchan = dma_request_channel(mask, epf_ntb_dma_filter, &filter);
> +
> +	return *dchan ? 0 : -EBUSY;
> +}
> +
> +static void epf_ntb_dw_edma_release_channels(struct epf_ntb_dma *dma)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < dma->rd_ch_cnt; i++) {
> +		if (!dma->dchan[i])
> +			continue;
> +
> +		dma_release_channel(dma->dchan[i]);
> +	}
> +}
> +
> +static const struct pci_epc_aux_resource *
> +epf_ntb_dw_edma_find_desc(const struct pci_epc_aux_resource *resources,
> +			  unsigned int count, u16 chan_id)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < count; i++)
> +		if (resources[i].type == PCI_EPC_AUX_DMA_DESC_MEM &&
> +		    resources[i].u.dma_desc.chan_id == chan_id)
> +			return &resources[i];
> +
> +	return NULL;
> +}
> +
> +static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> +				   struct epf_ntb_dma *dma,
> +				   const struct pci_epc_aux_resource *ctrl,
> +				   const struct pci_epc_aux_resource *resources,
> +				   unsigned int count)
> +{
> +	struct dw_edma_chan_config chan_config = {
> +		.flags = DW_EDMA_CH_CONFIG_IRQ_MODE,
> +		.irq_mode = DW_EDMA_CH_IRQ_REMOTE,
> +	};
> +	struct dma_slave_config config = {
> +		.peripheral_config = &chan_config,
> +		.peripheral_size = sizeof(chan_config),
> +	};
> +	enum pci_barno barno = ntb->epf_ntb_bar[BAR_DMA];
> +	const struct pci_epc_features *features;
> +	struct device *dma_dev;
> +	unsigned int i;
> +	size_t align;
> +	u32 next = 0;
> +	int ret;
> +
> +	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
> +		return -EOPNOTSUPP;
> +
> +	dma->rd_ch_cnt = ctrl->u.dma_ctrl.rc_to_ep_ch_cnt;
> +
> +	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
> +					ntb->epf->vfunc_no);
> +	/* DWC descriptor memory always needs subrange mappings. */
> +	if (!features || !features->subrange_mapping ||
> +	    !features->dynamic_inbound_mapping)
> +		return -EOPNOTSUPP;
> +
> +	align = features->align ?: 1;
> +	if (!is_power_of_2(align))
> +		return -EINVAL;
> +
> +	if (epf_ntb_is_bar_used(ntb, barno) ||
> +	    pci_epc_get_next_free_bar(features, barno) != barno)
> +		return -EINVAL;
> +
> +	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
> +	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
> +	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
> +	dma->ctrl.submap.bar = barno;
> +	dma->ctrl.length = offsetof(struct epf_ntb_dma_ctrl,
> +				    chan[dma->rd_ch_cnt]);
> +
> +	if (ctrl->bar == NO_BAR)
> +		dma->reg_submap = &dma->submap[dma->num_submap];
> +	ret = epf_ntb_dma_add_region(dma, ctrl, ctrl->phys_addr,
> +				     barno, align, &next, &dma->ctrl.reg);
> +	if (ret)
> +		return ret;
> +
> +	/* DW eDMA static IDs place read channels after all write channels. */
> +	for (i = 0; i < dma->rd_ch_cnt; i++) {
> +		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
> +		struct epf_ntb_dma_chan_ctrl *chan = &dma->ctrl.chan[i];
> +		const struct pci_epc_aux_resource *desc;
> +		dma_addr_t dma_addr;
> +
> +		desc = epf_ntb_dw_edma_find_desc(resources, count, chan_id);
> +		if (!desc)
> +			return -EINVAL;
> +		dma_addr = desc->u.dma_desc.dma_addr;
> +
> +		ret = epf_ntb_dma_add_region(dma, desc, dma_addr, barno,
> +					     align, &next, &chan->desc);
> +		if (ret)
> +			return ret;
> +		chan->desc_addr_lo = lower_32_bits(dma_addr);
> +		chan->desc_addr_hi = upper_32_bits(dma_addr);
> +	}
> +	dma->ctrl.submap.size = next;
> +
> +	dma_dev = ntb->epf->epc->dev.parent;
> +	for (i = 0; i < dma->rd_ch_cnt; i++) {
> +		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
> +
> +		ret = epf_ntb_dw_edma_claim(dma_dev, chan_id, &dma->dchan[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < dma->rd_ch_cnt; i++) {
> +		ret = dmaengine_slave_config(dma->dchan[i], &config);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Common endpoint DMA */
> +
> +static void epf_ntb_dma_release_channels(struct epf_ntb_dma *dma)
> +{
> +	switch (dma->ctrl.type) {
> +	case EPF_NTB_DMA_TYPE_DW_EDMA:
> +		epf_ntb_dw_edma_release_channels(dma);
> +		break;
> +	}
> +}
> +
> +static int epf_ntb_dma_collect(struct epf_ntb *ntb)
> +{
> +	const struct pci_epc_aux_resource *ctrl = NULL;
> +	struct device *dma_dev;
> +	dma_addr_t dma_addr;
> +	unsigned int i;
> +	int count, ret;
> +
> +	if (ntb->epf_ntb_bar[BAR_DMA] == NO_BAR)
> +		return 0;
> +
> +	count = pci_epc_get_aux_resources_count(ntb->epf->epc,
> +						ntb->epf->func_no,
> +						ntb->epf->vfunc_no);
> +	if (count <= 0)
> +		return count ?: -ENODEV;
> +
> +	struct pci_epc_aux_resource *resources __free(kfree) =
> +		kcalloc(count, sizeof(*resources), GFP_KERNEL);
> +	if (!resources)
> +		return -ENOMEM;
> +
> +	ret = pci_epc_get_aux_resources(ntb->epf->epc, ntb->epf->func_no,
> +					ntb->epf->vfunc_no, resources, count);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < count; i++) {
> +		if (resources[i].type != PCI_EPC_AUX_DMA_CTRL_MMIO)
> +			continue;
> +		if (ctrl)
> +			return -EINVAL;
> +		ctrl = &resources[i];
> +	}
> +	if (!ctrl)
> +		return -ENODEV;
> +
> +	struct epf_ntb_dma *dma __free(kfree) =
> +		kzalloc(sizeof(*dma), GFP_KERNEL);
> +	if (!dma)
> +		return -ENOMEM;
> +
> +	switch (ctrl->u.dma_ctrl.reg_layout) {
> +	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
> +		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	if (ret) {
> +		epf_ntb_dma_release_channels(dma);
> +		return ret;
> +	}
> +
> +	/*
> +	 * CTRL_MMIO carries a CPU physical address, while DMA_DESC_MEM already
> +	 * carries an endpoint DMA address. Convert only the former.
> +	 */
> +	if (dma->reg_submap) {
> +		dma_dev = ntb->epf->epc->dev.parent;
> +		dma_addr = dma_map_resource(dma_dev, dma->reg_submap->phys_addr,
> +					    dma->reg_submap->size,
> +					    DMA_BIDIRECTIONAL, 0);
> +		if (dma_mapping_error(dma_dev, dma_addr)) {
> +			epf_ntb_dma_release_channels(dma);
> +			return -EIO;
> +		}
> +		dma->reg_submap->phys_addr = dma_addr;
> +	}
> +
> +	ntb->dma = no_free_ptr(dma);
> +
> +	return 0;
> +}
> +
> +static void epf_ntb_dma_release(struct epf_ntb *ntb)
> +{
> +	struct epf_ntb_dma *dma = ntb->dma;
> +	struct device *dev;
> +
> +	if (!dma)
> +		return;
> +
> +	epf_ntb_dma_release_channels(dma);
> +	dev = ntb->epf->epc->dev.parent;
> +	if (dma->reg_submap)
> +		dma_unmap_resource(dev, dma->reg_submap->phys_addr,
> +				   dma->reg_submap->size, DMA_BIDIRECTIONAL, 0);
> +	if (dma->bar_scratch)
> +		dma_free_coherent(dev, dma->bar_scratch_size,
> +				  dma->bar_scratch, dma->bar_scratch_phys);
> +	kfree(dma);
> +	ntb->dma = NULL;
> +}
> +
> +static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
> +{
> +	struct device *dev = ntb->epf->epc->dev.parent;
> +	const struct pci_epc_features *features;
> +	struct epf_ntb_dma *dma = ntb->dma;
> +	struct pci_epf_bar *bar;
> +	enum pci_barno barno;
> +	size_t backing_size;
> +	u32 mapped_size;
> +	int ret;
> +
> +	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
> +					ntb->epf->vfunc_no);
> +	if (!features)
> +		return -EOPNOTSUPP;
> +
> +	barno = ntb->epf_ntb_bar[BAR_DMA];
> +	mapped_size = dma->ctrl.submap.size;
> +	/*
> +	 * Submaps cannot be installed until the host assigns the BAR address.
> +	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
> +	 * for regular vNTB MW BARs.
> +	 */
> +	ret = pci_epf_assign_bar_space(ntb->epf, mapped_size, barno, features,
> +				       PRIMARY_INTERFACE, 0);
> +	if (ret)
> +		return ret;
> +
> +	bar = &ntb->epf->bar[barno];
> +	if (bar->size > U32_MAX)
> +		return -EOVERFLOW;
> +
> +	backing_size = bar->size - mapped_size;
> +	if (backing_size) {
> +		/* Back the BAR tail added by the power-of-two size rounding. */
> +		dma->bar_scratch = dma_alloc_coherent(dev, backing_size,
> +						      &dma->bar_scratch_phys,
> +						      GFP_KERNEL);
> +		if (!dma->bar_scratch)
> +			return -ENOMEM;
> +		dma->bar_scratch_size = backing_size;
> +		if (!IS_ALIGNED(dma->bar_scratch_phys, features->align ?: 1))
> +			return -EINVAL;
> +
> +		dma->submap[dma->num_submap++] = (struct pci_epf_bar_submap) {
> +			.phys_addr = dma->bar_scratch_phys,
> +			.size = backing_size,
> +		};
> +	}
> +
> +	return pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +			       ntb->epf->vfunc_no, bar);
> +}
> +
> +static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
> +{
> +	struct epf_ntb_dma *dma = ntb->dma;
> +	struct pci_epf_bar *bar;
> +	enum pci_barno barno;
> +
> +	if (!dma)
> +		return;
> +
> +	barno = ntb->epf_ntb_bar[BAR_DMA];
> +	bar = &ntb->epf->bar[barno];
> +	if (!bar->size)
> +		return;
> +
> +	pci_epc_clear_bar(ntb->epf->epc, ntb->epf->func_no,
> +			  ntb->epf->vfunc_no, bar);
> +	memset(bar, 0, sizeof(*bar));
> +}
> +
> +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +{
> +	struct pci_epf_bar_submap *old_submap;
> +	struct epf_ntb_dma *dma = ntb->dma;
> +	unsigned int old_num_submap;
> +	struct pci_epf_bar *bar;
> +	int restore, ret;
> +
> +	if (!dma)
> +		return 0;
> +
> +	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> +
> +	old_submap = bar->submap;
> +	old_num_submap = bar->num_submap;
> +	bar->submap = dma->submap;
> +	bar->num_submap = dma->num_submap;
> +
> +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +			      ntb->epf->vfunc_no, bar);
> +	if (!ret)
> +		return 0;
> +
> +	/* A failed dynamic update may have already removed the old mapping. */
> +	bar->submap = old_submap;
> +	bar->num_submap = old_num_submap;
> +	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +				  ntb->epf->vfunc_no, bar);
> +	if (restore)
> +		dev_warn(&ntb->epf->dev,
> +			 "failed to restore DMA BAR mapping: %d\n", restore);
> +
> +	return ret;
> +}
> +
>  /**
>   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
>   *   to access the memory window of HOST
> @@ -342,6 +774,11 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  		epf_ntb_teardown_mw(ntb, argument);
>  		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
>  		break;
> +	case EPF_NTB_COMMAND_SETUP_DMA_BAR:
> +		ret = epf_ntb_dma_set_bar(ntb);
> +		ctrl->command_status = ret ? EPF_NTB_COMMAND_STATUS_ERROR :
> +					     EPF_NTB_COMMAND_STATUS_OK;
> +		break;
>  	case EPF_NTB_COMMAND_LINK_UP:
>  		ret = epf_ntb_set_link_enabled(ntb, true);
>  		if (ret < 0)
> @@ -488,16 +925,17 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>   *       Virtual PCI             PCIe Endpoint
>   *       NTB Driver               NTB Driver
>   *
> - * Allocate the Local Memory mentioned in the above diagram. The size of
> - * CONFIG REGION is sizeof(struct epf_ntb_ctrl), plus space for the MSI-X
> - * Table and PBA if supported. The size of SCRATCHPAD REGION is obtained
> - * from "spad-count" configfs entry.
> + * Allocate the Local Memory mentioned in the above diagram. CONFIG REGION
> + * contains struct epf_ntb_ctrl, the DMA extension if enabled, and the MSI-X
> + * Table and PBA if supported, in that order. The size of SCRATCHPAD REGION
> + * is obtained from "spad-count" configfs entry.
>   *
>   * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  {
>  	enum pci_barno barno;
> +	struct epf_ntb_dma_ctrl *dma_ctrl;
>  	struct epf_ntb_ctrl *ctrl;
>  	u32 spad_size, ctrl_size;
>  	struct pci_epf *epf = ntb->epf;
> @@ -511,7 +949,10 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	barno = ntb->epf_ntb_bar[BAR_CONFIG];
>  	spad_count = ntb->spad_count;
>
> -	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
> +	ctrl_size = sizeof(struct epf_ntb_ctrl);
> +	if (ntb->dma)
> +		ctrl_size += sizeof(struct epf_ntb_dma_ctrl);
> +	ctrl_size = ALIGN(ctrl_size, sizeof(u32));
>  	if (epc_features->msix_capable) {
>  		ntb->msix_table_offset = ALIGN(ctrl_size, 8);
>  		ctrl_size = ntb->msix_table_offset +
> @@ -543,6 +984,11 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  		ntb->reg->db_offset[i] = 0;
>  	}
>
> +	if (ntb->dma) {
> +		dma_ctrl = base + EPF_NTB_DMA_CTRL_OFFSET;
> +		*dma_ctrl = ntb->dma->ctrl;
> +	}
> +
>  	return 0;
>  }
>
> @@ -924,7 +1370,8 @@ static int epf_ntb_find_bar(struct epf_ntb *ntb,
>  		 * Verify if the BAR found is not already assigned
>  		 * through the provided configuration
>  		 */
> -		if (!epf_ntb_is_bar_used(ntb, barno))
> +		if (ntb->epf_ntb_bar[BAR_DMA] != barno &&
> +		    !epf_ntb_is_bar_used(ntb, barno))
>  			ntb->epf_ntb_bar[bar] = barno;
>
>  		barno += 1;
> @@ -1023,11 +1470,19 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  		goto err_mw_bar_init;
>  	}
>
> +	if (ntb->dma) {
> +		ret = epf_ntb_dma_bar_init(ntb);
> +		if (ret) {
> +			dev_err(dev, "DMA BAR init failed\n");
> +			goto err_dma_bar_init;
> +		}
> +	}
> +
>  	if (vfunc_no <= 1) {
>  		ret = pci_epc_write_header(epc, func_no, vfunc_no, epf->header);
>  		if (ret) {
>  			dev_err(dev, "Configuration header write failed\n");
> -			goto err_write_header;
> +			goto err_dma_bar_init;
>  		}
>  	}
>
> @@ -1038,7 +1493,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>
>  	return 0;
>
> -err_write_header:
> +err_dma_bar_init:
> +	epf_ntb_dma_bar_clear(ntb);
>  	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
>  err_mw_bar_init:
>  	epf_ntb_db_bar_clear(ntb);
> @@ -1061,6 +1517,7 @@ static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
>  	disable_delayed_work_sync(&ntb->cmd_handler);
>  	disable_work_sync(&ntb->peer_db_work);
>  	atomic64_set(&ntb->peer_db_pending, 0);
> +	epf_ntb_dma_bar_clear(ntb);
>  	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
>  	epf_ntb_db_bar_clear(ntb);
>  	epf_ntb_config_sspad_bar_clear(ntb);
> @@ -1267,10 +1724,13 @@ EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
>  EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
>  EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
>  EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
> +EPF_NTB_BAR_R(dma_bar, BAR_DMA)
> +EPF_NTB_BAR_W(dma_bar, BAR_DMA)
>
>  CONFIGFS_ATTR(epf_ntb_, spad_count);
>  CONFIGFS_ATTR(epf_ntb_, db_count);
>  CONFIGFS_ATTR(epf_ntb_, num_mws);
> +CONFIGFS_ATTR(epf_ntb_, dma_bar);
>  CONFIGFS_ATTR(epf_ntb_, mw1);
>  CONFIGFS_ATTR(epf_ntb_, mw2);
>  CONFIGFS_ATTR(epf_ntb_, mw3);
> @@ -1289,6 +1749,7 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
>  	&epf_ntb_attr_spad_count,
>  	&epf_ntb_attr_db_count,
>  	&epf_ntb_attr_num_mws,
> +	&epf_ntb_attr_dma_bar,
>  	&epf_ntb_attr_mw1,
>  	&epf_ntb_attr_mw2,
>  	&epf_ntb_attr_mw3,
> @@ -1847,6 +2308,12 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  		return ret;
>  	}
>
> +	ret = epf_ntb_dma_collect(ntb);
> +	if (ret) {
> +		dev_err(dev, "Failed to prepare NTB DMA export\n");
> +		return ret;
> +	}
> +
>  	ret = epf_ntb_config_spad_bar_alloc(ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to allocate BAR memory\n");
> @@ -1887,6 +2354,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  	epf_ntb_epc_cleanup(ntb);
>  err_bar_alloc:
>  	epf_ntb_config_spad_bar_free(ntb);
> +	epf_ntb_dma_release(ntb);
>
>  	return ret;
>  }
> @@ -1918,6 +2386,7 @@ static void epf_ntb_unbind(struct pci_epf *epf)
>
>  	epf_ntb_epc_cleanup(ntb);
>  	epf_ntb_config_spad_bar_free(ntb);
> +	epf_ntb_dma_release(ntb);
>  }
>
>  // EPF driver probe
> diff --git a/include/linux/pci-epf-ntb.h b/include/linux/pci-epf-ntb.h
> index 0c02d709aa08..5cc0f0badae0 100644
> --- a/include/linux/pci-epf-ntb.h
> +++ b/include/linux/pci-epf-ntb.h
> @@ -8,6 +8,8 @@
>  #define __LINUX_PCI_EPF_NTB_H
>
>  #include <linux/bits.h>
> +#include <linux/dma/edma.h>
> +#include <linux/stddef.h>
>  #include <linux/types.h>
>
>  #define EPF_NTB_COMMAND_CONFIGURE_DOORBELL	1
> @@ -16,6 +18,7 @@
>  #define EPF_NTB_COMMAND_TEARDOWN_MW		4
>  #define EPF_NTB_COMMAND_LINK_UP			5
>  #define EPF_NTB_COMMAND_LINK_DOWN		6
> +#define EPF_NTB_COMMAND_SETUP_DMA_BAR		7
>
>  /* EPF_NTB_COMMAND_CONFIGURE_DOORBELL argument */
>  #define EPF_NTB_DB_COUNT_MASK			GENMASK(15, 0)
> @@ -45,4 +48,40 @@ struct epf_ntb_ctrl {
>  	u32 db_offset[EPF_NTB_MAX_DB_COUNT];
>  } __packed;
>
> +/*
> + * DMA wire extension produced by pci-epf-vntb and consumed by
> + * ntb_hw_epf. It immediately follows struct epf_ntb_ctrl.
> + */
> +#define EPF_NTB_DMA_CTRL_OFFSET		sizeof(struct epf_ntb_ctrl)
> +
> +#define EPF_NTB_DMA_MAGIC		0x414d444e /* "NDMA": NTB DMA */
> +#define EPF_NTB_DMA_REVISION		1
> +#define EPF_NTB_DMA_TYPE_DW_EDMA	1
> +
> +struct epf_ntb_dma_region_ctrl {
> +	u32 bar;
> +	u32 offset;
> +	u32 size;
> +} __packed;
> +
> +struct epf_ntb_dma_chan_ctrl {
> +	struct epf_ntb_dma_region_ctrl desc;
> +	u32 desc_addr_lo;
> +	u32 desc_addr_hi;
> +} __packed;
> +
> +struct epf_ntb_dma_ctrl {
> +	u32 magic;
> +	u16 revision;
> +	u16 length;
> +	u32 type;
> +	/* BAR range occupied by resources without a fixed BAR assignment. */
> +	struct epf_ntb_dma_region_ctrl submap;
> +	struct epf_ntb_dma_region_ctrl reg;
> +	struct epf_ntb_dma_chan_ctrl chan[EDMA_MAX_RD_CH];
> +} __packed;
> +
> +/* Common header needed even when endpoint DMA is unavailable. */
> +#define EPF_NTB_DMA_CTRL_COMMON_SIZE	offsetof(struct epf_ntb_dma_ctrl, reg)
> +
>  #endif /* __LINUX_PCI_EPF_NTB_H */
> --
> 2.54.0
>
