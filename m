Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783C41C2E4;
	Mon,  3 Aug 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768283; cv=fail; b=GdgFCuzAmF0vQjHdU1oNkE2xiYvX2xztDXeIx7rmfnXt/6w2krvwfiNUiX9ZhFDTvNE1+L8aj84oABvTTukYcDvsdQkYeO1cSuDho5mDp1Ga/PMV9urzQQUMB5IL5cCFTuxj823rj58BF/dOqUDJdZjMMGEQNxnpanzPHdbYhGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768283; c=relaxed/simple;
	bh=7DkVE/CPPvHoa9cVsuRKmxCzn11kLdy6gV/17ofC1Q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9O7269WDWcJljaPIZ+szAsNvwMJO30vjEYDiI1Uu24nuCI79zpWquyd36cdPY5xeMw5v56HqdT6ntbtV/I9RSiamRtpiLbvGu2s/vK618b1vAdSCN9vbfunWhEx7dX4M0AT05T9CxeIBHLPtNgY2G9RIugeZfQQ5C7sHHzktE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DPBfIKF0; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DPBfIKF0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsHepioCDJIEZW43KF62kacA36FN+01wagwgxXAhHP/rL5QFdEw/kcHDyBdX9+S0hA1bA1ODn4XNPjkzZhZ39TogOM53uCZ/yWFJG0e33vS0VisIsjN/QLb2EFvg6NHldqray+r3KXGjhObGc5h5lO/7dmJcPDw/dcq4uXy8txBF8i136LwikfdnxrEFY5yDrimHywZjL171RlZsouEqt73DkpAdF0LcJ9pkGVYX+d6bsTu2ShnNxDh3XQRPzg+ye6lN3W5Atw9jMReS59f9fF3BGAR2HZtLbxw+7ecYK32P1QBY35ayX60/AsQoqvZfiMjDahjatDo5v/XseAHG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52AABKdNqYWf9kCQ7rYFjMXLG08Cu5ReP5qL4INF9GA=;
 b=WjTE78i1s3x+Y+7eKKWo7Dv9UwgCTew4hmfSA8AtOA72zmf7dinIUHCpbDxFmRfkESmdh/3D5egnXFKIf01HHIbLs4IGn9RlIf2/FsOBEFeSDV5o1U1bJ9R9qbKz9zMmpvCMiBNHvWutFXQmryLnu25E56WsMx5bHqOAdtZJzfk+fYRflhbOQXn+VZiL8rLoLPshgMs7P+MGX/3gOWk1+9vfDs6w1X+Uo/489hBScJyZEox1dXEOBpbP80IzShOk6E+KxnmeWC8Pv0NF0ijDrrnkkO42DFHDpug5tVgC0y14JrFDdbLDH314fS83kqX62b8fk1lUUQVjDaYBUeeh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52AABKdNqYWf9kCQ7rYFjMXLG08Cu5ReP5qL4INF9GA=;
 b=DPBfIKF0WMXl8fI32p1WYbSat2eX5Y8zsb84ZdrObDfcptJI7T7CW5WrwUqctFph/eIGaR5U0a635bDkTkWdxStIj6zybwdFoJ+QU4Y5RgLnFbg3IANFChdkx+58G4lOp56r4NhSQZEflviOKbFykNN7g7mfTzCVb1gAvojOA+U=
Received: from CH0PR13CA0054.namprd13.prod.outlook.com (2603:10b6:610:b2::29)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 14:44:32 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::27) by CH0PR13CA0054.outlook.office365.com
 (2603:10b6:610:b2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.13 via Frontend Transport; Mon, 3
 Aug 2026 14:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 14:44:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 09:44:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 09:44:31 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 3 Aug 2026 09:44:27 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v3 2/2] PCI: amd-mdb: Add CPM6 host controller support
