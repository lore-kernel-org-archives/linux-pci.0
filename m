Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010007.outbound.protection.outlook.com [52.101.69.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0893AD51C;
	Tue,  7 Apr 2026 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558577; cv=fail; b=KO2IcPFuyqbG5N/8tsC7K0k0dAS/AQW6FEHC6F+n2piqjhDeYtz8sG60rbgkvoVYlH7HowBbS9gYWuc363C+JFtEMqGmrMk8k8JBwpcNkKZtlipZCEHTlP2NPEspUmy9Tws2szuvnQpoRwmJJ3Yp8fwvKiwrtA1+KQ2KiPOHy/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558577; c=relaxed/simple;
	bh=bhd7sdPMyTLTMWxUSfuz2/r3EYJn8I2Uwi0UkbpZwCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SZaKh89VUjh6zj0N3Z+7npZVNkSE/3STLVZz5RFKH7ubertHpnjTRDJXS2TARdPA2EtiYojo1SQ4z617bmcuDFK7OQcSMIKfhz1SsLVqIc+Lxx5ylbE+fPKYndYGglOIv1BupIlswjmhXKnKNqtU/jN9M6tz/n77IER4Xq2RstM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aNlPQ+xZ; arc=fail smtp.client-ip=52.101.69.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aNlPQ+xZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLpapisCQBKcqYzlFVq7kh9yOpNls0cp1VYiVjf+058lX0nulHkhmDCLIQvak37qAnGFxd9E5plCB6xvzw/DTjiNyD0VxtwmlhMcax38np9bfeNP4mo5T8tV94tvRYjZotM17AlzjQKitf3kFNcgknJdMRXToKReoohPrmQdYJb14aADTQWcPWgmZVhI1iyACrdgs56tuKdqkt4kt/rpGo3jx7ppH63kXMtbopeHQu3V2mpOdWpvY9JXm1RA5eK46n8VocYv0HEgQpN+bQ7xpfViDt9elUsxYn1APU/HOVw7n3h+nl2MutaAAyAAISFTuJfUs72HqLNxicBRDrJZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar1VoCQOfqxRn9JTafCIhUPdpnR3eh4akKNpCkBDLIQ=;
 b=mgJtsl1g7h4adRb6VSM5gNSaRfFJrL52vokcAsW2GlFpRJMwY0OF44Dg190nrXQx7Wv3/6bkE9c+/8VA1uws70xdI7pmGSzM3aBH01eptOfe/IZ22qDtWcyJvxM+8Zqks+RYuSkVOjabTjP5t/OfKBtFGSXs5f82CobwZQ2RkeFYvqHl8gJkCWbPwnf51vm+k+0GsbtgdhoBuGtHKhD0DrqH1hwM7FZnaWATPs230BeCnbBDxnVU87vxrnxnM4X3YUBvoCNK4mYsqFoJ+wq6bRqbgdZxfSi6BaI6ojGsrU5qX3BTx6/0Ef3p6xT5/q5LjElggJdQPQcHgV8F/JlEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar1VoCQOfqxRn9JTafCIhUPdpnR3eh4akKNpCkBDLIQ=;
 b=aNlPQ+xZsRqU5SfolUUyEAmBECGy3fxvdQ8ttZyTw036+TjAfddnwMkukwvETAGz11oIWxZc7gawXF7yL+zVF32X9czMvUNvI+q0zkuCUO4mnh6X1OEMGKn69SnDZVF6TbHuSBdulQe+7VeU+OB65D7IGjAA/0DJYF/zYqR66EQHDL2DAAZnaezHCqZDJltd8OHKwRMn9aLFX5wO8CeMN6psy1AeNyiEZahzW2Jm81Q8TOrZuK5YVjstt/IAlmvVMMxmXbcrIrQAVyP2mJ9UlaK0PVtJB9ioIBWf/eUUinLVpyXoIqdNaS7kG0LBhb0clYlV5ul8IjQ25jsHW6KyAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB8281.eurprd04.prod.outlook.com
 (2603:10a6:10:25f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:42:53 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:42:52 +0000
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
Subject: [PATCH V11 11/12] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
Date: Tue,  7 Apr 2026 18:41:53 +0800
Message-Id: <20260407104154.2842132-12-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260407104154.2842132-1-sherry.sun@nxp.com>
References: <20260407104154.2842132-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0060.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f43e39-cdec-4a28-017d-08de94926b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/oYENoicdoKWL5ZBVMwe2mb/bB+8dRRxWCOzxyhhiAu0YCZQN8scQ1TPgHJaPz0B3+wjDznbsyaYZsKZ2S9SRyA2yXA6tQ2b1huEPq/27oEWnvEaIRhG8J8Oz40itd+TOhOYbzXkb6Rm4mSuYsWJxOTgwjpU52OH30ESdKNnLbSnxWJETRNx5jXkbzKXSwb8W00RIKhHPN8k2X0GDl1v4Sv5vxEKYTczDLYSkIuaj2ifP1mS/D6n8NFBHdGJ6KryAnzCYu/qv5+Byd76Jrt1XSh+DriwXYzt7GsqFr7bTlxn8UsqF69BPstoglxXKisRX/Tg0UkC6Z/7cwQi0T9Thh1SoiAXO8qqdaa/dBAU8nSEm4V2QgYE3NvTeWYkAhVKmJ4b19tRDSjls0qoeSgTZjeT85+EBmLW4FvfYSUfMvDHeDh27MQgV2n8sCiBjtcuTF8ExIE4qgX9PB2YxJPuALdwsWhR6bItS7x6uaN3I1aeq9gk2lt/+oIisVVty09l8+ZyJg6ze/G8dTS4syjcmPBYLq40w3zKkhq4m1WhQKu7Az4NbPx+COXS3Dgtx9u17t8VKc/jAi2kPomXpmy6M9BfTEOWm9fptcH77ZnGhM01IcLsdCv4D+4pCevPXZYMZJEDB8R4zV2QSTOhPL88Re1GJ1HLS8lLhZVpOlHqRyVGwQdmdXJRD/TkPU4dtgVq+UP/UwsTDLTfTZTrHxPwSjk0Fx1SUGvvNya6E2MsQK+RM1iqlUvmQAvtK/EH9U4bbvvbAcbxnemHiJkGA29dTr+svNIqUVVhohKphGAtNyfXkK2bOBtLzZ9XrsT5NiRm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FVJq9Y7CNfpF1f86zoPa3gPBLoMQxnfaCTzbhVsYwZIDmdccyLnRkgbCm/CC?=
 =?us-ascii?Q?DlWjcFMAEVf38R9qL9Zq2hM0dXfVhNWGYv/3k/94oh/hTIF9Xqj5WSFLii2F?=
 =?us-ascii?Q?FjEZ0hxEcuMNqc2mJfpmWCeHCGHz9tkH8NBEuej5Hr8XQv5bDmbIODeNihf2?=
 =?us-ascii?Q?rhIit5Q7TbXS2I83u2xsCvfBO+RJ0KzbcrRHoZnxI8ek09h7O+fqXjSbU/nW?=
 =?us-ascii?Q?B6HdFpggCF9oRFDRe0/LGnk/7feD+oD7v9E3X6uxDMzjQ38Giix+/Qr8Bh4/?=
 =?us-ascii?Q?HMc3URAy792H7aJd0qbOiYXc+qzTjb7yx1BnTPmlvT4ECjBucs3UeegXs2N7?=
 =?us-ascii?Q?x1VxGLUs2cLiG4ApG6kdjjhlpeFOmIje4FXCKF2AEl/SMuEv6V+i0Mqtk1HT?=
 =?us-ascii?Q?RiyMNaueuJaDRxIGj8+8DXhiutgTWc119/qGfLMTU2S39xyxFwXIQ03YCUAn?=
 =?us-ascii?Q?IRIdq5fLLmF6JfiBkbJj5s7JJbxxuIPu1/8cq8SoS/mIl2L/4xUKq8cbSRzI?=
 =?us-ascii?Q?y1Jvpddv7cRFO3NKdbbAhSUKDjRNbZHU2B5E33hZTH6MCEUOvqbiJUFnexqB?=
 =?us-ascii?Q?qvXaPxmROYGZ883ocbPamesbMtvuQnNvwga9PmyM2jK8XI9cXc7uhxmtR4qr?=
 =?us-ascii?Q?3Gcb/9i0H6B1RRrB6aZL74hWSfojZa5fK+H2DFK79pKX+xQ7RKuXlSSOUQt5?=
 =?us-ascii?Q?dLzTPetogaKTr46EpUZdfIyvCD3PZJcEaUl9FpTD+pzS8g5bX8EqVz/QokwE?=
 =?us-ascii?Q?wflrhz/I/fvlZEoTxndBSLJfwl39YiCjNNighpbH3vNJ7vH1He0RLTRAl4w1?=
 =?us-ascii?Q?E4GXkgRPKjaYyTodK/Ze5R0n73axMe+egB/+OqGJJXIQQDhpnDchhyDn353G?=
 =?us-ascii?Q?qn/jShbiTiOafkkFD1StPAw+kg9ltvhs/9BWpZTwEl8c4xrY7hd9wm0Xc94L?=
 =?us-ascii?Q?j5pN6JJwN3bgxqcZT4/ehfdmaParbQ0zBDnwBqLB8jUnRw9IFKGvQsNr4IdY?=
 =?us-ascii?Q?+FwkKL1YxQnjAvj+Xuik3NXfiIw0B7Qeob1eyJdRygrHakpXeiPMqjIfWtV6?=
 =?us-ascii?Q?yEtB4yGBu0JDNjBRxo6KEN2kY6PQ4txUa77kEaA32tHKMnARL0skrpeOV0ac?=
 =?us-ascii?Q?BmRN3dGRarf4Aw2Fdj4jvUhZ/mz0XcHSXgF47l7gKSkR+m3/bWZILvUSRdsm?=
 =?us-ascii?Q?nf8m0314XSvaxKACauYIfkYFSW7nTZiPLldLp6L6EW/ZI9f3vYaBXrZyPvlP?=
 =?us-ascii?Q?L7b93Lnq0EQonOP+LYboRo1VWbF1cVGZinNBhmhvS5Dya1at5HInKfm9FeAY?=
 =?us-ascii?Q?hINFYkFubSnFXy/hnCHkanVtz7fWTP/dyCc97Wl+xEsIZbKxbxq3sa0py92X?=
 =?us-ascii?Q?wiUxwt+Ck34SY1ta7UihC6QWRsN5x1vGx2k3RJ7RVv2ADw76gVuMD1PXpOJ8?=
 =?us-ascii?Q?6D90qB4hM2Dy2b3OzaYwUI3AVdm8ycQq6tMGrregPu70noeCJteLkrjlnDip?=
 =?us-ascii?Q?3Lmpm5qFPnN5fSKjTKcSzJVMqtbGOycvMLiwIqA6hK36VwtGAAPGgKfGIB4/?=
 =?us-ascii?Q?jlh58P0qHGdbRKKSkRT1X/evaHOsjZaOOiy4p3e7FiPfbC55SDlcRfPDxoAa?=
 =?us-ascii?Q?wh8N6ytCq998QYFWZPYFGSDFBRU+tho0quByIbgMNehslp5iAMHe2GM/vr1F?=
 =?us-ascii?Q?KUdLbWGyASv3yClj+gH2t59IB4UFvVrL3BYWtvU1AlDoRiD2ePazYq4Xk8Z5?=
 =?us-ascii?Q?MTFGJ1CkVQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f43e39-cdec-4a28-017d-08de94926b97
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:42:52.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BU1mhXRbHBOzRMo5Dn4XjaWRPoYBOLR/35dxmlpvLfP6qqJbWx65eiWzl6Wv7QA3StD2WW24xKgsuvA5XKfCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

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

