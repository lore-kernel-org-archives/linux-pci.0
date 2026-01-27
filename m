Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9552D47FF;
	Tue, 27 Jan 2026 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503885; cv=fail; b=i3pu21AbJrWSzTfenUp3WGofPhuQsrdrobFH5lPvpb/Kv/3jyojKILU2ZAEmj9/7+eNhyCOubaQLEBiVhX7Pmef9wLyePc+KjhNo4qpWUzVR+AGiL+4xOzjLNPRUHYoF7SAA4BSZAayN1CiiEe2m8q84u8aD5GBo4rT+hsUwBrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503885; c=relaxed/simple;
	bh=x/cLJAqyVzbrWydRZh+2fJpjaHVdKTbPVeQB61ijpOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjG8BodhIYtvucrPW+PWfFHBocjhBihnKsv9+bWaYR1Trbhac8Dhl6Dkkm/X+4GyyzXcnSUm9HGsrzUGgRV/aIzu1MrwX7jULWdCrJ9iaKETVQ3318j9XSHVMtFOhGcSLY+GarWeUhJR80vThyJvJo+7XY8AKbeHejHOSz43X2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mGlOA1ip; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mGlOA1ip"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9qLXdgNjlpXSMPsIwAipQuNw7JC5zSz9VaCIahbO0tfmtUOnZKHxjiWlAR4qP+/aYJhUhE/YDgWDVcdyhdBHI680loa3p2pRa9Eiw/N63aSiPSgXN/77vV6ep+oIti5szLkmr8fiGLZH+pkoEbcnyk+FKrnzD8cZjnLKw8QTbVxdOWyLvmtfSTMAEtF0ub2qVIUkK6Cq+jFOboBNIwASZuKzRdsVQWrvFUDq+iIzR5aHgLw7Jb7kr329ptWJEBahnl9c9SPLrFNVqZlfQ6mE7OLxNJFc5BlfoZvU7Yh30gko74QMx1fY91PDObtRfUkM2iFRI3JBW5cK/KUe3RzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXzheLLFf6eEqwDmMMK4tVhNhSPlLNWjs8VbslRg3qw=;
 b=TkES7G4trx/dD7H+z00LIOJf0MqKJzK2SjNoFlkZq1ml0PaqlQfP+W4v7GofSuk/p1KsTwbAvjVfaUZVzNLhfqePDD+7X2q5iAwWq0kscl1K/wIs1JAzup2sl0ghOLGG5JvL8Qj56fJUG1SRzbHWGflen1uZaTzMne1XTrDi4lThUjTUjiz8IW7l0GHJ6zi4y4lBoO1ga8nM8hwhP3s3dDMNrLCYqYWI9JRjf867UeSm0hZwkApFSlp/jTvCvVm0LMECyvtufcpUQGPyplmTDTHkq+OoxN7nHaFdHyResoNT2j+3hEjYtVOGzg11Q8gwhXny8SmF2Wr+k/gSuYyEgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXzheLLFf6eEqwDmMMK4tVhNhSPlLNWjs8VbslRg3qw=;
 b=mGlOA1ipEsqLZd86N+3RXGJCWCdqDyB0Nay6ZIhZTrvmVNUcXc1XIop1eJsH7RnupQT4k+cR3h03GHOfFyISD7+2elU24yycxXPUPVtrPUWtzF2NQNlWBsFlQCRmGu3SOm5xcWb4zXs92QiOWzdQwanM2R8ib+mOxDGNQNKiNvg=
Received: from PH0PR07CA0073.namprd07.prod.outlook.com (2603:10b6:510:f::18)
 by DS0PR10MB7248.namprd10.prod.outlook.com (2603:10b6:8:fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:51:20 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::7f) by PH0PR07CA0073.outlook.office365.com
 (2603:10b6:510:f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 08:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:51:18 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:50:56 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:50:56 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:50:56 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8ol4d4071462;
	Tue, 27 Jan 2026 02:50:52 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<xiaowei.bao@nxp.com>, <gustavo.pimentel@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v3 1/3] PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
