Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643AE30E0E4;
	Fri, 26 Jun 2026 02:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782441068; cv=fail; b=o+TNwcnNSttPvU0E4ftlLJqx0WKN+QN/3AltEM8tYU+/Ua1kssQ6ppZ/vZvEFocrdMbjnR1SjPPxPbNLJzCTAIL632PhkIp96/8O52gGnkIi0OoGxGf4lAAxs61xaQAtL6oO/4vt1oE4kFwxUrxFDz+4FEFs2vTFxI7fHEaTlu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782441068; c=relaxed/simple;
	bh=4XFpOLFuFxSrTe0CA7DxhWcTgiLlt0UnSAsiDvvJbXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NrwjkQqLdyT7hzzSqJ74dxOw+RvJ9W7phYCyILF1ZCD42qrMNfaN/JRZ45Be2kYiMSbORFVw0Ni9Cjlv7jqUzlTh0XJGwXq9Z8EJszAds1NYKiqtkbsBdEpmV8+J2zZGZ8MXnwr6rFzDZOBnaOFMvWMG2OFtr7qGsxnyrz4npkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DRQM3Pt1; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DRQM3Pt1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2Mzv1brOWOdg/Whw9xmQODdpV7dW5+/UtOoa24tQHXy9uUN8uJ5y2iLW7/N5fd4onmHRMAhfd9cfMaF6Up6s9fSflo/8p0O5TOoBWGa88FOKqcUPx5ZYnA13zVHbfg0gNhv1ASZb3DN4B6zO7YHFAdkml8jJWcCQdEzlv89ickj4RrQDYAqInivQFP7Vfrw2tgIDsQqypd9YUrvF0IIEj/5GWM6G1qtpTBWj41/BEVQ+3SFKzyFdjB/9YjgWFfHWoYQF8wtenWdIfhmMdlyYqQBW6pxmuWIiVf/sDac0NMPGlMnP6blhAnW3+tJIFRVuenW5Ynl0kT+Ef8t405SFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61QUgbKSikJteyhJQG6IV4XJF3plIflBHfLqvpbTvK8=;
 b=iu32r/dtqS+sfCa0FPyadttyRLvzbqyvHKutpnyVAzPefyGvgMV/pLlW/sAviR9Orm+n7ptofnvgZEf5apCxxqgsmB4SE8tPAimvQi0MqeRrGXnFJq7tlQlpvYinXu2bUr9Km84LJR6jS67tGZ+nZkO34+B13QKh4XvRjrCrqUeYU5FePh3XCPIkQNiRT7hvDu64GWb4VUMECZzm+hdCHUTexB/5jY1z7+5kv7+mxB/q5kHpHWnWVh56dMLAM95JXNq8v1rrkPs/PMhfLAYegPPAnLPiGztlkgeX5gVi+H4ZYoDlQRF4Gp3Ryohi9hz5lW8nFojTaloUxTTG/9qkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61QUgbKSikJteyhJQG6IV4XJF3plIflBHfLqvpbTvK8=;
 b=DRQM3Pt10Q3fS3FL3n9L+P279w1PbZ9oLxxD01rEPqz9xbtb8ORWCdkCiJ8QbWRWQsloYGEQGPx5EErW7kcDzGg2sbY7BoG3N87wzZxkqt6TcT0Go6cWld/GlShJTouQSUP7+/Ng11FLmp07eGq/i1sdDWaxD67gLFVGJGcWFac8OAS61sLCzTb21euZ2K2jeqQsNRDUx4Npb1HGF76iZV1rccdeJXaBmGf7rGTkb5jh9b3KFavTsvaegWyJT26klHUuwUqFtDsZ2+FoWn4Wyl5x/h7aM0hX9aa6qNDEm8UiFmNKd5lujTsgXrRvhQuGN0HFHKcgB8jiOYgdZmnf3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 02:31:01 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 02:31:01 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	brgl@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V3 5/8] arm64: dts: imx95-19x19-evk: Describe the PCIe M.2 Key E connector
