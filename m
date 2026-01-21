Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C5E421F1E;
	Wed, 21 Jan 2026 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974193; cv=fail; b=eJYFAayndr+XZLTmVMKaTOHv8N5L6oI+8fEvzZKtLnAQOSsWjXFmZDxz2E78IhFOxDTYa9m2uPNiwb3TtR91MwkNXR2x8/QwXqarFpCfjZKIaBi6DliwEAi67C95TlpPMkLNonWW3dMeOCvmBWZQQLUwY4jbDKbZNHnWvHfnwSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974193; c=relaxed/simple;
	bh=XW37bARLBt49TwkgrJWBCKp4i7+BCK6kJt+e5e3vSr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bS7ppyhx2kinrUpwFB0NBl82w/93K5o26zeVThMp/wcj8WGNW87yxx1jbpfugIaI1mpcMwkSLqJ5KTHirWLDCXeVC1uNPo7k4udzPznIJSQRRSbMeThtIMV/RdhYpnZgdB2btryoV7ESiSPUe50OkDXtJx+9Y4/HsyMgZsWbZYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Zn1nBLGV; arc=fail smtp.client-ip=40.107.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zn1nBLGV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sxw2vslt4ejoicB3/FEH+lPtwDto5ZUm5ks6S2dUY8C8STGwULF3kOurl4padPj11+BsgblZaoB5q+yFdmSbnXhee+RyaD5uIlfTuBPI0DOUplIm7eH7aFGEDkkSd1naqraxSpje4SRrSSDsoDpClO3ch0oL4eKZkwo+hjj6+nWD0P1O0hLY0zMayGgfpkGCC+m/QgrNChgSy65regkKqzygR9GKswA/epm8Q9jZOmedpn0VY/DlfiEVAM/2LxEzrndtErm/DyXknKxLCWdRy3qzmBAKdPV3AT3nvlU4rIlFkGuFWYLTmjkCoQUQckHfGFzjv7YnnLvbaxHXVhVVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEwAZtsaI9DygVrF5akUyjeiIy+ncOyK5sE/mz61F8Q=;
 b=G5UkqjJsTPxU5fHZJq6+Iw1WvSHMvDgNgds3ZBzEUdmBh91toD2VmOeXSBo7e7aZlHsZtLoJV1TJKNL1Vut+sn9eDdZa1QtzZSAuX2gQT7wry7317bFr2uvVz0BiSlHb9NpObiVNIhIyKS2fWRBGdtCiU1Bb+9/IA+lYU6jNeCNb1xw9asLP7PeyUQ4BCBZ3PqNIsRNSAutvflYkiQtVkHHY7kVV8vScksgGZVVwh0ACYU2YgGuBrJtYjiiFezibnUra85ylLeRkoBmdC/ssE3fhqbKeTiFfk66re/PWgG9xLBbTc2LyggNgkJYpvycUNleDsrID29bP4EhLLBLbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEwAZtsaI9DygVrF5akUyjeiIy+ncOyK5sE/mz61F8Q=;
 b=Zn1nBLGVCV8ynDPaViRZ5AoVIrgTjeeSkjVb7v2lZjnm+nQ2atPFTe4PbY3ThIqL7ZTMMvDgrkn76qCx+WDqZieoaaIgmLuTZW8efikH52rLw7ST0OGspgkyXbGzEnxq3s/pJTzsyVovW1/Wp9o2HInQC97zfnAPUQ3q6nZclRQ=
Received: from CY5PR19CA0006.namprd19.prod.outlook.com (2603:10b6:930:15::29)
 by LV8PR10MB7966.namprd10.prod.outlook.com (2603:10b6:408:202::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 05:42:57 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::b8) by CY5PR19CA0006.outlook.office365.com
 (2603:10b6:930:15::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 05:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 05:42:56 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:42:56 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:42:56 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 23:42:56 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60L5gmFQ2466752;
	Tue, 20 Jan 2026 23:42:52 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH 1/2] PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
