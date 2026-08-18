Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C6391E54;
	Tue, 18 Aug 2026 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067503; cv=fail; b=fNeCOBn5vTjU6QvyiXS7VcvGQTnxYR/cxKZf6O9X40ud9mJdv0stGWO5uU3bWX5LkFec0S9FDYPdvDJ8GeHeNpUsEhX8Na5gubHLh1gBafoywYP44w1iIh4JTcZk1sJSkqFIwO2t45x2JYDAbRn1aGXhjAlelfgHLtwsB0WP7y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067503; c=relaxed/simple;
	bh=LNjFn0z5Rn1XQaVAacXlshvY9dK99wiyI5NIjEkUxyw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S21Pi+IUxfqlEINevuKyXGe+I7nRSl/w1mNTeF4mnQ4RzwdCAgHmp5j0vCcg/Dsd+TEgfSZikA0P2LFcocAU/P4IfLVAO4ijO2EzaDCa8J/eehbDlewkVvG8Ez17lSwdQCgUXcICJX+jMO/XrdwNwR+wL3+dloaMR960F5WAWmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jVHU8Obb; arc=fail smtp.client-ip=52.101.53.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jVHU8Obb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+TxXEHvmPlJwnin13HUlmLzOFY8bh06nfKpKwWlDrVsS5EFzPfD43esTlmJh4xZrV5NlUjAex3tr2ldUNoUnG2l38Mu8sPSUqpIxwK0AQlSxBPFsrrNMiG2eMvzQINd/24fQMTBKqt76gyQOHCVbT1YqN6+EJXmCeNfsVFf2+Nz55FDoK9+rOOB9n5fef6oEDRsn89aj/FLLVurZmXnCAkz1D/bv1OGOFQXdntRUlPyUjMukTpIcccUGFSVnjowWlgMJsdX4nJmE6TtjM7U5EuQW9z6azDnHfsef6PD3vIVRAqXLIrOpelBqjb+bwQYoOtaDvNtdDPvykxVI+TuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCqS1BGOaEu5eREVK/G6jAi3UcYr3EhOdgC2wox4eOU=;
 b=hvpR1XnaGsFJBDvnVLsEl215KH2A7h5LNgfCV56UcJvtX5Ct/53Z0FC3atp4y96+bT7Aq6EK5chaXwupx2AOZQ21bnEgRxgNefHmUtSiXxzd8lzL+Fo8tXg8ba0iQXUCl5b6Sq88HpXHJPZzsssv8Hy9kulfzAqm7wkPOF2nsphh1zNiNxhne++pmWbNl/jlKekLWRn9lKYUarIdMYclxbQpjzDKvG6Fq7fwUm9YOGfH6n+fJwsaH86xQ8wescZVj760OvYk8QphaoqBr3jh2SYhbLxpjz5E3ZrweEBeyLa+PQ9U23HvGM4eM2i712t+9dDeTUv7CD/bZqE0BJmq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCqS1BGOaEu5eREVK/G6jAi3UcYr3EhOdgC2wox4eOU=;
 b=jVHU8ObbK9dqb5O8Ms3VTe3x0o/eO6KJDk3pgDjTTWF6wiAMqaKHANdHZHxc4K4yFACJKD59EAPP+C4NFi9FDYGMQmxVA84X88f4LdIV5wnRUhybFGwqc6wXK7Tgyp3Viit65LhJWjU7SOye8bRaiXICEdsbrWZCPgVKilg7gNo=
