Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B5439354;
	Wed,  8 Jul 2026 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524527; cv=fail; b=fGcy2IM+RXv+toLlExO9pIz98WrUpKwGMv7ZV1oqTVkqcRWTY0ZVqoGzFtR/G6akoitVYW6lwqUwNYskEKAY0NOJm3Uv4F45ps06lULysptRHL9XKrcRgzog3G8KOVMWEjtUJ65rX44yhphgficTpZlGu0FVXR60NQQfd5IWw2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524527; c=relaxed/simple;
	bh=jAuLxklGZYknPrF79YxqCb+aD66+3trk6dF53Fvr+4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mLYYTtwL3YQFycI/XIK6/k/1nob2OjYcEnpbuC2DC9QlO0WCdn0+iA9ZRK1XghL4I2Gzq4ywVelTJJqFlnofAA50VEf237jnE/8Scd4/NYZ6QrbEy1m0piD0dUBOj6i7lQINmfx7QOrvPPgfb5c4HUfN94Bh835qyzkHiH/Zj2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=L6MdxQJE; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L6MdxQJE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHixEC0XzvUZzkN7VDmS71qyoG70vuwKPo10MSKdQ5Ibd3mQrvoJOMwVEDOQdKNd9GXS/ggBGovIseSrVOt3DDfZWmauBVukE+Goqef9QUZfGrLMRLDHDSKox4PtQKfp9MY3JxHr5Ng7qSZtpjodLVjtghEohLR9EOpBvakjnlLvol27FJtcACAp5pGMEBakoJ+Cy5RI2lJt/+49nolAikIa9wh2FaoR1eoH7isAtF4ANVaDdVAhHAU1Yz2TeFhZpa829XBJQyaYjbpEtv2bGhfdl1v2olZTTpdWf1uJG06Nqz9uXS5zq16ionwxg64a0VINTOZ0+ZgTYkCqusdWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpNoegAwBBgpFOJ/94wfRUOQ5QhCTpt2OyfKFS0Y0u0=;
 b=sbfilosmdijBDie8+gSAxPEA2jW9pu2CL1a6Tk7WVNTBd3wdbFpZLHMs7qJQ97LqNy2AmFs7k1Eq+vlcMd7M86QQ6bysebA9NxnvHJKon+TkmXWf5W0SNJtAcOvwHxRFVEJYsGbbo9KnUiFovKxRgStzJd9/ZRwl/G2Yu3oBdgHhwHsoYfD81fUmF2HZ9ikzCar6vtuH2fA1fae6vqIA+uH/3svRVhFrtYYBB+LY0irklmUXbyzlVcqY3dM9sxLQQlgtZZovY+P+m/o1I8wN4HSdt1G5cJhB1/wdbum0voRxFuhX3uYcdaXlGZeCDz3htjgUWbWKJJHW1jXBlYIJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpNoegAwBBgpFOJ/94wfRUOQ5QhCTpt2OyfKFS0Y0u0=;
 b=L6MdxQJEMRyrV35uIh7zyKeov6EqAbp85T2a16b826WQxCRaM3UrCfOsSxxjFFLXVA9Mp1qJ5/u9sBi+OfBCahyno3buvYBORXQxbjMLyMymAwWmpcf4Ks/DB4nZZ1W0HNcBqtkteRoGEeyhW9aM7mentBn4r13ig470u+KOxvuxkIzyMjA9lWIYEvDRJOp9RFbN4C4alEUkPQ3AuRniIq3IFizA+gVl3uME3Onzxoz0/ngKh1WsU8QELZ0HJEF1LeMDtiZmCdIC2bCratwt9xi1XckfCn+gdRq+7lljTRGM1VH2cVv9jWpYI2JxC8k351G5K2zXGDQG/hnHoFLF6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 15:28:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 15:28:42 +0000
