Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3344BCBE;
	Wed, 23 Sep 2026 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148417; cv=fail; b=L/eTMa/rPu0UjIOI1LDfPgJMkVXbr1ShugkY+Noon/f+NQEHjb1/au0ta2g3yGa1ON1Vg2QMywmDJ5Ff59OXTUM7BrjYyHsRXAaJ0lOMyk8gDQ9jZZqKzJwNDpHlLiQtLTwylhS4QHEf//fQNildYcDmBWVD/B8TtmJ33Dj2JqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148417; c=relaxed/simple;
	bh=s6tJ+ykICwYsGCuACBX1PNcpqkAuUv96Y5IOO1FFcek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9VMhYXZ/+8sHEWxc7tH3jorlRbLxy8E1MHUPV7QKgtPsyqYWyhKpt0EymrVEPOWSW+oFI/3dgW+jFkl4fTvU2WlhRJMHy20stJ6YJxC6/lKeyVdnkqaeAW4nYR7u8ZvItfdGXUtUwRBj+nMKXjxAhfhfOLNmsHkJJLESlVEzmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=axjbNZAD; arc=fail smtp.client-ip=52.101.193.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="axjbNZAD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQnHinACbYUUdUObQOD7v2FHeX//vKY/3HBbMUIfkipOSajhsOI+XB9PnmruM2j3g1cWlk9xW1FndBfIEqbB5qNPPj4xwuSme/WdrenY6kesWvp7JBn/bbtGi6p2hGia2/tWe6LaScPejYYOq0iriWf+ZMcVSqzYx3mbIVPXd0R/KswtcJNxOCq+4dOA5zfFIy1AFK3/zZvanB+s5Ur/EP1dFU9gb9I5CpTgz2N8XAWyaZFSB5PX5J9zvIPan7O5X4aGqtK/pHviAlsMwkA60qCon+vzBGhr254dSLSOE+9lOhqJurtvK5MBE+nCz5Jh9ZcK/myu1We4LLM2uQXdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLVB4li1rpe5XaNcTbstuGduQEQLidaxMiutNA20U40=;
 b=F5gBMl+KvuFGGEHThtY15ATd1IYbz3pg7At7TwFRjxorNd7nxZ4MsKfl+rf+iedYXKkUK8sGwSD2Jpf8AloX8GNR4G/Bc7G4OA4BcWmaaR3yiO6Z3bVpQMEPn+eldN+OtTzbBUmKWoai0ydMGUWb0TQDqFlzKcldqPKgejmWtSQsxvUSpG3uWbEfoi324C38oBH8gN5HIDZ8AL9yMC7uqPFbfs79inxT89y6qGYxjv8n/E34Be6tLExWtswpXspAyq/tR+1rvAt8tjMM0IdjoLK3T2NPjWfm6YBqLP+J2X0TQS3ZljLdmKaQMHj92DQyhwC1X0jIiOf4jWiuBbZbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLVB4li1rpe5XaNcTbstuGduQEQLidaxMiutNA20U40=;
 b=axjbNZADkw4klZdemoZJ8hxCOuPn78a7rTZKoWmTRw5bW4cFK4gcfddhUMzscziL+5ah88oKtHZ8Rlk7qk3WpkUm8xs4/nDI2aeIIxOE08q5HmaF/yiXT26MGkXBohrs8w3mkZ2EK0LJugNi+1fHLawHU3VDY0irEeBOX3ex0Scv24mafTEnXZtLjPUac4Q9IBzaqFxgqGwEXkTK9YGxccpslAetgeKjfG7iBGv4ic0RpLcb2v3Uyi+0YAmk7bDUSTtych9u4LmMj01ijtSxWJZ3TucBYxiXu+VA9aIIqGWZ3ZngiV9NFbqxYnCoOKTd+uMbvjWgAGIVk7AKo/56TQ==
