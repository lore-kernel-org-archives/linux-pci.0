Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3172EA481;
	Tue, 10 Mar 2026 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107609; cv=fail; b=Zi+QHIqwrXZBR7MnfACL/s9IKfwtw+0r2WT+Ls7I2w3bnSjyliteXjKgnZgVe+PuMhy8rrz5vYzeZP8OAz9R/XzV7v4pxaFCRVaT2DHktG05qu7wKVWHSSgfP6MjUHUfdenVANibfhnUOgjUDyA8crFfEuC2jJANrqrf9YgXcb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107609; c=relaxed/simple;
	bh=hVsYm0cWa2IS+np+h6bDBttmWafZv21fd6eu4YLgdt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VRX3POVuTw3ktK70nrJLaSWCI3auZlhQZr5mgM1hzCdw5YzAjRXegtHtJVAhtcES0kBKCSquqU2STXOLYpY6KhnzIMOW/FxsiDigpjeS8MMcxGhv9kaScYalKk3tjlIznKpYv4qpXkbOCJOlxadRm3Ym0JxU91lEVZ6NDplOXYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ctRwVhrV; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ctRwVhrV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ys7eWetbJ7BobhdggJVmDqvBJZnYvljvq++8srcxpM6Yt4ps70LFdyyzi5a/jXJhpaqJi6XQXmSinwkvBT+s0G1FA9Sz81qg79pMGTrGGWnWOWgNb1gpUUNDwGMSCQ6PeOJxsO3+6m5359pEE4DQwAgW0IYoU8hemVOeBr6tFN42PKYSezkPW3YEoZnO13qpQ8xnAEBpNFaE+4POm6fbAWfnRcIBESxmzRNg4uPeYDyaDSueaX8UYQftuwpLJ+EsZJUwUj3wpw84xyHYXRzFPHr7mz1/DVxmrIRvV4v5dd6h6oV8Uw66IPF+g0ByK5k+VVuIORaWNmmD16EttPi9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDG5fxkiz5UXZM0uPlV2JjlYJ7yA+bt29aSs6DQuIf0=;
 b=v1pncX+Kx4KZaeTKsL9hdI4Uc33DLeaYWFxzBsuSv89gZIpjoq/21vXJ0/dOhMfrUf6gulywNgvMWu7aEesQN7xWPhKRMneXeGrnhp3++0MuX9nMPZdBZjZUvUGSIizTKKfsxlx4VUthKIu5eKv+h/mhtwZ7//6M+++t1BodTVgq6+HVLuN8qCnntt7r+QfJjEiYpaPxvQxtb70KOaY7nhb2aAgIYAoW/fVsIm2u+W84LzVN7PtV/Hz9wPhI+eZevR9lhEK5Td4r7US8f377jmrdBr3jSCAmQxGil3EZgKmvott5ZoWqkWsLNWhvXeqXxxUSUtlx1/9waVvXV4tlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDG5fxkiz5UXZM0uPlV2JjlYJ7yA+bt29aSs6DQuIf0=;
 b=ctRwVhrVYMSFlcyyvuIs/xppQMIJX47lffRzFr7q1uRWLHexGSdB0NK3xHjeCro5WYt6DjAb5J1orPaAPxr/xqxcRhg9PXcqHnZQuD6//8XxvE4SMedsVO9MT2GcBigo2eXIpR6Q4cuVp8nv7Hj+0TvewkMG3XLqVGqRvOSoH/NMJi9V6XDmRtytfo79zwhDy3XbU1l63C75KZMSoas7bWMG+s6UMBBIExbCID91yLLqzbCgeWknDeeDphHHDVQH2H4aAcS8qbH9OPdVvqaxtaw6zNU+1cWgBX48+iJkcK5hPDAzI7nsu4vIrnl8YOVxVOvg0EE9KkC+9Zji+GXyYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8889.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 01:53:18 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 01:53:18 +0000
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
Subject: [PATCH V7 02/13] PCI: host-generic: Add common helpers for parsing Root Port properties
Date: Tue, 10 Mar 2026 09:54:15 +0800
Message-Id: <20260310015426.365675-3-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58db33aa-bd9a-4a78-be4f-08de7e47cd65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	CA+H7apZHxJFOtVYT/HT74Dk1EOLzRwGiyVnYJgJg+KKHAwLHFePm9/OPRhFLWbx/CvS69dkH7krQEIRrjvkfc0HkOhu5yRTx0Z64sW8ao/YFUqTqUuQdS9+sbZCTZt1r9ONwl3GO/ZRhfnmKzUY3hd9RI/cvUwQVQ2nKNbUq6fC/QeJP8EbyCLiA8lfExmqP08z+ChDm70RPPz6Ig7rISMkRtiTO2rLcwGfywFuQmxjZLC3mZH/ifU2AywxSzYQN3J0a17N91Co424GnGbsyn9XLMoj/YibxlP6f41JoMBlAbGQ67TQbqTS4uPoPHPnfqkM5f3fIJk84jdgp94slS77eLfYzVq7OSx5/Y7nNgZjo5NXjEpgyxodg8/MulDYCXtH5ZFoci3JT37mHcIhW8ZcyDzRi7vpTJF8+PoW5FjqTy61o4cUySFWCdLwq8f/LxGrTJetc3+ZHrlfdF66tsM03LIGuunFIdxwp5Tmb+/ysWWMER0qliUqvsWmOUosr/KZL2+iafyjKJvA/mqYLyZJl6cpw7qyTCzcT7tYo3C+2a36RKmLkIZEvtYwUcqBufp/wbPpbiI4aAvmRCbQBBWSM7D7FHGz0LNDrpRyA7HxEClPQa+thFe28G3ItLxMmXW9JXoTRoysFCKgc7p3jRniGgl1JDhOWrwpWA3D0LA0BMaYddffpHjJEsDwiU6wgq+JZwScyYJErSoZIHBvcUCR/95kJZIZ1V+vODh5HNIgn/SnofC8nlDFbLpBVG0mNrRp/LVPF9xcItFnp/2Yof2wQDp5L3+9DMoN2QDCGqk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pr66agFrVCSAu01QxMzu3GZBji4OdrA3Lnv5v71Elga8ygyrFS6I3y2XFbkY?=
 =?us-ascii?Q?P+bljhmedChMwBZhOcsf1aqxgNe2LAl/lccXXKIZp0anFpYMwp0q3BbU4tRJ?=
 =?us-ascii?Q?9eb0pNpsp3oluFbSEC4cVMuF0Hupe7dIHOIEVoYrfaR5bby+Sm+Lz3sPBILY?=
 =?us-ascii?Q?rKjU/i8btn72H6T8kFqjqF1qKnouk3rP2QFyUTN1unNAeqsp07aD85yT0avb?=
 =?us-ascii?Q?inijC60cjigmWDdAms5HJt/D8xZGFDVRThJU2xqLOZOUt0s8/eJr3qXe2XHp?=
 =?us-ascii?Q?1BZmlgFPOlg4uBbhAnMKznuTXFho+45zROlN+pVqWWpRx4UjpY0p7x/2gqTc?=
 =?us-ascii?Q?U5pvbXYUq0Xs2qonzQbMmPNmFTN+FXgMviA2ayR6+u2plN5qnQxZct11JQNh?=
 =?us-ascii?Q?X4Xo4DFl0Z05D9qh2N+wzeqaDyf2FGy1gDlqiY3QxeyMJBjSpZCnv7fxNoJr?=
 =?us-ascii?Q?rQP59jLpcXXy+/Z0P/bj3ipCPJ95dSKWEWm2zbt8nNqa05yVxjr/0eKuzk3V?=
 =?us-ascii?Q?gzLzhxWEczsgD8Zi5/4zt2Rzm0szOb06Cb2sLDPtU/x0lcBQp3uTGNcGN+iP?=
 =?us-ascii?Q?4xC4awMQSZ7tSX6OqrkqVncm8IX1i1b3hnKpbT9Bv9xd5I25aNfUWFGtFJGe?=
 =?us-ascii?Q?KH3piw+k5GXLp6JJVT3raPI8A6n7mS2IgWMLskVa+XNDrXGST/Bb8/TDCpoh?=
 =?us-ascii?Q?AQvsUv/YN9Jmy1MF6+jJ22yJV5GbnhD4uV0n4s3D7wT7UCwDMds+R4l3Oy7Q?=
 =?us-ascii?Q?l58SzpjlJmMHLswjrAqY9NBuKDxmigyiQqq3bSe1OwYHzyW6MgzOSF16je5P?=
 =?us-ascii?Q?LuOxyChEiD1jf2ckuo+odw1OhXQwaSplvQN48dcFtAWYBWEHEFIXLt13RZnb?=
 =?us-ascii?Q?zZJAUBo5wsF6d4DGUbOcvtp0x9vabZsCn4hY2VCo9m7pLhXM9gE32AIcWrwn?=
 =?us-ascii?Q?Ah3KtRz2lNJdhe8iO3KK1e8M6+yfkfgUTxeKgMc68zZuUybPMKs70fcHg2x2?=
 =?us-ascii?Q?fWZosNMkX39g5EIPMPWBn6mrYTSLwd7sB2vtFW1Gh9ifkKo1oN08Bkr+fc/S?=
 =?us-ascii?Q?Tg8rRPVu/fQEjU4mPm7JITsBXFmhZMYYwRoq+mgr9tTSlK6hnfA2U9O4svyj?=
 =?us-ascii?Q?MwuDJCEek7Bz3VrEBjDk0MUHk0vWj/zJLV8fpIeeEDFZY+SplcREKRV793UL?=
 =?us-ascii?Q?ghJIjl57AVx0YxzJldSlq7gCGt5VzlYf4/MElqochVSRvl8KAOdRqJkHYQ8g?=
 =?us-ascii?Q?81CxOQ6MKHgwed1YWFnX3b8SM55k1FZMLFfMvrEqrIKhtZG6IuEUlXF7vemL?=
 =?us-ascii?Q?c2HNTj9mItQsLPoHqFnQozyfdl7Nnn0odGB0Yw80bhy2a5NYacjT/nWRxucm?=
 =?us-ascii?Q?i/bTdP+FNHFqsUb75TaTx+IWaoUEMmtQfhDsAHJ0GjxSDWYmYLCi1LL3t1eD?=
 =?us-ascii?Q?nixTgC9QJ9y5XYb6OMXQWJXD66PtQcwDv50E4L/u7BMXmTIeh4iMKaJyBMUu?=
 =?us-ascii?Q?2EqqI6EbnuqBKoekgDalP5gpLjPCSgL3Nar8Upvu0rEBBqY49hsH7qiotRFA?=
 =?us-ascii?Q?YgdSSJpbfUsU0F1sTsMNMn7eODTHmIAz7/+FJuMbQup8ylvs1rO0C/om6m9u?=
 =?us-ascii?Q?9bEWW76F1aUtqvJFP756XywMxma4Q/fqF5dEF50h3XG90nhD1aGUT3x0XIUu?=
 =?us-ascii?Q?TszTmrKBpsrORWuBeaF1uT6nKZ0G6Dub0LgW1zc2hvG4WaImEy0yz24M/pAn?=
 =?us-ascii?Q?AMf7C+V4XQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58db33aa-bd9a-4a78-be4f-08de7e47cd65
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:53:18.8695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoX73vK18g/8H70WpjkgUYDmDH9f8z3nzbxzfV3mMk22tQCzmAdVsg6e34VB+vSBTy9D09s6YhP1lc5met3IIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8889

