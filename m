Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD22F6918;
	Fri, 13 Mar 2026 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367684; cv=fail; b=HJifKDqAwSuGFbdhXaRtZVE+aS0WIYJ2J186FSYtrwHC/kbvzzQX7OtWyKg/Z784MTZ79GjGzSXBF6bsV13i/CfSqKI0ZW7iuVOndvDRFXo0RH+DTRyVCxBmCXwl8mVpbkFn/bqjWiIjVxFJ67Tohb7jr7isESsvIPrlE5DAqfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367684; c=relaxed/simple;
	bh=yKmOlSOfp6E1h1xdcDhLDSV02QqpIw9QqcRwt2+6m3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PWmpUR9AdaxURwR1OAWrWeMDoUjtDefKfoVVBWzMo0NO5qbM2JxRB3uNxy54p/4cKl6etWcUB5xLlASCFPbmG0+3wQqbdu5PcU1GyO6foa5A7ebrctntxesY7qAozUOqHns4Dqp0sE0dUVBhNpHN17lFl5isr2YWHorlZFO6VHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cRDdXcwR; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cRDdXcwR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQR6cAJ6pJ69zceuPrhJgCDXOCf0WIp59lOh94ozSBpDLO16yjUkePxb5WM8g2w0M3r0qAbnFXz85IlJZs/DElG6nd5HgYpZ7X7TccQSqves4M/QETQB+PsQTvKvawHA8XMR641F8Ip6AUNVRN49dbHpbew7Os6162+J8TlBbc/4RlXfPqccRym22lJIarB4l7eneoDlbT/mmBojoPFhEDSfzX/j6vbrcW5EZ4jZ2vS7qwHg6Tp0RnEKWlhEEmZSxKvIyjqNhoHODXYONwVkDpL2UXmHSHkkre3ubGZKwVFR9/lGGJaWasS9nJBLaD7xoNUmYG+2Dvl+J0kE5OnjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4xD5QKRVRV4bNXRNDHPxA4QQsRIcPQ7Pik8tFiA3XI=;
 b=k3mku8dV9kZLO7YMVdDZL++e9dEM/lxPitkzWR2fbCYgDjBUtpb46zjBFwBvEisVtkqMEW5uASmgMqk9SfPs7zswQICqDnZAYACTAwVfjEjN5KlKaURiOq03aNdFEDD9cDL6W9Ax5HKiGqOjfRqsfhWhC4ml/FQULImEYzXzC1x83BCYebs9pyzGI43pMojpe0ej2XpcNl6hB1ZEJVpxU14cqtfwuX7DhmmeLPTFG/Zi8NJC09Rttqz3eDtVqJsuhe5sjCMRMqojHcVsuIzYrmP6/twnA2MHBToosXv5rv3VVwrv0aw14PWamIMDn1tUL1NaAnYA3rhWnr34qTF2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4xD5QKRVRV4bNXRNDHPxA4QQsRIcPQ7Pik8tFiA3XI=;
 b=cRDdXcwREOP1JmkhEusWKJ/jWyLzz9/Bmx9ttlokNrky6SFjt2tm6Lzt5q+6eQOjfzVXu2hj9jqqDyMvwPVwVqi0kbRGyJzJQ6ht9dgXXNLNdqI7AouMlssUPEVaB5Kho74N1bO/U/vOZUYjgpFzhw1WY5A3NtEH8YNePJRuKiGkPwgssxgrv64cMy9KvI73S4a2FQARxmtplKpH1cNMMupHne/cWeV3J6mWwGk3J8RXBXI3ixZnOyiIWFpt8YZrHIZ5zhQ2Aj8nizk4ZOW97+78QZnJCOTpbIhALXNUf5OwrJMTTcRdORLAzwDcCaZVCvTX/kB4Soi5+3W0dtC8dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6844.eurprd04.prod.outlook.com
 (2603:10a6:10:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:07:44 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:07:57 +0000
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
Subject: [PATCH V8 02/13] PCI: host-generic: Add common helpers for parsing Root Port properties
Date: Fri, 13 Mar 2026 10:08:12 +0800
Message-Id: <20260313020823.1592389-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313020823.1592389-1-sherry.sun@nxp.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: a229c3ab-9e36-4c52-c1a8-08de80a5585d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2I2IAC0gQeV0lPXSWLAGqMWB9SmjNKmV5qj9w2/8WP9iSLL0XPgpJej6svmM2XD9LWPYhSVmU2c82AEHKMUo8CRz/fG5c9k7DctT3oeLJq/w7gXJs3AyHkiy9alTvntwrPLCcdDo5QP1ZfmKUDHfCPKYxNgKeNhUg9KyW9SMsrtW2vREo99FsXayPivrPxh/13CAWvkTW6d7dhRw1rpp3qjzRnHg0awlsiwbSPxeY9Kb7jk4zN0eJC0777qMz7xg/bwj9EM3MznsnMXPREbW0/fAKagMyMWevRiDH6pz66NvFf/QUKsXKHE4pElmsup2ccrC2Nc1WnW9J1cay6rhsbhrCqFRFO6/jZmfV4kjpg4TNIzee+iyMHw0FNDK7c0W5YfAbL8z0owFECMNNZpRq78nIifbp8jml1cMyHQkV5HK1rsT18TaXM+oEejx1HgkqvirePtuWkAuJ8XDMxG9fmhvVme0Eloyx0+jlLFHm9wyE0emGeUcADqJtYg0IM8NerLwAIzNX0zwOnfRCGwOR54gWLX4kM8rEVbi87PwSUc12voSf5He0cXnYxzvr3+/+Kz1/oVBr63M4El7svT2w7YFJh5c/ulInbYl8XTtvyToF6B/VHBkrKitNbftb/RuSyllIKpPtP+drhE0upoUM9pcNqJftzDatGoFqKYoWzLcgmpAtc8uGLqMIdni0BnBEJ7Y/5TBqpsRjnu3BXuNNwjKABJbGAXZAbric/P4710GqRwUf04Xh5mjSXluue0hEYxlaRBim21ALcbbDqF1Jw92WoMR0fo3688l5Sfdmlg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWNcPX7t4D2pEc3anO4PuRLfQU91DgwrZLgM4wObrxOtcLP6TGbtMB9CQ5a4?=
 =?us-ascii?Q?pJ3c3aDYiZ90AEFEmTz7OqgcnFu1lPqjnKgBkCbUMM8x1pnDWKcF5n9oVtam?=
 =?us-ascii?Q?iKrYN7DSv4i7L9G+7/1dstny214vOgsBwYvEyDbhLfHZPoQPll3di/qS23PZ?=
 =?us-ascii?Q?c2stbTXWg6/nHt8FOL6uUW5C2JkDpyz4O+jJF2k2Tm/k6+aaIbKtBgACx/5h?=
 =?us-ascii?Q?s8gt0Vk9ad/91dBxpn7CwD63TC8OCHrTbaB7fjunQmLrlgcNKr/ldq9O0utg?=
 =?us-ascii?Q?FhE8/J23DEV5F0o4N9qeaEKqnE4q7o7fotOF3Zdh59jiNlTi5ddb5koU24S9?=
 =?us-ascii?Q?H3Fg3ubag+/iApOwpDZk6wSnFc5Za/Tmv8aJQtv3L9Zz5ZcnaBAClUwWBJyP?=
 =?us-ascii?Q?uxjhm7pZoqpF3f2bA4EcEPW6ym4RXc1yp/iD4HfLBGqqr3m8JfGR3NA6CZSo?=
 =?us-ascii?Q?I38Z7DZmPEf1oy7DQQnPLCJkmJV/Oxv3Vi/uoSnBfuE7KYx5aV+Hw1hyPtxJ?=
 =?us-ascii?Q?v/Bp2Gwba3mCfjC004GKa4gEdGDsnn3afIf+XC6waCrC8C9Bk7WL+3ebuDab?=
 =?us-ascii?Q?EbRQb8vzOocDeh5upytG/6Hs1AgvyjNB2rArYi6iuGw7fLbAUWnrcYqA6M/j?=
 =?us-ascii?Q?znSAtqgZIIfVIKfeq0O2L6qN91fuaczFAHEhP01+qb9YRQ7yq9Q22EndDiTu?=
 =?us-ascii?Q?7zp/5+qo9jUl8ayC2U8jGqNBMiVNr2sINSpE1a0kZ/dsK0zHvh2F/b+Ni6pz?=
 =?us-ascii?Q?guo9qzGiDFsf5n0puijP/24aEmjKeE29MvGiH9JhJj1VmN9AiWlfCchAYVRw?=
 =?us-ascii?Q?6y/LGO1TgjaiZzqEbj/7FQBGxzYBYWVYUjT00Vej9NXKmobObWJei5zB9bB2?=
 =?us-ascii?Q?IDCmWWJ71zFVYsV9palZbPFVekJEcgKuSm5crkL+TKX4LkogcaqI0OUSeBna?=
 =?us-ascii?Q?uTksfc7mWD9OoaPHwAd8O55DYAUdkXGm7GTrz9Pd17eIXFwxxL5RNhLoux8J?=
 =?us-ascii?Q?gFelg74ijPBqtRxLOGEQe7CkrzKtqqZ9yEilgQU0MuaJJpPr2SRSAtNvrba6?=
 =?us-ascii?Q?4mt9JJVI2JqfRHh7zmL2Nx2AGNbOYem4tLvfHXsvfvOFv1JD7GlBjhlNnCtJ?=
 =?us-ascii?Q?zebPlkyJroAs39swqRw2pkLi8jikTB9jgVeOFhsRQMxTSJO1A6g6949k/B8z?=
 =?us-ascii?Q?EDL0C6BmixXk7mqtL+mBZ2lclY4Vd67k23UhL8GK4/fIKPocbxIBuGTLt6ZJ?=
 =?us-ascii?Q?A4D0S2okapsoMD2jVD0BK/r4dgC+WMhhDSh+TBIh1CYC/xoUhNXwxq/b7Dqt?=
 =?us-ascii?Q?6c0ZTlUfHUNNILtukvZd4CsgZyj552SwDUOi9U+S8XAoOZvqP3W+AW0s2BU/?=
 =?us-ascii?Q?CIyo7XMuxK5dwb6/4uvW8xS8/hb7cbKwZkdngIredXY1lrRG2xmo+1uMypDM?=
 =?us-ascii?Q?p8da4kQ3bHxCpKpLFaXpa4QsW+Z/C/sKPtCOFmeTHb1rp41G/wr4rWfJtNEF?=
 =?us-ascii?Q?WZIjXsWtTlKJGaRHe7zGOK9yzHivTcie8T544/u0TZK/l17Sl89/RwCiAsB8?=
 =?us-ascii?Q?qEaUcNFD0LCmyFS4BFXW82y/ot3YmXp1Ctm34qYYFwRWOcWCrDBvEmM00FXd?=
 =?us-ascii?Q?wS26iqP/VaewdFdZSvJSYULXFJUg77EuqqQ1KAfbovybS8cm0582Z+sRgLBF?=
 =?us-ascii?Q?ozDNP/7MnG23VDOlMAAq2FyRt+B75y/M3GT24K2eG4AC40G5hpcmbvjfLJvW?=
 =?us-ascii?Q?d9pUWAU3zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a229c3ab-9e36-4c52-c1a8-08de80a5585d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:07:57.4474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KZ4hyzVdISVzStlMITpQ1q+6/dpsWGkdBWVTa2fae1HCZalxSJB3aPsqPTh9lah51129c4oJRCo4IzHv+izlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844

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
 drivers/pci/controller/pci-host-common.c | 78 ++++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h | 15 +++++
 drivers/pci/probe.c                      |  1 +
 include/linux/pci.h                      |  1 +
 4 files changed, 95 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d6258c1cffe5..2f012cf80463 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -17,6 +18,83 @@
 
 #include "pci-host-common.h"
 
+/**
+ * pci_host_common_delete_ports - Cleanup function for port list
+ * @data: Pointer to the port list head
+ */
+static void pci_host_common_delete_ports(void *data)
+{
+	struct list_head *ports = data;
+	struct pci_host_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, ports, list)
+		list_del(&port->list);
+}
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
+	int err;
+
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		if (!of_node_is_type(of_port, "pci"))
+			continue;
+		ret = pci_host_common_parse_port(dev, bridge, of_port);
+		if (ret)
+			return ret;
+	}
+
+	err = devm_add_action_or_reset(dev, pci_host_common_delete_ports,
+				       &bridge->ports);
+	if (err)
+		return err;
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
index bccc7a4bdd79..65a111361072 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -671,6 +671,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 {
 	INIT_LIST_HEAD(&bridge->windows);
 	INIT_LIST_HEAD(&bridge->dma_ranges);
+	INIT_LIST_HEAD(&bridge->ports);
 
 	/*
 	 * We assume we can manage these PCIe features.  Some systems may
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8861eeb4381d..ac343e8f140c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -642,6 +642,7 @@ struct pci_host_bridge {
 	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
+	struct list_head ports;		/* Root Port list (pci_host_port) */
 #ifdef CONFIG_PCI_IDE
 	u16 nr_ide_streams; /* Max streams possibly active in @ide_stream_ida */
 	struct ida ide_stream_ida;
-- 
2.37.1

