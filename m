Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80761EA7CE;
	Fri, 13 Mar 2026 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773378995; cv=fail; b=MtuM8TvWWrWB8RPLWfvRocnvwRlv22lwv8Gt4d6PQCfP4mt4oKA1kgH/x/C6GAWQ5bohQSLWodZWKWsPuITHKO1hYJopms8VsTHrY+8LjLO3X30bAHwcD1m7hcxEmf4VL6KlN3Udknr1dDgFAuwSuql9LOGtObV+GjtAk0xRB3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773378995; c=relaxed/simple;
	bh=mwq5btialApKywVOD3tImgKNOxrm7kP7sYil9geGAsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fTl2iCWRakaWS8NXxAZpiCjPKUIGt7A+BuYfazET3YtRifk+ORYxEDLLsdA5XnVqWfi1ZufuP7l3bD83NE1Go73GlbEHPycbNlsQztzI/UoC4Cglj70DDjR82JOzooJyJ9Iq5AUjNKij1ZtJT/70ee3o+l1TwHqsDNvu7Ih0v90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i0zT6aLb; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i0zT6aLb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmh6i9G/q8XIWcCg/n5aU7jLR6tlZNczkY1GITFdLM2vSyiqaVhD77jEPp6ZjW9pVyurDKaqjUpmZRt0brXQTHzjCSDOl2jptbCm+oYhjw2yIJUTYyEo9iq/FkmMZTYUYtZWez4YzJeGpK8IFLetsGCK49mz/nECPIFzNp9fnDKD5prwlz+0N8Bptj/9K52RAxAGRjOXk/QcF3mG7eOfhGMmDBxQk2ae6BG4iHCxQsuRMWJ2BCx11ykegpro7uHnNxknQSKGr3D/Y7CxFfx14iP+HTRnwYQHf+pMDKIIxpejtZbdR7zDsBx8O7tWX049cAihTGVeINXkmx8epXuF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+i7QGSZLg+0eo81oF6j8W+Spg/u69Q4F7jGv2cDuHA=;
 b=sqK4nVjqtL6EO4wrIa+VocRMvZ+fwu+2/R4mpKf5Oe125oO0yyCIx757cqSwMgoGbr5IjNssK7nIwKoGAoxlU4DAoe/6jJvnBqP7OfADaCslyy0GeCXk47pcjRXdrJRu+Ij2Hs0JENFrG8464bbakBOzXvX49tQilVFtTUEOUSpyc+INP6919H96Vq+SL5K3rTd+tkh5uFsOvUiw5GGI0R/0HSeAtKzOWpmwg1H1qU6o7E8QdtvaaKahbaUJSA4s7D/tk5VDkr71V4A2igdnW5iVsfMvtL4cjTthDeSQ5E0QKUgo8yFmILkQxPyhiSZyHOxa6ciYfePnO2ha/CUQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+i7QGSZLg+0eo81oF6j8W+Spg/u69Q4F7jGv2cDuHA=;
 b=i0zT6aLb1yxBsZV7jq1ppIisvLJBleE+1IwiEs0Uimk6paosYGfJkThq/AewChOGYnE2F/TQBNL6Zo+0XvrUbitF7eO4SCPkOszGax2/RQeb5PTYZ++g9Xy4XCKIQkUiCYTnSimyXA8oYILboTdaMmrObc8sJ1QInVlxhE44rGvoMyLg1+TeyaRRGZe7vqjaYq+MVwpRkO9EaQMw896rbbVe5PEsAt2CpUxY9kxmKtEmh9B1H/zhvTwKUjsjs6DoTRFIyvIPD4zTxPn4W3GwZ2COGGJMNUGN25boCXTsmZOCNukN8M2NEUoRnQeUToYNid9L+EluivxpVzTy2ZX99A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 05:16:23 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 05:16:19 +0000
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
Subject: [PATCH v6 4/5] arm64: dts: imx943: add pcie1 and pcie1-ep supports
Date: Fri, 13 Mar 2026 13:17:17 +0800
Message-Id: <20260313051718.1931375-5-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0012a58d-ff36-47de-7462-08de80bfaafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	dGBZgmzVfcJDjx2fGTduQrUXbd/W04mP8avRXiiRJs8UVy56IywAXmraZeKc9K2BV9gT6md4jHWWkUrXIZPVoRdCF4yHuZBXY/7eTpt+P2+B3xlpyaeLVHinP/oCBQDOCcnHdCeCEH/mbJ8orW0nITslLLFjE1WSHdkNTJ38F5wVUuICXYvrqE/eS3KkSe8/P5uA2SzRhr+g1u1Q+6BfZ7VY5cXVjctyFjmaoboqIgzaMYrOjAxSS7i27Nxb17KAXXUKJTNnOBR35g9GNmI/p1lVluOElzeRwq7+JzRc41jZCE84bDPvnkRrhKVjdpMHxsTO7UlfE9GPhCPRk8jOtO9+L/ie9a7j4f/iGdfXIsYwyP9v7QDufbrvUyB/tT9IJSbOXU7RXXPQzU6WMiv9A8Nr54+bK3P5QS01fVuy+z+Mh8kmmowRQuc93n7Q4aXNpkfaDKBXZL2KSn9+OU8Yg7jBEj4UKfN1VqFLwwzVFmPqaAntuqB0DXHQkxZVtMVw1Q+m8v6uq+nCFu1MI0DXK+QxaHLp6QakBdTSpoGaJF7IVWQm1qnpw0m5ZArinEL8jVPjE9uGMMY+sRyOn/piPphw/1CJSqEjahnpZOMlEGH3lHtsslDpfEAdnMH4atwnL2k/VLmqCqZSKzz7Oh0fTSsczCTvv2uDyUbn/sZyxpxenvOGLMbMIljAPmbunrZiuZEz6Z/jmoR4n6hodY+26F/yBIFErfh/q2gD7rjLGoIU6rNMFwSr/I3pur8ybsNZ39CKX4DXDTaf3jOvXJErcGoak/Fc7I4dy4mHPt5OXkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GJguH3mINBvNObxYuxBIsM9gLDgb3sS0GgQxEzsDkct3CCzcdzq2C9skn4tG?=
 =?us-ascii?Q?/EjG0aYAke1d2F8r1C4FRaW9qCYnYLTmBMcQPqJnXi+JipfwW7xWG0kqZzsv?=
 =?us-ascii?Q?wKLOYich/jxxbKeBetI8t9j2V/JzIvvp6fmzWbetwu06G1rKsCosupHP74tg?=
 =?us-ascii?Q?wOp88f4y+nKOKq6FaqLnKxnYcb/HPo6ya+NIGASJb8OfLEu+2vgxvpbMPnjp?=
 =?us-ascii?Q?B16ObHhMeaSU3D/0ZwG5R/1P/VHwbez+zAJzTVxRkhR7dzW3Vr/qjoittJkl?=
 =?us-ascii?Q?/j3knb2JK17aQZVzdsGlokg7MJ0u+XW5YgWuai5H977DKpkYEti/U9E4g5ir?=
 =?us-ascii?Q?oOT3lvzp9Hz+FtV/beUQv4WAu9FhlNhylR42v0j5isjC5pH0egsMS3JmWsVv?=
 =?us-ascii?Q?Y8o927wxoKgfhDsqKQ13rNJCJDBXW74dqiABL/5MaRBiLE22fxdmdCGCdAMN?=
 =?us-ascii?Q?HJ+Im/C3KHKNRtVm13ZTH3QApB4+fHw1yyF54pMurKStfc6v2/DsoBwKbMTC?=
 =?us-ascii?Q?CT7ih4LwOROWVsqUMQUgTdrTz2fXMzsuBVa/DS2DVE0T+khxV5GHeyv8Ag6E?=
 =?us-ascii?Q?Dk32/nvQQH6J/CmgT6VE+0RNgJzIolhFVU84dZB4B4SWbrYREyxNJszxt1VW?=
 =?us-ascii?Q?FXTfvtFuAts2ah4dbR6K3yQrRvhnEIvuYaEkbQrRrPMX5FwsiNT+lM3zg5sM?=
 =?us-ascii?Q?3PvGi4911xSCYbF+d+bPo9UMJhHJsFweVdhCU9prAVXDqvV1zEPGDMzhIg5H?=
 =?us-ascii?Q?4YnM0kpYhAFxNKzmHfyDSynbm1liNJPG9RqOIk+tjm5QYktkA5s1lKAcz9gD?=
 =?us-ascii?Q?Bs6GUjzOW3mvK/j+8ASnEj1tIGMXIGuLgZPnesT4n1keCszlL2JDQDqhIfp8?=
 =?us-ascii?Q?jqSyfp4hbJd9uZWZbL8LixVq3tyC6cizud9FRqe9HqOeMaNukMMglk20+DiU?=
 =?us-ascii?Q?AYvbdsnB5Jm5WxI6bSQycnceA5eJC19A+wo80kWYGPeuvBMbsRYHKeVPOJ0I?=
 =?us-ascii?Q?oQ34zz3MyHVLuwKG9q3fM7qOaCEo+Jrxp4f77uwHIf8pWU0X7yZ9covzXm+t?=
 =?us-ascii?Q?5iiSNXL5gKMktatHoNtXNbF6pEAjO7p2oTSnsDRiZlK7CImiO2y71Wzc6ikU?=
 =?us-ascii?Q?nb4ig3eTSqbHWRpk+6H0bhiCFKdBFMHi2/F0Av8sNO9FugkgH68LQhP59YJj?=
 =?us-ascii?Q?b0UG1f9Vvyh2aOMNhNG+BchgoPt8gdd8I2W5aTj4i0owLzKN0eRSe6FsM0og?=
 =?us-ascii?Q?s0p1+NBVyNqQc1XX5v4xBGUSXE3xmTjzOm4R9ENOWFzvFnNljDe3z5waXRye?=
 =?us-ascii?Q?OvD183M946KF97/wyZQnoW9UKUfmLTo82bvERMenS7zMEHPmFaQuDQlCK75B?=
 =?us-ascii?Q?yt1DZLvqecxQfsjWowjgvcaJ7hCMhP5bg13nuUV1SDM4X9P1qAusZf/bIEp1?=
 =?us-ascii?Q?X+IZ24lJrZ6JLDDt7rzO50ZnPho949BwBrEgdw9/h5lmyQwgctUJ/VKw3lbQ?=
 =?us-ascii?Q?cE87biJYK9zHVLp3Xwe608Qe3mN167AfG3XOA96MJpaAzheJrCdCDsX57XAp?=
 =?us-ascii?Q?xhrwDpWDBR/mRR4TTS1fr3pW+Z2c05nshsB48CPZg6lTdfo+bXRD841euoMz?=
 =?us-ascii?Q?NifZ1LnpIVvwlLvEUCwtuJj6IevWsNYjthgc7Utzh1JAk3hKTE4udeEiJQX5?=
 =?us-ascii?Q?Gq9UoliyDIRHg5t7URvy37JzvR2Jz9h8w5jCBFF4X54gf+daS5/+4YBL6Loa?=
 =?us-ascii?Q?1neVY+A8rQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0012a58d-ff36-47de-7462-08de80bfaafb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 05:16:19.8187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSPQzc0NwsyScq2j7+MyLBJK/JMeYobHXbs6c34j8+NHtMaG2T1RxLzfeuibiOlrB+IGQJllY1alRpB+cXzWdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816

