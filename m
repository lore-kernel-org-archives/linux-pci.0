Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F2C3BE65E;
	Mon, 23 Mar 2026 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285404; cv=fail; b=KiKtSFljdjQIYsIhMYAH6P5GyUSlATd8ry57TIrdLyAtujB7nuRyy3mF62gZIIeQNS2GKtQu0JkpuvgH1qeGrLcihtT3MWEGhXBqFAYLKVIRzz6RO/2IfBwwhdUoFX9dwJK2sNzLxFsypftU4r430Isp9yMAhb2nv2ZXYoPaPVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285404; c=relaxed/simple;
	bh=SLiK60OhjoXdt8AlOin3ePJtOHyNf67CXReKup2tbew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JtLixQi0+kH4GmgHw/FKknTwny/tFBQgG8/v/1+RRm0Y8et0CloPWklPWo4hOL8UPf8Yrg8JnyknpGAnxQXiXULVbgf06kNpFq12Hna9g974YeSS16ZDjulKfNsUHRmkmxZARz4d68qr7pQaGNeJrxKM+V54lZyZfPLWSznWbNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gEaXOKnM; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gEaXOKnM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDqPLuewjpS1bUOIaMFbuQxZufmKDEz+WWIo5zSEEHL0rBg8GWH8O4mZ2MDDM2ep8KUGVSXBigm1v1iQzyiopK/DTs0V3bkkajezc04RDbtwC7IDnVYiyGvwWuHMzu0Nq1mRIX0IzHq17r3Lu2xeaKhUuiFZ3pcK5m4P2ePGot27YFZMffEsq5D/El8th7wupI+ZiJeZxMyoUubUuC4xazk1TD1gr19ljS+c6WHVcRCPRnBmXC/d+SEsWoQFyAtyWaPv8O4Fa8aMwSoGcGIl/FvOQjOBFKobxh8+ZJGtEN06FG43s16dcBBlfjbG5NrUPnhD2X/06gS1rrIAYmQWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcqVYHZOBi4BNirAinZQvzIa0RQ1A0wnMI3vJXdz6Fo=;
 b=gv8YCaKMFfAJd3F4pW1FsMzXWrVxRGGevorJ2i+U7ry4Eak289YG0RDb1AAovsmZ3ajDgJDgwzZAn3MRfHbWlpk0JVNy6XPIBQ1AVvi+LuZMP+/pgg/rOnkvA5wcO9Tkg+WcZYkaEXi6I2B74hZU/UCl/h/c3mwodKuQbIKEEfp8l3p/UZCfIH60xRpkC4HukOxGKvCIPqkEJa6uQ/MJdyCqI5YmF/oOycj5K/a277lq4waS2lRMlMx3KcqzdQfvjQnbR4iZcu4KHCYDWvbOTfyMjP4lh83zWrWzZnJuReYULFBkHx463aen9S0tllGJoOZ6yHeN+rt0Va2/6c3kBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcqVYHZOBi4BNirAinZQvzIa0RQ1A0wnMI3vJXdz6Fo=;
 b=gEaXOKnM3ixhIZ4mmn4QIUu8qdGNSz1G6FewmXEgK350hcRvWSBZOeouszNbNbwKLBT1BwloE/rGA4JiO412KV58/KUIaDV0agnLvVvXmnPC4JEkdNzLIz+4PHsJQ+f0E6hxccXR5Y74CWXGH9YXFo+PlXhVSwIK8Qus0qoetaq19xkW0EMezE9Hh6jZxH/S8zGWTLmIwR/qHcBthjmMhRAgzgv8ihlLEELAfl3PfHWNvzRyaKph+4ZGwhxT9zmdo3T0q1/vlgpgcGPqcCPsFNa9f6+pQSf6ijrr4Q+w6tqdFBZ2tnGYk0DELbmhW4rSHA95JjwhaSpEZ0X0dpWIsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 17:02:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 17:03:13 +0000
Date: Mon, 23 Mar 2026 13:03:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] misc: pci_endpoint_test: Handle -ENOSPC in
 subrange mapping test case
Message-ID: <acFyT6YWZ_JmWxWO@lizhi-Precision-Tower-5810>
References: <20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com>
 <20260323-skip-bar_subrange-tests-if-enospc-v3-2-4780f296a5b4@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-skip-bar_subrange-tests-if-enospc-v3-2-4780f296a5b4@foss.st.com>
