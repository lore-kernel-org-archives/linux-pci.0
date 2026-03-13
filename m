Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7686225393B;
	Fri, 13 Mar 2026 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773378989; cv=fail; b=AE+CMW8mpYGpg6ZuEfkLI+UXqWq2LR+DMyCOX+0X/ReorBNb2ruy354TnZYMjmCAFq1/sjxQ2tYdEx+LCve1np8Drp0MpaeNAC7tYlcFTFv2s+fp/4DpHVrksRTMxfypMzrVSeNzqu9iXWAsiwl5bMOrno2l/Zyu1TdkY8fuNeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773378989; c=relaxed/simple;
	bh=uOFf8lFjzgHydBAlJMmPZMLPbZu0F+kjeeTlAgsORfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h3lOs0Ha8TOVgNgz3MaDhJ9COHuGCDqQT2eoCug6G9B+LrGj1usiPbKrt7UfbKnNEcd26ukdLot0iu6QJqm6vrgiYnjxiEJbf1GWW8FJcEN/vqu/nBesAcr2AWc2/UKmMjZeL1kxMpEhOi7R4mHDAyIyCOrfGd81n3vzF4wKOmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rso+MpRE; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rso+MpRE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTD1aw/UEeKCwy/KIksmXrcfos4zU0s2olYG+pXY+JZ+qxPl25oy2QlTXKRGjF1zPmcSmFH2179qpRkHBzidVqy2yADBUTzND8yDTWb8+IbYGTd9isomI4sMIz5t8UPPPQukbiXS3rYL82ekUX6Q7BRUDXjmbmDnklYnU4yGbtJ2h1PGx8TuB/p6Vg/R1W1Rngca/LsFi/mWMLmThtU6nlsIUafulNFgBcrTSkHL50MIqc3B5FrZEdMMQVEWD2hH6GdgtN9uuXQtdl6s8qRx7m3GXwi8dWGXmw2ZErgq8Ht9cB40amTBiNlCFjH7hn8ba9twBdCV24iN29Odf9bi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FyNVDT1i2toV5G+AkwDNTp/wvujDSgOLEKOBLYlqCk=;
 b=wiTTv1/IregEQuA6gnJ1RBkjt5n+movBdWJmgEMq3z152ygIKFt0kheR0sxscGMTMNBE4X4jGMYtYZ7SOG10dH1E2uvB20rXA5nhBLUxqwnoushAR61rV5wmoggzCE198XW+jBzj3w9sYW0gvkzXLa8ByimWZguZ4yDxw6xS0ODn2T+mAOTWbL5yL59iuLze3dhNKIfDOVAn/Y9j0BEKo6bjH1r0feV89ntOzUBOn7KamfJRHV8IUG8Crj2eCZbc4U9Z6wTyRxaFBWcN9ZZvd4WqgHLtlHmgzmh7x3RfVfpV3JUJowSw34SsnziFO1tlhoHQnv6XXYDSTGAakU6Saw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FyNVDT1i2toV5G+AkwDNTp/wvujDSgOLEKOBLYlqCk=;
 b=Rso+MpRENFpwxPiYKAQSJ+mNsBs5snmokopysQgqNkQDWa28sPtbpS9qq1FfJ/MLD7B5tFjYIWBk/vMjLVUjq7muV1EZe2wn0oI8h08k0j8EXJteKQouwRd29PyhK3Ok9LjIXldT/VBeFCNv40KszGJnBzRocADfCqaiOYqkqilG41nq9LpA8iFEC4lmvWzt9lif/YBADeWYDDyQRtsnZATQfiwQFkTxJfwl021ZRlOMnodn4F2elM5XPZ32ZTxzHgYMjig/TRJ7WcL9bO88JOC0byrHCjeLZXbFfRFr7OvOWjr6fvzIZUp0wm4Nk15OE1cdztGkGGLDj+ZwJeJ3Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 05:16:17 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 05:16:13 +0000
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
Subject: [PATCH v6 3/5] arm64: dts: imx94: add pcie0 and pcie0-ep supports
Date: Fri, 13 Mar 2026 13:17:16 +0800
Message-Id: <20260313051718.1931375-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313051718.1931375-1-hongxing.zhu@nxp.com>
References: <20260313051718.1931375-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0161.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::12) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|DU4PR04MB10816:EE_
X-MS-Office365-Filtering-Correlation-Id: a773b99b-6b86-4e71-53bb-08de80bfa71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	ibholWQko+CJq6uD4B+pK3r+9d3eIgQ8kvwkPIXSgnpx+L2RVAwJKtrUbAxEC03y1ylAJmvjKSFLbZWIXkLXoVi92yh2VVSSlW5Ps/X6KtsbjDlCdLxBxWMFVTjXv6q/NGbCPwoGFPhSAZIHIoY5iDHR8j/Dpk4H1j+i+q0sQPTp0WEVNdGeZ5m+ZDPjCWvWNMh3cp7kJVZC0xYNTN8uwYefBcjF70+JWaKTquRzZtW+Hl73UuX76wbTVgQkOuZrV3IYOp1hMva/6RdSHR4gGnp6e+B8kdc2oKmXatrNGArIs/jvVKJkDaAvOCXVlLc9x0QFXiSCudszYu2VHL6O4QLp1q0j6xFk/TbeiyhD+R2kY9BRlaZjvo9636zm/EcDZ4FI6ZKJdwEPMZId2J9aqt+LVHOEtr6SO0mzntjNVW3biJD8a/mltFplm+/zHskWQtzmAVKu8ti7neX+GW8j7y8kQzjaigLDkXecO8aHK6O8gpTWqrv/yjAqNPKvDUIZUH9P3U9P/iRLFL6NIBw/UOvz0FkU43xfaIw/59l8lZ3E+QsQvv8gAfZeBn/D5z39J5BeeG6Q8O+fb3jD+zEpB9ttGGEpcesb4s+V9CQ2u7718zTq7dbPvHDo07uU9I/jd56RPWIMTjenO33bsjG0W20XH3H/M/qz35mRUSE0ZfjGKk8Dhec8xpT8SR2bqvq31ay0tGBQ8X7xQfGrYjja4t9PiQe8eq7vQczkgsjFpE8gQDAQ78PnFs+BSCIYM1yymjksQW+G5p0ezuR1znNjI3hV1dX0l+Y1VHMRTAftWZnnG8k/AsFXalaZsNRmAQ1R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cZUsFytSww6KLmZv6djIwDEwql0hDtfq5VktdHKpKfo1mKf3Pow08BjfdBu7?=
 =?us-ascii?Q?lSbg1Ysi6SbVVenqbMFn8VQzZYEOaieuCHkVF9yHjMI1sMNmzgoGRZpkbKNn?=
 =?us-ascii?Q?YTIR9eMnmjo2lpOTImlwQyLgQtAViEqT2oqE9Pvvc8ZS+iQCLUTTyl7RUwc8?=
 =?us-ascii?Q?Zz6yUb45XxbtMzoZtbuNqqwzq7/uQVWFJY5i1EAC3sGmlUzQQyNWvQpSefqW?=
 =?us-ascii?Q?kAh+Oe42gIcYlYYJtxs3wQems7XOcoyp0Fc52JYd+q/vVHsWsHBgd22LjH5M?=
 =?us-ascii?Q?1IPeFl5dfT1g8GJ+3XjkYA7b3MC95Mdo3Y3SSnGP6ECAbj+ATFyLmvN7P/XX?=
 =?us-ascii?Q?20GZ/XTqcZ9rvuOUTiHIJmBGrK4GyYrBHaG9bq938S7S19o5mp8oZ/FilVFj?=
 =?us-ascii?Q?xvsR4Ovflt2Tog7SoeMS20RbCPvCv1R9m2mjqpMMqKYPScd30jSdkJctpDeL?=
 =?us-ascii?Q?Dco2CtCbXXNke3/VrAnAcZGzzsrkz10PEv5vZxghe9gfYm647GHbT4w+RStP?=
 =?us-ascii?Q?5zJ11m5NvggEeTh/JVXg8jyy8Tf3RXfY5BsW+YXYjo0PQcZprfLf2TwNA2px?=
 =?us-ascii?Q?EA35Qb3m0rmL8qYlcDxZInJDxOgUWxd4jyuGMpYkBz1tYtBn8y7ZQXnAb50z?=
 =?us-ascii?Q?lK+MCnfF8eBXJz3Cs/Re0IQBcoUc50X78cee73JETXeoMDje41JYa+hRC53V?=
 =?us-ascii?Q?9pD8n0EOroswbzUUAy006CMxttAvbfngP+Nr0/dRTZsswIjNAeXqqDTEaoWN?=
 =?us-ascii?Q?C/flah7tHVvUG7ORqyDP7CIidBBorkR7U5AgIPq22SSj/gc+wLri4dTqt8/i?=
 =?us-ascii?Q?zqksnh/WLpShKwh0sWMdpn0+Bvh3XJU0WD5nJkbnkjhkEPgSvhYFnvMpjCBJ?=
 =?us-ascii?Q?2sH9Su3yBaKtbSnd41HymNmBL088sqrJ2PAMceQ9fhRH3+6GxmVUpyZ2a7qD?=
 =?us-ascii?Q?lxgOehAC0gG5bzmj+UpH9grsCZhu/UCjtQ5RPbTYteSWWj4muSGh3KSelWsm?=
 =?us-ascii?Q?qD/bWkktIVi0nUwwyZCnYFS1ysOEpa/saY/PuX6YHKkHk3hUBzH2dZP4gfFb?=
 =?us-ascii?Q?B+n8R3uQ80tD+gAOZfCqzjF9tmqh7D27PohFtIiyhGB/vnUvMjt/MLy0yWXo?=
 =?us-ascii?Q?4s4lPPFX8SHEKD5AWBYNug1OShPmCJaPywbtqRaCJ4c4ZlnSR2zvzkKAuiXo?=
 =?us-ascii?Q?8hdpeO2MLwWC6Hlixnu5GRSmY44i9frmYSSbf6C0GSpvUv2I2bYkYMxNaFAo?=
 =?us-ascii?Q?8W89yCjCBMBZB7/RZGEJeBAjATMezdrr6XaY1d/1EmgK/76Ob1KTVQBLHQud?=
 =?us-ascii?Q?6xq+S6vqxjQ9qt9az9eH/piyzIRFRnV6JlD4vo3aEgZugZknT9usP/VBPcmF?=
 =?us-ascii?Q?ROlrW1jH6MZbcyU8UV4vQfRssK1E5LvHxkgAw+WWLcQ0KlLTNEZBuzesBrfl?=
 =?us-ascii?Q?JuT0KUc2Ue5p6O3BOPQCunTpK6YLsdc+q3t4zquF9LAuniEp6tlI/VRBOf62?=
 =?us-ascii?Q?2qacgJnWJ0+32ZV0STEVcaqaQViY8IdiEQLIAFhNQSlF0qxmiQsI4DFEy1Ic?=
 =?us-ascii?Q?YtZ6r0PKCqf3AvX108/aoHyE5QStfFFBc5CE+d3Xaz1EQJ7nrfahIHZ6B0Hc?=
 =?us-ascii?Q?dW5aYQa14ZqbClXYI8S0eDPlRkGEWknyhp1GWcUcqDJy7W8UM8Ry7XbmI2qf?=
 =?us-ascii?Q?2YOIW/DnUwhiXY4vm4g8QXb1BNxB83pvESuDop21Bd0U+rmzGdmzqu6u05ns?=
 =?us-ascii?Q?kRJTWCZ6hQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a773b99b-6b86-4e71-53bb-08de80bfa71b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 05:16:13.4790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANYnzq1zXD2ai0Fvj+WWuOHJaUVsH30qyuU27uQ8BXkY/19uUELTEqveeggA7ehLaXAlRJ33vNgnk/Kn5SGTnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816

Add pcie0 and pcie0-ep supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 88 ++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index d2f31c8caf6e..2d8b870554bf 100644
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
@@ -1223,6 +1230,87 @@ wdog3: watchdog@49220000 {
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
+			compatible = "fsl,imx94-pcie", "fsl,imx95-pcie";
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
+			interrupts = <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma";
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
+			assigned-clocks = <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					  <&scmi_clk IMX94_CLK_HSIOPLL>,
+					  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			fsl,max-link-speed = <3>;
+			status = "disabled";
+		};
+
+		pcie0_ep: pcie-ep@4c300000 {
+			compatible = "fsl,imx94-pcie-ep", "fsl,imx95-pcie-ep";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x4c360000 0 0x1000>,
+			      <0 0x4c320000 0 0x1000>,
+			      <0 0x4c340000 0 0x4000>,
+			      <0 0x4c370000 0 0x10000>,
+			      <0x9 0 1 0>;
+			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks = <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					  <&scmi_clk IMX94_CLK_HSIOPLL>,
+					  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
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

