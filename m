Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020080.outbound.protection.outlook.com [52.101.229.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E92609FD;
	Thu, 21 May 2026 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345264; cv=fail; b=n5azsrZf+CESW3EpOYnPCZq5p7J6dZavPjYiHFWUi07Vx7HetLhSZPE2t96erigXMm3XML3/ctS2bo77cAGXS7Q6RHkGQNAh4nQo6sJBG8zzFbZ7G0XGWftucroTfhvkVSW/W5HMB/ERFF2mAxnvmNLm9GHaZAXsRpIXC0wmbtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345264; c=relaxed/simple;
	bh=vLMDqujhuLBSYCbt4mXRavDUk2/H4KZrbA++LE/47PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E3lPT5yrdm08ZQn8oYN9fcukQXw0nwUpuLjP1Ims3vWeKodHn7NqNlYFJL65xBO5avktgEc/ndwKGWR/GK12Xdp+KmzkLT+aaH8NjcT6woFSgrD5gNhum18+Pa/K7gdNW6tqo4x2puqTIgo1UR/+blLh6zP6n3qNgnvJi/JJW7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SqOQ8dKM; arc=fail smtp.client-ip=52.101.229.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SqOQ8dKM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXrsWhcqv6tAtVx2FPjZH9u2k5qRMS7JHc4wr07XtsP9PeWCMEfy3R+7sWhqswalRXXv7u/ldUofp3w9rDyQxn78I1rXNNCLrA/aZ6ebUGMd3C35Py2nlGCqCIOcdTxIQvaabJ4O7H14fKtfypy32A9M7ikltJizvZ8wA3+z13gmjm9shH28mWfWyLDQRf2gKpoqoDucK3KxkjLps62UbpZYM4pzxx5j8b7iz7BYBA6fDclbzUZn5ngoJNc6tFAWUY74cq558xtN9+KXDrzZx9iooUWlH00biHPnbKpYEQaO5k2YduNLBBQOj527OmXqfSP/rGU2tkdkwglWF26IRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL2Uc5mVgWPei9n2IHq5eB4qtlXzJ/7joFaZM2lLHBc=;
 b=A57z7HJHimxsEad0CxsZxGm4ywuiQHS4g0HYMj1/PgODMKWCjhLw9fNZiP/h4ubfPXxNbcUgL6GEzTH3REmHMJWPfGCaA/Qf0G7W8EjguYlhjcCJ2y3TlczIiQ//8Z3gQ8qHNoUhVLcgzdRXH0Nmkzz9C0/Qtno5l7OvbRgp9cAqG4Islf+fKvui5lKqTC5A+5HATXfI0LDL2NX23i6lYZgmKEtww1VEXKFB1CnTGZsmDDfhD1I87L2GWDnV/hGAaQtzQiFZhIhScYwIHZltCTWnMGOZaewaEcImvF7cLWU/aFp5spJt3Ejwk1tJR2E3j47dCbBNotjyhU4GYELv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XL2Uc5mVgWPei9n2IHq5eB4qtlXzJ/7joFaZM2lLHBc=;
 b=SqOQ8dKMug1xvIkgyl9Qjl0/gB6nXvf6WzBl08/UuBNPFBjdd/C+J8RFUfdtCg+Ocs5NWuIMn8TvdK0LoIyqR5b8cE/hMMpBoi0Ap1HCXmGsfG6jxhbrElJzaiIi4curHzBZlqScwKPcddOiU0Oph3f5cguMyBt7gYpZgj8OGWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSOP286MB3955.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:34:16 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:34:16 +0000
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
Subject: [PATCH 3/3] PCI: dwc: Expose endpoint DMA resources
Date: Thu, 21 May 2026 15:34:05 +0900
Message-ID: <20260521063405.2842644-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063405.2842644-1-den@valinux.co.jp>
References: <20260521063405.2842644-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:403:a::36) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSOP286MB3955:EE_
X-MS-Office365-Filtering-Correlation-Id: 62db842c-753f-4d3e-7390-08deb702faea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|56012099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oAmpwq/jFv5HjPRHnZhEls5Ji6qFtgiHNs2ZWzuWpJh4KFELKWrJptNjb+wAZe+4X1P9RiCfHB0wiJX2y4Gy9LTm+IH/TFgEM8QMbZuzOQ0Z6x5q6xHoWkS/Cr0BfeFpziWd3RAmBs3AIZhGfBHcXbkOGweCi4EEzzeaJwHMte6UPx+MwUXEBD7JXDcI8RhHrtLIkgfUcZes2y9XQi+F7tcxSPxN++hGL9DcLpbo7emDDbh80ugs+jmST/x5tLpJsr+x0ml5BT3VuBMckAj87Q+FvI3sqkWTgseaaYvZvcKYs6vFxqXGhvtPf7ltSN1aR3CSMrotsajzMGNJzY7hAUUWxJ2VaWcRoFKM4gPGlmipCdxubCcBXN2gBHPOFFVh/TR8NgkiDkwtUoMSKFe6XfoPNsTeewTbOXoupjifTH8GvOGGs8bYnfxdflO9xUyp9MtyJZ9+pud4h5RM2MBHCmOv+N5xc8wcWDcwTW/PwDxgsrYnULX7/TMkBeC/QsjZyQgJB3nHaDvZ1KWGGw1gkzrSdfFtAAtlfi4+X/RgNzOSCUuqoZkRTkx2vkVhvOiTGT982TSEfNxTdwcaZUbDFqruYrzvCUL3y9Z1Sa0NQSmHqkQRkx6vu1i13mBJqQKD5eD+UMDDtouaZID1WzqShl7G3hEsAqA43O/tzfq/ZyzBCocHvia7UtR+hpZNoeXK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(56012099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lYq28/9dpapA1ZwjC6KpK2f6sNjFa/1cvwa++AMOTxpjnsD9zGdrJ4hBe4mm?=
 =?us-ascii?Q?NrYgwOqJZuxHXvItvfbeEeanXpaoZDdhWOzE1JtEJlr5EbFxNZebQFuL8Cjn?=
 =?us-ascii?Q?NXcmkbFvG3mJw3I3CeLIQBAs3PkVwK1n305fvvX5fzyCOaJpa5+vrnTgljNa?=
 =?us-ascii?Q?nl4GW0gcOI1nfGKELOTmH4oYK3MnGLGNGAXVPWamggIO902u+cZAHeu6kgd+?=
 =?us-ascii?Q?pV2GZ7RzyGA53E8Up4+vyuQxk52GwuYYOTkgPJP+AwoJDjg5rBle7bNs0GHX?=
 =?us-ascii?Q?Vjrjt7DgpNVmE6YPupgrfC6y+UZ849P7tukrP9Vug0AznajJoiXgJwxTEZi9?=
 =?us-ascii?Q?iXVJNuKkWP7cb21oeOJKv12y2El74+kwpr1YEMZ95c0KKe1ASUnQTuI27OZO?=
 =?us-ascii?Q?bJ/dhF6QFbRo7fdv2UORW/gara51h194vbeVSpizzT8i4Ur9j4ubnutYdCq+?=
 =?us-ascii?Q?pB0uLngGm4+SIi1hOGds86gORZT8W2eT2hmJ1Dgs03b3TjYH6/iZYkCayuif?=
 =?us-ascii?Q?ehHaxo2tt2jLlQSw8XN7mPAsn64x/eLIof+Zihi5P+No2TS8xq1iP37Now8H?=
 =?us-ascii?Q?cTSGVAtFB0Ua1/WNEbl2tdIXic2wsfhogC6JfLNOHU9xk/m/4xZiMvOpityR?=
 =?us-ascii?Q?bnK0FPbRFmrexJif5jhnBAaodFeVp/RIyygs2a+QGaCNRNtGKEk6ZZw3zzg3?=
 =?us-ascii?Q?jKwAWTMlLuDpsE1rT4gj2ajB41DqCZfl+FhhbjKgH1KlA2Xn7E1ESLeIACpF?=
 =?us-ascii?Q?pZLkMfIoAYRHhn6btjlxX00P/T/lftkyvj404VN2wazrr5jK9GljTRTzHQB3?=
 =?us-ascii?Q?bGlg7lFpcaNkvbIbs39Os7U+tGhhZfJxzO1c4elgZB9tRSdlB+chSIX11gnF?=
 =?us-ascii?Q?cY5aIq+HfanNCBX/7jJJiO1bkRuFZ8xFSFk253gZ9WAgYhYU1Njjth577XVA?=
 =?us-ascii?Q?XlEAXJPsWYRuMUVgMKV+4oBKPH5r63rzdJwdRBBpEROqHet2f2yATAFjUKVW?=
 =?us-ascii?Q?tV4II9pdRoR0d/1IsI52cjzmDJBb34MTySbQ18yZXlM3Lges1VAXexufudqM?=
 =?us-ascii?Q?+kRfWp11oSXYHeYDxLzhqk2Rr0SNk3V7hJCCHSt3QFI/JDxmA/42VTeHd4WK?=
 =?us-ascii?Q?jpcHdBPrYSFbogDLMLsBEMLpRwjNmLoPr321EuFRbY3iRydiDCxLQnKuiiOK?=
 =?us-ascii?Q?9oC3GcaN+ILsPDIDB1NPZbkObWJAaVZL5sHR3QDr15/DTy1A+Wy2s29KWB11?=
 =?us-ascii?Q?whGpr6l3Qb5yA73w8pMO+RMqNJYtUZa8sLIAEJ+D6WiLk7N4ThUIYed/ALqJ?=
 =?us-ascii?Q?Mwe/T9NAVUnIHyx00FGaxs+h32I56RiTvex3BrWDDWMrTF/HoTTnKxtMRjdw?=
 =?us-ascii?Q?Zqozh2puNf6sgTgRZaufzTrKIEvzbX3Yh5KXIDMlD3+95Ev51zw/sIm3hl68?=
 =?us-ascii?Q?3sE1UPj8WUMdRn8cQweqH+6rTI+zrL8Y9BLQkZFGIIv5OGpaOBjca3U1ghza?=
 =?us-ascii?Q?XNYupfBd22VDJO07rJt4RdAVG94XElNEazasThA2mnaiqdcR3k106YDpaDxP?=
 =?us-ascii?Q?1iwECzpg777v9F5kMl1MWHTYYVuuaPFOpLZ4lOCDxbBRy6eqwUyD5GHNjY1P?=
 =?us-ascii?Q?+nKYW5dgV8PXJ/+zPTOSXei0MddSHayZ2xkYpra9DWfU3I9hjZRbUscVbNZQ?=
 =?us-ascii?Q?qISa9DMdG9ssITWSxdwsAlVYwJIVzaI9cCPT8RVWeoc3yVDT+/yWh2beIsRe?=
 =?us-ascii?Q?4OvpdfURw6v/LIdoBhAwo78vW7AZ60LZnn3UouUr1GftQcs6gYBl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 62db842c-753f-4d3e-7390-08deb702faea
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:34:16.1517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9VPldXE6fbrZDbeU6qDIYXs3qpb+sOoz3A9nS+7rfmek1xS++4d1+XsTTKI62sjN82b9ihqKRUqHga36FaF3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB3955

Expose the DesignWare endpoint-integrated eDMA register window and
linked-list descriptor memories through the EPC auxiliary resource API.
This lets endpoint functions decide which channels to publish to the host.

When the DMA register window is already visible through a reserved BAR
region, report its BAR and offset. Otherwise report it as a normal
physical resource so an endpoint function can map it. Descriptor resources
also carry the local DMAengine channel pointer so consumers can reserve
exact channels before delegation.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 77 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index e4c6f7193495..155a2287363e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -866,14 +866,26 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_edma_chip *edma = &pci->edma;
+	unsigned int i;
+	int count = 1;
 
 	if (!pci->edma_reg_size)
 		return 0;
 
-	if (edma->db_offset == ~0)
-		return 0;
+	for (i = 0; i < edma->ll_wr_cnt; i++) {
+		if (edma->ll_region_wr[i].sz)
+			count++;
+	}
+
+	for (i = 0; i < edma->ll_rd_cnt; i++) {
+		if (edma->ll_region_rd[i].sz)
+			count++;
+	}
+
+	if (edma->db_offset != ~0)
+		count++;
 
-	return 1;
+	return count;
 }
 
 static int
