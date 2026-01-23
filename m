Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DB36D4EC;
	Fri, 23 Jan 2026 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134650; cv=fail; b=L9tnJGFloaYZYUvjkjP/qxmlKVzFZo9aPGAEvFiLxTfoQ6ZRvsHC4+lxKjtcnFuKyM51TIU0KDfs865o2xEaKCZ3LIotX8j37P5SAa7n7Z02tvvYYsiP0WziAzItLeInHoYhRDRZ3ZoKNysSpRLRwAlbWWnbUNH0t8KnR8nsETY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134650; c=relaxed/simple;
	bh=AAkUszj6SPnK2uMoevOU62XdwWErsKVAqBVjYvH/RUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqsRReG/lDWAIq+gIL7PZFu1PVorDWhpv2ygPdWAapLpr7qaWLl24jzVFGcZJ51r1NmojJVGAzEd61ywNR4qgn+r3jOzA9A47Z3h2/NNXuRvxweX4xt7BJAoks2tAC3VTE5FeMRNTEbU/SYPN+kBMQuKcRdVAzA8SnUFtBMR67k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FEo61R1A; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FEo61R1A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9gSrG3K417KvQOH0rwSJTqxltMT2cpRuv/t5YNKgRbZvOiq+Eq5gBfpSXPvRQ6lICv9ly2hYfd0uv1NsjSaY6VBNSrJm0bMuo1gjlXSHZImpLFXQE5w3PuPsKctveDzRk6QjV5znQu4v3cVm8CiO0OQ3HzRdteC/13m70AzuKqaiAwjkD9HJPnuCAw2KlrSd49qOLvuyNuUe3FML7j3rNQV+95CUjWYfldMzXKCJKrrMRJIV+D/XdeckQFWR5eoY5OLf7S2pg/bUHEzy1Z2NsW8WIqdT6fvwMKJQl63gTdzHO4mFx6iWN+z1rXoGb0UMrmxnY4qomGDuUh/F56Yrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA6HH3oT7NxLhdanoXDLc8ORR9yhZ3AIV2S3H1AIpj0=;
 b=CIaL9V0xIFFPHhC0V+PSgT7+Q5gWneX3mRt/oS/5LIes4Ts37nPaPJlEBXw7S/46WkJWG/wWLDvphXPkmgjXtYSaVNXxxHAOlpK1lO7npMSvVG7UOO0isgmaPTMXdqYkh5boxA67bZAdfUkfFA5ONOCcmwz6TglWeRN5B1wMYG8lY7Zmg3iEI1O5HbowtvT6UDfHvSH+FpnagqQvbuhotbiDOGuEfsEOxJzXP2DvX/mDw6qJvFUxFjcieIFxSGDP0EOc+rt13pz9VqUQnLAfKZxoB8xlyMpROjViwSNfHJKMl5IKrA5SDgg/xfgQcMxh0CDdifmTlbKRE9Vo4jlXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA6HH3oT7NxLhdanoXDLc8ORR9yhZ3AIV2S3H1AIpj0=;
 b=FEo61R1Ax7CiEallGbe4W8zOO54GDjFWWFfN0yvQEwKD2B85iblw3h1AwkYHvuRRSnVJm/3tp//LWQ584TynoyeDIWuH0cJhCFvxw7KsuDcBQoyJq72DMf7u92PSK+DWJQliLErd/qdt/SMRzdw5xY1B8FkwK8jv9T2vpjrSsjAg1YIodEEXTftTl1fNqrrCNRTom0WTJq9aydGaxSmOYu88aCRj3e0BKEj0uqswTI2v1MDPIQD8FrON2BQGXdpgzOaXcF3GOVoEiry0obfsarMbxFFNm54kyYzlVwwjsCZ3t/XHmwm0CB+jbTYG3xxAzHOiC5tP/U117MKvV4e2Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI2PR04MB10716.eurprd04.prod.outlook.com
 (2603:10a6:800:270::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 02:16:18 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:16:18 +0000
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
Subject: [PATCH V2 10/10] arm64: dts: imx95: Add Root Port node and PERST property
Date: Fri, 23 Jan 2026 10:14:45 +0800
Message-Id: <20260123021445.3782170-11-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 81ba77c2-077a-4f8e-9a79-08de5a2564a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VVWvIUxji4fl5qiN89wWZFi43LkKnIpU35qTpst9AvfnHerBlsC1u2MvDg/n?=
 =?us-ascii?Q?pwcf+F7xbZYaRarIDQubnQ/GaAjiz+tOASQ3Sd0KMLvmQHOY7orHcn3k7kD6?=
 =?us-ascii?Q?f0/hAqZmfAmnFX/zVmfdb6rBprDHgP6yAqWu87avgBNEf8W66W+Ddg+gaId3?=
 =?us-ascii?Q?ulikeB+fyUoX8R9c14tNr8a0z02703RSXbf1OmjD2cCPFIb6/j7jEsCZ+zKn?=
 =?us-ascii?Q?N9fVeNM0XLd+JegEr3u+Ue5AsDMQM/TTQA/bISAvk4Rn9tD5hIskd1668XPi?=
 =?us-ascii?Q?/jhgHFEOYomGJPLRHf99H9Hzx0i24+r4wadNqN8mpWUl6G9ajnwbuQsQmjn9?=
 =?us-ascii?Q?JSuIhABtyo8LtT71XDIoo1SxXHZ2ZjM7kKy3FNI3iiLmwKS+MxBLr+DxGqUF?=
 =?us-ascii?Q?Q7SEs9ga4KMpaJq+zD3MCtwMoQW9SDFMJMnWrL/oPtf/odd5q8e5oRubxPNJ?=
 =?us-ascii?Q?WQLktFweb4PpyHIpieIcprdD+mHe51QE+6QsN6uZRMTonWzyGCHow/My7FGd?=
 =?us-ascii?Q?N3Fmp4F+l68vLVcaIF28eCH/WDoGq6uq6f0sJDo0jCBDbdOSVd8MIiDUj9ie?=
 =?us-ascii?Q?ski5Rm6MWUEMaB+A/VC/1XkB+3kcuh9iWfESEQwzvNwxAzMVlaeMYfRWTvR6?=
 =?us-ascii?Q?I86nbVpZJ7zxf6e2oW66NcJBXwCuoTa0BFzGdfeUiw4VUTaCFI3vCJErcvFI?=
 =?us-ascii?Q?jydm5J5Fmc3D5wDg3ULlzOG/52NEayga12lOlr5gHfib1a+LTu7K7cla3jzb?=
 =?us-ascii?Q?rPaog9FP8IaXEYAdzj/TJ9l9RejbZU9sC/h6qIruBXOg9aDWz8+egeE3V6Lz?=
 =?us-ascii?Q?cXS6IS2Dc4em0YGCruTnqWXqxNvzBG7JFnsMDqf7+F2EFOFHBfUsdjWs+UTq?=
 =?us-ascii?Q?5Y7aVIIMO6A9oBvF5dISdfSHIV7P4i4sZdTqgcuB3G6JPMFCQ/nt/K2ItsOX?=
 =?us-ascii?Q?STjpeEiWJshmZXonlZB5AcZiXHLZ0rfpwtFtJmINomIfsEkiXeLAA8WgxCt+?=
 =?us-ascii?Q?IRA8Nd8a8noQMPSypy6l7y/n+nROekbraMf8RmkCIo0yYdmHr7jmFkyN6fLf?=
 =?us-ascii?Q?gXIBgraE3IDY3WLViSGE+HSRXVaTM7BvppSKdNQ5njuxlE/bl2eo7vuyq5qH?=
 =?us-ascii?Q?0gb4p8outb+u6g+NFnwXi3+yEVP5auCexfVl90rnFDvb4VFgyFqW/Hvryfh1?=
 =?us-ascii?Q?ljIQUu4C1lx6a2+ZM02A0b7tT9ESQwRwrR964M0/o0W84lIHaqJV3nlMBz1V?=
 =?us-ascii?Q?wdDe9VeaKfMXo8rjJZpR2xJJjhTw1RAOAkX6anw1f8bjVXKF984SQNl7lkHx?=
 =?us-ascii?Q?G5gdbjTotWb6om8Rx/D8twL3H5O/qsUcqZ7VHJ7jyCBcY0S365QPfpZ2+pJf?=
 =?us-ascii?Q?LZPiszFV79sKJEuNp6SDnr00De/yQK1WhDyS0bx98TBsU08v+GwPsvUky4wE?=
 =?us-ascii?Q?vufO5Gqsf/SVNO5mcHsQbabZIMBSwfIs6CSql7MbxKDI4+t6vGWb7cqas9Af?=
 =?us-ascii?Q?n1hdou4nHd/hxqWydAEipRoe4p+693gWPj8cY/h230Wwpq8OpORABcyV62SQ?=
 =?us-ascii?Q?UHNNbwsLs9KraGPvrvX9VBUnYfp2U2VgCS1ZwMw444hvytYON1DcBpqBKvKv?=
 =?us-ascii?Q?ASDJXd42UYfENvpJpsbYSKdXAn0dq1ixMMugUMgBJZmW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?okdUOUuG5NIyhDBzCl9szbt8cJfl2AVyrWJVCXBNjagL0W0JLfcA2SO714Ow?=
 =?us-ascii?Q?YAPlgx4VDyy9dJ/16sEwsi5wxyctLdrBTBeocu0Ii9W2ESF5sryPjITAKZJI?=
 =?us-ascii?Q?59UVI5zizq9a1+ifPQVQM4tSQjQCz5AVv6ZWTjRC3MBe8EEq5dmI4y5b8bSa?=
 =?us-ascii?Q?IsECk/4EelsvBK84HgyOC585yaK6qUQVWjhdeP15DxCTukwST/Hop5Zh77oe?=
 =?us-ascii?Q?IN/gHCZNVinyDoe5Z5IRIigz5KprvHTtRxfsVejaQ787IN/8vE3euFfrRd0l?=
 =?us-ascii?Q?5Jpb8a6I+qYgh4yc/x7LVUisfbyA1hbfvysCrfHSTMejHrEiQsE+IXMtKJ7H?=
 =?us-ascii?Q?gVMiONgrnHeNPw/MHjMYvA3ahHcqAGk9n++0sN4DQXWEgpe+BXFWAtDiLFUk?=
 =?us-ascii?Q?5zUx7C0IUFv05c9qjOhOO0bcMoh1wz8OX+qU/zC2auh7B4gXPEIFGznE39lX?=
 =?us-ascii?Q?9tMWz9dJaekrtgSS9ZUQKMi7+5AA7+1om3upZRvjFg3q6PilvS5BJTTFWc/d?=
 =?us-ascii?Q?VLVvUjc4f9WmEGHj4JX7ydfcKXy1/TcTC2ppma3FTmJCEp/eUZW4f/1bbd6d?=
 =?us-ascii?Q?XAjAzx+9BN+4TEOuFbi/YdbHDyxKWpbMYClKTxFSMq19eWLciF/X5B+0A35y?=
 =?us-ascii?Q?4iJ90PMdVy+he77sk3e6clTAWP+Sp2jNErx7SbDQU1S7MB/uIwFCY6mZyG6X?=
 =?us-ascii?Q?xwDoS4SQSsiAOFu84d/07KGZUAD7asNiTPbREuJ+VaXKXlbwiN9WwCzYeunO?=
 =?us-ascii?Q?h5+8A0+iQ348DpjiMCXkAjXujnXmL/5dkc6Ua0BCZNC2utv28HO4hfFrhSCs?=
 =?us-ascii?Q?Z1idJA1yQbCfzjg+f+j91/Cy5ViGMfJUhtkGPgzZPiY3BLVHUxzwufktYLam?=
 =?us-ascii?Q?+sELD3+KzAj+++WMIXeiD6bo7lxS7o5nCMCQNe0eWY3iCj9g0QprjXt46EeM?=
 =?us-ascii?Q?3dLpFsCue9Uh0tLFNeFOEJf/FiH30eTFqiT+1kT2TkdeX6nspk8bEdxTmb6I?=
 =?us-ascii?Q?iW8gw3NZT30dvYsr+z0CWIdf1BeXtIfPQv3xmpsVnzl29UkV9OraSw50u0Yv?=
 =?us-ascii?Q?xuilOhn8+3Zj6I0ncg7cHmkzn2F7c39n8HgsBdI9aadfeVH9HYpHbosY9Ixi?=
 =?us-ascii?Q?Rst4vuP/vRNsz0iePy/zzIFTIOrkaVm4xjZmKlH+yRjytkoz/L2nOMrxGVP+?=
 =?us-ascii?Q?8ccm0GpDj5JmG6eHxQp2L1BQPFrJ4K+mzvXQnv3iPpVmK2ebpKinPli7/IFZ?=
 =?us-ascii?Q?6b/I8TE6H1p4lTxImw0p0chxEg8/KN+Y9XZ+R/dTBxIy2iHHDVZPuNkxTcGc?=
 =?us-ascii?Q?EBL2N8NwRhHv1EdqLXzlFOuhgGXbC6Z04BCrcBZzinkSTwqiXF+lbQ6WLkIk?=
 =?us-ascii?Q?iPUocmkVD73e3UZBKQItnxxhHNlLU2j5PD2IfOO527vE39+wAxlToOSjcjSa?=
 =?us-ascii?Q?zGyu3OS+jP0UUyc/+K/E439PPYk4Eansq1EQefj5y1+SEAuEbRPqofrOEbG2?=
 =?us-ascii?Q?CgvvKUrGawmUUVDdMs4qzL+SNhx5xOpoweXMlqz8/xbcOjI94YL4P9KkUkuj?=
 =?us-ascii?Q?Pr9oL5aQl+GT4VA9K1lpOwc8zOqS7RPLX5k3DW9DpBqgGXRGo2SB3dD/uCc/?=
 =?us-ascii?Q?nOZuFFGhScGJi66D/iJJ/btBuY2BUY0ZWuAXBAvJabhWP69j57P+R8bzDQNN?=
 =?us-ascii?Q?eazxxdQE1VorwnOOcNYgmafIk7vpQ8tTFHXDc9mkMBOcVmNAhuvXVAiQF0F/?=
 =?us-ascii?Q?+njkByjXpQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ba77c2-077a-4f8e-9a79-08de5a2564a1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:16:18.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffVm48EivZ6aXbG5jgcc04mt89AYyrqJ/Xa8NxnUG+rKchw85dfZj2lVi9hwvO3/F1r3ijoxe7a58D2fUMZ6Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10716

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
index 55e2da094c88..7c5f350fe3a4 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1883,6 +1883,17 @@ pcie0: pcie@4c300000 {
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
@@ -1960,6 +1971,17 @@ pcie1: pcie@4c380000 {
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

