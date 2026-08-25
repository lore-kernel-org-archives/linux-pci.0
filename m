Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF839061D;
	Tue, 25 Aug 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667585; cv=fail; b=K4Lg/2UN9ro8mA+EhAnARUsy/OXgXKevGJHbE/EBBuu+FP8EbzeZI4H+dbeYyQH76YHAMaULxRA+42jbpytUN8oUZGt/TgVQ15iaKrFX0LSorUnIiyVSrpUHn3eGdg4PSN7eiGXLT7uNhqJyYRbAesBLELmXRZOawiMdsEWhhjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667585; c=relaxed/simple;
	bh=6d39LhbiAO6L46AGC3RD4uki//rjGfAGjrHRLmsqtC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QSM2of5xn0HYP7c6tuh5fIX9jZeohRElgKSDJ8Sk9zF8z+3LVshwUdisgFpAZGhfhCNdPVZW7jwu0BYZXVJvz7WxBRHFvdfGoh9W3zVb+DJ4FG+cEQwR073rEEHRiv49Y6gLnS/MQkdf+0Zu/vFNZaLY8o+uSpGv7NwrydEkpHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ti+3ELI7; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ti+3ELI7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pa+tRJbVIu1VobwIvxZFXhE513M7ag62tCISO6de5Wxf7AUeEE/dOS94mrCmK6CkwWKXruMBMUBD14dBtpgLdqG1pMK57/wgXITuWRa6vI4mgxaGo17YvhynrMTfm5s4AATycEaeNp13yDjVxy+FTBj45BZmiWeRCfgXO3kfSe2Efe0bP9h8svMAee43EU4ff2Q46VsnV6SamLXgMPjs/McFqmP8C3E5pWJVK8E6lLE3jMKyTgVgu+GFwS9aM5JYs9V6THRxYg/XQW8SCBf+Q/Y6c2E0X8LpD8mtZDDFdQ2Rm3jMJr3XJ+Fo56flaoPU7Xy9k+6kjZxtrxjk0ZSojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8deBUt2zUZ7mcasmSUmYFVssWdZfPBk3k9uTOTL784=;
 b=lR2SirI5AvBcW6Uq6RNgLst6yje7nPhVax2opislhUZS63Pip/TkpzwedqD9tMbbKDY8BxotnbdSZvMmHi6kxPSEQRSX0XLFhhsHOK4RdsPAmts0oVMwFT6vG7FZF8/xar5MyMGId9Pijhu0qvRhJx7CngylwgTwHhnag7in1/O+hw8ogXNTKeRNQ3gulf+bX6HA0UCBH7uM1Bo5x9b9uuYsqiwvE5ZqMf2OEUvemPWKj/XjnknyIWzMoCAKejgd4kb6j2kq8Iq30mOYE9Ii8JOPkSFDVb0DyiuY54wIaviNlJzQ5fT2Qaw5cL2Itu5mD/eAXcAzn2IKz2RRAetErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8deBUt2zUZ7mcasmSUmYFVssWdZfPBk3k9uTOTL784=;
 b=Ti+3ELI75WdIb7vw1N0NGDf8WsI5A9nyNNH69bcawo+VvJYwdoZYw/P60FqE4PnOhTa0ioGADoq5vOAC2CVXSjywAGQqvCacF2KYaUrhaxxzI7WDlPmW7Hy96ShmN8tFwjk9xxb3Ayfhw8P8mzKM5fKbPcREu6reOABRlz4oP1fktVu4gikeFCLVtArFGfqiM0rGLhxmpZQL8/rmN5NdgSCRO1f6g6CMOoxcjoj/9T4x28c7ZY0eycddcNyhGq93WHvlrMV2wLKLbWRv9Ctr8TvN+lhxTuNp3g1f3upprnflRERHX56Sw6DdUTwEGHRBwI+M7h+DsoYFcWgNsng5iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMVPR04MB12650.eurprd04.prod.outlook.com (2603:10a6:20b:775::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 14:19:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 14:19:38 +0000
Date: Tue, 25 Aug 2026 09:19:27 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Zhijian Han <hanzhijian1991@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: imx6: fix endpoint init error handling
Message-ID: <ao2kb5op8osYY9Bd@SMW015318>
References: <20260825060340.3767635-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825060340.3767635-1-hanzhijian1991@gmail.com>
X-ClientProxiedBy: SA0PR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:806:d0::30) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMVPR04MB12650:EE_
X-MS-Office365-Filtering-Correlation-Id: a2da0e30-26b8-499d-563c-08df02b3e530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|1800799024|376014|7416014|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2GBLlPOaWA3HIGbFC5q9U/K8F+xtsI+js2H7A4gXuvM2EzL3wbmaQ9hctkGBi2agFuvVjAhC3A1yUG9JNgccAxNeRrybfgVyK271TE0vGzLM6tgh6209Zjy0DrA2o5b1xTjObo4kzMAAlH5etFZGCXat/bm5fvz8ybm44vcSsSRhkBJagQc+PL5F601gR2Dq9JllJs4aihdUrFtW3UZhiEIgI7oX5iKLNji/BdUumCrcQv3LBA7Hqro0peeo+O+JaF0j4LZZcwQTRRVbqe9pOGW8WDSfCYCKiaZLLB6mJlkHmQX1ig/FDSKyBh77eyZoZctiJuIjGuyf0Z26D2MbQOq3kixQ6xXEllR0zKJKoolBNWbYAEpcPSvtsZoiCEWZfTgYiOVmFgXn8gzLALfrvJAlWme+rrl7l2kMCVWeMa0YDYFTRC72MHLKxt7XPwmeeIuFp30b5ypDFA+20kKKmZLXfuurQfUxOBGS4Nh57bRYaIbvVpYIorl6pTQ6dRqH3uQtjSNVunnqvK/j9kuHwXlCkJkxopAjXIH1vyvE1xuVMUFy84IBl9BsqoD8/cENtGNQqqhj9bAb0vQdEqMUEXzilpWGKzfU4XmvGd+JUj4Rm56zOxjvnnbk1MR7xPKkjdo4Kz9aVTJSA9CZ/uWMoAfUr5K9YCo0z0hDmkb9zHI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lptAYdi/fvCexY+pmADsY3WAzC2XsAdO4g1AZEqNUHFc9yPo+7fp8T5KfnkB?=
 =?us-ascii?Q?XfSYjSoKoKk6lwH3i1kRpHa1GVqQtaTG/onpWTQrwJRRAo5Tf8UDzQDYT8l8?=
 =?us-ascii?Q?/9NRe0txviRMb0djQOzb7Ty78+lw2RIINLpm3U2PLsWr/ls8Rhr9uA7evgxZ?=
 =?us-ascii?Q?oFuqe7gj88kkNOjpnEJlFQczJL/D/SRNpa7OdhZ2KxMNQWlVmeY9TaBqmbYT?=
 =?us-ascii?Q?Qrr6A1ZLLXQ63HxgrkdpGS5WQBeCFmqL3h3UKR5jtNEGtJXBv+3VMH8nRrR+?=
 =?us-ascii?Q?/z2/uwNbLcEtA6NrW1iz4sbj3LeC+nCacHcFBH83IaJ7NLIPhD1G//ZwYXy+?=
 =?us-ascii?Q?KYZmsMMidD2iovVlK51S8LQwmBFM7EUHxJqox1cE0BmvgTQFlYPHzy86fYAU?=
 =?us-ascii?Q?WOT25JGE/gzahrixt3AURhh3fbQ50r6XwLS0UfsPjB8n3iG9BbnbTjuuz6Ui?=
 =?us-ascii?Q?qFQLbFTd+uiehhiswWI4KcloMcjBnYnno/emy52deYJ2qSY0dCC0XpSYQjCN?=
 =?us-ascii?Q?DVJ8cibBuR8oWDtY7rOdz8RR/P8eETQ9Qw571YtMYwUB8eLGqO0V+MQPvJKm?=
 =?us-ascii?Q?qB1e/QjpccFylZbY6twCKrKuc4+H/u4b8B6p7yn/rsVzF4VXNAkMznJPqGZ+?=
 =?us-ascii?Q?wFzP8JwMp77koFWiZ/CZw7mGtXzF7xfyhyMIPie5Tmhv3cMVS/JJ183lLBvm?=
 =?us-ascii?Q?Qi0ivtvVSWuVEBMvQnNhW6qQ47ME+BUQk/s/U1xgN6WDyW/xfT9wZ8HNIAlr?=
 =?us-ascii?Q?bQSwSoqkneSMLavgMGcDvherPIIFqr292QiG9FGMfAkhPqFtt5n5KhfHKE7q?=
 =?us-ascii?Q?+ArCsnrW/j27IF5eD34m9pxr4vlgWUAiyruCW+WRB7CPN8IebMaEXJItinjW?=
 =?us-ascii?Q?T8B0x47o8dYrgIP2pgldafLrFTXX1NmNNyKjGGOYaeZkNyQKF8py71wY0CyJ?=
 =?us-ascii?Q?Tzg+KlQAyIm9BixyY+lDfYw3qKVQy9ytt2B2cG4EYQzhzQ7t2j04E/dB1BYP?=
 =?us-ascii?Q?UJAGPMoxhW3JfUywmskva3q7s+3REhUuKCv9vbLuPL7TTBX8/O8TdFkovias?=
 =?us-ascii?Q?fJyKpDoTmjvr29vxtBmZwTSVytW7/iLbvlrjhVsBwCEiMOW6U5Qatu0EuTPU?=
 =?us-ascii?Q?W010C9szF83BWxg25EicfCRIFtxCcmILqQV9ne6zhx6BQzOyaxfE5fbV6g/X?=
 =?us-ascii?Q?IWKkYtjyFU+ItT2CFJcRF1taXMsPtZ396hjaOO8Sr1LtvLJWRmZ4Ey5Creqr?=
 =?us-ascii?Q?7ZYqkW1kIOIM7o3T1DA4F0w4fojUEtkPB7qMpYsYRoZnyXEcVLfHlijFQa75?=
 =?us-ascii?Q?guI4KY7U2dRLKQz8uWsQLXkiBSZFnINZnN9YMMZoeNR0OEg9wTu8/oJ8AIi7?=
 =?us-ascii?Q?OqVLxIN8tYMdi5qjfsmUTDzxrATVI8JT3ejURl22232LCl0B4kZRSoKtY/Py?=
 =?us-ascii?Q?GyRRRWVHQSGScVr5OEusOmFJOgWCOI/kmUNO+MkU2cwoe1vOFXjHR/vTupC0?=
 =?us-ascii?Q?hdgnP4zro5VDu3FVcLR6L+bqrnREZSdWzkHv+J6OFvTPGizLDqVKGNQdF9ZH?=
 =?us-ascii?Q?1PQHWyJARnQzBklQYtUFqx6v3uDsJcJsFsmXUh/CAjkEbOkMBSU8q05nV4mn?=
 =?us-ascii?Q?cjeTgvlpMk3AyvSRuvpw26IKvxsRHHpyfK85t1hKYUURXzyH7WfjY4g1llkf?=
 =?us-ascii?Q?VAHf6Gwb+mnVqWkHnrcbCqFpi0ntZZ5FBcWTYXB/bLDrflMC1CxSdTIft0n+?=
 =?us-ascii?Q?BfG/m4qq7gA06rJDYzCgbPeFhRgET2Q093lGeZbzst2SZu3e+S4w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2da0e30-26b8-499d-563c-08df02b3e530
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:19:38.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAMk9KeoW+4+vd/rgEQnRQgXiJIDUPJpVtycgDDlxtuH6f6p8v44ugKw3JymSRQmJiCrvjtZudeNUpK6dQL8WeGiBC57WKcSwG7M7EqdKnAoilkzsszxPqYsK71zcP3d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMVPR04MB12650

