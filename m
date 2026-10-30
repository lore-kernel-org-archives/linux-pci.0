Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793379304;
	b=Ic2RwXg8Cb1y7ID+ZEx11B/NDrfdgIcjg+30+vpReRqwRj2QZIxIrj9qhpNOaiDARksx
	 /wXasz4eFhvSxpUZDriPZK9wb9JkZgtyvjl632yjBJxFrM5Ag8oXE81nvE4t5csw0f4QE
	 QQ43iqIIfLSsE4UyyxW+BXidVbe/MenLnDiPKaMUA9tmjmjCsY+xpqidMmHlPHed2lCo/
	 IAl7wXqIBgbYTQHzuJRdvyGJ0sRAt6q2gXJMa391fM7sFJPlAIwvwvKsR+iKkKU4yNDfp
	 7u7WnGUNqJsLn1YWlVf7ayKltY5t/aicQ9IHDyk7d/QMpz4R25BY1n2V8ckR2dgRtKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379304;
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
	bh=YaR8lWLq1os8sb5kRQs3obH1s9zn8cjlDARw6JScnoA=;
	b=0BHmPW8QFkSmFN386Ic/QWEDydCWhj/mIP2hgcKCNYvHErajCZUyVX86gtyYwtnzEpQ7
	 7No9THtlmszPQ4RZ3kxvCH8GiOWJQe1uVDirkePbnt6zDrd2r3UDuUz8ZXvU+Sb8Y2c8n
	 126DsCHet9IPqgJkvA4SAWsj8Yw651T1kzrLYSTX/aJmWnXcyEdnHVUmvTMfsA2G0yjc1
	 WS4dCMCZ7ed9M7w1NAEJa0jtQaRxjIgE3yJqToOpwGD35PIhuJMKUcr5q+JTmc6+HZXop
	 dASdLZVZROXaLrOUSuY8ttDX/jDRpSdDfufcQ1T3liocg41PPZas7zUv2N7NGJPhwdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=a2p3PFx+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.36
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD30606A320;
	Fri, 30 Oct 2026 16:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DD30606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=a2p3PFx+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr6sBG9he4wWl/yYchRKoArVZsparGXK8ItlTctNcpRvGYg/7YASXT8I95FlUNSmtLKAy5gV2dhDrwQ44EW6MWhEx6IQ7lDUZ+wTmhaaZKXvqmQL340895+BMrqb1/TTFa2N/Qjrat9IRNqiyTx8bQDzFrRFEta7+7t4wZd4vUQU51Yt799LGjzGracilCfmjU0kN9ZxEApGjAuIL5FP9HkGj5Oc5zEvXHW6E7Zrvik7bc9GHjvwZGBJEHavvVkxa6O7WIo8Z9SznHCCbTEceY0zEcRY436tW1+MrSZHhC9i0Hp4OgQ8aOhxJwAWCtgk/dHl+KnLj0wo7G4TLCnV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaR8lWLq1os8sb5kRQs3obH1s9zn8cjlDARw6JScnoA=;
 b=HYMnYjPsLgzuabaznx4dJi1WwYtut7/tOGQkl5PdOA8ruTo62RvLsGfLZYplETA1R5xQX0O5sD+7W6r/oEzqHjA6UfRdqFs3o8CBmd0LZjrZdQ8cD9PROc787wRZ00eeJN5M/H4FSpQixTcUV8Jql8+TZIgo0HQPl2CpXB/10TB0CPRPA69YlXLwW6t50mtrVS3j9INbRAfMusjfLZTqOtMMHWzatQufQFz+vxqBmxxnc/2wnAdUgybjkU4NAx4tivX6Li2+OeYzbuGSZJoktXalIOwrG0NuevdKDTbBgUHlxsDbTSwz2vs1s3A2jgH/pO4mABy5nHoR2N//B5TNWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaR8lWLq1os8sb5kRQs3obH1s9zn8cjlDARw6JScnoA=;
 b=a2p3PFx+ey18Bg+2m6hySurQ/3MAiWSh0I40uxms/6+7LexJyC+VfGgREIQoW8i+K+8YKbVfhP2Z9H2o04Bktea8MhjhLC5P4rqjJemWYSWewy0NPPMOIMb/wAolSg/eo5RjfzohWTRFX15tmdLs6jhEHfvW6fgujwSZ9GNfWQcSUOEjvGp/KpjGAcrGb9tG/B0+EOE0fKHDB2VSrWTPVzsuKf4c2X8zBFXzxXXVf3PqtGWfZ5IXeWCyDUU9lmIH/AuPCN4pauN9Rwap9Irngsm8zLdA4UbF4M1IUs3BrCithuoBZNu1GMSs1oXu2RAGzyN9v0yK7sBgjL6Xqr3WRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by PA4PR04MB8014.eurprd04.prod.outlook.com
 (2603:10a6:102:c7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 16:54:59 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 16:54:59 +0000
Date: Fri, 30 Oct 2026 11:54:50 -0500
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
Subject: Re: [PATCH v6 2/5] dmaengine: dw-edma: Reclaim LL entries from
 hardware progress
Message-ID: <auTL2mHwCt20uhII@SMW015318>
References: <20261030150742.2586776-1-den@valinux.co.jp>
 <20261030150742.2586776-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030150742.2586776-3-den@valinux.co.jp>
X-ClientProxiedBy: DS1P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:8:44b::18) To AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21)
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
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|PA4PR04MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: a94d3bc0-47ad-49f6-4995-08df36a68853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|4143699003|5023799004|11063799006|261026135527099003|261026140227099003|261028144727099003|10067099003|261021121427099003|261022105027099003|261021123027099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	E0D9KDjqfSYH2hSnPVVl7dhJhVceFEBYFka5TTFISkZBAsJltVC/0E0HaE6vxZER/EHkoyKqbLvrpWSR90LvRwhHK09NhsyNq2Ix59W6tEUzaBH/m1+ECBgIO81iL0zdr3wCf4grnRq1tlaVZQgHZJ0QOc3gH4XJc2eGbloz+qY3DCFrvwvG45QAOLMve768FVwVAg4lFdqhjP7f2RK1HMhgc/2HlrfdO1r+ZrOLYdZ3NqTkgu7e4Jd0iCvwRgAe4bI9HK+dGAKkSUMChGQAwDGrflK78Lsje2/+c2KuHtYHRMrB8fEDhI2+qUV9/1Zp+P8u+WVTx7ZNGWBjAfQg5TmStO6i4KWznCZ2xBWlkXrb6VvTYstQdE5S0lfolvvnraHwKYVbeoB60PeHvKjs6Io110uEawiJCjNuziZ44wa2FqXgtVYT0uIPaMQvjrFcSxbK9L80gMHebFwGnTvWT8TwupZgPjpU5ZQTSOwnaHl+ayH7/hEbbS33g0ALVV3WpYcla0AHmdRPjbexg/LFvrsM8Oj2xSWgZQ9yLZ8Zo1esEmnNR5t4BzXZ+7oX/Nv5tWQyoFKOzl6fXEufjxY4/dY9mtmIVaSSYKTxkcjnp+6tAsUvZ/Yyu2O4fWNOIdPk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12445.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006)(261026135527099003)(261026140227099003)(261028144727099003)(10067099003)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1S30Pfo6plAMtxiBVAG4DcpbABx9ChKsUJPUh523rohcUo+yNW7NVu3LiPmk?=
 =?us-ascii?Q?85AT/znX6DewWG9BjcEgQ1Ae+nyYgqBob7tdb9xyAS4JLB+BIzxidSpbRd2e?=
 =?us-ascii?Q?TdpW93/coEM8jT2CocxlhWSIQX0riZLpUheB2Q39HKd83Eit5x3MPmRVQaw1?=
 =?us-ascii?Q?EFOe/tXnPYm6pb6RHVmPqMnMBwUmTzAgSsA5RrcivqwkH3q+lt3AIb0hImrK?=
 =?us-ascii?Q?FZYJK/ZyZjzC9MXEL20xu2DjTWNYt4o8uNdXulShbk4OCbqz/sfhsq27TLyo?=
 =?us-ascii?Q?pnTGFTWu/oNeu7rVtQO3COff7pTlFJNHEzsnSkDz5YsrZKT1zAVG3wl4EfFg?=
 =?us-ascii?Q?saPkUt9o12HRbCpU6syZVXbYW+jFi32sDYpgxI3iCNU15b4rrQ/1bGPe4P2e?=
 =?us-ascii?Q?lHQEdAzVfJZjLqjJOIK3r/mqHjxRB8xcnVfWHr2NZeXosfw2j17jlb3EzkEJ?=
 =?us-ascii?Q?mchfteV6JvdHKrUy+VbPC2wFJGPi5YGjaXAxqlPtNFVVkWj1EzVwz1bIOpEm?=
 =?us-ascii?Q?RoV7uVdN1V6EazeL/K1U7SUd4qKRuiYR70O6GMIIr+W7oKFW4EfcAa6iHtfo?=
 =?us-ascii?Q?K3/423lynpnA/+mzjoFndMjw+IZPGvW6QFtdtmHG1nxWPK+eDCCs3gcKDO23?=
 =?us-ascii?Q?Id/txJpVS+UbyLvFW9YxFROw/Cnm4+ybZNyaGEEXRe6v3k6wJQ3T9m2s7rNJ?=
 =?us-ascii?Q?vIYzAb+C3wwjC2j/U3Mpg3DGMAboalGxPTAyH3iP/+q7JANx2HL2zbE08RCH?=
 =?us-ascii?Q?zi+8rfkNtcywlI0RN6fquF9LEkEVpYdwL1/EbjTwxnmB3FRuL9uzj5QIYVZc?=
 =?us-ascii?Q?tHkosp7+jJ7uBRdIVWTTAyZ8DkCHSGL4Z0pJrv00eFm5X8daR3LYO5wBr5GP?=
 =?us-ascii?Q?ljt88DvhP6ZQ13O1pGlLmqpAsrSqKgKMddJOj5x+TXneRfdfYh9WiWxm6J91?=
 =?us-ascii?Q?/XQgDGCHumqYKEXRMcdqahB687apOslLXP0tnXoCc0M4Hyg1YEw9vqkMm5/8?=
 =?us-ascii?Q?pds9eJJBdUxEkSK8kRumLa9Xf+NaGrBEuOJAJV7d0/oXdjEkIO7qyKTuJH/g?=
 =?us-ascii?Q?YGmNQrNXYfbgZfVFgcJCQM+ECMnOrtZ2c0AFGLnANLT5uAIhnteF3d35amxX?=
 =?us-ascii?Q?GNd8bMXouNTLwfdvC1f0+QZWtVg2lQZ3E3NaVpEe/ZwmxhJTXoJbY+h+fxqY?=
 =?us-ascii?Q?kd2FXV13c/h7f4rkCGRZVZ+IGsbUuSUkQuVZ86iEqsfKbUKVkIRO6SWCrwyt?=
 =?us-ascii?Q?sI41JGWJApkLHI3YTjZc78O1PBmIq9RBc+kUB/89SS1NQ53aCs8RqpDdhQs0?=
 =?us-ascii?Q?RxfaM3LjxWjpLNXHS97Zf0pwjLN8oSu93pUaQ6hrkzwBZhGev9NFPm/TGCBh?=
 =?us-ascii?Q?Rg/dukTDNU/uTa4XWlCM2oZud2jhygJiJK3xWl6dVaOCiPgFJrtU4WOUICzg?=
 =?us-ascii?Q?Bg/IYrDavla2JcphlYrqd2ZFZ/9UOH3SxighKPknGg1H0km+PWjUSFQaxW6K?=
 =?us-ascii?Q?dzepkJAIbTe8GxeDP3Q8zhLeNOAgE6WlravhwUlmZDtIpqU6e4CThkygdUed?=
 =?us-ascii?Q?MjN8El40lpprfTYbi7u2K2ba1jjmymOvD/lkg9uye+v8kB+qgvMxNjTbibQL?=
 =?us-ascii?Q?YzFWhWi/M8mLI3wxEoE2AVuvaszsGZlceRUMS/wimhKLeAnQePNB6EsVBlgf?=
 =?us-ascii?Q?aYu0/t4g/P1TIuQ6klsRW6CET96xMwpD5gwXJdufYuFiZpBpWJYHzpm8GNKn?=
 =?us-ascii?Q?+CPuwjayhQzRigAphdo8cKI1+leTuOmvk6Hm4T+OpTknyvBKTdyw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94d3bc0-47ad-49f6-4995-08df36a68853
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 16:54:59.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oze0VrwrYMpiAhFpIRVK7Wf6eZ5O/2XAxpZnJAtsFY3Wq/uiTeoXEPhZjDW90HL9Vc+q0TmifMlFbIUVGkBtHd+RlZuHmziYePL8yhRNGCIolg+UzeGxOADtgos3ecsP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014

