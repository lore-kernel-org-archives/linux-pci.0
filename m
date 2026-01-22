Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F76B3596F6;
	Thu, 22 Jan 2026 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070358; cv=fail; b=dVfhq7GxiQ0YlhySEhuVVbiE5IRbd+vxHekj2uRTsQSuobaSAYJo1bKlpoqr6Q1mMr4MPs4QSSePOQAKuksul7ZuYmQzOhidJPJ/hBYVYq96v1xwVYkgjUAMW1paTgtAsg29RE3t7aY2WB15X96kEi9dBMyJCcvcfTudjUpTHNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070358; c=relaxed/simple;
	bh=hA0U5+O4H8SL7yef/f3s/tYgqEBVucEpzWNZMrGt87o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgSmjQFU37DeND62wz3A6QLE0UzvMHxQWzSRzkd3nYwQfGkHFptbuXCc0FKYQb+me677N52/Vgkh8YJoLj/NHEeOg7IPJHbZoSXaeKNJ0VmMGi6Wto8ITU88PwI5oA1YKgAUQFlWhcXjZyWNTWyjixZjq8TOucsJl3QUfHrJvEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vcdDtqvL; arc=fail smtp.client-ip=52.101.46.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vcdDtqvL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iM8hb4ifasy1QWVLSwpqCnulORHYGm6Xux/F1JUK4mljPt73RmKcU1uxkvFB9gqggXBEJ10DBenvThPyvGiniRbJTyp7563RdblF1MgXH7pltix0NdUGp0mMOKTfigJk1KhEOJAzSGqk4BH4njRva6BefvZNB3u/aNHJ3RQrwKbBbSs95Z02Mfs0CVTcrVNHCicxHdzRs+djbXi5kxaKx1L1o1G+5jUn8935zSkKHqScNn4id877WhOC07GN7JP7sKt7npNlkoWWZUexQerDczcz16cILFlPqHltJsPqpZzEuCWvbP7XfVYtQ3Z4UBrWOtvJm/jM5f0ZU8XFniHINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26kGJL+ZWVVW1pBUNntjJ8xY6oq0Ga8PpM7eIMVYBNk=;
 b=lzPJ3aUVeJ/8IoaaGSjxpw6tzBvTMX3qRTMH8+kwM6IHC7Ujb//jBwPeVj5C6LRZhs91LiMCFD5/4R9m+113+YdQCGIvvgU9EMnB4YbZP6RnrVLPQZRtHgOtet9ZQZxqS6FRp8/Zx3TNuGu7Zg+W42Q8xufdGWrZ7dJ0zV88KfiPpFnZCOsHamDUjlJBybhgozfCFZkubr8yr7jSyQ5mPm4RPNJgzRjpaox1U/HMV/SNwAJ3KQZ7imFgU77PmBnIqTt5Rrj5YXayEJtqB6WicVAD+JOOS/f6W55xsGSKyoJk3H9QyEe3oLy/5F5NjAfvq5dpGQ97xNzqVkNbaTCyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26kGJL+ZWVVW1pBUNntjJ8xY6oq0Ga8PpM7eIMVYBNk=;
 b=vcdDtqvLhDMG2w0f5wWaT78heKms7EZ7vCCVltF/KGaRra67GRBsJfl1zzWubTdxWG07e9d07e9O0YEW/dAMK79ZRUJYA0wSuOttnX7NW0T2dnHLEFu7Cq/8p9Mm/wxINsO5PuIdS6O8JICdRMztPb6dbll+muZvl+fyucseNxQ=
Received: from BN0PR04CA0196.namprd04.prod.outlook.com (2603:10b6:408:e9::21)
 by CO1PR10MB4691.namprd10.prod.outlook.com (2603:10b6:303:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 08:25:53 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::9b) by BN0PR04CA0196.outlook.office365.com
 (2603:10b6:408:e9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Thu,
 22 Jan 2026 08:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Thu, 22 Jan 2026 08:25:53 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 02:25:52 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 02:25:52 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 02:25:52 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60M8Pi0G125446;
	Thu, 22 Jan 2026 02:25:49 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v2 1/3] PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
