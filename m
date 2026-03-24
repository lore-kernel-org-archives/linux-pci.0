Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B3038552C;
	Tue, 24 Mar 2026 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774319373; cv=fail; b=b6rf001oRlys646XRkXK7kjTkV/hWRhcZVHQls+pny+g2EfTLXc9nb35b1OqvgTPpYpUFferGYn7B62F3hJzzvETtKUGyemA77QYNLR6lY/ypJcnshK2SgMQolGPKclENoBm+t976To9CI4uGQPx4VkSL0Ci6IG2wBAnyqeTUag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774319373; c=relaxed/simple;
	bh=ni5qSYpHQIFYcRu5THdx8L/T4pJdcDG9S8WM2T/d1oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mDTFhYqa0L6TzZF2RhZmo+zydbzrszLqrSx75/rPO8JPT2kMWBme2ITXFDG62qB/kRFSjQCAL9O62ScGgHdcEtoxnlVQupRIJ+sNjqm4fsj8yJRyb486kCgp2iiAzyjtKR+BoMeMGWl8WEJEzRfoJxqTQgx6g0hMCofpg5BD6bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HclaGG8f; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HclaGG8f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtoET9UcMf0banRNpeuaeBWj+lYpaMHEOgM+r9gD3SzA6AW3CDPNk9FGLv7yEgGv70NKAKTK7UbA6ZyVejioGEnpKsntP+juBpteuFCoXFOVQiuNrMjs3JVb8DRN1Sj0TFtB2UNItZ/k4MLfz5cO3qhxhhra822ip2A+bezBBt8rdAchG55rL+3DrEdUAo2M7qijl45LbFEBQhPFJ9Q4WfKKJ3blSpb40bqRdASTHF8vrlJvgxAaACUaU0iYL8vipP/kpFxP6gfe9ocubWl4zJ4dOJ086xCn5v1h+wE4VJ3ZpHtALtfWQyW039J8WcEateao+ixz8ixcDppDQcxdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKecl3pqO4GcUs+0JyUWIAR5YZQo2lgYHzkz04BrFwo=;
 b=MebGQMzk3SOoAzTtM+g0WNTNT16KE07t2Ifmpv43CR9Q/yMCaszpvp1P2RyOxgKkt0WchfHSmmR8EJxG0OPIJf+LXeHTwt+YhZBSgWdt3kggCjeXJZDp0S2EYjqKENs8kAsjEw6sO2B1cs5wZi3gGVZtDTWCP8jFh49NcToEuNzQjP5DqiC/n25dZSl7ORWFYOhQP+hoUOrQn+s4XB2YACcc7r4SbXHNtwMNmEcYkhuv4tWf5c9GJ8CLJrFwfi3fs6RK6IwkMKuHUKpZr4uTTUkUyfa/jeDc5aPDZBbGT8pmy3EJn3J/pMTG1/IcqkX9Z0bsh87zVSs/b2tbpH66Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKecl3pqO4GcUs+0JyUWIAR5YZQo2lgYHzkz04BrFwo=;
 b=HclaGG8fZVzgXHcKLM+OLI7aKGdGAFxAbFXW110jmRpwljSNVrB3KRJV7qQqYiiN8Kv8u+oTWxvW5hZdTUv/K+we1oSNdjvdsYsmHl5yZU73isB2blKs/Jbh6mKb1J/oLy13TnrjDXRwJC0E5HiDAGIA1WyJO42gGpeWgOngnm+Nerfe7Jy0MJwHVCPnq/7vKwfrZ/b76uHGSVe5a8M1FJLybPt/ATEm8WtjUVVJQgE5nUzKPzGzK3mVEiebkoEi2KiWXxcbIWN5cyuve6HMgbpThtmrReXmedHIXSOVd5aAO76z9TzHQJijR+0QulPe3EEq6C+z9GlyGC7rC4cyEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 02:29:00 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 02:29:03 +0000
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
Subject: [PATCH v8 3/5] arm64: dts: imx94: Add pcie0 and pcie0-ep supports
Date: Tue, 24 Mar 2026 10:30:34 +0800
Message-Id: <20260324023036.784466-4-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c81f10e7-9655-4032-6869-08de894d1d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|19092799006|366016|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yj/NE50Dicc3gB8Bqp6uoxm0OiSSAgdKh0jaiTUh9xEA2ben/jkX4S1I4uF8YUioGesrpBImOTlfDQXDjx34Kur/VdpTUdCx35k4kzZ4BCMIQ04V+GHnx7SCnn53hImT/vqobYCAWrJnkyNe+D99pno6d6WH1zT5dYKF5QilcshM7yftO+LY6m6EuYBkpGC9AjqI5UBV2l2jTlUcF+XQ4QkHcFCpDIpV/KOrEXkVNlDYv2a82uYI7o6v9f648xfHkJSX+FVKoJHLmxk6UnXAwdDAEeNfNcKBsThMGW2GfRaAzll7PM3CXBY+QpK58UNusMc43njKGiiiOfzL1cvBh1g+WcVU2AsPnrvPlPVExD4WeDinFWHXEP/Ti2ZB5mT+deGemIDCC5lQ/cyIpNiMqvv3Ig0pdtJNW3Szq2k9pw7pFt72+B18N8t/rpT2JRriNGMWl2sOFQXY4cy+ln+KDL8W3Tj4E/q46BYFCivqb+em3Vpb+L05SZirD/1W2pZAeP6J61iN0L3tSdZXfYmAk4+nNZQeBB59sxwHVVG6HjfioGX5NFCG8QbyzJ1dbir0bgPNs4ZrbvwZ1FDvVuehjRXBnj/MS3C/x5iJsYbHL8gEDOkubZLyvl2Lt5fyQ7cVbW2XT+/OdfdnU6AN9P+AC2N1PVJPn1SnUSRX+G1rYIWaSE3ln7XHdYvag3yUmyhrINikC7sLgZ317ca4/1iNXccFr/mbjbj7djL+jTtx0TzUrEvtTckMLDWdpfHtNDka5Blhnsur/nplGG4y4WR4dyostT9jlRnFIrVRRCUeKLLwoScJLhvKrZ7JNjmncALB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(19092799006)(366016)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7pB81vCgizEZNVtBT5Y6K9x+eiIlVvnbyJi28OGoniK/mZETvxLTKjnMTXKH?=
 =?us-ascii?Q?yi2528+C81vTa7b4dHi9pVUWbTBjtGTxj14WByVR6Y5aTPdG4/HIDb2DFYyx?=
 =?us-ascii?Q?m+hUZmYv/gXmBwcedIGFI4l1X+HT+0DM3ayFGVowCw8+9yYJm2k4MnKD4tv7?=
 =?us-ascii?Q?2zp577zNKbUibOkxECWCPg2RztjFnB9hCvkP/GSg+lENVK6dXbJepFwHpOUL?=
 =?us-ascii?Q?G9fVLOB7GMqJHpf2pcDht+77MIv8cosXFXAFPipuU9S/qh6WofG9cKuKoF3Z?=
 =?us-ascii?Q?3FJjvoASyGQcT1GKXdxyufJl0FXMO19jckDBjPovCY+s7opzcAptmUFxqM//?=
 =?us-ascii?Q?S4YY0qv8oqtVlBhHz3TCX1AYjcNqW7LpeEND40hFDs3+QX9/XCk4kc4FNTxE?=
 =?us-ascii?Q?48I3gSumBDaXZAovBSRTZz31Oc0X6buik0joOSAaS4bV+np9bFfPna+tGBuM?=
 =?us-ascii?Q?FB8IHjbfzHkZoNypf8ngHKsYZI9jtxsbe4FrOvCB8ZO8ZRZaY9x3cqoUtLzz?=
 =?us-ascii?Q?PHEAU9lULIolkypb859mb3qDdyyqssbmbTk6Sb0n4WQH7fwHr4BHYyC8Ns6j?=
 =?us-ascii?Q?K16ZiUIDXUtbgxv44AjHAhCUG+8o7reFb/bi/59R48+SJ7O3pJhxVCOePoOQ?=
 =?us-ascii?Q?4bdryGgLCKnh/Q0EWQAw5M8ZlZmPNCnklTszQP6l+hCfDIfyVtrUJ7MJhbj+?=
 =?us-ascii?Q?Ax2QKR7cXlz6V4WuB0+DbIHY+AJUSA8vLiZ3lkFcxTpVEi89h5ENPOrWs1Lh?=
 =?us-ascii?Q?W+NRkaAsTAHvx2ZXbXG+movGCDyA9lh04XchC5KfiSE51Tg/AMm6WUA8TJd1?=
 =?us-ascii?Q?ZjtcLexHLXx0jC0wuPbECIeLbXWIMiq9VavUp1esAv4oa7UL9v8Ut1LfVnI2?=
 =?us-ascii?Q?2hI+GhXc/7sxJ7kG8yYFaq7UeBuk584wF/wKQPbsstryGaLptzXKNvOdUqht?=
 =?us-ascii?Q?hOi1x83mnt8HMGG5w3fGU3T3y3qX8FbTULiZXGwx4/RlXrlMBsD64M5oNYVT?=
 =?us-ascii?Q?d1xGSa5Krrxk/pj6IIMNOjSOADwRUB7euCbpRJqe83gavCdjn/tluqvdLrkw?=
 =?us-ascii?Q?jmYHB4kGYXojIUrPlg9D3BvVB4okmzJQ81Td2ZLJcU+Vq671XMzRTLdpuH7u?=
 =?us-ascii?Q?Q8Q/TXGyJJB/kzhucuSgzcTGCvJEMv2AgXmZR8vjH/V3rk4P3iu3Pms7NNd4?=
 =?us-ascii?Q?T5+ips0Jxp323YAAKCBkK4Wcoun9US1q6M6KR5yEj1g3el+AZX/tQAGwRrsD?=
 =?us-ascii?Q?NMyY4zBZrpCznSikd+SrDUG9BXAelEI9bvyOsPcybj7MCuA3MjKK/3AeVmVs?=
 =?us-ascii?Q?i0pZ+CGPwRljJmfzDmKs38p3iWi7qa0NY9DCDUg4Hl+bGKdNlj6+U6DVyC+3?=
 =?us-ascii?Q?2oQpkFaV8ti2pafsKAUA644j66bWwiREnRh9Q/UlwAt/Hpcq7WTpFevo3Ngp?=
 =?us-ascii?Q?42rg118QaYc2H0kliwgh7QdaXraAB2QLMneAWp4+eV5ZO0GBK/AjdglxU1U+?=
 =?us-ascii?Q?uBEC1jojKCT1rGfa42gLiYpygO8NLwzAzyWQqfpsEZ0WHg3zKbrBwB1o+RJc?=
 =?us-ascii?Q?c820Wh8UewF3aUWb/rf5E1H3D1fwZrzdEpy0oQus/RTu8CllfcmWSZ/r8Biz?=
 =?us-ascii?Q?PDUc9Xg/Z9/fY6BjejYrQ1v1tp2tFB7rojsAm0CWGQymTeXdG5P94ByVURnm?=
 =?us-ascii?Q?sAV0Ok5CoT2Uhk8J/cB5wG9doTfHz9wccQ2M3YdEzxTXVFGCDVZz7ShuSKPS?=
 =?us-ascii?Q?B0/6jZ1Xaw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81f10e7-9655-4032-6869-08de894d1d67
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 02:29:03.4551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpLpgF9jhVx8bb8+lQin2VRMlC6D0lNGoOsZ9CiQxDAR6eceIQZlUSacF4cBdLMhy6HWBGUln6tG2f5ylgRLRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886

