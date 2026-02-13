Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F32257827;
	Fri, 13 Feb 2026 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770955684; cv=fail; b=eBIaIcF+rELfdbk9tXc4YGhj6/kSv5YWPsNAvZldg5nXAEYLhGeVBKdbXSGli9ENWlEadtPqEK5GFlIXYkKABUCWxqMiVrFXx+tDAkRxNWZHLu3ebEYUWy7yiJTqro2CHds+seJW1jQA5P4kcvlXOearaRyMPZvTU0ErF8xoidE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770955684; c=relaxed/simple;
	bh=j8xu8Ac1lxSClW6UJgv7Mf6RV4SNEAlMfoiGxAGVmsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FfbEpaXzQ0REax5ux6uP3rELt9dv7pmpBa+xRohEc6bougSQ71WKrvmAKEAwTXglBRv7oVwEzKtETQzOKaCjyOqfQNWIBwNlMKWj1/f26eJdekEa4HTJZ7Llvq2NToCN6gIBQNK1tXWHar844/tW69SyvjXom3xsWjlc9S+UqII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PhkWFd+y; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PhkWFd+y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkiQynQpRnmxmzX/iuaQGelRPB0Jru7FlysUQIvjmczCfMOyHoVtwMcKrfIVukG9CfqxhIPyD0x73Jy98f4P9Gvcnv3p+knhiCMu+7Q4zJwK9A49Wgu6krHmvZCgFgv8DCxjWS1ZbplGX70Je0jpx8uycg91IPLg81h/YNgbNK0FB/8+WbdYC6KnRGxLYcsY/JAcGolovTSvkQ0WrODqg9BNiW0szOPEVuj37BRwKG/zl/KqgSdBkok2XGj4dUz4ky2G23nOU306WrxXOUZv2QKVRCUDA5orNjQbzw6tEj0tEUXtF1XbS8U211V1bAloqqszYB7oGwSV6BrhVp0P1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIHMzao6q7mHLITiHxszZd1eNVv/sqTBFfWLjT9B00w=;
 b=RjNlgCkuxHihuZc8PXbFsr/2O+t5PcUzBivACtohZS020+/MgS34FeC5qC3svkR5Cwah97h/bW5V8NkEQefrl44L353S9rSK/bIkXUaeWEjXEtKYDWXIgWH8ADc5Ir9q6umKrCM9DNjJB1dMNUEEBFaX2NPGaTg9bVZQ6906UwpMRirdPXO4gpNeZ3eUtHUH7cOfYYhGMuYBUs63MvEobZSGZdsmn3obPU3UhKwditSS/W8K/prq+xnToYjRIiHEStXHJMNFSjkC+fdKEqfAt2g3hd38rtsmJrZw/DQFnDem5d+a90B5VkBy9rclyO1dDTdUCpgBRcjwEr8+wDt1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIHMzao6q7mHLITiHxszZd1eNVv/sqTBFfWLjT9B00w=;
 b=PhkWFd+yF4bCQZx5NrLs4/V1yqeSi0NZT6IKsKo+o4cMCLgjE23oVPfy9LPK+ORDoXUHXLthu4OTMD574BbjDPs25JcpifuJnHgm5ybSZX16cxBC1skavlAWkIyLtUrNoAB+MD0qUYeqiglu45lBoEkb+cnlfmeW4+YT8uPH4F0loZprLJjvxiXOiQGjlesihCQ1rdn1bOgtcmJRMvbr0YbCy+p9Yn/JPwRoWI1oeYTDHah/Ui3CGf2v22/38Mr700IMAwoBG2H83HtBLIN8DIe3fMMgKmMdRDTtzUaLQL560QnYkeggl3ZqjQU3ZLVaQiYzMjtHgAXDf2DkTUKlQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11900.eurprd04.prod.outlook.com
 (2603:10a6:10:61a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 04:08:00 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 04:08:00 +0000
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
Subject: [PATCH V5 02/12] PCI: host-generic: Add common helpers for parsing Root Port properties
Date: Fri, 13 Feb 2026 12:08:42 +0800
Message-Id: <20260213040852.3340547-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260213040852.3340547-1-sherry.sun@nxp.com>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DU4PR04MB11900:EE_
X-MS-Office365-Filtering-Correlation-Id: 5619b055-ae0a-4e09-3eba-08de6ab57a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qK6OzdDkkaFHkr9pZPbHeGCdWJjlJKvpHwjt4eeG13PPSWk5z0pji3DyStie?=
 =?us-ascii?Q?iOh0wj4FACQ9O4gAQyCxjTvZ/Wv8OEgSvEmLc1N7ljzLyXcJtPgRNdJP3ji5?=
 =?us-ascii?Q?oqLKqpmyIaDV7roJfwROFZvGKtHddv7HZcfB3DrLiePGY9rsp+sZxGSrrbqU?=
 =?us-ascii?Q?w3W9e9KJuy8/pff2paMb1ZP/tJ9YSjiVyhj7la89EO7ioHQXmudPDziAFkgH?=
 =?us-ascii?Q?hOvaIA/3o5n8NYLAaOO2kQSbovANENXMKAEy2GVk7skC0lq8e5XDhpo0cXZe?=
 =?us-ascii?Q?rq9lxFYOq/2VZe7cSdjLMfOBhgfjpm8FOXFO/bd8akOkL83NP36nkN+mvRK0?=
 =?us-ascii?Q?mRyXx2uY6davzN7cXqHRI1HRa8jlxh5/zDZ9Ggmc9lWuoaOptvr/cixCSMCI?=
 =?us-ascii?Q?proWMm3jZgxTKAwVshiMILQsomaM7be6RVQYxU4lGR/IQB8WXOx1Q4luxXS1?=
 =?us-ascii?Q?bXcJHROu4ovGDRmoo71HD0Cg12WFVd3F6J+s/MSNdT1KVAQ68chHV/0m3phH?=
 =?us-ascii?Q?7C0FmwSGgBwTDS+C0chX/lhVd38vFCZseLHetnrPiQmGRN+eG4ZuCk+le57H?=
 =?us-ascii?Q?j+rS8ISWwBOu05IzP13eauFaf9tToUv3LbSyTKt6SJP6ScU49i/f+Ewm/W7Z?=
 =?us-ascii?Q?WjxDeJipxvPZYMFY0jVRl23Rv53DHbCtRZv4EjrclLToDNHLuvt7Re+yjQEc?=
 =?us-ascii?Q?7kE1tA9vNC1gi1uz99jj5epAFm6Mqu2knAZjSgDaHGsUAVhKHlWuzf/To+Io?=
 =?us-ascii?Q?IBXAVr6yRQYBBmFYM6Gp05p+chlPerCIb52pYMtbppZXyxQesyT8SEbIakTq?=
 =?us-ascii?Q?kejahUiFgH4cGGJoP1vEspEu8LarkO+PDcFDGG4cvd0vTB5gAvzW2AVmnsyP?=
 =?us-ascii?Q?ZhBmNr+ghMAnsb8kbt9AWH3Ho0ouTxvPFGOuFfNe8H8Q76PsAKlGv6irHHTo?=
 =?us-ascii?Q?zCLgZHVsZYXPKeuST6k8Uu09hnrFgkNRshVVKwZrY8ur0Kx0qopbqY3H27WK?=
 =?us-ascii?Q?0rKv1rSNkHAErJS0McLFkAJE+28MOKqNERV/HcjdNSetiZPrKBqPIAHvDwCZ?=
 =?us-ascii?Q?AM10MgU9rPfF60ZbsOQFS1enBXVxq7+VceRH65sya6gS4MfG2MEOqGJPpDB0?=
 =?us-ascii?Q?w5qqYtKUe3chh8khVQZQeDf3//kVz/SYLrx/C9wRFvIn3hgVTvGJ93DYa0JJ?=
 =?us-ascii?Q?fflu719vAFsD0ttv+SFTxR2Wp0jaxmojZHqlgGK3QbGuz3RnxPmne8BaQUBn?=
 =?us-ascii?Q?yul2js3cH8hAw0yZ3t2JfVf19eUN4tsUO3BYhwOwioIkXZGyTVyCl0JiWk0r?=
 =?us-ascii?Q?MSzBDjQSRvfKx78VczXm4N6PBZT5hlm1KJqDs6GKhwem0UmuHM9xIb0WrSUH?=
 =?us-ascii?Q?WMj3WXoH3HnK8XTGUjIqRWuT2M3A4kz+u7x7IMU7mr9FG5dgW6BXG6MZmYWQ?=
 =?us-ascii?Q?YsQX4cp+dxzHdYe5O1L8V1EgKHtu5S00fnpgYYrj/L3O9L74JBnevLuM8TWK?=
 =?us-ascii?Q?5B7P9PczchzM4O+44FV6/zmI1IwoUmNNydCKFDkp9Hxxvgb6v0yq+mz8k6b8?=
 =?us-ascii?Q?fDRKRfDfdBd+VPveGA/knKHsjKU2mDnte2MnzStkh4b9JpmgTE1eQrnMMK9g?=
 =?us-ascii?Q?831vTLW9PKTGo0N29TSy1EU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+V/Z1xm1Gl9TVpms2ZIAKEAgcq6UU8/MwFWxvau3deISeCPXidIjGvXosjgL?=
 =?us-ascii?Q?B5J2gvz7UpIbBDX7IptkjfrRVMWQazinG76iICI2QWW9f5xmVx6qlPtM2ZEI?=
 =?us-ascii?Q?v/ZkCvJtgzAnGUVYfbcOxiwgoRZDhAIbW0LPJxg7BPfRYstMJp1Kqgbs5c6j?=
 =?us-ascii?Q?hyjAPZuTZPzhqPdupPLt9lunXf9g2mZ4o2cJKbFWUq0CbUPpRDvy5+wV5J03?=
 =?us-ascii?Q?YSlBHAAtbeN56VCYciAqgwG44KlewgJwaJdYbaBasZ5Dbo5oSPI2GjfEb1OC?=
 =?us-ascii?Q?Sq/gefzc534gtYLWsAmEhkitq9i+qNKd6nHkzkWZYtOrhqu17gvx7XdEATtz?=
 =?us-ascii?Q?dCAY4CdzbvAxz2nenz5/h0XlBjLi06M9BwBf5FxIqtflgD6vy4zvdOZc2yAF?=
 =?us-ascii?Q?TxLD4hhcy8qYLomb/cjsf3Rn0I/yxdZFmlGDtPwEwXxpaw4H9ZEukO6LOsAU?=
 =?us-ascii?Q?qS/igRPLNvJQTnbqe32bPy/iKdiqyf9NnOpk2b7fi+xkFrQRWEuJQUC4Xobl?=
 =?us-ascii?Q?/2KicujuDTr17sfBE5OzX4Z3WrQbcCLxig26ro5xOuFCXqaJsW4Ya/p+SBGv?=
 =?us-ascii?Q?X5bdUPn3mU81qedF+RCWRpLSbYpKd2RhnU5/EUMCEI7lqOZjzorn3gTtVB67?=
 =?us-ascii?Q?7tzJSlK+Vc92FUozp9tymv8r193b42ViOU5BsrYPX2zp/aE11iPFiJpidcuY?=
 =?us-ascii?Q?Qb4gGhtjDp4c6A/db+FxI+pVqK88kCFDXYJvCRjKghvKGHRYg4min8A2GJRG?=
 =?us-ascii?Q?8P7d9QlILEL3c2Tej4/xqZwRk8lAOMEzB0FocYTEA2pFSbJY+gpoQljE92O1?=
 =?us-ascii?Q?CeHj5vIgEDsFvjnUw8h2EeKacdJaJx5fOAd0yUTW/8h3vqdBjBL3VPgwAvUp?=
 =?us-ascii?Q?zNk195RsLENSVsdNhhR3Ya0c4bX15AOYKH9PpIyj+40msLC/yLuuJL7wy7rZ?=
 =?us-ascii?Q?J8Zi+geInZYWmu+Dq6kDU1+PZGs0u5Fu6l/u2VuvmjV29iqxOriQ1finKfV3?=
 =?us-ascii?Q?tNXxykpOCT7b0vsZ1XoNsvFCoW0atxdd8aYICG0NTi7/3PnnurNa0m2iaG3f?=
 =?us-ascii?Q?EqJM1jHP8OKs+JP7JtQOlnfeyjRqo3tXJc8qBGLygDNjFMZO2co8JhP58giN?=
 =?us-ascii?Q?6tiNxoy5CHwtyDUmNVsZZQkr3leUpdlnPSP0irxBBWYWbmrDfvcX2t4cpzed?=
 =?us-ascii?Q?8avQM7LgwRR7lhuZvdxC4hp9JksTCtDe9nAhIK1jxt16aCBfyeU0LVMUXxXJ?=
 =?us-ascii?Q?bE3D91XXVEiuzAYhTHIeIVQGkQbQhM7tX6QuNX1Ook+ynN9S0AYMNTpPtISb?=
 =?us-ascii?Q?VT9eJhQB47T8UAI0WDcyk7dPTSF34mP0auezOMLu6eV6+VPRwlATymgkDrr3?=
 =?us-ascii?Q?jZe29NIpgsSM/sTmRniicNupBk16k1OAPOufQQdqd9vaujfQBfeeaqhDeHF4?=
 =?us-ascii?Q?CmZabDUx6KQCgnU9lAhgawjN72a7GjyOaTZE1s1AwK7R2zGssQlDjGNaJQS6?=
 =?us-ascii?Q?YvwGM0KHXMieYfhsscBiCWP8cUXiRLXJU++5ZUVPQ4X3/32NCmZmsxED6BIO?=
 =?us-ascii?Q?KNBnToGBMlNUxVq8Qu6kx/d/vNXNTaDEq7okG9S9kJKn2W0MHYhlTITDJrKz?=
 =?us-ascii?Q?fAbd4qIk4yiwoT9TzJOvbBFuGXxhSH7whxwVs6OhYux/F+OzUCc75fDIZSX1?=
 =?us-ascii?Q?l7iFB5GfSXxyYTTDs4n3rs0XKgtL4XVvdsjAPkMzYaWcmAnLTLWFLZE9iTwJ?=
 =?us-ascii?Q?EbtI5UXtDg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5619b055-ae0a-4e09-3eba-08de6ab57a1d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 04:08:00.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6WwiAdiOW/cz6ZzTQsio8PppQB0QVHFJ2cE+wQHFDJoDJgQhLcIjnw6yKNmimjTy2Gczr3EVqelMDyKguWPIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11900

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
index d6258c1cffe5..0c35907a5076 100644
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
+ * @bridge: PCI host bridge
+ *
+ * This function iterates through child nodes of the host bridge and parses
+ * Root Port properties (currently only reset GPIO).
+ *
+ * Returns: 0 on success, -ENOENT if no ports found, other negative error codes
+ * on failure
+ */
+int pci_host_common_parse_ports(struct pci_host_bridge *bridge)
+{
+	struct device *dev = &bridge->dev;
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
index b5075d4bd7eb..25d808319836 100644
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
+int pci_host_common_parse_ports(struct pci_host_bridge *bridge);
+
 int pci_host_common_probe(struct platform_device *pdev);
 int pci_host_common_init(struct platform_device *pdev,
 			 struct pci_host_bridge *bridge,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2975974f35e8..007a3fb8da86 100644
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

