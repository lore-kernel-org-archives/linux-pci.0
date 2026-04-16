Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C32F3A75A3;
	Thu, 16 Apr 2026 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338031; cv=fail; b=iH2UG5iRtr2jhm7DJHh8vNBZOFR8SICqe/0V8DotteEM/YEBQucnzrs6kZbP3UXdCQZMLT7dBDlD632UoO0QARHRRDji3IlKURkzevclRB/9Hy7qCxELGJk+M+DO1snSMs+irg35bKw09u9BUjQv0tyLWDq4qSW4xVTqjUmbdxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338031; c=relaxed/simple;
	bh=p3VWd4Zk987X87jiTogJXJ5Nf/4FV/Sb9DSkzZu+rrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TDKLejHWHdXfds5aSrRJVIkVzcCfJR6pekAw1Bc86yaZcUJrCDmgypmVdZwp6bmfcTenQjjOBUdhTkp5sBG+a7wNUY/LltZR88Y+xYVA0iPdOFaJ9q9/B99jfA1g0rEo5F2z9bAW4Ba2O7mZpVwc7qFfhxZzuT9OWXwm3IG68RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yr7dt7wc; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yr7dt7wc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDHo92yinPinFFV5Zp4+TezmzpglIYgTaiXcwIBiqrJbu2IdMi8eSi6Y90nUpLZ7dlb6G1rvvzKWLi4QX1ttEkwhXcO+n5MgEC/ChftcgskcOr/qQ39fMx/Ip/OPt0alofLhcg1Rcja+U7a//jyf/bvflNbBxXsYsd7GOpqjNo3r7I0x12djGIz/7Go64AkMYdfkshP8Gb6YTSDVlne4RC9aaqarSd6NkQvrR1qd0NXERskrEkUjWkTMKqRV2cJ5hGowOciyaQk9kzfodxGuBwbNGk3d58gBF+o/hjXgZGxtFv+TtR9Gz2HUy7k/ikWXKYu5Pk5CLEdUh4ZnbgcaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnLsoxBtlKwwKIXSSpdqg/p60UkV42ewo5fGCfmOMXE=;
 b=ldVRAgFPxKQxN9KsrJthooTYQsLsqToPj2oa4Emx+1hMpD6/CFhbkhYH+/X4bjn/oAe05ucknwbnJQKPpZdmdd3Q9lBJKoZv5oVNFpnnx3EdSvZnMrxxvL/Wv8JkrXe1Sbs+DULDdLMVC2ECYsvSXxpfk0/TifBJ2l4eEMAsiFKFNvj0u5+Lfo64BzD2ktnhNEIfAJobi0YUMNi2PvjNCuXmEv5Q4uGZcBZQxLVI0saZwA7+Lpgf1W3DhOHDWpCiIOthnCGKlq8L+5a6F9w1lceckAFhFJwhpmW4BpvHm/Zp3wL+vGFpO58e0i/WNpo6p6hyk8O3BksBCbOwro6R6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnLsoxBtlKwwKIXSSpdqg/p60UkV42ewo5fGCfmOMXE=;
 b=Yr7dt7wc3ebbd0E2ERaCAmVUmZcICr+qK9WaO2MRrvswJYp+Yx+vAH0WFDFz/iPK6VhlodI383B1y1eYK3fmw7K/UDT9hD08jt1TzJzCPA+wScZ4z2OFlDNAsvNApZMRFk0F5q1x+dC3uPPumtLYqu+DoB/97azpOJehbWXtGMfW1hy5/FP84nq3LwJWtNVdpVRooowm2ODMwd8b36JTt98ry0XWpRliGBYCswIeg8C5aUJCD8O/mmK0xIrHvbq/+MaP6oLW2T2qUNDWU72pAaF4+DSr/pEIt82UwMNv5o7/TmC85EbFYhATa5Tmoka9aEJ2zwwkNmTRFPDkIP1uaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB7668.eurprd04.prod.outlook.com
 (2603:10a6:20b:2dd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 11:13:46 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 11:13:46 +0000
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
Subject: [PATCH V13 08/12] arm64: dts: imx8mm: Add Root Port node and PERST property
Date: Thu, 16 Apr 2026 19:14:18 +0800
Message-Id: <20260416111422.183860-9-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260416111422.183860-1-sherry.sun@nxp.com>
References: <20260416111422.183860-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec826e7-9d7e-4219-6501-08de9ba93a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J2jcSRr3BdntuKb3fRL4QB/BNiUeQsRQ7M72UUUS29QHwge8cauw/oJ0Ok/1oKzBrpUCIZRyfyIz6jVyA1qr24NK01kWa5oJRmTOwfPaJt2xrddHCotbRCB30rMjupfuYno5JzA60g42IRjB2ziK78ttJ/iu4eLai1N0rPe/fDNEWWOD8qqfSn+ZRT8MEWdo8VDuhs0F8XN/FJeox57ASe4eTr65nZX4u13yAL2wqHRhP1l3ZMS6UVsuOZ64miQ3lvCLbKFj8SFL3ZVlAn4droJuBkmlmWkJJMe9NAYbAGbNIWE/5l/OeHcqD22/cX26jaanQzL3Ihkvx1PBIIiLCz9TiwrOi4phR1aMRopIY/hZi/qSeiCuUtcHj6he/dxNVc/C/2Pf7JYJwhYFu1h0TRACQ8I3AvWVOH9p9jICtNYISKLA6tH4qZStTrHrfFR7EZTg1fOB8LAm0bJzKOyd0w3LE0ob9b8Y+xZSzy0e1n3wUfzD2yv2fHbRpDeD4OlLql9I3U1sM+JNUYDNWaShwHaOBXVV/LSaOR+0TNXgRjbcvmrOqhfGZ7XKFv3o+JLPKoKr+yXyehRzWKAM7SrS1p8re48N8N0COpCuuoEa+Mo3CJO0mK4wND7VyJH8ZcTX6Lh4asbTni8eRvOEU+SzU5jER+0MbWiTqBlF1SYbREOnt29IUrbanhT1Ma1RuWgr+m+BWLfn2ZolZuc12I3/3xm3EOls/uM2ivlCEAgxjO7Gc8tv/VWzOsln5oiv8Dl71SmnljgAJurO4r7lFCeFE3ea2SII9SjAnarQiUZmhMpbOAR4H6mmS761TyAx3voY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iDaSKiBAa/7Oa5UgZriA7zIOFcWiPFcTpfJPJAKEwZ8j3gM1uxQLadgo+MOg?=
 =?us-ascii?Q?IiX0hFmgbn4qaN/IrI5S1ceeDfHDB8gMaFq2sgNP0fTauDKrrtf4hNrxKSPc?=
 =?us-ascii?Q?Yx9iOmzfiuOvpQnUClG0q23JYfSz9PL0iieoLjPN5oil91LrXfy8zPodLvfP?=
 =?us-ascii?Q?+XV9ujYhXqCbJj1xuc+Ye8uDVsL8zr2MpuYesIPHgUN4c5hHKB9MUkjyKXrG?=
 =?us-ascii?Q?P5Tb/vdCr8Xq9u8hIVoD8LmvJPjvx3qLiiDg8JDcxkezSLt6gOrXLb81+NLW?=
 =?us-ascii?Q?Y7U5q1kWkpRZhc20N/iMBzoi4iCagOiTrRbnieMGx0c27A8c2Dw7ABkzRjRZ?=
 =?us-ascii?Q?DnzBWxuZ3N76r5/KzEhIbX+shsC8C3KTaEWNYaM0+PsuFssHX4h/fMZz/j2o?=
 =?us-ascii?Q?+vLETSQj7l2f6tIdGZKaHS/HYv34THUqXOrJka86yBfvzO9WfaupGlbRmBUS?=
 =?us-ascii?Q?3BBR/bQnq/+kat0Z5bgF1peTWouUg1hNg1IP6OCVUDXuMQdf+tCLgLAPX5dX?=
 =?us-ascii?Q?F4+7NqjLaDBD+eieGx/hBwoZ1W3LICHxW5OOnFqI5x9JoBXaw0sDpqk9/qtM?=
 =?us-ascii?Q?PLbPfvH77AMJloxLuNK+ZVIflxbAJ3NBH9ZSNsb3Ne7eIpXDJERhqkU70D3u?=
 =?us-ascii?Q?wwSlCjQDUQLJJuNdWbTaSSNJvPwQfYso8jGZIWkSnE49oXWHoyRVw/rw+U/V?=
 =?us-ascii?Q?ObDsazCTch2O5J2l+hftOOpr5uUp4nUfr+T8NGyOVA7fdvZfEiTN2gSIBJdg?=
 =?us-ascii?Q?uQCkf3Roqp7baoDNqM4AKAuc0vT157P1+n9jH7mQzi63m6sFLaun1nTp1DaQ?=
 =?us-ascii?Q?wZa2eZAbZDpt9vitjQKNFB9o40QVkyOaBKkS9DIunR4zgeT54u7ZhdnUjNZz?=
 =?us-ascii?Q?eOn4BiJboSQJvpZUgC861rHlabaoaXw+OVhEywyL59o+GYR9mL40bXkDh/yI?=
 =?us-ascii?Q?MvgtRlrMMymmgzE6t1ptX/lyP7vVDCNdB2tEAdOB9ylFAdYEqkp80hb3UDuf?=
 =?us-ascii?Q?R+Zs080Nxu5P6WWBsRT+6eJ8fZPkrQQIDZ8o7a1hJYXtjByVqY/JvYPtsHjz?=
 =?us-ascii?Q?AMBPY1olKm3hH+DfKVJVb01xJhR4wdXp9NQ5rRQjJoehjHvgGcX7kPagtNtA?=
 =?us-ascii?Q?GPIJBB2+VvFpbErV9kC1AALtQg+AF0kKK68eJdyfFKiwuUTO9JOV++hvbbvc?=
 =?us-ascii?Q?igjjvcTkFo5fxTkijZ3LnpX20jgoNDXC0rdj9UO/feBQD+YnZtXsoWxUkYfS?=
 =?us-ascii?Q?Puzm4aJBKswZzqLN/XGfYxW2M0kUVh6WIzZHLadrCMIwEOrSjtWZWg/N+hDE?=
 =?us-ascii?Q?rqYaw/W+Z42xd2X1HlnSJL1hDS/jbed7vsy2bhpaieve+Cgr1Xnhc2Wy2DoZ?=
 =?us-ascii?Q?y/oiV574elI6Uxi/n/WQs0cvOle/xZFAvaAM1BgxLCM8T1zKNn3cd+H7vkkC?=
 =?us-ascii?Q?O+7PZ+Rli5VLrsmVqYR6udrBqL8DYlqaaSj0QOUZPsiXTDrGw0/TKr0TI0zi?=
 =?us-ascii?Q?Wl8GVHJsilj5Jmk9mEMHjb9jAZHzEKKfa/euh+lA9OoAyZ2XuFMEvBWazpqi?=
 =?us-ascii?Q?GcNc4JDJv3o3d0H2ox/UnNNc9V7AvR2JAiql4oWm9cqpTHca3aefTzdBM76p?=
 =?us-ascii?Q?OPJ3BP4wmQ0hayudxcVGaWTc8Y+3zC1veN4eBQuTyLlC9mwp1Hf+yosYQxx0?=
 =?us-ascii?Q?uT0MY7IBGIKC6YbSeTy49hCo7b5ixHDFHY52X5sTHF7Zupic75rdLntUDvzT?=
 =?us-ascii?Q?kUSSI2aaqA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec826e7-9d7e-4219-6501-08de9ba93a2b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:13:46.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMwSmz/E45CTUgdwFYp+SQS8NJBPePaFNqQKXJXXDydQyQyMHbPaAmuFwGXRKQBPP8c5FuW+5M3NJEjCsRFPnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7668

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 8be44eaf4e1e..e03aba825c18 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -533,6 +533,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&pcie0_refclk>,
 		 <&clk IMX8MM_CLK_PCIE1_AUX>;
@@ -559,6 +560,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+};
+
 &sai2 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 4cc5ad01d0e2..5cf2998d396d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1370,6 +1370,17 @@ pcie0: pcie@33800000 {
 			phys = <&pcie_phy>;
 			phy-names = "pcie-phy";
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
-- 
2.37.1

