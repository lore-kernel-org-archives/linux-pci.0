Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90C307AC7;
	Tue, 10 Mar 2026 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107628; cv=fail; b=EWoJDnbJiupMA/JOPjI3NJn4QyU4PkYWT9zxYRdaaAHSYDUFUncFzKNaWY8qQQ0GqDdfws9Lp4PcsCEpzGia4gT3yJITtxUrfCvCdTM9WUP7IS91riwo4oGmh/DESE15tJo4Cr+Z9st9cmz8e9chrTxML6K01WQRWhYGxHRmGv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107628; c=relaxed/simple;
	bh=pW8Z6D8sYK3yIcLydDGqsZJOOVdE0pZ0f9lneRfLXwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SE1dXWeysWwZHEIRvGyThjTDp6tragHsv7YiHVe3Yq05XYTOaifUSdEzLpwJKMqaenLriDF63raDkzAsqddeOj11hOFuJKSqqiRneEYBWtZHgGpcFN6QdRbt2Jr4JWYhGe3QzM5kzgdkhQ4gmCSz1xAAoZXWEFdcGr21xfHdCTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BpEux9Nf; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BpEux9Nf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phdTvLgNkRF1oxaGVjcDUNXFDagWA88nFxs626gjCtqQsj09G7ienXe5dwQPmH0GOhOKYXyEdj4WPuqZoLLPklq3CsF20Xq9hiDXHxFFw1IbBJbdT1VCUEaGBmP2/3VUpKKYr/Top9LM66KciyVyb6MoD5oBVGz8/CJyKbS9nhEBdjtDH4G06kby1WNtbCCFMkg56uUZJ61w2ylTW03LENpoS1CF6lk78FjdJusyakBCuj+ePy48zXAdIIgtLdVw3VPe4Z2Ig7griDENZa59HzWPmzz3agnhk9920tbjIGq0DBvZUYSLZcGthThrBQRR24bV1r9PWfahMxyAyZ/yxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyrFWfoCY5n25XkB5LEBxP1a0OmHUqa/h4WW6x0a0jU=;
 b=Mq0BfOFLwbHKx+D4/fWmoO/E96TftSMgO25wpadNDNDeh6jP20nSO/sY3oxYmFNqeluS5TdsF28bN8l2hxFU1BoejGqF+1Lh6GZfgzoc9Rg1mKj0zCnww4dsFW+/yAw/tlfnQ4QWQG1fXsz9hIQEj4lHeQ9eGPQu2TDKOL1zho0S7wxhyFTuaStPPpZnrb9of4bEAxPZGycARjit+gy9Fs+FVfFgzOixRQruQGD1tsj5w9hkI3994+S6e5cZ/dnmqgCBNZI0mlcnSgWm9DLn3ClXoAqQoViircrAUbNm0cWXj2vInzcOxxGl0cMGlVXG1Ywev1ANpjYK4bJZOKIwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyrFWfoCY5n25XkB5LEBxP1a0OmHUqa/h4WW6x0a0jU=;
 b=BpEux9NfRGwNNCg+eQoX2ajiqFIRNVUMbaPvZHFYl+2GYLTiaqEEDkkSPlvhBHz39YHy7mPpfI5qEe+5Z9aoHXTLaLX21PWBpEEaGQt+7W86H2NxxLht0eGPG0k/f+dEIY0C4vkmsuIGEAUN7dAvBLU+7kWPLt1rli/LTvGqipeiRgTGj9ULnx6wrCbCXt9V98g6CmcWacHsQb3iXAyGjKPnXTIWvgQqzE03dUFfBHyV5la8gL5gHzALDGUfMkx+vVePlosIOfKq48v6Lx24D0EjlK9HpcCZ9TNJYW7rj7MxnE/QQ2wAwJR5invnRSYr9crlW1MWW+0J18B/nUVIaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8889.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 01:53:37 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 01:53:37 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 05/13] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Tue, 10 Mar 2026 09:54:18 +0800
