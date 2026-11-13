Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589463;
	b=dKt7HGCj9rSADnzX55PK5NkIsVAoWjREdXAQ2Am1udtJojmStsiU1HzUW5UMioRvTsGA
	 ggoh2E4oSphOksYKwww9bPwpbhp68OT3m44LkbiIe2lfzlFx+iVi80pzgrYFTlhUDwrz3
	 QYGiu/X7m4b5VmNIraC84Eo12GogtxyhjkfVjQ0rfuQnSNWRQgXGiZ5IbVIOELMCtBizi
	 0M5HbKvLhKGs+vPNNT7o8jlc6vJMTTYyK9QffEUstgAeJgpLFcR/gi4AtNHFn8L9UuBa4
	 zqlcIAlEgVVf/ftVTHJl2oDhODBZJ5lZORA3Ie0dhpB0P/B/RKj1C3Wz3GX2hZBxTUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589463;
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
	bh=AlTXAQrliJ7+nUV8fZVzTVNZkneNfRRkqfNR7al8Vgs=;
	b=NBLepR1H21MmHIvDxEv1xrZ4d6X8zLxGbK8a6rom8veZyKz1fpZtqHrn00Y4sgIvIGbX
	 bkcOjqQ0MIrRNdnSMT5EWDljfZELtcyXqeM5/0NYc56/JIINoVQK9JWniHAUfzZX1d9hv
	 gh1eOEquO5Ih++J2K32BA+bxBBBhKCaPpv5sDr9C28kD2tNoaRQn6O2i2hJtV9qLlI9Bb
	 uAAEFcYKmPCt9TToh4chgIM/rr2EbUwm7r5vpjHhmhLbkMmKZQVhT2R0a6WS6xSKnUfUF
	 9FdeIP2KNABee9FhAKUzLN5IVIdMmgMN6QTKLMKOS6PAF5AAfsiieBVKMhj+0p7ftcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YDz4RduX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.41
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789DD606A332;
	Fri, 13 Nov 2026 17:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 789DD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YDz4RduX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E11PhFY1nZ0vfHLL712hGh42zlYDm/XA7XX9N5DKIA4EFNHerC70PZeFfVs3/Zc6nFbxvDZNHX8ggsP17fpoVzy9FTRt12SMl4pAwuDAUwLeM898ZN+02BToon7H5l6vn/S7pN0ZUOkQXajso8dC40hd8F+S7iDsmJmSyRiNv2PqMF6MCXiKnSyzjg009JvTA0gucWxsPPFPczxpfNczIEgyYqJ8Pw05VFxUUt8YJG2hGXGTwS8iGREWKCQx2lIlxOu7p4fTKGDUmhuFVGWXi1G71o3QTImko9oeBUs1YKj99DJKIFcONpjJmjt+SV/JZGO2uiRf1tScnHOUx1tYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlTXAQrliJ7+nUV8fZVzTVNZkneNfRRkqfNR7al8Vgs=;
 b=o2696hCqexLtttXGCIraUs6voCgbFxG+6bdUuyB4fPbDnIE32USNh54CNAxBLrSpDuIAos5wyUghGLU1LCoMh8rBvOs/ylByLji9YVipkT0Kyr6JkwkC0s65v3qSt8WZfPvQmBrbh5aNpDgP8l1naF5XMKEq8EHX2I3/NEyAodqM/cAyCIlKuzSqXkwSraVlVLZbBje/Ubs+oERXA6Fv/vS0LXuUYzEIIHSseH8NJdiWxuZVxHkAeAN9Pu/ai4QpGgEyvDMl0lel6LKJjCE7GMGLzbmnGpv0Gxe9hlBFCB1MyjZJ3vGHKnUE7OTCowyPXZydfNHwrchg/3re5sLDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlTXAQrliJ7+nUV8fZVzTVNZkneNfRRkqfNR7al8Vgs=;
 b=YDz4RduX1FfVRI2AKzQpl7OW/BuLe51MQhaiSgh8qhfHLIUzp70upk8h5TfSg7tP3t+bs9Z5KG3dOy9ejdqjwTlHnJRQo3R1XIDBwfTeeNsdYckvXoVvckLyFu6AADqRrbGbezmk/jwRf3fqH9enLLBw4UkaZUnJPUY8jaDMa5m1OSA87kjoJr65i9KU417q04wxI5DcFOppoIxeptVbR4YTZCXyM7CYc+vJu+blhRB6QeVbfHVgIB0xhtecQdvAPrZ4KKHMK+8RuPVk6uaujnDAuvWntNngwrNYjEBmDB+iygAWL2rr/lG70tQQosTcl8s/yre3DDBfMIKPP6rxYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:04:19 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:04:19 +0000
