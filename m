Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020124.outbound.protection.outlook.com [52.101.229.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B2301719;
	Fri, 17 Jul 2026 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784264811; cv=fail; b=K1o/kE7WSyq+qlGsRc9DBK3ce40UefJp8JiShmn0lQYCGbJZhPvNmAHLtZDOaU2Z0ar5lfGg79rEXjAkdDGz9C4HJxvMOVC8Z2I4UrChQR4LrZARFNV43lATb/ac6BDcW9Yh7JvChJph5QCtW6O5a8Saw1ZUoO+0sTCm1ERfcNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784264811; c=relaxed/simple;
	bh=ueyc/KQC/O8k8+V6uZ3tVLwX5I12h7CY4ohmzZWQ58M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CGs1Fq2uIR2Q5WdYFoE29ZV57IJEWoP0KEOA5kcuuSyi3IbiAgNpxieW62la9xj2Lta7Rx8k4RCbuM31EGNK2YvSQ8/h0ZAlPS2Zb6I2Ye0oMlsAxTR7S/ZkVn9Fjbk1Ipf6YPuQnMSJRMsYIZl9Ai3j9NOIc7konsJOriLRteA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=eZFGt6Tk; arc=fail smtp.client-ip=52.101.229.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="eZFGt6Tk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRQgWIfpZQs4zwZsCNq1qT1iyjkjP0G5Qdu6XRGhcPAIjErnn9L0hK/LSDtp87W2mxXraMfAoBgHFQRflD1aQmv48imFtgKlaoAMndkylwCMh9U9hG3PLUn7Pltesp/NEQ2261dIriX1K37bcUcgmEJccGw2KNRMj5RnpGlbObEmhxFjTp4FAGUqaKvxT3N+oIfQJ8OoIglCuO/dCjjuBi2xzhTb3jnJdevXS7gWGe/Q8BE9qPvb/aZqQMpIhFWcPs5hN8cmtrthRwvqYHzbJ4UV1160HagqNkOOk0UyyoxXPP5biyhyS3v2YHc32ZIYZVVaVdcz+P2fXzI6B0OLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6LZX2zcuUY4KyHDAduPaXio8BND2VDuOnvtHTRJJgg=;
 b=FDXaJCJGWbGvSrY8so7jRzhO0Se5bZZi34rqjhgtNUUVhrddBuy0z0LnuCTw2aKfOCAWSSywt6aPP3KmzyKsnzT+Djx+vKq/+nODN2Z4Kvpk0ksyITJh1ftcfJTBNGYbd3Ab9xltqoPguUDURnJBqkc6NFYMnST3PNUVhQd59U0QETb6lW5EnwAREy8v3ZXaZA4BRgn4pLvZx+qVQT1O+KxTHsEG2Lo6L6diUeubrZUNo+g6UID2lFCiqG8Aq69GkzaLn2MrwDtEXX/3Curl/MT9thPCD1nW4Y4nP+gckNVeJf6MA2ptvz++C8DcORRyu06gEMVlHBM7eoVbK7ECew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6LZX2zcuUY4KyHDAduPaXio8BND2VDuOnvtHTRJJgg=;
 b=eZFGt6TkAjxW+cDxB7Ay/pODDqj7eU03490PiDHoLlOa21csjQohDHlFElVycy8fC1gjGSma90oI5eNBLSxB2cb8ZHqP81QnNU6YdagU1quT6Ri2g6PjkHq+05AGSDMQmga9+0nSmoVHKioWCsBedSJ7BpFEmuY0z3ms6RW8f7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6910.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 05:06:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:06:42 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 4/6] PCI: dwc: Expose endpoint DMA resources
