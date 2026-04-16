Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D180F3A6EFF;
	Thu, 16 Apr 2026 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338055; cv=fail; b=Eq6ftkjhid+tzQp10/ySUESwqRvkxSHQ6ztfp+QYKjXRjZ+aMnkQVUqPjKWDJ3Bjub2XGWda4joNoNXpchxUzWwlYat+8+SHz1rhcYQxQOHJ+RqdH0SAFc6BLWUkljmPxARy7k0920jpArzKYvSZ22AWpzGEaTGM9zB49ltOszs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338055; c=relaxed/simple;
	bh=bhd7sdPMyTLTMWxUSfuz2/r3EYJn8I2Uwi0UkbpZwCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T3quCrYk53UnOAN6VF9dAoHQSzwcilYN9dGHSlw4c84p5XWUo1G8KQkJDLFs2gU6pH/YyK+1pTwkzgKwEP1lE+6uLNBEjzIeERwzgzUgEs/sgFHGqY/guKRXt9VRFUanfF3gesJbOXy/6xJRA+w/+/LTJvr4qqDcshUtkBhyZaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bG77/eT5; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bG77/eT5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tt7N6ZNx3F5Uqa1mTueLb7kxxew/9kO0+mEpGyVfZ+wXfutzsGM5u/wwuy940PA3GIXYPHPlyvwdUvnte6I2o8/+p/257G2GwYuOKVDevh72gngMQL648PV7DcigEP+E5j/evdYmDh7XhB74nRfVDbO3X1TWsj7UK2Oqi2pZE/RkBqctze3brJDEnmmeppMkuX3NpQbaK8GURvATe4rhlvGQyqjagakUxobjwR/NQ9SyVXPIaW57rpyOuFAGVpXgzVPiaBoX3HyYLuLheEAannWL1Z4QgYo3NaIf8L1lS7HqM6qjWrgmc958K3o0XRYSo2Jc4daJt7sr1F7WNptpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar1VoCQOfqxRn9JTafCIhUPdpnR3eh4akKNpCkBDLIQ=;
 b=yiJdAAnVPkxuB6HtfexLDXOAiUmbBqYn2MIbhGJL7xmn9tmm31s1SydAtE9sAQ7yE+WYZii2tfYkh+js23sy6jKBXILKKbFJwJdZ/ia6Np3zS7nsYkLCTfTkc4au6hLSh0JNpCmn1fFWKXKsJcfYxEsZZ+/BKu9aBRJ7vpxSbOyL5tsEadg7lavfciTI2PecXWzok5dKJe4pbwXkhKqbLtOMHyIqILWFemS/CgxyBjVKt71UixPriWOopZTNHbygZrmQ15UsPZrZz0+kqdgXsf8lAyGcSxt3kS0Ml9ZIHySjLeMIJzGDNQI2RlrJc6dR2hlolkJgoG7cxZW/4w5Zjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar1VoCQOfqxRn9JTafCIhUPdpnR3eh4akKNpCkBDLIQ=;
 b=bG77/eT5yxm163fkV6dPl66aSew3XHsCaHsoVMlYqxE/X8n9ORshrhgJuNCFrs0+gv0BY8X4nM5+CgnOb2j+5xEzeQ5hNuNeQ2czjjnQBmdUIZ1+qA3xe87wJ61MMyHc0RXlzVUUH5D9nntNxr/v/CpYt4ligmwATUgmHhFjD0EhlAixCgmSa0i3zxjZFMNOVLDek5iAppvZicbXi8GxG9279CHEIbeqWWJ8heogPkYeDK7QWhPo5VJys+BD5hqOSQ+cY6BLlZwuT9yXGulse4jJBiwYEvDGhXYtQpyarEFDb5uNHx76gGgAuf4FosNcNxZrEeVtA8Gx/IsmNremAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DBBPR04MB7897.eurprd04.prod.outlook.com
 (2603:10a6:10:1e7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 11:14:10 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 11:14:10 +0000
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
Subject: [PATCH V13 11/12] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
Date: Thu, 16 Apr 2026 19:14:21 +0800
Message-Id: <20260416111422.183860-12-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260416111422.183860-1-sherry.sun@nxp.com>
References: <20260416111422.183860-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DBBPR04MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 444c33e5-1f10-41bd-e9e3-08de9ba94850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VYpi4sER8xu5a9bSDNIGL8o9orbJkW/XE5VN6q6EWG5aZRnIJmci6J4kNIPlQbd/cEahEV1IVb2TK+R22AE4UOs/pmfxTTQaghJOck8PfKyLJ2S4Go4ynLvULlu5PSNwbuXl4Sz+alJgW+9Onbw0L84nu8mqu3Y6ihICe2MRbfp3SVENoWJaWQhy4TGrzaG+hL4XKHUK+29/guKKNr7yBX/t+Y7adCUgjM9l+0oKz0SVlwX/FpLl4LPEvtESi2xz/ZmNe022M6Yx6c1eGGGNehO2CuxDatrpCIGfJskNwXFsRGeHOrykbb3FGvlu9bnEPOW5dL/ZQHLXWMBZadmCMy419QDvxYlkdW54mguA3LrKzijdFUTV5QJ0FjFYf6cnw/JR45kWfTrsvpEe4kXctnaBTWsLxByWSHocT+88n8pPwEjm21fQLKn7HQGSFTmf95onlLbj/ZX1cqgkqgZemlgsvUGQBI7SyeTyCva5d9zAOt3mD6/r4eUF8G8Wzuq8WUyrhewBN6GMkXwuYwdjs6f3xpyh6XA5QC9RjLIiyNVkiAb5FXl+W5vrwR3+3os74G6+kwavwbmFDFX4VKBHc2Yxn3IkdJwfgd+RK0BHE+Z8+4X6sanTnCC6HB21GM2J0cZ5FwVgWv1pTq6tksLP7niSTbsLINC4q0YhulgI+7MwlG2juRiiQ/TogCX/YDlJ1xPObtbgYlDwYqbVNqCDKbxODLmlpGezO4U1dVMHxf+KV/eLYkZB9Ahnf+aFWaVj9VH00x0F0dicRrf4MF+1XZxntI8ufpjVIPPl0RXpB3DkhFP9/q19QQEbdM5cmJs8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pY7iXQ55SKXiGHaCfxPThPBeA8+TuaB3UrFJnMBxGsQp1xAEGY/UaI9TV8sx?=
 =?us-ascii?Q?j2q8wowz8S0uQ1OQeqRdBxIhlrCpUupl44Xg1wWM16mKAsfFRknUCk1gRV07?=
 =?us-ascii?Q?cCHSH71dh0Qd2VFRSobgymS0RtICQuDg70abbIriqK3lXyu33WI5XBcTtXQZ?=
 =?us-ascii?Q?PKOpP1eccWpd1C26TQ4fANsz+MMJeyUNinIsZ2yVThjLT7yH7rE6UxOuGNYG?=
 =?us-ascii?Q?NcfWNx4mnrDHEJrPtpXZWs4X3HlBNXlDAUfMkEGpLnFVvwVAzJ2IfDoK9ZbG?=
 =?us-ascii?Q?BQUpjD63KR9Y/5lKaSEyJgRcphC0E6zM4Tadg72uHRU5KghdqMEQ/HiaclPe?=
 =?us-ascii?Q?l7LgixSepqSTAAB7eD84bBXApPFVRoI2gaaiQhcGO6s610KlbaZq90le7L8h?=
 =?us-ascii?Q?iXvn81dtw/pGa84xeD6VgZKqGfvfPkPiO68/5osuSKxgPrr/nlSVWjO/G8Hm?=
 =?us-ascii?Q?Tb1r8zKRe0z9hstz9Df8lx5szDdHELjwJPvUjja3oN4Ops9AOy8AUy1IpYxU?=
 =?us-ascii?Q?5rJpcd8m3opnm6xDuV0wuw6CYSl3mod5BDQILh5w94Gkg2r77+he6+5vPZon?=
 =?us-ascii?Q?zb7Ak6mSiO/KN9A3Z0XkFyLnPlHZknYgymZM/buLQZKfsudYyc7UC/4wWMrR?=
 =?us-ascii?Q?X1pqwAheZEWRWgrxCmdp57Og/W/LJui3mg8LLYpFQ6HAVPXvjzYahxk+qsLC?=
 =?us-ascii?Q?ogYfaHKVzQNKGCej2NDUD9DQp5di+sYkU9zVUFjTk2Ogry4U3AO6pDv0XeQY?=
 =?us-ascii?Q?2SEetaFWanV2pzWg0hcVFrBPyXSXvxCHvkAWN73IvexNR1cjhi4ZUbe2jEvG?=
 =?us-ascii?Q?3g7urwdd8Cbq20KWSv9zxfQyxxjAvooC2aUaUKBvqBruG2ykaEX2CpvPoPnc?=
 =?us-ascii?Q?Bc2jJvoZXaehZzJFl4w87KS8Aaw4QLtUOYjgWK0I1V5oLUQ1Mx+nfWFC3Tr1?=
 =?us-ascii?Q?falFxZUN0yyDVWZymCTj8BEtFSOwpvObKSh040AXo02mhEsuwNOSlV93cU5d?=
 =?us-ascii?Q?tk5SF7mJ2v9BpslDrBV1yHtNY6us9271BSR658WngQSLSj8sTkYWSbwdCM8/?=
 =?us-ascii?Q?AK9D1Dmt/fk6P3CQpMxXICZULmU2EdiC8KE4eD5cgW7bj8KKx7tZaSAtdI0N?=
 =?us-ascii?Q?XV4+1kH4pa/bJOoY+QCT5J8nm+cpyWdTvoDBSpzu2SChunGyZvhcChEm4Ryh?=
 =?us-ascii?Q?8Mz13bkLFTGvAxGvTJ4C0iCs8YySfgbOnUURSEOa2HlqDtYFSCTMBswwrPUA?=
 =?us-ascii?Q?ecJqKKwYlRhTR7RDzYsxQADKT2JmOaFFtgJIxNdK0IgAlLcnN35p7qwh2Cyl?=
 =?us-ascii?Q?ZjiyB+b5SS+VxiiQprx6FM3d4H1SCxgmOi2V5lYo14y2FUVPZ9hzoqWB6KY7?=
 =?us-ascii?Q?cFN+WQZMtXe2iBi4d1XMkADmTStdSgm6YDNNnB5P5/RttV5N1BN0rz+flZJo?=
 =?us-ascii?Q?E8jhRlaBt/6Anae8LWGsHBlDLuoXXm1Osfmv6CD3IEIs5QpcvVzcK/MMW1nk?=
 =?us-ascii?Q?11jTB4HCZrgnEOQMnz8wcj+J+KuTCY0UVsOukwQlNLefQbnCVI/a91DiBvkM?=
 =?us-ascii?Q?ELZl+/IrkN/Nau7cWKVdYfss7ldnrrYZgDoGj0cbCGx4oFp9/tLBRExxtUUK?=
 =?us-ascii?Q?dcksvLTqQ6zKu2wiCKB6Dyj4tOSyNY23vlsHN0Kf0pkhfkMCG0RyXQ6OngQG?=
 =?us-ascii?Q?QrWxs2jYHC+m1I2yB5patTw2uI3slj0OuBZjXCtOAMv9qNuX8I14xDXmz+ni?=
 =?us-ascii?Q?FZXpCKmh4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444c33e5-1f10-41bd-e9e3-08de9ba94850
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:14:10.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iT6oiNFDli2orpVGR2r5IX3FJ9b3eO+JrtdFXkbcSTshd8P9PNFKeacbKFtS2YA6f6304bubJs/OTgB4fV9dRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      | 11 ++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  5 +++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 10 +++++++++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    | 22 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  5 +++++
 5 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
index 469de8b536b5..009990b2e559 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
@@ -78,6 +78,17 @@ pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcieb_ep: pcie-ep@5f010000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index bc62ae5ca812..39108a915f96 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -675,6 +675,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -691,6 +692,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &sai0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 011a89d85961..f706c86137c0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -810,6 +810,7 @@ &pciea {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pciea>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pciea>;
 	vpcie3v3aux-supply = <&reg_pciea>;
@@ -817,15 +818,24 @@ &pciea {
 	status = "okay";
 };
 
+&pciea_port0 {
+	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+};
+
 &pcieb {
 	phys = <&hsio_phy 1 PHY_TYPE_PCIE 1>;
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
+};
+
 &qm_pwm_lvds0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm_lvds0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
index f2c94cdb682b..2e4fbfe0ca16 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -41,6 +41,17 @@ pcie0: pciea: pcie@5f000000 {
 		power-domains = <&pd IMX_SC_R_PCIE_A>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pciea_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcie0_ep: pciea_ep: pcie-ep@5f000000 {
@@ -91,6 +102,17 @@ pcie1: pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	sata: sata@5f020000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 623169f7ddb5..489e174df4c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -730,6 +730,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -746,6 +747,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &scu_key {
 	status = "okay";
 };
-- 
2.37.1

