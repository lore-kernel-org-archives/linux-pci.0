Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90D5733E;
	Fri, 10 Apr 2026 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788227; cv=fail; b=ps5SCGOqllTirGeHKNgfya3kL3mAAERLvAT2LzSRRArflxkKvb96LjcExGVa6NpUWgOvOVYS6qBIkCLAg4L3puupANuWtj9C72CcWi2/S2tIylaEeAr2tAZT4xCPGPioaczlsjeGLqB1Ik2ryxFSZIvgz0OHossy2ty0u+ByapQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788227; c=relaxed/simple;
	bh=p3VWd4Zk987X87jiTogJXJ5Nf/4FV/Sb9DSkzZu+rrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XVDbtsm7I1nocchR5R4/Pt3rAUNi9jLGMAfXpQK7qZsKb+4lMPXPTNUW+DqqW5FfILSCFmOXeHCB3x2yHmPvfV9gWpRC6i3kznawuQbiO3eodS3RSP30QnA7S8o6/qsq7Xj/D3V+hg6+gyFKZe2ARvHnkoB4w/AiZ/2C6nFKq+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VKXklpgx; arc=fail smtp.client-ip=40.107.159.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VKXklpgx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kwq8N1GCOWkFzq4OhF66INeoEcZpUNMN3VKZ4ngK1RizHfe37AQHjIrv0JD4hfZMAEavmAobLcgqUwIpyLARwL7I29NZPaBfBLAJLlu6WGWD18FrIhru0GrqkkTrnIAUnYs0UQIWjOkQX3h+TF35j+5LeTjrb3xqClQcGA3wSzKOfU0GHXeCLsHaZxOqNiK+EUgRxBHi/AC7VE5qJ6LKttthXCUrs5OMvkLksRCLMut1CF0eEhVACsNVd+TwPlsTIgn+WSzPmdUh4+GBotz7fwEcC01Dvu3/VCnx2beFyMtE7ARwoBAKES2kinL8UVw5HxeyD9buxFDjNARDfMnYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnLsoxBtlKwwKIXSSpdqg/p60UkV42ewo5fGCfmOMXE=;
 b=sjOFEI6GgGmkMVs7J0guViNA7phGTwi1kbAhoo/2DzuiSG5sx2hTAIG98Jx+PksYYywo8SbM6BraoaNJLfM0DmqkK48OOGQwzYsGEUB/Ry7yplLdWrmwsQgQsFqDgkCrs3sy3Q7W34LWqdkc6gu/JUXJZhhXTtL/PWZGQhflput4DRB8BXoCf8by985l8O7CVcaxEaob3OMmpvE2/O1/CgjyHb/Cy//E3hjCqPNPkRU92L++ROH/yVfws2sHVFH1Au8urMzCVLU/kvGel4lANnjwP0e7Sc7gyBzD2z5Cvl4zGI6A3EwiFe1Kp5qJcRG11Ns0RgKPc/6pZeO5kUV9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnLsoxBtlKwwKIXSSpdqg/p60UkV42ewo5fGCfmOMXE=;
 b=VKXklpgx6dtrKuOGwQ65GFQRCw1TKDJkpASkjKLMaF9550VrR/ql9Vx4PjWSf+DgKD2RMGNUGnWFzrLZtLkktriiJxgBRtebajO8e5nuNcKzIakZt1P5cAsPk9k/E5CERA5FbMHgmnOe+qeeEtbaoGhgotrwameK6cRfTwnbh9HkLamcpe5RzRU6XX+quNBzieLqyqxnR5g1uIjH0h39EAhQ7933PjnDOS2rBaQnoz1ulk5cop6o/+2W/i9bnB68qWNAIpm6huudtUxN4i3ngHVXL4BKXpBeWEeP4JG2f0NEaPoWtmH8Mec1RIFMOWkWo9HZX5gWSsze54Z2vIlppw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB9826.eurprd04.prod.outlook.com
 (2603:10a6:20b:673::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 02:30:23 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 02:30:23 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V12 08/12] arm64: dts: imx8mm: Add Root Port node and PERST property