Date: Wed, 8 Jul 2026 10:28:29 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Message-ID: <ak5snUBVsITwkLr-@SMW015318>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>
X-ClientProxiedBy: PH7PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:510:324::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: ca506221-c720-47df-312b-08dedd059717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|366016|1800799024|56012099006|11063799006|5023799004|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rNP1oHcHsS/s8SWiLccKLrg0zvsgEbsPiGBMZcFjCfLnpy3sS2WHQ4k4h818XinWygGMhdQWQT64I8XqQWhvbjRqG5QOHwxW/4k9bk6IU6YDIytH/2geIU5edipouaNgNzN9zy8YwcOZUcy10yMUEvrRI0lovGEirlERWMrA8teHbPnU52cJKsg6e/sZn/Bs5NnYwcXaIru3QTZSpjl1w3dZjghTKd1n+B96N8J50aEJ8+fkQjplW1fUH1iOYbzTfmXhRDYkGbV7MpU3L/JRZPGqIHuFz3HuACBT2lktPaVmiVBPDFGuB3lnSeIUnlJzUWJfQvZTixNEFEBtZkM1X7zSE1bx2cdWiW69r95djyJJMcDz9ePElJtn77kh+ZNd1Kx/skio4k4M4fEIT2Lh0xuounE6f2tz8IlVcahf/5KuhSg05Kjp2g8VrGvDc+0M4oeaxVSkJrMO4E0K1K1yfQ8zJ/EjGTuUdeGUcH3tnSo54H9wLDuRXYavtNHN2YxaEH7wvOvjK+WiZRhg54N2h2vRHQzWrV1NxCeqXAHjQcxS3AUCQ8dABoKNqL+zTVtVazgSGkb3FRFZ/FRPP0kepEG/ZWcTUXTm4e4xQw7rOp72N/EcZO6wqdTlTzcAqnEf38zdL2uYFtjQnhBB9AYFte3u0LFpUKAY4iC4df41gJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?abM0sC/ZTz7bUY4WpD8eQvn1+M0WTWbj83MmZh0x+k49y1niha3q7s/3H6Cf?=
 =?us-ascii?Q?Ymd0e1dS1dedbozVFh2N+xKBYH+mhYim8Py6wdJ3V7LYn9v4g2z0Ly4Zosv0?=
 =?us-ascii?Q?o1MYqVds61/cQunCdh4RZcn+usinj67zAoDEjDtUpGIRe75t20hPRyAz3c0W?=
 =?us-ascii?Q?bpuT3GQvS1wWBz9Sdi3KFj2/zO3xb/IBp8sVK1zQDEJj2H51rgt93pNhlRrJ?=
 =?us-ascii?Q?QLTA7i0kj6bmrtFwZgVsyqbZkLkB55cH+Quz//CJHVQiuPl5GOLqrXNz1Ef2?=
 =?us-ascii?Q?/MAdSL9fw1hNtXID+f7FCrcffnCbsWCMgrH1An2SlaxjfBVewr2Jpwayfn2+?=
 =?us-ascii?Q?NIsAEawEHoO5RuA+XZvZeaypDUmOTf9FRH7tITmKw2qAACrMtmCyNNK4zVLc?=
 =?us-ascii?Q?/bGaqs5REJFYcyeNe3VKQ9G2zQctzEnrtaW907VheLEl3lyPn2knhx87SZWg?=
 =?us-ascii?Q?MkOS1xAWwH00GHlqDFBYdAeNIl4lQASUULbtrCTM6fYlGKZgF0y5+nomwZOs?=
 =?us-ascii?Q?FL/5Z1T8fiQ9H6egxtiKpTidWBm1b58jBNg7EgWsUDi7lzPszpS9LZ7uu/6h?=
 =?us-ascii?Q?T5jb1lvCbBdOM/2mOV/MWsTysDTdpwmGFwXeYyw5TvrwM8VYtH+jWAXkF4/k?=
 =?us-ascii?Q?NpSVeFq1gKCwhl1DftbVbRP86Jnnh3Vh7jDJ6h+KDxy+NsfadducF0SMMCRq?=
 =?us-ascii?Q?BjyHHgEQEI9M3OGmwExsNwYL1UJSO2bXEKFd7B3Dedjif9/W1xwvmZIN1WD+?=
 =?us-ascii?Q?z1gt0ZK5omejBjyPn8K2HtewYTkiSyp8yY/MZRelLN9n++igvqGQGgNt4UqM?=
 =?us-ascii?Q?9dIK23HhVd7ltoemAoQx4j3hFEoQU6Pn0J6eFbSfqNzo+2LHBl5E6yR4p2Q4?=
 =?us-ascii?Q?SI3zGCOX/S8x6NSfOhX9/8kRcQilMOUQQjCMEU2zRAFNb+G5doiaKGYMGETj?=
 =?us-ascii?Q?7QTuEf0MXovCAsD1sROTOVW3IfSm2a5ytXstO672npqZYyscN26HRchNOFXk?=
 =?us-ascii?Q?yPbX8hqf12WKm9KaMYLDGwcndSDLCp3mdb0z5CfVG+C4CZXP7RMmH7MnQZ89?=
 =?us-ascii?Q?0I4NxbwhMUHyatCoQ8J9or7AZDzKdxIHP28RWe0+zC5JFGsPIlqhNRv8+NmK?=
 =?us-ascii?Q?zhKTAR0DbtKTab50eoxgrlS8zHWrboWyHRvStHTcgqaSQZMh1fu0vUGDbwPn?=
 =?us-ascii?Q?bdrTkaCnRWbB4RBHj9rj82RWX0/Ilw7BGBtA6pUggpTWIvTarfmkmw97Et6Z?=
 =?us-ascii?Q?uYg9LSEPCmWsU+hZTkgVSru/698R4aVuuUFDpGk+hxMSNcdx94tyIHoTlri1?=
 =?us-ascii?Q?3yivxeNwW5JpYInbSAAoSfr3//POffY9S6ZxL7SnkUcfscHaJR3RMZ/P6xs6?=
 =?us-ascii?Q?r2m0S2Dh7rRB9DqIcMl1EDR2DMtAN2Z7eU/ozfJeD6p7IF0ijHd+nm3CeeB2?=
 =?us-ascii?Q?FLTRZvLwjEzicXOHR15BbD2NlTM67JM5RGLdntoLPHE7UowmvMegFDCXem9g?=
 =?us-ascii?Q?wiakMx4E4SdVI5HlnpzAXBbrCCmnqarjh6u5dvK2rOviprajBznqz39EojBq?=
 =?us-ascii?Q?ZNI8/OQHAHNLrjGpMTZNFHoND+o7tPXsmWPVHYMXcl0AKPkR5so4sQ4ufzjk?=
 =?us-ascii?Q?xTUgWm9qQlFp+ClOr1CKQ41mO1ICHKBgY13h4pLc3xkkKS3RcANgF6VHen3t?=
 =?us-ascii?Q?do2cuy1t3L8EEcMYfsaoHqhxK7Van/BxQiUUELQ+OjNGsebRk+MEUtfAz1x6?=
 =?us-ascii?Q?NYKU6RRCAxulCtF52sX3MLeR9ZPKmgedSkkJT4Er1nbUSxB+2NXW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca506221-c720-47df-312b-08dedd059717
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:28:41.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfGxyE/TpMJqsD+FtG1qQp38aUDfJ6YhCJzcIepGmczjLGTYxapOWpqTMeLP1kSveLQlr0nKiRCdPxRMEnLUc0KQAxLbwc6wdKOmP1rcXBEuJ3cIIwkS5d4KIah1K94B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332

