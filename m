Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D83E8346;
	Thu, 18 Jun 2026 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777392; cv=fail; b=Gnd4GjFgEMkeLvjyOD+/cbWFVrhkY6jgeGj42l7CWypFE54xqVUqU9tUrSGpcEzD5ErX6mSXtiBbzSNol7gNmJJGDP637gE8XTmvSeKzzF4CHUh9wkfqduYstamURgN0H3gqzqp/RmPxsvTLPNT2bEoCcFWwjuTmwQAffJiWoWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777392; c=relaxed/simple;
	bh=3wpktIlNCnCUJF/5Z+ICzmeSZTiPtyDHOUGRj2U9k8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jztYt1jsaTrADUyQzzOIu5iPPKusXw/+IbliIqubcHPyY4H1/pmlZHKj/JBhXU20KQmo3/Kj2uvlf5Ybt4Y0IXfWWe1XwUdTQhdvkOIGq9FIJ7AuQlx3zoejuJnBL//60Xkhv+lLZgurzJZDKvM3uUc5wVbiniw/ROwF59Yg1N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HoIF+V/x; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HoIF+V/x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mo0+ZCCr/cRZEBAbiaYpSm9FXDIfqe24lciKCmdDNwiSIWABGuscJZpwzbB7u4N4Rhwr4KLiWrTifT2UOQdzmvoNMqOnTsJloZSDSfcj86+NSr+TYl+1RquSzXEGLUz6C2vVpZBZXRxrNK1u4Flusd7SFytlMAcYTGlHGKekofxBZzmOWkBTfdWf8CK4sIy40Cad6n44KCeFBKAkU4KWO8+k9x4NLxYxXUhe0qPIS4KbY+A44WZDc19JsKj+UZAVBspWDON4MGHYnMxDbAzTZO35XRyDzWjjcHLzHZHuOPNEizL7lnXMofMw+3KQgN/3F4O4jO6rTRfFDeroTV78Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/PAgwfG9OX2u8oSIqiE9YemjGeL43rdbImwyNjSA7E=;
 b=On8ylNvbyNul9i+oJTATNcz0Ko6PDwx862b9lnVCcpZLacSpTY+LAKnnmqtnMg5jzh8v+HLt9sB1rY3vCrnF18L8+8AyYlXdaglMMOYdynb31XlbCUGafaU6tqN8TCdNxQbimd/gsH4OCkwJv0Q1Z6Ukn2Zu0N7Azl7onjTBPcJuOCMW/S/U0CcCayYKNyy9WzdL9CSb5vP1Hkw5h9SEmlSiyMFZ1gVI+l2Qay9dfpqrZ5fZkxNxaYWwhumUFQJ0gJmW0N2ZMKhUals2WKH6W1RsPweDl3l+oLKSmc/givsa+1SwzoJY3T9rdSMdG54lOuoF2IE/MggkC3bfvdue7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/PAgwfG9OX2u8oSIqiE9YemjGeL43rdbImwyNjSA7E=;
 b=HoIF+V/xKhNISoLRrne4/HPuLLeY/3V2lmcalXYweYiIc/KGjCSt1XsfuK2W7DmWKLR6NYdcN+JHaySfQqbqDwZiFPrzkLLQb8a06qMFr34sRltEdCS2wa1quBF4fFHVX8g5l56DiB3tcvWTcLajKne+5cXYJWAPOPuvSAv/mQVVtg8HedeAN9N/crZzBvhiNbr/TYoO1eO9D8IFyRPWLjfU5FzDI1no3SKIkNPpAQpchIdbHjDOmJTVVWiMR3m5EI3VOyxoR/6EW3KUCt6+O32MFUlBcflni349n3lisLfSKpqUgqmvmtQmjgMvtlLvs9NZxgeW+Fe3mzWzsICxpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by PA1PR04MB10818.eurprd04.prod.outlook.com (2603:10a6:102:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 10:09:43 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 10:09:43 +0000
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
Subject: [PATCH 7/8] arm64: dts: imx8qm-mek: Describe the PCIe M.2 Key E connector
Date: Thu, 18 Jun 2026 18:10:46 +0800
Message-ID: <20260618101047.4185497-8-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::16) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|PA1PR04MB10818:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4ab6a0-659f-49e0-687b-08decd21b79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|19092799006|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZL7pOZ7wZ/YZKU92hmboY4SekOuNRthTVgsrY3+JMjc22Og9Fe4kbo11soOlb1Sx4V9RXTR1tjJvk6Fgh0ld3YAZR2bwlUIjQ0/gT7AFBaPL517ftx9s4CmVS+QOnt1wZ+SiYGl6wvjpzTJZrYqIEY2oZO5Vs5apw5WWkJ3p0fFZXe6CKpjygodvQWpHppLsluvVcv4f1t4f3P0iAAebkF0EpORwHo2Ut98kbStOF875LMwYi4dRElG2Cqz59dwbQ0iLtGHXXvPpY4R9KjLJzz3KH8Bvd3MRo1njEspmQWRd3CsCkgsidi5JFrAIWhfYXcoGe+IRcuDRnUuFLzydgtAqGN3UokjzSBCTwsRPqOmvGTaCB6H+X9A+cL3D9s3kKrs47/yza1HsoAdyBmBZWmKCwNr4Aviz5z6Gf3Cpzw59k4WO7V7jrwfTjAW0vPhQ1p/zu8WWs0+6Ixh1ebYbpey7pAcrNkoEy6Hu4/hBB3ZRENFQBSxG7ML9vnlYdGYOfPr6cOwC0ekA8QkqQ+pfyGyPgv/5Ynr/Fz2vX83tFtE+yG+Bwfm/qDmkpF3+Qwhb5z1Q6XBWURX1WGiXwF7C5Z7Lp77n4izGCQzIwAtj+p7fBGZJoVJLiD7Nl54UpZ/TNsFKMILtwLxgQQPJm4oJNLqjiaduV/SC7Oy5zSmEWfRbLxaLcO/JJFw471yMfBTWw/uhuJRqr1ChvlBEwxXN1xSN5pClrPUw5h7S667bhdo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(19092799006)(11063799006)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A1v9RZQDMI9OBDZaecHcmAagHaY7NK7qw6FILwoowqDUVETzEys0HI4eJqrC?=
 =?us-ascii?Q?uByWcLusi2G7IFEDIgY+bRdh8aN1uWZBY8MnEQmFyBiZKgpB3vdgEyzSvtnV?=
 =?us-ascii?Q?dqzvphfFN65LFzVf943qfaTIGg8gXDxQ2d6oN7FtK3p+fgi8rkT7w2ncgsM6?=
 =?us-ascii?Q?WsPbAmcVYNwN90Ran2z2yPdpZapYGbAn7qr4Eko43t3n8HIln7zDZ3DmW6V9?=
 =?us-ascii?Q?EFSb2LpENlotFfV4q1sCBuN8HZm+oAL5CSiYtgmfToFfBzLfTWpMZQvPRtya?=
 =?us-ascii?Q?7t59dzKAlLZH4HE7s+68RRACKT67Qjqq/fXU9KoYyLHIu6S/HO4qU8ru2Dz6?=
 =?us-ascii?Q?qqV2fEeVnJSFG1ryh0ZwPDr8IYVD4gZIyJjxkCZVev6HhhMwtA9IyMkF8tCA?=
 =?us-ascii?Q?dF9RkdWsmD87J77E4/s5fHwX6VUcNPhyT1p5d9e6tgq+8V10sKTY2ADZEbK/?=
 =?us-ascii?Q?SrpSm/JTSYkbrQa6KnoV+47XsicM5KENih/Bf1yPWzO7ibXJzI+1r+v4LFZl?=
 =?us-ascii?Q?waI8KKzFvRrYOJfdDPfJ1xUbxrFUGIvJ92PKBfwSLu2A5KKFcyy3VWlK5kdu?=
 =?us-ascii?Q?dMLCK4sXr1I9v9FGnclh48OdzJWAYiG95UAC9KFtHfU0/J38d3n8u/QmZUw9?=
 =?us-ascii?Q?zjY6SrLF56Ic5sPj2yVrbmDoujS8lq/tgV2ssqxFdfgfmtFbIYH4Of2cXlbW?=
 =?us-ascii?Q?i9GTQSEe/UclsITqJgC4Y5l3jqqDP5s2QeC00LAq3MsGqy0l3gNSFYGnSYEI?=
 =?us-ascii?Q?yOzXR9b+pfaXrDFLuVyy1dVdV4XdxpJFTis3YSu51svJad6tUnw0oRm0bZoj?=
 =?us-ascii?Q?HZG5vcWOAqr+WYfYZjzEUOxhkvcTuPKsIqqNTjJRuiDvj7YV4S+kxhOrJlo5?=
 =?us-ascii?Q?BZSZFphST1kPW67lnn+FBIsKjIJgMUYwdPOR2QR0bu+3aUTtZbDpDr8lc4mH?=
 =?us-ascii?Q?upd1KU0+/zd+Q3AGfAk3oFzT6aIhxwqO48tX8LGdKcs1knpzyu+iE/e4dTd/?=
 =?us-ascii?Q?ryFCUjN1RUnXDsJnr0KLIGYOEKKMdL3RbAbZkGLlRCDnpi1rsJ5bVHzdK3Qd?=
 =?us-ascii?Q?ccw9YNvgPtMS0n30+akJxZxJ+gG1kQWSb4MTX5W7jgfgpUPVT0wdb/xpc1cu?=
 =?us-ascii?Q?yfD3oIZLJCziLI0hnrn1zIfxDl74V8wQRzCccBB+CE1WwNWcKbHJLrwRKNY5?=
 =?us-ascii?Q?uFFuc5bpNWFSg+S86zDVO4b+s6YSQpm9ehawyv+2peo/c1udMoxIJa00wNgW?=
 =?us-ascii?Q?xBdfWuWX7VT4dbCS3JVmCo0FD6OQ2R6DCrS8Lo7gmK4uiEXWL6M/m5My8O/8?=
 =?us-ascii?Q?v3RswxnqR7sY/6tZ46dqBgh57uk6lZsuPKGEtSMRQ4NY14hzNZ5IKUogbq98?=
 =?us-ascii?Q?dTM/oWUXBbM5uQqvw+bmNfNAYSwBu8+PrxQTmjS6XJY1LVhNnjp3/zeK/9dF?=
 =?us-ascii?Q?rOZUsiL9xoHMrJYdqPZrq64kjrfzGe3nK04EZvj+gKvOwgfOXpGAysg+NYYb?=
 =?us-ascii?Q?pqtmBmIB1carPGaxTzYphM42s60sB2cQHv1DgMCmrXZup+yLwr6hi//2dsq8?=
 =?us-ascii?Q?GOiikVANzLtB30mQej2dQChe7x0IuEmkUK0ft2rexc3XnjwVKy6OSP3TIQPN?=
 =?us-ascii?Q?IVdF0LabdzG6pGuwcCYpGvbLkwr2m1CYY5sbvwiM/6qM1Ocvjj2mgTtsSmtq?=
 =?us-ascii?Q?3qMMP1xjnEeD5bEQAhYrOXW0q3wJ2lus2OIJcLb0AAJCSZDb1pZ7nYANkQgy?=
 =?us-ascii?Q?o9endz3vhgb//l5UmBNZboUG7p0Tj2Q4rnWrjgIVy/kiYv47v1rT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4ab6a0-659f-49e0-687b-08decd21b79e
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:09:43.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0Jz2VPFhXyeoYj8/CB9RRdYnVPzUdcoSrPGwRIuL9OJ19HYy5SHHIx1wKgDcDtNw2TGCtcU2eKk4s5fp0ZaH2dSM14Hlu5vomEC8pURF9K9xWoqOEtUG1Lnz2UASQj4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10818

