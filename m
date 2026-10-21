Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563592;
	b=OPZT4FDD8sxOFHiOwp9JRaijM3H7dZ6eSpG32EbWi9HjQfUVQtqMGy5fqbvRlv64NOnk
	 KULElnKT6x+uYbmw/3XyLPJ9EMKM9UqmJ1EIdlam5zVEBIPzG2vkCSFmqHVDS1S/a+A/0
	 mr1GEas8hb8k+u9CGvbyiAgf0XQYus7LXcTbxn0nM2WJAc9GnyVRmbEiYWYi3jEOvKjPj
	 wNlFl6FaObsRJIL+YcVQd+zuM9kqumBxQePMk6N+bYzkNKwo1HUZb/NSnIoi5ddm0KIcx
	 jdGyoFdR+xWman5mXX2bCg5Fyq+w/yDlOdMdFLs6mRlBO/Cuqm/bFCZGG3tqdZ90bOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563592;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BSEh4m4QFUAY/P4snYmGTxt9BeVKzLNuBTdwwA2Xez0=;
	b=g5OJAwWHCGVlwJKhkUMDQasMDYGn4feDyoxSra8KuxNnGqgAQBQGeMWKAvkqPs9X7jtW
	 VYiXgzsvBVXDM7eIxmtWspLr8boBDhjtPwTSAQYz//BWn52pJxxTR/bleUn6YRzeaRpEv
	 muruGFkLX3gY8sSpo7p5cQ3P7cMAmmu73IVETg/sH7p3CO14bGDb0+6J/S/eEqULsFaiT
	 RpUT5ULyasfGvRh5FoCCl+e4HFheAYTNf4MrltVQL2S2xs7UBqtzrAAlkT4BggpxKTSFc
	 DMIlihIflDab6kg6qwp0XJGXbp1caJbhpG+jdDlUqwNjqTxRSlu2qbliKNwXfaEaK/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C7Qof5v4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.33
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CBE606A319;
	Wed, 21 Oct 2026 06:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89CBE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C7Qof5v4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkkvWmsyw4WqFpFZp2gkBrWB4qWvxFuoaeC1shBd2Z9kAfM3/QABlXFcvdRAarzgqbcgRyAcMMYxUOBy6GTzsUqpn+VVDrXMK1/jBbFISfF3TDWSosy8Q+oS21C1TdgJPK12yJF+aNl8WGM0UDJqtJsj4qZfywvplbTnB2K5Qy/H3ItpoDAee78FNb6fsVh1qOmrokFgbmviUIzxXMgDNj4Ic/TNMZMQFqo+4wgTu5IEwcXUH9IeuS/jO0j9lV1SY7DAWsCmX6L1SfHWad+rRz9AXLQJa+bpKvI3fT3aqC8dyr20RHkeTkIE5WRAOInZK8bCOPfjQcbYPqTNNy+WHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSEh4m4QFUAY/P4snYmGTxt9BeVKzLNuBTdwwA2Xez0=;
 b=q+wJhzBDjYezIik4nV/z7bLb+XII9T+1PiGj8+E/Gf0m90xv8MlVZ1513qdZ53W4GpRlWg7MVAkU5ii0B8D4LAPkSSF9uNPyly221EiHXw+TIhmM9nZwPlhcpWZ74ed5o6HXMbngZbSF968w6rK2TTmy2eSf3xU6ZT9axh3BDopYEHD1Eu9jA3JRZjtMDpuIRXeaCyUkE2aEfOBznuWSftX9YeYjKl65QVBDS/k1J7I94aHpW8kGfho6RHx4s5PhyCUKHJdrybK0drvO2tGRwBK1R8G5NuMgBUeZPY0FQ8Ztm8W4EAaKV6V/bPAJtAJLlpr5JIBehqyMJv8Vh5ydvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSEh4m4QFUAY/P4snYmGTxt9BeVKzLNuBTdwwA2Xez0=;
 b=C7Qof5v4GblB7DJWZ24e+RtO+W0cCDnY6rR45ugl+ZqqQ0gpop0m0KymtCJc06o1b6CTdxtxsvZukhVlGJf/Zwl0xAwQYK7Skn+FUXuQJ0MbfRpCy8IYJI0N6U1ZpdDExW0IIDEk7JZMFTLLYzxFlP0awR+vK8sLKRcHsqCcMNdD2fJwNwwkHAJa2oP3eEJirWMwFPqm8QJt9otspz6jh331TdO4Z1O9auxvQCfLDlwl6P1msJsE7QMyPjqJK2Eol3t/bWe13n8jsHks1C/K6mNffQJuGY6UPkNlXxZbUm/h5UmkNn/+BadC/ZX9AJn2XizX3DXfqa7AxtNc5D+yyQ==