Date: Mon, 3 Aug 2026 20:14:12 +0530
Message-ID: <20260803144412.713639-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260803144412.713639-1-sai.krishna.musham@amd.com>
References: <20260803144412.713639-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 2117b960-7d14-40ee-a679-08def16dbb09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FEjSUsyc+CG5YnE0X4mDdhxFdOGSrC6ejQYcUxiGuCUmuSr559/6AqcC5/JbkqTNNkBqfgyY9SYKA5gnpIYgD5aZ/j2xlNRzFCQ3VumsmlEioEfVk6c2ScE49gQVBK1z+XH6UXtmqK3qct8qzfjM2xdQbCzQWMvYiq14u4SztGYTZTpRTAzuBCJiEx+y81RPqZXD6OGUCcf17fqHPHJegjmbfW/phodxTcTU8NV1DNVJPDriXCz96Jd+mCo0FDRsU3+A5Wwkrts1udnPo8eMEq6q+zKb+ns+BiP2SAH6a5TLQtx5d/rwjUJFn0wL2sz9hvl2ePWtP8xyfrM8K/U2ZffCq4qz5pbGyXbggB2GgM5ajEqGLLr39LfKTxj8eaoSsWDMXcc09pLoPw3h/haONqw/cqS7ePpL68tZwyRQxGxXkDwlaL5H4rzqasCzLl2NsEQvuHNaE+DUk6JORAaH8FBMn1ikSqFdeLY6a6rXaXDc/JRAojmQJt0PpdwyGsM8PpbXC5iCdgI5m3DRrnwrjYyFQXOQpfOxikBs9KWXw9D57FAi1cNaGz1p8kdmBxeA5WMuHk40l0h8duldxEpM8uSI6cdNOd/b0ijQFkowHWC/5wmLFuI7GW6rSDJNjWw7Gf+h8FA7hRwKY/Zi6HAgV0r/2/2NWAewmOrKOHWKpicFeA95FCnh3xIyecumIkIB2c1d2iX1JURlYzvQoLyTEA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/Bg/x76rWGhEuzWGibiy2i73NQbttmeaEajE0zxUwns3YpkOKC/h4BfrDMOWPoY7g6Z86p/Qknjwpjo2wMdydj2rP4N5mqMgN5UxxpyqABeQ4Ll2PouNo8Uee5jiG0IprgnwgzKVXddUELv9pwB4C702UPNVzQ2oMBvB5sTIj7JOVGgMPf8Ghl3tfK4afQZZvyn4OwIT7iBbUhKhru+TehQRtU3LAV2OcnOFcxAgbv0LU41AuYixahEUbIV52S6K/5qPAmrGL0/WJsh36N2Q8fYomAtivFdQSD2r2Whx72T3Nb2O6x55+xPd/X3W/h2jGGiHtX+2qEPqICRdxf8VRHO2vRszrKYJadOa8bd/Ct+abQrRY6X1ExZPq8sEPfsGKez/IKR6j0+QenFI2hiEyNSZQJ1MyWuHTx7wBXYH4GoSI4frxg3wZaMIgIwXQrtR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:44:32.4339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2117b960-7d14-40ee-a679-08def16dbb09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517

Extend the AMD MDB PCIe driver to support AMD Versal2 CPM6 variants
(amd,versal2-cpm6-host and amd,versal2-cpm6-host1). Like MDB5, CPM6 is
based on the Synopsys DesignWare PCIe controller and reuses the existing
DesignWare host support; only the interrupt architecture differs:
- The per-controller interrupt registers (MISC_EVENT, PCIE_ERR) are in a
  dedicated "intr" region instead of the shared SLCR
- The aggregation layer (MERGED, PS_MISC) is shared and sticky; it
  requires an explicit W1C-clear after servicing to prevent IRQ storms
- The completion timeout is reported via PCIE_ERR instead of MISC_EVENT

Add variant-specific register layout and implement aggregator clearing
that, after every interrupt pass, clears this host's contribution from
the MERGED register and the corresponding bit in the PS_MISC severity
register.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
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
---
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 413 ++++++++++++++++++----
 1 file changed, 353 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index dee295f281a3..d88fb365c310 100644
--- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -21,6 +21,23 @@
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+/*
+ * On CPM6 the per-controller PCIe interrupt registers (MISC_EVENT and
+ * PCIE_ERR) live in a dedicated region ("intr"), separate from the CPM SLCR
+ * region ("slcr") that holds the MERGED and PS severity registers they feed
+ * into. Each has a sticky W1C STATUS, a read-only MASK, and write-1
+ * ENABLE/DISABLE register.
+ */
+#define AMD_CPM6_PCIE_ERR_STATUS		0x500
+#define AMD_CPM6_PCIE_ERR_MASK			0x504
+#define AMD_CPM6_PCIE_ERR_ENABLE		0x508
+#define AMD_CPM6_PCIE_ERR_DISABLE		0x50C
+
+#define AMD_CPM6_MISC_EVENT_STATUS		0x514
+#define AMD_CPM6_MISC_EVENT_MASK		0x518
+#define AMD_CPM6_MISC_EVENT_ENABLE		0x51C
+#define AMD_CPM6_MISC_EVENT_DISABLE		0x520
+
 #define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
 #define AMD_MDB_TLP_IR_MASK_MISC		0x4C4
 #define AMD_MDB_TLP_IR_ENABLE_MISC		0x4C8
@@ -30,7 +47,23 @@
 
 #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)	BIT((x) * 2)
 
-/* Interrupt registers definitions. */
+#define AMD_CPM6_MERGED_STATUS			0x648
+#define AMD_CPM6_MERGED_ENABLE			0x650
+
+/* MERGED input bits for the MISC_EVENT/PCIE_ERR sources this driver handles. */
+#define AMD_CPM6_MERGED_PCIE_ERR_HOST0		13
+#define AMD_CPM6_MERGED_MISC_EVENT_HOST0	14
+#define AMD_CPM6_MERGED_PCIE_ERR_HOST1		16
+#define AMD_CPM6_MERGED_MISC_EVENT_HOST1	17
+
+/*
+ * The PS_MISC severity register feeds the misc/OR GIC line. The MERGED
+ * aggregator appears as bit 21 within it.
+ */
+#define AMD_CPM6_PS_MISC_IR_STATUS		0x340
+#define AMD_CPM6_PS_IR_MERGED		BIT(21)
+
+/* MDB5 interrupt register definitions. */
 #define AMD_MDB_PCIE_INTR_CMPL_TIMEOUT		15
 #define AMD_MDB_PCIE_INTR_INTX			16
 #define AMD_MDB_PCIE_INTR_PM_PME_RCVD		24
@@ -39,6 +72,9 @@
 #define AMD_MDB_PCIE_INTR_NONFATAL		27
 #define AMD_MDB_PCIE_INTR_FATAL			28
 
+/* Completion timeout lives in PCIE_ERR_STATUS; give it a dedicated hwirq. */
+#define AMD_CPM6_PCIE_ERR_CMPL_RADM		20
+
 #define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
 #define AMD_MDB_PCIE_IMR_ALL_MASK			\
 	(						\
@@ -51,24 +87,133 @@
 		AMD_MDB_TLP_PCIE_INTX_MASK		\
 	)
 
