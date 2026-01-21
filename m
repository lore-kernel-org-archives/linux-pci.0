Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDCE40FDB5;
	Wed, 21 Jan 2026 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974199; cv=fail; b=uDxHocNgDuhIACIBok2W8VYZgBPrS+8x7RcUfskLaWxZULEXClNpjSQlMi+g5OAM81JFRgVNcGvw0XM47Tzm7tLnW3L4irDNwBUGN7U1CRGNm17zaJ7KkXfpzFHJ7QIkQ1MZips1kWIUSxq4i0o43Bvzl6daG4cA2GnlqG1zmXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974199; c=relaxed/simple;
	bh=wggQi9EE6BOTe9uDDMPTZNAdPg1CFqJOp/KucQ44oG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltf/LC6WK0LaxvzF0eKgdFpKcQmLmWPwIDb1LnU5gYGnyWKfbTrNw8f6Hpc9UduMWgkTTxPFl0ktGsMq1mvFCCTgARoB5cXHrvkeNDuHLVmqr+JPFXhMAEFaKwKiPr9+tDp6IImB9GGOxDrFQaaFUIU+tQybBu/JMSUkJAA1TE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FHDwkAdl; arc=fail smtp.client-ip=40.93.194.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FHDwkAdl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7fBXBOoTMLND/qIxVR7horaQEOCUZ8WmDzXkZAUhufr/TnmR7KCvYi1iwmCFLCniLQOBtEPcTuupfj0aRkwScIIr1ue4+yK84nqpYXjeG3w5l/Sbj55VjndQNTkyYIIhyWqUpNyk45Gfgw2lGRRQ30XgE/nnvypi/pSUZcIaeVYZJdgmMoLYivA01oY6pLxFX7iHBLCHyZbBrDJFIH7lg9RxMtLHTjy4wBadgJViceClFPFTnOYsEl44/sx6wuwXqniqAa6i2veLsonrNCMOh+xzwPNt+xdHCiutvIrH8yDE4vSyQjd3ybpLE/SiVSafzgn77YwvxjMC2zxoagFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bBzTS7/6Tyy6+qWJ1B3Axhr06TJ949yRmACfzr3rw4=;
 b=FITUElPMC2UkS18BjNXnlptK72Gcgudh5FJXeIfIFoTCzomUjhpLgP4jPkxNai3f2mm5PrhHIpLXwiN2RecQ11Ik6J8ZMHAFVHeG3mEvbw2AtOmiM5SJyKDw+dlRNQy5M1yNgUDaSL/Ej2gT9OTy+22JNmI4S5YC5erTOKexUs10j0JqBmH8rTneJxCEM1uLU4gcQF8Yjm5nEsnuJu3jxpO2l4jyGeGDNDZOupywcJIA36mzCKOSMLKXBhZYmDfVryrM2auTyx5RFPcg8Lcjmk3AUCYalllV82gY+4jnp83UjbAu6xWYGVmfRdQQ3H2Om93B8sw2OQLEJ2eKPhiWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bBzTS7/6Tyy6+qWJ1B3Axhr06TJ949yRmACfzr3rw4=;
 b=FHDwkAdlNkE4UJulrM58RCrN+RbNZtJTAEv5oNPunD4WvwiEM7dVRYvD17TPB/gDLbN5oe4Bwd8kJpRg3R8zCxOiutH2facg+PE8ewVnDQL6iqEfSMPX2hssXPySpaDINGs850XOIH0cxRgUQN6BXnvkPWj5BnqCBCgoOPpLmgU=
Received: from SA0PR11CA0050.namprd11.prod.outlook.com (2603:10b6:806:d0::25)
 by SA6PR10MB8134.namprd10.prod.outlook.com (2603:10b6:806:443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 05:43:03 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::b3) by SA0PR11CA0050.outlook.office365.com
 (2603:10b6:806:d0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 05:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 05:43:01 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:43:00 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:43:00 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 23:43:00 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60L5gmFR2466752;
	Tue, 20 Jan 2026 23:42:56 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH 2/2] PCI: dwc: ep: Add per-PF BAR and iATU mapping support
