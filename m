Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F88D2C0F6C;
	Fri, 10 Apr 2026 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788246; cv=fail; b=BWZ0U0A5DoBYp5wN3LA1CubBecldFKjB+WNOyBEu6LndmvPYTnu5CIJRuDQ8p7b80I6iL+ISMvtUdPISfTjTOgUhKcV2cxI/xW0R3O0e/MY0i2f6maOBgVn/mzXWFqIO5tQmoy0LgIj4kQP+/T1Yvs4cVIcQenU/VCT7BOxIz1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788246; c=relaxed/simple;
	bh=bhd7sdPMyTLTMWxUSfuz2/r3EYJn8I2Uwi0UkbpZwCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VB7zOWs0etTcPIKovl2V4WwkpMbDXOLq9NFzbbA/CsSQlAges8Uv0IvLbo1bLEYfHKkcXB1mVmrnXPwmRvsUUuWV4QBFnFMhSMGgTmbYoujtPuIRX8yK4XBo/fkKWyjot7b26TMOaex+qBQADu5WfePaW0UhC8c7zraQtpGT5OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PU4oq5uN; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PU4oq5uN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUMrewS/8fe8EbwnZFfl2kzeyUPlDD+s8cNxbnqw5/2SdaopFCmFwmwEckb2w2DVN5kB1qsf68Xz6wJv1pZXPSUKv4Ki2sQCElU04mXRsrrgw5LEMKfK0PGm3rgL1U/w+JVvnaaZI9ZH0FBvUU232DeTNz/aKdB9suTZWmiKqiTcaV5RJKsDhCfn1naeOecvCZiuMNBLUmFZKifrLfr1KFMXfe2zKPznOLakZwZP47n7/IdzS1zdH+6uTx+VcAM4GYmGRJ/NdCxQNYXOdUSKs1/jD0nVKIAsphWgly0QzFr2d+54nDAMEHB1Agmd6vg11JbfLTucWrz9qa59PnqUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar1VoCQOfqxRn9JTafCIhUPdpnR3eh4akKNpCkBDLIQ=;
 b=eJsdUF+liTEUzVX+M7/hqMZHZqvNlnAHeYOa4UjTFKToU/cQHnhRgoWYQYP9kmrwQIPo9lqweDUhRFNtwJ7ZVqF4rf8dETubXM/BD7krTy2Xe2qhovyuBK/RXawRrSJStk/2mwLhBUvXunIG6ECf4rbSK3lZfHqAhafr0BwAel3OveKW3IALbgxXf6E384ONMJ/xGWk7f+I2BgpiLpZfhufpvRQ5cnHpX4o6kvHbhzjwxTKaImFq2HylHGIE6RlLe5bao8E1uBZMvMCzaoVB6pn0wo6YB1OdqpvKAbgQ+6RAal3INgXjFMOzcmiO6xDB6eR79sCqgFdTMH8cPHgyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar1VoCQOfqxRn9JTafCIhUPdpnR3eh4akKNpCkBDLIQ=;
 b=PU4oq5uNJ7NFHcBorbrpH7NZugFo5iXwK94SDwdH0YgjBizji33Lc3s2aA2uz6jUOowOVRJCpu5u794w9QEzGPBOm6hK/FBCPmkHXX3jebanR0K3yYxrM4mj9O9a/Yr64MLg/sUoNQmQ4nBXxSFKP85dVkJvPJ0ac7WUkHhN1+hSTvioSpkK/kV03DFMERFAwpMXXYyPM52XbVAfTVO6KuFIIzwhQyfPj/DujzhsNIlUp1SUE/Dn+ogpRTIHGJBYLDVq/XDz1rxDxnkBZZE6cv5H4pcdyq4IirC/d1Ul4DdBbQjwVFIjuIptlasqIuY2XTRtQECdHaFForXgH026Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB9826.eurprd04.prod.outlook.com
 (2603:10a6:20b:673::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 02:30:41 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 02:30:41 +0000
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
Subject: [PATCH V12 11/12] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
Date: Fri, 10 Apr 2026 10:30:54 +0800
Message-Id: <20260410023055.2439146-12-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6b040e9d-d81d-460c-f773-08de96a928e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lDOF0on8Z8ovMQox9iAWmNgbn8ayGX5tQoPFOnSYa774TNh/IVmFZZh9K6tBE36FFL1B5QvhBM6vWiRkChWRSzdpsRQowd95k08OMH8siFjL1L3ioG5odvBsq7nDTSVU3101t4wi/A/sPctBDywATRYt2K7b0m6whz7Gb5TXVYur4bKt8mw8cen5Mjbg85lDoziPSH6xaRR1aqYbGxDlYxpdFB4dVDAe5XlyLr8a0eJTCLLrdAWHbBrENidMFo6l1P/VEeN1nsF6lS1FmToktLwkveE/nyyaqyJdWWBnl1cdoXaVxvGV30EvEGQAxHUeL6yeL/PfraECmbOtEiCR1Kx3kLV7+h+3qCwIPwX8pO4GC7i4c0O59bDvv9OcXr5jml8D6cwHf3S8vdwXsGMyPYzYGVehzk7ljrVsjYfUuEkFxfrJlr6SO2c4yTIIYwULZIEYSW2nbgn8mZLPo0Q9awmwvYiNbmr44X2bi66BHiCbArc570Yqwq8H2TULqhkbcUkhE4x19j0eIFWwjpc4shw31ryfHpnBs/Izb8p+u5/RZY8kov4H+p/nR+ZmDMoFrESMZLffNXx8XpQpBYe+PTViMNpO+/aXThvgx+w6gl8dmIIE5fIB8HjJDTaWFyES7ZSZNmvSnqLYJb3gFnVGlbX0Kg6jWAOXtdYdYkic/GNMsNXfeDqMJ+5aqFyq3xonj5JRdUUk6ezZB1T5oxF5N4SnEIgG9GlDwsZ81qm3VZyV9gsD8eVP2W9x0EwFbv56SYBZw910yElbYLQ+7vz2J2RGsCz5hBKIBKTEVaifcyN5cLrUmXI9SLS+E0JxnlU3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fAv8LmbinlB+nU5eDQ3NO916JMplW6rxXJxnhPF0WFkSR+GNj3IyrQnj/2vF?=
 =?us-ascii?Q?v4gA0xItXgS2DslAAFbH7F41MZe8pkdOGVjrrSCjRB3xoUiAqJQeh+O28L+g?=
 =?us-ascii?Q?Ner0RzXz2kwDQbXbu/NWhgCbwudAL1WwoTPsiuYyrgQD8siBpql7HZBw6tzg?=
 =?us-ascii?Q?Li2hLd5Ab4bUE2d/Qlf2unkoCwAIgZTN7aWUdOP/Y/+W7tNSXxjmdtcjNg0v?=
 =?us-ascii?Q?MWkYaPU1bI//kI0p+Cmd2W1FtJkDRiCDYO9YyrQMtUaSC78rL9awO42cNdQR?=
 =?us-ascii?Q?/3IdXcsOrbKm3Mf4GMhCHrvg4bTkjZdST9143SqZO/nsA6V2TQy/ByuF1XRV?=
 =?us-ascii?Q?iBJN+MTOwaQ+0jruePDIghgbhf13+1s+qV1X8Jcs+RyNs/XyHmu1Qd+ChPaZ?=
 =?us-ascii?Q?q5qN3QQx2Nsr3vG1pD3z6gght+hoj6vBquaV7xHLz+lQwphN3q9od0wa4EZC?=
 =?us-ascii?Q?nkDMJMyJZMHvb3s4F3x7jsrxmZjd2Ii3/x/xegpBPn6JTfrEzgy4IRkn6ZLo?=
 =?us-ascii?Q?UNUbPGQpQHYfm9QowyYaV2HPkfL/P2zHUdUqhOj2yutdcUTXCepq2H4v+w0l?=
 =?us-ascii?Q?f3R09p5h47t7YfGqp6wxlYqm2kxB4UPR7lnQoyeoTad31WINZ44hS/KSE8uk?=
 =?us-ascii?Q?MFL0vcYkAC0catxIySCcHzf9gOfa0dgAR21RQY/wVYoUNJVE0IEzyzn97PI7?=
 =?us-ascii?Q?8yAGfHC/ASddpWAiOhhoZPCFVuSbD48mh/NF5XMA6qRkH/4kOSSJRLWcJqyK?=
 =?us-ascii?Q?NA40wPwye2a22mDr75+iY1bs3i0ldkYLHFZJFm+yClKoujz3++UXDfycZkm8?=
 =?us-ascii?Q?IdFN3M1UuRMkhQFYdfCAi2OaOd+mS9i01cwO++Cti3J6PTjd07SQMkDqU6aB?=
 =?us-ascii?Q?UPnXZnj4qVORzRcwcwMkj25jSmsbIkSKbkz9zZYU03rTB1oQ9akkucz5x4FV?=
 =?us-ascii?Q?b+SocHVFXwzpVwL0OzyCQ1avkb8CLyGF7yEuJO629+FZlJauAxmFhBu61l9i?=
 =?us-ascii?Q?/SrT5L7mSJ///2NcpXXPCsWcx2rrNZNrqUDQi83lnf1jYnFlaTT0dfzcaJoE?=
 =?us-ascii?Q?rXoiF4uLgMuoEVqdT3M7AhYtjlKVfWWkwDkiroW1dWMcWjAAfannNNa9O5bR?=
 =?us-ascii?Q?pygzOspJkupxdrqBOXg24Jf5pG+LI0fpyzNo2uM2OFpJs+TYmON22ApQIfKS?=
 =?us-ascii?Q?O0Ij+XRu6qcuUGd/prhIdU0Ssh4OPbu1QtUhXLQDV6GbfYguLsgYwUhGR4Xy?=
 =?us-ascii?Q?Wz1+Ko1/sIKQ6SA2q/T5R5ec76doG1RpFETEPemkMDPLK4U5YlqthsvE4e3e?=
 =?us-ascii?Q?8kDwDLlExjTJkfJvwPogT3MbBjXPa6bf7aOk2maLdLzvD9a61s+TcYhjRva9?=
 =?us-ascii?Q?WdTIPIC9W8QK332OWaNxvIjacHx4hLS9IA1tjxs/wMIKYZcXDPWOhAQm2YRZ?=
 =?us-ascii?Q?/luopr6CBVWqQaM75l3hKqpK4MSYvyzR9OlRk1WKHYtWRV9Kdu9pcgyPNTeN?=
 =?us-ascii?Q?VivSPdz/9dl137AX1YHlqDpwAgPyoV5sz0ampHTHUR8shdtyNxSzBSJbTTAx?=
 =?us-ascii?Q?tSs+7fvcWcOjvfT6Q/eNvQ4p5IIZ1bL7vigc5JyCwy6Z4ohUBRT/fhaEJk6b?=
 =?us-ascii?Q?DnjtSyBUEE+qesOK6aATv0iD/Tkaw477ar0QQvwParp1aKrtn0I2xaAPffBh?=
 =?us-ascii?Q?ElgVC2W2Jut7B4/uJkFpCNQgJ29FnUVR4UPmdzrFIVOA1NJeianZ5kRKcshn?=
 =?us-ascii?Q?yta6SEKmmw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b040e9d-d81d-460c-f773-08de96a928e0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 02:30:41.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUI3nDwlEJSWnohQbhbYsqwc0gd9j0xm6nPZ+9yk7hscZL1oGXLq79td2W/FS/80/vdNfKpcXH5dtPoCdBpqnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

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

