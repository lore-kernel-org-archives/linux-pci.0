Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00A30F547;
	Fri, 26 Jun 2026 02:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782441080; cv=fail; b=O/YUItsOnDbV+8knfOxWH7uNdEKLW/vdPaugwThn87MOqQ5Ml+ywhk9761XrNqtQcM4Fem8Bp1xYh4aBmPE7utoZk3iADU6fQ2d5TAtCtO2lqSAe6BcVjHLjrICIh9p5I1vHHy3IYe4tZhDzb7reXqgh5BrAQaOsuZzL0HUsxDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782441080; c=relaxed/simple;
	bh=3wpktIlNCnCUJF/5Z+ICzmeSZTiPtyDHOUGRj2U9k8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fV0PQ14Q2eRv/5NZelrXQYlVGkqzFDRmwtqJU+9IHLmaMxs5nYKPRgyjZhyyMtfXDIkaBTBWzL36zUIo4sEy8ub6z4JhXMbNKUZT0NRHMM54ww6fo71qBm0p0zGQye1YZJue1EWsKOrT2aUU3Ioh64fkOxQto4YsrvEmt+3uzY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nDCnm+bF; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nDCnm+bF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+wsQ2NxXOWP8UkDcucadyOvPZK0NLNVM0E6o+i5SAhNwR6EuegAtom+vOIIGO/BR7103P6+ZCMAH0FqESZrAvdI7tQZKqV3xlUNihL3CtO+b82fYeom9C0IAMJ31WP315uV/KjgJGbc01l2GiF5Gf4XXqjCCEB67n/BjtwJX+lSsopMFvpIEVvkUPSJ3aWnROPaONWe2FGzhDYhGoNVUg6Z6TP6tlyOXQJjzMNmO0Fb8s9tCYZRGZ1gWBqFBWYAt0KNCrOnzkqF1ZhHYjSjjtPPHllWCYACfEIibCKANwdQUei/MD8sijSOJAP9dauWydR2LaO24a0nvBJcY6TU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/PAgwfG9OX2u8oSIqiE9YemjGeL43rdbImwyNjSA7E=;
 b=l6OZgLa1yvlJYLSD0LB4C+wbH5+B7OJqkcKhbmbL21cT/WKNIVzfyBn7oqVN4HNAK2MVcUOKIe5xTIMuv2Y5apJRT8AaULbfSUcND8yt/r5IJuM3hWGDNXYW9c3kFjEk5uli+MqegIBWT47NCWA9vHAO75JDkjrp9RTjvoasaP7ZvNk236tEBMs941jrrZpKHKR7cP4H3l7V48OEVD+DqEPh7Yf+qevNLMIu4FxJA8EHYR+rPAxxafCD551oIMvDY3u5rK8poXj2+SxeasjCkzgu86rxZkTx71yDhSDbNvSZQHuTFaQIdwAo33zPOmV+4kWHbJTf4phiNMcueKqYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/PAgwfG9OX2u8oSIqiE9YemjGeL43rdbImwyNjSA7E=;
 b=nDCnm+bFr3o6LtWlmYkpFvtJn+yQ7SDt4vrKDISqLBMmw+hjc0cPrqWWs2l8Sc2ASuV8dP2MlZAht7mS7PJw5PGrg5YFe381fzKYQaYiM8gO9vLnCoFbweIl1/QzKywEqeZ2lNEXGVjXF6HwDjpX5F0ZbqqW0DdEC4/pUdh9wNMJYctXmbWsiKqyNx701i2JWOcT+AUL7nb2d/+D8avD2SsSnaIaafkyD5FPrRqlwQzEZ3drqLmq2RQtpOv8IOR0+JPbgXocEinIbNCNh/La0voaTynPCmSxEpIKWum1EzRzPXO74Xu3vOqnqgaXQmk0RE3tlibQgxFkOL3wKoStDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 02:31:15 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 02:31:15 +0000
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
Subject: [PATCH V3 7/8] arm64: dts: imx8qm-mek: Describe the PCIe M.2 Key E connector
Date: Fri, 26 Jun 2026 10:31:25 +0800
Message-ID: <20260626023126.2189931-8-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
References: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: d017a01f-9c4d-4e77-c423-08ded32afe9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|19092799006|366016|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	GC9L4VFT3MSiUazLy8kqHJ77cgqOe3NbPL+i9ZIJED0g6iEDFn2QjEkSrfI4fZJh78OybSJUDWuZS+DFzSfw+YU1VdByIuoLO/hW6/NFkNgfpCSDvUZuMu01POTznWalFZ/52iSssvZ2Rg29EmkAp9dLwJEldyasd8no63dsJNPs4XEt8hrc03zCtNOQcpaVtSpCtiOPDFFSgglodOSGcccU9KJp6OhyqthZuqAmggsZtzqJX1LNN2hbeQ5nGQ6A+g7dLEA4XKnwTE0xWD64BJYxGiWeJxKFvvlf1umqkDgV1KaVEIKVb8yOY80NPPDX4XGrzOkPclHq1+IFZ1rJfZ+eN79aGUx6ev9weSc0TlUGT7rLB1UihxFNo2+5k/mNrZ5XR+jxftcj7SApFQWOSR2qqJ8bznlRIlDXxr49wQixj9DOBdHQCqnXs263IubUr96/qvUqd9Kq0HQ1Y768G0lzM5+nGnm2T7dD21fEaBw4mz1+hz1pliCfZ0HUb6rPrz1kEizAZRXXqaFDl5KeHjIkGEk4P8Ivyo9rwmEEx42Ii4OKsVwvQIGFB4/+maBLAMBDShAX08Zs6ksmu5BHSqM1Vue1COcx5pZXXx82LEANGuIoXJEWvizOHFRx9uwLFxzC45yP4ExcmIccSD7No4tHlYTbURcDJp1I+pvtvy1zMTrMIOqf3B0kMe+3WsfsYj5fiDcHslDjkeln4hJ9xg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LcasBpE8g6OFHEpZ+Fynun5DNfIxDh2rdbttHB3tdrVH7jc/Gq5eNIZQKju3?=
 =?us-ascii?Q?gmM4lo6vHg5kuzAWpkwLO4GKzwCAdP80lR/mMEFaa/M0HQms3Zdb8CvrozUp?=
 =?us-ascii?Q?AwOl4Db3pxB5vvWZ22AycNLw7xPrvLvF+U5rLGRfuBm/2nPd0fKRDtbaqJCj?=
 =?us-ascii?Q?d2oc8Z8Jl/HD1FPk8Wnm26wPNlxEMdw1Vl17cyrZyeSaGfZKNI92buxta/m8?=
 =?us-ascii?Q?qCc14h9viPWXIbtQ5E6R5SfSfJ4k7kKjO/gUEURJ+G02ZGtTl0k4F3HVc9rV?=
 =?us-ascii?Q?W87V8K1/rxLou4+Wq0oXkb7rvgIvCgsTQs287V5+Y8v9lqOkr3NOJlFQyRMh?=
 =?us-ascii?Q?IyPAu+W5ya6EPZB4sO7dh1d6jN7jZxUoZulUq+OjumULOmtKj4d+eZYOSjD7?=
 =?us-ascii?Q?urbpBIbGoY3ww6qO6RejApZZtvAhm+e6yn+2FaXREtX0bmoja7pfELKJqRkp?=
 =?us-ascii?Q?h2YX0av3I6ZFth5htBCQpSuvdvC1z4vVQKOYOt6Y8ON39Ye33GVo6VuKCwVY?=
 =?us-ascii?Q?OPn6FVZt4dt6P20OZFVl962+PaqaCg3K7O9x9E7f9gQfhoPsHgIy8o32V6lM?=
 =?us-ascii?Q?7GtnSuHV/1ghV9tACNc168lkmBtQmqLt1C7epMH0wDPsFZtLGIRbo3qFwh2O?=
 =?us-ascii?Q?7XkwPcDJFHS58nYd4zsDuvf0W/2uuidASjWUEtRPaRZPuaQ3gBZ+UK8L8xZv?=
 =?us-ascii?Q?gCJEeGjqVzJZAkwQTTXqMqk2Bv2P+SuqCb4YinZhJ4fyDFiJhYLo5Fr3suqn?=
 =?us-ascii?Q?fl6zJ0Dc7npOUlhe6uHZfv+2dDPdMeQg8CGpXzF5QwTWh4dNqulYC1T8pY+3?=
 =?us-ascii?Q?k//1H6eZ3jtUJJecv4b+udNlt7ZlKC9M1MsjucVplLRZmjkdu783qkUouNg+?=
 =?us-ascii?Q?TzzOkabqYEVT2HtNtyL3vBA2Y3xyIKli1VEuG6VScjHIMDbLiLV+1M+/5WZB?=
 =?us-ascii?Q?alj25nkDw2lVHsaDIfqtpdMVWTrP8EJHQq0uvzrORFwjvjarMOpHs+35YU/7?=
 =?us-ascii?Q?liYJeyT2WsP3k73Fo1QLmSzFXBjJdQtTgOgEYdpT9TMqG9T+MI7uUASO4Hg+?=
 =?us-ascii?Q?ls3w4Nqd68X8Vo8Si+L+VA5G0NynQv58vMnyLN26/nsCfw7kz9iWSd+LLrF/?=
 =?us-ascii?Q?ve80rkugNEuV0CSHDVzfG4T4Dje82B6a0JJTOsGZOdEuDbd7nt76v6DaX42B?=
 =?us-ascii?Q?pEyCXmUNFwTZ3qW2l9XJX+eYFjUnOmBcszN44mOzWQAnoVe7zdUPeA9Pswot?=
 =?us-ascii?Q?PTZlovaqjxA8mS/sC7yajvImMmtePE+7q3TdDcX4mMjDGw0ekyyDR91PwDaM?=
 =?us-ascii?Q?V/mzD7aEU338LqdEOR9DRJr8Wfkah4BMflp8FxhsOkrd92r1mFc4+tcaU8Xz?=
 =?us-ascii?Q?MhqdtROKsYqtQ12vztK3nMF2M+RRAJeeslssHiE1OPDVlfE7O7Ckwu8kEpFr?=
 =?us-ascii?Q?WXOp72A0LQiSdkY9NPN29Fcc+pmxuJJWbDKwrRr7rFQy2jT/Vs3MRMjDudY7?=
 =?us-ascii?Q?BpxvmENe/d6XxRZiVJNrpFZXXftnWhLqk14DBBps2XZnm2XOTY98Nop/swX5?=
 =?us-ascii?Q?apcwKmmS3OVFSjzkFDt7CBPxXa5jnofO+j7jtmHFAA7UEGdNloXxsZYH8ZOA?=
 =?us-ascii?Q?awlq12GAdGdG/mN+jgtqcpfW2qdRgi7q2zhPnIEYEKZ7hqe0nTx2JvhzOjT6?=
 =?us-ascii?Q?FZPBVyRj7wBJvkAHMo8519MoECJ6tUEVRYvKnyQrSlz5HKY6hBvcySJ07NlL?=
 =?us-ascii?Q?WeuC2kfyHH3hhKuT0ABVBwlQ76g5E7753ccLY8YB6fRgmzZRBz0s?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d017a01f-9c4d-4e77-c423-08ded32afe9c
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 02:31:15.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGkWHZnJZnjN2S10yvsqgURj8ahQ4VQ7e5NlcwnbdurJCTbYfFXRoNWEvqM/vQMN+jjfqeE0a3SfPq295VxpyN3xdAEpxculyemamjQTuW3R0sX6CBFkqEHs+JhwxHaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445

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

