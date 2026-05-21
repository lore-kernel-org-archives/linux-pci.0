Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD837703A;
	Thu, 21 May 2026 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355867; cv=fail; b=l98jgwKr2h8DzwkmQzGVhwNlTsq1gStjzYfeXUWHBZXD43V4J+ngNaLZ8P2VO055vz2lDg6YP5BG62hpT8uZ4sbuDLvVCsHo9d+0finc5LDqnm6bv68CZF/IPQKBtzLn2Za4tsFLft2un1dqoCND9+g/GIVEtr9xpX4Lz7HwjHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355867; c=relaxed/simple;
	bh=aBIY3RtjQOyB0owY2wTIJ9xRhbeSCtMyf8iLhHBtlMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ug3RgBOpPkRzl4EdQobvG1H3g3XfZhWlEEfANMF9cXOXnfkzQhxQUdDOF2KP/nY0E4Do7sQrGSUl6Ai7Cq2GCWRnWerqXGCw7rkI2WD/9NxTemOFJD3q8w+SepP6EI+nzEPTjqC03BS2ItPcIzd+zUFt7rAcR/+eKgP4XKSFI0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KikNclDD; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KikNclDD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqX7hnmLdhdY1p1kog7Y2Q0L17BheB5V6fkzhYi7GmR89N2yu8E8o0+2AyU6dAMAy+gq644FBvoygMTzSWQr9HiTDktfnrQKKvAwE8XQdGIp/mDba1UN4WJonCN4KrJ1EoXBPxdh490mqe42VI5cb+2UDGGFhAUVVV4J0gd+qfF7hMPAeQz51GusnYcvm/lAvjU/Eqbt6X/u8RvCzNF6N1yj6jBiDaK+KMF52ekg6M2dSTlY0L4ClQxx3C5nWgw1nLu2XAFdEA4Z6O3A1tpEPgr0S5RUzouQEOlkVgntlYBpx38Z0SxhThXW4YgG2nDrxvsWMrufvcaHbpL4sP4v0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lxjESjsnZOhOz0Q1tkdb5ZUkMY8Ga7/ixrt2QGnlL4=;
 b=J4WTH4wycvH/DVPJ70bCBRxMtEQeBj/9FMeTxFMNlUiwdiawpXi+7OSZTFKbR+cxNS0cMdqoyM+NVvr1c/BTlv7fbE26YXDiC8WFCiYYDEWsZbX0stPyw8ivSuaQO6MfmdfQ90SD2XkEjIWxM/wPsm0RuVZlcsqPE6xtzRx/1VquG5+8sL7vTuvG/33B6wcKUDgnONpBZEClHz2ycyi3pYsETPw0eFdK2j8koq0b5K5lhR5E6hYirReWieZ8lvRjvVUqUGFml1yJaqp4zCgzcBR2DFFNe/udI1eAgz7hb+Qq+DDNUusIruT+wF5fpl3iBPiZzKB+eVSYhUOzYEDD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lxjESjsnZOhOz0Q1tkdb5ZUkMY8Ga7/ixrt2QGnlL4=;
 b=KikNclDD03ay+hGSpyvArMIcR799h83ewfBd+VF5JGUQaU629atAi6DzuhqbHcyQrsxAAMHBV3em+reg8w+VvlvoDyNQ6KwmXEV2335oHNZN9FDmY+sVkPfGxree4oTddBDaKeSQOb930RFKMz7gMC2nnEi7npJo7IFMn4P36yICw5TfVCmNf9KyhlWIsTky8OZA/Gi9Y0X44TSU3/zZlls68KF18VnS005VVxBzqwx24lD1ijDcFwFGYJcdEFGtRYHE5XzwW+fm8sjqkjyhIOUahpUxXlhwSz7vL62lszg8r1mGbbyIa7pVFbhNjgVPEflQCxvVeiyfLkm0UiovAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 (2603:10a6:800:317::15) by AM9PR04MB7507.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 09:31:02 +0000
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a]) by VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 09:31:02 +0000
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
Subject: [PATCH v5 3/3] PCI: imx6: Add root port reset to support link recovery
Date: Thu, 21 May 2026 17:32:55 +0800
Message-Id: <20260521093255.61585-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260521093255.61585-1-hongxing.zhu@nxp.com>
References: <20260521093255.61585-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To VI0PR04MB12008.eurprd04.prod.outlook.com (2603:10a6:800:317::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12008:EE_|AM9PR04MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4d8374-3316-4cdd-295f-08deb71bac72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|52116014|921020|38350700014|22082099003|56012099003|18002099003|6133799003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	HX4Rk1pp3EVt94NttuQbxcohai3ja4rkwyoakQgjsXpMmIcg6DpyWnO+/dgZb5tLIhU72R8+oMc1dOyi+T9RCaEeSJfBSS5b1sHUKTbCI6aJ2WExohdAUGaoimLuwLWN2+znuE8DL+J7C4TOpLj03CZMvxxem6lKVnEXX6dHV7XkHE8P0yyZFjCl2K7K1j+UUbxWxvDeGHEdTbxhUO3ZYOYsfnghhUclrE4fjDrg+C0ZklxhhD+rSKdmFb102BJFQ7akfe4ouLSHjQLRdiWCx5T/p/McKw4FFLVT9s4sKyP5PPXm1kY+2pqs+LajriTbN6tDOxI6dSfLRMCVa9UO7tsH8HqAholuLp/t3J0zqqCFFbgIW9expz5rOlGwAfsKyZlcSwTTmcdN27R/a+hS6FdvOeojgvUHWSQZYkwz9LGI/FN/1IqfPM39+lCBhHUJvkNB9XPLy83EG2WwbqwJTLVz4ziE4v8hmITCzuYgnX/cPW79HE81QRhnk4qjDLFf1nbMVAT00gHA/hEGEnuYMa5UdbOtgPa63kmBVwlhMr7PQ1U0pVPZelehgTr9ywSRhgqZEoW6pBuhWtkhfl4YLDN2PJuh4oL1t9G7PorfL3C7Pi8tV6aqgsJuKFZbYOdu7U90P0oekgSgJ3dlj8hCwQJdDroUdCI1SKTcc1j61qvRmtmFu98/RVyz3rxSOZwR7j5CGwTgYiN8dTpFwpMSt6s/RpkxX+unWmh91J+XmqQ+/0B03kBpSfE/bWh7CJfjF07Eay1vJmEyvxyiRu/Hag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12008.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(52116014)(921020)(38350700014)(22082099003)(56012099003)(18002099003)(6133799003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sskVv8oqol6CBmBUXOOcYp2BFdfOCGNq7NsYY7K8ZCoNXf4yx31+qzJszv+9?=
 =?us-ascii?Q?PMI6Za/Hxi4aOwHOEGZYJk6AVOrV8f3ZNQ8pi+EXiBo07vKbNjoxPjChHwg1?=
 =?us-ascii?Q?4m4g56YsJKNSx6VQyMBvU/1TeuwK9TqossWRpYrhPgg3LghuaqX81qTP+RYS?=
 =?us-ascii?Q?XUCKpqIbxF80oyYuoYa/DXQafxsJQGklOvx9tsGsBvzJ+WSdXaxotjuuHiKN?=
 =?us-ascii?Q?AfcydoadC2+0+wArJKeHuzbE7K3oWLdIhooYccpVavMGHvQDW1UEiwem9Da0?=
 =?us-ascii?Q?3/x//U58iU9enpo5kcYzHQBYTMc0MADc0JG2+MDCD29l2oEKYwoH2yBSiEc9?=
 =?us-ascii?Q?N9QWML+gqFLjEF1WORKTjZqXHZfhnPY+X/yvlYCz6fdKOCrSnNlQdV175dHq?=
 =?us-ascii?Q?01cL5qleWuT66lcVtnE2C7OAfEA9jGVb/hgPDunTJfAWie1s2Wmm6khqh6bs?=
 =?us-ascii?Q?otIJZ47hdYl8DceEafC6kFjyca24816M2kXKbo/JHIo6DyBoIs+lgnV9cWU0?=
 =?us-ascii?Q?xJvA6/aB7SA7Tqw5beI82XpXzaWxith+6L+4TXn/14lyU4WpnjQdPCK8Lrme?=
 =?us-ascii?Q?YqGdRo2tCHel75Zxg5DqWEyDGXTlAinyGDRoUsoBuSjuf3tedFB+42jNfkZl?=
 =?us-ascii?Q?oRDGTPwsrliOBYtVnpPBX3yOwOtx+7BWLwWljYaNBd+dtg71S25mwS2Sukuw?=
 =?us-ascii?Q?2nR9jsEMg9ciiMNqNkxeUKVq91/V4xZqWac6j4FZxYGCPqxQG0vtDV98V7B9?=
 =?us-ascii?Q?21OymYxyLV6fLrr2EWkCwp/DCner4pG7NWOrAi4sa80QJxOe5gAz3IIVOs+4?=
 =?us-ascii?Q?i5H2AB/XEKJP/1eGGlmA0gTKtHCMwT81FdBdogLEtoGsph9aZXqu3W3Oiaov?=
 =?us-ascii?Q?fKwQmstNjsqqplUxHRLzMu+Z2A9u3T7ZvNpRpkDDsxz+xYkry/9B6G/INfsj?=
 =?us-ascii?Q?O8E/rvvi5bwtTHPqtixy2SjsZq6m3sI9vusId4RdHuuMoaMC+TljnJ0NN6C0?=
 =?us-ascii?Q?RxzC+URMc0zy7uzuS5vqrMIO+wQO2sTZgm91L0mGNbBmYfoRfIsunbCmaTfk?=
 =?us-ascii?Q?5KTGYkWt2KtfVlkHIx260WOsdaV3Ubv/gJmDtLjCvR8VANmh3ZPOGCv7erdv?=
 =?us-ascii?Q?0OwUarDWPDUHG501zurJCJ6pu8prhb5WWK6OSD+UOb7foXdEDV66Y3U+CBcb?=
 =?us-ascii?Q?14zH2yRIXdSKFC22htOC4h4yw25aaUjZSKs2jYKwmATHff/gL4MlfmUHAv89?=
 =?us-ascii?Q?KgnFD8fXok+VKsuBa0UdVhBVJqmryDibxmN6w8zfvWIM5Y8SnFZuLotWoOKZ?=
 =?us-ascii?Q?v3aFDJvv4DtVSAbY7rnv/u5MTvEvDY1bT1gKXBnm630tzvRoXM/YWGIly0F2?=
 =?us-ascii?Q?8hQc67dkUbu7pNh+aXG0aQwGknh72DzoqwhEW6TW9KPPN0ptiHmsgMYeQEFe?=
 =?us-ascii?Q?I5nEPIvJmdmyBmRzYvvtxMpiwvYlaAAcYejR66rVtDY9gELRLlDaObJxSWp6?=
 =?us-ascii?Q?7RW6IRPp2vU/7FhIX7oLD1xYdarxx/YIPB74JYPPrSL4fV2GWk9DIgZK5lEM?=
 =?us-ascii?Q?jVuNBETXgafKq++D2Djzx4JIEHK2mbyHpXv5d+5qVGpVHhZ4gQgJ1XChBTIq?=
 =?us-ascii?Q?+C+rUMamiH08RXXdQ2YgVFAnyvoGqtsM8Ow8PCgJ649oED6F4ywm13L8aMwh?=
 =?us-ascii?Q?UNwAdetq/3I774rc9qsqeL0aMNN+l6C7Z68wJGAJpsH7tgUd8LdRxSlgUUoL?=
 =?us-ascii?Q?GpBLtdVlPA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4d8374-3316-4cdd-295f-08deb71bac72
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12008.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:31:01.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oo5dj+spkktfzC6EXeT02tsTapouMK5C2Ev5cWtfzhBzAT9YfFflTcIDYFykiIqnK4QrpIcjee3ao30W0QyvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7507

The PCIe link can go down due to various unexpected circumstances. Add
root port reset support to enable link recovery for the i.MX PCIe
controller when the optional "intr" interrupt is present.

Reset root port to uninitialize, initialize the PCIe controller, and
restart the PCIe link at end when a link down event happens.

On i.MX95 platforms, link events and PME share the same interrupt line.
The link event interrupt cannot use a threaded-only IRQ handler because
the PME driver uses request_irq() with only the IRQF_SHARED flag set,
which requires a primary handler.

To handle this shared interrupt scenario, register a primary interrupt
handler with IRQF_SHARED for link events and manipulate the link event
enable bits to ensure the shared interrupt source triggers only one
handler at a time.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 124 ++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1034ac5c5f5c..c286581bede8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -78,6 +79,10 @@
 #define IMX95_SID_MASK				GENMASK(5, 0)
 #define IMX95_MAX_LUT				32
 
+#define IMX95_LINK_INT_CTRL_STS			0x1040
+#define IMX95_LINK_DOWN_INT_STS			BIT(11)
+#define IMX95_LINK_DOWN_INT_EN			BIT(10)
+
 #define IMX95_PCIE_RST_CTRL			0x3010
 #define IMX95_PCIE_COLD_RST			BIT(0)
 
@@ -125,6 +130,8 @@ enum imx_pcie_variants {
 #define IMX_PCIE_MAX_INSTANCES	2
 
 struct imx_pcie;
+static int imx_pcie_reset_root_port(struct pci_host_bridge *bridge,
+				    struct pci_dev *pdev);
 
 struct imx_pcie_drvdata {
 	enum imx_pcie_variants variant;
@@ -158,6 +165,7 @@ struct imx_pcie {
 	bool			supports_clkreq;
 	bool			enable_ext_refclk;
 	struct regmap		*iomuxc_gpr;
+	u32			lnk_intr;
 	u16			msi_ctrl;
 	u32			controller_id;
 	struct reset_control	*pciephy_reset;
@@ -1301,6 +1309,13 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 
 	imx_setup_phy_mpll(imx_pcie);
 
+	/*
+	 * Callback invoked by PCI core when link down is detected and
+	 * recovery is needed.
+	 */
+	if (pp->bridge)
+		pp->bridge->reset_root_port = imx_pcie_reset_root_port;
+
 	return 0;
 
 err_phy_off:
@@ -1568,6 +1583,9 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
+	if (imx_pcie->lnk_intr)
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				  IMX95_LINK_DOWN_INT_EN);
 	imx_pcie_msi_save_restore(imx_pcie, true);
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
 		imx_pcie_lut_save(imx_pcie);
@@ -1618,6 +1636,9 @@ static int imx_pcie_resume_noirq(struct device *dev)
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
 		imx_pcie_lut_restore(imx_pcie);
 	imx_pcie_msi_save_restore(imx_pcie, false);
+	if (imx_pcie->lnk_intr)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				IMX95_LINK_DOWN_INT_EN);
 
 	return 0;
 }
@@ -1627,6 +1648,85 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
 				  imx_pcie_resume_noirq)
 };
 