On Sat, Oct 31, 2026 at 12:07:39AM +0900, Koichiro Den wrote:
> Once requests are appended while the channel runs, a DONE interrupt no
> longer means that all published entries have completed.
>
> Use DMA_LLP to advance ll_done and complete descriptors in issue order.
> Reclaim entries as they complete so descriptors larger than the ring
> can be submitted in batches.
>
> DMA_LLP may advance before payload completion, so keep the running
> completion boundary one entry behind it. Use DMA_LLP itself once the
> channel is stopped with a zero transfer size. Hold vc.lock to serialize
> progress with ring resets and doorbells.
>
> Refill reclaimed entries and restart a stopped channel if work remains.
> Defer STOP and PAUSE completion until the channel stops.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Reworked v5 patch 13:
> https://lore.kernel.org/r/20260812155721.2807506-14-den@valinux.co.jp/
>
> Changes since v5:
>   - Read the registers in the progress handler instead of retaining an
>     IRQ-paired LLP snapshot.
>   - Allow index 0 to wrap. Reject running samples that would reclaim all
>     pending entries, so an unchanged start pointer cannot look like a
>     full lap.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 140 ++++++++++++++++++++++++++---
>  1 file changed, 126 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index b08bb31657c9..74613c95ae11 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -53,13 +53,6 @@ dw_edma_alloc_desc(struct dw_edma_chan *chan, size_t nburst)
>  {
>  	struct dw_edma_desc *desc;
>
> -	/*
> -	 * For now, a descriptor that does not fit would stall the channel
> -	 * forever: reject it up front.
> -	 */
> -	if (!chan->non_ll && nburst > chan->ll_max - 1)
> -		return NULL;
> -
>  	desc = kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);
>  	if (unlikely(!desc))
>  		return NULL;
> @@ -146,6 +139,76 @@ static bool dw_edma_ll_pending(struct dw_edma_chan *chan)
>  	return chan->ll_head != chan->ll_done;
>  }
>
> +static bool dw_edma_ll_stopped(struct dw_edma_chan *chan)
> +{
> +	return dw_edma_core_ch_status(chan) == DMA_COMPLETE &&
> +	       !dw_edma_core_ch_transfer_size(chan);
> +}
> +
> +/* Return the first entry we cannot reclaim yet. */
> +static int dw_edma_ll_boundary(struct dw_edma_chan *chan, int idx,
> +			       bool stopped)
> +{
> +	if (idx < 0 || (u32)idx > chan->ll_max)
> +		return -EINVAL;
> +
> +	/* After a stop, LLP points past the completed entries. */
> +	if (stopped)
> +		return idx == chan->ll_max ? 0 : idx;
> +
> +	/*
> +	 * DMA_LLP can advance before payload completion. Keep the boundary
> +	 * one entry behind it, wrapping at the start of the ring.
> +	 */
> +	return idx ? idx - 1 : chan->ll_max - 1;

use mod

	(idx + (chan->ll_max - 1) - 1) % chan->ll_max - 1;


> +}
> +
> +/* Must be called with vc.lock held. */
> +static void dw_edma_ll_consume(struct dw_edma_chan *chan, int idx,
> +			       bool stopped)
> +{
> +	struct virt_dma_desc *vd, *_vd;
> +	u32 done, used;

lockdep_assert_held()

> +
> +	idx = dw_edma_ll_boundary(chan, idx, stopped);
> +	if (idx < 0)
> +		return;
> +
> +	done = dw_edma_core_get_ll_dist(chan, chan->ll_done, idx);
> +	used = dw_edma_core_get_used_num(chan);
> +
> +	/*
> +	 * LLP may still point to the first pending entry. Subtracting one
> +	 * can wrap the index and falsely mark all pending entries complete.
> +	 * Reclaim them all only after the channel has stopped.
> +	 */

Do you means !done for this comments?

> +	if (!done || done > used || (!stopped && done == used))
> +		return;
> +
> +	chan->ll_done = idx;
> +
> +	/* Match reclaimed entries to descriptors in issue order. */
> +	list_for_each_entry_safe(vd, _vd, &chan->vc.desc_issued, node) {
> +		struct dw_edma_desc *desc = vd2dw_edma_desc(vd);
> +		u32 consumed = min_t(u32, done,
> +				     desc->start_burst - desc->done_burst);
> +
> +		if (!consumed)
> +			break;
> +
> +		desc->done_burst += consumed;
> +		done -= consumed;
> +		if (desc->done_burst != desc->nburst)
> +			break;
> +
> +		dw_hdma_set_callback_result(vd, DMA_TRANS_NOERROR);
> +		list_del(&vd->node);
> +		vchan_cookie_complete(vd);
> +	}
> +
> +	WARN_ON_ONCE(done);
> +}
> +
>  static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
>  {
>  	struct dw_edma_chan *chan = desc->chan;
> @@ -174,7 +237,6 @@ static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
>  		}
>  	}
>
> -	desc->done_burst = desc->start_burst;
>  	desc->start_burst = i;
>  }
>
> @@ -283,6 +345,45 @@ static void dw_edma_core_ch_maybe_doorbell(struct dw_edma_chan *chan)
>  	dw_edma_core_ch_doorbell(chan);
>  }
>
> +/*
> + * Must be called with vc.lock held.
> + *
> + * HDMA does not update LLP continuously. Only use it to track running
> + * transfers when handling an interrupt.
> + */
> +static void dw_edma_ll_advance(struct dw_edma_chan *chan, bool event)
> +{
> +	bool stopped = dw_edma_ll_stopped(chan);
> +
> +	if (stopped || event)
> +		dw_edma_ll_consume(chan, dw_edma_core_ll_cur_idx(chan),
> +				   stopped);
> +
> +	if (chan->request != EDMA_REQ_NONE) {
> +		/* Wait for the channel to stop before completing STOP or PAUSE. */
> +		if (!stopped)
> +			return;
> +
> +		if (chan->request == EDMA_REQ_STOP) {
> +			dw_edma_finish_termination(chan);
> +		} else if (chan->request == EDMA_REQ_PAUSE) {
> +			dw_edma_set_request(chan, EDMA_REQ_NONE);
> +			chan->status = EDMA_ST_PAUSE;
> +		}
> +		return;
> +	}
> +
> +	dw_edma_start_transfer(chan);
> +	if (!dw_edma_ll_pending(chan)) {
> +		chan->status = EDMA_ST_IDLE;
> +		return;
> +	}
> +
> +	chan->status = EDMA_ST_BUSY;
> +	if (stopped)
> +		dw_edma_core_ch_doorbell(chan);
> +}
> +
>  static void dw_edma_device_caps(struct dma_chan *dchan,
>  				struct dma_slave_caps *caps)
>  {
> @@ -749,7 +850,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
>  	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
>  }
>
> -/* Must be called with vc.lock held. */
> +/* Non-LL completion; vc.lock must be held. */
>  static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma_desc *desc;
> @@ -772,8 +873,6 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
>  			dw_hdma_set_callback_result(vd, DMA_TRANS_NOERROR);
>  			list_del(&vd->node);
>  			vchan_cookie_complete(vd);

