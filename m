Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED5149C6F;
	Tue, 27 Jan 2026 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503867; cv=fail; b=hZlNfLX4kaYlowmVpmXYNSXvQXw3pxuIxIJIDh2NNYof2pIFPBLb4fdMb7Rjgt74uDrhA3nxQKMPCYZnVKQfMevZ/PSECFT3I/Rdgb3YXZHxrW3VCT5XcYy/k9Cd6+GlKJDH2Lm5glKkGR3P12biDpwFNNmMBrnfrx/FLAxo1Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503867; c=relaxed/simple;
	bh=reKsKUFRB2d1GObq2e/ty+SlMcR24bCrlDxc/8xVpPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVcciDbK42hBoZb/B46qHNzF60ijYSRtbBfH9VwEmDFvx1MYGBBAy6r0P3jCVJ4j5DGxg4NgcJa5Dc7MIvVqNy6wPP6fGf/KGV6A82xDxWEj8RibDnTj+I7FdO0Ofxg1yfkc+0GuWuIwQiUiWq+BNSt0ql3qs0BaKLCI+KoGp0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=haOwNCKf; arc=fail smtp.client-ip=40.93.198.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="haOwNCKf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0LNKzDM3qYwzOTaj5zLCd6jTxTQBSQTXwWXYXENdb0u/QH1u7DVmmtCArpcrTtS48ldDjDs5ltjm2f1cAmFxNPfFn/CV+l+5k4FkiaiGMZhYXZoSY6VY81xGjzi8tkNOoh7PE6pfM3HNSxlyKeA6JVm8NbzYl99FqILDbhO4On6avuMl5WjHpmYXUxFNkThdebVlYuvqf5kNKNaDL1+6o+/YQOiZqDD6zjr/q0cOpn3nZPMVqFTK2z+qduHs6FijbBbUhud5+UMiIT2aim08tGoTRskyqOipMLU6k14u3kkyNg3aX11TDfyqZCRjaasx6vVAXU7KvZ52FurXKUgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDj+OFkOUJWwBJSdeRSBvamqqgkd3gz5rWH7zUC4Iwc=;
 b=tynjJbJlSLB0Ki/7HgDR5d7tjIKWKaA2ELRJD0BKDEtONouEabQN9emfPl5Brpq0NedSfSnU+aBOT6VYcGapW5w6gFjpGZVdiwi2kTopl3EGrAS106QYm5qeG/OlA/+qe1y4Ip9bVGwChTddywEE3ZRLnUhD8p03XQb6XWoRAOqkaTzcfMKckqZyanfv+YpcZbxD8geqRVPvnkrrhsZpIBDbW78fpE1Aou7Nxx44YiZdHUPFpSXjFiSCgRyj1esabyWLQNkj7abLwmrFHXwwQOfhx+Sd1JhG8lTLr99y9b75nxMtNdznPTVFXq4XAbMd69P9JmlGu6zSBlYw0elqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDj+OFkOUJWwBJSdeRSBvamqqgkd3gz5rWH7zUC4Iwc=;
 b=haOwNCKfXFt9xU+I+JeL7vZ2uv0Zxgl/otzWK86jEsCVMJcU5OK6vNTAcSgwYwTdpR9VON3Z4/0srgcxPaxs6aF15rUrSyst0vZX0FQIJ2G7TVTEdkr49nZsfv0v5veP8N2KnRc0Pqakmp9pkAwdiOBdK1ZCCAeOQcUx++A07/s=
