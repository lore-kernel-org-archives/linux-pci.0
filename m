Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ECD3B47FD;
	Wed,  8 Jul 2026 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523962; cv=fail; b=nhC9A1tnCh8TKvzb4Z/poF44IE9BBYMY7xXnjNZwX2eyvU3HD0LHdIA+QF7ZwOuUB/InzKTyc5hUez8AhDKiapwx03k1kqlmXPoXB9+/OHcQPrdeLXSF0fejp17cm4NeRsRGkoSo1HzZJCYj6wVUdXN/agTQabNd4c8mAHYCr+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523962; c=relaxed/simple;
	bh=A7ZTQecetBSvwVoNO5zI2q/LE/xSxNBiqZmR4rFD4ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E9IglWa6rEUKDCn6iE5nhIld9kvQCnGeWO0JCzpjOcxrSg1Dd/X+QBJttLLqKKVt8kFqKwpe2DSZ6mHaFiS1CMLVYpfZPWl8PRTRIUG+h9fTxwhFyVYdruBqb7fvd7jBapbzRtizwZ3I5yabDWo9pq5JALjwfhsUZNj1D2yeFPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mjeb1EKC; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mjeb1EKC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2oyrePzo7Ol47fUk0hNrnMnCbS3fwx4s7i4Z1YilPP8NlRjXERlHwWwq5/yVkJYDFneBK9+BGgfiKWIOEyXPydPW57JJRYdSspUlO0kZA9/WP0IzErmfZBmXSbR7PNc6eGySK8c6yIhjdpYt7l5HjLWJJJUKQUFFBSdMT2gLaibd+yJ7JblmNSDXvCbuXCrmWRrpK132egfSW7iNm33CdnWrweKCHsbCBhwWNCrXNXoUSzLzSqJsdyB+wU7zDQhSz0ElJr7u/gJVix8B6PCSQY7fIcNf0fzhE5P6RgRoR5IC2VEnLkFOiNwh0AP/8WiwT9CwTH7FM2WqUWsSTJQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFhFa2Ii9TmzpYQN/UZouh7djHLEwjb3i4yEv9XD3Xw=;
 b=wndWXyIkGkJMMxLRGdQGao4ePPPjpRhUB3W9Yxf3BdIBz3FH8LJtvd5JYohfz2t8nc3wDrVQILjagwplkld7mbNCM7TOoP1F46ylM4coAwYgFfaa9mfjywK2SvsNEWbKcKsuCHsQwTuZgLtndqKnKRSFlGQ8ZP6n0l2zDITWe9vJZcFI7cZP4LxIrNW1zdfIXWEi7jbKmW9Rvf3blzeTU2OE4ifcMX7M4rr+MQk1YyM5AfB44yRt/wMiYdGDp5HZrJznxsuJpATVasb1xlot+WgJOU8NH70SJH9KFtFWpGAC/xlsC5Cd0DBxwQYJefkFbfB0oGxoZCVgedPLN2msew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFhFa2Ii9TmzpYQN/UZouh7djHLEwjb3i4yEv9XD3Xw=;
 b=mjeb1EKC6NRXFv6S6ayAHF4dLKHm3UtXwmO8BaJ+YSbRUNQdDMh89ZfVtzDs2ZiOKUpH4TDrEIwzccPOgFOldoRxXugQuYDRumgHx8Wpi+Es2UV34ujw6uVJ/xaljQhsqb5Ij+foqdoOHXt99Nh5x0KfURaqbWAqoZOfzHstpYUhpMsp1/51l2pPg+y34X2W3Ht/l30EH09MRADcKhPUUZviSYYaBr1M17n1azNa9OOXmTbzhCiTqsVRGW2L0HAD28Tr4X0ZhYbkbU8FYHQ/HxCuH3JdxlcpA8PlY5/djLEl0noNhgLZYdxY7t2iFtaGT82HDFWqjmwWw0+DmenqHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB11325.eurprd04.prod.outlook.com (2603:10a6:150:2a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 15:19:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 15:19:15 +0000
Date: Wed, 8 Jul 2026 10:19:03 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Message-ID: <ak5qZxsTsIWqe-ML@SMW015318>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <20260708035928.580236-3-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708035928.580236-3-hongxing.zhu@oss.nxp.com>
X-ClientProxiedBy: PH7P220CA0150.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB11325:EE_
X-MS-Office365-Filtering-Correlation-Id: d800b8fc-e18d-45ae-f105-08dedd04457a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|1800799024|366016|4143699003|56012099006|18002099003|22082099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	HrHXCXPZvwaRbmtImtSMTvdD2ALEyIc0k+NSYzrsozvlbkaRw/SuE9uxAb2OlzWCMPj4PN0p8MalWHpTOhzaoiLw+DHp6R2KLOs0jGCQSkVVtKtFPrnbICdzVS88s8gNGkk7VB7/NDq1v/+JiqIYRdagP2EeFKq/6Mtk3t1Jw2EfqBstUF7nwyfyQl3tJFaIQtRRJywkxKXHHu/q/VIPO64x4uRRhqcda3i8D/OYe9lFQP6UlbIvWpW3YRCEoC26JXSA86/AWS/wp1ccosNFzgyHaLg/EtZLdhFSHd1xZn4VnuxFF8o6T5gj5aUaQP9vb5nH73AhyPHQ1LsJ+MYKUIQXexuuMX3j0VPO7XSq5B9/UaRmpUnLj4BJ+rjVFoQP4x7OLE4esIw8F6qm32zloPhvxoJM3t6CGLlaYGiZyhOeh40NtyTw6n7KUzs2Q00kiRpJdxnctNIcJpCCBa0+q30B+KlyRUOsUJ2ZGBr6CnofbRRSioSM8i7Kh5xCmTHQ2ahhhvv/wnPKXx8us+qHFWY/xFDbYvtMF3b9aQjEUsa0vXTqAtY628P75lhjsTJ6zfn2/DMa2O++Oawi3IACJ/8pBtuXD+nv1P+8B7LW+auXQGBYriN/frLpVzp1Yk0PmVYnwkPhyMp2B1Qu1fqjYZg0tukY1GLQHi8ObbGb6+M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(1800799024)(366016)(4143699003)(56012099006)(18002099003)(22082099003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6pZ8NpwH1a/00N/z5HqgbpSVizl/mRNgR0AplVmeIQW6OqfKatPQ6kuWP5mT?=
 =?us-ascii?Q?r0cli7fhp74RbzDHINESClCljm//3Tu1L0gQmHE2SRqENImEG6ApABvochae?=
 =?us-ascii?Q?PxzpjRDqvzpCBxKsV6O3WN0w2AJBFRejErm4r8ylPmkcAagP8yY+lVM0EvaU?=
 =?us-ascii?Q?IqHvtciJPuCq7Qt00g3mgHMVc7xA9mQHhNo7YXwkrK31AQ3uLUUksPBPBLja?=
 =?us-ascii?Q?v971sq/5mhcHcvkgzm1ESpHv4wPNtZwtBJV+SZXiM26aueuH8far8NNi6qjF?=
 =?us-ascii?Q?Ca7oZQrRyEo92xidTKKajrWDf25G1xfYFoba2gH10Oh/g6Xyos+h6lHoWKDN?=
 =?us-ascii?Q?/1/fqpqOfwDd2FeSD+f9VTKwN+Vc+QBv1uMyslM6tBlIAaY2RZWnC1LCLEXh?=
 =?us-ascii?Q?gRF8XvPvGZ75JmBPir5uYvzdpqKzCgMIMoIwXIv0/K5/8Oh2+x4A6oLnQgTA?=
 =?us-ascii?Q?c1x8Hxtelz23k0vIlMr47WTPC2O7nBW9ReGEscLbJNTJR3VFldVC4kavZ13d?=
 =?us-ascii?Q?BoACHwaWrzYzPnGp5XAv4RFi3/YJ4XGw+9PIauM1EqdQ6EV2XBsFeNFizzTf?=
 =?us-ascii?Q?WwRU9ELOy+LIjKYPjPUSGLAMPUhYw6EOTC5Q4PkX/UHBuFmcfCe8deD/ik9C?=
 =?us-ascii?Q?hAHteYjT9ByOsBcR+3TbIckkeRSzUmZUH1IC/i8FwxD26MGj3xJEv7g5vtFA?=
 =?us-ascii?Q?tRqYUcpUgeIGz0UZMqqRy7j0FUZBdO+teg7sLvXweYBNQ+dX/acAuEw8hZvl?=
 =?us-ascii?Q?P2ahnez0OgMU9g1G9z+FfTpMNuF4QBYvN6zsy+UXKOAGATYjDoBxzVLAI47a?=
 =?us-ascii?Q?ILAkf9lPmM9LksxSBDPHeU/7zIiB7iGU4aFz4cOsiduMh8ueDcWzh0StAXB1?=
 =?us-ascii?Q?v57FHHbli9QKL+dAgQ3toLIPVw19VNYm7WpXO0FN9DUj5XypXt+Zb5OJLqhw?=
 =?us-ascii?Q?UO16zHqiHwzpvxKOiZcQCzFHzfQAlJCmeHm6clB0qT6gNuOYY0Vf3iirSp6A?=
 =?us-ascii?Q?D21lnOh+6oDOBUjlxaFV5XOU1s8wDGDre2/smadcnaAUNQdXVfitVsDMpgkp?=
 =?us-ascii?Q?HOLeJpbrGaQafxJZlzv8yswPW1E+zMVcSQHNvrXiDOrA8eYG+/h05FTyn7X3?=
 =?us-ascii?Q?FD85ddkimizZ2sJJB9pMC14iNyXlkni+jbtInQlioavO/tGcxUVDb4pbKnJm?=
 =?us-ascii?Q?mvaxU6zAJYkwElmwgNzihBC4+fCfLzMhu5IOiwJnArk0BGLkEFwKJ/mDjhnv?=
 =?us-ascii?Q?f2WxHxflXv4fFHtNo/jL0ppICqZx0dhSbRGubdQUqsXuz+xGR/X82pAMS4oZ?=
 =?us-ascii?Q?OI8Y7hnEudvNPS1W3EEby+HKA4RecNvoBaFVjzRxYmTWvbKbkrIWIrCMu9s5?=
 =?us-ascii?Q?CUVnko3WJwOwVBRO92RbOrjRqgzaWjFngaNCq4PLsVzYhmYqzQBkGLCLY7GG?=
 =?us-ascii?Q?j7nnK+oMpqmUK3h5H9X+xlAt1KLxV/hApuksVYO4YZP7R1fS1SvNV1CqSuNR?=
 =?us-ascii?Q?eldqTM9cM39r4HlmOh5k32fnL8LHMjR6FWzOCDn/bE6Rm3Khp9fryip0dOEX?=
 =?us-ascii?Q?F6/o2WovAVZY8DkFD1rpUH8Cc8JsGWFFvOCHAG1S9NX4FqvJqEyb3NcLEoBx?=
 =?us-ascii?Q?E8WHua5KOCE5h5XMKBUn4pE18icIkyjAorEzDaCoGI4FJMNOVkQB8MuEM49V?=
 =?us-ascii?Q?mEJTBJ4GV4QyKf5rHcTp1HZ/ZQrxwzhhODcNp0tzCC8NerUMMglOr96aQAu4?=
 =?us-ascii?Q?2mNTOpwzgL69N7urC/WwsABL0vGlXL81gQClgBGOpgV18OHI6NvS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d800b8fc-e18d-45ae-f105-08dedd04457a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:19:15.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpbuThyLnrPcmLdtVABqJFxYpE3mrE7FBgQorkXRPEVI4yBwMCMeQCswTL1dVQWNTNjLfTXepiySGp9wxMsAsgd5vLA6xJbLLo1QcUs8EQThEk2xDS/tFONPdkQCrAkP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11325

On Wed, Jul 08, 2026 at 11:59:28AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
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
> Changes in v2:
> Update the register name and bit definitions.
> Don't move IMX95_PCIE_PHY_CR_PARA_SEL settings.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 53f3da6ab30d5..5f75aa09e0377 100644
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
> +#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN		0x400

> +#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN		0x2005

This one IMX95_PCIE_PHY_MPLLB_BW_IN to keep naming consistent

write IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN -> IMX95_PCIE_PHY_MPLLB_OVRD_IN
write IMX95_PCIE_PHY_MPLLB_BW -> IMX95_PCIE_PHY_MPLLB_BW_IN

> +#define IMX95_PCIE_PHY_MPLLB_BW			0x8c

0x8c only one special value.

IMX95_PCIE_PHY_MPLLB_BW_XXX put special name for 0x8c, if no means, you
can put 0x8c direct at

imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN, 0x8c)

We need knows what's macro means, like it is offset of regiser or it is
field in register easily.

Frank

> +
>  #define IMX95_PCIE_RST_CTRL			0x3010
>  #define IMX95_PCIE_COLD_RST			BIT(0)
>
> @@ -269,6 +278,16 @@ static int imx95_pcie_select_ref_clk_src(struct imx_pcie *imx_pcie)
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
> @@ -289,6 +308,11 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
>
> +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN,
> +			     IMX95_PCIE_PHY_MPLLB_BW);
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
