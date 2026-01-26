Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719B344D8E;
	Mon, 26 Jan 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449793; cv=fail; b=F+Zczq9l/FqbXODzEaxh7dViWDUflNBYlNE8Z2YVk3hgaxEh2P2B2lJ3EINn45QJ+TuUGbCX1SG7CGT8Wu7+JyCnfk1YCJgX0q2HQG9SrsHty4nH6wneItETfSyA99QeiPAfV7zAlR3dQnfnxWUTaC35+boRoMN/Y9unw1SmO5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449793; c=relaxed/simple;
	bh=Ju2hUIpcLgGILM7lkF3zFL0ktYp99eyP61CPKGttgY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZL8dCQFNe5Nk5OKbnVETqOIaMoLq2Ese+iFJ94pV8yIT+7EWoTtb+fdkSfqgJEF8rHYs0FQ2M4QZR1Y8Bw8bp2BDZCAZrqjccTU5Z7df9U7tMrxqrNjHVkpOuE8P1PA7U9gmS5IjiKkwjHdKM3V45nIXPBCoba7xQiEC+3nOWoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sj2JDsBQ; arc=fail smtp.client-ip=52.101.83.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sj2JDsBQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5ioW9aOhtplDbKDCbYPxydKHzqIX4xjAEWk0kicyP3BcDhp89Vz9LPMzi0o3aahXavdWGoJiponOHBeNTxTLgCvRx9egmx91xgR4Q/XKt3ibOrKsxvgVzkBVa3MshmdE2Yjru+tbFF1C8Fin6qhxxI8kKOZp1sHoBqEut/CMd2NqEVYgG4py37El0CSQaMfaj2sqN6MtiwhlB7HgY++SLnxhExWbjIEaFyavVKSW/ZyCQY26Xi9fLr8KWwHUqdYpcx3H/xNa58X8+2ayt7AAZcRf5kIS7FV3m+U8subVBig6YxFRF8+0cbrzw2rPjJWN2sVL5swXdbsO8VvKwaRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQxarEQnATFJDykVCV7vIQFPjE/G8DbJxNyaID9eh/Y=;
 b=sygGz88PH0K7r4hABJlm2O4ROUHtLKcG29Sako0lR4zPx3lZ1WGOYtPY9jQ38T+5I4MrDLP9N90Hob1vm8JvRxGbOLu83ofe9FfjS8dewot/xmoYPv+jSPJodJApi8Xgq/8gflrJ4WDxefOEKcvsojsnd53pp1Q4nLMO0OG+izuHTcIxdVlS1DKBFC0eHGZe/44Ji5FvB4sSgh8HwymcyzdkGGx4aRtwXrwS+7p8E7YLSclLAV7tdu88xNxjcTDvcF0u/zKNAvaruiUjbW3Px6cCGx2eYVqTKwki3qT69CG/ow1Jh/cI0tIk8x9q1rDBJ+ckYYFKxoHFgt/HVTEMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQxarEQnATFJDykVCV7vIQFPjE/G8DbJxNyaID9eh/Y=;
 b=Sj2JDsBQYnPLj2WZVQBZDyGGi6n5lYCtZ2BmUsdtf4YYj3Utla7mT/cNHR2PaLNVCdA1qFqdtbvj0lhNZe1P3dIH1pJlhvoBQC24k2zglOOjiW5XBUsedrHCkTebWQ4BTKG/blHkc1mof/0z77BPtoY/y87RJz1f07BGs98/VOW1dpRP3BCpd3pAjvhS+m9/vlGos5u6m9XOWkE9vtrUZUe4CrFi4PhoWTTn4HUH2aa0nFgkqwmmmxxZgXj2uB0aEkZ/hxP64msbY93oDs++eUxZK2hVOXdZuY8MTHy1rVhd/eA8vtri2ETTb9XVg+SiBi9C9uK7tIbKQ5f93YS7oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB11558.eurprd04.prod.outlook.com (2603:10a6:10:60c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 17:49:49 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Mon, 26 Jan 2026
 17:49:49 +0000
Date: Mon, 26 Jan 2026 12:49:39 -0500
From: Frank Li <Frank.li@nxp.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Trent Piepho <tpiepho@impinj.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Fix device node reference leak in
 imx_pcie_probe()
Message-ID: <aXepMzJJXRz9G2rf@lizhi-Precision-Tower-5810>
References: <20260124-pci_imx6-v2-1-acb8d5187683@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124-pci_imx6-v2-1-acb8d5187683@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB11558:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fa414c-08e4-434f-991c-08de5d034cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S/AwcNvCHXQoU7ZYx6MzptmkjEPgLNH9hVPzi23o3hSaqsK+p/sEwOGB9Xaa?=
 =?us-ascii?Q?RaCdhbH2Mynx8ctrX71riY7DfxwmDJcMObIfPuS37dbOn+kG/IIYXMZRo4tq?=
 =?us-ascii?Q?//1lkZiQXOxW0lKNwwtccQ8BzQ/N7Qk+l/kx6p0tVLi7oSlsbGMSOL8NLVJh?=
 =?us-ascii?Q?7ufR1rbZYjmuyX+yp0QLwp5DUXtJqoWsQGuXWwv+RwFpamqbmAF30S8FTsRl?=
 =?us-ascii?Q?TrHIJdtTCo3lxG7b26+TWMiMn8mjM5XypYxrv5CBXKR+8gpHLJJDBQB58OEF?=
 =?us-ascii?Q?UKaGhoKxt1TpMBQCDxYI4EuWJllz4YbyE5javdRnxqwV8E54dY03SKfoHM7Q?=
 =?us-ascii?Q?0HRFoYzvZWgjzEQjwoUOU9sApS2DcdaInCMcXQa3ok+jo+gxSPJI5k0hdoCd?=
 =?us-ascii?Q?U4BUG6o52dqdVnAd/FTuW3Q6NJBpsfrtxoeFyog1Lvt5Un1cDtxxDMevUIcS?=
 =?us-ascii?Q?Vy4tX51nXo2SN3bm9di2AemIUBBh6CtZxrPaP+GQSjio/Uvc2jTwUdgfo80w?=
 =?us-ascii?Q?IwR5v/2ShjuEhrUy1+oM2ba3wWICMsK8arTiq0C/XeOgeLfif6KEyaIuyQQW?=
 =?us-ascii?Q?fCUKf6J2ZGcT3nAfArOkmtRTUuzQjHYqdHW2YGQqell7qgzY/zJatURlneJK?=
 =?us-ascii?Q?rq5HXml8mtNS9MHQ7KA2Iq89WX+iLJzzQIPkYN/C7w3PPPTFiXawTC3C3C5N?=
 =?us-ascii?Q?e0pwwhktSvloGbUtJBTI95rE+pT1jnn45/f0Ze7NPmFhC1jvm1kq29jJgniZ?=
 =?us-ascii?Q?rSV6bdLYGjuwly13E85po2nyDLZ2GdCqq6xTc/SfV1U1lqfxi2Er6j7mvWVE?=
 =?us-ascii?Q?gz6wI9Kys2E2goYyz+ipGwj2zD9gVeNHgYFOTDJfF9RdMcNlv9KxL0/8RlnU?=
 =?us-ascii?Q?NcXWbZaf+R0/wqaHXBikNWCoCQaUJsB+hhIGQbvG3EajMAhN12Udw3idXrId?=
 =?us-ascii?Q?EQGEouCqwJtb6ZydCTwFOTIIUhQSUDkvADbsEKyy/qQvekOUaGaU6Dz34jZn?=
 =?us-ascii?Q?7GJf9dHZWMtO0ggn51T60wcfrs9xWjCrAtatwNSLFw39EfK3K6JmU4w+O4Uj?=
 =?us-ascii?Q?1Mnylc4y/Z/Zw0PWXcw/igZn/uQROKAHw26RwHkJLuLWOHNv2t85qfiMknzT?=
 =?us-ascii?Q?Csss/9gGx+WaJvsqF+K2RcG9TEh5apz1WuGC4+RMhYBJnFuoqpemUH/LnqgH?=
 =?us-ascii?Q?RKXPx09qub00whAhGl7w84/tW2tQkh7h5UylDKAVKT3A+8pYPPw+xtRpEgPU?=
 =?us-ascii?Q?8Fn632Sklobm3aX4fSHIj2Rj25eTnaEWf2+WgYP15nXXnLlj3qFTTL0coDHx?=
 =?us-ascii?Q?PGUoPr6vSsvgAJBXQo98jntglx2k7Xrh070n6oIRmDKvk3NUM6fmoj8fSSss?=
 =?us-ascii?Q?EKPzkhu9YWsDhhcp+A+iPgkeE13lkOXPE47OpKl+iOm75VI+GZ91TWfEzfOE?=
 =?us-ascii?Q?PExSCc29YCkO6MUwUHLfbNM/KXViubCfleQHtEsNxUJgoze0RnEs3HlADc2K?=
 =?us-ascii?Q?XavrQrpaTX1U54GPR3ZLnfnH1A8mCKnKOruZZBjxLndOTOp5jacc7FDnViXX?=
 =?us-ascii?Q?wTKrOtKtu3YpLklp+QDWBFJTmeJKB22JyVQZuESBtysendjvwdFNkTlZf/rf?=
 =?us-ascii?Q?u7rh//DLsVUCbc0SH7Zj+qE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7416014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qWJ9lIAD3txm9B5H1htFUOmWlwi4y6PwqKw4ykF41v59ass1YfHmcw39lGFU?=
 =?us-ascii?Q?k0FdUFjFIP5CtaSe9YddpfrID9J+/vERqy/4RMkOAgrCQGOAb6tKNPXk9CnS?=
 =?us-ascii?Q?4HlpF5C1f3jNeRTCwpvTXZYMr3J6Jt4kuQt/OCWv1XLnuauEpxtbm+UeY6Rz?=
 =?us-ascii?Q?97LTpVBOp/12vo8GNf6hdlyQZNPIKBfYMRlHWhNQwN9yRCCrOpjmbtPtdt2g?=
 =?us-ascii?Q?7KjC+B/XHrYC98+lgkY7O7CVVehl16uR6jpUdvjfr4sp5cZu7B2VR2Z+MLWj?=
 =?us-ascii?Q?kgjaVcDFY3VbDrkNcuP0nJ7s4lqrcQ9xffJNMwVCuRhGyCHkMTP/Dx+BrSn4?=
 =?us-ascii?Q?09yTTSvEte4JLwVZCY32Gks5wEeZS1owgYFQKEHBAuH17z22k00TcCBT2Ff3?=
 =?us-ascii?Q?S/3uU7cl5KPeXfbsGy7eHB+0ds+hjN1Z8BDVxOCtkfz+eRMRUXp7LG9jIvwZ?=
 =?us-ascii?Q?x/t/5dIUl5+8qz7jwpr9JeQclwCo86o2dSvDHWlakHM2NEOx8oadBYKti6+O?=
 =?us-ascii?Q?Sn0uIweHqJtlPFRYFYr+iTxRjrf9rhQTdsdb4ZMwKXjUPfp61S78grMj6Z7d?=
 =?us-ascii?Q?D28fWjztVKPm7MvF07RC3UxmbU5Eo1Y+W+pKu7XU0/PvMcJLJ3N01o6UXOxy?=
 =?us-ascii?Q?XZuMvyksM9YWuEUzvUMX1vf4n7Z/qaE7niz42AdaW5i7onhqoFWQkfen0kO1?=
 =?us-ascii?Q?0Wjof7YiLtkBkwxXTGGDf7w9o4bLC8NQYiPdalmsp/0bpo2+/YJQDQI8LXYw?=
 =?us-ascii?Q?Y+w1SQ9DlGl8pppGqMkU3t1hAbEarNtF4YOfRILi09qTV08qRNCqvwbHTmiF?=
 =?us-ascii?Q?NnK7X8jLLqmjXIwUmioE4FqeAiHzBPhTUDb86gsAdMUwJvsN2iXfG/JZ0UIe?=
 =?us-ascii?Q?Pjmk9DISl44I6+rvwKnGjvi59kRp1omT4ID2+ZWOp78K5o2soTfoe0TG0QY8?=
 =?us-ascii?Q?en6j8t/dmdLYi6Lpy2C4471OwidEH85uWgtYn6cr3tA1Qb+h/OuGBl6lFEZ/?=
 =?us-ascii?Q?/3C+7cBjaqAllBW+GmG2Dq0W2Cs1kUE2v5jE/s0i8yDgteEKMSggW4rlGWTF?=
 =?us-ascii?Q?qGA2n7c6cKC6awp3/c/+dXiYjab3FFRvinBP15nm1xku0yO1j45WaplEauF+?=
 =?us-ascii?Q?r0ijV9pA+bEKllzzO9u7CBilkUMTnnqJPONYG8W4SZ4rSqTIF1ZhjqdWsyPP?=
 =?us-ascii?Q?WSaeXKxY5nIJrreyYHXEK1AKbUXvCW1/Fbmf6XfKV6nneMlphZNMX4S1aH72?=
 =?us-ascii?Q?O1zze6OqwRQvFEfIEzuQvbcx5Yp5iTdYsgXgWJCcBdfZcJa0x6Pfradu9Z1+?=
 =?us-ascii?Q?pItZ3L9GQe7hzm7W9jTjtrESB3QWgDFQUVlGtlLjuNGdoNfiPkUrA4Y2VNjA?=
 =?us-ascii?Q?cU4FYFAreCePkVNKlhEhW0nqaGYIGRrwrmtT6ZvvLd00E1DooBhud4PoF+9e?=
 =?us-ascii?Q?TVBGN5JKWOjH59aHRebN4p32GewVBTIkGrWcLIeLOpqmnafXyGeQcHdYZ7RI?=
 =?us-ascii?Q?vnNJw5l3cgYPK+/k/4JUdvk3RlIksOBo1Yo0t0AmjcN5rFIT30B/JnItMscq?=
 =?us-ascii?Q?LDGq1VchZh0E/qV54hGiftWxWD0JWjlTJgROdy7IDgSUbEK2IGCK+RTzyNDr?=
 =?us-ascii?Q?KUjaxQbV1vhlH6oj7BEa/wKQvKt9LYNXX9sKJ8IJQh3t/YJGbLJoLD6Czqlc?=
 =?us-ascii?Q?XOS7gTduaxmc0PtAJJjV35lJ9+c6KjiA8M+C0upkGXtzWg76?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fa414c-08e4-434f-991c-08de5d034cec
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 17:49:49.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONGob71POxvLkPf1YRQklwuPFE7SZ03lVK4S1aJq4mDjLGNH9Dz7bwoSaFitb4O00NWAEtO9fnrSaeRmx440mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11558

On Sat, Jan 24, 2026 at 11:42:45PM +0800, Felix Gu wrote:
> In imx_pcie_probe, np is obtained by of_parse_phandle() and must be
> released when it's no longer needed. However, it doesn't release the
> reference, which cuases a reference leak.
> Fix this by using the __free(device_node) cleanup handler to release the
> reference when it goes out of scope.
>
> Fixes: 1df82ec46600 ("PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---

After fix Bjons's comments.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
> - Use __free(device_node) clean handler to fix the leak.
> - Link to v1: https://lore.kernel.org/r/20260124-pci_imx6-v1-1-6f4379fc5160@gmail.com
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1d8677d7de04..f459d05ecd7d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1643,7 +1643,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct imx_pcie *imx_pcie;
> -	struct device_node *np;
>  	struct device_node *node = dev->of_node;
>  	int i, ret, domain;
>  	u16 val;
> @@ -1670,7 +1669,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		pci->pp.ops = &imx_pcie_host_dw_pme_ops;
>
>  	/* Find the PHY if one is defined, only imx7d uses it */
> -	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> +	struct device_node *np __free(device_node) =
> +		of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
>  	if (np) {
>  		struct resource res;
>
>
> ---
> base-commit: a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d
> change-id: 20260124-pci_imx6-f97d70887dfc
>
> Best regards,
> --
> Felix Gu <ustc.gu@gmail.com>
>
