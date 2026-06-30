Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58D3F1AB6;
	Tue, 30 Jun 2026 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815451; cv=fail; b=dw9VSG8NHoSz87fcGlaIavx+ycFrlc9f+LafJa3GBeKsiX7ZH9qZcR2IULzu55hoKMAH+Iwc8HP5Dbj0IDzQk6wQRRhDzx7DUYlySShyKt+Yy4BItvI9i0ejf+jajO0l8PYbJQSlY0Vj1rgQEBeol3RNtP557nhP0iS6HgmLhZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815451; c=relaxed/simple;
	bh=xoLsHlxq/oJS9Dmub9mdLGixmQl1czUXko1Umv+SNy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xjk2q7GknVlUpFwNoPzFScBq1t2vvnBoZU8iU3xNZPr03MMt5hn8dgW8Re6SpwhrdF43bwBnPiOuosEpenaQDKAuaZoTXmL1feIhfSLwVeK6+ImyCvVcqabynnvnBQtfVLR6xX4NkIO31G7KIONt3id6nWdx022Y49e+Jmb3V1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OMzVWtU3; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OMzVWtU3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWy3qMUUvf3am8bURSUzbsYtd8qt/uUQ7yNb7d01WvRc/Hf/Htw7Yv9GcRtYM8CGCtZJ+1c1C7SlcoEQVXj3gc2ruuCWvJ1ujpiXdCmhYEgMNy8Xq+LSIqDOOr8z8eZF+zC6GEh9co5vlQlNWQQv3gxCUebdSl4NwU0fcdwHRtZSA+rJBNNsIG4M7mtwkJBc8gI2uUOVpgaNFocjc3ul+Q88l6nl1XeGPdDrbYTW/sUH7eYTHHQ+siAIekEzWGFiEsG9XPJzYYP790dyr0q/hF7gbeoNa/reDSVnDHajassUc3JnB0l4ivnJVJwPRSygHLNjOhkIp6/ihVwweaQBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS197ExSHKpYeQk8NMJ42jaTb8mDcEjztsuBckud7AQ=;
 b=LzKiZfeGEG9xEGN9YsuqgKa0gp2Hd/HffHoYvyUStctHJdgEFFBWpFGp0dCbU4OWf4y5furDJi3zCmG60QvIOt/rsomlkQnb2I0mxHsw2I7QXe9Fy5YKcldXh+d3cR6TrExSrqgkim9Ht09LiHT14ooNIcPAPOtxCbPRemMtJoeM72rU/zH6sOS7AbSL+hmARPl7V5CmkhIryc6qq5ckreVNWmC4LvReMFOQEGa0hR2tuRlyjec0iMuN3LYhAaIjHoGlHBI4eOWXlLUqW3qwsw9yHRLmbBvLNC6OBdbLmHzl2CB7STckUkJ7WxsdXAUTcwFUdIN9iUDQkHc09uuzsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS197ExSHKpYeQk8NMJ42jaTb8mDcEjztsuBckud7AQ=;
 b=OMzVWtU3WUNdNjonszFeDtMdeY7aeWvzjiah8z2/BwhCdVI6zkwjstIraPpU18+w9GJUZtxLIeH6TJPXw7sShW1trwSRIlVkbLlyi9W9PPywAljJmCsQJST/RQ7oCwLmD5DK9vKvYv2EDSpplMbWHBk9bgzq8xty+5+ZlmwYDNSTpk3Pdaeu5CaPU3gL9pkqAUMqtGlEBOqIlMwoVRZc0Vw6JgCkwhX9g0doMsFi8xCIt2YoXZI5ck+nO2DrcQA7r2ngsZUtwCMxVt+HLbG56yVVT0N3BSVRIkTEnuZqdRQjcfKwvSnVk7TY4b84D6M1Yaqk08WUapfjP4zOe8S1GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI2PR04MB10220.eurprd04.prod.outlook.com (2603:10a6:800:229::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:30:46 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:30:46 +0000
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
Subject: [PATCH V4 4/8] arm64: dts: imx8mq-evk: Describe the PCIe M.2 Key E connector
Date: Tue, 30 Jun 2026 18:31:35 +0800
Message-ID: <20260630103139.3823329-5-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
References: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI2PR04MB10220:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e41f72-e126-4390-1e8a-08ded692a516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|7416014|23010399003|22082099003|11063799006|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	kkAW/SXTyn5oWnZEbVBAOH63zeoH4DjTOq9U9tPKRH8hqtwwhum+akpkLJc/Kb7JmVvonEbNnBzKBwJiH5vnZM7E8J/5h1nrFULAXc7H1mg4yH1DkiVjReJaocyn7Jwd3LhGXp0mfrWS++o29mdZr7UY1an9vH7jRCNBQxHlhuCa/ujdExGI0PLaDc404msugfWDjFrAdERm9Kws/lbGp2LKdur8iRsrbklA51zEqJWdGD3PXz+URyMVDHLEOSyQrIL+5Cofy0+EQVNLllWcefn6ZkIT7uzlgAJg/bFbA4jB+p7KP+VyPrIhPg0I9u6fzkheil1UCGhyBaCS9SApD54Ikk3iKDp0e6cTuAH3HlaXaUK3iuPmcfDALAojnub7yf1bqgP6+NMiVGBYoYqITUsX9J0JaGYN1YrKCH+de0CdsM9GiWFmdJV7EjbJ2uKf98LusFGeIXDxJnKRX2uxko3BmHy03s+z7vbzBhIKMIdFxZVhseq332U5vGjH3F1nCSsj9owvGM2ARc+qXR2np5g74bA6e8nZ9vodzPQQ3t0xdXl+YGLZ4K80T0h4MRNmt8zoP4HxU7AdwKQh6aaAYkalKuXwMSv0Jkfyn0SDa8GUv4JtBoK0NPPVdtje+XuYLgtmliM22a/r5mHjDwoh4ZZeuSToYST+7t4PsTxHgHdIDTqHmlOgyqlLpg/nSEre1+NxsxCd20GkI0rfiqMDmA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(7416014)(23010399003)(22082099003)(11063799006)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z/+qpVl0FDTemz00YVqjl+Zjtugirbr77+8rchuUwdikok8AU83QlYzbHI+o?=
 =?us-ascii?Q?lnyO/NhgOprRy5lG+Czzpou4UyzQTnIa+mgajwrPEUNA86aDwC45VpyQTjce?=
 =?us-ascii?Q?D++eH2XVYyG0/LZFviMP+yUM5L66Qro8Y0e9DWwYdcRQOAESpp2HKOIwYR48?=
 =?us-ascii?Q?p2moSkVsZfOjIwxCIQspEceQUAxcO66UcFpSwQTEpdNp8QZgSk5anB5RpwhT?=
 =?us-ascii?Q?q48CBJZC+6KUT4rlVyWcVvZO32d5jZipI1RWm4nkGzly0xedprSGyRusJpG7?=
 =?us-ascii?Q?fUFamMBP5IVciHBv/yQAi+RdH2zpIHq/KM5wMt3UkjIstoeC3xe3BH18O/PY?=
 =?us-ascii?Q?6Y5HJ9biLA7ivqXMfZzrjqL2jELcL8qgyfJOqBUrfvn25Hp+V4Q6kWfDRuw7?=
 =?us-ascii?Q?m6b58/D/nH22avhDmOA6EOoc2BFhaGtiZMax/JiN81ZoosbYxh2QF3pAwKvl?=
 =?us-ascii?Q?KVNT077Kwm/wxMKsTzeREbbztS8iaS2JWX0hSTAGYrYvGTRCS/P+OF3zwEm0?=
 =?us-ascii?Q?DlDFBNttM3rfXRmKVnZWqywhYCScovscF9k9hXUv4bvPU5brNTu/zI/ClMmn?=
 =?us-ascii?Q?4O3kuYeeq1BUJUtf5drb49h4v1saiDv8wcTPLkfburtJKuytyukpnJqPCnV1?=
 =?us-ascii?Q?QXS8sDMiSc+pEpcTlTdCN377pxRpuS129hH5o09iWBAlDWEjkIu8VCjeCmPF?=
 =?us-ascii?Q?X1ZgMRUuTuYdxzNVVPu0eI/fJqLPg8+uTk51rK7Xg5c6j29se5SJeGrfMwW7?=
 =?us-ascii?Q?kQXhzf+g7R8NGtQOer8wFNdPdEcL+GJQE0ioVAoxC4kZBSeMCG3gaN4ir4Q5?=
 =?us-ascii?Q?tmSgWGzniwRRrhA2k2ipet8x14MENf7yrMxGztVPX66Qe9Gg2gtMDj3NN0pE?=
 =?us-ascii?Q?XLxowl7caUZA8HKxZYlrfSKnMRGVJJyPTlEdCmENe0C7vS3z904lW4X9Szwn?=
 =?us-ascii?Q?9Zs7uoktq+0FKHxG2UKCV8BSEh3gMwF6pgHgLNqALHvqtFAZkAWBIuozFqjU?=
 =?us-ascii?Q?z5W0lMHagzRe9krPdxPJeU6IGlvcraVE5rmxPGZuW10ueehGYzxDRob+RcPS?=
 =?us-ascii?Q?+JlVbU4YUuBfzbf2w2Bufm5U7PwcYyf2xev50EQ/qP8BdH5QHcwcH0DG5Gh5?=
 =?us-ascii?Q?NfNJfIIOINWpe0Op+uW6/ZpIThHK2df4XMkUyC42ODUfoc8k2YUCj94nhsK7?=
 =?us-ascii?Q?Z797ZTT4Hylk3xAlTwcxEyccorQVjcqGgw3Fmi+WmN/jtDiKsjZTZVGZrGCQ?=
 =?us-ascii?Q?Sw0C1wp6aDBGBxkC57YHwKvaStfp1M4w99CwopP0px9e6CmreF7yiSOIwcfW?=
 =?us-ascii?Q?4LW5Wo2cSipG/M45cHv+aTgUSC9EVCCqABww6c9yh/uLVvfPooEOl3si1zFT?=
 =?us-ascii?Q?ZnEpuVNVUgZM9eZtN6tr0VT9m2s5UcFWEciJPba480vxhIgpLCN1hCH09kMk?=
 =?us-ascii?Q?j8N65KvNj+AC3mbafqMLorev6X+/VX1yidOCGpRfYOMh0KvO4CSX77Km2Y0Y?=
 =?us-ascii?Q?Ri7PsnilNbwSQkp1/L2rhAMaIcEx8Z4GgBTzhvP+TgtCP9pW7x3jbVBHmfHe?=
 =?us-ascii?Q?jvE1P7cMb/cxrNk1Y5uOn5iI8KM34SKEWyJ94cN8AD1POsPC2gOW+MUcR/ZU?=
 =?us-ascii?Q?wOMPWSsJbOz40/VzW5y6GjkOx8xGrYxWCTOXpD1lRiMqdEU/OUCz+M2pkE+L?=
 =?us-ascii?Q?BSb8FyXMq71lIi0X+RTnl+Jf35DsbWbvQ6/2RNwluaPEOhb0L9jn0A40Z+rN?=
 =?us-ascii?Q?I/kj8TN2sOo/xlODRmnmhifhscTvrZtoDnOP8k6m29yyrvDc7lHO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e41f72-e126-4390-1e8a-08ded692a516
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:30:45.9394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dF3AZFGufHiW9VJvOnIdwmsKCIJCXSbghEyZ1pfu1ljnrEYMIAFeWnUArJ+kKrYuI+8nB3UX4RfHdV8+OpoLb/hic9qRIeyDXIq2Vs3PFRaXXuIs1BN7LI6xosW8yLQK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10220

From: Sherry Sun <sherry.sun@nxp.com>

The i.MX8MQ-EVK has the PCIe M.2 Mechanical Key E connector to connect
wireless connectivity cards over PCIe and UART interfaces. Hence,
describe the connector node and link it with the PCIe 1 Root Port and
UART3 nodes through graph port/endpoint.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 44 ++++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 383a0976d457..482e5203e879 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -21,6 +21,36 @@ memory@40000000 {
 		reg = <0x00000000 0x40000000 0 0xc0000000>;
 	};
 
+	m2-connector {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&reg_pcie1>;
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
+					remote-endpoint = <&pcie1_port0_ep>;
+				};
+			};
+
+			port@3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+				m2_e_uart_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&uart3_ep>;
+				};
+			};
+		};
+	};
+
 	pcie0_refclk: pcie0-refclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -420,8 +450,12 @@ &pcie1_ep {
 
 &pcie1_port0 {
 	reset-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
-	vpcie3v3-supply = <&reg_pcie1>;
-	vpcie3v3aux-supply = <&reg_pcie1>;
+
+	port {
+		pcie1_port0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
 };
 
 &pgc_gpu {
@@ -506,8 +540,10 @@ &uart3 { /* BT */
 	uart-has-rtscts;
 	status = "okay";
 
-	bluetooth {
-		compatible = "nxp,88w8987-bt";
+	port {
+		uart3_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
 	};
 };
 
-- 
2.50.1