Received: from CH0PR07CA0027.namprd07.prod.outlook.com (2603:10b6:610:32::32)
 by SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:51:02 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::92) by CH0PR07CA0027.outlook.office365.com
 (2603:10b6:610:32::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 08:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:51:01 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:51:01 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:51:00 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:51:00 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8ol4e4071462;
	Tue, 27 Jan 2026 02:50:56 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<xiaowei.bao@nxp.com>, <gustavo.pimentel@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v3 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU mapping support
Date: Tue, 27 Jan 2026 14:20:09 +0530
Message-ID: <20260127085010.446116-3-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SJ0PR10MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbfa8a9-e5a2-4075-e049-08de5d8132ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tPnZDPxI0XE9ynQ65Jhoatleyv0QCISsOm7jnebdIowH7n2TYbDbcqoWPWWs?=
 =?us-ascii?Q?2RCFsiEW7UTPkit0ChHErlVo3yO83clVisrhswpp+KgSaPKZefLnLvA+2rHr?=
 =?us-ascii?Q?GmGnY4ouENUmosjaSO8o8k9fRZVOdbEvNTx+cItQIRs3PfNV2Fbc5neKgit0?=
 =?us-ascii?Q?kjtrxZ0YQxYMQie4Zxx1fuck+4Cy5PI32pHDkOr0LwiGXy/rRO37JRHFdy6Y?=
 =?us-ascii?Q?El+Gmd1QI00kpm1lhhl/nKxGS5jekEgsi5ZJyAQrbN6JO9I+VffIQxf1RoP1?=
 =?us-ascii?Q?kOwwXIOJ4eofMobomzhAvZDIBZRAeIPxe2r/+TU1STY/5hHkh9/gwdprOFnE?=
 =?us-ascii?Q?s90y3z6wiC5YUyrkkV+dhkC6Gd6aG+QCppp08FJyqd/1ghSaQYpKkPARR0M+?=
 =?us-ascii?Q?b3NsaEWLs+0i5zN7RxNaSUEAqK6Q21ihNyjNwNBBjCNy4GrbcDpEvjTykMoN?=
 =?us-ascii?Q?lIngG22V8b+zod3jE2jaUDQxxkTUUp4JibYHRmKFAQ728z4bX9/AqMOBpGGq?=
 =?us-ascii?Q?yw+6fNt7/O2I6Etn3O0Eh/zcFquSZFs/Unbi9/U0hQklHhUGfIEyLSxT3tu1?=
 =?us-ascii?Q?TAYb5dzJ0PwS+keFo+sGhU63i3+9Hkb3zh25ztB4MFus4dwWKsZxO2Y+fjID?=
 =?us-ascii?Q?BRcZc3hahsoaC/iQ/bQUlkPLXF2CND54bQZjtbN5270z5I7QizXDH5iEO8NI?=
 =?us-ascii?Q?rI7VE3hRDygq7c6cOps9ZyLiTa6Gsag8ZHzN/fJvPLPXVbH6VKcmwwjDmtBi?=
 =?us-ascii?Q?hBDcGZ1cCcyFh/RHjRQS/Ab3G4T3+GVZg0M6zfK7qGiJ3QM0LeiOu58PCOau?=
 =?us-ascii?Q?GYglFrplGX9E25ZftVdCBZBItz9Bkzr/kvo8bpc8sLo6YjXbNgbUYEuwRMGZ?=
 =?us-ascii?Q?qHvRhZIKWhIrGDW+wq1YT+eXbGiDLFw3fWnQ0QUlwyqzG5faBbhEP0f1xEGY?=
 =?us-ascii?Q?EwMIYARILIUa6bD6/rsodaI6XgKkxAnXvtVWD2i88OZLjhC2691+8Jiho6qW?=
 =?us-ascii?Q?ErKi32VB9LU7Ms1cXSfor1PlzRiANdjC36N8rz5iIHRvpnISt2OKjeKbuUdN?=
 =?us-ascii?Q?2s35NAe8P8h4RURSawsoIaiME1TNDXJX/ihlnQqonH3H2T7NRHnPldVtMTiV?=
 =?us-ascii?Q?GpgMSiXV6BclWQhgHojn654xfNF9gC/cYr0OhvuXQuNr8JMz28mEHf9RE/W3?=
 =?us-ascii?Q?rE2eXSMCcluw8st1aJ5ZzAvr1BaYF26IkmQvs5jpzkZytPw9vv9Jx46HK/ia?=
 =?us-ascii?Q?Kg9o761hNiUmjcDGg6eTpdEloMj+29L5d7bpA/xrAQrqX9Dfa33Aljh4zZ7m?=
 =?us-ascii?Q?3Cr0wbXuRuetVX3bf0glpP1dPTXbJeqoflePmgLFSWBu2i/ERowUsSH/VKTL?=
 =?us-ascii?Q?gNuUvPilfooF4USdv8f10bAQGEB69o5tSi5H17wW1danshgc4AjCz+RpItD8?=
 =?us-ascii?Q?EftjzIkqXflHoMpaEB9i9fHJ5nQHoTaaCxXDabZYPGfKsZH2kknggBASVrhb?=
 =?us-ascii?Q?v5eEKRbTuQcDqueSaUiRiXpEyRcATbUAqVFfY4ySjmmkdnePq6GYXr4l8flJ?=
 =?us-ascii?Q?x/dcvur75wC/LcR7olSmzT/Uz1yPWOKRtlcZ3dp6UTOABvNhUVtMvrqAuJ5w?=
 =?us-ascii?Q?Vva/nsx+8uKpH65O2lu50Csdi9ypWjwgOenu464Zadjn5KB8RseUEm7lo34o?=
 =?us-ascii?Q?KMAHPOlazAW1s1i4U66oyxKT+zA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:51:01.5420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbfa8a9-e5a2-4075-e049-08de5d8132ba
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5694

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

Changes from v2 to v3:
- None

Changes from v1 to v2:
- Fixed the suggested nits
- Rephrased the commit message with a proper Fixes tag

v2: https://lore.kernel.org/all/20260122082538.309122-3-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260121054214.274429-3-a-garg7@ti.com/

 .../pci/controller/dwc/pcie-designware-ep.c   | 46 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 659a56aa8664..095362143363 100644
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
 
 static void dw_pcie_ep_init_rebar_registers(struct dw_pcie_ep *ep, u8 func_no)
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
@@ -876,8 +888,8 @@ static void dw_pcie_ep_init_rebar_registers(struct dw_pcie_ep *ep, u8 func_no)
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