Date: Fri, 17 Jul 2026 14:06:33 +0900
Message-ID: <20260717050635.2145014-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260717050635.2145014-1-den@valinux.co.jp>
References: <20260717050635.2145014-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0079.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: d84e35fa-7ea1-4969-733f-08dee3c130cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|10070799003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nsWeGP+uuUspApWQ4FnN/cmOG8BAlwR1eOZ55qTiA3LZ+wVma440YsiZgJdPPpiznM+XLpHjHaAvi6GRfKFPC90z5yyInoFjLVFtY86NUgmq1wgffYfRtdKvemy8xyMKvLsPhbzC3fSYvU6Gi1gTI08vZz1Ln73Sk/DFuSctp406ulAHvZjd5ryhXY683y6648x6swkLlEupJrqhy9AXLogGW94HNZBht9XiyMLE6OLl7I7hHqpWS6Ju/TBAndJ57YK61sBwF3hA5C5nKLLRlagdnd498EnD24ql5PSA089irM2fFmtMMvX9Xh+x8lVGRialsehLbOj2qEft/PdfnpB/R22HPbRJU/u72zNSHqEK+b2fLyS56HEg3n4tKlDNEt7y+X+GlkEvlvLjskGKBwLCCO0M/5B2XehikX6Dxfakktrl/ozD9R4RCA1yVgBXZpUjFAN/bZdCAAqdocF4gxpyXygoI1Pe1JvkS5UNSF4IpqOrqpsFEPUa+v7nrK2qG7RMo3GgdygHa+fIaLaSXD7X6Y7JJDf5z3J0BXyBFewYYx/jUyP70CPeaClznAY+TGSwPgabCgvejydK1VVJ70ooLVQu6hpDLUtkPrxc9rZZvMbPIjijhN9HpthkdZ3UF8BsRYE4zt8FZfG6VYhqWyT2ZmeTLsitoohFXgyE7mA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(10070799003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FCIE2TJB60vyFPv4zyW1zZA4vU4vaScxXr12IPH/R4sbTXA5ApsbTf8q0l/r?=
 =?us-ascii?Q?b9tnDN4jg90GXoXqAopcjUmhpjYtqcHD9GLkEoVvfEQ0hftfySUDYufnsnW6?=
 =?us-ascii?Q?3wd83iOI6YBiy1q7eInaTPy86iwHWoQVADKY3ISizSKH6DITv4OXqx/ltvjx?=
 =?us-ascii?Q?pTia1s0XwxZd9RWRqOOJWcAcVUZiKMpX9FMW34lnK6KuT3QXIN49CIaJGliJ?=
 =?us-ascii?Q?hSLfmfKeE0zl52HQaOx1ILE11PQ3Zkvii4ZNFJnaWNK23nHftZQM0D2KXVEn?=
 =?us-ascii?Q?tsEdl87Ro+/AeBup9iwgoNITPJ5CMYrz2x7pruZ9ZmcZvYHD64olepWlbnz6?=
 =?us-ascii?Q?MvANCL5+EqJrIGbMmdAXClPFpVXNlf+/g9/3luUWAUXR0mQ/J7iuQpR8pp1U?=
 =?us-ascii?Q?VnHwmosRAe/d9HgWsFNrXagxCIeCvx0ugrF0Ru2rCE/arQQ+xz4rJmqu81Rc?=
 =?us-ascii?Q?g6rjJcAX22rcBB7NkG/P0vmp72dnxC6Cd6dXVed9d5K82JZkw3JmTxe4dWIP?=
 =?us-ascii?Q?3XziUdSaRfI6VfQi4ZPk7tRyab5XwrbJ64rvdjn+vw7i9nNnbv56YNd1ZsZj?=
 =?us-ascii?Q?Vp23V/NyXJwe3qypquclxDBhSdT0Wej3KUmVCUBG00bEvGhw0ZHcWtoyhJZt?=
 =?us-ascii?Q?pGS8MN71GQM13bjt1177Q/U8V1CP4RJMEfVDLvCAdRe97/A730oHa4CmfyFY?=
 =?us-ascii?Q?fRzoP8shBf/fr1egA+prKywumj2hEdsvysDlM5F/LxbtvFZdbBk/Dmsq2f8i?=
 =?us-ascii?Q?uJqXkOlxLBMoDwjMIh15POuZeajIAef0G2816CmQ0yUe41OeNww4CZYC/6mQ?=
 =?us-ascii?Q?TQkleaXgMdH+jeiiGglpR9mkeGPmM2pFUSJY64Qn0h0GimpEv3IHWM08uttU?=
 =?us-ascii?Q?ou9rn2hGuyNSUceICe72pftTAjWzzHK332itHAY//aQzWHiv4KKSlCmycQ1A?=
 =?us-ascii?Q?ewCfU6XojYL2l9jrCpeVM1TXPgUapwDbP4lnTHAmyK8966JjzuEc5PuJXYri?=
 =?us-ascii?Q?yLIS3uSJIJXyi6n9JOmruNSL2B8cgh3ILeOqdSw6qayKuTCzpypVHt25Khin?=
 =?us-ascii?Q?JAE1vLbpggpjq28Yo6R63wUX3NY8FTWV1ZTxMXk+P8gNEhdFawYkmfaw0zWy?=
 =?us-ascii?Q?yAW+O2e/2OcBprzOSvzVfXcZpEMxUEUxUgzCzdRJywrGI5u+c0zfnBkB0dno?=
 =?us-ascii?Q?VBYpAWHqFC+S3Fsc779YAwfQTYZdOs4StY9rsYClJqp/K4J8d6SNiQD3kRhF?=
 =?us-ascii?Q?Qyrb1MoFk6UErLaqP8cuYyS83v9HaexNtQofwkyRPOSqLiy4w7xwu6/18j4w?=
 =?us-ascii?Q?rPzXuiK/GtH+u8y5arJfbIkbjSc1OI8ifWdHewDdnQfc8PfYi6VuYYAVlgeP?=
 =?us-ascii?Q?QEOd5JShzDiNNr/0dtvN8I1ebNwzful8AS9SXAnRhzyqqqQAjhik1Zr88HKa?=
 =?us-ascii?Q?TuzBOHIOr3Q8foLr79V8u4w2lBEcIAOcyfubT+RY0mK2O/l+z5LS3uWBn+sN?=
 =?us-ascii?Q?dFX3089oSbs20rJJo5s67LQGgXP9Suj7dJl92vvRkZk9D1Y15jRWYl/EGg2Q?=
 =?us-ascii?Q?WDK49lDLCyR6QeDTUaz6xK2xQ7HU6uiLFefE35BIuFVQy80TfVkHDTOqHhzD?=
 =?us-ascii?Q?/Hdh+fqJPbwsf6dMEmXFssHNYk75qR4UHK/xuMTsAlsmbTr+OzMlLBhyHsEC?=
 =?us-ascii?Q?y92SXuwbzg4O1ApIvl3/WLadL0hqQ557b4cVj72Rnss/RAPV0g8jZyS+cy2w?=
 =?us-ascii?Q?QgfkfrpOR51VsM5M+RTHKiS4g02HzNek/Tc/8onA2p51F1kexZoH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d84e35fa-7ea1-4969-733f-08dee3c130cc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:06:42.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kS8rpUNi/PCRmwy8Z0qLbX7ZzSWwwHT6wrZmt/i/HK29Np4xRs/xDSdjj9mKY06wuZXmb3Xrd7kEWtjMCGo3IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6910

Expose the DesignWare endpoint-integrated eDMA register window, logical
DMA channels, and linked-list descriptor memories through the EPC
auxiliary resource API. This lets endpoint functions decide which
channels to publish to the host.

When the DMA register window is already visible through a reserved BAR
region, report its BAR and offset. Otherwise report it as a normal
physical resource so an endpoint function can map it. DMA channel
resources carry hardware channel selectors and refer to linked-list
descriptor memory by ID.

Expose DMA controller and channel resources only after the local DW eDMA
provider has been registered, and only expose channels whose linked-list
descriptor memory is available. The interrupt-emulation doorbell remains
reported when the local DW eDMA provider is registered and its offset is
valid, even if linked-list resources are unavailable. DWC non-LL exposure
needs a metadata ABI and host parser extension, so leave it unsupported
for now. Reject VF auxiliary resource queries because the
RC-programmable DWC eDMA/HDMA register window is assigned to a PF BAR
only.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v5:
  - Keep reporting the standalone doorbell for a registered provider when
    linked-list DMA resources are unavailable. (Sashiko)

 .../pci/controller/dwc/pcie-designware-ep.c   | 120 +++++++++++++++++-
 1 file changed, 116 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7d2794945704..ef1e2b6d85cf 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -858,6 +858,36 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
 	return NULL;
 }
 
