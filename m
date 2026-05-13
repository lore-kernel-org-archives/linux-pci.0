Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5936309B;
	Wed, 13 May 2026 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640558; cv=fail; b=B76yf192BDlpLG/onyEYfoBsN6NqwoXkGT9n1/59kg95F+zxts6pxZpBfs4sLEHvtVNg2VEGIWXWZxwnJMqMRLo6PWcfrLqeZ260Lpoonvo6x3qqufpLO/2bfHg+KpDQntg4bmVW+AXFVQ6gZ+loodhxTq1ydD9plLVk8o4pcks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640558; c=relaxed/simple;
	bh=BVFubaeoxmqtxj1uQ9L38WuceZ5VH97avradDOFmVcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fpFgaa3Q7Zf2MnYifa91maVuu6Kfg0Heh4BQIy7rKp99ENrT3buZYsCTjwnA/dk9hZyilsefFUPF+EETZ04429L5/XOhCtcY9Fcg42k54A7nyTuLfDRHNeMhxE3Jt9yYVApW97UDs6/n7JaPLi/2buQvVtsGY32V/qXVXDrRbJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fhn+vcWd; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fhn+vcWd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZcY9PLBlKN8/8iPeFnl1S6xsfMmAlM90TjY7Rwjf7Hd89l4vv19qo7V69bq9NCt9K3W+NUa9P13pwZhe6wCeKFABdHGrvvgFXJqWDDqx1Nvjk+yfqbIlmRo0YzqnsBWJz0knKeTtG2BS/lU6VW5SutWj7XFrS3fjDRR7tJGALgI/kl1Qdl+H0slpUBv9rkMwC3dbJrMQKt4XjG3tGW1eGvecKaoCOBXGTwsGNNawJGapoYgSljBaanoXjocQ3S+Ob4ZQYpCDvweCG6Cyk0T8p7xN31rXh3hgeukxaZD05dZQxLagwEEOfq5F7+IZUQQSTzJabOYwVxWpOm+ZkC+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js5fqpclSmUUaJlbAhfq3bEScKDbdTTzkHNwYp/dTqk=;
 b=CcABaC/ckMoINUnrTWUOC1xMbRE5yghQk+bo62qXIRui9K1OQ7hdgl/AYLAA8gMi6CdcJuz8H+qSafEXr+Dsibd1KrJoXr+1GjecI2cFExwTGhjpgejh8XXn2+pkAtQB6z7llCaXI77MtWORxMQNNRhZmkQla9NYNjNs/aqC36xIetDEg9ohtExr9x89brbK8MYkXFivc4RILGgjfnN3jSOKAn/al+dUg5C2Efb7+uMKwpFF/gkARCiiNo899XPZIViuXIK56ft6em/Vv+UR8mrdjTnU0Ir21gxlLzqFRUeDISIuUIyQuD5a/YSr8fJXOUoyRHsmQoeEFPybFlahgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js5fqpclSmUUaJlbAhfq3bEScKDbdTTzkHNwYp/dTqk=;
 b=Fhn+vcWdeowxpK8C5MMq6aKPlXVqzF5IyqixJcT+tNb1+HkPhTuDmcFLLhT553tmtBMvFXpri0ueFsiU9pLpW+z+wD/UmFH6aKVj9bPTXvktOaoT88d3j/ygyoj9uPG91g52s6XUWxrZvAko7ehNU90OjfrEf9ReTNccMwazsNejtJGeQ1Ns9WhkmzeL0FQSrQL4Ciu1iA717rDupg0mBFRxYPF9j91UNruS5QL6dz6NtzSJV2HVNAbRj0SR9Ymse+5L8cVdQ8XPccWT3nU3T3+ScjHIGQo5erGfpwHdSXVcKT0VLPNuaZZRahgbWMXvv3zJF9AcwEVmiYthv8APGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 (2603:10a6:800:317::15) by DB9PR04MB9867.eurprd04.prod.outlook.com
 (2603:10a6:10:4c0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:14 +0000
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a]) by VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 02:49:14 +0000
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
Subject: [PATCH v4 3/3] PCI: imx6: Add root port reset to support link recovery
Date: Wed, 13 May 2026 10:51:01 +0800
Message-Id: <20260513025101.1498104-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260513025101.1498104-1-hongxing.zhu@nxp.com>
References: <20260513025101.1498104-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To VI0PR04MB12008.eurprd04.prod.outlook.com
 (2603:10a6:800:317::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12008:EE_|DB9PR04MB9867:EE_
X-MS-Office365-Filtering-Correlation-Id: 043ae36b-7472-4972-aa47-08deb09a3835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|921020|38350700014|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M8WfLEY1f5lVr0jvBBsfr9Y6XqYMT7vraLNTSgQ8tjCMbYbMqg2h9xzG9CAEZl7LyHXr8Iest/s1plv452rxN1cs0+UDGfLclPQPd8CECkOhXq/1mU7I/4nCrF+a9Ev3lBpD/2n3lUwv/FTMku+aNrML7AGRrhnUcPasw41aMWElOVovoaBYTdDKnyfPIz2bjL+qmhcwPHCoWzhTkNALHLfwkSMJPnqUSw/mjKo72i3Ck38SAB/woAtYO2/B2rCqIIi/zP4omh1wLmVnuesI3lX8tG5u+Vf4QmKCtRYl09Hww/+5bG4UaidYOYQB8/FOA8t+7RvsxfHVzJTSsTxfEd1LSNVPLqAAsZGOhEVcGkFqhqDBrE9MUsDygIAFenmR6bwu5rVReqloJbjkP4GcPwTgAs8/sA0rFhu8z+kXwo9NOiUQOs9XAKgIfXByGVmE5pSkYRq5uDs5xeLq+CUkwA4TNZHFG3oVfg8w1KcQffTNInv/ozIsG8fAYl3z89zmUbNEbBZ+QwneVo8oUEyV8WLl4IgY7mkDGmqTxF3kIcTOQjg+rLKdpD3IQwM5J2ZNzxM7aWvv5qyNbNRvTM3n06pg9a3kC1vd1i3rALGAfkQwIC6kTdOn9M2DOK2CYTjMFwo98nE4EWDi6Oipq/rFqiOoR80YknEEJ5nzNrAJZrhOkaF+6cxe/cjX+Rd+EUDlhahXfB2Glo/DMuXh9cGt9nqV/p9NhT33G2gZc8oSaAcJgDFhfHbP3ZSkZcN94zKsUSO/Sfnl0DLqB8R/VyXRKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12008.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(921020)(38350700014)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oERVtY4PPG93aW8lwduGZY+hV607+MR8wvSau4pomvvwGAvEwIyWQyZpGV6v?=
 =?us-ascii?Q?yCx/crZyOQMwnkybNwFv4zpUz/HXPDmFxyQhee83T+jZktvcTL3GfL4Rex60?=
 =?us-ascii?Q?UODLnA/LV3wbBey2Af1kdu83QlKqUUMsy1MAI5XtGPlsHNMGMKhvd3Mr5VnL?=
 =?us-ascii?Q?AbjanDFFNIrlJpl07UKtvaC4RyfCyzsKRNSRs0w4lkOwsE8A8pxf873jDHCT?=
 =?us-ascii?Q?zumDJN/Pb2a+0A42SASY5JJGTuT6LP9yaMFpl4fLM8vHd7tAIOOZ4LQlk0dm?=
 =?us-ascii?Q?21WiLXUrun7oGOTf/wlk7mNCOcwlewuuyplDKjJ3hz5CcBw6Fp9OyX6av1oa?=
 =?us-ascii?Q?66/MGJZDybCZIqEQY+LXptBWFdNd6IRcQdzUZ3rUSJO9c0cM7kdhNjf17YFt?=
 =?us-ascii?Q?Jdj/fmI9RN15t94mfifkHR6EbsYeYvlap+sORY718nDlgU2DDdQOY+xI761C?=
 =?us-ascii?Q?HaPEGQifSCJ6BXSV5hhFw9J89YQ4R17YHoiPhmSLvvtFlZz+WcBpnF1okzJ6?=
 =?us-ascii?Q?fFFNk+Bl0u+okMGAmiIxQQ4F4OIbdroWI0slOHEuETPa5ZKkxZO4uS8n4x9t?=
 =?us-ascii?Q?/mBSnsLZscCftFchswmhOt6Vt4HE/jsXJQp5HmPY//qvnZbzR+YmZyOfVSIQ?=
 =?us-ascii?Q?2BfN8t75gWeWzMQXFCUTWJA4BJTvuWG8xrlSb6b/usfymEgCa2qScclzWzDm?=
 =?us-ascii?Q?E5DcTYQld/v8OU47zIMPB++Y3Oc8+/2DKKxHAWan75zW9ZgEjtymMH0w3pmN?=
 =?us-ascii?Q?dKGTk+h7Qav85BkhTtBY5AgDzUJ8fQ4g/aaDP6euScEaq5bDJiELlJt+S+PP?=
 =?us-ascii?Q?1rb7E27y5m8Ax7rGrplsBVNrGwqVElbXWziPoi97K/Oihjz3ca3kmilawziA?=
 =?us-ascii?Q?Iy+kxL2/fcxfIy5job8t4KxnMuYmAiFArEzlZAB258MOhOD9xJ1gZkNwt8yG?=
 =?us-ascii?Q?xLwb74bDSCNDm1Y1fF6z4WAhWKXQdt0jtXeu9sW6zQENTPvMzZIzHlh1zuZV?=
 =?us-ascii?Q?zfhqu3vxsj90ifzu7QyDyyaseV+RQOAwVVr4uPudHXkRSePuCROzPUztmWjK?=
 =?us-ascii?Q?jDxV3nx4DtAVjUHMI+uAfcCAFSiDO+utFpmJ+cWdw0vBLjoxGAVVGRGKEktw?=
 =?us-ascii?Q?6BZMC2IXwmxkHFMJ+vG/9weYbrASjTrl4X1kWo1bhXSWpSrI1fHi1Ta9eGMu?=
 =?us-ascii?Q?XGUEw/EaUhTudomXUYrhgY4MVcLb/yieT/fQHs1nD63DyVKVqKMfK+B9GNhb?=
 =?us-ascii?Q?3TzgzB6pEhd9jxgQgsjRn+H7UtQBmp/scfyoKC2eNpm0xBupjF/LyPLvbmR2?=
 =?us-ascii?Q?JdD/DHo+A2VoJXud+2MzWqKR9sHbkjh4lGyh7LrTFcVWK0TH2S7RyV7vnSNN?=
 =?us-ascii?Q?soayeD0MSE+Lk+JoL13yRDuG2xQMzVHV0OtMjC5z5KqRsAj/kFKc4+x4QQ0D?=
 =?us-ascii?Q?BJB/d+vBNOPnqe+iS2agwt+/RWvqK4P2FYkiMP/E69dByQ5IXQHqkD1tVXLm?=
 =?us-ascii?Q?JuYasYLl2M02BY0CLhzqjaxyyssHItfChrIPtx1Z2rR0YJ6tXg75rqdteda+?=
 =?us-ascii?Q?I4sPCKQxBW227/EpYo9l+LfjAqJ+g9w0F6MktMvSe+pxK4tenx3uJ2h73miT?=
 =?us-ascii?Q?jj5y13taoJUWt9TMxgCq1HPqrHrDxDJxyiuccg4HFQUPSkBtwO+po3JN80ze?=
 =?us-ascii?Q?VK2QqTsu9Ohyr+vibvF1+6uphZrbZjaSWMWi20K5FYy5GafAqWvSZKJDEHaN?=
 =?us-ascii?Q?uU9OoSaUYg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043ae36b-7472-4972-aa47-08deb09a3835
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12008.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:14.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNtEIJgCgJl1NdRRR4M69usAcGtumeXCbyF6qIolTu3ikCUBCg6r6UBE97TnUhBnDLXvT3mjvqHJB1FSjfl8xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9867

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
 drivers/pci/controller/dwc/pci-imx6.c | 123 ++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1034ac5c5f5c..79c92c77b85b 100644
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
@@ -1627,6 +1648,84 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
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
@@ -1829,9 +1928,33 @@ static int imx_pcie_probe(struct platform_device *pdev)
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