Date: Wed, 21 Jan 2026 11:12:13 +0530
Message-ID: <20260121054214.274429-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121054214.274429-1-a-garg7@ti.com>
References: <20260121054214.274429-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|LV8PR10MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e12da7-db9a-4ebc-fcfd-08de58afee00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k/sRgjWOjQLJ7zcQ+beclpruxykaq9XJR+WTflpuAuat2YPXcjGg0RJTCKDG?=
 =?us-ascii?Q?60/cgdCvaUxqJuFWnPFkKcuMCzYGyZttTMthsCtTrbm1x4mMJdvbqbDSJZSn?=
 =?us-ascii?Q?XktKrhrrz7yqKzQvqkdpuXniRoHrjtW6v+T43SuyQdj10RC0If7ncFVm9WtS?=
 =?us-ascii?Q?yrDq4THjbv3V9ZoSCSBt/8VWf2K1jvObfptpEaLt72vEdkIegae5ne3iEwV0?=
 =?us-ascii?Q?aEZEFqoo4rUQI1lABHDo8RBchcvzQKAyl9uK6BliggRfmX4dHfawB+qhkIL0?=
 =?us-ascii?Q?sNI03bmgzBKzUl634DSle4xdtBp7L76G296iiMeBR0j7/FQfqRZkT/n+Z5Ah?=
 =?us-ascii?Q?E4kCuaXFOI68rxjakopSoVQPYO353pJbg99ZRbkw5zTIe4K+aWtJo4uT1KY2?=
 =?us-ascii?Q?W3irWCqHKObd/fTCBn0TSLYXG6c0jhqjzCtrQUR6aLVL94Qs/b9AM1XCjtcG?=
 =?us-ascii?Q?g+UVfTcJG9qX+4l91kQWPAto72aqsrhu6WmFQL841rPTS9bAjRewmzNSYIfo?=
 =?us-ascii?Q?T6vC5sgHLVXxQQHX5f8n6X3XvnWEtjLAKAhY0PqyHvEy8fooiHLX+wD0wfvl?=
 =?us-ascii?Q?Z7myQS1xnZ6Qvs8Or7HL/K0TFod1rVdR+Ed7JDuxtYFEnu7Nhcrd7fKjftjv?=
 =?us-ascii?Q?gTFGu+EvjM2tAiM9h+VWRLAuwdY43LX9VBWub1XbsKgF5E1gFgLfocuU3oMu?=
 =?us-ascii?Q?sA8WbQ6oKMAdn6LWjh2p53nVI9o7c+o0ZQvM+YU21ysWV2jTSu1yQmQyRfJ9?=
 =?us-ascii?Q?o4DtliHpc4F86H9C1SyEAB2hl6JowEixcfQlkVl0ypd4YcBV5lhgoAOhqPkl?=
 =?us-ascii?Q?sn+PVrR3DXWV6RVbXy0FYuzV82PViczI0XeUHMDLOCSF83RPXc4dR3XhpGSe?=
 =?us-ascii?Q?hAuC2lk+o75Y0SmL5uD3nNjXPTr3Zizz7zx5heSuBSC7T2WoLLPai5CmGzSt?=
 =?us-ascii?Q?y9PkZ7a7VJJ4XFkIJg372lCOss9Ky+ILLjMpoXNe4tR4fHnOutf2W/J5Ir0F?=
 =?us-ascii?Q?996s+Y+hpAP7UsXLU/cXTiArj/J22kC7Pg6BFhduj1R1CHwBxklw7+Z60F/T?=
 =?us-ascii?Q?yNJ6MbOFfWcn3ytIt5NqMt3MeRdO29vSXPXo/Do1KsGciXwwIuSml7aVG3iU?=
 =?us-ascii?Q?xNRm64cHTN/TcEeU8A6CtmwQPNMoeKIsFjctjhbnKoF69doQSBymItuDauJk?=
 =?us-ascii?Q?ExJ4dUptx1SKUKpEi0lmRm8NlbT+19j+IoxYqMYorrQPQxlZN3ZF6etXwVVt?=
 =?us-ascii?Q?BxqhEqeW35MiLqAqCec9HI0Grp+Gjb6x1xz1GxCAg5JJpL3zZ7ij0tqZyvI1?=
 =?us-ascii?Q?lfgD3ZyWgLZCNoJVDQkIH/ULzyhPEhIdKwD3x/mfCMZPFQdT3hZ9aE4/HlNE?=
 =?us-ascii?Q?U7nlCYPT7amfr+3hSpZtt5NpfAHGdGbSfaggTpO0/onZhFw4OG7Q+9jA17xj?=
 =?us-ascii?Q?36v/xoXxwV4W8+GrLwz5D61Qi/t0XDBENC5yCg4BBoCFv73tuKCz6zQ0aB12?=
 =?us-ascii?Q?VaBq05tQR661A//MGwrdpI8m+zXs3GgosvZGiAyjo5brxjEFzF+aJ8dzMBe5?=
 =?us-ascii?Q?hE6MYNhWItGUEBEx+mscAzCm/DkJj5NecQtRfXH6Y6HCD+d2I8U11gakW6wU?=
 =?us-ascii?Q?J+dZsR02+7rn+EBUzlRo4avckRuJfKcdjnCDxNzRItVTLJlyvHIJtdaJIs0C?=
 =?us-ascii?Q?FOD7xg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 05:42:56.7974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e12da7-db9a-4ebc-fcfd-08de58afee00
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7966

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
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 49 +++++++++++++------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 19571ac2b961..f222677a7a87 100644
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
@@ -870,16 +874,29 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
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
+	u8 func_no, funcs;
+
+	funcs = ep->epc->max_functions;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	for (func_no = 0; func_no < funcs; func_no++)
+		__dw_pcie_ep_init_non_sticky_registers(ep, func_no);
 
 	dw_pcie_setup(pci);
 	dw_pcie_dbi_ro_wr_dis(pci);
-- 
2.34.1