Date: Fri, 13 Nov 2026 12:04:11 -0500
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
Subject: Re: [PATCH v4 16/25] dmaengine: sdxi: Add completion status block API
Message-ID: <avdDC1vEqInjEhvR@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-16-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-16-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS1P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:8:453::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA4PR04MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e793a7-bb0e-4168-45b7-08df41a8282e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	iHc5XiGZpsHDYj/VODA/BxkXQhXKs5gvx07pLwizodc9vxID0eq4SOn4bV41nRMjjSIwhvHIMh0b2WR4QTL6bW5SA6J65O3hBK2+EFZtd7v1a8Y8ep7yFMAPx+FW+h0OLFk06qk9BJn4A04DUvfIZ76Xfk3eWVc3CTl12dYc0PLuQh6mJXHgmHmwIe4NBJEZX02jPO/ij0dzewXkOz196JlONtU35lFjRyfE+Ju72kVsZmYeL8TvpsYeGQUvly5N9e+VudCPmEfMvpbdp+KRPfhUuxgPh2XrdSk0kVoPkhNpOfg34X+P7KTGDBdJXe3ZwPFAeRxref7jetcHzuzrQdugENZ4oeecb4gEYyfmNov8a8/SvZdui6r5dZSAFMOxpiQ1fg0cSFWGDRKv+WGGZBiS8XlBGcEpH8mlFNXnTWNfkLDkr+gxHlBd3FCi5ISEYI0dQzHze3wXDwjYUXEKj45T5PWrgC1e7weUEpygnxgaPmvtAM+offM28PssgBnjZMK0pzM/POfcvPKe7GSTkyxxbnnz7CwvPnFG07tstR3i/TGHWK+LY191fCtwJ49jUqU8KBW+D4gKAc6jhis9KS3iCS5yRluevs1w8k6ygeRP+mubkf8Wj13243S3WarFn33mvKYPZ6gTbP/SXjwx3ocvQywmmMVxLIBAAxTMPJk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?247nXXA3flMS70ly1nUHviZUleNRv8H8bXaO4tjcDaGCs/WX/aMPPFpj19+V?=
 =?us-ascii?Q?pBoh6rTVGtqaiD+86XaUVwOLelGGkrkCJsNM3UWtQ1XjfDgauBrXd+IdLC5U?=
 =?us-ascii?Q?gc+EQReNoBE3TyTHbfLUabmQo8PW3EMpYFhZ+iEerEAJtGgEKX46FMqnyGS6?=
 =?us-ascii?Q?U76th6fixqDFrMhXAqd7+rjMt3HnftjfKX1hJyeJHTCVHBmwu6dDkH7Nk3qA?=
 =?us-ascii?Q?8FiuNOqYd6DwPXJODZkVqlE+9BbyN8IlWKp6JgW3Dq3lkKjvpIpdd2ksxmBi?=
 =?us-ascii?Q?gi2jFRZ+7D7G653viNwUbpNPllE6hE55FwdvOahHrXQuKnjhcBjEhn7uw+XL?=
 =?us-ascii?Q?Dwz8kSQNtQ52AJvCpy59SFrXLCbhxVxnJuDo+39jDsyRfwY/RFtFt8DCeAvn?=
 =?us-ascii?Q?uM0BGkLQcYaic7jI+xZw39/WqQFMpBAiXhdRmW14v2Ie5Jm+Kru3zB3yQ1s4?=
 =?us-ascii?Q?azCB57658AGcDo77Pc3UfbUzO8wXYIIl6SRjDp3BCuDNdj4Ux6F3EfkRbQyu?=
 =?us-ascii?Q?iBO6Df1e7zUoVwuY6zvI9V5SE+mXIWWosFCAuScL1JQUC6zrLJ8UOBs9/7kX?=
 =?us-ascii?Q?V8AtioPLPxbR9ccUBNMC8xjc0My8+nIs28sNF7RDpvYDN2oVysdEcyFTqbkp?=
 =?us-ascii?Q?q8FczoJAvziXLXVv0HjIH+80Tqk4H1aKKQaevyqhLxf8CXfTACe9TMyFmcnU?=
 =?us-ascii?Q?MqrorWsWysN7FQfFWWZT8UUR6+X65fXPnqA8WcqNAtNVSKP1QVru4Xq94FR4?=
 =?us-ascii?Q?mg54fiM5YaRP8me74RN9iyOyb8XJuba5Isjk5KDBrQcmysNNRNNiZ+72Zyte?=
 =?us-ascii?Q?SCsc5NTXRHLyUMOzoRT8rVFeHfbCuedj1K6dLdi5l8WvkUlZZxnit36MuOu+?=
 =?us-ascii?Q?j56IYhvNwpt6/5V7eySEgAs5jyh4MLZytYTOb0G0ZyvYJtgtFcVyylEfALcT?=
 =?us-ascii?Q?P1+/sU3cKE6+/qfl+pfbsyX4cOzI2juYnZSZMWvZq7ryVpncLLgleNVLGcf3?=
 =?us-ascii?Q?eR65T0B7HCUfcY3bluR/nmzOF3znVjxhQ+OQVEA1ilz06WwtKpIJpLYZ6Mj2?=
 =?us-ascii?Q?1Z7VQ2Vzyg8bU1xpfPI3Z0TqRHyE1hSOgCU3OdDIeGdDQOSyXzk2K7sP62S5?=
 =?us-ascii?Q?O9hb06wr/wQ0BQ6j9V7TQbKv1qualQsfuuPVRDl5v6VvddnMIZCy8LZy07hf?=
 =?us-ascii?Q?DGXa3wr4uRiPJtbEeLv3ytsyAalzaS10euAn55oboyFNzuY2EA5ctK1KTJAx?=
 =?us-ascii?Q?LNdiMjEmPeHlWBGV63v/HwRZZCEMoEkvt1gwAaUXwO/JuEk/wrGHlAcU8ZDz?=
 =?us-ascii?Q?fyASCy3reN9AjOgz+jgEOdadCL8SyoZK2cKw1sqzWxv7QWU33ttirvvhUezT?=
 =?us-ascii?Q?21iqOtx4bj9GWQAinlXhS6lLzO+n0InjxTM45GqfN3o6o5Sy4vRlVu42NtNg?=
 =?us-ascii?Q?qnyov6WiA4Zo9T+TBx9p5Pj6Dv64qJqfuxkG6q/u+DzqYpf7oqXPIWnJAApy?=
 =?us-ascii?Q?ndzX70Nww0HIZ7MLa53dhBeqU9YYZ1j4bEVzFGi/bl2jOMfusA1SUsh/Wflr?=
 =?us-ascii?Q?r1/efsGmknyvIv6LiDtzwENP66o2EWFAKIcnUmP7My2QFlJIwZcQSwK73Vi3?=
 =?us-ascii?Q?N2PVUtvKzNXq/TEWx8JI2RJlKP4LzVZModROSC89Ia4/ooCfi2r+++EzWiN8?=
 =?us-ascii?Q?8dfk2a0Je2p1ee+XzEoitgbWNIj+5PpjYngl2ShdcsQEDDHElGxG+WZBSdtR?=
 =?us-ascii?Q?WTJjor8AFsK6ku9rei42atQA0WJcqk47cz6e5SrmbbJtSwqavxfC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e793a7-bb0e-4168-45b7-08df41a8282e
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:04:19.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NBqF3fq58tIV4+GwIktIwap1eaoyNlICIgN1/iTE43j1WmtigPRpWrmgYtX1lGRSPenqk1fs2Yx1XkcpTAfC+YkyeyRZYTXOvS9OwAMXyiroiHR7jAa3u+XD3d2PPZC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9640

