Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3939346FA0;
	Tue, 10 Mar 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155275; cv=fail; b=VFrMlJmm4V7BMkO8q5zEpamuu/vVgjL8XdHNLOpVLdiRI/8MuD+JKShW3n+7RrSb8zGNwS9rz+Y4JgDYEQx5VktvfDv+PhaBLHjKZqpgvOc3FWH7drJeDn0F+GhkuPMsQ1l+haScruJr82jtvK1trKZtDBCxOAQbM9oQts76iEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155275; c=relaxed/simple;
	bh=2b6wklAND5DNLttxdM1ASuYRQaP3FRkSkCLtY3OS7AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=leu5VO2OBXAnSNKIYGOdVtlEb+jli5/XiMRbxJXK9cXDE4tLhtzsqd34GZQ3hHKDtI956981+t/KzvQfPkrrQsdX/AXgbjZ6zEkKNTfHRB6yzkxguv3V4v7jq5GoBkk9TFKhFz/bGGSQLTsHCQVHkwT+HVc/2smgquB3Z9DW6rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d5UNwUrZ; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d5UNwUrZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctjlleoA4lGJonygfb4hbzkBu2nW1pLpuI1fy7c5fzYFEq7OdMFk06JHDe+2Q1RZctFbA/gALKLAl7PdE2LXi/n6vUAMPg9R58DODALiOLbQBMdQuTcRBts0FwJPckQeX0vQcGsH5Kc81njRze9KySr6UHPY9KWPGYJomeXU68ywbaLyHzw4Jv2xL6Fjq45Txp0VEfXQfIr2/UH8zEZR2nkF0EWf67Bnl7ittuu3elmsX8Ng4wcGkCeUU6Jn+48KJ0BIYiV90yRi59okJxPixhHAwXcNOQtKF2nmTRjK268oh8vNHF/PI7v1fpL+3PbQQ9aiAGF7YQJBhF/dS59p/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57jD5b+L+KglmUXBSQUHy8FGTr6sBtTg2KtYjN6cA+I=;
 b=jF5hVKchSM1iKtMa3+DjsQ6mhYZqV9bUWGDH85WCyFT4ZsXAkZzIDgnjr5GEx9sXCguC72u62o9Vul6KSTnxSgAqCXW8rtEVinCbG8SrTLPUf1bMvx6A+++X3fCjDiDUeXqWEcug3wg+ugr8dTLjfQSaCVSN/gTbgpWx93k7kjzYokatAsyUx+7D7HfX7ufzQBYwRNl3k0QBSaLYnzgQ2+q5KhOCf2tn7XnU55X/eXFTVDE1BSpj6a3y/IQBphnY+AAGpNkCo812DugT9onsRzW245niggF7OyOuKNmid+jiqcv7UcKsktUOE0i+E7cU9Rywz0rn1zzhoRRjaTDAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57jD5b+L+KglmUXBSQUHy8FGTr6sBtTg2KtYjN6cA+I=;
 b=d5UNwUrZJLBUcuk0Lwt3aHMgsOCEbpiQj6FXNIjGj12gl5sjGvAIpUaSHMK6INoquBM4tbrfQ9tZJFVPNrIZhp5zM4jms2UYE2mpNthtW3xMPPLpIMpsZ1RSrdLpn1NhC6oE1xP3RJRPUKn6toTU5mRYLKSCRqgeYvFsY+eYg4nM0i3vIYkjypLsP/1nvR4e3vKl8A7kS0iyk67kQ0FR+dk3XoFNmfV3U7StV8QBiQqH1DN/dLXzRMWTFmQLDgVflbf3mA54dR6UYJFaxmTW6ktRvsgogL31gy7oKQ3npfjOfvvAIEPkKmXT3zZwxQsEGer67HFI6AVPRlH76AkzkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB11053.eurprd04.prod.outlook.com (2603:10a6:10:589::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 15:07:50 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 15:07:49 +0000
Date: Tue, 10 Mar 2026 11:07:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] arm64: dts: imx94: add pcie0 and pcie0-ep supports
Message-ID: <abAzvSGioHN1AOQt@lizhi-Precision-Tower-5810>
References: <20260310075459.726495-1-hongxing.zhu@nxp.com>
 <20260310075459.726495-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310075459.726495-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH7P220CA0142.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB11053:EE_