+static irqreturn_t imx_pcie_lnk_irq_isr(int irq, void *priv)
+{
+	struct imx_pcie *imx_pcie = priv;
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 val;
+
+	regmap_read(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS, &val);
+	if (val & IMX95_LINK_DOWN_INT_STS) {
+		dev_dbg(dev, "PCIe link down detected, initiating recovery\n");
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				  IMX95_LINK_DOWN_INT_EN);
+		/* Clear link down interrupt status by writing 1b'1 to it */
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				IMX95_LINK_DOWN_INT_STS);
+
+		return IRQ_WAKE_THREAD;
+	} else {
+		return IRQ_NONE;
+	}
+}
+
+static irqreturn_t imx_pcie_lnk_irq_thread(int irq, void *priv)
+{
+	struct imx_pcie *imx_pcie = priv;
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct pci_dev *port;
+
+	for_each_pci_bridge(port, pp->bridge->bus)
+		if (pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
+			pci_host_handle_link_down(port);
+
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+			IMX95_LINK_DOWN_INT_EN);
+
+	return IRQ_HANDLED;
+}
+
+static int imx_pcie_reset_root_port(struct pci_host_bridge *bridge,
+				    struct pci_dev *pdev)
+{
+	struct pci_bus *bus = bridge->bus;
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+	int ret;
+
+	imx_pcie_msi_save_restore(imx_pcie, true);
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_save(imx_pcie);
+	imx_pcie_stop_link(pci);
+	imx_pcie_host_exit(pp);
+
+	ret = imx_pcie_host_init(pp);
+	if (ret) {
+		dev_err(pci->dev, "Failed to re-init PCIe\n");
+		return ret;
+	}
+	ret = dw_pcie_setup_rc(pp);
+	if (ret)
+		goto err_host_deinit;
+
+	imx_pcie_start_link(pci);
+	dw_pcie_wait_for_link(pci);
+
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_restore(imx_pcie);
+	imx_pcie_msi_save_restore(imx_pcie, false);
+
+	dev_dbg(pci->dev, "Root port reset completed\n");
+	return 0;
+
+err_host_deinit:
+	imx_pcie_host_exit(pp);
+
+	return ret;
+}
+
 static int imx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1829,9 +1929,33 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			val |= PCI_MSI_FLAGS_ENABLE;
 			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
 		}
+
+		/* Get link event irq if it is present */
+		imx_pcie->lnk_intr = platform_get_irq_byname(pdev, "intr");
+		if (imx_pcie->lnk_intr > 0) {
+			ret = devm_request_threaded_irq(dev, imx_pcie->lnk_intr,
+							imx_pcie_lnk_irq_isr,
+							imx_pcie_lnk_irq_thread,
+							IRQF_SHARED,
+							"lnk", imx_pcie);
+			if (ret) {
+				dev_err_probe(dev, ret,
+					      "unable to request LNK IRQ\n");
+				goto err_host_deinit;
+			}
+
+			regmap_set_bits(imx_pcie->iomuxc_gpr,
+					IMX95_LINK_INT_CTRL_STS,
+					IMX95_LINK_DOWN_INT_EN);
+		}
 	}
 
 	return 0;
+
+err_host_deinit:
+	dw_pcie_host_deinit(&pci->pp);
+
+	return ret;
 }
 
 static void imx_pcie_shutdown(struct platform_device *pdev)
-- 
2.37.1

