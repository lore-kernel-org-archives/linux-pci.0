Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D92DA749;
	Mon, 17 Aug 2026 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786934398; cv=fail; b=jRinlqbhqnM1VcIrq+HvKneRTHv+lO7Gh3kyszPIZr+ksjyz7iUhu2N8n/mcx4QCmxZNaiXlQHWJ790leD1T0SciUp40JNf+e2cEFPN1h3MwUOrf9PXxlEANeM+mzSrmfqnnNqv0fnDJpoz6eZ+X2oCvLs9746eQQpm24mcWJ9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786934398; c=relaxed/simple;
	bh=nnOA0Dr8+VdtcFFct4Nl/UFY9fCGOTdHTfI8bz3a2tE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnXToEd6reRW0rlStAegHfpFxItuwUXzcwHw/BRcS2uDbDmDh95LnFsFI8pln8mooI1Jj4+WVnUyMiRQXhbjvO9Cd6zlQxlhvEtAu1AuF2/oGrUZdEfuwCeY44jehtf+47moiHieoiUQILaXJBeFWUQ2stOOa8geC/PQrVJXpzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mXwkibp2; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mXwkibp2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2PCTbC2WogqkkjOn9SwhTyBNPoncMgqjxN0XsnB230r0jYrtxgqoDVM9/AKdYmo53Tivi0k7AU09rP7VH9mQh2NQQchMIPmvsg15SFTzC9Z2cHvnJM639B3nmCFlXFFHLPXLttQsOFScfhw/SDfkqZ7r6eQfOhLMc8AsVWxiZzdV+tJVFaCIim7qtld+kqrhHdd2jzAV855PbLgrQT/HLLHDHlQq4Z0mIGtWG5362RnQOMM5eFawoDmEJQ9yThMfKfrZh+eC5asPerlpNKBUEQnKkYmcBXiDs+JkghsxMkbCHcghwEDvw+pj+37AmL+9HLv0d5O/3a3LJxQTA2xvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qLoBqqmViz5ZjOyAXR2O3yl1Upp3uob8zR0IWGg5QA=;
 b=DHfAQvo9a5t8MF9qtaMP2tKFZwY6XGBqC9E2mmNsUigYKueXHcSHGyP3ErKRF6gdYseL0pR0rbNCNbUARfOfpddjETnB60y1l1tSdqDPoArI2LQjAOZKb0USNI2RDJBJxtLbZCF7cCD/rTrpovC2LQrUa8Hgf+9UgfSC2U4Ml9dITU/9MbAStOEuNhYCWTqodfL/rotqg6rqeEWY+F/9L/fRwf4cXI+e2ejm3etXQflStSONEoIO7YFzssNa/KgiEcjBuhQQ5EQG0KmIoXrEQ82gEX79ymaynb28RfmQvsVg8TZr5Wc1bRacuM6MSMVxTvwldKViBdUAHnvrThD90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qLoBqqmViz5ZjOyAXR2O3yl1Upp3uob8zR0IWGg5QA=;
 b=mXwkibp2YX9R/s8YEbVBwrgK6R4R0X7F/Twe6bA/vk5Q+tPlx3lhexGkjlcbTdmi5AG4JK3hTLN+bpcwSFrOEgTN1wVZEuMxcAL7Pd+jRDyGYOpjWiIKfnFyQHQmBwIswpfDxqr/RsoOuq3vegNI8Sb3Ow5wPX2axkiZOchRBXY=
Received: from BY3PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:39a::10)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 02:39:50 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::3) by BY3PR03CA0005.outlook.office365.com
 (2603:10b6:a03:39a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 02:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 02:39:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 21:39:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 21:39:47 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Sun, 16 Aug 2026 21:39:43 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v5 2/2] PCI: amd-mdb: Add CPM6 host controller support