Date: Tue, 27 Jan 2026 14:20:08 +0530
Message-ID: <20260127085010.446116-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127085010.446116-1-a-garg7@ti.com>
References: <20260127085010.446116-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS0PR10MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe7fa00-a5cd-43b8-976d-08de5d813ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4tv95Tkn8mGSCQrqDWxvg24v8Obsd+KRnxvupI/1LC54popAnDx/fKP7CHP9?=
 =?us-ascii?Q?7AfWrSc4o9oBmt4io0NFIwLwvgqAlkEA5YKK9zsXx231HNUXH0o6a3uxIpDg?=
 =?us-ascii?Q?B4BeiPrXIR2gaoESH+Ds5EWITCkqLSd13iA4JLmAADJ6ecePx9XuPXc0cWad?=
 =?us-ascii?Q?rkDocgefFvD4aQBfsz1cgRHyosufTOgSo8ddoqnD7/beHQGxjD9QvNZKOTL9?=
 =?us-ascii?Q?ZMdq9MteHzTDWvMjiA3mgHVSUyRJ/nmFYdvIuT3SSKDpCW1PRuKj4GRlFsrg?=
 =?us-ascii?Q?uSRk3kgZL7+71cMyta7ZyU16ZxOQKSXtHMWnOjLGlQNRH43p0JUnN6V3qsup?=
 =?us-ascii?Q?3AN3HYlat4arM2SvxkAHEGjfgkT8rqafD+ucWtlAIVDNo+bmsdKU4KRAUmj0?=
 =?us-ascii?Q?8sNBGKVCNiQagAhmG8o2jUVmrubNuaKKhmObzmePw79RzziFMa79T+hONMuW?=
 =?us-ascii?Q?uJUnt6uVuz88hdq/IxROSsU6NmAGKcOjNWoReMI0w+eo5NuGw4epOIcGFZit?=
 =?us-ascii?Q?1rQ4hXxph1pcCevtQURutdsRxbnAhPRObYfsSRMemC7amaBqgGte6ylJ6vn2?=
 =?us-ascii?Q?hUcFvLC2Ab3fJrJ/vHAAT5QwqQTQvhhby+Q0v+JOkNKY7Q8boZGJ0NfUGkxA?=
 =?us-ascii?Q?uAEnR1JMnobAbC6mYFL4NpAJT3rU67ftfi++b67whCeZJ8r7HxkqOwLaDUHt?=
 =?us-ascii?Q?ZsDfzRXiDUS4loxhYgQs+RsGwiufQTqnIn+F7oigtIqjcIRP5TR6vrYd8t+i?=
 =?us-ascii?Q?A3i0K/s07oRFOo94McFs/yKO7GqOgKYP54N5bpKypg4Bky+1BWfO2bbXkchl?=
 =?us-ascii?Q?FHNd0zbA98H6jxnpBZh0usHny+sZePo0y5HgT4TMUJoNmikcEM/KoU+wQqD4?=
 =?us-ascii?Q?tlikiNKbL9Mgj/LpGacUk1TC94dSyGKJJ6XnGJK5U0m/CuCR8PNqti7KkvKo?=
 =?us-ascii?Q?txalyGxK7VFKxHq2UiXwsLLYSritp+3ixvunySMOyjCgMVfSvv6CrSWyOvtA?=
 =?us-ascii?Q?3uAmNidXrwB25MsWM8GLHZ9pSJ5Zbw3TSy/RNLahAkQAGBiMj/6cJlJR0m2i?=
 =?us-ascii?Q?hv+Ppp1Dzxb7uQosfx4ee0fwvuoyq+pMWdzHrRhbevLu7UpQchxw3MTsAd/q?=
 =?us-ascii?Q?PA3yiYz64KnBOGx+5Pu380AfLMInzuQBrvEQrjR52z4gGmC1kO4AcK89l/JO?=
 =?us-ascii?Q?/i/wlq5p/YYVpbSKMDDVdBSrSGCgHP6QitnFjEVJivOkKH2YU/eVAvd5IO6r?=
 =?us-ascii?Q?UkETHYYX9Zz26ZXWooe2LGFexoa4Pq+xIns7KtCxrpdDNE9sKZL8aendCgkB?=
 =?us-ascii?Q?IRYAKGy6miYeE5XBsmyKtV7LTuwhoVUnnW5L858gkRBZFqzuZ4p4uJ7gEMdm?=
 =?us-ascii?Q?Z+YOazxRgijStW7Mwz804JpdNyEi3OZ4M8YPjeEWpwpncNjHcRJZT1wlBZTI?=
 =?us-ascii?Q?8t5YY3I3sElcsTFlrtu0+hNN0nIOfHGCRLcs2XwgNrHWbJMWdCsBbjDjj1ym?=
 =?us-ascii?Q?8Fu1FS1ZyQ1TwbOV0Q/yIwqETEoc2xpc1yDIz1mGVOiEH/Bu6jxFxlO+udD7?=
 =?us-ascii?Q?qlSCHeqeFVMHCMky1POvGYLt6f3ryXvJKPXTKaAdBzs/2D+8TqOfmRS4i9/h?=
 =?us-ascii?Q?b5+Tt1AOM2OQoaKE64s8YxXcaAT/YSFULc60PsvHp61uxu4evUSdDFnWmdOX?=
 =?us-ascii?Q?TBhiA3zUEwScUOJ9m49vzMhNyNA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:51:18.1648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe7fa00-a5cd-43b8-976d-08de5d813ca1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7248

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

Changes from v2 to v3:
- Changed function name from __dw_pcie_ep_init_non_sticky_registers()
  to dw_pcie_ep_init_rebar_registers()

Changes from v1 to v2:
- Fixed the suggested nit

v2: https://lore.kernel.org/all/20260122082538.309122-2-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260121054214.274429-2-a-garg7@ti.com/

 .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++-------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 19571ac2b961..659a56aa8664 100644
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
+static void dw_pcie_ep_init_rebar_registers(struct dw_pcie_ep *ep, u8 func_no)
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
+		dw_pcie_ep_init_rebar_registers(ep, func_no);
 
 	dw_pcie_setup(pci);
 	dw_pcie_dbi_ro_wr_dis(pci);
-- 
2.34.1

