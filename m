Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69593DFC6F;
	Thu,  2 Apr 2026 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123494; cv=fail; b=fcr3grbnp/HSH1WXm+HJrzI0PRmp8B7w2xuwDrXQUYTjD9fENqYeKmOcNlvxTGOLTb7xwXgNddBReT/AxpYqOnoHcsJXgwmArlRLQhT0HvrOnoSsT20uFDtITSsLnnq99yh7ywQb0tLkh/ivg9AaavmL+RpA97qC7KE0URhUhYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123494; c=relaxed/simple;
	bh=qenzXLklhHlqYAtsHgiZ91iUxT0DbrT62hGAnMX5908=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GofIvC6aa16NMGIuAIuiGZ7iSKG9UxDlqdqAJQlhKSoAT3Dwgg33ewreuGfdVxpIeYoU9wWW85CVOyRHRoRbu03K9cafbcQRbPNKVxNeL3DQ1y+N8sE6XURlm5GTLUHnEb0Sij6pzIZVE1oAE/Xez1Kp56bQafZ1v/w1M6p7QnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c3wSJE8s; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c3wSJE8s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INppBGUgsMIemtGzt7WVBN6pZFcEcVn44FN6iUDSNlqDqiDmvA2Dx0lvCg9asiyHXmsGm2Kxivjcme5fnDMwanZBG7YJpmA3DfKsK1oGUzqmbcjUOTw0K4sVhDfZfZk46hxUwwI7cRp8uoLWfl9Id8/PKr2ta1PEfDCANfwEk1kJA4XvasIIpAOSw8fxN498rUj+ZAf3nPb4E8juluhc68yjdPn0GAB44FVQnsQEFR70A65JJeMdNMvTAB/vCNsvTFDxc0xEWLOq/PssehuPSICmgTPopK/h4DSQpC1OBFhxcdaC+PUIa4qFxcdJ7KngcLnJfrwHMc0mnomMFdt8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJcLjZ34i2X/erIyjKhzluwnQx5p8ZpyC/lM7caq4UU=;
 b=WDbExt/isKekHiDlnrhu+y7KD0I6pZxbBYE6aZ/mFLWYl2qu8dGrNTspArRvH6E9hlPxHv8RrmHwWmnAgwA3Vhqe7NeN7Tkbk0rVqUVZV5Lw0X5TGtucIEgpq6qGShFEnfkloZ/zGdp5tCZj1Vko32cTp9nCO/QUHkXM7Qym8wkoZH9AcS1r+hKxk8J0t2q5zhQ6X8htM8YkIKGCs/yR+mU/dVRx74RRrbVm1BknEbr/SA3mmq5sbUcLMSle+Kfs0EkhgPwE1YyOUsnt+QhAAM1uJotHVwpvFBZs7CEfVMPMprugrGjPttrdZBWF02U+qGr7lCSR2V1EHTm4d82R+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJcLjZ34i2X/erIyjKhzluwnQx5p8ZpyC/lM7caq4UU=;
 b=c3wSJE8syZ0Z62/ld/ndAI0bW3rI2yK1I3I//xypTsJzucbjhwQx13RMzwOj2EOYKM2NyQNJZMV+bA7tTAi70h5Ih5x4gP/tClhpRikRBOZd9F23Gia/amCkivjDH3E4n6/8oFWZIXIGGamuC7MgiQA7glKlcTpMgUyWInpV/35GYYBHT9gzJPWRwn5JWLPFVlTiaZmnl1+uWGo8IqiqHFxFlUkDj7A83sM49vkBloPQifGCX1S+V5vWHzBknDtApaWWOZ8zj/V3win2wUHBi59GdLX0LtUDpGfRpd3HHKsNCRYXncIKNn6+nVGgKI2G5li2zWZm81Y8/YG4fX7XYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB9865.eurprd04.prod.outlook.com
 (2603:10a6:10:4f0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 09:51:23 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 09:51:23 +0000
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
Subject: [PATCH V10 13/13] arm64: dts: imx95: Add Root Port node and PERST property
Date: Thu,  2 Apr 2026 17:51:07 +0800
Message-Id: <20260402095107.205439-14-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402095107.205439-1-sherry.sun@nxp.com>
References: <20260402095107.205439-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0163.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::11) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB9PR04MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: be29e29d-8bd4-4f9c-99cc-08de909d6600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|366016|1800799024|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ECnI5t1GI5DnvU/EHpMkeZzjnwiOm3F+E42HWN+brisT8q7FVgE5KRpwXwicIyb3VrQDmuFQPf85k5bnIFwr83a+cAv00vTwLrRx+U+bSFxevQA8XnG0lkA2GtNGdgEwR2yhSe8ihXKKIUFO5c6PCeea6T1GAh/tz50b/eflIrqRF4mL2a7ZNtcs3LZmGSktzfdwx8ovTxEFt0z7KWtwdqjR621Hy58oCaLRAtI/lqqk8DZR05rf/zQrhJvSdiu98uwHVrd87hdDQOttDI6X20CbpoSKMdRgaXAFxmLqyWGKtlfzSCOveGUheZ9iBlRnow+dM5YX9N46T2EmoQmXtwAwDDglKwTwDKH6kP+3gL6LxaBg1C6tiPybmstS4AMnDV4469jPJPBtr3ZJIpnfU4A7jmV94VSs9x5igl1goDXfN7EckIUakcyMqtGCvldWLPykBnS5G7K9TmOUq+KqKeol4IRmZocAs5oyvZ1lxZ0tyly9dloUrFeL9pp1w7aO1kX3uhUA1x1oPs2Ug2u2IguYkVvSQHwjdFnYn2QDdjZGlcoENlX2d1fLiBf/WebijGXasxEIoGSF0RDRhPS+78fUaLurwIjEaDdXlVBKJBQu3vK+sUDf0XkF3Jlqn/GpER6ff25Qs9dQ4hEZ8qhjvT9TG2oE07BeUTIesvI2FqkSt8gc+V0mphBjHaBQqg7n2svg6FTMTkw3lUSCndinv+9Uehd1zX7H8vHUEyYIOdvg0A63S4ObmacHqNWGSm6mAckU/yeWA7upHPe6K5YUNA399Crpstr9IA+xg14Te0Iej7B1AxOc/BokKuHLGSAD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OY/0sowuNmK6fC7uWxY2ElU/6xToXogSZJ551M11nhxsar5bvpQZAB5RbLtf?=
 =?us-ascii?Q?PmedVN7lzd3FsetolwdicsVxEsOb3oFU34J4+/mu/nWAH0Kd2BhajUzWv7Sr?=
 =?us-ascii?Q?gPCsVf+KxbwN359Txq3JuwQtDoqXNQqLOktam/rEpVJzHepD5uKnITpUkt2S?=
 =?us-ascii?Q?ihRu+ze4Kl020HJaEsiIfNCGqUJWMHEkuPTZajENTAQKHcaIFGkYWm7HNsEy?=
 =?us-ascii?Q?ajAg7CK0HVno2zEiaG8rwOhkIFPX/Dd0LNnqBmyKpR7e3wpOxrP3wpl+P9RA?=
 =?us-ascii?Q?44ro+mKFHCsHgRKT927Dq0+MgbIEmXyMuM//xekUHU8IQ+eWvKzfTxQnPZn7?=
 =?us-ascii?Q?Cleh5hlsCmMThoQ0gVTr0XyXV0ZvUUfXdCmCoPCLeXxNa2C0nKJeo21BdyfE?=
 =?us-ascii?Q?KrrfPacNmCePFXABsTiCrqODZb2ui7nUFDtd1PF44WBhVpfiuaR0sIwwRKRK?=
 =?us-ascii?Q?PDpLoN1oUKvXFIkB23h6qS0f/pFjC0IMuV60V3dx0SkTSoRX78UqOo/i8Rj1?=
 =?us-ascii?Q?hHnQfzEXw1hOK/lk6T4UEjD9lUpCEsSOadylWR54+g6TO1KImHq4iWa96MNH?=
 =?us-ascii?Q?pNfUgD268fu2Yzzcw86Nu1gCadhzJ08XL8+UeXNv9NuTZer1VolLGWz344s7?=
 =?us-ascii?Q?JrNP5sScpFVCywmouZZuRpqxIOxBjcTSe32nheju+k5qaYAHRegXC+V8eBTU?=
 =?us-ascii?Q?VhgC4f2GTr2H2Vw2UxCbkWVBC7ADJ1ap4qBQgLBGstj3ExsyKyK16aQr+9NR?=
 =?us-ascii?Q?wNl5HAzUAE/nRkQK1e0ox4cQtnvQG262JKaqNTDbskk8o4bo9XqaIzx1BSZA?=
 =?us-ascii?Q?/3iVRXYj0xCnC7vyzqGbvDw8BDr8Oa0TN2ODX1K213DoaTklVXIbE3LL/i4B?=
 =?us-ascii?Q?dqnJmnHby21nZkERiwA76UkyxI7WLTn8BEmQ8Ika3jbKOGye6J4BGGd6JkwL?=
 =?us-ascii?Q?RNDw7fyGdoo+lEBLwf9Mr8brj+j+7Bl0aYB30/zJvFhCw01y+j6vztbR+JFJ?=
 =?us-ascii?Q?zPtquw0CZQvHJ46ZcEbt23Qy6Qrk5yLARQct5ygqFsvdipW6wHtAt2/ZJjOG?=
 =?us-ascii?Q?iwPEn7tFMaA/WDcy76MChcqFhK+nJFp28mgtu/Ud39GjSrTfyoBeXqVH/QFw?=
 =?us-ascii?Q?sqYa1Wl18BhkjpTY4V8D0wXtBXPZ3840UUhM39++wkpoSbktcgBzO/QVKRMd?=
 =?us-ascii?Q?EafsDHfM0r7oNPLxw2yrb2e9viinIqZNV4NPG6PNDuj3IQXepr2y5lERmIUc?=
 =?us-ascii?Q?z9++KBgb1R3ejEHjCllwPmNE/IwQXsha1c/XFJjMDHvcqWI6enrHsiVo97zG?=
 =?us-ascii?Q?cAfNncrEymjMnKgRLIvHZXcshPSWF+a/OO82YLY1E78KPwdg9zYK5hbnkT+P?=
 =?us-ascii?Q?Xu2e+tG/jvHVKyxRSvFVceR/CGJ/ReReWDQi3TRbA1dGnypO48tS2IGVqM9V?=
 =?us-ascii?Q?6CkgwRGeDIb1mEOLD3R+QhCYriCfbWoX35zucDyLZIbH9Eg6C5IEPSWaATBm?=
 =?us-ascii?Q?sK5p4nwne7k/yxsj1lGMGQaNNtC9HYzt+RB7IFBL1f8uzlkmcxj70LsquoO8?=
 =?us-ascii?Q?RVoZU4j6GG8DD5RkrHlSubAP+ChLo8w+2K0zSvOr3tYOCcoSAwHvta2oza2u?=
 =?us-ascii?Q?I9ZM4kss6neH2yGJezehSGBxPJ67h/TXxkgDTTDGnGwh/4KjeaNQlZHxwesr?=
 =?us-ascii?Q?BHsUqwcb+1UUuCuohPeIjB24qpyuU0iajVMr+R8hQ6Nn/dh2VNR2PQj00xL0?=
 =?us-ascii?Q?3XKxapJAtQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be29e29d-8bd4-4f9c-99cc-08de909d6600
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:51:23.0475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ra5see9isoS7juRXxiucCnBxENZh/9Fu9fEPnZj0oa1M/2xRDR0q86W5hvuMC0fy3g2KOaFKvfUQQPgdAFG6Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865

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
index e4649d7f9122..7d820a0f80b2 100644
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
index 71394871d8dd..0cc6644f98bb 100644
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

