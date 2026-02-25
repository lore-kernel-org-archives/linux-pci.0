Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E8394471;
	Wed, 25 Feb 2026 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016933; cv=fail; b=NNQjbB76N4ZxFw+TSq8cnxBtN/mituaEgy4SPtsiMXKqf7jLBkuJddJtgA7rTh+ggolBbkOcbqwJUZKL/g0vGJt6xlZ/K2siMs2YZrzs1r8GQonGbzOyDQscPWFX+WD0p8F3pWDFSmb/YTzTKlRU9P4foyXUMPckotTJkD0xM1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016933; c=relaxed/simple;
	bh=AAkUszj6SPnK2uMoevOU62XdwWErsKVAqBVjYvH/RUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KbkE2J06XKKxEl/AY3/Ef+yybUaV73gQ6M5lqIwkKT60AofsdazVdaz9XHNDepTbyZ91Vc2OZAkLiJWCyZRxFmQdM+pZ6f6YuBaCI1a9cf7gpSqc4sBJt4ioRgxv/uLSLgp+ZOVji0pmdsBpA1fELdukY6um/RNJumgiDN617VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Epm51ls0; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Epm51ls0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytocul7EhQWt3W7QJ+CMjSekr8aSGPrS0XmzNoR5w+lvQaIk548pFcRwmQDP4Psb2JwUJMYD6cn1aABfwQReT1GD+pkWaU0iQ3GxLE+n2dYK0YSnZ/I5LldhTFWVnSoh5ESKkPyQsZDj8zJyNVRotU7mlhjHnOAKMyFHfXOrdfcARtE2/3ZvxaGJHLLZf/vT0nLH1JlPSLNFVebNY7nsIfmAnAk95Vka7g4e9C21HUwrQogJlBFMU7kWzAnugTYn6YE0DYw/5aIgO+uCDCHeEcI1GQWZ1BKSpNTMg8Vg7Tvg8DllwY5rd0pvowrjBG/pzAUc9zpFcEfu7txo3qS6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA6HH3oT7NxLhdanoXDLc8ORR9yhZ3AIV2S3H1AIpj0=;
 b=NstARuzDCwt/Dl8bFbF/jS7hw5+lzBlVOkLlD7ffMJnAHZ9eI3YLi/WRFWM+2wJgJ7EgFbloNNr4Pia6g8M4hOrWgZAxtUmfEqJGh5jwkeoAnwNC85FmPy/PjLhOjEWtyQRWnAketFIxhbjuasuNTjpnxZpxKrhp1HvAp6O01ysm3UP4wKeAqlnSscsx3wvodYSIuyXShpjtlkX5WEkw/7cwaRjdpioe58QYmo6d7wp3zE/ohnpNdemRZNNJvBrK1O5Pv/US8ZuLNVpsc9pq0Em1mcA6jWaA95Irfap/dQiwtywb6Bn39J6L8hJA32U2WdwqtToiAk8ZtQ5cQFnrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA6HH3oT7NxLhdanoXDLc8ORR9yhZ3AIV2S3H1AIpj0=;
 b=Epm51ls0oVmNctVI2/IbrIVTRcSgl4e2qCbluVHbK64wgTYF0yCGIRMrCk1iBNxEWEipHKswRVwaU0q5W0I3aW9v/SIOSx3Lx4o1kXuD5dhJRcxBCki5Ltxl49MhCNQRuDVKp0t3JmXRzrV2RfZa+k8XJGNy5tQjOohkv7vVgzY0wKpDQ2vguMiv+A9jJSPkObMgbcbk9pIP91VwZP7g9cUEex4PW8lpJakYWi068U554XQk0MzVxRQ3bES9KNXZIQmKUUDNudlqIMcieesl5nM5zaiLX1FdoeEtb4fOyiwUfAgOZ7/YNNffH8doYs3lbUA0r4s7B4DUKHTLG0RYAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA4PR04MB7823.eurprd04.prod.outlook.com
 (2603:10a6:102:c1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 10:55:28 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:55:28 +0000
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
Subject: [PATCH V6 12/12] arm64: dts: imx95: Add Root Port node and PERST property
Date: Wed, 25 Feb 2026 18:55:23 +0800
Message-Id: <20260225105523.748775-13-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260225105523.748775-1-sherry.sun@nxp.com>
References: <20260225105523.748775-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA4PR04MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 969c5c7c-d719-4295-a59c-08de745c6352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	KeqHudLt9bLBrjwPO++T6WICH4YtmpcyeXutBBd0D59NXSTUhsk9szMpEM2WlOdjCc4RYZ7QbTYtMbrQ8v0Fm510GTrUS2mKM20FncaQI4ha43rqJo1sOphhMm7D/LYBQ8wFxgNYUL8NXlTZ4bcjRjmNkys4IyOMgaks+Wykj/pnjoUXd+m2kBUBLsSfzpCP/TE9CsIluDFsZNgMGf/f4kvPuBWB9GHkm/fM1WKnBqjuxwSb06+/QmBlBVPzdGPpOzUADevlmBgP/4ppijIcn/2lRa4JldauVhkaB3uQlQ2PaeMnE2GfI6scloN3Ob0rEAuCs0yvezjdNxxhG81DPc1xX8jbDFGrv1efdeiDE3Roo5duYAZtLeo/5YmYcEeyHNeaqjJUjRGkmjOb3SGZsDPvVE2w/BrofX8oj6hi3XnUTfqAtlr8BhFU99/7ohyqNj1Z/CmqwcRic71WfBBSA+Lr+C/1rgHz33vqsZmeXZA5dR2sJxNvBieTGv1HLo8O3hgwG7BJk0+iH6zXJ/C1fdNpR1WDxqw3x3tfy9fYJmyKHuN18762+GUkvu8iPo1wMqwyDjDfJVXOAqV4TgEyUq7aVUUVo1PpGizopBJHAF37y0jfDBykps8zyKJvhATWS3RVFo7Noo7YndbLPOi3CZg4Q8m8rLB1MXib0kh3222uAZ1HLeRbAGjNwPtXob4mNEkCkPsh6ohvyc/o0IurkO4lTH2yukVyuH/fndQGgVbfmjDEOX86MjWMlPxhScaRwl2XKUKjWhnka9SgFtpR/aI3nYc2ryyadR1ysiSxRoqv9NVWWUScEpn9vXAWRXau
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XWWqsaU29bot4SnLqAzdtsBqXma13UARjestnXCP5FGnscXMHgE8ztNCoGNe?=
 =?us-ascii?Q?2sl+pVf+ig5G6V0Sfz5derfgaD6aaXRQYI+eL35lCIg2H/gvBvH0FfbqDRKj?=
 =?us-ascii?Q?H7oiZmGcKu2skMjxLOAgBKLJTPNAkwfiVIWJyB44oAw6bsbRuaEtCPPrzze1?=
 =?us-ascii?Q?DQ5qxCWJzNV5UzsxGF6CkxAPErUov7VTSpNcWM7wU0WHxIO6v4BKinCZyQVi?=
 =?us-ascii?Q?iwrBdzjzs8SwpiwYn/wdd6z1BU91Qa/uYRV2WfNkPES7CYxIsxtk3bysMZBb?=
 =?us-ascii?Q?KlZnFbjA6JcTg4NMNN44xgRfx+bKVJDar7acRdsJ2+pKP7AfLYtSfpQgi+Wd?=
 =?us-ascii?Q?lpRPrhSjcuyOnrfzZiAV4GLLoJaksxOSl3C3aqZrNckZ4/9OoDU3IxI/CdoT?=
 =?us-ascii?Q?trLkfOthpiRsCW47pSJAxw2f47JvXShzjNVJdXUPosb9pTj4vrxOeVxfUe2Y?=
 =?us-ascii?Q?KQ8Vdcx8kGCay0QCJbDaHVqJQcfSlNYCtliZh6WJNn2dkCRzK7xwGDUDVaCZ?=
 =?us-ascii?Q?4O+S+dlbdxKs4DMEa2u5Kc4WnJakQdjKj0l3fW6d731dTWWkOnSEOuvXQJ5I?=
 =?us-ascii?Q?LmpXxIT+KAY8nJu1Jwv7AajBY5rvfhVKTLDj4f2lAnxP1QZ8BMyrgKXFzRE6?=
 =?us-ascii?Q?YCGRF8tPrhpdEVdm7/lbf5ETJ0a0MPJVKxftRtNwDplUTMTfA1xajEIuhJ9p?=
 =?us-ascii?Q?2zGomIc+f92yxJPV/AfpIZ3m09DXgjiK6lSonDm9w98ErS5oWRm1YReF1mBZ?=
 =?us-ascii?Q?wHyTxNkglgYwTfW8YEFd9ul3qMvk/LVlNsUn6s1eTGdj+wz7cz46Btd/D60z?=
 =?us-ascii?Q?UtbmWuyaf5Lzgr+h0dub/pSuqFkakcdYH/aEC71Sd4tOAP5iyErbKDOmElQG?=
 =?us-ascii?Q?52tJbLASolAYBTydRXNNvk14DbLkc9ifPTlgUJGa0teyXASNtuWfKNZVJGj/?=
 =?us-ascii?Q?9CVZDlV1mt/IvyAnzszuNTY1WE8B47AMrTxjWKJfNIAJFJmUNRIauI1kK3hT?=
 =?us-ascii?Q?rCYvfHXMz4er8jJzV2KTEUqyZY46oTwfaIsAaKLJnj2JYmYG1AMfirkGqmoS?=
 =?us-ascii?Q?+CIc4nkfkjXbZxcFj0frtUxBtTrzs63ovHvcC4fh/Lb5BMdiCHO8D04u6Aom?=
 =?us-ascii?Q?vgOx6lQ2KL5+umnBjiCaWgKscjB2L4lutyg47N/xMuqxawv9bIPGrXX5+vQT?=
 =?us-ascii?Q?nAhXIJ+gn635eMIlWpdhaGD0AwMXr+nPxl6Y2Gc1Ciu2pecHBrhlW4dethS+?=
 =?us-ascii?Q?z0tYA9CHxAh9BavYfU14R979uUF+xdq5KADZLgVPqDjtcYeXKCCBJmWh9X6+?=
 =?us-ascii?Q?MFhig3QBM0naoP2tVAEWf1ZPjAdozGqXHBuRw+8WOlPSR4bAtA6EwI0RcCSJ?=
 =?us-ascii?Q?zYMtLHrvT4RR3eurSWTkAwayKRPPeqx0kmhPFm7zzCwRlo9VN7ZnR8T9WFdI?=
 =?us-ascii?Q?uiP4oDOwO5YXW/FO4e0u90MfYVYSA5HGfiJvp3QzOJNh8ewBAGvx9zEky9ce?=
 =?us-ascii?Q?TluohuckW7+ssoTlDg1On8PrHPGNp3/6f2iiOmtiJTWs/YEyf4pu4zRcjNTV?=
 =?us-ascii?Q?hzGcE8nMNc+QPTat2oItINpaBrCQjlinjrVA4eL70CXOURTZiHNU7wXddP7i?=
 =?us-ascii?Q?LkfeTpXEq53Niqt5o1Ae857tkZXafp+0ZMeq1edo37Qs16VmuQs9JrMVuTT2?=
 =?us-ascii?Q?HxKx7I3gad5vPrp8JHPevccJJlTmj+d2mcxpQwJMXq2NxmwBs9tseQzLJXkI?=
 =?us-ascii?Q?AtiBgyYSZg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969c5c7c-d719-4295-a59c-08de745c6352
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:55:28.6056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+Kf8ulXvRJh7RmdXPf6QD++ePhLxKiScCKt7LfCl2iuMf3AYfzFZ78Yv5ys18OleQME0JiwrB3PRFI43TLA0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823

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
index d4184fb8b28c..42bc09e48b80 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -554,6 +554,7 @@ &netcmix_blk_ctrl {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_m2_pwr>;
 	vpcie3v3aux-supply = <&reg_m2_pwr>;
@@ -568,6 +569,10 @@ &pcie0_ep {
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
index 55e2da094c88..7c5f350fe3a4 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1883,6 +1883,17 @@ pcie0: pcie@4c300000 {
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
@@ -1960,6 +1971,17 @@ pcie1: pcie@4c380000 {
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

