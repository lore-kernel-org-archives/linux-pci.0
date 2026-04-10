Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013018.outbound.protection.outlook.com [52.101.72.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D931B3B19;
	Fri, 10 Apr 2026 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788191; cv=fail; b=XuGsEh+Ym8Y47J6bJUpLYbNRjs8YdyGYjChG/kxdqaVRquiQOx9Ns8hTwYn0GAw78jgUHRYkY5vEiLee7qcgBQ4f5ZMHbEZPE+++62PKYndEBiQGhLNCvTR9wRzGmVFDqvkSn9Ai9ihHkYptCS2HM5tZlgIwBgeLAyeTMEQ8ue0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788191; c=relaxed/simple;
	bh=i34QDX8lN4/M0uZJ+E/fZoQlNxqXW+XK0z1L3pw8Ic8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PFdg/I6YfqyhIeMWSjcqxMjtJNrBVwL5p05sg4ADYF1LZ0dXWFoJQ5+ZT8Omtl2afjv8LL7tLsO4mPH15rjkskNWCMEHc0U5N0xNGiDDMPXjssXG+JC+q5jqIY6FauL8jjdT/aJWhGis5ma52NGyODM0XTIs43bUXByl5fiHCGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mLtaOmcu; arc=fail smtp.client-ip=52.101.72.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mLtaOmcu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=em1A8D7cqhrxEcpn3UZ9g9jtR31NCm9fGzl2LsJ/03W1o8NrNOPNEQm8P65xVHss859G0XtCGMSeHjKmeU518vw3C5lzRlm9FBjxTQr+g5kNwYCTwFBzR/Gj5cy38pk6zmN7yRiNEOy/nEQ2y8Rl8PjrCqiQCketQAu3eLPDZ2h0D2o154LhD1I9lml4+aEQMiAlJ4EB9Y/4j2EWm1BkwQWKUhMakCOOcumUvkUxLYgf7CcrvV69M3d9eqfpxWFsKdbsH6ibODuQQ0ZzPjJ4c7Ck6TWDWNcHYtVZ1/Ug7Ju3ePcSZwbbM6py5n/b3nS5ZoBHsO8kU1KqjwmziWDzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYdsU8XkLfPnKGbqexAxx1qrdcjHQERmJmERbQFjT0c=;
 b=wrKUN/QVs62WQjgE9ftK+b2l6Ymz5wGMXFJhYPlX5FWnklVPAEN/LDjC+qpPpGzDmc4l/xl3XpCQchdqWnaGNGB8SRUyICwTpvPcr9Y/yNzTMwh+1jhrwYVr5J7GeQTDEh7CWq1Dv2ZlY6dI4OvGFJdfesi/Bkv+7XNl8glMBEOapxkqdCMP5uBTdwFipFA2HGGuH5TAvXk76Lm5F429R0plrtZfUjBWoSEfnrh7wYjlGOfOhqNf0N06P4gAP7unJqZqj8eWgUKErj2mMst4SAq7HcWAk3Nc6e5lzBTawiCBADHZ9+o6+x44bfJjl0ERWMP8cLVhlq8JKO/ljxRdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYdsU8XkLfPnKGbqexAxx1qrdcjHQERmJmERbQFjT0c=;
 b=mLtaOmcuiX+VOWG7A5yDIPzqcjOs+D54lm/KVaWQwFuCFOAex+xxyGKyykoeJfnkXHeHpteOJp10tanWrr6JFhrBLJ+teCpZ7PzWEjI3N/4V0YBFg6xjjpl6nzFT+5v2dOUJu2qfn4LRmYlcjSmkpjA4ifn7qnCsUnmffNajb2UJs/qQM8OhFlwvwcns1vcEcy5o6mcSA7yGErEFFWLA1gCoW4fRvsXh+dEuIRZhHdGL8LAxPF6PYfw0evM4Uv77NClNEXNwmsOEpxItys0j/xunj7KJYtSUTtJecUuEt591sH2xCS1rVKe0fIskqqaxR0J8Za0TGJ9sStfa/zKdXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB9826.eurprd04.prod.outlook.com
 (2603:10a6:20b:673::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 02:29:47 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 02:29:47 +0000
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
Subject: [PATCH V12 02/12] PCI: host-generic: Add common helpers for parsing Root Port properties
Date: Fri, 10 Apr 2026 10:30:45 +0800
Message-Id: <20260410023055.2439146-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260410023055.2439146-1-sherry.sun@nxp.com>
References: <20260410023055.2439146-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 39535062-d396-4f59-685b-08de96a90885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	58CCi6SkJljUJAVaMrxITAczDLSU8TGxVeKRre8VQByL+DDPEphNftxFSRK4kwW1AwKnyr37fzCxRxNRLaNN1XLe7aYGTPQ82mInEiG2Yp5uSuyIzwniR681pbfekOVQAvzhLTpOfyvcoO0Oykgf5Wtc+jPc84jUpKfSUveUNrtHWtOV3yoZKyg/Oq4yJBZClKKulpX0EkIIOLUF+vMwmQqiRgiR0jTFEbItyfB0NSfQtz6R/7IMfmgf2nepvK/g2lrKlLCVECMs3CMs0SwpcUwzYjVhxvv3PkoQpKoCOfjA3FO8zeboiN3oC7C4YQPssLGj0meo3grMyGHsliwuD0DH2voTlBrySP2BjxdBuQSnh2p49OHqbzbUzDH+HglCoKhz7rZE7CrfirljZ8akj+2H/jjt46+xq3+YygxhAiVpJbgv7nz8gzKgxBqDgoVfmbZTpSEFroGPvJB5b1xqGEF0doZjwulK7bRa4IO+PFgvrNRwbT3BMudrMbqO93zTL+DwjBlhEAD4v0EwnjIIAC84iQJssryV5w2SWAuquYHZkIiB6FwYj9xtHFqLqeGmi3gUtvqfifFfZ2evWpu6Lr53lA410qd6p2kCM/tDweiW2qfV+0wCMOCTguXknYPNeO1LPkmldrxjo1je2aU0K7ZnanMQTMzZ+h/wO/WNb92kleRNU41F3AqqNDaJcTk5C9qYbmBJVsSOOAvyti/zFq4Dhl78TNgAeaH8NUh12VwxHEB7MZEwaK56I/yxFEszZ7LHQHZU5453CMtcHINxeuZ4qx+8IPQ+R11HPzG9vAYVo0Ly1G51VRFQXgMyoCta
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7HKynRJKec4lp6USjW4DjgbFVCbalkaSzrhVzKiKC9LKG6YRiJejXDoFS8U?=
 =?us-ascii?Q?p3bPNjoQnszaDYR/5wOHjwIxf5N47CYnHE1R0zKWDiHwq+j3jv2Yov3xQo0A?=
 =?us-ascii?Q?FvDG+F5ld4xEszi5F+jaK+zXPtQQZipOOB0SX64JlkeQvKu+Zzd6MORvVsYH?=
 =?us-ascii?Q?TkIYb2C9dn8Uyp3rebaCC94JYBb7FEN5HNtVPEwFwOla50uvgIuo8Svk8IIw?=
 =?us-ascii?Q?TLNj65tQ8Xju4h4a3i+LeN34FYmVTN3Haf69JoUk5IOy9+88TLoDkO69fLsu?=
 =?us-ascii?Q?BJdShNXGwKOh4hZIJ9qkI0YnTRvv60jrPuy3f+/vdJhXHvQQTR45B45WXTMA?=
 =?us-ascii?Q?DCIXc06ukKJPYxWH/L3klqPNdCr7ILvMSvcfnviaLVlJ0d/kXZnyMzEZnqrZ?=
 =?us-ascii?Q?SxPVkZ0YmAYwBfuQcYmMnTesLRPzEu7Ii86IQkmket7KKpKjdYPUzp7cDUzW?=
 =?us-ascii?Q?UP3hpg5c+b18LMtv8K9b6bbsGqZiOK7GL8RuxBf/KSNqWUzyIP3aDSVdaZdY?=
 =?us-ascii?Q?ssJVDTvJ9dIbE0PzfTkQG89RJzEwrnRjK68GNo0gjsLZC0lvvfjI1s0fGiFr?=
 =?us-ascii?Q?pGtx/ryGEVdjYp9tf0lwa9ySNQYf8XcbBn8vzWvpyPoR/gJQE8wVdZJXduH8?=
 =?us-ascii?Q?tVZlocmd/DWlVko6L1KJQkiNRMC+e/PQUaYa5PdFHbM6ic9H164sMqKR10LN?=
 =?us-ascii?Q?DkGUKSfL0PIxTaNSBa2bASj/A4SjEt9JOPpXDfSAZU7mapB1B6DrNYbciFG8?=
 =?us-ascii?Q?2Ewp+8FDysfPRHJKMvcOCmiSltT6LXKuBWaKIsfCH+vK8bUcEV2LSVV+wzmu?=
 =?us-ascii?Q?VXumxlkfSRqOw973PmU9Debdc6fPq5xfVnUnRDGVXYEWvoLhRVODYrN2+jhR?=
 =?us-ascii?Q?lbC6fNxnGUmKRZrbPcU2XmLTBWGsqIoUM2IUqal2lDcM2zwDYaCaI47qrPGH?=
 =?us-ascii?Q?VT1pWANQtR/XENTZCh6z7J/lqrJV9PFDLX4URAn/QG2sOIybjPTitHiFXegF?=
 =?us-ascii?Q?Sl5Stp2U1S977dRdxhNqf6fVcFjZm/yaqd81DZMfPK8fFBN4kIblONn+zxaM?=
 =?us-ascii?Q?nHo6ZcJn84Kk2jNvQ77pWheEC7L8SJ53AH3iICbxieLccf5R1gWOZSoTAqpi?=
 =?us-ascii?Q?ekq2hD34/Eg23ky+FIPdNoHJF63nTGm4Vw8VxFg7jevxayV/WbQVtmMxJubm?=
 =?us-ascii?Q?ynJgpdwC5auW/4lwpCOIytQHu3XDkJOsZedCNDfqf3kcXyt2qagBadvw0BAw?=
 =?us-ascii?Q?JZT1XfZ0BTt1qhlql9z9n/KJ0zTz1phBMR/3sXDqHrshZE39DAekIskTaj4d?=
 =?us-ascii?Q?WboPj4x1yYk6/+DBtgf6D6ZqA6F3zlNISDjcAW4X21oEq4rqELFIPpNaDdOB?=
 =?us-ascii?Q?xxyCT+f1yp50NphwNYJB0kUyKAvjfHdjnTqI0c21DulgS0jKrpYT97PZG0sX?=
 =?us-ascii?Q?JYPIQVE3A4Vi7zuyik5G8cSTScySUz+l1pooDvZ5Vtmer3FVQuRevQG9c046?=
 =?us-ascii?Q?pcojBXg4MSPVCu2BIGN1XjLthQd75HVcyDQr21d7BN3pzUJio8qPyUCidS1t?=
 =?us-ascii?Q?VK8H0kix78lqyXs0N4Bbb6/3GFEtkAWBxFoYrIOIt0inKiENuN8tn/NSiXwL?=
 =?us-ascii?Q?RCj29mrAfe6IkyQ3zykMlRblHSEU8840OyhBXLTq7sBwv8e7ar9F0uMRVrra?=
 =?us-ascii?Q?y5pMLdGAcbf8CoOjWW553tN9wXqW7eQ7Y7iUPw/gqZhXFJ3sxuirhymTC8z7?=
 =?us-ascii?Q?CBVfeaVjsg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39535062-d396-4f59-685b-08de96a90885
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 02:29:47.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J64nH5rMAyQWMHy+BmKrzk1vV0k1dSIaA2OKuGrtIkveMCoZ9oABLJKWITcAe4lPS1qeiXawK+Q82GjPC6b1Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

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
index d6258c1cffe5..064640af80c1 100644
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
+		if (of_property_read_bool(dev->of_node, "reset-gpios") ||
+		    of_property_read_bool(dev->of_node, "reset-gpio"))
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
index eaa4a3d662e8..629ae08b7d35 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -677,6 +677,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 {
 	INIT_LIST_HEAD(&bridge->windows);
 	INIT_LIST_HEAD(&bridge->dma_ranges);
+	INIT_LIST_HEAD(&bridge->ports);
 
 	/*
 	 * We assume we can manage these PCIe features.  Some systems may
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8f63de38f2d2..a73ea81ce88f 100644
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