Add pcie1 and pcie1-ep supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx943.dtsi | 75 +++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx943.dtsi b/arch/arm64/boot/dts/freescale/imx943.dtsi
index 45b8da758e87..8575134176f5 100644
--- a/arch/arm64/boot/dts/freescale/imx943.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx943.dtsi
@@ -145,4 +145,79 @@ l3_cache: l3-cache {
 			cache-unified;
 		};
 	};
+
+	soc {
+		pcie1: pcie@4c380000 {
+			compatible = "fsl,imx943-pcie", "fsl,imx95-pcie";
+			reg = <0 0x4c380000 0 0x10000>,
+			      <8 0x80100000 0 0xfe00000>,
+			      <0 0x4c3e0000 0 0x10000>,
+			      <0 0x4c3c0000 0 0x4000>;
+			reg-names = "dbi", "config", "atu", "app";
+			ranges = <0x81000000 0 0x00000000 0x8 0x8ff00000 0 0x00100000>,
+				 <0x82000000 0 0x10000000 0xa 0x10000000 0 0x80000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <3>;
+			msi-map = <0x0 &its 0x98 0x1>,
+				  <0x100 &its 0x99 0x7>;
+			msi-map-mask = <0x1ff>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			num-viewport = <8>;
+			interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
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
+		pcie1_ep: pcie-ep@4c380000 {
+			compatible = "fsl,imx943-pcie-ep", "fsl,imx95-pcie-ep";
+			reg = <0 0x4c380000 0 0x10000>,
+			      <0 0x4c3e0000 0 0x1000>,
+			      <0 0x4c3a0000 0 0x1000>,
+			      <0 0x4c3c0000 0 0x4000>,
+			      <0 0x4c3f0000 0 0x10000>,
+			      <0xa 0 1 0>;
+			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
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
+			msi-map = <0x0 &its 0x98 0x1>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.37.1

