Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2933DEFC;
	Tue, 14 Jul 2026 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040141; cv=fail; b=ERrrehRb8AhlaMZBWs4goMKTQnT2xXtSKVL5/+rgJ8oaZPnHDex+DqvYYy3vrUxd8KRWQ/buMjqkhrWjWlZ3/4iJtnRxVAQYIjQgtHfCmcXfYVR4RDN7uoMh2hTi9jIcr6gfZqBOIiWqNoadI1dnUuodK0LuUlZVH/K3czt5FvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040141; c=relaxed/simple;
	bh=Tf4Zbx2kJ4/8jQfOwD7gVYAgxycxaC96k45B7mDtdf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ccu5FlnxusG52eN+qcTieok3mjqaFx43W0394YoL7MHahkCflrVk38LX6A1ir9Ep4txsjtJGYrsrAN3CftyexnMU/Esfs2n8AKmsp53OmbLElDLI0aE0kuGjotK4+UarHc+4Cieu0/BNpEmZUJPKy90zScU0UreJY4YC8D9Cur8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KoUdenj1; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KoUdenj1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksmECUrReXRB21m8qmjWj1kGgD+5OPpFGiN8PHXB6BYUtSs6sR1RAV3Mlb+rHtBUMxhqHTtS+/RmXnqkwImeScnOKVL0+GuNpNaGXgncWopBh3G8aeubbfNQsf6nIZzcjGmoIhPE4srIVb5m2gwb+knn+BBhl8bRsGhGXbQBgXkgYrVaTPQPExiMIqNzjTeZrXDF/2ShBnWdb0LqZH7YJLcq0UdBLhke6XGfh4CCBwb3dL1tUAoD6yrUX4Fom3bKOdrp8FLDk6WdAlF8MXN8J52cAFwNU+dtJFwBl1wkkdHwZVE5b0YwHkdk34XTVhn6tvUJJ6UraCeI0K0tmCIseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXeZfp4XtWaQskabUHyJ7hWvNVDB7M0p8xHUIafvGjY=;
 b=rNQpKbhrXQsJ1CckSOIp4hRvQ0d0DYeNX9b6GB3mlaUnXcXoFavbmMASF0nnqBq7dthygbrdql6CgMi8+vlnT23m983RPcQbzOpd9rBi+ibyv7RVc+Af7fve+r5WWQ3UrpYnHmkQzFWHRAZ8/euZB1QAdQgwlLsUGO/EYd7TpnPkx/KoV3DPUsyHxARz2b9iqfMKEBZLOFj3YD3fIlAmZpOmy/mYISNSlQrMhp9XUGjnaF3OR9YkD1v4ERpShIwtSPi/7F97GxIpXWDpLfAUQqLX8qXtOFPPF8tlV+0Ikb5exPEWeJLSitF6oiltP63u/fzpuUJ+Gr73OZfgfG/RNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXeZfp4XtWaQskabUHyJ7hWvNVDB7M0p8xHUIafvGjY=;
 b=KoUdenj1ZNjyu7tEuBb/5DU3zaI+ZOFVn6ras6pxOLCwFWi2L0PvSBtpNd1s+549xDsjw9vLDIAM7S36zDAhsuA5gtmh9d3QCbeh2USWzS18sEBXEjwZS7m44EN0CU0ACrB3zD5h+w2uuN+BcCiTiJvXEEPZTRMKVHLUPbycgP/BfnQohMqafajltnbFqwz2RjQoYBrhpYkxmEnAdpsNtsSX8oZ93XSmwD48JWbQh5Sobp7THFBat0ndYndazaXH+Eu9Pw/c4oIGJxutgJz9WSDj9eiXndC1UGRpXSXYkG4ItEKZwZHpkTE4epPAH0RgkHlBp9hxV54p4bn4Rttd9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMVPR04MB12675.eurprd04.prod.outlook.com (2603:10a6:20b:774::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 14:42:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 14:42:07 +0000
Date: Tue, 14 Jul 2026 09:41:55 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Message-ID: <alZKs-jRJhXYHZm4@SMW015318>
References: <20260714024107.4113926-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714024107.4113926-1-hongxing.zhu@oss.nxp.com>
X-ClientProxiedBy: SN7PR04CA0240.namprd04.prod.outlook.com
 (2603:10b6:806:127::35) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMVPR04MB12675:EE_
X-MS-Office365-Filtering-Correlation-Id: d54620c2-82f8-469c-988b-08dee1b61459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|19092799006|366016|11063799006|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fI9e3KHUORTI6h01It4O0lzyvabTwCysv3vfQ9fQNwEl0WaqnEybLJKz/80eCVEcecjyDcLpcT9YXRNbLz80aV9n0OOoeTKjVWuR3xH47C27dIDjnedPtxGGwDLdy+gljG3yLX62Hc48dprzcYqXSS5zllbn02KKMxFMQ7EyAqMdEGSxtpq89nSIn+yqfDZ3bjOX4l9Dp24fZq4MIqnsyKKUWTYsl69G2f0Kn7o/rWy0aqIhLEEXrQICt5BPzkk9CO7VWxlPKCLA+oXP56CDm0jBJjgPHljg4NdSbd0FUEO7eS5cSgvHpqugs5Kw2eanGP9VgS6UdBPabupvGoy8kOeQjPks2mGDLIhHaAEpY8+dRJLtZhtWziWS/DLnbpwIBsz1+7kjaUhKrJrofTIMLlmpLFIgtyjA+MrC8VoCl+3CK59d6zUZAmlrpDbRPdYL7RugT1fb+CempcVr5YkxOTpfZII6LbReHjkIdd0lRvYCeoi/8fyoJ/UNFipZNxfhVyO3wL1Qwky124WJ0uF8SD9pKjq750lL0h8aGZP7RGKvIU/W0hPrvXUyMn7a1o1KEJgXgQKxHeWYWZvz+8iGV/lbZ1U+jyQqftSTOopNAp8X9lBIEB8+S0ekkcTCXsQajGmDB0ARmw5vXhWGNReWcDXHrpm9oz7RheZu76zVnvI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(19092799006)(366016)(11063799006)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BOUQH/OUrhrD1xwFy/cIK2dK+scESD/lVc2XImgnVg64OXgmCxW+Uap0hrfE?=
 =?us-ascii?Q?wnoxbRQxr5oKoahwbm0G06lL8DbsL4L04uQ7VPN25KYCG2S8gsaEt42SG8+9?=
 =?us-ascii?Q?6t/FSihLCgVXPBrFs/8xdX1sl+62seBjVX4wPh7Q10mGEnb7e4Iap+qrMpIS?=
 =?us-ascii?Q?tv8j3Rw92jnGs56Ecce8ZlUpGRzZilY/32HgO1qeRb5JonOxtxVA+V6cXX4f?=
 =?us-ascii?Q?JU+jJTMNfXa/VSqqA8aYkk97cbaxBCse6fSteKONjxbdiBwKqD5azD0PAfaq?=
 =?us-ascii?Q?QAf2UpMH9LVOUS5L3t6a5Ufak7Z9rJ+kcXGQv+rMWEL1Lx/2WunQoAc2sHkq?=
 =?us-ascii?Q?DfrNSy/dZPNQm6pTSL4ncXGHCu9Wzwo3o8ZZl6ocBSFcV4kllPrM7dl62m0+?=
 =?us-ascii?Q?gstCec2CLRvQNlZXM1xMoAhuM+T+iRA0kuhxja+dOIdAWScxAPTY8ZsRN2Pp?=
 =?us-ascii?Q?9Sp//PqVWrzVf0j0NcItaePYlz9VBBuHdjQrtIj0CN/cRdEsyYn1gsmzHmxh?=
 =?us-ascii?Q?wH/1Zh3JXW9Lw6Js53OC28TMjvTOGrC1ZabZ9gx/kq1V8/IQBoHsmuKVQUX6?=
 =?us-ascii?Q?PuKv8Kx021uY6bkGIshN7+ohjWwWYWYUmrcbB5/QGQ1ecwJ7+SBgVN7Q88v7?=
 =?us-ascii?Q?lWxGwPqlhcyBH88noVxNJLAtuDd+iDwvvE9Gh802aVWXdKfuC3fEcDDFMJXP?=
 =?us-ascii?Q?xxLoqOYc68DRim0KqriCxCMiCAGoJRL1wZg6/W/X4/kc9f1uEGEYpdqfdk5y?=
 =?us-ascii?Q?Dgm2v2MbBYc7zALt9PMJiRlnI3oW+YEpEclILv/yFw1fg2Es2ZIuL6pUu3xJ?=
 =?us-ascii?Q?A2yJVDYr/neKXd21ViMt3vRIkLfw1sBIk9wg40XRHB7tHDeeEcYwxyF327sz?=
 =?us-ascii?Q?Sh3yI8NdX5OcvWdU8+bMdKwlDX5ed1kT7qRfrRrRf/9NCFUFSlXe7lHqjf2D?=
 =?us-ascii?Q?V+5oNn7bm0xKml1Ao6G1Rws418T1g/17ojrA3iXwbSsaECysqWEooqbVt8Ds?=
 =?us-ascii?Q?t5Fiq/wFZJeygbEaFhQQ7pRv60G8AZYjW2VcjXnoSR82DeiofjDAGMt0au6+?=
 =?us-ascii?Q?8YkCxMnly7wMTAacx4KpVBVG5gn4LhGsIunAGpP4pXZGls6SBVUA9bhbKVHk?=
 =?us-ascii?Q?8+ns/yi50LvMwjpagcWQ3j85s8u8lGpPjSfbZUSZd9Jk/3mOZcq/gOP9Q2pD?=
 =?us-ascii?Q?3EsQM7NlBXxuG2bFYsZh9DwINybzhI7hP9fz60bjMtmkPc7Bsz8WtrQhq3EB?=
 =?us-ascii?Q?Bf25hPzOsfJNXaFIEV3gaChr3HXjPgIkGiEQcgyUA4owTU4ShOGW144Tb5iS?=
 =?us-ascii?Q?CXMZvxGOJ2WdqykfsD60/tYoK+rR/n9CZBdjJKoCSrO+fYqSlxMNLz1u+EWN?=
 =?us-ascii?Q?T7Ozqp3KnlrMNZYGdyldTQVD62vKjiH0AYtFQRZxJDrpp5giaCvKH+JWDDy0?=
 =?us-ascii?Q?hTfWfrJ6XELHi6ynRqVfOqpsY4GFL6djqAbU1I7nOlZRfLXsjHoHtabhDHgc?=
 =?us-ascii?Q?EneNaOGnyu9+2gAyH4nGz1mo25HXa+HJVKzl/iKfvSVg9AWPoTSV+o2Jcw74?=
 =?us-ascii?Q?Q9DYll8w9mtLXDtzR1jjHQDVz/oJi47eiO4apXtYQBLN/QQ+onNLN78pyhCf?=
 =?us-ascii?Q?tQ6QXMI8/nexfYOOVqXUmzHob2BpEfzaR1k+gaN87YFN1A7rbKw3+o6mxu7t?=
 =?us-ascii?Q?zWY6bWxUSDl5vsjenOciz6w9B/qgf3azxZl2JKTVnurOQ9ocW4Cnxq8jmJfA?=
 =?us-ascii?Q?LZ0yDlLWFrqKgHvVPVaI7PZ5q7kU3xlkB+OOSlb7E9MJGX40ATgN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54620c2-82f8-469c-988b-08dee1b61459
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 14:42:07.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldd9UzzgoKQqFa73brN0Wr+OLukNJuBFlCTO8Z5+693cwxYvpERh1nuB/djByuc6GU5ZEp1DO2MyK0Un13x3zdzYZh6Uyq/Bpxym2q+1jbGQphkRqfnzf/rOrfgxB5tE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMVPR04MB12675

On Tue, Jul 14, 2026 at 10:41:07AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
>
> Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
> the default MPLLB_BANDWIDTH value. This margin degradation worsens
> across voltage and temperature (VT) variations and different test
> matrices, potentially causing link stability issues.
>
> Testing with MPLLB_BANDWIDTH value of 140 (0x8c) shows significant
> improvement in bandwidth margins across all VT conditions and test
> scenarios.
>
> Implement PHY register write helper function and configure:
> - MPLLB_BW_OVRD_IN = 140 (0x8c) for improved bandwidth margin
> - MPLLB_BW_OVRD_EN to enable the override
>
> This ensures robust PCIe Gen3 performance across all operating
> conditions.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> Changes in v3:
> Regarding Frank's comments, refine naming consistency and clarity.
>
> Changes in v2:
> Update the register name and bit definitions.
> Don't move IMX95_PCIE_PHY_CR_PARA_SEL settings.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 53f3da6ab30d5..fadf14de10f7c 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -80,6 +80,17 @@
>  #define IMX95_SID_MASK				GENMASK(5, 0)
>  #define IMX95_MAX_LUT				32
>
> +#define IMX95_PCIE_PHY_REG_ADDR			0x3008
> +#define IMX95_PCIE_PHY_REG_EN			BIT(31)
> +#define IMX95_PCIE_PHY_REG_ADDR_MASK		GENMASK(15, 0)
> +#define IMX95_PCIE_PHY_REG_DATA			0x300c
> +#define IMX95_PCIE_PHY_MPLLB_OVRD_IN		0x2004
> +/* BIT(10): Override enable for mpllb_bandwidth[15:0] */
> +#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN		0x400
> +/* Register offset: Override value for mpllb_bandwidth[15:0] */
> +#define IMX95_PCIE_PHY_MPLLB_BW_IN		0x2005
> +#define IMX95_PCIE_PHY_MPLLB_BW_VAL		0x8c
> +

not sure why hex value have not align to previous line, maybe patch
show problem. Please make sure it is algin in code.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  #define IMX95_PCIE_RST_CTRL			0x3010
>  #define IMX95_PCIE_COLD_RST			BIT(0)
>
> @@ -269,6 +280,16 @@ static int imx95_pcie_select_ref_clk_src(struct imx_pcie *imx_pcie)
>  	return 0;
>  }
>
> +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
> +{
> +	udelay(200);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> +			   IMX95_PCIE_PHY_REG_EN, IMX95_PCIE_PHY_REG_EN);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> +			   IMX95_PCIE_PHY_REG_ADDR_MASK, addr);
> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_DATA, data);
> +}
> +
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
>  	/*
> @@ -289,6 +310,11 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
>
> +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_BW_IN,
> +			     IMX95_PCIE_PHY_MPLLB_BW_VAL);
> +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_IN,
> +			     IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN);
> +
>  	return 0;
>  }
>
> --
> 2.34.1
>
>
