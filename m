Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618262;
	b=w+yvDX3vX694JeVJ8gLahwixsq2rBtzCGobLiocvTznDjTZBmSQSN6up6MkId6y4Fkf6
	 84mD0fnVzqCYE9iXC2rBQE6ORII/tc33vvrHbOE9McD3asXSBS2eo3YXEKeWnVJ2a0Awe
	 ODpCJnPZWoBjsvFhzXmc3f+IP/oKVfc0HBCqA+dgKWPro4b0UwvQsx/01JFBCyoHufDza
	 eGefI/6FOpmNjUG7MGxUxTz06bFuoWbwsMPK5mkvL7EWsR1by6I/Z8s7qke0gx9jNd6pB
	 zL9dPv4J9bpJghMirhf34srU4RUliWemQk6LBvoUjmCFrbzAGprK3rqTXVAzqeLJ7ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618262;
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
	bh=as1LHW9/D66Sb4hty/EyOFs/nVqhH3B50LYvFUpAxpM=;
	b=oVf5P90Ya39aFyyMK5iJFAtSPvnVzLVtdjER/95ofUTyfQ2cvlA/3QIlOaCvVK3YBB8E
	 tCcW7ZLykiv/0cDvShJkgJVRkE3fnD8c8bpczaSTAZBQsKPwmPToqoFOD3eJbRXOWpJdw
	 //gUVS0Y3pSGQVdhoHfBZk0tjniwWzu9grj50UN+lPTBgROHR5MeU4q+aOfz3yZMJWr94
	 N+vsjbC78Ar/Wgy/p5kw5f0JbAO09RSZQfZIqy+/rjCSjzZkN8iccd9Q6tcGJIgtZq5u0
	 Mof83BSOJN7oQL8aKANdXkX8A+CgHKJvqO+MZ8yvZFDJBXkVoBhsztiJbrDgcz2sv7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DWoYJGsb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.25
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8B4606A324;
	Mon,  2 Nov 2026 11:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D8B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DWoYJGsb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrHsOYdSlEsbFt2SW62bySLQG/IJOgELg1avkzQczdrRDkSk01Kd4FuXnx2T/1Wm9xmY/SvwhmLq4yQLUHE5ZZHYFEt4KRfsVE6/x9acJKm/7COTFNzoWIw6V6yPSxs0PGB4MxrsH2flGU6DqBoK2zIqLplGX69gIKmpnMSuEuLVmkBd5VJQtYI6auO/pmdI34he7P4gbE9+fjRAVYwfiJLIeNvU5QlgO99cLros2C+gSrSUwu6ZtG+AgWVHTX3YraCbvoassCQOI5xT0qv/1Hr8xrFIxV+DQ6+LpFPBTIVZKO2HC1gsVwLaTu/ijpE32wgjShW6WXeANYgEZxPqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=as1LHW9/D66Sb4hty/EyOFs/nVqhH3B50LYvFUpAxpM=;
 b=EJwXB8rYbasbntPAMI57hhYO9SrCJXHFsnOCXqZis7JRAKee4LSG0WKvdscs4OifZMEzuqbaSJNbwMCSO9lIUl1QY/wf1zRZVYp8A4BMf+2pfdvWKDgLBSta2f1yrPR1Cl5i6FJ8UIcVRq5f055eLe3GiIgK98mp7QAfvnvEmUcSpdDbMbyrXAuTZ/Q3FdYuB1wrrif2DQe+3iY0H0mjss2FtYjtSeClct77J7XLQFoQsR8UFcxB/Z4jOi1MdK82GGdHe39KQ3cYe58fIk1NLoHEJOBNjIRw+XwvLgqIAEJ0gVE4SRyFboTfAHKgSND1Ja9a91RRcpm3OYnq62YbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as1LHW9/D66Sb4hty/EyOFs/nVqhH3B50LYvFUpAxpM=;
 b=DWoYJGsb4lhX1p2m6rvwmcgDPoWzJ5GxuxaAraDgLe2ysjXNvcOkJFGjLiWJiDt7B7bqoLn4/0zRwJn5ZhQPltyKuyZhypYbfYlg5WdFKV04/wGdF9uLw91NcDpaRhJOJmgKUGFwQVTqxgcM/ExN0eD3ohRIydAyC9Uq7mUOBQU7kTGQEjVZee1J/BZ6l8uf2vW0ZDGAR7RI0AUuJjnAbL/i+OoWVqrwaZnzyu3A+fWEO/ZlZb1ku7trSyEYTKyNscL5plzkHaXfwahF/d1WSN7BJOzD1pIdrVMoFdSgnCdW5LacAnTsE0jtEkSGHDXcTyyGbx4xWZ46RtSy4SXiYA==
