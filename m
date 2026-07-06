Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010031.outbound.protection.outlook.com [52.101.69.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527CD420867;
	Mon,  6 Jul 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353640; cv=fail; b=G+n+gDjQfrJQ5+y6fqfMCgsedGK2kMT203+h/Rl67z02hKnxB6UV0FbJr2CasSzluryvIHj30jPppdqUObEtKsK02kHVCLexD4SpQy0JoYbSYlchGTK9uMQdca3o1//0Yq1Q/RUQ0ZsOtsOUTlBNeoUncNgRtR/Bz9yerNNXWfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353640; c=relaxed/simple;
	bh=G6+dxbK5QywsOt8N4+5Xs5pDcUJBiQvXjtG9fOKLkNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i5okVERbIxqLQKOQwhbmsQjJRN1E4ZZILVeVmzg5j59fpvA7I7gac87t7uXxtIkoAWwxh6i9Vo5bvH5v2x8AzD+zCg8uHq1Yl3Sz5N2Xz9A8Oalp6DBjhKWvAdsMlzzSKdL3CCjgPGw7YsrH6bDIGvfRhLbMYwByEp86eM8Yqbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lvuTadgr; arc=fail smtp.client-ip=52.101.69.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lvuTadgr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xD2veWHfmyHtGSAAAQ977MGZztxvzh8i4stg8Y5wuqHF6o0VNHLuAsNr+tOWxyzjtHWqpRXpw9k/a6rsqrL2vEo0icyv0RmMN442ZFDhlSVUwSEJYLiPDdOdG2dRcmqku0OmN0pMiE5sB3+Ojtc+cD2Vbdzx+D1x7YZjuu7qJiHQ1Igq9CJp9QrZNy7DK8HkwYuk8SwBC2H9KIUJNJqeQme7gCBF/ZCqW9Ua1UC+AAyBI64xiwoVwyZgCvGblOMtlqwFf+AXfd+sU7dRKLT8Rf50bkJ0Tt0q+qRA3xM/PtiQJX3AqTtKBCYpMqS+zNzOrGcTfFDkb9HQaD9/H9BQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46bLZtqq6jvOp25oRRTdqNsE3dd8eFvRNd8YSHFFbbk=;
 b=wnnSeneczQYOswVTj55rZ6Ue2vUN2N/Z0otLIgP/pY747cWF0PMcEMfRiyVlEnsZAqGqoue1UYBEehBZgsvZSALgg0zLqgKS4ctNsY8Oi4vAVg70c7UaMVve2pWuuuwGd8R93hJJRW9heqPTf57mx8jFpAK+oycCe54ZetA1EA+WLEISbSc5bDNtN0g/4bSHiUv9sU9eLPwHI5OY9kgkA/94vwPucdzemJXxCH035qjEikVsMk3b3tz5S53x+FhBWA6ty0umMKVd8uCXcnKL5rE3/VFKUKdUJ8Y/rtRkrUnC+jxDkGA549OwSKApZKyA3mdkMGcJZK12PwTOueg+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46bLZtqq6jvOp25oRRTdqNsE3dd8eFvRNd8YSHFFbbk=;
 b=lvuTadgrtXapDC6iTH3XcKO/rZjD0wPyEVdRswUd/CcNcSe5N2/Xu6GAR5vToXqsBsNB8imLLCGCpIIolibcKUNWjoA2U+ewaqyG9JO8Z9zkLfVR7VV1ZPQPpan3ujQSl4jaETZ0VyLTjRGYGF+fbI/KtfiSP+8PrHkTCPVRkw/e/v2+33dtbPgyV096Z0d++PmlH4VJjiFNwprHTE9m1lpNnieezedER7J7B2jPzblrIS7RLvE7JeFq29CPG2NROi45jGGZqxIHFL0TgkTD8UfGnF24/jnTcd//Aa6izk/sC4kQY8jPg+uCXtFJAt+foEqEix67fIZAFJWPJmNrpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by FRWPR04MB11176.eurprd04.prod.outlook.com (2603:10a6:d10:173::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 16:00:30 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Mon, 6 Jul 2026
 16:00:30 +0000
Date: Mon, 6 Jul 2026 11:00:20 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v1] PCI: imx6: Update MPLLB bandwidth for i.MX95 PCIe
 Gen3 stability
