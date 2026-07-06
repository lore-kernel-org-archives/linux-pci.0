Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24DC3D7A0C;
	Mon,  6 Jul 2026 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321229; cv=fail; b=hPXRvSavTSXDDcOi29AM73GgPOaAdpG+hLN9jx1M7kT5gsVFz+IeJcvBq7IQfD1gQxs2RHLUHv2PyKmn2bvVXOv8yH8VlTPAusUkEwuTSgOToNlm192llR93+2qNO0wRjYEqp8p/MzVIJY4zVbYh20ROQxh0htv7xAHdC6Rabjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321229; c=relaxed/simple;
	bh=XuzhseJYcGqylxLWVAIobrr5f8wwimZfpE6zhA20I78=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=knUXSehlrbM/ialWzOeGcy3J4SjmQu9goq3wTlLFPHtnZKYvD/biHNhOvxSWQ6G1ZY5/9ddvDrr8uQvtyVpD6CrnRCeKPdAfH4V53K/Qk9P5mAs7iVYghcaF79IMfudSUWZpLkoNtg4KOLI5DF4CQeh3R+HSMQtkwKKdXIjonJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IkGXZgFc; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IkGXZgFc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSbAI9RMlWp4B8dbIXFHder4ZM6v/75tP+ZkDJR8LK4cX7MON6QRFujc99QKZZv2ls1lQOz8DQ6dUTs21X7d+Yv7M1+TQrG6YO5VttmPXZr1vP4x9rdQLIPVacXtUosWOS//XUkyUAS+LP75SCXooHqGpKwhmPvcC5fUNmdrLd9C8Syg3veAfuH4sZczpbcIqqiLA9gVB+Ntb8P4TXK2wS3jcNNUgwNf/Dszt8ol50TqYVo3xpEDiC96f52iqNVruCKu7PJci3VyX+RlRNKB6v+VmbUuVBVEBb711IMMsKQAAbTSLOGW/VQ06GcmOXnOUtvANPFcHslgAROWr2ZoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7ae6Big9lEnsgC6x/x+CbgGqgGKE1/N3oXBt4Z5PxQ=;
 b=UXRpxrkfg0AcSB5iHett5iLdoCyP6dJK9F8S90NpNrr8g1slYA+DtnULTHkx9MKwUEhlyIZ5S2oCwcG60kH5kJDUv7UB8CbHfL3jA9OzTh7eJZ9lTf5vfDtteK5mPuHwf+jWTMp7RP8kbQ+ytKD5RDPrvVCLOPABMGatO/Ok7hs8uQDzVWDuW+6U0nAw+xnYQJA+TbW8JwCYzKbysvKbBx8J9YsCN59hFUO+wYL8Orwp5gghYy4F5N8FsyWUhBefq0hPayxnN8Ho8UqTvPR2NxbcymL9W5Y6r/5D/78k6eyk+Aqvr1j2RuYM6eOZ8XFEgJ82UCodyHXsmfFwBuxk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7ae6Big9lEnsgC6x/x+CbgGqgGKE1/N3oXBt4Z5PxQ=;
 b=IkGXZgFcu+YTa8dT+vZNrZKmh7r27cf5/B+XEJDhKv/8rYM43ke4YJdnSAaecl/TP73edPDM5OExFPfBKcdw/ZoNrAK3zcoWlGpa9PlqwO8BetlQsKhn6TAOMka9C5gDWlBetn0DpsGjgtTYOIua8ZYveEbQiVjlwz4sl6hkaeA2sU7GN+r7xVhXLeG0e/ZbuV0vaFK+deBarGMeXLMOiQUlOcsIkQZbAiAkzbZ5+KpVevgyCm7p/NyaG4wwTE1ataH8AdMZvekZYnMw+mb+3vzF5cvc3bRQIYvMpQQlQAZEmx8/OPrgxwOMv7wSOH10I6LBl98F7SJkV+aEskchLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by GV1PR04MB10918.eurprd04.prod.outlook.com (2603:10a6:150:207::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:00:17 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 07:00:16 +0000
From: hongxing.zhu@oss.nxp.com
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1] PCI: imx6: Update MPLLB bandwidth for i.MX95 PCIe Gen3 stability
Date: Mon,  6 Jul 2026 15:03:40 +0800
Message-Id: <20260706070340.3603150-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|GV1PR04MB10918:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d92bbe-8472-49fa-04c1-08dedb2c3b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|1800799024|366016|921020|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QmRzf5U/RF/hk128cX7MGTRi/MRrZpdzxp4ZtrkFO34KH9j8GaEIrSfSlC+8ypdDUeWPgudu3h+7vvNjDjtSARvhFzBjMVoZ6MkKw30iUsM61+nbnp3PV18xA3qPVhg8Fun55KL2FD2geA9FJA3Zjf8/+tTZQVWdhIfkU2nRREENPSS7DJMZrFK1A4TiL2P5yjwKOSxUjvCT5Bd4JKtqignXJywz50ycWMbUGfR0ZJbOm5bvp7NluQV3YHSJlP7nT90qgkkr2QP+Htb/bIn6P2WvyOl9ijPUpc0IHIjwCCCY6QvxJp1uWP0nBFtMU5cDHy5G0ifcn/Z5PCYmadWjk04WgyJsS3fqizMWRL37KYcZyE/CwAcFiHdSiRZcRbY2ZoE8141m5PsGMycQvgly8HVZL4+SLf6bFzwON+vQgykWwSh7POfiJuCWTu67F7JG13ebn2FSsVKtPlrOeKVIYIyd8cpgCa7V+iOtFAniQzTRvZKiFRy+Vv8Jgl5I7iHcanaZSatiOKoPH+0lngKgT3fcR/UyDlW6m0E1WsoiZVJQ0SQvjXfy49sh7je+N38Feptm/QL3Gmoycm1nsOmTFeGZV7r6I/6+NyQuBtUEYmEkCkgZliNYL1/DlB65WFVOTe5k6SLJIhZ0W4YzTn28qn1wC+c5C/4s7F/PoSDtwR/ZCF72cj1n/g0MdEbkiuLYBP8lJJF/lOTW5R5qXknwgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(1800799024)(366016)(921020)(56012099006)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VJ/fFRz0jBeAOlHsEhmngSy0mVRMWQyT4zno9lXLF7NXYAorGbLu5xSvBVo5?=
 =?us-ascii?Q?iEDXWS8EAbq+X8+C3IfrahJ7jYX8ZRijAaEiQoOmnDkqH4KAjITUkcfvBckT?=
 =?us-ascii?Q?9blED0vRYRlfusvUfS5Tl4yJKMXRhXBMh2N/0YX1BrlaNLXF4OwIhusON/0Y?=
 =?us-ascii?Q?j52/P0iZ1EmdLeI8R7SuFHA+IkgmeVxGgBeyMeYx1zm2jydCoD4JrPq0rhTs?=
 =?us-ascii?Q?O1D6t5qPKcu7dsX4PzT6NE0xb9hFGQNF8wHiFrRbOuJQPHLLpMMqeOZjCEtu?=
 =?us-ascii?Q?MLKoBGNymnL9TDvllZZPCd9+vLOWDMoibJsiaB2jyjAtKDxD3sTyw3JahM87?=
 =?us-ascii?Q?eteVH8FMMB/+mpfUpY7wCmOT9olC7vxTVGV2k6YHowLe4ZYELJedeeT25qkC?=
 =?us-ascii?Q?00F9FjLilDVK5HDPRAwo9jT0T4wARBFafLmEOkV4RptXH2IcgOnXFi8eykxx?=
 =?us-ascii?Q?bME8TD1MdGGJJNzF8M0wL0P6FKK5XlV63WmSkqQn0S0rUIcwaqFpHjHDEpvj?=
 =?us-ascii?Q?0nCUydfycueJAgcJjLP8Z8Likfti4ZyYS/e5+nOv6aUbLqYFdMPJT5f5mvuH?=
 =?us-ascii?Q?92DsSUV+YNhr5f9thmH+mEUeXTI1PRifBpl70Nhh2LPmyeO1CZPUyi3hLDvk?=
 =?us-ascii?Q?xkrQUtAZmk/zv9pNBYx5vJIkFZtPF9+Mm+lOh5pLQrAa0mHMwZDVdfvDxdl6?=
 =?us-ascii?Q?wgNDYVbgytFTzXHHfDly/5J7hRwS6oAPY14nbFMciHyOI7VssvOGpNJmExLi?=
 =?us-ascii?Q?iUqJKOIJOIHTsT8bJBR8OlJ8qHpau6Kni4CUb9qC3rAiy3cDHb+xL21GlYXb?=
 =?us-ascii?Q?zo4ioIoOn6K5T1WB3Z790cLuL0PleCIboW0evZUgSKnYt6TgLTU8A4rz1EKC?=
 =?us-ascii?Q?qEHQWvqqY5RSMP5oWCULzGO61k+pGZ1gHotws//eLQEYwwXxtQaIsFX2uHSQ?=
 =?us-ascii?Q?e3PyPETKmyfDTHcnMxHrXwEZ7PSGmJs0WE5bhb6gJUEgJT/Wie1IAZ2B+K8i?=
 =?us-ascii?Q?iszpyFmFLAG0hgk5CKAuxWODMj7h/+xV3m6dl687gsbfMiCgdp1IIswOZ34k?=
 =?us-ascii?Q?CxT6YnRuJlBAe9XKpS27ciHBkcqfPi5x1hwyJqcKB9PWVtLbysmL38NoyTlI?=
 =?us-ascii?Q?J1nZ7ETQkesE/ajObPsMOOjY6OSY/Q3/q5UB4OwgqdIuVlmP3az2CFC3uv4h?=
 =?us-ascii?Q?1NESz43bZsUe7xfhTfcsvGQaImWcLgDpuDnSZwTMta/PAaCamDB/ycBHzFfX?=
 =?us-ascii?Q?16GFk7YSPMKtq/ja7NXtTzpy0HFdP4+KQTskp3mOikNRP7FFDmy+3vdi/nRT?=
 =?us-ascii?Q?4jiSjKKqpdKBv4LhYFPI4hlQgy6GpWlrrgJG4t5gk9n1rzNSU1cbM8riEv+N?=
 =?us-ascii?Q?whIQbF9NS5XuCeJR9mCMfIT5OGhtkSvQBq3TajMx6jM2XHMbu0yHsbH94ZVm?=
 =?us-ascii?Q?JR1jpLBry7fC3eozG2mjkC0R0Cd5kvjtvdVzoDFugU8ZBI06fGZ9F2bj7MV3?=
 =?us-ascii?Q?LwqgMWMhm0z+EcV9mBHwI9FE+SUHhBW90QEMKxovAulak8cHjilhHqDW+JPl?=
 =?us-ascii?Q?BJA5dv8UEUUvQu+r05MalOlz0kTHlL6UjgcnXoxshAX/tSrbyqnOS206wmmd?=
 =?us-ascii?Q?wfttQ7f+2wYizZbx0RlHMLpMoM2x/MqGOCT0p4piR+epyu3TdQeiyMAaoa88?=
 =?us-ascii?Q?Ue9li/PTq+6/AOMemfiM75b4Rr+nNHj6WG6esK8geEHi6bUrVOrcMSUavhqV?=
 =?us-ascii?Q?X4yJttfi1I8BAlAK5HgMCu+jWRboY4sAYpOraoJ2r5tXXQXGsgU7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d92bbe-8472-49fa-04c1-08dedb2c3b7f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:00:16.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7i5thbPcC/nGvgotKgLt4U1d3ddLXKeLUHFzKstIuxH7k4WfLoHGzM6EChl6JomuvYM3SNwf9xV4M3KREdcF7r2+/XXJZxwC1EY0ZpGstMomDWXKhSgJJ2iSikMn+MJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10918

