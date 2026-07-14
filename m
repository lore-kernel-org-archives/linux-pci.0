Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC0381B05;
	Tue, 14 Jul 2026 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996677; cv=fail; b=mZbJPktjcXOcl+9IqiySKkAv0xgTxqi/ZtMvLnBPfMmWW2G1BEkfI+ZZgegeiIjd/xyt/zV6f1JgLTgioLL9hl43unY+c8DKt4XxDOgex9fat/n0BXvnBULVqN5grTTdgHi2+p0ZmLN79ad8FuyGFyRNZDFHakSR4AG4uP6q0Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996677; c=relaxed/simple;
	bh=LezNb1hSe71mZ3I88VQ+KTmHxwE2uXcBdctRqMyfAV8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Mn7YD7599XFr8boPnl+QKsqkQogkKBnVx4gITGYQnaTJLZEqkJs8bqgPg8iyB2dLE+QCsi+xMLTrjvsyYAXh7h84Pk+dpI24ziHPMlJRdnJJQxQ2YAKMIjNo6bcQQ10X4mpciw+HP/m5t6IFSeVCcRuFDDv62leo3PhMjbzDp5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J4juwapV; arc=fail smtp.client-ip=52.101.84.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J4juwapV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4+CvYe8nI6vsZin8GV/GW2EG/Weem39Skhur1EghYJyFUgixR5IMVIJVenudOx9ops1ztd0brbX2YSXpbpfHeddvQ9wmi0sV8uLPjbQJSM+XSnkD5YZSNVfZcgGd8OcKXDjRoEfT3Fdtl11Vp1TwdISe0B+75R7RQdb8TV9pMSuzVrv5B/6+TFzFz9cHHK609J1q0w+w79cIsqMzbRvJ6zSBFMscVwkj/borP4suO2z8wHYLgP0leAM6pSwghoMJxS6qD6TZIxk6T9JApC8ETMxgDrl/u+uIhuLrrq3Bc0emEotSBbYDx1vsRsWUF+ZSVppxb+A7VbXQaas+mQi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwZ7LltCIY8e5UxbY5SgVpgSCjUGrptJYNUGClMBKGQ=;
 b=fdnF9hqJgraPKI3QKuMSJ1g0d5nmfqy7izXj/TQgrDaQzzSbc99rwmiDnnZNJ1B25Eia/+susW9tX2v8d5RzF+xJeeVoasXihN8EUDXA9RrxbkiU3mqkbxltHCvartDAr/BKh5966xOgzXVJZ2jx8QImE58/lE6KHkUK/mFG5FRE7UmMytJu5M5GWQ4dHq4eAv8qNG7iMNDpoJUV8aQSbeYMlb2bC9pSkjyRBaSu5tW0R3LdF6yXt4zPcE2HTv/0yibwv5+tkI+iCnGgDyp7DdlCNSZABIalA9Oo9cu6bXTc5A1Qb39wZ5lFuiDsMVj3bsnq7eojyJynLCbOT3zcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwZ7LltCIY8e5UxbY5SgVpgSCjUGrptJYNUGClMBKGQ=;
 b=J4juwapVRjL+/IlOVvofKKi/slxZ0ThtnEM8ONYWGVsfsX+GQQeXrekOOe2VH7VIulYkYsmcwWp6xBHoZE64IIItRBQpsoTEjCL5Xi+U9WT4uRJ2REnU6F+s/RBuMx1AfQRThQnGMj2kUwcnHROdlh9VcaerQHWzIOGsPPNURpNWquB0C04TLP9yP32D3YP22WPqQ5eE5ImyKjUA06RD1OF1vgvRaJmr0TCyKih+2NsJMrWTSBj7idjQ0ruDIiOSQwxEJKdvmLKCnSp/UcZdZYaopDaWJ90cxqufxma0Umk23TbtN192tgvZES+M9wkpJPjDO+w1XfuZXAhrcQwwQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8083.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::15)
 by GVXPR04MB11543.eurprd04.prod.outlook.com (2603:10a6:150:2c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Tue, 14 Jul
 2026 02:37:52 +0000
Received: from AM9PR04MB8083.eurprd04.prod.outlook.com
 ([fe80::44f5:bd7a:e05b:9a41]) by AM9PR04MB8083.eurprd04.prod.outlook.com
 ([fe80::44f5:bd7a:e05b:9a41%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 02:37:51 +0000
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
Subject: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX95 Gen3 PCIe stability
Date: Tue, 14 Jul 2026 10:41:07 +0800
Message-Id: <20260714024107.4113926-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::8) To AM9PR04MB8083.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b5::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8083:EE_|GVXPR04MB11543:EE_
X-MS-Office365-Filtering-Correlation-Id: b2095f11-5ce8-48d8-6028-08dee150e664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|921020|3023799007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	z2rMWBmhIrHkPKBa9e8VWm1Q46TlzOfO4bgqasDbVUPS4n3lcFc7/L9VqtakD0Y+b1CcQQlFpH4NJHh4hmVOj8g2LYUJGyj4jeGktkcceA0GP71wMiQYIludAn+gHcvrlvi8MHdoJTU6WKL4st528a1JlDeGBlH7Mfor2KSmzCBz5Z3xMzXp9hkqCrX8/kWSvqimTEeSLa66lATXRUtQuGDeefB7NLZOajtJue8x4U2n5E++puh9nFbMtchPmRFNwAzJZLLSXbe1/ijpDp2sVuPr87ukFuZulvjTQ8SUgMUjBQhp/c2bp8CJbvnxKF6tfPNahoAPs9uWbDP/0w4fCSYXmNBol40j7VhqZriyLH2H4o/Mcd758Q6eI1OzCQ2EEBm78Cw2yh5e7B+hBT+EXAHRuQnGcB4ynavTZcNFcUUFiHmeCF7doSixjVCXx9JMnW1hrhw9FpFGfvgcOv63Bu2FdFPVXxLC+hAgWN1sNgf1a/hl/3t+04M9U1mhbO71xv2XYsmTw6VtwLbb+tG1BkwZ2YLiaEVvkIRN7I8Z70dEzSw24nl/QI/gFnTlhjs5FqkFODx6LlKvJQn2yZUCNcbEOM+zCWyYjf14mw+LuwsFQ9Alc6+dQr94v+0Z0B/RbBzzQdDq9WirmBMrLap4c286PdjaujB/Ow2cJE5ej7/rLBnK8Rg0fe2URZsVOFZA/0JR8ihnIQXXX5D/DAyvzg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8083.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(921020)(3023799007)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T+abAwtHo9QxGPUMQCURTZ37CSLoOt3oZZFLU4O+SQ50INd4/tmNY+enAwV/?=
 =?us-ascii?Q?PZtGf8h0lPnzcvnIWchMvVrOb/HThfC4/nijU+9646JXgEsC3R9YMj3crU2i?=
 =?us-ascii?Q?Kb4S6RFsnIs3jmWg7csR/gp2wrsH7CTXXHppKf2GYqF8SEp7CVcUAsd85xNe?=
 =?us-ascii?Q?VdAkyjhYq3wEYqezzz9GYCE7e/3uSuUXIgcwD5TsxCRU2wymxnhS3j3bpCap?=
 =?us-ascii?Q?oJYWGSM74mzDeCVipNt9LaC7+21SjYyVU6RY7EzSi3meWhIttidllFXS8g6U?=
 =?us-ascii?Q?OKNmO+OEUVZQxfb0tT/1rx/PE0NVFWLf6l4KB/R8eU9Uh6L3785tuqwDMMO5?=
 =?us-ascii?Q?r/n4XfC/r2kFRv28sLCMtpsb40/dM+4P1jBNb3BdkZ2GVF33xWWzt85MY8dW?=
 =?us-ascii?Q?VdaFvTyEBav3pqvT2t2kftDtjZ02SSOcuBEBpCom7daOwTHGDaPdyaO5eW1N?=
 =?us-ascii?Q?ulfJfDvhDXdGQkm2NrOn1l+NPxdRxAcj8P5qObo3kewSeXkuQo5fVLvbv6Jh?=
 =?us-ascii?Q?tvJhMc+soyTfsk8yC8v5GDxYcpTuVKnFn7SrR8SP6YWC39jFu9Cvn0+FgBQy?=
 =?us-ascii?Q?tKhNDHhC/vWR8jzKKCQXp2GaokvF1/6lr9FpM+q8laHgNLM4izrZh+I79ab/?=
 =?us-ascii?Q?ZWG9nBwZN0rQoCmad7OFedKljuiRnPvVGUMzfEz9Ik4qLr+AiIm2vWUGLs4a?=
 =?us-ascii?Q?+4vxO0K8jneSJDKu7qCLkE3IlHJ4bShlUuvyLRhiGu6m0EEMaZAZ+lPsSawr?=
 =?us-ascii?Q?O/m1YZSpvc98Wd9BK5DED23+KbCQHvJlY3skFqCWpnrBBBMXp8NlpU6MDh17?=
 =?us-ascii?Q?Q1tFkWAPHign2J5zO8JeuuRYDednRLQcUeTd86aP4nAmJEohqfQu0vHRew5j?=
 =?us-ascii?Q?VoweNDtJl7ZtLd3LWdU3cABjy5F7iUOepqBeCDNuEvliBW+92Ktc5XCMmEn/?=
 =?us-ascii?Q?HMu89RqjHIuQQ3q+2mDzuZibrl6WIa4B6L4/Zez0P7cwp98X6XoxqD49Q720?=
 =?us-ascii?Q?2X+3iNIDqp2ryxlBBqcLSvf3uiZSLz79mzarUmuDJRD5zMr3onemE+hQBI4A?=
 =?us-ascii?Q?n/+UM4YGpFnr9FCor0rNUxX55QpaVQMXeREWB/8khXIaiJN6A5Itms7VJpQH?=
 =?us-ascii?Q?6oDGO2K+NzYpXbPmPRQcVD+vUqg2JipTQ7FkrQxxYuxv2VfC967iUhgbQdD1?=
 =?us-ascii?Q?z8ks9aiP0UMdxuBgPNZVK+idMJKI49JG7gGM0raaN3OdLtAoIUjlX2+9ckBG?=
 =?us-ascii?Q?vfGwK16PhsoklRWxR+485DlBFC3Uxsyy5xVvYMJYnDGBhCe1tfr6g2fYrEKL?=
 =?us-ascii?Q?SKsXH7/L/E7L7FS1zXpCM4NN9J37MbsQXaaFdup6owvDXF4wSCJwrHHf293A?=
 =?us-ascii?Q?SAP3cTFZfhWqAmSho1f+8XfWwEkXxHFm1aJRTTC+NHcoZvazve0/mtAmhpag?=
 =?us-ascii?Q?9KUTXaStjTJgcJLcqt+yTUpV1RJE5ozYU1HstGi7rXU4kyMaCUgfe+loCpUp?=
 =?us-ascii?Q?Ehigm9ZQ18AG9fGrVGU72V8l4uWUI7u96TQyYpN+o0sTVa+tPESR1MVHjGaS?=
 =?us-ascii?Q?l+a7wG6rtsQF4gUwvVXzzzfg6vZEfeZOCY5AAX4NRV2gMZxVE5eeUZDh+j5V?=
 =?us-ascii?Q?Vm2hg7u3RlClmhTuu130TTFXDQo/8xTAyE9jzgCCgXSzr9z+HU2IaizWwuHD?=
 =?us-ascii?Q?9u6EQ6eDSt1YacwUGXsw7mV6HGdJaAeJYtNgawLIFxZr3UhY/8CbLKwBjyHa?=
 =?us-ascii?Q?U5aa3OBURQ415SLnDYzH/7mdYv4SUg179RTOf9WQLMi2CJ2QavAZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2095f11-5ce8-48d8-6028-08dee150e664
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8083.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:37:51.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03mLOMqaFa7vPp23zwfanGGtY6XjDztxPlDur1hF+8U6Eyb+sinajyqLMv/R/p85ZbxiXC40lZ3OsySpUjyCnVblduMGCvKAZLo18PtwMQPcRcHxlmHfkHmdWiKGNO2i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11543

From: Richard Zhu <hongxing.zhu@nxp.com>

Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
the default MPLLB_BANDWIDTH value. This margin degradation worsens
across voltage and temperature (VT) variations and different test
matrices, potentially causing link stability issues.

Testing with MPLLB_BANDWIDTH value of 140 (0x8c) shows significant
improvement in bandwidth margins across all VT conditions and test
scenarios.

Implement PHY register write helper function and configure:
- MPLLB_BW_OVRD_IN = 140 (0x8c) for improved bandwidth margin
- MPLLB_BW_OVRD_EN to enable the override

This ensures robust PCIe Gen3 performance across all operating
conditions.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
Changes in v3:
Regarding Frank's comments, refine naming consistency and clarity.

Changes in v2:
Update the register name and bit definitions.
Don't move IMX95_PCIE_PHY_CR_PARA_SEL settings.
---
 drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 53f3da6ab30d5..fadf14de10f7c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -80,6 +80,17 @@
 #define IMX95_SID_MASK				GENMASK(5, 0)
 #define IMX95_MAX_LUT				32
 
+#define IMX95_PCIE_PHY_REG_ADDR			0x3008
+#define IMX95_PCIE_PHY_REG_EN			BIT(31)
+#define IMX95_PCIE_PHY_REG_ADDR_MASK		GENMASK(15, 0)
+#define IMX95_PCIE_PHY_REG_DATA			0x300c
+#define IMX95_PCIE_PHY_MPLLB_OVRD_IN		0x2004
+/* BIT(10): Override enable for mpllb_bandwidth[15:0] */
+#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN		0x400
+/* Register offset: Override value for mpllb_bandwidth[15:0] */
+#define IMX95_PCIE_PHY_MPLLB_BW_IN		0x2005
+#define IMX95_PCIE_PHY_MPLLB_BW_VAL		0x8c
+
 #define IMX95_PCIE_RST_CTRL			0x3010
 #define IMX95_PCIE_COLD_RST			BIT(0)
 
@@ -269,6 +280,16 @@ static int imx95_pcie_select_ref_clk_src(struct imx_pcie *imx_pcie)
 	return 0;
 }
 
+static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
+{
+	udelay(200);
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
@@ -289,6 +310,11 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
+	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_BW_IN,
+			     IMX95_PCIE_PHY_MPLLB_BW_VAL);
+	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_IN,
+			     IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN);
+
 	return 0;
 }
 
-- 
2.34.1

