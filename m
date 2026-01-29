Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120FF3587A4;
	Thu, 29 Jan 2026 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769719456; cv=fail; b=sZdFMNzF5GWkKVkizrSDIC4DKwFJVgv4nkeCna8ExoVveiJDJNg144zCoKJX948gNv1ZhtlrV0QUXEmTs9mbL91NydpceUpwj/8htk8x88npZoRkg8RtRplSSDTDX7hXe/+569BKHqHImD2OwvNvfdpRqy+lPj2ma1XR7TjFdyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769719456; c=relaxed/simple;
	bh=apxJMi5m1B4Fe8iNmN4V91EnmNS59D/f1F727AA7Ndc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ID2fl8+rhA79N241sByABtTZSEkBhMxD4BnJJEnRwhGMYtjCTWbOOgs3+6p3ugvVO/DfX3LoLnyR3aJIZ/1mzGdzuU5WrVW1swtsLPrn0YzNHTZ9d85tJW997fN0kRVj1TKMSqCktywb0Xv5l6nkwXoKwW7DXS0grdg4PgQhpHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OreLE0fq; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OreLE0fq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CisWS2TNEkqoDXgVVLZkipLbqALss4hSZMRV5kd1x7YI6X1TXy+3+UUKRkYi1qbii0LyMY4GDBrldxrwi8U1W01lLsd4wvn0mvH+pcM7bArJ+2o8kv4h7esjA5L0VqDE32URNa4V7UI5k2X5tgPGyF4Y38n6K+SLafEQlWLfZ4tuwwZc+jS5fBRa5rvX1lSCmUhSL+H5wQPyetxfFEXzPyOqr9uwEyM6rZexvOKLaQF/2ULA+LrhbUfY2MKs00Xvz0/bLNMS/H4ZSUWN+5qJMzPNFDyEEaH5vPflB2LH3kVbbfJgcH8WzsPZELfY84OhP84YSAXUg5RPgcl2tTDTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5Do1eVYICqY9h7AnSSQpgZCvfIDhPKjQCrxc+T44J4=;
 b=oAJLG5swqxENAxb2xqP4G1IfTE0r3H8lJrepl80mRZZN7VNVjFCh5a3rtCox9fL6Ffi04FAievI82mGrOGBDV+f9oyK/Sad00qELSZgKFcW23FXYlvStiSWzndr4MNhjC77F2lOPvbwUFGCSdCP0mCI0U5HyGVr2wkc/X+4cIgiiiYn+Nb+sTR96vMdBF5lg/5umILIRO5F7elQihBk+MQW1jhpoYzEn32oMaNkTelfUHSwJigz1NbU4+bbqQ25LnrPXTGES/0CN0Ray7xgAIk3lTvhDFNIBo4Aaz9gD7sSAQe2qqqIm1jQ5/a4BUciUv8t5rY2WXXbr5S16apPxNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5Do1eVYICqY9h7AnSSQpgZCvfIDhPKjQCrxc+T44J4=;
 b=OreLE0fq2Wzaqa92xh+uRwMQgLQWEHA/AYGvCSZ4Kf7Zm5Pvq4LM18Lw8875X4CLyHiFIQtkr5VrRmYJeK69euji+uc/FRtEiqVl119bdxLautuT6ZCfy9XnwVQoYvKBPdvtji2u+1a0vPVI3ezq+lg1XgLyaWriA7+mq3VTOdUHZvVDnP17eWSbDtsQW8WzuD+vPJIrPMKMXH4cSsR+BhV3QOOKGzvQO/gyfOpwXod6QmnR7snC54mZ1qvG3AUEzIyJ2dG6BdhscQ6aGyZ8u8j2ODkDA3vhV0ciUVhKqaJaqpcDXsid6rGDHiuducX13qLEaQsokXbuh/2xcLkfow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB12327.eurprd04.prod.outlook.com (2603:10a6:10:631::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 20:44:12 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 20:44:11 +0000
Date: Thu, 29 Jan 2026 15:44:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 02/10] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Message-ID: <aXvGkSHbUE3qmxMK@lizhi-Precision-Tower-5810>
References: <20260123021445.3782170-1-sherry.sun@nxp.com>
 <20260123021445.3782170-3-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123021445.3782170-3-sherry.sun@nxp.com>
