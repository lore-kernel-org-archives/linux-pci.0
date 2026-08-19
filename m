Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD8483BF4;
	Wed, 19 Aug 2026 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160106; cv=fail; b=j1FH0JtwZ4jpM+C6654UwjVgtj2byrySOG/RmiegUNILXcwcqzhFSRhf+/C5vo/E9UVdqWvbMuUv9sbuKY1yNtrcETmDXqCjfOwS7uSQPZfFif6cpAL7BJKq0EgxuPA2caOVraGmwJ3nGVcrs37kBdrKgNgX4IqhA8l7FbkrgIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160106; c=relaxed/simple;
	bh=swfwB5ieo/Epbz3ZgD5FI2vRuNqvRFmveu0uEZbtZVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJmN6M0CwXgI9vCEePAxCtSLE7n0RgFZ2n3hZMdvxQbR+Z0++fvwcgUPI0suN31h6wfKgxp0EJk1m1f03nJ8X2zpS/GehFn4wwhGHJYvfb2RMfge7c9YZptItiBpTi3z3XPEEHFNuX+QyXfloz8RX2LGiIjcf6WGUFRNkVTIkjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KpBmNmfP; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KpBmNmfP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVQ676shrbj90/1MdKeqw/prMGKQA9QO9m3Vzq8+ifLG0W6Fv461bcHj/aCOtPY/RP1zo2zW4Xc3rmyBIlBUJ86ymtjMflYJTnvukG59m8hyeb1kMcPobBZ4bQUu/nf0DKvlUQiyBhRbjFlmSy6A+nunzQS7aGHIygDr3WkG6IZTbPbiQqh4HV4Y8pNDkvkIDXpS6vkuIB1v/AVbYsp6HwJiX+hBvrdKiZdd0ulull5eDg+bj5KPIdVI4ABeX9aSHdHgQQRh2kGUKD7vIUJsVww01jcIwAXGRqbnWjDD2B6UzDFcLosZyqWUyv+NYaE7snNhR1KksbMFXmDInRtE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IYtsRhPAbs1KY5M3zbayIPVaXGTLfEiCAcozcBKj+4=;
 b=accPDZrALjlhXKEDRZF1X+1nLdbmJ7Gx5VDJokwfACNsQHRpx54YUDmJe5o5UVNaQ/cnBIVIInPjDEV5jEBZmfApYvkfwZsW0sPet3zqll4fDrZvc46Fpaur3Yj5phLIHD7byDHQWAmtv9XmFVM7HJIuuAO8rJhWR12dyMWLjielH9kjZGIKyiWF96OWKs5gYbHmLJaZ1NcKzdhkEcIuKN+Te+hoNhxms5OJeJVjQCq0z7f/lwpWe6hnj2GoWva9RfZ1Kw18gkCXMW9dj/MdJpVGeRDNDbFAbu0UG8Pz353zr7+x8JJJmxUbhheS+QQvAI6tLaXSiF/ATYNoA+XDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IYtsRhPAbs1KY5M3zbayIPVaXGTLfEiCAcozcBKj+4=;
 b=KpBmNmfPINNSw+Bp16X2TIQ+truG6MjIx13TV0B3jnaof9ud9Pjv55jTz1NBMst1qnIsSYo3uRQpKZzhmRFfW2N9lbDqV8INv8S7HNPinIw8NhnkDEDmKb3rqD0TzXsGGEwIOb59BA0JMMySei+krihD8/v6DhqMFFuIGXlbHWw=
Received: from CH2PR08CA0029.namprd08.prod.outlook.com (2603:10b6:610:5a::39)
 by CHAPR12MB999248.namprd12.prod.outlook.com (2603:10b6:610:2ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 17:21:18 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::95) by CH2PR08CA0029.outlook.office365.com
 (2603:10b6:610:5a::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Wed,
 19 Aug 2026 17:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 17:21:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 12:21:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 12:21:17 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 12:21:13 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v6 2/2] PCI: amd-mdb: Add CPM6 host controller support
