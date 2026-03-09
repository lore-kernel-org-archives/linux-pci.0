Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A73093C3;
	Mon,  9 Mar 2026 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773045813; cv=fail; b=RAnTm3cRnj8aZYOtQRpKwsrvY/x/ty6kO6SBZLECTGWC+gqSKA2LFJTktxj5iJzZi2gaS8SJUY/MmHwchcnOqJx+x1zFiHfjPfIDA1nkKZBCgr24EITflhAgyerOiSVtyS0wYf6QnIVogpVeFGAYCzyH/8NGRAB4mwTOinn9hIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773045813; c=relaxed/simple;
	bh=ZBKBWfteEUs3YcA010WQoGnMA0Idg23J7EKq8NplCeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LZ9dcXU8mCs3Ax+SIlWOnWuXwz6S+tSiP2QI5ojWkmOlYPfEYp6ayHtZ+WgHa4mYDYwblh9I3kkcFjcku784RGJlZhpteCkuQIgZ1H9mz5bN76PtYo6K60urW7mIwEl73L303/WlX2gB7zif6MvXAm3pjaq3n6t0UYkuFW+GxCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nfcaPeD/; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nfcaPeD/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIZ+OitImmrNQpq35LqAVOF02hd0Kj1JT0R7IQA98JYNg+fyLq/IXmxs8ykvPuElgxhHpaBnRnr+dwqHw3BNP9dYFborzeiJ/XC+HLjkVhKZLJPbQBS8/54sRxgaAKgHAT+aNQ/W/ETIc5I0AMUuzuPLlVgiaqwdCnbFq777u63rv0yEamWnmeQ04xqwjgSB7escet2Jta4xDrhIJRaZ3+2dwEACeYFykAaC1fI6TppoStjirEhRL9GD1JgfNGOJ9mHILG0lE5zBBRpwAZyF2OeC7dB1wrWYjgGAb4iz69MhoBhae7uepbBreD3P/lovY23DaPQg5ejYWMJa0bCSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8J2lo0rBfqRDjM/aIpr0SOzEzM3YrYBqN6hoyGnwBc8=;
 b=LooFz3MzDjb2BcTQfniqXCskifykhwg40epaz3N8TxMFK97oU+BWz1obLmoFUPdB/kOECyB1zkenVSE7+zmBwKLTvvThyWlg3IpIasWTTwt1/qxxH8FfgIHSownUfEFPg0E6CznrKCwHjRoSySLSdcxUPUa9DdAuD+lKP1tx0X3HgZ90JXyyjVGa+fL/wUpQVGGHmnUVEzxv84N2B0z7VHf5C+2zfinbTKk57secA06Ew3eg/ZTTWfZHk7C8LA3OclCq+vnS3suwY4poUV7NaQGsSMq1ybThdLD5btmTclLFIEMwZsHoEXXDEZJwx9cQD+JSBv5mWYFdRyC/L3XtgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J2lo0rBfqRDjM/aIpr0SOzEzM3YrYBqN6hoyGnwBc8=;
 b=nfcaPeD/9ffsF6YCMiVr8tjUxbGg6zdk/CG7Gxq/WQEG7fpYknOzkeq8QGZ7CfNLq2Hw8MhyEM4kXXnl5wTAOS/wh+ANM61L9etazQEGOpOwfaNW/MhNH4pRSzicaY81mAzQtzZyPkQag18p33ofGpqY3tgfgWS2FDGGD744VqJp3flS1ybFzbqXG3BxmyvAUViH2K0KtjC9qtJ33aMv88uiKIUntO3Wg/QExlKw98iAZa+cPshnBL5Tg9o9r6XbUzX3dhkr4pJsRW6smxwdQyz1IKwWIZ6wXRkiUx/4li4SivSuKL/h4moDRWVeAyEgzvjc2mEEXd/rYOjVyIiNpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VE1PR04MB7264.eurprd04.prod.outlook.com (2603:10a6:800:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Mon, 9 Mar
 2026 08:43:27 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 08:43:27 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 2/4] arm64: dts: imx94: add pcie0 and pcie0-ep supports
