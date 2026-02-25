Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082522A4E1
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051050; cv=fail; b=sXCY+lbVDQdB++aL08C5A7Q6H/QGlWxPRi+eSKU+dowQRmr9OOp/Nh1ZuRcQBKXCj4wu6eVzEg6t4qSlwhjnltI+Dg7C6BvT+PH5juodBCEL3hkWnENhPIehhObS2pMi6VVVOu6TrqWfrvfO84XmKjy2m88kAPczvYFl7N1JyyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051050; c=relaxed/simple;
	bh=iDFYXZNO/yIoW74YfUL757IPirgN6/wa4LTpA+Jy8+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HhmQkVKgnztAZ3220GP14r9b4rMD09ORYOkvqDza+n9zWmbkh2qFRLi8D5s2e/dysyy4OAtLc6M75XsjL0+MbQqzyJX25Yu7clDxyPb0bjfiIkqS3xtfaSHuC5C/+NcKZ0uokvpr4sKgagCQtV+4m/lSHOy3rOtWabG8ShysrlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O0CvgWZd; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O0CvgWZd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9S5SAlhl3++wy7IyHAsv3x87Ztvy4yzxZjqONA9vD/v4ASKmeVWtP+OGX03U2ZJFvtKGQ3pm9kGJ1RhzIlx2zJZbZWaRHLdPC7P6cBB7Kt0VGbz9n+/znsXAFmwi55r7Fx0XpH2MEchR+be3ZykKcAI32T3wEPzjSwHX7HBb2iP8mczkvYCxkh7f89sFHvgNJ1/cYN+XvRCa3CjTmJmmDtciiaWtjyUSdSttHn6d2he3VcJH5+Z0ihxgfomH/QqTSSO0ZlBwZR559Vx8WB5D8lXRjctPW4nESmC+YypKWJMhxMT7xBaFAQfZb0uc9KWnNq4uFV3xF1r6osXAvxyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuMlvDhJcfVbXLAuUyEvxwJePaJUIlz+oQD/CCzXYvw=;
 b=jFiHWKf1qtiHk3jdkltCS0tEtKvEdVLd0MbkxHUcWp1P3U0v4fO3/I5idZZv/Tvb89+afDhsnLCwN2KVk8cwF0e/SzPXcOuFkklqdmF/uDAGh6uVemPeCRhs0L3lw9ccdrWHSCaxYTkKnTvCyFhcpv32dUhOMJWVP6p013WaCJkrxPskN1HolGLmLH4IOc7n0Xr9ZwlGP0wjOPb6T7GanaZ8qWUgps/scOhmvB55kOEQMYU4tvMl6hR2g/S1fPW1JM19hLlN6AFw90J9j4iyGUjED+b/LhLCorp+M/wSAckZqg5jx+SN8NnaHZdOfYmclGcgCpB0d/ltYpOcYLxfuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuMlvDhJcfVbXLAuUyEvxwJePaJUIlz+oQD/CCzXYvw=;
 b=O0CvgWZd/8fbEhUlVqgOF4NZHQ2uXCgUhMZH1TdQ63xTf4zk9Si9NaaIhtfMs8o3jmVk4EHa2L5y23V1Dz2ge96dfbBawFjFElmOX9U9lqb6Webkvx7myErNVvDkFJaE26oPGTpbq2IRIs0r32siZPTbL4jLVIVvmXmjztXSYfW4/MUlMugoeh1kzR5xFFfRR9Mk9vZit3kciAej6s7SLvMPpj/O+uGr2trbqhsvAUlZPUNFJq/8zXBZ9UZdMROT8jwlPxkbQoOojmpKykjfv8QnEnYkuuhG8eeFDyIOed/mWEgjL0PAZ6e6I24XExp2KqoNo8cpbgM+72W+GbzSlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB7172.eurprd04.prod.outlook.com (2603:10a6:208:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Wed, 25 Feb
 2026 20:24:06 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:24:06 +0000
Date: Wed, 25 Feb 2026 15:23:59 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/9] PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl
 window
Message-ID: <aZ9aX2ZzEWb3YuUt@lizhi-Precision-Tower-5810>
References: <20260225170324.4033466-11-cassel@kernel.org>
 <20260225170324.4033466-14-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225170324.4033466-14-cassel@kernel.org>
