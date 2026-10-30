Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.66.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793377317;
	b=YD70B8qcGoyN0kDB7tMbRZywmLB7/5ETEPmLhdGF8mciIzGQGbky7lDcYNcE5w811KHr
	 b571Rks95ApUZqu+8vZhc3ziBrsOFIH9Zt6zkeyMzqnPDj4e/swdWAb+ndWiZG9EPiv4T
	 E7U8fIBQXslG4H4yl5LZny8nL973A3yykVeDy5oegbPyWGqwr0II0CsCZ4NPe46hsJ/eN
	 pjWQx2AYVSszLmT1VxL5qnZbFk0kN5nVrfsWo0gD0kIyTySHnjRJv/QlRxW7tzpJoQUeH
	 i8mAMMfTSyNMwq7Znx4ugMdGxNpChnqlZSYpfJopcwA+yhW2k4RXikITEJRrU0amUcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377317;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UTtjKxF2T0IX9ouY9tuZOJvPeey75dou+vmla+aoLT8=;
	b=rli0vB/AsA2LWENszEq6wzJ8LXaveJEQuYKLdHX8zkkeFTLcqphXDXgHG7LOfTM6PDNk
	 ht6r5bSPlXqq0Zr98FPxV22LmexxbxTUAFpufA6iCwMr7lbEJjhsIzuBpAwZFYSMcrodF
	 MooI2hYPIlx7NOpllfB+7cWzuXXCxBqWvu8bTFVRbFW5W7HY8oUVIgVKBEEVDsI25Mgy0
	 0n3OS0flnHA1WBMy7Gz1vyJMrQbhT2QHIaHol/CD1vqXnsx3LfztsaEmUWBhD1G+LiMZl
	 rJyCMm1tDqxnRkk/QFjplhSwk7pmEyc7+kaV9gEp4dMOB0Jd3BZTieuVIlLoDboQVpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=fail reason="signature verification failed" header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eAlDgFPm;
	arc=fail smtp.remote-ip=52.101.66.41
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C51A606A31D;
	Fri, 30 Oct 2026 16:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C51A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eAlDgFPm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=golF9hoeWP2g9MM+u0Bpxxre99USUnIxCAr8yXPwCxxSXrUJ52/JUSPy5ry+6v+CKe+aFo9cgxRjyv++GQsms+8a5Ip7N5PCuiKKJkTDjhVOhmMPAq7RDUkG94ZR3WEKPJSmsGOr4qZOqyobHGxPq+wKRYdevTMNvUmaISNZvYbi+JJk4UXxbw+5/qdqL3t+Vk6pgWXXk672MJVKBuC6kRF1VTBh/kRPHOwBa+kpOt2DfYbHPADlyYZI+7Oe/LCi5NDmcF2V4HDZ5z7ZRNyty6lhOzi4qrHzOAO7yTKEX5c+TFjzGO9K+7PDF+ei7hjWXPa57VPjJ1NtC4VTwD+yKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXaztg16ndQQfh9VlyF1OOIr59N0HBot+AXXoJwW410=;
 b=evFc+SUva9TP8VhwZlhDfmQZGIa093uGyFJ8xucQGrkPenwaKrOv6MN/37c0cMNz6Tvyq31u+YbASJnpxo7rkzXYGMZURfI3EHjD5rZ+hU6G15ca55nWlA87drY0M76WCSQ2pj6++1K0ad9CJDuj8u/qxWSol3QVw2OBt9LbPWPdE/Wvjix/8UipvPOnJ9fbqn5KO+NjYsVqSnQwWXY1SCaTboHWRlru0d16/85cZtZMYxk7GJFeQrU/VYNCveCuY3aNfsoNsWOwdgjwrgtxl333bMimaDR3+j0IqQYsgwlUX7wiHaUoKZQdVDJy+KAZqYZKPNrtG/w3+gnPkSvWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXaztg16ndQQfh9VlyF1OOIr59N0HBot+AXXoJwW410=;
 b=eAlDgFPmHzLRKCYtJdus4wOsdheyfbrYBq9Sx3swgJo+fz17/V55Gsnwv2ogr2W6kczbKVfb/LI+EoFWEbWnGJ2dUCTslrtN6191GODd3bPjE91zBk+em+NSNtAB3ZluqfobrVULsSUGO9XEyMMTEcxvldxYoCPCQNUsEkQycd0xqm6aNkcEn3z/XZ9ioPpZLe3j62Au76NQLsLbcjO3jnx/SYV2WH27p/veltIiy58nuJAI5VP2aopAQVACv/D5exqhqBieR4XEuQxWqt4E9y8bJFshkxvjqWHE14hbAiC7MYCah3L4OnkXFA4C/Kk1mXJfA/D7R3xymqQgtVyWiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by GVSPR04MB634494.eurprd04.prod.outlook.com
 (2603:10a6:150:719::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 16:21:51 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 16:21:51 +0000
Date: Fri, 30 Oct 2026 12:21:45 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Koichiro Den <den@valinux.co.jp>, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
Subject: Re: [PATCH v6 2/5] dmaengine: dw-edma: Reclaim LL entries from
 hardware progress
Message-ID: <auTEGSSGk3M1mx4h@lizhi-Precision-Tower-5810>
References: <20261030150742.2586776-1-den@valinux.co.jp>
 <20261030150742.2586776-3-den@valinux.co.jp>
 <sashiko-outbox-191180@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-191180@kernel.org>
X-ClientProxiedBy: DS7P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::6)
 To AMBPR04MB12445.eurprd04.prod.outlook.com (2603:10a6:20b:75e::21)
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
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|GVSPR04MB634494:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e70992e-1a80-4a4c-4735-08df36a1e7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003|5023799004|261026140227099003|261026121527099003|261026135527099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	QT3V69iYEN5H1du9qQpHcaVF9HnTTnXpNzUJu9SGiKZPeqxhKs6z9zWwAaykX9oOs4qNXxXqozjuHOPLtNh5pb2USqwKOz2CwSOqPlzkCnYFNnR9IUoG3MvR36TuCx4eLCAvgfVNsX8E2Nh9ufIvKwJAOFxl8tXrW0+sgJszmiNgW8qnX6u3WbkSgIZn7j1QzEJv26hszlujD/HgrL+x+RE30FcNoSEQEIHTXaW8slXs7uNNL4apGDWBr+/W8ut8cKJQtVh5aay7kwY33uL6PvwqZPHCnQhffEMPqGwZt7BOT0Ky+Bhbu64hIYsNEBjwRWcTTvi5vJEHROCreYqL0d6xA7KteCNhBQ9NjfC8xpKGBdhxIoZaSJWJgkI59OZfAxjEuNFsfTANF9b5Jv7LYXGUYwofY7Koj/G9P1yzwlEy0rURJucEN47x0DeWdiyUxGINBuWbVdcAiHaXcg+BmIAwNvhKhkxiv89QJ9ryVCmPq19p3DGVog+yPM33GnHzNIP7FAzQ3ClLmQ1+L2kaO25Mzqowpnee/uJzhlHkuTi9t2SnT5JQhpz0/LtzrhXTngjRApgkQWr0TB8KtAaXK7KdVTX8mm0mCaF0gIQ9L8w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12445.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(5023799004)(261026140227099003)(261026121527099003)(261026135527099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?b7n0c4r+Cc5gnycVCD/QrT96ne7PL3kWcBDz/YyBwmBzL1a6pxLjbLlAE+?=
 =?iso-8859-1?Q?tas+A4IM9pdkEin7sYHFbfjBMmpTogLMEWaL/l2pGCV2ylBQZjdbj+dMzX?=
 =?iso-8859-1?Q?0GXMoYmISzgv++xv1t46/LUsLZgaIx3+AUFFmjfbTxgU1JUdarskcn5+Q4?=
 =?iso-8859-1?Q?fehANLGfna0pwTgI1slHmspNVOsRnZgPifSU0i/QmZAQ55dLQ0Clg26Hd0?=
 =?iso-8859-1?Q?CwB6im0PfilNhhWlNIwiXK1UNShlf79VUuW7CjsWhP22w9h/Nw/gM+FGE/?=
 =?iso-8859-1?Q?HG6ZUIbxE0Etdd3rC6e1/0K/Uc/ZoWH81tu5HruwnA3nYbY5eIzl1BsMS3?=
 =?iso-8859-1?Q?U6d53MlyAwJ8WYpHLftGnvsplPjh7cownZNtQDpvVg2llojWUj0dtigP1Y?=
 =?iso-8859-1?Q?NhC7x/ujnI2NuovdRllqm2st/wYf8J5TREDqr7UOP9Y+fdO16HHoXNrcfV?=
 =?iso-8859-1?Q?3xkjGoEthwWNBGHb9RVH3HKy5O8yK4smquaG7RtNRG/KvsALI0nnLheuRG?=
 =?iso-8859-1?Q?TTXzWsrQsGeLLdYjdLlrXaa2U1Zo2aJ5meXhW//Vr1mNbPl5nU5eprFxjX?=
 =?iso-8859-1?Q?Cx0TXVpCaTn9QElhrrQulkR2PP3GXv71uyxTIFeVUdk/s+ZK+qLzaU041S?=
 =?iso-8859-1?Q?Mh1NYuFqRG8lP063/jVjn7TLa+Cyn/L+NbQ3uPs3mYE/uqGnLC6MMKiuaz?=
 =?iso-8859-1?Q?LVJfP0otlBZTOmATQdbtd4u+2mU/M1Zi1kVPo31tYpF85X2rJX9hgGsU5o?=
 =?iso-8859-1?Q?9th0z6AuZ/txSldzrKvkIXHQhHZjQB8S0tDqSXCojV5EljHTxDkWdj8w4E?=
 =?iso-8859-1?Q?dHNy7G/fZX7KbLMpv7TBUYITm1+EzPrJbsQaXoN2DkagtRhcnpmkEYoax/?=
 =?iso-8859-1?Q?PjU22S1BhOKBoC15rCYZMyAKURY+8qYpMBTi1Ajj/LFTuQZ/c4v42YeZNb?=
 =?iso-8859-1?Q?mXhlAGwS//XCQGHXh0Ot3R7oyJDVjn7KMdYMd7JqcuI+M+8Kl/E/lB6RRw?=
 =?iso-8859-1?Q?a6mBfLq8pzPXWUcwTcssfPqA60q+aY6gArPWKjehRkCsJXUk/MQQlewsBD?=
 =?iso-8859-1?Q?BJWro/pCZmy5Kd/F6+7RVOGMHO1pFpXSZm6vFORqW0/0bjBgufa1xri869?=
 =?iso-8859-1?Q?6szPPfVGdnJKWco9RA3ZJRccWJaafll5hG0z2W07eSpPEjZVX+SqNjbBwF?=
 =?iso-8859-1?Q?h1UMQvoh9nukCEN6zdQSkbG1lPl1CJl4emGgdeH/TNlUZhXzF9P5cL1EmI?=
 =?iso-8859-1?Q?q8UnMrF4BmCzQ90rWYk0/8dD7KfC3HbRz+X5Fsg5zZwsYKqbhYEOKiP64e?=
 =?iso-8859-1?Q?Nmh196zqUCg4gbwtsJpDXAdSJDxTwdMw2suQO1waOhOyKocLGgpW62Qepr?=
 =?iso-8859-1?Q?pAxhRF+4mYaavs4IKRsDVMzeAaDRUXQ6yu7TIFpX2mS96rS7WS5EwrAL/g?=
 =?iso-8859-1?Q?LpEbBm9ZxcgSjGz1UsrZPeOcgE2GaF2qX4bSjY4sOuKHQfdfmmtfFWEfop?=
 =?iso-8859-1?Q?6dwCXsaY9O9B9UMsroNo65I/s2iSoWUlIH+OBD9jc5GnoboO2k/mTAIYEl?=
 =?iso-8859-1?Q?RKINhX9HPkm3C+iomNKzGViGbCyrA3QKGUpl0hkPPVtEaQuolDQlbgvvmk?=
 =?iso-8859-1?Q?I96D5rY0OMpo6Jokf5PH5wlWVgVJ5lUAR7PmM6QcxyFBQZUFMONu4JRqOV?=
 =?iso-8859-1?Q?XcBHZZPZ0qUl9NoUEVb2tIkbu6eicIUeTgmBBaiZKc5fBtkXWctdAk2DRZ?=
 =?iso-8859-1?Q?tGSh08sCnJ8GAWYMOyIHyL6ZXjz1gG+5tqqGmmvQPJnx5jD/mQk3fJ5JkL?=
 =?iso-8859-1?Q?+eNZfiMCLCERG9qDXkrxJWAkREyMT2Y=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e70992e-1a80-4a4c-4735-08df36a1e7bc
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 16:21:51.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pblko3BnlM1fjRS5vkgc0ZALtLz1mj5M3hTsSnCeLmCCDuCD+Y7MIKonaEkCSJFDaX1bc//N/XzXc+fC+jp1BkFroILHIAoueKS4ylNI0xcWpWau2wS1LZyrkV7ixYcG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVSPR04MB634494

On Fri, Oct 30, 2026 at 03:39:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] dmaengine: dw-edma: callbacks scheduled on STOP in dw_edma_ll_advance()
> --

