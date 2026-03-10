Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B0364EBA;
	Tue, 10 Mar 2026 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129235; cv=fail; b=eC0Qn8crTgmjmDMCtRa5ypBzSLpwMRQUCBmEV/BCtxV7pGfRv6Jjl5tiH4d9oNypio+aIOePdSOXXdeaG7f7lO92iNV32gePE9fhcdB/jetH9a1KUpB6n1NFCa8dZmxw6qir4qfC97uN/4Cc+QqT4N2e918jbpC9vceLgrmfBGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129235; c=relaxed/simple;
	bh=WHoRW38pWAqogntxxeaOvbJz4VIxiQ8XBFOScxDLcbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nute1jDMLdjPejKVPA5k/+jzCQ82qoF/SsNdBX+t+6M17Pjmxw0n+gGnznc3JFblsdWzYLNNG/5LUAzxjkGNVpy8NYiKlrwUykZzwKRAvvLSfIDq3P8upvxdw7hI/593NzOmkc4VtAFnz16vyjltvMjt65FSkhG4HmNRnnyT788=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cF9hXtTf; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cF9hXtTf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/+RDu/r24chWEF8BTq0YWhtqj9E6bKcQ8biA9Yoe+VzfHjCp3TeLV2nXF5iDDitJg4ZWIwTl8T8Fd9YeCIunYApuHPh9Z/bGgqVd6FowHtUaOW9+3o7D6lviiNJLHKszE8HxHDudqY7YPBoUouDlafwUAHd/rVUiJwnObn4sSndDUl2G9hsDkP08+6QVNGRxI+fGKT2MQnfc7jb2E9tYalW+RxBjiZGzUHrqNn1jU2ZSePREefzEDvYdh1vrThtx+wwcv9sNBrsqmao2Z++2Jd84yZFSWqkJtsQJVloIxmcnJLGHEPfhDl3wxwo8NNiDjdaIPd4mmUqhOjkQAeDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCw4jLB4NZhdxCsib6YvpHqWbG5QfeOZu0eeuyZMOGM=;
 b=Ms5DW9Ow5Gu1IByYFgUGZpWX6WcsA1vWjizZK+1rwYBO8UzvHnV95zaQeGiXYfp8XmVN2195vyrb135XFdOYhOemCzPzmE0ibyGhrRpwxSb7UEYaJasuzp9vUTEHfnVsY7kDuzcmDimnSRx61l6PCMXH7nAG4bgysFmma3jVX5imA/tTHHHwkcb2Fmq47lLszXGME8YR8mhUscPLiOkdc35EiHsFVgwa7b5z/ghILMKj/Wc85qSpqhL5zuDo+rdZ0NT1ajYjQkEF0P8REKRuPFY+lZ8tOvGMuP2DLs1ubb2pv/hJHw9mPBEiYj/cFFfccEpiQZ1cE6Qg09tywZ5VYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCw4jLB4NZhdxCsib6YvpHqWbG5QfeOZu0eeuyZMOGM=;
 b=cF9hXtTfJGIqxNIIxHaZ9yuvyqLIQve1nbvDPQoY19203gpgT1GqcdzNhu/YRZQ5BZoqFpHmbjVmw4AqT/NaErpW5WUlpisOeehGdo3u3RsOep6hrGyzw9L2t3DDdOvk7Mv/TM4lz9sbG/A2sp4CuHM4t4HQa2S5fdZmGlMuTwaBDvk+lvggM0adXHaqTlGkZw8jvRO/xIzphfIg2T+LuZ2FnItHz1R8nWzu+XGQigwRT+7w3R47jwHH5vj29iWqQmCoKW1d7kXmZ1r9zIYZMwIoArEewJZ6TVSbcQeSc+NDU32KnqLZxUHfTldPHA+XBJz+wgiMdDnD8K5uPeuslg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 07:53:44 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 07:53:50 +0000
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
Subject: [PATCH v4 2/4] arm64: dts: imx94: add pcie0 and pcie0-ep supports
Date: Tue, 10 Mar 2026 15:54:57 +0800
Message-Id: <20260310075459.726495-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310075459.726495-1-hongxing.zhu@nxp.com>
References: <20260310075459.726495-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a71221-2fa4-41e9-cf2c-08de7e7a2b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	51aUKwKpnXG0Qx//PrfHGB4n6wee9qfz6+Fprm9HsmmmnV0Yc2gQtoTTH0TFZeEH2YIYMinhLf9O+eoRHIYt9Q0PS/6v/gDYGvpap5mTSPGnZDUh+3tI4VZUeZLnWVvN4x1isI8GyOMt+KNDniPjqieWaiUpZjglAP0C1ODBLcIupclE5GAtaN9wsRR+IirzFScPREDfASE+KOV/0vaEn9+X4EcLGSsZELhqRiTU0xGgt+BEmVhnJx3LJlOh7DU2bcm4dXlcrR1rq4/m2scu5p1o9HBEYm2BoY4rpW4yPd7YEQtajtXZcJ8FW/TnfQo2bHd+DRcpDPcUrffyru6hHCC+ihTWUzP+5GN7KEgYcmulCRCJg7CoNwN48ebxZY0ArCYQITL5lFawQZZWlU0mN03CO/Mgdj2nU81PANRsLatlwS8C1RdHKjq1GVMc/SPkx29tdP5I1C2OUJFP4MJaphPaR2yFxxSVFMjLfMEjsY3KjcKcqbPxrofRHUafiRch6lsuF0bkpIMrz7jxwH1Vr4Kj6qEiTSObkI3lMAtF1yg76511flprLo8PuGUt4DeZ2zsw6zoq2D7Be7GuR/H/jmrirmz8e1ZXOB5BNm4CqLljZK/a7+g7N4wZe9Ft4/0z8CB2kz1RiAbSno1TksLUO/CChW6isUSnFTdgzf6VBCiJeZHcJerBh8TwPOWo16p0ygKUvEk0V4BM1NqDacyMa8oZWoUxjOoPjqNlsTgpRZOrGFXJhX/WqF+oFEtoKal9Axtc5UAN1hH6Cm9q0bOrEfDs0R5MzLfxfwqschnhkcFEl63hx6Lh+Neg5DOB0Ia5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LO3wmT1F7KhaFqvS8UW3rwUU5vP/weYhcU+Dsp/O03Y3vc0p4eUaosNudwKy?=
 =?us-ascii?Q?zmsCvLs0PUs9liGM/f7/hMCivF3syK5u0IhUp2N/CwIN4TxOqSL3A5Sp5Idm?=
 =?us-ascii?Q?+FuvSKp+12AUp9h1OhGON6bFeFkcVcFuCeHHasyTzKObY2IkEQ02xU0nqNAK?=
 =?us-ascii?Q?u8Amk35HY8UZ5opjxDQl/3FKbIKuKMsfikiNkf3k16VDy5yo164O7m1tjAzU?=
 =?us-ascii?Q?YwtSPL6r/cnYSXyTbr+kcrW0vLes+EqmyZ8ywUZaDjTohaxHJZ4oNr6EQl+k?=
 =?us-ascii?Q?16F5k9zygR2GS5AfEAuuReK+Nn9eigNj7jCySpgfJeK28rCmpZ5L4ueIDDxQ?=
 =?us-ascii?Q?ltsL6At6L8Nad6iWMEq0afvp0TFiUJMPLhR5CWkxbnwHrBKx8hyHxbVKMfb8?=
 =?us-ascii?Q?4prMpHR4uYoWkr7V3E2roXpxZv+1DDN+XKiUxG8hkAq0D5xsg2NfKeujGcmY?=
 =?us-ascii?Q?sfY3c2eL5oM/Jtv0rUyNNMHWO5zH5onyPtbl1fp2vmE/UnXrO9x3kFYv5Hy8?=
 =?us-ascii?Q?6u23uJy49/ooifI4j9jr7WSRI6VW5GfTtnTOUsXphivctAzhBhH6vemRmciH?=
 =?us-ascii?Q?tlkaMjiQGGg1IxqYJHLivmMz4zV0blsFpJAKTEhyAw/gl90L9qkVVQSjhqpP?=
 =?us-ascii?Q?ZWmxtmLpXxyVudtBJwdv3JzRtPzmpP2P3QI4hOMOQvE+L6rvBel3xgmNAFxw?=
 =?us-ascii?Q?fK3Z4fEkhjKxaOg01kGRRHxVzkK+d+cNo27MmCIBiFkxerqIjaZwh875gTNB?=
 =?us-ascii?Q?yqLgo8pA8zgDDqDO6X5iXSn70Pqt925TWrAJUdUZBXn9e/fyU/0k81Rli9jn?=
 =?us-ascii?Q?znFuQ0snctCdeniR59AQxdnzsdoAIMBwe3uEZqECWtc9bf/F4m84+gnzoixi?=
 =?us-ascii?Q?4xC4Jp+oDZcdenClLrLLOsXEBnYMvFL2LTosPlYyRt6Fgbhokjos1UZV4/PG?=
 =?us-ascii?Q?fhcEpgRCBqZ1WZFAgInKUSkwsXKpq2tWJB9qF9sj5huRvKl3sfejYw66wkDN?=
 =?us-ascii?Q?yh36cnkxDs/w1pYqeGCYe+425de59Rd1d6ues2RU1sDzi+Ntd52dumrLI4mr?=
 =?us-ascii?Q?vWOO4xcQl0kmEn5gsoiFNhpyPxtjXzx5UgiVzEBmrkkC+tIZEWKAE08OgZGz?=
 =?us-ascii?Q?XvF8Ub/1Drqy5XOtajBy9vlp54RES45BlwAJLjI+iesqDyNcmpyMYgOPhXHA?=
 =?us-ascii?Q?egPw0Ym7+jGIkRetuOtjVyTEWFjuCAfvYqb9u3Xt+4lmVXU9IZmSkOetrjAc?=
 =?us-ascii?Q?mCwFGzXWvHf0bypEzEQSqh74pQP9O1lnCLb2k4WAIXJy4gHtvWGo7EWct4qK?=
 =?us-ascii?Q?+EaYeOsLeI4fxuz7SXJBd5+rO95IE2KR0URSpYu9quK71KPMvTd8iulfC4Gt?=
 =?us-ascii?Q?khFqCXyYV3EszETgILy4v8PANKROT6jX0IlXZK4Arvf8C8wO5yAnLvM4Bm7Y?=
 =?us-ascii?Q?Hfi971b1ZqnYOLhn47TUXKZxQrWOT0nVs9SgLYhJ6gtYkox0+poF05nxFBCM?=
 =?us-ascii?Q?NyxrfRKnPWahlcnp2+od+sRR+8IUyLCiMebr0/mfPkMa3ZDHP2pkQBWTB5lt?=
 =?us-ascii?Q?T8MqR8jlUsjxi80T+/EDIM5phhiiTTQNoQ8CxsH9pNakplVYM5aRvvleM3JL?=
 =?us-ascii?Q?v3a3K2nUie19Cf0Ojbavi9K5qVttZyYq5uGByrszJ+XQEfQC99NlagWzy9fb?=
 =?us-ascii?Q?zZv9yrP3pijbqt0jGfVqAk0JuUVaW0jOCPGRzX0cEYKPraVh0j41Xjb9t7O1?=
 =?us-ascii?Q?j1UJYlZU0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a71221-2fa4-41e9-cf2c-08de7e7a2b01
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 07:53:50.6876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5P51neF6RkOqyVB6zp+KpJUUgEpWR/XeQrLEJbevyIHvZyxgVOvw0MYo+CObH8xiNCgkj1CnD74VTJV1H5Z5RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128

Add pcie0 and pcie0-ep supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 86 ++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index d2f31c8caf6e..2f75e8762b4e 100644
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
@@ -1223,6 +1230,85 @@ wdog3: watchdog@49220000 {
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
+			assigned-clocks = <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					  <&scmi_clk IMX94_CLK_HSIOPLL>,
+					  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
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
+			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
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