Add pcie0 and pcie0-ep supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 88 ++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index 38488147a3ef..5d19c34cbc2b 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -66,6 +66,13 @@ sai4_mclk: clock-sai4-mclk1 {
 		clock-output-names = "sai4_mclk";
 	};
 
+	clk_sys100m: clock-sys100m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "clk_sys100m";
+	};
+
 	firmware {
 		scmi {
 			compatible = "arm,scmi";
@@ -1230,6 +1237,14 @@ wdog3: watchdog@49220000 {
 			};
 		};
 
+		hsio_blk_ctl: syscon@4c0100c0 {
+			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
+			reg = <0x0 0x4c0100c0 0x0 0x1>;
+			#clock-cells = <1>;
+			clocks = <&clk_sys100m>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		};
+
 		usb3: usb@4c100000 {
 			compatible = "nxp,imx94-dwc3", "nxp,imx8mp-dwc3";
 			reg = <0x0 0x4c100000 0x0 0x10000>,
@@ -1284,6 +1299,79 @@ usbmisc: usbmisc@4c200200 {
 			#index-cells = <1>;
 		};
 
+		pcie0: pcie@4c300000 {
+			compatible = "fsl,imx94-pcie", "fsl,imx95-pcie";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x60100000 0 0xfe00000>,
+			      <0 0x4c360000 0 0x10000>,
+			      <0 0x4c340000 0 0x4000>;
+			reg-names = "dbi", "config", "atu", "app";
+			ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
+				 <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x80000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <2>;
+			msi-map = <0x0 &its 0x10 0x1>,
+				  <0x100 &its 0x11 0x7>;
+			msi-map-mask = <0x1ff>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			num-viewport = <8>;
+			interrupts = <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
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
+		pcie0_ep: pcie-ep@4c300000 {
+			compatible = "fsl,imx94-pcie-ep", "fsl,imx95-pcie-ep";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x4c360000 0 0x1000>,
+			      <0 0x4c320000 0 0x1000>,
+			      <0 0x4c340000 0 0x4000>,
+			      <0 0x4c370000 0 0x10000>,
+			      <0x9 0 1 0>;
+			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
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
+			msi-map = <0x0 &its 0x10 0x1>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			status = "disabled";
+		};
+
 		netc_blk_ctrl: system-controller@4ceb0000 {
 			compatible = "nxp,imx94-netc-blk-ctrl";
 			reg = <0x0 0x4ceb0000 0x0 0x10000>,
-- 
2.37.1