Received: from DS1P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::14) by
 PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Tue, 18 Aug
 2026 15:38:16 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:451:cafe::9f) by DS1P221CA0012.outlook.office365.com
 (2603:10b6:8:451::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 15:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 15:38:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 10:38:15 -0500
Received: from xhdlc250064.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 10:38:11 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v10 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST# signal
Date: Tue, 18 Aug 2026 21:07:55 +0530
Message-ID: <20260818153755.3801111-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260818153755.3801111-1-sai.krishna.musham@amd.com>
References: <20260818153755.3801111-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd92ff8-775b-4995-a01c-08defd3eb849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|23010399003|11063799006|10067099003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mcTslZlKEAOI9xcPZuvfueHVhL/YB0CWReLCPQU4ZWkumtxWd0mjlcw6XrUXZEElTdcdble0H9wKGJ5JA2nNf5vJvt7gcYhPuSPJXCtScheZKcIZfVIoQE8ulfvi8b5kXb+5Hh8GMPXh2pud03F3d9qPHmcoqNTL9pmLSMMwP6ICnf7Vby3aUpaLDrypklB0DbNEcA0rOaS2SHhgouz3hYvE3TwYvH2YY80+ZYzUa4NQNKR/Me72pec3VCdI+L3IBPhwd2vAl5uhOmrQIrGsBkD+8NdlNAgmsS2NRtsh6UU9J4jE2mCLmRVZs5FTWhAO86wGhjVc4fYrOgOdKCIYnnlTWGGQxNSUafSWKfO8VdFmddIf6pGO6ejZ98NjZOMZzcdqigTUFzxCZg1z3ufB9GFNnIElKH1kCChfn0VHmL6j2u74jFu0P9+Mlx8zYZrC1i6vczbnVuY+O/hH+MHnSAVP1ZyZ1JMIkmEpHsEA0XOz5eAA5n6gkQ+QEnBYNJDwO146dHKNhdq1inBp5i3tYYKU5yb9O3zUBLrjRY5RD2wHvnV3OPjcv76tRlroZMQXz9GQI7iyJhsxQyebVifqrYuDscmbEG+qNRpkNCi/An/jnhxNLot0GXB4E1ZD5ov/2VjaC4QVTr6oGYboKNaEmVxkvftIZOG/0oQOZIP5Awr81CMqeoa4D93926Ib5Y3wZO7YHHSBlwq0AMUQ4Wwxyw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(23010399003)(11063799006)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7i0kcLCcwHZDpb3FYcdallHnv2MYdttgPX0rDuIerRF2V0hfuhD2FCQG31wkLT+YP3ZeoY2XaAxtpF/oQcMBRw0fHO4LFkt23x2wryQcCzY9HHhVpKXYQHlhR1doOLzPxNJsKysw924fJis1OEeDTDiEuA4Vnea4WV9a4Ak/TdzBX9VTHRv0ZOhW27MBKLqDQlA5jW0I4mqoqsVhChCWu+xZ/cg1isAnQq/NrfdGH0qG3lZ55XkIsBN2/r6IrQMPPGPEp0/rbEPZQ3yXWepYdFS8icqO5cf0VOoIuVPmFCKSw9UCeSd3ng6mh3kahdII+qSMxNavoVa+wzSP8PpVF0U8czMhlsy76Dc4OJwOIyPO59iLsGBC8ejfHfZTcLjOF8NTlf+GZnQeo1d+0xo6sCpYBtYhkAPszlqpr26eVLzOKhHwDTDpHAYlQ1GTqGK1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 15:38:15.4206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd92ff8-775b-4995-a01c-08defd3eb849
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858

Add support for the PCIe Root Port PERST# signal using the GPIO
framework, along with the PCIe IP reset. This reset is managed
by the driver and occurs after the Initial Power Up sequence
(PCIe CEM r6.0, 2.2.1) is handled in hardware before the driver's
probe function is called.

This is useful in warm reset scenarios where the power rails stay stable
and only PERST# is toggled. Applying both the IP reset and PERST# resets
the Root Port controller and Endpoint synchronously, improving
reliability and avoiding lane errors.

Both the reset GPIO and the reset controller are optional to keep
backward compatibility with existing DTBs. Also add a PCIE_T_PERST_US
(100 us) macro in pci.h for the PERST# active time (PCIe CEM r6.0,
sec 2.11.2, "T_PERST").

As part of this, update the interrupt controller node parsing to use
of_get_child_by_name() instead of of_get_next_child(), since the PCIe
host bridge node now has multiple children. This ensures the correct
node is selected during initialization.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v10:
- None

Changes in v9:
- Fix reset sequence when only PERST# GPIO is present.
- Replace mdelay() with msleep() to avoid busy-waiting.
- Remove explicit declaration of `pcie_port_node`

Changes in v8:
- Use resets framework for handling PCIe IP reset.
- Update source to parse reset-gpios from child node.
- Update PCIE_T_PERST_US macro in pci.h
- Remove PERST# support for CPM5NC.

v1: https://lore.kernel.org/all/20250224063046.1438006-3-sai.krishna.musham@amd.com/
v2: https://lore.kernel.org/all/20250226124358.88227-3-sai.krishna.musham@amd.com/
v3: https://lore.kernel.org/all/20250227042454.907182-3-sai.krishna.musham@amd.com/
v4: https://lore.kernel.org/all/20250318092648.2298280-3-sai.krishna.musham@amd.com/
v5: https://lore.kernel.org/all/20250321114211.2185782-3-sai.krishna.musham@amd.com/
v6: https://lore.kernel.org/all/20250326022811.3090688-3-sai.krishna.musham@amd.com/
v7: https://lore.kernel.org/all/20250414032304.862779-3-sai.krishna.musham@amd.com/
v8: https://lore.kernel.org/all/20260807123507.3418671-3-sai.krishna.musham@amd.com/
v9: https://lore.kernel.org/all/20260807140205.1070367-3-sai.krishna.musham@amd.com/
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 77 +++++++++++++++++++++++-
 drivers/pci/pci.h                        |  9 +++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index d38f27e20761..1fdd7f920590 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
@@ -16,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
+#include <linux/reset.h>
 
 #include "../pci.h"
 #include "pcie-xilinx-common.h"