Date: Mon,  9 Mar 2026 16:44:29 +0800
Message-Id: <20260309084431.3015463-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260309084431.3015463-1-hongxing.zhu@nxp.com>
References: <20260309084431.3015463-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|VE1PR04MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ce4216-531b-400a-8ba7-08de7db7ef00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	hKISMKx5fu+so8mPBwtTKZ5Uc1zSIhbC2CWjSQvTNQVQwBLSC41iC6zzHrMOZCd+9g8oFAFHKduf/PF9X9F+zMlx8IjPvPdeAZe+mI5tJaJKbZ02ug21U25nb5sWj1dCt7QsqvVGSBwExhknjniVWICZLrINqT9RSXUzcSgGZLE81wFc1VE921gPNPcGlTfvTY7lQ7J2IOemZ1Qm/FcyD+hB2C6CEkXO570qoPBY0q6eh+wck+s088frTxDYxjamruOqW1WkXTo5fI4XKn+N8G9P4BMV4pPpsb2DNhAq79wdeae2ols2YHYp3EidzVxosC27zhj1pvWMuMT5pM1CW6r7Twbkln/KXYusEjUu+X3qLpoeT9fCUfpT45FZtCQhCKy/qNojuBCsoEO1sTEzoGHSXKr/C57g5K9mgarbtK6JS5T2XXvXBom8MzqNUVVUlcJbcwH4lmqQzlsS0+hLg0ywsTpjIyqNG5bi5yyS+/mTpuai2UKqljgKsDjRWUFAl7DBXkxv1vje9Ei28gmi7CJFChPdzPyMDVdgF9PjcmkdZ3Pu5sYNI4BufBlo0QCkKit0YtJic7+0YS8bjG36BlujfMd/Rd89M3ZXr+dRLGEk9sIP6gLV+QojoOlZPl2y4jiimFhoNVpQzcKrzAOrax4YqfM2o4/b75IqaZ4CxgZWNxU28TVC/zbzOrCPnaq72nUkSxT4Dpa+PBOhTtlTNlG6ZOO3LpyquJGf6r++L4pmOpQXCSEtKbhYYJsUOnybJ0axXRWejI6HmHp6Cq+gp8MMa8CZbDzb7ZbVA54PizhPNAr+5u5naSr/xvwX2bdP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oDeKMCY4XgkYHtqsIk3LjEv9b9q22eJmZ8kouT8nwH4rc+ftrzu76FV9TFWi?=
 =?us-ascii?Q?J3xb9kIH7ID6YnMeJ3dvKsTZjQtulOkx4Bd1Qh7WO57QWYQrkpMVhG1KpfZr?=
 =?us-ascii?Q?SIZkG3jByGxz7DBbyF+JKZ8FmnGkGC84S8GFGSVQKV71mNFRyZchfPZgrMfX?=
 =?us-ascii?Q?g1/Rnv3q4kjhWzI6tVpdrXsdSGKPUX6KdfHT1snfvxZDOgjA4APPZvLJhdBO?=
 =?us-ascii?Q?76BWhnbkEvnvMmwtO3FCVshx1kA1HJFT34U6IW8+VAjdCwXyj8tg67f8UtIU?=
 =?us-ascii?Q?B0N284NoEBs6cMmBXHgIEqy9v4L18Qp3cTeLpSOjqH1YAycLPFHBPuhuZUes?=
 =?us-ascii?Q?3lBBbaYesaVfauVfex/1dwfXyo58IdO4A7ImBTgXEkoEuuoui6dtY4b9Krgv?=
 =?us-ascii?Q?N3h21oEspDMnpeADnnIOrqyczluDd4pjul1SpfzVBrT1XfSQ/Q0d5gSP/rtN?=
 =?us-ascii?Q?SIh959nZjuIN9iFRuNt2TGDGma4J2XdzreceftKtrE4z2Ji4NvHidU1I/6XD?=
 =?us-ascii?Q?W0cRmP27AXcXIYABJKuKznorDzKRNA6DqLksg0tj1glZYviN9soDTuFHzVLW?=
 =?us-ascii?Q?P1nS6QRw8hlj3vCP3ZVkgum0Bofy2bnatc22eH9Kc1u1PIJljUHG+y8idHLQ?=
 =?us-ascii?Q?UmVG0lqKkzkkVfLtYg2FX4ieFFn0Nck1KCDpvcye2kyw8EQqW2idNq3E2UmM?=
 =?us-ascii?Q?3LqZVIgvO8v7E/8bTzCF2uofcZ/jy4Qi/2XhkNYa4xn7IlDGDEv1sBgnCl5b?=
 =?us-ascii?Q?uy8uEZ/49JRRxSrtNyQ6iDr6IRU8Lq3NFuUpHV7jJJX3IsQo+YgJJOKCVekI?=
 =?us-ascii?Q?QtL64RipYg4UqFEcLtiT0R+vmoKx2DnPZa2uReivD1CNSlkXkAhFUVAZdxLN?=
 =?us-ascii?Q?91nxpxsRuHHTEAST2A5Q5QYIkLPB1M6IwU47H63NZDk/W+fOKSjIejKE2Nbj?=
 =?us-ascii?Q?zThZDxaMefR0oKRW25AB4zPcDK/1RiI+gmFZCzSw0TNoyzWRX3cQNHKhGtU3?=
 =?us-ascii?Q?05iLoF/pyhjcAbbHdZtJuHWtlHDECze1dDUqLzkKY626VgDI3s8HEhR/5bCk?=
 =?us-ascii?Q?J7T7Ae6xSTtg4zvi2kqfi2yzoEucCUxWW8HFBLtdfW6aRjUmAx/NjP3XPvfl?=
 =?us-ascii?Q?r5afdmXLwuBS71UMQuX0I9jHpAb9m+Mx9clZwh3bZW2nWL7AQHJpqLMALOwK?=
 =?us-ascii?Q?d6w09/mloRj1HbVg11SKo+qij4sa6vTcZvZP5fAOUx68YsPRvmBufbjL0Gvv?=
 =?us-ascii?Q?Rsynp8Qrv7QELh5mkfVTLQaVJfO+I+RvvHX8N01wlXpcJdDRYDak5mlHY99E?=
 =?us-ascii?Q?n8Xn+fluPyqhhzAKo6/HOOm5sAAalB4oZUnA19aCT0ZfvUfNPFa4ZkXrjpp+?=
 =?us-ascii?Q?Y+vZX8iLhnfGUwBF5JXFABuGyFBd+ii5yboYTuAmOMJsHd6SudM6J8SogH/V?=
 =?us-ascii?Q?a3f/4tLIMAthSzDbI0Q163jfmr0/fSB3rQE8LH6cO/RzbpoChqghC8XbPeGl?=
 =?us-ascii?Q?/UqrkoLD155k+RvZPIqtmixx33rkziNCuk282BS+rAj8ZQ1xWxqN/kotxUHE?=
 =?us-ascii?Q?D2/tlzDXnNbMypMPm+tOVBxz/hKIqSy50o8+cUkS5ui03EOXUnXnHo0Le4Pz?=
 =?us-ascii?Q?FgBDSl6G7ia3LlI58jXRqPg7b97tdPmyMYyTNEBW8EZFlFNMftxHI+9IQUJi?=
 =?us-ascii?Q?aHC3njORTgiG6FaCDkDTVWDXA1Iyw7RqML7Dl7DcgbNlT8+CVrYfeqpE8aaE?=
 =?us-ascii?Q?6dOiUGXEeg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ce4216-531b-400a-8ba7-08de7db7ef00
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 08:43:27.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYqHLUniAysE3LI56tGwhwf4bCju1nZXCq3DpjUwoaf6dFoW+tG4H+oMBIrRletP+pkjZz7h8WGQblHZjN5Thg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7264