Date: Fri, 26 Jun 2026 10:31:23 +0800
Message-ID: <20260626023126.2189931-6-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
References: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: d6aa2e0c-d99e-4fb1-4290-08ded32af680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|19092799006|366016|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	BUp0tm9n01W/qwclN9u94Z71F7qGcnRx2krtVKNBjiyjiBMpY8PDAMP6bYAEaGOWppNXZUGtRr/AbrbWXojFWVpmlnnJ2Qv/a5GhOEL3mhKZI3p0oXKsljGYKIUnaJjtN+g6Hc19yUoyTZyD09lHxa9lXPj7gHM2eykEMNZIbaXFtAntN+cNzFUat59HPg59w1IGKP8ZtlyyuFZwcLg3AEyfOLXsgj5gn+OQrxIXBLsAnxqiaX1RGUQIhvEszCj7HHSWK5PBQTC1Wi+h6jEQc2S98jyvjwJXqIqaD+RpxJ1XsjyGKKt9xn4Blt40CmjN0WE+KlzTpOBav3qaScCMojxUmp/tu6D8qoSmEzQBYg5toy6IzD3zHk9LaiWFxv9pXZ++obPSF6XGGbJza2Kf3yhygYLSsEuu74iIi6A6u9GIbQcqcWa316pPb8eNIgEwuqvM8R8BhRAtLrWAB6m4cpn/kIDm9TqyALFj4ZCoQKuGBli/PCKHi7cy6xFfWQAlOzmvqJcN5UtB3hA8nZXltt9fda+3WRRkvBMOx7i9Twm7ZTGohTOw1di8hBU2l7BnjwqVfthmPIEgENux6xbHQCsWgNkSXNbQzej4jpYfCMe1kaSnqmqh/7mMF3wZeYSfT7WF15vv/dVxR9SRLJHhWCPcx27y022N1n35FyrFBJNGO3zYLHixMe0CghOPS4fZHTr1rwJvke1YurR2tUMWDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N2328VrQMaYaduKQ+Bqs79RphUK1Fuz10IahZYHTA7A/4WHYyt+8QZKHcTeK?=
 =?us-ascii?Q?k/dw4eCH/DfmpKYL6yqO1bbo/4RKAfe98ilU2ysqYDR2sotXebEK2Qtd+m0R?=
 =?us-ascii?Q?FKwH1gRWg46Q1o4HsJXoZPmhFXlbPDa9m1ulSJ9Lhxw+bhRFU9rp2fJmn2b1?=
 =?us-ascii?Q?G5vI4KIllVpd1nijqUk7MJ+TTUIhFe9jJGRMgWEmTGD4t8mFVb7QgqIlTlM8?=
 =?us-ascii?Q?YXNfam0ZlYAs81cBkbEv2V7TbvdufcGhv5VMGI7W55icsoLDmifECYI29loG?=
 =?us-ascii?Q?BvSz15g2/MbcehGhmoEABUktS5l7K1h3RussMdXt2CsDgcn9N42joqv3+f3y?=
 =?us-ascii?Q?denimr6w+iaGl5rENFt7dDwGW2OJgiItj9O9KOiOfvwIlrKXIbFjPhNbSY68?=
 =?us-ascii?Q?NyybDjHV6YAu1FOA0bPijZfeKWcI/iuEhRgiL+NCNX0lsFG0LlSCB5UvyBWz?=
 =?us-ascii?Q?uePJB5hNXRDkl6/pVLRcV+R+XNdXDILOzWWcs+IhiAwFYiohHuoy/mEQ1iJi?=
 =?us-ascii?Q?P21OOK5eK4JIMAiVuzQWtLddFG2TlEwxhEQr00GMFamkhXsxaxZO9Q7vQHVM?=
 =?us-ascii?Q?q8Y6hdJB8u2LlKBr8623A3h29kuyS0JL1sB5B6nCGzEzAFTcv0CFVDPr6H+a?=
 =?us-ascii?Q?8LIqXelZwJ4UiFLjlGbwyFI8ngV0wt/3wOmt1mImSgEDooy8MqJKGpLNWK3e?=
 =?us-ascii?Q?T8Exh0Cw8Pr88laROFgxMJ7c2Bi/7oDeEpbv4KUe8+00nn5U/Ao7whcMgkYE?=
 =?us-ascii?Q?C2KQFj7IO35E+y9Mv58raWpL79+Pw1Yn6hrTFdsEVkx2rcDV3OmrOilSPPN7?=
 =?us-ascii?Q?fxda34sFGqfs/WIflwyubCrlToY+1CNZYNBUIQBHIwMLPTTPvzkZIFgmzZe1?=
 =?us-ascii?Q?LWtENURgBE7RAgslu6ijPp0bUkJdY3U+fNhWgNul3IiNTiufPvwH3isBX92I?=
 =?us-ascii?Q?uDBdKkfDdrc/rhrjALwtR7ucJ8mj0EEymLAOFgPbUbEaCDA3jzua7u6QAlQW?=
 =?us-ascii?Q?vA7IA2mUtqJduucTOh3oI8iLEI8rzgg4ibLFQPdwXj3bdwqdfFGPProA481l?=
 =?us-ascii?Q?OhDS3V4KaxrvG7vZA0OlDnx9mbtAFvqDsutfMkoh3XWHa2NwhC5aiGhTWvIZ?=
 =?us-ascii?Q?Gq/DjntkUm/2T2SSovH9grqjUEE8gAuap5smKurIOXxQX5XKZNdZjwdzjDmf?=
 =?us-ascii?Q?I0yblYeSRLPS02huDPV6CE+T4fMyWGBJ/ydBtufZEE8aS4KiB7BatBFutQe5?=
 =?us-ascii?Q?VkSLiYIwv34B2vPWj05S0XR9fT/RrqrcXHcufLpFNcHG1I1Olf9VAuNEOjoQ?=
 =?us-ascii?Q?n13GS1AbfkVAc2fd36zy4uFdGReOtJ/yaQW5W/LamDSQEpHQAANf+awkJohZ?=
 =?us-ascii?Q?k2juw7LuZKZDaobAizXtfXI83r4IxiJj4+CVmrVG5nMZOPK6xn1rZtyNf7AP?=
 =?us-ascii?Q?2m/BszXCEbMR8yMnnmHpw0GOWIAXLejvGCM8WoT94au+kPn+sUcjcmkEEMqC?=
 =?us-ascii?Q?OHvlEjAok8t6sfdeq1JPOIWuWRUXrUfB6eWzzaho9yNW+0WlNBNLptDw+Ocw?=
 =?us-ascii?Q?LYH8qArvgioH6wiMn3e0t2SCIEgAO3lL2v0Ho3atnawC4k6v1gn/uuNikHus?=
 =?us-ascii?Q?B1qQVMG3xlEgYgrl5+6G8u3RvmzCCyuudmSBrUzb0q+v/y5tTuJzPZGcvxEJ?=
 =?us-ascii?Q?cZTYrzzc+4Sv4sHGXd1EROCO5s3FMwl23dyxGBsx9eyJ5FBTI/O3yOffWTrV?=
 =?us-ascii?Q?3eE5NtUJBaHMJE89eyCT5+SEfh9SqCilaJcqnHhFsvOcTErfsphM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6aa2e0c-d99e-4fb1-4290-08ded32af680
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 02:31:01.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxbr8gbZ/p8l+LnNoWAESzU6cNjCWtNEZz6p6APiE488W2yrnXxUgbCPjdJbGMjY0HFFz8Zudi/B9hAYe+m3vMzYnh/AH3aEDLQHGUOuzNdSMUql72ooKcn33odJ74Xm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445