On Tue, Nov 03, 2026 at 08:49:57PM -0600, Nathan Lynch wrote:
> Introduce completion status handling and a fixed-capacity pool owned by
> each context. Only the 32-byte-aligned status blocks are DMA-visible;
> a private bitmap and spinlock track claims independently of descriptor
> ring indices.
>
> Preallocate storage during context allocation. Claiming and initializing
> a block cannot allocate memory and fails only when capacity is exhausted.
> Provide a bounded, killable wait for administrative callers, and wake
> waiters when blocks are returned. Release blocks only after consumption,
> unpublished rollback, or hardware quiescence; destroy the pool only when
> hardware and software no longer access it.
>
> Represent a completion-status block by its CPU pointer and DMA address.
> Check the little-endian signal with READ_ONCE(), then use dma_rmb() before
> consuming error status or operation results. Polling returns success,
> -EIO for a terminal error, or -ETIMEDOUT without relinquishing ownership.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/Makefile     |   1 +
>  drivers/dma/sdxi/completion.c | 152 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/completion.h |  48 +++++++++++++
>  drivers/dma/sdxi/context.c    |   7 ++
>  drivers/dma/sdxi/context.h    |   4 ++
>  drivers/dma/sdxi/hw.h         |  15 +++++
>  6 files changed, 227 insertions(+)
>
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> index 00e3f1cb0808..eacad504a816 100644
> --- a/drivers/dma/sdxi/Makefile
> +++ b/drivers/dma/sdxi/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_SDXI_CORE) += sdxi-core.o
>  sdxi-core-y := \
> +	completion.o  \
>  	context.o     \
>  	device.o      \
>  	ring.o
> diff --git a/drivers/dma/sdxi/completion.c b/drivers/dma/sdxi/completion.c
> new file mode 100644
> index 000000000000..c07a0fc101c8
> --- /dev/null
> +++ b/drivers/dma/sdxi/completion.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI Descriptor Completion Status Block handling.
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/iopoll.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/wait.h>
> +
> +#include "completion.h"
> +#include "hw.h"
> +
> +/* Only the status blocks themselves are visible to hardware. */
> +struct sdxi_cst_pool {
> +	struct sdxi_cst_blk *blocks;
> +	dma_addr_t dma;
> +	unsigned int count;
> +	spinlock_t lock;
> +	wait_queue_head_t wait;
> +	unsigned long *allocated;
> +};
> +
> +static void sdxi_cst_pool_init(struct sdxi_cst_pool *pool, unsigned int count)
> +{
> +	pool->count = count;
> +	spin_lock_init(&pool->lock);
> +	init_waitqueue_head(&pool->wait);
> +}
> +
> +struct sdxi_cst_pool *sdxi_cst_pool_create(struct sdxi_dev *sdxi,
> +					unsigned int count)
> +{
> +	struct sdxi_cst_pool *pool;
> +
> +	if (!count)
> +		return NULL;
> +
> +	pool = kzalloc_obj(*pool, GFP_KERNEL);
> +	if (!pool)
> +		return NULL;
> +
> +	pool->allocated = bitmap_zalloc(count, GFP_KERNEL);
> +	if (!pool->allocated) {
> +		kfree(pool);
> +		return NULL;
> +	}
> +
> +	/* SDXI 1.0a 6.1.1 requires a 32-byte-aligned completion block. */
> +	pool->blocks = dma_alloc_coherent(sdxi->dev,
> +					 array_size(count, sizeof(*pool->blocks)),
> +					 &pool->dma, GFP_KERNEL);
> +	if (!pool->blocks) {
> +		bitmap_free(pool->allocated);
> +		kfree(pool);
> +		return NULL;
> +	}
> +
> +	sdxi_cst_pool_init(pool, count);
> +	return pool;
> +}
> +
> +void sdxi_cst_pool_destroy(struct sdxi_dev *sdxi, struct sdxi_cst_pool *pool)
> +{
> +	dma_free_coherent(sdxi->dev, array_size(pool->count, sizeof(*pool->blocks)),
> +			  pool->blocks, pool->dma);
> +	bitmap_free(pool->allocated);
> +	kfree(pool);
> +}
> +
> +bool sdxi_cst_pool_get(struct sdxi_cst_pool *pool, struct sdxi_completion *comp)
> +{
> +	unsigned long flags;
> +	unsigned int index;
> +
> +	spin_lock_irqsave(&pool->lock, flags);
> +	index = find_first_zero_bit(pool->allocated, pool->count);
> +	if (index < pool->count)
> +		__set_bit(index, pool->allocated);
> +	spin_unlock_irqrestore(&pool->lock, flags);
> +	if (index == pool->count)
> +		return false;
> +
> +	comp->cst_blk = &pool->blocks[index];
> +	comp->cst_blk_dma = pool->dma + index * sizeof(*pool->blocks);
> +	sdxi_cst_blk_init(comp->cst_blk);
> +	return true;
> +}
> +
> +int sdxi_cst_pool_get_wait(struct sdxi_cst_pool *pool,
> +			 struct sdxi_completion *comp)
> +{
> +	long ret;
> +
> +	ret = wait_event_killable_timeout(pool->wait,
> +					 sdxi_cst_pool_get(pool, comp), HZ);
> +	if (ret < 0)
> +		return ret;
> +	return ret ? 0 : -ETIMEDOUT;
> +}
> +
> +void sdxi_cst_pool_put(struct sdxi_cst_pool *pool, struct sdxi_cst_blk *cst)
> +{
> +	unsigned int index = cst - pool->blocks;
> +	unsigned long flags;
> +
> +	if (WARN_ON_ONCE(index >= pool->count))
> +		return;
> +
> +	spin_lock_irqsave(&pool->lock, flags);
> +	WARN_ON_ONCE(!__test_and_clear_bit(index, pool->allocated));
> +	spin_unlock_irqrestore(&pool->lock, flags);
> +	wake_up_all(&pool->wait);
> +}
> +
> +
> +enum sdxi_completion_state sdxi_cst_blk_check(const struct sdxi_cst_blk *cst)
> +{
> +	u64 signal = le64_to_cpu(READ_ONCE(cst->signal));
> +
> +	if (signal != SDXI_CST_BLK_SIGNAL_TERMINAL)
> +		return SDXI_COMPLETION_PENDING;
> +	/*
> +	 * The final ER state (and the operation's effects) are
> +	 * guaranteed visible only after a cleared signal is observed.
> +	 * See SDXI 1.0 5.6 Memory Consistency Model.
> +	 */
> +	dma_rmb();
> +
> +	if (FIELD_GET(SDXI_CST_BLK_ER, le32_to_cpu(cst->flags)))
> +		return SDXI_COMPLETION_ERROR;
> +
> +	return SDXI_COMPLETION_DONE;
> +}
> +
> +int sdxi_cst_blk_poll(const struct sdxi_cst_blk *cst)
> +{
> +	enum sdxi_completion_state state;
> +	int ret;
> +
> +	ret = read_poll_timeout(sdxi_cst_blk_check, state,
> +				state != SDXI_COMPLETION_PENDING,
> +				10, USEC_PER_SEC, false, cst);
> +	if (ret)
> +		return ret;		/* -ETIMEDOUT */
> +
> +	return state == SDXI_COMPLETION_ERROR ? -EIO : 0;
> +}
> diff --git a/drivers/dma/sdxi/completion.h b/drivers/dma/sdxi/completion.h
> new file mode 100644
> index 000000000000..f91f44b9b516
> --- /dev/null
> +++ b/drivers/dma/sdxi/completion.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright Advanced Micro Devices, Inc. */
> +#ifndef DMA_SDXI_COMPLETION_H
> +#define DMA_SDXI_COMPLETION_H
> +
> +#include <linux/compiler_attributes.h>
> +#include "sdxi.h"
> +#include "hw.h"
> +
> +
> +/* A completion status block and the device address the hardware needs. */
> +struct sdxi_completion {
> +	struct sdxi_cst_blk *cst_blk;
> +	dma_addr_t cst_blk_dma;
> +};
> +
> +struct sdxi_cst_pool;
> +
> +/* Software completion states derived from CST_BLK. */
> +enum sdxi_completion_state {
> +	SDXI_COMPLETION_PENDING,
> +	SDXI_COMPLETION_DONE,
> +	SDXI_COMPLETION_ERROR,
> +};
> +
> +struct sdxi_cst_pool *sdxi_cst_pool_create(struct sdxi_dev *sdxi,
> +					unsigned int count);
> +/* Hardware and software must no longer access any blocks before destruction. */
> +void sdxi_cst_pool_destroy(struct sdxi_dev *sdxi, struct sdxi_cst_pool *pool);
> +/* Claims and initializes a block; false means the fixed pool is exhausted. */
> +bool sdxi_cst_pool_get(struct sdxi_cst_pool *pool, struct sdxi_completion *comp);
> +int sdxi_cst_pool_get_wait(struct sdxi_cst_pool *pool,
> +			 struct sdxi_completion *comp);
> +/* Release only after consumption, unpublished rollback, or hardware quiescence. */
> +void sdxi_cst_pool_put(struct sdxi_cst_pool *pool, struct sdxi_cst_blk *cst);
> +
> +
> +static inline void sdxi_cst_blk_init(struct sdxi_cst_blk *cst)
> +{
> +	*cst = (typeof(*cst)) {
> +		.signal = cpu_to_le64(SDXI_CST_BLK_SIGNAL_INIT),
> +	};
> +}
> +
> +int __must_check sdxi_cst_blk_poll(const struct sdxi_cst_blk *cst);
> +enum sdxi_completion_state sdxi_cst_blk_check(const struct sdxi_cst_blk *cst);
> +
> +#endif /* DMA_SDXI_COMPLETION_H */
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 956bb06f9499..60cc812df204 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -22,6 +22,7 @@
>  #include <asm/barrier.h>
>  #include <asm/rwonce.h>
>
> +#include "completion.h"
>  #include "context.h"
>  #include "hw.h"
>  #include "ring.h"
> @@ -56,6 +57,8 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
>  	if (cxt->akey_table)
>  		dma_free_coherent(sdxi->dev, sizeof(*cxt->akey_table),
>  				  cxt->akey_table, cxt->akey_table_dma);
> +	if (cxt->cst_pool)
> +		sdxi_cst_pool_destroy(sdxi, cxt->cst_pool);
>  	if (cxt->sq)
>  		sdxi_sq_free(sdxi, cxt->sq);
>  	ida_destroy(&cxt->akey_ida);
> @@ -85,6 +88,10 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
>  	if (!cxt->sq)
>  		return NULL;
>
> +	cxt->cst_pool = sdxi_cst_pool_create(sdxi, DEFAULT_DESC_RING_ENTRIES);
> +	if (!cxt->cst_pool)
> +		return NULL;
> +
>  	cxt->akey_table = dma_alloc_coherent(dev, sizeof(*cxt->akey_table),
>  					     &cxt->akey_table_dma, GFP_KERNEL);
>  	if (!cxt->akey_table)
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index cad5a153ec22..94e0fc45f281 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -16,6 +16,9 @@
>  #include "sdxi.h"
>  #include "submission.h"
>
> +struct sdxi_completion;
> +struct sdxi_cst_pool;
> +
>  /* Use a 4 KiB AKey table, the minimum architectural size. */
>  struct sdxi_akey_table {
>  	struct sdxi_akey_ent entry[SZ_4K / sizeof(struct sdxi_akey_ent)];
> @@ -40,6 +43,7 @@ struct sdxi_cxt {
>  	dma_addr_t akey_table_dma;
>
>  	struct sdxi_sq *sq;
> +	struct sdxi_cst_pool *cst_pool;
>
>  	struct sdxi_ring_state *ring_state;
>  };
> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> index b333e091c583..c1bff631a5ae 100644
> --- a/drivers/dma/sdxi/hw.h
> +++ b/drivers/dma/sdxi/hw.h
> @@ -110,6 +110,21 @@ struct sdxi_akey_ent {
>  } __packed __aligned(16);
>  static_assert(sizeof(struct sdxi_akey_ent) == 16);
>
> +/* SDXI 1.0 Table 6-4: CST_BLK (Completion Status Block) */
> +struct sdxi_cst_blk {
> +	__le64 signal;
> +	__le32 flags;
> +#define SDXI_CST_BLK_ER BIT(31)
> +	__u8 rsvd_0[20];
> +} __packed __aligned(32);
> +static_assert(sizeof(struct sdxi_cst_blk) == 32);
> +
> +/* SDXI 1.0 4.4.2 Completion-Status Modes */
> +enum sdxi_cst_blk_signal {
> +	SDXI_CST_BLK_SIGNAL_TERMINAL = 0,
> +	SDXI_CST_BLK_SIGNAL_INIT     = 1,
> +};
> +
>  struct sdxi_desc {
>  	union {
>  		/*
>
> --
> 2.56.0
>
