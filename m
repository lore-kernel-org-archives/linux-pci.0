Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE013A6B99;
	Thu, 16 Apr 2026 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338002; cv=fail; b=tdY6zf8frH+Jj6zQxC86aO/NsG/TVpsK93tWJnNFViB30nl72jz6EdPNcfwifuQzwrBduqPu1rv3BFBvOzDepPehRtVrM6ujez1no81KnfOzv+ZAnwxNqktVTykaGuudvl5uAVE9t5ztOx7hD3A+qdnQzrbQU9i5HHpCOFaiaOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338002; c=relaxed/simple;
	bh=K8aB5A/3Ep9EzHaAZm3fr0XDQcyLq5IB3AuYc/DFGSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iA6jCWcrVm7I5WDEqT6ZAcjbnpuMYh76cbveXr/nKupDjczZnMPo8rL16Y574JrngNr8LxZqe7d4FkKzuRY6xtt/FKKn59AgGomHr3+e2H3bv3K93RBZSv4ECDz3Gs7K9lw/Ibi9gyseSfV8TIulgx93XMnKuslmOsaV8U4ZXzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k6W5Hfa7; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k6W5Hfa7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9IFScfsLnbXmXdK7fVTzk1nzAkMb2Mmt03wgf59bmXX/y4irUua34BmSpkWFr4LSsYYikv2eNxndJI3anmNuX3dcaOyg3gfe/TcoekTfTMP9zyBn/Q0ZtOVISW+ZQtW1wA764KsBOu6iEGjZDti2ZIcXq5feW36A7vnHpfgHnM8A7a1Kc43o1I1rmkZ7qqrOoLXO+a86TZD2gYgPsu/F9Sa0+Xp/upNXzMv/wx+xAhJQT5+lgSdEQXmb8QQiLfqMKvjkez3/lbyON5VsP1upIcb1YddHQzCfQFuiCjXQPBSAKHTofLD96hK48No+9r0EeErJoTY1N/F31c22DsCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vQuQLBhqKW4EYziATyrg2RIw/rygIn6Vl3UTAGVbuM=;
 b=J+itNIYLnxWrO6UNLYIbp89v5dSg0yvP+NH9hV2hqa7+eh/NPJ2UrknXvmQ/57S43TYeXD696UyO5pxsT0DYm2qI4Oq/q/ZxK9Nvv7Ynz8n+rJz02O8jOcM+oD7Wr9eZMqhTi7X+zt/8yE0ARau01SHtXBgXOYCbz2h90dFJiH023fY4HicOFpvbwdZSXlARNe+XOgT+fVGj3wMzqh0ZWf89pBHKSNse+jRokkCCx5sUCzP371QDDuv85MGlaVcn1mS0cWFeCLlVd2hOOdHguN28Q+YOtwsFnIFlix8iS8Zjn7hq/8a29fE8Z2NoKLp/DjGTuLDovjlNEVyK3cHxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vQuQLBhqKW4EYziATyrg2RIw/rygIn6Vl3UTAGVbuM=;
 b=k6W5Hfa7q627F3CBqfgouiBXXuscqF/6chrM3h7J9uq3zq8dX6vqtAwb2+0NuwUStMPcz3Wm4RRf16UHn5QNp6EH5UJ8+i/nS5KCTJ/RFGRBoWbFckiVN2pqZ4LMkXKygImU9f8cA0KIJr5pFMfNZaVJUy5T8HT1Ade2TyXOfNRt1fUOVMLLlT9KRq3Ef+JO5k65m4oRVnKDeMlBluP/X0z7J4oGwN+ftXmey4VctA0yhr349L2PY5kUNpS5ZStzaysbTKJDdugMqjhURrXFb1AO/4fB+wit077P5eGK4ARXa2XMpa9sh3m66pDlJ4h3hEtZ+ZmpM2ukxDGiU+JTjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB7668.eurprd04.prod.outlook.com
 (2603:10a6:20b:2dd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 11:13:17 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 11:13:17 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V13 04/12] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Thu, 16 Apr 2026 19:14:14 +0800