X-MS-Office365-Filtering-Correlation-Id: 154b6cc8-cae4-4d04-f616-08de7eb6cb55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	shdRYw7N6UzVH9fNztxaDOJCsQlSQyDL85eDtBrOwfLdm3X72X+wM5Gi69P+/YWsCHeL0TGcW6Q3YcT3GILLN6EY6OQACUEpR1fjJdhjMXdLcMsLiNOUjp68Qx1s4MMW5zkYk4bEfmbU+0z9jdzRIaTgRdkrQMOQOgbtbjuyhFd5e5kaGNloqryAMOzniNtsPCqMtJtrWjuB2vsMJjr6lx3Y8UCcpBKhlbugQofFCPLrQkb+EfZTjcbGHSKErpcbe5LrABUIrG6Zr625JpCCjTeT9b1RBbr5MrV7jMUKARqON+FrC7ZDbn4d/JJ3CxosQYf+2ahNbNjXhJSKRoUUGmMLEdmhPAjek+JNCbBmeIwB+0LLoqyCoqMzPaK98yJBQCu5RwDkFsd3EgaRutTm8MWMPFd6Q6Ujawz76rS40WUBXcLUuwL/uHhtkXANtGVVawx0jNmCIbiXQYYLelGAHwfG22Z+dJMHqrQS+TnwQIuWOtdcGhpnLyH7D4mgNX1/13Eb86E1FZYIpuDyNuPM/ymnMRRAbZXwjjcADNvycDYyHSuMk8Yfn7RYHd3tmPcLA2ip1o9NiBKY5xJODnFJHAhyDgKmTlKvjhPnJ9T4ApsgZxoaQC8Ug7iFO0/fj9C8dPXcMjK2iuoig3tPoWFuot1iDGMICpQUCsPxF9rdGhruF/7P0N9ErLcCRk4MQIP1dYmvzCQYnfKRbEnNyjPCOSRBhCFOOjTGysLA2pTP7asDfE79ruNM1+UlzXLkCxHMOeApzshzRimR4N261TJVrcq7XFX2eZb5+eaOMaMst+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q13EuIf6Q7B400crXisE1whu8N+sVKUcllA0w8lnbsawZ7e3/BZhIkxJmcWN?=
 =?us-ascii?Q?Ktbm7wqJBtWhQtCtHpZuq4RkHjOtU2868fVIDdb5U1VokWqTyfPg6R6tg8GD?=
 =?us-ascii?Q?sChXhGpVE0LC9KLMLoEPBWuNg78PR7EXAt9w4Mbwe53bI7e1TSGRc4+eYSzV?=
 =?us-ascii?Q?T1TmbTMBVdNM124x42RNJfrD7j9ASZmzqy5kpToRV2gCwAI2K0oSSqDV3F/w?=
 =?us-ascii?Q?n23RP8aHYVpmfNHNsgAQULn0rAikN8lAd2Ut888IkoZNKLZ7IBSN3TOTsvrb?=
 =?us-ascii?Q?zf1xzZ1DmMQHPloYVVJ7WNJGtxim84+Nar5SNaqrTGwpFxeGcp7YIo5PPZaM?=
 =?us-ascii?Q?VUoaGD3fl79I7hzX8hftkKvHkdt2+T0fPdr7iIabT3iiCXED1gf7Cbp6t3+R?=
 =?us-ascii?Q?O2Cim/h8BqMeEjWE59rgH22NKjUa4bc8aUMdOQH2p35ZiaV2BrU2j6VCoHjw?=
 =?us-ascii?Q?kC7iRW5Mwe0NHg5g8qyulOwtsR264u7YB1Slt/ZG/Sw4pfrwUWPeStpP10Hu?=
 =?us-ascii?Q?MzqyQWpg5E8+Tf8k3HhXM+5XchWm9i7B/wDT5tqeFShaas8MjPk+pC3QdhwV?=
 =?us-ascii?Q?gmzUkmb8nsRqESfsSjIZVrkSQ1zoJEuBZrVyS0SFPRF7Ua0sQIYGrmurts8C?=
 =?us-ascii?Q?2Dyu51iDZrpm4k3ZI+FhTwDTsO4uFhFRlFQgFdbreP1R2RFe8ZJUC4CdK4Cf?=
 =?us-ascii?Q?tzF3fj4crUweNV8h0MigXJhYsfUCXpa3mSgKE9iUwUWhkVCYMjL7OcNpRNfJ?=
 =?us-ascii?Q?lIqjPhhpt4R4KKx8IsPTyN8BlBaBHKdWG910ZYJ8I31bF3fDD0sxa+jmF6ca?=
 =?us-ascii?Q?BdE5Pgas9HdjIGxW52dXTfAOpsEHlTXymuJ5AjebtJO8PyC1kelq8Gn+tb11?=
 =?us-ascii?Q?bvwD3BP3sZWNjwziALb1TwVLXDZt1PN2DtzhxHCyBO3OGmWeIs/mEzygNZfN?=
 =?us-ascii?Q?/56ELRsYqJDGAiGVry/++KL49cNtvMfXR2Z5Vi3kY7QCM3g2hFa2+FxD8vRl?=
 =?us-ascii?Q?rwHQREt3e0Sko7CkIQSETVeYObqTNIOuNPSH8MJjTUBQOKRmNlc4KTmntbZG?=
 =?us-ascii?Q?ymrfYAaxAA3Lp34tid57z9iBjGL4U/XbdmmE9yaN7RRSYw7giFzHKZ4OGgW1?=
 =?us-ascii?Q?E9cRWCGIJH4tDhh62m9inIi/716d9jLDPZ1d+LW6qk8avxuNoto0bO1GpEcy?=
 =?us-ascii?Q?OOhgohFd8kecTSnW8aSjzGgDh8OMSepSFZVhZm/8uEP9cXWJMEKTxoXqr7j7?=
 =?us-ascii?Q?w291HApDdwDjpN73241C5ES4x3+691jcRL1GeA3xGPZT5xDXAdIMb1+Jk+Ic?=
 =?us-ascii?Q?+lZr2KFfGwwvafybozg/Js8+w8C2PfnDab4Q+UuqHdX8xdvlgSWqt5e7Co0e?=
 =?us-ascii?Q?Bu9O0+sy7xP79zTtX8w1E4DW0yLqHl9HxNPhywfLoN8pv4RmSi6BVV7zqfSd?=
 =?us-ascii?Q?Xim6U6E8hBK/waj/JlhY2utbXMNwMkq26/d5gt/ebpDOsn4tWMu8BI1PcTYQ?=
 =?us-ascii?Q?FnWfs+F/NZwEC9MVDpg2FFeXhNXXy4V9EV2qBH6LgL9oyCB8semY8E7fFBZU?=
 =?us-ascii?Q?6N8lGvgy1qyhK94MHK6fpIPZUvMqdbCUL/3J7W1Yzd+msWGVo+aCbQIligWB?=
 =?us-ascii?Q?iWyMdmaZM5PSI3f1RfgQdc9cmmGQLIKsfBJ67ialXMPbVoDwgVU7u49wi3Pg?=
 =?us-ascii?Q?wq+3/jp2lIody/UB5ahAMXKsdoBS+6oHIxzBczEn/arfPK9SVFt/3P3PD7X9?=
 =?us-ascii?Q?J2dUepIP0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154b6cc8-cae4-4d04-f616-08de7eb6cb55
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 15:07:49.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Z/4I2D46iDZ3LJdSrbHFKivDqz1uHe/jyy5rlx7odHQnFks1cgzyhgj4xuLT6k+dX1ejbR5y7S1XIuv0M4R7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11053