Date: Wed, 19 Aug 2026 22:50:57 +0530
Message-ID: <20260819172057.3636214-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260819172057.3636214-1-sai.krishna.musham@amd.com>
References: <20260819172057.3636214-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|CHAPR12MB999248:EE_
X-MS-Office365-Filtering-Correlation-Id: 260a95da-db79-4878-53e8-08defe1647fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|23010399003|36860700016|13003099007|6133799003|56012099006|10067099003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BQvzfz4Cqh5gprdNOTnctmqwrkqBF6vQuvFZ03MYmX/in/FyYwwtJF1Cl7C5RrclB1vmoMHZ8fa7i8CBxN4gXgxu7zp8mt44kd2UwSz2rLkYxpQBmFzt1ISyufY9n393CWtF2G4jSxXhoUv4TdMWH5qn+0qOtTKzIp08MtEV402G2YspMYpw1p8g7Z7q5LzXMimUcMcwF3NHwvD/Btm08gOLcxL0tHgtYBgDu76E43rYeIMSrT8THhEP3WposqlQYzVShVKxA4useZ2mLbbxdGmDc8rMMAouamWXd6DygjPBEEGOerrDiTOi4D++FvT7Nt1Om3SymgFvMW3qw2C5eF1Pcib+qhiOBHOjBYf5LkLAEhDJvs1Yd+6K0eUJh/41cdvCOS5uXxjfJOuDVDsapJ/lqFXunMXKkHUDXhWw/tyqax1fRsNm/HhnJfRMlJArKQjj8j7Q4tEvx6PlQvrRGouwxnhTClS857Xdjdfm3YxKAmwOHAA0kjMm0/R5cAXUWVXKF8FUYER50S4yw9ImOQyCrbE14n8bElugX1GmvH4XkeStyuKBhlpelOFW19mR9T4jbOyvQm1P+hbrFzsO+ExfbBJc8FsHt2jeiMRnEYEpZuNq1NNhjhccjbF26YZGCRhIi5DiGCXIyCvyG57jn7jgOs+2OLf6xNHmR54X5ZFj6CA2AwhkNaTHHHDLRKOX/sq9ILP07ZKY5OnqTNqbGw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(23010399003)(36860700016)(13003099007)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OkQYEmS0YD0ifVzR+FCC78QYp9fI6VsPBIor00XXvBE3OHzhfo9If55NTG9h2Qqy+qDaApVh8MCTYp0hIsK3SAN36swgVTH6/Kf2YFxIkI4iEHtZWiV9fUPozAaEMNJP/J1uPwRlsZPzgMJCM8dovg56bz3/fxsiHIxRPb9tNeuosPwJQKVmqlx8jpLOIyr7TW5SBIrSRNvOiMBgdkU72exU8HzxfEk/FEKEUbeogt86uYusjHNSKdL6sX+NcwazDz6NNdTS+U3g3puaHMYAuMb/xzcBOGG0mLvDNU58LoJd1rCzUH/M6zEK9BgTTU0k6AkYv9ewTRKFb5WBAuXJaVwDeiwRmDYu6En++7XsWhlAJCQMbI+MWLZ3ksBgemBxhvJgt22dg3zkzqJ4A7JohuQjaTcegpdXQ5wnahhw2P1CxgAL/nROIa4a01m4ag0r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 17:21:18.3167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 260a95da-db79-4878-53e8-08defe1647fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999248

Add support for the AMD Versal2 CPM6 host controller variants
(amd,versal2-cpm6-host and amd,versal2-cpm6-host1).

CPM6 is based on the Synopsys DesignWare PCIe controller and shares
most of the MDB5 host controller implementation. The main difference is
the interrupt register layout.

Unlike MDB5, the per-controller MISC_EVENT registers reside in a
dedicated "intr" region rather than the shared SLCR block. The
MERGED/PS_MISC interrupt aggregators are shared by both host
controllers and remain asserted until their status is cleared.