Message-Id: <20260310015426.365675-6-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310015426.365675-1-sherry.sun@nxp.com>
References: <20260310015426.365675-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 61db40c5-70ee-4002-8a29-08de7e47d8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	UjioRz10GIMRgkKIcd9xfvX+2meG5P85TSxn8FzZ8+6Hn0UNC1/C8g1Zr/YQYBRVXzn3y0HyYvvY/aVCkikkilm7CW5+zSNrfYncxyFkK0FNn8Hj/n9YKOQM0pEnkxPLipiOvXumC6t1AHkQxKTn8NHQ2IPt+B7sE5VdlKSNoMBqH6SwIeC3gTHeKN1iJl9YOvJdVRo9OpEJGnKSRjH11DZShtTtvKqp0RvIq49yWn314ksFnWo5iyNeHceDpq0TbL1RnLDWEEQ+8zs4AotsPkbbntRfCqsYUq6DnxmaIg3W2IQ1qzEcIqmhm1AvYM0j4kNQBd+WRP5J6gmV5zXjiqFp+RZaW1egYK7S6Th9BpISOCIH/VK16VBP12MywDHNe+uMTVUoXLCBakIaG+6TUoGqDgK8VRUIcNXNzbUqxYJqMiVqtmd8TOgghT54gzprDaeZeElG92tht4DzuGeh0QuzCJC39YP3s0uOTI5VjTDdt3PM0aHMOinpcz4m41L+UgkzhNpm/xaWYztfGMNKiIxAovDs+Tu2sRa/U6fqZLbT71PSvbgF41JsH2zjtS91+6oMbIwRzFeK9M6+qO7S+GDnHasKFkrEb6QtHjZN9xxPZ7mBEsuSRiNf1jMvvZbe7LIPbDUKzNPXQah22Z3hwv0ajB8NTqen+TRCZDcn+d+s8czzc7DXy86/oGHhEuqKtYpGvvY/FYXiYzOkcWEPZ5vSkkz4JxEFBpKGrOIaN80ZZ0rrCqSuasBmiQZBLIVYvhhlyTCvDGc7fnxoe/zgUGcORnDRPctmh3vV1g2AZpvsL5eLt/CgI4yYFmDdXSnB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IZ8j8rTqh0Z/MsUus1FHv20VJVscOWYInv4t3b0Gv/ZNOXX83MaRoC8xOW2V?=
 =?us-ascii?Q?25OKm0ej1yNRVTzh+MVRQf2HSel+8ooSiImaUeBxlpnPgjlzDnKmeJCUBET9?=
 =?us-ascii?Q?oqW51feqKx+xvhzGC+8iZMynv64TJo+fFLdYavGcXNPR5gPKkYFVkuUPbYJc?=
 =?us-ascii?Q?nEdYsZ2N+Fj2tov7v0455M0HI3EkDKXK0HDDxOjJ8iqaX6wCDJ5/t7mqicLL?=
 =?us-ascii?Q?Z1i3UyK/mmaYN/RzVeeBYnkN6hHBU5TKVpqiu/0MUMSBcH4WGieXnOg8XYDd?=
 =?us-ascii?Q?QlNvtNS6PG8KKkegGOJJ20Hg25Diz6sLJf/wr3LQqGCywhtNlZdngpgUEG5+?=
 =?us-ascii?Q?yKPAPuVHu/1TWEzH27WvnYNFGNaMYkaEzRPN0F7+X/6rykXUWKlK/z47GO18?=
 =?us-ascii?Q?rf0hbX+J2y7b9wWaJVu1qV/0gNkaa+pIVXERkZB2Xp0Rr4QYg0s2l7aBBAPF?=
 =?us-ascii?Q?BGfkpENzd6H//BY0gOlPhNSbfrinGo0LZ0jQEShQoRIgPJ6djHw8qGCEwYLn?=
 =?us-ascii?Q?CAilX0uSGPyLknu0NLPTui9GcGnB/wlvLRXRSfyFHu7xYLShWiWtKPoITP5V?=
 =?us-ascii?Q?idMVFg866cx4j9a+IUvLxiKbim32aymyACiPlljE77eXqJgwV9p5V+MgbpV3?=
 =?us-ascii?Q?cNnI/wAMp4jgGLFkA7o9wIE18f+cMdByxo2Zw1cbowig38ofKEnmsQN20jS/?=
 =?us-ascii?Q?lE0c1/cfeaeYfrjsPKMUOyMUDKAz6XyMxvn0EmIzDCBsF+XlWac5qOSAV7T5?=
 =?us-ascii?Q?OBwm5DToyMvjYMqrz4TtWrxmPALPqvrWTp4JXF9gXWfp9ycTE6CnfR9i9M+U?=
 =?us-ascii?Q?COAV+K5VIbCkoiMfxSK2d+Avh5Xr1uV3T+dwPR2geJTyy/uTmX/sI4ymL431?=
 =?us-ascii?Q?W6bUbeeI8vsdBqPz7DdeFlMLNbKG6zHNM1+1uxn0lWK2KfLG+4yIfn8y8A4A?=
 =?us-ascii?Q?ce3ToufIb85P/0wB1g8adLKUD4DDMe6QCREyFnlpjAPg409smDX61bbDplD1?=
 =?us-ascii?Q?O3+n+YJ0c0hNiBcqodSXHeUoJnZwjy9rB7r95GoQbmQfjuVG+OMXftLt/Eia?=
 =?us-ascii?Q?JXyuPGExQ6kWwGFqoy09lY8n4hsiEO8fjPwaENYNT8wC+wjF71qyzufQffBw?=
 =?us-ascii?Q?q5vHOmt5HvZfaqCTQ71rEtle3LitJy9lx92J/llw27G27dORSAh/VJ0OxpoG?=
 =?us-ascii?Q?jFD8E/Pp2pO6QVNbyoOySuaGL6Uf5XcLdUVKqqCxE45jY6JqEQm8LaKMCa1O?=
 =?us-ascii?Q?SXBjx69ZwGwvuXg/PZyJOxqA9huEX4vhP80XXnwZ2UzwcrJgXF+73ZIypCSy?=
 =?us-ascii?Q?h3uCDDdEsxjxDWWEIUr2/yM/aL4Vk2MqowwtxC2+zq1fUMb+ip+EyyePRnNR?=
 =?us-ascii?Q?v0luiLqhzxj49V5vR57hfr6kw3PN3Bsp0oMPXZi4WBNwsiP1WmVvEsep/WD8?=
 =?us-ascii?Q?aQkVio1tsKfmJ3Y1TAkRiclJkGGiVXHxsEwodI5bfEgTMswjYApBlN/mLvxH?=
 =?us-ascii?Q?0wNQtu7U40EYHmJM/cQqWRDsW+XV5Gz9D2emNcFVQfZzxDQKNcE3c6/sbCrB?=
 =?us-ascii?Q?zL5RTuepuCKFB19sPp1623JsnwVNKncuo7fsgE0i4xPx9KFE8UN06EUds1o0?=
 =?us-ascii?Q?Y1KZVesFSGumsMscF0ykh2a+ha/m7YtkP0IkIdd5aWqPnx1f0kmckkSa3+Kx?=
 =?us-ascii?Q?lc2aYrg+b3TTsIqOnjfbODKa4iEzDlz2H/8a9c0gJrgWjkCWgefa8kFTgheg?=
 =?us-ascii?Q?JSLky6e/tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61db40c5-70ee-4002-8a29-08de7e47d8ac
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:53:37.6912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nvmxTcJb0UrDq5TXDJc+6tAckWE9Etx/yOvo1F1BQxDcgcJlss3SdWWUlNVbbzVs53SXDt3erWZqBCRuKIL1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8889

