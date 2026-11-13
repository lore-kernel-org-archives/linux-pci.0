Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589957;
	b=2YJocJTrHsgg7K+9qzPRHMxmDlMbeKzpfIiKyCCyW2fSFHyRRicNn7Cm70/KW8IrffGu
	 IlvXeofnu4ckfNyrHJDxgYK7lvykfsQtI9GB690DElthX74FV0qhQf/PPFNXA7q7blINY
	 68boZSRl0oW9wh2zwpwmzuZxjPMSk2YXVzgEL2q/SZAOVVihDrCxA5dFpXABwdZfJ8tkE
	 Lm0r1KVu/fjqXXu23/dm8C0H2Wt8nLz9EOtjZG+cZBiX3TKQWrD+35JwNP1CgJ1JXi7cX
	 tEktJuTRHEU92lrYoWePzSbCPyuQhuKf10Ut/Uco2fh8huhEwzhfxEuUa0IGZpje11g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589957;
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
	bh=4w+8hXL5G+Tl1wYKCK2wiELmR0OZ7AU1z+xMbyxDt/o=;
	b=P+H7l4KJE4FJGUaxO/icH1MIbpSLUYeNKVxODqdPyILN/k/duvqHHwdMD31sJNQTumFf
	 m34N78QqIyTL5ixERrRFhVMQdJRXI2NQE69wRREP4z3p9eW0ClbtrBt5BaKDthIXBmgee
	 muYkKpChsg6e4Su3pzyEHHvHH1zr5b5JvSkU/dqcpVGT6XoPg/d752w4XsiUaIooJoK4y
	 s21HFQ4Je5aJjFfvas7njpg+qu3j2f1SKpWiX2+y069xn1nksVSAw4Kh5Ey2bK3M8tzyP
	 3jQXKT/MPgRrZaHN5eYMgLcv3kvuvrMx5HCqPQ6zYpMejfsJZH0/NSzi38r7U/zyJBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aVPrSbWH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.44
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB1606A32D;
	Fri, 13 Nov 2026 17:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1BB1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aVPrSbWH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFRFs3ugRjYP6lKI0xpWRfw+5tQaRomuOoNXXKDjaEZB/BQzJ2TovqXL9jb0XTARvWlcAqk5jPwd8dhOiPQ1VAqKiUmq6wn4UDmJTyZFxNOBSslmKZPTOAAB899wkTYZu4avNmYlgouDmiW3ptAZs+3k8oaY5xO3aMBqpVVxbfSoWJj2Bytf1PzwiWJ6j+ZIIzuyWtzMIy8hMmJK8O6mJbyMc31kQArhLgnZ7PNjfAUAXQ5EJM2EPVB74bnmx3a3O7n5W/Txsc1AvDXTCo5LAuLcxBx87P+e7d4biy1vzEWGi/5tMxrwReNWO4fUYW+HFW1Izy53qk1Rkm3Bzylz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w+8hXL5G+Tl1wYKCK2wiELmR0OZ7AU1z+xMbyxDt/o=;
 b=eiSba6YmYqgLgAjgJ7diSMJsk7yfXCExP/jHQ7p4BUIpULvXcxRQwIUJSBN2G19Fij27cAPgIGh1v/Pla8fU9iNrQJKhVW82jM04IdqUibnMCJJLxebEBK7KJt48QxIEvwtIClmzr+ljYhaUuzVHk5WbSmRg05PGtkAjbdbVvLRhF5EiSPdRate4B+F5uGoaTeWsN75eKR5tAHFHsgg8fZFbFqZFyU0jdaOyOeH6y9DU+0IllSkgd+dUQwvQdUYNqB37eRS7KWGE72TUn6YGq57MPvGReB2reRnPfq6Oe7ePoa1rLixrcDMd/PFPAb2P4IFXxUzGLyRID2zi7C/ulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w+8hXL5G+Tl1wYKCK2wiELmR0OZ7AU1z+xMbyxDt/o=;
 b=aVPrSbWHXb6IvBq7pXxDns8SKOK9FLn595q2QKpfvGaDF3ZzGZOzvRnnIrIRK4n1vLnkBgAaUInAlV6q1trSF1FGmA4RCWK3LxU1St2uoPKoXKDZvHEFP6Gx1vzqRyzQRSBz5xSf3IYQi0t39wArH1REQ8tiaUSu6HKswcu2OVdDDbyj0vZTcv917Bae895Thc/XDk4ZiWDukVf7X9/hFNOAjGFGMq4bxCUCVQWAwNSKHgLBZcZigRQU5w+vLh6eUwzoNjM1V0OHegtYgvHACHB9l46YZt/rZevKGhUY97R/2AL3v4UfMyjyLfQaQ3FagHkrS8v17uFZzTCR/Zj6qg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA4PR04MB7599.eurprd04.prod.outlook.com (2603:10a6:102:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:12:20 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:12:20 +0000
Date: Fri, 13 Nov 2026 12:12:13 -0500
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
Subject: Re: [PATCH v4 18/25] dmaengine: sdxi: Add context submission helper
Message-ID: <avdE7dckg2azmum3@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-18-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-18-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS1PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:8:23e::15) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA4PR04MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f29b0da-00a5-4297-b3b6-08df41a94713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|3023799007|56012099006|11063799006|4143699003|261102123227099003|261026140227099003|261021135927099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	hcnJqo4UtDvWITDngmW/9M6OSVdO/Vye3iIOBHoXMCJScBJsd9e36PhsvmLgSgobDYZt0ccyyFF35I4px/5+DyQIQB8iD5ULgoj+i4gbX+J/WA22r2tAW9xoRvET7UZZI1aoE5DGIVnWFhykeNDTgQ+oiNZFK4HpkuuVBaao1DpAcmuv72wnHhIfeLBvaRFdTi858WCX6yqoXKVZLdJO3V5OILrPXhzffFc30RaWCAzMdrtBO3QdvdZoWkz0EKnN6lJPriVLYcqBiRdpZvikQ2NJwwz5WRbv63lnPgrgz1Lkf6k7S536U0VdoJ8nCzL12MfyMKCnxsf95z0tpzg5pUTpipGV+9DW3SKkrBPJLdcnyAJE+dEB2xb1g3mizayZ/ENDEeq8ZZV/K4wWnhNpNaCyV9wtCohwJvZNoalDAxtyibcf6Ta9VELXT27LUVcfkQWcd3qqp/PCaxSC1nXnIWeKxAncCn3szVF9qhwEqY7eg4t81rZUAaqmUswIPKL8j77DzL4j9Ssd9J3gkr4YoFfwr3CZeJvaC39dcV1xB4OS6UTBM/tmhGwGwr1zn0t+rpMevNbpH5nOmi8AG5qDMzh6MrIQJSlxOHvO+ohS2LRDwk/730vxgHnfvQs/h3FL0yeYMgoDLlJgcHIIDZHEPh6YHE56KtdOspl9eL09sp0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(11063799006)(4143699003)(261102123227099003)(261026140227099003)(261021135927099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q2QCu20Bg4cBuNFiXmB0y8x3lqV21dZcTpkKZhaRWYopVSMNCCeu8x0LBL6s?=
 =?us-ascii?Q?566BYfkE9Ae3jCHumbGc05uDkdhakkKRD+3WR2TixNI6iOhy+wTOVlBNtZFw?=
 =?us-ascii?Q?jKX1FgkctXmOcroOu+amXmM1FjSDT0oQvB8Cq8fGWHDonAA0PuzFU/R0HGCk?=
 =?us-ascii?Q?CvhxRyXohyy9vkLMp3VQJMSCjtBufyv6PwJNPSUrsZL0cABpJLQxEII7o+rt?=
 =?us-ascii?Q?/bEeRgEXQxPmt9Gf9bAcytwn+omkoPxyQAlR0KenxmxWNjnHwlWFjc0ny1SB?=
 =?us-ascii?Q?gsMvzyew6m/r+uh9krCU4V1c3W4fuRDFoKu6W8WYGTwdKaX7C5aXYay0v6aw?=
 =?us-ascii?Q?1s/XdrcHqeCD6AlsiAFvR7Y71zusZfWYPixuBnWCm0iX+ftpjIyrUZgaifSW?=
 =?us-ascii?Q?lcSuldwfIfeu1DepraJ4j+MDM5KRL4KUgblqzmnNBpUsO7Gqlm1n/v4T4vDL?=
 =?us-ascii?Q?7jVcAI0g/Jn03oQm/KAHNwPhWFk4OOxJMn9Bx0s8uW5/W22iRojcmCbh6eU9?=
 =?us-ascii?Q?n5gYSLLoozwCiF0MqD1tVX1lRo9Sw73SfVGYky6zXmioUFibWaeCnmaCi6QF?=
 =?us-ascii?Q?OuC3NRnrQ1qXl1tk5PF4WXWJ3GCCbWokZ1jo7vyh7dxtLnEJ5URZE8H/HyrD?=
 =?us-ascii?Q?V2rZB3O+F/GcaEN7dvK5bLtOSkGsrIvq8jSCzmThMWtKeNHeJhJdTzuq1wW5?=
 =?us-ascii?Q?11/F3/aHDGQBwMYEK4zrwsGVNsxI8KNj6e0n4DVeyoPE8ZeNwzUj9II2stvE?=
 =?us-ascii?Q?qhudQWMq+kV5+82P72UaOZae8Tk2iFOMXiagazf/hNWDZ/7ISXBGp3tQ7zD6?=
 =?us-ascii?Q?oXpGQWKckrC+ZhZjAXc5nI9n7FN/4zXmygZravrIUeDZhCnUTfnfLKGVQQpz?=
 =?us-ascii?Q?PH9KeiHjKU3xYYPx9z9iIidwKyaIK3TJR5A7QtPps2LMYmCcZBkLxFcsrLwv?=
 =?us-ascii?Q?PWLkHKz8QtXGY1bbqy8BYyMbUcKSvxDZV7YEfTv+Jky48X09Fm9VSGE9f1W2?=
 =?us-ascii?Q?SoyDm74Zb7CB8WqHxdQ4v6UBXl2/j2gdeA4fzMjaakZZuNzRmN2Mf86Y5ISX?=
 =?us-ascii?Q?2yjF23OfsaoVoTkxMU6QgjGaNycDxWzMm1RW1EvbLb1WzGGIzYXtS5bPt5Vg?=
 =?us-ascii?Q?x54FX+GRYO5b4nzf9EsrGOVtG0BuUik8xYXaXzKXJi72x6zqPhMNuYMIcKcu?=
 =?us-ascii?Q?S36t3n50yTjPTJgBytf7MEd+3XZz6/NO+FZ7NAQN/zPcpIIBE434RG4wqy/t?=
 =?us-ascii?Q?s5+lVA+owXfUpLp8VM/RFxyO8NPyINwxvjkLForPeFiAnIXLEj+yS1m3ZaIL?=
 =?us-ascii?Q?4jdL0YqUUrV3wvycJi1TGUVG7Xelgbv1Sa9vp0Ki62fJoqJHZ8+3up6TsliR?=
 =?us-ascii?Q?kABA6eQDItMsNFfGrD+HOkk5EjJAM1BtdckOTqQox9Vauu6gpOjXc8xkIqEt?=
 =?us-ascii?Q?GIKo/5leZXW1Puf6m00ou4paHubaYIF3LGgLPZKBD5Nr3fuREBcV3rlAQX+U?=
 =?us-ascii?Q?TJ48txx9rsr65jOwIv3U1uWPuNYs0kA6oyPDjRSKbB2PtSooRJpKoWskCze8?=
 =?us-ascii?Q?M8ozRqi2BT/sWvxfh8lCpbwuNDannLHuIWURHsX+k0ls47eqOcl1zMQmYJMU?=
 =?us-ascii?Q?RFgaLmu7LowlLCK7xKP4aUpvHAuMeQrI76mntSmhcesTUYnBXdIY1I5Tqlqt?=
 =?us-ascii?Q?DYhPcAYmC+Ik9Chxcaw2w/TcIPot7++R0nuhulcmYv8lOmoDmqv8MbJstcvF?=
 =?us-ascii?Q?kc0WXd5mmDDwJdBYxscNU4yByeD8WqAgl0vjfEIZ5zkhOZf74C1C?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f29b0da-00a5-4297-b3b6-08df41a94713
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:12:20.8433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvfaJ7bDaQj3Ggbo/548G3Ii5eEp9TnNhITzFn5cMvXBI6dcUaTILRpvJsi94EzMbwEZBY103bLOWDTLqlfGKXuAj7o4Dlp11+MTwYBleCgaUQq5My23cfj/IeP8MZOK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7599

On Tue, Nov 03, 2026 at 08:49:59PM -0600, Nathan Lynch wrote:
> Add sdxi_cxt_submit() to consolidate optional fence and completion-status
> block setup, valid-bit publication, and doorbell ringing. An optional
> struct sdxi_completion input identifies storage already claimed and
> initialized by the caller.
>
> Introduce generic descriptor helpers for attaching completion storage,
> setting completion-status mode, fencing, and publishing the valid bit.
> Publishing orders prior descriptor writes before transferring ownership
> to hardware; the helpers warn if a caller attempts to modify an already
> valid descriptor.
>
> Provide sdxi_cxt_attach_cst() for attaching completion storage without
> publishing the descriptor, and sdxi_cxt_kick() for ringing a context
> doorbell.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/context.c    | 36 ++++++++++++++++++++++++
>  drivers/dma/sdxi/context.h    | 28 +++++++++++++++++++
>  drivers/dma/sdxi/descriptor.h | 64 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/hw.h         | 10 +++++++
>  4 files changed, 138 insertions(+)
>
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 60cc812df204..679c5cfab19d 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -24,6 +24,7 @@
>
>  #include "completion.h"
>  #include "context.h"
> +#include "descriptor.h"
>  #include "hw.h"
>  #include "ring.h"
>  #include "sdxi.h"
> @@ -362,3 +363,38 @@ void sdxi_client_cxts_exit(struct sdxi_dev *sdxi)
>  		sdxi_free_cxt(cxt);
>  	xa_destroy(&sdxi->client_cxts);
>  }
> +
> +/*
> + * Attach a claimed, initialized completion block to a descriptor slot.
> + * The descriptor is not published; the caller sets the valid bit (and
> + * kicks) once the operation is fully encoded.
> + */
> +void sdxi_cxt_attach_cst(struct sdxi_slot slot,
> +			 const struct sdxi_completion *comp)
> +{
> +	struct sdxi_desc *desc = sdxi_slot_desc(slot);
> +
> +	/*
> +	 * We use simple (non-atomic) completion status mode only; set the
> +	 * descriptor's CSR bit. See SDXI 1.0 4.4.2 Completion-Status Modes.
> +	 */
> +	sdxi_desc_set_csr(desc);
> +	sdxi_desc_set_csb(desc, comp->cst_blk_dma);
> +}
> +
> +void sdxi_cxt_submit(struct sdxi_cxt *cxt, struct sdxi_slot slot,
> +		     const struct sdxi_completion *comp, enum sdxi_submit_flags flags)
> +{
> +	struct sdxi_desc *desc = sdxi_slot_desc(slot);
> +
> +	if (flags & SDXI_CXT_SUBMIT_FENCE)
> +		sdxi_desc_set_fence(desc);
> +
> +	if (comp)
> +		sdxi_cxt_attach_cst(slot, comp);
> +
> +	sdxi_desc_make_valid(desc);
> +
> +	if (flags & SDXI_CXT_SUBMIT_KICK)
> +		sdxi_cxt_kick(cxt);
> +}
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index 94e0fc45f281..f048e298f6de 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -9,10 +9,12 @@
>  #include <linux/array_size.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/idr.h>
> +#include <linux/io.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
>
>  #include "hw.h"
> +#include "ring.h"
>  #include "sdxi.h"
>  #include "submission.h"
>
> @@ -52,6 +54,16 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
>  struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
>  void sdxi_client_cxts_exit(struct sdxi_dev *sdxi);
>
> +enum sdxi_submit_flags {
> +	SDXI_CXT_SUBMIT_KICK  = BIT(0),
> +	SDXI_CXT_SUBMIT_FENCE = BIT(1),
> +};
> +
> +void sdxi_cxt_attach_cst(struct sdxi_slot slot,
> +			 const struct sdxi_completion *comp);
> +void sdxi_cxt_submit(struct sdxi_cxt *cxt, struct sdxi_slot slot,
> +		     const struct sdxi_completion *comp, enum sdxi_submit_flags flags);
> +
>  static inline struct sdxi_cxt *to_admin_cxt(const struct sdxi_cxt *cxt)
>  {
>  	return cxt->sdxi->admin_cxt;
> @@ -62,6 +74,22 @@ static inline bool sdxi_cxt_is_admin(const struct sdxi_cxt *cxt)
>  	return cxt == to_admin_cxt(cxt);
>  }
>
> +static inline void sdxi_cxt_kick(struct sdxi_cxt *cxt)
> +{
> +	/*
> +	 * Ring the context's doorbell with its current write index.
> +	 *
> +	 * It's OK to locklessly sample the index for this purpose: it
> +	 * monotonically increases and the implementation is required
> +	 * to ignore out-of-order doorbell values (SDXI 1.0 5.2.1
> +	 * Multi-Producer Enqueue).
> +	 *
> +	 * writeq() orders the descriptors' valid bits ahead of the
> +	 * doorbell, so no explicit barrier is needed here.
> +	 */
> +	writeq(le64_to_cpu(READ_ONCE(cxt->sq->write_index)), cxt->sq->doorbell);
> +}
> +
>  static inline struct sdxi_akey_ent *sdxi_alloc_akey(struct sdxi_cxt *cxt)
>  {
>  	unsigned int max = ARRAY_SIZE(cxt->akey_table->entry) - 1;
> diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
> new file mode 100644
> index 000000000000..b19d5d329e43
> --- /dev/null
> +++ b/drivers/dma/sdxi/descriptor.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef DMA_SDXI_DESCRIPTOR_H
> +#define DMA_SDXI_DESCRIPTOR_H
> +
> +/*
> + * Facilities for encoding SDXI descriptors.
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/ratelimit.h>
> +#include <linux/types.h>
> +#include <asm/byteorder.h>
> +
> +#include "hw.h"
> +
> +static inline void sdxi_desc_vl_expect(const struct sdxi_desc *desc, bool expected)
> +{
> +	u8 vl = FIELD_GET(SDXI_DSC_VL, le32_to_cpu(desc->opcode));
> +
> +	WARN_RATELIMIT(vl != expected, "expected vl=%u but got %u\n", expected, vl);
> +}
> +
> +static inline void sdxi_desc_set_csb(struct sdxi_desc *desc, dma_addr_t addr)
> +{
> +	sdxi_desc_vl_expect(desc, 0);
> +	desc->csb_ptr = cpu_to_le64(FIELD_PREP(SDXI_DSC_CSB_PTR, addr >> 5));
> +}
> +
> +static inline void sdxi_desc_make_valid(struct sdxi_desc *desc)
> +{
> +	u32 opcode = le32_to_cpu(desc->opcode);
> +
> +	sdxi_desc_vl_expect(desc, 0);
> +	FIELD_MODIFY(SDXI_DSC_VL, &opcode, 1);
> +	/*
> +	 * Once vl is set, no more modifications to the descriptor
> +	 * payload are allowed. Ensure the vl update is ordered after
> +	 * all other initialization of the descriptor.
> +	 */
> +	dma_wmb();
> +	WRITE_ONCE(desc->opcode, cpu_to_le32(opcode));
> +}
> +
> +static inline void sdxi_desc_set_fence(struct sdxi_desc *desc)
> +{
> +	u32 opcode = le32_to_cpu(desc->opcode);
> +
> +	sdxi_desc_vl_expect(desc, 0);
> +	FIELD_MODIFY(SDXI_DSC_FE, &opcode, 1);

why no dma_wmb() here?

Frank
> +	desc->opcode = cpu_to_le32(opcode);
> +}
> +
> +static inline void sdxi_desc_set_csr(struct sdxi_desc *desc)
> +{
> +	u32 opcode = le32_to_cpu(desc->opcode);
> +
> +	sdxi_desc_vl_expect(desc, 0);
> +	FIELD_MODIFY(SDXI_DSC_CSR, &opcode, 1);
> +	desc->opcode = cpu_to_le32(opcode);
> +}
> +
> +#endif /* DMA_SDXI_DESCRIPTOR_H */
> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> index c1bff631a5ae..edc43190148c 100644
> --- a/drivers/dma/sdxi/hw.h
> +++ b/drivers/dma/sdxi/hw.h
> @@ -136,6 +136,16 @@ struct sdxi_desc {
>  			__u8 operation[52];
>  			__le64 csb_ptr;
>  		);
> +
> +/* For opcode field */
> +#define SDXI_DSC_VL  BIT(0)
> +#define SDXI_DSC_SE  BIT(1)
> +#define SDXI_DSC_FE  BIT(2)
> +#define SDXI_DSC_CSR BIT(4)
> +
> +/* For csb_ptr field */
> +#define SDXI_DSC_CSB_PTR GENMASK_ULL(63, 5)
> +
>  	};
>  } __packed __aligned(64);
>  static_assert(sizeof(struct sdxi_desc) == 64);
>
> --
> 2.56.0
>
