Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35829B79B;
	Tue, 23 Jun 2026 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183961; cv=fail; b=JjdIqOJsEMV/Wq9nR2iEIGatuaC5GqNjaobYoYnMqM82JISFCzP3fxq+A2s3sr4T0VIxLxpy63Fv+ikZ03lc+K6c0NMsGiipIUaV9SBDsEA2Gnzk9LF6fxQgYlgVNTrDsgb3PdxhE9/wVZkcBvB6X3SNXviwNKAfj40UBLq1XC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183961; c=relaxed/simple;
	bh=x6E2UBc1Wr0f+S+3Gfl8t4FdwuG8wJl2j0CMh1yF0Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ga98000TAN+XzAQ+RTKjMxqI8/Gp7LXHnVW2fqzTV0O3+Vy/A6/HlTeFsxe1TmrzPd7TmwUT/GF58NYjfWnS0On3tvGVl7XpGU4K7Y6uoVTLTtvYOPV8vlyuS9AVHCcWMU9cB8yw57dLuLhRlzHSIHV8LsmXeqzTu1vFkdcntcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qTmC4aOc; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qTmC4aOc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c++xEXM56U9r1iPxWthI69slkdhmfYIpnSDlcagRGl0iEj6CWzFsCJjr1+zmDrjSb8Tkb2uUG3XmLBHjJuVGCZPaGTTjrVJdbpVipbYBeO/6aIMHJWE6RMpk6AG3M3PVmWzPYE1V+IagWPBd1F5sg0/UjrO1LN0CViuePMaW/P8FJIBcE2yvlN1eIGCs9jFxl1+JTqg1qAEWXox+MokxGtwPeXBecihSLUp52UkfyClcQyS/J+sa/pXKoZkBHL8zO1uFoQ99CUox2Z3QjsXLMp4w6j59psGTE/VptGxGAROBkRA4Dm/uk+LsAjlc6r4RlutgNH8dyyXygMaVrGX8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khbBAqF0X6yEhA27tOY5BT9dAoL+hAJc/LaqySVfBwA=;
 b=rNMYDASYDCm2Q+psSo3BdgQiOjY3O4kW9VeGSvtT5A0B2T0q0ZjGc1pUH4Y5zqD9FenmXSHmg5EyXJw1srs0JB7pwTED1bJfhYoFi9Yq8Wb2h9cb7vCrEZBeASsf8hPVUBrwvScubVuonANvNm6QlKCR3Z0fHXjx6GgCtTpi7I0GBwnhLi4gYN/eXvmqXGAvZmQ1+xh9ApKDXI/m4Cku1/dXaE69VaWqvE8+GE2J2OMuvFWEhsJTiywilVkBguynHFbEoDexCxWHDOkepYKztTLRcIoRFce/5btR620GZ3cLoVIQxkHipBwi0d7m3dto06zdZPliTDDBcaMM7BL/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khbBAqF0X6yEhA27tOY5BT9dAoL+hAJc/LaqySVfBwA=;
 b=qTmC4aOcMGYaMPjysN4JzAJggftzjXN2D1kwXCWXlcDDJCJHGOw/YRl4fSlWadcX2MnZBmy3WivrM1SfXGdMCpRRTkXFBV/YrGJ8m5AsWwGxQ9hfbiKqSdxL5rRwV9uwYCIpgQd0hNSsFTbQmjhkGybQg7fOLeDwZutT/rq4UXewOEsSZKRyaRMXqjMbMBJ5Cz1NQzmokpAcxiCZ+S3zrsicJUXkA7nNjzDDX2TBHb3/v2nrrFxekC9rFUr46Q97J0YlMmeOyYlomZs72jRFOVaY2IGeHBTO0/+vxB/7LzCmHyoRb0TmDGb13aK+sgTTbDg8Dc7VwKZKPVarRU6OQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI0PR04MB12188.eurprd04.prod.outlook.com (2603:10a6:800:332::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:05:57 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:05:57 +0000
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
Subject: [PATCH V2 6/8] arm64: dts: imx8dxl-evk: Describe the PCIe M.2 Key E connector
Date: Tue, 23 Jun 2026 11:07:33 +0800
Message-ID: <20260623030736.1421537-7-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
References: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI0PR04MB12188:EE_
X-MS-Office365-Filtering-Correlation-Id: 5badcb71-67d0-41c1-5e24-08ded0d4589b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	uKstN6z4zk85ss/CRSkaZ9nuTBPDnbQtOAI1d+2b3OKuWutMZ/AHpAirHFdZBAkrWW8AgRt04FBT2U5YUPl24sl9PfmGN7h29P0ZwwxBSxk2hDqVPxYe/LQDkm4I8PHxMW/gm5wn1QJDEGUnPyDJ/oQRUNZCPpky1SuRStBqdeD1aRaChwkXn56sfjid9Zk6vIRZo3tMTRPh6DEHHAoUeICLdK3eaSe/rHV9pPDQXhHkIklGqPUBsgOIBRM4dDKyDiYHNxbso1AVQ5jrxAaVchwY8L7vIuf7vxZVeZdEPJD58x6Mo65OQieQWWfj6AqG2NpmmzIdONP2XocapaA8jHOfWIwHYYlk3UVLhbsVCwq4vtM7eWVT6u+pmLt1iw3bqfB+XGS81BoerCQAQSlSQ8NE2c9Hs0BNn97eN4twpFrHKWzjS8c/7Zaoh4x/j5B0eakceT7qTXQSupcztfz0zcITEwt3IixU/4PZKTl3ApqWa8To5Jt/ucvxsMgc9ZkQW0A1kXVv6AKSh6vpT0vVQ3zHP39Am0a+Yq+beDOIY4N0VwHuhhYX5MEyE9pjJiQJxnihDuro/LISW6X3xSdSHd2sJZYsmgPpHPz7bpiYXW7s48Plu4CeX9TsE89XlE/zQ3f9xjLNbdfh8imgvtqkfmGGxPARDeYxy1vLzQRNzkG3QzU7Qhtd4teU60Lc5H7G1jCFr3KrDrVaeUjV7FYkNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WlY6OjEjbz1b2KFQqc5648wv01xG+LMsJAG5lCoMelaNppehE8uAnHV78UcL?=
 =?us-ascii?Q?qyStdfhhZbBRs5GpEv+YgeVH/9bB4ABgX1jwl6SxoOY4gc4clIXOg//578bj?=
 =?us-ascii?Q?jvyu//+9FQ5udGBLDPFzaFwrlqxC0jCH9jsVfWwXJW1HhDsFf1+5jXg5Ac8Z?=
 =?us-ascii?Q?Gfph28oUw7VXAuRj2ybEpBFMhtJQmL0BUQzYs8IckDcGMmQnwm1pJ4hMU7uP?=
 =?us-ascii?Q?OliTvKVPSsGY6nccLql9OFMDZXhiNtS0qEDTOoEnE1WEk1dy5MHtlUXvYh8c?=
 =?us-ascii?Q?/0mXisWY2hEUMDnvhaPQBneHyRppLhVDMRumM2ChDzfH8ObBBVTc0i9Jjp80?=
 =?us-ascii?Q?mtZrjmjLE8oaRXZ1ZPVB+zy6HKsrlI51B12/6P+fxjCJzxpHHPOxUopginwT?=
 =?us-ascii?Q?63JU6BxCj5IE1p0sfdt+D6LCREdCJsjjo/1/HcGqPxS2WzUifsKfsgTSUDgN?=
 =?us-ascii?Q?k4PQdmKxCEgyIWYh6f85UP+YMBdTCcewC0YlxdQRVreqVR5KJLGLUuc6/Avr?=
 =?us-ascii?Q?niCkWrARuz/I3qiUdgkhFbJ7k9kniPmT4jCuwqqX/japANz/pWbsEC4R4iyX?=
 =?us-ascii?Q?05LA2tu1PzSZYUJLqV9o5gBaudBcrIf8vMwqTKMdGN7IR1H+bUh+rqlYO84W?=
 =?us-ascii?Q?gAjyu+3iEfWn3cY3dECwffzTdWiAOXN4dGlNVAYsDkP+xCEqZTHsB1bsFMEz?=
 =?us-ascii?Q?HGrVB/L3j3AtR2aUNSwe4Mcev+Tbh4CmS9f9ySLnsra20sxrsZhZb6MDrej2?=
 =?us-ascii?Q?vcePRQ5PGj7qfTfMBtZv5xurpWqRHkQtTDXlBIHE33SdNoXQmqilR73ndumU?=
 =?us-ascii?Q?Wzc6+nTfJ1rDOZV48BhgYVnCiR6Cl4I06H46EksIr/u3pN2rf6wotKmhN6xT?=
 =?us-ascii?Q?O/6whThiZf8h/Rp5jBDkB119SEpqyhI0GrQsk3ALW7TDyproOJTfnpBOhK+Y?=
 =?us-ascii?Q?W0xUrYPPbHE9//aUJ++9KMiOrRD2hdCpwuPOpIjpKjAGN9a9a5FNj6JvanYm?=
 =?us-ascii?Q?L/JrEJet3bWMMavrsRK/ki6aHNXD7XVh2866DgZ8nk1U2P/Of91UUVPQygLu?=
 =?us-ascii?Q?0eUyTEW+cxGtYz8HCFv74E4tZgRgs0jR5L5HnRdcWSWCnXi0rGZmn9ZH8RvY?=
 =?us-ascii?Q?Rz/pzVFUpnVFcDY83MMaF4TlCePJly1azthRtZZTxjzN6BcfG1jWZxE42IOV?=
 =?us-ascii?Q?c0NNIveD9rRZLtymJdoXYtVQifeALbcDb0XNiPt05vkOWrNUbelwyVgXipXB?=
 =?us-ascii?Q?iXPnqkhI8jbbpjbNnWOjWbsW19hB4ctUmLIvxNU3WL/IN4OF88t6hcj6p2KX?=
 =?us-ascii?Q?ye5RozSrlXmYDIsZ+VisdoxBz5+nsd0smXkycyMPx1q2HMH2qOJ3pmshChCh?=
 =?us-ascii?Q?I0r3x7hAEX+V7n648PHcu65WgEsQaUHfmipGL1fpT2dnP9kNAb6byvG8Ghzn?=
 =?us-ascii?Q?CfsrQYHU+zhlZbXGD2s4sGAxBtmFF5OAdPSMlIXqDl82tbCxDSwIwnaeqj1I?=
 =?us-ascii?Q?Q5GBIiEWFcDpGpHM3HD2oxJW64bF2sAnoNo6DEU2HHsxuhIHlED8R1B2zkED?=
 =?us-ascii?Q?8jgpDSOZk0SmPGbsq5+9lr0rYwKP4AyF7QwXnScTpfehfM2+0bFYZNDoROXy?=
 =?us-ascii?Q?qnkevhj90y47JOUnJC2J0OBraqSkMSK4TeUcIsB5s17NZpPs8OLUa5ey6Yl9?=
 =?us-ascii?Q?xPR5reoHcnppzaiDie676cI6QinzGv4cJx1iN4LiXgXi9o1DhCfIItfBpNcv?=
 =?us-ascii?Q?SOHB854Ja9Dq+H53iuOcNyusMiY6VJjbqEcbJ6A7BbAldDvXnVJv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5badcb71-67d0-41c1-5e24-08ded0d4589b
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:05:57.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hZiqQLDKSPf0V7bBO6dFNDpvAcj9U+uYRMIWq3vFbk5/6C5xZkR3ra+qXnKqJ2xR5nbUGAt7fzJeXeZXQkckCMdQ7Gl4sg8dMNJmdGMDuoIpOItNZQhwG96GIVl26eL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12188

From: Sherry Sun <sherry.sun@nxp.com>

The i.MX8DXL-EVK has the PCIe M.2 Mechanical Key E connector to connect
wireless connectivity cards over PCIe and UART interfaces. Hence,
describe the connector node and link it with the PCIe b Root Port and
LPUART1 nodes through graph port/endpoint.

The M.2 Key E connector is powered by a 3.3V fixed regulator
(reg_audio_3v3), add a reg_3v3 label to avoid confusion.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 56 ++++++++++++++-----
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 1084164d1381..6afee1f1a9fc 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -42,6 +42,37 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0 0x40000000>;
 	};
 