Message-ID: <akvRFHY_tW4KiguA@SMW015318>
References: <20260706070340.3603150-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706070340.3603150-1-hongxing.zhu@oss.nxp.com>
X-ClientProxiedBy: SA1P222CA0125.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|FRWPR04MB11176:EE_
X-MS-Office365-Filtering-Correlation-Id: fae379c2-73a5-48e7-ff7e-08dedb77b3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|23010399003|366016|11063799006|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TvhxVumTjlemc+CQfKLWeBO9gSQYhHgGvuOXSiDIESmqwUMLwTLhQsXilXRT/wIHWEAKDpvdO96KbkPQBppFHy36LLgTtHi4tQ0okpCPmOmDV3lFFz5OpwhFb4PsjEFwFV8YdLWINyKJlI/Lk01VpYXwNqctZ6ThYGULsojF9AD0fgcvgKN/F2gpnZ1HUE/V50boneJ6CMPel6OOrcRMQayGQoHWh+ywsVtNlDwsorJfoi6iSOgdSPtAEmRgtlos89ro88MA1t0TpkTR5+FuEPNnCMQn09VAIFyYkZi+G5ooyR54RUOnEBl5GzSFvAteOo9GDdSnCbtyCF9i5yHY/4NtCtFjbGbNXTsdtfAbq3j4GL29w3uA5vkY91UeE+HJQoL2Zevzjb+xiID19y+oaBRgRJgM0+M+Sp9RDJHbQfVs7I9tbM1N6rO7siya4TE5NYFfbrGwHSrd7BB3C5p7FNEG0kNgamxjWz58kea+8iTcq00O622EWTokFIrMyyiq2JOMcwzgUf4Dn1cotj2nIMW6NQ2wOs33d6RAH2Z1pMBgyGtHMwwUz66GQLcF9dX7fXCegeVnv2/L1yrX6jEc1KwivbVbbCOjLS0VcX46piysL9tcweu+ZdIaJylIj5ACyg3KYAgZLUnRVRRiVlaSRygWnIjmQN3EfRJMafUREvY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(23010399003)(366016)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r41tXU56hEmaDoP0ysP7cBZqgmgkmPjKjxhkHvGVpIa1Garf997nG3x9zo4n?=
 =?us-ascii?Q?hwYzwYxI1wkFLX4LtAdL90BYK+aPULDPQsXJ/y2IU0k/4huStWv6X58hKay8?=
 =?us-ascii?Q?YjGDcOmdoWTG2njfMoREiF9bNrZJwywenmvNdtKfZAmvtDBgl3hNC28o2JdZ?=
 =?us-ascii?Q?9T+gzoi6UQ/WkZ2PaOIWPBGQtjitu6ZX5HvvYjP6QW/3MOGCGisByXmkCFEJ?=
 =?us-ascii?Q?Znv+NM1QfLr4hpl73EGuDLfraPey9koYo3OwjxaqLN2bpMX0T9Gd0MMB4321?=
 =?us-ascii?Q?3l/rNzQkWCz367S6gTAiykiDk7QYC4V8D3JS8L3/kwRhZldD7q06E5c4FztT?=
 =?us-ascii?Q?ugXSuf4X8PY+iLZwEd0VwJ7gKpy4e+dYYh4gFexScYSQEbjVleY/PDsshlqq?=
 =?us-ascii?Q?oL5Yxq9f5mYdY1+bDJkShR4fxYt/JQN63oQNSl2tlamJl4gktWMGhq2Yp8po?=
 =?us-ascii?Q?PHbKK7GbJnGGcP85HHmvmJ8ySrqutqbuSGJaz+p4jUdD+hF8ZlmHG49bjEp+?=
 =?us-ascii?Q?D/7yLudvIoTh3tWPH3isacvBYku9mK4tmbFrRDxei+3Ks7SI69D2FZ7JxccW?=
 =?us-ascii?Q?Ft1nZM2eSzMJP4T6t2PGAWiWsSUsZdFz0XGd+VHBWT8Z0CjZRHDL5AarcSwO?=
 =?us-ascii?Q?xbECg3PYO8Aorr14HFaJZqyMxC4PjFAsx2QsflgA5er3GsDpd1r31O6xFWAP?=
 =?us-ascii?Q?dbnLMX3KaxuG1rCJDvYjB/naKOnKooEOlE89gs+ULi0cmD5/redOqGdnxWmi?=
 =?us-ascii?Q?CrBzHgFXXR4PumBOyTxnaYVzzA4QpkJ3GhfHG67Oou4hajR5vO0IUHhALzj2?=
 =?us-ascii?Q?x9OToUC0Zj3kQSH4Ze43qmbfRaAWASJznxaQR+B7DEiescWOFNWP7VuM84ON?=
 =?us-ascii?Q?1tJubwRNqTty2lO96wPPxIo98RpzcCvDyAkljZ2xGHoXWqcuRQCdw+ocW9jq?=
 =?us-ascii?Q?3+jGOJ6LIlq/5UrqVdrteLvBSWWRKCTBYuMYhoEYW27cGZTlepKoQ5qdBoUM?=
 =?us-ascii?Q?bxhmExG+2xuWhF+yiToyH4lh+gU0NCtUSj1UGrSPGcf7DkLiaYFVOIWUUCtr?=
 =?us-ascii?Q?z+5e7+S9ZDZwfuGCJRfs5zd9EPezaoazEr6w6a/gp2Z3020a1wh1J2wO+JOj?=
 =?us-ascii?Q?x7/PIyif/RdzXtLsZ0yvunBW3MC3t5bM6rsyk7t/ZhbwyfV14gdisHZrie0t?=
 =?us-ascii?Q?4LYxV40kymw1ELt6FAYtnAI+nexJMBksYqB65uo9eGbBlCsxIZBfW32wxb47?=
 =?us-ascii?Q?XIl+Jp18oYKa/1AgZmiWpC2ovbAPJicGhNQ7WNvlVx7Oy10An4N3Au33o5Gt?=
 =?us-ascii?Q?LCjGrJFz69zgY33auwAhcIKB1GCcK0zoUOQ63Zx1/64Nu8w5fwQYMolvS2ew?=
 =?us-ascii?Q?EnYqDJ2u8Sxg2tltWK+pfxXpopU/ydVSSAGW04F86NdkzJdjp9lK/z63vH+H?=
 =?us-ascii?Q?ubCkkXYANP9u0dOXMSJcQC2RWa+cg2eletVPXHQG39B2TSFx/hAz+wcuuTy/?=
 =?us-ascii?Q?7WNX2an/Q9Erqsc6tO7SMDxrvQQmMHNO8QlctyPEy+dLng48/AvKtI2qn3cK?=
 =?us-ascii?Q?Sslmudq7/EjBIEXcVUzz/Hiz2LzOU6Pn2f/jPBo6s3JKDH5Rt+iqWQZVa3VO?=
 =?us-ascii?Q?ZUuMNBLhHB5lWaDrncDT8SFd/jJTFewGenyZAgU0CjSbfWczuVuzpruAOk0S?=
 =?us-ascii?Q?hvWx8gWeh82fScRnItT1ev/xnfM2Ra/Dp/3MzOj6mnYF5bzK2k2CS3eOGMxM?=
 =?us-ascii?Q?CCMl+1s+p8dvtnrl8hlWPOhwar2czEkCz+MC5qNYPfTE3JcmmOve?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae379c2-73a5-48e7-ff7e-08dedb77b3f2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:00:30.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AU9l59c4A3l4e6/7m1jmVouUAY44rnWRYUVsqr7ETCh3xOHcTuXuC5sEyj6KxsreNqweJWXpBPVtCRawsYePItd+JcLhpMsVnw19Ex0BCF25q0DXvxuL+Ot6KTMboaPb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11176

