Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42A3A9618;
	Tue,  7 Apr 2026 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558520; cv=fail; b=meGj3LgFKLYOq+ZXIYPWLsyfZpBgzbIEe0SELV5j3/knyaq1mHdj/wcrm4eVG0+sbl+rqNBrk/z+Q4KjFKAhDV6Xoq35CeUTEkwQElF4VRhRMoVOssDz9H9pWmpBR/9UzujcM3JCgj0co4hwGjrQgDJatlrQNxNxIqnHnqmL25w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558520; c=relaxed/simple;
	bh=ABBA6YcqUqncWx1Yfw3oBQivDxneBXvCKZzIxNjCLHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NW98rLXjSEoYnYnfojLkbcYp49Gl/aWdPQTnMIOvuF0wqNn7zPPTZ4etOg1zulYgtb39cHq4IneHuuODwsZ2CcoEp2X3MCNJoHvhGaSmApUl8Rlvs5x0ItRnCs9GD2e1G00qEefqGGqwvjmLZLfYKnb9bp5aW1uKpqkp0YDYPwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J6r/Bs6j; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J6r/Bs6j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0Kl1VhpjIojc4hIXHwHy3PlPLU5ZdRKP350JuNMS31EzypOMeqL/G80YIPw8ZZa5wNIQVZct+Z4pnwO2RwLDxLF9MVLXKfDJ1YH2Vr/TRLj5dkHvvzbo5CqYU3c0ztBecMRFYxAvheY6Y8fDxF0Hlg1PmJp0kRVWl0c++SUbOmiNCBwGZ7om1Yh+SLwyQZ8GC6462IFwkgvT0VGSkZspcz71pXpu0gA46AAT5ldK/e8tzTnKEzQvcAH8zLmliyPW8/2G08ZWi6S+f/1jRfB0RepPZk4fVDo32DdkOf+iwFGUwDcIkSMSQwB3a/0mJYBJn/aq3/N5uBMtiuh0W7Ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWc5DpOZwdPAWd68S6FIswmTCvI8uEkPWqQpR0jDV1o=;
 b=neIr+Qg7c6ZrPggqsPcOuhelY5nnMYn9ruoLmRUy/q5SbnNzIlX6Uk0iyKpc+yhS6ngDbUT8bdMurAm1GlKDw53LdI64gvU/mt4id/khMUOAmE5qlvr5TAMWyRiJj8EpKMXQvD5WX9LX65jYc0FMNWEcBipcx+j/UQS1SdMuZ2evoFYX51UFILoQX4GvmHZgMD4k3VHOtQ+g6ONrgcaLDfUneW/hJPcEC4ZUYMCyRXqitVuvHgrZoW3fSqW6SE2j/1p4d/Bi1KtsHJQRdz2UnqVGl/jCHnwETc2sa+/l0yI39SoxnOwJyiseJGOfalT+G/D3zvfdkVlbUwH9uwFPjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWc5DpOZwdPAWd68S6FIswmTCvI8uEkPWqQpR0jDV1o=;
 b=J6r/Bs6jWnhjI7MI485SVe5jQwiPG/zY2wBNtZBzZbP/VyZ4tBwt42/zrYAviLgHy2WPQhcomPLDCIiA4Fu8Qsea8qEKGOm7JkO7DPvJobMr5ueDkhtRiu+r7906oxrfZ6PoLdzi2h368qacy/R+8Qzg83/msdya/UvprQfqKR2zlAO9ouE5Z4KowD0R6m1H/xnELcZsMOQWQBsCTyVnL4T+s8C7+qoKK5yfl3Z8uUD8rFDAGJKyRw541eq9ivabNDd4rh9hHc2n8lYiwBtIU3LilBvocBhtnFgc9h2tYnJVMeSmJczXILzvW4zaEAIGfhgv5Ih3PAjBvUQUPotyrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB8281.eurprd04.prod.outlook.com
 (2603:10a6:10:25f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:41:56 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:41:56 +0000
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
Subject: [PATCH V11 02/12] PCI: host-generic: Add common helpers for parsing Root Port properties
Date: Tue,  7 Apr 2026 18:41:44 +0800
Message-Id: <20260407104154.2842132-3-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b7681fb-1a10-4d82-947c-08de94924a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1iVgPN9QPYsxBJVugCyAapqnLpOTPD2gAmydzDBtluyuVdzqg6zSwaPS/PWlbUwxumgSpot+BvIY/45cIoxkGuhtiE/sxd5fSJqPRyDI9TXY+o5D64vUGIRbxdWa/C0psg9vvIgtTSaV1zpii/y0tZkKO8597FYQ0lV3ErUP5OAcjI/FT9LtM9to1j4i2JmTadboKKr9iVOrvj5sBwKpDM+8WHKCn2byUR/FLwwQ1p7HBICCUxZkDyXTeipZGlQ8B+HtpJSuVEBloHSo0LcngdJgyelluHP3ZffvNXVSQEhy79RlAlU4Zg7aOWDhn8o65E7cogw/Iff5JcBaxr5tVdF81d0Xxf78cteJgiFmUvgsYgE8UdbHXVZKaYG/ZMOO2XPjUtZIablLdMIUKW+QkM7Y7K/g6JPoorXvgJIPnblkbk0wahK8FdIG7IglgYWHw1+JHzbIpu+sZ4QdbM9VsaPg6csRvgg6tsY/fbjxeZfBN8nTRmRM/1wpxwAV0LPYqQZjN1o0lsibYfJs4quWEAciICGSFmiuku5EFyIC/qG1bgZ350ZQENc+VG/PXfJsNbajLBhzUOXhlqWGresZndHLs3ZCTS/mZMvtdwrHBMlnNr+amwrhD72RqWd8W6UYzAt3J0ryhU7vkCM+A5uqqp6iAj6+lqqFWvYh5XWQjsPFwg9HLfvFi0J5Hu2bbc0QvPBMi85jG7zs6ni9S4U8UKCPTe7a60sYPHD5SqNxvh0OKWokCp18MgLy/IE3CTEVL84wAh7cF4za3k8vk0kJZtmm9OzaP/4NPBxnM39xnME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MX4smWyBaB+muglZbxsT7LEI/qCqTT5TmqQhbasaXqtgvE8NIkKAiklvo74x?=
 =?us-ascii?Q?4XCKD6ijDouZJaVAzRdbiaRdZgmOJRzvZUglL+lOwzfIEExygHGf4aok3opC?=
 =?us-ascii?Q?lKnHlhy8ft7wBLZWw9CwRkmFnH6IQ9PGBSOhPH/TqjuxM5+NOYIKCwBb1udE?=
 =?us-ascii?Q?uWMLFlfjRUs+P5N7Kl4PwwGZSm8zSSCSE7AzaWqNlP1V0B7WD8H5SIlvNn8f?=
 =?us-ascii?Q?CvD0LNbkP82kCHPWFJLGFwQB8JokXfxrFPDb03ffxyRWxHDGOSFXn16MQ8ed?=
 =?us-ascii?Q?AYf2yARcQ53+hSBu20HW2cM88kEm0jgpdPoqfsE5Fw5dkW9jFEF5b4BarqZ1?=
 =?us-ascii?Q?4GOztncXHsmDpBKDrsZwLT51CdvONAHeNttjAjkUWW0vxisN5aNQe4OvV8sn?=
 =?us-ascii?Q?U0y9Rs0bn9UxuPcepty5EYpEK3PnE1XNgGXQtlbeSZi+z7xBl+6JMqat/BYY?=
 =?us-ascii?Q?/gvDQjgfe11XbTcfW07o/aYRvWpJMhp0sWt3jZkqu0nYHVvbCrvDMtbrCspo?=
 =?us-ascii?Q?PuioPsU4blPJUHWSrkM+UlMHOpKzcGkM4CgfoKo2VVKOVhEk23ocDeOdF9Co?=
 =?us-ascii?Q?tQ9gFNtkv4kA8f5LbM9mEKYjQogQ5nOzZ/tw27xSIddFUqb/MOFQGhypNEtq?=
 =?us-ascii?Q?LkWMcDgn+eqvRIyIQfWdIlCM2NmoGdvrfwyu0c0+QtHTdvv82TLgJJuss2Eq?=
 =?us-ascii?Q?SzhQEl8z3PAVvvlBu53QNEQh0AxwDnSFTJyzHqaSb+DjWgbKPhLH0Y2qxVLr?=
 =?us-ascii?Q?MwQuxzRsgKqhbZI41dPLmJ7d9MZdau57F8eTAld5NxkBINAFdWrfVwIEmoh0?=
 =?us-ascii?Q?Y21/BWzQxmPe7F1IgtPP4pE+W/QUoSzg+D7YnisH997MHo9ud64YlC0kxfIC?=
 =?us-ascii?Q?vQ98P+UGUjE0qUy6zuVmp6ZhSGpuunxkibjWYqYFyQqIieWsQ8FUfb2CVA7d?=
 =?us-ascii?Q?1d3ENyZWucSIdWe8XiLa1j3MowrAEiA0Lr+bxGC9+rFABOS5ucnettW5SiMt?=
 =?us-ascii?Q?JiDWeIwjSFyKAYIwbPyPQVY3MAlFz6gjhI2u+p2RYTEMRlksBPVH17u+qQkm?=
 =?us-ascii?Q?Gc1okd5cUHNjZX3b3h39Tc3swzgFC6OiC61uGCutZtcxy3lAvDHXYCFW9bC4?=
 =?us-ascii?Q?7x5cYeDdp8iXaRIAqGCy/+WpFqAl2HT14Gheil/1oofYv+5wxGhBJWow8ove?=
 =?us-ascii?Q?ypA+2aT45viZ4V4Z2E/bEL4gjIYIyYNRPZERCnKsKE2KeTLzDRYZO3duV1ZC?=
 =?us-ascii?Q?7UIsThXt+pmblbSPSKdch7qIBFsisON4yUg5RdJoHWk1Mhb5PTvZcS+gQoKg?=
 =?us-ascii?Q?inHsqBnmst7/x7JfZllNF0kl/ydQX3Ln2KmABdlpp6pDOBCG0CADn3iMW1x3?=
 =?us-ascii?Q?JRwjbxVy99m5+I8tcXIfVdLlN/0ZCVQ4HYQyMYvIlLpHfgOfqU+OdCLBAnto?=
 =?us-ascii?Q?higC+9ewWSCebFuEzJ1+e1mMioqU+RItLDp0Y4W9cOSlP7DkUBSOZGtZF5F6?=
 =?us-ascii?Q?oDbAqrrlmGjp3dzPkTByDokwWEA9Ew1lr+eKVNqJ2TggUZ9d0qRksmJJLHwR?=
 =?us-ascii?Q?eH5pxhP4L4KsEPvVi14luKKwuMEBxkHGLgVAh2SXx4v+X8zO4j52ExZDUNSE?=
 =?us-ascii?Q?HABETPwt3nsyLD4YGhsihexi4LXJKMwv0aeDg8fIPNmQO3YtAby/p01BCaNc?=
 =?us-ascii?Q?yyznMbx9X6JokhlEyHwgLnIDis7eTjTvhFk/GKpb4WlSiM9Y+jmbC4r6sayG?=
 =?us-ascii?Q?4lEQ+Jgc7g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7681fb-1a10-4d82-947c-08de94924a35
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:41:56.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amskOO6n8iZs4NX3v4Fk3TLgHVHZCFzEzaoUiB0+ZxnKMEVsXfLGjU0V9XQi+euAG7YV2IFlBbRtQDj1Q/zOLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

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
 drivers/pci/controller/pci-host-common.c | 77 ++++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h | 16 +++++
 drivers/pci/probe.c                      |  1 +
 include/linux/pci.h                      |  1 +
 4 files changed, 95 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d6258c1cffe5..0fb6991dde7b 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -17,6 +18,82 @@
 
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
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, pci_host_common_delete_ports,
+					&bridge->ports);
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

