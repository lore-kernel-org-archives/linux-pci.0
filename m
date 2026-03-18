Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013000.outbound.protection.outlook.com [52.101.83.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082636682C;
	Wed, 18 Mar 2026 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815374; cv=fail; b=U9mnw/jJZsVUycRbIsgznYp46H0vxvq8wDS7XpNjAJyrzu1jnsP4RamTa8Dt0XhjZKyeTQuy6aBnOxz7HZMTxerZUcOb+Uo8jEfc2q60l98fdGrgucvv7pTAzz6wQt4Bahhlpc1HEFMM9Jj7z4S9OjwIeimmcUD0KlGopB5FOT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815374; c=relaxed/simple;
	bh=lXPxyHTx3z6rbz5mIXWBmnOJcdOXlkWs0orjbI6LUb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HBB2ZGX3YoCLNsWkSfXC8ZZlk1r+BsKYzrNjJVODzD7bY7N83VOWeFkhhY/HcYwqZvWRD9N9vFQ5tVEU1yne/MJd9gBUzoumcIt+sJwa73ewpkH6QrKpR7WMs6NBkEGYQrr9oi6ShTN0FAa8n/DLpg9oTUXbaivjYoZ8jAWcP6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DEWI/sO/; arc=fail smtp.client-ip=52.101.83.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DEWI/sO/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hU45A7DtVBs41A9Ouu4G2DwmQJEvb5YspODgE94ysjX8ynRnc9apHKemiOI9Wo1krRXtdj2XesANwvT98OVDCM0r1WYCTy9G7nQz9Ve61cxoECwMqtQpas/Z7WCjd970HM2YK6vXfgBtmS0vd4c5dXIqaWBg+HiwUR2QEivPNwKh3PzkiNyk2XYmJW+7Y+QPC5gPivBDKdctj2/FZ2p/H4pwjdoozLQD25d9PGbLbQI0b58hVCxapZjYt+9P3N0wrQE5mdHTacISXnFOuz81SJkJ/acGAIKYqbD0/t7Uwa6pP/xdjaSkKgYmA0+Fd4uteHZC8HYnIxWrL0f8XPN8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCy24QXHvyxpiC6tC/9ukxRP+QZQp+WH2riOBrAV2nE=;
 b=AS0Tdz/FP60VpSfJDcI8d45DVTX0TzeCLo5zFQtuy0t1vGTuk7vM581wFwthxZwmzWvtTSynceEyMMypiYJcamf4QDXx1XtdfOxq0fluzFo4p3w76dcKCUWBgueJVAdmBo4YFYZW0EYYnMN378wZM27r3+J/ViDvsj8Iclc3AwE1L1/ba4ZpqWJT6kkgU3hxm6iHIBT1JnAhZD0D3kb97A9GCibmntSY0szWZiDx+Q4NqdekXWhAMymT/vhMzWByZL3kmLVtInDhBn0kvjbvemuG6heBQLUitdafbg7VeA7tMyw0dcFDHjSL5Ta55Ujuox7/QrteZ3SCmcst8WFvJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCy24QXHvyxpiC6tC/9ukxRP+QZQp+WH2riOBrAV2nE=;
 b=DEWI/sO/1C+MgnkWXb7eIjgH+mYzOPUIZgLtew11bEK95WVAuMdUT0+1Op7TuPnnttOcAscM5NKv8r6R0V/nNTy9wGJ4qqfByaXEk553q107OaPFOD3rrc94k1c++q1O3gbs9JwjgXmUkBGovziqL01c8A+JojE8xep6AGpvfbC8d4V6zfg9eLSBOH7TTSVpEg+RNLcYViJyHVF5n1OrK2yNFgQbGalEEvDp0WLVVPNCQx3/6/s7P5q5Gx3nozq878mj7S4VunBIConuMA7Da/WV6YiWTeo7hoYu9qKB5eQTUsjJXuC+yS28KxuIJRrk3LXqr20MyYo60Q4DCiw3Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB8021.eurprd04.prod.outlook.com
 (2603:10a6:20b:2a7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:29:30 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:29:30 +0000
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
Subject: [PATCH V9 12/13] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
Date: Wed, 18 Mar 2026 14:29:15 +0800
Message-Id: <20260318062916.2747472-13-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS8PR04MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fb8404-8955-4c50-adfb-08de84b7b60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2ZgIsy8Di/lOAxVRWDJA1sHGY1mzpyVcJh2nPCh4BI9IeC7zpEmw9lJvutwYXCthoUTz4etQnfN5TwjYUWnx34A/w78cIcNaWv5Kj/nhMb9NJGcysF/8nqoVWIZgYGf5TwO9sqLjgsDCLY8+ULRXXfcFjNP36zq/q3NM9zKOmrhDYvboQU4HQObjEyJ/EUHhnp6OVeDqSg8spTqliYG7rBoQ+H8vX5HPUzOdC016f9yVR+Tq7yV/iKf4Tlm2KO7dyZQ+h36vtVxtOc++7KtfdGBUpyYhwVrPv9GS5+B9PuUoGo7DSmrjqtHnqFOHpYgEMgIQDL/Ku8CaLznvzn1emz+RSCrhf9Zoc/FMXk89+0mApmtpj5UuMtWlYKHe5tTHIN+sLm/ep+9mBqraRJ7BCHWWF1KB4Nju/Uxn+ocTT81MmW03gAZHigfO7I4hQXe7hpo0bEPyelfSB1ew5hqMAFX59Ps9ydxrb4HuwJ2NfKTxiTVtY5u7Cqwe8/00L6Y/iuQ/8IXHZCWu2hH1083hZxs9pjF6VMdr+3NTUpwDWd5U9DrB38f7XTgI2Z2ATBQqHhCJqtJpIpI1S6IXxnbPdoTslb6POPQowAlIrp/BSIp3AgnFO/TFZyulC/1kn19bCWGFhg42wQFCwmW5LI/Ym/I8vvgb7AICLJiUs/bedCdRWMVSMJOPvD+81N73GBYykNZj4iKrviiFXMe6viD9UZZy631P1QuUlZXNeHu/6qhZMcvTzLkCXB59EsdKnNnDb5nHnYKyka1nQIW77RGjGy0Bh3OghBdR3APL/PsfFhd6PGJsXkwkkwHt1edsG/as
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(921020)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EKJQTzOPWagQH1rh2dbrKTT7F+kcOMdzJjzOodr/Z8u39aT3M/msV7IMe/ha?=
 =?us-ascii?Q?OlW8o1rY1BOktC8FEXJ9tHscmIRmS5q0pSL0PmRWIccZERb6uJk2lKKJGErY?=
 =?us-ascii?Q?ieyPQHe9i8uDe5WWB33RroXb3pSeOikk5j5mE2Ef1P2okhsjdH6gZ2ZwEE/v?=
 =?us-ascii?Q?zn5gqSq3oV5SUcpJVS/ESz99e/9/yP3GuWm2iMl0pvdsDBnX0F2yZrPHS1hB?=
 =?us-ascii?Q?wU3+mIT86Eqz2GD3DJ8M4vkJFb/Wa1ieY9zXV2cdRyGGe0n8p4lxmGT/EdI6?=
 =?us-ascii?Q?kCa+Zr6wKqcj7VJST7/WzePSWYv26jbpfBmfZGsmHbXLqbhVD0Exnfvb4QwM?=
 =?us-ascii?Q?iSkFcRK6qvBZH+CxYVRvMfFHvARd3Qf4fkm+PNZsGjfXve/auYJM21dXna/t?=
 =?us-ascii?Q?6Au2bXV4qaxxRSFwNlD34QarwVRxUEC4oal/LYqglNk9I2WCRaW2isaFrBC+?=
 =?us-ascii?Q?yiA2t9RWS582TttWgx6yttaA4Y3XRP362VO0gcBWki8EW0QSFM6vGSmmJtHc?=
 =?us-ascii?Q?gQhA10TWD19yIt36GOW+iHkp+PEhn3sA7qgiFywY3G1+Q4O92qHztO33C3GN?=
 =?us-ascii?Q?CuO3+8nuFNJRCWglwG4tJ9VNBA6bLBbDjRhZQZZpcvfeowT0jM1bpq5ymZTG?=
 =?us-ascii?Q?vJbeusGk3hCTPgR0raGLOj8Ll0+gPGRPEmPytqd/ILsI1agkb4eH0Uwe8wNC?=
 =?us-ascii?Q?ydF4UoXL2/XBzavWCbbQ+OboTjvo06TMFsjofI/sxCrbVsTYEuCMilwizuB0?=
 =?us-ascii?Q?StDF1LnCfUlmFDWYHRbYf7n0Kk39uV2d/HAwSSLQgVIlMDQ/PGZzXHfpPwF6?=
 =?us-ascii?Q?R9BXFbJVux020Ui2/DVadf7HN02LJrK44jX09qE3Jp/3C+hhqO+GiS2FNtnx?=
 =?us-ascii?Q?ofC915L1QeQ1eEf5F9ku480nPWRAzRAt8qUaxv00i5Qsk/pyOeDpAGaX8z0n?=
 =?us-ascii?Q?1kPF4LHhPEQMZBK3rVsc/tKTPNympvjc1qIuxVxSf+xnUd0tPk2XYhBR0z2c?=
 =?us-ascii?Q?gOUwzb5LSNdqP+qBF+wRhdy4kuiP0U9vQA1kcfZi+AWvm2ha0t3CC8hfZWe2?=
 =?us-ascii?Q?LahVHiXHiuWCufnHpSVsl0Gkbgeoxf2HDV3LtwAUlleXh1khr997sCmg+uvS?=
 =?us-ascii?Q?ltLztn2Mbgvs4zr3zKpi8rIDSZ/rGfTIZvcCwblwdINMxf0pM0E50iFdk0Jh?=
 =?us-ascii?Q?4z1U5fNr9z32qpZfC7b6AkE77jtPab3wt46Td80Zm8PCAUQQOnjGi/bLZbgc?=
 =?us-ascii?Q?4uaDHjevhKiwEf8Nya7sCkDGu40lz4ejVpr4sYCvzPF0l4tdsp+63JINPVqh?=
 =?us-ascii?Q?FiEUnjbMaokyAZU4tM2S5sjwZa+qVeTvleXQwjQW8gtKNWI0mhSxzArktmcm?=
 =?us-ascii?Q?Hap0y9NbzIAwxvmcUgYBclRbxkJEZkUoqQ4STZzCgKT3gds+7RQHqtBlJfVE?=
 =?us-ascii?Q?g9Ve9yTj8NfmkVFQD1TGeNI8ju5+imBR7U+oBSg+kSOXJRsMpHUn9Ncl0pCz?=
 =?us-ascii?Q?hmwOTV7mpemNVuXNkuwAUHMqmBjWdMrtAb4BkGedrwfxpmUyXMJDTHz+wtcx?=
 =?us-ascii?Q?a9OjDv+RvKYptjd4Tr6TyL1ZPrVAwHc5IMiK5wnDPZJkvrYcdn3+NL2a2UY0?=
 =?us-ascii?Q?D9a16EXjiLBh/d5HzPRMye7p/RmyhQWnqdQ2XF9xPivdfWU5rsDPON6inirN?=
 =?us-ascii?Q?3XYeSaVMMzsYuXhtMbe1u28GJZ1t/2BvxlZnxXu53RnmzD2tONBKVafonwX2?=
 =?us-ascii?Q?BFjzqwcMpg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fb8404-8955-4c50-adfb-08de84b7b60e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:29:30.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLnhFHoV8SIaVtU4Djflt04K1gpLFHIj+5l1dYRZlPH/6pDl467cQDpaB2l3tlXLCrdwZeZnqNXGVdc+RS785A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8021

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
index 5c68d33e19f2..8f2c2bd00cde 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -651,6 +651,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -667,6 +668,10 @@ &pcie0_ep {
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
index dadc136aec6e..02f7589bd860 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -802,6 +802,7 @@ &pciea {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pciea>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pciea>;
 	vpcie3v3aux-supply = <&reg_pciea>;
@@ -809,15 +810,24 @@ &pciea {
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
index 40a0bc9f4e84..cd127d0a0a75 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -722,6 +722,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -738,6 +739,10 @@ &pcie0_ep {
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