Date: Mon, 17 Aug 2026 08:09:32 +0530
Message-ID: <20260817023932.1743100-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260817023932.1743100-1-sai.krishna.musham@amd.com>
References: <20260817023932.1743100-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: a462b3bf-8c9e-46fd-9ff8-08defc08cf63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|23010399003|36860700016|18002099003|22082099003|56012099006|13003099007|6133799003|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	zcROQIApCadPceD58v5ZZ1m33IS5YspGWHTLqm7j0KAnftKDZI6Nuf4E1R4mNp/RJ8iZZHT5q9RMf59+SZ+K1eCaI1dohnhghtIfo/lUZqCZNC3D/7dGs8cwQeVOkAX+AznUWP/keMBHnbJNOIGyKAANTan7Y83NH2tKoj8GOkVzxlHtD0Qg2Svvd3En1F+o2D/6Pd6+OMX3RPBq7r7bUO6/hhhkWXB89qFjODl2SCmKiFnpz4XDk1aJsrb/ObPI7z9qY8HebEsrPQBpY4h0tAChONnY3Ihhv4ylEppqi2RtapKd8sSwRxHc9W8MXOKHQZZ86wpCdzZBA2gyTCQ186drj4xrY2t6KTvIfmK6lbR6VGLUYRIbGTkNfF8z+I/TPorV1JgBdT2NY4GdKdH+pCPt1shbKBC9ivWV0bgR4pYJxnXyI8Qw8Yz9ziHTiQs1tFOHf3qZS3ufu0evb4Ddg3vR+6z9NgJEsS90z3RlQKeViByx9rh4pTSOIVMmMd8k0mtuGK6iWcuaUDxLiU2R5UebnZikqbfu5Bduuz46um/KpCIjzvgWhLSBQNkgD2QDf425UI+B+JuDdJVVaqRXbtcTQ6b/60aaBfXC+PA0jtVPEaeLcutK+JTBq7jyrNfVk000R6WFFf+1oNEjdqejPjba+Na37gC52syoc6b56FT5/J4NKKpD5e/v5uOnKLqXXhf1bkGlfop+5Pkd5gcECA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(13003099007)(6133799003)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GkpwkPr055dSIJOM3R0HEyn3UJbGrbf84ePMFplObhnkeZvRpbC/6C7otzxZiNkHPq3yv8HA9U4U8c1vWqpNDejJNwNWTnSiH7VPypT7RBhaaTbTHea9jpvx+cRUA5z3o7TsuMyhZbTgZQuD2smLtz/ushiLQwgkwb5HoKlEmFK84C1IFu+OnzGtSVHnffylAzS7FY73JzUDG2JADSuePVmXi8jnKe/Kq3RQlwVR4QsaWIEvwJnSS5VyDmc3h8UiO5NjMXHmcv3wT4ig3/z0zuoqfYMDCynGb+WkYJgiY9l3JgQ5JQCWN/qEFrR2iXPbujJ9btcrtEfByFwf2BPJF5GggutP7rNzzdUgGWxMqj3xzXS+opiQeROr31yWkxQmS/DoyS+8e+fY+RWOK5uTztMwL9+MIP54lG8HTI4yiUeLXoRPDpDwm/CgP3aK5oQJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 02:39:50.1207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a462b3bf-8c9e-46fd-9ff8-08defc08cf63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457

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
---
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 480 +++++++++++++++++++---
 1 file changed, 418 insertions(+), 62 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index dee295f281a3..d22a8aa8a7e1 100644
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
@@ -30,7 +47,24 @@
 
 #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)	BIT((x) * 2)
 
-/* Interrupt registers definitions. */
+#define AMD_CPM6_MERGED_STATUS			0x648
+#define AMD_CPM6_MERGED_ENABLE			0x650
+#define AMD_CPM6_MERGED_DISABLE			0x654
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
@@ -39,6 +73,9 @@
 #define AMD_MDB_PCIE_INTR_NONFATAL		27
 #define AMD_MDB_PCIE_INTR_FATAL			28
 