The current DT binding for pci-imx6 specifies the 'reset-gpios' property
in the host bridge node. However, the PERST# signal logically belongs to
individual Root Ports rather than the host bridge itself. This becomes
important when supporting PCIe KeyE connector and PCI power control
framework for pci-imx6 driver, which requires properties to be specified
in Root Port nodes.

With the common Root Port parsing now handled in dw_pcie_host_init(),
update the reset GPIO handling to use the parsed port list from
bridge->ports. To maintain DT backwards compatibility, fallback to the
legacy method of parsing the host bridge node if the reset property is
not present in the Root Port node (indicated by an empty ports list).

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 74 +++++++++++++++++++++------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index fbaad35e43a9..26de892b48e4 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -150,7 +151,6 @@ struct imx_lut_data {
 
 struct imx_pcie {
 	struct dw_pcie		*pci;
-	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
 	bool			supports_clkreq;
@@ -1222,6 +1222,44 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
 	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
 }
 
+static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	struct pci_host_bridge *bridge = pcie->pci->pp.bridge;
+	struct pci_host_port *port;
+	struct gpio_desc *reset;
+
+	if (!bridge) {
+		dev_err(dev, "Bridge not allocated yet\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * For DT backward compatibility: if no Root Port nodes were parsed
+	 * (indicated by empty ports list), parse reset-gpios from the host
+	 * bridge node.
+	 */
+	if (!list_empty(&bridge->ports))
+		return 0;
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
+	return 0;
+}
+
 static void imx_pcie_vpcie_aux_disable(void *data)
 {
 	struct regulator *vpcie_aux = data;
@@ -1231,13 +1269,22 @@ static void imx_pcie_vpcie_aux_disable(void *data)
 
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
+			gpiod_set_value_cansleep(port->reset, 1);
+		} else {
+			if (port->reset) {
+				msleep(PCIE_T_PVPERL_MS);
+				gpiod_set_value_cansleep(port->reset, 0);
+				msleep(PCIE_RESET_CONFIG_WAIT_MS);
+			}
 		}
 	}
 }
@@ -1254,6 +1301,10 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->bridge->disable_device = imx_pcie_disable_device;
 	}
 
+	ret = imx_pcie_parse_legacy_binding(imx_pcie);
+	if (ret)
+		return ret;
+
 	imx_pcie_assert_perst(imx_pcie, true);
 
 	/* Keep 3.3Vaux supply enabled for the entire PCIe controller lifecycle */
@@ -1712,13 +1763,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
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