+static bool dw_pcie_ep_has_edma_ll_resources(struct dw_edma_chip *edma)
+{
+	unsigned int i;
+
+	if (!edma->dw)
+		return false;
+
+	for (i = 0; i < edma->ll_wr_cnt; i++)
+		if (!edma->ll_region_wr[i].sz)
+			return false;
+
+	for (i = 0; i < edma->ll_rd_cnt; i++)
+		if (!edma->ll_region_rd[i].sz)
+			return false;
+
+	return true;
+}
+
+static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
+{
+	/*
+	 * The DWC endpoint databook says it is not possible to assign the
+	 * DMA/HDMA registers to any Virtual Function.
+	 */
+	if (vfunc_no)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int
 dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 				   u8 vfunc_no)
@@ -865,14 +895,23 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_edma_chip *edma = &pci->edma;
+	int ret;
+	int count = 0;
 
 	if (!pci->edma_reg_size)
 		return 0;
 
-	if (edma->db_offset == ~0)
-		return 0;
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
 
-	return 1;
+	if (dw_pcie_ep_has_edma_ll_resources(edma))
+		count += 1 + 2 * (edma->ll_wr_cnt + edma->ll_rd_cnt);
+
+	if (edma->dw && edma->db_offset != ~0)
+		count++;
+
+	return count;
 }
 
 static int
