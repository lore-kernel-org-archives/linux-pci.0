Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013037.outbound.protection.outlook.com [52.101.83.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262E38737C;
	Tue, 24 Mar 2026 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774319379; cv=fail; b=egHYvrCCke07LoVotuhWpb4/aG+JL8IiCY4eaJOoAF+FzCftOC27UBUsSjNJFCGRAvYYoFUcTe1tX7pvQj/T2MnZecymwlZrjvh6RcUKz4H35h0/mXyAiBjNBw7Hh8LjRCmCUxx0OlQ3YWRpAnod0feYAoPfTw5hyN3iAOLJPEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774319379; c=relaxed/simple;
	bh=mwq5btialApKywVOD3tImgKNOxrm7kP7sYil9geGAsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oc+qXYbtaXkXQfgYetP5Gw2XoLp+Q+Ng3zzn3pcQOFLSSQD2vr9oTIc2CpIwMsFP8JXK7xrGXZMiXk6qBWBjVTSrJiqiWriNy+3D6dYPBbRfPZvspRPo32+/+npRl3O3TPEHHKJcv8r+qllVbZ9EX7HQoGts3PsLKWaLTGPC+As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eXowaANT; arc=fail smtp.client-ip=52.101.83.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eXowaANT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR/7sb0LYw+Wbm0cZWYbUiG3dIEJBemn6hxzAQuX7RdBTDINNyVcso8YkxtBTZOw7A6eFODR1DlQUrzdHHoZcuaPmmIk93+bjIQ9iQhRgu3IjvYHmoEY/qFNBYoLUQDAwo+MzSZKcXynlw0OxFtuc9qLhG9fdDSSX68Qwku+ctCX1hjcJj5V+hD1KiwRh9ijCdXlQawtRPNhz1jFjWRu0obgjSxPbQ/Bqw5QDJS9drFNAGbT9CQGunpaB35gIhQ8IB5tfoBYNPsY9U0UzkO0bSs20gizktl19cnkY+q04L2LucgBeSdDxzjx9V10J55E+c1yGb5bEZGgBrVmx6BBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+i7QGSZLg+0eo81oF6j8W+Spg/u69Q4F7jGv2cDuHA=;
 b=n81Lf7Q6DurYUQp/Hp+PyzSsuzDBH5AhM9QkswG2EBc/i1z0LEiVxUUBUynX30GmaZQaTl/3sLy466rCyK03cFHCdwiut0Uh/0S9XwqVyZPBPqsrHXo9DTqYPpC1VGgT6xW4VkYONlj+heHxIvrmPb3+M1XQ5Aic1hutlL4QmxkdenY4UaRqJdgdJFuU842rPJglye2tXiQsqkW8XSs1moX7BXL3o8qJsdgRLv5UrHdrKWK9TYRiVmxe+duMt7CRBSWbiLq2XousaTU5ZC4vZ0UXgcuUIVeYJkimYAXPIC80kcHBbkkgicXru+DisLswzS5gL06ES0OABUN2Md10vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+i7QGSZLg+0eo81oF6j8W+Spg/u69Q4F7jGv2cDuHA=;
 b=eXowaANTwhrYm+wSIzyguM0xlireshMkNPKGDJjWIFLZtcAKRD6P+Roh5mpF/pr0SE6/KPx6y3Y5s2wE2+N2R/PSy4NVTKWOlMXUDwUPU4DZ6egtef4By1T/JhOduaWGZFsNOs130W0MBkxH5uRzvNHfOErnD6bxPcYY69g94oY0+OlrbO7DVA9ofVKYMxkB14NjRNZZ8bGzQ51P8j8xfyIdGM78wV99gslr1i52Ig4M3PwrVrwWI9YCsVLEnXR+Y/HHOTnZmM1kxV+ogARc7DZHvhd2iJSuq4zLWBSiSNIiYedXxtx4Q/dAI1c/xs7zJQPVxdRdcb+rBQya2EYpSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 02:29:06 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 02:29:08 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v8 4/5] arm64: dts: imx943: Add pcie1 and pcie1-ep supports
