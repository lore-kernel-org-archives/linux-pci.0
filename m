Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE11D6195;
	Fri, 13 Mar 2026 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367707; cv=fail; b=WZTW+tnjeS2wjy74N0j0CCHZUcLOPiVIWJkkL31F7J8oy6u5tYGnPhwLUvRfG9z672+qDyhG0i0xqG6TTJKCqAUaZ1GZghQm2hUFD65BCTuxGSgVZjCioth9US0WsvFPUNurWY+vZuYF/blQE0s2sFo2gEi+8Jm03shY2CmsQ+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367707; c=relaxed/simple;
	bh=DcriXr+Z8ZbC7d00DxqdLzuiQjIj/ZT0nGz23NB1TZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUp17VdhhuPuJ25hnqSfsnWNSGbQJ3YsRJAhWg1YvQlBSg9DN1cAZIUW7JTZBkqvUJDF3JEhUIyEEhajVksn+GxEPMUtU65zwdXHWTX2P0zkimK8ZbJQ9y8ceasbMiyN9M7eHZKzhWOWcA1/1bRWV96uEma1PV60IRc7h0Q+rk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K+NggU0f; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K+NggU0f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF+GVSJ/hUFb0oZyOI/YHmPLf2RyneNnBxF3Eh7iYgSuk+QCiFzQDS8gp19p/gVShUzhlIii5s77PI+RzYWsUHbDJQB4c/s1HRAjwj7+D80zaaK8FXm6sL90SkvMIJ8p9IqYdN4YpyxXdQ96KQ0BeTycu9i2EYQVoBwBsmWU+ga6PMwI8HxifgpnwlDYUbF+Q2hhxkCanYx9QeJmL6zbjvdjRQ1lO+eAFKW5PLyqYz3mkTu8mIYCKCUIEUo+pzxmAJoW1MyRasTjnjjVcKsG/lLeioq2bcmABCVEnBvA1c6+M2irvGRPfVUOx73AMJfib6tqm1PCRGisuA0Ao8Pbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AIat2mzwx+LfeZBwOS7XTYabRfThSe+oGSHSCqNG5Y=;
 b=fawQn5+hKYdilmtYsZwAh7V1lN+Lm4U5fjplLcGGOUgWJAw+dg+XMp+n2+6AMaDzyd04YEIxwqhhrdXRpjJzczO2N9ZqArrFe4yl3S3AnbBMLKPbREcP7n4cfsouUHyJgqHoqBpHDFs4ZSh5y4oP5ycy87iZGpjPHRZAd2yYNEsEsPD5hpSnuet0fhXrqwahVRYQK+IMq7E10/SFgGfXCAsb3qwg9vI2UJ0n7YIQ7ZnXEXao7PRqYL/S1HhW6gpeDpAiUiQuaCClqfqrBAZ9dKlMcyRx1BsdY5Qo8FXK7YqWgyl7rN3ry2UM5De96Tj65VfG9aNUsBvrHuyrW1RX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AIat2mzwx+LfeZBwOS7XTYabRfThSe+oGSHSCqNG5Y=;
 b=K+NggU0fX/jOI/Cil/22v7qqE53DoeTV4EbBNRtx2jpmkwXNS8RHCbhngq0QNZWxA+bgC6PwkF6O70gTRxJJIKOtlniX+jsXWFQRs7iy7cLRaXitlUfSLRlYBjXCJ8hM8NrEyK4vyK01XKrddsiSqKARd6JkGqbNU8WdhphsB+Epv6meFxoDv1zEl/wh0KcFyK0dbRQZv21pPBIUaet9R5IqvyNoZASWTLLXK4lIltS6lE++H/p3FUzga5qqt/FufeBThKZnNJg5CA7CNUr1DTtIp2Nz/hu0mMPnf3idlq4AbHH/i1xb941s1HbHAzs53sp6/DwLoaJN/pjikvEKEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6844.eurprd04.prod.outlook.com
 (2603:10a6:10:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:08:09 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:08:22 +0000
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
Subject: [PATCH V8 06/13] arm: dts: imx6qdl: Add Root Port node and PERST property
Date: Fri, 13 Mar 2026 10:08:16 +0800
Message-Id: <20260313020823.1592389-7-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313020823.1592389-1-sherry.sun@nxp.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 18434e2d-a20b-40dd-77ba-08de80a56707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	d9wLNSWXI7J3iqTt9BUIMhP6ipdr7Aa0o0hddfSKNxozxZ9NK6LL3JhILsmnR2noMivvrJHUbNR7/IyndZ0up6vhPqB0lQFWgedb8sW/1VhnfSJnXvAxultcAk6VFENf1hdgq2IfkPX9NCRKVNwzVN0S+uSioBP2PBmfd9qnvqZFvun7UL5ZEAC1LrB4gbB+9tPkVOPA5LAxZvAeLRFomWoGAJBXU0JE3kmTvivg1F5OFn28tMWnPAhUYQ4HtWDzLZmtrsP/kXTptT4XfNrLRvKIgrkvymifszRHAV41/tVfZBPkZoGBxFxSc9PzUiU27CI/DeY9d4bXVOxOWOXdbAxVFr5RFMpDzNnt7BQd83HnnuwbDqfoiA1O2U4e/527PY0hgeoe8u2GMnpMNoX4zNEhlFpU9rZ8pydhcEDmh1/csYln7NiPM+595wewOaLscX4QVAv5jKeMKREr2Jh4Gf45a3jiR7cLY+jnQ9xx2LI3Q8Y+PRO/cdvMjW5pYTduhPomflJ7wIQze50Trjb+Jp3YeVUf4uuBdamWWcCHA9eVnxF7OHSIsCSUIwyhl5x4aoAPcW5lLhQnjrgaEhmJDwGlQkFzhq56T/55Gz5Zx7t8Iq5zj8+1zbzHdUk7r3YjGbQIb9m0Cps2g310ZZm4TpDTYOUvb68M00xaYyE3LUAoqF53/eUnkB6ujXRwhR7GjT/+FT7bXHWwyrXe2VoSXPLEF548mlLPN3HJJyZnNnFW7kEfgayrZi6W33X2ByDq6h9r7ed2Hw951U/usTgBwMc+U/pLs5rh3RmSlOAxnqxJoaxSzcPkX05qmlvFnXTH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?am0dLNcRkEoj+F72Y7dqS2T9HvXzwl6B7R85vW7/rwfzwXgR8GhAQCHxpDxR?=
 =?us-ascii?Q?uz2XTdUC4qIPXBLSEyLCB/nBpbSXPAwNOPmam25tgl/D36JzWkQlREUy2is4?=
 =?us-ascii?Q?xT/w8qOszoHe6ymdkgrnQ0oZ2rLO0IuoGIY0DuoCd9AO/1RV+DH3sjTGWuUO?=
 =?us-ascii?Q?NGYuytyl6Yn2+d8NgMylvkdsuTGexaQx1Pd0nJSmsCo+rFpmlh+f9lp68NDG?=
 =?us-ascii?Q?rjSJYjCEBF7qHhLbGf26nRTNZuCFXwTnBamGEICBnhErOfHP2xtLdDxj/Kct?=
 =?us-ascii?Q?4NxCtEbWX1d6u42WvnFY68PfVsQxMDbCPOjPr3SdZi64G33WwmKfX+q6ALQd?=
 =?us-ascii?Q?gQhJC/yGIp+ybjEGhVzNkoZNg8Dl0Fdz6qZjL2ZlHIcMru514K13nqQEVOcf?=
 =?us-ascii?Q?FnpzSK1uV60uJ/M+xiQXy02IvJfdf7fzoSk+/3ls4hq6++TL+53DNyfMqel5?=
 =?us-ascii?Q?3rZV4wvn6RSv+VHKs2AGjgjM/iOYuRCbFMvLCUnIBI/7Hdk0QpmZtAV768At?=
 =?us-ascii?Q?wm/PRpecOGvkTk7h5J6551RKXGpGg7tkJaGjMh6PWJhvQkn5eJEP3e3MHsTJ?=
 =?us-ascii?Q?7hg1+POnVDFDsfmfx2/EXSngn1XBtaggeD1a+2joOaqydqDa4sPHOU7szlqq?=
 =?us-ascii?Q?xTHedzngQ201QKMDPWje761ZxJZ/fn9S4Wdr6ith/EZfdkuKtaBBw2s4+Ehy?=
 =?us-ascii?Q?eHKeZwKbtgHueThbjXO6RO9e/Hu0iwoKdENTP8JiTLzO7lPVzd50/l5pXc3l?=
 =?us-ascii?Q?zo9lzevqOsBob/PNWm1qsOs3SNRskfEoTyod99jg+BLmY2yckqY1y2sZcvR6?=
 =?us-ascii?Q?yY8Niw5EZrNNO0YGMTnZXpolQyXHzsBDTB3Yqr1/zTILFJn93bqYI7KeQ/Tt?=
 =?us-ascii?Q?8jPFL70j3GsdpfV84bTsXw+mN0AO/UppbIVyfucdf5994CiE/ZRRffYLywxw?=
 =?us-ascii?Q?QJ25tbKFz2N8yBOJTyJghcBiv0xvcYKMEtm+jRkpc7xH+tSefXb1wuuQsPAf?=
 =?us-ascii?Q?NW07MMECLWv/DU7MAAmVVF89SkcLXxguSEN+QO/88d5Y0l/+8QLWci3XJBTr?=
 =?us-ascii?Q?OFQaFwc86+QQBg76+iFIWKlMLpAkKs8VoaCmEmjpRaZRAzMUlocl1SbvkGVW?=
 =?us-ascii?Q?U0r0zNSpgT+VKg7kYRNbSDKQg5MIo/CamWG8kk+K6s0PZm+TrN4j7RCftpMD?=
 =?us-ascii?Q?Rl3KKCwbhthtnJWE7LiGcEemKuA/l+tZbyXCQ3vlI9pk7G95pVcGNg9/50Sz?=
 =?us-ascii?Q?el2H+R9bNJKJQOJbD25isCXo9EcrMvmchOoGw/Zq+pfbm5GUGzxEVjyAPKeg?=
 =?us-ascii?Q?GrnkM4Q6OcPzvgVfyT43Q1vUaKyVgOmwrjgGzkmGnsASU7tXHI0bJqkjgGsu?=
 =?us-ascii?Q?pJ4LAhoBwXaQI6suFF9CtJW9L8fAd/KCGdBWyWcnLRiLhtkMnmb1tVwbTGmV?=
 =?us-ascii?Q?foF2+iNYBeFBgPx7+zs9H2MHATJkS8QTJsS9Q9BP7Sd6DidhHZI6byN0OFlw?=
 =?us-ascii?Q?kWrFSzPhppLX3z6f1W0PI7Vz1N9N3B2PvF+IoPjBz/FHUTCyvKtnvfFiYGrl?=
 =?us-ascii?Q?3r2nneZhActxdHCZ1LkI9ls4il6AeCcdS8yyuZODPZSo8pFXWVEYQOzhHZz5?=
 =?us-ascii?Q?stsnIKK9pKJZYJZ7WfQQhtwShS7PZCuZ5Z0ejlOSZl7b/RkW73mzfJScmBTR?=
 =?us-ascii?Q?+SlWN+XTJ4VwllA+Ls7N/hRz85FW0aNR1jZMuGXc1sxnvZL3vXglUEHpPpKJ?=
 =?us-ascii?Q?speYO9UG2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18434e2d-a20b-40dd-77ba-08de80a56707
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:08:22.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQDU8wnJca7aLnhQjaKexJWX0APmNgQneetTZCcO9ikppmy9tnBGQpPKEqTiGeW0Zl/xam3JTwO7JCDSlQtjVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
 arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index ba29720e3f72..fe9046c03ddd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -754,11 +754,16 @@ lvds0_out: endpoint {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index 4dc2c410cf61..9438862b9927 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -302,6 +302,17 @@ pcie: pcie@1ffc000 {
 				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
 			clock-names = "pcie", "pcie_bus", "pcie_phy";
 			status = "disabled";
+
+			pcie_port0: pcie@0 {
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
 
 		aips1: bus@2000000 { /* AIPS1 */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
index c5b220aeaefd..6b12cab7175f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
@@ -45,10 +45,15 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 };
 
 &pcie {
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&max7310_c 5 GPIO_ACTIVE_LOW>;
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.37.1