From: Richard Zhu <hongxing.zhu@nxp.com>

Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
the default MPLLB_BINDWIDTH value. This margin degradation worsens
across voltage and temperature (VT) variations and different test
matrices, potentially causing link stability issues.

Testing with MPLLB_BINDWIDTH value of 140 (0x8c) shows significant
improvement in bandwidth margins across all VT conditions and test
scenarios.

Implement PHY register write helper function and configure:
- MPLLB_BW_OVRD_IN = 140 (0x8c) for improved bandwidth margin
- MPLLB_BW_OVRD_EN to enable the override

This ensures robust PCIe Gen3 performance across all operating
conditions.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 31 +++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6924a06bde305..023145b0dd2c7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -80,6 +80,15 @@
 #define IMX95_SID_MASK				GENMASK(5, 0)
 #define IMX95_MAX_LUT				32
 
+#define IMX95_PCIE_PHY_REG_ADDR			0x3008
+#define IMX95_PCIE_PHY_REG_EN			BIT(31)
+#define IMX95_PCIE_PHY_REG_ADDR_MASK		GENMASK(15, 0)
+#define IMX95_PCIE_PHY_REG_DATA			0x300c
+#define IMX95_PCIE_PHY_MPLLB_OVRD_IN		0x2004
+#define IMX95_PCIE_PHY_MPLLB_BW_OVRD_EN		0x400
+#define IMX95_PCIE_PHY_MPLLB_BW_OVRD_IN		0x2005
+#define IMX95_PCIE_PHY_MPLLB_BW			0x8c
+
 #define IMX95_PCIE_RST_CTRL			0x3010
 #define IMX95_PCIE_COLD_RST			BIT(0)
 
@@ -269,6 +278,20 @@ static int imx95_pcie_select_ref_clk_src(struct imx_pcie *imx_pcie)
 	return 0;
 }
 
+static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
+			   IMX95_PCIE_PHY_CR_PARA_SEL,
+			   IMX95_PCIE_PHY_CR_PARA_SEL);
+
+	fsleep(200);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
+			   IMX95_PCIE_PHY_REG_EN, IMX95_PCIE_PHY_REG_EN);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
+			   IMX95_PCIE_PHY_REG_ADDR_MASK, addr);
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_DATA, data);
+}
+
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
 	/*
@@ -284,10 +307,10 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
 			IMX95_PCIE_SYS_AUX_PWR_DET);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			IMX95_PCIE_SS_RW_REG_0,
-			IMX95_PCIE_PHY_CR_PARA_SEL,
-			IMX95_PCIE_PHY_CR_PARA_SEL);
+	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_BW_OVRD_IN,
+			     IMX95_PCIE_PHY_MPLLB_BW);
+	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_IN,
+			     IMX95_PCIE_PHY_MPLLB_BW_OVRD_EN);
 
 	return 0;
 }
-- 
2.34.1

