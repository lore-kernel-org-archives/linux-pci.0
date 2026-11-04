Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793813735;
	b=LhqOrdx0DRmG91yP0OxHcGadddaIDaGNpfYflMdhWrOx0t1yNdEfhv/9deylnSh48w/g
	 RY00fN3RBicEwXvUVWouB1Yb/xO1A7T3+Y4D1SPayZsCWWf+JCLy5Vd3X3lxu2ATdITyF
	 thXBqiJ572k+jQ36QZ12lPokr1TcDeoR7rArlKMoxGHISk3Wac3iltjCmUP7gXNKD6nrE
	 /Ln12CctgCphSKCxjkOtrQldLfD5ExR2c+KwEZLEMg0FAtfqGdtxe5rYwrrX3WpNx3r4m
	 Y80LN7cOq0PXg/tZ9W3qXnXsCiqAsgnldsnxgovXuHjLxD0yUTCemVzzv2h1AEzrBLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813735;
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
	bh=OxGxdpzy3fOXvtteKey3N0WFb4e8fNOktDU3//UaKIc=;
	b=nZe1gSPh72UU621bFGYzsRb7IzvU7J/2KxHubx0ZkaPUiUv7s7GT23+HD4pb8mEoiqj9
	 M6kGqYKxAFs+/Lw93SbGIUSeAg4pOyDn7aLMxJ5B4QB31JjVh+mk/dXZgyFlkr74x5VaN
	 ay/eVnPF3fGVucjFiVcyhNNCIaVqldwYJRQA0by3TbZ94DB3MLCNLp/4UqUPU6590s/7F
	 FChU98IbuQK6Ym+4795V6Qah6aAgVGdEPCRfPwcjoD434eDo2YBxDISo7kwKkcbEtuy3s
	 MH3E9KkxPE781rnQgTI3Y94j0UA/YkItj/DkuXNJ+kXkfD+lbq+Op31ngxQCEVwZY2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NgD6cBRe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.62
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013062.outbound.protection.outlook.com [40.107.162.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB4606A329;
	Wed,  4 Nov 2026 17:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6FB4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NgD6cBRe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNP0bNjeITaWsASYQ1q6vKWlriku/PhROubxVGbB2gD1kLIa561MPF0/J0un90RThsbRG+FtSPGmPn47ISbO4pCe5zRCTQkz7IfCO/gry/GB4VX0PCTsgGo531Wx9X8sallR5G/NUg3QWIUV1Xeciy27X4Dwx70WF+Czcjm8fFwfePL35IulHhH4BIj6kk3zyT4v3/9N1ckH1RTVBVbhDl50FKPWXSx1l00QxMiDuxPoXhQkvGGjpKUxCzvgdZMmlf8Gw9o8jUqs5GIXtqxLSlabYJixXtBsp/T1z/n/ifglHDDL3d6VJl5+es3YmS6pW9OGFB2DCC/TRxhm6jvCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxGxdpzy3fOXvtteKey3N0WFb4e8fNOktDU3//UaKIc=;
 b=uq8znzl1wRF6e8w9CDXFjvcRZc21biSXVkVK2BftBnQDqFZ7yoH6wjnhI6pl+ypVDzKkYCeLjdnk8kL/8tBMzaVdKk8p4DkSYUEA+8o6xQRWe8VkJm5NkOUo5hNauyJ3B+Z4+C8VyZH1nwSg4d+l9hE8z2toRilBxcwR9kiUxIgqenwtzYwQ8pb11K6X99ATpKc3jQbuF8HwQfFaV/ifWd66LnK+rT9o8g1Luyu/7ZapNGD5XHHTfC7iPk8nuyfIRcq80/E0bxPZnw4nzoqP9HUNAeDw7PUgZSg7B16ygUdnzwwPqYKq1g9BqP+caVDtTK/H0HHbGc/h0n+R7IMQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxGxdpzy3fOXvtteKey3N0WFb4e8fNOktDU3//UaKIc=;
 b=NgD6cBReRwANNhe5Jyjrctx+yPiR9TlcMFgV6FKMthO/Zsv2Nj9Oygsx5iFhxYwUDOAUqR/iS5Emd7XzVJ4AzAolB+fC13EgWRnEpVRA+0kJdgbd/bvnuy1lEg8iaA2sZ0IlZ8ache2K8QkFQ5yrFO8Yy5hwKlEIHvgOFNryx8dBu8zk4IYky4yv/wUA92ZcZrn5j165VA3JOn70fa03i1TppXMd4JNMzlmyboiimorwTx8WDW6dpH/bxSRRf4xUe7yYRSyaKmDJ8Pb3Bg3I6i5ZS/pWIYYnmC48+Xkh5yCKI9oy7G/L5xUTU4MUm/Nc6qaSQk0lx1FQ/ZkRk7uJVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS8PR04MB7591.eurprd04.prod.outlook.com (2603:10a6:20b:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 17:35:32 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 17:35:32 +0000
Date: Wed, 4 Nov 2026 11:35:23 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devverma@amd.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 3/7] dmaengine: dw-edma: Factor out descriptor
 completion
Message-ID: <auts2-ocM1pLv2nN@SMW015318>
References: <20261104161227.1742005-1-den@valinux.co.jp>
 <20261104161227.1742005-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104161227.1742005-4-den@valinux.co.jp>
X-ClientProxiedBy: DS7PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:8:55::23) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS8PR04MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 8896df66-ffc0-4c0e-6cf7-08df3a9a06a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|19092799006|261021121427099003|11063799006|4143699003|56012099006|261022075727099003|261009223027099003|261021123027099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8u9uF6EJKJPlisJj03BzUWI8bVZKUUUccd95zs0LlbcnlGaIASWMK6fVMBlohZWUwMwIlsm2MnAq51w7ozTFxWdKp0qW13DxVkvPfcOCMeuryv+K03+OaKGr0VcvcfqeglVSAfJAbMXePnBjXqyw7PYw3z5B93XuoF38zgU9JUqOqQkn3osOIzBN6AM2NH5WhS6qFCn9I3h6C261cCZxdCiMJ2Avhsxcg2KlQx3fku3/JQBKRfcXFj4SgzsbOzdPx950PGecA1Ft/dE1jmVJfuaHQ+EdHbZ+D+ouHFhlbGmMWKj1PwaMyyuA1Ix9Po8/LKYz1MSctbcBeXz3dsa584891vII2tSS2rxqgk7zpmTXfO+RLRuwwGncIrnDE5aRivJq2qYip0HsKv+Z4zl9BTGAfiqSbZLgdzScxQ59eMkZrwlKUJgrFTsfX071wfxJAT9XBirqbzVl7o/5GXDde6SUrdXW6I1VFPpJEGRFoG60tizh6wZvUFeo3EO80fSv55qq8FY4n/YJ9s5I3wUvOT0SBQvqiHKzGU7m0TiVNLa/YlI/INjbowqIXjuxiMQzX2/h0AtIFWbsegH9fAlJqA2Cr2AcsgmpUcnS3FqTeBM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(19092799006)(261021121427099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261009223027099003)(261021123027099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3xlhFdxL/TvyQE16U5lKi6kbXW6VwwAZ1cqJD2eFzDHlQ3N4N4itEJUPm80w?=
 =?us-ascii?Q?dazJ9EgZdRIhZQ6JnPi+oTDHzOS+W07UCVgFrC/ycUZfBzZy15D7xfAhob43?=
 =?us-ascii?Q?Mbv8iBnF85pv04Kt/Cwxz2zriH86qlK0N1/UdoxuWr42rF0aWMQo+5tiZByb?=
 =?us-ascii?Q?fbfDghH1zR7XQcKdnpqp4j/Pvo9w1bASD84tGmPrzV6tKndE7JmMy47lRE5/?=
 =?us-ascii?Q?vYPpApc1m/CLQnrwqxcd/n0Tcqx4t8lD5pbcsNmxnnHw4xoQDI2e7sFoixQV?=
 =?us-ascii?Q?cmpWW98LLOW1vXqNprUfQOtXVUqbMmACG3BkWGhgBMEy0mrWsvwbM6+a8lee?=
 =?us-ascii?Q?GXbeu05/4O8mRIYPIclA5rB83w7ObU+Tsrs+PJ6vnzOsbmqImg0VCe9EocLi?=
 =?us-ascii?Q?BAHc+XTwM/17e7BlI3OfCMDZTfs7BS3uR9GOtksbClQbNhxRxHoimOk460Bv?=
 =?us-ascii?Q?0lGdvZHuljZYaF+3jL/pejeIjCqg0lVjvi9a0l+f6XJIcKtnODDpH4hD2NEi?=
 =?us-ascii?Q?0xM9iMpdIUBxNDhifbVNxMvopJpkRoCfC1xqwQm1Gn4wpdp6nVMKfXNm9ZNh?=
 =?us-ascii?Q?3qnMLYU0lBsrefB+pVag7KyihYjtDY4RicMnoJlvAybnrkuXY5Gs4sUiRM80?=
 =?us-ascii?Q?JVIC1N62knNHgWER6lthMwEOp+Ta+CZ0dwCszZdawfGfKRZiee/hvpEuS1S9?=
 =?us-ascii?Q?SjXLhqPkpxELWTiNABDnx4PoycBsyQNutYwOYlcbrV8P3YQNj/4VU9hESeH0?=
 =?us-ascii?Q?E2Rb5b6+SL/2BHuaZ+08dpOe9EsZ5gCnKkkanoOEYdAs7/wK0lew2dy/KYfb?=
 =?us-ascii?Q?g5tUTx6vQlUYIaBixP0HuwlWsBPQnNyNq+fz3Sg3jeYOfkkRkPeSmRv0MR7k?=
 =?us-ascii?Q?D6nEawiiPjgiQGarT6vRihh+ygxbvPbfFunY9UEA7kcFKMh/PPADjyQas2mL?=
 =?us-ascii?Q?SEcMMzQpGLmwCsHE7fdVjt1KF/AJzD6Ors1fQM55lfAkRRE8d6w3WuQVjMlm?=
 =?us-ascii?Q?GAvyLiHEVOJgprHdd42HTkl8b+9KJK0WG8KRZY3jitEcn2VnTewtYw7bJ971?=
 =?us-ascii?Q?ZvOmjL89T8S6vNLslR9+6xNISjqs5sUMkP54TRTnj2t4GHZz7zk3fK18eoU3?=
 =?us-ascii?Q?GeAS56vSzL2/EfARDG/84vz/++6o5g3Y3ny9TN3kjOQFlyZhDGmmf2s49FJa?=
 =?us-ascii?Q?7smnMw+77kFrpaVi2Zx0oeZQromOE4wP7xx0Z0mejU2AwQjEffe/Z9OxMfsS?=
 =?us-ascii?Q?FKpVHXobcgDCWUFAW5pL8QLTGgKB3gxJXvMlSaOPi3E9yAzigVHdyBPZEMH1?=
 =?us-ascii?Q?Hojw6YazxOGZilcjRB+m0cwi0xB1lBzsizCh30RHWoix8n9G5hy0xEaoaNeB?=
 =?us-ascii?Q?Mj70cJGoZwDmw7vgje1zGzCOF0T57e/hQIvxJVHspvj/tOKuIIisB0v5NyNR?=
 =?us-ascii?Q?yQI+IYO/EvtkqjFyfKY8i6ckpkSlXD99MOZNkXmQl4l3ZYa+owXd6L+oXcHt?=
 =?us-ascii?Q?/1fgnme1+g3Awd5K4Ud4YGfwKaclUp6DdPkJTQxEIao5Ok6rnFXqhWcmK2Iu?=
 =?us-ascii?Q?eDeFzOR0ISnRc39jfPDwhmCXXnvmcG7KUmtq/N+wyRxjFkxtv/JrgBdCIRYf?=
 =?us-ascii?Q?DS0f/M7qCXvbVsAwhwkSgdoawJXpCtNMeykrxWgJwVihniAYTSvZEPf68O/T?=
 =?us-ascii?Q?pxDGO1/ZqvGCn1WQ1FnJh/jPKdlEsKXcMAu3AyUp5+Yu9po/RfDDOOmiIpOq?=
 =?us-ascii?Q?g1AwlQa04+Fus35VMGrpoKrAzRRX6AB4ySDRgPL3FYDkHiheJSAh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8896df66-ffc0-4c0e-6cf7-08df3a9a06a5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:35:32.2830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjNj6HMQ2mmWVKnnk5H0kjk2n1w34N1a8MsIeVodfvCL2bqTnaTDXAiOaJJbTxGgIr/0kx0dGUIpOys2kYeLW65Zr5br+XVH/iXLPZD7x+DhKdKlxHX6vmJSX+6R6qg3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7591

On Thu, Nov 05, 2026 at 01:12:23AM +0900, Koichiro Den wrote:
> Completing a descriptor takes three steps: record the callback result,
> unlink it from the issued list and hand it to virt-dma.
>
> Factor them into dw_edma_complete_vdesc() to avoid sprinkling
> vchan_cookie_complete() calls throughout the driver.
>
> No functional change.
>
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes from v6:
>   - New patch, per Frank's comment here:
>     https://lore.kernel.org/r/auTL2mHwCt20uhII@SMW015318/
>     "let vchan_cookie_complete() at one place only".
>
>  drivers/dma/dw-edma/dw-edma-core.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index fb38d51037c5..e2f7af5969c6 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -107,6 +107,15 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
>  	res->residue = residue;
>  }
>
> +/* Must be called with vc.lock held. */
> +static void dw_edma_complete_vdesc(struct virt_dma_desc *vd,
> +				   enum dmaengine_tx_result result)
> +{
> +	dw_hdma_set_callback_result(vd, result);
> +	list_del(&vd->node);
> +	vchan_cookie_complete(vd);
> +}
> +
>  static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
>  {
>  	u32 i;
> @@ -788,9 +797,7 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
>
>  		desc = vd2dw_edma_desc(vd);
>  		if (desc->start_burst >= desc->nburst) {
> -			dw_hdma_set_callback_result(vd, DMA_TRANS_NOERROR);
> -			list_del(&vd->node);
> -			vchan_cookie_complete(vd);
> +			dw_edma_complete_vdesc(vd, DMA_TRANS_NOERROR);
>  			if (!chan->non_ll)
>  				chan->ll_done = chan->ll_head;
>  		}
> @@ -838,9 +845,7 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
>  	if (vd && chan->request == EDMA_REQ_STOP) {
>  		dw_edma_terminate_all_descs(chan);
>  	} else if (vd) {
> -		dw_hdma_set_callback_result(vd, DMA_TRANS_ABORTED);
> -		list_del(&vd->node);
> -		vchan_cookie_complete(vd);
> +		dw_edma_complete_vdesc(vd, DMA_TRANS_ABORTED);
>  	}
>  	if (!chan->non_ll)
>  		dw_edma_core_reset_ll(chan);
> --
> 2.54.0
>