X-ClientProxiedBy: BYAPR06CA0033.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::46) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB12327:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c7995f-a989-4558-14c8-08de5f772844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3UpE+3UUVRGo5sqUhgC5ZPaSa7o9XbZnV2CkEeRQpnQwGrMxR/qluDWOdRxY?=
 =?us-ascii?Q?8hvWaCaUKFuzM3eqIZ272g+4pmXJhp9lDpSZ34IN3NKNviEJ3c6tHtx/Y0Sl?=
 =?us-ascii?Q?rMiLzey9UyQZoXxICbEzAprlqQCECJ2TPKG4vbziNRc/EDXDTNQ41PDNymV1?=
 =?us-ascii?Q?BqSEHGLv1KqNCCcq4o8KOpGH5QiIOtXTtsj9gH7Oiu355FQ5WHx+BSklzCRp?=
 =?us-ascii?Q?2bf26oQ5wC98GFikHE9mRkYlTCulCYK658ScXrXCqv1fNDKkB4ZGWNlbUi2L?=
 =?us-ascii?Q?tzttz65jPh5yGVRlw/HlM5gng3Bu4VjhcfQm9tpovsvgsi9UbPqZOQ89ZL3e?=
 =?us-ascii?Q?xzp4QWQRaw//5GTO9HzYzXsRGCflN6blOlJnWpMGqKbzGUh46QVDq+dU2+Bk?=
 =?us-ascii?Q?4HE9ZErVNNz7tejvAFbQ8Vt2Mf5Dif/YR5tl/xTyNo7cFDdHTr3MKE2oF6pe?=
 =?us-ascii?Q?Dmz0ktxSY5/6+ahwi2XjvRfAW1jq3GZuzghQ1SWgpJCVU5YCQiRWYI6Z30ln?=
 =?us-ascii?Q?YoZzWLLB7/JJUaS90Wb/ecGPwxfh9an69Ufumk3ZlMHe2S7I3KaBAi5zKaF7?=
 =?us-ascii?Q?aGQw+OgHVRiWNzH/H8u/KRdAnfl/iuL8XKHYPyW8ytIkm8TWoHqGlJK58cm8?=
 =?us-ascii?Q?kajHpzEBdnn9yrnwG/DiKkyZ1KPTbuvMKgRPODScIO9nqC1+icEJ1l6p3amX?=
 =?us-ascii?Q?UUVHLm8hYfrorlby8cb5U5rsopk09brNu+jgZ75A2Tp0xvO0ZShrOIbHa182?=
 =?us-ascii?Q?CXiVE8NxLfy7ibFgirYBl25vcYdoEmv5QSTCuBBDncQDSjhZlieMgiH03QoB?=
 =?us-ascii?Q?rHwr0AEQc6CqH97POhtS4ZnDxNMhN0Yc3oNNN9TsloSm0/zYxhbCML7HNi4R?=
 =?us-ascii?Q?AOdm7Mm2GUDM+Bf7pkA+fHFmqSEKz1KE8/KWq5KRr/qWlDHOgSZpNFeSZ4M6?=
 =?us-ascii?Q?+9+U61waHrP0UOMxMg3eCc/K96KDa7JD5WOIUFwh2BySYBkHZrb/BercEHLw?=
 =?us-ascii?Q?dGWdQRGo5qAhanY2t90qEMnTIfXd+OyKJuXeTzEdOMNh4Nj/h/DeSsDke8B6?=
 =?us-ascii?Q?867nitMnDsmpBqYVNezoPiSPLTMKsZtHycMPVdS7QKNfodRnJPTf4s0EKo2Q?=
 =?us-ascii?Q?c0wclINMO/2A3l7kYj+S6Og3FdqF0PyF8ImUp6Q2Mqr0/Bnh9SfFzKEGwh0s?=
 =?us-ascii?Q?ueqXodSr5BGEYdQ+TdvHfw1lzzhyKe86E4Q1zMZdNr0gn5FeoHDrR5DPjgZW?=
 =?us-ascii?Q?QMASWphXfSH6ldN5YMXZj+ZVrf1srTQaMyUGNIeKuv7WIMoCBaLfiLdZmLDr?=
 =?us-ascii?Q?ZnFyIGzbfwT7ES4lkuNJNSVFwFbxE678TfBBU4SBpv4nC65xVPlxd0IZiJeN?=
 =?us-ascii?Q?5ID55gv3n9CaMQ0prrN/p879KHkE6qGxGQcY/EWXnTOH+2q8rcE4z1Q9985l?=
 =?us-ascii?Q?kvfJ8H1GRYBMzX5Sy1Nj84Kt8awKhTMnbvJQJRodZ4Qhvk+TBoEIVQPfwIdD?=
 =?us-ascii?Q?6LiR7EZ5RzhK3MXF25C1oJ6k2VA55fekRQ2Sl5RLR/O8fe2Hx6EDfiAWMvfb?=
 =?us-ascii?Q?OWEEYItPwB4RlmLyosUm9/seGkyu9V7tIbJKq+k2AYAHvLMoiWo0ke7xsApW?=
 =?us-ascii?Q?X4FG8vkElCHmD/b0MKccy6E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wu10dc5fNkm9U2OcBrnyytz6dNrTvf28Dvm0kYyqYi2ZMJrlVCNnjp9E4pip?=
 =?us-ascii?Q?HEO7JtcXJp3xGoRDRsajSeBLF9abrmAzXEkeBtEjgTFm22irg4w6BkGYCQ9l?=
 =?us-ascii?Q?Q24j5yeUPEfggBKGqs804nXmqTDfoxxOmO+eH20NTwnOJ492yvLCd9xpCOsL?=
 =?us-ascii?Q?cK9NL0Y4d9G8IqeOEXK8FmYPevZQz5bnn10sbf+0wUDt+wEC+fhGCFfDv7LR?=
 =?us-ascii?Q?BrAx2fOSbEAUkw3EefnLqlQamcdxoZLmbS5oO1rVudgIElY64av/BuCMplRc?=
 =?us-ascii?Q?0mmtVC3zYgQ7JgNHTZvOfK5Cz2l7olC8mUDcjqQXy3EFeYIW4vTkWa/FJUIa?=
 =?us-ascii?Q?APqGWewnZEEeQGp91g5SYJE//HVSanlWgm7ndCO7L6a/gccBomuo0ku35DGH?=
 =?us-ascii?Q?fC2eaKDSs1OBkQ/Ez7rndfigqS0LGcsO4a0CDdslGNx9XAEumwzfHtOvcCTY?=
 =?us-ascii?Q?UqU52Z9MHf/Ki2H8efhI/rOOPy7bHT/Qtc3Rtqn1bujjfrz8N4HoEfzbdTUF?=
 =?us-ascii?Q?Wv/lTLFMpVc/e6T99xTF4LDwkF5/RL11jAbrevu/cN7nHUQ2EtIkgQZJ11W7?=
 =?us-ascii?Q?zncsrzV0Gq3nwODLqRdwufnuoOua5tyXlnT7xxOb2mt3qrMMqw/Upm0PpNm4?=
 =?us-ascii?Q?WteMWsXQagoYKz06mzBGEMT8mV8h/MfIu6qmG8tfmbFkbQyScPMTWBQB/Uel?=
 =?us-ascii?Q?/JCShN0R4G0kNp8PyAnV2XoPU9u6R9J6FI1sL1puDt1s4YNDfKvK9+nfPIDj?=
 =?us-ascii?Q?nCMLaHYmLn2E3+AHQRMGwT0CzK4QgQBsoZN4qnG9PwAQ3ZnjbpjLB/zNBz/J?=
 =?us-ascii?Q?tS712DdFcgVM5zPFMcycwOTOR+FYwIvYMjoENyLWZLx0htu+4+gutTFGo3q4?=
 =?us-ascii?Q?KlFO3TuD70R2gyN4AMvu++7ElrPv/T3undZynWvYVi7ezSh1RfI56ST7u83e?=
 =?us-ascii?Q?B32M6nEbSHnhIQkmRhzORs8Ce00k4Z1HhNpbNvWY/kbSKRIt7QPtvmlGGlY+?=
 =?us-ascii?Q?ZeWg1NSahthGg/iyhJ3YEU0rOwGyvSsTejtCXrvAsYJk8CkmlfvXJYUvltEp?=
 =?us-ascii?Q?kfeHCB94RKuc0b3aWmz7OEW1Q3FVVc3sOPbsa7Q7SL1QpY2NOIS57/VPil8m?=
 =?us-ascii?Q?I7cMW4SR9ATbnHhYbK7W/KZnzvTaqmha4Iw3SkUtHMtLyxg9kJxnaZ78Y/nq?=
 =?us-ascii?Q?MHG4qk2L9xiAJ1n82GzmedXon4fuJIw1c7iE5Lw+twfOuvKyijSPaJ6e/T1k?=
 =?us-ascii?Q?9EAKpeJAw8WoHHyUj1Jz9WwHK13BLXTSXYzur4+ztGom2KJeVgFRQzqNwuLA?=
 =?us-ascii?Q?G/ACnJwWt9sdh3f8yEBR4bwAnpffQT9bG2aoXgfbqvKfH6k9BW7FACODtzqu?=
 =?us-ascii?Q?oRcKi8oj2mIwofLItLOS0zogsDEZ6V5mbpKyEv3heecUMIP2CHK4prBB4Bvd?=
 =?us-ascii?Q?M4Icrp/9v71+yP+Uw0Pa9pOwm2+71DT2ssmfkqgKEOTth9tHr3E+RHG5ivJM?=
 =?us-ascii?Q?7QhBMTkvHFoYtbvwo93D19z+nixoqSRf1wvgXO81R5BHqGf130TkvIkqhjcv?=
 =?us-ascii?Q?COk8wYcmx4u/FGDlw2y2mx7esBNDqa/XjSxAX0l3XgE7bnUCAi7rS4bp3kUY?=
 =?us-ascii?Q?UsLPKto2iVnoIM9TeKhsO6C6l2+v75f+PtD6WKyI7Ruh84Le9LFLRofJ1vRl?=
 =?us-ascii?Q?mIsyaTv7p6+tDtS2TqsBsql1k6kJ1d/uERLnh58m78m7g8qs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c7995f-a989-4558-14c8-08de5f772844
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:44:11.6048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zflb41lqwnhj/2gcHN4WDDCfWakSiiT/M9POV99p4oM0xvmTvudDP7WqOVnFKt4eVzSglNY4zA5TvYS8xGEJUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12327

