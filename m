Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6BD3E9C0C;
	Thu, 18 Jun 2026 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777380; cv=fail; b=rHQKHsq2PLPNW0+en/V95YlVGzyYjqJ8/6F5cTWlGLxZoLJVWZUeQkdA0y2zzTOi80lWLyotUxAJgQyb0/ap6czP5Rn8PAMwsZZVjBwkRWom31yKFxQ8WJ8TeneB/br830+71hnKP2WyTIYgSLmi+zjc3y3U7hOHPR3iBnTK6jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777380; c=relaxed/simple;
	bh=4XFpOLFuFxSrTe0CA7DxhWcTgiLlt0UnSAsiDvvJbXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M8y2BvPZs1UuOQJjx1BDFR9ybkQ6ljCya1olleDMKPjw1CGJzxGv4hZmhLb41Ld8vQ1viqTgtxsMbxZiNbGfh8edg8lJIQRvpdRSjpktZHNNwwUki2uxHuMtDouAKKp/3z1u0dJWCuA025Rl2FTKn5TjNLW4YK5zsHevl/U2Zdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=W97NBnyf; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W97NBnyf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1KcbnQfHoYTgi67TD7KLqpd71XBlovndvz/ISKCPd8oRchRODDPxXnRr8bwSLRGh4eLafohEp2PzVyiLgxQmNUbpmkKdjhTL1/rnw2gQM550CAxIlRMGtMf9rm6KsCNI8U/XesjzljEZEEZokRWWf4DeTc4Da55tpnHlSgkEdDs7D5cMPNqthefxGCK6hCfvnvSvkdLKrMUHsrkXJg/yrpe0+9axIkwyPuuBV8Wq/6BmuMJZ/FC4Z9rmiKKI2jly0iAkFHM7i3fHttXI7sNuh7eAZZiTGMU9hT5LhVcalCrY6AR5E+cE0v+9Rrw/iwgQM7Q0l8Kfx6l3SpBDAbJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61QUgbKSikJteyhJQG6IV4XJF3plIflBHfLqvpbTvK8=;
 b=Tmdztefzg0hdKX6X7LBIExVqtPRQRb8fYTfP+LkjkJkO4VZLVvljCqtb86Sg7uRS02YHYpADruX6kwszjOJhRu3i3xC7MDzopdmhr+Y+f+vxeKvXhBW+JCdQEPyXsy69xeaShD/IAUGA/gRutSa4n2qV2c7gl6eAlpO+I04lDwzL9j2c2ICMBcDnxTIDjO+FnTXrpoOfSR2VEdGAHD6I22Ml1rH9GkMffNJEg4h0cSr2ahOY2n4tQ+A393DqjeuSX75I9zun/G/W9a1sew1TIePqF8vUI6XF1zQ7huiPtq72S7I8mSzUog6m+g+knFzZq5TB4pL/1Sf6tIq2cJDbzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61QUgbKSikJteyhJQG6IV4XJF3plIflBHfLqvpbTvK8=;
 b=W97NBnyf2vs7kpZ1Nc0FWTPZ74NBmQ8mAtQZ8pYVezDRCOiFHSCidqGHPQntPSxaSAcehJrfJHCC7HniG1M+UvPR4f7m+oWwWIl477lG8kr/gdYp+bc8JADfvpAs26cov4dX+3rfUc6q3is5BlfBYZ3wPz/Z4I0T2Ype1bA/FAIBu/Pde8QUhJgUgark94ieyojqpzkuQITIJhaF6tU/S2eCSRy0G3d+R/sFwBWRopzLP4/vofudtI1riendJdDGuh9Cwah5hSTR14T0rKwwBKGDFG/l3FKP3jCFiNSF2uLMQ12Wh+ReW4rFxE9+zRSuwe7nUiTxc52ZcoNLVEpQ9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by PA1PR04MB10818.eurprd04.prod.outlook.com (2603:10a6:102:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 10:09:29 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 10:09:29 +0000
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
Subject: [PATCH 5/8] arm64: dts: imx95-19x19-evk: Describe the PCIe M.2 Key E connector
Date: Thu, 18 Jun 2026 18:10:44 +0800
Message-ID: <20260618101047.4185497-6-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0162.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::17) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|PA1PR04MB10818:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3fdc94-d093-4c27-4525-08decd21aefe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|19092799006|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	o/s6wb/1vu5JWa2zOfMYPQOd7BEvr2QCs1k7jJm0YDDqnhngYP7k2PZji3B6l78tb4XY5Nu86nXnQW5emzCEZIC8xp/fOgunUw3dZaFEKIgdnEZoyHgPQFWemYQAZMZu0Q0XF1RlM25dXKN4IGZLcdQn01AKTv9zIflg/k8urm+YRYSQxoEQsEDYl978cwaM8mTReYHe2NDI/MtTIcYkeiVeyNSgxtWOomeBpt75EDRkai7MApAJxJyMPoPwwtoCOMDXsbxRH5AgCxkvVwc/uFgyNFrgPd/lg95KgrdSAiXjogsex+XC4kObW+BlpprQPTXaJHcWaD9sqMYRlx9SOiFXUzt7ZxJHosWy+eNnHULW1LGo+Doq8InQh+n54J7PSynr+u3ZJozZxMMVFzT+FCJXHNOGHw79pPRS+Wv+cmD+LFydNMgUD5LFn8EZ8CTkRPacAWjQKcoxRm8XLeHJb9on4GJaOg4/BQm8uXpgTVIUSOR+XcHEAXgBjZVvO189steTJS5zX5fwMyOGN8RBlHH6YDynbiW2Zpa5gNJ3PtBazceGB/a6weG1jbo1BuyQ7WNEhhtlYny64jRo9wsox34dlPH4wYt6S4BS+tmN9z+E6WQQmA8M5wqJbWb0gGSR1Kjbj3rjgDdMXc7umv4XXhlGs60XS4Z01HtcXkhYbsDxFdVbdGgv4VldVy0hHeIUY5mgkrxE7wfPNl8jO14khfJhQQQ3yCdM/Vz921ZagkY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(19092799006)(11063799006)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jy41g+LOqY/KUGVx4h2nJ7lVEparR/ZWN8V64uwmZaVHuLIk3nBvyLGwLf4x?=
 =?us-ascii?Q?Vl3oogGjpLHUts6/B8tmJ5J/5Ftf5ERKcKFLXPQqR09g/d8i6tIDIwjy9ZwK?=
 =?us-ascii?Q?oslmCsOvgVsdFMBy9Kgf59aeBvBf0pCWJTUSdEg7Wc51+q/dZ6F0KmMAhPDV?=
 =?us-ascii?Q?pO2TG140TT3IdVJsPchg/wrh23BrEuUpmo5U6SyGopHThiKZaqoL0iniuu5O?=
 =?us-ascii?Q?TDLCYQBhslTK4/flrq1lojeWaLS68PR+nV43boxlQ+VBDG/X4BE3R8lr6mlE?=
 =?us-ascii?Q?SNHNkmW6CHecZ6uGhL+eQcIApLYpUDVN3DOXMphKsseSy55CBeZPwjWtcsOQ?=
 =?us-ascii?Q?aY135gKqM1UMXGd+YELB0bOqNZBm9HzIKPIsMBx2T7892da9xwlatU09q4uF?=
 =?us-ascii?Q?NjC/UKSPmbbbXTaBj8xia080u/KdH5fcqOdUdOh5BbYvAFsc3swXPLxZZTDH?=
 =?us-ascii?Q?osaw4MPy8obj68roogEaTyWqvC1NPGuCVrugKgiaMSemP7f77dTPzdaTyE+R?=
 =?us-ascii?Q?Lpgckv2xjvz6ctyvNx2mjz2V1mzRj/suFKjsR/frCcLvwi562cud9l/ODtH5?=
 =?us-ascii?Q?8WIN4QqD1si3b+ki1U6qVWFZ2emGzLFGGRessh81jJwxgSTCilxez5/KTbK+?=
 =?us-ascii?Q?AoFUclyBAVRByAiqDrr+UTxHRqKLuhdBV/n70UPOgyRA7viI4uGbPICdfSPt?=
 =?us-ascii?Q?46HIf9oA0r0O/NirakqAk6P0Yrpnshmsn2EtKgR2E9mS5DjYu+09i5q3KwTw?=
 =?us-ascii?Q?y7dRJ98TbLEiAH3mkoxaeRzayPXjUKOyGg0V/LBqF1kgppDpFmWVdrd3qEIp?=
 =?us-ascii?Q?r1Wha9VzXOs1OPm43o/UV577KKru+kHoJktfPJEy9QFDpLMCezlPjTS2H0ry?=
 =?us-ascii?Q?usClU+N5BxqTj2yDVuub6P4mtCmo66ENCpUaLrQoNMiSrRx38wpVBhGtSazh?=
 =?us-ascii?Q?ldcCB3jmPvi0yzxPkQ54tHgouKHEjLCLqayz8T6GMfC88T9kWGkgwpI9vUkQ?=
 =?us-ascii?Q?CMkUihNcbnbVgJVbZzMFgIcDc2CzsTYeVN633uxdYhCTR77Y/+TIIGd29e+P?=
 =?us-ascii?Q?fGy8i4o8ODCsLyslfZkcKb51Igg8raKx9pDXSTo/NPmUHbFo903aI4tNGvw2?=
 =?us-ascii?Q?3Je8DIzqBxMq+IjtaNfTLhGZMaq4jCZhMmrC574fgmTupx59wYd0lhS4t5fM?=
 =?us-ascii?Q?ndAltfrPjQu7tRkCB6n2MFUfhv7EYEtngH2tooWJim+rKtyVS9/i5PetJKnW?=
 =?us-ascii?Q?1PT/gknWfJNQ/W8udCCWGivFUSCWXccO1kgZbk4I+qk8kuIJ+JnUoieQH63R?=
 =?us-ascii?Q?MGV6ocr11r6zCEDY3pmeBPKmuMiW58zIdBseb2DKhSuDsL1RDOrtYS/JbOBl?=
 =?us-ascii?Q?/Bs4kjfA0ALkkEkBguGnjQDaSCuHQfcu0L2/UpV8n3BrAJzplkLlUPourEYR?=
 =?us-ascii?Q?A7FSHY0YB/ZsoPmycWRv1yQY0dx0ORQTCumzHLKXM8mwbDqtYAinKEA9ZFh2?=
 =?us-ascii?Q?5pAfbBG3SGwxbMIordyCEsuEhiJVE2umOqZs6XuPYNj063pvgkTlX3zq8tjx?=
 =?us-ascii?Q?UMRbpdPmbTN1iH3SMHh+rap8PIhbJbJgSKr01CnhymTYZ3U2LbjN/sxBtGA2?=
 =?us-ascii?Q?quEKs2iXYVJwVi86Jp5PTOW33V2D6Pa14k7AMn6YnsEpOLzd3UklooNBO+d4?=
 =?us-ascii?Q?uE9qu3HrMk5HfLwBCd4KtaoJC+AEcIQ6vAG+xwzdoudBmvxIAC709iz54HY6?=
 =?us-ascii?Q?Rh92KG4vpcG7NTkiSJ0dVUNkB9iHlnMbYudNmTeOHwOtT3ATkRW7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3fdc94-d093-4c27-4525-08decd21aefe
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:09:28.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8e81zAKcE+bEZ54M1SGXlTwTiq5+04y6ARZO0rJW5rk+zrRCCIyQq0H/Pytas71HlwnD0zk/RfOZw6pIjjc7PkUc5YkNq6BVl3YQhe919qn+s7z+1P/ieLb160u7yOS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10818

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