From: Sherry Sun <sherry.sun@nxp.com>

The i.MX8QM-MEK has the PCIe M.2 Mechanical Key E connector to connect
wireless connectivity cards over PCIe and UART interfaces. Hence,
describe the connector node and link it with the PCIe a Root Port and
LPUART1 nodes through graph port/endpoint.

The M.2 Key E connector is powered by a 3.3V fixed regulator
(reg_3v3) on board.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 58 +++++++++++++++-----
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 5e725ad8aef9..4c02592cfe14 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -32,6 +32,39 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0 0x40000000>;
 	};
 
+	m2-connector {
+		compatible = "pcie-m2-e-connector";
+		pinctrl-0 = <&pinctrl_pciea_reg>;
+		pinctrl-names = "default";
+		vpcie3v3-supply = <&reg_3v3>;
+		w-disable1-gpios = <&lsio_gpio1 13 GPIO_ACTIVE_LOW>;
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
+					remote-endpoint = <&pciea_port0_ep>;
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
 	xtal24m: clock-xtal24m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -320,17 +353,6 @@ reg_can2_stby: regulator-can2-stby {
 		vin-supply = <&reg_can2_en>;
 	};
 
-	reg_pciea: regulator-pcie {
-		compatible = "regulator-fixed";
-		pinctrl-0 = <&pinctrl_pciea_reg>;
-		pinctrl-names = "default";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "mpcie_3v3";
-		gpio = <&lsio_gpio1 13 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_usb_otg1_vbus: regulator-usbotg1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg1_vbus";
@@ -718,8 +740,10 @@ &lpuart1 {
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
 
@@ -818,8 +842,12 @@ &pciea {
 
 &pciea_port0 {
 	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pciea>;
-	vpcie3v3aux-supply = <&reg_pciea>;
+
+	port {
+		pciea_port0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
 };
 
 &pcieb {
-- 
2.50.1

