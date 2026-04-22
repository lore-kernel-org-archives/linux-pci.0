Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17E53C3457;
	Wed, 22 Apr 2026 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850532; cv=fail; b=YbFWW8NzzW/OTThWbQUpEMQVZgVYtkzC2O1yRLEdUsbypHFZ+2pdR5zQJNXDl3Katlv8H1PZAwj4lCnDeMf/4uM+1aa6rCP8CyxuniYguUj2qF8A9GrWjcQHq+WMkBPNt4APr9EphZQxdoicX3tJUTbzVLFFK9zqE2dwDOINBPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850532; c=relaxed/simple;
	bh=qenzXLklhHlqYAtsHgiZ91iUxT0DbrT62hGAnMX5908=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5fSRZ6cE6ZyCN09QanfUVfzhPElxUe/m1DtWNaYySzOS7Hm7JfKC6UCRkirJ5Ru5TxdsYvRWhx/hlcFoS/6aa6ZdQwD4aFz+TmAvUFoHgq+B1+KKANOQLw7cpDzeitM8Ov+PkdpZs9rpiO7D6QMBKGAZYgbTidTvxDuyxGjZpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n25N9bwF; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n25N9bwF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2bPpBdwFiPrracdQRM0rYbhkYVgNSvwyn7cuAtVhVVQt8ZYBMeT1k3iUgG593oAIKliH7i4qQB3o35eCRDufDAHw83f+3aaDoF2dyQV9/1zJBZQR3gu+oKnOA55gPR+C6BWNjmqSkw9COnsvxSKgC+4hQOULGFlfwOvTYW8d4kZZCaKklGgNLiJ2VCeVOXKOI+hdE0FSoakvgFcXTahJ72NTsAyebqKuzt1tK66CIrjNDUBiJWHTGkHrAICsdjus9PgI/ussxNuT4gkJz9OjiRdYwf87/KX0avLwRIcmUwpcjefkLz9NkR278SdhnAoc+JtvMM/DgsmynGC1Oe64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJcLjZ34i2X/erIyjKhzluwnQx5p8ZpyC/lM7caq4UU=;
 b=nVOTAfDf9JUe90B49LkJUIYmozXUpHiqNHb/boToSnHKWnF9sgBd/E+tUJsgyeMzfRhvsJNPl5WH30jhxIcrboLCZW0NEiXyJvWhoKlGRMX55iWMiNN0VBMGAdKKviBJBrPA0hdtINmAKHOysRDUIU3vkUJx5gnYFsPwDn5mMbYBZd8+AzauUypnDQD1zqnBfRKTpDo2tG5fPK2WRwYx899SHvtWAVCrL9BvbbjC/BRyjqBE4olEqxleDWFkk2+qK5Ay9XNYsFfeo0jw5h3m1Y/HFdgivACPy/0480L2N4vH1uG+TujPdKzx9A6v1xYVw6HkfEa2I0Sy6ywCtHhEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJcLjZ34i2X/erIyjKhzluwnQx5p8ZpyC/lM7caq4UU=;
 b=n25N9bwFwTACQihYBycYJ4uiXSbRAiKuvdRzue/RsIp4CRwFSne88/7O60aY/ZHdt1FkBs5ZO4mXdu50uzbLrb4bmcRbVdqU0+8dBaMkIuGdpoIy07c72I+yVtmZ3lD2BPbh4o+r7uxiT60HaaWSyKkd7TWEWLWshA1iAWE7QrfTR0U3L/5DV0EGaaLxDyfzN4HDhJ5Y4gljevMBQ3WMJHDM8+KO1gJIZZqvuU8SD7rBmTrquyHSE5ECb+Xzvi6rmbsdIeykL0ffjhm9pfROoGocdMwYOp2DMRsbSIosgxY1V6wUvdV9I5lOqnPNGMLEL/RO7HF3PKMFhwdp1F5xXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB10554.eurprd04.prod.outlook.com
 (2603:10a6:102:484::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 09:35:27 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:35:27 +0000
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
Subject: [PATCH V14 12/12] arm64: dts: imx95: Add Root Port node and PERST property
Date: Wed, 22 Apr 2026 17:35:49 +0800
Message-Id: <20260422093549.407022-13-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260422093549.407022-1-sherry.sun@nxp.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: ed72e18b-ff0f-4997-c5d1-08dea0527cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B8yJMBi2QGYzDLblUcHWoNs1b6h7O2xjko4mCpuPICpvFArd1vdkW+IEB3TUhEHSIm2Po/1slYm7EuIGlBRObcpdWe/vpY80uwPMNwQXwdi6LhGLt1GPLMcMp04wJx5OhC6GakPAfX4V9aNJGs+sh+ZgWiEP+c8BoecKEUszwlaGKQJUM/HQbp3BXK73OAAzrgzEl3lHDg7QQ0S82ZjBaa6Cdi/aknIugGA1LK30JIXUoBLGbvDLVCZJ36vqinRfriBaPixJxWRXQ0zK6qKGpfuXsWU0y318ogwuzV++Y058oOI7vcrvfKlscKhVRMND5z+KzTTIfu735wnh8y4PNPlYFRCn5qxNyUnvXp8GVYWZTMf7AF+OJPPB8sZk7eUiMV8zMmGtS3qnjbJcDEFsuQM+Oek7QQBk6C6nLGsZ2OIRSP9t6pHUViYGi6ov11+vZ3l4Pu8EaMWEsMkv4NMBV6x6NxtGHXbus4IKH11t2uH6CCpEMnHItBijROu+SzhsAlevNGcdKLkilIbdlIFSv8O8N3AmLUtsFg8LiomORzGNHcnEKxiONTyAGeckQiMzYHBa/cY9D7bzW0aU5yvgBELtgKAEUaNrfZhAsw2ymVG5LJKAZw0b1jRcJ82AvCnhveRmifFDpwSQ2u51VuZRELESSsEcGqgGyW4LfnSJxqoCH8C1g9/XpIU1hvqGOAzWv/EIu0A9PgX2vJDz+4VBa694XF3OmrFWuug0BPs68dqSiyBoUbiqwqsWnkVoNiruHE25KijC2mWkZh2WlxzymIQFJkgrmGqrOsr/SWH/3tYOUrrGE3SW2O73eK6kFaKH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+5SpYHYl8C0XiVc0bdBTV4VisKYxeLNM2x0/va23UnOQ3mBlYzVtRMks6Kqv?=
 =?us-ascii?Q?reSOhvLrzA0Ke4RrquxS/0aKtDP8qJG4m6PDRY/CKpWxjNJMZAcHVqUP0Dbj?=
 =?us-ascii?Q?ikzeocVdvt5ONqQDEv8+RvG/me3jiAfXVc/8x4ix2m1RNxtrA1/fJvOI24/j?=
 =?us-ascii?Q?GnJ6EPql5lg/2/EBaBujhTyjKP0SZdYuNT24YZpJlU96EX29FlYKeYx+F0ZT?=
 =?us-ascii?Q?6mOwg0UAb1lAnYImQFxTewyfDKaPo82n+xdUVnviMssxKqyB+U6tMIEJ6KDv?=
 =?us-ascii?Q?SoBXSv4pvIrWElkgGioNnVAdIFps8DDT86we1AgkxypEVoTWjjWA6gxzkkZl?=
 =?us-ascii?Q?TPCYgby4zcmJzweWGJ6IqBODSHjL6ZPllpFzg3WZGFuuzryqPKcwIVWZ67Ah?=
 =?us-ascii?Q?/X750PpZVqqKi2wEf7TfykITfgsp7NRyJT1P+LmijZODsKNUe1UlXthWlM22?=
 =?us-ascii?Q?XXLkJoMMwfdpyEdkfDH1h8tIkvMsJEtbrOJ7Ji0t25Xev0x+ZWH4EXPfQBUn?=
 =?us-ascii?Q?9QzMf44CPaJhrNbwQfxAzPcQ6LHfe/gOE3bD0IDHl53cYOB8pE5b5Lg04sPK?=
 =?us-ascii?Q?+ubYH0XPHC4xnKUXsdVK61QPxAUc6S1Ljgs7hTxBPFbULnl5vZ4wK29HsZ2g?=
 =?us-ascii?Q?1Kgc/dbeJ3tb4UVIatYEnM7kG8TYVD/cIitOMJSNlq/WsWzXPsUOL9BBytOO?=
 =?us-ascii?Q?W5akPRu3g7ADQsjjxvnK1Fec0+0apMiAcNMoLeLjlVfsKs252niDl3xaf5kG?=
 =?us-ascii?Q?jk0PEGrvxp9lfTSpa/KkyakJ6lxGxCdvtm4UPoBSuZ+5QDWW4kaVxmTEr5Zx?=
 =?us-ascii?Q?scVcMt75bJI+0nG1PGDz6+Qjfgiz+5feBWrHnByqNR/WPsbzqbh349jIuvXT?=
 =?us-ascii?Q?FIey6LAJM6vyv1jnltDMQyG7+EoZWPPouMvokqidrO5btoNNLBivfa2BbQX5?=
 =?us-ascii?Q?5Emrb4Ljz+eNQTEuPy7O12NLIML5qeae/Ml1001tDUhtsdbdzBUqNsqAxIfa?=
 =?us-ascii?Q?Eropv6i7/wQ1Kz1/FUjj+XW6iV7KWTl1UIwP7DDffZbbZM6yyuo/KLk8Hkeh?=
 =?us-ascii?Q?xwstrIrSGMnSFH9I5wKiyIgeEhzG4oo9P1JCjko/Qp0BQcn+9teRbwZQU+lN?=
 =?us-ascii?Q?qFGgXNvrPqZMK9XhjGlMoH4iCGLoSpehHVR6P5XcSvPlJBZ6Zxxw5GVuvn9e?=
 =?us-ascii?Q?VdgQLQ8n3FFFnCP8YhShj8XXnjhmSkS7sQZSXCxQARp/o/ZON8XxMudRck2L?=
 =?us-ascii?Q?1AcG7QAurI13V5QosMO/z0tvXt1kr9Tpk8tH7nRxoPsTJ7T/BmRbKJaXcJtQ?=
 =?us-ascii?Q?mg53pDMxp31S8NQAuoMrHlREJ/Hx37chEJHuqGOVIOE4ct6G402HiIMIs397?=
 =?us-ascii?Q?F68/D2nnGq0AP/htLteDDEWNOGOSgmXK1sdXZ8Vh0SILn/D7PqIUl8OgXwT3?=
 =?us-ascii?Q?tvVMxYT4y8cEkQQII8qCrG2Mkyx1oBxmG6bh4HrCrpjz1ytXV8ZrPFo9B88v?=
 =?us-ascii?Q?icA6RYGwDYUkNYcWlKsw4a27TAmdVv8U6cqzC53tbBoCyXFWv+t/bxDOaNky?=
 =?us-ascii?Q?aIfvATZdT7GftpZT1LHlzE6L6Lnu2RyJT2XZtbzGORZaLinC3e6Jgu4tGUW7?=
 =?us-ascii?Q?LE26Vj9Cjj4uGzsS7uekTbdmqHbZTdh5NssT0DDjREmu4hrlj5Z3MSuGco9x?=
 =?us-ascii?Q?vgtpKNUzixT073k2EyFylsT5Y/RMwOUeixaWbWj6VFFS17LXsI9o+xbZ4Oux?=
 =?us-ascii?Q?YgkguoH5dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed72e18b-ff0f-4997-c5d1-08dea0527cbb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:35:27.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eWRUYOqHKlNbHGeCGJQIUlYzjnHtzjjPi1StobvmdGe1xaXVkDxvDAC8//So820B0YKcxqOCGyA4s2MOopFDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10554

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