@@ -889,6 +901,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	resource_size_t db_offset = edma->db_offset;
 	resource_size_t dma_ctrl_bar_offset = 0;
 	resource_size_t dma_reg_size;
+	unsigned int i;
 	int count;
 
 	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
@@ -910,6 +923,62 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (rsvd && rsvd->size < dma_reg_size)
 		dma_reg_size = rsvd->size;
 
+	count = 0;
+	resources[count++] = (struct pci_epc_aux_resource) {
+		.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+		.phys_addr = pci->edma_reg_phys,
+		.size = dma_reg_size,
+		.bar = dma_ctrl_bar,
+		.bar_offset = dma_ctrl_bar != NO_BAR ? dma_ctrl_bar_offset : 0,
+		.u.dma_ctrl = {
+			.reg_layout = PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+			.reg_layout_data = edma->mf,
+			.ep_to_rc_ch_cnt = edma->ll_wr_cnt,
+			.rc_to_ep_ch_cnt = edma->ll_rd_cnt,
+		},
+	};
+
+	for (i = 0; i < edma->ll_wr_cnt; i++) {
+		struct dw_edma_region *ll = &edma->ll_region_wr[i];
+
+		if (!ll->sz)
+			continue;
+
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_DESC_MEM,
+			.phys_addr = ll->paddr,
+			.size = ll->sz,
+			.bar = NO_BAR,
+			.u.dma_desc = {
+				.dir = PCI_EPC_AUX_DMA_EP_TO_RC,
+				.hw_ch = i,
+				.dma_chan = dw_edma_find_channel(edma, true, i),
+			},
+		};
+	}
+
+	for (i = 0; i < edma->ll_rd_cnt; i++) {
+		struct dw_edma_region *ll = &edma->ll_region_rd[i];
+
+		if (!ll->sz)
+			continue;
+
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_DESC_MEM,
+			.phys_addr = ll->paddr,
+			.size = ll->sz,
+			.bar = NO_BAR,
+			.u.dma_desc = {
+				.dir = PCI_EPC_AUX_DMA_RC_TO_EP,
+				.hw_ch = i,
+				.dma_chan = dw_edma_find_channel(edma, false, i),
+			},
+		};
+	}
+
+	if (db_offset == ~0)
+		return 0;
+
 	/*
 	 * For interrupt-emulation doorbells, report a standalone resource
 	 * instead of bundling it into the DMA controller MMIO resource.
@@ -918,7 +987,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  sizeof(u32), dma_reg_size))
 		return -EINVAL;
 
-	resources[0] = (struct pci_epc_aux_resource) {
+	resources[count] = (struct pci_epc_aux_resource) {
 		.type = PCI_EPC_AUX_DOORBELL_MMIO,
 		.phys_addr = pci->edma_reg_phys + db_offset,
 		.size = sizeof(u32),
-- 
2.51.0