X-ClientProxiedBy: PH1PEPF0001330E.namprd07.prod.outlook.com
 (2603:10b6:518:1::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a5b90e-cbb5-4a4c-657f-08de88fe115d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|38350700014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jl2H5wmVFyaaZAh+aCtxzdTOayg3BAeHH8Duk4GbBdom1fUMGUasLvaNXzzB/8s+cS1AKnI6hUV/3RPVnYT6rJ7SSMGQ5bBxdf3DyHIOrW6GQbvU6P44hm66ByeSA1GVwg2YAupsqM5qaFeJKuKAxZmtak3ftVJfM2fp/Kmt6tff4FFRsaOvFcvg1BwgkmNbodlgit29QlW+9awZsAqRFY4KHhAOO65pG03pnxSMtvoZTEPpdu/OCgJOWmy0xy7aIOw6ZXml9airaEOsClpURTLldfwBSF1sFD2JwKJK7dZsyMDb66RNsb3rv7Vuq9VrM/DtLyylexxxeruH0CCnHKisnCIhBT/zv6vdETqRGi12oG3sIxqiVNV8aFk105bFIYXKZJpCXbzLVYzSq6pbAuYtoPOi6MAcXTOxfTmWlEJVvAV3zjsnT1auco9AWDWa8jAbEgnOEHP6ly4njh87vvqJ/wb7KptOy8R1eECBTSDhTUjMwnjRwOdYzj4Dew21dkWMCi9F11x2i753veG9FWy7Fh9ukysbuZM9L43L9L7RZ0SPPakabIM6pODtE+jMo7+a8k7MWYuhxTdbyssIxWImTdybBhKga+aJTWNTV4PXnGO5fyOD3OfEivwoUm1xpJk3Bzzw4ENmOgV2OA2NSNoGrSZG9+za3A9RvWno025hO43Ga+lTDeMKytml8JS9rTFsQyTubES7EfFRjrzUl2FpNsek2W7aeUSrgVfdW95eXTOKfSSG0TmVKlPxUNtm3xYZP6zEpNWyYdplmWhaRPgc1FWgy5HJzj3euAba7DQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(38350700014)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q5zlGMEAFLETBMMRSKwaw030LYILiokPZuPcikG3Wur69BT3f9o9tAh72xmC?=
 =?us-ascii?Q?eCezz07BiZJY/jKePadULZgTiY4hNytdFzhvN3/b3p4fKaDCHaR5l/HjJ7TF?=
 =?us-ascii?Q?Q0gwhk4Ii70yodr2NLA7aCR9YtmNyvTx/wAlX8R+V/F2+qoa7l3UJCofbyXl?=
 =?us-ascii?Q?w6ki7ZJn2VJ8GRZHNecAHLTrJb1WHafyMejzjN5x2POkq5aWHgG8YWvCdJYp?=
 =?us-ascii?Q?Ui54K4OTcCcPNtZSOtxhtpfp6TdvgJjp1znL1J0knFu8s10t/hUCzQiimruO?=
 =?us-ascii?Q?BRaGjKBqkd8GdwB5zGUP8f4nmXxXu+Sipwitz5Dm+s3ywmRFfPhY+2/3RHSy?=
 =?us-ascii?Q?UnwOhm7C3EpytCj4Fw9UEmqrLexUQz0dNykcAR4MPbjnkhTANb88Jzege2kW?=
 =?us-ascii?Q?1PyeL66rp07ad2TgRasPwAXLgD3t5xSIicAESPh8u0VO8+WExy+g7DFSXugv?=
 =?us-ascii?Q?MTc1TSHh/kJO6VPHebZtnKH3ySuz+BAGeZSiOqBk4YWpbhPzhGLawqV2+lv9?=
 =?us-ascii?Q?iUQvIj1gTZGZU3W/mexQhq+lH56zPkTU1b+jupbytCyxoGYWDKbdsk6Baq0E?=
 =?us-ascii?Q?kisK3YdeVnVqI48cwPkQEBKUgw79Ffx9HJgeAtodFr0uuAb5ZuuFWCiYTX4l?=
 =?us-ascii?Q?fbRYR9APC2rmKVcFc2XzxPZcwFjo5Nf04iVD8zzvk80kCoHYduzDALLsAhnl?=
 =?us-ascii?Q?ykA7yrEFcW6LAAR5OdUbyQ4ceh2nzvq2vHfbBrmN2PFFilCc2B6h3zHLKHT2?=
 =?us-ascii?Q?vG981ux3u/B0cMy5T5J0UUj4ZP2JFDDd/oogdxzwqEqwj//ZB7jqRv/Ll6Ku?=
 =?us-ascii?Q?Y5BiYVDOPNiL0wl/WRlBqmXn3qGS8Kn/sBF2+Nu6umpsH06ZmAqV0qDX0kxV?=
 =?us-ascii?Q?yldF3PSznJY0LTjInw7+ZeML4CfKyCJYy7iScIekeImbsmFHJzxb47T2FFa+?=
 =?us-ascii?Q?Ce26XKgAmFzlKnR1Qm11QKRSxsMxsFPWabyN6JJg4q9MzQlJF1w9pWjrX/bN?=
 =?us-ascii?Q?UoZHOd9ff85fHcB3pOyfeFCptCvaCPe7mWSIhxe5p99rGziaRtcDmptlOt2f?=
 =?us-ascii?Q?NBspdNlkrSRzhIFvhpUCVdBl2G5FSS7xJcgJhD8ksnOuoaMSZmbzNDszgVR4?=
 =?us-ascii?Q?Nx+Owd8ZCicXzxyZWMP3d8u6M/iBOfEcW9H+KTvDb2VOyQkdwU0xAPpaae9L?=
 =?us-ascii?Q?l7g7M9ww7aTU1w1hRE4SVaG2wxBuFWsuWKBmLP/K3IAWs7Mu1pGcnZoqJaVB?=
 =?us-ascii?Q?jhrpC9DT7ayTO8+hJDKYGBzCCfxyo8v6s0lNFl7YjjGuMwxoESuWPYIqV3HG?=
 =?us-ascii?Q?/9yI77qjbZS+pfeZI1HWqid1qXiE4I7I9OUPfUtWxNkz3WjKy88GMSwHv80u?=
 =?us-ascii?Q?v+1fEB9DVM2ouOqFEiWGjC9Ib3XcIfIsYRGUU+wIFKZj6KWWiUm6gRiwjtD0?=
 =?us-ascii?Q?pexzMNbZ2xZ74j/fjJ/pHp0JucfyUidEYXHag/DxKGh3StWUgoltuPv46Gtg?=
 =?us-ascii?Q?U5Ju9G+8D/BQWFfYag2vGYgMnVozmyNYtO4lLeKr1zghDMeymMIQoR90JSrh?=
 =?us-ascii?Q?y4HzB+6mC+lQRyH34csA/AfTgWj57HOJ5CnPhFf36lqDnrn+ANhrN6mT27BD?=
 =?us-ascii?Q?tWoyZOjYGhqR2x41cDIxY3Gbx1esx8oE/yzo9AaT6FzS+IG7QC6MSZBXuitc?=
 =?us-ascii?Q?EyIGzYmF7cxkCtTdO4E2unDA9KdnRMKaMgQHN9eUn4IxWMrS0Y2yrmhMd6sE?=
 =?us-ascii?Q?XfQYkIpiSQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a5b90e-cbb5-4a4c-657f-08de88fe115d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:03:13.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vuew15e2QLCeK9Vn8FVQo+7QG+7HsWdmmQMB0JHNjj8YKY+N3idR5ELQ53cfHhtSQaKcFTlcPYxXW15+tX1NuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

On Mon, Mar 23, 2026 at 12:59:28PM +0100, Christian Bruel wrote:
> Return -ENOSPC when the status reports the STATUS_NO_RESOURCE bit.
> This signifies to the pci_endpoint test to skip this test.
>
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 55e128ed82f00ae13b6fe9768cdbe56adbe8f9da..202196adf8ad84106ab3cf72016fa791a74697ee 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -61,6 +61,7 @@
>  #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
>  #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
>  #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
> +#define STATUS_NO_RESOURCE			BIT(18)
>
>  #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
>  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
> @@ -477,7 +478,7 @@ static int pci_endpoint_test_bar_subrange_cmd(struct pci_endpoint_test *test,
>
>  	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
>  	if (status & fail_bit)
> -		return -EIO;
> +		return (status & STATUS_NO_RESOURCE) ? -ENOSPC : -EIO;
>
>  	if (!(status & ok_bit))
>  		return -EIO;
>
> --
> 2.34.1
>