Need fix all sashiko report problem or provide explain.

Frank

>
> commit cb11666c731e633531785427e3b24bbfbd73eb2b
> Author: Koichiro Den <den@valinux.co.jp>
>
> dmaengine: dw-edma: Reclaim LL entries from hardware progress
>
> This commit updates the linked-list completion handling to use DMA_LLP to
> advance ll_done and reclaim completed ring entries in issue order. It also
> defers STOP and PAUSE completion until the channel stops.
>
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index b08bb31657c9e..74613c95ae112 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
>
> [ ... ]
>
> > @@ -283,6 +345,45 @@ static void dw_edma_core_ch_maybe_doorbell(struct dw_edma_chan *chan)
> >  	dw_edma_core_ch_doorbell(chan);
> >  }
> >
> > +/*
> > + * Must be called with vc.lock held.
> > + *
> > + * HDMA does not update LLP continuously. Only use it to track running
> > + * transfers when handling an interrupt.
> > + */
> > +static void dw_edma_ll_advance(struct dw_edma_chan *chan, bool event)
> > +{
> > +	bool stopped = dw_edma_ll_stopped(chan);
> > +
> > +	if (stopped || event)
> > +		dw_edma_ll_consume(chan, dw_edma_core_ll_cur_idx(chan),
> > +				   stopped);
> > +
> > +	if (chan->request != EDMA_REQ_NONE) {
> > +		/* Wait for the channel to stop before completing STOP or PAUSE. */
> > +		if (!stopped)
> > +			return;
> > +
> > +		if (chan->request == EDMA_REQ_STOP) {
> > +			dw_edma_finish_termination(chan);
>
> [Severity: High]
> Does calling dw_edma_ll_consume() in drivers/dma/dw-edma/dw-edma-core.c
> before checking chan->request == EDMA_REQ_STOP cause completion callbacks to
> be scheduled on a channel that is being terminated?
>
> When dw_edma_device_terminate_all() is called while an LL channel is actively
> transferring, it defers termination by setting chan->request = EDMA_REQ_STOP.
> When the interrupt fires:
>
> dw_edma_irq_work()
>   dw_edma_ll_interrupt()
>     dw_edma_ll_advance(chan, true)
>       dw_edma_ll_consume()
>         list_del(&vd->node);
>         vchan_cookie_complete(vd);
>
> In dw_edma_ll_consume(), any descriptor in chan->vc.desc_issued whose bursts
> finished before the channel stopped is removed from chan->vc.desc_issued,
> placed on chan->vc.desc_completed, and has chan->vc.task scheduled via
> vchan_cookie_complete() to run its completion callback.
>
> When dw_edma_ll_advance() then checks chan->request == EDMA_REQ_STOP and
> calls dw_edma_finish_termination(), dw_edma_terminate_all_descs() only cleans
> up descriptors still on chan->vc.desc_issued and chan->vc.desc_submitted,
> leaving the descriptors already moved to chan->vc.desc_completed to invoke
> their callbacks.
>
> By comparison, the non-LL handler dw_edma_done_interrupt_locked() checks
> EDMA_REQ_STOP and calls dw_edma_finish_termination() without calling
> vchan_cookie_complete(), matching commit 99109a51efd2 ("dmaengine: dw-edma:
> Terminate all descriptors without callbacks").
>
> Should dw_edma_ll_advance() check for EDMA_REQ_STOP before calling
> dw_edma_ll_consume() so that terminated descriptors do not schedule
> completion callbacks?
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20261030150742.2586776-1-den@valinux.co.jp?part=2