From: Sherry Sun <sherry.sun@nxp.com>

The i.MX95-19x19-EVK has the PCIe M.2 Mechanical Key E connector to
connect wireless connectivity cards over PCIe and UART interfaces. Hence,
describe the connector node and link it with the PCIe 0 Root Port and
LPUART5 nodes through graph port/endpoint.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 55 ++++++++++++++-----
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index c08731dfb1ee..d2c0345f0d61 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -57,6 +57,37 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
 
+	m2-connector {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&reg_m2_pwr>;
+		w-disable1-gpios = <&i2c7_pcal6524 6 GPIO_ACTIVE_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+				m2_e_pcie_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pcie0_port0_ep>;
+				};
+			};
+
+			port@3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+				m2_e_uart_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&lpuart5_ep>;
+				};
+			};
+		};
+	};
+
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
 		#cooling-cells = <2>;
@@ -145,16 +176,6 @@ reg_m2_pwr: regulator-m2-pwr {
 		startup-delay-us = <5000>;
 	};
 
-	reg_pcie0: regulator-pcie {
-		compatible = "regulator-fixed";
-		regulator-name = "PCIE_WLAN_EN";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&reg_m2_pwr>;
-		gpio = <&i2c7_pcal6524 6 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_slot_pwr: regulator-slot-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "PCIe slot-power";
@@ -477,8 +498,10 @@ &lpuart5 {
 	pinctrl-0 = <&pinctrl_uart5>;
 	status = "okay";
 
-	bluetooth {
-		compatible = "nxp,88w8987-bt";
+	port {
+		lpuart5_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
 	};
 };
 
@@ -555,8 +578,12 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie0>;
-	vpcie3v3aux-supply = <&reg_pcie0>;
+
+	port {
+		pcie0_port0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
 };
 
 &pcie1 {
-- 
2.50.1