On Wed, Jul 08, 2026 at 11:59:27AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
>
> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> introduced a boot hang on i.MX6Q/DL variants by changing the initialization
> sequence.
>
> The issue stems from coupling PHY power (TEST_PD) and reference clock
> (REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
> managed together, the timing between PHY power-up and reference clock
> enablement cannot be properly controlled, leading to initialization
> failures.
>
> Fix this by separating the two concerns:
>
> - Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where it
>   logically belongs with reset operations. This ensures PHY power state
>   is managed as part of the core reset sequence.
>
> - Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset() for
>   shared PHY power management, avoiding code duplication.
>
> - Make imx6q_pcie_enable_ref_clk() responsible only for reference clock
>   (REF_CLK_EN) control, simplifying its purpose.
>
> - Remove the 10us delay workaround from imx6q_pcie_enable_ref_clk() as
>   proper sequencing is now handled by the core_reset functions.
>
> This refactoring ensures PHY power is controlled during reset
> operations, fixing the boot hang while improving code maintainability.
>
> Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

look more symmetry than before.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
> Regarding sashiko's reivew, invoke imx_pcie_assert_core_reset() explicitly
> in error path of imx_pcie_host_init() and imx_pcie_host_exit().
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 45 ++++++++++++---------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 9406bba36953f..53f3da6ab30d5 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -680,21 +680,12 @@ static int imx_pcie_attach_pd(struct device *dev)
>
>  static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	if (enable) {
> -		/* power up core phy and enable ref clock */
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> -		/*
> -		 * The async reset input need ref clock to sync internally,
> -		 * when the ref clock comes after reset, internal synced
> -		 * reset time is too short, cannot meet the requirement.
> -		 * Add a ~10us delay here.
> -		 */
> -		usleep_range(10, 100);
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> -	} else {
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> -	}
> +	if (enable)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +	else
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				  IMX6Q_GPR1_PCIE_REF_CLK_EN);
>
>  	return 0;
>  }
> @@ -823,23 +814,25 @@ static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  	return 0;
>  }
>
> -static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  {
> -	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
> -			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
> -	if (!assert)
> -		usleep_range(200, 500);
> +	if (assert)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_TEST_PD);
> +	else
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				  IMX6Q_GPR1_PCIE_TEST_PD);
>
>  	return 0;
>  }
>
> -static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  {
> +	imx6q_pcie_core_reset(imx_pcie, assert);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
> +			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
>  	if (!assert)
> -		return 0;
> -
> -	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> -	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +		usleep_range(200, 500);
>
>  	return 0;
>  }
> @@ -1445,6 +1438,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>
>  err_phy_off:
> +	imx_pcie_assert_core_reset(imx_pcie);
>  	phy_power_off(imx_pcie->phy);
>  err_phy_exit:
>  	phy_exit(imx_pcie->phy);
> @@ -1471,6 +1465,7 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  			dev_err(pci->dev, "unable to power off PHY\n");
>  		phy_exit(imx_pcie->phy);
>  	}
> +	imx_pcie_assert_core_reset(imx_pcie);
>  	imx_pcie_clk_disable(imx_pcie);
>
>  	pci_pwrctrl_power_off_devices(pci->dev);
> --
> 2.34.1
>
>
