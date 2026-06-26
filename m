Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C1311C2D;
	Fri, 26 Jun 2026 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782441072; cv=fail; b=oAX53hxJgxuL3HbmnbFw9kr63VzuIQGkmNM6Tc4NiFyvO9rpwziL4kpMF4Iwjz+Z90IxlqjLnV2upYaxKcono6k4nN1n7H3MUnQChjqcaStTlRakxMpOLQ+YVZoEcgcqzDGHlBC+U5fWW5mppuOn7xi+skeWfqgISm5S4VDfONQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782441072; c=relaxed/simple;
	bh=x6E2UBc1Wr0f+S+3Gfl8t4FdwuG8wJl2j0CMh1yF0Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ScUVwgq3E0RHYG9GfYIlnaY/cq7cLhdS6rosB9nuZODIjycxy5HAql2yzVKzr8zNJC7cSfu1PEkLOtkymeDYVqMby6SIx9dM8eKEO1Y8iOmyNkAfL+E4qKXuIMSfb2+qL+tlEonXBiZrxemQbayIHW1xXcQHCstrE7d4QNVOuSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CXVo40DE; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CXVo40DE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqEjmYfYa/Yvy7ZdWeztuI5zXE6HGB7ku7Ji414xw/3/fgjXVaDx5QsplTP2E3rLd/epQF9jXFeTOnFOSrU5xID6soeoTBsI7w6IuA5Hfu6sKQwQWDLwMq43BvMCUGqoUw0pzEDA16gHUdlDLJOenvF0Uukp/rhKdf/477S0+GbiqRRXmKzq1qMnyk+xsUcP01VmlSsiFyHQrBRFnQMf1Fpe4dBmDHP6hI5eZgSEmDzWmK8l1Vq+oTz9j/VqrBPbJrfrXZWeixZ9E/HZQjz2Ncdpa1UzhY/xoDaSPxoFMgYW8O1Eln9rY4qT531tD8BBE77pZLkXKut9Qh8nY0OOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khbBAqF0X6yEhA27tOY5BT9dAoL+hAJc/LaqySVfBwA=;
 b=ModVnfxqIC3wpOG7QZRqqoDwGHrkSnlFoXW2RQyERmB91FdlCETXqZc2NVVJmHg4GRnN4NHYOoe3rXlHOHi5t9/porjkRdwIQqCyDEJzZARQ3ED+HpNjrLKx36qigeggQ92RBIoQK8Nq7JlhLBdvRb62f6CETtR33QIqBlkpMS8ue7oEczieSnBSDbXzrHRxGXPaxmF5eKpllYLLKB9taXG9NYHdS17EVSex6M9Lp/6xDQRyjnB7dNjThYsX+FVovJo5Va4AUXCug6NeqC9fPvxHdWb505Vk1gHMytHfJP6uX4RTvjX7f4CdJuZdIr4mlGQo4yQNFeEXa/1g8TG8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khbBAqF0X6yEhA27tOY5BT9dAoL+hAJc/LaqySVfBwA=;
 b=CXVo40DE+hHc/ozgY1qVkyV72v7WBFXY6tT+qYcVMHB1wyV6obGx89MDgowq7+/PHyNDErolwc/4IoHk3Rm2X6mEqmRqdFxB4/D/IdvlxONr0c6BY8gMB3mRYzCavyOeoXApzoBhXEtylJ2hlXlguvEkQgm47iGTjj6+jNu3cZlMI2NEFoSgeBLiPG1vWla8VAIc5hxACIL18Gvm3rBKVFh8Iv5TSUzkKZwLEbacpGbWb+x9J/wwbZZKGrz1YIA3lAri7zW2HUN2CM7YvpprBTB5pXZLp4z85GJFnXS+n/ol2nYI5hK9/L4VaGvRN7B8jRb8RzjTzYYAar8jKo205w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 02:31:08 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 02:31:08 +0000
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
Subject: [PATCH V3 6/8] arm64: dts: imx8dxl-evk: Describe the PCIe M.2 Key E connector
Date: Fri, 26 Jun 2026 10:31:24 +0800
Message-ID: <20260626023126.2189931-7-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
References: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 742286f2-e89e-4b7e-42ca-08ded32afa79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|19092799006|366016|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	kebkTxY7NOccRCQf0qv4+jsskRiMuM1oZh461h7MjsibzyKX7BBouW/q+vgrfGbMbQx0OWMuca75/9L+gtyjRyVmc2QABfpiBCiuKD+raqV//yUzp3RSi6oMRQi5pUudLroQFPHb8ek6lChdA0KDf9vgORFhUZ/5kCz3Ku72z9q02hlQssu9RQX3oLUQGyzYfBfIdTKKgzq10nhNw3RqKbtsSErwfWJ//kyIChuTLLj7gqfvYKmXm64lOqDTxkYK966CvTaXDKETy9onNiHogJLNjkMJVum6lrSDAE6uSRNDawjTHSkSPumiog21EC6dJ4stU9pKe2g6teva8MyeJ/fiV/q1L9aQMQv0HFcOFObV30H9oeX+ZODfz1akl7gWZtxjs4o6ysQXwnyHrZENWgWZO7XohRwOSB2ZJUys4EUYhk/sPgkRI7V44gPbp6Y36wV1BXpK1V3oKM6sNflitXZVGy90bZ6tz+UFMYV9BHkBc+4wGydDaK717YqsuX6VT94lfmjaZ2ljycVCI9UohzZlCjvKu3zHYO/Ex96Ll5qgejcG5YY1NavLNUVPCJYUNo762shtSsfoyRM+7UnWLhwPvB5a7uNCLqbeNZ2Bcq8k+/vWsFEik4xnmT1lp56ahWjE+oW5+dQCp9Hz7Ung8g9L0riQfTP1pBJUz4Az6M+e5O/LJTcJoO6PmzqlNmpnAeb/yUFRsXr2fPzXv1e3tw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wyG1obYREl/4oBH7Eh2aWZxLEpUQySnqMFZtdGogK4Dx3RRa5ynTAOdVHeUP?=
 =?us-ascii?Q?YcZn+BNs9Wl6p3/Tq7bQyl+W+cSO4DqIX4Kq8RNGJh1hKmIV/YIf4qCvPhtd?=
 =?us-ascii?Q?qrwN06LeYJhDs2RnVqdVJ+dIcK4zRF8mThe1HqF6fBX62G0p8TncpVRXqkI4?=
 =?us-ascii?Q?1JAI56GQekArTkKJA2Facxp//vGkRYDgH7g1YmZreLs4sQeHJoJwMjWEo7DM?=
 =?us-ascii?Q?XIZrJx0lBvLIsgNDuRodFmzYEwOei1z4o79ynNgl4SORKarq3k+L86mZOIpv?=
 =?us-ascii?Q?gU63wLiu1TtOCUuJAP5fvm2sw8h6RUplAcqUp4XNNIV/vVL7qcmojJUXYZXB?=
 =?us-ascii?Q?2Q0O2f2Zvl/9w6sguLunJ5BzNd7A7MIGDvLPEDyGepHmctgwk1ufs0PbqW3w?=
 =?us-ascii?Q?lUnAQZdszUGczoz9mdLr/YwE1DVW6a/dYBZLVTxOcDEp+U7DgaJVV2mgm97f?=
 =?us-ascii?Q?ZievYD8CrOJLfCGAWCjX6WI2sVLUgnkEr79Lq/XXEJBpmJ+dKpiq9Ie2n1tR?=
 =?us-ascii?Q?JzjjFIqgyC+zgLeFz5Xtblw/WgYen91ruvtEXGytG1Tcr6PMSHofJUzmYszR?=
 =?us-ascii?Q?mdhzy+UC8HxbsF+wSM41xCmzFIPUQe4N8YxGwrhuPOWk/ATgaMMXB2jGtD6e?=
 =?us-ascii?Q?MG19s3FyToQ5rtBdSTHWBPGJoEim5gm3r1r/+zZgYHCYvH/V5+34fehjzbC5?=
 =?us-ascii?Q?n0TSmtskM5WUNkHQTcb/uL+4wPsxSNeTo3FXE851xLK3jUL/CjZtXUR+jgMC?=
 =?us-ascii?Q?rDpxgBMGYHt+zeIY6SBRQuIZ+1s8cdnzyM3M7pwq9rZtf4MGKgnWVOkI2SuB?=
 =?us-ascii?Q?IevZ0rhkOhd5dtXPnekyBgCdVRtCFD2tS4ZtWG+rZKSAPxF4LwTxZPmHKHK6?=
 =?us-ascii?Q?wkyN5vlQBhu01mjfSk98lSZ9Vu2TNsGM3bDTcIcil/H11tjd6Yy0No0Pc2vG?=
 =?us-ascii?Q?evXUxiTv/ChSZwGVCXVZk06PsToKy1SkdhNrEPghSg5e3OmrplKtMzaIWLu3?=
 =?us-ascii?Q?ICLi+Y3ZamTZpMP/LwBmF6qKwVCA6i+YXJ8MSE45vrKOc5QCxGSb+qd/Xs8R?=
 =?us-ascii?Q?ztxamLLPx4WImzLACsrc8FsV3++aNBMXNkPhAAjzsacgO2QBHbNdIcAypGNE?=
 =?us-ascii?Q?HOSRpIoI+DT8teovF0U/AjEl0FBlr2iQRGj6OICdRV7g5d3+2IuCWK0/T7Ra?=
 =?us-ascii?Q?qOEmq+OJ69s67WJU/tSqFXEfKapfWek11OB3DA2cvPOlLKNDYlwX4nXBDTSH?=
 =?us-ascii?Q?recApdc3vFulOWB1CLl+ow+IfMVy/7RYtzhFLqLB08rye76cWDJYKyH+wTVO?=
 =?us-ascii?Q?UWDYDB3W8RKdvMpFZ09UnSuN11GiOy74mPiM3Uqdvpc6aRi4nGg34ocXKz7A?=
 =?us-ascii?Q?mPr3luI1leuHUtCC+eJmysqNT42b8WsT30ErAvJcnxDAOwvhiWiujW/jsc2A?=
 =?us-ascii?Q?sWT23qBmjTheyiJHCxUH/OvuL0pONaQT/Ri8hG1AG9jY8XW5jY7R3SkH24I5?=
 =?us-ascii?Q?WNfhbvH05eFBdY+aBoFKeqBDwvfa4bD22R0LNrX8tK+VgFD8Baaw4F0GxQfw?=
 =?us-ascii?Q?vaBq33vLlNrXwT7LJjCfTxvbSh6mwkHhImp9wSJZHZdP9JCvMRQZo/7dc8LW?=
 =?us-ascii?Q?7MmyctioiUP9gKad2H+B/je096T5FnVUeGJSnUoWlfq7BLtYPz3CPXrkgYXu?=
 =?us-ascii?Q?pYSJfigGLJbzY8dCdd1f/j4Jpn8m1DvqalmyBcml4/+yQg82xuSMy1Owbnov?=
 =?us-ascii?Q?FvtLtsS8JtKxEtQ8779rKRqEiis6FqegQMjqOmBD/AjZbWweSF1T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742286f2-e89e-4b7e-42ca-08ded32afa79
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 02:31:07.9570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lds7GBSoucPjlRDMcCQYNFfcmuxAhJLfDN17GpHvvTR8Qj/2X0wSehHMUWqE4XIv1mb7HwIz5T/JWv9hP/tMtotaWpV1f4gOPCGGFVeIFTlQcTML6NT7L/4+wNEjeVbt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445

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