Received: from BN0PR04CA0202.namprd04.prod.outlook.com (2603:10b6:408:e9::27)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:19:44 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::6a) by BN0PR04CA0202.outlook.office365.com
 (2603:10b6:408:e9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Wed,
 21 Oct 2026 06:19:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:19:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:19:25 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:19:20 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 1/3] PCI: dwc: Reuse Endpoint resources after fundamental reset
Date: Wed, 21 Oct 2026 11:49:01 +0530
Message-ID: <20261021061903.1269605-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021061903.1269605-1-mmaddireddy@nvidia.com>
References: <20261021061903.1269605-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e29813a-115b-4d3f-743f-08df2f3b4cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|23010399003|36860700016|56012099006|5023799004|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	uevH0HIe/ofpdo2xfeZDdRlEEr9EhYmjnYETL8ZcQpqFejDin0UQ0hm3jHySkLTasRjBKabVY4X538UO2mwTDmoYGxsPBx4x/ax3ccIQO2Flgaj6IMelUxh+YbbNrLVhh4J7gacn/CueyeMVmqmnwpGxHCyyUyBIn6D0asvZ7/aaJydYgI+uaVAyHtHd1sup6z3FdqDbP8Gx2F9V8ZMmoodUQ30KcB+J0xr6cMDRaaNShWqafFid+aqUZQUsvdbSrNbVvoEPeyUJY76hVaMmAtl3/VzlTnrFpECC06cRZKO/A/nnvIiF17IlQPYIhfgnrivgCBN7VEOFjWEo7lT4Bkd4D9j6umTOUptn968ZftmmrWiHBK05EPMDpED0BjwUZJJ0mGDtWlnfxAuBRA2EGoqR8U1CID82KnmS3vzPABt9m7EX94WFjGbSyTtKhhYsugY4iP6rO5ZqXAwj0jHml4Mj1bPlPO9S/MJGXPv2A2fDD2EjKb7JTSU+Sw6UIj2M3dTsPZiXJ23BDlWx26RBb/jR31olN3j+2ZqcwjHStAbkEvjyhOAXRaOzAMdccwWRav13ULeLZHGOpCS9Euqd67BIEeaMhMdE96EdWkucXPNQKe0TzjtFVEpRvf2WoHltPXsgeqLi5CsZW2TDZ3duMIHdIPBCHBeAUWXbqD0NXSi2jpSwpsB7Pgred6388PGIvALpttQ1Sq6k84azZQoLTw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jt/eaKYEZB3CoBVnq1IOkCtK+HG81RRXngAZGKgV+9d4aRXMQqtCWwSvNdfI+JRmQ8NLN8nNce4ZJ319PuiUQc4YX6v7//mtlLj4Sqn8LJr6MKe/xBnByzMfUEEMsZdMdeMeApH2JwLTC48X1s24MweJ4AN/bydolfHqL1UpkueQ/+rgGZG0teq99U8qpI+GF3lnD28346GdB1yCsYZG5JDQvp7Fl7mIqxyGuoopQ+mwP2W60/vzuHwCC9jdir5mTjJTo7l1fPLe6lf8tf3SEX5fAwJCr9FuVqa4ryZBjJxAnDwQClAi4nO3O8WCgO9Gk7I0j1GF93xi9P7C+xfOpTzVSrWWUdGRskSKylp57/I+HI8f3zscVPndR9gFcGb4pFlNj0m97Avy1iFAYzVaF/cKaRVJFq76JB0wz4auiSWMoMSPlC3N/H3zky9Pne4W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:19:44.6558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e29813a-115b-4d3f-743f-08df2f3b4cd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270

