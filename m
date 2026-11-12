Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794520360;
	b=t2GM8akroyNeB+VbZOtZK2h/6huKDa7ZBrxUtKlVRo7zue0/1J1JtpTquZPZVJvUCgAm
	 1gwrypBkO5UafoNMGz4zsloPkDFjky+pXraw+ea/LyJ901tEowCmklNUMZBj+5f796ROj
	 8W8xPqLTTnB/MUB/dg7t4M0oEges+vVg7lHku8q3QaiJvbfCVkwX1ZPTDA2tEfHw1gJHz
	 RtOBDUPUM3n5bk+zgGFKAFKCmf54V4033HWP3IVzccKLd8nRQWOroP8zUwi+oejHQs8/v
	 I4yP9skc2p5REoGmq0Va7E3SANAsFu46gNUjkAVxfsc8Kn76WVhmBL/BPEscWzTXBtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520360;
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
	bh=yvjaypfLRu11feBXJbSyQhtsh3ImgVEAyHAzhPsaOqc=;
	b=hQesy9M8QggMMHGnBsl/OcIOiIrqOe4VFTdlV3Riz+MrieIdomhc0JWmpoc40KtFuJSr
	 0gIdhdmriRKVhRWS13ia20xsk01WC9osym30Z4sY0jrXtd7HIR6mQp5ZZT+evBp153pbz
	 pfcjoKoyFS6ZlBUVAJ+5hU4qdXX+lT4UKiDQdi9cDIN6Nns93EsmMgxLFaLwsU0KE+vfP
	 JQvRJwK8gfE93u1tlGiz1cdk5vC+GOkwcffdHSxRtjIhwWVEX+OHOugoFLlRZnVNQ5FUc
	 EDgLy8uq6iEOmcGVVspovRf1SiWjxGrqoYhRYHITHgdm1Y5zZZHGpdBvfkM0UhEyEiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=xy4090kS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.20
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18082606A31C;
	Thu, 12 Nov 2026 21:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18082606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=xy4090kS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGo3rc1+j2n7flszadX493mAsEeESo5GBwu07k7K5f/7dbTvXpdDVg9FK9R5y0jne08saAWNaqPZUAAZWKRk7sN0KnIl1aw3UMmmfE/6ucPAooKJBBtjMcLe7G89clB/ERLC22fvHd8PiE8NCzHWRszywKWrsokE991YrxnDqi3HqSY/sWLdyMHFyqaffcpAWQyrgLeXmtEkUldaR4I1mqneMZ2ZaPjeSoB+5Dj8JPbGSSSyDkSBvzyXYhsnuzv0iyCzBdTYvIUgsFGlyA+1YaD3zKC9LiRVgiXqpvb5R+VeLALMmXvbYrcX+Ynph8uYxfl71t9cOF7r2hXkLEgMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvjaypfLRu11feBXJbSyQhtsh3ImgVEAyHAzhPsaOqc=;
 b=jK+vQ6NonBv95idvqCq7pLk6WdJzqkqN8ZJbspOUsBAVfRtg+rzMyrwj8lW9gFLhbu3bN8vMpKuOSg3l6aXSrAe0OSYHDEYKGsS60s3gNIMD6kMMNvfNZR78MxbODnd6bu7/1nbxoe/jKyEF0a6D/5RLXZ9HpZW41NTenMz6sAXQvGJk7OL3C7CBlN+uR4Bi6k0zZScOgkCDqKbSqOy4MBiZztwnjCqS36hh3xnSeqhRncShLkUEEKcDHHRphyL9KS8NFBi3J1/6TUOKcbjeFsd1pFY9yqxRYdc16G+KAq+X3I19HdZUgqR8GP7BNJhm0GdN4AltUnqVoIpKRGrWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvjaypfLRu11feBXJbSyQhtsh3ImgVEAyHAzhPsaOqc=;
 b=xy4090kSp2ijCQyGGr1SlBYfn8d61KpKARNzvEVggIIgWHY01f/9/p2zEYr43IW8UowtZd7hOs8LmzWOLD7wayr6bvWBMmOB0A+g6VllMrsI+4fdL4Oe+yHdtvv3b5PZ2ooVNJmezD+Z97q8O96joJ931XgZ4fFAVWXilSWVFAd3bSAFQQTpEmwOry5c/yLPjMX2wqug+Hmpc8UHEdwKijlxQ6o4DqPu2f3YzbVCc3O+9KIGGn9R19o8PYGdCr2KGxxghn5dQPbaZBOvqFTCxPRQVgojfBFa0sLto4jisti+TYFnGcJZp4ZpIeP5aKza5NytC7PRVp/x4RuSMciZHw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB9PR04MB9674.eurprd04.prod.outlook.com (2603:10a6:10:306::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 21:49:16 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 21:49:15 +0000
Date: Thu, 12 Nov 2026 15:49:04 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: nathan.lynch@amd.com
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
Subject: Re: [PATCH v4 06/25] dmaengine: sdxi: Configure context tables
Message-ID: <avYz3knsBmmFa7fs@SMW015318>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-6-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-6-3668ccc7aab8@amd.com>
X-ClientProxiedBy: AS9PR06CA0348.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::8) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DB9PR04MB9674:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df536d8-285c-4ace-dd16-08df4106cbe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|366016|376014|23010399003|1800799024|18002099003|6133799003|261009223027099003|22082099003|3023799007|11063799006|56012099006|10067099003|4143699003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	DIk/d64zk3gLvAeChIEsvHg0PYJHAilBtmnV0oYg8Jlf+N+s7JpgF3rU6SaBRAV3AMoJM6BBeq3a9IRPPDS+v1tF4Y6gVENSs7OLOt/6CTPVPC7D449W65wz/Gl4dxx9oHASMO2saZXpIn24GoKwI3kK5xei2t02MXewV7O3rfhIqyx3m67B5Esm59SlqlBwI4nY3M08Q1GdBWrfh/sVTaN+JlCbwA7PD8jgmHRm5/10GdKSQDEq5tDkeDKqMS98VrgEJWKTHdJS8qjn2g/Xmh2sF1C8BiX0YiZEQxcBgZJOEtVLTRFLFcXyfeFaX8QVQEOvNsQiFiXg6HaCENrMD9NboHFK0PFGUe9BYWZ1L3idWht4g1ZYTITW+1sfHG3n91QSN9HNwPLxRqLRlH4ELGDd8AEIuqGHdbC/Nn+yRnZ+NbJuTajmOKaThtvosALjw/+VXs4QG+5gwHUjXprvXL8KJ8lnyn7VnuqUoM07Nm2jGaskTXUlK2tgrK5Cp5CSLfk/1u+r72fZNzl9KyWm7D/tB/Rh0fGjq+lzehQsLz3QNOPBwuugHzA1PnW77c7CRBTKTqcmFywDMCGo0ZouQcCO8mYnOlByTYwjZJFJ5xWo+Obiu2ea4oWgQ3wHv0ZDHm62mlgXQD4d2nQI1MsiCB7db33UHpFB/vIBWPsq2GA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(366016)(376014)(23010399003)(1800799024)(18002099003)(6133799003)(261009223027099003)(22082099003)(3023799007)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V0ay0AjfW1fOVnS+V5/cVQzbpf7pOIe8lubAtSNqyo/eg/cqiGM0SrVur7ms?=
 =?us-ascii?Q?boP0LTye+eWUy2zRuH5+Umfa+dQ4pwp00U5XnDquBrHsPRC4yV4QdKrbSds5?=
 =?us-ascii?Q?xYG91+/DS4T5qqfdphIcyIWWKMDscWUZRKhavQQxy+gus9ZS3X8ID7ch0yK6?=
 =?us-ascii?Q?kb3lu6ya/mXf7+A35jdADLnknJRx1E8BweJpBAPeHYzn+N+HnGiFRATH8vYy?=
 =?us-ascii?Q?szFUjs7lHu/Dm3JZCbJGv5Std0JT1QDDaCMP82YitegQl66mgnMVGgDu9Ixi?=
 =?us-ascii?Q?WfO+NmGTMr93/mmGz6L0zZXg8b5yb+mdRZIM9WL7Nw7AsWqsefgkigZcmD8k?=
 =?us-ascii?Q?aDnxm99Tu4oueaWtoGwcJpePDyk5oEfzWLRUBd6379zyU0uo8LqgD/vd2cxR?=
 =?us-ascii?Q?9OJk+a2C3qik4NeuacbPyCWJ/hjv6AyhIYdzOD9T8fQIgVuZ2d6pD1pZ7Axw?=
 =?us-ascii?Q?nQBNkaRWZA9ElBt6CCAWocT0dzxKhrWxvt6Pb3eCap05Y/cTd/fulWlqZIHK?=
 =?us-ascii?Q?/MRWByzXAzMipKWsZo0dGU9dl6n4tt+T2RD2KlXpPUK9qAX5+/Lz209c7Zlw?=
 =?us-ascii?Q?2lbfIvRUMBuonDzMDjsKMZX8TM8b9y8c8Bg9Axkt59RhjSAsbA7tQwPeuinu?=
 =?us-ascii?Q?mzR3IiP/x3E/gL34CRYuEXcBJ8Y14iqu4W2/qYvnrDjsN0KufSXN93bcrS3Q?=
 =?us-ascii?Q?YBq9xo9T0mokshkjkC/DcQ9d9A4mVD6K/OxwY4uVVX7uSDp2Yrcnhps5EN1/?=
 =?us-ascii?Q?qHeEOJS5RA37E6EtXjO+r2olol/HhYgooCZJTrcE820P1ygeRSTPlZbOLGUu?=
 =?us-ascii?Q?0Pm8nYYkpXuGB6dmGKxo2zDZj//6haqtWNgKO+8Ta91FAI3FQFolbZBox+yO?=
 =?us-ascii?Q?FDACsBO05oYVAo9W/VCIRTbizajiArADiH6zpXTygY606HogzyJJa/17yen/?=
 =?us-ascii?Q?cTFthxs2v3zV40GEVdNQfjt91/B5pbVziMnZCLO3Uu4R0jevqSxKihsBeXvo?=
 =?us-ascii?Q?hd803vwjq8rPLskxHrCOjX9A6KckD3aZBFYvVxHZ29GYgX3baLWRSaphljgE?=
 =?us-ascii?Q?l6ujrBsjUCUGuLYJ6jth6iUDZAB1UVhOAAWr4DVHTFMz+d6tL6e+uwiM83lJ?=
 =?us-ascii?Q?aV6nQ6sKe5zS6X0iXLI6MxY5pfBxtgHwfXJs/S/MbNobQjQbqAe0BhyC7TTh?=
 =?us-ascii?Q?85Y1tlaVNoq8+mryg31XfaaRBXmNcdZns83Z0G1pzAOcM0SuIXqzJNa757FV?=
 =?us-ascii?Q?h4PWqNA8jXRoVCi9d08kK33vCDEyfBa2/CJtbSbjaSIqcoYNh3HSoqIe/GUe?=
 =?us-ascii?Q?M1RmqE0TpVR67r39unmdqJ4B/1jNums9cqCbY11QV8w4WqVMKHGMAuOsDr9H?=
 =?us-ascii?Q?G9Tp2hDRjfCgrOiMNfo39XtAjamxoVC0R68Htt8xUviVHudvTKSWOFe0c1Ad?=
 =?us-ascii?Q?3jo2wtXAcuA/EQK6sol0Z99/xQnVj5XlE8H8aSFupqOXQUejk3yRK0fVhksI?=
 =?us-ascii?Q?rTMxqLky84gGzSOmiCzAK9rLnejlzrUj32Ah5XXy9JIUkdsVQto5qUMlJ6AX?=
 =?us-ascii?Q?9OOjFoPu9VyDJa9PPE4pjKswJLrDMfoAike8MMvtlSmClyqaFidYIkApmUuO?=
 =?us-ascii?Q?8RPrS99jp+iDGfjdWPzd1QXPvfjtGHEh3gpkLbETUQk011khOrRoMicSc/FO?=
 =?us-ascii?Q?7ybs6g6HiAxLY8g/PNC4yF8Bl8BagG9zW/w/817M7XNTx0Ydb34wz/BgQABu?=
 =?us-ascii?Q?ENYDtyn195GIeu12MDrm8nxuw2S4E1CwSBkbdLDiarS/epEl+kui?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df536d8-285c-4ace-dd16-08df4106cbe1
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 21:49:15.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzHsWVqgm9VLPu6Cshju7kUwbtTQmiStYf521WmQXDZOV6t1Kv0yx2o967GxQnXIxLeShUAQ+I5Z3+9Hzvy09ZR7tXeIVfiwT0JI75cZbYVfEqINbG8VoS4sI7gT9OUl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9674

