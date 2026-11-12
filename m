Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794505718;
	b=fl1UOt17mvu9VHct3BUZN60n/gyY6Ko/t5erAWAhMtIwOxQIlfAU+vnslS8DitJQRxmF
	 z60wMSTjqR/OO1xUjEKOQy+e9PeA28+rtgtil+EpeOeoIAelRysmIxqCB6YjRcegqPYFR
	 +qdClof2gEpzrVmcpJEFi48+fLcP7LaNAnaoitCS8zK+5aWt9lL0pFfhtfzx3ZzxW5o3h
	 aUHlwjqkleQFPASJmFX3U56RCK+FNTYKLVx9JOZqIfgszr0WjmIuW7BA83mzqUcw7/WHv
	 y4rgtjjJnxzQNaygZ1ZZEb5MV9bV3I4hWCS/iJSj2T2tO1z4OvNXKDRdGPEwudM355A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505718;
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
	bh=CW9g/gq1Y8dF+y9flplp70OtHiT4gc861quhH+ispH4=;
	b=5UFHK0ynPN0bHj/wT6k+VbrXMJiNpQ0C1614sUlTHZ7PWgWOHCqz9eig0ifSFtT3rgrQ
	 4NgPpmxxZSISbg9wuq2Xv1OUoCc7/JUW1HiRrXzVNif5bu0/0ZwFFS7MIrFN0c8y5C+fE
	 EE4JX4aHgEVERsGRw8N2c89AM/LL6L83xVlzLgkMvBDrCmp1gM7TXYP1grM0o6eDk4+F7
	 Wg/X3uF+bYhm+jhT0BjYUIfm58FoUH+PNIrQxLdFxvJaI5/IS8E1sF0+c7WzHxcajUowT
	 Uv2kdug9+eNiFZ2FXAJIh+B/ogxIiHhyvhvTagorVsB859a2EW59bEqNjb2mhjLBmnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nMzh+Fmv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.21
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B42606A31C;
	Thu, 12 Nov 2026 17:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4B42606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nMzh+Fmv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+HVxpC/rKx0CIOAG4jEd0gaWojoKBEfeEcHHymiRWmoFGWflsuwdQN5qofWfch2v43Y/e+xtNbdAbyeCucG+6DDXZvlWOe591xqXk0bkrY/AZVEGzB6FG54TOivOIEKt7ASXIQbTEzVOfvEtXhMMNJeUPmokUi3tSFOZ9QVMb8+LHU+1HTt8I7oy2keZJvrUwexT6PsJmaf342RLnb9kiRncNKheD1ccp+farr2HX03u6FKM/W3tuGMrenUuja6/Vg3Tmlf9y6GM0fNQ0st+CYPFGNhQY9lf9IdaaKsc8x67SNwQqJLnJBZQJ+zh8IhYJLXwjKp3UzbI/k6JFcaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CW9g/gq1Y8dF+y9flplp70OtHiT4gc861quhH+ispH4=;
 b=B+ehZoD8EccH4QwMwmeGuL+0nk4DRsE5I4LhvlEfmD06HEZSSN0GXRLVVm3SkIh1IMFD2FK+nSxmYPJ23JUmEuBW2ZBejMGdFy2Vzue7Yep7V4iaVVB13rp66egN1sKZvz6oTky6Y+Mq3QNpMuw4AEjdOs79MiT6iePXQVtCVoAYu6Dd8elqZv3mWEvEC9bGgT9zEaGs5/WGhZhgarxx+VFI4k048XtV+bL8sgcJPvpCE/My/JoEehhdd7UfTKXzYZMAtFg0J2x/PS8/IAVrN0JITaBy7HUNP79uodQrMCuvcC6H6d1ydiBL8+PKWclPGh6XGXAdP0kQS0r7RVR1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CW9g/gq1Y8dF+y9flplp70OtHiT4gc861quhH+ispH4=;
 b=nMzh+Fmvjwti4//WN6QXVuuP2USFvbTSC7KgQnyRZroFh6hHbmjq+z8hTIHTIGIpuNyMqZCSFMibnzI+OPH8Drn7NPpbOX4Mz6P0611NUBd81LX635quGvD4jumG/Hsn8IyZkvvBN3lugrbOuTGrUOIbSs28gSJJ95tIoG32pa/t+WBsiybOr/zJSS3npatIL3+WEvOFE4tBRxxVuml0chK3Y5b4oZrGctQKX5Vl9LmSflTpbja8wXQLB3ui+yMqA6V+9WbcRptNJ7csekk783CDUCLxIJIz6/s/2Ey62VEAeRxZB4Vv7ujf7R9GYSGZZi72vshOSbUJcN8E7DDtHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MI7PR04MB897750.eurprd04.prod.outlook.com (2603:10a6:290:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 17:48:35 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 17:48:35 +0000
Date: Thu, 12 Nov 2026 12:47:43 -0500
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
Subject: Re: [PATCH v8 2/7] dmaengine: dw-edma: Avoid resetting an LL on
 stale stopped status
