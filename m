Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC66374741;
	Thu, 29 Jan 2026 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678324; cv=fail; b=CPaxGaVEUUsEdKaqYWti6OSf/ULEvL7yZeBgFWJmK0w4c2A1h0tQvjG2Dx3bq7Tje2QepaglbK02vgGH4fDYmJEP1zvf/9Spg2jOsgtNDARYYlQeLrIkJwGaEsuZER2pbZE544TVqx/VXVrQFMiUcDsWcPp3+y09JSil3fi/Jd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678324; c=relaxed/simple;
	bh=CjciJRxQhWU5evQphuQgXs5ulMcAyKQX8jnzZlflHpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwQpRzvo9S/PxySd8tGRMjNIgDtb9b+zgXCT9lZOgpRkgR8Tpqay6m2gz+C8quFiZTKq5Ki8tCF0UKA5vJcKdz5mMLZ49mEyRUytN8aRl5+O4tE3D4wIuaDSQ5kCgUo8GO2ekTsZo0t3tgfZslU2g2H5q0tQfTrONhn0MyVb4jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W0Bkls/g; arc=fail smtp.client-ip=52.101.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W0Bkls/g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXweKkLwdsJUjlRU15SCq2rhqn+H6q22YmfciG54CPF72bTkyAqc2b03aNJTJkxieeMiXtgWYUEo7cgg5BI1s0SGsWVIFthyoigCNWntiwFPas1DN45rz8hq71NI33cMMdHaWNZCiu4xxTmxs1wNvf7KaXqAIDmrOA4Ys5J/8GvYS5moSi/OycU21FxwfVzPwWPTIa9V/K6Pl4XO1RRCsYiqovRqm1sZhS/hevXh64c2dF/1yhqdN33lw/b5n6qWEpODVFJpUDV9HW+W+CKtT2EvD7ds0zc2BL7H/uKUZZOpGsUv7XYV4O2Zoz8kbmKkVuko6sKHpFHyI5S7fNV0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/Kv11OaHn2HLEoF9IrQ6GehIoOi7bK6PvH+OYvl5ig=;
 b=zU6+MCeCS8dqdq25E1quEycdnWpC8xwjtK6uq9mIi9b3o4bbMEnqCKARn5MPzYdLVOFWSjLWpRivysGi/6Ed64zMgJF8cgxSLAjKI/c7JU3m8/A1qEfbJQeCT+xwE8KE0/h00mi8affRmR9O0fQ4r0SZp5fsVSQiv0gOe10z31NJvEhr66Ua8bYfmy/WiyDabsEEd2z6tqR2cEsvYwUnX9Gd8ybELR/TEE3AH/Pp1c9l77UBCwAhoAJmPj+aJR36hbiTwyUecD+yo2xOWtKH6zsa3EGwXt+tNBWiGXV6L+CVDPJwLhCh+8ccnkid0GpYt8+0GfOcBpXBl6/myhVyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Kv11OaHn2HLEoF9IrQ6GehIoOi7bK6PvH+OYvl5ig=;
 b=W0Bkls/gjvFU3xuAQsVzcEi7EMzA0Mwf0hjs6npd2qC+sCg9FH0lDZyvwrYdEfZ4QxVs2VUBLf8gboDSnKGIHtIDJszJar1C5j+jtlqb+Kbl2jcek33pTWrfU5hUCc1ZsjUDP/CpdG7YPnM8ZOThHnXLnbHx9rkBhAJrJ7fKmkk=
