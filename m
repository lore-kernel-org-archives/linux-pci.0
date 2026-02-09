Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3D3815FE;
	Mon,  9 Feb 2026 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654940; cv=fail; b=V8ZBPYkHHLnCfufzNuLZkgaXOQEMLxDLeiijAlE1lzR1lZq9Tuox682hZ6sd3noY4l3oLCsUBrG4/LNipr3lBmsdo/RBJfWCs7GOeUWxlPjHh8h2flgsDlf4Hp2HHpPk9ThCJYiAQqyR7dhYGASX4xZ1kerGX8VCFr6ZNcJ8TBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654940; c=relaxed/simple;
	bh=D1ooaMpMzhtSNMlszRq1nXhYmAzAIvn0soLVYEpCjTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=khSpS5AbvpMfzKiUvSL7d7sCaV2jLo94Fzdf7yBlqSYlh0CJ1xuoGzrvYt6dX4ljpz5X9pNnGjRACYKlqOJIrb9Xp6gxZFoPm8YL6TaHZCrdOyn+JmZ2er3B5CPzeYfSdaRNCQJNwR0uS2ljUrDTjtKl3SUxIc7yrM98++gA9/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VOvKC/XX; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VOvKC/XX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFKe7UWbsr+ADruhRThnhwbnglqb44I6uSEZjwp6s/sngZ+lSAMKuI4snQO+mfV/iVMZU/lntNknyZxvz36Wd/RD285xgVh0VgG83RucW6Y78OjYfR7ExyngC4eubGPBycYRufjU0LWlKxHTZfzlO1IGNbXBjXasMJ7OYKjYhgqNMCM+KS/gEgsK2/XJzJQyfTtXc4gAe8b5G+30YMcI68JuEkJhisYhRYg+ilq1ICW94zk114CYguxshQZ4QITcIj17VDZh0RLNdhJ1R33udz37Fu8ZSokjKhCLa+Tv+Qi0Qb220G64POZr2+Gzjuks/6Bxs5J0q1g5f4HPaQagSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGpyJxFHeumfOGoucH3WKy8T8Gi4HOi6ZrStS0+4XXA=;
 b=pXNfizlVolp2GbT3dkldoA2Yg2QeW7zGhw2sVerUj9N1hBdxE+QpuEwuPaNbBwJIRsiyRDhQIZ+/1k7Gbsizm6qosrXGHXosH6QTzlSqLiu3C6PxGU+GYvMH3moSAxuFKGQViX2Ef8pjLx9TAwZITQdcUBfHTtDU6jDfcN0wPDLni7eTZ4sLuuh9+k4BOkNnPGyLMHx3oGs9Ab8tc4PxMbmx2U8Vx2UtirxMKZrHTD9wnKWjbzuDC+YYkcblAqPMc5lx8aV/zvR34QueUEPJpDASRi4ZkPLoyrZbzgMLKi/i3opfbxNEb8JMWptZuT8BuyasRwG1Wf3mxgH7UVemSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGpyJxFHeumfOGoucH3WKy8T8Gi4HOi6ZrStS0+4XXA=;
 b=VOvKC/XXB3PO/TSdej30AS3Dlg2uWm6Tvw19Ixg+jDt/s7AMIgzHGGHQB2SyIaFlH0KYRA984OwcWLlCuxfzsh8YKLFFmrlOIBbkauoKc6A+NGEHE8ILjtqy9qYxjuhNMUY5x+18+u6KnaZgscLv2TRRTzrgbAxWuF+u2u+WcdosxRu4vTAY6zXOb17BKRiIEdIYjC0CNPELGcr4jGFri5Le0wQPdFb/EsdoJ9l31jzWftI0ZaZkt1L3OcW6qyRvgS4Y84nQlm29qCXWInkwIphE/2UZSlsq+4ZTqi2f45Xa0umoe2pqfqVB4Ulh+tz9iBR8UR9pA27mU4624c8+Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10575.eurprd04.prod.outlook.com (2603:10a6:10:585::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 16:35:33 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 16:35:33 +0000
Date: Mon, 9 Feb 2026 11:35:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, will@kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 03/11] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Message-ID: <aYoMzM4omurMaJw5@lizhi-Precision-Tower-5810>
References: <20260209082454.2097628-1-sherry.sun@nxp.com>
 <20260209082454.2097628-4-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209082454.2097628-4-sherry.sun@nxp.com>
