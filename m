Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0FC4192FC;
	Thu,  9 Jul 2026 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592048; cv=fail; b=eX5ixJ2m1Ss3hTqmKCiB5Wmj5K+eUq0j1cDgxhFOA1aY6wrDlQtrKG4AnY8rAmEuy4u5rjnJBB/Cw/Rvte8VhZweIvoq8SowzynmQgu01gzi9meF/XBU52zsPUZ03XWX6sRN7WMtxt4PffEL35bouxnqm9jVDxuztnotx1XdvyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592048; c=relaxed/simple;
	bh=gaVlYUmID78Qdg0bjv4Rny3c5Q9MZrWFZqAysR8gksY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=afxEhUanpE6QL8Ai90d0TCRb76gsk8dj72GWkDsvYnwDVjf5NSqL/qishFgSB8GgSBYAzpWY0tbI5pAnmMeKAX79hNVd0OdJ+/OH+nny5yIO548tBZ5HLOpxQONDEIbz0jV/u/5xCKwUEMDij1iah6T9YfY9R+5A3F1fZSjvzTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GhvwfDyU; arc=fail smtp.client-ip=52.101.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GhvwfDyU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6vQvG9NLIcT83vzCdVGMRi5Enfxx6QMWL+GqgUQfsABNULbvuS7tUHvGdNMSlBCE/MCjC0OeOYt5DovkduEuvgDOIIA5CMivpnmJTvb2dLQmXkAO9PXT7uF4MJZsCqlSr0Dt/LElbTQUqeDuBvC/r4aDPaOyyLSW47+GmZZvD8t5gyeHNlCfGCOoPwaxb3+hsKCOE3dxnre61Q1w92lDudtwbZwN37coG/+4OVJxrTHQRGIQpvT8BayPi1sX7Kl99gIVWi4agRJyvFczpeIpEQJDlKHJftgBLhiiXDJlx/b+RPTG5SmNAeUeAhoXHS01CmCNCkhqcnwWeQOkcCRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmSlTgbiYGe/2JPvw3yUOYyOATLeHJ0hM/0WUrpKlK4=;
 b=Ykw7KrPajaEQdIS5UAgUbiHaPkWicDIt4ZtXvgS8T4uP36c22APHOZ4UqowI6gkPazbYzkHtctFOodiu6sZ4atO7iJG8CU2+ZIYIINL4hRzAqsN8Rx1F0+q7uKmyo85qMAiukPfz8C9Pu4gjNdERJkSdu5rOG++TdcoEICkS5eo1Eyp3ahppZmISxVxfHQnUXPvrfibMI7hvrp7DRGzV/fzDpG+ZhDnVSghItAxYDCAmjaeCPek70wfX2EgxEox2lpDll9Ya/6/1jccVBLwZ/WQXHgBZOrq0dDA07Sfy3JmXesdDybDcSyiHXMxddsgdri/XSxKYDhV1/R7uUrOwlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmSlTgbiYGe/2JPvw3yUOYyOATLeHJ0hM/0WUrpKlK4=;
 b=GhvwfDyUkctlzYYWKBroqSy8Tcto30oMrKNhCAYVCGVeVIC7m+SL1zouKhCBhw57J9Kz8km6ObCiJ5zSsRd93ZVOGjUK5oRgyjWZ1PKViu0Idn8e+berly6F15COuaLHLmhiCd3iD+x7FEEjMsNvSmqdmjXnzqmOQQiXrFTFgSL/1qvEjA/dPZPQHVQ+vQP2DSLtZ9qijnWLEFIKJDZSJPQBu5epQHsSYPaElS8fwZwDNlIioqXu3+cyIwwIu5bwpQsTRH+kXqPpo3na8SnRy+mQqzaNBNEhFcDuDr7umuFCeKfqqvqlH3XI4jdfvTJnnjsmittQLczOc2aZTFxjAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AS5PR04MB9854.eurprd04.prod.outlook.com (2603:10a6:20b:673::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 10:14:04 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 10:14:04 +0000
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
	sherry.sun@nxp.com
Subject: [PATCH V5 4/4] arm64: dts: imx95-19x19-evk: Describe the PCIe M.2 Key E connector
Date: Thu,  9 Jul 2026 18:15:55 +0800
Message-ID: <20260709101555.3034853-5-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
References: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AS5PR04MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a28b80f-49bf-4e13-ea75-08dedda2cda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|19092799006|23010399003|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	xopBfaNjQr5MKnd2O69GNcNDuXUVJpmWLThmmHgdyKAN7+D69VgZJkufJGFCn7Yg9MPAk3/IBcG28pyg68SjAEHsYqDjuBKJ3Ai29eBTMo8Jb0/RH+ftfjAIItKUfOg2HXeuO8RcWu0124kjvlpDoPPAqIQdFN7haIJrysPVoY/rJ/z+YLl8zyQ9+h6BRwggufWhnHSpXExBDagW5lky542utdRJSVor0ad6Vk/Uu0HVwxc8ilSVgnMySUGCK3Xsf950fQqZRkBQwBtdPgcsg5H5RM3c15wI5H/F9Q96RKclkiW94U8reu8E79HwXSkI7Kxh9Q7ZBQyCmNChNDOhE+jYedhNeGtqOsvNFeUXGyWSN+KMagsn515qpJif00yOebmxzWvWhWBhr0LnetSEZeZNAQtjfgdoyeqvEVTNyQEH0IrWukrrSasHUbvTmpH7v1NtHofNIAFGrN/T8/A/1ECvZ7WxklDV5IqLzwY2QZsogIwhYaqWuuwTaJO2CVqW/4a7aa+L7xgTwMZR/UJVeTB9pXY9bDwDUUa6pnnkdx0VGSwzvhpGsMedBwONgDcIdUqHq8AaedRdDvKQJLuhwL3kyYA16WB/ItxzNUntTUxfe4iVl1RIS5SAvmfvAh4jE77lbMLSmNoObP4EzWWUCeyWVW3NYtsTObGy4epCk+BFrQ0ROgFkkyoOs+8VXyamVBmu5UUXqredC8roDNy8Bw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(19092799006)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6JlDQ5bwZ+/TowS5z1ObVuNYxFVcWTj2RFJVFCdTIwv5HvNcUK/77FdLp4O8?=
 =?us-ascii?Q?SwwQbhDpU+StIMPWuJE/gOxtFpP2TVDri+eDTSxG8m8el0WqmTPdqdFxj/L+?=
 =?us-ascii?Q?B4k0cNdZs7SivoWh+cJ29A1ON5z+pG5CMoQKHzblaRjSM6amFwXRaOftGu58?=
 =?us-ascii?Q?0SNV4/Hz7Ch42iRo0YjxDstyLI3+VRIdycOSEZBR9+IyWSc+A2kdPUh2s8yA?=
 =?us-ascii?Q?J2OHiSRsECtILfIHHdfmOKYJB/KP138L6/CztM10+eZ+9fupFjZXebfO/ag9?=
 =?us-ascii?Q?B1V5S2fKVAu7sU72Qp3CLxBsBd657McfJ9HYLEMaLB3uUCfAyFhMZ8fQ5V39?=
 =?us-ascii?Q?vnYK2q6S3nFJ4sWBSNR6wBc4pm5R9vZxrYyKsqv8GkefMbDRj9cCzJPP0rE6?=
 =?us-ascii?Q?eIBc/VhimkvNm8nbXwIWJKCW/O7V38hGRztCjCpxWyrs681pMcUKMro0FeT4?=
 =?us-ascii?Q?0srdkxWh7mwK5lX5DMOm7ND3iSQG+q5i1WPfy018XLALfahY1l4CmPKWEr1H?=
 =?us-ascii?Q?W1f0ALT0m8HQxMO8Cu2CcsXVZPNfrlBPmxT/hfuDsPh5aiJ84TyhtaIpdi+k?=
 =?us-ascii?Q?/wpjRYrdHiHtniBrAzYrSDYDN9J6i2RI8gYzMb25nzmNHw7O/WSAH4o2aXBD?=
 =?us-ascii?Q?lKwpkMV/fii03T5SZmIxsP7Ptwh9hpSAOM6KbMf1DuUWfKe6FjL2qBVGmlEw?=
 =?us-ascii?Q?Fv0gXhexlmeRNL5rn0eAtQHSHQFo523J27gxNIYWbuKFN6fxTCmYoIkR7sYd?=
 =?us-ascii?Q?vW/ASylXdBx/408kyGwlQb8bVHkyjDluiQpDUlaHqvw0ORtF4tPq9DdQXgxS?=
 =?us-ascii?Q?i19EfTzwXou3XxqC2TnO2GcNvIPOGfBLGE/mAefHCIqjg74XtzeE369tjSXy?=
 =?us-ascii?Q?p3XJyblICEIbzpxadc+FkZFvUGDKZcjqhXljQT9d/ItXObUcsDS0srGYMkPx?=
 =?us-ascii?Q?sermWj+js2f3f0YQqcklSgdyqH40KhYayEmAnJVjqjfPtCm5g4FH1AGbzfhx?=
 =?us-ascii?Q?3z6GAr4o7bclo9JRorQqh1PN8l2yRnVrIyKFudxUCTyVpruoTszzGtfkzjEx?=
 =?us-ascii?Q?HZgWmFb+Cw148no2XfygHRu4SdFWC0DhumdJnSyTo1Ftk6T9MA6KlJggktl9?=
 =?us-ascii?Q?UMO64U4+F6kfca24vXwM+ieU09ePUsplKAuumh0T+ojf3FcIm2kj563mcHAy?=
 =?us-ascii?Q?/0mvVsULgfxNmBM268Ue/jHFT0DT3/Qro9Xbm45juyp2stvRucFS5e9y5Nlk?=
 =?us-ascii?Q?I8lp4OgdCySIqtqLUZTDZzlrdAaBtxga/zvqamm+KMPMiLzvkM4ncXKkf9he?=
 =?us-ascii?Q?elBtVBTr5OY+xmFN21ibgU5Sfp27kWr1eH9C0u/Dj5tKJqatSMaz3zleDqwB?=
 =?us-ascii?Q?51BFFptbG0CFxGoth3AGN7v9KucdXFCHaYoJnTklEsacw7SyEzjSuC8XCkaj?=
 =?us-ascii?Q?KfgWLwLufbomSI+IdW+8RYN5KmF4fPQJWshRWXJOPgj0zgR9I0IsDrwtkg/C?=
 =?us-ascii?Q?qzTtVG3/Iq6c+E489fODnpDb/l/I7OvQy89601vbuOGtgRt5A0Fk3oZkoRHu?=
 =?us-ascii?Q?TMPobmjsBuSPC659GkHcrUO5sHmxrvvcc4eRcIRVsSPZyi88uSct87EJlf+A?=
 =?us-ascii?Q?QemzC76FhTfxTk6FXV2gdGB72AnIB3NsxanXZdRP7ZzqCCTj9bKVgviJWr5h?=
 =?us-ascii?Q?gBpjFkbCUo85fEM+e1ArRBMkStpiOjo/H0h3zFFKgkYH57Fo2FBk9fr+Enij?=
 =?us-ascii?Q?/ly9nEzLzQwUB4i96VMQa4SaUJ1txJE+gxPq/s/IynIbcIf7oIRA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a28b80f-49bf-4e13-ea75-08dedda2cda6
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 10:14:03.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIMDTmcPT236jMt6BMpU0rZiVD5hc5PE1n3Q9/M5KCdphhIoSAhPwOuiGOZKrot8AOOfBfWZR9R+b1lQ0U+w9cqrqXhE+YFt1fr2qvJ5naIeP6vpG9pYAytwo8aaJrBj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9854

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