+/* CPM6 hwirq mapping (hwirq == MISC_EVENT status bit). */
+#define AMD_CPM6_PCIE_INTR_FATAL		17
+#define AMD_CPM6_PCIE_INTR_NONFATAL		18
+#define AMD_CPM6_PCIE_INTR_MISC_CORRECTABLE	19
+#define AMD_CPM6_PCIE_INTR_PME_TO_ACK_RCVD	20
+#define AMD_CPM6_PCIE_INTR_PM_PME_RCVD		21
+#define AMD_CPM6_PCIE_INTR_INTX			22
+
+/* Map the PCIE_ERR completion timeout onto an event-domain hwirq. */
+#define AMD_CPM6_PCIE_INTR_CMPL_TIMEOUT		15
+
+#define AMD_CPM6_MISC_EVENT_MASK_ALL					\
+	(								\
+		BIT(AMD_CPM6_PCIE_INTR_FATAL)			|	\
+		BIT(AMD_CPM6_PCIE_INTR_NONFATAL)		|	\
+		BIT(AMD_CPM6_PCIE_INTR_MISC_CORRECTABLE)	|	\
+		BIT(AMD_CPM6_PCIE_INTR_PME_TO_ACK_RCVD)		|	\
+		BIT(AMD_CPM6_PCIE_INTR_PM_PME_RCVD)		|	\
+		BIT(AMD_CPM6_PCIE_INTR_INTX)				\
+	)
+
+/* Sources handled in the PCIE_ERR register. */
+#define AMD_CPM6_PCIE_ERR_MASK_ALL	BIT(AMD_CPM6_PCIE_ERR_CMPL_RADM)
+
+enum amd_mdb_pcie_version {
+	MDB5,
+	CPM6,
+	CPM6_HOST1,
+};
+
+struct amd_mdb_intr_cause {
+	const char	*sym;
+	const char	*str;
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
+ *             "intr" region holding the MISC_EVENT/PCIE_ERR registers; on MDB5
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
+};
+
+#define _IC(x, s)[AMD_MDB_PCIE_INTR_ ## x] = { __stringify(x), s }
+
+static const struct amd_mdb_intr_cause mdb5_intr_cause[32] = {
+	_IC(CMPL_TIMEOUT,	"Completion timeout"),
+	_IC(PM_PME_RCVD,	"PM_PME message received"),
+	_IC(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
+	_IC(MISC_CORRECTABLE,	"Correctable error message"),
+	_IC(NONFATAL,		"Non fatal error message"),
+	_IC(FATAL,		"Fatal error message"),
 };
 
+#define _IC6(x, s)[AMD_CPM6_PCIE_INTR_ ## x] = { __stringify(x), s }
+
+static const struct amd_mdb_intr_cause cpm6_intr_cause[32] = {
+	_IC6(CMPL_TIMEOUT,	"Completion timeout"),
+	_IC6(PM_PME_RCVD,	"PM_PME message received"),
+	_IC6(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
+	_IC6(MISC_CORRECTABLE,	"Correctable error message"),
+	_IC6(NONFATAL,		"Non fatal error message"),
+	_IC6(FATAL,		"Fatal error message"),
+};
+
+/* Both cause tables are indexed by hwirq, so they must be the same size. */
+static_assert(ARRAY_SIZE(mdb5_intr_cause) == ARRAY_SIZE(cpm6_intr_cause));
+
+static u32 amd_mdb_pcie_merged_host_mask(struct amd_mdb_pcie *pcie)
+{
+	return pcie->variant->version == CPM6 ?
+	       BIT(AMD_CPM6_MERGED_MISC_EVENT_HOST0) |
+	       BIT(AMD_CPM6_MERGED_PCIE_ERR_HOST0) :
+	       BIT(AMD_CPM6_MERGED_MISC_EVENT_HOST1) |
+	       BIT(AMD_CPM6_MERGED_PCIE_ERR_HOST1);
+}
+
+static void amd_mdb_pcie_clear_aggregators(struct amd_mdb_pcie *pcie)
+{
+	if (pcie->variant->version == MDB5)
+		return;
+
+	/*
+	 * Clear this host's serviced contributions (MISC_EVENT and PCIE_ERR)
+	 * from MERGED.
+	 */
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
 
@@ -81,14 +226,21 @@ static void amd_mdb_intx_irq_mask(struct irq_data *data)
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
+		/*
+		 * Writing '1' to a bit in AMD_MDB_TLP_IR_DISABLE_MISC disables
+		 * that interrupt, writing '0' has no effect.
+		 */
+		writel_relaxed(val, pcie->intr_base + pcie->variant->misc_disable_reg);
+	} else {
+		/* CPM6 shares one INTx enable; drop it on the last mask. */
+		pcie->intx_refmask &= ~BIT(data->hwirq);
+		if (!pcie->intx_refmask)
+			writel_relaxed(pcie->variant->intx_mask,
+				       pcie->intr_base + pcie->variant->misc_disable_reg);
+	}
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -101,14 +253,21 @@ static void amd_mdb_intx_irq_unmask(struct irq_data *data)
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
+		/*
+		 * Writing '1' to a bit in AMD_MDB_TLP_IR_ENABLE_MISC enables
+		 * that interrupt, writing '0' has no effect.
+		 */
+		writel_relaxed(val, pcie->intr_base + pcie->variant->misc_enable_reg);
+	} else {
+		/* CPM6 shares one INTx enable; raise it on the first unmask. */
+		if (!pcie->intx_refmask)
+			writel_relaxed(pcie->variant->intx_mask,
+				       pcie->intr_base + pcie->variant->misc_enable_reg);
+		pcie->intx_refmask |= BIT(data->hwirq);
+	}
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -148,42 +307,40 @@ static irqreturn_t dw_pcie_rp_intx(int irq, void *args)
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
 
 	return IRQ_HANDLED;
 }
 
