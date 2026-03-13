Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F8033F5BD;
	Fri, 13 Mar 2026 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367750; cv=fail; b=EgjvsA8iRTbEGGQqqw+AmEUVF8/+OR3qFF/RpFsPk7QxLc8sNLaCY5kGyYg5lYgoJkoOjZPMlZDh8aotYHYhgWHh6DAOOLt7dn11SRj5vWstcOCQ+0AGHhoF1Oq5S/WzlNUXMc3pucUoto45uHGuE/Zq7POX8TUcHdgrgNhrQkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367750; c=relaxed/simple;
	bh=TB9G8cHydqva9M971aY+RbsmjdA24fxUMKy0mCVwjDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rSoIqNW6H6tRE/Qau6LcioibYUSgwDk9/OnoHlpo5v9aRcWVaUbs0EkRqUSMxd/Ny3xt0SQSxm7yJIGXlK84uy09hUa4VOpcv+ZpGcTGwlXzXnyiy4t/HhYqAX2pDyYvZt+xr8X5ElDU4SejZ4T80CKd2BA7hTHzj6XpPg4OvGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DUts89QG; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DUts89QG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/e8xsr7xHQvklShlMP41k4WxxkBR8k6BSUd7jOk3ZYOVZF2LopoZNvHqzziJ1wdJSSs2HYRQmfZuo2TgXyzC7q7RPofboWZNjWymx3WWT6nnOHIBmUvCXtGHe10U1zYSzQebcg/kH47DPNiI/h5Tc8kaMU95zhFX3MN5gB7C6jhqNNZZ8RZHz/5hNFsB+OUerHHHzmUJrLIVq42Lnuj63glq8QnO2LNsLqabHRVfqfAx7/yaO+Rd2JEbKb4exbWKsCAAmG06Mp2lT6fVBOenHpg0Q1XxMpCYxt/l0Ffq4vsj3yxSOEKCfzFGZbb+zjJ5q8jMGo7wmvs0c8vr0034A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJb9oHe7kobPyTsQ/blsu7kFAjj9YJd9yLolL0/IInY=;
 b=mxfnQu+AeHRUa4UQXVGzcPDT9Xrm96U5uXqA/gGTRjqr5nzYViqvcgcK9cBz+DEKAl+WAcKoOnTJEgJXm32Zg0+saRPeRwqr08ZEVK4pOC5+97ZeE3BLjk6LSBIqnHLO9iSYbCbhvdb0aWNvpU8s21sf0qVNL3LZrOmqYgtukIZegGbZ0+P4NC/j6wf/hFzzKB3w837YclOgzv0wUybsIm7sCTZGRx+AYsIM5Q/1RjmxFbjdgyM3DBRbI7WFgpIbC4LSl6bOrFwKzvXXYNfBvzTRtCPOsT+SG7AdORII6orduh2UaCsTjeD9HhT0T7hpHSxHIVWwNpaUyU/4uROZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJb9oHe7kobPyTsQ/blsu7kFAjj9YJd9yLolL0/IInY=;
 b=DUts89QG8Ll5SLrryb8mH+NE8zGqXoYNHaA4Hq9Jv9m1VfwKLauh+3WrF5NrrIf9KNJPWeGOu1Az5WMa7dww+My7KgaQdkrdtdJ9rGfHAxrNqEPQVa5Y/TYbXCk+XqgpGLtoOxyG/f2Qj1hXG3pzHtpVW6pb6SOHOz7iCb2JvigLj10OJ9k7eK4c+AhgO6nClfw2QtpM7h4zR+1h6UM+IOhvb22wcYTTlHjjE3D7eR8i9Dcam1BnZBUK5MSx7MNvAQNo2iC0iInVxI5bj75GNqhSUInUCBnChUmd6cygR5PUq2sGNQErTtHb8dUAZeSF9EQR8QZ0SXqLM1b2jzm08Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6844.eurprd04.prod.outlook.com
 (2603:10a6:10:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:08:52 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:09:06 +0000
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
Subject: [PATCH V8 13/13] arm64: dts: imx95: Add Root Port node and PERST property
Date: Fri, 13 Mar 2026 10:08:23 +0800
Message-Id: <20260313020823.1592389-14-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313020823.1592389-1-sherry.sun@nxp.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: e94bdc69-5a4c-413f-7333-08de80a58135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r2f/YiXzujKKmLk/ptSErKPU7zd4BSa97GTuAt5RpJ8y9wNu2IsORuBR0rQFRoZAUtetjh++kS8o3YE87Uo6AyxWkAOKJrVvTO/E4xGGDIg2xjfsYZ/VptFgYooUGw+ZMxm3D/MrceZAb10DNE+Q09KtHLbLUvUc/Qbh/kPfENKKgPeZ/e5lQGrHaPANMNN93nx5qtkKkJqNO7lu9Y/F6WjSAlZLiXPbai60GC3BngINvFeV/VXlrKXUdw1jJEjuwsj9Pqg9wY/ai6eDVdrG+RSCCON5MZ1b+A+DKDtp7v2qJ9tyJhJNXtc0ydxlodS0C8MLufBbJIQCoAmkBiM+Ivyitt62fFIQxuClrfBmCf8NqwcmSTP4dL0mPZs94OqF4VVlFIPqxJvmD+6/Senn3EwyqhyasgqzoAAmjxe3givUxIZMQqqkpTKRUoqaGgS0uSSIMcwk24BdYB08HJ5Nz2DloD4bPxCJbcU7VAdjKZiMLF77yvBdsX/qJW5jKXmfokX9XBTUeMdNopNYBRykxgWegzRcGlj6hphEZYtbkfxz0rjmgpgZ740WFqMHNTEne8z8TYz8gZMCCIXJVUt8q1clXr17Q1a4Im507OH1C60SV8nn6Azcr7npWqXBH2IzWIYtmLvqUGcV74UM97YAJAHlnFavyN8LugnwRDMtq2RGJdzurdfrhfQwrcyYfH+iokrvViPE5yXib+pbN1//H5eBdvyMkkbqE2fyu5PDyzRdp8Mr8MiyUASVYls0xG9mNgbnZ01YHk0aKBbGNAOsdc+8EFBDUYkIsm6is8/lOJMX+qguCAAuib90bsQ3M3oz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ncBUVre04AjRdcDeVI94/f0ZSk1jI7Uoo7AeeMuCu3ce/6jIztzAt9rjBu41?=
 =?us-ascii?Q?oEn/m5Kl7cLUsOwglHnpHJbaYP3rDIoSGbOkfDSim12FADdi7iNl+3RgaUrl?=
 =?us-ascii?Q?2Xy4rvct6qrJyEBKf/5vb0bh6Nr5nsAK4YNrqcS66FuQ6qLeEFj3V3jKi6w/?=
 =?us-ascii?Q?AxdQ3j4LqxKn+8DC7np937vnL1MzWkiyDwhH0FrfnHhuVNjmdtLzPim1ZjE1?=
 =?us-ascii?Q?U4jyMf+rEHGU4kfTlRvmo/5QYgeTtOoYSdb36ytchoZTzh+nh6r3SH0xNw5k?=
 =?us-ascii?Q?v2U8W+6A8y+V8YYTtebEY9fC5zH7QN7RVA5r49gqSmD2tYGcwYMLKCC9ksGJ?=
 =?us-ascii?Q?sElMfjFjPOOubkSGvo00R3cHeuZHJk56l+snnsXjnxUij7+H6fcWjyF6fg8g?=
 =?us-ascii?Q?lqLv62TPDvK4ltF2QeHDJKNuI4QrcyG7Mttps/8C44awM/DwkeuoNTRAhU0A?=
 =?us-ascii?Q?jeoxuBJg9uyUEoJJsVSGNhCtfdc0J53Nbogl5+kfeONlx832ZiK8jkvOG2/B?=
 =?us-ascii?Q?20V8Rmw73U7CQcQaSdmLR7KzxQODpKICbOjcWfWa3otd7lwbqkt8Jf1l0Onk?=
 =?us-ascii?Q?OBpsP/CwoMcPV7/022ofr60mzPZfBNenHeZVJs9YpvHdYTYXTt+1aObFdOhy?=
 =?us-ascii?Q?9IG83A03+C4XxXNDGek1/W+Pc7qzcCBc47ZS65HAUYDwOKAONZ9nTI1poBXC?=
 =?us-ascii?Q?mT1XZMNfCO2nxH9jTZ28EIOBfFk2KRlc1t7QlP101ys2boMFBMr1NQOz2wmt?=
 =?us-ascii?Q?CP6fob3NGcP1yVkdSJJdGL8kovgl6kthLtr06FLLdWQocSnpgpA+YcutKNNI?=
 =?us-ascii?Q?x8o5ZlxeZlvCAPxLUHWdrIn99v+LPLPluZAwQK7beX5MMQUPtplb3kFkM47v?=
 =?us-ascii?Q?4ZgRgaAhnl+CxkAp3/7zE8on86QoaEJg2riJhQ7YXKgieVw5uxHiKzpiy6FB?=
 =?us-ascii?Q?trP9q+NYJVC8PvG8t/5eW2jqR7Sqace78bVplUg3rqRXyP+nstEtX1K8QywF?=
 =?us-ascii?Q?qL0HayC8B42qzHYz7aSS7I1T1J7eW68fbBFmXsQtxvrrbw+NFEeLJhCPJY67?=
 =?us-ascii?Q?gxaC5PmUuqo1/4e2JNb/V+CHyNzpH99uyo4ebwVW6E2waF3sJYaOoSK+GMoA?=
 =?us-ascii?Q?TviSJ/oYmFs9OQO4GpKxCJX+bFaTIR3hekHtwLVVf8KYx+LjTkhQZdC7bTiI?=
 =?us-ascii?Q?UBX87PQ7PxXB+6ysKZBV5d0JNo2B4ZEhnT1T+haqW3pd98SNTH2GqE00jaHe?=
 =?us-ascii?Q?THDBVgwP6e3C7FuE6kfuCk3OVh9Wsbnw+889RdDUkZpUHqWLRcNMUAILf2Xy?=
 =?us-ascii?Q?SZCoh4mDK2KZQzyILHTE0Ui/SipCrBEl47AtjD8E+Uiyee2U6DSIlOX5lD7R?=
 =?us-ascii?Q?eM7Q7AyTr7fKKY2LX05dJZeZVIx8ztQ95/jDTzRhSnzGw16CI/KnUIdsO9qA?=
 =?us-ascii?Q?9J1PahDL+op3I8jffX0KD4exxKYrboFZBOwVQek4upc2PwrXZYUVXrYnCGSg?=
 =?us-ascii?Q?TIRigcw8ZPB5ZHIkfLqkkDPs1BXxREzk+GYyZvXtnh+/na0Eh0kca4focNn9?=
 =?us-ascii?Q?YjK71MGxXVu1csZi+7CrDLx100Ub5rf+WM4JpOyegKt46Vp+351Ihw0nc5qz?=
 =?us-ascii?Q?oJV9lAB9+DRC1HwzrUHvorT045GpeifeXtX4sckdqAsGjDe76OZ8vKrYwWaf?=
 =?us-ascii?Q?hzZHNrM5LQTye7bi0xwulS+vPvCQXEAH425tIaNdnx9HiKEGusdo/OxeGYVs?=
 =?us-ascii?Q?bMok6CCucw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94bdc69-5a4c-413f-7333-08de80a58135
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:09:05.9674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uyjSw35ViN0oEZawZwBuRpvY6DQmwrHaPDdhCCSvSok8SO5FqVDJQRvTCDs1QcQ3YxatHFeXPzV/linSALQvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx95-15x15-evk.dts    |  5 +++++
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 22 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index d4184fb8b28c..42bc09e48b80 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -554,6 +554,7 @@ &netcmix_blk_ctrl {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_m2_pwr>;
 	vpcie3v3aux-supply = <&reg_m2_pwr>;
@@ -568,6 +569,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
 			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 041fd838fabb..6f193cf04119 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -540,6 +540,7 @@ &netc_timer {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -554,9 +555,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-0 = <&pinctrl_pcie1>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_slot_pwr>;
 	vpcie3v3aux-supply = <&reg_slot_pwr>;
@@ -570,6 +576,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 5f61866e9df9..752236afce11 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1890,6 +1890,17 @@ pcie0: pcie@4c300000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
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
 
 		pcie0_ep: pcie-ep@4c300000 {
@@ -1967,6 +1978,17 @@ pcie1: pcie@4c380000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
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
 
 		pcie1_ep: pcie-ep@4c380000 {
-- 
2.37.1