@@ -888,6 +927,8 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	resource_size_t db_offset = edma->db_offset;
 	resource_size_t dma_ctrl_bar_offset = 0;
 	resource_size_t dma_reg_size;
+	bool has_edma_ll_resources;
+	unsigned int i;
 	int count;
 
 	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
@@ -901,6 +942,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		return 0;
 
 	dma_reg_size = pci->edma_reg_size;
+	has_edma_ll_resources = dw_pcie_ep_has_edma_ll_resources(edma);
 
 	rsvd = dw_pcie_ep_find_bar_rsvd_region(ep,
 					       PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
@@ -909,6 +951,76 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (rsvd && rsvd->size < dma_reg_size)
 		dma_reg_size = rsvd->size;
 
+	count = 0;
+	if (has_edma_ll_resources) {
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+			.phys_addr = pci->edma_reg_phys,
+			.size = dma_reg_size,
+			.bar = dma_ctrl_bar,
+			.bar_offset = dma_ctrl_bar_offset,
+			.u.dma_ctrl = {
+				.reg_layout = PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+				.reg_layout_data = edma->mf,
+				.ep_to_rc_ch_cnt = edma->ll_wr_cnt,
+				.rc_to_ep_ch_cnt = edma->ll_rd_cnt,
+			},
+		};
+
+		for (i = 0; i < edma->ll_wr_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_wr[i];
+			u16 desc_mem_id = i;
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_CHAN,
+				.bar = NO_BAR,
+				.u.dma_chan = {
+					.dir = PCI_EPC_AUX_DMA_EP_TO_RC,
+					.hw_ch = i,
+					.desc_mem_id = desc_mem_id,
+				},
+			};
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.phys_addr = ll->paddr,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.id = desc_mem_id,
+				},
+			};
+		}
+
+		for (i = 0; i < edma->ll_rd_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_rd[i];
+			u16 desc_mem_id = edma->ll_wr_cnt + i;
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_CHAN,
+				.bar = NO_BAR,
+				.u.dma_chan = {
+					.dir = PCI_EPC_AUX_DMA_RC_TO_EP,
+					.hw_ch = i,
+					.desc_mem_id = desc_mem_id,
+				},
+			};
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.phys_addr = ll->paddr,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.id = desc_mem_id,
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
@@ -917,7 +1029,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  sizeof(u32), dma_reg_size))
 		return -EINVAL;
 
-	resources[0] = (struct pci_epc_aux_resource) {
+	resources[count] = (struct pci_epc_aux_resource) {
 		.type = PCI_EPC_AUX_DOORBELL_MMIO,
 		.phys_addr = pci->edma_reg_phys + db_offset,
 		.size = sizeof(u32),
-- 
2.51.0

