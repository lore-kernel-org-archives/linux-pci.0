Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020092.outbound.protection.outlook.com [52.101.228.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC97440A13;
	Thu,  3 Sep 2026 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423907; cv=fail; b=fmmEm4XhivBrgRTo3Qo3nB82lN/EOBtZ6l1+adxBY//X34FhHdT5bCVs4kwpsSo4f5+AEcAvXrbl1lYHJ/P9IC+aRyqqCSRqL2n+Xf4nAILPxh8Zk12oFaoLUGzGbCjRSRRFg5cLXU0bspRC2krmsyzlY04CJK5lwSbx9HSzCmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423907; c=relaxed/simple;
	bh=RGIAYQw7SyqwOqge3nnx3oX8GPX5sr/xB1EZ7fxYYT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=STPYPeC9c2BRe3tepshmwjkAW8y9EC/XD5g1IEb7PRhXLyt76iiFyxZLMHFfVlv7nPGBKqrV0IfHCH/hCBvp0s2zx/dAXpjnsd7pPEZWL55JF2HXyuGLZAnomz6GpNHYQjkOJ9JU1lwsPamh6pHg17xKyTLdJCUU6W+yOmZ8gPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dVZ9OJG0; arc=fail smtp.client-ip=52.101.228.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="dVZ9OJG0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLmw8AwBEhHI6qJL5vRpghrd1QtqaT+fNP1xZA8EJBISJIrNobepYuSlGrSsGHg21axA6x1yZlIHfexmPZOU32Umq1H80xdGmMfUbeKOxgILsqTLIDW59XA3iR+ZYMZZcl42/kZyrvsPemJd+G9fHFmZxcJ+sdoprKrA3Ho/mPeGcm5v4lmi9Pmq+XjPpct5MMSYAt53HVW7uRZZQKuoc+pZTyOH1hgVCoaxKrCZ5tFuu031DALnYWPg7JhOlhLMkzdkczqTA03J+bLhvAysHtstyCxVCfttaiqQCk1o5m43ROiPfOKiVs99vaTSRbaMUY2gv4sJPV7fCq5z3WCdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/3gtnpfADFljUalPmELMFWTccx1kkCwWpGUdiPI6Iw=;
 b=U8tkFQJpOTeAoP8HyY3NbqK5cN0V6CPUuomKWHLfUQk/z3wnl09MMJqvZ8pkeskkLXLhnOxB0231jK5NHogotTkSyedr99Bd4j6lRBQzXZnQmH6znZSRQqbiCQsW4ShPrcvAHRoZYyvBCQf3dpaIPkwKP+EwDO7ZLy3srVGWQx3SCx/vWbiw8pdN4qHFkOexRtYaLmjY/ufXtJeiKZ8+ulLVZzYKyIRyl3Je4lQd/vjM7UkF4GN76lRyEUJkgj7Q0PjHyvfuOHgtPLPmyZGoyoFe6/ZFgmgw0UVvylzJdP+tocMM6XKvTd9dzQNq+7zptQbIFVa0xhDIL/c6ehriUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/3gtnpfADFljUalPmELMFWTccx1kkCwWpGUdiPI6Iw=;
 b=dVZ9OJG0wyHnqJWNHS1MRuAFqKHoks4GDSgP6eqxNZL/7X17dIpk1GeQHjMocjrsFCIUWBZGDX59suNWDH2xztKyamCI3M3WcnqincuOcJhOixr7froxQu1UsXXILvRMj0xLwc6sp71D8iXy1GrW1Xc4PbPsAxR2X9qwUv9+pzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7060.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:24:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 08:24:59 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 2/7] PCI: dwc: Expose endpoint DMA resources
