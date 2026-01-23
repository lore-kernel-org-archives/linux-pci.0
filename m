Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2E2FF669;
	Fri, 23 Jan 2026 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134581; cv=fail; b=ootzSN72Qq0UQVXC4R7OZ9nTko6cuf1bHXPhggzIS2R0KBWnPktyQ0J7jyDM0TSywI/RywJt/e2vjfbxWHFGWmwaJNRAFowL3JOsgO7Tx3oFuHiT4ypXsOLz4J/H7JzIysqh5CDOH9i6bzz7KS7Nt3I2IfaR7WZrYJYQihQJWeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134581; c=relaxed/simple;
	bh=2QrNdCAJJCRH6qpVacd7O539pJtn47HWWp4UJch0H+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FQ2gSgVfbTXgSOtgWs9j4mUkpe7jdiIXfeDWKUAxvT62kcboUPwnqmUCfkhRxfXT+Pi8N/fnpGMjP7XZ2Lo1ZnVAJuB0+79Dawl6O8BbXDYV6q8sQFsw65oRJQNTuRGytmvc3eX2EkZEvz5jvDKNH8fIVzASd38rjHsGEP1M040=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cZSZGL3B; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cZSZGL3B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLgf/t7GjAYsVNlD/gdNRbpg7p+aJB6xAFOPQQ5oUyysGBx6xXPSTeNYBjFJI83oZOEVEnoS3lYoB+pl+b6PY96FqrV+GhwDbOuPIiio2IUAS0uqP5dm+ZnFxt4zxKtxIJSL3phoTm8a8j2o7XQGTLno0rTaQ7cxEUMYLZ0MB+eh0Y+4TpBnZGKvR5Ggk9qvewVdctUn+8Ti6ePDsF0reNwn0KqtLoLQQMV0qciLXelcsXi0I/Nnyslc3hfYLHy+5WTdWxJvMslT/lSjl/77Lxz+bfB9TZvR2m4nk6cwDPCUCD1v+I2fRGmC0Cflgf6dJVVGcreq8nBQ0E7SjrM7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=qngCrdbHVUOAnCsznSrTKHOG6qZJXk1zIvgPtqkBLV2pO1oPLKI5xTE79O7G8vVze0nR9PXa2BQXWGUA2aj2SNBnE92Tpa2KX8bmtCCNHPpGPHUPEK97rhGq9Jqyf2fHaf4oIOmDtQMsxYgyENtcOHqAkx4B3ux/lXViw3wIrfvPlfPoZnG50xIDl7KSonx+qewzmsViPCST30ua4CPrX1oDO12p1nBWAeKl/kyj4/diLkeyDCNjZK++eUvhOMAR25g1yMszSPy4U6eQER3cgGdARsmZ0pgky5SBoBzKMRVGYM7BNFQjIPiKm7xo7JbpP0d04jJo2OHiSWlZhYmLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=cZSZGL3BIDJ8mtw5RNTvQXeVyBRjOcWDCxIc9c3qqF8lrMr43sR/P1k6n7DwkNcHhAwJ2T6+euHY1lKycH60FwnEekjM/Y3FmqYDClviY3LOXyLA+oen2y3EJrOAeup+jbVGwZ67K2n7D+ceedG3ydRJCoboxj8O9eNYKGP9Gr3fubmX0VxxHS3i+LMkK8ztFK86kGldDm9CoxXL/s/fBt22dOsOQOxrFWrfwI1NYPQ/xR613w4SPKRYEXljzSa/tSb+B85N0oHdyvFVaVBNgcl/B89FHbu5m1o+0E86v3Btia8iWerDWHQLYup0XPKs2vok4bZ4xu3GR4nxH2jUPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI2PR04MB10716.eurprd04.prod.outlook.com
 (2603:10a6:800:270::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 02:15:48 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:15:48 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/10] arm: dts: imx7d: Add Root Port node and PERST property