On Fri, Jan 23, 2026 at 10:14:37AM +0800, Sherry Sun wrote:
> DT binding allows specifying 'reset' property in both host bridge and
> Root Port nodes, but specifying in the host bridge node is marked as
> deprecated. So add support for parsing the new binding that uses
> 'reset-gpios' property for PERST#.

Need descript why need this change, such as support m.2 key M/E, power
sequence.

Frank

>
> To maintain DT backwards compatibility, fallback to the legacy method of
> parsing the host bridge node if the reset property is not present in the
> Root Port node.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 123 +++++++++++++++++++++++---
>  1 file changed, 109 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1d8677d7de04..4b3377a48b17 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -147,10 +147,15 @@ struct imx_lut_data {
>  	u32 data2;
>  };
>
> +struct imx_pcie_port {
> +	struct list_head	list;
> +	struct gpio_desc	*reset;
> +};
> +
>  struct imx_pcie {
>  	struct dw_pcie		*pci;
> -	struct gpio_desc	*reset_gpiod;
>  	struct clk_bulk_data	*clks;
> +	struct list_head	ports;
>  	int			num_clks;
>  	bool			supports_clkreq;
>  	bool			enable_ext_refclk;
> @@ -896,29 +901,35 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
> +	struct imx_pcie_port *port;
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
> +	struct imx_pcie_port *port;
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
> +			msleep(100);
> +			gpiod_set_value_cansleep(port->reset, 0);
> +			/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> +			msleep(100);
> +		}
>
>  	return 0;
>  }
> @@ -1638,6 +1649,76 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
>  				  imx_pcie_resume_noirq)
>  };
>
> +static void imx_pcie_delete_ports(void *data)
> +{
> +	struct imx_pcie *pcie = data;
> +	struct imx_pcie_port *port, *tmp;
> +
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +		list_del(&port->list);
> +}
> +
> +static int imx_pcie_parse_port(struct imx_pcie *pcie, struct device_node *node)
> +{
> +	struct device *dev = pcie->pci->dev;
> +	struct imx_pcie_port *port;
> +	struct gpio_desc *reset;
> +
> +	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> +				      "reset", GPIOD_OUT_HIGH, "PCIe reset");
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
> +static int imx_pcie_parse_ports(struct imx_pcie *pcie)
> +{
> +	struct device *dev = pcie->pci->dev;
> +	int ret = -ENOENT;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		if (!of_node_is_type(of_port, "pci"))
> +			continue;
> +		ret = imx_pcie_parse_port(pcie, of_port);
> +		if (ret) {
> +			imx_pcie_delete_ports(pcie);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
> +{
> +	struct device *dev = pcie->pci->dev;
> +	struct imx_pcie_port *port;
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
> @@ -1656,6 +1737,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>
> +	INIT_LIST_HEAD(&imx_pcie->ports);
> +
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>
> @@ -1684,12 +1767,24 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  			return PTR_ERR(imx_pcie->phy_base);
>  	}
>
> -	/* Fetch GPIOs */
> -	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> -	if (IS_ERR(imx_pcie->reset_gpiod))
> -		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
> -				     "unable to get reset gpio\n");
> -	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
> +	ret = imx_pcie_parse_ports(imx_pcie);
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
> +	ret = devm_add_action_or_reset(dev, imx_pcie_delete_ports, imx_pcie);
> +	if (ret)
> +		return ret;
>
>  	/* Fetch clocks */
>  	imx_pcie->num_clks = devm_clk_bulk_get_all(dev, &imx_pcie->clks);
> --
> 2.37.1
>