Since both controllers share the same event interrupt line, request the
IRQ with IRQF_SHARED and clear this controller's aggregator contribution
after each interrupt handling pass. The CPM6 event interrupt handler
processes only INTx-related events, while PCIe errors are handled
through the standard PCIe AER framework.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v6:
- Drop the platform error-event handling on CPM6 and leave error
  reporting to the native PCIe AER service.

Changes in v5:
- Return IRQ_NONE when this host has nothing pending, so the shared
  IRQ line keeps spurious-interrupt detection and does not clear the
  peer host's aggregator.
- Add amd_mdb_pcie_disable_interrupts() and call it on the probe error
  path to avoid an IRQ storm on the shared line.
- Mask interrupts during setup and arm them only after all handlers
  are registered.

Changes in v4:
- Use IRQF_SHARED for the CPM6 event IRQ since the misc/error GIC line
  is shared between both host controllers.
- Read PCIE_ERR before servicing MISC_EVENT to snapshot the error state
  before it is cleared.

Changes in v3:
- Add missing completion-timeout handling via PCIE_ERR.
- Add CPM6 INTx shared-enable refcount handling (mask/unmask via intx_refmask).
- Fix probe-failure cleanup to avoid double-free/use-after-free risk.
- Fix CPM6 slcr mapping to use non-exclusive ioremap for shared SLCR.
- Clear unhandled asserted bits in AMD_CPM6_PCIE_ERR_STATUS.

Changes in v2:
- Add CPM6 host controller interrupt support.

v1 https://lore.kernel.org/all/20260402180006.486229-3-sai.krishna.musham@amd.com/
v2 https://lore.kernel.org/all/20260728202044.1785986-3-sai.krishna.musham@amd.com/
v3 https://lore.kernel.org/all/20260803144412.713639-3-sai.krishna.musham@amd.com/
v4 https://lore.kernel.org/all/20260808105256.3705889-3-sai.krishna.musham@amd.com/
v5 https://lore.kernel.org/all/20260817023932.1743100-3-sai.krishna.musham@amd.com/
---
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 367 ++++++++++++++++++----
 1 file changed, 305 insertions(+), 62 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index dee295f281a3..4355fa6d48a3 100644
--- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -21,6 +21,17 @@
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+/*
+ * On CPM6 the per-controller PCIe MISC_EVENT registers live in a dedicated
+ * region ("intr"), separate from the CPM SLCR region ("slcr") that holds the
+ * MERGED and PS severity registers they feed into. Each has a sticky W1C
+ * STATUS, a read-only MASK, and write-1 ENABLE/DISABLE register.
+ */
+#define AMD_CPM6_MISC_EVENT_STATUS		0x514
+#define AMD_CPM6_MISC_EVENT_MASK		0x518
+#define AMD_CPM6_MISC_EVENT_ENABLE		0x51C
+#define AMD_CPM6_MISC_EVENT_DISABLE		0x520
+
 #define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
 #define AMD_MDB_TLP_IR_MASK_MISC		0x4C4
 #define AMD_MDB_TLP_IR_ENABLE_MISC		0x4C8
@@ -30,7 +41,22 @@
 
 #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)	BIT((x) * 2)
 
-/* Interrupt registers definitions. */
+#define AMD_CPM6_MERGED_STATUS			0x648
+#define AMD_CPM6_MERGED_ENABLE			0x650
+#define AMD_CPM6_MERGED_DISABLE			0x654
+
+/* MERGED input bits for the MISC_EVENT sources this driver handles. */
+#define AMD_CPM6_MERGED_MISC_EVENT_HOST0	14
+#define AMD_CPM6_MERGED_MISC_EVENT_HOST1	17
+
+/*
+ * The PS_MISC severity register feeds the misc/OR GIC line. The MERGED
+ * aggregator appears as bit 21 within it.
+ */
+#define AMD_CPM6_PS_MISC_IR_STATUS		0x340
+#define AMD_CPM6_PS_IR_MERGED			BIT(21)
+
+/* MDB5 interrupt register definitions. */
 #define AMD_MDB_PCIE_INTR_CMPL_TIMEOUT		15
 #define AMD_MDB_PCIE_INTR_INTX			16
 #define AMD_MDB_PCIE_INTR_PM_PME_RCVD		24
