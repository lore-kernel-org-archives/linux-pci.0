Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BBB3FAE00;
	Tue, 30 Jun 2026 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815458; cv=fail; b=ZXTSLWS/Iipn9uDHe1ELMcXEho+J98ZYNmn83qiFHmVxMPJB/e1dlqvUzB4xlM9QX8LAp8mW1MhgPLniH48ruAPmQfUEg4v5/PVTHS2xlxmGeXo0pp3JxJ32+fTgnY1V6vE0RSHs1KrA8oLKPesEry6QuVuEU5ruVLrnpvuIJs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815458; c=relaxed/simple;
	bh=gaVlYUmID78Qdg0bjv4Rny3c5Q9MZrWFZqAysR8gksY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FK+yKszZ7OBuLERAptO48jTWh6fjnqjL6F2wadYGTeEjed2Uy6yUJjeQ1H1Jl03R5HRGbtyLUuqOtv9YcAJC2bz9tOR308b/pTyTYaT69ztu4iaz1celYyzHpXRsuZsR1W5ORpTkeinqlICdAJ59qoD8yoU+jkedQX1vCG8jQvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aIdkdodY; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aIdkdodY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1ZAwREZI0O3etILNSRGaAmoQCVXdFr+qfKBqGjKMH8FVdVEBISZzZzPTc0+QhBhMcDqErlbgJxO0fRcS3KKJ0A1ETh/8gL3B219UsstisIdDV9xEHZBaFS/pvYLDZvT78TL2XdyoMXcWrEMw0nfbfsEP8zxD5yIswj9UE7v43Pnq3U1Q/Z8Ho3vMZ/vg7FRMvjimG36lP1A4g/hr7wVfwvWNCTvpySO3lzHQFLkLzKpPzgToo27tNswwyvHUTx24PbsamsvVUfBv8/yZUWpFjUrmbI+wSMt5W6wawjYiZT/gHJxCncR6gNBUyp+Cg/VrvIzZ0lTl/JJB0CzF4TtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmSlTgbiYGe/2JPvw3yUOYyOATLeHJ0hM/0WUrpKlK4=;
 b=o8W8K4zPwf3YJYRYiCRWsAHZa4vgF64zqFZzbdu2FFms6Kz7QLTDSlvd0lCviMRvRFVwWnjOjQRHFY4FxrD6MSwZcWToG/JU7r8tW5SE/qeylW0TBFtr4IMnbENZo2AVgnkiHA2LBOI4ecaA7zlzMdDy7nEqOFKwNNVxL2d5nyHsiqKYU/VhaT9x8JNz7TcNUHHXT74yP1yosuvHCFkfKFoobst7QGViFtb4YtVedAKgdO3MiQmjPO5rQOgpLoFqud7Sd5j5PtJd6zK8IoZzTdXTuhEh1IApXUm968MFV80eCW6rDek+iE8NbEgVv8ei5O2UsYspObVgVtiLidMPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmSlTgbiYGe/2JPvw3yUOYyOATLeHJ0hM/0WUrpKlK4=;
 b=aIdkdodYY4OeY1Ie5KJq2LEuRxEJ6ALNVCkvR9cQog/ERxsjT9tmzBHe5R+bd6fyAIA2olGrT9bixdThTRxw5Uu2QKmyrHDXDsN6cv0vsAdusk1ciKW0WB5If035+7+2UBCHiVL0uXssDkPkxnfhn3hKFwcAwVfFftBEf8OnpNPUH1u8jBdH4XiK+Pzraqg+g9PniNzjoiTACcIA4HG35jjo5zaeHeOEzXm7rwHOP5tJSjBGdZJqJotWvtFRQUGs9zzPTbo/eUxEnc9bCoD2U1x9qKn9CqGcHLmTpzvin+dhWz2d8QcGCoATWc6YCdCLuvRrt3m3YOHovn6Bhm5J3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI2PR04MB10220.eurprd04.prod.outlook.com (2603:10a6:800:229::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:30:52 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:30:52 +0000
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
Subject: [PATCH V4 5/8] arm64: dts: imx95-19x19-evk: Describe the PCIe M.2 Key E connector
Date: Tue, 30 Jun 2026 18:31:36 +0800
Message-ID: <20260630103139.3823329-6-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
References: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI2PR04MB10220:EE_
X-MS-Office365-Filtering-Correlation-Id: effe40fd-c7c1-4415-e185-08ded692a8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|7416014|23010399003|22082099003|11063799006|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	kq7rpqH29ABbuyrJfQPml/N7ocsZHm76BZJIkFqHkCONK7pSLmEGNUjxBnLFTK5LtON+pKxgJoq/7SgWyN9cgz57Ln8iy/EzDmR3x5HZshORXC8vZIhEl1q71ZF7GvLD7o3/Hm/0J5opdJT+hq2f3KtsYAqiKJpirKY5UCp9fazhRUyguqU4Y5yjIPnZ7LEEBOlQY7khaEqBus2lfDC8GTI2DFPTwR6uTTMnqF0UNTV9AeUedoT+7U/gCDEw3wKPpFdqZGFv0dWzphyTChlnTUZp3BQMJZrpeaThiIk7qNFQD5xhm1v3CaVJccFtMSzTBpnNP5Ck3vP/jmtTMbov2LHiu487V6vaFJpfA/3cV/QKMVPsJXc9sI5XAidcx45MjuUnmM/oogg8lXSQY8yrxCTUf6Luz2AmomTNv4iTSSMzkXdUZrIYtYG13I9zz5EFAQdrtiGPaKCorN2o2U/82gRyS3MpHGCmYzQLAqKWbFLwlrePhDjdxB7179I9fc0bfoU/Y5Xt9kGSrOWvH1cT7wv+yDSYdAh6qWSszRPQuQI09HCty7oSdKGqJFnhn6Wd/E1ElN8TGuB3yEnUz418JcQvuyp5AC3+QN2aKLkOBpHAk7ODqHabx8rpNwWbZdUn3dq3s/P0TLNAdtSCuB7tXwtQ88XTAjYqnKvSSA7mjnwzbvmsWiLVB2DxVdTBzoKo62IkQMmSXWa63p8f2I0F5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(7416014)(23010399003)(22082099003)(11063799006)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bj6IHoL78qPJNwMSizesgrGatrurL08WElMrROShOFexxQ1d5xGuZJEBSO3P?=
 =?us-ascii?Q?ty++vx2/S/n/yz9FdDlIG3nVqBvioy9qEHoBbXcaBN7p4SYEImKiHmLcMPh7?=
 =?us-ascii?Q?IauBFtcxCAunljJFeceNB9FKJsxVZeU8XOZ6n+IwULzj+z3uPUkS2oIyUviW?=
 =?us-ascii?Q?1O1/8uCzyCgbGznCBHZ97mfIyL1WfzFnlePuCFKSh3CvBSLWMtolSNvM0a9C?=
 =?us-ascii?Q?LeOIWt+jY0lFfz+d/f+/2PvK4KOg2aEKCeTSz5cq8U/pIr2SqrgMM4Id8WVJ?=
 =?us-ascii?Q?fd5u3etm0QCYx6b+jpCv//yXVrjeXnj8J4AfxdZ5g8rvBvVOC+YTZwWdjWEE?=
 =?us-ascii?Q?wUzs+WJS63NRlR6MyOULmombZrOZfj4Y4ja8Fe+mhe0I30TlDNXnWNE04UUP?=
 =?us-ascii?Q?6+61aWOKGv64bbKgBREbZJFIBBORqk/iexkF1qDlYAEK1/ydluCbHM9vrwgq?=
 =?us-ascii?Q?dx3eyZnPgjelC5sr9X6H0kfPbTuh9k/rA5kS+PwuukgMNG6fKhxsyd+DDvBS?=
 =?us-ascii?Q?FIVdi/SvVgzTDW4LEASiXWzOQ5AiWIaC/XT97RAWRlJrmw3xA6BipvhOW0Rc?=
 =?us-ascii?Q?hkPvH5hMNw2Y8O/P43aWGvP5mzKRkX2lP0N0M4uRlZgEQXx5eafhEUhN3pxb?=
 =?us-ascii?Q?0UKtJKOGfMPk6NgyL8el8gHtw+1HVX1vFZB3Xcws3Mj0yOI7VJtSNRCq/s/0?=
 =?us-ascii?Q?7Dbn15wJgLqTDjVe8vhd1yVtXzQo3gRVa4v4pWE+3GXFraJBNJ/r9Omqx6RN?=
 =?us-ascii?Q?mZ4isLWut6V91T1cOak2J/XQwraSZh12uOyb596F3J308+5GH9zF7q03VHB5?=
 =?us-ascii?Q?/cxUoZVNUuw+m65gUQXLFBNIUc/R0O+QTgZjOxR6F/EDTHR9oRpICnClXI2X?=
 =?us-ascii?Q?Lbgca1uodZsBa3+toejvLns3SitfwsXPIVnVdlFf4TNmm8/bPLCowZgwirF4?=
 =?us-ascii?Q?tmATYpuqq4aJNkD6HL1Nj0CzxedW6odykjrO+6Y0wajD67m2FbaF9oXBxqMQ?=
 =?us-ascii?Q?cpxbUEK9TiXllbziJe0W9IAm3XFxi266oGopCJ0jTeurHzDIeLmAvtpIzHPr?=
 =?us-ascii?Q?ct9qAilk3svWbT2WSel8CWgyuDE4PB9Q+w7DNMQBD15EaWGFjiD8JjpASE+H?=
 =?us-ascii?Q?7XKXX9lqnfEcTWANwxQNpP4BerB9BFITlPht54Wdy1Ge956Y8fDauTe69ax1?=
 =?us-ascii?Q?c3LtyItIyE6WUcEo3tEWfed4o1JRV8guzxoZALzU36V0CpweJp9cY/Ix3Iik?=
 =?us-ascii?Q?wk3etdW5vkz+0fYVy7lWThqaGlMEsSzMy2OMvUcHZ0a0W1my5e/I9+1lA+ud?=
 =?us-ascii?Q?tA+H0CEyT8ebEjOfxZFHoZQUxJIP6joyzvVX15cDA3k2uAxaza74IFj7Ey3U?=
 =?us-ascii?Q?Y+3mySRagrnDeqWxb6LhN6hrEw7MgAM/HYaoYVqbrnOPWw3X4hoVApuhZUY/?=
 =?us-ascii?Q?LzjY6j9qkLroXt9INijF6uxE+tk3mWudMdlMgI8vMYCfGy7DfjWJ8yk9ddDF?=
 =?us-ascii?Q?oMxr22gIG4dzfZU77/MQmG/Z3dFjVtlZkG5O3cUxe8Ok0CtISX01S61EfOcn?=
 =?us-ascii?Q?Z8N5zjO7VSofAptFPcQqKPwTR6XHQmw1i/2XuXU2Gl1WJ1GVSrZWqz/u0PnR?=
 =?us-ascii?Q?ear8dzo9tpymz+vB1f961codTqc+s2dtp3EcHDhKd5AWb1uf5sdPqfAs1h7E?=
 =?us-ascii?Q?FYPrHj2h/ZvCe1i8i1+D4L+OU2FOvf/vmvhfiSgfu1u5UG+yQr4QKqPu1qMh?=
 =?us-ascii?Q?DEkuaoa0IuqknCOPixwfSir5WDMjPI0Q6296T6hXezCNEKuKvJF6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effe40fd-c7c1-4415-e185-08ded692a8ab
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:30:52.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAxUv4fAT6+GGpLNNMG5Wva+dpdoTZF7I29YFajij/dzF4y2Er7i8H3OpBFq88kFsHERxcvjkuDkUjWGDuLXgoJ/zE5bFDCNff2OwS/dTEUjWIiO9sUXpwbbyxdlgcQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10220

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
index 340ab0253ec2..1ed1a8282edc 100644
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
-	vpcie3v3-supply = <&reg_pcie0>;
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

