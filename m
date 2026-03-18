Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E23659F8;
	Wed, 18 Mar 2026 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815296; cv=fail; b=fwCPeoKcwlIWIuXWktX/Y3hdg3shnPz+PoMfnICYTPUCBpAohLXloGbGnlJeEaE7Avbd6tT2pypXdENNFKGblN/J0weV28R1SftslSIdAtN24YhPvTxmRtvbwFW0/lN1M24DcHJew/c1Wxk9GVaDNK4HBp2hPtHVJCjFz8fvB80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815296; c=relaxed/simple;
	bh=FYaSlL2kDVcnNh2DHOfNnwOEq4k2FoRYHyF5pYttKnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j47PXgsEC3Vv6zPCZfSd7cezPOSA6Rq47sSItdf126TtF36nXNXOiXOnyjmTdM2bRrs8/648ZiszAKl60lkhWqwLaV38tKGadSol4bE/gQoWc+ntmahwv8CbcSEtfRsR8iMWgWR3JTeRSyQ3PaQOd/mONPp7Z5kspqVYO7D1G5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VwJd9Ei0; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VwJd9Ei0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbEo4urcTvMmm36r4oG8srJvRn02D1lQ/jKm0OeqcUupWw3IX1Pp2RlpAf1mflaoyhe2KVHP5tyilXo/Bamm5AsFmELupnHag9N7+pCg9shTMGK7kH3HgMPRkk1/k2i2HrpDq3qXaid//w0SeaHkaNutt3gVPdZici6AaaMq9wGiYq9DOwGrYAywRz1QI81iAz/9xL9bV9Q/1ykEHqT83CGGc/J/vO/nDckl3cD13JCjhDJ4cdkuDV/pjWKBr+VYPvVpCKK39UvFB1PL4Nv+abORSOxkCw1iggEBtoZmqMw05NsG+TmfEBnJOPk6grTr9WowNlSi0dPMDHWjrj0mDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OPH4ARTxhB422IyO2zUvCVkn5gBwZDn6toCot2Sx+Q=;
 b=Kn0FcqAECZjziElDR7EWRcrbYtUyO2PdA3zOcmqUr0fAVC6nPEb8LFphVkrF9B6ryI/l2mGCBcGVSQTKHA7oSGrBD8YhLOsgnpx6btLeKBKW2kgPzVMUssMDnzcALMYdX8K8jOUvB3+4YeRPSRscRydfj+ihiR/eXMP6nvnux0Fw8juYtfi63BBNCsZmWwnRu8ZtP5i4nm2ryYttqdM1/NaECfuz9c9axrBYYVbtyR0ue1zjd17U8SEem5D7weyTVltzqTvTd+iEc2Kx5mV74T1fkL7DGtQBtOCsP/24F7h8qeeqCFPxndCllcQi8FWjlKxUD4gUSistbcDgWqs/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OPH4ARTxhB422IyO2zUvCVkn5gBwZDn6toCot2Sx+Q=;
 b=VwJd9Ei0TeBPHeL/joksC0w7Ht3Ppcw9NK732n18x8GlS+hSVQsc+CKbu7Cpqnd3ZcatZwdnWkat82Eq5Lwuuj74coNLisFwH6645Yil8loRphGZd64B2BPhZY8yBjHCTGI7iUBfbNFcCnsaEY3uM0E4tUpC9EKMnoPm00mpN2/wLSd3BLQcfyV+HNmw7ujqSfbTNRlEvyGgh94gaPU2vKYMD0f/dsoxvfSAtm4BKRXu4KIwYRhPRzUC+XVwaDM7XQkAMRpomVC/a61D56AJlfMzl5JoBL9hvKhBvewbazbX+zP2SqWiJ5EsawE2pr42XJnUDVthBBbnx+Dsr3kvPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB11334.eurprd04.prod.outlook.com
 (2603:10a6:102:4f2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:28:10 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:28:12 +0000
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
Subject: [PATCH V9 02/13] PCI: host-generic: Add common helpers for parsing Root Port properties
Date: Wed, 18 Mar 2026 14:29:05 +0800
Message-Id: <20260318062916.2747472-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260318062916.2747472-1-sherry.sun@nxp.com>
References: <20260318062916.2747472-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB11334:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfc1243-bb00-42d2-fe26-08de84b787d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|52116014|56012099003|18002099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	LajC1rzwxVIDt1sftYwcafqumX5/sh3RoccXolGQ1H1p42bbM5NSvRK9S5cFFMifefB6jfYAJJXPoL64+tB/A9WKGYAY6iU0IzU7qLoRzJoPwXeVuoRyn+LCbdgoYbRqDHfrYjQsJbcOWQKLHTHdL/ZU429iD2hrmJiBp5rV7Nr10qTRQFczw1x2AIQ7hX+0PdtiCTRNxV8udLZVGVHBkDtNaeDRFhjJfgFHwTzkO9++Mpb8T3Aa76uOYXuASOT42BfazPqb423CFW4+edhFEmXWGo/tPDxF7hjqeMBUpiJIvGmAUnE82yMwFpEOopWjGHkpP9Gzqj0HNO7XgSFS0qJuyA0b3EtyZXLm1L6k63VbikM0tUEKd+yYMpWXKuDEyYfueVTht7sL1V0JlFdFDEig0Roq2kj02K13yqDzMA+qJ1lKoE0Gb7/T9JhcKOj2KWg25HROgPGxjWGyLicHHzGmHAIQWfoPrhi6fd1rhXGdNrwlEDLtsP58yLq/8mVPpNHGrDjHAK6oSbU9LCHVaSjdD5FVkhCg2R9pNTYYNCc8PSX+AINm6we0rgxUdmircnv772S4L0GafRgA/6725iBFDmmz4G+k18bFQZd8ZF5Kkl1zi/WubIrRCM5Qkf+swn86WBcjGW/Tg0+tYDm5tRUjWZe6awnsSiQcGPY2Np3S/EpMFrTJf3jF0ZlKNjMMCZGwxBm9s1CDH5ExSasSjHAcFKKLxcjnLbJyQOK80bePYOwCBonPDNUQig6BkIWtzyaSRZg4hbNTNqVPpZgeUWfghvo8xgUeYlMpUM3rNZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(52116014)(56012099003)(18002099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H5yS8+S+0iC5/i2XPlXuTrWhux5vMYbaANtrpL/FkdGW8KPxujOeuwU1Hgg8?=
 =?us-ascii?Q?cZfEYlpDVl9BxwCoE8LGdFDe4KG6fQ40GJAGhnqQ2KIXdhqUGYVu4PJn8mvu?=
 =?us-ascii?Q?B58/J9pvK407ZZXyF6gVuZ4mMDeYvmcK7wa0REHw8tdKKr7JMjGpassqeEAs?=
 =?us-ascii?Q?o4uUabGBQy30gClGymEEUcRcDUllybm3177ALiP0to68ge5M/gOtWJeBBloM?=
 =?us-ascii?Q?g6JiXNBkoNJ2x/7YQcUDMic9wNLX+Ydf30mnDa0xw5CF0UYp6cDceM/uM6o8?=
 =?us-ascii?Q?axFczsq5EXV3uvgk3E08GyDglTYz8kfivsul3F9Df+qFnHOX/UmUV9p90ldS?=
 =?us-ascii?Q?qt82z8Cc1bHCgOE8XdpTUYcgU0aTK6/I3OUx8QTrP5kYMdEt9DRgr4aPr3ci?=
 =?us-ascii?Q?LoSU2lK6NQRlYmWZexVrtEBVv6+uHIGpugxNtrJHEVMcwrWK0D3CsOfNA5Je?=
 =?us-ascii?Q?s+LOqb3XmQ9YujxXNavsPKtDrGVq6iEld7EYFnu0nIotaTb6ZISuFXL39on8?=
 =?us-ascii?Q?0H8L2vQAbMumHGGICeg0DrBjxQBOdxvXt7PTko5GiGvQ8EZ2szdzWFjNlKjv?=
 =?us-ascii?Q?9QEFWizLLxFBqgstJiRn8ejHaNsOVEH9IBhlVhwMIGHhBfYos2ZFt5eyvp+E?=
 =?us-ascii?Q?U5/K83iogfSdW4NI1FwW2D5yGr4Go7868uQOJiBPZ7bk/q5h2DKJaP3zcCA2?=
 =?us-ascii?Q?tJyI1w1VrprgrgqXDEW/Ed5XYYGW0fCLmhYwfntlHHnPPMw7emkX2ucK8JDU?=
 =?us-ascii?Q?4bI7zlXBUiZT+Az5k02rEmYKwVP4BSWc90o87zhsVUT2j3+jjmY78oRVvoMS?=
 =?us-ascii?Q?J8WozTt9q1Z2Ns5SXtRSQZlfeqab2HyjoSHB+BbtH6l0svJItuWDs6yLrJa0?=
 =?us-ascii?Q?D9Ern/MySXIgitzTqki+2St5pueG9jnE4baCz56ERTufFADiZMqK/UmHattY?=
 =?us-ascii?Q?jgPRdluuwJzu0krtP+yP1JwXnBKqQLsE5Kyub0UzteHjoqsx6jyVymTRQb6k?=
 =?us-ascii?Q?5uwx+itahbMRl79zhWfiVfAQIWpy4q8LNYBO0Zj9d8SnP9H0EZ2bGtuKrQ60?=
 =?us-ascii?Q?a7aHvWpODFE/TJg9rLzOBrczoIjHtc0wqYNbHZT0NLZR9EhvLYovhAVjpwA0?=
 =?us-ascii?Q?t13J0nNpmQOnr3K1r3gFcJJ03+XJ6vM0pkjntKwFwwT9kR0IlRKJc0KMeZmq?=
 =?us-ascii?Q?LsfFoOyNTmMcnc+SAAOzgFT7wH6ju7hEIpUm+MK+76cC/wmcGsnYIufFJyRI?=
 =?us-ascii?Q?2ACepiVupWswrzH3gV1GEFC1sVGGF5ruyx92onHPUQ4ACJAqicBdkINC986o?=
 =?us-ascii?Q?eyjiHH7cn4PAWI4oXorawOn15prqOeWUfu3Phdjnxtu5ok89c8737oBm3ASf?=
 =?us-ascii?Q?TQ9pByYj06SLUYKAxSWc9vrZ4Wsd7r1ciYSn7kEFOBJTuYP8Jx+sJUG2M8gK?=
 =?us-ascii?Q?+d3OgdGRhl7UkFu6iOUgw/oHEC4ZGDDiLszaFm2mzGoeVd/efJzO8zyzj3uZ?=
 =?us-ascii?Q?ORXMZUTrx5F8yC4j5IbNwz5YH24skkfzr8PfPHw4qbhqMuoyaEcwjskWRXpl?=
 =?us-ascii?Q?/S3cigrq3NSTl+LzyKr09FT6rTKKQzpZrljSq+JY2BCTljRU6Lnw2ZlVTtnQ?=
 =?us-ascii?Q?Juvv9KiwlTqD6WJzX3KDpiciXEPpY45+QNZvsm1dtUArLtfFq9VUaPglfDNn?=
 =?us-ascii?Q?AkN33VndtCRkD9P6JkdEyqn0WrFusVX2ZshNd7qETpDYRt2FyLzP+8TedteB?=
 =?us-ascii?Q?VfMoKL/2Lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfc1243-bb00-42d2-fe26-08de84b787d0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:28:12.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0pCL2VGEBzJ+ItxcvEOAyInz+fX7kzAJ7/JzSRCP9PRvgXhoQOuAwoFMbm4iOpSppYePfYq6rK9c+kB0CXoUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11334

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

