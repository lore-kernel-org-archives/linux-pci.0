Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75289364938;
	Wed, 18 Mar 2026 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815335; cv=fail; b=lQ7vh6v3XCO+6snp/PKMGyCcHaJztYkER6m9VS/hY3hFxqwOvCiRhTN2MtxBw18oD2j7urknj5pQWnovTf0EH30DdK/0W/ZeMi/G2xNoYMJnoP7GUQoHXlpManEpd5LwTTeMifP8oLN0Smi1R773lC5tRPR4tfmtnZAT9eh3Y0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815335; c=relaxed/simple;
	bh=dGLGGGayHF1kXMBXPouDMRXOhNmIWfXdQITz3dlnR8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eE3xxVpCc+grdicCS2B1z+YYoxBWw3dWXQmlLInhaeZ8uiy5J201fPoE7hnnkFGaFvqlmmY5h7aka4EAJlYuRWWQPXFCF9ud/rGVbshSB+yKZg5LkhZCQ3ItpnYEYbUfOZaZIThKdH9E2+HzVkE3g7NXbhCFaQ1VNYkdlOe4Afo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l3kyiZT+; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l3kyiZT+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9gFkAVopisL/Hcs1ZbQrtjfCMaLZkqciW59RLjNzON7xYBrJZT1KmeyNx0FxV4zOFxaiH8cWx0XUcfsWgrZ5Nl0BkoYOqS4BZ8QWSYi950+ikPmgCr1/sZswVCT+lE49il2+mtm/vhtdzRYnDc4esSKfwnOEoOFE46dVX3c3VX5rRSH9VPRXYNFH8q6nZvPmm5sGtjYAbpKIPqLsGBlzAQAxMygG1ZfDCJE6JW2anlaOwWS7QAF2e0hRRrptqagQ8HZpyjvkwcZZBM9hn1VJuh7R54sw4gKNGXjIFtjPpMEaLzHNXeKvhzd5cSMuvbqDl9/rg/FcJg7FdGPz1r71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7MWOqbVCYe/S0udzXx29xH1QVeJxfwCDNt3FnYHEco=;
 b=cLCMQivy9bLg+RYToD+HJeqHr/EqSSjovRgj8+hOB1QnEg67nlr7cXeVPfSm/e7UWsjwWu87CyyurHUYh6U6eXsyFis0QP7zD6nHlGFCnPrPpjuMbVduITXoqWj/GoFhnnUNs0JwLBWqgY0hzbgaAltvvqk5JSGYK1UjBsURw8jU+dpsDvw0vzdmAj+qFnPVSMwRcuHclvk8f7IfXBz9UHjhYwB0nyOxjPikMQr0drRekCl4WzGeO/5OPkFgFUViyMmig3W5uT+kSCUt1T0vL/W1KhdPPgAySwZknq9iMsyZsY1Efok/FlnBW1Ds+p9pane7D52sH95aWqFmbPUuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7MWOqbVCYe/S0udzXx29xH1QVeJxfwCDNt3FnYHEco=;
 b=l3kyiZT+xErDkrBB2CLkO32kx8ADKD0+6O7XUxppDfgxvQ0WmagC3urcuGtJYELVAeJfSRjfirelEMweURsQxGW70HzRi7OxPm00O973dZeRa+Q4TQ2i6EMdOI4mAoE5YthV1kvvrI89J3sZjD4hJQZbhk5JpJ6uLkhzZKqEIbAW65EFF/STO/1rrLE+BuBEsGDaPfMlKsfGfUJdoXqlFztI4rLZcNuHXddsf0xBlHyStwfLBVWowVVi9Oyo/y8uP66HRQwXmrte6wyXgJCfSeZ1FoDubDuYQBTfG7QhCO7/V1A5gd3wIHZltmPbiCggDrNHCUog3xnxd8jMWvCUew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB11334.eurprd04.prod.outlook.com
 (2603:10a6:102:4f2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:28:50 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:28:52 +0000
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
Subject: [PATCH V9 07/13] arm: dts: imx6sx: Add Root Port node and PERST property
Date: Wed, 18 Mar 2026 14:29:10 +0800
Message-Id: <20260318062916.2747472-8-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB11334:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb0c2bf-a1f6-4a38-96fb-08de84b79f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|52116014|56012099003|18002099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	a0exnVvqtlrmbKG2q96SgQgnvy4yqv2Il7TmSNKPyMvOgfzAJsmNFLGx/GnNHqxTy3xT6nxxyLOdbUv/JhOTOlSqKtfiGieHvmD8FQh//ue7989fvicgkr4lXt9hrSQbzAuGa9RO9BcpGx9Mb2RQe2hY0ePrhwDkAjMlbiZW4cFL+9IeIu5hsgTs3wx/IxLFtVQ7RZExbe9tBeY/3EDKgYUqKrc2xn/wGu9rEi410cOJc73/6BMaZjloNaxsvmn203hi7sRjvvy2YoYA2HIeDTWfFDFGkUR2hD2p/IvSucEJ7e2JnB7+79am5N+OpkZ5S/4N/RJCcHgq+/whWtZj3A8Rto71cS0dDfMH5g513T7a9FAb/kFL+Y0tGxoXNIAReH/+kxD9AuSsddiPDwRk5BMj6ULXiErD1ikPhHLrwYP74qh/tMPF+GRPll/CLGiwJKbr/6Ll6I7CygEghUYPSjc4n4K+wjKz1FM9BjAFB49xSalkNd3x0NWIsM+5PnRsbAbQVX2qpHF/DyrRhah/QEt3+PLK06RegBgMpJxqjiekB3rTpTXG4wPcONEW7YH2WkiQmcwACdVCoyq00C7jOeQgJ+wwyGwgFGAreRB27OE4O7jmswQbZgRf+iZZ/MlxYXvXePlX16Jc5hl+4aZviAPUeDKvfntUdz45YeESW9aoEnBm5juik+O58N1gYsuKRJ572OgrgWOwchncRy59vmiqhaxzkEoFqCy9cDcAne9lngZ8LkU1SJ4MKZjxDL12kmrmXwvVAniiUvYh70PpEIhs9IOv2tr3mFbnEo5dz3u8CZ23a75HFFFVI1Dmqq9Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(52116014)(56012099003)(18002099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5NiynF+OFCtSwAuNO3StXyjFn+aBVdUxvA3bsHyb6qNhBCv79dLIb0/DDJop?=
 =?us-ascii?Q?jaRH1UcXEhTXvzpgqTNGpoQ9FjaVufKtsTXsjilLxsC9jfbhBAprONkyH7PS?=
 =?us-ascii?Q?srYGdadnP2TvgEm4alfvKCdpJ+iKLpM7t7aLJ4tyqYNtmdQ7nFBzs9jBgbHP?=
 =?us-ascii?Q?Mm6wcyi9TKouEcIBq0K7vyqgoGlCNvESkwZvBVeM42f6jRJ+aKLQQWOvE3D5?=
 =?us-ascii?Q?IHqB2sHKt61l/WbAuGQCueSlxDJnCp+f/P94H5my+GA7d7a0ojCv7IJvoceV?=
 =?us-ascii?Q?LE3rU+WZCnL724qX987HoIcY03I3lhDlCYsTDkQNiEWrCw7k3q9CJylldbXX?=
 =?us-ascii?Q?rS8kfP0G75kJ2z8VUErdt6I4q+45bA2IcZIwlFS0MousQ6H6Up2XPjZnpSP/?=
 =?us-ascii?Q?kZv+0mWNYfo8wmMGN3UnuHLjgult/tlUHw8VNvnBw351NVMeraoxa6e2lXcl?=
 =?us-ascii?Q?g0KfGcdGaAgTGuSuMqErsoyA8grD76MECZzHKLkUPDabYdh4pqVRCgLWra0J?=
 =?us-ascii?Q?Jaa8cZ/ytEbZXdBSLf/CwB28aNvQKd6xpCx1IZmT+0uY3co0t0HUfrcLLMbT?=
 =?us-ascii?Q?W05CTmZGWTD4yI1avzXhNYYzQncbwYRVFimTD6JbYTSxwGoFGjV2Cj9OVG8C?=
 =?us-ascii?Q?mjqdNxEtpj1IqZa1bSaAU5xwGzFiPRJTy7VEwR1kWjP3H8Q0YiWv55OLUVzs?=
 =?us-ascii?Q?MiOAULjQMJyw5FJjmsQTt6tftIwSKjUmy/S9OxUlsn72ebpJ1+8A7PH/5Xaf?=
 =?us-ascii?Q?kQuxDI6Ag95gbk6GwWB1avGGyw77p33/F1Vtizgui0ceLfL5U8/wPPpj3b/J?=
 =?us-ascii?Q?3//N43wbBQSo1dKsoY0vqjtsGNY4zUZNkbZqF/Viva5tNjNkXhkS/G+8mJIf?=
 =?us-ascii?Q?wxBHcmHTZWbYVbxm9RPwdQ5FbY1X6L7QbRkEDJpSIwtDJ9/ik+F/6BH3ZELX?=
 =?us-ascii?Q?pPWUvLkDx1DpWGVapzMOXf3kPbyBxpMoS20SExUzOdSN4gnT/k7wRy0LOqz0?=
 =?us-ascii?Q?H3nBfV5Miw1LwC1CCDHOpiifMlbvJOuKwVLrGTmiwuscaOWDFTk5wMCiofZj?=
 =?us-ascii?Q?1h9QAxHBNNgFXm8fIWy0o+ATDPVpY+F7nMb5PwPXmjXZj3aLJ/VNhTAmu9o4?=
 =?us-ascii?Q?DLioxgyPEvzv4J6vJU2MaFT151ZzIWg93lRM599nHuFXzIQIHZ6TRBAaEJnm?=
 =?us-ascii?Q?rsW0fEkOde2ucxYOLpUWzj/LB9HGc5Ubpy839W5LyMobHMvma1rN/4o8q8YY?=
 =?us-ascii?Q?QApS7eCCJ0zZTuDpeJSCzNT6thK3dGfvXiirJAZ6tnWWGagGCMuTVLiCnJeQ?=
 =?us-ascii?Q?bKuYkZYnaroenKbXFFUqpBwqrCgEn+cxSTD+32ftng1CNXO3JOFKRCRN7bIT?=
 =?us-ascii?Q?Nnxk7jg2rnkyhfxk4OQSB8LSpMFGD/s1uRsGIDqVYCfFqJrAO+fSzICWlmp8?=
 =?us-ascii?Q?WF+z+qhqMUBtUl4oVkXXWOYUqKBQRtSGFSe+Gp3JVPBOq61Jmj+QoMRh/2iN?=
 =?us-ascii?Q?A9yFkQp5NDDgj4Hg+2xr31RGlH6M9l28Qie9WrZUW/xXkj68FNsy5lLzEXmR?=
 =?us-ascii?Q?MwQaRO/tUWAsX1fgmaEOrAp+Yilp0uUi5VL0bw0ntiAcwTRrvttiAIQDm93d?=
 =?us-ascii?Q?+4nZ3dLOxTtPTGU7JUwChxkzZqa3asc6r8beyCs6NbfYhNXRowRitMt+r9sM?=
 =?us-ascii?Q?YfeFaD46bBJ4JeP1tulx3JW7Dedov8H3LbF58nn1BSBGYKjARZU9ODpPZvYT?=
 =?us-ascii?Q?fi1fCBVL0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb0c2bf-a1f6-4a38-96fb-08de84b79f24
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:28:51.9603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWPqiXQqU2fewBXhozXqGe3odfdb/Itq9F1sZ6FOh4WWKAf4HL/jFUjVkcZwmDB8ehZXV2LrP94MMvxORyQNGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11334

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi     | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index 3e238d8118fa..338de4d144b2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -282,11 +282,16 @@ codec: wm8962@1a {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie_gpio>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+};
+
 &lcdif1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcd>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index 1426f357d474..d42363cb5105 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -1470,6 +1470,17 @@ pcie: pcie@8ffc000 {
 			power-domains = <&pd_disp>, <&pd_pci>;
 			power-domain-names = "pcie", "pcie_phy";
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