Date: Thu, 22 Jan 2026 13:55:36 +0530
Message-ID: <20260122082538.309122-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122082538.309122-1-a-garg7@ti.com>
References: <20260122082538.309122-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CO1PR10MB4691:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c62f5c0-fa3a-43e6-4274-08de598fdbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CuRODc5Im+8YpJA2NTk2Jcyxz1jrebPwldLT3nKb0pGqQnz5505NpfI+c0xg?=
 =?us-ascii?Q?Zv5UjykVYaXaH11A8tlXbZZ0o0Voc2NY5LTg20xDMC9I2je6O27VfNfwiQ0U?=
 =?us-ascii?Q?eXJFLjeroGMf4z/JqSbBMlmj8xIsC94znvmfO4jJoLYGWJgPQjrrbxsyBsNZ?=
 =?us-ascii?Q?e3be8pMFOrAH3IR+c+Tu+DmAN+FMviTgd6jKalnV9Hwp2n1UBrhdR6CEGacX?=
 =?us-ascii?Q?8p0dQFeUz65Thn6SSiqz6gqSpXL7XcFJRjJcPPSd5WkkBZz5RJxLf7Z+3WcF?=
 =?us-ascii?Q?4k+XIUOERlRvgh5YyoVOtUyu9RWp5hSqMindsxvLGiKc0cSFM0fH7LihjYLr?=
 =?us-ascii?Q?nICyqZh1x7wXWOgnW8qK9CPLnmc55o5/Kybesn5gX483oubud2rkAvrZhaTY?=
 =?us-ascii?Q?sv0JXt9F4N3wmyCoLqwbfEVVqYN0HUV00DhkmyzDXpGtWIt1vv0Eg6m+oGXT?=
 =?us-ascii?Q?EnMN3mBrXfx/ZWmsdcMz5MtB+WM7xm1fVYgFxBoJaMk6BhpK5mpw8zBD0kYt?=
 =?us-ascii?Q?zQ+NjA9R0n7h5lqezo+5FjM8agJNjHF/QV0t/ftOAxcYRo8K34hqmYXVBdT9?=
 =?us-ascii?Q?SQljbIYQv9vpI/SzN6D6TYHuA/s1vs2u9Pub3lfMrOjx3sU3/vxd22N7GYSJ?=
 =?us-ascii?Q?2OXqpsYEE56mZAf6rvVECfk581hih53MRSQ3uMjMTYC5ltqwlMzJqNQ+lZqu?=
 =?us-ascii?Q?rYdkYtiRFRAtCL+V2GICXPbIhrqsOXQz9+5pEMA06/2b1EM0lYZRljA0sNSv?=
 =?us-ascii?Q?eMuPykKp9TdRnXvU5JN9azS546O2PtqSgJRVo+slHuU9cjSkOuRmXuAmg/vZ?=
 =?us-ascii?Q?6Itxba6kQHzNIHm6TlwyA0wZpo9vlpO8UOKZr83xH1G5m7TK8J8jBNJ1etx/?=
 =?us-ascii?Q?sQM/BT7FVsfrn0wMJvYz3A7uKoVDNL9xpiKdDvwIQHeGu2nyUO7ySeSo/o80?=
 =?us-ascii?Q?jSREwS/d2W3FctyFcOscHT7LHaxbP+c9VcSSO1AshrqpQAfp9Fk4207z1KX/?=
 =?us-ascii?Q?6f0LHvtD4AiYa95mARt2RT7jwA6/sBTrM422Ob8RexyD95yCmAihKQnJD9AW?=
 =?us-ascii?Q?x8y/4uDQzSlv1w3asCUtfKyeCpaDUYnYVZ0+FFuAMw5eIHHGoQvtd+vMKlYP?=
 =?us-ascii?Q?443KU/FUByZHW6jf57PuwYk130R7QEfiEy/4umeED+IPka7Naj14AZ2XIscC?=
 =?us-ascii?Q?tyicCisjrZ3R+EQTEalU64bjZjhaP/N9n1xQ9SHJnl5HmwRrs4tFZ5udekiZ?=
 =?us-ascii?Q?jw0yF4ZtELhjwJFyYG8+V1Qc4iNrIqE4GR6xfRj97dc3im9Vn6lXotc1w8q1?=
 =?us-ascii?Q?GioSp6XnvWFpU5lLFBq/cUetstD5M9rZJN8TxkVeSY8/OSAO60m5coH/BgM9?=
 =?us-ascii?Q?F0fxVNWqKaNKFaQd+L2VdZfLFLw9UAYWXlD1t5crKqIZncZbtfYgPHRmV1D8?=
 =?us-ascii?Q?h4P77OrjkhjoSfIxI8raNm/FG9XqvAqQeXctDRhuh0VSIr8iA0ROZbVUMJug?=
 =?us-ascii?Q?6cddYuRoUyxLwqFCtjzwADdXcXbtz5fpZWFCf6BadwWTjZQ3ta6MGxGodMq9?=
 =?us-ascii?Q?ULDy/sbyTNq+f8pH95PuzeQmg2ZQvxVuU+XoopTNaR5ACR2n3Qt+0WPIdmlF?=
 =?us-ascii?Q?pe2EVHCcjV6pyqqJ4026+uMHsGxQCdcpKTf6M6CpW7ONWy3rok/Q3fKWzPEp?=
 =?us-ascii?Q?mB3cnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:25:53.3759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c62f5c0-fa3a-43e6-4274-08de598fdbbc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691