Date: Thu,  3 Sep 2026 17:23:22 +0900
Message-ID: <20260903082327.2345602-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260903082327.2345602-1-den@valinux.co.jp>
References: <20260903082327.2345602-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0065.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 3512c2e3-87f5-4c2b-569f-08df0994d7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|10070799003|366016|6133799003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hVNBn94Hgb2KRHIYOPIQmuI6L+LgfdOntadaHDWPN7hnaCRN4UkKFHtKbgwNbUE76Y4aafzg4OjB8JhmTqdQHkUEgfwYJj1Xa8TTiKhg7r8TdqLSp43ragql6seqdhkLGH3u1vLoSnE1qfhMHMjcq+ZuUppkyM7niQBX40a+RyJMBxD8HgNR8PzUJ5ErRYDono2gPoz017UolbnIB+QMk9MkFbtG4D3+ZDfUdeds1vDipSToyf1ly4ln7U69vNfrMj3UCFDDukf5rOeStmKLrUAY9vgimw4VQb26FSaW8u8K5oJN+nJYcpa5j0jx+yOE9dZIE4Z2uf1sK+1c0Vwgwx9cVCLV/PRwlIMjPcmLFiJcxNhjIOxv+/GLgnykMeBWnOaCVv8EOwnIUneTGHMnnLMeTaaU1PNG1M0ayQjOEasI4YWBs/wAIDrwOHVxMN86lf6MvFVsZR9Niiw7ZDmLUhMu6NgLLPAa5lMfQfVJayM6rUNsfrAKrG5Y/ssYg93g3q81Gw+UdnaGRjILXwMCOR0PJ/kxLZV10HYbYPfzC3c/lHBBQdgwjL3Z8OccY2cymBthP28mw+9gNTvM+q/NeSL2jnkiMYF+nI9DeW483/JN0nNb0IlB9U0YtgIC/Bg+v25OwttZrgrIG4ZWqEhMKwK1Gp1FHrr3zQGYBMSDw5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(10070799003)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EmpTb/nddLnJjDjj0pk09kpaZ943UhegCSTmT4UAunO0j7uwDSwmmbGnGg/L?=
 =?us-ascii?Q?tKrvX7KoyhjPc6+T0fO/H9TyAMyA3XQwtIi7+eTHxvh0XHa0TEnDkjYrkHIh?=
 =?us-ascii?Q?k/c+kX3f4k+ckrrUCbhWgExND+lxTzma2q/xSNSUDJTsy8vXWGhIsRpRdbqE?=
 =?us-ascii?Q?v5mwF1dEigY7+J9RI5f4DaoqIvIog9IFVgVWQlFe8iDRJtDX4vGCXqXHHffJ?=
 =?us-ascii?Q?MZuYYFe1KASHWuwhB3JeIBtpR5dlpYPKkHvj788d+mMJFpCEtaphAlvVH5ut?=
 =?us-ascii?Q?wgbHMYJZj+0lbQCHId4X9Vv1VZcByOlCXDzfvaxv43WWdFLirZlMlAKyIhwc?=
 =?us-ascii?Q?R+1BwPWP6zStNPGN9KCkmQfm1blgOva35Eww31C/68RMtANLKKQju4GsleAn?=
 =?us-ascii?Q?x7RhTK0Kl5IHuYvXgb5KnQ7ZTtNp7Kv3zYp4aXBF2CHiAHHZBjdqr7xwsB0K?=
 =?us-ascii?Q?UnzaUs7Jcg9GRedU689oefSEFijYQApBa7Q36NZdijcrgflv2Dk0Wwu2gDZL?=
 =?us-ascii?Q?vx4HkpqX5af1e6Rwpm1nLPe51MGNtDTSp2piRwWrP9NTlOVVACsUSMsEFeFz?=
 =?us-ascii?Q?ySigJbZKkHkkoPi+BBxqRRH5Pw+61efmZhqgz7kFGR5jgQs1G6YoiRU+n4HS?=
 =?us-ascii?Q?mHCZsVjTX6LI/FRHzqdoFnsmZPdmDn+ZjvMaKvULVTkZ2Qoe4QCzDX8WbJtk?=
 =?us-ascii?Q?DHmRtXY2NMpMSl6RCZealrH/pAwioHER7cPXQQWXb96HZhIjmtX83ONefAij?=
 =?us-ascii?Q?KJ6bXr2fpiWzOM5p20RTXt5amrfxPg59/CFekw7yhOlShL1/rKQNXrUL+qnx?=
 =?us-ascii?Q?37B22kMCIMEYhm6uiJr+Iobg4TODuX96X5BJFtp3bNFOojBUgmQT9uR1FoQn?=
 =?us-ascii?Q?FQP/Jf2WusRDxwc/V6p8Y8utuvfhwqDPG68+vVdAiEj0uxxGPsXCxjOG9cw7?=
 =?us-ascii?Q?AEfMLw+CrwsJ53+s+uVVYWXxPSaFq/hwlwFQfdXx5PPzhU/lnRqcKVA78+xJ?=
 =?us-ascii?Q?Jmhog8LgebENmd/IbsKW8yvDir6thkeNVvfVxm0fabbzHyQUrgZCDEqrDH6T?=
 =?us-ascii?Q?wo+/UJK6wsBkeWXbhQHO3huCBknTg+95/djNQa3NBAnsvwHU9zfl3jVSRYh3?=
 =?us-ascii?Q?nJKjtZM8A9lY6qNFNqaeiQdaDcPxQ2hFme0FU1ahj2xWJJVOuHGfRsZ/an6Y?=
 =?us-ascii?Q?SuRt247JCmgWgalMs70CM4kf8s+Wni1DoZBDj/bqE2l9snCmDRl3pbQllTJ+?=
 =?us-ascii?Q?TkpMB1rUvGJc1Pf/X/2Ke4fXcMmjtbVYor2aU4okqNTphcXBvoB+PuELRCWH?=
 =?us-ascii?Q?oqvLKrGRKBmxMRxBmyLlrxJnTMyT/F4ZC6S7AUIwbb9hac8SDmB6pSnbFkZ8?=
 =?us-ascii?Q?6/kFW0qX6DwxoKMmmeuaYLPYRsj1fQzMN2rO73yV6SVm4tz8uLMIrKUduqi9?=
 =?us-ascii?Q?tupyyvcXlUslCTNrr0FgObuO68fmWWsOfGC+XSCvei19fAAQuihMd7+jpUYK?=
 =?us-ascii?Q?aq2m/6+zchMb953Deg5Ipm2vJ1Wq/YembUJo9rjSiFkGPW50aKUlEKMH0UQC?=
 =?us-ascii?Q?WYLyL9K4TClLe1PLPjgxG5VeygTteet21+TNtrUMss9DlWQFMGyeRVlIxHu0?=
 =?us-ascii?Q?ZQQBNwftiJ9MJxfX9+Z/rriJw8awW2KAU+ACXeCknJUDKE1OAcUG6JIFec6Z?=
 =?us-ascii?Q?Yoch4sG5kn/9sod2fgfTeRZd8l7vaRPck9myJMQQdaLPQUuWz+PRDpv4r2Np?=
 =?us-ascii?Q?FWOnqGLRFQPYqJIyaAc7fH4H4ZwsB95FznpeExtN37o9bboLaI/Y?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3512c2e3-87f5-4c2b-569f-08df0994d7f5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:24:59.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWiEe67EoJEacaEBQNmMDpVUAxQvsaHpNQpFvP6e3udA1Efl4S+k8u5KU2+9oOHHqO4Y3aNj7Vul3QD21RKgTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7060