On Tue, Mar 10, 2026 at 03:54:57PM +0800, Richard Zhu wrote:
> Add pcie0 and pcie0-ep supports.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx94.dtsi | 86 ++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
> index d2f31c8caf6e..2f75e8762b4e 100644
> --- a/arch/arm64/boot/dts/freescale/imx94.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
> @@ -66,6 +66,13 @@ sai4_mclk: clock-sai4-mclk1 {
>  		clock-output-names = "sai4_mclk";
>  	};
>
> +	clk_sys100m: clock-sys100m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +		clock-output-names = "clk_sys100m";
> +	};
> +
>  	firmware {
>  		scmi {
>  			compatible = "arm,scmi";
> @@ -1223,6 +1230,85 @@ wdog3: watchdog@49220000 {
>  			};
>  		};
>
> +		hsio_blk_ctl: syscon@4c0100c0 {
> +			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
> +			reg = <0x0 0x4c0100c0 0x0 0x1>;
> +			#clock-cells = <1>;
> +			clocks = <&clk_sys100m>;
> +			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
> +		};
> +
> +		pcie0: pcie@4c300000 {
> +			compatible = "fsl,imx95-pcie";

You change binding, add fsl,imx94-pcie and fsl,imx943-pcie compatible string
and fallback to fsl,imx95-pcie

Frank
> +			reg = <0 0x4c300000 0 0x10000>,
> +			      <0 0x60100000 0 0xfe00000>,
> +			      <0 0x4c360000 0 0x10000>,
> +			      <0 0x4c340000 0 0x4000>;
> +			reg-names = "dbi", "config", "atu", "app";
> +			ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
> +				 <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x80000000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			linux,pci-domain = <2>;
> +			msi-map = <0x0 &its 0x10 0x1>,
> +				  <0x100 &its 0x11 0x7>;
> +			msi-map-mask = <0x1ff>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +			num-viewport = <8>;
> +			interrupts = <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&scmi_clk IMX94_CLK_HSIO>,
> +				 <&scmi_clk IMX94_CLK_HSIOPLL>,
> +				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
> +				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
> +				 <&hsio_blk_ctl 0>;
> +			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
> +			assigned-clocks = <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
> +					  <&scmi_clk IMX94_CLK_HSIOPLL>,
> +					  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
> +			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
> +			assigned-clock-parents = <0>, <0>,
> +						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
> +			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
> +			status = "disabled";
> +		};
> +
> +		pcie0_ep: pcie-ep@4c300000 {
> +			compatible = "fsl,imx95-pcie-ep";
> +			reg = <0 0x4c300000 0 0x10000>,
> +			      <0 0x4c360000 0 0x1000>,
> +			      <0 0x4c320000 0 0x1000>,
> +			      <0 0x4c340000 0 0x4000>,
> +			      <0 0x4c370000 0 0x10000>,
> +			      <0x9 0 1 0>;
> +			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
> +			num-lanes = <1>;
> +			interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "dma";
> +			clocks = <&scmi_clk IMX94_CLK_HSIO>,
> +				 <&scmi_clk IMX94_CLK_HSIOPLL>,
> +				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
> +				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
> +			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> +			assigned-clocks =<&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
> +					 <&scmi_clk IMX94_CLK_HSIOPLL>,
> +					 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
> +			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
> +			assigned-clock-parents = <0>, <0>,
> +						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
> +			msi-map = <0x0 &its 0x10 0x1>;
> +			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
> +			status = "disabled";
> +		};
> +
>  		netc_blk_ctrl: system-controller@4ceb0000 {
>  			compatible = "nxp,imx94-netc-blk-ctrl";
>  			reg = <0x0 0x4ceb0000 0x0 0x10000>,
> --
> 2.37.1
>
