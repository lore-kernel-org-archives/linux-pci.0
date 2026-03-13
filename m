Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBB33C19E;
	Fri, 13 Mar 2026 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367701; cv=fail; b=MOnhtVDKx12cx6EtMF/nQb+ep8LEFCOTzG9pfBKKhYrQPvvSnNoLcBFDn58pPggH5fU2aKKzXPSUbw3o10XsAivKVl/IkHw0E8IQ3vFvgI335D1OWTuXTPBQJPFKknZjkQLHbyx2HIxosbHsKxGhp/yHXgyxbGds1byUkS50Ta8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367701; c=relaxed/simple;
	bh=De5fcYmMwiAApdx2cOAKwngmj90wVTif9YJHS1cSTyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ab5TaIVMzX2dqivJUruXIvZ7OzmURSpinsPLW0gXFXyzvDfAR0JrgvtUWj2Wnq4/d0AhHpX9j4GRWiU8KKa4MlarxS5OftsIYN5O3SXLb4X3Fl2Enioq1NHQn9l3Z8gvT++hgVmf4D14p1i+gvK4PIzvTpnNKqq4mdRBV7U6aHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RyTVaBbq; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RyTVaBbq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toSHJ3kuib0N5MP9Cd0mBYCqSQU0m/+ex/YVaxQwrL9b765DO0A5PqwbMiQARMP/Dv6DXVGLNLKPPGc5VG6DYn1do6oq1aorWnIHn7sqT9X+hDRcohT05AqS5oXt09M1Ufcyq598SLj8YG+0dS6rvbc0ozku+DeG6Fzv9dRGKCbcP/lxfgcWoYH5tJLgfoMV4waX/jts9xO7QH3NvW4M7RvJHMPNBLelh88zyekTl2BWcG7pzeRnjUJhmXkAzkY7L01E4ff5weVMqGVyzuNxg76aPsIEIaWE8U9Eo73p/VaG/HDvbwy8OL0yAxc3IbZMG0ZUHiXxZfSV/+THlbqYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSf4ouKFlxck110aaJ3+1FWFbvHdQLP/LpYu8P/8E5g=;
 b=DTDz8pn3Eu/NGVJqG5zJCraL07H+gWtAApZoOmGznVlaPxxe95zOwXEqkPq0iuqxuBBQ9XhU57vaOcj/aiG9cd3EdTx5MvduSN9vapi7FJNUY/nzJL5LBsEEdihA+moBjkA5VaBs0lsOebgGhq64mufPhYsvxx02wnx9DSRLbYbcSWk+US39s/4d1B6l7biQ76FnZ9PEcAnn+3KxfzrVHYnXpvsxJXQJ35Rp+27fWeZP1S3tRxOUQBtEcz5pD7Lj49ihPqFaLfT033YR7GQb/xFeBuuNTZf5Og0KFVxc4HgScTh6RUXj8K3fKfyHJt50Gq0dztXE+6y/0xIrkpaQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSf4ouKFlxck110aaJ3+1FWFbvHdQLP/LpYu8P/8E5g=;
 b=RyTVaBbqKwd04lvk0L6MKjtUhvCrxih8VshxHnNfZYVt/qG1Mf4sTP6Iyg/VBKNZCozXVmaIe3VaECsyJH4Mf2U1SzlYWJXKiq7j3q1DT46PFDtS1NsMk79nNQJ6f/EuCs46K6ZW+oorFLEEiv9LubpvY1b7ycHFcq8QHeLdC9RiQvx0u1hclejJKQ8xnh26Pzaib7VPgPeFHZKiwjKWnQdvT3Wo33RRQrCw+swMAPngHDnZ06DrA7D1LU4zdWYSCeyvRXQQfRwrIrNLtiso4kwH5O3wYZgEbZmV95C5z4PCDlN+7xl6JmzOOiV5g8z3NIRtQghUn2ZdrWlTLp/Tmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6844.eurprd04.prod.outlook.com
 (2603:10a6:10:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:08:02 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:08:16 +0000
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
Subject: [PATCH V8 05/13] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Fri, 13 Mar 2026 10:08:15 +0800
Message-Id: <20260313020823.1592389-6-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b3c55c1d-ffd9-43f7-3093-08de80a56350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qrnvbdOn81pFm7V6Pb6VKLd60kbSQtWHNPWWsw34pZwhNU2mm1mdwdqqg6zTPm1BBhExjglGuq4CJ4kcpvU3f783y7/v/dgCyRzb+wGh4x0O0rfmMXbUlk6jpbkO/EzpF7GNgTNiwidmGPi/CDKGxBbGzCTlmc1+NxkvPsRk/9pnZ7Jpk8TXCoEV+q2m5DEEu+dWvQXmREm4StkTGCeyjo09Q7WxxBBu07FKsWFxClyD1V+zR4JhE/IOyUmF2fw/EXwzLQw56UxE203DgHyKsHIMt+RZnpavYAyNFZfCfKGL+UYTn0Kgk+xKuQ5DjhVMbiNurEXT//Oezd0GlsNU+MIJRj4iwinPzJiRX0XqH21wvGHYiPay12i5/fmRPXAS9Lg1mplZ3UzUdTFNT+yyytD+7RiE5ppWJHG5Z9QNMvH2cOCI0kbvVaBkhXYTZdjRHBJ2uz47hV+HRGIt1+EUq3Foqez9bAICB0761ThLXyHg213lYhpUV4vUTsi3wAtizZzCUdEEw6nGnXmIcaAKZ+gipV/Ien8LvZ9J4BQRS4PgSZsh6NHz/B9Z5G9fmPCaQBLPpazdvMUz7kujPU7/3x4d2N900uusMbzNfv21IkdbSYsiHSzuMgLBdQSN+OVo2fsaD6fauaC286L1vOVo7FIv4gyCf55+l+HKcViQsdx2vQJNEhg6Cs2fKA71g8RAp6tveR0k8JMSTOQW/EESNb583/bTjZwHjTzPjPLXK76s+gXxR84eSF/g63BCtaG0hpJ1NtHdNnmwlhpAul3ynBXUPJUFKAHe0XOL4k3vdGCKGlONFMtb4Gup1iGIWK1Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a6m1/3KTfFcRx5wwiFKb2O1ss8UDxd6q6ciVLqCj5OE0MT5HZzkaeHacGswn?=
 =?us-ascii?Q?MPQhIZ2FoBEQzz1qycUwXjBSD4T831H1yqu+QQHyUMfqoyJnPIPgqlkgL67g?=
 =?us-ascii?Q?N9KN6i9agKFuxdihp7n0+EONsJ2MWkasdtScavWZDUkukq9D3EcAprACdKqY?=
 =?us-ascii?Q?INad0kTwPTj98IdZVnszzkmURXq4SeszWfv+AES0kOFOlfgSlKTVPqS9qlQg?=
 =?us-ascii?Q?drHZIdXwxnvOLmZ1VUj3EWkPUeQUy8mix6yyxS2yE1woQQ6EwP5SiJSBEpLA?=
 =?us-ascii?Q?QCY7XavSbR++hzeu/GSk9njktr9R0DHG9Bf8qd9kYIYLfSjqqfMvkq3LPAEU?=
 =?us-ascii?Q?2Z8V2cuB/9CQsA8w3T+MyetsH0KDiK25VBZc3xqgjb4Nr4h31yzYH3Gy9yx1?=
 =?us-ascii?Q?WWNducxBN1gcZnyXqDidSpJmGj6PoEXJxezHmHxVuandG5zBpqz0OrugtVrV?=
 =?us-ascii?Q?u2TmpBn+4C+JHZYl6naNHaNysh4CJ0rF01e0uh2MOnGFMv+ZI1ddTvVVBqPN?=
 =?us-ascii?Q?jEt/5oS3WjzP/SfOkmAOk5Q7RMFDCXNTIT7tGq78em4YI1DvGhtqwmGPSzUU?=
 =?us-ascii?Q?c8XoiZPVP106sLK59bf95dL21PL8dBQufeXGS/jc2r1V232scLr4fdJk2BhD?=
 =?us-ascii?Q?M+ddQbwp5l/tuffcemeeWGTmzDSc9/dfG+ClzoTWEDxYG1Lbp2A21+vHlnzG?=
 =?us-ascii?Q?YHtd0GM1EBIDMH6gBTEVquo1RxLeaEbtiLi4/kYL185WpBMrMcVz3PRqc2iX?=
 =?us-ascii?Q?yu5GihTbfsq91lZNHUfG5+S3OOUA22fjQMzOHaQTfdq/+UWaqer+HyQRPsAL?=
 =?us-ascii?Q?oRRTPwvQ/WqqHeOSnN2ZeVpZtV4jtLySiiSfedzM+EJXrfUeWf/vMfexaBew?=
 =?us-ascii?Q?NJNViB9EG7Ck7rzkixWQjCG5Mocw2F+C8to0LLkUx2KzsiSYHqeWtmizsHho?=
 =?us-ascii?Q?M61lXnHWJmZNC26ff1c5ih3NkJS7pQ9Px28Mk6i3niShYRYSXBZaFyPNL9Ge?=
 =?us-ascii?Q?skukYT/FVFY+GWuc7SPXG9sFTwvxLVQv7Rqj8Q9zaAtoLdvoBEuVQhnr93Pq?=
 =?us-ascii?Q?uZ6hv05O3hbMNzvFpOhNGOcI/9i06CCy6pwliQxak3H1wte8b4hSY9YWDE6Z?=
 =?us-ascii?Q?CGmYSdF/4peYGJopOOqvaBr8tamXc7s8s+NFcJ1zXMTYXVpG1cVoRmHIjO5F?=
 =?us-ascii?Q?zztJDFcrk3iOGI8Di3AMZmBRI2bjtvznsGQHl8h+lVlaTS9IOVVWyrUQFP/L?=
 =?us-ascii?Q?SGGLv95UcOYm35SIFK5LiDh49eKMKPxKCEEfk2x6c7Eqj3sFxzvJsxmvdabE?=
 =?us-ascii?Q?KMuj7Rk5LNIsr9re3x9+8C3IygoxPISxhO6z/bgJ9BSUxU+87eiUIeuLEl21?=
 =?us-ascii?Q?G6EWvd0p/gBaKCvqqZSjUIxA4HlXuuRhjBtDOkCa4UDlfz7e2jPbvs8dbhZz?=
 =?us-ascii?Q?QEUmBXRrllApP8clmQx8crUJYaINUN6PPg2uF97R8RK8i8tYGzQmzUOQ7qCb?=
 =?us-ascii?Q?v0V82eJx7VkmS32oKgC2z60ImAMYFdSQJlq59uvZNfMjoRQrvleTGuOYN+f8?=
 =?us-ascii?Q?vXs6+tbaPWtpIXnltsWFxmEty8SKMIB/UwJ/Xb2ZLrHFOVW+0xY9LdNRo9us?=
 =?us-ascii?Q?udWv5UOgWVMIOgwR2hmeBosn6X+l5hRi+XAwCObYVn5CqLzMiIgvuRdTrFsg?=
 =?us-ascii?Q?UGeSlqfLdKt3diDpcX2mE06r5JRuTZWOtysRSdTsYsSOJFFXl6q8fWhfcwvt?=
 =?us-ascii?Q?xtv8iLeQ/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c55c1d-ffd9-43f7-3093-08de80a56350
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:08:15.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAcnXrR9IsVd0/T8G07po094VRT3wNch2hXPqJpxHkO1o8OnApmsHPippNCBCMgXcNiRiK6kVqYqrMcd1QFNaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844

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
index 83beca5a1fc2..cb18e1579788 100644
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
@@ -1249,6 +1296,10 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	int ret;
 
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