X-ClientProxiedBy: PH5P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db5b2dd-a172-4b90-5589-08de74abd2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	fceCNGuQLMS9oDZKVzUiZ++DTrXwzfu0xp2IzGFY/eWc5UjiPUoaX1Ibe7+XsCG/seW5EJX5fy26Oozw6XZlF7qszCzRu7Eg0SOXT0iDZ4rqWlz/KjkrmxwlqrS/epBXgU9LulnAj2a6SHaVLZMKmibcufpyMzqWQpTdEDmd0uSwPRZR2tiawBCFZVHQWFRgjL5nNihe/VICG3BODFMJtHHlp1/3P4owXd4OOsbD3SrFFooJIVBhIOM9ZrIhu016nytRo9/l/NQxvpRd8yg8aMSz9vv7l+ZfWMq4LKIoeH3Ud7a64ZyzElU7edN03p+f8PWx5Qrvwkhijhol4XBA4tJIUMaVneY7igyae8b5SrcjQd9LZDUz4/dmA/vqJtDCfL4i4PzrNCl+eWLGQL+RD/wG+uOMIIjwJLebh6TJUOAYLZWF8JH4vJ2S8qcmOGhhL7ZNR4jsITNLtvNDvPJbVdUPgiq4WHutDGeKNGqcyUu3eIPQK/LPwanXMyAOPDefeipT8hjmCS77EPvg5gDqRly0kAAN1vxb+FWGVVJowNvn45ZByFmuczJwmhpnhCSxnyADyf88RArP+A9A5uMWTdUkRF0QeUSwNSrb306D+q4UeLdVyllgylFoqYTm12Nrnr2bIlJrRkv4Z3jEILlQggEDHKwlyNjRBEo6GvCZXteGhYGOmMih6c1nd9y0IKc1DOb2Oruh50wdVy7yNJTKXN9ODZreoAXmCWPsU8xRLHQtajLo09YzIBQ717sYcwPJm2jksopch5qGBviPmH1vZ/1X3LolpSsmSz6NvklvmqE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uvz6EiCQD8CGq57N5Mou07Ig9oTssBTnfpfyWQlbolNJhyhFm7U3kKs3s7AR?=
 =?us-ascii?Q?cI9Hb7uU2dUEzMxRysvnMDYdKCOb1Cprn2QvQOOENXw7U/wrfQzKC2m+FmxD?=
 =?us-ascii?Q?gZb5rKdtdugp7WSf53P5JGzGAqo1B+zxogpdLuaa7SV7mE5HJXIAz+UtoYAq?=
 =?us-ascii?Q?oeCNJhJQM2UoScNAuUDw4bWSET1o2SvL5LoATfFmrTIW4Rx+zp+G+xhPzhsi?=
 =?us-ascii?Q?z1WxSWfMwAl+m6iDOvijUao57A2HvW0nytj0o1Rphk3hXKqZcZvhwIeyMC67?=
 =?us-ascii?Q?2X2aLkfJSiOgL7R4gnXhkK0OXdhl672K+eXVbCOJN1bOB/F2niD6MzHImUcj?=
 =?us-ascii?Q?GlsuTTQIFJT1ctsRI8xtv1YoJxsXMxwNtltB6/CB2tRTMUle6PWUDX0s65Im?=
 =?us-ascii?Q?b2hmNP3yTs+mfAXtNv2j+EBLCQpXsieN9EjT8Im5Wx8QbMm39nhAQHCeLn11?=
 =?us-ascii?Q?cL/4/5NAUabWJHJKdzNsMnkBKay1vs9Q3eqS4oA5YhBDcXaldC6m2ZEDeUI7?=
 =?us-ascii?Q?hhbZuBmLoxlRWIOmgIDZH9i2Wh0Os859UQXVx0UB6WncUcb57gzggoEBHFw2?=
 =?us-ascii?Q?Tg5rj/Il/62S66sdRvutJ0A5NvKYZYbJwPh8q681UTkW1Flwk84ksuAD680B?=
 =?us-ascii?Q?hMvT8yN/XUDpOvNeREYjNnSG2SiTgZ2CjFolAlSy0b+LGJx0xAop1xRA9+ok?=
 =?us-ascii?Q?2yzBl7//9OSFPPAf21odB3xiXvj3wqd+mO6m/v5yRXFhvhP7bU7w/IFAoj58?=
 =?us-ascii?Q?bLrb36t5bJtRCB5hELFEF9tmIJTTsPe2z8RP/2oKkw5TBcUGGuhDI1OX6ACQ?=
 =?us-ascii?Q?65PLdK8cnYvQjYwl21+ek2i00SbD1Bwa29C2kVNi9EwGsu91pNGANPHHDufW?=
 =?us-ascii?Q?8gzEoTEB6tH8s3mZrlTSxMWe1eqmEImVRVr7w45dnN1nSt5+Uv2MDDFtikaD?=
 =?us-ascii?Q?eHjToXimj180w9c2E7RWFtOGGS4uxv9qJMLbXOm2gupTA3oXw3yQBOUc3Wmf?=
 =?us-ascii?Q?BL8GrTBquEeZws635fGeV1j8jNReJ0ZiIZA8o6Tp0Rd4Dm3bQVbyJybJMKgR?=
 =?us-ascii?Q?7WWHCXiXTH2TcmL62qyNzDcMvH+nYu2imc1b2FH1YtxIv6gVbHwq9/hB1Opy?=
 =?us-ascii?Q?sJbjy9UwebYKY5nGpHcm/iMBcsuUPoXyOm0GR6qfdT3blCI+PaqVqGqeaRU6?=
 =?us-ascii?Q?+0lP7HZ8U71ThB02gyL3l+c8hpzVdXrEIlHojMFy4zAt3Kz6J5zOlNadsVUO?=
 =?us-ascii?Q?3GXnKm3nsdQCrOk2Z4lyDwD74xMg06b4wqqHRGcUchrfPhcXNM68E0afZPC7?=
 =?us-ascii?Q?fEO7vZtHS57jZbwdbLAbUSaCrinShGDrg7o2YYAEnl/rOQzWoi4xA8zfcNks?=
 =?us-ascii?Q?l73mdCGWE/WQ7O1YZqTBJj647lUAwaW/KSotdmya1ny1nVEmVejoEG12bhBl?=
 =?us-ascii?Q?1oRZyLvq9AfBPjB8DH6bAsj/6rRotgnlsykFXHOTMxK4tS5ErutJugLGmt8X?=
 =?us-ascii?Q?WF4abrUBG1XtZSeteahvOzn4EWCveOrnEmvg8woBd22mE/or0uPl5l1Mkn97?=
 =?us-ascii?Q?bUnx8QejWetctpyvcYORM+kcJzWFLWagp8Hx5M9OaZepF92FYg5I+bAJ3KyR?=
 =?us-ascii?Q?xNFMYkGAVMQoHypPvtj4mXwXmmmSDNio1xYS2KrvxnxtPfDFYuPCT3MzrFIM?=
 =?us-ascii?Q?vaY3ccznYS8oLDlYwQanyWtqVZX8ns6d+C8L5b7R32KM8uNL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db5b2dd-a172-4b90-5589-08de74abd2e9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:24:06.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xf5Ykqm3Zq4wbGuHhCociGYb5ra+lP9uatRXExEMazo7MRZ4vUaebDA2r3YPoxDwvVy/XSdWSI19HZf2rOyk1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7172