On Mon, Jul 06, 2026 at 03:03:40PM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>

subject:
PCI: imx6: Update MPLLB bandwidth to improve i.MX95 Gen3 PCIe stability

>
> Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
> the default MPLLB_BINDWIDTH value. This margin degradation worsens
> across voltage and temperature (VT) variations and different test
> matrices, potentially causing link stability issues.
>
> Testing with MPLLB_BINDWIDTH value of 140 (0x8c) shows significant
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
>  drivers/pci/controller/dwc/pci-imx6.c | 31 +++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6924a06bde305..023145b0dd2c7 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -80,6 +80,15 @@
>  #define IMX95_SID_MASK				GENMASK(5, 0)
>  #define IMX95_MAX_LUT				32
>
> +#define IMX95_PCIE_PHY_REG_ADDR			0x3008
> +#define IMX95_PCIE_PHY_REG_EN			BIT(31)
> +#define IMX95_PCIE_PHY_REG_ADDR_MASK		GENMASK(15, 0)
> +#define IMX95_PCIE_PHY_REG_DATA			0x300c
> +#define IMX95_PCIE_PHY_MPLLB_OVRD_IN		0x2004
> +#define IMX95_PCIE_PHY_MPLLB_BW_OVRD_EN		0x400

Not sure how spec descript it. but BW_OVRD_EN is bit of OVRD_IN register

look like IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN is more clean to avoid confuse
it is a bit of register BW_OVRD_IN.

> +#define IMX95_PCIE_PHY_MPLLB_BW_OVRD_IN		0x2005
> +#define IMX95_PCIE_PHY_MPLLB_BW			0x8c
> +
>  #define IMX95_PCIE_RST_CTRL			0x3010
>  #define IMX95_PCIE_COLD_RST			BIT(0)
>
> @@ -269,6 +278,20 @@ static int imx95_pcie_select_ref_clk_src(struct imx_pcie *imx_pcie)
>  	return 0;
>  }
>
> +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
> +			   IMX95_PCIE_PHY_CR_PARA_SEL,
> +			   IMX95_PCIE_PHY_CR_PARA_SEL);
> +
> +	fsleep(200);
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
> @@ -284,10 +307,10 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
>  			IMX95_PCIE_SYS_AUX_PWR_DET);
>
> -	regmap_update_bits(imx_pcie->iomuxc_gpr,
> -			IMX95_PCIE_SS_RW_REG_0,
> -			IMX95_PCIE_PHY_CR_PARA_SEL,
> -			IMX95_PCIE_PHY_CR_PARA_SEL);

why need remove this part?

Frank

> +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_BW_OVRD_IN,
> +			     IMX95_PCIE_PHY_MPLLB_BW);
> +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_IN,
> +			     IMX95_PCIE_PHY_MPLLB_BW_OVRD_EN);
>
>  	return 0;
>  }
> --
> 2.34.1
>
>