@@ -51,24 +77,77 @@
 		AMD_MDB_TLP_PCIE_INTX_MASK		\
 	)
 
+/* CPM6 hwirq mapping (hwirq == MISC_EVENT status bit). */
+#define AMD_CPM6_PCIE_INTR_INTX			22
+
+enum amd_mdb_pcie_version {
+	MDB5,
+	CPM6,
+	CPM6_HOST1,
+};
+
+struct amd_mdb_pcie_variant {
+	enum	amd_mdb_pcie_version version;
+	u32	misc_status_reg;
+	u32	misc_mask_reg;
+	u32	misc_enable_reg;
+	u32	misc_disable_reg;
+	u32	misc_mask_all;
+	u32	intx_hwirq;
+	u32	intx_mask;
+};
+
 /**
  * struct amd_mdb_pcie - PCIe port information
  * @pci: DesignWare PCIe controller structure
  * @slcr: MDB System Level Control and Status Register (SLCR) base
+ * @intr_base: Per-controller interrupt register base. On CPM6 this maps the
+ *             "intr" region holding the MISC_EVENT registers; on MDB5
+ *             the interrupt registers live in the SLCR block, so it aliases
+ *             @slcr.
+ * @variant: Interrupt layout data for the matched platform compatible
  * @intx_domain: INTx IRQ domain pointer
  * @mdb_domain: MDB IRQ domain pointer
  * @perst_gpio: GPIO descriptor for PERST# signal handling
  * @intx_irq: INTx IRQ interrupt number
+ * @intx_refmask: CPM6 mask of unmasked INTx lines; gates the shared aggregate
  */
 struct amd_mdb_pcie {
 	struct dw_pcie			pci;
 	void __iomem			*slcr;
+	void __iomem			*intr_base;
+	const struct amd_mdb_pcie_variant	*variant;
 	struct irq_domain		*intx_domain;
 	struct irq_domain		*mdb_domain;
 	struct gpio_desc		*perst_gpio;
 	int				intx_irq;
+	u32				intx_refmask;
 };
 
+static u32 amd_mdb_pcie_merged_host_mask(struct amd_mdb_pcie *pcie)
+{
+	return pcie->variant->version == CPM6 ?
+	       BIT(AMD_CPM6_MERGED_MISC_EVENT_HOST0) :
+	       BIT(AMD_CPM6_MERGED_MISC_EVENT_HOST1);
+}
+
+static void amd_mdb_pcie_clear_aggregators(struct amd_mdb_pcie *pcie)
+{
+	if (pcie->variant->version == MDB5)
+		return;
+
+	/* Clear this host's serviced MISC_EVENT contribution from MERGED. */
+	writel_relaxed(amd_mdb_pcie_merged_host_mask(pcie),
+		       pcie->slcr + AMD_CPM6_MERGED_STATUS);
+
+	/*
+	 * Clear MERGED in the PS_MISC severity register so the misc GIC line
+	 * de-asserts.
+	 */
+	writel_relaxed(AMD_CPM6_PS_IR_MERGED,
+		       pcie->slcr + AMD_CPM6_PS_MISC_IR_STATUS);
+}
+
 static const struct dw_pcie_host_ops amd_mdb_pcie_host_ops = {
 };
 
@@ -81,14 +160,17 @@ static void amd_mdb_intx_irq_mask(struct irq_data *data)
 	u32 val;
 
 	raw_spin_lock_irqsave(&port->lock, flags);
