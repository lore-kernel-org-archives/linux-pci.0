Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA193C456F;
	Wed, 22 Apr 2026 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850520; cv=fail; b=X3ndMZoFVnNHZMbra7XuEx8e6N+1NP3BAxQbzOTuq+IwPZo1mVegCJCfE1gfB88ecZuj9iZrnmAtPZ1zYe3w+Q6Jf6RYjEy1ssQqqLI91Ca48QmRntvVXl+n0GnjTsHjqdydu6osA/nLfJfg92VeQlGUUHhntdE10CplDZRkLDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850520; c=relaxed/simple;
	bh=x+jr4m49wP+8i2/FZYDMOQfGG0j2TOvL7tn8QjaWo+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uCJ6kCEEctI8TAYbJIfISqD5sLRkgecP8I4VCmGdxOeID+cisR9HwbXicaaKy3mxVosQolbhTbZT70N/8m/4rBY58hS9+ZXVQG+cVKUsOge8nUxiLRH9IT3kH/Q4jEBSopTQdWOnJpOol/mQSJ162clm4hVaqTp2Z/OGAcf/eck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hxIbkspM; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hxIbkspM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+5JC3ygMU4Ey7rg8D8j7PZ60xaGBcndoc9QEmwutw6NjIYLOI398YAlufHkLFgwfYgThPk0TTGYTyRehwfa6dk4p0ZRv6GMx5XbUa4LNHFWn7faZfMjzun9YanG+GZC+wjsL+9NZ6NSzActpOPdDo1AYre9zidjs0I4QeoYRdQ8QRMMb4TBqiH7fNcMXZPfXgwNzpieRW+W4m4jJzmoUWHHRQvKkqkvlDe6vbQU164gNiFU8qQJq9RIuLUmPohliC5jOOSJ1jNi9rb09HTQlS1pvT8RL+7IUoUzG8mhWrnPzoGEJJ9dxUPPflfRr14KCPHkpd9LrIXaS2ihS9m6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQRbIJIKrp1TwmDhYhB9Zfx6X03aWZARMa6qioX9YUo=;
 b=V4QslJ2/AjoMXeSDCCgB6D9C6GLxFyG1ilG9ZbqCCjuBk30AKu+ibfn1wxLPkfJhgUPVPLuwaKNUpwTjG3Rj8JtY7WHXVkIK/e93EhScrT6eDuOiAidv3d3NMqJDD1gW4RHGZMSbAYNwgBoP5zDPk3f/k+QeYnbHQBhWfRwnXzKPh/Nb3ODK82DTFA2IvpWL+8QGmSEnsUwkARrDoOFHXWmq2VbJoQQy0yxciyiG7h7tp1fGJu9WPFU4JlhB0jZ3cNQJUHABd/4DmbLoildkRt3sZEoqdFLTmbEZT9XlfRqoCE9XTX0gAtJ4J0ibRTbO9SCuvn6GmO4JCXCm7f/CNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQRbIJIKrp1TwmDhYhB9Zfx6X03aWZARMa6qioX9YUo=;
 b=hxIbkspMmY1tUax2udlFT7i8dMMiK4LR9Q9HY5hKkwEJkLVTQjWYx4GJPVaDj1QDXdTXrWqb2o4VCsOIBkPwjg7dsUCdWuIoHphdPgDCnC9w2cTjdxag3YvA2Flc1018ARMz/b94PNbuIE8dHlrc0pq24qu7QwWIneeUNi0GTfWRaxmzg9I2zVybDaWFJc1It/WFY6veqOLvzMtsMgNMExhV5D4nPG81ogxWgxmyKLnQtzU4F5CVwueIkpKIjxhZL8Xg4mf6AxwQhDTaizOv+JPBTw6IfHby2uWhmFYjMsf8l8wGaWTV5ZdcotcREpg9Tq6cZ56EXBuMIsnKMBL+gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV4PR04MB11428.eurprd04.prod.outlook.com
 (2603:10a6:150:29a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 09:35:16 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:35:16 +0000
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
Subject: [PATCH V14 10/12] arm64: dts: imx8mq: Add Root Port node and PERST property
Date: Wed, 22 Apr 2026 17:35:47 +0800
Message-Id: <20260422093549.407022-11-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260422093549.407022-1-sherry.sun@nxp.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV4PR04MB11428:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ef449e-c2bc-49d4-da38-08dea05275c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	L+MalL5ic7AEBVzzZEM0qdlRTpyE/MR2cH/dWa8nyjOPfSUFE9VdwRyT+3DZuqE9LOi/pw/s0HZdl/OSxr0mn6efNx+BFzqy6jvkLCCSfNJveyWXm+8CZjOiSaetIn5dFVEOw60tBayENj51heO68NUdliW7lWuQ8vx8OGIe+wwBqzyhcbi0knzVKoaLUdew8MoFXnNFWwMvYdcMt+jCtQJ2M7DsfOL0N0TgF/t2NiBdE3p7GhSTURHVi9xtW3Za9aB2yR8Iet2A0A4S5bnmjx1BP9DV0Jnb/9LpJyIc5pSLEs4TCX7fAxvqWtdGUG6MsZTh2fc1wsUyPP0AqMfSpggDPI8ZgIRu8kTLmuab5TmBcqCP1MIWtQcszYE0Yfhs78VvEoffF9ryVn0a3tuUWl7DGqS7/CHzhAQ4dBr5mUEMxYWgIQ2ybVBG6wMfpoimR9RAPQpu9fGpOOEDNz9d7zqBAz6og1iJIvrvzAc833XHQMo0q/yaljec8rcwl73krdpUWQQNW8wFNI5/gKYqkx9kIn/IHUmel2yHQxd7gEZ502R6RnPsv1oRAGu0kCwGHCcsHKdb1g/aInT0+Yg/pnfKGd8Dnvr7iV7eKPu/TNXegg4MVmTQHvDBVN5RKoOtdL+tQ0kP7X1rY1XekI7p+1shmhtTtUKgVpWGdgr5mPvEKtxDGKD09bKw3RGwPVKWo1wme4vuXdgxQ3u00gmLmBIu6cnWvTqJIKU+RnziRX6+i5WPPMNXRpnQU8YdnMEhQAaxZ7FLqtY/lS5VEvCiMPT1owVsR7ZgEK2bbBszbCHnhdlXX236uhhNFd3p00Z7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N+R0hZ85Z5x0UT4UGTG1u9YUs/w0CT6GKycuHiOo1xmrOlYH1AIuOeZrR5o4?=
 =?us-ascii?Q?HRHLeW4x7afsEc/e7f24PJfFy1B4G7NU9otJleK6Hr1x/4cyzbY2746LDKfL?=
 =?us-ascii?Q?9kc49m5b5sA4cqKr7w3LacLHJLFRJU30slzEteNLCkTMeJ2tpxKGjYVqRdQY?=
 =?us-ascii?Q?+vl792Kl19EbKlaVcxjqtUIliAxPeliNHc2dfLCAOJX2w05EsfDx3QsK4VJR?=
 =?us-ascii?Q?fRrSDtF8vH9vLQxyzQOgTX9mGXaAsswBUSbqfieGyLk4x8kDMMe0pIf3i67p?=
 =?us-ascii?Q?JFRqG9A7oW27SXPENzRwGENeXeThdn/bFaHPRpupt7vvxFt9j7bszlj8GrLa?=
 =?us-ascii?Q?F5HDg4ZJcgIcYxOnw/aDs99/Sz2Z4iRvLM1s7d0ZqjNGifgX8/DOIKJFxnlV?=
 =?us-ascii?Q?GwlAVHqdDMg8zj4bTt3aHgOzYVEhqJPCE+iPEIINRyRKrxsAFPanwDT3HnVH?=
 =?us-ascii?Q?J29X6vZ55wx3sx4CKFYdtSSVeqVcL0b5t7ufCz+8R6Dys3977rMaYGgr5DAT?=
 =?us-ascii?Q?88PgKhxYf2rrbjKNMbO/6B3HsKfum6wvq3NiGEYK0lgK6xi+1pcwIWtVz/9Y?=
 =?us-ascii?Q?SL3RRH0mlIz/uTYDJZSq3NkU/qCa9Fxfr02yYUNJxlPkUYk4bBRGw/jhuaoy?=
 =?us-ascii?Q?tYTHZIYiynTBET66piDZOBEiAkokJnprUFyjeMkXgunIv4+10eDqRV1alZ00?=
 =?us-ascii?Q?8T4J1SlxTNplACHziq2LrRo8glsh2h3KRH+uWrCwR0Jv/ti7QqNlWNLj4uFk?=
 =?us-ascii?Q?QsvwID0kjL4iNOz6S8OOPljx9q18p/hQ/K/eoWWi+9eOlNOSDbyJDYZp50aB?=
 =?us-ascii?Q?XnJEr1VESnXQi1zLp95R74E0EoQF+f6F4gxVoLH4ee+XvKF5GLgfdzpvGdpS?=
 =?us-ascii?Q?LO1tXmTEt5lzFxE4Bv9JagjdA+J/n1m97iDpQGMM0z3ngIeu4qXf6mACq6qD?=
 =?us-ascii?Q?4mAeHSkwKVsN+46rQYTxalTzBxfmisG3JGkTBd2tQmIFOs6bm76TzHXvQemD?=
 =?us-ascii?Q?mR5rgWLnes0xYsx7ZvEXH+quloXrnGgaKrzd+Yw4gNK0ynYkZaTGeVc04Mj4?=
 =?us-ascii?Q?V6KNDG3OcBjSZeL10QR/VlfHqFbM7frSyOL2Rid/sudyF/pJgsijWNo9jrPa?=
 =?us-ascii?Q?KeNrMDjTGYYqhCT/usSMsDcFOMwgXpZEi4kPi6dRQb1Rf1RTNpN5yDqX3YMc?=
 =?us-ascii?Q?dObFsO6kxTvQxScvvFpm7c9hnKtCeoCB2fuCbGsbqi9kg1j10r5Q1M63h3aK?=
 =?us-ascii?Q?eZyiQAgjSv0fyKwqZp2NtZSBMgDdxV1zkjRcmtULBKRSkrc8QmG9osNjSj2D?=
 =?us-ascii?Q?rbQTeizGn3ojKq5t9es0j6cAWq4k5YC/cRMWPQUITdF/G9gJJuyPPIUU3Llt?=
 =?us-ascii?Q?eAYu0R9UTER8/+s86r52Fe93kiHZfZDlc6ubA1ZBZQ0N6YUoADVUlgVYDEF9?=
 =?us-ascii?Q?iOxVC56sJQOSBVfetAarrxSOz4TH1pc67puovwrBP2VS40sLddBvCe+aSWZw?=
 =?us-ascii?Q?Gvpl5t0eiyrB2zzdJoLheSA+zQU1EBCOqFBGXsgUiihTj2yrGOk/Ai4+tV9k?=
 =?us-ascii?Q?DWoksD2peUc7ceruAxA5YlCcg/d34oZRGPxz56ZvxJW0srqBoc63rs0Alcxw?=
 =?us-ascii?Q?8NmNVmWZ0WJ1Ta85+vLMT2F269UzHzgCM6O1Ymzkzifkeqiyc8szjw7NSOBG?=
 =?us-ascii?Q?azuX8KEjhB/G9UblpY/gBzJGvn+y3w3VXj7osSwOa7KCLQml85DrZzx6rGjc?=
 =?us-ascii?Q?yt+z2nFzPA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ef449e-c2bc-49d4-da38-08dea05275c3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:35:15.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rd9q7jNX6jXrjTQpk0Gavut1FKqnxfpjp0AlXBBWfTtpD0zk9B7Z1V1as7zxg8Z8J5S5i1Nb/PNVXjP6s+PVHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11428

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