Message-ID: <avX7vy-nHIY_a3cg@lizhi-Precision-Tower-5810>
References: <20261107133027.364237-1-den@valinux.co.jp>
 <20261107133027.364237-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107133027.364237-3-den@valinux.co.jp>
X-ClientProxiedBy: OS7P286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26c::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MI7PR04MB897750:EE_
X-MS-Office365-Filtering-Correlation-Id: 06315679-1611-40ae-e638-08df40e52c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	dz3yD6HRtjZbfyV/LZ+tJ8/zMiupQWbP96b45BO/Udlu3AlnJVe8uWyJrmSEJ/8XsNGgdzXT37rI/QBmBXRcm7T62lU+watLuI17A2ajIoaL96ZK2QSVpRqhB0lcp3i/S5JSfmWZMVRAgmFAEf+bvxXioczLwSx0VBTko9pww6VOfewGu1eaaOuJ3aTQS/kt+Z84w6YB246QNpN/kXfe9ZN5cJ0z6ogoQO/EhQNGzYGT06fLxXHHsQ1JafVP4ez0NwHnzGppOku8vt3oOZHNAYG7uCz4zVrGEzbqRHt6GW5w5vQvih42VgKWJtoIHiKr+HvORYofxaWiBIFjdcNdh393NN2Gj49NdCdnnhqqq4TrTmm9QRFW2xAhNEaJ57KOPNc0fIYatU77jNH7t/SfbT7dxqflJ+x8qhtseskFRDH8vOgYJ0+gWlUqBPzM7LDDMgYc2saBflggsifF5X2A7E1oHA6ft8mn+L2vfx/aTwkMaejMk2zk8mhlU3wHAIVxqJ1Pv6GrcRrniNVa7ddgiKYxLyvEjHE2tAzD0g9Kc5FuXLHoWTg31YH3yaopy8NDi1E5Sf1QShDtzCkYHeIY10qmMeneJTH4lQb5WAw5Dd7A5/do2p05qnIWhITc3odFLqtuYy3sJQwLrnkZKrg8LpAfcfhoh7dtEZ8P2xxjidQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yyfr1xNFqqjsgrNzFGV+37Nvv25JCp1M00IZgLteQColQr1AHexeIZWF+tGJ?=
 =?us-ascii?Q?Q2Hskmi3OBIFP3C4NGrjYCSMh9FKHlQ/pQ5+yQgej7kpmA1fB41SJEmTMuII?=
 =?us-ascii?Q?BNHvz6TDVFkKYfQvI+SP4ADc8MiffTCPJ1/yst0BEKFmP9q6/6Faj40HVhlp?=
 =?us-ascii?Q?RccdN0Kk/DQLOGvh+dXgb6WKVwRbxs/XH/8cOFVMVCPpGpmGn29ifEtbPqLD?=
 =?us-ascii?Q?bMMhlClsqdj8/iCTTwjXAXWgKAhXUk3WXGhGTHr/6VbgiiPeEtJNe/QAPikZ?=
 =?us-ascii?Q?Hj+IznG+UZgPv0/TQSSAPlVjR7Z9s4quIWHzIedU9auBdOcv4SpQww0bsk6Z?=
 =?us-ascii?Q?pXuul+vsLjgMDDuwXzjEhwwIH9q6phS6UNoe8eEiOX5W+mC3FEX9dUn3Xb4M?=
 =?us-ascii?Q?91O9n388WKLbM4fsIaB+G8mNN3kUjYxpgR814IcIL9geDU+Y9lhNABAD+AqH?=
 =?us-ascii?Q?qFK8EV/jqfrYBbUYtVxljtmaxmf/HDbwnE/sR5aPjJEZn58Q7iHq/90a8CaE?=
 =?us-ascii?Q?kJDeJJmVnOJyW5WLUdY3eQD1AjA61+HKzpDDjMBZ7Ysh9TLyIgK1v6jrpWtM?=
 =?us-ascii?Q?twxmgqrVQiytS4OshD+WHFfoI4sQJLLRxzWyQr2GgmR/6hFISFIMierbsiBQ?=
 =?us-ascii?Q?6TbT7LJ+llpxOfuI2pQvsflRCKC1OvpwLXHeeng/cwV8XdNoIyG4soEp1ghT?=
 =?us-ascii?Q?m6A4kUF0KSZxIdanDikUKqjTTs+zbm/PYXyTNjDkLe9rZksC4atOdwtEyUEH?=
 =?us-ascii?Q?PEpUsPz5AovUWKJOycMetuEqUvtRr9s93VbmxLuJqU8lAgQYh5UywtXV/Bz3?=
 =?us-ascii?Q?1jEEwzPScuZknFhN1gO+BA25epK/fd14cDc8RTeWQ1v+nmPTBYGUFKvOtanf?=
 =?us-ascii?Q?cUQHo5/cpF80djnTH1+TQ3vKObxZWIqQl6LjEoAe5KP7POyUUXSzf9F1b//3?=
 =?us-ascii?Q?1JTc/FgU80dz95/ZjvuFg18VPXnx1maku+3+FBxrQpQRIZtW9aT5sB8i8V3V?=
 =?us-ascii?Q?jHkAP4h/a4jABqwdrCe9CmZEWn6Un93iHAw55bRyJ4DX+kukH8FqSs1T9mZZ?=
 =?us-ascii?Q?xitTDJJitM9jjNpgQ4bPvemD87+QIe+UWFmhbAyZGj6l7GbefOEg8q1+db8t?=
 =?us-ascii?Q?qtMilHcmhr4fKxN42fy7W+s4qDDgmQQpKgM8RqE4Yqr6zWCF9p+y+7avghUz?=
 =?us-ascii?Q?3N7Q8gLZ40JAzfhtnuZGX7WaR9WZNa4nC4z9iHUP+XYss5uN7ptz2Ch6/dWm?=
 =?us-ascii?Q?Xm/q52mp6fVhoZWzJre9D/KMcVu2FjFT77yd7sPcC2Ch8CUXiOsU9v77kPPW?=
 =?us-ascii?Q?d0ApxR2TNUhS72S++DIaQPFyBZB5vM2QaMJ5fhlDtIpH0o7Z0mJY/noePjSM?=
 =?us-ascii?Q?7xZKZ5vnq2K6nEP7OIBpje/83Gwo0J5FtO6+UupvnowEoAc06oWmRwH5oosi?=
 =?us-ascii?Q?e9y/Hq4/Xx8/xK/IKWn15L7wjx4G5dU6LCHHgLdnxXSyRcqQI287u4lSXxgw?=
 =?us-ascii?Q?z5ik7JBaQUyGNBlr6gy/5fC9V1VIcNMJqDY0VxpCuap7uCIDTCyFFhNN3ykH?=
 =?us-ascii?Q?LrBIEqHD5Ns51ZiPRml5laiMuQfTpph+wzkGUogfPkC+WgYyInSSTTzEK4b/?=
 =?us-ascii?Q?Zx43ZnWbPX8jCkSdOiec1iGgqvH1ZvOsB766jRMPZREcoU3DMQlaz64kCm6H?=
 =?us-ascii?Q?KM3EmyWbE0JfjLd9SOX+Sm4jBVLT3gd30cWvpZklugHkf/V0JKS4lMIyY322?=
 =?us-ascii?Q?UePqqRhba2L1n55O2rMJN5pag3Yby66FjeeO3Dp0g7jLVO5BspuW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06315679-1611-40ae-e638-08df40e52c8b
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:48:34.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAyjJgPXRozOSmcjTJdRDNCaE9sH+G1rEwmmnpiaTsrLPx+4ZixCxOFpEnQGT6XrWDXLZavj1Xc9BK23W31TDuCuIMyBEp4pJuLxO6xvvBt0XK9W2hhrE5VxajYFlfVu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR04MB897750

