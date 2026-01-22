Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699FB3A8FF9;
	Thu, 22 Jan 2026 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070366; cv=fail; b=tPxRfOY69OOmb++mY3AdG/bhYmkaubdG6bySivwkLAWdXRnDWRX63sdyru1qdXtzBpd0wzv3MAjROccdlLW3wbNOx+8yQz22sudMUjMTYFlweSUwJfwEulE6NqXlHzjIhwlE5o56LlA2sE2Pfu51b2rslzyiIiw2E0oI12hpBGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070366; c=relaxed/simple;
	bh=mylyqG+tohslM5N8SX63VreQXC6XyhEUqYjF7PGNU3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+jgAMFjVFmqmqNM7mW1JAGpe9Z6osGmorlVEGvWRxR6G4PW8pHjvejKKbf2wBq01Fu5fe2nA3bGuM/4UOkHjGm3CiT/opxV3sKI7zHpqcJBzCXTB0gTei4hew4r0UtLZZpCRelTQ6UvNYEoCGUVG8D9bDeJLyn8EVN27xzeg1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PoVeNnRs; arc=fail smtp.client-ip=52.101.61.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PoVeNnRs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmllNvnN1iuHbegjhED0C+woDeenLES192Et4RhvFyBMme62SBdJLu6EAEtvFwf2tK1tC5BAI7UlXWB1r/udnMimJC2K3PtPA04e5UW9sOVsy5bSkG5v51QyzXqeD2S3/N3hWkWVo4w0MIcm4qboVJLn53r9e+8T1eV7+jDXYcAdu+yHD8jxjbReVSp3kT1uGuU0Qa94PP0Ji/p9oU5Y6iqRewUtfFBTGY2HDZ8Zno+cRo0QbMqRaqSA9/99uIn8gRgyqLAONjcmARbyDriC84AyLOSy2mFyU/8QYS2bPbzkldpEoz/9s85hwoVRU6Tv8WnKojRWkvBe1eladO3qlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln/nfIc3B1EtTaMS+RNGroCMUJYaNxPL4qv2+m4U+yc=;
 b=A6ZpYwV4khm818XLiT8F4KnQJ1EqNz+C5opd1pVg1nUFWt63ROprspYVzDlUi54tjCqehLayAuU1vxzyAr0+6twA/MxvPTtAxsdMc+vX3iF05pRcSzf61/FtB5KnH5HYdshR7AuZLk32QB6vZWaQJZIsnhahwA4QLUS16XTzxy9Hpzs2jbM+/pRguY/2LIdXdsSJt5eFhgWE2Bn/OU4OuYhpcXUXvnUDoOGl6wSxD3TwXkWtJqacNlaTX7QZC8gFSGesy6YxEp0zu8s9/llbCxFdffbMG6vLIq1FqrkgnHMKTOQR1Hqzrb4QKH1MT2iex5q2xUxQE1bzKM2wyM/i5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln/nfIc3B1EtTaMS+RNGroCMUJYaNxPL4qv2+m4U+yc=;
 b=PoVeNnRsRNkwhq3W/KKCMwSrnB7FxgCpe00FMvsx5hQ/e8PQ2xwbf76HtmzL78GZi40A3z3hVRdyKJl5u+gTT1L0UG0OSr5oOCJUMvC7pgO6GVrFMP+QhblaTUh63ramuzc152Q9iZ1ODkjm8CEacW5To5uPCLgv5mnjNbuq0U0=
