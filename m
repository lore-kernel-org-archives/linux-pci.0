Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40443EBF07;
	Fri, 23 Jan 2026 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196766; cv=fail; b=mZNWAtNu6X2yWjBOr4pADLASKVD7HU72ICuvteJi6Lts6x+kjVZsh6P/VbVahJB/2nogqml1Lq7SZd9xLMG4GVVS/Bi6P0VL43j4lZKIQK0wn0oFA4QQf117G2ElRAMFsz8NAeTZshaGeoDedD6lIfAG9JP9UJiagXsugWKj4js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196766; c=relaxed/simple;
	bh=ADNTVNbuX9vvRVSVgnr9fNtTK0dlJpCW2lT7egP4/pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J7MzPc8XVG1wJOycZt7q+2F3xnO2b4m6bvEULu73zgZZT0rpStzarj+0LdN0S/BdnUJOBLTaOQ2BDuLCPF3uVPjgswvCGtWevkpp28YOOmOsIFn7vPrrKbCFpHUjh5xKc+lixKnpisEokErqjvRRORlA7dZYjepBJtvZwvw2gMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UFDwoMCZ; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UFDwoMCZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3Vyv3oxPILiFHlN87ybY2y0/5/W5Z7HIC/t4kNegeJ8uuvbEeRCJFbz8ekYBKh4AJB45bQg0wOEbU1jgRb8CjYXiWJy3ubJHyqpPBkJcjO9+Go3kk67WwIEDTXHJpgiHcJdKM26/DGKkrK9mU79Qi220KPo2fGGnIC6vWOJvwuNraAyFfO/fo8SxJX4HdxYRVxTD+HVkfHVMxgSxPHcaxm1DkVAP38F3vhYvvGfWTL95hWSpVvLa1aZQS2Uvuhq6GN3JRCJ9Tq+XD6ziU9KBNmYNJbetKuVfyHQ0xTPs/GYj3Nnm+MhgV8lnyBwudYcM+hv4u6DwbPtO0PlhGNaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+r5fZhkf3GNfegUj1BRvCyBl5daCwtOKvn2OSlQg7k=;
 b=xt6zTS8F+Pr4TPwxboADXweww5baURJq/DoLdg4O6kUhISQZNz6+UbL52RP0lV1EQPasJFCuwqumL2aCj6ievsnEBPVuF75QO+tcpc+2bCUZXifTOtBPjnMibVnncVtXIvajWeF1EO44ohM6qiVNzpIOQOVoNxFlPVcVqyfzTGbgFebnF07lzIA8D5ugQRBZ+w2InNXCaewFvrihvP+RzMC8tfChI+BBKvkexrhDbhkPVYt9PrpqsGye9WYiYHsWOp7RYpNlQ1iyp4JM5Hg3wmIo/4XjT+vzIklp4qoG+bP6eaCGqWkKnUyVCiRVE45Se2waBUpoiqUmClWLW7pSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+r5fZhkf3GNfegUj1BRvCyBl5daCwtOKvn2OSlQg7k=;
 b=UFDwoMCZ719QxwuaQeG2AQN0sM1pslmzCSG297PGW91AEjIEi5IrO6G45yf0VYPqvQmWIb6iALN6QsRo7pgzVjpT4pjTpF9QlDNkuMmFgL7Ih8ezbg5TMJebAitj49v+knvb8myRlBnIY8I9yDVUV+ft8VzVfwgmeS5tIuPP/aeDu9Rrvf+x4yHEUFVzpxdG2Qpc8i6u8VRWck/S2SjyPszKvJrVWxGPBfnL39BkM359llgHrY099x98V/rmN9mAvR/sLpEaOSUF6MbKxW2Nxgr/cVUpO4Czp21HqHuUj3HK2zFXlobe4c+321BJLAdtLsJBNBzwEc8TTcwJS+PkVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by GV2PR04MB11591.eurprd04.prod.outlook.com (2603:10a6:150:2b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 19:32:41 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.005; Fri, 23 Jan 2026
 19:32:41 +0000
Date: Fri, 23 Jan 2026 14:32:25 -0500
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
Subject: Re: [PATCH] PCI: imx6: Fix device node reference leak in
 imx_pcie_probe()
Message-ID: <aXPMyYeFVvDjSMhZ@lizhi-Precision-Tower-5810>
References: <20260124-pci_imx6-v1-1-6f4379fc5160@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124-pci_imx6-v1-1-6f4379fc5160@gmail.com>
X-ClientProxiedBy: BY5PR17CA0056.namprd17.prod.outlook.com
 (2603:10b6:a03:167::33) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|GV2PR04MB11591:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d98bb98-5f6d-4c78-2c70-08de5ab62c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PCNAz6SwERwyMUG1sFl+PNzStiJv0YR6s62+rGSrnzVljwflBNji1nl9EeJk?=
 =?us-ascii?Q?VrbgQlO4ADMFZa0Fm2dkhVzPh+Ht+taermT2pwrXO3nRTnPExo8TqcxcKn7B?=
 =?us-ascii?Q?FZ57asfD8b2/gh3iZCYl2ofA7rsGGMOkee9a8k8tloXVEl8+0LSwroKxP0B7?=
 =?us-ascii?Q?7D7oFUrMqb+oejoBtQjxtoFGizCVWyCjTZnpFuIvPhB1yyi5l2pAGOTv/AUL?=
 =?us-ascii?Q?1f7Mpxv/wpRV6k+ZxutIJjGZqQ5BmVinayjLkWpLgsX1XZk+zmmV9DaLh+VY?=
 =?us-ascii?Q?INssAufy9x1VIZr7n55++nKicwpMurIXutxxZ/xOr9xWO29W6PeI0xnLZB2H?=
 =?us-ascii?Q?YOPebccoQUUSjYJ73jrNDWWzt5j81WHFEE1VC5i/4pqSyiMuDp31ckR+Nl2m?=
 =?us-ascii?Q?84bDwv19lQTvNBIt0uQyv0dRCWeLXtFNu+0TzLhrde4SXD89RW0QFSHvl8M6?=
 =?us-ascii?Q?7WLZATX9jkAHfOwiCimvNv+Y8Egkg0kQ3xDTW5MQzkU82fe0mNOziEr/Y+K9?=
 =?us-ascii?Q?qDtEM3OUtO+1xZluamFEqnEzfeFDa7eTG9PxOvQwoyYH5FUz8F+oEvV8QsqZ?=
 =?us-ascii?Q?C8zdIN863DSgDRuu1Ca9yDTd6jB36tYXN1IS23MbAqYewoCvjTUMrwV7EARC?=
 =?us-ascii?Q?aUylY2P4oUqPoZZkE6Bkta6zID4lK1DZzvOxjluYzKFwJq9my4f55QVlH9XX?=
 =?us-ascii?Q?zxK+QOSW3Gk+kDT51zRLCbgVhDLIasfVD0vj8kGwF/nl8VmoUJcSWflY6ES4?=
 =?us-ascii?Q?43IpH83Q3RF/2OC9wnZzKkoI0gwm3+01TR2ZIuTyZPVe/bo+/0M7S+0/mp9z?=
 =?us-ascii?Q?XLRk87ezXN/Ei7nNNNi3swlsg5NMYA/0IC+k6IPH4uV2gqWNZDEiDwa3521Y?=
 =?us-ascii?Q?XZyfWgPBTJwFRgYXDEU2hyuWAokt6uU3GmrNDj2UdV7Aryx5ZulYboZ7IU+6?=
 =?us-ascii?Q?tUEMDxxw1uleQtLRNXSUIXrYuTcGa11U2/RZ3r6i01nT12r2hrtRjS+SrZIH?=
 =?us-ascii?Q?SeURgZq+Edq1jEdyLbdUclfRV9rRNfeUM+fziObX7BXx4RNMxKzoAVY0DqVF?=
 =?us-ascii?Q?YWlloirnU591/CVwv3FDdZvi5D3Gotlhv/Af5Xi7WfGvYWma5qmds9Tcn/3i?=
 =?us-ascii?Q?uYB6lmp5poY8gg/esBDZujLWGGuXXsYUZLpsiEW4bIN57bxuwQLM05CkgEeM?=
 =?us-ascii?Q?y5Jz5sA4fKHKiJwOgX6jOEmhnQhCrIaUiEwB8u8h5Nx1M4ShNACShRh6nz0b?=
 =?us-ascii?Q?2BUVV8226oQ0NaAMItImIbeylkqQHCAfWYpEKLw2U6GeoceNucR2pK5BhFMd?=
 =?us-ascii?Q?hCF0srNiKNHf/+2ZHjIhxFMR1DBP82fO/drsTS7EulZ16NbQQtC+QWwkbxQl?=
 =?us-ascii?Q?sKtTc7rJD16bxF0ywAHd0PS6XqZGGxsOwyQ3uxkUiZsypMywWafdAmxA16cH?=
 =?us-ascii?Q?mj2CchsGx4rixwQYSyqjJsxFfqrELFcbhlVRqcNv3kI5EFEDLa0Mo6lYd22b?=
 =?us-ascii?Q?icnVIq1X3P3RC5JOMovrGan0pdxN8DqFkqQzz881nrkhmGBjLmycze0O8KPb?=
 =?us-ascii?Q?W6utAPZTiuRJg0tpZet0+q8JZTmczkAwN6Vn8MB5jiTE34y6bm4pX7XhSUa/?=
 =?us-ascii?Q?98QmGa7fCqNwvuDzx++wRjc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d2xg38LJi4vBFawPa9u9HIT6vBcfa1rWm2LGe9WFyBv439NCcFfxlQ/ZXK7y?=
 =?us-ascii?Q?yC4cFGF2JTPFQAMWt3MCzdguTsQaq3lptcgEWlR/L5jdEgrwworeC6COtw1I?=
 =?us-ascii?Q?JV8SFGANu9W4k6y5M+7iy7ZLDgEYTjPhVlZG6sDwx4ASL1tDfWMQzJ4fYb3l?=
 =?us-ascii?Q?n+wp6R+fOndyCTmaik6AJXiGbKyAJNgLB/PLR0Y0Rt7KRGbD6/9txAi3tg92?=
 =?us-ascii?Q?mjVND5CcoyL3jhIwuqTaH+m63ysJS7uTa5p6YZlWHW3ex+hAr+pZgewMV131?=
 =?us-ascii?Q?Sf1ENUGTcomG0I0LdBj/+TYifjYEeX/WiwVRJzyNXgm4L32GSpXOKTLrnuD8?=
 =?us-ascii?Q?YnGH8CSEVC5dPBwRS/Mat48NWCbT4GOlM3O9uYhZRamquSxYnGAO65O7HH6Z?=
 =?us-ascii?Q?mrRnxUXoZGBCVdp4bbypGXomGZwNoqLtYRQ/ZSZNY0tj19CaPR4/NeCS9YfU?=
 =?us-ascii?Q?iZS5ct2X3tqt8XcSv2Zv3OZLMD1t9tMOM1uMoU4gbZ/nrt6o+G3UsM+zb8EK?=
 =?us-ascii?Q?R9zeRHdnZWokRx2vrZXIc1ftU+28M4E/khWeBMq3RXE87kWl2ObivlsoxA6S?=
 =?us-ascii?Q?SxE1/OWpW/4dSvVyWBYGbXzXKtlkxobDIMasjS8mMrUOcyd6xEl0UxXbqAsT?=
 =?us-ascii?Q?s5wCb8Njb0g3AbP8ORwEYtvtcKnyhAXLlCmpGNZS4Xu5b6kNwEIGKBAv1pcu?=
 =?us-ascii?Q?9dArmjl2rQCY8C8rXwr16s9ITX01WXt1S6R7ooeFAKcNb5tlVLBH14CnktNN?=
 =?us-ascii?Q?xxBkx9R86Y1JDeqxjDFX2tB60k1j0EycnrD5aslqZ5QgjQk9dP2dI+SoTmLF?=
 =?us-ascii?Q?PJCGesVJL66Y2YSJg0ouu0YfLaMSaXxHScWmLoDQRzH6H3GvsdN1KHITBBOJ?=
 =?us-ascii?Q?jZUt5U6HJxya4Z40rkSTP0527ZP8vmRemyUa8KX8tfmJtl2TkF4mJQxXonVT?=
 =?us-ascii?Q?hzxlERghYnGxK357NyYLG17fyao90OgRDsEy8a/vTj/gwASiVUZLaGgQ2yIj?=
 =?us-ascii?Q?sbUMPVCZBcuclMeU13f0yOJlXe2IxJlh8DDqPF/5ixcDDhPzfErp7spQgDyX?=
 =?us-ascii?Q?2BvtdM+xm59rQgPT9D/oMsXtDt9lTEhhjYoCfIPjp9Obn+iDrcWaK4HZ780+?=
 =?us-ascii?Q?e1osb7lbxrafSJwTV5bNvCu1Hik/4Qg71bn9azGSD4X/eSIIKEb9rYO5Ilvo?=
 =?us-ascii?Q?EAuNri7Cb7sP1WyamnInZMDUh+beHjMrgZwoNmKjAnX5KE2h+n9as3/g0c/J?=
 =?us-ascii?Q?d1D2+8RcSQK9dRim5h9LDmw6L+5nwpvJsrlsCpLYYWEbCRvxUuxSS3AYn6LG?=
 =?us-ascii?Q?nNqoqIhjMuHolTLSIFFvMRj4eYLDeXAngRZmDDfrVwhb6gQbaFxxZq/EyoiM?=
 =?us-ascii?Q?F/dxbxp5dgbMGWdOiTx9VIxdU96Wf2QBXB2bpd0ISl+i4BN6c1bAkGeLJJLv?=
 =?us-ascii?Q?L9575Y9qjwTeXIUKy2aYn8iP9s68jP6NR4IvxI6FkHzZXaRxdvdYSygTwo/B?=
 =?us-ascii?Q?e5hXLLPihOcWn4Mm6gG7+a4lq1XQe7HWOKp8DJJ2JZmAcfE0FT7uL5BW6pIS?=
 =?us-ascii?Q?vTTeFm3smDTNXbSwAW+KOfkPSd0Q8lVORT0V5BGPTUFojmwk0FekSM9Rud83?=
 =?us-ascii?Q?EI1gKLaBJ0DmqQgZ7JWPk7k9EN7Bb8oVPcNgJteZmByV+NxnIaF0OlWcFFWT?=
 =?us-ascii?Q?uFGuVkptWjll8yKJWYIxk4428zzi0KEWZLWbJDVu30AKpoo5SlH5YPwY0RfG?=
 =?us-ascii?Q?omarzNX/ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d98bb98-5f6d-4c78-2c70-08de5ab62c52
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 19:32:41.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Itch5WbShKT+PMBmHsqTIaZ04+jgwfomtXUhQIaTGu5Etjk7Ca44uVPnAM/yX11rNKplZS2ESpkFhw+jQWqDZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11591

On Sat, Jan 24, 2026 at 02:18:49AM +0800, Felix Gu wrote:
> In imx_pcie_probe, np is obtained by of_parse_phandle() and must
> be released with of_node_put() when it is no longer needed.
> Add the missing of_node_put() after of_address_to_resource() to fix the
> leak.
>
> Fixes: 1df82ec46600 ("PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1d8677d7de04..3ae02712d3f0 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1675,6 +1675,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		struct resource res;
>

Please use auto cleanup

	struct device_node *np __free(device_node) =
		of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);

Frank

>  		ret = of_address_to_resource(np, 0, &res);
> +		of_node_put(np);
>  		if (ret) {
>  			dev_err(dev, "Unable to map PCIe PHY\n");
>  			return ret;
>
> ---
> base-commit: a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d
> change-id: 20260124-pci_imx6-f97d70887dfc
>
> Best regards,
> --
> Felix Gu <ustc.gu@gmail.com>
>
