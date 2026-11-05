Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793901613;
	b=PhgctDeOro9Y67mDedY9bxNhQnzHjTVk5KQiqdglRaxuHRj0zc2176NxuER5/OsoeRl+
	 UaOYTTa9hDuY0oo8VgWBoo5PYhcCiRVsuPldVlEIXFLtZ6WfjTfFoi+lpRmHC9gZSxoh6
	 cRoFlxzr83RDIDkKKrVHXBQeRdHXOPGeVhf+ZOBBSByW7sGpbRoXuINbM+WpqG+764gfv
	 3vknX2Cplt3gxHerXYZbk+JYvUYcb+DaHydyOnmR9oWwMoIzR50fKsaPLm7+0HxGUNcxk
	 cR8HWU8x1yKN8x9bFjrxcYHYe92tTI65ZgLMtXSqrBpi7bO3y2UODNBu6sWOxc8JYuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901613;
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
	bh=yGKOfpSmcFqqpa0WUbEL81vEaCzd49tUZuNo7w4tmIM=;
	b=ko8cJSXH5FY5hmyNygyTGwYeqs8+306Mo48hM/GHSVsg/jdKX2dBFXSBhEL1+h0O5cS9
	 qAc1cG/X42zH6vIUv11YIABPZkP9R8a9DVEwPZb6ew/ARuAgNspgeWLAiVyjvIWdP/3KM
	 pV9Qr6P5L+HLiitquFP9Aq9HHz3Y3PzhQ1JOeei8+qoRAT1bB2lx17UreRUK5KRCbu4EB
	 kUUUuP00JJXS6K5FbFJodKZ8EcVHSvHp2p7A+iwMIcYFpgew0TM/1OKz4mlE4Wt+cDj9r
	 ztFzpCnpU9IQ91qgNdvegcWzo7kOWTxSn3h4aENkdFqXgNwC4NoyQQnppM+cy+rB0Xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Le7oGJp2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.2
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD4606D809;
	Thu,  5 Nov 2026 18:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBFD4606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Le7oGJp2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTHgeig3R6yxy7SrmI1276oUPGKucZygf477OtPM0TPElH4M6SRbriTmWB3WsAwG2BNjTdJI0ZbuGRLXsVdzAkpMhCLUeJT4a9tkwkBEhIM65QBbEJjaFPoUJcK4VnNVn7NHeGb665XIo2IinOMQp1RXXqbpi+xvEeDtscDrJ8+bZNnwqaQ+NLDv6dOUgJr5mWxQnR8UqAdC7nxehlVURfin2NkfDK8P79Ujt6pqhN8W8WpoKM4Ey+RzVOLY9HKyYWbqqSLRqurFSLojOldpSFn9PAI500DtmR/XVnYFEnwdjMrmDnNhk/YLrxhvdGLyNG8dMWIv62ldpbQ0SmGjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGKOfpSmcFqqpa0WUbEL81vEaCzd49tUZuNo7w4tmIM=;
 b=KT5tNbgkXfaf7tZ0Izw2iQeuA1StWs0vu04maBNVQFgEbnYh0HCWmZU5m2kr2mKCTyGrP/gjONdnX+Dq1cwSStnm6HPRcQUp0it7SSelhVGM8W7CuEtNY8u93uYYSPCKPBYCteR2ji20f6us3NwZTO6eQkRTSf6G9mCVPk1EBlUwOSmDSQdgvqW6FoePVxK7yhQTA2xdvdf5iChaHX7WJh7iuxbXUIhXCTVtJKExbCDr0Wk+H/HHw3PXE4FUWYRgEFFpVem6J1KJeBonCl1QbL3QcLLNDdNRYX24mK4lzG3pPQhID8J2EtWg4Ih6KMe+/PNFw00WeUcRPTSkOBiUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGKOfpSmcFqqpa0WUbEL81vEaCzd49tUZuNo7w4tmIM=;
 b=Le7oGJp2oLKaVoHbNXu3wmxenFhBPCxy1pv9RdsnjO8e2jcrJL4BQ99RvF1oqjkFW6710jsS2fMxgWSerQhFJzJPJO+FvjNtacR3nJWWAzH1mXuUVjoMqUxsPobYeSs0LGkvio/EzhIGChSdTVO0woR/CVhoIU7IiHzctfePJj1PdbcT7p1L1wliFZVkCSPlZjEb/7Fvllfx+/iQ4pDH9QTliX2+dECmaup5pWlfRtIwEodxUadB11bZVUeH19/r99UloyXXvtVjGQjumR3LhDl4D/Ezl99wmAlNYDCz1I3Atw0ywPmxMa8oZm5f3Qa0woNdHjw8hnXVyixjO49iHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI1PR04MB9858.eurprd04.prod.outlook.com (2603:10a6:800:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:00:08 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 18:00:08 +0000
Date: Thu, 5 Nov 2026 11:59:55 -0600
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
Subject: Re: [PATCH v4 03/25] dmaengine: sdxi: Add PCI initialization
Message-ID: <auzEG0jcbuzxTG_Q@SMW015318>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-3-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-3-3668ccc7aab8@amd.com>
X-ClientProxiedBy: PH0PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:510:5::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI1PR04MB9858:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a5776e-b328-4a8c-eeee-08df3b66a10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|56012099006|11063799006|261026121527099003|261026140227099003|4143699003|261009221227099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261028144727099003|261102130727099003|261009223027099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	iwV4mQv/pvS6bNELtbPaHvTD2bi5tNfKuJdO9qxPQ3F/n9poMaBTouW1nKjbZHXXM0HibEJ4D4KH0nBO/AbyLw5EnwLpHWPP0GOaB8s0D6RVq+fjIH965lfGnW5LzjwMeqTdl4smtaf/t3GmYPC7Kh0sK3nzAH44d8pRLJQBi3Zs5KY0YBfYfN5g47gSuahaPi1edIHIUWq5afEM0olE7+HyHDOGtrrEEeKH9/ABEuHw4PRfFeEmvKeU3E+lg2lDyJe7HNuWRA1QVBbjlJTHp/01//ICN1IezWC04/zBctA4B0MJHUVSnhIkCyoPR2eat2i9qUvNP9g4QbVGBkisnPqIbIMkva4eaTT24oEQT3T7A80msOHPWlKVaU/AOhehjaElxZKGZj43/OF5tTAh86+x66ZaOReE8PWQf8Eq4OBj6PKPFaKQ9TWQi9djZYlxlG35J/0k2/0SLjD0bX3OJ3p1QXBx8wLpm2agQDSGhE44WBbSWdWzo3tjQMXHN8Waq/GLYFYNSNYT2Vgb6BMOeZSE4jyatK8BJ5/2TNHEgU1rcX0OYeTZFByKIsiJN+AXftodc++eFODhyzlpNOxPOWbz8itJLUfYNGFMnEaPjUjsGq2bm6dtrnY+CraXbA7M6D9Spgnk3kQcBctC6MD+2YVEjzrpxmL0ZGdRxfFMkMI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(4143699003)(261009221227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261028144727099003)(261102130727099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s3HP+FDMTMvnAS/xqHi7fCa6tvY7yK09mfaYXeZuDEMlmyPqOvJzxhxypf+g?=
 =?us-ascii?Q?D2C+2eJh6NORT+gkZ0LNo6hjgg2AxbVnB2nDANxcfN9i2wqSaWQKjzX0mQqd?=
 =?us-ascii?Q?X0fppZzWC1o/OHU4gbBPi8/KRZtdnyly9gzsdqpJTVb524mzeB30K7cY6ifQ?=
 =?us-ascii?Q?AQsTByyGWDXiTCF/9l+D+FopuzUxmmv3ZAEEoiUWFpUGCYuIGxoDQCnmfIml?=
 =?us-ascii?Q?WE0jSjWOahPkIKVAj9UOpnk5ukujw+3N4uWn41WEyU4gSg3rj2G/A/1057pT?=
 =?us-ascii?Q?FTPktAS7kThb/fGvFerSrnp1tzdENmoksTeNUaKd9Jp3KxvOSub+wh4tsLnh?=
 =?us-ascii?Q?3A0mn4Ls7F6s8FRu9CnPEaFaKY8pJfIm3TC5XJfE4taqCjm8cU7Two+msoc8?=
 =?us-ascii?Q?6rVKEvrCAJHboZsxOnLdh1t1GjyuJve5xdwkOngprXpBGsnlBb/Inpgpvv+p?=
 =?us-ascii?Q?WjIzhKxzPw+Ur1U0xWU7ULF+wMY6eNJwP/cT8DbhbFNJ68l41v5pV6wkDmkX?=
 =?us-ascii?Q?nTz5WiOLcHVvV+ab9Jio+J4Wot54tcFIso3PTVycU3ZeeFbk/gWe9ACeBQuf?=
 =?us-ascii?Q?GcBi9tZ+BXnUXGmopoEnuajACe4+mOx8BRuY7sNt9Ut5dmZ6cm9Y5HLlY3On?=
 =?us-ascii?Q?E6BxXMYVofKnv7bvbfLwWLU5vMGOJ7VdT1T5gIpmxltJdaTN8SP47ZNAEm0z?=
 =?us-ascii?Q?EYgVeuMhYz+PM/YIGq8FJAHPL9IVJc7W5nkGTC4ysOHUEKDok3MRR8UW39g2?=
 =?us-ascii?Q?SDe3PGdAbmM03EBZn1jzpwYFRz6c/QOZ562g0GvMwj+Q2KO3VH8h/V9JTIQ7?=
 =?us-ascii?Q?js9QtU/YDIOh6LpkcJL9I+90vj8YEQ9EdSxQsrYQAp1+fmk+EuhVJHYVMQ4I?=
 =?us-ascii?Q?6f9wwi7c9zZZ7maaogEoNgFBPH6sixcx+lSewylaBuy2F3RvJWxeZUhbqxks?=
 =?us-ascii?Q?GuDmEQR08djmTFoX+X3p6DFOp058RdhXaskmoWQ7WvIeVOKlC0Q0d9HDoW4Z?=
 =?us-ascii?Q?lEMhbKqtpomIzSxQRoFTtzyB8O3IJdhEBsVY+jRwt/NY6QCHxv+SK4HVgRgm?=
 =?us-ascii?Q?auxS1axOne+qzQC5U7MlXlntl0N92/nMAOBzVkK7+3fE8ODJ0SxuiDzXvzhD?=
 =?us-ascii?Q?3fJ6vEb1l6yQIQC8Ry7kBYzywuUNG2AdpCtnZdtts0QHFw/o9QbXHeQus+Rp?=
 =?us-ascii?Q?LDAATHUfQIHk5uhpcVArJKNoAACM+/C8OK5XUGAbks1RQWFJ1xu/J0QS0SD7?=
 =?us-ascii?Q?I7JsoG6ypjNL7UKMgxXmcn9Dgb4tqLL8F3EM5maRrGFt5xsFqs3EowmH0ZXg?=
 =?us-ascii?Q?PrN5u1/znwDScbwv3Och8JJpn9zr9evypUWA0wXcKJIfqFNZh8YtXZnF36Gj?=
 =?us-ascii?Q?r4DaZml0k4Gd/QDzht5vwakjxbXLqqiwcS5MOGQdiJQn+0JSHFkOML6S9vwN?=
 =?us-ascii?Q?8iZKUF7A77aOG4wab/e6dkCInJa9m8653CMrFCkMawRwLF771Sics1kVJ3rl?=
 =?us-ascii?Q?W2B2dOz1OaKEXARUkwzpmPlKIWaJJaTNHIyl5tYFg0ZPsvml4RfjVwUrRJ0X?=
 =?us-ascii?Q?7qG698BTlzwZadOrb2KogUZzi+kUWvdkommAu819wm76zgFGFLsUjaKTo6F1?=
 =?us-ascii?Q?gPdDUsJoTr2NyjdTElUipG+h2zSerC4VjCGHpIGVh2m2Gmgh7lCdPJjX/Yqh?=
 =?us-ascii?Q?3Y6oEmZGrpkcFaoziwCr2B96v5MUcoCqIbtfm0HxzYTUKtB5McnmUmFMW/tB?=
 =?us-ascii?Q?/Seqdx1/TtFmTeS+gX0gnsSa6j7oYR4Xr/F1zXLIGdNeSeUeb9xZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a5776e-b328-4a8c-eeee-08df3b66a10c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:00:08.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BB8qb/JZUvYnXcP6Hf/+24S6d3rLNttUnyfOnVG2tySltdILproCwoaO4C+ihxgm8ssKHIcFWUcwgNr7w6IYsJUwfupb64iRtjyPwzvjnVLZkozvuT0uRj87caN52PsC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9858

On Tue, Nov 03, 2026 at 08:49:44PM -0600, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
>
> Add enough code to bind a SDXI device via the class code and map its
> control registers and doorbell region.
>
> Keep PCI resource setup in pci.c and register devices with the SDXI core
> through bus operations.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/Kconfig       |   2 +
>  drivers/dma/Makefile      |   1 +
>  drivers/dma/sdxi/Kconfig  |  28 +++++++++++++
>  drivers/dma/sdxi/Makefile |   6 +++
>  drivers/dma/sdxi/device.c |  33 +++++++++++++++
>  drivers/dma/sdxi/mmio.h   |  22 ++++++++++
>  drivers/dma/sdxi/pci.c    | 100 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/sdxi.h   |  38 ++++++++++++++++++
>  8 files changed, 230 insertions(+)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 01f96a8257e5..3e3b685895fd 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -772,6 +772,8 @@ source "drivers/dma/lgm/Kconfig"
>
>  source "drivers/dma/loongson/Kconfig"
>
> +source "drivers/dma/sdxi/Kconfig"
> +
>  source "drivers/dma/stm32/Kconfig"
>
>  # clients
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index f62d12b08e15..b375f9df9588 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
>  obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
>  obj-$(CONFIG_INTEL_LDMA) += lgm/
> +obj-$(CONFIG_SDXI_CORE) += sdxi/
>
>  obj-y += amd/
>  obj-y += loongson/
> diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
> new file mode 100644
> index 000000000000..b91b44231a04
> --- /dev/null
> +++ b/drivers/dma/sdxi/Kconfig
> @@ -0,0 +1,28 @@
> +config SDXI_CORE
> +	tristate "SDXI (Smart Data Accelerator Interface) support"
> +	# Doorbell updates require naturally-aligned 64-bit writes, per
> +	# SDXI 1.0 9 MMIO Control Registers.

why comments here? is it related config ?

> +	depends on 64BIT
> +	select DMA_ENGINE
> +	help
> +	  Enable support for Smart Data Accelerator Interface (SDXI)
> +	  Platform Data Mover devices. SDXI is a vendor-neutral
> +	  standard for a memory-to-memory data mover and acceleration
> +	  interface.
> +
> +	  This option is automatically selected by the SDXI PCI driver.
> +	  Enable it manually if you want to build the SDXI core for unit
> +	  testing without enabling the PCI driver.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be named "sdxi-core".
> +
> +config SDXI_PCI
> +	tristate "SDXI (Smart Data Accelerator Interface) PCI driver"
> +	depends on PCI_MSI && 64BIT
> +	select SDXI_CORE
> +	help
> +	  Enable support for PCI-hosted SDXI devices.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be named "sdxi-pci".
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> new file mode 100644
> index 000000000000..0006edf74d86
> --- /dev/null
> +++ b/drivers/dma/sdxi/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_SDXI_CORE) += sdxi-core.o
> +sdxi-core-y := device.o
> +
> +obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
> +sdxi-pci-y := pci.o
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> new file mode 100644
> index 000000000000..0974a83bb45c
> --- /dev/null
> +++ b/drivers/dma/sdxi/device.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI hardware device driver
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/slab.h>
> +
> +#include "sdxi.h"
> +
> +int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
> +{
> +	struct sdxi_dev *sdxi;
> +
> +	sdxi = devm_kzalloc(dev, sizeof(*sdxi), GFP_KERNEL);
> +	if (!sdxi)
> +		return -ENOMEM;
> +
> +	sdxi->dev = dev;
> +	sdxi->bus_ops = ops;
> +	dev_set_drvdata(dev, sdxi);
> +
> +	return sdxi->bus_ops->init(sdxi);
> +}
> +EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
> +
> +MODULE_AUTHOR("Wei Huang");
> +MODULE_AUTHOR("Nathan Lynch");
> +MODULE_DESCRIPTION("SDXI core");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/dma/sdxi/mmio.h b/drivers/dma/sdxi/mmio.h
> new file mode 100644
> index 000000000000..2676736f3998
> --- /dev/null
> +++ b/drivers/dma/sdxi/mmio.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +/*
> + * SDXI MMIO register offsets and layouts.
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef DMA_SDXI_MMIO_H
> +#define DMA_SDXI_MMIO_H
> +
> +#include <linux/bits.h>
> +
> +enum sdxi_reg {
> +	/* SDXI 1.0 9.1 General Control and Status Registers */
> +	SDXI_MMIO_CAP1       = 0x00208,
> +};
> +
> +/* SDXI 1.0 Table 9-7: MMIO_CAP1 */
> +#define SDXI_MMIO_CAP1_MMIO64 BIT_ULL(6)
> +
> +#endif  /* DMA_SDXI_MMIO_H */
> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> new file mode 100644
> index 000000000000..0778cde31f14
> --- /dev/null
> +++ b/drivers/dma/sdxi/pci.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI PCI device code
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/dev_printk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iomap.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "mmio.h"
> +#include "sdxi.h"
> +
> +enum sdxi_mmio_bars {
> +	SDXI_PCI_BAR_CTL_REGS = 0,
> +	SDXI_PCI_BAR_DOORBELL = 2,
> +};
> +
> +static struct pci_dev *sdxi_to_pci_dev(const struct sdxi_dev *sdxi)
> +{
> +	return to_pci_dev(sdxi->dev);
> +}
> +
> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
> +{
> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
> +	struct device *dev = &pdev->dev;
> +	u64 cap1;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable device\n");
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set DMA mask\n");
> +
> +	sdxi->ctrl_regs = pcim_iomap_region(pdev, SDXI_PCI_BAR_CTL_REGS,
> +					    KBUILD_MODNAME);
> +	if (IS_ERR(sdxi->ctrl_regs))
> +		return dev_err_probe(dev, PTR_ERR(sdxi->ctrl_regs),
> +				     "failed to map control registers\n");
> +
> +	cap1 = readq(sdxi->ctrl_regs + SDXI_MMIO_CAP1);
> +	if (!FIELD_GET(SDXI_MMIO_CAP1_MMIO64, cap1))
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "64-bit atomic MMIO access required\n");
> +
> +	sdxi->dbs = pcim_iomap_region(pdev, SDXI_PCI_BAR_DOORBELL,
> +				      KBUILD_MODNAME);
> +	if (IS_ERR(sdxi->dbs))
> +		return dev_err_probe(dev, PTR_ERR(sdxi->dbs),
> +				     "failed to map doorbell region\n");
> +
> +	pci_set_master(pdev);

Add empty line here.


Frank