On Wed, Feb 25, 2026 at 06:03:26PM +0100, Niklas Cassel wrote:
> From: Koichiro Den <den@valinux.co.jp>
>
> On RK3588 PCIe3_4L in EP mode, the integrated DMA controller registers
> are permanently mapped to BAR4 and must not be repurposed by EPF
> drivers.
>
> When the remote peer needs to access these registers, it must use the
> fixed BAR4 window instead of creating another inbound mapping in a
> different BAR. Mixing the fixed window with an additional mapping can
> lead to incorrect behavior.
>
> Advertise the DMA controller MMIO window as a reserved BAR subregion so
> EPF drivers can reuse it safely.
>
> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 5b17da63151d..ecc28093c589 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -403,6 +403,15 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3568 = {
>  	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
>  };
>
> +static const struct pci_epc_bar_rsvd_region rk3588_bar4_rsvd[] = {
> +	{
> +		/* DMA_CAP (BAR4: DMA Port Logic Structure) */
> +		.type = PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
> +		.offset = 0x0,
> +		.size = 0x2000,
> +	},
> +};
> +
>  /*
>   * BAR4 on rk3588 exposes the ATU Port Logic Structure to the host regardless of
>   * iATU settings for BAR4. This means that BAR4 cannot be used by an EPF driver,
> @@ -420,7 +429,11 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
>  	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
>  	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
>  	.bar[BAR_3] = { .type = BAR_RESIZABLE, },
> -	.bar[BAR_4] = { .type = BAR_RESERVED, },
> +	.bar[BAR_4] = {
> +		.type = BAR_RESERVED,
> +		.nr_rsvd_regions = ARRAY_SIZE(rk3588_bar4_rsvd),
> +		.rsvd_regions = rk3588_bar4_rsvd,
> +	},
>  	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
>  };
>
> --
> 2.53.0
>
