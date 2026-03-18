Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013000.outbound.protection.outlook.com [52.101.83.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC3366576;
	Wed, 18 Mar 2026 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815382; cv=fail; b=FfEGuX/YWms6W/+Ma7GYcp4Dt5KA41eET8u+B7hyGos6Oeq0rw4DsIWJ0SxUbaT2Ft9mPqPe5H39ZQ6AtTaFgK+sj93LF7VobEviIs3mMG7iQX9uB26nNE6dn0R0DQbk/EqBM5HUGcM82/oCBY2NOY0t0EJPJoxyOlgy+Rdet9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815382; c=relaxed/simple;
	bh=4XVQPFVezRwaMGxR4zYguO5QEG314znWL4bv1JyYFpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQyMB5l8ShDfP4i7M9COTeCnTjRoR+FrDmYKhsGCjxwCQxgoL6J4yir0AVsuejXn/cKMHtfB2V+NGxspCVb50f4MtB5kLyNADRrjRlYriF+j5hQ1rr8KjkckM6NTEeEkvPQKioc6M1Qey7teK2BHa3/U/4omCeNl5Fy/QMgYWuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DMCV7M3T; arc=fail smtp.client-ip=52.101.83.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DMCV7M3T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOOVTu+rzdc/+e/jNb1pnnm1UycM/ZBR4UjMf5Q5i/TqhV4tb3EBe0tui1CCHcMM6uuL7eneJyIOQAWXu3IHUYQqt6WoVqbaPyrwPkwQTNpM58LAdP7l7l+OBpS4ptcxYwcG6Zf6y/qA44Lercm6j79KY4SVzfWwIfqw2zURQrVuSikug1yviwJ7VGzN7mZ7zS4c0R02iogI+tU1g0+QcqxOtQsBZxy3JE8LAKVkU4VMd/oYmGaRse1w554jRsf+w1HjIhKyk2AxAuETDgBxUVSYzrnNBLV4NPGARVA7z21leb8ErfPnvRJBeLsr4FF27vbLYpPYn54Qjr7Lm6Ajsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4iyLqlRgiKMzIL8PVH23ogot3Rl48bpomnFAqYbI7I=;
 b=rzN8kO+IvHEDPtOPQCy1YaUaGAjDv5pwMfW3+sOH6JE7QHmVOAI73+5gFf2IYYIqV9/TDRP+lSApi/xHmHIldpbeMQMeax3DsTHHMhc7h34/viDUtQcXFk+RYl8wi8sxgUGIhMJiRHzMc3hr5TFkZdxoD9/msuuNkdYdYI/Lz5ztf99RJaFf12io79Oayb4f9s56Kx0NIoDuLaQL+Q5hyHEvtN5TxbzykNdpR8XIp6MPFKKqC62nDmtJmxTHmjwuViayv5AmA5iMVz/2vH7o9er1/dGL2L5tRPVrpKlLb3EMS8GY1vBW9/FDCTBx5yAC7sp3E+3CWOU7SALUrbODlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4iyLqlRgiKMzIL8PVH23ogot3Rl48bpomnFAqYbI7I=;
 b=DMCV7M3ThgBlhwFZmZl6GBayPbCPNRsZmbJVYX5W6YtjBf/z2idLCfeCjBhKY2bvO5V0QKDoLHdQJJVNdksB1jgcvUzh94AklPduFSWeR6qP65l4A1lAII8UEL4NSZTuEzBwADxR3WkQjfNCdFAwwOUnAeGhKdgr3j45IuD87frZy8jZxi4E7vHLghvf4JNjRNdTzowNdiePQQGA5vIVlpfs4icGS3Fax79LU62uMAg2hFoPnIoHf4UdYR8xWwP8rLbVUZRiQ0Pxb5/zjXdjWzEzG/PJhzig2I+PhNhMBNqyiBRSYBsXN8nuR+SyhwW6fUTmjcvYhKgyXwtkUQDRdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10706.eurprd04.prod.outlook.com
 (2603:10a6:150:219::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:29:35 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:29:36 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 13/13] arm64: dts: imx95: Add Root Port node and PERST property
Date: Wed, 18 Mar 2026 14:29:16 +0800
Message-Id: <20260318062916.2747472-14-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260318062916.2747472-1-sherry.sun@nxp.com>
References: <20260318062916.2747472-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GVXPR04MB10706:EE_
X-MS-Office365-Filtering-Correlation-Id: a81bec84-85fc-48f0-bcf0-08de84b7b99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|1800799024|7416014|376014|921020|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	462w/5f7hn7j0t+34V8mbLU7qskoXpaZ+NOv1ZjhZRsOMHfJz+O4QISL9dy6Tj3vKKWtmoAPmVh7/0FSU80YHgp6vUEVzyukGjP48FsAcFrHtkMIa/p2lRAL/60XJtb3x6MMIyeYlL4oOa9HGtAo/s3iedf/dEg9Kt+z4QyNwo8cDP1yiejVmUq4ZgzklJAvVU+MMedj/gVFbiZK1TPU4MHrYtaA2n0SN1yP10SiRtcASWJQSSO67L5OacH4NdhbcgjWE6xw80g+utys6Rs+XArii+oB/gmd9NMPn1C431hEP7jUMuSvcpZXyCnSeG7oVQqMicuYg3NtZ7DIz4UiZS/m2l7u49UJKyB9Lm+EP0RYcbGepHFY5miQW+CFEF8MxV7jZcVukV6LMoykh2CjOsDkCfmpRwSuSX1A8346LRRH+135oNPzeTKSuKWVy6Kugeaq/XyezLNdRjUWRO9pLyg0XE5F0hnl9hFN6P6JcnoEktN8ACJk435i7IkMRwk5+xSvC87sAJKQHsLn3l9gVNdTMfmzfuUBaDH9OIn+M3e3rmld28tvGas10QnXpKSvS4jI7EE42lSLAA1AniM5rbIJQM5gOdLaIDY5RmVEK4RmZ9zsxaOLGl2FBr3WPwh4A6Ancy2UbeqVpfV5epQRg4b/fXJfFbiepJ2BTkH0hSU4evS+lRX9FCmVKBpubHkJiyAgGzPeYlZTvK1ulBq/rg4dRZSGfzn3x9W1gcmChRCq7kb0PmNKnfNeqaOVsaN4CHthd7Y8WX0PPV8aXAZ4Xe0wNAFhmLRX59mfvnihruX2ol4qOMCKhGfLKaTZLxvL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(1800799024)(7416014)(376014)(921020)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3+Ndwm/mN6PJiNQWqZTFaJzB2mVy6nkphMHoew3qR15ptF4yHCDfs5j9mNp4?=
 =?us-ascii?Q?vryW/UqD/u0tsXbakVFXFn2DwY8tHWkoG0QncD2ucop/O3hPdWcC87tMhsE+?=
 =?us-ascii?Q?1ZjMy4JwXSTuL5p/g9ZoE68a5VLkIWWFU05ut6+w7Uwtjb6NpxgE/GKgU8d3?=
 =?us-ascii?Q?C9zEq7Dx5Evcr1Z1xiFuOUab9ehKyI9dH9mA1OqA1/iK8n/PJGROC26I2D86?=
 =?us-ascii?Q?X+jPMQvQnk0dWJ7kvwphfp8AdU4oawuKWJ65yTWnbsMvUrp8RYoTEwuPhw6B?=
 =?us-ascii?Q?JHxu4sw62uB8MEIljPeLbw45oPRudvgQVJqIl7sm74RNFNJEf7+rxv2VS9p5?=
 =?us-ascii?Q?0FTR/7S0PS6ETfr7TT3t9LlNm7Xxv8P6OPysbPE3kpH69pXYK67t6NU1qEd1?=
 =?us-ascii?Q?5BfTUR2rIvwSewuSyGOxCFTQdlGpnffQjG1GSjAWUOUlnVkRoClHbiW1QXPh?=
 =?us-ascii?Q?iSU/IzO51e0PerKg0ZLCbxgVp/RRoZPA73I/yGc9DUnL7i0Ju6vvz3skShSo?=
 =?us-ascii?Q?nX3hF9YxyCrdw/RJz5Ekvp+4ITQ6884WkI7DZgp+hSz3pgD9mwvJnHeGPEEm?=
 =?us-ascii?Q?ggADMSkdB9pAWUs5DTBxLcaJRy6i2Or3qgvnJvxAjHymL+71cXkmXe4hCsWZ?=
 =?us-ascii?Q?iCRqh07A/AqNR5Rdb49hIC6029deYrM1cKYooM22aH0uCAlGnO6ZO/doGyqz?=
 =?us-ascii?Q?Wnk6h0nfjbkjAC/aULDelmdsRuiV3cxgZPIHDCWE786Q+YBWEbTtPMC0F7IE?=
 =?us-ascii?Q?MRIT3Xhq6iFyKZiQKlvATTd1OdPws6ditVofjxG3pmuww8CCzOFvanrkd1JL?=
 =?us-ascii?Q?yo7YAdonsqfpguNn+g8P3ZXUt0UwKZYIcBXfCrbeW9PNDdi2VB5VogufC9qD?=
 =?us-ascii?Q?36zTiIbna79QqBpbwwoKm4iaTZWBAI6lYVnS70XsONV5GuuM1lyTYWu1BArS?=
 =?us-ascii?Q?KCpdpVLleePI0wrdh6lRJgAFPvPq1UpAQ3DH3tghOHsZfugSo6NrDXJfbITg?=
 =?us-ascii?Q?knbF4fxeltbehlq6iT8mwaHjtTLVRpX0h2nwRHFCArhf/+KcSIkKscYrZ3Nu?=
 =?us-ascii?Q?6kmYEu584yUZACzkkhWA1QVxNZWpQzusWPglcSkaIM4pAQJ7AQYeAq75ZVGk?=
 =?us-ascii?Q?iTyp+uwuuj31ObJIPFDLUYWUs1wo3ta5d3YkP00m6sjdA+SKkbNOVxySjizt?=
 =?us-ascii?Q?DHZaL8OdPTndRh8Rs4D7gkIVO3/MLAgIjiweiGj3ZFSNLdt3aOx6+9WTCmt/?=
 =?us-ascii?Q?HdFhL/DebHW8V2erQ5elMqoDhxwlY4AlTgAKDD4DO/d8Q2JdzrSbNmjDkQdp?=
 =?us-ascii?Q?W7Uxz4hZpGkISXMeDqpG5uCxmFSMs1EHiH1/0G8iJDXupv0R9dLgIU72ZLuZ?=
 =?us-ascii?Q?NJK3seIdTOXiLFTKtp3duKY39lmSu6UXQo2FkslrDqUC6MfgmG3XHuahRa13?=
 =?us-ascii?Q?CldpsSxNqG4W9BZWxevMyYAVbt0s2YXXjhnAc6LHpMByPm8bKdF0sK9CRtUn?=
 =?us-ascii?Q?gK85vTAeqFuNaX9w4jqJ2uTWGvzWI3Mny6VFjp8gs+9i8VCf0nBZ3rmoLosq?=
 =?us-ascii?Q?K+UWz2nBVd/U0l8ybilJiE3SeR+6RH3tszz6IWntqjaSMXtHXApAieFe+nCp?=
 =?us-ascii?Q?FfPCbW0I3KrvPHLWvhnXuGsz6OAmO7jdu1SI5g0TUWDr7bG5+XFIIGWVPaoX?=
 =?us-ascii?Q?0Y62m/4ErAAXgiNw+D1midxzBi/IIhjIfGV6CTSoDFlhaLimKLKpCE2VulfY?=
 =?us-ascii?Q?YJeI1g7YCA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81bec84-85fc-48f0-bcf0-08de84b7b99d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:29:36.2549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTov6/ubk/vuEoSOp6M89Q27mALWAFBdvuFafct0kQNSQvZ5BrKMm4r6gG60T6oZ6p4pql0nYOPxiiTt+84X9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10706

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx95-15x15-evk.dts    |  5 +++++
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 22 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index afd89ce3cc5b..7ff758e25de8 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -553,6 +553,7 @@ &netcmix_blk_ctrl {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_m2_pwr>;
 	vpcie3v3aux-supply = <&reg_m2_pwr>;
@@ -567,6 +568,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
 			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 041fd838fabb..6f193cf04119 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -540,6 +540,7 @@ &netc_timer {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -554,9 +555,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-0 = <&pinctrl_pcie1>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_slot_pwr>;
 	vpcie3v3aux-supply = <&reg_slot_pwr>;
@@ -570,6 +576,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 5f61866e9df9..752236afce11 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1890,6 +1890,17 @@ pcie0: pcie@4c300000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
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
 
 		pcie0_ep: pcie-ep@4c300000 {
@@ -1967,6 +1978,17 @@ pcie1: pcie@4c380000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
 			status = "disabled";
+
+			pcie1_port0: pcie@0 {
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
 
 		pcie1_ep: pcie-ep@4c380000 {
-- 
2.37.1