Expose the endpoint-integrated eDMA register window and linked-list memory
through the EPC auxiliary resource API. Endpoint functions can then choose
which channels to export and map the required windows.

Associate each linked-list region with the direction-flattened static
channel ID used by the local dw-edma device. Report these resources only
after that device is registered and only for channels with linked-list
memory.

When the register window is already part of a reserved BAR, report its BAR
and offset. Otherwise report its CPU physical address.

While at it, harden the existing doorbell resource query. Report it
only after the local dw-edma device is registered, and reject VF
queries because DWC cannot assign DMA/HDMA registers to VFs.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++++++++++++++++--
 1 file changed, 99 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index de8ee3db4360..c5e07edb52b1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -858,6 +858,15 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
 	return NULL;
 }
 
+static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
+{
+	/*
+	 * The DWC endpoint databook says it is not possible to assign the
+	 * DMA/HDMA registers to any Virtual Function.
+	 */
+	return vfunc_no ? -EOPNOTSUPP : 0;
+}
+
 static int
 dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 				   u8 vfunc_no)
@@ -865,14 +874,30 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_edma_chip *edma = &pci->edma;
+	u16 ll_wr_cnt, ll_rd_cnt;
+	int count = 0;
+	int ret;
 
 	if (!pci->edma_reg_size)
 		return 0;
 
