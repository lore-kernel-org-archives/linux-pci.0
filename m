Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3736493A;
	Wed, 18 Mar 2026 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815367; cv=fail; b=bZNnZ4J2I8y9WDMwrH4jXqMo1WJryGJCWbQATGPQ5FN3boFgJ9DDgN9N2C2l7CIYVKXCe2b1s2lT/jPsj8EhUeAmg7A619QVpGYg69kCt7CJMFl+mmCSgsjBRh65u925DYqAunAzhtc/zHcF3BrxJ+Pzqb4/o5fDJX2OE/lL6aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815367; c=relaxed/simple;
	bh=x+jr4m49wP+8i2/FZYDMOQfGG0j2TOvL7tn8QjaWo+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S47pk+8oS1VdxG2+o72Dbqqyersbd3zEhcVFOZF7pYML8fHZpIOtJfYbI+Rs8OE/Binars1a5SRpUlR/2xN7sZNiYU50ch4lzBbvdSMFUdSOQV9sCynEHVTbSA0ru6EKS/M8PUcFfqJntqt/TDUBtiQQtVHCrZLt91ceRn6uBkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ECLm5F+x; arc=fail smtp.client-ip=52.101.84.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ECLm5F+x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9yFoyKeJb+VKXRGtwVUGBgDlLqewPCrziaWrxyCzvOcUOpr6pYUUl0NIUd+NXPyflOj/Tqmnwlk8q20IJnJpxt+LfA2StzaUTgxdh6Oh2JsKJlGatjh/QQrEanjU0eZ95qg0EDjLGJLA92Z4m2NgvgOHOZy7w25HZmYTK+ozSIw7ep4Bp6DRqZnMRQOWjLH0ZksB5ODf+JjTYzKiYBWAdMoSqMZ3kDsVlDw0Xm/dUFGaeFBjP694YtsH4N9xmM0y8S3VyIJdKrKaAYFHy2uheAJoz68BvmQWZBXUzbiqDB8QtrV0xZxsdzIj0dwZR7i1Vk4NEhj6kryEhY0osqEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQRbIJIKrp1TwmDhYhB9Zfx6X03aWZARMa6qioX9YUo=;
 b=SY9Xr0DA4hixo6Gac5AyQphXV6UPyHoJuYZYgeT/5q+H6A48pTUPzmUXHN8bezSl0nZBRwkDZN32rDCGcC58j8URFCnpDKhEqaEhCLsYdyjypRX7xpoV0nK3NV95+qfMKJZUCc6nyFIuwnYtnwFyCWjNaRdmEdDro6DWDoteMjEcsDuFioDcwVjgbuECnesdfs9ia2ZFdcrmU5Ea3LMB2n8UUG9owI61B6GWWgALb/pqZ1YFH9LnlH8HXQdFiEpR4/p0E7kYXlaiS5xxPZR3xx2gHzBEO7McivUlMkdIfqebl+5eCP/JqK7FBv+9iJK7K89f17aLypVnAQLwZU0KLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQRbIJIKrp1TwmDhYhB9Zfx6X03aWZARMa6qioX9YUo=;
 b=ECLm5F+xzlclsbf/6d8gCP0qHfzCzitT7ix04xbDNQZHsiZDD2p3FqQHnIsOwVtfgrBq6q0YJsVV5KRtx1yTfx2tvRx61u1dFzMZYkePPAPzRz8gl8cu8nx6p/Zqg4oIV0W3TXEscRJOz/N9XD+Je7Gk+7OydbJA9VON/VJ4+Z2lxiBTJPPSDQWSldYyLqDKiTM3dH1Dsye2KuN1QKC4uj4ZkDdld8UM9PEvF/L2oIQIxt0kgaUaZ6YR3obq1D3ALh8cmnyeK9IoYRC3BH0W6Zx/ic7o2QZVmdeV3VOyj9MAaMnIkMXr5sLZhc6cPvaYFPKorT2x2zmzdGS3RxKQLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB8021.eurprd04.prod.outlook.com
 (2603:10a6:20b:2a7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:29:21 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:29:22 +0000
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
Subject: [PATCH V9 11/13] arm64: dts: imx8mq: Add Root Port node and PERST property
Date: Wed, 18 Mar 2026 14:29:14 +0800
Message-Id: <20260318062916.2747472-12-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260318062916.2747472-1-sherry.sun@nxp.com>
References: <20260318062916.2747472-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS8PR04MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: fdccbdbe-4e8f-42eb-d7e4-08de84b7b103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IIPLV6zSCmlaS9CAwlvww1SGmkkrIulZDjqCkhk16tyI3RXg5MtaAP2vM1ky+I1PTceyYtNNEHF7ics+LDIJwAkzB5aDXswO1taiVbA8vW25OfpM2Igr3BMWDLlaRjfUwczN9wKxb9uvbFd4sr+FN2ri7kedCShT+Kag8MKkfpOzcIhgCW036Pi8hfeFi7d8IhFr2XO8/7aosstcAmUo0lWn2e5OdWDlrWJNi4HSCTBBFoaPUQfmNcZHdT29Po9ubuR0ysAYESQMGsxlgGXJYalawqGHSyQMFavY+dQ11ipSgFBwviznF0nWNp/Y/rIu0FJusOQqANdWcmNbJhIrwtwe2pf63KfKmO8A+mGcFrWV7XXp27F5W6MZygtNL02Q3BjdcsR4isSM2V6Zl+GnirAr8FvfWEeKp3j4PuotV+K6MDqP1SN0XHAkZ21P1AlWOdiv1JzphbcdL8ewxTMnssTkG6fz/oigcjIOYP2WrCxNyizFV1qyNnTGKFVfr8iOQJzVmNi0+iHW2Diu92YyClFGJgfaRBcaEdtf1Dn1PB0nZgp5djElr6pE0yiOTPByd3LCbkCYYpMIgIgY/rmAB8RDidxzXBE5i4P59nlb43opC6K41SCnF9ynT4cHXf2PvzHgRgTFoDT+RrecmW0h8jLSvsuFve7zblcoXVffT5I5WiSBChbV5LQNZWxjBg0z+UMtCkTKb0pbYqYDep00Ganogb3Q0gufCOfmy18x0N+rlPJiLuqib/IW5dZTOcEL2610OMrXhTcLOSewqPSVxviknsLT35B7KH4PevLVkHh3VAmI+rFqbQbrcB7ypK7O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(921020)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dblhL51w6OwrKqhqj0RcM09J261t0fFw814eU8Z0PRBImE+hhrbGaG0yaIHB?=
 =?us-ascii?Q?FIGckgs1seNdZNPM9A7FYaJ53tA3VEsNSylfxfEEkFE7BlDT9U5FYH/nxWWg?=
 =?us-ascii?Q?44n4bO1pOQQ/Lr4O/nEe91UDncF3pdLAFZUAk8WygCSY6vTtQO0gLXIKKjUY?=
 =?us-ascii?Q?lYD1nJEodAFxunbrl8quJZdV5fxsn0GxF50MBgIh0QabJw7gTjqcFstaNeMD?=
 =?us-ascii?Q?ysd9wO/VS/wktGcp3u3LP0TIyoQOwVx2Cv2H/F3XeT58N2ebb4zFO9T5+bFg?=
 =?us-ascii?Q?7WWlwGGcf+V3ry7/40d72On8JtToposczWlYzciA+brXstvnvEJ1DdWhM8wH?=
 =?us-ascii?Q?P/Aplzb9Nv8G5M8oN7rMGQU9hrMIE9M7yng5b/bXgov6DfuyGbmlcsqQuOqi?=
 =?us-ascii?Q?zzK7wXUyGFJyW8bDiJGOA7itQJUTWuk63/CmPQXr3TXZ2zBAel95tvelSf+Q?=
 =?us-ascii?Q?V2FTCeDBA51EiTsPsXgBz9f05I0H2K0YmKDxiRwGBigEuxYI0qYgd5hMKDGq?=
 =?us-ascii?Q?DTt3cop9fH7EnxE7Hfp1Cvv680dG4/ZmVFYmOdELzypeK4QRsu2GTRUrV9Wh?=
 =?us-ascii?Q?AMMj2YWxpLwVDNPSxP1UBFEgwtUx+JEnmxEABYCfXuaKHX6lk7gK1jpGOyxj?=
 =?us-ascii?Q?dN8SfnxCyGtA/Zi7aAovbF01fLpyeJ03gFM3xQDB3x1ypSSnoYK6QUMAFVuJ?=
 =?us-ascii?Q?ASlEKp7j/UU8uFeMUn9p9w6LVQ5DjmSnNo0UepmErmjQ3kuFKjcAcDFbSyQt?=
 =?us-ascii?Q?UgLwf7g7wBb9/G8a7lNe6wwoSkfrjmbzqcl3tF8UnXJ6DmUxs8tu4knh7/VJ?=
 =?us-ascii?Q?3f1E6cHZJzmuvcQxaywixMnjG6xZL8rzvHZnFW32mYkPc9s9PGQquAJ04R4d?=
 =?us-ascii?Q?4DA++7uR/WRKWbwYaTGYZij0E0EBucZbrkpvYLZLjKDRq6yt3f7X90o8zAuP?=
 =?us-ascii?Q?UChEeS0vHy8P9wd5sdH5/uiCUryXO+O9kAlhOqW5aYsw8+9O+aTLZB0XhwJp?=
 =?us-ascii?Q?WKARj4iy9TSQ8kFBBt2j2ix0TA0dN8YNGgOhoAXed+W6LWFsa9+8WXvcfdIN?=
 =?us-ascii?Q?GvkR5isb1m3qNQ0GGVtTrA3r/fZfqLvJCaiStjkC/yLnNrpeKZzTfqb4WhiE?=
 =?us-ascii?Q?+dIxheqHBv946FkKYGBhot/CVanCsmHosfTzZ5r4DCVgXOfhb31hShtbW4i+?=
 =?us-ascii?Q?GkEMUVtjUcNraxRAFc3GxY5nutB4x/TomnSlhv1Rd0gQH1/gDSrCmEAdI+a0?=
 =?us-ascii?Q?EIC/ObFxiTXl/MEKJg2AFHMi9iHHrTp/D90VQ8mirEJ28cyDTR5Tmbu5XxbV?=
 =?us-ascii?Q?PTHUFYNsJibfVFkDjBJBOAT+WHf+ACYg7PZT4hhct7GQ9Iy/EbQUL9t+LLlD?=
 =?us-ascii?Q?AKxRnZydlpAW7kGXmd5HcLrDJcNePq7Tt6CwTblqVV7sllWSrXSoodHAwnLn?=
 =?us-ascii?Q?FOI3inCOdHbScUQH5JtIt5JYV+Lp7/VwpwTUK87ksRBEbupn87fwiMmNtN54?=
 =?us-ascii?Q?VbJ+iyVuFzbhSlOxKcKIb+aTp1ImhhP69iOHvgmRkF5KgkyRcpC+Q1P1Gdrr?=
 =?us-ascii?Q?dhzfWyZmIxtFsBCyIy0nmzOnd/f+xL84aLPD0s1eox/8/PM4ctVgRmur5UqU?=
 =?us-ascii?Q?3Ml5hTYt9Hl2mGscktpBOi/0PKFY+ZlDFWcKtECwtH/I7KAWzBL2vHt1BvZf?=
 =?us-ascii?Q?y955xuwsWrTlE28D+ZSgFq8xKkrfmk+O31z2MwlNcb+dKd/I3hG1339NUo9+?=
 =?us-ascii?Q?8sks3gPxgA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdccbdbe-4e8f-42eb-d7e4-08de84b7b103
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:29:21.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuj6L6GipqUho9r+iN+LASn9hB4xAq/0By4JMXRHOF8+E8S4u/oohWCI7axJJorcFHDphBTaRc2Sq0vVYVsZ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8021

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 22 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index d48f901487d4..e7d87ea81b69 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -369,6 +369,7 @@ mipi_dsi_out: endpoint {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
 		 <&pcie0_refclk>,
@@ -389,9 +390,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie1>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 12 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcie0_refclk>,
@@ -414,6 +420,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+};
+
 &pgc_gpu {
 	power-supply = <&sw1a_reg>;
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 6a25e219832c..e60872aeeb49 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1768,6 +1768,17 @@ pcie0: pcie@33800000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
 			status = "disabled";
+
+			pcie0_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie0_ep: pcie-ep@33800000 {
@@ -1846,6 +1857,17 @@ pcie1: pcie@33c00000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
 			status = "disabled";
+
+			pcie1_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie1_ep: pcie-ep@33c00000 {
-- 
2.37.1