Received: from BN1PR14CA0003.namprd14.prod.outlook.com (2603:10b6:408:e3::8)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Mon, 2 Nov
 2026 11:15:30 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::2f) by BN1PR14CA0003.outlook.office365.com
 (2603:10b6:408:e3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 11:15:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:15:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:15:12 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:15:07 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v3 1/4] PCI: dwc: Reuse Endpoint resources after fundamental reset
Date: Mon, 2 Nov 2026 16:44:47 +0530
Message-ID: <20261102111450.4010818-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
References: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 859cc3ea-d148-4269-be9e-08df38d29a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|23010399003|6133799003|10067099003|22082099003|18002099003|11063799006|5023799004|261022075727099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003|261021123027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	iMlrZrL3mtHyHL1Q63BG+NlM70ktm/NQ8mTvcAnVIDaXpJIgVouBH1lp/sVI+QWqpTNNFcBls850BgLR8DM+G70pYB1JR943xDuKS27aLX7UvtPaCA19VTMFWR7wdCY2ZttAow7mSZFI6IkCborLLscLqP1lk7A98uyShV4MvBQLnUVY+tNaH7DAlH3WMCtUhN7Imq3l92aFtLYf62hxCytCb4fFpNJkUcKZPDaxOEYQCnd0UgSYlEpD+KQH9RKbOZ8fXIDrr5WM/emNergMHxHlVZ61xniZQL6NT7Ynq2oycYHU3KYLuVCU7E2+7N4PP/VsTBrOWSj2xJmR2UapcSw+sHnXKf6lE89cu1jRLFL1PxEPBgCaNsuAAyhm8Z8XT582Sb4qI/Gv8gLTC0wHhKA8WVIi3yLkydXl36/f8O1bf2viiASGx3BFIZB6yty7f7+50XDTR3rw7giQ6Lv7gwY+WnLKReVT8QLvlEgG6J+miTs1bdrseqSXZwPyNOLduZRmT8ghY8jzP0Kg0FrLZAVrUYbZJeBpYlarMQdKuIKxel9QeGKWu5ElCh2lZGYzaJkWUHU729pfdH8Vp1dqhN0yYC4TbU172xrh+3TElh/X9gauOXnMu87oCevYZB7qAW0lU90xuUbxV3FwVf403UZ9YaKnWZR6cYfEaQbRtPwSNIDRYMvGHNN0zC06BXhnPoLiHahi+M43UMLHr3parQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(5023799004)(261022075727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LgAhXoeFxeCWPO24FYsEt/yVma+v+ChyME3iLwBI1gXPHmd6tWvjpo68bPHf8bV8F1Ki9095rs9Ro/LFxN18ZthiXoRIShUzybj7HjuslJP8rN1wqAXzSqjE+FgUl8Mc+eSJhrj1odnATQGnRDQIDFLunKHNlZuCKQFjBBz3MLnUJd+jq9PVBvNgn3/RXJ0XSpHxnp9txS9YSJaUlmvHh6+nuvmOuXEA7CLXJ2FGnW7561zgoLUUkp2AUohffHJDelL4U0G92Hxi36eW/tdl9k0mN/1jY7WP7oSlI5J9i1fkTXQIuUrIb9CHd7T5fPmASbBwi0Zj4XHXDhdlEMAxqfyOXbEds+jGjUShUu5q1q5NxTPkOUz+VaR29lMikVkBTouevgYGwDX5Nev+P+gHeGLK71C8UYs7CY2EaOFUjiGAPg0+MRb4nStoPWtxBH4h
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:15:29.0875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859cc3ea-d148-4269-be9e-08df38d29a47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698

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
Changes V2 -> V3:
- No code changes from v2; rebased onto the current PCI main-based stack.

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
index 630ba172280c..be0a997416f5 100644
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
 
@@ -1310,13 +1337,84 @@ static void dw_pcie_ep_disable_bars(struct dw_pcie_ep *ep)
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
@@ -1324,7 +1422,6 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	struct dw_pcie_ep_func *ep_func;
 	struct device *dev = pci->dev;
 	struct pci_epc *epc = ep->epc;
-	u32 ptm_cap_base, reg;
 	u8 hdr_type;
 	u8 func_no;
 	void *addr;
@@ -1339,6 +1436,9 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 		return -EIO;
 	}
 
+	if (ep->resources_initialized)
+		return dw_pcie_ep_reinit_registers(ep);
+
 	dw_pcie_version_detect(pci);
 
 	dw_pcie_iatu_detect(pci);
@@ -1389,47 +1489,12 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
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
index 09fb802174ee..f40d488cd561 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -521,6 +521,7 @@ struct dw_pcie_ep {
 	unsigned long		*ob_window_map;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
+	bool			resources_initialized;
 
 	/* MSI outbound iATU state */
 	bool			msi_iatu_mapped;
-- 
2.34.1