-	val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
-			 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
-
-	/*
-	 * Writing '1' to a bit in AMD_MDB_TLP_IR_DISABLE_MISC disables that
-	 * interrupt, writing '0' has no effect.
-	 */
-	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
+	if (pcie->variant->version == MDB5) {
+		val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
+				 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
+	} else {
+		/* CPM6 shares one INTx enable; drop it on the last mask. */
+		pcie->intx_refmask &= ~BIT(data->hwirq);
+		val = pcie->intx_refmask ? 0 : pcie->variant->intx_mask;
+	}
+	/* Writing '1' disables the interrupt; writing '0' has no effect. */
+	if (val)
+		writel_relaxed(val, pcie->intr_base + pcie->variant->misc_disable_reg);
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -101,14 +183,17 @@ static void amd_mdb_intx_irq_unmask(struct irq_data *data)
 	u32 val;
 
 	raw_spin_lock_irqsave(&port->lock, flags);
-	val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
-			 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
-
-	/*
-	 * Writing '1' to a bit in AMD_MDB_TLP_IR_ENABLE_MISC enables that
-	 * interrupt, writing '0' has no effect.
-	 */
-	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
+	if (pcie->variant->version == MDB5) {
+		val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
+				 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
+	} else {
+		/* CPM6 shares one INTx enable; raise it on the first unmask. */
+		val = pcie->intx_refmask ? 0 : pcie->variant->intx_mask;
+		pcie->intx_refmask |= BIT(data->hwirq);
+	}
+	/* Writing '1' enables the interrupt; writing '0' has no effect. */
+	if (val)
+		writel_relaxed(val, pcie->intr_base + pcie->variant->misc_enable_reg);
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -148,11 +233,19 @@ static irqreturn_t dw_pcie_rp_intx(int irq, void *args)
 	unsigned long val;
 	int i, int_status;
 
-	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
-	int_status = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK, val);
+	val = readl_relaxed(pcie->intr_base + pcie->variant->misc_status_reg);
 
-	for (i = 0; i < PCI_NUM_INTX; i++) {
-		if (int_status & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
+	if (pcie->variant->version == MDB5) {
+		int_status = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK, val);
+		for (i = 0; i < PCI_NUM_INTX; i++) {
+			if (int_status & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
+				generic_handle_domain_irq(pcie->intx_domain, i);
+		}
+	} else {
+		/* CPM6 exposes only an aggregate INTx indication */
+		if (!(val & pcie->variant->intx_mask))
+			return IRQ_NONE;
+		for (i = 0; i < PCI_NUM_INTX; i++)
 			generic_handle_domain_irq(pcie->intx_domain, i);
 	}
 
@@ -179,11 +272,10 @@ static void amd_mdb_event_irq_mask(struct irq_data *d)
 	struct dw_pcie *pci = &pcie->pci;
 	struct dw_pcie_rp *port = &pci->pp;
 	unsigned long flags;
-	u32 val;
 
 	raw_spin_lock_irqsave(&port->lock, flags);
-	val = BIT(d->hwirq);
-	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
+	writel_relaxed(BIT(d->hwirq),
+		       pcie->intr_base + pcie->variant->misc_disable_reg);
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -193,11 +285,10 @@ static void amd_mdb_event_irq_unmask(struct irq_data *d)
 	struct dw_pcie *pci = &pcie->pci;
 	struct dw_pcie_rp *port = &pci->pp;
 	unsigned long flags;
-	u32 val;
 
 	raw_spin_lock_irqsave(&port->lock, flags);
-	val = BIT(d->hwirq);
-	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
+	writel_relaxed(BIT(d->hwirq),
+		       pcie->intr_base + pcie->variant->misc_enable_reg);
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -226,13 +317,30 @@ static irqreturn_t amd_mdb_pcie_event(int irq, void *args)
 {
 	struct amd_mdb_pcie *pcie = args;
 	unsigned long val;
+	u32 ev_raw;
 	int i;
 
-	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
-	val &= ~readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_MASK_MISC);
+	ev_raw = readl_relaxed(pcie->intr_base + pcie->variant->misc_status_reg);
+	val = ev_raw;
+	val &= ~readl_relaxed(pcie->intr_base + pcie->variant->misc_mask_reg);
+
+	if (pcie->variant->version == MDB5) {
+		for_each_set_bit(i, &val, 32)
+			generic_handle_domain_irq(pcie->mdb_domain, i);
+		writel_relaxed(val, pcie->intr_base + pcie->variant->misc_status_reg);
+		return IRQ_HANDLED;
+	}
+
+	val &= pcie->variant->misc_mask_all;
+
 	for_each_set_bit(i, &val, 32)
 		generic_handle_domain_irq(pcie->mdb_domain, i);
-	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
+
+	/* Clear handled + any unhandled sticky bits to avoid IRQ storms. */
+	writel_relaxed(ev_raw, pcie->intr_base + pcie->variant->misc_status_reg);
+
+	/* Sticky aggregation bits; clear each pass or the IRQ re-fires */
+	amd_mdb_pcie_clear_aggregators(pcie);
 
 	return IRQ_HANDLED;
 }
@@ -250,24 +358,59 @@ static void amd_mdb_pcie_free_irq_domains(struct amd_mdb_pcie *pcie)
 	}
 }
 