Date: Fri, 23 Jan 2026 10:14:40 +0800
Message-Id: <20260123021445.3782170-6-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260123021445.3782170-1-sherry.sun@nxp.com>
References: <20260123021445.3782170-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|VI2PR04MB10716:EE_
X-MS-Office365-Filtering-Correlation-Id: 4281fd70-b930-4ae9-64f7-08de5a2552fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KSCX1Sg0oHA6K7DJNOlq3sCyscthhtrI/9oGOgZ6xtptBAo9nx1HfRQJSjP6?=
 =?us-ascii?Q?lhCMb2jYu6/EFRLlRwsuoIqXeD4gWyVW6W+IjtERxGHWxjFH8vKW7smHVqY8?=
 =?us-ascii?Q?HPivjt43Ecr3RPaNmjM/3o8cWV9nYSEZk0Zjy3vasR4m5Z4PA4zkA3MRcJ4o?=
 =?us-ascii?Q?nB0nkS61fXJCx/T37eTH4sCju434LCubflnmsj6MVu92gaoPcJ31JvvDstJC?=
 =?us-ascii?Q?1H4ezXpqfBS5JCCdBCpzUxqsEdVvoR/kJi5it8vYSal7ClPIzovCWS7F7b/k?=
 =?us-ascii?Q?PufrSRgp0ENi0oI/dblVui4yFit6KfPxixvR5OgQa1Pp0SIZN6aTE8JLdrPF?=
 =?us-ascii?Q?h59ofZSqvkooCtgOWxUYC+VmVfNv6xsWlmRExOoq6fbDOqXKym/IdI3Po7RA?=
 =?us-ascii?Q?G3nr+CifktabahxwgnpZKmnJfw1rpd5YodiAWnPQdFPhcIJtk+FyYuhYJorG?=
 =?us-ascii?Q?kEuCPmM2JGOV3F+OatulYyrrXM0vGk8oRJrOaAL/JvmWsDcLluxBszXcXNLB?=
 =?us-ascii?Q?YBb3N9XONrXCNdcUnDjdFBzELgZpEddgc7pIUK2kcEiH2utN95NuKFzOlAhT?=
 =?us-ascii?Q?0Aq8qHPHhQPukswVRsLXQP+/ujvqe3yC4prMjKfuV6e+bcd3bLAFvoReIhU4?=
 =?us-ascii?Q?+2OjU8BGa7kTmynnCxzja2ItTL80Ig3HMgR0WRxyIMmFmz8UNf9GvC/1SVwm?=
 =?us-ascii?Q?wMbLrLgPkaGRNeqx+18ut6Dlec1U3un8qmjwdf0/cYR2fCcvXvmx1vjUTGca?=
 =?us-ascii?Q?FW85yQstDgtFYJaSAmZZAdShRuOx7MZd99+qPyqm8UrjZ82rX/S7bD6CTFif?=
 =?us-ascii?Q?sr6p1h9FQELxMjNhLGZb7+MinEx3+iDa43moxInoKUvaMZTvmJFPxxmMh2kA?=
 =?us-ascii?Q?X8/zx4KXNh/Jx52sYOJeoW+3OXzvGa9xCqsvDfgTi7zYlaXKLPK6XVY175OG?=
 =?us-ascii?Q?MNxpCU6bW9+3DJmG26rTKu05uGI542oTwaPfyhc2mzOm6IfgJm41aNQXQC9y?=
 =?us-ascii?Q?oHggx2xjgxBOTQEWbKmTDWWuOgvf53tcN4ONbj5IMw9R22wYbv/N1cJnnUxK?=
 =?us-ascii?Q?19HWjmoGug34bptPwxBSXM99u2Hqinrv2bQi/1ngaJ31yxYVUF8ir3Z2LcSO?=
 =?us-ascii?Q?cB3C52hZC7gJ7OUVzG8hc7shJptwsAg70kLvNSS7q6BO+DCWIVnYikFB7jZb?=
 =?us-ascii?Q?lRIEMJ0kCkjcotQZQYZb6a6jB/JDcWxoK2eleq1GUsknptpsvmeOZO5M9umC?=
 =?us-ascii?Q?j1PcgR8VodL+yoLfUOlOfEHz3DDmDlCujP9+Kmmekb3zm/S1XgilRnGw1wkK?=
 =?us-ascii?Q?8r/JBdxLq/qqtYAZwMKmQ34z5Kd6BSdWrKfBF9DJsjBYayfuTj3naBqvNz4p?=
 =?us-ascii?Q?5WzPg/nHl2dRhI9PmYGIFQCDTauO5Xa9f/e/f1+/aaFUssZo7byW05ICYGms?=
 =?us-ascii?Q?tXOZIFCbou+SGCwUm/xdMI9sMncqzx4ZGYGKIY35tKFXlMWV/kpZAh8OFtto?=
 =?us-ascii?Q?kHf17lP0mLsl5MKVU5PDvAmlHkH7WruFMpBqPTmb5zaqohpzDVIdmdlSkXKG?=
 =?us-ascii?Q?HLa8HWnfEaTq8UGNVJ7b/bDzTdTeQnKPXx1nQU9O0ONAcZMZ+cjUPTk+htjX?=
 =?us-ascii?Q?ev4RQQnqc/Wsm2MBqTFHyk60gFoIf9AlgmyiZMcuGUaM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+NlzYbL8NCxp3p150dhNqoKltP1KXdmsYINEgGGgyajJjd2gJh/yAj+GdudG?=
 =?us-ascii?Q?3vPFzW7kZH1RR8LaJuv+x80VkZO+YnhBGsNSXKqkdJNmPUJsUrKK+OlMBEs7?=
 =?us-ascii?Q?z0Fth8p1Sg60N2NHuwWwKhSfBkIqK0o+6JDz9TrWQ8Bj9osqpPqkFUI/g4lT?=
 =?us-ascii?Q?omJNldpmswHLcWrYUcD1ZggANTasJjHEa/2/Z048XTFDlYToQW4XvifNNpMu?=
 =?us-ascii?Q?CqyG1QCHMGP2ZkL2ozn6DzyoZGmVS558DW78HgfnOLyJzPRXjxcMoV9n/o9Y?=
 =?us-ascii?Q?6YnQmp0yHoqEvDP/xrFDOHtPADUe3BnSmNQ9OcnWsYrWP+Qi2m/Lr61HdST9?=
 =?us-ascii?Q?9SBYJBkVCz7w/PmZ7akepqlL4TlZJ2ooD4ZftLeyaqiq04OjfG8nDab0BM0u?=
 =?us-ascii?Q?SgnFM0/IQdRql7HhvhuIskRTJE4xA/b9A9joPiLP8LssQzSc16w78Fz7bGCW?=
 =?us-ascii?Q?5tyHZ+f70svWZFkpRZSjjHEhZA0BzX9AdtB/IXoJmDH1w6dHveWNEzbhuwLo?=
 =?us-ascii?Q?zjIyUSoB5s7XV7sfNr9Mu4BlxE02MSJfX7AstNOiTUPM+Gtkcwuj5fVHJl0G?=
 =?us-ascii?Q?2iankz97qmCK2nmbfKdwrIrSoJGUk1axwJbHoUdt2b3ZOIyXkiVevMjRuaRe?=
 =?us-ascii?Q?/T7Ovn8Fx6EsYDcB9RJUFObTHv6zQZXF+YlgPPw4JB6WvnhinmbvSXW1CTEG?=
 =?us-ascii?Q?PDV0ciUIRU4bW5uVD4/qvmdO8XVVyyW0kxyBB09XivM/0I8RtL/XFI9l0K2F?=
 =?us-ascii?Q?13H9REDfgxZaQ064LknjJd954UaxahDQOiCMGec/HEc67Oj9J/ak4DKozE8U?=
 =?us-ascii?Q?uIVcIyRdUz9Vw8LncrPa+0b3gPUBKau1yQmTftAEHehGMEuamUqYTT5gXphz?=
 =?us-ascii?Q?+Cz6BSQR8jGous0Q17zUyHTxjhR5fzPmd3QhcOnybwPjtWGSfaFZI2TbNBYg?=
 =?us-ascii?Q?dncgReme7kUDv9xsdOqNo1aYIMnl4wu/W0drAs+CpoNLKl18D67SNmlkwmx2?=
 =?us-ascii?Q?mO7i/UjFOHOlkVwfL5oylT7CwkRg9GZNPOh25BVybtUOocJBSli4w6B3blHB?=
 =?us-ascii?Q?TezKuxmxc5DLZzv1q/+0wgXxsygh3qekwi6vXnBl/4IDg/yhfibHE9UOvNGi?=
 =?us-ascii?Q?gqhCoVtKTA63geJGm8idVgqan7Hlz5M55JC7UAbJXoSC53615UJRaRps4Ziu?=
 =?us-ascii?Q?Io+pKBDze2I6pQ/eXCXh9KFhn+/Gxp0DSNgF0KFF7eJEtju+6Pfb8kE6MQk8?=
 =?us-ascii?Q?oA+N/UyCCt0MIuZ489Lpx8ArMw1ginYDYs1L5kuiSqCxf9xt3cG9KkXSMN81?=
 =?us-ascii?Q?MTNiyr/ubA7bE5v1TiI4J/aZrZJJI9mqAfH4WhgdPzTG+qgvM83IPB92sCq+?=
 =?us-ascii?Q?F/+z+L9U5OCGKpyeX2R2TtV2aMNFFWa/U+NA1LYbSWCMpR6P2i4Icr23/GVd?=
 =?us-ascii?Q?+i4IbBGxj6sGZfS8LSrs4rVScC1EGdda3LCTQcUrW8zBNKIu4pGSIGfkXX9w?=
 =?us-ascii?Q?jBwUbCVp4JLMY58YDvdo2zXxVw/UAwvqLWWczD1MElh8oGqgBAB6v1Alggsp?=
 =?us-ascii?Q?2YJZdKr2/beRlPhTN2IpMnCdFUdKECPco+mhU4s5Rz2turQD28qttNiNiRml?=
 =?us-ascii?Q?DC9ooRb1zMRx/ZuPNI/MVLjrgJYfHYDOA0PCrz6ZqbDskKBOZpLR/0qROpUx?=
 =?us-ascii?Q?ir+y0qeNI/49k6Td3nKfptW87vnd60afEV9nkusG0HnXagSvkcGb8mvGD4Eu?=
 =?us-ascii?Q?yKEyICbMwQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4281fd70-b930-4ae9-64f7-08de5a2552fd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:15:48.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiOm3ti2Es7zfG4Hk6MYh6DtgRMva+YsGWp39YMIW4etdVnLVenOxji+SuvOUwlfvXtS0KkDHZdUq+quyA7q6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10716

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

