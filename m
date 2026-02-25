Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74F7393DCC;
	Wed, 25 Feb 2026 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016928; cv=fail; b=CJUs+D1axdDjHCZEir2OgixUrdCN9o8VVd6qMQtzj1NFfHl+zu6Wx2E0QrOJz4k4FzAVYdpPslyefEsbzwiMCukoB/QqKzthOFcgwk+ymCxz2fa3PnzGEn0SqlVTCNom0/gIjm/jjNxbMJdgLm6MRFcQoenXSCMcW6is9HMCYss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016928; c=relaxed/simple;
	bh=JzAh4R/6Uc+iZaymM5PvLQQ9CaVnvghTAw3BGlqR0xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K5HmpToRL0XFLmtVIOr44lLi3N9U2DZ4r6NqE9aHaJTePdDn5ityYlilycmjBKp2RDrOf4Z9qwWnM5YEbwnZ6LSSuy3XIXxObhOjwiX+xumnF+E8rXtQug03bVaoKtwNPVLWNWI4dfXIX/NPQtPkepeFaD/Nibun/ueYVWbQFZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IQ7mqpxK; arc=fail smtp.client-ip=52.101.72.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IQ7mqpxK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSdQvxWu2hPub/ZFaMZOMC6yy7TZVKkN3Zf/9Phx3GLH4lVfIMDAcb3S8940FeSvGhHJY3A9FZUo5hQ6GqlEVr1/9F6RMPzCAdIF1LL7UtgLd31l1zscPfKBcR0Fo+5RzdUOYlvaPqoGQesLTch+72UkEq9oryKDz8URtQGvNw5XWSpF8d01xV749S00HXX/SZ6ZuUQM4GfYsRnMAU6zg+GzCL0nOX4JvkxFnvfI2SfiF3Aw7d5klWYR1oYnbmNJ+ttjM0EcOH/CozciaoKdnEqjk9dd+MNGHdPU3yvW0twg5wRQqinJUh3GhxaGfBRd3c3hk/2ALCw56ASsXYguXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f27SUcPc/7GNnkQnoPRzUdp6Y0/1ifunguGbldvZAMc=;
 b=IoJk0DYPGqEOd3kbpRaZVJCOqvX+bWLNKn/137wcyvSQZkWmnhbb6FVNKVNepdjZwUPVxubqvT+4SJZ1e/GaYnDEz0bPjhLOgyaRIn/mollBPqwMdamN7okattGeduRf0ldavK+m/Wy/CbBgF8YO3nDvyoYCWy4AaC0eQ92l5pdHhQKBF/ZCx3aLFi3aNMKlwIdx54MNP0ULMOPkhHrKPg6+qN/Gfi/Y3fth+1+lVMf36ZE7VDeU/7IWNzOk3gS0xHutefXVbx/kNM+td60olRxmJ/zFMwaTKvvJDirW1pXqXb6GLmkO3WId8yFqzyETn+49mFoa+8smD0ZnbflYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f27SUcPc/7GNnkQnoPRzUdp6Y0/1ifunguGbldvZAMc=;
 b=IQ7mqpxKZs1waGUY7bl+W2OFv5c7H0jTjyKsvNRw4C5Fqhw21HYLw4JBQBlHOy9J9CLSQeIK/Pa9HNwpYglmTREIgvz+kIf0g35Q/6bfpQYi6v1ETkj+XInAd0VXciB+sHGeMYzZbSU17QPmivSaqMyzYQuQb+Zs3mVwtpyLcFUK7mvrcJ1DFctj7VrCoNGUNkHdgKshdK83CMs/lANuU6Wv9SHvC8czb57L8HIbYlnHDxCUZqDsDvDTSFE/NdQnM11rZLMzW9yKHtWufc4WRs/WDBiZvrq9Hg6jBpLq0kSj1KVesJFG0nMni2ijdzTno7izkozDGVpLjfG3Ir0QrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB12224.eurprd04.prod.outlook.com
 (2603:10a6:102:561::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 10:55:22 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:55:22 +0000
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
Subject: [PATCH V6 11/12] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
Date: Wed, 25 Feb 2026 18:55:22 +0800
Message-Id: <20260225105523.748775-12-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB12224:EE_
X-MS-Office365-Filtering-Correlation-Id: 644ccd3d-27ad-420f-427e-08de745c5f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	ppBFe1O+OZ5bTos8hjQVC8VsVYTxOdsI1g5zaRYtGOTKjQE7bQFuRBXxmqqYs06TAXzkUHTBWMo/zgGg4780q8A9UEO4KJy3LPvprsmwRtXBpVF2wSj3wVhnNRfoP1khr9IYVZtPX1Cw/HZgmYhCuhth0YHkvHV/Mkl/KC7aXudXTqua1J0MvLCfC2INFOiEyv561TuXnelsky5JQYBbwe8swWabLaqKUAboEvhCMgm/eJb3jy6NClJSHrXHatYM0BK61awBXNhWLdi7+MSL3XQWh/9p6+7Fu8Hflm0HhUxzqHNSx73hyjdk4fDgPLo3e4XyR4Pe1LlWszFk/1WYj5jr0wqXelxVAF4ftZLj3tgMKqG0voYYNaEUF3HZ/GKsLGfL7++BrkRogua07LudueziC2DfM078T7qFbptL8VJdVhKlTyRXh895JfnHpp6FhUt8SVt+qrK4bMgEjV6Hom0uVxqQa296n7yxiKVFYb5OwpTujQ9Xc3Lcf3szczlab0L90qeOXN/rH+9/E5rOGjkplt8cBLH3yiM5cBXwuUWf0y+Gy0MDj8Ve6W6QBCAOEnrZAc3GgyWk5j2eyZiDa0hdtZVY0RzNknGJBdx0dsGGJxKBXaeUjPB7ES4ki5avtsDaSQnhLvbrIMhKY8hNVSLHjoNL4tZCSnWMWg00fVCYr1O24f8/RbR0ht34gkjWluHH8RAZkZv3nE/EYfOoApkNyo5KNDA2BWSo1NomgLsS2iHrKmrArOWBONyiJmU03kykQeHGPHAMA7smZXTqxvFsEHjoYjaIFVrOXyak1XhqEfVHg5yjltxoGm1KlsBS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ysUsQUkgypOBAa3KTGEN+UD2M7M2Sxyz7j9bNiPmDTqFJINUpm47hq0nqF6U?=
 =?us-ascii?Q?T6S8laDJ0h4HXTAVb+9WM8Lc+o0Sqx7SjDK4NTj3FAqOX9tfVqpwL79+nhPe?=
 =?us-ascii?Q?bkEso3jQr48FIoEqw+SptzX9D6TT31Q3o5yRAbpqUGWwG03jF7wIoTsrBRrk?=
 =?us-ascii?Q?J/THAtpRg5iJizPMf2eZWwsHSTX8GI3FY5rt+yunbBZ40Fzx0VdRB/utL5IU?=
 =?us-ascii?Q?mbOk/50DmCvosQpxWmE+185U000I+5DSuHhEeM+N1Sd8Fvbb4oC9mT3616WX?=
 =?us-ascii?Q?lgSxUYIIajlv0jl236zu7srx/PBissb3/CSJvucLZd9+k4pM/xbTzybfwZaZ?=
 =?us-ascii?Q?k4py+RDY0Bd/lprQyjv17DkPhbV0dqzlu4x7l3JvbkD76NGzBedbRbvNhCsI?=
 =?us-ascii?Q?EWzwZOYayla/VDO02l16+oKHYigdC3R21wCqNaBoEnhgeYTjRG5aF2MYXhzF?=
 =?us-ascii?Q?mOU4sHVja1g1dLFOV33N+ea4mrhUE0DWAoLI7QCRLutbf2hfh0NXwbxv179j?=
 =?us-ascii?Q?eOIJXtvEgMuhN5FppFSa6JkxEHeYslHsp/6Yj8pbobJpQk/+3nHtfLvbg3tZ?=
 =?us-ascii?Q?gfvBDQbpNzqHYE8n5Gn34cPGCkowbQFVa5xjgA9rw7a6dqbRXZpLO9NEkqc5?=
 =?us-ascii?Q?+q9G6m99DCUrWaGO0FvNhymON/l7MphRLDbNENbxPH0h2uZswtFgHq2IdD1s?=
 =?us-ascii?Q?LsbM/TwAu/ysBpV1gZ9gMLDk0hYlS0dETgEAjYP56Ll8zfIPHYTAr1XC56Tc?=
 =?us-ascii?Q?heYFb2Y4T0aUzD5xUsQ32KxZPTQWsFe23X3WK+fd8VqBVUZPMoXL06SVNa6f?=
 =?us-ascii?Q?lE3tpGDKtXWmog7SW0OzVMxsda8Xxn1KmOblpdesJotcrJe6MjwVPZDvhNkO?=
 =?us-ascii?Q?6PRcdP83PalImHdtO4eZkFKfHoVxRQ+QLWis5bcpYSF95Szrh5mCzQZpHSgc?=
 =?us-ascii?Q?Z2V/4m/PUM4m8vxBzqszQY7mqYhdZeNr10DVBuow1qACxwy2xvR3AWwQKoja?=
 =?us-ascii?Q?2YDNCYfmM2YSLXVNNGLP+srfkNQPIJJicg/AT5tln6/bKKwbsweWIFYbvSJw?=
 =?us-ascii?Q?EeIPtcQPFWfeE+a5GZYRLWawMNC9o0tCRsRNfv3YLkZDT2msBXD5S6/kc1Et?=
 =?us-ascii?Q?9nflCcUqCg2XrdhdBFfc01qgtT9D32ybO65yOVd3RmDydsr3Sei1pfBYrDH4?=
 =?us-ascii?Q?qfby5wzD1xj5ZtzPcB8OKqesqmoq7W3hp4B0pZzIpMqDmtXSEEBcZ4+ymzX8?=
 =?us-ascii?Q?B4Qc2S5iHVXgVLotaMvGFT0bSe5N0HvyJqkQ69WmzpHMNsM6Naq1S+83lhK4?=
 =?us-ascii?Q?1GpmH7eV5Xi3p6rIDXs3OZtIR108VXmxDaA7qSFeFECMp/GgDEdBWrz1UpUm?=
 =?us-ascii?Q?SuMTseimNhyhW7fmkDLJ6iZxnVZONcQm0+X8PItFNPFUhMRvaP9ZvCPWPQ3+?=
 =?us-ascii?Q?kS2pJ4cAGSjDntzD/kgyCHrXwcEFQTgsr+WDi7Uj7pmmEZIR0Qdg7HBU3WSn?=
 =?us-ascii?Q?UOJjgV/0FA/z+LkRwplX4EgYQJa+cwwAAdH/UCHGCnT6F2MqWR2G6Kt39iKz?=
 =?us-ascii?Q?eM2yGA4ypoLqaEkRrAMnj/EOJP1GHXrTN+yyY13Dm/nP18AgPCaAcGZp3P7e?=
 =?us-ascii?Q?XDCGOBJdDkWD3fvVRcnfsSxZ7//h71AD/XmmVm3Qo381+7sAEqvx3KT3g6Q6?=
 =?us-ascii?Q?OPY/ohnQYrTyivanx6z7MHQbLtE35DseLivljNdeDJHFevn+uOFGXGiXPZn8?=
 =?us-ascii?Q?hOcDYESN3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644ccd3d-27ad-420f-427e-08de745c5f58
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:55:22.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3N6hfAWEX/AcG5VD5hmfFVNTtbUn1y0m9Mh79A1Ym2a7ZOP79nUq4LOZT0jX7tVzSapI8iO40J6SnXrt0JIdhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB12224

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
index bd6e0aa27efe..48c29c2cfe8b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -40,6 +40,17 @@ pcie0: pciea: pcie@5f000000 {
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
@@ -90,6 +101,17 @@ pcie1: pcieb: pcie@5f010000 {
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