-static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
+static void amd_mdb_pcie_disable_interrupts(struct amd_mdb_pcie *pcie)
 {
-	unsigned long val;
+	u32 misc_mask_all = pcie->variant->misc_mask_all;
+	u32 val;
+
+	/* Mask all leaf TLP interrupts. */
+	writel_relaxed(misc_mask_all,
+		       pcie->intr_base + pcie->variant->misc_disable_reg);
+
+	/* Clear any pending leaf TLP interrupts. */
+	val = readl_relaxed(pcie->intr_base + pcie->variant->misc_status_reg) &
+	      misc_mask_all;
+	writel_relaxed(val, pcie->intr_base + pcie->variant->misc_status_reg);
+
+	if (pcie->variant->version == MDB5)
+		return;
+
+	/*
+	 * Mask this host's MISC_EVENT input in the shared MERGED aggregator so
+	 * a stale source cannot drive the GIC line the peer host controller
+	 * also shares.
+	 */
+	writel_relaxed(amd_mdb_pcie_merged_host_mask(pcie),
+		       pcie->slcr + AMD_CPM6_MERGED_DISABLE);
+}
+
+static void amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
+{
+	u32 misc_mask_all;
+	u32 val;
+
+	misc_mask_all = pcie->variant->misc_mask_all;
 
 	/* Disable all TLP interrupts. */
-	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
-		       pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
+	writel_relaxed(misc_mask_all,
+		       pcie->intr_base + pcie->variant->misc_disable_reg);
 
 	/* Clear pending TLP interrupts. */
-	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
-	val &= AMD_MDB_PCIE_IMR_ALL_MASK;
-	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
+	val = readl_relaxed(pcie->intr_base + pcie->variant->misc_status_reg) &
+	      misc_mask_all;
+	writel_relaxed(val, pcie->intr_base + pcie->variant->misc_status_reg);
 
 	/* Enable all TLP interrupts. */
-	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
-		       pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
+	writel_relaxed(misc_mask_all,
+		       pcie->intr_base + pcie->variant->misc_enable_reg);
 
-	return 0;
+	/*
+	 * On CPM6 unmask this host's MISC_EVENT input in the shared MERGED
+	 * aggregator so it reaches the GIC.
+	 */
+	if (pcie->variant->version != MDB5)
+		writel_relaxed(amd_mdb_pcie_merged_host_mask(pcie),
+			       pcie->slcr + AMD_CPM6_MERGED_ENABLE);
 }
 
 /**
@@ -351,35 +494,48 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
 	struct dw_pcie *pci = &pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = &pdev->dev;
+	unsigned long event_flags = IRQF_NO_THREAD;
 	int i, irq, err;
 
-	amd_mdb_pcie_init_port(pcie);
+	/*
+	 * Keep the hardware interrupts masked until every handler is
+	 * registered below, so an early assertion cannot storm the shared
+	 * CPM6 GIC line before there is anything to service it.
+	 */
+	amd_mdb_pcie_disable_interrupts(pcie);
 
 	pp->irq = platform_get_irq(pdev, 0);
 	if (pp->irq < 0)
 		return pp->irq;
 
