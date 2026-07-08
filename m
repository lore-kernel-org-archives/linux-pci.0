Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26350361662;
	Wed,  8 Jul 2026 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482984; cv=fail; b=MVkTI807k7wqwiTXbalbovVkUeS1tw98+IRhJwuOeGDxMj660pnw5FEbhsRgAms0di0rPBSwrEdnFFyDwG5A5KHxsuxgM3lIJfy7EgeeZN/Dxi8zAl4S7OfJWJAwzQPHUH/4u1f6m4cl6n7x2aJip8n3wCKYVpfy7BzxTcpWRYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482984; c=relaxed/simple;
	bh=i2hmVFkxGbMS4DGlmX6sT74FbjsXXwaTIBIXQgZspsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IS1pLzBHX2gmX2e/QQHV9OinbLF0Rp9lhuCX2yXmyTDlc5S46/O+Bk9hqEiIXfiM+N8FuNoRcx09LntJBhh3OPwBIyz/5/qbDjmmu1ht57RIvZc47CWLfSKN/Jxt8MyicH+9yVqumLtLolZEaP9FwFxHgD8vXOEaihAgCxNMYBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AnfwVlGT; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AnfwVlGT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euCF3fp1mGe2X+zQNOApTOVdIJv1AAsH8TmiWRgiVemBg3ANK//L2qBZKJs2jwgraEL87d9+joxM3fhBvaM5kGuaKgdu/AwUn/LP5CwpMpG03cQllX54MSDCTUZQefNiRSqnAxN1829r1v6trLU6MJyTj+9XtHtf4aQtXTIIlXljrtakwB6y6ASuCOd6BQVN4eqnwprq3TITpMyvUXEaOj/J1LqnPxFU18UWO5MH7w1T5qWjrNbePF54SapuOck1W4WYQ1ZXGDldXXztgfp9iuw8UNNWGnf9RNdhMborZTZVYbq0DA0/BKwLBj9qBfSAJ+tm6RqwkLpTIHwG1Sp18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgqYdqgAHiA8ufrgH8v9pk34W8DLhMxDAZXmCg+cJdo=;
 b=XyhGdAxEmxuhwjw7tkW5p+wAZ+dGRShVShASvqUSZornHm/xqmsIXR3HbhSlnE+AHohp3lo86baGyqLwiq5B0+hc2OaL0XQjSxRMdZufwgAIOfdR1CrtziJLQa60skBueRqx9lmfI4YzTY6t7kaBqbcN+IBdVjRvHfzOGW3i8CWLizMkmYW9W8t18XsOWtl2wrHKxhPY+niRwKn6uvNUcJ/luC3DI0BzNL/4YaL3iVNTKD7D8AcGAxnwJEoNMp70wIy69QY/60zi+UmzTyX3h3wiCUtlCtTIm3UPsNi1KkX1LG92VRATy4Oz8slgBk4cqS39UrffCk9Z0rT0fuWRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgqYdqgAHiA8ufrgH8v9pk34W8DLhMxDAZXmCg+cJdo=;
 b=AnfwVlGTULDRKIg6E5QQwucf0adgptkMLP+Y7WmSgpoEUDXjwTpxtrWlKIMHS3M81yUsNOaI6kcJ3nGEmf5PPztTEAS0CHO8ck7L+DlRV88t+/CEUrnl1mXEZw08IV6AVHxKD8PL5buovG2mBksj1UZ6HqMP4L0k6xsy1X4mWeyPuUS/EO81zWhenFHsiFkUJM6bHPqAVOfxvrDpL17qA6qX1se61g3cbZfg762cHNEaLnmQ+5jFlp642CZ1EufdtNFeUSEJq6FSisjw1h4WZ6WR6XhZ+970X92yMOBObqT/uM9SViyD/ssL8s75k0Wco3m40bgOlyMHftCyGj5o1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by VI0PR04MB11768.eurprd04.prod.outlook.com (2603:10a6:800:2ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 03:56:20 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 03:56:20 +0000
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
Subject: [PATCH v2] PCI: imx6: Update MPLLB bandwidth to improve i.MX95 Gen3 PCIe stability
Date: Wed,  8 Jul 2026 11:59:28 +0800
Message-Id: <20260708035928.580236-3-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|VI0PR04MB11768:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e9650c-7988-43b7-fd40-08dedca4deae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|19092799006|366016|921020|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	28hvds+8ZRmQ/UcXI3a4ZJaX841ekkha4yABOaazB7wMh0kAITOlQMY0UtXAc3vEDJxZDL7KfH1st+6JwdUD5ZttDE0dMbrn1DRXds4cwjsGogCwKZGDtACDFAgFQe6voWCPMoWsfzyPBFZLQ6Y+Cvtm/54mnSv5AWn0yWO/zdeN+VwrnYz2tOu9KPkk7w/GphLL4NW6GSgo8+llL7fWsJU0EPN0lpfuwpUMMVrVVoB1yZGLkpQEHHfqcOSHwz8tCUbG4dUlLo8FpOqistby6dCMNWe3/ugjqF1G69eOg/SIj9aP1+U/9HUZ9LwHCXjL9jnL1KGpArwXu/2M9eXTxPg8lgtf6G0lXtHtN/4oRTP3QrDKnLYAwWs+l3ce5SpYRomSuo8l18F/Pcr8AEcfly4xrdYbZbMIlgBtoeW4b4UZuxCTQYXHWteW5INRW4hJdLEuu72r4eHYrDwoYsLomQKUDc6oDlAETdoDQiyUeixqgSi/vFDNfL0qB7yXqtloMT/IUBxp0/AVSRAXVXEVxsJYCcyJeudJXNsmi1J02rTMevwB9ew7xgjfiAkPa/Qf+JL1WHP8ICymv7eD5n8plbnpT6bUAnvLHkKrPpz4PJLaqNM1+UGt51mc0PYbI0GenEdOgYMpZCkEShk23hzKqcrWjy2sGL+aEbkWaNEpQbj8J5E0ogIiqmbEHHBIwPq58qR1xxCBPhvplMrB+yetsg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(19092799006)(366016)(921020)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YJwcX19oUcriShwCTQU8x1rg9G+4TqfnWdrEuCeJPFr9r/k5N6ZiS+LWnFWz?=
 =?us-ascii?Q?90zlgvtyKlyWSMIQvUwRbNnCxAOia8VuRtVhq0vBxsjn0XZx2kDpNKFzhq3g?=
 =?us-ascii?Q?bpLLx6mVwGcdP2rS1CWxvz4DOgt4+mUcpyAgKcM+xTyfZBeTfiLxdy8CA/KF?=
 =?us-ascii?Q?xIA3kBRuP7DNNcbyMBobE/3woWWk+yun2nr/fSabMjuz2GMNFOpO+F4PkHP8?=
 =?us-ascii?Q?9t8NXWi6WniYkG6PXsi8mDERD8lIdegohiY0IS6vWo9Mgjx2m1FK/+QlfdZZ?=
 =?us-ascii?Q?JPtW7eWPgRQINpvpLia+2CJ0D39CMhHSiTrzGEtBrXGvQQYJ6QXhTJqaZJQK?=
 =?us-ascii?Q?QfQQi6bRx28maI1FWE0GOTbJvCEYmPm8RvZIb5PsqaldoM/aTKB/og5Szr0l?=
 =?us-ascii?Q?GTxXXlFQBq3S1vT43DZw8KLcrYDRrk0lPj+2uHX655BruG4IuTXyZ5j7CSwy?=
 =?us-ascii?Q?3BW/zMcpwGP7iaT9x3tLudVuUsCMPrGG095R/H+SeVwPDaXN1tHMyP0tMovD?=
 =?us-ascii?Q?tsQvlHQ4U4hns2u42w7avnBlJO+RqMdfeey9zQ687ESYZk0AVIyyNUb4RY7J?=
 =?us-ascii?Q?KRqrNEiTqHWuMZkes7p/s8H34pEIuf0rM+XkhWwjg6QyQEGQC4yYBkw0crJY?=
 =?us-ascii?Q?yil3ruk7ovK746WrxdMXeDX/XJ1PH0eS6ZhJE3bi64CjlTAoarOE00RGFatS?=
 =?us-ascii?Q?a6hbtk23fmO3m+5d/LGEC2ucc7WxpUq9IOYoSxPK4KIWGqkW9A92xhrYicXI?=
 =?us-ascii?Q?YXg+15cI65nY8Um2G6DjEW0GiStBS8Y8bWQ++3+Qy69iJ3k8XaY5ZW0Wz2Dn?=
 =?us-ascii?Q?tPtEwsXrqZnVqb5iOcqjh1drNXKEJhzbVLapQgpwDBwR8auL6v7a0zUuMtv8?=
 =?us-ascii?Q?w31oILfcOx1l4mheBxNNH8mO2kzGapYSlWjZ2OUTzKBjJqzYlB987owMo8De?=
 =?us-ascii?Q?gq25ozy7N1RikgaUtzzpypeuX0+QoTOSIVwyZ4j9tR8ebatAn0YIzZ7O0mHO?=
 =?us-ascii?Q?KTGJiBTprr+C+35Wjov5MDsR4/zyNJbOqIGpLSwux5KOVD1aRYff3+sUUIyR?=
 =?us-ascii?Q?a7qHnxTd/P0ij4CYzUwKcftwcaW3SEAkgFOQeo8nieAZzpgCPtZK6/U6NJ8T?=
 =?us-ascii?Q?yzbSeVjo6l2w4xegtsFyFAGM63wy2/drPJySDpbXeCiimYCYAAOilVYEK9dv?=
 =?us-ascii?Q?TCM6aNl3yt59t5Dwe+PXk1QT78pXSnb74QCi0xyJ6t1f1693YhWVRZKjWs7T?=
 =?us-ascii?Q?cDQJ+Wcu74h7rBOMpUBc5F0KoccvxrYjXno5hntPZb/asdr3HDNzh5Sz1q12?=
 =?us-ascii?Q?M6ou924gJUh1Ci8Cz6JNZTkL5dGbInob4UGfec/QU+3dRNtfnrjwBm+pJ5AD?=
 =?us-ascii?Q?5bLE/EsQA1oy6VFBOaERAdYlq6D7KDuKezrIaS8tAQ0Dc3bZSiuFdgQYvVMZ?=
 =?us-ascii?Q?JxWCRf+hYXfkRRbh+7Eugl4jUQ0lWNW/mVOVI8ksv+JIweWopIZmWLI4Wf/+?=
 =?us-ascii?Q?3voQ2k7npqDqw64PiOeTGNIQ1pHUMmSXJ/Hr76JYIL+E1oz5Wt+atxHcZj6L?=
 =?us-ascii?Q?aUDXXKnkiTqw2pH+6AtJtxEyXMekqj4L3SwysKSgG5TDLdO3tUOpctuTx7YT?=
 =?us-ascii?Q?Xfx1RDhmhF8em7Lqy8H3AuIQxdbj7QNEfKZOl7yeUY1sOEXsHdGmo5tJIc+v?=
 =?us-ascii?Q?J2SU4Enok3QSKllgNfHaO98YGTWiuZ1X9TDirE9sBEmvU9n9in4lh9SsbeMF?=
 =?us-ascii?Q?phNKNrU7nt4hwJGBjICNxnjVAoFh84Lq3S+E118AV/JZVXJe3GDq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e9650c-7988-43b7-fd40-08dedca4deae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 03:56:20.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rg4aTwguYhduLrpmcFejnlIAoCAsvgThg8GN+n1Cz7YnditFif+uIXFCRzJxZRfxDMN1+RkBGGRZdlAUEftZNaNMcyrQqjiqAXwl2YvzaS5prUM26PGAw8O5jrPIqPBd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11768

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
Changes in v2:
Update the register name and bit definitions.
Don't move IMX95_PCIE_PHY_CR_PARA_SEL settings.
---
 drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 53f3da6ab30d5..5f75aa09e0377 100644
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
+#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN		0x400
+#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN		0x2005
+#define IMX95_PCIE_PHY_MPLLB_BW			0x8c
+
 #define IMX95_PCIE_RST_CTRL			0x3010
 #define IMX95_PCIE_COLD_RST			BIT(0)
 
@@ -269,6 +278,16 @@ static int imx95_pcie_select_ref_clk_src(struct imx_pcie *imx_pcie)
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
@@ -289,6 +308,11 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
+	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN,
+			     IMX95_PCIE_PHY_MPLLB_BW);
+	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_IN,
+			     IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN);
+
 	return 0;
 }
 
-- 
2.34.1

