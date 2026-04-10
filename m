Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1432DF13B;
	Fri, 10 Apr 2026 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788241; cv=fail; b=XJfRpjljoPxohUQ/pSg7REH8iTR+mo25scauTbMu8B0CemGz73sA/qVVV+1ydFDCgwMPoEi70MmJw6oTA1YbU0S+lkjNuSJ4T6u2qKSxbEIeFVvx5T1wvhy76aSLGjVnifxRsD6mZl1ae2MMv+NUZlk0cmgdnPyZAkBZZ7lm4ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788241; c=relaxed/simple;
	bh=x+jr4m49wP+8i2/FZYDMOQfGG0j2TOvL7tn8QjaWo+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IDhvKdvnxIl3Bfsrr415WJder9q2x30Bn8UThcVHYFTik5YAsu5q5vZgrLbG90xZyquQbjXaBvn1dUUtqROnyTRqXEg2Wyrb63vjdCcjspMDQ4dKeO7KTWMwk5uObLKhhQHIDKWNhOR5Zel0Eg8ePbHGjK1Qn+2SuL882o8CocM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KDcWvm8K; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KDcWvm8K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiFpc1UkSzSxvR4OrnLBM9X1A/xOBz8ZMX93Tctd162u9kpOzHaq+ok6dm60/AC01TEf8LBEVuJ9Fs6QuTRURAX2btP3exP3CfnLHDy+vTMnUmLYCTWjQiLMQPRWUYatxI1GyieuWXxaq9UroEm5GjX11iqWtHyaiGIJYPfs8OqWsu1Zg5fm3WF1VLFNIiR3PszSem4AhXMia9sZP8CojcKe3fFGvqjwVSf+3RoyyiftigBLjjQCVy2JhWRf09pbTvQcIQISmQVcfW7IQ6IWT7N8J8ZOxJSTM0YmCkU9IdaH6d7gS3mUU+VGq5DrXRx+JudpyJ8N26kDt7XItgwh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQRbIJIKrp1TwmDhYhB9Zfx6X03aWZARMa6qioX9YUo=;
 b=lx0FozpJjTRZQcrAvQEc4DWmD1z5Nyw4euO97xulzyHOwYdto1p+RqgQiWnv68iPH7mfXeep6gwmzBjFOhRbcXP+LkeyieCj1OjI9l1PFSmodsxS/KPDkg8hkuTvfjeFU7z6v/Ubqt2jahqo3ZVZEBN24tWeD2iYBCj6ta2lFMunuKd5qeCwVn7uDc/CnfkSFn5tRa9lAZ0YF8eWLA26LrwqxUZAuYhZPfkRvwZQoPYETcZij1bt1JOex3v7AQLTpmpsuPIml4fcdPl/OjBONuMQlE1M0w4Ae72MI2YxpI4aBkmBmMQKH5fwZnSmnBIy1IlxRLAhspPAEaneBgKScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQRbIJIKrp1TwmDhYhB9Zfx6X03aWZARMa6qioX9YUo=;
 b=KDcWvm8KQCK139WSDYIbFg2CVb7J5B9gDtUkIGCa+x8TNzvPxqY6Mp7xlxh68gpbUbn9Tsm4JFf72ZzHhDnudjT1QMcZlBNpXHh34nWy2S8oRyfBzqmVQECNvkVEyC2nJj2ULD6t59uJtF+ISYofpAONeSLa+53rWg9FNuzfb6lgwR1P/aNDs5G1spKYnnVMevuFtIyeiO+mjWjeLmxr1WZW6cWYm5RKAOdNa1VI41aJ60bH7Gnnp17y2wJLl/hKUOlvsLxYVS0VYkJLEbg1FgmnK880zwwbGzypo4Z6iLrAFhy5exkDau0/mY81ucdWd3sfHFJqzHR3tPg8JbNANg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB9826.eurprd04.prod.outlook.com
 (2603:10a6:20b:673::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 02:30:35 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 02:30:35 +0000
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
Subject: [PATCH V12 10/12] arm64: dts: imx8mq: Add Root Port node and PERST property
Date: Fri, 10 Apr 2026 10:30:53 +0800
Message-Id: <20260410023055.2439146-11-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260410023055.2439146-1-sherry.sun@nxp.com>
References: <20260410023055.2439146-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db61c2c-6ac9-48e6-819f-08de96a92546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aqoX6ZN4e6iTqz9BUq8fFPoM8WBZKVeKOayweUbkV4iKRJFYHzW4EgSJ6UGPXD2m29CwQaWoF7kTwxDwWSUSronsOm8M/0V5t4cHW4vGtyNI83spql36vD3snrui+Et3drih4dyzL2uuAdwdXRlQTQtkdL8FWl/jUY4slicMPe5KYGrokkfa4i0VWJsUNjHgvXgs/0SOeh2wClE6oJIv7hLDz4rLn9V/aGtfqeqkkMcbE2cM1OEYahVHhVg8I2msYRphM8BSbFN7iNCPVZ1yxOrM5W/cPJC/62CgN4yRJq8CMeqC8BWo7UY3dL9H7lPFxpfhWH04BZL2iduTf6V9qlb7pam+oHqZW7f8W880SzeisepfR/4Omcxk3uNN01lQhS2hYqsCGFrFB/iBXJoEMHdmVqP4z5D5n5aJdbT0TIkpheqazgSeMHgzDak659pUQK+lzaxggJA32Z9UgpJ1KDR7h5MkqoWbSndHTqs/CUu2Dt9PibKba4l9S0W1BJXeqxme530Tu3P4VP11RCZ6R7Fae9UsONkV7BRFSEt4xO9PvqNB9gIlsxS5YQG+BHhhFT4dc7XCOy1WecTlcNNUPDwmYC4kjqeAWDCt1IR8guNofpi/+5jCF8+tI5xrtEjuBOrVmlGRfTKMDVG8wQCj/IPqsXUsvQnOJtdexVlV1vuj/6OPxunag5ArM+3iFWQbXB/upOxfmYuRb2mFglEDBRuFozpZbfVCV9QQOaJsv8UcYxuPV+Rmbr2/p+yZCH7MFCBf9Y0yNNScRs95vWA0BdCWPF5BO7Irdoel36eyzefACLszvqbm4zBTPoUNpV1I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n4rqyWRu4up9vClFYNRRxw7C7Tche3hj3YE6FMmM7hFrh+uoL3W7MmpAOoEb?=
 =?us-ascii?Q?ULuRqwaH220oFVn/55IjuB2wFHoEYeySkZoSFqpCv8R4yashaXECAj543tn8?=
 =?us-ascii?Q?YZx3FWJTzgUGX4PAlnk9Co6bj2TYEFGNkeOOwxLMTBBp/QQcqtoG6QqN3gwO?=
 =?us-ascii?Q?D1kqjTfQj8hAQ8x7aY9IriGYVRYOIpR93QxIHuO/xXNrzkXMfrvrYnxyMpO7?=
 =?us-ascii?Q?5ZpoJDB+px7qM22jXeCG5vlIE5R8YtIjTf6DsTY+fIYChrNoBrzD2rUlKciI?=
 =?us-ascii?Q?eilBK1ANAfSuMIoEnboZb0r/K+guZ+l+9yV8J42rB3aBX95vyHozFS/Xth1O?=
 =?us-ascii?Q?FW7pKScCbUog9pLXdcOyRYptVWXQqKY76F7ho1GrPJhjEXYGMB/S1aIWGPIR?=
 =?us-ascii?Q?eeLLDdyfalab26NyYwNMj8h6fMKE5fXac5Z+ggyWa+1u4CKwqPeahAvlVmtI?=
 =?us-ascii?Q?ffAy2eH8emDCeElGq0qZiUJmsm2KJXxQeutoZup0Nwr97S2yBdSDvdqYjm/g?=
 =?us-ascii?Q?0nlH44hiNMOAGA7VP7K3Cuzjvgg+6a8yCOCwIUByaFLJLFiLhi7hpdnbBuTc?=
 =?us-ascii?Q?Z7lm14bD1w41ypDyHbWyGeIZAYaAB4OLWjCrGmMqUG7lWUVRwnuYiZQiDVvC?=
 =?us-ascii?Q?8scQHo5xiN6mXIPpZmaU084daiPkSa3anzcBv3Iiqb04qa/trASOBXhlVeCL?=
 =?us-ascii?Q?y4OpOECLYHqlmrA+YEJy71BkYnVf1dw3Ii6fbxSvZPLWKFNv3198AWGS6G5m?=
 =?us-ascii?Q?5x573BB83+xGRbygNl3PIm/AT7jRW3yJfw2GfiQ3yudR+oNoN8PHdvplS64M?=
 =?us-ascii?Q?OjCsu8MkgppK7ucuXOHGWBBrvmyK5YFyQH4EDTlBzqygCgSAF/WiFWIy0OAt?=
 =?us-ascii?Q?SVyN7o/1nCjgfZ6nMEjKQuu1K7fDSi1rdA6HkNvjlu+lfXNwaK41+YinyBE1?=
 =?us-ascii?Q?6Puer2IbDY3DsyMAwOc84Z6laykJcqBSPRq0R1LU79aOhpwG6/zX8OiL8w+C?=
 =?us-ascii?Q?gyKlAB7/7I3UvhjZfxMI6kqWFKG2hPiS4pZilnDU9UqsaYUhVTC527mKMcRu?=
 =?us-ascii?Q?l0jsDLxaNgkKJ7ZUSn4z90UGMPvpgZf8zBWIhDT2GQ8oh2R2u9dWyfAm9ZGU?=
 =?us-ascii?Q?A6Qz3+pdCi9HskMvjzJOnmM8CCzrVEWuPyrC97TQOiLD3+kweT/FS65E/4+f?=
 =?us-ascii?Q?RDdvbD1mdQ5o2Du/plxtBPTsZLXf5fHiYIZo/dd15iQPsa2PJyPZtt0rWPiU?=
 =?us-ascii?Q?6h/Uu68n7RhXkzyaM9l057GKGeSqCKCliBE7DLrJv+yDGZEYPx8mnfbP9IDz?=
 =?us-ascii?Q?PLh/0ke23K0rye6UqSDASuz36a/cKgHfeF/iMGK8a9LfiiTmGc91xR3tvWpZ?=
 =?us-ascii?Q?8nQmQZ50z+FUuQHfiNDAiBNBeBeIeoO74H7hQA3X8ZRZrPVIBOQP0jJDUkhq?=
 =?us-ascii?Q?9gpoI49uzmLNU/CH9gbq1CYeLmJHxBocprkCYzAPJdJERBWLEnBX3c/+6p8p?=
 =?us-ascii?Q?TYDXpe9VhHoqoFrbnG3a08EjTJg73f8JLXSCPy1+JOW53OxgkbPd+aVKP0CQ?=
 =?us-ascii?Q?qjfetDQVPyp7K2xdTcYuE/sxWHiJftL+ZnWGg5Maepvx/3s3wcQxO+a6EIwU?=
 =?us-ascii?Q?KJtttSXro/oSqCvSe7UEvK5GuSH1RRhATpf4j3f2m7LsNEr3knchplUIuVSO?=
 =?us-ascii?Q?f/Pvpo7ct/CbtRKBW98g7ZGgGyrYUbpOrbwtwc8txgJTfWRV78Ijb96cS5hw?=
 =?us-ascii?Q?EHDdrvG/Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db61c2c-6ac9-48e6-819f-08de96a92546
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 02:30:35.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SRw35TUtpUI5e+lRlxgAuIhihsFxhbfS/zIWvO6s8xaRE6he2FytdLyITnSYEamJKHb6UCJyahs37JHxa1qeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

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

