Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5256328B7F;
	Wed, 25 Feb 2026 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016868; cv=fail; b=TgmWyTu2lUgqX0Ut7qQIiRKAbYzX4OB7Ik7OlFDYxEOwO5DD//JU8wSN0JMXbcW7Q6Nk2BYudqi1HvESJJSPdVa6osXQtNLRXz72tRoUcj6KRMf/NVlti6eaRHJU3erFekvkp3RZwTlLBcdwCCN5PmaJCiU0NDjcnaXJtNJlSGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016868; c=relaxed/simple;
	bh=XKK74ZA42CovxAOSxQxe7XEyYNBvOY19Yet8t+/Ys+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZmgalt/DAKoCJck6zAwSldPTCAL300z8XNm7wTi9oFJ31NbjhSgZzNp7WHLobY594+lEKGCiJ+MLok2D589HFiHFsjwufEbDdLFjp0I6SgT0eKxADMAcAbHvbFjLBnRz7eRlTXDkSWwcI/ojnla9dyG9WRUsxecV8l/XQbKifw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TcDSw9/9; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TcDSw9/9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8sYRiKhqNZcLv2pTqTqxj95skaMKitAsdvp80sMi9MYy4njDBZSuxoVI9LgQQ5z+MKH6lTETuvE+YaHgChPqySvlP21noKYaBDdnl9ORAF5k6tUbNVIhUsXUAVeSsakriFqOu8egujDUT4RRVEdsiSA3H8B9aucx6QPHPNfHmwQBa1Wxpm3zAaqFPum2LsnJhyEz2893+LiQyj1hz6j7yaQtb+trxkivSny4rTDPVYJGkcjhPTV7R49FvgDJ8Rf8dQC8VGqC1Kb7DI9G8ojRDDQ8jil8hXkVhlKDcCwEmQ0+8PI49LH0yx5jVU1EENsNN6bj0U5MFnSM0qgYqJ3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9Fi3fHT0lk1t9lq785RZ7WukOhZcGqyeYuvY88yl4c=;
 b=gh3+UpBess7slJaOyrj5QDTN5VcGsGetWVMso0z5Ln5vfN1Jaivl/UYxLBl5rob7g7EooAcXX5wGwEaIaGAWAUOkWhS7Sbs8qnpVhLMvFDepEntvrwSl93cxjBt1YiryBstRDFeuhn4Qm2Hq+nCdZoCe+9dLbeda5AaL1ayQiACKGJHjkqcz+hYDp2trQW4nli5y6am4kQGbwf69+G8hfdhYWDOF5f3O460A+E9UYf9zBrtB8Avw/26aToF27EvS6AiJAGeaAA/r1DMwvuZKbk0GS5Yco9m3tu1pYfiX5RhInHmGV/PvA+LKCq+nW+cL2co4xdQQ3MuQNrE6XPn35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9Fi3fHT0lk1t9lq785RZ7WukOhZcGqyeYuvY88yl4c=;
 b=TcDSw9/9ItuQaRSfZWLO7/MyflfJe8uftmxAPtDWSOmd39zL1wS7Xey5l5cxpwoKsin3EODPmGAzOkxjVtyKVrqhqa/Fu+GctbOB+kP7KYKCjCrwdnKdb3Gp2EpvoDINV4lCNyTyiNHiUx+Sx0W8izOlcjkhrasbWtlU6KlOfKKMaNaCxTFiwfd/ZblWOm5C9iRgV4CFjbDpcSUAAyo6CDunwxEnnt4xGNDdLLK42vm2XccBhpQSuPNo9WM83/xCeNbvsGV73dQuVokm+xi0B+KtIb/f34Yf1WX+CbA0GlKnXaBQee78Ay6RrZz8IkNgokhe664AGGCaqWOyXL0EcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB7668.eurprd04.prod.outlook.com
 (2603:10a6:20b:2dd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 10:54:24 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:54:24 +0000
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
Subject: [PATCH V6 02/12] PCI: host-generic: Add common helpers for parsing Root Port properties
Date: Wed, 25 Feb 2026 18:55:13 +0800
Message-Id: <20260225105523.748775-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260225105523.748775-1-sherry.sun@nxp.com>
References: <20260225105523.748775-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: ce54a478-5ff6-4c62-586c-08de745c3cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	IdJjoq/FVM0cZmJS0T4rW2PAYhP4Fe1ULPamwxnffpbqosbeYGrimwFa+wdCpICyg4c1BpZqwvJrsD5hvz/o2+8g0XgC7Rwv08Dc661/oJ8V9Qjx64eqxcb8Lx++bGc3IwcXh+6FJQMNd9XMUsCGPAm9vhCeega+5hyVqxqPpwC2Mb4APyYFVXMD5156XJRN236xj4M23xf2f0B0IbHChim8jV835mSmwqoPeknH/5G2x/T7SF48PTY2ssNHui2pwqrY67SyvdOA3ty6mrV1AEyGGSlG3Dt7NhhKnMZLuAdoKtoQEbYwtPZRxFV1wOfdIDMOVeMJVWoRPV9IvohgYLHfDqELMZ4zop2YhbiW2FSxTAxK66mU9WKfSLkQV+Y75kZN1TKSmqR6yRWOM6EOLuX8d+MWQ9ip5uC6ztdc1B956plCkJXgq1ZSFt9SIlOokQ4sYeOR5yDjCBO1slmIoevi3Rl6p+7asPCNzB9PI32aSn54q3VKhoxcE27lbLyafRg3GoD3CR7prxNLyp69TMvHerClOBcAJ+aAm8o0UZgyvRnNlTNiQknz1DCBMrT341ih//a4X7vR+dgdXe5msYYt6/P34r4n9LW5tQ//rRAXCZUtNAkmWG4aBHJReswr0BFZkA5lmVvVCPa0mudDda9C3dCKSX62KwZ7Ily5/QCCMTJbW6vM01if1Qfix8rs9TnZIlwkX2k1FCqUn23n0tUO84uf9IPqGHmkk6+Nju/lLe77OcS2XFn+wquhODDuMnbyOdWtMDIeqRETVQOJhcwrjb7NJa79JPWRjkzSLa0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KGDB74/KEb+bo5YrYV/3KnVRsdaSfI4oKiksc8mHEK0WAsJIerfs5vn10IL4?=
 =?us-ascii?Q?VUZBJ1aqK/8BdKQLxWnPqbDsbTs3hh4bIsbluhK/8gRMb5LaXGvZmMyiBmnz?=
 =?us-ascii?Q?T7YuXNJuEKlmDvcTfYPs57WzOP6T/LbuTj9HsQT97i7mujS+MJwPm7MmNoJm?=
 =?us-ascii?Q?1/NCeTchPNUquKQerkGMgAtvbxzvsi98stD4jVREcwaal+dbvJnNguTuDeK5?=
 =?us-ascii?Q?EZ0HSSyVyG5IKX94dYunqk9NvKACTEOM6eWqUJdLMnyjB+DHjk37nrdbl6cY?=
 =?us-ascii?Q?3WIeogiwQRLOmgdezVFbqtZUFFPy4u+BzsQGwHNTRD/FNDoSpj4YY5G/k/vz?=
 =?us-ascii?Q?grd2zgsEHQb/RaNbAmZ3UGviMJLczn8lJfOc26r3wcvT9ltHePU49Tk57E5n?=
 =?us-ascii?Q?tDPxDzxNR9SLrL/qgCYra7on1a+GNnB9X9fH2t71fMpo0OisEyKIWEBELOA+?=
 =?us-ascii?Q?kcEfBqDI4egFtM465AXWXSQe14NaNhRz83iBeRTH6KzBEe27AC69P1fF/I+F?=
 =?us-ascii?Q?aXy+4j1sbkVPdVk797O7DcP3l//jPQXPWP6Mpsn2aWtfrtyF1qQRuoD0aYPi?=
 =?us-ascii?Q?/y99XRF0U7u4pfop7yaGUpnfkUyvXM13Tvbhe/6fQParFa29oTi+YIMWEHGG?=
 =?us-ascii?Q?Aael03gYU7CfF5jAbmZmWGs+TjfMBfGYeN9XxPnpYNG6mDBP837aAY8Riybn?=
 =?us-ascii?Q?8RMLMU4LeCzlQCWo34EtzSo4u/KO7Ug0WURY+0o1f9pnzMdE6I09/79svzTa?=
 =?us-ascii?Q?9XRSZXBKvVWmnxdfJBTeu7j77jPLQ+oknVFn5hfJ+7msfR0oEDGNo/CC7idf?=
 =?us-ascii?Q?kgxvjgIN81eVoT3Q3mbt7lsJaZwbW5SJ7q3jjV/42KuKymiKEkrw+GPJYJBL?=
 =?us-ascii?Q?k+Y0e/p/56owwtjkbSe26DURIsxZlFScMAX42/mTPzQtXRc12FOqCTp3NW4r?=
 =?us-ascii?Q?BXs0LCd18oq1De46vpT2bzb3N6d/DUgRTOsl1L01P5qcvGlsLaIycGdwuCJ5?=
 =?us-ascii?Q?gFfOkXdibjR3PYfSmR6uPX1UxCFPHPcv2sb+e/l+QsqMSBX1n61b0fqlyijN?=
 =?us-ascii?Q?ti6jw/QPC/MwKSkHjm7aB8JAop5URS2v/I/s0GSPsJ3k/NOkcZ2EepprsaQe?=
 =?us-ascii?Q?gY4qccfBBAaf+bWsTRvbA0+5kOnlNQthclkxffoX//uouOmIUpVdz4AiMvMn?=
 =?us-ascii?Q?+cVIc6kkhGhJvS6LJUluOd6ccVJmiCHfisTHejT4s1RcAMupzwDjySTLwwoP?=
 =?us-ascii?Q?pT9bVNjteCm2dcogYY6pQ7tgBhUOyO2EnOMTpdojcl0E7qzzyD3NLwP9ZqsX?=
 =?us-ascii?Q?b7il+XyVaA4ojnosVLjmCuIMiqXKIn/4b27pzy5AhnZOFoBawcv6YRQYdCaZ?=
 =?us-ascii?Q?Soy21EXrH/CwwXVGCJ77YvHJzJV4ymE3x11/YAHNVuN1sRZHPnLn3Gi5c9mg?=
 =?us-ascii?Q?Fo/OFFdfYipj8LcgDZ6viibUgA6JFtsxGq1UMJNNPFqVHrM/tEsgEQ5HEWp+?=
 =?us-ascii?Q?wHT/RGU/pCzCXrTNE8FL3WCigo+DUna43lSJfccpgKK5G66x3FhnbgNvO2SM?=
 =?us-ascii?Q?84AgkfM/63904mrZ4IGvHAnu0IZYwJO85fv5oaSF4pV04xT/tYrIdyqEAb+y?=
 =?us-ascii?Q?NovDCD93CKLhOQ6ebehPpiy0d5c4CqGe9dn9TIwyI+PsOYHRKzwmAATDSyQq?=
 =?us-ascii?Q?R7jr/dQL9xqKTCMPpTjRhJj46BZ5weMKXJo8cOWpdxaj4VeGF5HR4FNncIkN?=
 =?us-ascii?Q?/TKFG8DYBA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce54a478-5ff6-4c62-586c-08de745c3cbd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:54:24.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSJoFJiqcYzNTIDastYciRwdDVBoamOIrLQjak4mpL0alyyZOMUCvcuyQvqiaOHMBl5H03G6knEoie3kitaNew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7668

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
 drivers/pci/controller/pci-host-common.c | 58 ++++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h | 15 ++++++
 drivers/pci/probe.c                      |  2 +
 include/linux/pci.h                      |  1 +
 4 files changed, 76 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d6258c1cffe5..b9a958f745d9 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -17,6 +18,63 @@
 
 #include "pci-host-common.h"
 
+/**
+ * pci_host_common_parse_port - Parse a single Root Port node
+ * @bridge: PCI host bridge
+ * @node: Device tree node of the Root Port
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+static int pci_host_common_parse_port(struct pci_host_bridge *bridge,
+				      struct device_node *node)
+{
+	struct device *dev = &bridge->dev;
+	struct pci_host_port *port;
+	struct gpio_desc *reset;
+
+	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
+				      "reset", GPIOD_OUT_HIGH, "PERST#");
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
+		ret = pci_host_common_parse_port(bridge, of_port);
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
index 1c270f1d5123..b05482355abc 100644
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