-	if (edma->db_offset == ~0)
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
 		return 0;
 
-	return 1;
+	ll_wr_cnt = edma->ll_wr_cnt;
+	ll_rd_cnt = edma->ll_rd_cnt;
+
+	if (!edma->cfg_non_ll)
+		count += 1 + ll_wr_cnt + ll_rd_cnt;
+
+	if (edma->db_offset != ~0)
+		count++;
+
+	return count;
 }
 
 static int
@@ -885,14 +910,32 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	const struct pci_epc_bar_rsvd_region *rsvd;
 	struct dw_edma_chip *edma = &pci->edma;
 	enum pci_barno dma_ctrl_bar = NO_BAR;
-	resource_size_t db_offset = edma->db_offset;
+	resource_size_t db_offset;
 	resource_size_t dma_ctrl_bar_offset = 0;
 	resource_size_t dma_reg_size;
-	int count;
+	u16 ll_wr_cnt, ll_rd_cnt;
+	bool has_ll;
+	unsigned int i;
+	int count, ret;
 
-	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
-	if (count < 0)
-		return count;
+	if (!pci->edma_reg_size)
+		return 0;
+
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
+		return 0;
+
+	ll_wr_cnt = edma->ll_wr_cnt;
+	ll_rd_cnt = edma->ll_rd_cnt;
+	db_offset = edma->db_offset;
+	has_ll = !edma->cfg_non_ll;
+
+	count = db_offset != ~0;
+	if (has_ll)
+		count += 1 + ll_wr_cnt + ll_rd_cnt;
 
 	if (num_resources < count)
 		return -ENOSPC;
@@ -909,6 +952,54 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (rsvd && rsvd->size < dma_reg_size)
 		dma_reg_size = rsvd->size;
 
+	count = 0;
+	if (has_ll) {
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+			.phys_addr = pci->edma_reg_phys,
+			.size = dma_reg_size,
+			.bar = dma_ctrl_bar,
+			.bar_offset = dma_ctrl_bar_offset,
+			.u.dma_ctrl = {
+				.reg_layout = PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+				.reg_layout_data = edma->mf,
+				.ep_to_rc_ch_cnt = ll_wr_cnt,
+				.rc_to_ep_ch_cnt = ll_rd_cnt,
+			},
+		};
+
+		for (i = 0; i < ll_wr_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_wr[i];
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.dma_addr = ll->paddr,
+					.chan_id = i,
+				},
+			};
+		}
+
+		for (i = 0; i < ll_rd_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_rd[i];
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.dma_addr = ll->paddr,
+					.chan_id = ll_wr_cnt + i,
+				},
+			};
+		}
+	}
+
+	if (db_offset == ~0)
+		return 0;
+
 	/*
 	 * For interrupt-emulation doorbells, report a standalone resource
 	 * instead of bundling it into the DMA controller MMIO resource.
@@ -917,7 +1008,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  sizeof(u32), dma_reg_size))
 		return -EINVAL;
 
-	resources[0] = (struct pci_epc_aux_resource) {
+	resources[count] = (struct pci_epc_aux_resource) {
 		.type = PCI_EPC_AUX_DOORBELL_MMIO,
 		.phys_addr = pci->edma_reg_phys + db_offset,
 		.size = sizeof(u32),
-- 
2.51.0