-	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
-		if (!intr_cause[i].str)
-			continue;
-
-		irq = irq_create_mapping(pcie->mdb_domain, i);
-		if (!irq) {
-			dev_err(dev, "Failed to map MDB domain interrupt\n");
-			return -ENOMEM;
-		}
-
-		err = devm_request_irq(dev, irq, amd_mdb_pcie_intr_handler,
-				       IRQF_NO_THREAD, intr_cause[i].sym, pcie);
-		if (err) {
-			dev_err(dev, "Failed to request IRQ %d, err=%d\n",
-				irq, err);
-			return err;
+	/*
+	 * MDB5 reports the error messages on the event domain. On CPM6 those
+	 * are left to the native AER service, so only INTx is serviced on the
+	 * event domain there.
+	 */
+	if (pcie->variant->version == MDB5) {
+		for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
+			if (!intr_cause[i].str)
+				continue;
+
+			irq = irq_create_mapping(pcie->mdb_domain, i);
+			if (!irq) {
+				dev_err(dev, "Failed to map MDB domain interrupt\n");
+				return -ENOMEM;
+			}
+
+			err = devm_request_irq(dev, irq, amd_mdb_pcie_intr_handler,
+					       IRQF_NO_THREAD, intr_cause[i].sym, pcie);
+			if (err) {
+				dev_err(dev, "Failed to request IRQ %d, err=%d\n",
+					irq, err);
+				return err;
+			}
 		}
 	}
 
 	pcie->intx_irq = irq_create_mapping(pcie->mdb_domain,
-					    AMD_MDB_PCIE_INTR_INTX);
+				    pcie->variant->intx_hwirq);
 	if (!pcie->intx_irq) {
 		dev_err(dev, "Failed to map INTx interrupt\n");
 		return -ENXIO;
@@ -393,8 +549,15 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
 		return err;
 	}
 
+	/*
+	 * On CPM6 the misc GIC line is shared between both host controllers,
+	 * so the event IRQ must allow sharing.
+	 */
+	if (pcie->variant->version != MDB5)
+		event_flags |= IRQF_SHARED;
+
 	/* Plug the main event handler. */
-	err = devm_request_irq(dev, pp->irq, amd_mdb_pcie_event, IRQF_NO_THREAD,
+	err = devm_request_irq(dev, pp->irq, amd_mdb_pcie_event, event_flags,
 			       "amd_mdb pcie_irq", pcie);
 	if (err) {
 		dev_err(dev, "Failed to request event IRQ %d, err=%d\n",
@@ -402,6 +565,9 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
 		return err;
 	}
 
+	/* Arm the hardware only now that all handlers are in place. */
+	amd_mdb_pcie_init_port(pcie);
+
 	return 0;
 }
 
@@ -435,9 +601,36 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
 	struct device *dev = &pdev->dev;
 	int err;
 
-	pcie->slcr = devm_platform_ioremap_resource_byname(pdev, "slcr");
-	if (IS_ERR(pcie->slcr))
-		return PTR_ERR(pcie->slcr);
+	if (pcie->variant->version == MDB5) {
+		/*
+		 * On MDB5 all interrupt registers live in the SLCR block, so
+		 * the interrupt-register base simply aliases @slcr.
+		 */
+		pcie->slcr = devm_platform_ioremap_resource_byname(pdev, "slcr");
+		if (IS_ERR(pcie->slcr))
+			return PTR_ERR(pcie->slcr);
+		pcie->intr_base = pcie->slcr;
+	} else {
+		struct resource *res;
+
+		/*
+		 * CPM6 moves the per-controller MISC_EVENT registers
+		 * into a separate "intr" region. The SLCR block, which holds
+		 * the shared MERGED/PS_MISC aggregators, is shared by both CPM6
+		 * host controllers, so map it without requesting exclusive
+		 * ownership; otherwise the second controller fails to probe.
+		 */
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "slcr");
+		if (!res)
+			return -EINVAL;
+		pcie->slcr = devm_ioremap(dev, res->start, resource_size(res));
+		if (!pcie->slcr)
+			return -ENOMEM;
+
+		pcie->intr_base = devm_platform_ioremap_resource_byname(pdev, "intr");
+		if (IS_ERR(pcie->intr_base))
+			return PTR_ERR(pcie->intr_base);
+	}
 
 	err = amd_mdb_pcie_init_irq_domains(pcie, pdev);
 	if (err)
