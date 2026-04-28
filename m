Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552502EDD69;
	Tue, 28 Apr 2026 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362581; cv=fail; b=ToLpmPyGvhHnOIoZjn1weuPan/0ftiAeBx2GLSDXlpqWlXQlphLoaCQwqfm0Fgh0DfLRc0lBDX9eJNJEY02dan4gzBOkakKkBXNN+8FmBMV/mHhn4cg5VCrDPVn9U3gs7EmLHWPuGvD3YND4jbDOzL+nblF0T36txhay0RECwiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362581; c=relaxed/simple;
	bh=5Lz1LRGHDKMi3puK4Hkx31JVL3QL5RTcR2GrMlgne08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7KUcJ5nR1YpHj0PMZDhjy8rEWDaucFX0Unjv6NqeyinN0K5Mk1VZ37bhqCvX1b7DLWUV3LztEbSPo6XH0ITyB9GBYH5mrIiwC52CAk64MIjleZSeREBWfQEDyxSCPbuawI+MSIE+1P7IwAqWppTXYP+7SqnafvQeKijnWwd1jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hUpd2DBQ; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hUpd2DBQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP6ZTTA5hxsSeXD7ldBZdKhnimC5inu2eTF2xeSXXc2BISJUiMArKFwpzn5fw8Xzb25lgfhakueSPgchi2tCztyOr5j3oY2rcYEAF68zAUGJpf9pus+JUikP3a9UkI3o8vF638yz1Q+0xyc4on2gOGKyK7NgJb/2sDP4G6AGgs9TsbUFVpnyoZ6FUL4bDh7D1rcjTAG27ynA+q/vb1bUmdz5Gd1tSijX3WUksq4D0/KATbhhsIfjSFJvDYA+2xcnX3A8PBcHdjoJSBcALnaoBsjj56GClbPhz1xDTSsg7wJgW0C85iAfjobjh624EBhnYfc2PRBbK4JLYwFA38FOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+E9YSHkt48U5922M0PpEv9fPS4gnw1ZNhq1rXdSBMY=;
 b=DCIVUzo1ytsy1JkOwQvKjEOa+I6Fox+IzA5CBe/0RReZQRjoHWC/bYXEnlOyQib3zfS3XZZ+SqKNBluys+eW9ARVpwxKlwe3K+7FFiAVyOk5yXIGm2e6vkkjIsKKYfm/cQ2pY/DUxAtnwZ9Q9Z8gMFeMwSPfeNaWUfypd3Unf99kHsRpr6VeFWpFjsqoZv9jP4dPzwjiiZKJUDK6BGcOgS4XjLV+Sdi47F3M8tcEduc/sqyYPCSykV1ozFrog8Zi/ju/vOwTeushV/Ih/d8DQyHbutqQZVXaP6UF3Fh3PQpaThj9OpLQ8GFtllBm9GTftH7GdBu75V3yK6tXpayKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+E9YSHkt48U5922M0PpEv9fPS4gnw1ZNhq1rXdSBMY=;
 b=hUpd2DBQq3E6fRtvkRer/seONG92xBvXGvRkuDXvQQAhposE5L2+lhJFt847VKzASC9t6nQcBr5QhxKVrEhvHXxmwLvYH+989yOIp9GAihQGGu2Q0EwD5Wi2E25YG7iFYZPHxcl/TyD4B+2RxkuqLo0UuqrxpkdLb7kT4VXJWUshIJING+8vfgUZjIa0Ptz8yDr/hAXyc/iUhlavxdG5CWrAVj+SZZPKsd59EEUbXmxGIUiAVvcQQjEcHD1CVVVOy4DoZ2IjF1btl0O1WdnonjMRWL5UV41SniAb4+Cnx1ATEJUYenftBjZx6dXRwORVYr8RYMhvV5djRf2QtgOXrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by AMBPR04MB11720.eurprd04.prod.outlook.com (2603:10a6:20b:6f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:49:36 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:49:36 +0000
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
Subject: [PATCH v2 3/3] PCI: imx6: Add root port reset to support link recovery
Date: Tue, 28 Apr 2026 15:50:30 +0800
Message-Id: <20260428075030.1626440-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260428075030.1626440-1-hongxing.zhu@nxp.com>
References: <20260428075030.1626440-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AM0PR04MB5220.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5220:EE_|AMBPR04MB11720:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e585a56-9ade-476e-aba9-08dea4fab1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4JlXE2q4LuqHsSJX7g0Zz5Fa77X8NBWl3tKTbwbzxe8M9ts5z+n7DXsPyVqJ6ORLd50M7EyuOcMIvtfgxnVBBvlLADnHl82gU2H8zSilEoQ6qrrKZpCJxzViD7RjvQAKmOnPHAjGNgNnWgwllquPZ+lJnfv7X3m+NV1uQ2Wzb8liwWloMHjXKcGMh6J09UBv+L29zawlh//Sb0oWX7MJvKn4jq17n+SnjlKIn+nh5LYhhVpCAIWp7ypaTpG/0vsdTaAtgZt6xmzrjkviKvwODyHKWGzJVXn4oIb7ZXMHQet1VmTuHH3xS3hEl3VbX6EC/Ls03vaROG2Zawost6fRpZuTMkZHDagYSTS7/ib7i+YnjvYm2tKJFzoJYowXCoU8U/Pq1kzc/EUtuo4LHPiiB4jWWiF4bx3oOkP/wmfUQsRYW2BgwC5whjrxOi8o+8qSVASDT2l1dwsr6lzPO0ZxAy9JFU+qGeF/iSwDVod9ePep3mRUiflMR76rm9ljUctPJ8c3jhDSqs6Q+Qp7FYzLAVBjm6f13/T6rAbCcCdwusyOJCt6AH/qPeZAHThoPLcIhvpSVEekvhdsXCFjGjhK0BxoWs09pBsuv96DM9qtD7Eu22pKOlMMf00ZlYTGq2gLu9Q7YwkWo/RGGpA/MAJ6rtPbAVxDwLPp0s2D27oC15m8bmZPhwBiiNMn/Wd6oU5kcnXVtZ4lVKXtC5IYq+A64LETjX9XOCmCPW6fZff8Tdl8eeEqpgTTozsCYTxRdL0L5kKmHmWelroTG8PrsjO+agVI5SdGL1rdSrZXzY165CPu9ZvIgj815a7wGgjrkfaa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4cLcqEEeip72EazYrTI8EZVr4Y5xPUIPnwtMkR3TE5KmB0ZMh/Z8jA04AYlZ?=
 =?us-ascii?Q?lCHVmL9NgLskJaYZLbDkCkqq8w1d5m+8g1iLYoGqYx01o13IAmlCPLJ4fxqL?=
 =?us-ascii?Q?NWxpSipZlDkoHsJ/c2eQwO63WHuhVxhgwgMs5Jsx0dJu7hnjZ3sRvAUiZAeN?=
 =?us-ascii?Q?CLJCrWTXozCoN9rmLYrqs7zm9eUjP+7Yke7Jo0zkMu5LZobbj7uEFH6IemQr?=
 =?us-ascii?Q?yDDgbHk0EEg3OKBCMCiALLoni1AOf+ka+PBgs0U6lb2qey2ev1GuuEYabMc/?=
 =?us-ascii?Q?OYy41H6sNxMdD3i4+yvK+Ao/45/JFhGzFaf2WGLutRWHv+DNBNX9o++znDQw?=
 =?us-ascii?Q?VNe24XaDO19Ba+FdYVRuKo/oAMzGYnlhoO12/7rRqLVCcIVADNzETqIWbFrh?=
 =?us-ascii?Q?gljBGZJR200QsMycvGbQcuk3gYHcHolEyXKNKAL3CNtC0sHlNipm2nvWmemC?=
 =?us-ascii?Q?4LO3YuFt8Acq7vWnW2IzK80rHAiw4zV4Rj9gxCMNSHJrnEapIXi6hITR8Zh+?=
 =?us-ascii?Q?auCGvx3WiYvcvsuoDNsRCwjzgpdJTXOevIt5wpIpCsFQ7MXux6TPQRLisZEf?=
 =?us-ascii?Q?jB7P2ZH0GNuahLeYNVplQJ3ryvWOzjm6d4TRrLZBC2cjLGTSgg71WKlor808?=
 =?us-ascii?Q?v9GSDaqSmQojRZ9YxL1jYa0FgSVzk1nezn7e0TKElboO2eVGnxVIsf6ADn2D?=
 =?us-ascii?Q?UMMgLW2yJQ7cSFqU7qX47vcA9gebwkhKvWpv3GhbhvIaRm/e5bslkMVkEEZj?=
 =?us-ascii?Q?shElXOQlVJR4cJ9B6rS4dFqpQFKHsPu2Hoa9ttNOItUJRWq0/YUHIGefUBA5?=
 =?us-ascii?Q?YGbaubq1Ao75AMXax869hPXUfkQShdQrIRHxccNX9KBNK/AMYY8VziMw/Hff?=
 =?us-ascii?Q?SwnagKAaGelAVZ+oEEGitx5irXWjaYalSpSzkVDL4bGi28CR+8W+H5bQAtNb?=
 =?us-ascii?Q?rJJffbVh1zt5efAmbwsdq4HkTIppPywsp0iB+s7KNwSkuUIaAid28i0/pty5?=
 =?us-ascii?Q?Tm4foZdI2syHRF8w6Uo0T0L3fJI7JbWOli5i0cX+5ijN1Ts0/CeWcLYwRPKI?=
 =?us-ascii?Q?RSsGpC2ZSkt4arRLC06sUUofvdtXlQ9BE7+x4u5a9Ihk4vcYHnuMqFiXpoGs?=
 =?us-ascii?Q?mDuQblFHyHQ8fa4/QBbVnMqhz0hAxRh7UCZg5ip4KTdKk5wGo8bFN+bEI4Sp?=
 =?us-ascii?Q?/S0iIFD/pa2+9BpgGUeQptyzVgnJOUmXks33xx9JQTCgYHl0oqDKUI2pLWL6?=
 =?us-ascii?Q?pt2WIdbp7LIXFWgcxwB+F4GgY3aHltV9lZubceaCIZxssYe4aEtJYj5kAc+e?=
 =?us-ascii?Q?PTdXjSuUuZ1aDx1lOlwBMbWfmfwyhrLucHG9aUH97Ci6BmwJPt5XQKesViqo?=
 =?us-ascii?Q?SyosxCW+G0d/4D/+vrgGLlVFpFZ3ipuAHp+4wohF0ezk3hNQpINfcd9p74uD?=
 =?us-ascii?Q?b9HZFxhQxKBn0Ke3nl/7Vf2h9C7nPY1aM7H8Z6QmQ8Ijo7kNtJD39UHcX4wl?=
 =?us-ascii?Q?+hZSLDPYsoV2ZnoPYl/GX4wMsHMfZSFV0PiFMv44SHToVHzvKY9o/Vle5qWe?=
 =?us-ascii?Q?lhAeAiB05DqgDTv6whMfqn8qYTLfrVH6MkztDd5GVj/p0MH45SDxGon1biHp?=
 =?us-ascii?Q?apGVEQcXtq2MWaWMNx5tsi9JPYtTq/Ig7Dvc9+rGmsO/L97NbClKp/PWJiRH?=
 =?us-ascii?Q?PW+PsKRGk0U+5Zf50XN30fNMa7GhDXDqwKMgrxfGJohwJGVQbL0Vuu6zjsSi?=
 =?us-ascii?Q?Wkfc2cuorg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e585a56-9ade-476e-aba9-08dea4fab1ae
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5220.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:49:36.4785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICfSYl8zucCNZutfVWMSw5e+ggNRQVmS8muskfwFS3LZsAfOocYLA8sXz22aHKb83Ulg8BZYqLJAlZhYpwPaIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11720

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

