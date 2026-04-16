Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97AE378D95;
	Thu, 16 Apr 2026 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337986; cv=fail; b=nLAXlgNOMkl3MDqtGke9/z/dcRBHFhIYLQHbIlM39YWa5a7pblwp8dxeHXcKfHpHDSrp4+clLAREBDwv14EMj95gkmYDnoBRI9pX+0/2NpIVJpbOtFhDHLNSSsm1kLrfmQ33ajhyuSgbcFDflnl30MYN9chx+670IEEXWmWK664=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337986; c=relaxed/simple;
	bh=tlWGZL38RVxyRLjtyLdexCAKpFlaWFLSxBnez+QjpIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvSwgDB7avq7bZD3IczSqpKhJzuNnlIeRlDLQuyJP3FldA3i0kI1sSiKFi7GGr+cbDVA755jXZBgUn4lqD+jagiBDgL4izGuK6AGmyXuboXvcZLY02w1r372akFDLpAaq79WVlC07NAF2939bOepK8glQTNL8IFAzOYHmhDEiro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lHvUNwy9; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lHvUNwy9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha6meWe/rDI+A9cErOaAWLgz6Z0b7RI4iGYKiibwF6bpDTiaMXRdtDdSPv10sIxCRGWrYBg/+PMx92nKAagXXJS38bsSbEkbdaAxCeysKGKX3MFSbbhfECKnB5kD0jwDyr9g/p9p2poGWI7D6e1F7+7wlpXhqfecEKbOPW5L9FcYI/yVMN4TQ5cPzqMDAZ56fuLrWvfODt8kbXDJF9IVT82wtrkFWsPLakX3nJKjbOMZVvbG39jqL90dcSDZ6XvH5ohGQydO0s5EYNCkhJPy0rq21Hl7gJiJqjQLezEa9fCJMXxHU0eb4Iqs2xTDU5XTC6GesQAfD0TU2sNRWCd7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCBaykDefjbIK+vF7tORaHFFgIqsMumdJfV0axVqvxw=;
 b=hE5zw2j8NGpGcDiW3Rc83O5Sf2GmKEFb4PeB+m0JqR/YnHYGmqY0KzBsygbpy6fgPXn+QTDTfztim0liVZiv6Hn4NF7KNVG0skt/J3vmHyUxhKr+GtgqloM3MOXcWnsyyeMFnw6/AVFce9O+W9nzjT2b2trK98ZPgoh6lWCOpYNPNmi7lDHyf09LuUv47byBX3//3Aiu5AeNZoNfUeJPamzySJKq3uUx9H7s1j2uuwpWG9bnB3m9WDrHySPDUxtb1zcHzUOlglpPbdMHtex7PtXXm6/Tl3TXFkdNCcnkwypjjD6wDzGxJe407gKMFkOopnkN7w/h7A3+GRd5cplrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCBaykDefjbIK+vF7tORaHFFgIqsMumdJfV0axVqvxw=;
 b=lHvUNwy9QxDaekSNzhpsUw+s1va6McK/Dg7cl6yKBo5RObfVJBGnziuE0uDk2LwRaRnEfb7XqZLkyw9rjt4P/m6QQP1POFZ6zuDQPSLHHy7EW8kN866gXrcAr3t2XrxKeyJ8JeDgMt/gW3aX0LpUQ2CcgFZMqwpuBW7Dn6nCDQMu0a7JL7Uf2iXk8an5D3zvjHLw79DGYXr73LdWRjS7ffIbVecSLFT2wxTF2Bjm9Q+gi3n8yGwxtWmFmVSthp2km0drWrMliBMtfPPatv7Mny9/sSaXxB+N1PuoAY573VucdU9IA38Q8QPXiph+yc63rTW1c0A4L+EI5JKt3EmJCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB8804.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 11:13:02 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 11:13:02 +0000
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
Subject: [PATCH V13 02/12] PCI: host-generic: Add common helpers for parsing Root Port properties
Date: Thu, 16 Apr 2026 19:14:12 +0800
Message-Id: <20260416111422.183860-3-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS8PR04MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: fc03be15-6e35-4043-f3ba-08de9ba91fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|7416014|1800799024|19092799006|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	MboO4Y648x2CEyjl92FyjD8FB/h+cEbT4NiHGWO3ZJPcXx+XoId+GyIh/H6lRNtDsSd4QeWeFOasIhQkfktCDxLaT3haH5cE1VP2+Oo/Uv/Od3CwHr/DUL6NZ+A1oNorVE0/zmIABum58sJXCaER/YfgOEYe5kmUthllHXQ8ZvMKfsfeCCQ+TUwEybyF38e3F2Er/Jm/jm88HmOLcIQMvYowDaQ4KD8gmsBzfJS45uutzMBGWNrG2QKyVGOWHkMrKb/nWg7jMB6s0qER8ZioUSyy62LMRHxnxVKQKIMQKwsGCZXScCB9Nd3OnvrRyVc8VAI7LiW64Dcv0BbneamyKyvZLUIyujOKq8iS/wujO1xXuZCq9YqHayHOXKZRY53n+1HUjkhot7tu802QxFnhvVKyBOdJV+VlLC4rWzVx21urn0knqljxi638H33HCLMqeyMdjHdMrNo0QB+RX2p4UuC1+O+kZGpay4/SjUOeJayQ2d9ka9MRVYvMqStPqFsBitKbF8BTrb1byR3DtH7lmXuvyRmb4KUx3sWz8m0f2IvAxQPnPgs9Oc/8p4gJloYFJgyrEqfU08kXTm7oJJh4ix4/LetfetJy0hREAoZ1gbneJZ15cmiazQOpyxd6wp+bH2bvshORfSlQAIEP7M2gGfDWqmVcfhycOInA1bYNgfkC7aoynVVeDutHU/XF3juVYkEQNVctZrR6UkRQ1ZhSVjgsXcGzuh86vGjQjYLAVNFW35bHGobLuCmdaKfIk6J/hyU62L8gWP+pqs6o1ieI7iTgr1+jqayug8TQTEjhWC1Vph6b6dsYMJZlVDvyoQPS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(7416014)(1800799024)(19092799006)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lAKQkpFZOheDPwuQiOImavUPDFcaRLr4TdhHS96wcvhm2zfiQ6o+mM6z+u7I?=
 =?us-ascii?Q?kuA5AOyXxd81kMgye9OYNMnCgEJRBIURBKBQyDIHZAPu2EFA6jxhICevyQ+5?=
 =?us-ascii?Q?TMmWEdjb14/b3vLOOlheJZrhCdUhNkafcy66Zt1P4iApgVjzMLOrns2hGBmA?=
 =?us-ascii?Q?soNfifmJdyIkaSRzBmy2i7w7mhUAeI7n6dyO0ZqWShWP5u9INgoKsvbLpmeb?=
 =?us-ascii?Q?updvv0o8sA/Ko28siHd2CKXGbxLKm2tfFt2xJsZqJ88qFe90Wd+l8uDFVdpI?=
 =?us-ascii?Q?LkPnycirNsgllaV7KASQUfJiViwcYdO9UFZ7KF5WdDKZ/lfhfm+8WwonF0T+?=
 =?us-ascii?Q?VZ+BpxcluPBAi1qHkn4t+4mNNjUcv4w8doNV6lLxW9c9LowJ/5Y437eOa6XE?=
 =?us-ascii?Q?Su6jp4LajBnCnM69q94ivlmLGRXii/NfLfjX/dTKe2ffROJ7OnV9UxZBPAy/?=
 =?us-ascii?Q?8AMKPBS0RVk89KL/YToo1x7nP9ZxmGovQSWk2qInAhf+bboxi2HWlACbsyBQ?=
 =?us-ascii?Q?gO45rIueYsjdXSjDvp8TCzlfUA+k5EkrPgKQf8voM1XTcv+Y0Zx8t8vaguKm?=
 =?us-ascii?Q?rMi9/ASfhyovzVGzHPQfNdXJyYt+mfAsi/qOjifpYKBYLNGQ43ElACqu7lfr?=
 =?us-ascii?Q?kvujk82KE4Eon30UayQI2Xb5paTqMlfB5vSQgeYJoRwOo10A4obydemWk+I9?=
 =?us-ascii?Q?o2yV8ivSU+NOCWa416oWKdXwzmhIySXn831VQAobFlcR0AVLKkch3FNeOaSJ?=
 =?us-ascii?Q?FncmQcD82dtDN+Hcj0NkDBW4iF+j7iRAOiEa7vh+l3Z7d+zqa8RV/MlR1NuN?=
 =?us-ascii?Q?5lqVMXnVds/XPhyZ7Z+MYCfArEo4dJ298ZSZt15fcJAm5A25T2Y+x03vU+45?=
 =?us-ascii?Q?KBjmcY+3A2cLj9PBrNH/7jnR18pQTGGOs6uPjtBiotxoz0yaQ7tuWRpjvvy8?=
 =?us-ascii?Q?HZrwfeJPM4CgOD+THPOciZ+6Pd0DXs7zGQE9101lvyYpvQS/I/df+s1X3v/a?=
 =?us-ascii?Q?qIg4QJgg/NHJwhY2qZItjUqYteFtHvnB5Hy3CrYaaZ+0DRXUMtysi++ckIan?=
 =?us-ascii?Q?bO43O52EVous6067OMBWa4a12k4c5u6VOfcvWczJFjisFNsVkWck59VH7Kml?=
 =?us-ascii?Q?WT/LAnuWhtgMwQjHkGG2poWYMZzWTJoLz8cmhSnq+roTd8sV1run+iWWOhhJ?=
 =?us-ascii?Q?z49jduLR0ITrunphPmU1UkFX/kgkGj4nkBKxs81Z2FhZAbMt7k2v9oPePz1w?=
 =?us-ascii?Q?jJ37pF8BRXqFwvnr29G0nNz1AdXLO4dhOGSS4AkqXTai/hkF21/RF5oWRrXt?=
 =?us-ascii?Q?64mOxZF1TFkZDRkPHp1LU6hChtuqoACYoN4JbowXUYpazOH17iVlRWbSY4Tj?=
 =?us-ascii?Q?JRjhFHA7Yeq3GiDYhS1GnkSRz/B26r7xRTKp10yI0UGe/ERrZpy68WHpVLHO?=
 =?us-ascii?Q?NwbpbOlu+7s7CaAR8WofMpi2p/6k+SppmWcMFwdiZ/ptSfhpU4ZD2eVKpFj9?=
 =?us-ascii?Q?9IwkUgGuNWmztLQNJlfnJCh+p2YY/3y5S2xaqulmctCpMqINxpbkZ4zsHgr+?=
 =?us-ascii?Q?D2bUlBogT9NPtFuSMb89J/LB6M/zlGT4J4LsbZpC7+zHTuL+IEfs9Agmk3xa?=
 =?us-ascii?Q?k61hVfRWNrmgf26z0Ecz6w59S53bykr3p2GIpD01kohsf9QOnX3YcFKiVqD9?=
 =?us-ascii?Q?7L4xjqq7YLTiw13owwAs1ei4HFpIEpZBHDw1btHBA300P3agr/+FiVaKDdxH?=
 =?us-ascii?Q?gcbd3r7D5A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc03be15-6e35-4043-f3ba-08de9ba91fc0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:13:01.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHvFI5+l2BFLgsMl9xb+QNQNGkPC874FF8FYnKAq4FHlLnHtktcIdqbhmYxUuPetPmpQYuXysgP0ORvzeDB0Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8804

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
 drivers/pci/controller/pci-host-common.c | 104 +++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h |  16 ++++
 drivers/pci/probe.c                      |   1 +
 include/linux/pci.h                      |   1 +
 4 files changed, 122 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d6258c1cffe5..cb6cd00dc0be 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -17,6 +18,109 @@
 
 #include "pci-host-common.h"
 
