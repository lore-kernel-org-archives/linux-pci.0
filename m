Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D63ECBE2;
	Fri, 17 Jul 2026 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305864; cv=fail; b=t6E3tDfKdNWojN2+f9b8PEYvQoFk4ut2Twg1SYUSGvrPWt+M7dqhYWX13lMZG5NPVNfk/FOYuYQGdCcaDkfoTscfh0yIN5hcGD66RXJV2+7tM1Z8yuWiBQpdYSOFHRi0fyI8K4STGzfpMKds9gFeTIqkD/PqNmfWigqJ3LRibps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305864; c=relaxed/simple;
	bh=372mXwYWjQndVWAVRhXeV1UwVDMm1bX1GRW+N2+ZJF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BCfoXgG8BuLc/GFS4qNim5ZCivG1RSbX1k0AaKeEuU8w/BxYvh3ABXOYFT0husLSiy6MM6YQD+lEIb/9T2KlQ/4r7hKUWweN4Hg5tn49duivk28MgjmuxWHyoDmuPIR79x3Z3TywWAoqPDtbXeYnYODy4sMsB2Vhgjm/yf8e1YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UO4WT6Fx; arc=fail smtp.client-ip=52.101.72.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UO4WT6Fx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgUqakUShKlA7yVTAx8PGWDMcPL5I0VBghwEWZtaI8CVmibyT5qHl9qdwRIVXNtPqykO879QFCrRPGq8WBDqf4fBuXDus3FVk9doupQAXoKcV+SK41GnYprc04ihcrBeCjlTDY7uyssFgePKyKXNqtolmRAbd9TWNz9F17A+faoVJ3/yHIqzdxvwdTBS8qcAozp/2GEY2xnvwf5ukMEqnv5GGG+dNPPXOOuD2J0biZ379uDq0wjp/u98VZ5f9ww8kjkjcHXhwnSDR3wLq2TlrW+f3IZNuX3xhB1o+lFBu9e0HI/FhpKsreNzp5OwJWuUHkDExE5Scui3m0sVBDYrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aATbBoFQ2434QAVnaQ0IhzAChvgq0oIvxbfkUlfMGG4=;
 b=aKXS58gSWXFdT/qXNKvnf508WKDZ8vXDQ/kRWmE/SYRAmwk9DDNhoAhWXDQBLj1f3xwVCxT8o2TleUFI+UTzW1V5dJG7WZFLOu/p6dgJdXiSIV/M9/YQWcpMYj8WJ5O8KPvdKsta+mYWCOduS367uO3rWjSUjUpzuJM8vn/tOfbcxANWQ3ihrGBE/nSgmFN9AcQyfNL+7P8yz+0Er4qXBI71VbEi33MgzxylhzfmGAoAT5ird8VHDmb/C9U8L5S12LYJFpOgnR8tMv/DvXuzPUzRyZKdUsdpMluzQAd0oiSwsvDIWyJLvoimzlwflL0cpm4T/zqvbvJiwj5sCm22bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aATbBoFQ2434QAVnaQ0IhzAChvgq0oIvxbfkUlfMGG4=;
 b=UO4WT6FxDj13UNSqbkEFeVSxAGnWeE86x6Ytm5hX68PdA75ZrHQu4IkIbmeNukHc0jZaeJCKHccv/sRbnqC6pmzL69/cBZ4fXNnega5pdWAM7ozgKsenCpbjxdsWjGfMw6upy/+SXAeM+42pfPymFroAo+0UWyOFNBQSLFsZQRvhAx+CvYPHkg4jfsoka+iGLiZ10eJ44M82h2rqyHG+VLNgJiFXYJeVQzv9T9VhUobyVoNq90B356o9i8leC7YiV7+hAJ4z7mZ/cwAmSp3GB8ZWs30SmyxudX5tcIkFMkhrRAdhJVDq0NKcK5JbINO7BzXwjMzObZh4822gCMKsCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB11079.eurprd04.prod.outlook.com (2603:10a6:10:589::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 16:30:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 16:30:53 +0000
Date: Fri, 17 Jul 2026 11:30:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Add runtime PM support for i.MX95
Message-ID: <alpYsyuDZxmy3v6a@SMW015318>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
X-ClientProxiedBy: SA1P222CA0147.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB11079:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e38cd1e-d03a-4d35-906c-08dee420c548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lqp8WSS2GL86i/gNBy73x2RZDX9Cvc6a5JluUsd1d7rYbQ2M6aTxE031/E3gavCE+f/YFnCnQPccUGo8xdec1n8YwgEGpCbJSeJp+NkWiV0N8ayIZc+3yGJXAJ8l1tKpD8kVkKz+J158vgFdvOigpoDf9hHqC1jvM7mqcmisBBR83OQZ4NjVbfaMSTBPRVwoZWCp5IUcGpGEG2ETX5y+k7T9C+Kb6ZD2Mvf1nUf3hXDxsfnv98rkKSIIV2PB0+qZ4vtweZAIuLxl54MpEDM1ALqecYQnvMQ+FvSuR9YJkDX4fI/PSbNf7MikzYkmGRDprm1qHhuxOk8QfxMaHGUpPoLwqt3SKUt2/G1+owNej9OQraBbn7XbA3MN2AQoO/vJuatQx58Jc1elqCWzcP7lraJW9PvvDNoz1qz6ZDQhEXJFeI7iN5hjtyD6KXI3k3KeGtRpFU9zmaJHFUW11z5AI1SX8f+B20ttzVKDSMqItlhUUbGhtbIuTgoner9RfHkKrrJqsjCF09LIMiSl9hjkRUMPZzzDnYmkt63rJ4YGyrjCYULVrJ9wgPMZf3aSkMLjow0/5v4PsdRVI1M+oE9Bwcmp8SCG5dYf1XCH64hv+S06s6f/bhjO1EMYWKXPTI2Uz/gsIpDvliij+vOPEuSddvVL0pX0fKGjYfXMiTziW0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YZyqVQnULanQ9jNOv1qFHKOQDoQGrqoE9GQXAH5ZJFCfBX3akvtWtkp+XHg2?=
 =?us-ascii?Q?PqwIbYcf7GQ2lR6I9kw7waIBM/GBfHBfs5TZXtVx2hVAzdgpRPzLeNjsILh8?=
 =?us-ascii?Q?rp7TYxr0g4m/IvfZQChFeeaOy6FuYsC7XknUYUUC1ER32E/5lRz46XXJFXqm?=
 =?us-ascii?Q?ecRQ5vshPwTSIBb5vQ2mZ7h/SCEM6q89YPSrYpTIQFTy4qAThVrmXLpfD+Xf?=
 =?us-ascii?Q?o3iZkG3FdbFN1AFkVFB0iBQZx+3PJk1D7tNmnmbx7ccEQ8mQNv7H9qQieAir?=
 =?us-ascii?Q?xdRjyjtooDf9+DxfkYFCpLEVOgWRl1yO2ArWXyMvFikkgb6iMmOQhQNLzhTE?=
 =?us-ascii?Q?fyWpxpXVWRp3t8U6MVtaDSkDjsT1w9x8Nm/7vmK0FJGJ+ce5m8HbGEEo9kt7?=
 =?us-ascii?Q?0ge7/JnvUfL6sUxeJ+0VHTH4EwYeim8iuurXXIezlo8vmnsFdrzCgy19zNxC?=
 =?us-ascii?Q?5VoWfsnrKaGWZl0BiavKA8FFnZHsAMMcpFlIn1ug0Lt4zCytOFeFIeLIZ5P0?=
 =?us-ascii?Q?BQzNGTFdYhYugKdp+aOTCLOLEEIqZrR73yh2Fh4ROdbb20Fzbg4G07xU/H50?=
 =?us-ascii?Q?bw7LFF5uHzRDp0CfM+/uQK5tpkbiTei/Lnhe1AlbG60mJq/nU4VlYljZILJv?=
 =?us-ascii?Q?M3aXS6vpkHSE0yQDThMXJIo9UGW1xbrH+aPyR+yO/8BIpEtX3FLrORHcMezs?=
 =?us-ascii?Q?tBHFUEm8GbOdV/I80BJP57V9QsgpQwlFPp/GGInnyfymT6FpnHY+V1eqAcr6?=
 =?us-ascii?Q?PZwjirMI0xraqDml2c4KhShycivHVR51gOmXM3LP1cX6zw6y/LM77mPADiB8?=
 =?us-ascii?Q?hrhddnWcXN2Ldo1jjAg5Uw4TBicvLES+FXbSsC2c+EneCPy9W8iSrZOojcLh?=
 =?us-ascii?Q?UncYMG/OkZXcN6NIgxXuk5KBIGujj4v16EZPzn7orjJ6yLuefP9vZnIGPt8z?=
 =?us-ascii?Q?yKDHgIbIYNMizIEn/OwMZv9YW1JlZbYFOFAnjpsU3ecZtEUgMYjSj/l9Z36G?=
 =?us-ascii?Q?acvbKxHrKrBfastankwRKnG1JYrUnhvIMbXojonPl/5OT3oIUMjAd8gT7aMP?=
 =?us-ascii?Q?dMN0xbAeaDoe/vhukW2xK0IFnHq477Sdkm3drIal1RiMn/dpP4PqBwkHJ3Rb?=
 =?us-ascii?Q?+VEcxLBowLj0fVch3mHw2UamhBdU3DUTlh2zZIqpuin2yBhZPstWyHaf9QKS?=
 =?us-ascii?Q?7hh9hfQB/dVUKHjCEhiNVP53fKWrd0gYd7xxfn5XvjHuUtd77dCJ9EIz9QJj?=
 =?us-ascii?Q?pZzrfoREAmYAh4HdPSN0RTCMDBWqbzVLdlZf3uxCXUoGsnuoN/gXS5srlkDN?=
 =?us-ascii?Q?W17PxGqG/fBY36muOu+dRW6IYDjQDaK3yDVxH5uluroqJNnn+4imzF4PSYRC?=
 =?us-ascii?Q?c4GczbTmQbcctPCSvgJRvFQhCQPTU8UiSxs+d8nyZJZlQOCW7rmwnvaIjsHG?=
 =?us-ascii?Q?C+z7uaA1gloxyF/RU6wokMJJBd01RjuVjYhjvOo6yX/JBSlMcT6737OgG21s?=
 =?us-ascii?Q?42b+7s7XrkkzQvDp22CJ0UOFlQdMMVtVRCNwmLN+S4dysqnZkwKdZIPVGcuo?=
 =?us-ascii?Q?19p+qvotWkcfsrT6Uua6kDY4KaCo2JfRs0pdYhwPiBt81RXIvg6rmKTlhLEg?=
 =?us-ascii?Q?hG/FcVfRess709Uy5U5prKVjRMLEiTcWL2e+qjgnBia9+cMlhy159UD6l5V+?=
 =?us-ascii?Q?Y5ZgphDoJMqJA0Jowcvs7Qwb0XQ3NQwkiwUodxDcHLAs2JzCEh93wBb/slfQ?=
 =?us-ascii?Q?q4gD8pHTGlI1LXKj95oOi0RdOFUpaY7c6jIxS7MqJJCnYE0UUEjb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e38cd1e-d03a-4d35-906c-08dee420c548
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 16:30:53.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfET5f4yM6+z2Fk//vO66u3+Ggw2AqXBZg6Q59I9N/HK1nPxf7MzqprvIIh3KVvY6G/Y03mdcHxKZQ/nm8cQk4OjqmCNnsw6rINNLEiyMefWOaMyMWp+sS7YnF4bMt1n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11079

On Wed, Jul 08, 2026 at 11:59:26AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
>
> Enable runtime PM support for i.MX95 PCIe Root Complex to allow dynamic
> power management when the PCIe link is idle.
>
> The i.MX95 PCIe controller supports entering D3hot state when PCIe
> devices are not actively in use. This implementation uses
> pm_runtime_no_callbacks() to leverage the PCI core's generic runtime PM
> handling. The PCI core automatically manages D-state transitions based
> on the runtime PM state of connected endpoint devices.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
> Use devm_pm_runtime_set_active_enabled() simplify the codes and error
> path.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index eae495a1b7990..578410f262aed 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -130,6 +130,7 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_SKIP_L23_READY		BIT(12)
>  /* Preserve MSI capability for platforms that require it */
>  #define IMX_PCIE_FLAG_KEEP_MSI_CAP		BIT(13)
> +#define IMX_PCIE_FLAG_PM_RUNTIME		BIT(14)
>
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>
> @@ -1973,6 +1974,13 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		 */
>  		imx_pcie_add_lut_by_rid(imx_pcie, 0);
>  	} else {
> +		if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_PM_RUNTIME) {
> +			pm_runtime_no_callbacks(dev);
> +			ret = devm_pm_runtime_set_active_enabled(dev);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
>  		/*
>  		 * i.MX RC is powered off during suspend, force L2 entry to
>  		 * ensure proper endpoint notification before power loss.
> @@ -2121,6 +2129,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.flags = IMX_PCIE_FLAG_HAS_SERDES |
>  			 IMX_PCIE_FLAG_HAS_LUT |
>  			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
> +			 IMX_PCIE_FLAG_PM_RUNTIME |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> --
> 2.34.1
>
>