@@ -466,6 +659,11 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
 	return 0;
 
 out:
+	/*
+	 * Mask the hardware interrupts before tearing down so a stale source
+	 * cannot storm the shared CPM6 GIC line once this host is unwound.
+	 */
+	amd_mdb_pcie_disable_interrupts(pcie);
 	amd_mdb_pcie_free_irq_domains(pcie);
 	return err;
 }
@@ -483,6 +681,9 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
 
 	pci = &pcie->pci;
 	pci->dev = dev;
+	pcie->variant = of_device_get_match_data(dev);
+	if (!pcie->variant)
+		return -EINVAL;
 
 	platform_set_drvdata(pdev, pcie);
 
@@ -514,9 +715,51 @@ static void amd_mdb_pcie_shutdown(struct platform_device *pdev)
 	gpiod_set_value_cansleep(pcie->perst_gpio, 1);
 }
 
+static const struct amd_mdb_pcie_variant cpm6_host = {
+	.version = CPM6,
+	.misc_status_reg = AMD_CPM6_MISC_EVENT_STATUS,
+	.misc_mask_reg = AMD_CPM6_MISC_EVENT_MASK,
+	.misc_enable_reg = AMD_CPM6_MISC_EVENT_ENABLE,
+	.misc_disable_reg = AMD_CPM6_MISC_EVENT_DISABLE,
+	.misc_mask_all = BIT(AMD_CPM6_PCIE_INTR_INTX),
+	.intx_hwirq = AMD_CPM6_PCIE_INTR_INTX,
+	.intx_mask = BIT(AMD_CPM6_PCIE_INTR_INTX),
+};
+
+static const struct amd_mdb_pcie_variant cpm6_host1 = {
+	.version = CPM6_HOST1,
+	.misc_status_reg = AMD_CPM6_MISC_EVENT_STATUS,
+	.misc_mask_reg = AMD_CPM6_MISC_EVENT_MASK,
+	.misc_enable_reg = AMD_CPM6_MISC_EVENT_ENABLE,
+	.misc_disable_reg = AMD_CPM6_MISC_EVENT_DISABLE,
+	.misc_mask_all = BIT(AMD_CPM6_PCIE_INTR_INTX),
+	.intx_hwirq = AMD_CPM6_PCIE_INTR_INTX,
+	.intx_mask = BIT(AMD_CPM6_PCIE_INTR_INTX),
+};
+
+static const struct amd_mdb_pcie_variant mdb5_host = {
+	.version = MDB5,
+	.misc_status_reg = AMD_MDB_TLP_IR_STATUS_MISC,
+	.misc_mask_reg = AMD_MDB_TLP_IR_MASK_MISC,
+	.misc_enable_reg = AMD_MDB_TLP_IR_ENABLE_MISC,
+	.misc_disable_reg = AMD_MDB_TLP_IR_DISABLE_MISC,
+	.misc_mask_all = AMD_MDB_PCIE_IMR_ALL_MASK,
+	.intx_hwirq = AMD_MDB_PCIE_INTR_INTX,
+	.intx_mask = AMD_MDB_TLP_PCIE_INTX_MASK,
+};
+
 static const struct of_device_id amd_mdb_pcie_of_match[] = {
 	{
 		.compatible = "amd,versal2-mdb-host",
+		.data = &mdb5_host,
+	},
+	{
+		.compatible = "amd,versal2-cpm6-host",
+		.data = &cpm6_host,
+	},
+	{
+		.compatible = "amd,versal2-cpm6-host1",
+		.data = &cpm6_host1,
 	},
 	{},
 };
-- 
2.44.4

