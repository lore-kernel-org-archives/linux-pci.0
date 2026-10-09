Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021123.outbound.protection.outlook.com [40.107.74.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9883C3F6F;
	Fri,  9 Oct 2026 05:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522011; cv=fail; b=V/GdC9WXU1gjDDgWxxU8qU9erR6HwEkcePoZd9lYE64SEcfkf30FSuUP52/G07JTBmOA7+Pk3IqOe71wuMvnfuX5EBXQR2nn1cW2duRybFBS9LPvRGeXCh1W1Qv95u5gObPwHxxKU5z+/ILI/88j1v/DBVfhBNIuQG96WOPvvEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522011; c=relaxed/simple;
	bh=8H7aYfRfQrCZKRnv2fABWMJXSda+t/vbcp0yzv75YuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A7qIwdicScWxeVHPZQ6hzHoy3irDvq9/X//toa+Qws1N3naG1CLyLjY+oULnwDW+RzHZWZ0TaYScXKpxnH2MDyBnnuQhp0jwvXjYqq6m/TNFo+WNMdC1pegZhG8x2UNwEoLFqsRlZxOkK9E0YK0xU4kNdN34fSRSuGJN7JOvISs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BZjKq0w2; arc=fail smtp.client-ip=40.107.74.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BZjKq0w2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/5rw6G3TqBVGImnisqLh5KPuoe1vWbOOTH2MrRBYEQfbXFpYCn7L904qKNw1PtWpzwXEH4ozFLr9WW1JsW/o6GfWHvX9CLv1yb7JMyn8QZgjJ2Sz2Z0jnAeRpjm6KTx5s9BYdFO95t+nN8Qf8nqWA7DACyGCutKGdiONSlWKZXLtXsN3e6FtZT7Isn8Z5/NJhCbWEH5R9/9Biy9GV+ohOCIBPrd3RfjchDiR1VZaUQb4CpI0oyHHYssGDAsnKlNZTYgWvgKUEokhetoygOuAx7c+Fw/wQk1cgW8Rlo4boE+bCyNWrgGdI7WpBVTxSCI4vGZYWXCqMQfXgAEwdX0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4APyPyRfVrVmOlSK6BhewjzpcxQzN+8IAJ9jZLE8SKY=;
 b=MefmIcY2HmryldwmDSHXZoWw38EE9lvjYJVcVMGrcBiDMni8VVrzyHc9HpNZ0bo3UglcYTI4e9t66aMe/o5plZwVfofsPeeTBkotVIIZIRvgOMaRDcwoPt4ub5RGFMIGbDzDu9qbDJ1owmdELX20mJNGFfm5nrowrEjUMNepzS2q6DsqhT3IiyM/oDPAj9SBFMb7VB+lXqBu6xPp2uq92vfxj6zyl85b+SBxxl2OsEwCQwOXL8M1xlFPCfRfHn0S6KhhZHNV/08bseIzR8FeefNps7QRKFupHXXhblnp774kWQ/w1JUO6WitTe4NhDYu/DClKfynByIfFDMmGT9+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4APyPyRfVrVmOlSK6BhewjzpcxQzN+8IAJ9jZLE8SKY=;
 b=BZjKq0w2kbr3ZKfs29bNxRTYyuyRJwtv04jue5HqutVXIJpONudzxAKQs/F+pwrwfPeTnRnATEGlLMKM2WhuGfq3SJrDOFQlZwMJw5isG/V7BTo/APRKKKEtD5XrYhqp5WvO6Uw5OOC/fyWTObJ1pU//tkqfWOmqfZAEulfqgeI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4369.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:309::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 05:00:07 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 05:00:07 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
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
Subject: [PATCH v5 2/7] PCI: dwc: Expose endpoint DMA resources
Date: Fri,  9 Oct 2026 13:59:44 +0900
Message-ID: <20261009045949.1109871-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009045949.1109871-1-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0300.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d42af82-789c-4ee0-b778-08df25c22fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/kwTzhFHnbwmiw0ZryOxqGHGsbt7y3puyPgwOqz/TT8JV09LDiN+z0dC6e+ptTA5Wkw2VI0TmqUFPBzLjeDflbf9MzukEMf5Ww+UtK9w+mMsN3CEMXPtXF38WniAZy2vgSSAzR+CbnwPaEhOP0jgPfKr0omG3tEtjINBjPrm3/XNPYBPbxoiDUJia5ZkSQIYSY5GUNJkrCIK903zBugdrpYc8RSr5MbntsbaKoWKlxyTDx5/0t1Zhr+rw7YfI3e3nmScnNfRD29ReHu7cZiLFpiMKkTm8RpJyQh532IMNabMHnjYTvGmrdCSLrGI6nOutheFtYSh3jHF/eUv0lbctg9xJ7YBFcpha1jTX5bOicEjyhEK41WdC1iSAgKYwR1fG8S19yWjKh5nq36QdvyxvX1A5aWf0bSvX/D0H/8Dhm3kqVz36jN2KAdvL9IhtfgtxjNja0zYX8uvvMxqmF6a3Bk7BGVJSom0U3W/pv1rQugmvaJlJQwg2cegSE8TAb5HrpOJT8rtNtF676YAf7NaUWvRryQSVQp9l64PHwAUtr8fAOBar4VijQgpgcHpj2YVVgYdh4MmXZABjmyvLA5IzXAT/0miUVYzp4U9mvLSG1vrQUxFMClJbSltpqjs6RC/rSDs6ogo24rHSD2rrWnwOELrnsGxT+R/QkbPlit5t0s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?35VWh6UK0B7NVUVDSPaQb74vvttldgzxFbIBDDTtG+TUVbFoS87MDBN3MLKE?=
 =?us-ascii?Q?zoTyghUSgoHwRQAhAbQ4hVr6v6e8Mwb91BYZaVGr8s3t7sYcJv3ONDiiewbj?=
 =?us-ascii?Q?Fq+jsxP6LiIh0FEFi++lENrYddIm1pfyV75sNuuysS/4ApYLyJAs7YAJ3V83?=
 =?us-ascii?Q?Z1I0Dp3P4nllC8fmljIhCUCoKtcwd1DfWIUjP1Tk0Q6ndzbVcn5zcf1iVcNg?=
 =?us-ascii?Q?Xu47OgvmrlH0cQETa8IatdZZ0MxmqxW41kqvFE6ca3dKSoTGISjjYxncuF3c?=
 =?us-ascii?Q?rA2OLudesBe4OiK6/XB3zylKYsrY4pfVYKoZzPWX0xMmsVpcYOJokoQM6xS3?=
 =?us-ascii?Q?eCrNmFWsIyjst5F/gQsp5n4JwHSYABJUtiep+6yRva/GFpLbkkJoeYJxOaVT?=
 =?us-ascii?Q?lZaHFYeDO9x7O3j9F73DlQtfpKXqd+e8KZoktCnbOP0Y2p2MRNf/LZDnJTcq?=
 =?us-ascii?Q?jb2SZ4sfukbBBVijAQuNJWrxrCIxqChWWJEzjkWr+To4vHP4m2W6quKxIKuP?=
 =?us-ascii?Q?Kt61vFenOrK/A4IGwL3NeHtp2IGAiA91e0iAOvxaEV5ivAJdot0YjD6PteF/?=
 =?us-ascii?Q?+lvUh4v5PxGFvAdj4iBZyJy5mVthkTRJ63ImAes/mkgGIA74wyaYShX3efx+?=
 =?us-ascii?Q?PDat47cFR8hsLM4rOp8Lp6aREHQ4rOckMVTkCGvkBVBTY6dYpn4eOeeOhr33?=
 =?us-ascii?Q?zGNTZAj2PxtoaFJTL6S2ouauRzHw7uLSPN7n7RWVxf9LhHMrNWHRf8qbAXfY?=
 =?us-ascii?Q?aKIuHaPvBXfi1j2GUwUXGzYy+l6F4mYot+vAGaCmrn8J0GdRkXrZTweWNw/x?=
 =?us-ascii?Q?7VW7ie5rQFtoZpsKm+qvr5ZSWEkHe8jIilgtDfFJj9UpAlFBDY34vdqMpruD?=
 =?us-ascii?Q?ExTzs6ph0eg5NJLir5dsIL/RCsPP3NsIUKEu2SVTzIUgUvJ5ZaxuP2F+jG8b?=
 =?us-ascii?Q?NjsOMCrCBCekBoROypOqc0qmAbcgOJeSwiS2ugSWBUXB6e/1Oq8GwvCJOu/g?=
 =?us-ascii?Q?ps4XTjzbaeywG3HagLfmW+lu3lorn5hhYXTPLN+qQRfJfa9ztQllncqwBbXZ?=
 =?us-ascii?Q?dIcaBRjlCPQqfj8UTGoeKfdf96CghHu4Wa91Y+xAyPDa1ubZsRHRTXTkSRcj?=
 =?us-ascii?Q?zGIbxgc4Ew1BCM145MTtnVcinl8IL7fa8c8ORRH24ljAqGk/rDWBVmbIw1zp?=
 =?us-ascii?Q?KH3/eihMDouW1L8vYaa5foHy4w3yMjSrX5oI6tBg8OUgQ6q+agh7ZLR8nJzb?=
 =?us-ascii?Q?Rx0D3OMIBGGOs7faSEMiOwfy+GSq3Rshdb1AwhdAnR/H4pK6/lsLzDI9g30c?=
 =?us-ascii?Q?WUfPSfncJE3b8mLZQbPcXSHt0aQa52wrRQi5r5UTQJkBz4mNVCXhFglxTop5?=
 =?us-ascii?Q?4FK2nbAsKyjkf1zOp48I0mbeGl4gei9uMcrAI1GsuMyJBeECi08gTbVRd8iG?=
 =?us-ascii?Q?wP7UwtqIKkYcgEwGG7oD8Ym69IDY25WF5TNtZ5mfDFTtRNSEdqSYYIqFhuY0?=
 =?us-ascii?Q?GZgTqTrBT53IT9o0dF77Wweoe/KFLWgbYWBW1tIi5N3Ai03UMdE1StEU7qK3?=
 =?us-ascii?Q?5kUxeSgIV7kpQL9YXGm3qGhFDK1HqIWff4+8d83sPuh5AWoIawS7oI5rrHRB?=
 =?us-ascii?Q?qPpdOWnbw400VJx9ee8v9Xeh8kClw7VYhp4Q9ucjIb15OIZ+hxsmsdt9yJTJ?=
 =?us-ascii?Q?PQtbpiRyDRcdU710pCJyAfRM2aDqpfOf+jMbRBwNx6H37MOSAAi/56WTkSfo?=
 =?us-ascii?Q?Wvj2yPMfyimmltHsbzRQrN29Mimd+2L4pswxlId94/33/g42sU8I?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d42af82-789c-4ee0-b778-08df25c22fb7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 05:00:06.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vm4Q281mPdWUGPS+A2wyFUO7eIz55L7KxUFOTTbQPc2KnU7UMNDXsJeZ354DHdepaQG/l0UVCxXQwOpsOCwOkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4369

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
Changes in v5:
  - No changes.

 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++++++++++++++++--
 1 file changed, 99 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 6c18579466b4..2b2988011c3a 100644
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