X-ClientProxiedBy: PH8PR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10575:EE_
X-MS-Office365-Filtering-Correlation-Id: d198b6a6-7311-4898-e797-08de67f93ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CHsjlB9VP12+Z2ALU6JiYjIXapGgWdNeDvojQlRsSCN/Rcj86JA/V55jwUUb?=
 =?us-ascii?Q?lHHB8Q/LIUwgKgzO2YKTL3tvDLlfezowewo8V6LMewKwszEX1oiXFVkpP+99?=
 =?us-ascii?Q?oFTKBTnKmAwxCf5CNy6QnP7WxnAZknljACTHsukuj2QHItwKq+18FH986GAr?=
 =?us-ascii?Q?nfW3pgLklsT7IXigxl+T7dUN+5HWDVscglgQ6koW/u7jXkAb1xgiqEdHGlDj?=
 =?us-ascii?Q?yUn9cw7bM8rzubuyY+E3QMm+rJm0SQvBF9YdTVnH5BWG3/Gq3fN1+VzwM7GP?=
 =?us-ascii?Q?phvLchtcmAWaIM8XQerAtZpgH+UTzjAI6QPQekgB7XtcjMpf4KhWkVzf8Zqo?=
 =?us-ascii?Q?xxHLcer95JN64RtLlEfIHCJGO3E7hfIdXo0itU94xRgZbSFkkG5RHTBPLIKW?=
 =?us-ascii?Q?Fpsqik8KrP5+tbk6v8njdnvn95PBgyLtNXutQr2P1j1ijsblcVmibJfNBc8e?=
 =?us-ascii?Q?FB29b9zS92YOtaDIr5IO3oy706ra+wNPM2zr7WXd8MzzCAGIgapgtOjODj/O?=
 =?us-ascii?Q?gZmdAHkrm8S6ubYUBPbrARJyKhfH0u/JUfNtV+Xkft9FdN/J06NMZN6U398Q?=
 =?us-ascii?Q?PscLcP2iuYJYJQKZITZjMtgyx7GfgawOFgMZdMOi9C0rZtio8drcRZFCtodO?=
 =?us-ascii?Q?S95PSzN3+AkmprBFWaiHEvJNx4gb5L+SRZHnXPlvnPVy9k9KSLz7a+Loq3PF?=
 =?us-ascii?Q?po52jgSWNWoqjebIE3j9Ud5+e0G3Kaqq/SbC8V+aKWAuHmtiOMgGm/EBb6xN?=
 =?us-ascii?Q?gJrT1lph4xv6DpErT18vAEpANvnJGviaNzMHBFZBnWmUQYbnKu91XS2/qpN3?=
 =?us-ascii?Q?Z30XvxriClmrrRgWmKODM8rhuJInggkhp6DJPr5XSYC5CMHks0mDqO8znLTc?=
 =?us-ascii?Q?Dd9in9Bldxixp1RNGkU0fIQwsw81I4b8FHpyjel5IetGbD6D4Hid1tiAflsi?=
 =?us-ascii?Q?mgIXejDJTYGdyNihJ7emTT9u607WfOp9XqguSm1eJinoUvkMMhYS8HIJ/EI7?=
 =?us-ascii?Q?D2ktemtX3HvphaLP4Z9T42LMTdupHAeRZtSd5FDmMqYFPXLNfDja42kE7wv9?=
 =?us-ascii?Q?oQzCaXr/xZlMUM73JrfnydHQJWgwkLpTJEFoBXlB2gMjHyGDUOdbGnKw3rvY?=
 =?us-ascii?Q?r5ov3uwJnyrm+sUt2zGTLs8+ijiKqGfQDsMKzu0omeq3C7127GoYd2HIB9ee?=
 =?us-ascii?Q?Ep4RQmOHPeuWcz+TazFn9bq7B+gi0w5YF6NPBfp//vNKBpcyOrfi92OdeHtM?=
 =?us-ascii?Q?4VZT9AVviqsWcHpa1gs51T525vfcCWv/+6K/I9Qm2vn0PozR3ktEkFh/jyeb?=
 =?us-ascii?Q?RQM83gQBrMNP3fIJDI1hY9ARRMRWMd/H3b7Yg7nQbxN8OMDbwQqdRGgCDgOs?=
 =?us-ascii?Q?A97fW/IATSYW9bLaTHTqD8Gn3Vsio1dtb52dSs60kKRQivpcnyK+ZaV8NsoW?=
 =?us-ascii?Q?8iAcB3WaSoxoDaeJ/OcS3HUyJplrJxHZocqkoHowuRzyiEYCOAdrKHjUlVdN?=
 =?us-ascii?Q?zmc4/ih41M59kvFaJCTigdaUa5Fr6L2Po2gzV7HWd8zDamG4hzMxzphLygnE?=
 =?us-ascii?Q?u5LFVBcrCT3KQJSazKiaD+qTtWX0uK5p8MT/ha54h1s/311F9cIJxNh5H18F?=
 =?us-ascii?Q?r0iJ7J2FD5isstfGK2AZjGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t3cLE7t1icUwcfQ99mkowbUBJiAxkDlL79lwYuxGitRmKZ+E0AIRpQTE3bY6?=
 =?us-ascii?Q?o5ry16Wb8R+N5Ecwzwbtbk2xORWm/v3cRW3W+bI5iBAD2VfUefXbbm/+TM/t?=
 =?us-ascii?Q?9rxxqGp3Sg4BwhikRMaTUTn8d+SG1nwva1GxWVjtvt1xEfPrwkH2qGFKHP3o?=
 =?us-ascii?Q?NMZzKDdkA50Trzuf96nB+CvH5I54eEZ6yD+WUSWz9ps8+oCf3941hFwxg6y0?=
 =?us-ascii?Q?Yst61zpzQkv2FvYYGBrwpH0erh5EJAikFttIcFt6/pUXvRl3wOj1W8ThIYkH?=
 =?us-ascii?Q?/eN5hwKn3pRHJbuxr6T2s+q0bkRq4cJrECDtuWWh17xGX0YoEnIAegWERkSI?=
 =?us-ascii?Q?BEGT71WBPBjMblGpPmyV+fMtekYhF/kDk6VvstozRdQkZCMt2KK5TZGCcrpy?=
 =?us-ascii?Q?VO83wy7nrrupDZJ/VAkuGrv/vMyij08i7JEEtuK0TCrEmiADPNy8AshA4ofk?=
 =?us-ascii?Q?WWCJXanIUcblc8+tD6yPOGJfvrT//URdrfNxA+N7G6TvhZE1MbWS6+txhQrE?=
 =?us-ascii?Q?8jTxB596lu44P/G7KJU/KVxthvEDub69UhcX6GBmTsGOEG2uMg2Mn3GtWgLe?=
 =?us-ascii?Q?WqRq4S08dnMyVdDSloHEUw38Vzhlz+dznJJyxzFy7VoM8TR4WP5GwleeI0uY?=
 =?us-ascii?Q?8ft76Kj78NUnaHgkijLUWmvWLBW6UdV0IDu2A5NsPKudHCn9lJRgdJNU3ogf?=
 =?us-ascii?Q?beIaCKLD+fJ1kjYWvsiPKZcCgSw/mEJVq+rZr9oaTHnq/T8ba5itav5MOdC5?=
 =?us-ascii?Q?LyfSbVFZQBz6NFNtwbX+ko4VMTAIZ9YEV8p+KYDmR10uNQI7FZPgVAPUmWbs?=
 =?us-ascii?Q?m8pVeaWbtFyDZUq/F6PcCiOPKAReQazIGauNA0SSVpb0loQiUqqWeCwoF0i6?=
 =?us-ascii?Q?cN3S3utakQUx1Ljg8poTOCxUufrUjXVeGP4GZVpVAj3Ye+z+UtYJmb0T2uqa?=
 =?us-ascii?Q?/08AfV1XigeMQ+ZEWGVsa5yTYKrhs3HqC/TaWB9/x08QBvwVfv5AAoY/vm/6?=
 =?us-ascii?Q?UKtoR2nhYiElKXMDqfc8eRKWHzercmPsmQ02gvgx7bBX+fhmhZRvoXF06+Q7?=
 =?us-ascii?Q?l9HrCuEDwXrMBusgqCxiK/6jKYomh0FGdFBUkvBCJqTE+WJD1ZMjgPPCsj27?=
 =?us-ascii?Q?wSCN+BBBf0rbU3MCUgf2N6VzEmz00ZPOCAVwb+Syh/Ar5+6tQrgRv4t7D/hH?=
 =?us-ascii?Q?d/dnaixhalMzDRz+cVLFOJBppD1iOPjfyypIs/R4zEY7Vmx6hL7+ec1vTb6H?=
 =?us-ascii?Q?X7liY+PPogBp6SzJDIN9IFsJFlmQgVEVxX2kFMrURvvSQ/bZexWX+5HE+d7s?=
 =?us-ascii?Q?BE/3Cw+WeOr0voQm7AVy+AnCILRaOEIN8sVirRmERzuYW19uAJ7zGwqMF3UK?=
 =?us-ascii?Q?oPRzEH5xiGQIAletU6rJ6nKl/Iim7RhfP/FBYKDC98YNfA5zVemzCCFx6EJc?=
 =?us-ascii?Q?g2CEM+ejJ7TyZVTFX388oLavpr2HvdyLpvqxnm6mHG0VdMtm18QHwCnh3F4U?=
 =?us-ascii?Q?OHR9jOEuE19DCKeZKW1UL6ZjdglAV0EMRoY3fxHPp5W0nSaugsAsYh7Jhzpq?=
 =?us-ascii?Q?E4EmsRuVhZIM2teLuTGXat+T9JOn/M1MZFlyIj+ExBCww4vOxjo/L6ERCp3f?=
 =?us-ascii?Q?edxvCU6jUAtIRnNNPx+1IWRsCGh4O4J6taSJ2Q5boLZNMNnrBskDWnJlK1oU?=
 =?us-ascii?Q?akJI9j6p/2lEkM/0eL3vW2mT6w1JHIIX/vxyoqcxaRj01puk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d198b6a6-7311-4898-e797-08de67f93ee0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:35:33.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GapZT1BKimp9OTTG6rjC6BmT0BbqgMPcPnerk996BOnjxNVL4CtV+fGcCNlYusAZlWfAYleeXk4bi1xzGbyVzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10575