why not use dw_edma_ll_consume(), let vchan_cookie_complete() at one
place only

Frank

> -			if (!chan->non_ll)
> -				chan->ll_done = chan->ll_head;
>  		}
>
>  		if (chan->request == EDMA_REQ_PAUSE) {
> @@ -796,7 +895,6 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
>  	default:
>  		break;
>  	}
> -	dw_edma_core_ch_maybe_doorbell(chan);
>  }
>
>  static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> @@ -808,6 +906,16 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  }
>
> +static void dw_edma_ll_interrupt(struct dw_edma_chan *chan)
> +{
> +	guard(spinlock_irqsave)(&chan->vc.lock);
> +
> +	if (chan->status == EDMA_ST_PAUSE)
> +		return;
> +
> +	dw_edma_ll_advance(chan, true);
> +}
> +
>  static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
>  {
>  	struct virt_dma_desc *vd;
> @@ -838,8 +946,12 @@ static void dw_edma_irq_work(struct work_struct *work)
>  	do {
>  		events = atomic_xchg(&chan->irq_pending, 0);
>
> -		if (events & DW_EDMA_DEFERRED_DONE)
> -			dw_edma_done_interrupt(chan);
> +		if (events & DW_EDMA_DEFERRED_DONE) {
> +			if (chan->non_ll)
> +				dw_edma_done_interrupt(chan);
> +			else
> +				dw_edma_ll_interrupt(chan);
> +		}
>  		if (events & DW_EDMA_DEFERRED_ABORT)
>  			dw_edma_abort_interrupt(chan);
>  	} while (atomic_read(&chan->irq_pending));
> --
> 2.54.0
>
