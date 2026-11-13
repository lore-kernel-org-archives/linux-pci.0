Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794590641;
	b=gWEBkLTnF5F5EXBC1+y47IK6SrSKDkTXt3G80n/6jFyYmutsl9DnQbrpyggbkYGqSYbs
	 1GsKyS/AjT4GusTjGRaT6/VS+QER26DYcg10XA2ui4jw664zB0Yf+AOCogFuiy0H3hnQJ
	 u2+cWmLc/8J+KUIjvF/jrhmBKCVfaRNgdQzVzbQ4KO1ymttFVwIL0EtNm275z3tT9xPRO
	 M+3nFSVgHqjGaTrBBPlZxIBmGZE9ovWdQl1y4f4OnRhfHc2W28qrUFR8E68HKvWZU6MxH
	 VvL/WhQnyL7zN8kVpjP5edESHUf+fOM652oeyk0wYuLz92Lg1qWVYyT1hGNBkUS2GrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590641;
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
	bh=PBWFrPB+7jTC7q5Jy+1RuQCHtYrdzIyVMp/bJnoznIA=;
	b=Ol8L/UYp/tquiUzsWOwenL1b0g5kuktc10iZchNwxyKnxG9RchMYvoDdTNDTIPX9eVX6
	 3mSwHisnrUiTg/I+3OAxxgXODiVh16xuSWtOo9xBQ+BcGabuaI684ZliMfBv7jW11NlZC
	 XqDwH85NDgezfI1xIwa5/5iG5uo6vOGwzcE5PiKGCUjL5vfSNs3LihL4V7UVnhBNk6+xc
	 sYN34pwz2uQVZUnMvBC8Rlx00Q5aESZK3fSAG1OWshScx5DQD8SUbeD1gwWSGr5PA6Nz/
	 fAqlGHfSQQyN9OsNmBeu4HWuDHaafVjxVgA3Air1tjvmZIWvacekBLGW23iL+kKGjRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rJh6AZox;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.11
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EABC60A383F;
	Fri, 13 Nov 2026 17:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EABC60A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rJh6AZox
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ38kWzq2yuDJB7jpLiWMR1AhyTVE8GZ1Oc5tybzdHbcH2ZiOFUJKE8K54HYn7nHnS3MIePat26dlbZfKu/Vktg59Bl6VjHmo9rOpbOFdw7fmhT4SVkjN3QTA12Uu48mdcIR92loRmW8g/uTLMlIpqUPGJ5e+yWfq29dp7H4bX6yTIxcrpjRnGTjiFSrVp1zwaZ1jczfr0R9tZuJdh1ZO586aFLSMVkHwDlxtZQ+PijldE9J0dYWTq91yxrIwsfWDkN8NxiW2PXbd/SNxMzLqoHgqc5nl0GjvHo1IQHONZ8kvVAcp2yx7AUK3wi+m7bAlT/eCM1rO+ViQRbY0aeZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBWFrPB+7jTC7q5Jy+1RuQCHtYrdzIyVMp/bJnoznIA=;
 b=G0TtMR47TV+3BhaW6C8sqc0Zc9XUmpfb9In3SC8NGK/wk94KDn/QbiN17+KVLmSmu4xCOs1vdM2nomtK5IgjIKItQlCZDqTOHoIQm8umy9OwRq7LrpdAC2yROL+4ssZYUrR2uSQY0vlCVEiTdViAMoDc57ukEB4FdjmZX9/pRrwmf1+zbxZYC8vmb0oOuB+PmMPyqI2b2TrWmz7h1HuFBXkSkGmfvPt2F2jFdTVwNHhL3EuNdyh4r5C2GT9Foj6CV2Ws/U0aWEwTS+HUc7GN6dpPrPU6Syt/fVkbY1ymOfcM48eRxIpXw3Xz+BbzrXfXZMevSfhgudnM1Vu8l+toeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBWFrPB+7jTC7q5Jy+1RuQCHtYrdzIyVMp/bJnoznIA=;
 b=rJh6AZoxKHoKo0SezqMeYPQ0lbMJ4t0xhtodwHMmkLIDr4OV0u79IFV0nHJB8/01WQ8EPy9WgnUCG0IRmw2tXXNbOE30WuKK33XtgbHrdvu2UJXJQ6eaBqP4bWhahqjZrQEM+HmAqI1lmonlXrXqFXtXzqmPFRxo5HWNBulOqnS+XY9CkRE8n6oDWTgH9CL65DpyJ24Lvo+/Hfv7IVXU7NdRx63hd3nj0LPF/nUpDP+gYgvWzQXKcSDJusHhwyrsJIu3Q33VKap4DzYkNybqN6DSKpSRX5xlFGTV5buERPOAr6Brg2y/HDT9r082dgxd1HiF8RK5b4YZhdavVo1buA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS5PR04MB9972.eurprd04.prod.outlook.com (2603:10a6:20b:682::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 17:23:56 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:23:56 +0000
Date: Fri, 13 Nov 2026 12:23:48 -0500
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
Subject: Re: [PATCH v4 20/25] dmaengine: sdxi: Add client context release
 with update and sync
Message-ID: <avdHpIGQ2Pb_K7yv@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-20-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-20-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS3P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:45e::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS5PR04MB9972:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b4855d-b5e1-402a-619f-08df41aae586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|22082099003|18002099003|4143699003|261022105027099003|11063799006|261028144727099003|261021121427099003|261102123227099003|56012099006|261009223027099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	X2oUmrMlCbxuSIhWq+C2J3/IAq9OQMvU/dM6LbGR/6sdXlHz8G0gyjqY2FJyUCjZs+HaDKOOzTzsMK0oqP9N64prWzfUCOy4oK594BrqUJlllcaSrdKAL293G6fii+n69GzgFr0tBriX7xJ6/o+XgscCy5P0Wg2mlRP+0R2ViZbbBA8vddNGHXCF3im2f6KaHvcUZcLdRsa/qQOeKeN6b1eyamxyJRiGZFb06dTr6xaar1clLhj/F7cbL95ADFv2swg7Gfn+aSej8t0GNZ15IWvUlyohzyO5Pk8lURQ36N85wQ8zUnt+2kzy4+kxFwT28G/Sau0lfsjtB85hubI3pBWTX1j22ABRb6wSDCAtSok9iFbs4Iot1A0U6KJ9wzj5p5iRCBNzI5uJ+zgIvvScSpQsYi6HLICrP1G7GIpsMkukdTlWMcHcladVld9DstW7cQQvLrTtfBQKSVedMM8f81+UF7pMutxG1U2apDa3qqJZ0Q/eXVmyRcHK8eXPWopGN5O0/b9okzy4y98ELQ/kbmoZYpdYveezLcg6rdR5OZAv5SLYnskkvDxaGgI8EIiAWqh2Y1wBqgBkFFH6cfsB/pshudmAGCHs262ZsGVPv0+EkLcBi5MBJm4Jtrpd6XIG1ALNcIvwSZFHcNP5uw/kLqZtrN5MHCmSADIKnws41Gw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(261022105027099003)(11063799006)(261028144727099003)(261021121427099003)(261102123227099003)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KALT+dCnJ/+eS73Psb1p8mspzxhU0STZ+267nBFJ55uiZDWt3XX2EDpASdoX?=
 =?us-ascii?Q?DH6RHF3zX0e4RwA1sy0vyUh+OmytAkQM7D90ddXii/rpFtill83Acu8j7ObX?=
 =?us-ascii?Q?Mb+L2WVQlzMJCYQGeHnqoIuy2EFrv7OSyzrZ1ragzF6fAcnGypiPEiPyNDhk?=
 =?us-ascii?Q?c4DzKwOfQb5so0Sgnefs3sOtQ4FhmdSUs67bTU/oGmlw2arqefWyJZmg4RU6?=
 =?us-ascii?Q?S/sQhY2DPKW7dI7BrXpRfCeXqqwGHtjtdksHen1FnUL6Xpp0rEnPWWOUtZ0X?=
 =?us-ascii?Q?GsWZsh2fTODycyEYr0hpSVyVM2wjhleUi8Wu9j82IKk01Tpwgi/7+KI2lSj5?=
 =?us-ascii?Q?jIw0lkprqWiowo4SC8GkVtRZu6Pv52L+ItQ981NGj2CoXIl3adEXAT1+T0lA?=
 =?us-ascii?Q?PigPLSIooGJK3ijR88P/cJdY2/XQZcyoqQkyVvH+kQfohtOfbmdwtk6PdlOH?=
 =?us-ascii?Q?p4wxIuVErfgOkJL1Gc+SpIne/xRa8Rv2TvR+UeCgAeOCswc5NaKyrjR2uvU+?=
 =?us-ascii?Q?YiJO9JOXzd+UlqOSp/KPr+d9ZQkxjhBB9bsig9eV6wjPSjo1RwkJMiU7Vwtg?=
 =?us-ascii?Q?tnmWes+qz97/JsY66gXMCyXmwNLk4J21qWJ9zAsNK7uJ45T2TA/bwzodNp6n?=
 =?us-ascii?Q?e4bVL9ed6NqDh/1FDH9PYpboMShQIl9Xwr4TJYrG5+tlfbTpLeyDRB6CVZNf?=
 =?us-ascii?Q?WUOnqV66+JvPISboATTQG/OcA6nzVUQss03fm5j4pUN4iGMslU2iG56vgpeZ?=
 =?us-ascii?Q?EMIlPh71NPzV1ZybRLUlI5P/kBtho+JH7/PmXO9LaPwxAobFjaXl9xqoXXp7?=
 =?us-ascii?Q?JZh5s1CD5cJMbmq2qX8XbANVkzLVAVRUSFXklIw6NBdiv2yqaCHlXRMtVT8n?=
 =?us-ascii?Q?767igsFf/0z0b7fPfmUS82K6Y6JMdtPdCiZt4kPNH/t57jF8W22xkS7LgjmL?=
 =?us-ascii?Q?rTRFdM1Au/meyQ7haOxJBMCFEBmNkaSuLzYh98/K+qpBhJk9CASh6nfp0mjc?=
 =?us-ascii?Q?5xgJ1gQ24oFbAkSHWZJYrzITal6Nrhc2XgeBrTYftkf02AOAvv6w6yx+duhG?=
 =?us-ascii?Q?tosMDUYhdw9usUtrbYCQUoEvYmoQ0tk27Txk65ciKMFoJ6J7DMPsMxqT1G1q?=
 =?us-ascii?Q?kVY5wP3scXoNzpX6QHhk7YdZBsS2qGktt1bpGTe3roK01OfV/fvNtWe+6Fst?=
 =?us-ascii?Q?V8asP0qw/S827/Tq6YjFIAGnD03v1LwSNGfyuK7fzEj9XsanylENLqM9YRa4?=
 =?us-ascii?Q?fk13UE34w7+jIalyzhfw7BQKhsy0SH8eHfxG9I3eq2m2zhULoBLDx8Y54rAa?=
 =?us-ascii?Q?k9ObxIbrXmH5+ncl5j+o0FTMwdAZFHMVgJqT1zkiO+BguoCOwKn31HuyEi8E?=
 =?us-ascii?Q?xF8z5vx+peG/qTaWWpIERzG1cPtxjagikPsQzn80PUxk+kiWqWviL3zLIvG+?=
 =?us-ascii?Q?MyBMch0nrDmWV0HhoCUs5pmwl+rctAzYjTVzhQh6W4OUbXtDR33IyfgTSwSu?=
 =?us-ascii?Q?h65ri9sEwxFq8rdDOmUAb6qKut3hZIFLJDnJ2EfbC3ELmKQyJtDjkIoQeR+A?=
 =?us-ascii?Q?maqOq6CumL+2P5meqmx1FHTpULoZ9LZ//t5xZGzgxNQdkmJtjlQfITB/ISas?=
 =?us-ascii?Q?jJYX6OdUiEhaSQz2xxACuTjc5/DYnO4o5jPkwoUoqeOKa8V6VtbL8xS0sNtc?=
 =?us-ascii?Q?tOcliZfJnCaIfbOYmlhsHmsdwKMeoD6iNgvjjurnsEwM+ZUMs3GF81DkgheK?=
 =?us-ascii?Q?BIwLPYjcwsbAhW/ugQe16IiyZSlBVK3q/iIj4yPpYBwILOPx8C+J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b4855d-b5e1-402a-619f-08df41aae586
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:23:56.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgBRB9EmZZ3jCvN75kx9wuJynksCeOmDKt+D9CpK2zjIIJN1Sd7pce8cA6Dr07blJlmCtt5kM6ef3vy8hGCSyrTNtdMApVPiqokb0x3oB/rBzdY9IfyAhn0xSkr5oFVa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9972

On Tue, Nov 03, 2026 at 08:50:01PM -0600, Nathan Lynch wrote:
> Invalidate an unused, stopped client context and synchronize hardware
> caches before freeing its resources. Add administrative update, reservation, and
> completion-polling helpers.
>
> Claim completion-status storage before making an irrevocable ring
> reservation. Return the claim if reservation fails, and release it after
> consuming a terminal result. A timeout leaves hardware ownership
> unresolved, so retain that block in the administrative pool until context
> teardown, even if the device writes its terminal signal later. Repeated
> timeouts can exhaust the pool, causing further claims to time out rather
> than reuse outstanding status blocks.
>
> If update or synchronization fails, retain the context and its ID for
> cleanup after function shutdown. Device-wide teardown frees clients after
> the best-effort function stop/reset path without submitting additional
> administrative operations.
>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/context.c | 128 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/context.h |   6 +++
>  2 files changed, 134 insertions(+)
>
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 679c5cfab19d..5ca99ac8080c 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -106,6 +106,78 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
>  	return_ptr(cxt);
>  }
>
> +/* Claim completion storage before making a ring reservation irrevocable. */
> +static int sdxi_cxt_reserve(struct sdxi_cxt *cxt, size_t nr,
> +			    struct sdxi_ring_resv *resv,
> +			    struct sdxi_completion *comp)
> +{
> +	int err;
> +
> +	err = sdxi_cst_pool_get_wait(cxt->cst_pool, comp);
> +	if (err)
> +		return err;
> +
> +	err = sdxi_ring_reserve(cxt->ring_state, nr, resv);
> +	if (err)
> +		sdxi_cst_pool_put(cxt->cst_pool, comp->cst_blk);
> +
> +	return err;
> +}
> +
> +static int sdxi_cxt_poll_completion(struct sdxi_cxt *cxt,
> +				    const struct sdxi_completion *comp)
> +{
> +	int err = sdxi_cst_blk_poll(comp->cst_blk);
> +
> +	/*
> +	 * A timeout does not end hardware ownership. Keep these administrative
> +	 * blocks claimed until context teardown, even if they complete later.
> +	 * Repeated timeouts can exhaust the pool; allocation then times out too.
> +	 */
> +	if (err != -ETIMEDOUT)
> +		sdxi_cst_pool_put(cxt->cst_pool, comp->cst_blk);
> +	sdxi_ring_wake_up(cxt->ring_state);
> +
> +	return err;
> +}
> +
> +/*
> + * Signal the function that a client context's control structures have
> + * been modified so it discards any privately cached copies of them.
> + * DSC_SYNC.CXT is required before the operation can be considered
> + * complete.
> + */
> +static int sdxi_cxt_update(const struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_cxt *adm = to_admin_cxt(cxt);
> +	struct sdxi_slot upd, sync;
> +	struct sdxi_ring_resv resv;
> +	struct sdxi_completion comp;
> +	int err;
> +
> +	might_sleep();
> +
> +	err = sdxi_cxt_reserve(adm, 2, &resv, &comp);
> +	if (err)
> +		return err;
> +
> +	upd = sdxi_ring_resv_slot(&resv, 0);
> +	sync = sdxi_ring_resv_slot(&resv, 1);
> +
> +	sdxi_encode_cxt_upd(sdxi_slot_desc(upd), &(const struct sdxi_cxt_upd) {
> +			.level = SDXI_CXT_UPD_LVL_L1,
> +			.range = sdxi_cxt_range_single(cxt->id),
> +		});
> +	sdxi_encode_sync(sdxi_slot_desc(sync), &(const struct sdxi_sync) {
> +			.filter = SDXI_SYNC_FLT_CXT,
> +			.range = sdxi_cxt_range_single(cxt->id),
> +		});
> +	sdxi_cxt_submit(adm, upd, NULL, 0);
> +	sdxi_cxt_submit(adm, sync, &comp, SDXI_CXT_SUBMIT_KICK);
> +
> +	return sdxi_cxt_poll_completion(adm, &comp);
> +}
> +
>  struct sdxi_cxt_ctl_cfg {
>  	dma_addr_t ds_ring_ptr;
>  	dma_addr_t cxt_sts_ptr;
> @@ -144,6 +216,16 @@ static int configure_cxt_ctl(struct sdxi_cxt_ctl *ctl, const struct sdxi_cxt_ctl
>  	return 0;
>  }
>
> +static void invalidate_cxt_ctl(struct sdxi_cxt_ctl *ctl)
> +{
> +	u64 ds_ring_ptr = le64_to_cpu(ctl->ds_ring_ptr);
> +
> +	FIELD_MODIFY(SDXI_CXT_CTL_VL, &ds_ring_ptr, 0);
> +	WRITE_ONCE(ctl->ds_ring_ptr, cpu_to_le64(ds_ring_ptr));
> +	dma_wmb();

all memory barrier need comments.

Frank
> +	*ctl = (typeof(*ctl)) { 0 };
> +}
> +
>  /*
>   * Logical representation of CXT_L1_ENT subfields.
>   */
> @@ -194,6 +276,17 @@ static int configure_L1_entry(struct sdxi_cxt_L1_ent *ent,
>  	return 0;
>  }
>
> +static void invalidate_L1_entry(struct sdxi_cxt_L1_ent *ent)
> +{
> +	u64 cxt_ctl_ptr = le64_to_cpu(ent->cxt_ctl_ptr);
> +
> +	FIELD_MODIFY(SDXI_CXT_L1_ENT_VL, &cxt_ctl_ptr, 0);
> +	WRITE_ONCE(ent->cxt_ctl_ptr, cpu_to_le64(cxt_ctl_ptr));
> +	dma_wmb();
> +	*ent = (typeof(*ent)) { 0 };
> +}
> +
> +
>  /* Publish the context control block and L1 entry to hardware. */
>  static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
>  {
> @@ -398,3 +491,38 @@ void sdxi_cxt_submit(struct sdxi_cxt *cxt, struct sdxi_slot slot,
>  	if (flags & SDXI_CXT_SUBMIT_KICK)
>  		sdxi_cxt_kick(cxt);
>  }
> +
> +/*
> + * Release an unused, stopped client context. On update/sync failure the
> + * context remains owned by the device and its resources are retained for
> + * cleanup after function shutdown; the caller must not reuse it.
> + */
> +int sdxi_cxt_exit(struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_dev *sdxi = cxt->sdxi;
> +	struct sdxi_cxt_L1_ent *ent;
> +	u8 state;
> +	int err;
> +
> +	if (WARN_ON(sdxi_cxt_is_admin(cxt)))
> +		return -EINVAL;
> +
> +	state = FIELD_GET(SDXI_CXT_STS_STATE, READ_ONCE(cxt->sq->cxt_sts.state));
> +	if (state != CXTV_STOP_SW && state != CXTV_STOP_FN && state != CXTV_ERR_FN)
> +		return -EBUSY;
> +
> +	ent = &sdxi->L1_table->entry[ID_TO_L1_INDEX(cxt->id)];
> +	invalidate_L1_entry(ent);
> +	invalidate_cxt_ctl(cxt->cxt_ctl);
> +
> +	err = sdxi_cxt_update(cxt);
> +	if (err) {
> +		dev_err(sdxi->dev,
> +			"context %u release failed (%d), retaining resources until function shutdown\n",
> +			cxt->id, err);
> +		return err;
> +	}
> +
> +	sdxi_free_cxt(cxt);
> +	return 0;
> +}
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index f048e298f6de..71eef2c6243b 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -52,6 +52,12 @@ struct sdxi_cxt {
>
>  int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
>  struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
> +/*
> + * Caller must exclude users and stop the client before release. An update or
> + * synchronization failure retains the invalidated context for device teardown;
> + * the caller must not reuse it.
> + */
> +int sdxi_cxt_exit(struct sdxi_cxt *cxt);
>  void sdxi_client_cxts_exit(struct sdxi_dev *sdxi);
>
>  enum sdxi_submit_flags {
>
> --
> 2.56.0
>