On Tue, Nov 03, 2026 at 08:49:47PM -0600, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
>
> SDXI uses a two-level table hierarchy to track contexts. There is a
> single level 2 table per function which enumerates up to 512 level 1
> tables. Each level 1 table enumerates up to 128 contexts.
>
> Allocate and install the L2 table and a single L1 table, enough for
> context IDs 0-127 (i.e. the admin context with reserved id 0, plus 127
> client contexts). For now, to avoid dynamic management of additional
> L1 tables, cap ctl2.max_cxt to 127.
>
> Since the table allocations are devres-managed, there is no
> corresponding cleanup code required.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/device.c | 39 ++++++++++++++++++++++++++++++++++--
>  drivers/dma/sdxi/hw.h     | 50 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/mmio.h   |  3 +++
>  drivers/dma/sdxi/sdxi.h   |  5 +++++
>  4 files changed, 95 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index c03af5833414..baf55f6b6826 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -13,11 +13,13 @@
>  #include <linux/iopoll.h>
>  #include <linux/jiffies.h>
>  #include <linux/limits.h>
> +#include <linux/log2.h>
>  #include <linux/minmax.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/time.h>
>
> +#include "hw.h"
>  #include "mmio.h"
>  #include "sdxi.h"
>
> @@ -284,7 +286,8 @@ static int sdxi_fn_prepare(struct sdxi_dev *sdxi)
>   */
>  static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  {
> -	u64 version, cap0, cap1, ctl2;
> +	u64 version, cap0, cap1, ctl2, cxt_l2, lv01_ptr;
> +	struct sdxi_cxt_L2_ent *L2_ent;
>
>  	version = sdxi_read64(sdxi, SDXI_MMIO_VERSION);
>  	dev_info(sdxi->dev, "SDXI %llu.%llu device found\n",
> @@ -301,7 +304,13 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  	sdxi->max_buffer = FIELD_GET(SDXI_MMIO_CAP1_MAX_BUFFER, cap1);
>  	dma_set_max_seg_size(sdxi->dev,
>  			     min((u64)SZ_2M << sdxi->max_buffer, U32_MAX));
> -	sdxi->max_cxtid = FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1);
> +
> +	/*
> +	 * Constrain the number of client contexts supported by the
> +	 * driver to what fits in a single L1 table.
> +	 */
> +	sdxi->max_cxtid = min(SDXI_L1_TABLE_ENTRIES - 1,
> +			      FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1));
>
>  	/* Apply our configuration. */
>  	ctl2 = FIELD_PREP(SDXI_MMIO_CTL2_MAX_CXT, sdxi->max_cxtid);
> @@ -313,6 +322,32 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  			   FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1));
>  	sdxi_write64(sdxi, SDXI_MMIO_CTL2, ctl2);
>
> +	/* SDXI 1.0 4.1.8.2 Context Level 2 Table Setup */
> +	sdxi->L2_table = dmam_alloc_coherent(sdxi->dev,
> +					     sizeof(*sdxi->L2_table),
> +					     &sdxi->L2_dma, GFP_KERNEL);
> +	if (!sdxi->L2_table)
> +		return -ENOMEM;
> +
> +	cxt_l2 = FIELD_PREP(SDXI_MMIO_CXT_L2_PTR, sdxi->L2_dma >> ilog2(SZ_4K));
> +	sdxi_write64(sdxi, SDXI_MMIO_CXT_L2, cxt_l2);
> +
> +	/* SDXI 1.0 4.1.8.3 Context Level 1 Table Setup */
> +	sdxi->L1_table = dmam_alloc_coherent(sdxi->dev,
> +					     sizeof(*sdxi->L1_table),
> +					     &sdxi->L1_dma, GFP_KERNEL);
> +	if (!sdxi->L1_table)
> +		return -ENOMEM;
> +	/*
> +	 * SDXI 1.0 4.1.8.3.c: Initialize the Context level 2 table to
> +	 * point to the Context Level 1 [table].
> +	 */
> +	L2_ent = &sdxi->L2_table->entry[0];
> +	lv01_ptr = FIELD_PREP(SDXI_CXT_L2_ENT_VL, 1) |
> +		   FIELD_PREP(SDXI_CXT_L2_ENT_LV01_PTR,
> +			      sdxi->L1_dma >> ilog2(SZ_4K));
> +	L2_ent->lv01_ptr = cpu_to_le64(lv01_ptr);
> +
>  	return 0;
>  }
>
> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> new file mode 100644
> index 000000000000..0551c2b52980
> --- /dev/null
> +++ b/drivers/dma/sdxi/hw.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright Advanced Micro Devices, Inc. */
> +
> +/*
> + * Hardware layouts and constants follow SDXI specification names and
> + * definition order. Reserved fields and bits must be zero unless specified
> + * otherwise.
> + */
> +
> +#ifndef DMA_SDXI_HW_H
> +#define DMA_SDXI_HW_H
> +
> +#include <linux/bits.h>
> +#include <linux/build_bug.h>
> +#include <linux/types.h>
> +#include <asm/byteorder.h>
> +
> +/* SDXI 1.0 Table 3-2: Context Level 2 Table Entry (CXT_L2_ENT) */
> +struct sdxi_cxt_L2_ent {
> +	__le64 lv01_ptr;
> +#define SDXI_CXT_L2_ENT_VL       BIT_ULL(0)
> +#define SDXI_CXT_L2_ENT_LV01_PTR GENMASK_ULL(63, 12)
> +} __packed __aligned(8);
> +static_assert(sizeof(struct sdxi_cxt_L2_ent) == 8);
> +
> +/* SDXI 1.0 3.2.1 Context Level 2 Table */
> +#define SDXI_L2_TABLE_ENTRIES 512
> +struct sdxi_cxt_L2_table {
> +	struct sdxi_cxt_L2_ent entry[SDXI_L2_TABLE_ENTRIES];
> +};
> +static_assert(sizeof(struct sdxi_cxt_L2_table) == 4096);
> +
> +/* SDXI 1.0 Table 3-3: Context Level 1 Table Entry (CXT_L1_ENT) */
> +struct sdxi_cxt_L1_ent {
> +	__le64 cxt_ctl_ptr;
> +	__le64 akey_ptr;
> +	__le32 misc0;
> +	__le32 opb_000_enb;
> +	__u8 rsvd_0[8];
> +} __packed __aligned(32);
> +static_assert(sizeof(struct sdxi_cxt_L1_ent) == 32);
> +
> +/* SDXI 1.0 3.2.2 Context Level 1 Table */
> +#define SDXI_L1_TABLE_ENTRIES 128
> +struct sdxi_cxt_L1_table {
> +	struct sdxi_cxt_L1_ent entry[SDXI_L1_TABLE_ENTRIES];
> +};
> +static_assert(sizeof(struct sdxi_cxt_L1_table) == 4096);
> +
> +#endif /* DMA_SDXI_HW_H */
> diff --git a/drivers/dma/sdxi/mmio.h b/drivers/dma/sdxi/mmio.h
> index 7c416de9f874..b040d2283fb2 100644
> --- a/drivers/dma/sdxi/mmio.h
> +++ b/drivers/dma/sdxi/mmio.h
> @@ -68,6 +68,9 @@ enum sdxi_reg {
>  #define SDXI_MMIO_VERSION_MINOR GENMASK_ULL(7, 0)
>  #define SDXI_MMIO_VERSION_MAJOR GENMASK_ULL(23, 16)
>
> +/* SDXI 1.0 Table 9-9: MMIO_CXT_L2 */
> +#define SDXI_MMIO_CXT_L2_PTR GENMASK_ULL(63, 12)
> +
>  /* SDXI 1.0 Table 9-10: MMIO_RKEY */
>  #define SDXI_MMIO_RKEY_EN BIT_ULL(0)
>
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index 7569b8395ce1..856a3838eec3 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -44,6 +44,11 @@ struct sdxi_dev {
>  	u8 max_buffer;			/* Configured log2 buffer size minus 21. */
>  	u32 op_grp_cap;			/* supported operation group cap */
>
> +	struct sdxi_cxt_L2_table *L2_table;
> +	dma_addr_t L2_dma;
> +	struct sdxi_cxt_L1_table *L1_table;
> +	dma_addr_t L1_dma;
> +
>  	bool has_mailbox;
>
>  	const struct sdxi_bus_ops *bus_ops;
>
> --
> 2.56.0
>
>