Received: from MW4PR03CA0319.namprd03.prod.outlook.com (2603:10b6:303:dd::24)
 by DS7PR10MB7280.namprd10.prod.outlook.com (2603:10b6:8:e2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.8; Thu, 29 Jan 2026 09:18:39 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::af) by MW4PR03CA0319.outlook.office365.com
 (2603:10b6:303:dd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Thu,
 29 Jan 2026 09:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 09:18:38 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 03:18:08 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 03:18:08 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 03:18:08 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60T9Htkp3499594;
	Thu, 29 Jan 2026 03:18:04 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v4 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU mapping support
Date: Thu, 29 Jan 2026 14:47:52 +0530
Message-ID: <20260129091753.490167-3-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129091753.490167-1-a-garg7@ti.com>
References: <20260129091753.490167-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DS7PR10MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 096b33cb-4cf3-4253-db20-08de5f1762ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ZS0ha5bpJYzT5qYPqwP6NZoyuz76VkZmWYNq/pqK5fW2PgZF4FRYYcPe6LW?=
 =?us-ascii?Q?p6bdLSJARphWo6865M1RFDSF+azTlhCXkllcMSZA3YvieAxE7+n4rYI8iCyk?=
 =?us-ascii?Q?432jLlJLx0gsHbx3ehIp8bhz7Umyo97ltRwW9njiqNHMM7/V1VzXbDiiOTPZ?=
 =?us-ascii?Q?OuTNZP506+6G+3o1I4SYvaf1CZLZJ35qcZQVFSs2aG0BUzWpx/OqFU+8QL3j?=
 =?us-ascii?Q?o9TkNLh0NjGkQcCmiuQ+lAbeSeJS2UWJVwtTy94n4siWvdFMJ7Pi/6Vlzfsa?=
 =?us-ascii?Q?gFOQ/cdVYrBDopqOrP3OHWcbTru8juebfzeF6nYDNxLKYYyDKJ7TYmlIRxcd?=
 =?us-ascii?Q?xHDa/A5TRaU9u4pu9HIKQwMRaWITTcxMaHv/by+6BAKb4xHAJA+PS3prrtep?=
 =?us-ascii?Q?hlACZsik8QlNVcX6hkWZiH/iQDhSsPGwrI7SNywC/PjTnxjXvN10fXxh2ZEV?=
 =?us-ascii?Q?YdFs3lvmS7cUvPKLib0aHLMmZxBr9oPyENt0ihC+VHR0N79UCTBNMpTkl8E0?=
 =?us-ascii?Q?LgQXfl6h+pjWNYvjZ4/CflzAyAnAeWeCAbFDwcer3KEwYuNNxNNpa3KBj1q7?=
 =?us-ascii?Q?U5hHTMRtG4sZ7MvZ3DpCpbYJbkFhHNJlRkJupsLPTMCf0khV6XdZdA1AglvM?=
 =?us-ascii?Q?OOfgZuTSNgGRGlvw6CC+deRDetWQsGkkCn35NJGlHWxC7yPArWOZfD4fuNN7?=
 =?us-ascii?Q?7ppnkSmJRZP23Fw6JGf9ZJ55Y1OK9PQ6ZsDiAu1mdbvX4WkU8JlzstVv+hC5?=
 =?us-ascii?Q?HvK6BylnbuCgdks1oT5Wfzy6aetj6v7tELivkVBxJyITfZWKS/0kprTYERuh?=
 =?us-ascii?Q?QRcodjW9ag8kJnhs0A8jg4RTNAHMg1oklt05jXszMkSUh1wZbx9g0Rmf9nvX?=
 =?us-ascii?Q?SorcIJL16PmXlR21WgE+epk4/YNV5WARxbZJlM+sJ3IOKhGrjL9EzLkbzcyz?=
 =?us-ascii?Q?fWqEi2jONBZprW3k3NBVlxaPOSuGSjMeMHPlpn8uefVD6WrH4/P3fxsfXphd?=
 =?us-ascii?Q?sJO3sooKH5nRdJ5R1Uf4TN1Zk/LIk4Ydu/zcs4qvdRehelgmEodHbtCszvC3?=
 =?us-ascii?Q?Ej1LlbO/ebaZ2qYL5QaIrE0/N4Nr42t2gBYTWpkx6MSjZWXkybH63v8ouWiv?=
 =?us-ascii?Q?jeuGOFG2qD24Aau3cY1+b0UUN4V3kmSP0TGrUHLMPQXIMvbO1nLNOg9VpiHv?=
 =?us-ascii?Q?Btr1x6j+C3IOR5RnAGFPWFMm/1znmDp6h5TuObLBmEGbNbA3b0tU39rJkH3V?=
 =?us-ascii?Q?OZWDgZZdWlZ5b9ASLzELKzzAaOjwjYYXDEk04VOR9FFJwCnRNFHLw/uqTnES?=
 =?us-ascii?Q?uk6DW9VqyXB8haRZSGh7lpdoIZya8vRt3tmd9yFrzAh3Nu1Yoy6/HpzJGlW/?=
 =?us-ascii?Q?AqKrJDxUyY2s/x+WRaWRYEJ7tsjFVLt8Zfz0PGOuGE1woUSBpY3XsyGHnMTR?=
 =?us-ascii?Q?TqzSWvayK1/E0uINtM1TBKRMgclPCORC3QrGqIVlPtyJxfcurK7jJa6fKbJ4?=
 =?us-ascii?Q?nKFsRe3oZbH2O8pNP3gUI4rKV5UpCIJu1FGjw5Xc3woNxyGi/4Jj9ADV2AQy?=
 =?us-ascii?Q?5Zg6hpeXtEfzvQ7f154NjC45e2qwp1dtTMfm1rd/8ZxRWmAic8c7mo8BD0CQ?=
 =?us-ascii?Q?wBuJbQG7aEx2AFatxyafHeyQAAXuM96QdHCJvDqNUxr31crHC40Uuio2s5lD?=
 =?us-ascii?Q?gAZ3ppz6Wc7RqqJQ5jxqoxNyA4s=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:18:38.0473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096b33cb-4cf3-4253-db20-08de5f1762ec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7280

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

The commit cfbc98dbf44d ("PCI: dwc: ep: Support BAR subrange inbound
mapping via Address Match Mode iATU") later introduced Address Match
Mode support, which suffers from the same multi-PF conflict issue.

Fix this by moving the required members from struct dw_pcie_ep to
struct dw_pcie_ep_func, similar to what commit 47a062609a30
("PCI: designware-ep: Modify MSI and MSIX CAP way of finding") did for
MSI/MSI-X capability support, to allow proper multi-function endpoint
operation, where each PF can configure its BARs and corresponding
internal ATU region without interfering with other PFs.

Fixes: 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
Fixes: cfbc98dbf44d ("PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match Mode iATU")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---

Changes from v3 to v4:
- Fix the similar conflict created by the commit cfbc98dbf44d

Changes from v2 to v3:
- None

Changes from v1 to v2:
- Fixed the suggested nits
- Rephrased the commit message with a proper Fixes tag

v3: https://lore.kernel.org/all/20260127085010.446116-3-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260122082538.309122-3-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260121054214.274429-3-a-garg7@ti.com/

 .../pci/controller/dwc/pcie-designware-ep.c   | 76 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  | 12 +--
 2 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1b3dd07e6004..b9a234b47aab 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -115,11 +115,15 @@ static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
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
@@ -137,14 +141,15 @@ static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
 	 * Always increment free_win before assignment, since value 0 is used to identify
 	 * unallocated mapping.
 	 */
-	ep->bar_to_atu[bar] = free_win + 1;
+	ep_func->bar_to_atu[bar] = free_win + 1;
 	set_bit(free_win, ep->ib_window_map);
 
 	return 0;
 }
 
-static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
+static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci_barno bar)
 {
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = pci->dev;
 	unsigned int i, num;
@@ -152,18 +157,18 @@ static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
 	u32 *indexes;
 
 	/* Tear down the BAR Match Mode mapping, if any. */
-	if (ep->bar_to_atu[bar]) {
-		atu_index = ep->bar_to_atu[bar] - 1;
+	if (ep_func->bar_to_atu[bar]) {
+		atu_index = ep_func->bar_to_atu[bar] - 1;
 		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
 		clear_bit(atu_index, ep->ib_window_map);
-		ep->bar_to_atu[bar] = 0;
+		ep_func->bar_to_atu[bar] = 0;
 	}
 
 	/* Tear down all Address Match Mode mappings, if any. */
-	indexes = ep->ib_atu_indexes[bar];
-	num = ep->num_ib_atu_indexes[bar];
-	ep->ib_atu_indexes[bar] = NULL;
-	ep->num_ib_atu_indexes[bar] = 0;
+	indexes = ep_func->ib_atu_indexes[bar];
+	num = ep_func->num_ib_atu_indexes[bar];
+	ep_func->ib_atu_indexes[bar] = NULL;
+	ep_func->num_ib_atu_indexes[bar] = 0;
 	if (!indexes)
 		return;
 	for (i = 0; i < num; i++) {
@@ -248,6 +253,7 @@ static int dw_pcie_ep_validate_submap(struct dw_pcie_ep *ep,
 static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
 				  const struct pci_epf_bar *epf_bar)
 {
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	const struct pci_epf_bar_submap *submap = epf_bar->submap;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
@@ -258,7 +264,7 @@ static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
 	unsigned int i;
 	u32 *indexes;
 
-	if (!epf_bar->num_submap || !submap || !epf_bar->size)
+	if (!ep_func || !epf_bar->num_submap || !submap || !epf_bar->size)
 		return -EINVAL;
 
 	ret = dw_pcie_ep_validate_submap(ep, submap, epf_bar->num_submap,
@@ -279,8 +285,8 @@ static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
 	if (!indexes)
 		return -ENOMEM;
 
-	ep->ib_atu_indexes[bar] = indexes;
-	ep->num_ib_atu_indexes[bar] = 0;
+	ep_func->ib_atu_indexes[bar] = indexes;
+	ep_func->num_ib_atu_indexes[bar] = 0;
 
 	for (i = 0; i < epf_bar->num_submap; i++) {
 		size = submap[i].size;
@@ -308,11 +314,11 @@ static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
 
 		set_bit(free_win, ep->ib_window_map);
 		indexes[i] = free_win;
-		ep->num_ib_atu_indexes[bar] = i + 1;
+		ep_func->num_ib_atu_indexes[bar] = i + 1;
 	}
 	return 0;
 err:
-	dw_pcie_ep_clear_ib_maps(ep, bar);
+	dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
 	return ret;
 }
 
@@ -346,15 +352,16 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 
-	if (!ep->epf_bar[bar])
+	if (!ep_func || !ep_func->epf_bar[bar])
 		return;
 
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
-	dw_pcie_ep_clear_ib_maps(ep, bar);
+	dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
 
-	ep->epf_bar[bar] = NULL;
+	ep_func->epf_bar[bar] = NULL;
 }
 
 static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie_ep *ep, u8 func_no,
@@ -481,12 +488,16 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
@@ -500,22 +511,22 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
 		 * When dynamically changing a BAR, tear down any existing
 		 * mappings before re-programming.
 		 */
-		if (ep->epf_bar[bar]->num_submap || epf_bar->num_submap)
-			dw_pcie_ep_clear_ib_maps(ep, bar);
+		if (ep_func->epf_bar[bar]->num_submap || epf_bar->num_submap)
+			dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
 
 		/*
 		 * When dynamically changing a BAR, skip writing the BAR reg, as
@@ -573,7 +584,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (ret)
 		return ret;
 
-	ep->epf_bar[bar] = epf_bar;
+	ep_func->epf_bar[bar] = epf_bar;
 
 	return 0;
 }
@@ -968,7 +979,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
 
-	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
+	msix_tbl = ep_func->epf_bar[bir]->addr + tbl_offset;
 	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
 	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
 	vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
@@ -1031,11 +1042,14 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
 
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
@@ -1062,8 +1076,8 @@ static void dw_pcie_ep_init_rebar_registers(struct dw_pcie_ep *ep, u8 func_no)
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
index 8f170122ad78..43d7606bc987 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -471,6 +471,12 @@ struct dw_pcie_ep_func {
 	u8			func_no;
 	u8			msi_cap;	/* MSI capability offset */
 	u8			msix_cap;	/* MSI-X capability offset */
+	u8			bar_to_atu[PCI_STD_NUM_BARS];
+	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
+
+	/* Only for Address Match Mode inbound iATU */
+	u32			*ib_atu_indexes[PCI_STD_NUM_BARS];
+	unsigned int		num_ib_atu_indexes[PCI_STD_NUM_BARS];
 };
 
 struct dw_pcie_ep {
@@ -480,17 +486,11 @@ struct dw_pcie_ep {
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
-
-	/* Only for Address Match Mode inbound iATU */
-	u32			*ib_atu_indexes[PCI_STD_NUM_BARS];
-	unsigned int		num_ib_atu_indexes[PCI_STD_NUM_BARS];
 
 	/* MSI outbound iATU state */
 	bool			msi_iatu_mapped;
-- 
2.34.1

