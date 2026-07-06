Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534C35BDA8;
	Mon,  6 Jul 2026 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783307047; cv=fail; b=bMVzmn6jHiq1hXT88cgcq+y/sSdvfukaJTTz+/0ddcZp2cVDaRD5bEsIBu7NZMNLQNdxacwRdifIN2SCKl2hKOaaBFhIiaTBT4aj62TxkNCpKgf8lQ/Hdu7vcZjafT2d6O3oEgCUCkz6we44r5/UUzWfoVjwMKLpaWezeNBw4AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783307047; c=relaxed/simple;
	bh=FVXfkrHfOLVUph5XgExbdSM5zLc1E5VqBmGDVmbWdtY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=E7PsQsnUQfrZgW0K7TQ8l1GEP02KfKw2PZHwy8supFfO5NU/MkfYmw96RsqtZzYTXyCjzT4EhPE6qOT0u22mPiAQm3/o+Ow/gd4tewS7/dcqs8mTAXYwljv76shXRgV9eMdAdgtCL9Ko8PEZTGq9Lh/q2PKm2WrA4Ctv9Obt6Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ciQ0FpuP; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ciQ0FpuP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2iZTK8QXMBGtadU0h3ASS/4qD5u0oeVhuTd3wz0KaAUZKvwPrEOuPkOc/nLCEfSD4MA8S749v6q0qZMhcs63NZRSjFbkMuk7FwA1eb6LWgODPzMneCZ+EVu80z338a8aV2O/1Vk8G8k7NGvsBUqWxgFJD4jfWC92gQFV2/0V30crA48G/09FkN88k2sZrkwV7qAZlqiz7lqVZIzHdPs65gflj+JMWrLfzfmS2iJr0rXdsTSVJY47AVCk6usxPMHFrWNCh1Apqo1A53byELkp/CMbJOFrxbYDxhjtQaoP53un92o2ezQqTcX7sgFgwi6KeE6C6kVa/13k+oGpwIoag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VM0STbeYY36qNGS/6c0vTMHDtd6J1CECOhowLULexo=;
 b=L2ksIbvEM+sHvbL+p7H5PQa9XIfovTrmNA9ZHwnHUOR6ur0TYD2w0YVZj2aaOmJm6vTlkyE+dLGzTRegCpL/IxM9RMNrwoqqCCOugJVBsEkxeMyButhNTKaF83h+m095MMp0N3mAZhPhRo43dmQCxHtR/a0qT34YNf4q87b0EbkOmqB9UfaoLqMnMOgfsZ0j8JumN1JJ1PG1rEfTcJwELt6dPBtHtyQD0nWlusOBHkMZT1b237uig4vHE+deBep5kBle7/yyaCg2ql/BPmTMyuK+nPJp/kY4QUwhegvwT6GCJpPRa0bJQB28N8H9zxsIERv4naGV6uGjCYrtAlLb9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VM0STbeYY36qNGS/6c0vTMHDtd6J1CECOhowLULexo=;
 b=ciQ0FpuPTWo30BLvtfeCjtTFiZNrS7DsalUZjoRV0y1UnyybsL8Z2zOLnFlFMX4Xr3VfS4btR3X1TqsiO3fJYo7yi6nH16jj9dN2nqNH7lFey522yCcyQE4zeSM6wSM84hPSfJtE7rrFxl2KnCbQGfyMqB9ojAiWvZCfaJtPYw0XwLWQwXh8JBe15iQHqBoKS6+zM2NN9oXZVohgGbPMYMgW4HCImXrOdKq45ghDgxw9MXMaZ2cuXXVX2HV0E6gtJaGLLqMzpfeiuHwXbmSp93x6UVwTdV5EyauXmVQhx/r1EOXdjjMLKr5U8gDufzmaupnpue6WQJPbQyHSG1nvaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by DB9PR04MB9865.eurprd04.prod.outlook.com (2603:10a6:10:4f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 03:04:01 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 03:04:01 +0000
From: hongxing.zhu@oss.nxp.com
To: frank.li@nxp.com,
	smoch@web.de,
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
Subject: [PATCH v1] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY power and reference clock control
Date: Mon,  6 Jul 2026 11:06:29 +0800
Message-Id: <20260706030629.3264320-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|DB9PR04MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 098f6183-d08d-47c7-f161-08dedb0b3ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|23010399003|921020|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	A9GSxaUIq9URnOaGekx1WHIHn5K9r1IuloLRD5fdkEmvm4tYacku4Ef02IhgW2Jeg7ZMvcQoURhpHEZJ3gDSe2LaJJvAp3lsrtZpdjwXhxTY6bQaI4DPJFNdwBVoOmQf36NiyHzUbkHADoaUhnohUOmihmExW5QaUL55btqFWeE5amkl4JGNDhqT21JCzrcLVd1/eUv4N2xucdiocDdPKBvGfHmCaGCAvX1JBygg+unP/kPrzb4mwoA4F3Wep0gGeCA9LtS1GJd27JpuJV1RVJLnD8HYz6G5F6l17R9QMzof7CBR9hIBKGJtG8E7CljhCt+b4P/offeh5Kpg+sf5cb9pcDiMUyeWVLnxAGR7+AKyUMaGFlpeIvpM8kdrL1sl+BB/+JD6TkiSWDxp7w49P1QB9jrvwnPlqJkHVU7AQ0ZqHe3lCrzPkM42p8DgPWSpuLW+Y4cH+JMgcjWdhZw8DgPy2PAHhwNYbvIILLcnY5QdWR/hfDau33oW9DncGmpVGOowpuDP9Oy5sdu9U1B4hOI+peQY63J3StKLfKBQfvg2cyiYZOLpZhkXbfHpH3AVI3Up9qSeB1c1Nls7V1USQwUAxV5bjvP8sLt/ANq0hKdbdYEvHFKMX4KAI6hQHwS/NxbI+k1JIL4qvyBW5CSV9XVPAU8wCchMLulu8ErnmqgHIU4RV3QG78qxeZixWiOrFADJqj2r3kUvJr9FfqruJQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(23010399003)(921020)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6u9AteHTDzsosIA10u5F/lWKhrnRdOtuXRTQpC9iN9Q4gCrq6kwZwPf3aK/f?=
 =?us-ascii?Q?CzAVmd19kTtCa0rSTtWEJABGoHTESlm2m3+WXKZDR0kxo0L9c4mcbcCAsMDB?=
 =?us-ascii?Q?av2WbyN8BJ6sh1BpZ532bMkzhIGQv/yqlnxjJZ940Eda0wxdWZJlYY3FOhCs?=
 =?us-ascii?Q?NaCW0D8Edk96ttx9kDuE5o1TLI+cn6YG/Iw8UqCVLnG/tjQaQSsewhyb0mF6?=
 =?us-ascii?Q?44SPakoy4AOb0zFe70aqdZkK3j737paDtmR2fIcfp6loyIZ60fADCUudi+Vg?=
 =?us-ascii?Q?5wmMThKyZnOs4ty8+4a5lr879RuxO5SQ/D2BgmZBlWh4fPkKQE72tpHpToH6?=
 =?us-ascii?Q?Gm1GMZcecC0qAY1cI9HJhBLdfMuM6oa9hiTLCLTSp4gDF5bWA4tdUg+Kh5Jc?=
 =?us-ascii?Q?un1bR6ntz4IUBFw3Gnp7Ig6WQBhSRfk3+iCJGJ9ao70BwvX5PWd2zmTyJFuC?=
 =?us-ascii?Q?UqOM73NUm9ypPqiRQR1j0YP9xaHph1si2FuGH3pe47jCBYWRhBGtvEfHypGB?=
 =?us-ascii?Q?5FcTn7eg43LpLV42yvW/8QJ+v91usg+dX174nYxNHAa4LpZ66FNeSKYI8E+D?=
 =?us-ascii?Q?LVxqH8utkwWdgBufG2rauskxAkrYCJ6Y33cudJ/zrRtQvg0w2JUaL9gFBk+a?=
 =?us-ascii?Q?MJrU9MpHduN7A+1x9SsuU0sBf4VD6dFTZmAdlVPs2W9i0ts+mjtu7A04+nnb?=
 =?us-ascii?Q?6NnY5FTYhx8xS+k7YatSZxgcn3KOs+K+jOvHY6lYXyXXLjfJRE89TSmaKlaF?=
 =?us-ascii?Q?rLQAXWhRMCbUl8DS1WbuLRBJVLE4gyCT9++Grr6axLBQ4EbsDyqZLMaQk05H?=
 =?us-ascii?Q?8uN3MeLCxp0ibaCpUAO56eiMZLP0A/a1a1Cw06iErFqX6LCaVoFiFDFRCgaq?=
 =?us-ascii?Q?umT1R2a0M3Y3Ex2Q7Q37CFhbL2Fryj4Vr5CR5gj2bPJw0fQ7UuzvFvq5P8nm?=
 =?us-ascii?Q?N7G8dytxFKpbFX0/CK7W4qT7GIe2bH79YEIB2eQPeVLH3gWHQ4iUzNsqBH85?=
 =?us-ascii?Q?aE4GEKmwId59LrHOJQJJvvl9Z5rX4E+onZvBF/SU/tooRUBZGKC09+6kfAvr?=
 =?us-ascii?Q?v79lVXa31hUkOQbaJ6zo8298FnKFCdGyRdycw/QDnlTzHXpt87n3mSNlDx1G?=
 =?us-ascii?Q?169DPa7o2zTK7DbF7Z11L5667CbnFfMi73Hf52q7WnU0IY+NtwQcl3vtHpKT?=
 =?us-ascii?Q?wvMlS09ve87QO6QK2y88qvH1dkgJ4gq49JnR64KxHGASrD0P62tMIF2/O5vk?=
 =?us-ascii?Q?Xe94TTSDKFuQZh0wosM+Ax4ykJ9W9HSAuNGWY+GFaf/4QnsbdeHkYv3rjdod?=
 =?us-ascii?Q?MRTJSy8pIQB7Mt8Na8rjBQwc9QvPOcd7Ew+tg+Rx/KuBkry5jjESro4ww7mv?=
 =?us-ascii?Q?AfJ771cNDfn+0M0MTGd/XC96nt/ttyZJRGvKWaoW2SM49dXlNjDM4kwRnSnJ?=
 =?us-ascii?Q?cwFAwpQ6jYw0rpMBRCAfBRUgN4dJ0xgfL0HVZDvji1gURxB93IbCr9vPv/WU?=
 =?us-ascii?Q?1gG+G8ShEPr7MPIXotdSws0b6WSaw+rXj0zLosnLDU6u08GJU+7rFFNAwjcs?=
 =?us-ascii?Q?4InU4XP41c7tzahpgOHEAEDJB14G/JEIJDdxUxyMJOa8BlUOcux6bEkqn5AT?=
 =?us-ascii?Q?SnmYjx5EGAmogUMxiV8iDtPVg6rHosMrr+dt6Mjxf6g0WJAN8OujlUUA1hD4?=
 =?us-ascii?Q?yC2zx/akrSBu7xdbq8AjQFzUjEZ05CLi9oXSouCclpzWcBbGhtdT+ktRTz0A?=
 =?us-ascii?Q?cjS0C16q//nnviDknLopjJwe8KuRyhEPB0RXBckYeIxlw1hEFLNE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098f6183-d08d-47c7-f161-08dedb0b3ad1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 03:04:01.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oer6cg50guMcjhcosNk+Pln84K3RSBHendDu3Y+aJQn7kfp28G5ahcnmkHvgazsnEF8UGt+gAoKuoGoovuNDoVr4IU2vDtpXvZfVmLuouOWMrt1OPm/9BmRmrciifSf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865

From: Richard Zhu <hongxing.zhu@nxp.com>

Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
introduced a boot hang on i.MX6Q/DL variants by changing the initialization
sequence.

The issue stems from coupling PHY power (TEST_PD) and reference clock
(REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
managed together, the timing between PHY power-up and reference clock
enablement cannot be properly controlled, leading to initialization
failures.

Fix this by separating the two concerns:

- Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where it
  logically belongs with reset operations. This ensures PHY power state
  is managed as part of the core reset sequence.

- Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset() for
  shared PHY power management, avoiding code duplication.

- Make imx6q_pcie_enable_ref_clk() responsible only for reference clock
  (REF_CLK_EN) control, simplifying its purpose.

- Remove the 10us delay workaround from imx6q_pcie_enable_ref_clk() as
  proper sequencing is now handled by the core_reset functions.

This refactoring ensures PHY power is controlled during reset
operations, fixing the boot hang while improving code maintainability.

Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 43 +++++++++++----------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ea0b4eb03c1d0..6924a06bde305 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -680,21 +680,12 @@ static int imx_pcie_attach_pd(struct device *dev)
 
 static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (enable) {
-		/* power up core phy and enable ref clock */
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
-		/*
-		 * The async reset input need ref clock to sync internally,
-		 * when the ref clock comes after reset, internal synced
-		 * reset time is too short, cannot meet the requirement.
-		 * Add a ~10us delay here.
-		 */
-		usleep_range(10, 100);
-		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
-	} else {
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
-		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
-	}
+	if (enable)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	else
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				  IMX6Q_GPR1_PCIE_REF_CLK_EN);
 
 	return 0;
 }
@@ -823,23 +814,25 @@ static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 	return 0;
 }
 
-static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 {
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
-			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
-	if (!assert)
-		usleep_range(200, 500);
+	if (assert)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD);
+	else
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				  IMX6Q_GPR1_PCIE_TEST_PD);
 
 	return 0;
 }
 
-static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 {
+	imx6q_pcie_core_reset(imx_pcie, assert);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
+			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
 	if (!assert)
-		return 0;
-
-	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
-	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+		usleep_range(200, 500);
 
 	return 0;
 }
-- 
2.34.1

