Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81E3845A7;
	Fri, 13 Mar 2026 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390834; cv=fail; b=O9oYlNIiBPc3g/HC7vzEvUQaCE3nVIuhV5FukCQViOnUn4U9v+I4XvtBC97l3VdlcrPe93fnSpeVwAOcges/5Lz6ma1eGZKEj5iZmxpfb81uEqRF85FxY7QQ82YG3CQrCk8nhhBxQboecbTh9LstrDer2rrbEAo0SzeT6kitsB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390834; c=relaxed/simple;
	bh=mwq5btialApKywVOD3tImgKNOxrm7kP7sYil9geGAsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NIP6TlahcHrO0Nv+GgGGBuQS3FJeegFUFSoZPsaYcVBz9Hvo56cj6Slm5KSOgO+GsZjulBr4twXRmp7jdAlRPPRxtx3Yk6JPrY/PX3V9jpaB09ul+UEsXpfFCGjX/AP0G1TQRT0pVLGvQBxN7RdeRsh9DCygg2C27VQbD3Rf1bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fOkbENfV; arc=fail smtp.client-ip=52.101.84.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fOkbENfV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ccj1WUZ6RlG3pNWiyO7t3YVRxNpRllwYnv6XBEqQ5oUGdCzCvQXh8TmNyYQkRvkFIUK/ANQfOQE97w3+PZKVX7BXCiFztj1tu8HovxoEV7uVXXgCu42b5wCDoD67NMEjb452TKJzjsjpO+d+dDR9R33385KIZ9jd9Cf4mNGw5NUtC5gFJdKptsjL5omgbpx6INmdozkATK2WtdtROhgOFdrEWNqqHe36rgTF0+rS2+HIgrwSr6u32P1NMwsx+hYK1+JPdtlp3L8tzSOvL1GX3WejUxaAE+gtTa5U1VF38tchTNzd9FYz6fdhwFltTtqZvGPcoNXpM15ZqeGOVR/jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+i7QGSZLg+0eo81oF6j8W+Spg/u69Q4F7jGv2cDuHA=;
 b=Wi2vj02Ye5nDY0y5Fm4brBLBleQXbfn6uJEjeeZdh/ST2ueTPrvcNxC2NN6RcyshwgfUCRjwPI13VnmmV/q/jsMI/72LkfUfjdlR8ALoC8fA6IReCQa/ibRd+yk1wVkH7Jv/7EV6N1lE8JuSUoU2fINhcwfFg8YnMOCKh/FPilbw2ngq4wpFvbPy42V6IffLn3a8pljxe6+HxxL3Wxozfs52ssLlDg10TRKBLflI+BwerqZ6bMiGkCC6h8lA71ysaeYy1Fhlhp9NIJR9HAGri9eixDXZMeKJiyuvjKrNdDsYAImwVyf9LrRYo9Ha3H2qrjQ/wgVuqVCs9Z4XP9QYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+i7QGSZLg+0eo81oF6j8W+Spg/u69Q4F7jGv2cDuHA=;
 b=fOkbENfVnYs7YczMHLQsT9VRj+1N+rupbIXlqgLerTIPWQP22xmER+tu0nuPOSDdjDGN0qeEQIfN4gkBzbN+voKLPAyK3BgAJ70Jf9fB1JJDRxzZR0LjI11PKPVaCC5itPDF+dfS5nTpG37uk+S/Ck5ajkcshuhnSZ/N//xjN2z6Mj3Z7qaP488rx1vTA5iYVQyovQrWt0MvRoy9HOvTt56xBWYvAkQxr//PzHgfYFMuZEe1bYPVQK3tzEB/tM+uDc3sZ34/XJA/kA8eYKmwmhnxMDGeRrZOi7Gp9+1KFia80Pn85dOHO09q15Q9u+mJISqryBybCAn2dAlSsP1Xwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 08:33:40 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 08:33:37 +0000
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
Subject: [PATCH v7 4/5] arm64: dts: imx943: add pcie1 and pcie1-ep supports
Date: Fri, 13 Mar 2026 16:34:42 +0800
Message-Id: <20260313083443.2391254-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313083443.2391254-1-hongxing.zhu@nxp.com>
References: <20260313083443.2391254-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU2PR04MB8840.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ae3c1d-b06e-4575-9587-08de80db38d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|1800799024|366016|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IPmOiQpDHipwRO8jiPnvaomJtPjjg0qeVJBYkkwhE3l8ieX43xbOqoceSipQMAtqB7SAzIQ84nzZZkgwNX/EdKYapUIXbp3+O/GSgwtuO3KtPNvCM/85POyc18rn40Z3gi48TFyDBqmRJfTZO9gIPdYDFmwRxfo0Iya9VWdsTNiqlDVGsDwamFuxzR9qtrqmDgccGM+GOajcj8RPinHrPJ9V4Hdy1pGxEAg3Qf/Q9DC2MVJXw2Prl+VMapA5BbJKHKrUYGF3h0ziUD14pH7l5Zc8XvX3enIFQhxULkcnHzuGh2CrI5UOoCvQbr72ZfSj9ffNnrkN0fVqwXrsf4xmNipcX2BDbSUeGN+dwtvgi+fN4GNfBMP4Ps8O2A4y6U37uzRWRCEgjNePzm4dBy71fvfC/0QrMGDpBswx3d2aDiktq81WkmgA0HYo7YA7zu7ojQTIbrJW/2cfP2lMZNWf2bZ8HIYEzvItPtetxIPJKHGCrNO3sQWE9if7TQN/PNIAOBgRuMaKXoS6mdl0m3K9k0LGBk77stEF37bMnEsCjL8IdHeRRlCejICUluJgKpeHzushhJN/jy/1GB3vdLk8ybfIdnvgY1mtvSF/kPaPDKYVjy9vF1MHFqXWYRWELoJu1hzjllX7xXfvFa7aFcawi92ll0/0m1r3EORLymh7bMuC910b5d5nXTK8mukoYzpdCuqqDFUR0fmwb+Mwrfjx53IFuwIxuvsWWzpZZ185+zKPuAORYWnMRWoX8Kp5UkhGK5YdAZHiqbSdSaH8LwBpwLIIP5E3IDsKMx8ADpGIxDg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hKnhJtRTbGKCBbJP2Z5V0MYWU6lx8AlPkZtbCKlx0y1ZTP1GOfgFExtWzCjQ?=
 =?us-ascii?Q?bMait0Ck97ON2xE8gkHvNIx7JTUfhBDUozRhB0Ntqfh+LFMECO3Z6nAKw/1U?=
 =?us-ascii?Q?BfgcxALkl2XAdkZR+rWfhfGjR5FNe2x2qEb5d/Ycst4YMLlx+3HT1NsXFVuM?=
 =?us-ascii?Q?b9B7cJWN9vp/3Oy2OYfXqv9vT+u+3xA1b/WfL7crLMADj4hv1hlBt6RkT3G8?=
 =?us-ascii?Q?Si8HGU3B0HN1zpYLwUgYiK1Bk9xBKVCeviA2UYW2LIw8xDFrsHRhiUF3teic?=
 =?us-ascii?Q?D5NH8D9NFuAlFCfvE+iuff6b3HCtkEsSs9m2mmqfwR9aUS98d473OKoPN7Kt?=
 =?us-ascii?Q?Evnob5M+ZLVSQfoRw5IaWpSljqyBG3GdoqJklEqXrT5mhtCv0FmpdxIjJvKn?=
 =?us-ascii?Q?Jy/RgxUPYI/j02373iWFqpanQ+mICkZ9VSSqSfn6qvtJ9jzdsttg9tBWUjh8?=
 =?us-ascii?Q?dVMYMs8PnsueVlDAi2IrxbmCWcabfjsXC7bReYM6xJbvfAnWPCWPuGSg//iu?=
 =?us-ascii?Q?GPOUnvT0BwhgchD760C4fzptswyJBxedejm6MsLYV2flyHTzxxdm7ux8SDQd?=
 =?us-ascii?Q?dRQXXbNusmrZjKMzXiHt1iCQMfzPzK3NcW7HL3ZmDNABw3mSouyFRbym0Wne?=
 =?us-ascii?Q?5VDc/hgA3AnYp578qx9UPsBLk3ODvHQteSuwP8+jcOQtRPOsEoFqGX/w2ikF?=
 =?us-ascii?Q?iEbZD43ooCLQ8UUWB+UBVznxP+HzKa0hdi9F9c6m75lxbwQUuGVBuMZRIgE4?=
 =?us-ascii?Q?eFlv8AnBsUfUQHDoKaSB+4ixn1Fb4YoyY1x7FpbJQvj3n3WuRXivjBjOZh5w?=
 =?us-ascii?Q?rqih/+bxEYSTXNUToQbnucjAGHsxPsRruS6N5W5BzvkJWBv8kkpCqEwLk92Y?=
 =?us-ascii?Q?SdC6ftPq0wxNtVbE5y0TcdqRmBw5n4rZgalyYM4ZF/VkG1OyFO4UKDYiLDVQ?=
 =?us-ascii?Q?fhaCeVjmYFu9zbeGBX+2F0N74T1P07FdKxGPJwQVD2yGdxhWM/T2jlgSEhIp?=
 =?us-ascii?Q?ZVRpvwK/WI7150bbEIzRUJ3BHCr7kuFrbqw01xAmblNHmxXnCUMvjFiScOjB?=
 =?us-ascii?Q?TZ62D+qNAWOEMFSAWIG1eU3AMwfH00c8B0cxv5PuJSqpv2Z2M4HriMcFKzUn?=
 =?us-ascii?Q?bL7lseYtY9KheRuRJwIV5wCUmSufu44397MxHGyPwVHxHKYwbm9Kx3hdOkBP?=
 =?us-ascii?Q?0aXFq1of9yM9RaIAfrK2gfapPKZCFJPQ6kozeEDetJmGEOZxMuCTXRUOjIi8?=
 =?us-ascii?Q?dP8f2NKtZckhhWlVD29Aid6czphJ/HFh/uz5odCDcjTHXQ8JuVGml/HAJuie?=
 =?us-ascii?Q?6v38e17YTtNwP0D7//ttEfH1tlHGhpD9VfKZpptMVuKUFedAfED6RPmRT3Ss?=
 =?us-ascii?Q?+bz5Y6AonNXw0hBor/Bbr3DuwmJt7QSWdagbdo+bh3taqmKBXMMTSTyGDjiM?=
 =?us-ascii?Q?ssYcwa15BdQbcb+pZdyBfwYvqOmvRdQDWvDFR92HJuNcgICCJqx41vstrqGA?=
 =?us-ascii?Q?VOSfQOmM5kYN9zafS018xCmFH4uLPQvcqWdmVeLjBJEGN8uA7cdwmJlTTNHe?=
 =?us-ascii?Q?R46ylYcDI4YWbTFdU9ca2SzrdWL7Z2zwPRClzchNWM5oEvOXTn8iUCnQSKor?=
 =?us-ascii?Q?ClX2wUx39q5MW59D7JNGzs98Ol7dAne6LRna6CEV96QKSTvUGCe3kfnwvWxL?=
 =?us-ascii?Q?XFIGVnPWOiNwTO8+T6n+YmeHqonbTK4BT+qbcf+TKDivz2BRfsm4zyItlv7u?=
 =?us-ascii?Q?JYaJgvofmA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ae3c1d-b06e-4575-9587-08de80db38d2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:33:37.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //w8Dji0CPAELIJyNG9JChS5KBa5NUGsTHQPEx4MijoOnG3pZWBTuesNqbcN27uxtoYwa9SHWYbBJI+kuOgRBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

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