Received: from BYAPR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:c0::42)
 by CO1PR10MB4737.namprd10.prod.outlook.com (2603:10b6:303:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 08:25:57 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::1d) by BYAPR05CA0029.outlook.office365.com
 (2603:10b6:a03:c0::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Thu,
 22 Jan 2026 08:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 08:25:56 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 02:25:56 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 02:25:56 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 02:25:56 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60M8Pi0H125446;
	Thu, 22 Jan 2026 02:25:52 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v2 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU mapping support
Date: Thu, 22 Jan 2026 13:55:37 +0530
Message-ID: <20260122082538.309122-3-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CO1PR10MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: 0347939a-3946-43ba-7adf-08de598fddcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xUbJXEVDQi2aZyiFB6+gp8pG8eyMzLXYt0yimNPmPpS9rac3ziO/EEkOgqjN?=
 =?us-ascii?Q?GaQpDjb5aFVJnbQ0wNkpcgF3dTobyiOJ64Fb/MK6t36w40w6TlO0gm2Y9V6Q?=
 =?us-ascii?Q?5DEqqipZwbfTltgn6LPW+xJViOoAEUOfEzDXp7O8EZ2KOp4/v22vFFUr3/uY?=
 =?us-ascii?Q?enzVzUXbkI/NSmJ6GhYum2KIBc92pDydtLte+EHid5UvUrXm5KrMM0SiEJGN?=
 =?us-ascii?Q?Tt9fxfYwheDcQ640s+0wL1Knnm1Kw9Ml62hMqL66tqpM66k929NodFGrpKi3?=
 =?us-ascii?Q?9t0ISJNyybPGsYfalZj99AbAVE95XA8H+4qkIZedrPky5itcMcUXjqwAxlCE?=
 =?us-ascii?Q?vqUGh2CBNDaJKgCPs535vjNlwtT/RV6YPyBPY1xN29yc1Voajaaso17NS6Eb?=
 =?us-ascii?Q?AYsDg2Gbp1BeVV/3s+0jo/QnM3el0twZnYq4LUC2nZ9loMqMTEd5RTYqqK/G?=
 =?us-ascii?Q?LCjoCLsb0hOBOtAdDuwcn2JK3saGKXPDMCDRV+XyGHDxIEcK+LvVOTxI3YDm?=
 =?us-ascii?Q?bsa2Folm+SsK4UrmzHjmzP2e8I+PYbQhJTUWX9Ls7j0GZ+hb6OiTXv0JAX9+?=
 =?us-ascii?Q?R9let3uVKVMlIYcQ99pwahpgUFllGdHRA0U4uABqLtOcbQXd/JfnLZk/OU2R?=
 =?us-ascii?Q?b2ouTpjpniv9meBiybk8LtCank+zDiCVkYMq6MRQfNfOKHpodaFVbOS4uZFF?=
 =?us-ascii?Q?afLdpoMT9ewf59woyz+mWxLLl2r+hdGgg6W+8aiDvvI03HtDaspG2MSYdhWb?=
 =?us-ascii?Q?+EIw00Fodcb+ijBpg3Z4qMIFXS5eC+a3z3/ShOv0zmlFkN98uFTFZDF7VFyI?=
 =?us-ascii?Q?tU6XbS4mJc8XVDwIFfODs5iIwo+D0fnTbUZgYFFaOrSHcspohyJEDbnOwnJO?=
 =?us-ascii?Q?WP84PV8EvC+YokCglEq6wcSJHofCWVdXUXRVE7SKIWbvdHIDtGg8w6GsbmyG?=
 =?us-ascii?Q?hWoJMOmmtyQFkatUIQXv+3unj8tPra2XBXoZRufsJFSEs2295r6lyy93wo0M?=
 =?us-ascii?Q?ErVbrKUqHOlmDQAQPQnIcJxn73I3avz+CCOFwdwiNoobxpX/4BrXV9pJi/nl?=
 =?us-ascii?Q?hL+DNMUkhWN3vDFq/DeNnZhzS0ibK4XjUXNPLz8qvWsfKp/ZUOWXndXF+Uma?=
 =?us-ascii?Q?ca7QiJHjb05qZs0opJxg2mtBkzG5bm2Qb3SaRdLcX7iIFsWyRNF+FB7qt7jR?=
 =?us-ascii?Q?BJWduD3heSOY/go1iGKcE+nqGPIhZaiBtSEnYSYMrXihv4S+Dfoqx8M4jWt9?=
 =?us-ascii?Q?uzexghv4gXF9yLUH/9sCwTKf5ydzKtB6Q5B/7VxLmPB9IGC3wUZMmXi8Pez/?=
 =?us-ascii?Q?YQFu4zy55R4K+2FmwNBMhTKZ60UHnGqRAllZbSEwQ7YmthqZtqTlDsxA9koe?=
 =?us-ascii?Q?CxDeuIW3ao65i2iJ0n7z5jUpIgUiWvX+NC+DA6pzUXdc1hzI2GgoL+deUuvC?=
 =?us-ascii?Q?pvmWZICUyjFQfZPlz1bv75OFLXNeosKkQvxy89gYbufJHhen4VlwiO0jwIdr?=
 =?us-ascii?Q?PokF9wdkd/GHrAjAbr4yPx+mR/stAxbH+KMDhlytawlZm8Ff3kzYZnSMwjgm?=
 =?us-ascii?Q?qG6mJBmyDtMPvd04FdHMrFtb6afvG4tXavOTPn+LNcUPN0HRXD0xDfdPYXec?=
 =?us-ascii?Q?w104orEhbvXbT9LLSWoRTKuD62/4RpkyUfpY6NVs2YSHNRyWli89P6ZgFMq8?=
 =?us-ascii?Q?LelrmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:25:56.8151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0347939a-3946-43ba-7adf-08de598fddcb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4737

The commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support
for DWC") added support for multiple PFs in the DWC driver, but the
implementation was incomplete. It did not properly support MSI/MSI-X,
as well as BAR and inbound ATU mapping for multiple PFs. The MSI/MSI-X
issue was later fixed by commit 47a062609a30 ("PCI: designware-ep:
Modify MSI and MSIX CAP way of finding") by introducing a per-PF
struct dw_pcie_ep_func.

However, even with both commits, the multiple PF support in the driver
remains broken because BAR configuration and ATU mappings are managed
globally in struct dw_pcie_ep, meaning all PFs share the same BAR-to-ATU
mapping table. This causes one PF's EPF to overwrite the address
translation of another PF's EPF in the internal ATU region,
creating conflicts when multiple physical functions attempt to
configure their BARs independently.

Fix this by moving bar_to_atu and epf_bar from struct dw_pcie_ep to
struct dw_pcie_ep_func, similar to what commit 47a062609a30
("PCI: designware-ep: Modify MSI and MSIX CAP way of finding") did for
MSI/MSI-X capability support, to allow proper multi-function endpoint
operation, where each PF can configure its BARs and corresponding
internal ATU region without interfering with other PFs.

Fixes: 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---

Link to v1:
https://lore.kernel.org/all/20260121054214.274429-3-a-garg7@ti.com/

Changes from v1 to v2:
- Fixed the suggested nits
- Rephrased the commit message with a proper Fixes tag

 .../pci/controller/dwc/pcie-designware-ep.c   | 46 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1458477a6ba9..12625a1059a4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -153,11 +153,15 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	int ret;
 	u32 free_win;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 
-	if (!ep->bar_to_atu[bar])
+	if (!ep_func)
+		return -EINVAL;
+
+	if (!ep_func->bar_to_atu[bar])
 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
 	else
-		free_win = ep->bar_to_atu[bar] - 1;
+		free_win = ep_func->bar_to_atu[bar] - 1;
 
 	if (free_win >= pci->num_ib_windows) {
 		dev_err(pci->dev, "No free inbound window\n");
@@ -175,7 +179,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	 * Always increment free_win before assignment, since value 0 is used to identify
 	 * unallocated mapping.
 	 */
-	ep->bar_to_atu[bar] = free_win + 1;
+	ep_func->bar_to_atu[bar] = free_win + 1;
 	set_bit(free_win, ep->ib_window_map);
 
 	return 0;
@@ -211,17 +215,18 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
-	u32 atu_index = ep->bar_to_atu[bar] - 1;
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+	u32 atu_index = ep_func->bar_to_atu[bar] - 1;
 
-	if (!ep->bar_to_atu[bar])
+	if (!ep_func || !ep_func->bar_to_atu[bar])
 		return;
 
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
 	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
 	clear_bit(atu_index, ep->ib_window_map);
-	ep->epf_bar[bar] = NULL;
-	ep->bar_to_atu[bar] = 0;
+	ep_func->epf_bar[bar] = NULL;
+	ep_func->bar_to_atu[bar] = 0;
 }
 
 static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie_ep *ep, u8 func_no,
@@ -348,12 +353,16 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	enum pci_barno bar = epf_bar->barno;
 	size_t size = epf_bar->size;
 	enum pci_epc_bar_type bar_type;
 	int flags = epf_bar->flags;
 	int ret, type;
 
+	if (!ep_func)
+		return -EINVAL;
+
 	/*
 	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
 	 * 1 and 2 to form a 64-bit BAR.
@@ -367,14 +376,14 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	 * calling clear_bar() would clear the BAR's PCI address assigned by the
 	 * host).
 	 */
-	if (ep->epf_bar[bar]) {
+	if (ep_func->epf_bar[bar]) {
 		/*
 		 * We can only dynamically change a BAR if the new BAR size and
 		 * BAR flags do not differ from the existing configuration.
 		 */
-		if (ep->epf_bar[bar]->barno != bar ||
-		    ep->epf_bar[bar]->size != size ||
-		    ep->epf_bar[bar]->flags != flags)
+		if (ep_func->epf_bar[bar]->barno != bar ||
+		    ep_func->epf_bar[bar]->size != size ||
+		    ep_func->epf_bar[bar]->flags != flags)
 			return -EINVAL;
 
 		/*
@@ -420,7 +429,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (ret)
 		return ret;
 
-	ep->epf_bar[bar] = epf_bar;
+	ep_func->epf_bar[bar] = epf_bar;
 
 	return 0;
 }
@@ -782,7 +791,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
 
-	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
+	msix_tbl = ep_func->epf_bar[bir]->addr + tbl_offset;
 	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
 	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
 	vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
@@ -845,11 +854,14 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
 
 static void __dw_pcie_ep_init_non_sticky_registers(struct dw_pcie_ep *ep, u8 func_no)
 {
-	unsigned int offset;
-	unsigned int nbars;
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+	unsigned int offset, nbars;
 	enum pci_barno bar;
 	u32 reg, i, val;
 
+	if (!ep_func)
+		return;
+
 	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
 
 	if (offset) {
@@ -876,8 +888,8 @@ static void __dw_pcie_ep_init_non_sticky_registers(struct dw_pcie_ep *ep, u8 fun
 			 */
 			val = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
 			bar = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, val);
-			if (ep->epf_bar[bar])
-				pci_epc_bar_size_to_rebar_cap(ep->epf_bar[bar]->size, &val);
+			if (ep_func->epf_bar[bar])
+				pci_epc_bar_size_to_rebar_cap(ep_func->epf_bar[bar]->size, &val);
 			else
 				val = BIT(4);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 31685951a080..a4d1733f5c6a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -463,6 +463,8 @@ struct dw_pcie_ep_func {
 	u8			func_no;
 	u8			msi_cap;	/* MSI capability offset */
 	u8			msix_cap;	/* MSI-X capability offset */
+	u8			bar_to_atu[PCI_STD_NUM_BARS];
+	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
 };
 
 struct dw_pcie_ep {
@@ -472,13 +474,11 @@ struct dw_pcie_ep {
 	phys_addr_t		phys_base;
 	size_t			addr_size;
 	size_t			page_size;
-	u8			bar_to_atu[PCI_STD_NUM_BARS];
 	phys_addr_t		*outbound_addr;
 	unsigned long		*ib_window_map;
 	unsigned long		*ob_window_map;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
-	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
 };
 
 struct dw_pcie_ops {
-- 
2.34.1

