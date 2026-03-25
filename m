Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502A3C4578;
	Wed, 25 Mar 2026 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436546; cv=fail; b=PNB0iCsuPq/QBlo8IxVZdMyZXnJ9D5VltlesVprBBPAk6D2RIiRZZU4YM0Ad8uvuBW0oQII/Lg02hlpMyVDcSt/JSg/HzZrrmFWjVBm68gFMsvIZu/W1bycf9+eAQOeK9a3ijciP5eYQRWxRhebkdx+TFWxSQDogLMeRc99PVpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436546; c=relaxed/simple;
	bh=CVk7j9SOaLPM6Nkz1fRvDY53F1EI2NoDvuOiNwNHvsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZhA87YFHQ1jHn+AyK+tlmE4nLacCUlzBrIE+Cr97pTBIZn8xgtz+N293ak0K9p0qhNfRTqgZd8601PnA6zC2Stx1If2BMUrVira/BW/9hTJRlBctzqY22cvISgbyHjZE6C964TuZ649fsYz1SBW3th+ApctDd7AMqFgbMuhmjAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WE1OqR4t; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WE1OqR4t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtxWG7bW3yn1l+jEihwh+p//dFc078ZOnAX7/GpWHiigwkoa+iBoq5UsE11mKR7ZSCvYcSxGnIQCEcAl4HAKw68hGW5fmAdQwVjVZTY89U0+x0OMR2YdmMYQCenZlKb78p8qn41pu2Gv1ttAE86e2hVz2W4LGGXRS3m4fvZHEoM66qjchfXXZ7B9+W3aXBGoUY3cV3q332AVJl11jivwcpGTKturOCrudJO8RwJ9X86Jzr/ESXytE92HQwfhBmjB4tjRmqDxHNiQclgsO50an61kFlFirhjptJMVh2hhUYAsgfkr6W5R2gxOUOflefFCY5JW0ZzKOVd7s7cl+Pi5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDOXt1Lp7eP5mpi7Y8WE2CktQeu6zGJWAaXA2Zd08q8=;
 b=w73xkIQ+WhNKfFixpVoVv99tz40ik/nRrG5m7ibrL2hO60DIgUlhtwXaOihwm6gGYjwb7VJmEaLLompFtPxJgmDHG+BJuAY2dztSDbXldICOqGtPoZi3P63NvNbrdPpFbvXei4Ab+tcSbd97uEV983mcl58xGmhhZdl86JE7aB76cxRNiIdFbKK89M3FDE8Nrkx4qm/4CVYhQPgjYFxKr1Pz4CUJBgknWsA8BvCE9QLEfqz3QNWbGaO850MWDyQ9r2IdtcUGph8ldbi4wK4Nf0Xc//hFBa7dbWMd7AUR71IPOyi28XqxpFO0P0U5Y/Z1gUc2VfL3y5FInkCXgVXOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDOXt1Lp7eP5mpi7Y8WE2CktQeu6zGJWAaXA2Zd08q8=;
 b=WE1OqR4trE1vC0H3ZqbMxAkPA5SWG2tM0DXqjjrPa4nSOBbl4hsW3ZDqLDUoMz2WBf3l5q7mHsq3ZxOgJJhcG7jEA1fyyN4MTn+LzBYrN0CeiwhAH51F0ZlvPCZmz0e21D5SMJdMOk1grfEhOOnLXbflU2ojiB9r1QdAz2XiXcHySoz20usycbgXJ77VMpsL72FHb/vsXJKXfJzTPjrgImpvpHPW5csxG2uVQWYQ8CGEJqO0DNR8txpDi4Sm3cRNxt90ebYxQpC1hOPiCGPyXh++juiNBypCeg26+OkSsDGXWdx0gm+oCjyKkCtPHSDKXQzQLMnRD2aIeSxQfAmEYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB10398.eurprd04.prod.outlook.com
 (2603:10a6:102:44d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:02:21 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 11:02:21 +0000
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
Subject: [PATCH 7/8] arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port node
Date: Wed, 25 Mar 2026 19:00:57 +0800
Message-Id: <20260325110058.2854742-8-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260325110058.2854742-1-sherry.sun@nxp.com>
References: <20260325110058.2854742-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB10398:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5a170d-b2c8-40dc-4a95-08de8a5dfd20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|19092799006|376014|7416014|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uajsl5f98acXCAEGRo2SY/Kr74ORWYCcJ/Dz5Z9aqxfXd2deHVcsh9N8QK1i01RFRrTSoTCLU4oTn8sM75NTNksNpf+CtWl3YXsr44I1U0sgt4l7PY0XFFdXHKiO0lwbxBNo0k7MxMOTiQC/z0ZWms1kiYPkNH1EPgjww+LhrRksE5CoNVz9OBUOjw7DfvC1k54/ks06eqaIzi7MmcAdSeNcCAPYI2QmwZEjNqrf+dRdmUWlBArUt+rDwwR8qJJL3EMPTWnbI9OQRjbxx9aCyiWr4GkoKRKkf2jMtURUun7vWNQ9xNHrVYt4myZaPz9qp8YsElamfeVahW0PebjUt++M5LQuyz4bQyceNnAP3ApKlZ9UuwTeeoTxn5ZQWzHVh8uF8gmpHM/bBxL40z2SKM6MvzV69bn6ahKgeAQ/yyS6U7lyflqOPSdUOkZ02stylepW/Frb3eiIPpNCpGBoRLQ7VO3ZvKcQ3ZViIjp1RLaVOeJQHNqCN1Igx8sVEkYRUdmrNeTcmIV8sJ7Dwpayv/zrr18fCoEUwpCNPiSMLSt+TP6F+T2Lwss+LYTb1mBQfAqTDpjFYejWm7j4HTCaw+RMGRElWNG/1xmpuYHpyQoQT2xSbO2wKu4r17E/8u3SQg/Ktq4oEN8/7kp1Uo3xD52GcgS+/tpSBYr3yqs9YDaJODAdzMX8xCG2T+TnM1eytvnL3GNQn0RUz+fASVp4xHk/oFMVd6n6fmR1P1Reu9aTs9rsth71pic485Q6UQaz5/WOK7P7Ra+XMmvJEZeT6DzfzXhExtRxBYby/hcv6JhmJ2xGrxZRh3eV0DKrZzoD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(19092799006)(376014)(7416014)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z8pwjNt0oJWUBca12DeJifnLkh4wbuOc3xRp/fqjb3A7QGBFxyrPwJqPC+Sk?=
 =?us-ascii?Q?u3hJ8Lx9OWKihQHao18dyRPAlmx+pJkCdAMQMVdQ8c2O80KiikQUBy+E65ZE?=
 =?us-ascii?Q?C6chD8M2PZqAgLeIzXa7W6kBVDGo1wJsFxuOOd76m2IUdfKPjOIQ5tGL6n5P?=
 =?us-ascii?Q?dysIX8rrarlpJjp2CntnIGfQniTXXdH9loWTO8fdGk4hahhsE55QXy7edBM+?=
 =?us-ascii?Q?YF0I4p4K2al3trGmtZ0ezzf8RAiZexs+Eh7HCZ7bZBFJvHiH+A5RnGx6Yn1p?=
 =?us-ascii?Q?TTvw+lfrWuXMjjEj8zXE3VkJ6EpNQL48bklkYoKiPjb3l1IqbAJ0q+j2yiI7?=
 =?us-ascii?Q?6HGmtgty18F+P4n1oJQxD+yuv7vxfF1wJRJPmKpPFJVfUuSTKS+HksvG/PDt?=
 =?us-ascii?Q?CBGJqHsTVntuh+qAXm16orkMgSHAXuvpvd+TW9/t+NljZOC0O8dXmYk/VfEJ?=
 =?us-ascii?Q?+8ku7hZEMpTjh9uv2FVq3bmLMCujVYGA9RUJ9wgRlfgPROko4eV00cS67aky?=
 =?us-ascii?Q?uVkU9peK4fjVQWKKabCrAxULUH/+3mhAv4nt1aZdHaDPKIEwy5bScgphjQAG?=
 =?us-ascii?Q?mU6aKbWhFIpnIHNA0QJieb+7DBkQlt9njZPRFjyhGITnhJGowYBh5DJcmsfZ?=
 =?us-ascii?Q?10R6uOw7s6k3OkmBtzkWo3cSNbBfh2uCZV/0YZ8LftiWE2NCZBaWUN4pQGgn?=
 =?us-ascii?Q?9f+bdlkcWo8gkI32nR1nVRo1ur8644OZg80rBzwTITMaFJY8bHA1uHKlmIsG?=
 =?us-ascii?Q?cApXClzS+/+z/p/dWS5JUogcGhjmaVCTZUypeW2Ks+Hf8SzWCBiWZwtHEO+q?=
 =?us-ascii?Q?FLQtLC9Jgn3+QW6ka5m6m6goPfkBulP07hxyKOk1b199pNykQhqxVIxxrGfP?=
 =?us-ascii?Q?NKJfKBJMcYjBF8fnaKj0HRUW23C6RAYu6/BMcW75zXltjvBEFoD6pZhk4mQG?=
 =?us-ascii?Q?CwneeuebDsn8h94ue9WMir3HBsTWKeDVokWAt5u+LppszPEnZ615HZi5yMrk?=
 =?us-ascii?Q?LSPLxK+ZENl28MQltqejPzLh/lZIP4w/HmCaGPkHsJogKcDjizHHPPXKpcvP?=
 =?us-ascii?Q?R4xcVL44jzdR06vYJqkye/qOBqleuuAY78wqIZvSSkhPAlCIwQkPp949hJOP?=
 =?us-ascii?Q?AGWNrgSG2mPOSrIob8hFxc4S50YRUnPB1MqDk5bYXVUzAmJ6yeQrwUgCeyD4?=
 =?us-ascii?Q?18M/mIOiYMWy43dyTQ1y8aRXezYEpMJXkHhoMtTIjQLB9XFVcopPr1LZwQiu?=
 =?us-ascii?Q?nrnrrJiBtnniFL+NRuIzVmjpc6ntvEUNQwwLuF6TJQHswxKc/AT2UwwyOCCh?=
 =?us-ascii?Q?5V2417MHF+U2eABd5vYws9Icm9qQzfBAGqtHFtYvrzP4ofQo9y0HX2Adz4xq?=
 =?us-ascii?Q?sE50FoIlq7TDhLPZroSZFTHyU4/kBhIr+PsMSJ/wyMcI39Eip1qJ3zJX/jw+?=
 =?us-ascii?Q?HcwO+MKOTBWTEgj5vMs9dOXgzhfafHiDu4TCd88+6EVkRCs1OoTQjTucXlyo?=
 =?us-ascii?Q?whKLjH3jqOhiAKx+ZG0ryD8YgT2HhTnGuD1mullu0OjG/8C6+fEWG3NkFJNZ?=
 =?us-ascii?Q?L+sH3/APh1god7nhW13b5UhF3tqTOHSqDDk/tLWimWITLRk+Oncc/6pFyiep?=
 =?us-ascii?Q?vDBHcScz316g4cNVT9t3LTfYrvtN7872mit9PJHUIFruOJ5OoX/wxAids/la?=
 =?us-ascii?Q?Eg52MrKXa5XC0EQrl1BW66RQqTvseFVSdbPVgaRzD+CMsvRw74uBC2aD58gw?=
 =?us-ascii?Q?7IPJljVNqQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5a170d-b2c8-40dc-4a95-08de8a5dfd20
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:02:21.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhihRpC97oKgx1PHXz0kOWcqEw1SCZKPgj/umTteKI2iF7O9bxdOEb4uouAj1jOK/TqFBaQ8LpjXA7FkkdeGPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10398

Move the vpcie-supply and vpcie3v3aux-supply properties from the PCIe
controller nodes to the Root Port child nodes to support the new PCI
pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 8f2c2bd00cde..5f2ff7df2a95 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -653,8 +653,6 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcieb>;
-	vpcie3v3aux-supply = <&reg_pcieb>;
 	status = "okay";
 };
 
@@ -670,6 +668,8 @@ &pcie0_ep {
 
 &pcieb_port0 {
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcieb>;
+	vpcie3v3aux-supply = <&reg_pcieb>;
 };
 
 &sai0 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 02f7589bd860..a199823c313c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -804,14 +804,14 @@ &pciea {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pciea>;
-	vpcie3v3aux-supply = <&reg_pciea>;
 	supports-clkreq;
 	status = "okay";
 };
 
 &pciea_port0 {
 	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pciea>;
+	vpcie3v3aux-supply = <&reg_pciea>;
 };
 
 &pcieb {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index cd127d0a0a75..c1d920003b1b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -724,8 +724,6 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcieb>;
-	vpcie3v3aux-supply = <&reg_pcieb>;
 	supports-clkreq;
 	status = "okay";
 };
@@ -741,6 +739,8 @@ &pcie0_ep {
 
 &pcieb_port0 {
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcieb>;
+	vpcie3v3aux-supply = <&reg_pcieb>;
 };
 
 &scu_key {
-- 
2.37.1

