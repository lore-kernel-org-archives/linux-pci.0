Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793812875;
	b=LLpaD3377WM/7KjqOFlyTMIIJbWoXLz0Ve7+cNy6rJvi/xdojPcSLhlh6SMZjCPlTXgg
	 F7oVMnyCV8P3TPTmbsjLP2sMpHM94Zax4ln8XOmwPSz/BdreDPvGgCW3hBhikn4Xf5fif
	 EkwwFvJdfrp/SKXyseeYuFYaKx3277M9L9Q4JL1gh3Wp1uCH6KN3b0f2bsdx1sRvTgwrv
	 Gt+2ukK8yhj4prwEmIi8c0FNv4RUMY78QZXsnmf55p03wpG5WQPVj+upzITH+HWuneDVJ
	 7s0cp7sCXEGbTn0+OXDeYpMolizvc9ccO+hsfKjM0e3wl52rq2sMHoveMW3KRvUK+3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812875;
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
	bh=TSxfE+gz+1en2rtNkrs5hrLfsLrTU1M7/SodrHVMk5A=;
	b=BNHOMQ93NQATfdExZ9vH/kuJQi0mEGHphpQ1VU1b/naePJm0SesSKu2xhRYRHNRB4yrn
	 5jvY0eAQFuV9FcfbrWe94RQoxpWCJrr6Hs425Txla+/gZkNEyReuFCvtVw6ixkuVP4zVB
	 zTQ9SSYYPjki2uLm5wsMVPksXyxTb7yD8DcmCgt/1t3xu8HqbUJ8miYuErB0VArGse5lv
	 Qf7D0vl59eEefE/X0lTm+7DgPXII0Q8p7WLbQKmyDJsjQ5v99GEV3AhdPw4Du5X213PoN
	 gZHaF+IbIkPJSun7c8iNYggqVKJzv9iXavQTMhAvcvxW5zWdwv2GG+DWv1EnfhYf4IA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kjDfs4VL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.37
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6746C606A31B;
	Wed,  4 Nov 2026 17:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6746C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kjDfs4VL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHHjjDR3XNg4Y83tt+cCsNs/hR6p2NQmmCIWct2dggsCK3Jj5lKKbgcbOkZlMqfMDNmF3clf/im7+SUAusc/aPPYuC5UzqGQG8ppbXNdI9cP7l8BlnirNt/B3I0l0jJ1wfRYo3bX8KKQNnKCezzbV5Grn4mrBBnZhDI49h6GgjxJBkEmLbpEYmLObYmX7QujELeI5r7n7Y9/1IqIiP/8CEyJxXz46fXGcF+fRz2x8XZToCuehWJDf+9TxVyl+XAGFkQArZI1PrRiXjRg42h49wP8x6EOAI9gZSP6NQVOdm9KKF5mHzBOQGc6K22hbb8xVhPBuyXZU/yEbAJvyQKajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSxfE+gz+1en2rtNkrs5hrLfsLrTU1M7/SodrHVMk5A=;
 b=Mc15A1lBctr3eSRjo+49tvvyS+AxvM4frAwtfnnsjmvsFQLAx+wEAi/x+RkIe0/HyUT9aMFUQRDZq+jsoAWl0maud5OyPqxcZd3NQdeYFt6ap+l0eTUZq4GCfoq6V53ygunUBbz9sWSjf0In6YJCE9yu3iorVl9ngYUU3pMuGWo3j+PVurc1Zw3dtF5iYRlT9iJyra/3G7LB3XeH8/Oa0nQXooKaxKV6/6gmQVSn2IMnLDd21AOsyuODg+Fg8jWFHiE21LNQFfl1AQ14L5KSOz+Xq0FrGCG201iGKv+oajsqK01cIb6pjwsiDeJ1ACoPWiJwFq9bxVFBTZqw9j0mdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSxfE+gz+1en2rtNkrs5hrLfsLrTU1M7/SodrHVMk5A=;
 b=kjDfs4VLJxaP6oRu3jKybldJAsHcuyf1Qxhlq22/tauIXHo8OEOy2rgTuglMlN2aPgzGwEjmG7ZdrMjWGsnbCpLoIXMfzvCuPM/EuTHYyDfjxG0YFosGs4YzMbeOxgVrXZlnFXZeipDYSeF8SBAg+8LAIpDRTl4+ApRKijikcdj4HsGC3NR21uO8Oz5azgsSfYD9IOcxBSRdaxZGD6qKtIlrLgx95kMQzAIzIxPWQgBZ03AWDLU75igmQh/rglcemAow3yhCe3yhuKXDqfWwWoo/+0CgIQTVqPuYcKbActi1JVWdqlGR+ZQWopY0y/MFhgtVxxaapJFcmnAUIGXNNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB9PR04MB11597.eurprd04.prod.outlook.com (2603:10a6:10:60f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 17:21:10 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 17:21:10 +0000
Date: Wed, 4 Nov 2026 11:21:01 -0600
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
Subject: Re: [PATCH v7 2/7] dmaengine: dw-edma: Avoid resetting an LL on
 stale stopped status
Message-ID: <autpfbvm-mcvXrEr@SMW015318>
References: <20261104161227.1742005-1-den@valinux.co.jp>
 <20261104161227.1742005-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104161227.1742005-3-den@valinux.co.jp>
X-ClientProxiedBy: PH8P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::27) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DB9PR04MB11597:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8636c1-5786-4de5-775f-08df3a980523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|19092799006|4143699003|11063799006|56012099006|261028144727099003|261022105027099003|261009223027099003|261022075727099003|261102123227099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EVR3WINkEt2l2cB8kt1zYKEgbNh2bupeMNMz4UPy5UUTXmXHG+fC9/atlmLhqQhvzdvN8oZn/h4d3H78+MFZ40/yostZ3dWGMkUDWAbByIWgvThWM3u3HuqraUvFpk91YmT79Yp/vMaweJ13W0mlL6qR6meQOKQlgdFmwCeadCXNHrmjdsSkJmo2oivOM9/XCUldtnL24ebHTfZ+R7XTX6Z/jF1V05RXIY1iT39hgX7iZlxHrAwKxKPglgO5iu3auQABoal8rE5AOxsCBz/Rxh6QTc8FrK/u2z7gYpma5YVmrhiNWtkbHTt/mMdGpyE2+0dF42iw7LmcflY46Ki1Oxh9sNj6LgG8lG9dSIIOMI6Wg+JE+rQbjFZi66bKtkInlFSehxcxqbG7b4owfJ0BzMopMV8H+wkN3M9/giRCflgRLIA4IVRn3nLuALf9YkECAea6GeZqS0xEisggs8wSjroEMc5KV5rvj7mzXa6yf2WzRb6c7Yn5yb33s/GoFt34xVqwxnvilC9jYmzwLsntPlFWceNF9WsHrraJ7asFpklES6W88i8oyUKCZWGS6XSvmi7xDY85YFv6hf6+OaUmaPgf5j+G44jes8JlRjsnvLh47LLrK12er6+0undJgBcdS37kA8fVWBoDUpbFhAqAuZmvOzdkDKxGEhnXIiQ6FZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(19092799006)(4143699003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261009223027099003)(261022075727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?isUrhriQUAEcwo8INVZ/Pdy5ZSUR8t0jlrfVzL+4mbqsm3pPyVN73G5FMyYU?=
 =?us-ascii?Q?pdlni3ly5hMxrXF3b01jZnq8U1sYCZSzwAvHECQVE6dzf81d8FLaKyDazE7V?=
 =?us-ascii?Q?u82VvQXc4EV8BRLpcEBoiEY3yJFHYU2BEAczKEbKEpxhEl0QjTMqBwpP33iX?=
 =?us-ascii?Q?ikVJnG9pf5BxZKXigvqoc8k5VsAwVnh1lfPB3bwXOANueEvl2/Pq9fW2JwjG?=
 =?us-ascii?Q?9i2rSV0d4SxZmGs+5/sF5bZbX49D8oeAUgzzq87pvYclP+H/73oqlaQDL8aW?=
 =?us-ascii?Q?5WZVukl90ccGYK9SIcXp7ejOoJSC4RC46+dsj0E8vdjcyQQWGmaBOoD23eJD?=
 =?us-ascii?Q?4iWfUfSXoqwgkr+KMNQagutgLMP0k517OJWTSWlKnKm1e6wDCXR4p87dVFYG?=
 =?us-ascii?Q?fWJdWkhl7XOZt/tHTvnCpUMDHaqNF/F5kdqdxGqnatxLEZsDbWu8c9QiQ4A0?=
 =?us-ascii?Q?G8x+2QdO4jH1D2mCCJlkS84AByiueadTutLjcs+QaEqJtuqRTWfSve42weUm?=
 =?us-ascii?Q?dcaHM6OtvjpkOn2I6pGQMiyHwyrC/nwPipW90u16/2vIN2q8ATVnWyqjHsUx?=
 =?us-ascii?Q?TOS8WKkpb1y2kbCmRRW2C9QSQr+PPIYuYYTFjRayHJseL1AtvMlcZKY7EKgC?=
 =?us-ascii?Q?prHYT/bgI85/ZAnn968Cq3GtG2ewp1EeJ6DB9dKyMoIyJMcQyyKEyPYftSYo?=
 =?us-ascii?Q?D42AeIkwYfv3RaKil05x7tLXWQr4zB/tDPXUUkrymIzdTkEn22D28IZjF15U?=
 =?us-ascii?Q?eMbHMj1ynLLioDlDHDGYq+CNIIOK+UkInDEnEXJvKzHMKHznb3M892PGjQnS?=
 =?us-ascii?Q?S9LpzyXPvmJaZdNdcHQs3hnOcw5sG+MBMjV5KbemuQCRIPXmUxECVDr3jCUO?=
 =?us-ascii?Q?Z+hWQwwlDZmKBrk6ngH5lJr5QbS6p/GHRlXVXTZLj4DbUSeGbqDTIwE7CoBN?=
 =?us-ascii?Q?NrrKvVjqjgw8KDE7Jc/j9k8ni/qFDbCKg+EsrsF2xlY+7/EZz0RPOrsRQbOp?=
 =?us-ascii?Q?e53gGS9Onfxw0Efc7FIlGeDCbA30mHHxCBPz2BqQWs5NKdMgQt7eBZtbyduO?=
 =?us-ascii?Q?1IBsvP3zEYYi6ITx1xYRKEbDSLvId1B/erLg8X55+yl90ZfK9Oqp6AtxPriw?=
 =?us-ascii?Q?mq0GhLEDBU7T24nBUZB97cBLmYWdX3NFJg8iYfLs3gSQjb4gunfcdzvQUzKj?=
 =?us-ascii?Q?uTuza205KnMIZgULIqJsgIawkdIPF3PTzc+oDYB2xT3QWR+j4jU29JygSYfB?=
 =?us-ascii?Q?jMjhCrBRabP0iEqhDUHH7Ac3BN8J916eGWdlLF4oSox1PGeJWAP84aIDke4Y?=
 =?us-ascii?Q?3dduDt8Q7+5FxMIKsFxZT9ddUdDASODDipBLLMV7d76e/qgi0CM54FhwVhPj?=
 =?us-ascii?Q?GPYZ5RyvKc9DPyZX+7NM/DKCEJpZbZv+qio1pT4T0+/a6Uwy8t4mLhpBXcG4?=
 =?us-ascii?Q?IkDShwOzcwED9VLga6R/Hz5vn2IVrwx16+VNXkN2taWgFlGCBxYUzPdb5UP5?=
 =?us-ascii?Q?bU7jfNhGdLEBKi5hvfHMCCqRYuVszqYk5yoP7mzSMgqavokLpG2cz+qR6uhF?=
 =?us-ascii?Q?FyjJqxjeDbybwr8OjB46/lM/Ht+v8sWyHheNGipGgQXLpptTCG6R8cuMi5NT?=
 =?us-ascii?Q?hPbrBe0SViIBUy8wkqfCjLfDfpsYQKBLhR8qVijPIRZ1c8gpjgqfo0LUYxtz?=
 =?us-ascii?Q?1XFAp/NU+Pg2a70ncXeeU5Y0ooTfcENht+jeAuBeTm/qSh403Spb2o7NpuvJ?=
 =?us-ascii?Q?NFoeOoDg8BgSjxTE2gJFp6CDKz/eemaOEXkjqoeTWson9zseCkK5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8636c1-5786-4de5-775f-08df3a980523
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:21:10.7702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liBua687hqYRRmMujjiIo0X0hGUXLLOtFuSiekUjoGdts6+inxINLdBdafJ6yGkmM8Cn8UbQSV/TDALsO6dt32iUhLxEPZqtanmcm8tH/Qhw0yoHHrwjmmlbNT78TeF0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11597

On Thu, Nov 05, 2026 at 01:12:22AM +0900, Koichiro Den wrote:
> CS can still report STOPPED briefly after a doorbell write, before the
> DMA engine starts consuming the published LL entries. Finishing
> termination relying solely on that value can reset the ring while a
> transfer is about to start, leaving hardware and software ring positions
> out of sync and stalling subsequent transfers.
>
> Require LLP to reach the published tail, on top of the standard criteria
> (ie. CS=STOPPED and zero transfer size) before
> dw_edma_finish_termination(). Non-LL mode behavior is unchanged.
>
> Cc: stable@vger.kernel.org
> Fixes: db79c4e264ef ("dmaengine: dw-edma: Make DMA link list work as a circular buffer")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes from v6:
>   - New patch. Resolve issues found during terminate/pause test under
>     dma load.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index b08bb31657c9..fb38d51037c5 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -146,6 +146,23 @@ static bool dw_edma_ll_pending(struct dw_edma_chan *chan)
>  	return chan->ll_head != chan->ll_done;
>  }
>
> +static bool dw_edma_ll_stopped(struct dw_edma_chan *chan)
> +{
> +	return dw_edma_core_ch_status(chan) == DMA_COMPLETE &&
> +	       !dw_edma_core_ch_transfer_size(chan);
> +}
> +
> +static bool dw_edma_ll_drained(struct dw_edma_chan *chan)
> +{
> +	int idx = dw_edma_core_ll_cur_idx(chan);
> +
> +	if (idx == chan->ll_max)
> +		idx = 0;
> +
> +	return idx >= 0 && (u32)idx == chan->ll_head &&
> +	       dw_edma_ll_stopped(chan);
> +}
> +
>  static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
>  {
>  	struct dw_edma_chan *chan = desc->chan;
> @@ -455,7 +472,9 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
>  		dw_edma_finish_termination(chan);
>  	} else if (chan->status == EDMA_ST_IDLE) {
>  		dw_edma_finish_termination(chan);
> -	} else if (dw_edma_core_ch_status(chan) == DMA_COMPLETE) {
> +	} else if (chan->non_ll ?
> +		   dw_edma_core_ch_status(chan) == DMA_COMPLETE :
> +		   dw_edma_ll_drained(chan)) {
>  		/*
>  		 * The channel is in a false BUSY state, probably didn't
>  		 * receive or lost an interrupt
> @@ -790,7 +809,8 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
>  		if (!vd)
>  			break;
>
> -		dw_edma_finish_termination(chan);
> +		if (chan->non_ll || dw_edma_ll_drained(chan))
> +			dw_edma_finish_termination(chan);
>  		break;
>
>  	default:
> --
> 2.54.0
>