A fundamental reset clears DWC Endpoint registers but does not end the
lifetime of the bound driver. Each full cleanup/init cycle removes and
recreates debugfs entries and, when eDMA is present, unregisters and
reprobes the DMA controller. eDMA detection also allocates managed DMA
linked-list memory that is retained until device detach. The
inbound/outbound allocation bitmaps, outbound-address array and
per-function descriptors already have allocation guards and can be
reused.

Track successful resource initialization in dw_pcie_ep_init_registers().
On later calls, restore the platform-specific registers, BAR defaults,
PTM and non-sticky registers without repeating resource setup. Keep the
register restoration helper private and use the existing public API for
both initial setup and reset recovery. Clear the initialization flag on
full cleanup so a later call performs resource setup again.

Invalidate the outbound window bitmap, address array and MSI iATU cache
after hardware has reset the iATU. This resets software bookkeeping; it
does not disable or unmap live hardware windows. Document that reset
recovery requires the hardware reset and quiesced EPF activity.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V2:
- Fold init/reinit selection into dw_pcie_ep_init_registers() instead of
  adding a separate init-or-reinit API.
- Keep the register restoration helper private and remove its public
  declarations, export and disabled-config stub.
- Rename the outbound helper to dw_pcie_ep_reset_outbound_state() and
  explain that it resets software bookkeeping after hardware reset.
- Document reset-recovery prerequisites and clarify resource lifetimes.
- Update the title and commit message to describe resource reuse.

 .../pci/controller/dwc/pcie-designware-ep.c   | 149 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 2 files changed, 108 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0262d85ed390..3c26c03b42f0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1155,6 +1155,32 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_msix_irq);
 
+static void dw_pcie_ep_clear_msi_iatu(struct dw_pcie_ep *ep)
+{
+	ep->msi_iatu_mapped = false;
+	ep->msi_iatu_mapped_offset = 0;
+	ep->msi_msg_addr = 0;
+	ep->msi_map_size = 0;
+}
+
+/*
+ * Reset only the software bookkeeping for outbound windows after hardware
+ * has reset the iATU. This does not disable or unmap live hardware windows.
+ */
+static void dw_pcie_ep_reset_outbound_state(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	if (ep->ob_window_map)
+		bitmap_zero(ep->ob_window_map, pci->num_ob_windows);
+
+	if (ep->outbound_addr)
+		memset(ep->outbound_addr, 0,
+		       pci->num_ob_windows * sizeof(*ep->outbound_addr));
+
+	dw_pcie_ep_clear_msi_iatu(ep);
+}
+
 /**
  * dw_pcie_ep_cleanup - Cleanup DWC EP resources after fundamental reset
  * @ep: DWC EP device
@@ -1169,11 +1195,12 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 
 	if (ep->msi_iatu_mapped) {
 		dw_pcie_ep_unmap_addr(ep->epc, 0, 0, ep->msi_mem_phys);
-		ep->msi_iatu_mapped = false;
+		dw_pcie_ep_clear_msi_iatu(ep);
 	}
 
 	dwc_pcie_debugfs_deinit(pci);
 	dw_pcie_edma_remove(pci);
+	ep->resources_initialized = false;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
 
@@ -1307,13 +1334,84 @@ static void dw_pcie_ep_disable_bars(struct dw_pcie_ep *ep)
 	}
 }
 
+static void dw_pcie_ep_init_ptm(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	u32 ptm_cap_base, reg;
+
+	/*
+	 * PCIe r6.0, section 7.9.15 states that for endpoints that support
+	 * PTM, this capability structure is required in exactly one
+	 * function, which controls the PTM behavior of all PTM capable
+	 * functions. This indicates the PTM capability structure
+	 * represents controller-level registers rather than per-function
+	 * registers.
+	 *
+	 * Therefore, PTM capability registers are configured using the
+	 * standard DBI accessors, instead of func_no indexed per-function
+	 * accessors.
+	 */
+	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
+
+	/*
+	 * PTM responder capability can be disabled only after disabling
+	 * PTM root capability.
+	 */
+	if (ptm_cap_base) {
+		dw_pcie_dbi_ro_wr_en(pci);
+		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
+		reg &= ~PCI_PTM_CAP_ROOT;
+		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
+
+		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
+		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
+		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+}
+
+/**
+ * dw_pcie_ep_reinit_registers - Reinitialize DWC EP reset-lost registers
+ * @ep: DWC EP device
+ *
+ * Restore the EP registers lost after a fundamental reset without repeating
+ * software resource setup. Hardware must already have reset the iATU; this
+ * helper invalidates software iATU state but does not disable live windows.
+ */
+static int dw_pcie_ep_reinit_registers(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	int ret;
+
+	dw_pcie_ep_reset_outbound_state(ep);
+
+	if (ep->ops->init) {
+		ret = ep->ops->init(ep);
+		if (ret)
+			return ret;
+	}
+
+	dw_pcie_ep_disable_bars(ep);
+	dw_pcie_ep_init_ptm(ep);
+	dw_pcie_ep_init_non_sticky_registers(pci);
+
+	return 0;
+}
+
 /**
  * dw_pcie_ep_init_registers - Initialize DWC EP specific registers
  * @ep: DWC EP device
  *
  * Initialize the registers (CSRs) specific to DWC EP. This API should be called
  * only when the endpoint receives an active refclk (either from host or
- * generated locally).
+ * generated locally). The caller must quiesce EPF activity and ensure that
+ * hardware has reset the outbound iATU before calling this API after a
+ * fundamental reset. Cached outbound mappings are invalidated without
+ * disabling live hardware windows.
+ *
+ * The first successful call sets up the DWC EP software resources. Later
+ * calls restore reset-lost registers while retaining those resources until
+ * dw_pcie_ep_cleanup() or dw_pcie_ep_deinit().
  */
 int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 {
@@ -1321,7 +1419,6 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	struct dw_pcie_ep_func *ep_func;
 	struct device *dev = pci->dev;
 	struct pci_epc *epc = ep->epc;
-	u32 ptm_cap_base, reg;
 	u8 hdr_type;
 	u8 func_no;
 	void *addr;
@@ -1336,6 +1433,9 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 		return -EIO;
 	}
 
