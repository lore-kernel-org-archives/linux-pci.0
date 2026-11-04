Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793813505;
	b=yMhaLgw82Al+mE7YIeRmUwp6AlcijJ5d+QM7cyZHP4X3X8FhfdBKUWHoYRcmpsrVdU1x
	 7zPpN445SuJP7j532B+ma3sRO2AGggigPK8Q4bFJr8CfdaatZBBUrpv4Am7A+3rBhqx2P
	 6dJI/CVjA3aJvZlytXHtK6k/mslQm2HHuLEXTlC/2h9ezEDrxiCzpuju6NYcGj4e05ANf
	 HxOS8WmX/5rz7QBAkCZfv+27egXb6WlVyepgfojqU6IjnEmP2LR6sQyzgJlWkft/4J2tm
	 9ViiexrSXo/sO+GPB6mV7yR/YCyiM8VKBMo0cShBgvS80uojKAM+swKB81MunKvADzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813505;
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
	bh=Kwj4yM/QsoRF5E37chdA2GT6Mem4thCgb20wGv3Xpok=;
	b=j+YlefnXFx5nQtL837wDKWuqj/tWzcBb3sxsqF3la12BwXHHdeYpWxxf3bZCcSRvBIlX
	 G1LvQ+fuiFfouYlbPJ4Gf7CR/NE95b6aKVMoPwaTyYH0O0gYjLBjIcn3dg5m+ssKA+pNt
	 gfypc0OZYMzVQt0Rt4zlUhHMPKdxqCJ9ZDfnVZUBqt2Rof22j4pNJ+8AcK6j00bDL103R
	 mbsv9lij9EeTQM9LJRAAHcbg4YllJfTkoLb7z+gAyLEGKsUVJzueXmVDacmgdkDikmDt1
	 Swq9CsPLiHu9BXs33EXXgSYxFk2Lnuiz2C6eMZA2DjJoZj/Zgt2+H0dfaED+lNaJX0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lXGGyd8o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.19
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B6606A33C;
	Wed,  4 Nov 2026 17:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA9B6606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lXGGyd8o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZ6RgBlbLGkrDNyU0bevWBzjblCiiXrFMTyEh1BSmd4rr34iWIm0AgvoG1ZgqdxHeOWfj6hjLRBkgO8Xs/OGvyuwQDOxNzl8PAWnIYJFa/+xZ4xFOry0viBgdfeAIttJ/Fc8nohvfmozCVNlmH8lxsQ1jNn53mT+JqE1pDtgvJmPvhI33+dJPfy85YbtPVVk+WKa+aZQRYGbp427QoS5oditW0rd4NdCYAiLXcLMNoBHMzeJS0VylC9xtD5frvUKYW7ypVeHv/LfofoXLpPO1VMW9MkvB/PR8/v/l0pyimT74bkUjMp8lqWxlwj93joIwto+TkdAtp/W0qnAMKPxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kwj4yM/QsoRF5E37chdA2GT6Mem4thCgb20wGv3Xpok=;
 b=omEf2vZ9zJoH5pJI3jBCNGPb3UapInSZPGI5Poa3dk5TOHdLqo7bEBDe9AAygwDG//7ksG7WCg3r5O+rbBTnU0hcI8oCAtc7hThp8jdaEUrSMh2EOwWcJnXiupPWKAEyuoGq7vRZcjhUEoJ+6MPRTPQ5svCd0Nvq48p9BcupiYuJuXwGLth6KGtVSRrPdJ0fEhlwu3sFKJ+vBk8fi6vYYr0PF/dbkeut0nLh8bs0PT83P3Pcu0oFSaSCHn9/p5rHdKVJLDpDz2W1wB+4TelFAxm6UNpCzvuPCNSaA1+Ca6Wv1wrwqHR2bk2ZXXr0iBiOIg1hDfjBGpack1E+PS1K0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kwj4yM/QsoRF5E37chdA2GT6Mem4thCgb20wGv3Xpok=;
 b=lXGGyd8ovtQyOnu1rFqUy7BA/aygeA8g56DINFgnvKHqel1RShXdDb84YNSztfIHGvF3wxSvgl31yaH+TljFAss0ngAwUfhzHeJUQsvlbcnlXLPt/RQxLQpy8mNcUBjoObim67/vUZe2OU8Zb+ptXZoJfDn1zYmiBfIzUiNya4zmEeXmiNCrGSSb5dndgUyqEnCoAA57P2X4FIhyogxVbAZT6vFUl828EtBgZu44cAzbnK67Ll053T6td9GWxUGr2QaLbPAEb8qO5MpvxgBDysbrlXKy3F4a3RRmAcCi9HMqTZ/mqCWH0Yd1wH2IQ4TnF1N4zlzBL3HeX9DNOtspxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MI9PR04MB043780.eurprd04.prod.outlook.com (2603:10a6:290:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 17:31:41 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 17:31:41 +0000
Date: Wed, 4 Nov 2026 11:31:33 -0600
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
Subject: Re: [PATCH v7 5/7] dmaengine: dw-edma: Use HDMA watermark interrupts
 as LL progress
Message-ID: <autr9WC4jdFD863h@SMW015318>
References: <20261104161227.1742005-1-den@valinux.co.jp>
 <20261104161227.1742005-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104161227.1742005-6-den@valinux.co.jp>
X-ClientProxiedBy: DS7PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::32) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MI9PR04MB043780:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a3d5d3-73e5-42c1-16fc-08df3a997d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|7416014|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006|4143699003|261102123227099003|261022105027099003|261021121427099003|261026140227099003|261026121527099003|261009223027099003|261026135527099003|261028144727099003|261021123027099003|261022075727099003|261022113327099003;
X-Microsoft-Antispam-Message-Info:
	sD/Hedg9qLhPZSV+iFikonOL2o3/NLqSnOCeE+I6wE1Kd6gMcnhvBXw9LYkv7WrSc17+yo2YcLJ+1m0q7/4LqwSuJLhk3mpQMMZDD48XZZNCM9XY1Zp+n4ysUav1ZbHrHPrr+DKNUStOnTJDwUrCh+YCTSMoxzmB7gKKv44mj4o980NgNpzHBn7B1V7J94C9cWxFQ87rSy/UM6iMtoG52i6NZm5fFIg/Tw+elTOXrpY4M4KqsV82UEFmAg+pkaBjalDoV8oX1+hJzR73s9npQBF3Xd7PRq03Gh2jJbqdDQSotwiRn4Fel1WheyKlOmOs4LqmiPO3LRiSNT6gXpYqugD5SY9DeOeDjXGv9m8WHUNeVygfvPSdTquGOr6qO7QiEInucsl5yTQY3cFWiqCxkKZYHSbAnM3viYSSy8U9wqUgZPeWPQMQyf7FYrYsooM8wb4WzCo1PpfdxxxB65t7GlGV6e/YSGh5EAZ3CUPWAsEG3VrPtYaiwJut1rD6Z0hcP4yDjoWvHc1cThM1TZGes/Pf/PeqfdTyhXDkbq+pruDeFxgX/1fKliiAA2iYQRLfgAQbir7HOeyIR5pwAWoG2JiJY6tekMS5q9Ji+aRzxdHfLgCq0U63smozUbVsGP+d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261022105027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261009223027099003)(261026135527099003)(261028144727099003)(261021123027099003)(261022075727099003)(261022113327099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q2JKDzOFjzGd8292a2Wh8thkEr/WQ6HM62El4oAwIEMEAJtauJL5Xahgp9yX?=
 =?us-ascii?Q?POvFr3aBybbBa4hmxj6NFUOLgSi3f27vD+1id/O3HOtu9va4lp1eV38z5uKK?=
 =?us-ascii?Q?suL7xN46cQWzi9o8i3WULV3cRy9+lKpHj7IFWX/AuJLOs1DiRLM8FznhqBOW?=
 =?us-ascii?Q?fzN/67R/IAiOT7dguKf06bMnIEnC2rFlzSm1DIck20DxbqgXBZDuI5VyCqvB?=
 =?us-ascii?Q?O/QNdHgSXFJSFMKD4twZU1PjeRghjFyNkMFltlm61lEHCM5JWJm0+dHUKOmG?=
 =?us-ascii?Q?+RfD/0O1R6l924vIDGhjmHqFGM7a/gQaJgf0XnFvS+hCpsVXRZtMFuU6H+gN?=
 =?us-ascii?Q?AGlyB1xeXTL4ToliP15K551mL6gQq0frDIXoy3F5eTVdzxx2CkRtmaGwxotO?=
 =?us-ascii?Q?bs/isHlxn05+ZOisa/vo+teqAaQ0V74/1P1kq+qljp0bYKqt8dxgLuxVqp/j?=
 =?us-ascii?Q?e6+UF9UF+0l4LZNkzXXWW3GF0qA/2WBY6L4cszvjl6cSYqa9lDMTcSXW0IKD?=
 =?us-ascii?Q?eQMFSXZLXQVRHJCeVXtrSDODHlt1KlH2juTn6bV5XdeAGL6WNibmp2zuSqvt?=
 =?us-ascii?Q?Q5zqckAnEaJYMwUOYca4yVO4SO/UWh5k9+yeq0NvB0N29fYutXCFjtXzwTgg?=
 =?us-ascii?Q?OI2rWRQDrIK3t39WsiV7TMOJuGLcuEmgIpp5hFhyij9iiGkaQ6EOZLT9/G8u?=
 =?us-ascii?Q?oiwbNrP6WPcbmBf+hx9Qpj/h1Ny49MX+nZUqZQo0T3n0l1wkOeGDltgg5L7c?=
 =?us-ascii?Q?mmG4mvMekusTzOVSKq8Vl1fajcbBi6Dr2WVXUJGJprbAp/TyOMb28OMbVy8I?=
 =?us-ascii?Q?LdOc3pS/MxRtXrez8aX74ODLjqFYCmBzTrUizmtt7b9LW0MfAukneMQrQJlM?=
 =?us-ascii?Q?u5FJXEKx/yjCWAfSKiALiDA9Pg2vay5GY/Qm2Cs63QGjgG+zX6TO45rf9I3I?=
 =?us-ascii?Q?HPZ9DR2GIBn5T41rTUUykMJbTTYA2p1K3WBrpiiaydcOvuB3ryHN78u/sUK3?=
 =?us-ascii?Q?wKSgeeG++h/c1JIHZ3bcyeMBKDR6cSaHFRXDgpAeHdPXsJepYLA0WgtFTek0?=
 =?us-ascii?Q?Bj7zd0sbKPC+fTK4MwOWoBqJV16UnFwyKRaIJoopVgk81DSEI0McthDTo48p?=
 =?us-ascii?Q?x7pUOD0uu58iXgPdyly/Ctk2Ns2XKfWgfRdbEATvM6004zwBVXDQ21HtoNR6?=
 =?us-ascii?Q?p/uowd5E4jm0T30AgbCgQEF13haooL2ndWDFBDq1XG6WF0XIrcZZDDmaalc4?=
 =?us-ascii?Q?0iUyzMLaXBlsvAMZr3/WxMQ7zB7mxfFOn2USILq9c++Ugzh5nVQbXqgYUVWI?=
 =?us-ascii?Q?DFu+0cJswSVENplmdvPTKUt1yMdFrPdJUMOcC207b52LdOtJFxM+/P9glaV6?=
 =?us-ascii?Q?/q7ntR2/SGwtAU3B0uP/NtSuy6ANsHvTA0+IItNSPgvZtQpcskYn7zMWoT4t?=
 =?us-ascii?Q?7hiqFUQ7Y7eAluLQca+OYhRBatK3BS3BgVd5zxraYbh4AvnHY2+1XRh13oQH?=
 =?us-ascii?Q?k6YMKRGCqyF52K5lD7SJQkmXc3t0RYHK/nXZu3WN4Jf8oWj+Z6qhDxLjvU7g?=
 =?us-ascii?Q?8FmEyPsB/DR5EWtE7ZYAECNkIGRaA6pmxMx5vhEkljulWJTA/XCSJGm0Swas?=
 =?us-ascii?Q?34/gt3UxwD2qi0tP+SSAMpUA0sF4wIbQnjX2LkbK4nbPdOdvJOoX27c1esp1?=
 =?us-ascii?Q?taA9LVzvtknYFZK3Gf60hrgkYOUUjnzlYV6IGXxqu+stPaXULWnun+OoS3iz?=
 =?us-ascii?Q?l/9K0XnQbF498XmJdcVUTdklBlbFbd8wI+INOD4s+j85vvbbv6Qh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a3d5d3-73e5-42c1-16fc-08df3a997d2b
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:31:41.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iB06nKMcdhpaDr43NpX+kyu7cy4Ukcevt1+n6B7KVBRTnG7ID8KNssFDbL+FM9TbfDS40Z0rhcmQbsGWTIR1kHV7Fh9QNgXjeTGwjX3NhbgBVp6PEpp4VuYGJOn0HbL/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB043780

On Thu, Nov 05, 2026 at 01:12:25AM +0900, Koichiro Den wrote:
> While HDMA is running, DMA_LLP is updated only at watermark events.
> Enable watermark interrupts to track progress without waiting for the
> channel to stop.
>
> Set the watermark bits on entries that request an interrupt, configure
> local or remote delivery, and pass events to the LL progress handler.
> Unmask local watermark interrupts only for LL channels in local IRQ mode.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes from v6:
>   - Keep watermark interrupts masked for non-LL channels (Sashiko).
>   - Link to v6: https://lore.kernel.org/r/20261030150742.2586776-4-den@valinux.co.jp/
>
> Note: Since v6, IRQ placement has been limited to descriptor ends and
>       the last free entry to keep the series small. Further tuning can
>       be done in follow-up patches. I should've mentioned this in v6
>       when dropping v5 patch 14:
>       https://lore.kernel.org/r/20260812155721.2807506-15-den@valinux.co.jp/
>
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 62 ++++++++++++++++++++++-----
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
>  2 files changed, 52 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index aa430219d0af..0cccd0003a1b 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -58,7 +58,8 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
>  {
>  	val &= ~(HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN |
>  		 HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_REMOTE_STOP_INT_EN |
> -		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_STOP_INT_MASK);
> +		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_WATERMARK_INT_MASK |
> +		 HDMA_V0_STOP_INT_MASK);
>
>  	/*
>  	 * HDMA_INT_STATUS.STOP and .ABORT are latched only when LSIE and
> @@ -68,6 +69,9 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
>  	 */
>  	val |= HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
>
> +	if (chan->non_ll || chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
> +		val |= HDMA_V0_WATERMARK_INT_MASK;
> +
>  	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
>  		val |= HDMA_V0_REMOTE_ABORT_INT_EN |
>  		       HDMA_V0_REMOTE_STOP_INT_EN |
> @@ -81,10 +85,12 @@ static void dw_hdma_v0_core_ch_off(struct dw_edma *dw, enum dw_edma_dir dir,
>  				   u16 id)
>  {
>  	SET_CH_32(dw, dir, id, int_setup,
> -		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		  HDMA_V0_STOP_INT_MASK | HDMA_V0_WATERMARK_INT_MASK |
> +		  HDMA_V0_ABORT_INT_MASK);
>  	SET_CH_32(dw, dir, id, ch_en, 0);
>  	SET_CH_32(dw, dir, id, int_clear,
> -		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		  HDMA_V0_STOP_INT_MASK | HDMA_V0_WATERMARK_INT_MASK |
> +		  HDMA_V0_ABORT_INT_MASK);
>  }
>
>  static void dw_hdma_v0_core_off(struct dw_edma *dw)
> @@ -95,18 +101,26 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  	dir = EDMA_DIR_WRITE;
>  	for (id = 0; id < dw->wr_ch_cnt; id++) {
>  		SET_CH_32(dw, dir, id, int_setup,
> -			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +			  HDMA_V0_STOP_INT_MASK |
> +			  HDMA_V0_WATERMARK_INT_MASK |
> +			  HDMA_V0_ABORT_INT_MASK);
>  		SET_CH_32(dw, dir, id, int_clear,
> -			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +			  HDMA_V0_STOP_INT_MASK |
> +			  HDMA_V0_WATERMARK_INT_MASK |
> +			  HDMA_V0_ABORT_INT_MASK);
>  		SET_CH_32(dw, dir, id, ch_en, 0);
>  	}
>
>  	dir = EDMA_DIR_READ;
>  	for (id = 0; id < dw->rd_ch_cnt; id++) {
>  		SET_CH_32(dw, dir, id, int_setup,
> -			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +			  HDMA_V0_STOP_INT_MASK |
> +			  HDMA_V0_WATERMARK_INT_MASK |
> +			  HDMA_V0_ABORT_INT_MASK);
>  		SET_CH_32(dw, dir, id, int_clear,
> -			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +			  HDMA_V0_STOP_INT_MASK |
> +			  HDMA_V0_WATERMARK_INT_MASK |
> +			  HDMA_V0_ABORT_INT_MASK);
>  		SET_CH_32(dw, dir, id, ch_en, 0);
>  	}
>  }
> @@ -168,6 +182,14 @@ static void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan)
>  	SET_CH_32(dw, chan->dir, chan->id, int_clear, HDMA_V0_STOP_INT_MASK);
>  }
>
> +static void dw_hdma_v0_core_clear_watermark_int(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma *dw = chan->dw;
> +
> +	SET_CH_32(dw, chan->dir, chan->id, int_clear,
> +		  HDMA_V0_WATERMARK_INT_MASK);
> +}
> +
>  static void dw_hdma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
> @@ -208,17 +230,23 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  			continue;
>
>  		val = dw_hdma_v0_core_status_int(chan);
> -		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val)) {
> +
> +		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val))
>  			dw_hdma_v0_core_clear_done_int(chan);
> -			handler(chan, DW_EDMA_IRQ_STOP);
> +		if (FIELD_GET(HDMA_V0_WATERMARK_INT_MASK, val))
> +			dw_hdma_v0_core_clear_watermark_int(chan);
>
> +		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val)) {
> +			handler(chan, DW_EDMA_IRQ_STOP);
> +			ret = IRQ_HANDLED;
> +		} else if (FIELD_GET(HDMA_V0_WATERMARK_INT_MASK, val)) {
> +			handler(chan, DW_EDMA_IRQ_PROGRESS);
>  			ret = IRQ_HANDLED;
>  		}
>
>  		if (FIELD_GET(HDMA_V0_ABORT_INT_MASK, val)) {
>  			dw_hdma_v0_core_clear_abort_int(chan);
>  			handler(chan, DW_EDMA_IRQ_ABORT);
> -
>  			ret = IRQ_HANDLED;
>  		}
>  	}
> @@ -275,7 +303,7 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
>
>  	/* Enable engine */
>  	SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
> -	/* Interrupt unmask - stop, abort */
> +	/* Interrupt unmask - stop, watermark, abort */
>  	tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
>  	tmp = dw_hdma_v0_core_int_setup(chan, tmp);
>  	SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
> @@ -336,6 +364,11 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  	/* MSI done addr - low, high */
>  	SET_CH_32(dw, chan->dir, chan->id, msi_stop.lsb, chan->msi.address_lo);
>  	SET_CH_32(dw, chan->dir, chan->id, msi_stop.msb, chan->msi.address_hi);
> +	/* MSI watermark addr - low, high */
> +	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.lsb,
> +		  chan->msi.address_lo);
> +	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.msb,
> +		  chan->msi.address_hi);
>  	/* MSI abort addr - low, high */
>  	SET_CH_32(dw, chan->dir, chan->id, msi_abort.lsb, chan->msi.address_lo);
>  	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
> @@ -355,6 +388,13 @@ dw_hdma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
>  	if (cb)
>  		control |= DW_HDMA_V0_CB;
>
> +	if (irq) {
> +		control |= DW_HDMA_V0_LWIE;
> +
> +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
> +			control |= DW_HDMA_V0_RWIE;
> +	}
> +
>  	dw_hdma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
>  				 burst->dar);
>  }
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index b88226cdd791..e240ffb3dea7 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -18,6 +18,7 @@
>  #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
>  #define HDMA_V0_REMOTE_STOP_INT_EN		BIT(3)
>  #define HDMA_V0_ABORT_INT_MASK			BIT(2)
> +#define HDMA_V0_WATERMARK_INT_MASK		BIT(1)
>  #define HDMA_V0_STOP_INT_MASK			BIT(0)
>  #define HDMA_V0_LINKLIST_EN			BIT(0)
>  #define HDMA_V0_CONSUMER_CYCLE_STAT		BIT(1)
> --
> 2.54.0
>