On Tue, Aug 25, 2026 at 02:03:40PM +0800, Zhijian Han wrote:
> imx_add_pcie_ep() ignores the return value of imx_pcie_host_init(), so
> a failure to enable the clocks, regulators, or PHY during endpoint
> initialization goes unnoticed and the driver proceeds to initialize the
> endpoint against unpowered hardware.
>
> It also returns directly without releasing the host resources when
> dw_pcie_ep_init() or dw_pcie_ep_init_registers() fails, leaking the
> clocks, regulators, and PHY that imx_pcie_host_init() acquired.
>
> Check the return value of imx_pcie_host_init() and register
> imx_pcie_host_exit() with devm_add_action_or_reset() so the host
> resources are released through the devres framework, which unregisters
> the EPC device before powering the hardware off.  This mirrors the root
> port path, where dw_pcie_host_init() releases these resources through
> the same framework.
>
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/all/20260824152857.DB9771F00A3D@smtp.kernel.org/
> Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v2:
> - Use devm_add_action_or_reset() for imx_pcie_host_exit() instead of
>   calling it directly on the error paths, so the EPC device is
>   unregistered before the hardware is powered off
>
>  drivers/pci/controller/dwc/pci-imx6.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 39790e66b..f0fb4e1b0 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1488,6 +1488,11 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		regulator_disable(imx_pcie->vpcie);
>  }
>
> +static void imx_pcie_host_exit_action(void *data)
> +{
> +	imx_pcie_host_exit(data);
> +}
> +
>  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1634,7 +1639,20 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  	struct dw_pcie_rp *pp = &pci->pp;
>  	struct device *dev = pci->dev;
>
> -	imx_pcie_host_init(pp);
> +	ret = imx_pcie_host_init(pp);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Tear the host resources down via a devm action so that, on probe
> +	 * failure, the EPC device created by dw_pcie_ep_init() is
> +	 * unregistered (also via devres) before the clocks, regulators and
> +	 * PHY are switched off.
> +	 */
> +	ret = devm_add_action_or_reset(dev, imx_pcie_host_exit_action, pp);
> +	if (ret)
> +		return ret;
> +
>  	ep = &pci->ep;
>  	ep->ops = &pcie_ep_ops;
>
> --
> 2.43.0
>
>