Add pcie0 and pcie0-ep supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 87 ++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index d2f31c8caf6e..8bd4ef9c7687 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -66,6 +66,13 @@ sai4_mclk: clock-sai4-mclk1 {
 		clock-output-names = "sai4_mclk";
 	};
 
+	clk_sys100m: clock-sys100m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "clk_sys100m";
+	};
+
 	firmware {
 		scmi {
 			compatible = "arm,scmi";
@@ -1223,6 +1230,86 @@ wdog3: watchdog@49220000 {
 			};
 		};
 
+		hsio_blk_ctl: syscon@4c0100c0 {
+			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
+			reg = <0x0 0x4c0100c0 0x0 0x1>;
+			#clock-cells = <1>;
+			clocks = <&clk_sys100m>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		};
+
+		pcie0: pcie@4c300000 {
+			compatible = "fsl,imx95-pcie";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x60100000 0 0xfe00000>,
+			      <0 0x4c360000 0 0x10000>,
+			      <0 0x4c340000 0 0x4000>;
+			reg-names = "dbi", "config", "atu", "app";
+			ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
+				 <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x80000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <2>;
+			msi-map = <0x0 &its 0x10 0x1>,
+				  <0x100 &its 0x11 0x7>;
+			msi-map-mask = <0x1ff>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			num-viewport = <8>;
+			interrupts = <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
+			assigned-clocks =<&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX94_CLK_HSIOPLL>,
+					 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			fsl,max-link-speed = <3>;
+			status = "disabled";
+		};
+
+		pcie0_ep: pcie-ep@4c300000 {
+			compatible = "fsl,imx95-pcie-ep";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x4c360000 0 0x1000>,
+			      <0 0x4c320000 0 0x1000>,
+			      <0 0x4c340000 0 0x4000>,
+			      <0 0x4c370000 0 0x10000>,
+			      <0x9 0 1 0>;
+			reg-names = "dbi","atu", "dbi2", "app", "dma", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks =<&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX94_CLK_HSIOPLL>,
+					 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			msi-map = <0x0 &its 0x10 0x1>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			status = "disabled";
+		};
+
 		netc_blk_ctrl: system-controller@4ceb0000 {
 			compatible = "nxp,imx94-netc-blk-ctrl";
 			reg = <0x0 0x4ceb0000 0x0 0x10000>,
-- 
2.37.1