+	m2-connector {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&reg_3v3>;
+		w-disable1-gpios = <&pca6416_1 13 GPIO_ACTIVE_LOW>;
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
+					remote-endpoint = <&pcieb_port0_ep>;
+				};
+			};
+
+			port@3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+				m2_e_uart_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&lpuart1_ep>;
+				};
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -182,15 +213,6 @@ mii_select: regulator-4 {
 		regulator-always-on;
 	};
 
-	reg_pcieb: regulator-pcieb {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "reg_pcieb";
-		gpio = <&pca6416_1 13 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_audio_5v: regulator-audio-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "audio-5v";
@@ -200,7 +222,7 @@ reg_audio_5v: regulator-audio-pwr {
 		regulator-boot-on;
 	};
 
-	reg_audio_3v3: regulator-audio-3v3 {
+	reg_3v3: reg_audio_3v3: regulator-audio-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "audio-3v3";
 		regulator-min-microvolt = <3300000>;
@@ -623,8 +645,10 @@ &lpuart1 {
 	pinctrl-0 = <&pinctrl_lpuart1>;
 	status = "okay";
 
-	bluetooth {
-		compatible = "nxp,88w8987-bt";
+	port {
+		lpuart1_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
 	};
 };
 
@@ -690,8 +714,12 @@ &pcie0_ep {
 
 &pcieb_port0 {
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcieb>;
-	vpcie3v3aux-supply = <&reg_pcieb>;
+
+	port {
+		pcieb_port0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
 };
 
 &sai0 {
-- 
2.50.1