Introduce generic helper functions to parse Root Port device tree nodes
and extract common properties like reset GPIOs. This allows multiple
PCI host controller drivers to share the same parsing logic.

Define struct pci_host_port to hold common Root Port properties
(currently only reset GPIO descriptor) and add
pci_host_common_parse_ports() to parse Root Port nodes from device tree.

Also add the 'ports' list to struct pci_host_bridge for better maintain
parsed Root Port information.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/pci-host-common.c | 59 ++++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h | 15 ++++++
 drivers/pci/probe.c                      |  2 +
 include/linux/pci.h                      |  1 +
 4 files changed, 77 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d6258c1cffe5..de04686fc715 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -17,6 +18,64 @@
 
 #include "pci-host-common.h"
 
+/**
+ * pci_host_common_parse_port - Parse a single Root Port node
+ * @dev: Device pointer
+ * @bridge: PCI host bridge
+ * @node: Device tree node of the Root Port
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+static int pci_host_common_parse_port(struct device *dev,
+				      struct pci_host_bridge *bridge,
+				      struct device_node *node)
+{
+	struct pci_host_port *port;
+	struct gpio_desc *reset;
+
+	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
+				      "reset", GPIOD_ASIS, "PERST#");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
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
+/**
+ * pci_host_common_parse_ports - Parse Root Port nodes from device tree
+ * @dev: Device pointer
+ * @bridge: PCI host bridge
+ *
+ * This function iterates through child nodes of the host bridge and parses
+ * Root Port properties (currently only reset GPIO).
+ *
+ * Returns: 0 on success, -ENOENT if no ports found, other negative error codes
+ * on failure
+ */
+int pci_host_common_parse_ports(struct device *dev, struct pci_host_bridge *bridge)
+{
+	int ret = -ENOENT;
+
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		if (!of_node_is_type(of_port, "pci"))
+			continue;
+		ret = pci_host_common_parse_port(dev, bridge, of_port);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_host_common_parse_ports);
+
 static void gen_pci_unmap_cfg(void *ptr)
 {
 	pci_ecam_free((struct pci_config_window *)ptr);
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index b5075d4bd7eb..1de015d10b9f 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -12,6 +12,21 @@
 
 struct pci_ecam_ops;
 
+/**
+ * struct pci_host_port - Generic Root Port properties
+ * @list: List node for linking multiple ports
+ * @reset: GPIO descriptor for PERST# signal
+ *
+ * This structure contains common properties that can be parsed from
+ * Root Port device tree nodes.
+ */
+struct pci_host_port {
+	struct list_head	list;
+	struct gpio_desc	*reset;
+};
+
+int pci_host_common_parse_ports(struct device *dev, struct pci_host_bridge *bridge);
+
 int pci_host_common_probe(struct platform_device *pdev);
 int pci_host_common_init(struct platform_device *pdev,
 			 struct pci_host_bridge *bridge,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd79..9cc3f4ebb370 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -647,6 +647,7 @@ static void pci_release_host_bridge_dev(struct device *dev)
 
 	pci_free_resource_list(&bridge->windows);
 	pci_free_resource_list(&bridge->dma_ranges);
+	pci_free_resource_list(&bridge->ports);
 
 	/* Host bridges only have domain_nr set in the emulation case */
 	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
@@ -671,6 +672,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 {
 	INIT_LIST_HEAD(&bridge->windows);
 	INIT_LIST_HEAD(&bridge->dma_ranges);
+	INIT_LIST_HEAD(&bridge->ports);
 
 	/*
 	 * We assume we can manage these PCIe features.  Some systems may
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c620d4b6c52e..926f75a20d7b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -634,6 +634,7 @@ struct pci_host_bridge {
 	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
+	struct list_head ports;		/* Root Port list (pci_host_port) */
 #ifdef CONFIG_PCI_IDE
 	u16 nr_ide_streams; /* Max streams possibly active in @ide_stream_ida */
 	struct ida ide_stream_ida;
-- 
2.37.1

