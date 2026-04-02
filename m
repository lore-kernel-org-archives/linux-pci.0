Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0B3E5EE8;
	Thu,  2 Apr 2026 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123464; cv=fail; b=FiuVHFniOti+KB3W8GvRIP/fwnOgGzuJLCpuh8KZWzhE+sduuFsUNhWeEAPJFXskbhzeAI/bP8MAFSBUVFUzW5OTbmqgcPVNA+a8VOdLKtIlPNqt6cCrDGrtwXmWEypICg5r1NF1c7OnIedUCi3X2xVH8J48dUf0ENXs8AOVb6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123464; c=relaxed/simple;
	bh=2QrNdCAJJCRH6qpVacd7O539pJtn47HWWp4UJch0H+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BMkGOOuGHf/Xb9pvDwRGH1nZr5LqfvUQvLEza/AvlEuxEO3VeNgg9W+kEXR8J5+trGgCb30HK3XS8mWrkufA8AaxJ6+6PE59/AE30jA/aiyH197CEge3lWVPpGBsLhuXl32TG9fFLYjsMHhx6lMR0ggT6mFHKtONOkRQy+XBKTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BYzVWgsw; arc=fail smtp.client-ip=52.101.83.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BYzVWgsw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdYYTOWcOCGjRdgFrHHYgWFlyRt0A/xuNqOlfimJc9KHWKJC2ttOp/swOzbCZp87OG5P9CVowuVgn32w702MX6AIbwGBTuvAWXItzBwKPsJbIlGG5P4jIA6tcqXpLM+n+78uMcy+tuz4Oi1d5A9JLutkTO/AJcnIkIsM3Quo8fQHAEOv2M0DgYOJ1IwiWq6qW9QBAFxLYWNYHQ42wo+1PgWQBaCFk5pROoZ/MQDW0+8JFJnasHh8CxqBsqZaQTho6nWDAhQ6KMwy3/fXj8z5+EtM6hgB1TjcJ/1rRHAhfM6Nm7QAy/hMPiy9ffsF/huhWgPbQ+PS6h4cvyOvoE4jMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=UaL/IGsGCtaVRH8qMtY0MRCNaIHP8cjZjAjTeDQIKyOT9bXfyu31p9X3Yt8AXV6P6qYvhwsZc0tV+YKVFwEA6qpCoWY56wbuNq+EOCvF/uIs/ZLVZ3R2Jma6uxrT5c9bnq/9yfqHzTEokrfb9IbqdAn2ZtaSJk17jswt5lI67ELVNgeExEh2fiC53suLnpcRt33F3lWgxyMTQS4beYRbWFDgNCSFWQTBopPDbLWyN6AYstVSnOFuiFKxLFBiOmk38h/9Kn0XCqqSQVjCkNzS3xQVVXw/mgBg7CnpgSZPazOv3Xn3zdBlvu8piC8VOXLLRhjyUudlBhuorlQt8dnkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=BYzVWgsw9gcfMHnf4tsHNdFGNHTlADUIFFbjPqTe0Y5nXtENvr6Y7heAjOGHJuMUyFl5TfZZ1nbC6cgD4RI1MDBIOZcUh7PQEeVkuq58Yn0qIIPyzNb+Lv1JbxzAP8pXTOP3ENG/dJRppSt6+3KMr2jVd+QoGEOW0suRg50WxPyMEf73Z82p49dTglSX1+yxtkEMRQQT+Xrwjwq6Fcj0vBIxs6KiFd0eZTYv0IjhDCFyfsG3v2msx6oE4dUapg1j6PgHJ21R57SIm3UdAHUHBPchBH5C4iyVK+pnLEvleGlZkKnOOCLDR9QNkGnwzVbdRwZFn7EL8dZ3rS8mf1HPmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB7683.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Thu, 2 Apr
 2026 09:50:51 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 09:50:51 +0000
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
Subject: [PATCH V10 08/13] arm: dts: imx7d: Add Root Port node and PERST property
Date: Thu,  2 Apr 2026 17:51:02 +0800
Message-Id: <20260402095107.205439-9-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402095107.205439-1-sherry.sun@nxp.com>
References: <20260402095107.205439-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0163.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::11) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: e3045144-b974-467c-31a6-08de909d5354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|19092799006|376014|52116014|366016|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KzEofSwOoTiwptttHc8JIT+pDm8rnbBIIf9FOQrOPyjhJThKMXtrTENUBADteiGQUGk9sQFYkoEbRRL/UbJqfT0gcSL5gdL5dVxJPU/7yNqVuZQsn0Tg0aQluWNyq7+4no67U6e6i+lXNPCjKzou5LHO9sMwrxOUWpRrH4garwhRUeMgcRgb+RSlAPi8Vn+ttEfP17g0XFZrKDQ1fVGRqvkbw/NPDRe0XByodaptOyxwYfgESAnhvdBKpjTkjlecT9/65dJhySAJ10PcDiwh+tY6h03iXU/SoxAtK0rp8Pn0SbtXkPalG0zl2URm68ud857o3ALx3Q7yaa7Zl06c1Hsbyt2Mmuo7v0Ss00hDWKcHSJ/0gxsPDbWFNGz1ubSotSjhenQtPNMWt1+5Aut/dluW4fiByV9M+wtJG25zKWjpjsDVhBw4XnmAMUx4RxJM3oDVvv2Pw60Q1oe0KOfadKvFA8VEdLBqBWTsClNgh2LFfsjpdibXsZ1Is8vJaayrhTABpZZJQPbuJB+kTmeTHdFGH/HZukqCTWFxj8qiM7xY4azZp4IBogOoH2nco23jIv+AzCj2xcwIqVYnV3O4Hmcd+No31NBdJ/JwbQ805aOP59T4TW7YOw836h+d8jfpI08O1UCnTe7Y+Tqa92MQQFlx2ClqrAUeS1M0H1D8mSrXSJZWkoqOmwj/T6g1nJ8VkrHuCwpMpk9BwP73mNYKXU3DHiozmfcoKxYGAgZbZzpTQk2VpcOlhp/nNjQlzJjFkMTEDvq+J6VtvX1n6I0rLm1QjVd1TGRm+bkamT6e/270rbwewqvyXbJygBdDkDLs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(19092799006)(376014)(52116014)(366016)(921020)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lapEUxQQ4srUHWdk3QD20AEBx8e3QBYv4muVuiJtaDR6ajJ3tW9ABkYcY4/d?=
 =?us-ascii?Q?bbirx81+S7zugEMwI31KaY6TOogfv3DNV/t88Rkodgi3k7Iv1+XQiNSny/6Q?=
 =?us-ascii?Q?9iD3v0ZnJHacOpXbHt5buiyOK8hYz3TWhBth+OWWy+ryDSwBke2+hEQzW7au?=
 =?us-ascii?Q?IejTHjdTfgByOElc4erjCEtF+9ZWbCp88U92DGP371tRc+dv/OY7U/G4Rzda?=
 =?us-ascii?Q?kzJWPpMgjqfB4Icn+Qjccws0CrfrxXa4oe/dT8g+BX1rPnbbgHm3Ymp5utTq?=
 =?us-ascii?Q?0JMuI7z8jHC81xdjLxRJ6fGgUOHDIB2oU6HoLrz55SoePpzfQicwLtXaVqFx?=
 =?us-ascii?Q?wNqVowRkQSlqlR9Eh4616UDfk/rRO/3hJQqPebBL0VQDxN/o25PNFJiTOStW?=
 =?us-ascii?Q?YU/fCAQlgMZcGX72w4A3zczkjpVnz+pmiOnMVLURLR+kyizipQU9M2Hh0o7e?=
 =?us-ascii?Q?8E6S1X8u+r1cDnCZBTRqRVmPFePxTB4a62eeEuGHopBxfLPu685J3w937VD9?=
 =?us-ascii?Q?+KXlnJ4XOlBXHvCMhbmJ7K3wSfdpl+L0t3TgX0IosYR/bxRtblo9JCQ7R5lT?=
 =?us-ascii?Q?GePUMxr/AGNB8BfSHq43uk9vLdQ0I2l0srFlE6LSxfBMZE2XCAqTydKtUQ2i?=
 =?us-ascii?Q?MwfeXID2cjbce25ZKguxHDJV9puo74a1O3iBXg7sRjXMD/iQ5cBforyTz9YR?=
 =?us-ascii?Q?jGE7mHvrwzSkJ4msRClmYzCVsbeD8Y7BnPvkUonUfQXGT4H0zzqMlmTk44/R?=
 =?us-ascii?Q?B8Wvq88UhkdlDPEgCtCRIgatht31MvF095DhCjYMKGjW1sznwRUh3KLYbLT6?=
 =?us-ascii?Q?0E6Hy4HLLOUMmQnyqB8HDQrnGCshFRnUvgnphVg3sko3WpxwcULazHWVXws3?=
 =?us-ascii?Q?h6OkXBw0yrAevzZ4iZN/AczMbW/gRpSlHsENPjOxbHLli0B8AQ3PRUiF/FYh?=
 =?us-ascii?Q?G0+zogsYac1eTQ78iN7yDXKXIg7xqAOTaNQlgRvZ/2SmEqFwdBfNNwPntKrv?=
 =?us-ascii?Q?fPKHZzf8TEDDcY0YeYTUB4agAYPtcAdOAhnqOZ7sKWaKzzy8qQM1L00SoPX4?=
 =?us-ascii?Q?C+4KFNWDqkniGnCSmUEpAyUyTYottoTXPA0LyfE02HQVeOxZB8FneycyPQeV?=
 =?us-ascii?Q?HfRx+oGMABz5EYZTZmbqbg1cJ80aIYEP+WUYqaJLdk4fmonqnIiQ51xlsnTA?=
 =?us-ascii?Q?5vUtrF4mHDXBfYSG7Re4tB8nCCbj1STggilhxo7oL6Iqwi7WO7k7KSPxf3yj?=
 =?us-ascii?Q?R0MFpH7aMa/ZDYrPchaOBg7pbzoA8Jxm77XGoYiUfZxv3ER8pnbPYTes1Gxb?=
 =?us-ascii?Q?ScKU3bN6wWW/gwQrUTdNwfXhCUq7JkCFdD1ztWzGnf2CUNQpFT8S4e6pijtz?=
 =?us-ascii?Q?uhIRKmyd7d+zNM0aO8wMdml/SEfuDKm2et+sVT0edqMpdpnrFykT1oIJ35vL?=
 =?us-ascii?Q?jjkl479zsx3jrsVMx4mlshSmFFejaZmL6knK2wjJGyEgLbQhdLOgQHl17OoU?=
 =?us-ascii?Q?BO+2eP3NjYzm9MRZ59gPxefUVSTVSkZIAy+mYD8RFxIGky4XVnTVM84uGnPu?=
 =?us-ascii?Q?3zHtVUXI6ngSue+4/UPY9FZ/y02rCaY5LV+rKcEeLt5RZtBjbX35vTJd7FQe?=
 =?us-ascii?Q?I1sFT0TlVd7LaYifSYR4TsMsaxi2YrYaBBddSt4+48FyfiuWvJvnQ+DVKfrF?=
 =?us-ascii?Q?8I+1IS+u/Qu7yT6Ors9ecOAHa3GmhjPUd++BRRgkwMlbrqXPSoIPQ6PKhjpG?=
 =?us-ascii?Q?E7Zdq7XjuA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3045144-b974-467c-31a6-08de909d5354
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:50:51.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Yt7DV8sQa9feSHy/lONRPd+0YKtdbYddCf4ZWseZNbppH4JJb9EzTUnFBDvtQUWJu0uByOJVqZAGLzhTo8gNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7683

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi    | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
index a370e868cafe..0046b276b8b9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
@@ -456,10 +456,15 @@ display_out: endpoint {
 };
 
 &pcie {
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&extended_io 1 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&extended_io 1 GPIO_ACTIVE_LOW>;
+};
+
 &reg_1p0d {
 	vin-supply = <&sw2_reg>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
index d961c61a93af..3c5c1f2c1460 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
@@ -155,6 +155,17 @@ pcie: pcie@33800000 {
 			reset-names = "pciephy", "apps", "turnoff";
 			fsl,imx7d-pcie-phy = <&pcie_phy>;
 			status = "disabled";
+
+			pcie_port0: pcie@0 {
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
 	};
 };
-- 
2.37.1