Date: Tue, 24 Mar 2026 10:30:35 +0800
Message-Id: <20260324023036.784466-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260324023036.784466-1-hongxing.zhu@nxp.com>
References: <20260324023036.784466-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM7PR04MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: c34472f3-3d31-42be-bf2e-08de894d20a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|19092799006|366016|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yTg3q2AeaFrvCc1T73uBbEk+SRRjsA4dsnTnHBbzrLj+jnQKxSl6HsANDf4+PLk2pApm3qgzZENMjodThF+Zd+s2G3TXmEgYjB0ge5AWEubedAs7JL4bKOV2k4LgAAuUKA3W4lrjwrPbnHL0pBlmHYylVSx2uHejJ4d+iBFImQSxQONvqXTrTqb7Q74wJSx7c1RN/rJxUN1hvNQIrUq71VXVDNVMXPSDNBdeFCnHz80hLzweJOmOtOvl30TcZsbsRL3Hc1s+HcicIwMyf/rlDz2KecqcUiBlXvlCHMCt/gHGcUUqUY3LPAXfmjCANz556bUiYu2OIUSyWJAlYiUuekQWN/jNy1pDN43DjE0gQXEaUE54mAgjJ5i7RVMB+ijuxWEzDqEXsteVQccjx2jGxn1NBLcv+6hHa9GKcCofIXRVShIjLben7ePxa5jq6q8ZTR1CtamQTh38QYsebBeLf4Vc6uI0G1cym+Rg3ERFnAB1MCeVY9EtGeiaz1kgmqmyGs5/1ArrrxLjFS9aoPJMo04kDP1CzljgsikY3VPrAGWh0a5Xz6bxvJYsAJhUgfxsOHmCPu9OrDMnN140nmBJmT6rEyVx9C4wGNRCz4nyKRJL8pkTdgZ8ftD9W//fBB3UZw8n2d4co10Yx9UUltojlSmuOC/mhjP2Xu0tpTPIEd2GZSvwKHfyAc9Lc2/18OuE3aROBFcZNmkSnIn57deKLXiq4ldhVQINXFAQRC0m1tC5KLWDkCC6L3VWmFd/W4bgq91PBGW9PJ2UbVWOjg1LzplOmFza6S6gcsRxw9O4dBBv6JoLEfedYXnSD6mionnw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(19092799006)(366016)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vx/dSHVl8qBDWoQl5+jGSqcH94BjX28Cg0Uf6n/A31B3hchEk5ugg1vOA++v?=
 =?us-ascii?Q?8eK4n/9HNFzQ+ukJsgeADSP+sKIkb1FPXxnyIc4nDOYzb2EVfZobECJdF/tK?=
 =?us-ascii?Q?ipLUfjCTbqp3hdtCMjjRzHUVKDZxDMa1eC6YAA9axZItxjB0FarFkf2FmbvF?=
 =?us-ascii?Q?pPTgC2jdq8nt0Q9f23cDLAKpcDsB3iUovY3wNmUIItzvHwLDnyz36tA62zq1?=
 =?us-ascii?Q?3ChOag5jsh+yK0NT4X1/YKskjE5iVJq3DnYzasBCfPZ4FdwcDvD9VSmQPQBd?=
 =?us-ascii?Q?LgDivAxu24Vpsz6uArZImqXmPlCIvY3VWc+nKOBoeCUfXdsuGO8d7rYGeNcy?=
 =?us-ascii?Q?tqWQ6vM6WVASupM4zLmQkbC0a0eCuJjeSo4MFhCVg6hmKK8ZIowHgVUpmqHT?=
 =?us-ascii?Q?iC1NLxAJjlfU/a+PqXz57WvrqkFnhCO2CQnBq2KkcdCucB81o0GtFCjG26+l?=
 =?us-ascii?Q?po1jOyeZH6VlPGrnP+RYRKnpV3+7IchOlul6xHOYu0P+CGFOJl1nPOGCZuLP?=
 =?us-ascii?Q?kdf+MOwwsIyzAPNpYF51Xwf9yg4zTPXyeal2Q/FTdPYQwKZpdPnbcAVvSrE7?=
 =?us-ascii?Q?n0DDTYCI/xlAiy05UCU9SX/CMYGec34CHUv9oO6OgFR8j6OrU7b166zZthSu?=
 =?us-ascii?Q?kKJodQlBQWqMTT4wpokr8BJfwqcLG8Wqv16nv05h4G36DJuBaq3+KSLel173?=
 =?us-ascii?Q?uCry3Z3me1eRPrCV510FzsdtTBHnBdgaLElVmko+H6o3Za73SI2xl3PfQvEs?=
 =?us-ascii?Q?cGiKzcmfl6aKApdLfnsSPrUBk86c8oM8YaF1w88+sUbeg+jsTTXlpPQyBJXh?=
 =?us-ascii?Q?ktHfTU2vW6UGGN7dxV8L1dSf1H90mVwwE+on086aeHJz2VzokoITLOLjAkKF?=
 =?us-ascii?Q?2YTdUuESuz3aJ/4eSvawY1yTkfZUtbXhOg2lSwO1t9Q2Vxzw2AbIyUoMAGvM?=
 =?us-ascii?Q?+jqkqIuUzYb51Q2Nx/Twizq08UXqI0CMtWQK01goYKo+jlBPXAKUxhqKmg54?=
 =?us-ascii?Q?eWfqkWABu3KLyB/FgGi/eGunpaqxQOqwAJb3+U3lCcGHaCH6QuNFBm9xegM5?=
 =?us-ascii?Q?c4ojJf3BufcIeq4rnoytsadz0caJ6ilkTbMb/aWImbePbp/1uhh+IlW5i5KF?=
 =?us-ascii?Q?hVeTLrddYBXdla2XmF9x90hrJUH1LRhwQP47N6Y00SzJ9kIrHqFWXTss7l7H?=
 =?us-ascii?Q?DLU03q/zap9J/0gRsbBKbBGDommA3st4hehHTeQDHM9o2nZR8qzpekDVTXff?=
 =?us-ascii?Q?SpTEP/FAXCp3ELQd9aj55Y+X87ONsaJYZq0MKeYDId+Wn6Rummy85d8MlM8L?=
 =?us-ascii?Q?vpKcq6W/GUfNImcUlbYwf/TuSRg4sKC8bbyJwbpui3NRJ9gPX7Dz1BN46AKz?=
 =?us-ascii?Q?+wbccXmDE1uYT1QYASOrNyM1GTzWbt7KmB4pZFYPgegbkoUpmklm81bqwgsV?=
 =?us-ascii?Q?eaF9gCx0h9Cp26QmVkO6/Cf251HW9h9qQYO2YP22d9MBenUl+SIHEQ00KFO/?=
 =?us-ascii?Q?R0KHDuhyOtLSJadFb84mFC5kHy85jzyJnIifAqyC9R0EUUHHcLvDpepo5Jke?=
 =?us-ascii?Q?Hrw9rcsNw8IQvq3YoiWnExS5GT8Olh6Zco4I4nyd1la9LkV5ZBeERCMu25z1?=
 =?us-ascii?Q?XS76nJdDFsPM1uoiALIbx5/NcTa1zsEMOJ2S3NbX8LVo2qW4QLSWd1lJNCpY?=
 =?us-ascii?Q?pKr0wPMZgvkmBaTV6Qlxytj8nMniWimqE0TepsRpmJDvh4KLaH2jPoEmcK2s?=
 =?us-ascii?Q?Ct9fAWv/qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34472f3-3d31-42be-bf2e-08de894d20a9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 02:29:08.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INOOepkR0aHaWoeo3wl32+8iedZ7LMNhkJf4rMZf/MJKOLQkJyJnO8+agTlu7fknBj4MXbxK0WJpnq7wsLO/FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886