Received: from MW4PR04CA0165.namprd04.prod.outlook.com (2603:10b6:303:85::20)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:26:48 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::5e) by MW4PR04CA0165.outlook.office365.com
 (2603:10b6:303:85::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:26:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:26:24 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:26:20 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Krzysztof
 Wilczynski" <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 1/3] PCI: dwc: Add Endpoint reinit helper
Date: Wed, 23 Sep 2026 12:55:52 +0530
Message-ID: <20260923072554.1141864-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923072554.1141864-1-mmaddireddy@nvidia.com>
References: <20260923072554.1141864-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c406f0-8fa8-40b9-5593-08df1944071a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|5023799004|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	16fzna3j0DjAI47MX9EpZGqzFBVVrhuwNK0g9S97eR+Kf3bfPjnXSWPwQIJSNeX41zyfzrqoY6EtYe1XsGzjiU7eS6XAnhaXP2N0zgD6mNOGDFAk4Jf/YEMmlBfwo3HDPKfy1o0bpdrVFomzAUQOSKlzIWanhCWtaV2nwVoyqP5YpIXYViGtFndjVB86nBOf2zfHuxLaVbgVyKaNYNb6NfmbZT28Jk7LtQpw3UdG0yOxBjuoHq6ARIKWiR+a++mK9nuAdIq+sxlR7uLGLaD7L/cKz3oG0BkzmAf1wN2uvi1dL+jn8ITkDLPyFjoXwkuPGxbV0kx+GLxaFHiBhk1oV8bMQXucTv3/H8xJ7sQu352u9L3uO9tkNZyLhx3wGZrHpkFery0dDyqQ2y/GCDIbzT6ZX5PaYbV9H55XecoFvH3A8xdphFYuNVI7FSBanQObyD/+bMsPlEigXpgk3+rQb4pjZxGGkTzOmr9Wgq++bxoWIZwCZplmB6ZpsUoqbg3G69DqZbCDKitFpejPk8QHuTISbHLG03fSxQxuv1+Wd0VE9Cx/McVX5VGvfqzIWiTjYC4bRwB6bfjlmQHC97b2NDfRkdUILoYKVJDHEtOY0dUGJcbWAXYQ9FLlH0zdZnH6T+OQWNggNYfyIYqcsEZbDI8S5QsyyLHOTqHfPtnGAPou+t3GjPo46qILPc3SWbUlaCUJflvfwKjzw9wHieRo7Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eICYKiys3xHugKVIsxHkUWehadLlQPpVGtBVByVr3riojK+zNoMvN4HC4GTHkIewOhaQWc7E/lafcpMSmmRtYYf62VYKNG0boTCPZxmv29dP1bhSfKM6fw5cRYRyCsSyC1NB6JUQhI4ygtXPqwlyWTav+Hk5tdoDGsigE/5s7kg540gViv3v+CVAa1NFYi8P7YLro+m/s9xyMbqC4SmNtrHO1rBEwEzdsD+rbbMgmAyVSyQKZ0zvQEYbbgZ0hkXCiiEpfQDXkHsEKWhhJ/hgq84pXtMvio6evyInP8Z6BlKfO/abbndYRGZEY+MwPsJX2VmmIcPTMQNZ1zESG3Rao3KSYeiLljVn9zDomnYHOo805KY6tiP+zsYW9a5noObGfi1DeyWATcOSNQbi/8QG1PPa9Q252ufuSJdOA6mk2IZRS8/Y5klBhXJJ1xFwaPDi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:26:47.7276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c406f0-8fa8-40b9-5593-08df1944071a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006

Endpoint controllers can receive a fundamental reset while software
resources such as eDMA, debugfs and function state must live for the
controller lifetime.

Track whether DWC Endpoint resources are initialized and add helpers
that perform full initialization once, then reinitialize only reset-lost
registers on later fundamental reset cycles.

A fundamental reset also clears outbound iATU programming. Clear the
cached outbound window map, outbound address array and MSI iATU cache
before reinitializing registers so stale software state cannot hide a
window that was reset by hardware.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 152 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  13 ++
 2 files changed, 124 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index de8ee3db4360..7ba40220b821 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1155,6 +1155,28 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
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
+static void dw_pcie_ep_clear_outbound_atus(struct dw_pcie_ep *ep)
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
@@ -1169,11 +1191,12 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 
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
 
@@ -1307,6 +1330,89 @@ static void dw_pcie_ep_disable_bars(struct dw_pcie_ep *ep)
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
+ * Reinitialize the EP registers lost after a fundamental reset without
+ * reallocating EP resources that live until dw_pcie_ep_deinit(). The
+ * caller must only use this after hardware has reset the iATU; this
+ * helper invalidates software iATU state but does not disable live
+ * windows.
+ */
+int dw_pcie_ep_reinit_registers(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	int ret;
+
+	dw_pcie_ep_clear_outbound_atus(ep);
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
+EXPORT_SYMBOL_GPL(dw_pcie_ep_reinit_registers);
+
+/**
+ * dw_pcie_ep_init_or_reinit_registers - Initialize or reinitialize DWC EP
+ * @ep: DWC EP device
+ *
+ * Initialize DWC EP resources on first use. If resources are already
+ * initialized, reinitialize only the reset-lost registers.
+ */
+int dw_pcie_ep_init_or_reinit_registers(struct dw_pcie_ep *ep)
+{
+	if (ep->resources_initialized)
+		return dw_pcie_ep_reinit_registers(ep);
+
+	return dw_pcie_ep_init_registers(ep);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_ep_init_or_reinit_registers);
+
 /**
  * dw_pcie_ep_init_registers - Initialize DWC EP specific registers
  * @ep: DWC EP device
@@ -1321,7 +1427,6 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	struct dw_pcie_ep_func *ep_func;
 	struct device *dev = pci->dev;
 	struct pci_epc *epc = ep->epc;
-	u32 ptm_cap_base, reg;
 	u8 hdr_type;
 	u8 func_no;
 	void *addr;
@@ -1386,47 +1491,12 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
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
index 4d55339750f0..ae442de396ff 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -511,6 +511,7 @@ struct dw_pcie_ep {
 	unsigned long		*ob_window_map;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
+	bool			resources_initialized;
 
 	/* MSI outbound iATU state */
 	bool			msi_iatu_mapped;
@@ -922,6 +923,8 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep);
+int dw_pcie_ep_reinit_registers(struct dw_pcie_ep *ep);
+int dw_pcie_ep_init_or_reinit_registers(struct dw_pcie_ep *ep);
 void dw_pcie_ep_deinit(struct dw_pcie_ep *ep);
 void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no);
@@ -953,6 +956,16 @@ static inline int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	return 0;
 }
 
+static inline int dw_pcie_ep_reinit_registers(struct dw_pcie_ep *ep)
+{
+	return 0;
+}
+
+static inline int dw_pcie_ep_init_or_reinit_registers(struct dw_pcie_ep *ep)
+{
+	return 0;
+}
+
 static inline void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 {
 }
-- 
2.34.1