Date: Fri, 10 Apr 2026 10:30:51 +0800
Message-Id: <20260410023055.2439146-9-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260410023055.2439146-1-sherry.sun@nxp.com>
References: <20260410023055.2439146-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa23f52-89b2-4c53-0bb3-08de96a91e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3wEHqhJ21xkGCz/eW3tns+Q99lwqlO1jJs5YTvE9IeT413N1CgA8S8BLRP7KJj5Cqclwzig0B2zJJkgbtLEECu4U3bgx/hrzQjCSEWDd6M2ID1ZZuSMT3ccNezE+vV4DaXOHRbbUiBTNRPHg/sKOtXn0cBxar6Z5ou2CNPCu5OrNPAi8j+OAYQ1Jsg/W/ZNkzkJdcFTI3nFBoitUpCCeR71JcTTVtrqme/yX14C2GKuutHJse8WCZUV39yh+DyGuvvpmMOKxFbS6DIX9Ji9qWGoxgaOPnpXfKbPZhX3GCZMtWz948Dlz4BQLTfoIlyZKWRht70ehmYi/oQIDP5hF53HjLEF7W7MASkCnmReGNoJKJEa0W6Wrn8c02L9RUGiNmWJhZDNMvlodKeobDicI9mwu9eZGd+Uw0HqtbJxLpvMdHQJO0THgVsQL/rr84JoEf6yZBiRJAdtUN1olXbYpOB0uaOInUwMICTEXYyGGnb1RJofAsdTSvQVBcF10pFcq1a4USIfZygt2a1fDeXl7FCM8U0AoncyoYtmpK0ti0w/hIzfDmBbFv9A4v0kEJHphvD9YmLWan4FL+P4D2pal9qOwLl2nhGawBhG6267YSI/pGTWy+3If/7Bqxew8+YvYv2uFkarVVlpBMT+gxBAaUXJ4QiRWOEQeFLlVNYXMmHinR7iDfACQR/UtqfBbHpaX//dFCXDS1K4dxUHnMOd2LMxt1h9HPQbiV6n36SRiVkzA4EBwm3octTgFWZTtx+TGrEZca/q8jDCJOOYTUJrR+qKT16LZq0SZRmEP/+4qE1xZ2nzxYtZkgoneb5/PTUAx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qoUIgRmzZGuZGqVjaFpsY2Kuda758ldEW4PPBMpOuWE9n4CK3LcXkGg8JRlM?=
 =?us-ascii?Q?+FdEq3i4xm5FrZyHUhmaBflzFJGMWMY210L0Z3G5/+oXevBU5/BXAn6se6CE?=
 =?us-ascii?Q?T7K8QN3A353HxZUPP9i6Hp3R1TVSXmX6APFXZub9XDtcZEcJXtbMJfCnr9Ju?=
 =?us-ascii?Q?yLiEMpKfwJArdMMpFCwnE0aQQeAnSQRwpfrf9aD38VFIF45o674WwvGkAk4R?=
 =?us-ascii?Q?C64OWZjL85+kQhmtIxmR2rcw0N4tftje5GVsP4YV9dq+xcSCUjkRUnaqa8Jc?=
 =?us-ascii?Q?Y7IrLaN/6YgSgEqrb4JPaSZsWxJDiGyMx558jZTfzze5bnPTozAb/IwUaXOH?=
 =?us-ascii?Q?1V+FbbSokNnNgtGf2UP0XabbMFEFbNF34Y2xIebvqHCVLw4+lR4yWRKVSGhX?=
 =?us-ascii?Q?/T6jKyK7lmheQDE1NQGt7nzeViW1I9oJbA3mWpPIUKOSx+7iQ/0+vZsMq2cl?=
 =?us-ascii?Q?xWaH1yGi5m6c8CxsiuE81UKXwmiGKHkKxhVdz3ebAg0kXnqVzVhoxn1v82xI?=
 =?us-ascii?Q?QBVGb8ZwoLAITR8Z55pz0bYGKBijgNRgLyB29ucMr205Glqh1A91RJhIqWOT?=
 =?us-ascii?Q?5algsdv+qcVxNTFjqBbQVcOiTX3cV3iD2hhQcGLsH3NRE8bt+c29DSxW+c6d?=
 =?us-ascii?Q?rYDVprOBsHwgyAMqOL5s7qNKJDiXuwheTk3VQ0T/9JXA2RnSW4pOGRP7ob0/?=
 =?us-ascii?Q?BB3NogjBVjUdjlPoO6x+gcocruzkiNEJ5MxAzvc7fEXlE1dFxbrit0GUEFb9?=
 =?us-ascii?Q?2BjgnvOPyNJcJEkaW26nBxKYsR14DLR2ex6h8e8fA0ercnRijtu8T3FVE7AT?=
 =?us-ascii?Q?tFi3rfvKzqL0CTdDpA74JAgeVJNfjZ0Pa9PV21I3d4mVQRqPikpLOJgoq8An?=
 =?us-ascii?Q?W6NW5BxRZBhov1MLsqVZb+2s6ryUMuqRGqLwA8q9RPOekMCe9/ECf7diBFwM?=
 =?us-ascii?Q?xDITUc3AQQlMuiMTub7/F43Vmp6bVRO8nGxaAtfYCZEGJStHY/56l3ds02XY?=
 =?us-ascii?Q?t0JmgbC9GctHCikuxAzFQ1FCH38Xf5uuSR6VaMD9PgPFx96KRKQn6T6hn59G?=
 =?us-ascii?Q?5pG7lgONNfYGvsJb4dcW8C5iPC1zXzsiEkusaRPBXQ1Ct2Hq0rCuU75REE+y?=
 =?us-ascii?Q?PKwHW5g6CPYXOABAHiIHVTG+YRwqeDrCTP1ekAgekAo+LDXOm0F/clf24rc7?=
 =?us-ascii?Q?17G50am4LXpNEDN+sUtcBndCg8jbC3cZg0KdLC2m/de6Neus8YCu6gUzUdzE?=
 =?us-ascii?Q?NuNfrIosTjdFAfcLb81Nx3CRlq6AUQxFCftUam6WbPwZAaHaWOm0rdupuCvL?=
 =?us-ascii?Q?fgxLUzOGPOlp0sFxR7zpEpSeDbG/h0TNGWSCxx+rKA2+jTCM/cDTWxn3rz88?=
 =?us-ascii?Q?Ppj/1HQsmqQ89FA03oas1p7BBl9Q9POeJ53aG8Zw2nxnWMrCa5/b6oQdBeF3?=
 =?us-ascii?Q?cRU/rLmJaYW6FK3trDbz5x0P45A7+xuAMsra/ZtKTk285E0y3MkRZ59xOK9i?=
 =?us-ascii?Q?hBIvXxPMsXt1I6wI7jqaH0yThoGaxSLb5pZsihrsJhNjT1rO4O0A4zSJTBkY?=
 =?us-ascii?Q?2sE6DbyHOXjWexzTzZTGugttmG0H6c/UScYCHJcJAwemIJqQPzS7h7Q8mTnr?=
 =?us-ascii?Q?AhEaT3e7kkcsTP47IJZvUJC8T6rng5QR+rgmTmoixOCH+t++HcJLSSktBLbK?=
 =?us-ascii?Q?7h6blrYKKtj8JMMlM2iCmrFgNAil5MXX5B+Lyr6H3X8igUxk5ClgofOliAgd?=
 =?us-ascii?Q?sQs/lgk5ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa23f52-89b2-4c53-0bb3-08de96a91e21
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 02:30:23.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjOX26X+fNZjt+gQjbJSu2FlU0J/cz+3eqx+RtKggKZu1/pqStUNLXkBOpmqHIW0Fjk/eXVuxW4mfeyq360hjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 8be44eaf4e1e..e03aba825c18 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -533,6 +533,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&pcie0_refclk>,
 		 <&clk IMX8MM_CLK_PCIE1_AUX>;
@@ -559,6 +560,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+};
+
 &sai2 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 4cc5ad01d0e2..5cf2998d396d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1370,6 +1370,17 @@ pcie0: pcie@33800000 {
 			phys = <&pcie_phy>;
 			phy-names = "pcie-phy";
 			status = "disabled";
+
+			pcie0_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie0_ep: pcie-ep@33800000 {
-- 
2.37.1