Message-Id: <20260416111422.183860-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260416111422.183860-1-sherry.sun@nxp.com>
References: <20260416111422.183860-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 5928859e-f937-4aef-bf23-08de9ba928ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5tbM9bvExMu2gMivMy2pNt9v9wBpARWMBSTW5uHJ599ymgOET5W07QZtpqP/UlyHoALRd3kmtg7X9j0nriEs0xyfId2p3Fe1I6lm+2dUtP0B1LGzKjZQYp6krf9kGzMXw9C2RUpGAxIa/RAURNwW497EWWEham8rKebhJY/6OKGkB2N1E87WHc0t9S5wxk4d7OLSsir9lAsx69Lmw/TpHPy3+6g60pHkGtWv2zdimWuGT3gTvM+3RkFUZfAtnlBQJfhlxzf+BB/e43lKjar75/QIiYat1WK4oLl5fl0Dt2YA5606hmkgto/+vogaK32XKJ9ZHWXojfKfPcHy80oCNJnG08bCwjLuvfHEni1OknB0HV7ChDK3vvDyrVx54zYlbrxpsyacUj9nFl5nUXtULGGV/51RlhvH1qyAELleB1QEye4z2gS7GfuSHcLtSRu1IKd77/Igy14QfHVs+p8jSlYF+Z2kZpy33M/BMEYvGXAq2dQAqH2D55EdU3/DDejd+QRGj/OAoi5WDAIxNfBEtKZ9fyCXSKO1QTK6YNqlPnBK4R+f7yBfQuZwTOD61cfHhBQiat0IYm1h/NJ/CroAi/kd8LK6sBV16lALIXFIIglf6XmmFfA3a9yidQ4mSPrB9zr1vdb6/tYrDyf29lh1VH2LUtZIo/GBSVgaNEzqYAWeRw+Yb9qQvWVhe/VKXg4porFQ97DZtMiOPCpv7XUMJ8Jj2TajdBqMvlbPeZN6U838cDtG9kjIqRSVdLAP2yUJsGfBSZtsIEvu6Aw8J/8j1t7Z0glsSZZph9Bkwb9da4Azwxt0quRXpdXxKQjhqBsE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4/I7NzrTzzepn4q/jGYOIHNzGQfiMz07kBKZHXP+yre5n8cqgyNqH4qmifAl?=
 =?us-ascii?Q?qX5dki/1TLAT2foxiinOgcRyA1nz25HMiw0GfPFAerpHi1g7zjJqqj4MWV/0?=
 =?us-ascii?Q?vgfK0B4ChIIIm31JtxZQ3hOpE0kKbRYEJ04EK8ePW0h47QGX4KELmEmRjA0V?=
 =?us-ascii?Q?au2ktSnIuiWAeOanK6GjgSoxrdYvomxvydJirQaI8ufV26pQM6Nf2+O47Fcp?=
 =?us-ascii?Q?G9vZK3rLkJsWGTNM8kBBmV6baMXAakDrVpN8Q7hEyZzu/ywmAyWNandq6g/K?=
 =?us-ascii?Q?8DSdKB0xfuQ3TDP0KFFNXcDP7e7rNjBiVuscAGb6ST2GpHMmRR+mIJs8U3nx?=
 =?us-ascii?Q?I2Gb7HR55uTklROtkrBZEpPYPt/VYFCd1sBonAWAELpoeq0pKHwoQK6g4mIr?=
 =?us-ascii?Q?8tNQawobRYzm1kyNqRcFbVHtksC+f9KTPitT7szjiNztj7556Yl+jVQRapvM?=
 =?us-ascii?Q?Fit6tWD0/U65lLneGobRsiS2ahSRUSJ8aNhjzVRdPOJlzlUXo/QRk7bYgBSo?=
 =?us-ascii?Q?lhmhjNDgkhy0T3YWiA02k78owxeIhE0L1XU7MwDG4okkZ5rgiVfHm0cEBujx?=
 =?us-ascii?Q?F8QFyOQ+QNV+cI3Z8unsWF/STquOjCEb7+brC0YbUkclT+Dhgwwf2RSX42qy?=
 =?us-ascii?Q?ADadOHYxC0b/bN3AL3v7NnNX3UUpAVKDQr1dakR92Q4Fb2KzPax/Uhn+9lya?=
 =?us-ascii?Q?UNJX2tvqMD/CqlDIy7Y3ks20EuCUy8fMTggJicV87d4WoyhmcMuZq76A2w2+?=
 =?us-ascii?Q?gYpPs/d2Y5sPcMNkYijBjLQnHFNz1DTwmSYaYMUpu3dCUV3I92uGfA+pcR55?=
 =?us-ascii?Q?869j57V3WBOl2qJYZXUx6AC3vzr00UqXgMBBPt7nh37lN9JZ7o9BuWGWq5NW?=
 =?us-ascii?Q?K4spf+6uSnqescnpkhs/fSkggU96eeUEigb4JO0rLBoTHjVVDP7myqr9aokO?=
 =?us-ascii?Q?Logean8vO2sKLlxuvmzFqZF4ubCeFZSy0UJ2FWWOQ2rjs2STlxh5YYYpSelH?=
 =?us-ascii?Q?hmXY4WxujTy1L1aWDdNasQPv5nDLJSQ2nLFVBrGG5ghJFgp/FEMvglcP3yhG?=
 =?us-ascii?Q?3JM32ga6nCMxClqoKECm45aamLonK9kTf/8lndOVMU2r8zVhWDaMz5aVlawT?=
 =?us-ascii?Q?PJLGbbih9sLEwyKZe5fPIn3vnzEvrJg8fj3myUmIAUB1aRWYLyjTwCViYn/6?=
 =?us-ascii?Q?yHuwfN1bGNey9QZW7X29yAwaSYsYfq/3a+Dkw0jJrHerOfJrTC70GErzs4CS?=
 =?us-ascii?Q?uKhkYRIhUU07i1Pvz1nK6CwFBaEDBMQGPFR82m0OOwQyrNTSPDNzukOhWcCn?=
 =?us-ascii?Q?/mIyIG8da8DW4l22n3ZfEGnw7FUVwUtEotkRJnrHf1MTvWf9EnmyR6xwNljv?=
 =?us-ascii?Q?FkwPCJiTGcsh9GaTJoMAUSTQjiqkiwBCk7nxQ+ng/KWTEtLwgviSVCOl1ZVl?=
 =?us-ascii?Q?ppjyZ0YV+0ZtnBejoA6fjnh1LwtUy+dDtLDGbh4w8SLMckajbUqwlmH+ROPt?=
 =?us-ascii?Q?s+R6C8sCg5trjTlw9IRfU7ZFPiGnYWZTOPN4l78iWhWb53Gu5+drT5UGS83v?=
 =?us-ascii?Q?s1uZ6jPRDlcVvk2decLqjxHdZQVUASFKtV+L3afQb9AvWjsxk/J8ynDwyUg6?=
 =?us-ascii?Q?87djhdb6OW2Dy6KKCNVX2h6hnEs9hSrm5J0INJ+tYJkKtbkf8BN9P1WbF9fq?=
 =?us-ascii?Q?5bF23AqI79/nx4lP3V9i5nOTnSVY5EOsHVhVvfGHtKL/GglDkqcjUL3RE6IA?=
 =?us-ascii?Q?1Pzle/aQqg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5928859e-f937-4aef-bf23-08de9ba928ee
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:13:17.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYlAa78Y41l6WYYWTvDn+z5kF7Sfd1lB5fGuwh8HZEw6BpbbR/u+3eKmuVJBVZV+Cw3ZVrM9qa1AI/UbgY2eYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7668