The resizable BAR support added by the commit 3a3d4cabe681
("PCI: dwc: ep: Allow EPF drivers to configure the size of Resizable
BARs") incorrectly configures the resizable BARs only for the first
Physical Function (PF0) in EP mode.

The resizable BAR configuration functions use generic dw_pcie_*_dbi
operations instead of physical function specific dw_pcie_ep_*_dbi
operations. This causes resizable BAR configuration to always target
PF0 regardless of the requested function number.

Additionally, dw_pcie_ep_init_non_sticky_registers() only initializes
resizable BAR registers for PF0, leaving other PFs unconfigured during
the execution of this function.

Fix this by using physical function specific configuration space access
operations throughout the resizable BAR code path and initializing
registers for all the physical functions that support resizable BARs.

Fixes: 3a3d4cabe681 ("PCI: dwc: ep: Allow EPF drivers to configure the size of Resizable BARs")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---

Link to v1:
https://lore.kernel.org/all/20260121054214.274429-2-a-garg7@ti.com/

Changes from v1 to v2:
- Fixed the suggested nit

 .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++-------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 19571ac2b961..1458477a6ba9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -75,6 +75,13 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 				 cap, ep, func_no);
 }
 
+static u16 dw_pcie_ep_find_ext_capability(struct dw_pcie_ep *ep,
+					  u8 func_no, u8 cap)
+{
+	return PCI_FIND_NEXT_EXT_CAP(dw_pcie_ep_read_cfg, 0,
+				     cap, ep, func_no);
+}
+
 /**
  * dw_pcie_ep_hide_ext_capability - Hide a capability from the linked list
  * @pci: DWC PCI device
@@ -217,22 +224,22 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	ep->bar_to_atu[bar] = 0;
 }
 
-static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
+static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie_ep *ep, u8 func_no,
 						enum pci_barno bar)
 {
 	u32 reg, bar_index;
 	unsigned int offset, nbars;
 	int i;
 
-	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
+	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
 	if (!offset)
 		return offset;
 
-	reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+	reg = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
 	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, reg);
 
 	for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL) {
-		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+		reg = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
 		bar_index = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, reg);
 		if (bar_index == bar)
 			return offset;
@@ -253,7 +260,7 @@ static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
 	u32 rebar_cap, rebar_ctrl;
 	int ret;
 
-	rebar_offset = dw_pcie_ep_get_rebar_offset(pci, bar);
+	rebar_offset = dw_pcie_ep_get_rebar_offset(ep, func_no, bar);
 	if (!rebar_offset)
 		return -EINVAL;
 
@@ -283,16 +290,16 @@ static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
 	 * 1 MB to 128 TB. Bits 31:16 in PCI_REBAR_CTRL define "supported sizes"
 	 * bits for sizes 256 TB to 8 EB. Disallow sizes 256 TB to 8 EB.
 	 */
-	rebar_ctrl = dw_pcie_readl_dbi(pci, rebar_offset + PCI_REBAR_CTRL);
+	rebar_ctrl = dw_pcie_ep_readl_dbi(ep, func_no, rebar_offset + PCI_REBAR_CTRL);
 	rebar_ctrl &= ~GENMASK(31, 16);
-	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
+	dw_pcie_ep_writel_dbi(ep, func_no, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
 
 	/*
 	 * The "selected size" (bits 13:8) in PCI_REBAR_CTRL are automatically
 	 * updated when writing PCI_REBAR_CAP, see "Figure 3-26 Resizable BAR
 	 * Example for 32-bit Memory BAR0" in DWC EP databook 5.96a.
 	 */
-	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CAP, rebar_cap);
+	dw_pcie_ep_writel_dbi(ep, func_no, rebar_offset + PCI_REBAR_CAP, rebar_cap);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 
@@ -836,20 +843,17 @@ void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
 
-static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
+static void __dw_pcie_ep_init_non_sticky_registers(struct dw_pcie_ep *ep, u8 func_no)
 {
-	struct dw_pcie_ep *ep = &pci->ep;
 	unsigned int offset;
 	unsigned int nbars;
 	enum pci_barno bar;
 	u32 reg, i, val;
 
-	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
-
-	dw_pcie_dbi_ro_wr_en(pci);
+	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
 
 	if (offset) {
-		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+		reg = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
 		nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, reg);
 
 		/*
@@ -870,16 +874,28 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 			 * the controller when RESBAR_CAP_REG is written, which
 			 * is why RESBAR_CAP_REG is written here.
 			 */
-			val = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+			val = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
 			bar = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, val);
 			if (ep->epf_bar[bar])
 				pci_epc_bar_size_to_rebar_cap(ep->epf_bar[bar]->size, &val);
 			else
 				val = BIT(4);
 
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, val);
+			dw_pcie_ep_writel_dbi(ep, func_no, offset + PCI_REBAR_CAP, val);
 		}
 	}
+}
+
+static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
+{
+	struct dw_pcie_ep *ep = &pci->ep;
+	u8 funcs = ep->epc->max_functions;
+	u8 func_no;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	for (func_no = 0; func_no < funcs; func_no++)
+		__dw_pcie_ep_init_non_sticky_registers(ep, func_no);
 
 	dw_pcie_setup(pci);
 	dw_pcie_dbi_ro_wr_dis(pci);
-- 
2.34.1