Add pcie1 and pcie1-ep supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx943.dtsi | 75 +++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx943.dtsi b/arch/arm64/boot/dts/freescale/imx943.dtsi
index 45b8da758e87..8575134176f5 100644
--- a/arch/arm64/boot/dts/freescale/imx943.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx943.dtsi
@@ -145,4 +145,79 @@ l3_cache: l3-cache {
 			cache-unified;
 		};
 	};
+
+	soc {
+		pcie1: pcie@4c380000 {
+			compatible = "fsl,imx943-pcie", "fsl,imx95-pcie";
+			reg = <0 0x4c380000 0 0x10000>,
+			      <8 0x80100000 0 0xfe00000>,
+			      <0 0x4c3e0000 0 0x10000>,
+			      <0 0x4c3c0000 0 0x4000>;
+			reg-names = "dbi", "config", "atu", "app";
+			ranges = <0x81000000 0 0x00000000 0x8 0x8ff00000 0 0x00100000>,
+				 <0x82000000 0 0x10000000 0xa 0x10000000 0 0x80000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <3>;
+			msi-map = <0x0 &its 0x98 0x1>,
+				  <0x100 &its 0x99 0x7>;
+			msi-map-mask = <0x1ff>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			num-viewport = <8>;
+			interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
+			assigned-clocks = <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					  <&scmi_clk IMX94_CLK_HSIOPLL>,
+					  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			fsl,max-link-speed = <3>;
+			status = "disabled";
+		};
+
+		pcie1_ep: pcie-ep@4c380000 {
+			compatible = "fsl,imx943-pcie-ep", "fsl,imx95-pcie-ep";
+			reg = <0 0x4c380000 0 0x10000>,
+			      <0 0x4c3e0000 0 0x1000>,
+			      <0 0x4c3a0000 0 0x1000>,
+			      <0 0x4c3c0000 0 0x4000>,
+			      <0 0x4c3f0000 0 0x10000>,
+			      <0xa 0 1 0>;
+			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks = <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					  <&scmi_clk IMX94_CLK_HSIOPLL>,
+					  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			msi-map = <0x0 &its 0x98 0x1>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.37.1