@@ -113,6 +116,8 @@ struct xilinx_cpm_variant {
  * @irq: Error interrupt number
  * @lock: lock protecting shared register access
  * @variant: CPM version check pointer
+ * @perst_gpio: GPIO descriptor for PERST# signal handling
+ * @rstc: Pointer to the PCIe controller reset
  */
 struct xilinx_cpm_pcie {
 	struct device			*dev;
@@ -125,6 +130,8 @@ struct xilinx_cpm_pcie {
 	int				irq;
 	raw_spinlock_t			lock;
 	const struct xilinx_cpm_variant   *variant;
+	struct gpio_desc		*perst_gpio;
+	struct reset_control		*rstc;
 };
 
 static u32 pcie_read(struct xilinx_cpm_pcie *port, u32 reg)
@@ -389,7 +396,7 @@ static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie *port)
 	struct device_node *pcie_intc_node;
 
 	/* Setup INTx */
-	pcie_intc_node = of_get_next_child(node, NULL);
+	pcie_intc_node = of_get_child_by_name(node, "interrupt-controller");
 	if (!pcie_intc_node) {
 		dev_err(dev, "No PCIe Intc node found\n");
 		return -EINVAL;
@@ -469,6 +476,22 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
 	return 0;
 }
 
+/**
+ * xilinx_cpm_pcie_reset - Reset the PCIe controller and deassert PERST#
+ * @port: PCIe port information
+ *
+ * Reset the PCIe controller and then release the PERST# signal so that the
+ * link can train once the bridge is enabled.
+ */
+static void xilinx_cpm_pcie_reset(struct xilinx_cpm_pcie *port)
+{
+	reset_control_assert(port->rstc);
+	udelay(PCIE_T_PERST_US);
+	reset_control_deassert(port->rstc);
+	gpiod_set_value_cansleep(port->perst_gpio, 0);
+	msleep(PCIE_RESET_CONFIG_WAIT_MS);
+}
+
 /**
  * xilinx_cpm_pcie_init_port - Initialize hardware
  * @port: PCIe port information
@@ -480,6 +503,9 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 	if (variant->version == CPM5NC_HOST)
 		return;
 
+	if (port->perst_gpio || port->rstc)
+		xilinx_cpm_pcie_reset(port);
+
 	if (cpm_pcie_link_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
 	else
@@ -512,6 +538,42 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 		   XILINX_CPM_PCIE_REG_RPSC);
 }
 
+/**
+ * xilinx_cpm_pcie_parse_port - Parse the PCIe Root Port child node
+ * @port: PCIe port information
+ *
+ * Read the PERST# GPIO from the Root Port child node.
+ *
+ * Return: '0' on success and error value on failure
+ */
+static int xilinx_cpm_pcie_parse_port(struct xilinx_cpm_pcie *port)
+{
+	struct device *dev = port->dev;
+
+	/*
+	 * This platform currently supports only one Root Port, so the loop
+	 * will execute only once.
+	 * TODO: Enhance the driver to handle multiple Root Ports in the future.
+	 */
+	for_each_child_of_node_with_prefix(dev->of_node, pcie_port_node, "pcie") {
+		port->perst_gpio = devm_fwnode_gpiod_get(dev,
+							 of_fwnode_handle(pcie_port_node),
+							 "reset", GPIOD_OUT_HIGH,
+							 NULL);
+		if (IS_ERR(port->perst_gpio)) {
+			if (PTR_ERR(port->perst_gpio) == -ENOENT) {
+				port->perst_gpio = NULL;
+				return 0;
+			}
+			return dev_err_probe(dev, PTR_ERR(port->perst_gpio),
+					     "Failed to request reset GPIO\n");
+		}
+		return 0;
+	}
+
+	return 0;
+}
+
 /**
  * xilinx_cpm_pcie_parse_dt - Parse Device tree
  * @port: PCIe port information
@@ -525,6 +587,19 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 	struct device *dev = port->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
+	int ret;
+
+	/* CPM5NC does not support PERST# handling yet */
+	if (port->variant->version != CPM5NC_HOST) {
+		port->rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+		if (IS_ERR(port->rstc))
+			return dev_err_probe(dev, PTR_ERR(port->rstc),
+					     "Failed to request reset\n");
+
+		ret = xilinx_cpm_pcie_parse_port(port);
+		if (ret)
+			return ret;
+	}
 
 	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
 							       "cpm_slcr");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..bf53354dc5a9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -39,6 +39,15 @@ struct pcie_tlp_log;
  */
 #define PCIE_T_PERST_CLK_US		100
 
+/*
+ * PERST# active time.
+ *
+ * See the "Power Sequencing and Reset Signal Timings" table of the PCI Express
+ * Card Electromechanical Specification, Revision 6.0, Section 2.11.2, Symbol
+ * "T_PERST".
+ */
+#define PCIE_T_PERST_US			100
+
 /*
  * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
  * Recommends 1ms to 10ms timeout to check L2 ready.
-- 
2.44.4