-#define _IC(x, s)[AMD_MDB_PCIE_INTR_ ## x] = { __stringify(x), s }
-
-static const struct {
-	const char	*sym;
-	const char	*str;
-} intr_cause[32] = {
-	_IC(CMPL_TIMEOUT,	"Completion timeout"),
-	_IC(PM_PME_RCVD,	"PM_PME message received"),
-	_IC(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
-	_IC(MISC_CORRECTABLE,	"Correctable error message"),
-	_IC(NONFATAL,		"Non fatal error message"),
-	_IC(FATAL,		"Fatal error message"),
-};
-
 static void amd_mdb_event_irq_mask(struct irq_data *d)
 {
 	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = &pcie->pci;
 	struct dw_pcie_rp *port = &pci->pp;
 	unsigned long flags;
-	u32 val;
 
 	raw_spin_lock_irqsave(&port->lock, flags);
-	val = BIT(d->hwirq);
-	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
+	if (pcie->variant->version != MDB5 &&
+	    d->hwirq == AMD_CPM6_PCIE_INTR_CMPL_TIMEOUT)
+		writel_relaxed(AMD_CPM6_PCIE_ERR_MASK_ALL,
+			       pcie->intr_base + AMD_CPM6_PCIE_ERR_DISABLE);
+	else
+		writel_relaxed(BIT(d->hwirq),
+			       pcie->intr_base + pcie->variant->misc_disable_reg);
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -193,11 +350,15 @@ static void amd_mdb_event_irq_unmask(struct irq_data *d)
 	struct dw_pcie *pci = &pcie->pci;
 	struct dw_pcie_rp *port = &pci->pp;
 	unsigned long flags;
-	u32 val;
 
 	raw_spin_lock_irqsave(&port->lock, flags);
-	val = BIT(d->hwirq);
-	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
+	if (pcie->variant->version != MDB5 &&
+	    d->hwirq == AMD_CPM6_PCIE_INTR_CMPL_TIMEOUT)
+		writel_relaxed(AMD_CPM6_PCIE_ERR_MASK_ALL,
+			       pcie->intr_base + AMD_CPM6_PCIE_ERR_ENABLE);
+	else
+		writel_relaxed(BIT(d->hwirq),
+			       pcie->intr_base + pcie->variant->misc_enable_reg);
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -226,13 +387,43 @@ static irqreturn_t amd_mdb_pcie_event(int irq, void *args)
 {
 	struct amd_mdb_pcie *pcie = args;
 	unsigned long val;
+	u32 ev_raw, err;
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
+	/* On CPM6 completion timeout is reported via PCIE_ERR. */
+	err = readl_relaxed(pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS);
+	if (err) {
+		u32 pending = err & ~readl_relaxed(pcie->intr_base +
+						   AMD_CPM6_PCIE_ERR_MASK);
+
+		if (pending & AMD_CPM6_PCIE_ERR_MASK_ALL)
+			generic_handle_domain_irq(pcie->mdb_domain,
+						  AMD_CPM6_PCIE_INTR_CMPL_TIMEOUT);
+		/* Clear every asserted bit so the leaf and MERGED de-assert. */
+		writel_relaxed(err, pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS);
+	}
+
+	/* Sticky aggregation bits; clear each pass or the IRQ re-fires */
+	amd_mdb_pcie_clear_aggregators(pcie);
 
 	return IRQ_HANDLED;
 }
@@ -250,24 +441,47 @@ static void amd_mdb_pcie_free_irq_domains(struct amd_mdb_pcie *pcie)
 	}
 }
 