+/**
+ * pci_host_common_delete_ports - Cleanup function for port list
+ * @data: Pointer to the port list head
+ */
+void pci_host_common_delete_ports(void *data)
+{
+	struct list_head *ports = data;
+	struct pci_host_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, ports, list)
+		list_del(&port->list);
+}
+EXPORT_SYMBOL_GPL(pci_host_common_delete_ports);
+
+/**
+ * pci_host_common_parse_port - Parse a single Root Port node
+ * @dev: Device pointer
+ * @bridge: PCI host bridge
+ * @node: Device tree node of the Root Port
+ *
+ * This function parses Root Port properties from the device tree.
+ * Currently it only handles the PERST# GPIO which is optional.
+ *
+ * NOTE: This helper fetches resources (like PERST# GPIO) optionally.
+ * If a controller driver has a hard dependency on certain resources(PHY,
+ * clocks, regulators, etc.), those resources MUST be modeled correctly
+ * in the DT binding and validated in DTS. This helper cannot enforce such
+ * dependencies and the driver may fail to operate if required resources
+ * are missing.
+ *
+ * Returns: 0 on success, -ENOENT if PERST# found in RC node (legacy binding
+ * should be used), Other negative error codes on failure.
+ */
+static int pci_host_common_parse_port(struct device *dev,
+				      struct pci_host_bridge *bridge,
+				      struct device_node *node)
+{
+	struct pci_host_port *port;
+	struct gpio_desc *reset;
+
+	/* Check if PERST# is present in Root Port node */
+	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
+				      "reset", GPIOD_ASIS, "PERST#");
+	if (IS_ERR(reset)) {
+		/* If error is not -ENOENT, it's a real error */
+		if (PTR_ERR(reset) != -ENOENT)
+			return PTR_ERR(reset);
+
+		/* PERST# not found in Root Port node, check RC node */
+		if (of_property_present(dev->of_node, "reset-gpios") ||
+		    of_property_present(dev->of_node, "reset-gpio"))
+			return -ENOENT;
+
+		/* No PERST# in either node, assume not present in design */
+		reset = NULL;
+	}
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
+ * Returns: 0 on success, -ENOENT if no ports found or PERST# found in RC node
+ * (legacy binding should be used), Other negative error codes on failure.
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
+			goto err_cleanup;
+	}
+
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, pci_host_common_delete_ports,
+					&bridge->ports);
+
+err_cleanup:
+	pci_host_common_delete_ports(&bridge->ports);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_host_common_parse_ports);
+
 static void gen_pci_unmap_cfg(void *ptr)
 {
 	pci_ecam_free((struct pci_config_window *)ptr);
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index b5075d4bd7eb..37714bedb625 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -12,6 +12,22 @@
 
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
+void pci_host_common_delete_ports(void *data);
+int pci_host_common_parse_ports(struct device *dev, struct pci_host_bridge *bridge);
+
 int pci_host_common_probe(struct platform_device *pdev);
 int pci_host_common_init(struct platform_device *pdev,
 			 struct pci_host_bridge *bridge,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..6094b6c1fc90 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -660,6 +660,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 {
 	INIT_LIST_HEAD(&bridge->windows);
 	INIT_LIST_HEAD(&bridge->dma_ranges);
+	INIT_LIST_HEAD(&bridge->ports);
 
 	/*
 	 * We assume we can manage these PCIe features.  Some systems may
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..cb5f3e7e8e48 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -636,6 +636,7 @@ struct pci_host_bridge {
 	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
+	struct list_head ports;		/* Root Port list (pci_host_port) */
 #ifdef CONFIG_PCI_IDE
 	u16 nr_ide_streams; /* Max streams possibly active in @ide_stream_ida */
 	struct ida ide_stream_ida;
-- 
2.37.1