On Mon, Feb 09, 2026 at 04:24:46PM +0800, Sherry Sun wrote:
> DT binding allows specifying 'reset' property in both host bridge and
> Root Port nodes, but specifying in the host bridge node is marked as
> deprecated. So add support for parsing the new binding that uses
> 'reset-gpios' property for PERST#.
>
> The initial idea is to add the PCIe M.2 KeyE connector support and PCI
> power control framework to the pcie-imx6 driver. Since the new
> M.2/pwrctrl model is implemented based on Root Ports and requires the
> pwrctrl driver to bind to a Root Port device, we need to introduce a
> Root Port child node on i.MX boards that provide an M.2 connector.
>
> To follow a more standardized DT structure, it also makes sense to move
> the reset-gpios and wake-gpios properties into the Root Port node. These
> signals logically belong to the Root Port rather than the host bridge,
> and placing them there aligns with the new M.2/pwrctrl model.
>
> To maintain DT backwards compatibility, fallback to the legacy method of
> parsing the host bridge node if the reset property is not present in the
> Root Port node.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 69 +++++++++++++++++++++------
>  1 file changed, 55 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index a5b8d0b71677..317a969da96b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -34,6 +34,7 @@
>  #include <linux/pm_runtime.h>
>
>  #include "../../pci.h"
> +#include "../pci-host-common.h"
>  #include "pcie-designware.h"
>
>  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> @@ -150,8 +151,8 @@ struct imx_lut_data {
>
>  struct imx_pcie {
>  	struct dw_pcie		*pci;
> -	struct gpio_desc	*reset_gpiod;
>  	struct clk_bulk_data	*clks;
> +	struct list_head	ports;
>  	int			num_clks;
>  	bool			supports_clkreq;
>  	bool			enable_ext_refclk;
> @@ -897,29 +898,34 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
> +	struct pci_host_port *port;
> +
>  	reset_control_assert(imx_pcie->pciephy_reset);
>
>  	if (imx_pcie->drvdata->core_reset)
>  		imx_pcie->drvdata->core_reset(imx_pcie, true);
>
>  	/* Some boards don't have PCIe reset GPIO. */
> -	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
> +	list_for_each_entry(port, &imx_pcie->ports, list)
> +		gpiod_set_value_cansleep(port->reset, 1);
>  }
>
>  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  {
> +	struct pci_host_port *port;
> +
>  	reset_control_deassert(imx_pcie->pciephy_reset);
>
>  	if (imx_pcie->drvdata->core_reset)
>  		imx_pcie->drvdata->core_reset(imx_pcie, false);
>
>  	/* Some boards don't have PCIe reset GPIO. */
> -	if (imx_pcie->reset_gpiod) {
> -		msleep(100);
> -		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
> -		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> -		msleep(100);
> -	}
> +	list_for_each_entry(port, &imx_pcie->ports, list)
> +		if (port->reset) {
> +			msleep(PCIE_T_PVPERL_MS);
> +			gpiod_set_value_cansleep(port->reset, 0);
> +			msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +		}
>
>  	return 0;
>  }
> @@ -1642,6 +1648,27 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
>  				  imx_pcie_resume_noirq)
>  };
>
> +static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
> +{
> +	struct device *dev = pcie->pci->dev;
> +	struct pci_host_port *port;
> +	struct gpio_desc *reset;
> +
> +	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->reset = reset;
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &pcie->ports);
> +
> +	return 0;
> +}
> +
>  static int imx_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1660,6 +1687,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>
> +	INIT_LIST_HEAD(&imx_pcie->ports);
> +
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>
> @@ -1688,12 +1717,24 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  			return PTR_ERR(imx_pcie->phy_base);
>  	}
>
> -	/* Fetch GPIOs */
> -	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> -	if (IS_ERR(imx_pcie->reset_gpiod))
> -		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
> -				     "unable to get reset gpio\n");
> -	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
> +	ret = pci_host_common_parse_ports(dev, &imx_pcie->ports);

if API provided pcim_host_common_parse_ports(), needn't below
devm_add_action_or_reset().

Frank.

> +	if (ret) {
> +		if (ret != -ENOENT)
> +			return dev_err_probe(dev, ret, "Failed to parse Root Port: %d\n", ret);
> +
> +		/*
> +		 * In the case of properties not populated in Root Port node,
> +		 * fallback to the legacy method of parsing the Host Bridge
> +		 * node. This is to maintain DT backwards compatibility.
> +		 */
> +		ret = imx_pcie_parse_legacy_binding(imx_pcie);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Unable to get reset gpio: %d\n", ret);
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, pci_host_common_delete_ports, &imx_pcie->ports);
> +	if (ret)
> +		return ret;
>
>  	/* Fetch clocks */
>  	imx_pcie->num_clks = devm_clk_bulk_get_all(dev, &imx_pcie->clks);
> --
> 2.37.1
>