On Sat, Nov 07, 2026 at 10:30:22PM +0900, Koichiro Den wrote:
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

> Changes from v7:
>   - Resample LLP and stop status if stopped to catch progress made after
>     the first LLP read (follow-up to Sashiko's review).
>
> @Frank: Dropped your R-b due to the change; would appreciate another
> look.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 45 ++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index b08bb31657c9..0c8b9545a5ba 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -146,6 +146,44 @@ static bool dw_edma_ll_pending(struct dw_edma_chan *chan)
>  	return chan->ll_head != chan->ll_done;
>  }
>
> +static bool dw_edma_ll_stopped(struct dw_edma_chan *chan)
> +{
> +	return dw_edma_core_ch_status(chan) == DMA_COMPLETE &&
> +	       !dw_edma_core_ch_transfer_size(chan);
> +}
> +
> +static int dw_edma_ll_read_idx(struct dw_edma_chan *chan, bool *stopped)
> +{
> +	int idx;
> +
> +	/* Sample LLP first in case the engine starts between the reads. */
> +	idx = dw_edma_core_ll_cur_idx(chan);
> +	*stopped = dw_edma_ll_stopped(chan);
> +	if (*stopped) {
> +		/*
> +		 * Re-read once to catch the final LLP if the channel remains
> +		 * stopped. If it restarts, later interrupts will report
> +		 * further progress.
> +		 */
> +		idx = dw_edma_core_ll_cur_idx(chan);
> +		*stopped = dw_edma_ll_stopped(chan);
> +	}
> +
> +	return idx;
> +}
> +
> +static bool dw_edma_ll_drained(struct dw_edma_chan *chan)
> +{
> +	bool stopped;
> +	int idx;
> +
> +	idx = dw_edma_ll_read_idx(chan, &stopped);
> +	if (idx == chan->ll_max)
> +		idx = 0;
> +
> +	return stopped && idx >= 0 && (u32)idx == chan->ll_head;
> +}
> +
>  static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
>  {
>  	struct dw_edma_chan *chan = desc->chan;
> @@ -455,7 +493,9 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
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
> @@ -790,7 +830,8 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
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