Date: Wed, 21 Jan 2026 11:12:14 +0530
Message-ID: <20260121054214.274429-3-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SA6PR10MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f4c6f73-994e-42d6-b3ae-08de58aff111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aRoVC5X5sXK0Nu1xtNS0+wBjQg+FrghZsBb1p5B5kvnX41MkVRExF41y0Abe?=
 =?us-ascii?Q?O8JjFs/8qa3qbEbIUsvPpM5gIp8Y2A6Enuc9Rt4ZaUyxyNZPs9p7V0YN1JM6?=
 =?us-ascii?Q?DSaOw4sCx3OMnMJuY8FLu70IOwR82fbW1WPH9LWF/OX9wmpy8FxgYKZBgusH?=
 =?us-ascii?Q?LM0fRJZbXdO7FRQcGE3wkpAzbGqpcePyCZs6BobXJ0lD7/xH5RoEcwuSxe9d?=
 =?us-ascii?Q?q3gnpAM49S8PaRv3EWbKWiHXBs8UXwFN9zrhEWiPAmAeSSEMTxFm/epGkxph?=
 =?us-ascii?Q?dvXj6QbDXKYsbG19x/DAn/myWobE/yNIdYqQ4SjuiGzPizs5EeYVGRDc6UmF?=
 =?us-ascii?Q?WCdfFU13uOIVFM2gdvIvHnigZBwvlThQJEk19JYzDBqsLxf5YLWMjla9zaLy?=
 =?us-ascii?Q?AfQA0x0ABL6YL835a+sYUQw4TNfJWKKDTR3C4mWNQweaP5tAfcyTOlWIwkOx?=
 =?us-ascii?Q?WFj8Z2pYmXgOGNxHFQRSHx584Q+rCvLygeW0Unj5IqaqHeVx0jW6ngavYaw2?=
 =?us-ascii?Q?kp6h4MrByvkTb5h9yMRvubSDnYJVwXCGzUJsmPjhnJyF0r6J+ml1+H9TUao9?=
 =?us-ascii?Q?IxXrgtPB2dq1LOqjl+IaKtflYPGrgSE95pIhSZ/JMdGadKP1dEXr7459Y841?=
 =?us-ascii?Q?Om9DO7ZVv4jX3CQuvI8aSvDQlZVB1HqYRlfIHzrgZogyQWFmiXnhjvs91XdN?=
 =?us-ascii?Q?KZ4aKs52QXyga63/F3/dDXhSSX86Xjax/pNlO1SfbVz+BmKnAJLTrCVaVrZt?=
 =?us-ascii?Q?FtK+3xujC9W1thMTTiqNRfiy/SKx40pELm98q18N/jasQMbCdqbfbA+iALID?=
 =?us-ascii?Q?RqSQnvqIMVprHOdF9QzRCUPOCXZ4jziXx13Z8TkTBmli7lOgHyZOvCdpUlMV?=
 =?us-ascii?Q?Zs1PgmNtKdCjLs4nG0+ab3dscd7+ZQpKMI2BtxwegliRzJe8cD//ZMIGuJSF?=
 =?us-ascii?Q?kLZfCgtEoM6vqZhndPbx0ynaYfSGZTXjKqp2YP4TJjz3YoMJX8OyR/ay7Ap4?=
 =?us-ascii?Q?8P/uvWh9lTGB18gO+jcsSGtM+6D74GlFAPvN8gAR94FZuieosfm/fEbI2N7o?=
 =?us-ascii?Q?hJBXtP2kCDCfmguY9H+8tmuIfypJH6P8xYOzoD1421mcV38TnK2JacEc0e/w?=
 =?us-ascii?Q?7W7MW3C+lLCsHpiXXVZkTFRDlwW0M8Y9IXvYaySLyJ6BxIzLnSILDCoP/FKT?=
 =?us-ascii?Q?rtG6Exsve+t13cvkp6JXwf9zb/5+SonBkGxSAkGGmoIzPxaRPNN2bk6aPZMz?=
 =?us-ascii?Q?WqYuqCtghIjeNgccYGFXkgj/vvKVGX1tw+erQ00rmN9F04OA82fXWOQP+i3A?=
 =?us-ascii?Q?+XBfDblhlInVswodyU/Gj3yA0WlAElM6UJefyw+EN29Grkg8Y6WGK23N6el8?=
 =?us-ascii?Q?zqjC11g7GH+htKkfsCbVemDoKPQeJYkeDo9rzpb76kRvt53obCmUIiRQKmy3?=
 =?us-ascii?Q?+XqI72M2TsJ3iFxZsLWycmzj3tHhDEG4s1i5O2bBKMB3A39LoVtP2IUtmP1b?=
 =?us-ascii?Q?qQv1lC8V/IbjZ8wVnHeBAumarczcPhmQy1vXSEwR5meGSzJ7v6v6kklg3km1?=
 =?us-ascii?Q?BjlesxN2GlRqgxgnX9n7HqlSiO8xnCNbbzgXpoQxFjJeVF7QnxlMFmF/qWO8?=
 =?us-ascii?Q?CDIP9pVoMbOSn9Q3C2Dgz76V6YAH5yJseczrQDsqH2qxphh73YiC13qeorta?=
 =?us-ascii?Q?ndkoqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 05:43:01.9503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4c6f73-994e-42d6-b3ae-08de58aff111
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8134

