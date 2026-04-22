Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6E1231836;
	Wed, 22 Apr 2026 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850464; cv=fail; b=US8w3hjy1zB1QJUvGrXAXNdyNQGCd8iDnMXTPwY7OwyT4zIfpAefrhFgCtyrA0MyQHeLM8pCVJf0KQI/PQKaeUfM+3glCfgsfDnYJmlbZT9zkTZVXISzwkKeuMyQP2X91ARjcnAVSnPn8APyq9tgf5QEeTBPAfRdU8K0P2phvow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850464; c=relaxed/simple;
	bh=A++ytBZo+0feJHUr1Rvi+b01Dxk7S8vyCF0Sue7S+D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tn9U0jMzs8zoXjssuGwfJB+silTXWd9PAKUlLgElUNNzVMUkoHMTZKxgNdoxVIsapqY25gjb6a94G4fTfXaSBaPQzH9R3pKLU3F77ugYnCQ4k1LeoWFihhlMJn5oaBEj0TI1U4T/JcGIi+2/HcLcu9K0dMdCSvghQKIq8xinn2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TD7m9QwC; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TD7m9QwC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuRs1hSMBiv5zS6rO88PVjKhAGYSEVa2oMSTwUAmuc7AzlgWunIynLskzLwlV0cX/L94+xsZB+M6fdTSRQk13fhihg/nw7p0LG97zG+ftoecwULov2VXrSZJ8GLi2pAZpeinOB+2pc9HfhnDQogRdAtVAoP6qgYA6iErxdJOr4DHYkyiE9ac+GmvwMIdrYnMIrY4aFqtmDHD6z6JRzRp1OMrmu2gfSWGktFPKd4/AFpsdaxHTb/+7pyCDf9d2SPUhnEGEBh8C1jhJHvC+AEC6DhcpPMvd4gTSFRP28BdFe9IInfSoeQ3vBx5S1Utfsc2BVWjsog94mMPkp+8b6TyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXYL9hD7Zb+bYERt9M3ghxoEy0ChaVYvDjQmA1hXq3U=;
 b=MncimihRaBF9sND5bwpvjtPS685piwTx2b1hWLC6VUpg4ghGMSn0yIDfEuInGvP7pYSDr6JS1o3d5Y5WNqiJ3iBjT5cL6iDWZE/pAK5wkLGmVj1MakYi4wjOSQ7tzlc3Oug059imi2RqOUTkOfZ2ilc3V9aHpSuUjLPF1NOSR79ArM5By6ZzqDtaxpjdTpGXLqFpqrjpClqaJK+J59ftJfY4YCOg9kK67wFX6PNlfLgcqYXhnBZBNA2cFjcIq4Zr+yBOgKN2qsTu2t5k7tqZNdpWt2ufAjkqWRpnDtQnGALaLvq5RUk6DUvKMZ/GjTNTg+TBM1pL9E9ZbM6oSPOhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXYL9hD7Zb+bYERt9M3ghxoEy0ChaVYvDjQmA1hXq3U=;
 b=TD7m9QwCS83qM3TZj0gaLePlu4EUWEDDDN2OEbwX+p4BYFqWkkWJdyLJ9fBEE5UW8ExX7nbOG5ruBQtJMaFJh3Ad/EPfMSEGKLVTMy5diXNILSYPJavTkrAuxvo2ild4x96HtMX745N9yHFWllIFeN89fNFQqz0WL6NPSmpm7doZr2ouLEqJ/sdU5+AdqTzAeLlPzRITdMyEBgUqdqoTzySr5y55xe8pEXBKCB0QP1ILDoVMlFWXf+205nrQcmFzT2RdIbK5cZvk2gpF9Z6Hs4yEgNFZY/7EjtNVDysBPNA5wSm3ZtkFYkNCNAT1CV44ySRu/g2pkCGUokrSJT5l2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA2PR04MB10129.eurprd04.prod.outlook.com
 (2603:10a6:102:3ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 09:34:19 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:34:19 +0000
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
Subject: [PATCH V14 02/12] PCI: host-generic: Add common helpers for parsing Root Port properties
Date: Wed, 22 Apr 2026 17:35:39 +0800
Message-Id: <20260422093549.407022-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260422093549.407022-1-sherry.sun@nxp.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA2PR04MB10129:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec5b9a4-9f51-4ed0-cd85-08dea0525461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|56012099003|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	wc9QwWHZEoko3COLD2yUkHkpea+qxW8sAWlp75z90hU+s4kSk6FtBmCotYWyGZpoha94uYTApDxZ9ej41mcL9tFyKSEetu385yzQb3229TOVj3bvCs9Kyl1/rNKAz1yUCmn6TFCRNHYwJPMAljhY81k3Xm25sjbQfjCwsSuIYQpp4Yk5alyOH/+JtnA6FwCWm9URv+Yc1suja35L05xozImeRtslu7KXiDaFFzKPWDT4kyyhgnp4v7LrUIn6MpwAcNyqxNnlc8wgETE17I4nCn0h8cks0I8ghdv/pYXST6/kgJvYnvR49WL1tEQv10MncoyhIodjYWQMuder/mMwl1P/Q66TmtZRm6Tjebzhd7e+pfYUGqOY1qo/bYqJ2183Wd92FeLPJ64HiWJhomLn2OhiSRhIzoGgCKyaR6JECgE5jCv8Vegg0Hz8qMb7+kMUamdfi2oPxerXUlAvySlnQgHA6GXAEAucIlCqhAfxI+Kp1bu7M69KMu5kg1OxoyD8Dzz+BqnqMxWd1F0lbdGydMZAFel7mYdml515eTZYCzYgM4bDzYpjXtRLnrZlrbtREPOIE1izjY1+yskjiazAzJLztHLlQJ7Fnhmu5ZMnktpiLJpYstnKvTGUWutBaQBZjY8/HKZPjDQNicpCS23XUhrverJfJxLw2gl7TWEwvvm8SeDQ91Kij1hKBTseAjoQ1TXNxgZEopx7xm8zwQktLw05cgMOSlExCFelmUWnkHfxji1FRTXa0pbPG2Ol45zGzIOuKScYHSCCxLvaai4KSkNrsAMP5YxdeomYZC4tbRefaHwzI8MwHqQMrqOAhLFc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LQlNFFxPSq94CT81WfB51yv7sqF+FHfkF07tSHLWoVTa83ECcVw3Ccxo1XhG?=
 =?us-ascii?Q?PUkqwcaw0wug80x51VSHvMWijMBuWYuQB1kxpBxC8n5qJUBnOcFf++PYo7X4?=
 =?us-ascii?Q?9v6mXKA9VFKQgteiEo/Abghss4rMDJkJy5RzHRJ9LCEYeXUgQsIbK0CDj5Ju?=
 =?us-ascii?Q?RBdMwAeooCCn5yArLOPxi/HRd0CNRA4dyY3wCZvntc4LX5WxyhXt3zvLeSvx?=
 =?us-ascii?Q?8y/8WiV4bbJMWKr9Du1jUe6e7cd790ynBpKI9vZm0OGTZertlVjm9of9BCEi?=
 =?us-ascii?Q?w3WXhu5E+bfYpzSxdmtxsNcx3R65zee4c2hRjUrdetO8U55CbgJeoVQ7qBD1?=
 =?us-ascii?Q?e4+QAmnLmS4pviEqI/4/4t4r3d3owM5S2TUhGCjO6x8wlA+y0z0pyotUTXMR?=
 =?us-ascii?Q?AmpNY22a0teiF09NY0mg4Yygal+RsWyNVWbebG8vUOTRSpGsO6VxrXAMAwk/?=
 =?us-ascii?Q?zSgI6EZfOZsa5imON6TtlAgCp6FQiGo94fHtsi/yXT65MccEAWZQuqDe34Vh?=
 =?us-ascii?Q?wyKvNiUMR/QzRscMZG3uDb7/pAuQbgFpU3Cts7udCd7rqVXVmibFo40PhUqY?=
 =?us-ascii?Q?1iaq3IHFwWLhxjL+X6wEoTgG7z4v6x3h7Sr/Z90b8VpwKaa35V79zJru5krZ?=
 =?us-ascii?Q?pghL+ef0oxQsL/m2T04YmrrMtUl0TsS2xbJHujkCDGoCuh7HlHhlfyKLS8Yt?=
 =?us-ascii?Q?qXVEDxlYugAAc4fX/Q+griviOfUM4ttYlN+6Dgb2xxWGmis4ybimtuJydKF5?=
 =?us-ascii?Q?cWLAuLa2eQo3FQaqAumTIn4LNbDMRwpkUmlGuR8+wVLppWPn7UOEJVp4usPI?=
 =?us-ascii?Q?i5fVGKpTNHuCdSGNnyV1rzRtsuuTA982pKk2igNl9RqGKqAI3CZbPGMd9m8J?=
 =?us-ascii?Q?tC1s/Eye/qyKNPi8y8GgJP1cZdoRYvW5QUJ2OvcAiOx8SBHZsnPXcWTGoiQf?=
 =?us-ascii?Q?Bjvj64srBNJB+lHdU/gXjCCuub+AVJHaK2nirJeNUZVR0n80AFo0jcFtLNGX?=
 =?us-ascii?Q?RmPxFraUxbQRkDi0auef7nKFP/GZBaQZcHL2KPlcYHVnPT7IfIcfp8bHmBmj?=
 =?us-ascii?Q?wJUMLR4XWJZBly7iJ0SJSivnI+HrrMaD8ESdS30a/3JIdx1ySrmTrrCz/bQe?=
 =?us-ascii?Q?fmnKTQ4XTce11j0olMlhalRGKYBIaDj5Y3EEFbsvP83xw8WB4v9RqXYRy3MG?=
 =?us-ascii?Q?G9MEQth4I/w3h4WrG5qoUGI1dSaq8Voc6CwsPXoGzjEgYa6FLef4IwRsWi2d?=
 =?us-ascii?Q?UgOwq02RIbKbIyt1ayAF/LsXb5CD6ErfON7nVhXdpEp9X4mQkQoUceaHOvPP?=
 =?us-ascii?Q?Lyd7AiPmtHrqomJR42Yqvhd78yv1s0nLm0qyvYCCNAFK6r78l87C6dFDbLkl?=
 =?us-ascii?Q?Ke00QzOzixVySlNUCkMz8JVRCFWoyFd/gdYx/OsQD4dEDnEuiHSrD0ZVtQZC?=
 =?us-ascii?Q?haG0JLEWKbA5tIovd9lXuRW8LMOacdZc81U2UXAOicEH7IQXuhuMFtrceAGW?=
 =?us-ascii?Q?BRj21LnW180lFAoHCJu25L/PK3ZZZbOw4dyba5z4Lin1Vk840Owa8H64qzIc?=
 =?us-ascii?Q?H4EbeSFQ8sUIiyHI7otyBNRYLjPH1EqgAqzmrATdCAIW8+v1GjmK5vZE5V+O?=
 =?us-ascii?Q?Q1OQefe2kUkJ94ZVPPd75mL4gmzphC1lzYGXNVdjb2B5BNlLcnuHdfTX8FlU?=
 =?us-ascii?Q?NB6ZWt9d/VkEOdQsQecWgVoJ6u/Jn++YRvNEDU8Nd+gjMvvKwVwFv1pcnnry?=
 =?us-ascii?Q?z4F0lixd0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec5b9a4-9f51-4ed0-cd85-08dea0525461
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:34:19.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HtRdviUSr41HisYj3pnaGYjbRqBroKfO5PVlMxEwA2eiTIQdjMxEsjLMmOi32nZ1b+CfVuIOSMF53dLDURdfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10129

Introduce generic helper functions to parse Root Port device tree nodes
and extract common properties like reset GPIOs. This allows multiple
PCI host controller drivers to share the same parsing logic.

Define struct pci_host_port to hold common Root Port properties
(currently only list of PERST# GPIO descriptors) and add
pci_host_common_parse_ports() to parse Root Port nodes from device tree.

Also add the 'ports' list to struct pci_host_bridge for better maintain
parsed Root Port information.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/pci-host-common.c | 164 +++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h |  28 ++++
 drivers/pci/probe.c                      |   1 +
 include/linux/pci.h                      |   1 +
 4 files changed, 194 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d6258c1cffe5..77905c728d0d 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -17,6 +18,169 @@
 
 #include "pci-host-common.h"
 
+/**
+ * pci_host_common_delete_ports - Cleanup function for port list
+ * @data: Pointer to the port list head
+ */
+void pci_host_common_delete_ports(void *data)
+{
+	struct list_head *ports = data;
+	struct pci_host_perst *perst, *tmp_perst;
+	struct pci_host_port *port, *tmp_port;
+
+	list_for_each_entry_safe(port, tmp_port, ports, list) {
+		list_for_each_entry_safe(perst, tmp_perst, &port->perst, list)
+			list_del(&perst->list);
+		list_del(&port->list);
+	}
+}
+EXPORT_SYMBOL_GPL(pci_host_common_delete_ports);
+
+/**
+ * pci_host_common_parse_perst - Parse PERST# from all nodes in depth first manner
+ * @dev: Device pointer
+ * @port: PCI host port
+ * @np: Device tree node to start parsing from
+ *
+ * This function recursively parses PERST# GPIO from all PCIe bridge nodes
+ * starting from @np in a depth-first manner.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+static int pci_host_common_parse_perst(struct device *dev,
+				       struct pci_host_port *port,
+				       struct device_node *np)
+{
+	struct pci_host_perst *perst;
+	struct gpio_desc *reset;
+	int ret;
+
+	if (!of_property_present(np, "reset-gpios"))
+		goto parse_child_node;
+
+	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset",
+				      GPIOD_ASIS, "PERST#");
+	if (IS_ERR(reset)) {
+		/*
+		 * FIXME: GPIOLIB currently supports exclusive GPIO access only.
+		 * Non exclusive access is broken. But shared PERST# requires
+		 * non-exclusive access. So once GPIOLIB properly supports it,
+		 * implement it here.
+		 */
+		if (PTR_ERR(reset) == -EBUSY)
+			dev_err(dev, "Shared PERST# is not supported\n");
+
+		return PTR_ERR(reset);
+	}
+
+	perst = devm_kzalloc(dev, sizeof(*perst), GFP_KERNEL);
+	if (!perst)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&perst->list);
+	perst->desc = reset;
+	list_add_tail(&perst->list, &port->perst);
+
+parse_child_node:
+	for_each_available_child_of_node_scoped(np, child) {
+		ret = pci_host_common_parse_perst(dev, port, child);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * pci_host_common_parse_port - Parse a single Root Port node
+ * @dev: Device pointer
+ * @bridge: PCI host bridge
+ * @node: Device tree node of the Root Port
+ *
+ * This function parses Root Port properties from the device tree.
+ * Currently it only handles the PERST# GPIO (including PERST# GPIOs from
+ * all PCIe bridge nodes under this Root Port) which is optional.
+ *
+ * NOTE: This helper fetches resources (like PERST# GPIO) optionally.
+ * If a controller driver has a hard dependency on certain resources(PHY,
+ * clocks, regulators, etc.), those resources MUST be modeled correctly
+ * in the DT binding and validated in DTS. This helper cannot enforce such
+ * dependencies and the driver may fail to operate if required resources
+ * are missing.
+ *
+ * Returns: 0 on success, -ENODEV if PERST# found in RC node (legacy binding
+ * should be used), Other negative error codes on failure.
+ */
+static int pci_host_common_parse_port(struct device *dev,
+				      struct pci_host_bridge *bridge,
+				      struct device_node *node)
+{
+	struct pci_host_port *port;
+	int ret;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&port->perst);
+
+	ret = pci_host_common_parse_perst(dev, port, node);
+	if (ret)
+		return ret;
+
+	/*
+	 * 1. PERST# found in RP or its child nodes - list is not empty, continue
+	 * 2. PERST# not found in RP/children, but found in RC node - return -ENODEV
+	 *    to fallback legacy binding
+	 * 3. PERST# not found anywhere - list is empty, continue (optional PERST#)
+	 */
+	if (list_empty(&port->perst)) {
+		if (of_property_present(dev->of_node, "reset-gpios") ||
+		    of_property_present(dev->of_node, "reset-gpio"))
+			return -ENODEV;
+	}
+
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
+ * Root Port properties (currently only reset GPIOs).
+ *
+ * Returns: 0 on success, -ENODEV if no ports found or PERST# found in RC node
+ * (legacy binding should be used), Other negative error codes on failure.
+ */
+int pci_host_common_parse_ports(struct device *dev, struct pci_host_bridge *bridge)
+{
+	int ret = -ENODEV;
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
index b5075d4bd7eb..6b4e43e6ff22 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -12,6 +12,34 @@
 
 struct pci_ecam_ops;
 
+/**
+ * struct pci_host_perst - PERST# GPIO descriptor
+ * @list: List node for linking multiple PERST# GPIOs
+ * @desc: GPIO descriptor for PERST# signal
+ *
+ * This structure holds a single PERST# GPIO descriptor.
+ */
+struct pci_host_perst {
+	struct list_head	list;
+	struct gpio_desc	*desc;
+};
+
+/**
+ * struct pci_host_port - Generic Root Port properties
+ * @list: List node for linking multiple ports
+ * @perst: List of PERST# GPIO descriptors for this port and its children
+ *
+ * This structure contains common properties that can be parsed from
+ * Root Port device tree nodes.
+ */
+struct pci_host_port {
+	struct list_head	list;
+	struct list_head	perst;
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

