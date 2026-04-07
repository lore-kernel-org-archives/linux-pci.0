Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011048.outbound.protection.outlook.com [40.107.130.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF9F3AA1A7;
	Tue,  7 Apr 2026 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558539; cv=fail; b=s/abBxuRWEKYdJEd5KP6e71STQEHhXpvKaj8S9EcskRdg+lJFn6UHrvYs1t8lJLRUEavM+ph9GKm5iCcdedveYJitYck1koruW/EyXBfsRAoLjW9xkzPZ0Tqau0fsdY6VLQ6Fa+qdn5+8bg81vr5kKQYJPqYeIFv9Bb/qu8tQhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558539; c=relaxed/simple;
	bh=0LG0wnDQtq31bohPxFWd6pTieFN6w+tIqouAZJVkstA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=phxYUfeKFLH1Pf6rsr2CqOND5EcLD6FmqGiQXuc/Jq/8kddGFBD0iPkY62tOTyczyRLM4HuMVwtoizG+bJ3ZhkTMwZYgoqnDdPMRquNoowUWdtp3a6JdLb2JTlk80HQrHirHFLrtpi4H7LhBQmXLtahC1V+SqiOMc9/OmwHBxTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pyh+iWs9; arc=fail smtp.client-ip=40.107.130.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pyh+iWs9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw1/dTcLOe9kVH249rHLX1LUCVeGkNHZNm1h4WcBVW8pgseLzcFmw+ENNk1gVzHWbtEtzQ6HA/SbwRUIrzBqzt0apfVvdlbEkZ1dJrhAFfXmgjLg8hI4l1PPTQi7W18cAwPavRrLbAx8fY7DA32l9IucI+LGkWxOztqIbdEZbIZWj7QRKArcSxlVrH27DhvP6vgVtxaNvbWaQLSBF1Y0zwcj1kMh2QwMdfxXGYVzDOpeJ008ey0Osmtjh1OpYfWZpFLDXzMA5K8BNDhXVykfD5mRfwhn5wrxZfHWCs5TSWGEq80UPbzSOuSBSJAeAo4CKdUGGOTcP1s0dkmQsbhM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF6EorIMLg0ZX2v6dvKnfojtWyQYPU/dJPmHcNiwRIM=;
 b=ZZGfMgno3YJ+5CfGfv/7A6raZEDl/UetXD/45qaBhSE80oBnoz6O0Yf/GO2d3t1HEINNEwv3KtVwnl+K4Lb4o0vBsw17zlXJZFv5LPxKgsjnfJt3g3JAiKOwGnKLzBJelnOU+Y32U2F6gD7gA4CGAmU6zuDf6sxBcMIA9PWh+BRZgauz6CC4nBrFnVkPh5YIcUHywloPE3pp+9BvVHe5fNh/M0N12YsK0x2WRZP6jRHjAHskXYVjgtgIElRnJ3FCgQtJGe6vX0TO5lFcPUtsnyC/4yHM/uukpdFx4Z5cHkSaGIbVM1R2X9BUISK6bf/iObx/0RXfdUOSqRIoOi8t0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF6EorIMLg0ZX2v6dvKnfojtWyQYPU/dJPmHcNiwRIM=;
 b=Pyh+iWs9pn0QqS3sunYjgV3PcEelJitQfY/PVcNP0CuBC90OHc7RILPgrL1JmkrwEuXt8/KqZGeBdS1GLRwh/cTL6hq5jGfwXoYH9yoUuM4zLSFtvjPkK7Y0YmK0L9EvTkNsSt8L4bVdSJ6Bfu2M4lULxyAUxdpAWmRkKq+Na9dPiU8XHJydh2kw4kZqXHnghDRR4BgiMa+e9KTUq6QpxVwq51Ge8pbuM6Nv5eZ+OdUJQzSJ8SpvQkOLgpqKo1+sAiy6mLf/C98uhMB7X5k9XgSulATbJb9Ky/lBAuamFD0VAyLu5yWsf6RCa9J8MF9NaHP1Zh62sVB7r3fwkT42Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB8281.eurprd04.prod.outlook.com
 (2603:10a6:10:25f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:42:09 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:42:09 +0000
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
Subject: [PATCH V11 04/12] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Tue,  7 Apr 2026 18:41:46 +0800
Message-Id: <20260407104154.2842132-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260407104154.2842132-1-sherry.sun@nxp.com>
References: <20260407104154.2842132-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0060.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0465af-47cd-40f4-9365-08de949251b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b1PB1FAMcq+IwV37GgDif4+ZOAy9vtDd++JCTsLxmP4yJZIc/XhChntFEunCTFHByHwXkUq95EUlf+RfKeYJyn/YGYAEHiu4te4F8XXKetWRvJNIAikKkbahr6fPp4vDj4zc4hsin6W125Wb+oNwn7nBmCChuUr94BlftuaW4iaWqlLR3zz85HthfP2tl0hxyV3qrUCwVBGnR4ymc89kexAvUlBJt6Irpuunyn9O7pVYjuVGaYNi630JbLWwoFutPeSqXDjndffM9FrRmdYI8pR80Y3HIrPvqpIvoqfC/0uzi1uOAHBPS6mQ0HNa450M+wRN4n+b41LvX3ermh3uVqWdbLG0zkwIIpUGwohQkW7M6ANlvsfc6zjglbCfH0W0N4TF5bAl/JOHzOgN28PxXqAzdWY7u4jUM1Gc10wvytjJt86DN8sfSmG00ZOVztZSIbRgeU0PFiUzuXjvxoWafKq+HCn4bP5bn1teX0+mMU4OjmfgfWFsF2ruR+Uy2G1laOXMFAfy49ajeINI7qlKyI/cKXE3eb6KXIruFCupHAS++i9DDL5nWcItK0LlrpZf5RGRxBq8mvlVYaipBoXLKwE/yrA9IiLvpX/Wc9Zc3ns1Xw0nGSWW42rPAUBgM6bZt+7CStxvntOitAUCP4cwI9jVdsr7LugD/QU7Pn25lXkOo/ivuvljWcflkvi0F9ym9wVVINi2UtkSZPTXfotc//tSeD4NfAg6dzXG2K8j3jlZ1wHQnS1l5qZOJ2x7ib0lI+m5WTEA2nvw7Eovq+yT1y34y+nzjb5eZBLNXpE4gamH3tl2iE2ixVX1ddjC9k3h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e6QHyV5+vlfc1Ik8ITJjPFmXAXtqzYPM/VSmthbNNT43fm6S1rb1qbfq6iYe?=
 =?us-ascii?Q?lnmkNxez/0hmPwvYLn8H3SrL04Hq1MIyvz83ydk6WpU/6Pveu1m7CnqHymyn?=
 =?us-ascii?Q?Bk8HwbAU/cwQRvHBCWMWytFQDXQlL3H4HECApwqk3E4+8XAve1vwrGZyKBP0?=
 =?us-ascii?Q?/7bL6XcIYdSrZinoapFprYX5hMq3WDWqtkXNeEi6i0grV+OsgluBIPz6Arf1?=
 =?us-ascii?Q?gT6Jku8m/t0+xCKhSLJkXB+Y0FhwCiFjQkeN8pbQ7QI4UCoETq0t38+dySlO?=
 =?us-ascii?Q?Jjdf+bzhPuwpoyi5LO/0dWxPrzuD/NC/hztt/N09aGPM+50cc68XHtEmmFyD?=
 =?us-ascii?Q?jFnQ6TDtyLhviHOsWLLLdQwVSLIX0xodVLJAMGuCHlRCOJZJLNOobe4zcdg9?=
 =?us-ascii?Q?UiY2IRzVvoQK8jG9tk25l1Oj03oL4o56jP39PMX4nZnp6Nlxuhjt9yDC2Rkf?=
 =?us-ascii?Q?Ius+rJFyANhOciNyR9baDRjT8LZF8S5BUI3UnQUoTdnF5bZn3S2fTL1XL3Fa?=
 =?us-ascii?Q?DmoSSEEcNhGhWTrPbNE0sCAIkfhUnhVBagPx0BLamZ3spA9nop4jWL50ze7n?=
 =?us-ascii?Q?gbTn7oJcP1jF9eZbXgk4j5yBblqFfOs+19GctVAccDpljdp5vKPNidwKc9xX?=
 =?us-ascii?Q?MS1pckNVsguLkDZG5eOl5eCTibUDL6JpFkSbFf0l30P21l+k8/OKAz0+wVl3?=
 =?us-ascii?Q?dXNQ+3hgP9GoAR93PQSUTDWqXQ4kElahnI+iEqLTuzjU0vk1ld5IW3oYGgV4?=
 =?us-ascii?Q?unbTmJtKdRGHKJRh7BfPlVCjbd1bjGZXTlku1ZDSt1vNNcwHCy2jc/OqdTsz?=
 =?us-ascii?Q?2JaT4pBuLv4FwGoWHxKDJBPbV8CHrVrwGEtG29zDQgIhw/64lL5ErlKNZa5P?=
 =?us-ascii?Q?kOcJlB5XYvq3wtSorWYm0foAUOlYlTHVz8dg/UX8wvFrGykkr6hrhY8cO79x?=
 =?us-ascii?Q?nMgvnX/xvSwy+zxhu3dyNDr4cWrE5pGQ6T97TenkDl3HJW+vxL0d6eX+j+eV?=
 =?us-ascii?Q?TMQdV5qWIk3lHPcuEfmIy0m2EW0cIHf8/5DnyhqI5Qp8wz5Wfs10P/b+ybbe?=
 =?us-ascii?Q?5OWi7O9ByxosfTfoFe5BxTPZtQ7WBuG04BP9kxeCPanLUEe9MSXS+tEPC+aV?=
 =?us-ascii?Q?fGyRuEvvA6fpAufLqrQwkk5PKb1j3o0cOG7Chm7y4kfPvTlsxmIOzDnCNJBC?=
 =?us-ascii?Q?DoHNwVhOfVW99Gr5er3U4K13mMLb9638qvuwa8q6dGoVJfS4cf11njFX2xas?=
 =?us-ascii?Q?VwrRG0RvvkUOsOyAuxTcdnXll/2tOmuJcL9cHq3IyJ0LqUGxk+LV4Zd7QL/B?=
 =?us-ascii?Q?eo+w8iWWpPJWB1YVaO3NbM9gcC1WYUR/QxijQXxNwJ1osLsqKQzppCMIJkyt?=
 =?us-ascii?Q?xia7G8WwibKHQNQcb0JaDbtiRfrzv++lTNGfbjpXZgNhsB0lPuw5ZCwy/+/q?=
 =?us-ascii?Q?Mus6m5VMXM+Hs6jwAzXht84cgQbsGMNWE1NbtbpUPiyhwLiyyM6aNKIwPjJe?=
 =?us-ascii?Q?gJ24rc3lgmDUvv473H5gg7MZLcbOhPaqvN+hS+jkIaxj7IsjGDksdEafuGX1?=
 =?us-ascii?Q?rc/9+YapmyrQLR877OU3Zpx40TArK72uPfJHBpWxHQWIwtCiRl43QJEKDl1S?=
 =?us-ascii?Q?T6XumQbOX7NDpjZLekHxCfZcViQPkYeLkhUEg4J/vWtuA5w/W5Z684U7Tach?=
 =?us-ascii?Q?46b3uqThFYyzkENgF4HF1OvITFGvXcxM+Tc3HJziJ85lKXEipS3zseTaKiXM?=
 =?us-ascii?Q?7nIMfAvq3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0465af-47cd-40f4-9365-08de949251b6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:42:09.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymQogKdHc+/xRWebAzxIIfN0J+KuXyORus367eeJ7ptIwPFRsZp5lPKxnGVO5leOvqHedVBDGEnJ71NRoEESzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

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
 drivers/pci/controller/dwc/pci-imx6.c | 75 +++++++++++++++++++++------
 1 file changed, 60 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d99da7e42590..dd8f9c0fcec4 100644
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
@@ -1233,13 +1259,22 @@ static void imx_pcie_vpcie_aux_disable(void *data)
 
 static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
 {
-	if (assert) {
-		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
-	} else {
-		if (imx_pcie->reset_gpiod) {
-			msleep(PCIE_T_PVPERL_MS);
-			gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
-			msleep(PCIE_RESET_CONFIG_WAIT_MS);
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct pci_host_bridge *bridge = pci->pp.bridge;
+	struct pci_host_port *port;
+
+	if (!bridge)
+		return;
+
+	list_for_each_entry(port, &bridge->ports, list) {
+		if (assert) {
+			gpiod_direction_output(port->reset, 1);
+		} else {
+			if (port->reset) {
+				msleep(PCIE_T_PVPERL_MS);
+				gpiod_direction_output(port->reset, 0);
+				msleep(PCIE_RESET_CONFIG_WAIT_MS);
+			}
 		}
 	}
 }
@@ -1249,8 +1284,25 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -1704,13 +1756,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
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