The current DT binding for pci-imx6 specifies the 'reset-gpios' property
in the host bridge node. However, the PERST# signal logically belongs to
individual Root Ports rather than the host bridge itself. This becomes
important when supporting PCIe KeyE connector and PCI power control
framework for pci-imx6 driver, which requires properties to be specified
in Root Port nodes.

Add support for parsing 'reset-gpios' from Root Port child nodes using
the common helper pci_host_common_parse_ports(), and update the reset
GPIO handling to use the parsed port list from bridge->ports. To
maintain DT backwards compatibility, fallback to the legacy method of
parsing the host bridge node if the reset property is not present in the
Root Port node.

Since now the reset GPIO is obtained with GPIOD_ASIS flag, it may be in
input mode, using gpiod_direction_output() instead of
gpiod_set_value_cansleep() to ensure the reset GPIO is properly
configured as output before setting its value.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 71 +++++++++++++++++++++------
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 735127ed1455..ec0b1690a41e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -152,7 +153,6 @@ struct imx_lut_data {
 
 struct imx_pcie {
 	struct dw_pcie		*pci;
-	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
 	bool			supports_clkreq;
@@ -1224,6 +1224,32 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
 	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
 }
 
+static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	struct pci_host_bridge *bridge = pcie->pci->pp.bridge;
+	struct pci_host_port *port;
+	struct gpio_desc *reset;
+
+	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	if (!reset)
+		return 0;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &bridge->ports);
+
+	return devm_add_action_or_reset(dev, pci_host_common_delete_ports,
+					&bridge->ports);
+}
+
 static void imx_pcie_vpcie_aux_disable(void *data)
 {
 	struct regulator *vpcie_aux = data;
@@ -1233,14 +1259,21 @@ static void imx_pcie_vpcie_aux_disable(void *data)
 
 static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
 {
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct pci_host_bridge *bridge = pci->pp.bridge;
+	struct pci_host_port *port;
+
+	if (!bridge || list_empty(&bridge->ports))
+		return;
+
 	if (assert) {
-		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
+		list_for_each_entry(port, &bridge->ports, list)
+			gpiod_direction_output(port->reset, 1);
 	} else {
-		if (imx_pcie->reset_gpiod) {
-			msleep(PCIE_T_PVPERL_MS);
-			gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
-			msleep(PCIE_RESET_CONFIG_WAIT_MS);
-		}
+		mdelay(PCIE_T_PVPERL_MS);
+		list_for_each_entry(port, &bridge->ports, list)
+			gpiod_direction_output(port->reset, 0);
+		mdelay(PCIE_RESET_CONFIG_WAIT_MS);
 	}
 }
 
@@ -1249,8 +1282,25 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+	struct pci_host_bridge *bridge = pp->bridge;
 	int ret;
 
+	if (bridge && list_empty(&bridge->ports)) {
+		/* Parse Root Port nodes if present */
+		ret = pci_host_common_parse_ports(dev, bridge);
+		if (ret) {
+			if (ret != -ENOENT) {
+				dev_err(dev, "Failed to parse Root Port nodes: %d\n", ret);
+				return ret;
+			}
+
+			/* Fallback to legacy binding for DT backwards compatibility */
+			ret = imx_pcie_parse_legacy_binding(imx_pcie);
+			if (ret)
+				return ret;
+		}
+	}
+
 	imx_pcie_assert_perst(imx_pcie, true);
 
 	/* Keep 3.3Vaux supply enabled for the entire PCIe controller lifecycle */
@@ -1704,13 +1754,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx_pcie->phy_base);
 	}
 
-	/* Fetch GPIOs */
-	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(imx_pcie->reset_gpiod))
-		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
-				     "unable to get reset gpio\n");
-	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
-
 	/* Fetch clocks */
 	imx_pcie->num_clks = devm_clk_bulk_get_all(dev, &imx_pcie->clks);
 	if (imx_pcie->num_clks < 0)
-- 
2.37.1