-static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
+static void amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
 {
-	unsigned long val;
+	u32 misc_mask_all;
+	u32 val;
+
+	misc_mask_all = pcie->variant->misc_mask_all;
 
 	/* Disable all TLP interrupts. */
-	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
-		       pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
+	writel_relaxed(misc_mask_all,
+		       pcie->intr_base + pcie->variant->misc_disable_reg);
+
+	if (pcie->variant->version != MDB5)
+		writel_relaxed(AMD_CPM6_PCIE_ERR_MASK_ALL,
+			       pcie->intr_base + AMD_CPM6_PCIE_ERR_DISABLE);
 
 	/* Clear pending TLP interrupts. */
-	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
-	val &= AMD_MDB_PCIE_IMR_ALL_MASK;
-	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
+	val = readl_relaxed(pcie->intr_base + pcie->variant->misc_status_reg) &
+	      misc_mask_all;
+	writel_relaxed(val, pcie->intr_base + pcie->variant->misc_status_reg);
+
+	if (pcie->variant->version != MDB5) {
+		val = readl_relaxed(pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS) &
+		      AMD_CPM6_PCIE_ERR_MASK_ALL;
+		writel_relaxed(val, pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS);
+	}
 
 	/* Enable all TLP interrupts. */
-	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
-		       pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
-
-	return 0;
+	writel_relaxed(misc_mask_all,
+		       pcie->intr_base + pcie->variant->misc_enable_reg);
+
+	if (pcie->variant->version != MDB5) {
+		writel_relaxed(AMD_CPM6_PCIE_ERR_MASK_ALL,
+			       pcie->intr_base + AMD_CPM6_PCIE_ERR_ENABLE);
+
+		/*
+		 * Unmask this host's MISC_EVENT and PCIE_ERR inputs in the
+		 * shared MERGED aggregator so they reach the GIC.
+		 */
+		writel_relaxed(amd_mdb_pcie_merged_host_mask(pcie),
+			       pcie->slcr + AMD_CPM6_MERGED_ENABLE);
+	}
 }
 
 /**
@@ -327,10 +541,13 @@ static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
 static irqreturn_t amd_mdb_pcie_intr_handler(int irq, void *args)
 {
 	struct amd_mdb_pcie *pcie = args;
+	const struct amd_mdb_intr_cause *intr_cause;
 	struct device *dev;
 	struct irq_data *d;
 
 	dev = pcie->pci.dev;
+	intr_cause = pcie->variant->version == MDB5 ?
+		     mdb5_intr_cause : cpm6_intr_cause;
 
 	/*
 	 * In the future, error reporting will be hooked to the AER subsystem.
@@ -351,15 +568,19 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
 	struct dw_pcie *pci = &pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = &pdev->dev;
+	const struct amd_mdb_intr_cause *intr_cause;
 	int i, irq, err;
 
+	intr_cause = pcie->variant->version == MDB5 ?
+		     mdb5_intr_cause : cpm6_intr_cause;
+
 	amd_mdb_pcie_init_port(pcie);
 
 	pp->irq = platform_get_irq(pdev, 0);
 	if (pp->irq < 0)
 		return pp->irq;
 
-	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
+	for (i = 0; i < ARRAY_SIZE(mdb5_intr_cause); i++) {
 		if (!intr_cause[i].str)
 			continue;
 
@@ -379,7 +600,7 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
 	}
 
 	pcie->intx_irq = irq_create_mapping(pcie->mdb_domain,
-					    AMD_MDB_PCIE_INTR_INTX);
+				    pcie->variant->intx_hwirq);
 	if (!pcie->intx_irq) {
 		dev_err(dev, "Failed to map INTx interrupt\n");
 		return -ENXIO;
@@ -435,9 +656,36 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
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
+		 * CPM6 moves the per-controller MISC_EVENT/PCIE_ERR registers
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
@@ -483,6 +731,9 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
 
 	pci = &pcie->pci;
 	pci->dev = dev;
+	pcie->variant = of_device_get_match_data(dev);
+	if (!pcie->variant)
+		return -EINVAL;
 
 	platform_set_drvdata(pdev, pcie);
 
@@ -514,9 +765,51 @@ static void amd_mdb_pcie_shutdown(struct platform_device *pdev)
 	gpiod_set_value_cansleep(pcie->perst_gpio, 1);
 }
 
+static const struct amd_mdb_pcie_variant cpm6_host = {
+	.version = CPM6,
+	.misc_status_reg = AMD_CPM6_MISC_EVENT_STATUS,
+	.misc_mask_reg = AMD_CPM6_MISC_EVENT_MASK,
+	.misc_enable_reg = AMD_CPM6_MISC_EVENT_ENABLE,
+	.misc_disable_reg = AMD_CPM6_MISC_EVENT_DISABLE,
+	.misc_mask_all = AMD_CPM6_MISC_EVENT_MASK_ALL,
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
+	.misc_mask_all = AMD_CPM6_MISC_EVENT_MASK_ALL,
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

