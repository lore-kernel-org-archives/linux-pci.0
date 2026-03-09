Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A541B332612;
	Mon,  9 Mar 2026 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773045820; cv=fail; b=GC89w7sPLH7WJz9S1A2Uo1h9iXwjYiHA21QsVy2r6olX9EEldJEsBAbM6je4dy4dPXDw4oUsAx+Pj2eYx3WGQoObkpv/kcbGAC+5FNu6/PLH1SNVSWbt4rDTGO9Iq5zprjfyh/J1Xl7+6ujbOORLOnQTQJRN5vAbOf62/jzzruQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773045820; c=relaxed/simple;
	bh=GyduWzAbIm3hEgsONO9wEQ6ZPN0ODepkezDiUOUKYps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A7e4iGU0C6EhyR9FMxjZLb2tnVFhLhm2S8hX0bulaFElidnEm0OLvzddWl1FlrlpQ7/wje8B2tSQeSRNGtBFQVB1tO6izLNZCJKCvF0kKMjtrMKTXMfOLdcsaIFC1HCrUVJydbNE2I30FFp/8L2C+rWfL0Q1YfLD92eCOLXJVCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B8py0S6N; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B8py0S6N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCl2JPeevwZtjAs9Z7/gHE8jCgPhAoLhbHET1qZBMLJXKywWTfibNmiWycJSQ+e7h1sgG/gRRRx83phiHihrkORmFRE0C4A41A9SEFZLbst2jfakvZNXxMpT43npm2urkTC2ye/HhsGfg7wn9jvvN3glc7yvnWz0x8C0IAAkSkN/dSPJryxnsF0gMwSFqWyavd79YvQyVEIwevHzOfLfHKkKXmOgQ3Uhpw8jqAgkVdKbN4BUODLjNQS8czCIjoQEfktJI3neozntQSGKZEtycOE6Zmf7AUZUE6LwnIXWtuRTSPa29uhiWubhg0OQPwEb5jjfKdukxKI3OHbZoJx9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAxjxDz8wJG0tN5MjI5fPSe4J1nE+8193K0lzTezqPE=;
 b=BdRhvlUYVExCjCK60I8cUyZOUsP0cSf9bbKSKJkgvfg8x1rPg2MBOLdI6IANxmBC5M73OguZqS7OKLCKhxWpHy8hI3wrKXy+5MiApoNg01K5BS6GI7I31GVSHJx9ipKbk/iLVcPUvr6uWOZUzYunjR6MjY+HTOyGF/ZkoLQ+zkp2IhKCwKmu1fvFnRrvhT6LuWMti8+sXgzBpFLhPPjkagUB16sOZKOdx91mDpm5Gol6ftJ1WMPvNgMgviZHQvY+7owVQB0DuQ/MIjE5mUJOl3Q0lu3cbgNe6hqE4jnLXzvBSajxr6FnMM71mKBX3+WiXoYAi0uS+yA/ZMCg8NRndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAxjxDz8wJG0tN5MjI5fPSe4J1nE+8193K0lzTezqPE=;
 b=B8py0S6NxltQxFgj79RhthXeDl6Toh9U1pP745Y/jxeePocJjNrClk7GkzpVjNOJW5uvkrPscqqVH8433xIK2bvqgBks230i6vMNnWtCTOlrdCgIvlFXdZhVFaSspGBwS3u+BjkQbEYtW40k1cT1NLoWL54zrrh89h5DPvSKxpnm3R3Y4Why8SU59hCk0ZD5B6yBYdk1hM7UtucbF91wztupS/KU2LRzo0TwPPWXGhXOKmluzeujgnoJ+ZsdOtdYSxHKWYKRqn7nfqZYGptTPDMb73IicITtgXVc244ePpblm3TQQUAuqBHgIph+RVquGXg7y6Rg6X5WpHJ9PXN4EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VE1PR04MB7264.eurprd04.prod.outlook.com (2603:10a6:800:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Mon, 9 Mar
 2026 08:43:33 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 08:43:33 +0000
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
Subject: [PATCH v3 3/4] arm64: dts: imx943: add pcie1 and pcie1-ep supports
Date: Mon,  9 Mar 2026 16:44:30 +0800
Message-Id: <20260309084431.3015463-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260309084431.3015463-1-hongxing.zhu@nxp.com>
References: <20260309084431.3015463-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|VE1PR04MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: d559d624-3490-4fc9-7d1f-08de7db7f26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	wubNeL9dlcAk2mqENtHzrFmWePYFx3YJnlcKvyM2uI0QgcQDctZeI6aPJdoAKDfllPsAY2ZRTbwiGZRZ5CKmW0tFVruJQIMiTPX4San6lhMxFEbcJYaYlOy41kXfr/DaRg9/Q7fhIATquT0OqQs0pVrrRlavGjTtk7131M/4JSphXPIrIaIRhDAfstlJ8e5moZeuzD2LulVwUZppWUdbWLqJsJTSdCPREjEV/LEDHMdBOF+FTvdW0i8FHqWopdW7WI3cMqc0jJANFOfeQSskVS7ZJpFkMoT1wWD1Hjq7ehlow8Ks3GUubT8ed9zQYBOT8+rsfR2UOAarhfP9GF2H6aWKjSIykSBUERM/cxg4135nu9HCAMlP8JnOPubgYOwb+Wyu0N2NgfahNQPp1KNUSiJQ2Uq+/38Q5ZkhA4IuuAbvyyW6p2Y5D7ybe7E4Z9KTJEyIiGkiALguOYiOqfbSiz3Wuk74a2O6U7lfvK0OG5C7KO3OAts8LwAvP+4HLjODrC4n6qbNjO//S83iq3CYthdwlfeXFYnU8+SZQCIfpXzWD/pKnrmw6x4gemuiMOoM7T5BLrohkbJ0gxotmX9kHe1W7x03Bj9zTDAgT0A9xxxZ6mctlZse3uFYrAA1q7uBg/SotmhVFZONfm69vt+yIggt6DyJ1gwwTRSgymLL6mQVAzT5mMLc99Vk038n4PQUQ8dG8rPNyoVrZs8I4gcc/zweIwpGzjt6pe6QkTN+R+MMLW3GsfWa5upnfVgsfmVKXLqN0YnFENQY6HyqgCmKhGReMGqtweKLuekiXyQVKoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8l6zFLlp22iyhI3rziPpDu/l7b9I3/nbf9X8U8pXy9ftJLsxPEEtZZjmZn0b?=
 =?us-ascii?Q?Y1JmLJNvCNzPNwJqnfgWhiM2m5hkboso4vAnCE1imj+0Im2cTQzMSxZKgPUB?=
 =?us-ascii?Q?lQzcQfQb1NjvmmzNjL0rL8v1W3N5e6Tj6+4wc1+w37y4JZdQgU5GiKMWY9R0?=
 =?us-ascii?Q?fdXyvOYwrTZKZfzouPwc1K1X24Lps4K7egAGSWFZIJgDpolr8XFE/DsOFDKG?=
 =?us-ascii?Q?41lPJhEEsmu2x3j/dXlhTP2Yw8/I/8vOJVYjGG2MI/1ITo9Ty9dkG8l5ZRcj?=
 =?us-ascii?Q?TJk69xJv9vnwnhu59eAmH1w8pHXxyHIo19Vex306RPvrt/nmYxsH1aEfyD2v?=
 =?us-ascii?Q?carlHkOVe7Kpw9qTlaFtobsJte0BqjBN8yCNNDC9Us9dpiYQaiOxl9q5ktmb?=
 =?us-ascii?Q?YYDDFzLwh1Ju182YEt0AOH+W9enjl5fOsGT2cGuatHSlJ5OkZUr4Fc2CeS9k?=
 =?us-ascii?Q?N71q1BG3haLCO810oy4DMYBzIia3VGaGq0ejTJn6BPz2t5pYC9fdXzSL213X?=
 =?us-ascii?Q?Tp21khi184KVMRHpAc/2oUkiGSe9U5Lb20V2n0iyt2e8PtGJvn20ZJuluMGx?=
 =?us-ascii?Q?//3G/7kj4Al+b1bIKbO0jUW/YiOzWkzK/kVV7St8MP6Xi3cSA1dCNhyFIbjg?=
 =?us-ascii?Q?SbnTLTmY2YCyHZ6HWNmk5bd7FIEvI1CS9Bhi3+GW6FB3B1EpxXTn9lEzlgVB?=
 =?us-ascii?Q?nwCINOFg4F8LPH/0leA4MfvhMoVcQ+MWVkAn1614v4701jWeIr1Oagj6TK+e?=
 =?us-ascii?Q?qRNwqKg/Nx3P1T0Ux9NY+thr5v9WMenJSFTz+9UQoj+25Q1DpMvmbAk0wniW?=
 =?us-ascii?Q?dpElHPjTYFrOxv3rAFKXDsPhsK8JJ3Ij0ZxVo+qwegF3cqKflo5OeNZnpOHS?=
 =?us-ascii?Q?03nh/TJyk+5vxq9TgkUfgaG+KofknFkCJCUz7syqNABj5ng0kX6ZvCiTMVth?=
 =?us-ascii?Q?yL4bfnlNluMb4+7qNBGu+n/ssjO2cqZbsVwF3M9VWank95weKnj9zQ4SsVkF?=
 =?us-ascii?Q?P5bF9MZqIYUN2KVED/xPuTrfdjtRt2LsnAMZvzZTsociBPj5CnaLFy8w1LzC?=
 =?us-ascii?Q?C6ytgS6lkNv3XkmAyc1A8wVMJoAWz4litJM44qQ3kU7TLutoSZ058/a0qDYu?=
 =?us-ascii?Q?4My4Z+svRsIfV+xEAed5zw81DA3Sqi5RiWEsYbM8+SCgxvODCEmKd9VxmdSQ?=
 =?us-ascii?Q?TAMzHZiWU5kmfdT8cqwroR1+Qi+K71N1OIUZqV08enEQ7BpM5JWFS6Dc8Jw8?=
 =?us-ascii?Q?MzGFvPh/A5UIlZF+HiXmWgTuu2lqf9Jm/+4fjNAmkpWg4xyB2QHYPOUN/KOP?=
 =?us-ascii?Q?T4K6+/9z9vgFSjI5GkbHoXwzDBjFrCXbybHV8wD0iUIaJaUrk5YWAAEivIUy?=
 =?us-ascii?Q?C/HSjROGVetwRcZPu0yp/YIvFlATzhX2/+5/mDNNBLQ0cg99vhZI/QOib+R5?=
 =?us-ascii?Q?v123uY2epuh4cihS6MvM5bACk1imZnZkSwFcsgMUuvE1M4iXCLdaVfBG5TN5?=
 =?us-ascii?Q?PxgycbyLKOOiLM4luAKuT+pfdNata4OiohpOBJ4TnJVwq38r1oMzJcTO7dcx?=
 =?us-ascii?Q?BLhwp0siiM7sXaejT0XwV2zBnO/ZavJCQPupa2L7z0QFMjA24qWKIVdrV/5f?=
 =?us-ascii?Q?/BMowwrKGaA+zBudl06ON69FbfkDLr2AyFTIZIxDUMMWg6tibTBU4BCn1OTH?=
 =?us-ascii?Q?xEskBs6f7JcJHEjuQlZYTHvcEtkBr4rHF30W7SBYAlEyCaaQhMwMQROVD0Nv?=
 =?us-ascii?Q?L4bWforiLA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d559d624-3490-4fc9-7d1f-08de7db7f26d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 08:43:33.4163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ruo0UFzU1L2Dy6aNV656ejGSh7krI7eLQGTYsSsKRMuJ9/w7pZTuI2cNaAjIZ41RZ5Carpk7OcHwOC37cbvMIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7264

Add pcie1 and pcie1-ep supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx943.dtsi | 74 +++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx943.dtsi b/arch/arm64/boot/dts/freescale/imx943.dtsi
index 45b8da758e87..8a5751a68610 100644
--- a/arch/arm64/boot/dts/freescale/imx943.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx943.dtsi
@@ -145,4 +145,78 @@ l3_cache: l3-cache {
 			cache-unified;
 		};
 	};
+
+	soc {
+		pcie1: pcie@4c380000 {
+			compatible = "fsl,imx95-pcie";
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
+			interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
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
+			assigned-clocks =<&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX94_CLK_HSIOPLL>,
+					 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			fsl,max-link-speed = <3>;
+			status = "disabled";
+		};
+
+		pcie1_ep: pcie-ep@4c380000 {
+			compatible = "fsl,imx95-pcie-ep";
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
+			assigned-clocks =<&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX94_CLK_HSIOPLL>,
+					 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
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

