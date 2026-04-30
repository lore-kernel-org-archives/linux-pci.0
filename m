Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0972D6401;
	Thu, 30 Apr 2026 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525696; cv=fail; b=DSy//bfAtT6SjVMErQjyz/WKCU9gc/OMWPG+XbIlZWlKZRQ++nuh//sqjQyaGcdZG8+N0CPOB3fvfB90FBTtgSVU/vqKAezuSCO43Jn6ZEr/L7ljoj0gvF9+8Ik7oMk89LUmMGwD2p4Dc5qWMCa68xeP1Ff3RFEnC98LZaJeREw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525696; c=relaxed/simple;
	bh=5Lz1LRGHDKMi3puK4Hkx31JVL3QL5RTcR2GrMlgne08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ipn7620dD7NuvCoiwEx1t2yfvt+uZ00/Sk9KA4dyyF/o1JipQWIyaaVfdSkT7b8WprBqcIIHr0p6pMZrh891qqQ7c9H6zKi2/HIq3uDH3wNLDYz6QRZfrikWsiUASYBZSGHhQyMHYPsbd57LvsKkL0Hltl3zQ2518Yw/iw8jaPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AZe5yMgc; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AZe5yMgc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFiUmruEj60CdfPyWdfJ1oQfcjJErrlDExTzAiQAOHOzSWHdigiDpNYGGLuCm17MxB+1M0M64ukBYPsJunYLrTerXJceGXYPdYHCu72wT+JTZojKOIdSy3epWcsKClXoebDi4DjtNBcsOWqoEcUghj29ymw5a25ZbD3iNvIqvLQa+yYAmdIARuOjjphmb1lOuFFDwWcszp3UFDb7GmTbC8CZUhydcCTtstYs6+ORUas0QytNPTfm2T6oleIa2T1URuIFbp+dW3hz4lWijVrwKEE0h1zY2DPSQ3hpI+wC7V5VSJpsTId2aqJE1DLMNcQ0mVGOBiK+cvfo60vbWg6y1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+E9YSHkt48U5922M0PpEv9fPS4gnw1ZNhq1rXdSBMY=;
 b=BVwOQpCfKt26Vu4Mfe48LJmOndcXIJ8ZjHZr0PZWrlazo0juQklIjNjCL6A+yMmcxz7l4WFv4Xtyah6Ei/NvAOmcks+hOj6xsuqL8LpcUSd77rTJIdWXiDz1NXL6TX8YifSQO7fq0OTyy6gYmAL3PtLKDal8r8nFkuS2mVrql0NitclGKj/TiQ0kjmY+e6/+zBN9SVJT/F3922OhzQ5zII1I5mQWIA9DZOFYE3Op1Bz8N+dapt+9duqG3fOb88ZpLbclV+K72QFJL04J6R7uzs0gef6MwCAFaoiOwRuRgiZ/nuXjG1hhq0oNUtO694JZXf0v0otbbdFjgskJp1uy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+E9YSHkt48U5922M0PpEv9fPS4gnw1ZNhq1rXdSBMY=;
 b=AZe5yMgcFcI3PCxamSXhQi4nvtAK5/3pYqX1FIny9TULW3HGw2xoMC4zOmZW0TX7ny8I0jSnCgTFMYffxMRrbFMch2F1bhCy5FlL3Xf5aQ1kE+Zs4muK012VxFgvd5hW/zgycUrhvlTP0H6Se1vx6TVKEilg+GD56UsGF+d9nL3xhGFzenkmQOJuNfqqj2PGjO69B6bDjfGnpexaRr6PbOyu6VImAzw/rNG4jg5OkcTlns5YIa2JpGGSUra0nxp1H+wJQdTS0h0XJM51E5qP6Arfv/CTL27TiWdCR/Mek0R9DxHkyGs8LYuWkJjpGN+YBa/gB9sxSnkIrpH3AY5Pow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by GV1PR04MB10108.eurprd04.prod.outlook.com (2603:10a6:150:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 05:08:11 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 05:08:11 +0000
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
Subject: [PATCH v3 3/3] PCI: imx6: Add root port reset to support link recovery
Date: Thu, 30 Apr 2026 13:09:54 +0800
Message-Id: <20260430050954.3467984-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
References: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5220:EE_|GV1PR04MB10108:EE_
X-MS-Office365-Filtering-Correlation-Id: 08026d3b-e5df-4527-b98a-08dea676798c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9oMaOXvuFC8VztsHUF2paEScsaCqVZpII4+Gr3GJdzRd7XHZ7N6l6zGEWI9O4gtbBDwHG7VLD4YU2RA4yXlqOcd+cavJElLroa+ycNymoCFz+F5ULqfquFMYNVjsJKRNV3BahmU66iVoTc4bFkcfIa1MCk9KjI/nUqwF/eytNOhRzj0iijms/6xSiiuJq6R6ulO7USx+v5NphJ2ABF5JHFzl60M/StDqHIqpzkytvC61g5Fa6ZqDUGZXWtScYOC1pfF+/Vvvhz8Xg03VTzVvgLmzlOy4CA30soU7v+WJpeRUWhhO/42sLDzUdScC/y4RZCDPCdLI0czmHQ/eXdGhhzet5YhTcLgMUGTFQIsuqe/h/8x+/hgiiHKu8ob+1uKvVmgNEBqBV8HBidRTqwcZp7AT52GBQa3mmYBWrwsHiNmQaHxMPGDSe3dAufklgaQNBSIOMzmhqwyxp9yoEoPljbH8uIp0gLo2qvUS9Vmm/rDOELgGZt6fVxiKE2k+6xXsomYm+p+cbTxW2IPmavNRpe6CV5m5pw4slUjLGtvYoTnvSxZ2+szrqA+fVZeAzOTRI/VqMSY9sj8WHE14FvLTsKIJjiflgyheDYWU8ZBxpyRyfLi5VVQecmb2eccZtkEholKQUT2/hmrIlx8Bxt8/x5iL2gIJ/0363uVyB6Nh/YBVqKcUxgCfepk9eaHVbkinpT8p/7XM4TD9V9Sl2Vvoz/JWR7Uz8jhGNk38JudVCugvRPs/0Y1tp3Hs6glWGaEtL/yrozRnQ3WpyF10YsKprhFJ7Nzey+jSXfCtljWmmBYNtF4tuTbSAqgyb2mQ/yOt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Lr2BaH8eN18SP2ztz2V704GGolf0WQ+tidt6sA6kSAXNJm6NZn01d3X4zKC?=
 =?us-ascii?Q?5f7R+UFWqywpKS/Gk/lTpgetXQMUPiUolpJJ/baGHENqgaUxONgGi7DglqFl?=
 =?us-ascii?Q?9rhP+EtZJAz0/scFwi06kJNhLmfj3nqTK5q3yQVgqEH2g1G82+MC/KmmhfoG?=
 =?us-ascii?Q?AdoYFXZHmE2MFyHzAxxHBqlniRXjJdfgRkRGgbXcNi2cgWNUEhSuk36HtzUf?=
 =?us-ascii?Q?NxtSkx7aTxVnwinIgKwkriCXCc0GT/sji+4WJIzym5Nz6HFYLW/Dkhnqcyr3?=
 =?us-ascii?Q?btkIHL8nqwmPL+t1q7h8juOi4BwXparBgkpQZWHdvfHk2VU5DCEUyeUmub2W?=
 =?us-ascii?Q?4gMSvRqVX6Gw+r0UpHwtCKfAcMVT9zVgyfy1VD/7jmkgYz6cN2epTz8u/P/w?=
 =?us-ascii?Q?y15TQRTG/TDM/plAUepMBdaOXq+JBECRKBPJiVnnfBCUTQ2Y41CBcdGHrZFS?=
 =?us-ascii?Q?99z9gSXR5MhMDEHWkjVVuTTlXQPjTlilxZpiwYTjb0VMzCC+LwRspxgIzTS8?=
 =?us-ascii?Q?4xiw/FzhArXw310yEmz+ZFwZYrZn+IZZr1KNdsqOpPjHOk4jDKyk1qST2HTf?=
 =?us-ascii?Q?eiPljT5QoAGdLzEm1c3eVO6uFDBS7ackDWb58VwpnVArdpL+A6TJc+DntBDx?=
 =?us-ascii?Q?CAszmpVR/SiFYUx+dfROlG6peDUSiOj3hrDsNlJpIW/GNPEyvSWcs8vq6/v3?=
 =?us-ascii?Q?Ki+2ZMtZAs+kfKOs5TB2uNDXq7QpguqsW+z3AVZRQeZDmYhgY92m4yNliDgs?=
 =?us-ascii?Q?CcEVTd+8Da3rhv6F4u7JEKtgCwFqpZaN0e7zZ8E7C5PJ04P/KddG59VwWqRw?=
 =?us-ascii?Q?/LMoX5o8LkA16cc0rncUSP+g+qEFPz6s9kAnSjLYawsomCJi1W6GDXZLlrCg?=
 =?us-ascii?Q?ABEw8WLPITUr1jyeVcFeb1CIPLbOWlFOzIcC88MIdGWsMNpBBovdNLnxQAvz?=
 =?us-ascii?Q?oGBRVkzRTOgUAxhxbUi2tuSGJ+RQ+DYiNcoQ4xvatNChkh/GUqhTkM/HUo6W?=
 =?us-ascii?Q?Z2IiCPzkowNjoTh+Wzn/ELAPTIx4wtZc+dfSok6qbom6zyXtiC0hqpKtMd1x?=
 =?us-ascii?Q?OAg+n8YhMDQNU3nG5QDoZt0H2Pnza+cgNwJCnvNwwznVuE6maipDaTXxH40i?=
 =?us-ascii?Q?XBjaW4tV0KAj0jZwFpxpuj2XfKVV4Z2lG6yut3oDOF8EU5nQad0GdYAadWQV?=
 =?us-ascii?Q?HeznaPt76YArqIIoeaVFQWBrIIgKT6MnI5R6DeNIAk5GkL4KnH0S17yVMoiR?=
 =?us-ascii?Q?L8jHiZsTDfiYWjb6htyCBxNKGdvjkvWJGyW0DXLb5tsTWheVME4tl5MoKfxA?=
 =?us-ascii?Q?F1yaES5y8qznq0k5Mip6j73nbvMhj8ECDohZBW49OaVc4ijcLcC3kGvm6uRL?=
 =?us-ascii?Q?GXHq4jF3aOC4nW7OuWNWvTgfgvGm1obD4Uu1e2DpGvXAx6F+CBY9SnNRc0KV?=
 =?us-ascii?Q?61xAcGbPmn+BI89coez1WpuWLyqu4goSElc+Ail04TWad83orbyZeBGqysll?=
 =?us-ascii?Q?cduL05kU8xW6eoONXfRAIbvGwnM9vv/Er6mJVOw0JMWSCvbuBLqPSHJBrv/1?=
 =?us-ascii?Q?fRCA1itVAbIc9HASsxndCIaePlzVhxBd1ilaN845FgYXmUnGX0vMPqaAP6fw?=
 =?us-ascii?Q?eA7VwCJ5MM/99XGk+x1YQdA1hrxCHEt0xdses9JjmOnmio9q80hZOeL9HwCU?=
 =?us-ascii?Q?xPvYbTMKf3GPlhDbcAUbdDKaI1SLslU8EUTkAFkEj6lI1Bew9aikRigO6W8D?=
 =?us-ascii?Q?Yui6eH22mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08026d3b-e5df-4527-b98a-08dea676798c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5220.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 05:08:11.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KshD8s97AWCkfI5P377Q5yxO6vuD73e57hWBr1dwBxIiw6mIadwQC5N3kRVQ1HOl3uccMzTU1jn5H6nepG5wWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10108

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
index e35044cc52185..38e0a16655092 100644
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
@@ -1306,6 +1314,13 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 
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
@@ -1573,6 +1588,9 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
+	if (imx_pcie->lnk_intr)
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				  IMX95_LINK_DOWN_INT_EN);
 	imx_pcie_msi_save_restore(imx_pcie, true);
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
 		imx_pcie_lut_save(imx_pcie);
@@ -1623,6 +1641,9 @@ static int imx_pcie_resume_noirq(struct device *dev)
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
 		imx_pcie_lut_restore(imx_pcie);
 	imx_pcie_msi_save_restore(imx_pcie, false);
+	if (imx_pcie->lnk_intr)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				IMX95_LINK_DOWN_INT_EN);
 
 	return 0;
 }
@@ -1632,6 +1653,84 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
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
@@ -1834,9 +1933,33 @@ static int imx_pcie_probe(struct platform_device *pdev)
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