+	if (ep->resources_initialized)
+		return dw_pcie_ep_reinit_registers(ep);
+
 	dw_pcie_version_detect(pci);
 
 	dw_pcie_iatu_detect(pci);
@@ -1386,47 +1486,12 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 		list_add_tail(&ep_func->list, &ep->func_list);
 	}
 
-	if (ep->ops->init) {
-		ret = ep->ops->init(ep);
-		if (ret)
-			goto err_remove_edma;
-	}
-
-	dw_pcie_ep_disable_bars(ep);
-
-	/*
-	 * PCIe r6.0, section 7.9.15 states that for endpoints that support
-	 * PTM, this capability structure is required in exactly one
-	 * function, which controls the PTM behavior of all PTM capable
-	 * functions. This indicates the PTM capability structure
-	 * represents controller-level registers rather than per-function
-	 * registers.
-	 *
-	 * Therefore, PTM capability registers are configured using the
-	 * standard DBI accessors, instead of func_no indexed per-function
-	 * accessors.
-	 */
-	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
-
-	/*
-	 * PTM responder capability can be disabled only after disabling
-	 * PTM root capability.
-	 */
-	if (ptm_cap_base) {
-		dw_pcie_dbi_ro_wr_en(pci);
-		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
-		reg &= ~PCI_PTM_CAP_ROOT;
-		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
-
-		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
-		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
-		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
-		dw_pcie_dbi_ro_wr_dis(pci);
-	}
-
-	dw_pcie_ep_init_non_sticky_registers(pci);
+	ret = dw_pcie_ep_reinit_registers(ep);
+	if (ret)
+		goto err_remove_edma;
 
 	dwc_pcie_debugfs_init(pci, DW_PCIE_EP_TYPE);
+	ep->resources_initialized = true;
 
 	return 0;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e7cdf1c69744..2d3563c3c4bf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -513,6 +513,7 @@ struct dw_pcie_ep {
 	unsigned long		*ob_window_map;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
+	bool			resources_initialized;
 
 	/* MSI outbound iATU state */
 	bool			msi_iatu_mapped;
-- 
2.34.1