The commit 47a062609a30 ("PCI: designware-ep: Modify MSI and MSIX CAP
way of finding") adds support for each physical function to have its
own MSI and MSI-X capability structures by introducing struct
dw_pcie_ep_func. However, BAR configuration and iATU mappings are still
being managed globally in struct dw_pcie_ep, meaning all PFs shared the
same BAR-to-iATU mapping table.

This creates conflicts when multiple physical functions attempts to
configure BARs independently, as they would overwrite each other's
iATU mappings and BAR configurations.

Move bar_to_atu and epf_bar from struct dw_pcie_ep to struct
dw_pcie_ep_func to allow proper multi-function endpoint operation,
where each function can configure its BARs without interfering with
other functions.

Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 50 +++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f222677a7a87..769602b58bd7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -153,11 +153,16 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	int ret;
 	u32 free_win;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *ep_func;
 
-	if (!ep->bar_to_atu[bar])
+	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
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
@@ -175,7 +180,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	 * Always increment free_win before assignment, since value 0 is used to identify
 	 * unallocated mapping.
 	 */
-	ep->bar_to_atu[bar] = free_win + 1;
+	ep_func->bar_to_atu[bar] = free_win + 1;
 	set_bit(free_win, ep->ib_window_map);
 
 	return 0;
@@ -211,17 +216,22 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
-	u32 atu_index = ep->bar_to_atu[bar] - 1;
+	struct dw_pcie_ep_func *ep_func;
+	u32 atu_index;
+
+	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 
-	if (!ep->bar_to_atu[bar])
+	if (!ep_func || !ep_func->bar_to_atu[bar])
 		return;
 
+	atu_index = ep_func->bar_to_atu[bar] - 1;
+
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
 	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
 	clear_bit(atu_index, ep->ib_window_map);
-	ep->epf_bar[bar] = NULL;
-	ep->bar_to_atu[bar] = 0;
+	ep_func->epf_bar[bar] = NULL;
+	ep_func->bar_to_atu[bar] = 0;
 }
 
 static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie_ep *ep, u8 func_no,
@@ -349,11 +359,16 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
+	struct dw_pcie_ep_func *ep_func;
 	size_t size = epf_bar->size;
 	enum pci_epc_bar_type bar_type;
 	int flags = epf_bar->flags;
 	int ret, type;
 
+	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+	if (!ep_func)
+		return -EINVAL;
+
 	/*
 	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
 	 * 1 and 2 to form a 64-bit BAR.
@@ -367,14 +382,14 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
@@ -420,7 +435,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (ret)
 		return ret;
 
-	ep->epf_bar[bar] = epf_bar;
+	ep_func->epf_bar[bar] = epf_bar;
 
 	return 0;
 }
@@ -782,7 +797,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
 
-	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
+	msix_tbl = ep_func->epf_bar[bir]->addr + tbl_offset;
 	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
 	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
 	vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
@@ -845,11 +860,16 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
 
 static void __dw_pcie_ep_init_non_sticky_registers(struct dw_pcie_ep *ep, u8 func_no)
 {
+	struct dw_pcie_ep_func *ep_func;
 	unsigned int offset;
 	unsigned int nbars;
 	enum pci_barno bar;
 	u32 reg, i, val;
 
+	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+	if (!ep_func)
+		return;
+
 	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
 
 	if (offset) {
@@ -876,8 +896,8 @@ static void __dw_pcie_ep_init_non_sticky_registers(struct dw_pcie_ep *ep, u8 fun
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