+/* Completion timeout lives in PCIE_ERR_STATUS; give it a dedicated hwirq. */
+#define AMD_CPM6_PCIE_ERR_CMPL_RADM		20
+
 #define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
 #define AMD_MDB_PCIE_IMR_ALL_MASK			\
 	(						\
@@ -51,24 +88,133 @@
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
+};
+
+#define _IC6(x, s)[AMD_CPM6_PCIE_INTR_ ## x] = { __stringify(x), s }
+
+static const struct amd_mdb_intr_cause cpm6_intr_cause[32] = {
+	_IC6(CMPL_TIMEOUT,	"Completion timeout"),
+	_IC6(PM_PME_RCVD,	"PM_PME message received"),
+	_IC6(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
+	_IC6(MISC_CORRECTABLE,	"Correctable error message"),
+	_IC6(NONFATAL,		"Non fatal error message"),
+	_IC6(FATAL,		"Fatal error message"),
 };
 
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
 
@@ -81,14 +227,21 @@ static void amd_mdb_intx_irq_mask(struct irq_data *data)
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
 
@@ -101,14 +254,21 @@ static void amd_mdb_intx_irq_unmask(struct irq_data *data)
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
 
@@ -148,42 +308,40 @@ static irqreturn_t dw_pcie_rp_intx(int irq, void *args)
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
 
@@ -193,11 +351,15 @@ static void amd_mdb_event_irq_unmask(struct irq_data *d)
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
 
@@ -226,13 +388,54 @@ static irqreturn_t amd_mdb_pcie_event(int irq, void *args)
 {
 	struct amd_mdb_pcie *pcie = args;
 	unsigned long val;
+	u32 ev_raw, err, err_pending;
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
+	err = readl_relaxed(pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS);
+
+	val &= pcie->variant->misc_mask_all;
+
+	err_pending = err & ~readl_relaxed(pcie->intr_base + AMD_CPM6_PCIE_ERR_MASK);
+	err_pending &= AMD_CPM6_PCIE_ERR_MASK_ALL;
+
+	/*
+	 * The misc GIC line is shared with the peer host controller. If this
+	 * host has nothing pending, return IRQ_NONE so the shared IRQ core can
+	 * poll the peer and spurious-interrupt detection keeps working. Leave
+	 * the shared aggregators untouched, otherwise the peer's pending
+	 * interrupt would be dropped.
+	 */
+	if (!val && !err_pending)
+		return IRQ_NONE;
+
 	for_each_set_bit(i, &val, 32)
 		generic_handle_domain_irq(pcie->mdb_domain, i);
-	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
+
+	/* Clear handled + any unhandled sticky bits to avoid IRQ storms. */
+	writel_relaxed(ev_raw, pcie->intr_base + pcie->variant->misc_status_reg);
+
+	/* On CPM6 completion timeout is reported via PCIE_ERR. */
+	if (err) {
+		if (err_pending)
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
@@ -250,24 +453,77 @@ static void amd_mdb_pcie_free_irq_domains(struct amd_mdb_pcie *pcie)
 	}
 }
 
-static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
+static void amd_mdb_pcie_disable_interrupts(struct amd_mdb_pcie *pcie)
 {
-	unsigned long val;
+	u32 misc_mask_all = pcie->variant->misc_mask_all;
+	u32 val;
+
+	/* Mask and clear all leaf TLP interrupts. */
+	writel_relaxed(misc_mask_all,
+		       pcie->intr_base + pcie->variant->misc_disable_reg);
+	val = readl_relaxed(pcie->intr_base + pcie->variant->misc_status_reg) &
+	      misc_mask_all;
+	writel_relaxed(val, pcie->intr_base + pcie->variant->misc_status_reg);
+
+	if (pcie->variant->version == MDB5)
+		return;
+
+	/* Mask and clear the CPM6 PCIE_ERR leaf. */
+	writel_relaxed(AMD_CPM6_PCIE_ERR_MASK_ALL,
+		       pcie->intr_base + AMD_CPM6_PCIE_ERR_DISABLE);
+	val = readl_relaxed(pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS) &
+	      AMD_CPM6_PCIE_ERR_MASK_ALL;
+	writel_relaxed(val, pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS);
+
+	/*
+	 * Mask this host's inputs in the shared MERGED aggregator so a stale
+	 * source cannot drive the GIC line the peer host controller shares.
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
@@ -327,10 +583,13 @@ static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
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
@@ -351,15 +610,25 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
 	struct dw_pcie *pci = &pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = &pdev->dev;
+	const struct amd_mdb_intr_cause *intr_cause;
+	unsigned long event_flags = IRQF_NO_THREAD;
 	int i, irq, err;
 
-	amd_mdb_pcie_init_port(pcie);
+	intr_cause = pcie->variant->version == MDB5 ?
+		     mdb5_intr_cause : cpm6_intr_cause;
+
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
+	for (i = 0; i < ARRAY_SIZE(mdb5_intr_cause); i++) {
 		if (!intr_cause[i].str)
 			continue;
 
@@ -379,7 +648,7 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
 	}
 
 	pcie->intx_irq = irq_create_mapping(pcie->mdb_domain,
-					    AMD_MDB_PCIE_INTR_INTX);
+				    pcie->variant->intx_hwirq);
 	if (!pcie->intx_irq) {
 		dev_err(dev, "Failed to map INTx interrupt\n");
 		return -ENXIO;
@@ -393,8 +662,15 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
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
@@ -402,6 +678,9 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
 		return err;
 	}
 
+	/* Arm the hardware only now that all handlers are in place. */
+	amd_mdb_pcie_init_port(pcie);
+
 	return 0;
 }
 
@@ -435,9 +714,36 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
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
@@ -466,6 +772,11 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
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
@@ -483,6 +794,9 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
 
 	pci = &pcie->pci;
 	pci->dev = dev;
+	pcie->variant = of_device_get_match_data(dev);
+	if (!pcie->variant)
+		return -EINVAL;
 
 	platform_set_drvdata(pdev, pcie);
 
@@ -514,9 +828,51 @@ static void amd_mdb_pcie_shutdown(struct platform_device *pdev)
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

