Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20D3054C7;
	Tue, 10 Mar 2026 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107667; cv=fail; b=cxwBq/tcRpTZ7ATils7A7qxVmeO39fNrWNvB7S8Bp+/lSDKFN2PNZGS/cS1AtaahdJUEUQAdHgJJzAdPG2KZX2VX63aBt/+E6Ew0FyRDHYFLKNqfYL1Hg8Jz7xCS02+6PZdPuqlElkULDbw4wwZIcwKvBhWx1eho4nxJcYdYFjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107667; c=relaxed/simple;
	bh=x+jr4m49wP+8i2/FZYDMOQfGG0j2TOvL7tn8QjaWo+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yct7O5wgbI4TgHUU0twuEWOqPoIYolX9L0e8tJjFJqHxVkEKUj1QKeqHmITHVJBgtsLNT8LQfnETwsLKWRSyAmfRx8c+Go+pBz0IP1v89Eaiq3Jc6yl6XDudkoeR9J6tn31rrrE9fxeWUnzDmje3jZYxX3JKTFnHh7rGJ1n+gRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aJ9Ub5WL; arc=fail smtp.client-ip=52.101.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aJ9Ub5WL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVjquJxbv8RfCyCZy9auEBSxLV/eD3v2VqYI0x0W13c94F+8ZfT01HNcFcjT4OV0bcCadGzH/KTgqBhjzKa5mRvRBLRqbFxQZc+Il4UkVHEuaz2ImoE1i9WhrAsnOq+NfK+4gli1Fxl0O+dVHMjCL9PN7+k41WQ9XOxnBVA6RsBS5TTzML4tGF+B/98/YmSy1W53/te8ePbbS73MHWa1+d5hQ23qmCvYnE6pWwyzir4Fs8C//HgRDsaY+Zp/ad5E67zYk85Uu3QBGniZBHoCGeSDqbysdCQ6pdVurJoIB/2xOXjL5UtWpIWiHJKJpEq1NKzuJLh+HkSy2D5DKnkhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQRbIJIKrp1TwmDhYhB9Zfx6X03aWZARMa6qioX9YUo=;
 b=c2z0TlMME/A4Gs03Qa/h2rvXxIfCegmE6/BEk4NkawCFwkWwPlgZym1rUj7XT/a9+7xvaoti840MRAO4hWhweXTXZiNQSk5y7Gr6A4zEDj2150DXaZwgsd3OzDaAic3GdY248gSc0QjURKy8tyfvRjAvV6oS7CfAcrr2BU9MAt7jUNzVbZBpKlhapVu1od6qOZxt+in5tchZyAPVyG/xZ7N0Se/yq9QnzlcF5Wb2sd8g5jKodw+ABlzAaTi3/1pTPextvMdPAdbaY2XkLtogFnTEVfyDcNN81z40qOzQolhKkNB4xkDcq/QmwLmZWTYwsBxyY3boTOVvUi5dDNDh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQRbIJIKrp1TwmDhYhB9Zfx6X03aWZARMa6qioX9YUo=;
 b=aJ9Ub5WLQHkhKQTEBQqUOlG3qEN8fWG0m8XY28rTRlLOX0OkbjxFG7SLlj8ZhGM9FSViHyPDgDXBcZhgbxEbaQD1hR3aw7yFvhHoTDXaJsvqZUtqqj/uWheasMWU8auXazcrLrHIkIdLwZzY/HuvoZVZ/X+zq+hSniomp6lkBIPThJzVEtk7sD99f8f1QeyXVmTw9XJhrskju+jQ3VEfKWTyscEo/H0TVP8kXAiZ1GnQGtktHTLS3Vn0LrI9fIS3h9aTPx4AL1SPLJ8Qlwj3pQY5aiFgXYYu7jqIw9TVN4C2zc+JAzDlUdYPsEDjN1RjkfIE4Jz9/il9NOk5sRiU5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB8434.eurprd04.prod.outlook.com
 (2603:10a6:20b:406::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 01:54:14 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 01:54:14 +0000
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
Subject: [PATCH V7 11/13] arm64: dts: imx8mq: Add Root Port node and PERST property
Date: Tue, 10 Mar 2026 09:54:24 +0800
Message-Id: <20260310015426.365675-12-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310015426.365675-1-sherry.sun@nxp.com>
References: <20260310015426.365675-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS8PR04MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 72be39b6-fdf6-4801-5f48-08de7e47ee84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	SWuHurOoAaCzexrd0j7LSoJRA+cToC5Im7Ce6KUAfXPXXXSKO+sn2R08uaz9yjADkXv+E/9TSHWJii0XxGL1N6m1HJtWTks8xab520jKyi2wLzMtWB4ArCKObQFHpKNvzQW8rzbUOaKaigdn8dWBFxoSmEAkoSTRCFYX4c63BUcP6oE6cAGtVMGgM+AWBJ4dOUTwJNPCk7+Q8eWJqrSfD1bchPVnASbSA/IPAc6QJ4Vd6OKHA8G1RSPq3pEiDtEKM3hi4vrCKVXRCp2SLTtMAZA9IdiHyTp7iVgI59s/XlhS+DgwsV0eczjU4AKSGbcQWQZnSwuCJfcNGkm5B/olXlJlnzze7a6d6EAHOMFPeCxc7493AjMdZe57s19Sx8s9KjSP7/eEZSSOiKOTllYXOiNSQj6In/aTLh3RBPEQwBUksVl8YDmn0TSKsv5dfnvfQE7fUEIvlv3vwAPRUYJpkJqzB/FdL0A6+4fV8e0wy4WzQVSAkNPATrbh8eiETxnD4dbwB4zE1SzDjB/24brWItLDSqu0qxml+LYNlnZUshqh07wWScfyjnOknQvyYOWAkQmkWA26gcKwRwDTSsFj//cKA+zWHugfSRX+6lh5TJWq081xpMoRF4BfhNf2CcHnfihiq71rxg8bgV6kghTX3yAEgd+zUxeUEc7KOuT8ZRGc6cF84Y2be2D0qE2BADElaqIPi/CQ5FyyMVpkDkmIFPu/h66fnvqmzvmCMzxcOY/XzARy7xLw6UFznEZQ/NppbbK1yQxbX4I/eAhLe9Ltgp9OrwmRmBcs287Hedwlng6kqumWf3nljVoIECKW5bJ5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kg0Ik6QKTElTmm8HFq10pLiPJO7otmvruPvQ005oGhpiVdYLp90pWtqdHQfT?=
 =?us-ascii?Q?rodZVntyL4ff+Uvv2/NpEooRJT37T+4PAnbiwERetKXX2TQGAVp6fyyPbUZT?=
 =?us-ascii?Q?jBTPCiutD50NowaZ7sYlKBGqtdplvLCGBs/IT5N4k/wBfu3c11dJ26vRAGoE?=
 =?us-ascii?Q?DmvwOjFV4DXmUaSpRqPdhKQTFiHMUaqe/P8R+uBIn+IvswHtivuUyaZCoMZ4?=
 =?us-ascii?Q?f02XTAFxd44ZGKTjEyDd/2+kyCSALul/aPIp+2DTjn/aF59tDkoPoH+ja71y?=
 =?us-ascii?Q?1bQ+Kaiv+dHGgcVo4DGrwaMh5p37xZWSaQ352H2E8GI4i0I5eUFnBzXI+YQY?=
 =?us-ascii?Q?NF07JBxf/dJddim4H2cqpvsVA0OwRbUX8Jq8+cYDaVlfJ+f6tfy30IlOh33Q?=
 =?us-ascii?Q?C6qa6qFJD/B5I+KFziSb0DEveCCdZtnneAF2GlADxf2VuZ3+bOc/v6d3lDvp?=
 =?us-ascii?Q?tO0Oi7Qsr34GheV6It5xU0nyljBCqC/KurrtCU44qPEQJ2DXkEpB5yXzL0Dl?=
 =?us-ascii?Q?Qk45cCwHdCA6EymxTB01Gj6jPHS5TyznrzmU2+MrN4Yn6syOdPZBfNFT1vuV?=
 =?us-ascii?Q?Uk7ae4+tfHShX1Y70Itzd7WaQ4u2BIioAA1QIwKk1PwXizx5j7FCEC/ngYDU?=
 =?us-ascii?Q?APO3ELWOPwv3NrE0U+8tGYCw2POZNImtaQ4K6bLM3s2Zt4gpCe17y0tR/mlu?=
 =?us-ascii?Q?atCI6XPTKPUIEjL3N1vpfdcGFJJzgJTkboH196fK7tuc9SdVDJ8GVRRx6T0d?=
 =?us-ascii?Q?isJ6z4Lc1XZPECivpHYlM/P3iylF8vkGJCLt03ZrEBRIpn0bxH4FlpaA+maU?=
 =?us-ascii?Q?m1oZrcEAPqGWdoDcWZKwA3hHiPjTiGCIs8zSlvh+LUjRZ9zeHfatw/HX7i6N?=
 =?us-ascii?Q?BOjwEVHVDmVQoU8MhFFsYmL8U6bem4VbLLtq+Pb/KTmk3euuprfD5YTe8MdE?=
 =?us-ascii?Q?hn0dTLYpeglpkroo7nUf//O6XeKm+WXFtQ4/8aiy7HYYtNvAs/DW6yu3hf/w?=
 =?us-ascii?Q?gXEcWcvTyZOCPFbNQGC1WmY+wol/QCEqSX3yNVcM0sTquZ15lTPO0FAUxr9T?=
 =?us-ascii?Q?L1ryiam4j+vYGTlOFXH93zKc1EI8/jsDhV8njF8bM7e5OJMGlrPA43P4lbiI?=
 =?us-ascii?Q?8n7ZpMyndaVu3FRxpvncUg0kodRwNwENll0KGnzdxhvvm3BK6kPUI+C3O8UJ?=
 =?us-ascii?Q?2Jiav18kKbRlge9GuDUfQr5/tS/hgDC02iaW84wBQ85JeWvtU2vkn2jF+KdD?=
 =?us-ascii?Q?bWZutzGDYpCCc3aonelKoA7F6KWj6lv0CVkRVRij1iZ9inZKr3xW1q0kTUCB?=
 =?us-ascii?Q?uC+nzmwt5HJ4DaMiJj80MuqkYlMIgVJN6+eKu7yQ04Ha3UiNq5VLjTSvEfNY?=
 =?us-ascii?Q?jBSgfDwys9cusQHDUVh3QDCltf4qNUDt/koe4mo1JViuUQoXtmUh4SaWqkvE?=
 =?us-ascii?Q?N+73+ww+ThEEcHMofUgLAmRGLJjyUg18XZk7TefO4dnyb8bcY65Rc9PEo7TZ?=
 =?us-ascii?Q?ZgC1o4GeDdjgB3X8Oox6Up2xCedwGnFJLcrM7234A4h8mv7SoWaJGkQyaEpO?=
 =?us-ascii?Q?X24Lth/bGV94g32FnO3SDpdu7QqCb0uQQSeUJ7iijLJ+5iwG9MqKwRTAaAge?=
 =?us-ascii?Q?2HeYWqiLkCPkt+yoXzYIwaOwPoj1Heo0lt7mdd29ZmQHJnESiRjSUDYFW4f8?=
 =?us-ascii?Q?aoFVWAHDN0D7qB7Ne3dMxtKF6uv67col8kMpYlQ9wzEhN/ncMwfdzUjWVkuV?=
 =?us-ascii?Q?e5rqSFAvuw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72be39b6-fdf6-4801-5f48-08de7e47ee84
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:54:14.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acvJXnl6b5neYQy2NfG+ZAYWpFa8emBN7eVZjPUSfNaIxUbE4lTS0jNovWiVMesxNVFSGGK89xAHX2SE6DP7lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 22 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index d48f901487d4..e7d87ea81b69 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -369,6 +369,7 @@ mipi_dsi_out: endpoint {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
 		 <&pcie0_refclk>,
@@ -389,9 +390,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie1>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 12 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcie0_refclk>,
@@ -414,6 +420,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+};
+
 &pgc_gpu {
 	power-supply = <&sw1a_reg>;
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 6a25e219832c..e60872aeeb49 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1768,6 +1768,17 @@ pcie0: pcie@33800000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
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
@@ -1846,6 +1857,17 @@ pcie1: pcie@33c00000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
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
 
 		pcie1_ep: pcie-ep@33c00000 {
-- 
2.37.1

