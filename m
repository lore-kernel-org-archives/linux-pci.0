Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020118.outbound.protection.outlook.com [52.101.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D32D3A7580;
	Mon, 25 May 2026 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690703; cv=fail; b=sr3aAeRNA7YgabbHceOGfGBgk9Miyv/WlOvthi1nb5Gr5Y+5fR6DaiDg4+U+8u2JI+0AxdfSlGhMUZYYdON5+7NSgihgkMW4KAZr7ZjO3pYUtMETTnxL8l0lpUTEX0LvkiFxQP+thjd3ECHt9OHocmAAuZfwopIq9hUqSkTL1/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690703; c=relaxed/simple;
	bh=Ak2Fg5dGvLwYXOkaaH5fBk/3BtWR/xum+LOhL6Jt0Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JlYKH8ArVmMrVCI9MAkCyy92yhIL5oSYSmJ0UtWSu7ZzZuieH1SOYp0hkJE7j01X4uN8Vy2oTU0YflPo9yJcjM8fTpXonmlvJyDH5gElMYqbQtk/dtqB9xfJaLI3LxLE3PR/U8ru7rMaX47uCXpTE36uw0/eoEnRzrJDFy8tG+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GKJDrUzM; arc=fail smtp.client-ip=52.101.229.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GKJDrUzM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCDOCR/k2RHMdWV/ZP80qZ9mpZWEizTEBeQQfpWWDkv0O8ZPxDCD+BpivxopqQy5rVyULL7INMCEse1Vm9L4FsB9eXURtfUS6lHwHul90l1uZcTD+tIVxHYwcW8xDd4tYI3RyaPwY7hFf7bmryo+twB6YR8onNAQMGzdKL8MlrY5GFP4wwMRjCE6wmgMcptK5DE5DkewFhnwA7O41zSuD9sgZ6AQFExbNFQQDRlqmIHV6/CFrx/0/cd02if9dFZ2Uj6xMwcz0kp6fl1ZHA7Bz5tbkakwo0yNg7m039fI4/vFHePDjB7O6Rq/iI/HuQBki2mzTr4Yx797ZecanPpGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXjKSEX2kL6A/C/9hehgK9lcsuLgZV3vvVEm/J6t2EY=;
 b=N2VHA1P7q6yNayCiIt5+UpNb1aAf46mDI0dXkCc6iugOvIII1v95a8Dk9WZsyHtuKo4TvXf5W3sfOSItfdXIWwaX0W/FDIMf6bogeR5gKM95k3j91ZBdjxI4i3JqUlcJnvFmVgpS3/Q71+8WRu+ERsbZL6ksmPfYoDj0wjoRWXmxIfpsE/TpGjKmqzCwD04I1EH3qOJSG4w4VbIIbB3WEX9mouyxiEAa0OOvgoM7WWtW3ioy4TZwyTixJnIe0snwvNpnSYjxWe/QFQ9mE0OtdFdUd05mq97g0Cn+F+5s21skNSCdxmUNK69JyfHvQjr3PEa823b0WL9wtVWmhT1QxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXjKSEX2kL6A/C/9hehgK9lcsuLgZV3vvVEm/J6t2EY=;
 b=GKJDrUzMl2jaPzBUGwxVf0wsBf37tUI+81mII3l2T/Qf8FuD4yuYVhMicZjxzZWQfGebMeij/3/Uk611RvytEmbZHRgjTrX1e7jCe9DJVDa00qBju+OKVt+mie6ycTADU+hbhZhfFKYxzxTVgaPjiQGDchJdosGrJWOq2R2HgB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4607.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:31:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:31:35 +0000
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
Subject: [PATCH v2 3/3] PCI: dwc: Expose endpoint DMA resources
Date: Mon, 25 May 2026 15:31:29 +0900
Message-ID: <20260525063129.3316894-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525063129.3316894-1-den@valinux.co.jp>
References: <20260525063129.3316894-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: a611d779-4591-426b-e04f-08deba274503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|6133799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iljEplaHhHmq7MWyS6KC0ez2O6bYs/pVTzL/UZ674pI2UOUmh1+FyN3/uXgTr6/F7caI+5n7Hw7uZlvAjWAwDTupRkEXFd63XQBsfvZHi6whMCDvb3rxvh5LrtMZu6LLe9WSER0IWn+2wL9eqxqW6neAhMjXgyUQQx2yeMenaRoWygZrtCgIhwY/qAAjpf/xs3117kGaG/iE3BJT+0InpQKFrQ3pdzKUX/Uor2LtB71nvq+a+wJE1uQtUA96LUySYLyFTnvAZHkBknuPl/eOJgPgN2mf8fLi0Ovxxfi5W/7Dg+2QtNDoZKt2LZ5+cCaXHl1pkeOUFr3sWjnF1odfVoTjDhrUflIZ3Rj89wuL0vS8NO79HZ0YoFarUX+46y/Te8hnbbEDHYNboon1Pb0OkT2irPNDRFaw/+ug8dU1KyyX6JASpAVN49LzMXRRrNiwqlcO2eYqZ51IGZrMGFaGhMgWICseewupbX91SnsNYDEXHda1SZnOAFWWFRUeFeJGr5th8dQcQDBEjtfL59dLllqC2xO7Y/I08ujDQFw7y9WKOPpdWtNwlGa5leAwpUk2MeuD1OkRlWz5x4R/adR2kqgEtPIE28Dghjlug7GGb9caAcRHvmubyehRA7AaOTOsHwFwuUFBulZep4v8MoJoKidO20Xuei6M2iN2yx2gEan6hu80Ho00etATew9dOKVG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(6133799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GA5crAP0gEOx1PmEDwS5Cb1OKph/jt/g4yiktauB+BWuHtlS/PiaMGL8gr2n?=
 =?us-ascii?Q?ebAJrtJ0j0ZPYGWj4ieWUyXhIJZWUxVbGvHXDVB/24mPVto8hbUOlA8WcfHh?=
 =?us-ascii?Q?5H0Tq0NzIsm1dSGGQUY209KyRAMsM50wS2p2I7SRH3Phkg5SRrnb9mvDqfVQ?=
 =?us-ascii?Q?2E1qEJgermaEeqDgeRp6Te1coVXbVvH2KM/Lz7uBPgv/IIqQga7vzfrlUwbd?=
 =?us-ascii?Q?XcAhu1GTQFX8WbKJC6ITkPQ8RV1tDxQeNhyOs7vKF39YHPOvxyVDClAqwmV1?=
 =?us-ascii?Q?x6/7g4ZN5aQcamhSp5kGM1ZIpb2WFbW6hWA6nPZUtts0b9G8aXs3xAxElcQ+?=
 =?us-ascii?Q?Q21z1DrqtgtsdBFR+oHNNiRJYQRn5j8hJqTii66kAxNZ9Gwye+wrnkbuE85q?=
 =?us-ascii?Q?B+7PVWzfEsbmVgbZNvCQAxEzWz420CJyYeBGNAu8VLRRd7KRuoBesy92aXuX?=
 =?us-ascii?Q?fhbXp+Hv8kURsXO+IcdtwXO01POdtRzZhDbB78zsCRi9IOCWF6m9cFRs3kby?=
 =?us-ascii?Q?Kvsrcvqojuz5KsEC5gGG7eZBDwGZIwco2VDcjjffigFrPXoOXFE0rLTIoAtX?=
 =?us-ascii?Q?Zy1XG0ZbQGoQm44GD8avH/Go4ePX993+FZo8jvj7Re2FbtQwlKDer/J+EDGL?=
 =?us-ascii?Q?nmZ/gOdYgmklTTQPdK7I66R7f9OJ9EPvfRgJK+I/mVd87GBlwZJ3vMBDSSiH?=
 =?us-ascii?Q?tHcMChZ9tHoIbAWrutZxZ3Toa1cUjS0TQO6W/BqGr+UhK/ue4kU4trvPTqZB?=
 =?us-ascii?Q?hZXbKsEvb1nXVbunX6bUFdm/rIMIj5uyw4PF5CRMpM354njHX+GC3njvwYFW?=
 =?us-ascii?Q?1/P9G56Q05VcRYjXQMcQgLEET9NoRdTPEiJ9PVqiUUUFMO8Ne7/pqjsbJvoO?=
 =?us-ascii?Q?MhlenOtNXBzSmOBv59NXXdVh7zN1cTBKhicZV6xVFJN0gJcZ6fykVFplqBj5?=
 =?us-ascii?Q?Cgg69ujc3n9xLJXGu/7z6JCktDkFKEkLzGC0G525stkOawZpc0HfOPCbz+D+?=
 =?us-ascii?Q?8aRy+ziREMIOZbl8vs3+nDkEKxfTaKQsrt2yy2xV/hkhqMLpZaCIBZHZ5foB?=
 =?us-ascii?Q?tbfKUmhc+O4qLKqTp1wO/kCyANOZHiS9VfAjKKSsuMeUxiSmQonZl2vKqOhE?=
 =?us-ascii?Q?9jnQEIXIRobBdeCxCfZ6VGoFLx7l9KKNyoIz1S1fKRKULtNTKoRmoT/EuYo4?=
 =?us-ascii?Q?Z8KwMluqAQaXoFZp+w0+pstBNE6i07swNxP9M1XLBHvG00C0a8w2VPOjITJS?=
 =?us-ascii?Q?bwAGW4eQoT/od7q/XsU8QwJ4jn3Ry2tb0eIDS0Pus2YIfGRDkXoNiTUvSDL3?=
 =?us-ascii?Q?T48cMT+tGr6rvaeqVVu4kYM4MB+LTR5ZMXBL2qruFzdQG36J/kGpq042VpsQ?=
 =?us-ascii?Q?lBGog/EI5WVC289fvq9fUKXcfyS1OrgZ2Byh3xARLqdBs9cu5BtMIAFZqPHD?=
 =?us-ascii?Q?iCS44nEuEQhRnydn41cQtH8zvRHFwGYaq53Oq0K4bwKndScrE6a1+G12KyMW?=
 =?us-ascii?Q?FGLjA49m6nCVoUQyAJK2P0JG8KNfTAMEn8fUx70DCku6HXqF4fSCPBO9SoV0?=
 =?us-ascii?Q?VsyGRFVS8K9rIi4tA44Bketr5KFgcy+jnCltRhU3ZHUK1yl92PsKy1rIyMEg?=
 =?us-ascii?Q?2PTJth920GVcK4y7d3lKcI0JOcTeb4rtpLf4BhkT4rsogoK9NGxtjNPYQij9?=
 =?us-ascii?Q?zER31eH6avAC/DrNlGkAW3tyeJ90MdDuisvFLWGIWXJOU2oO+nhVdj8xJPjg?=
 =?us-ascii?Q?RVCzxlKcbFtJH+3tu2lRMN7SL+KrFrumYngxZS922ZOayjOuX5uT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a611d779-4591-426b-e04f-08deba274503
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:31:35.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K50TF5RrTKxZLC3ZiMt+IijZbZxnpRdhVRZq3wimUEQ6LNVRTKtFCWPYNcfjxU6P68c4/f2dQnubFLTLwRyNgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4607

Expose the DesignWare endpoint-integrated eDMA register window and
linked-list descriptor memories through the EPC auxiliary resource API.
This lets endpoint functions decide which channels to publish to the host.

When the DMA register window is already visible through a reserved BAR
region, report its BAR and offset. Otherwise report it as a normal
physical resource so an endpoint function can map it. Descriptor resources
also carry dmaengine filter information so consumers can claim exact
channels before delegation.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Follow the part 1/3 v2 channel-claim model by publishing DMAengine
    filter information instead of calling dw_edma_find_channel().

 .../pci/controller/dwc/pcie-designware-ep.c   | 91 ++++++++++++++++++-
 1 file changed, 87 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index e4c6f7193495..90a44be0287d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -866,14 +866,38 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
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
+
+	return count;
+}
+
+static bool dw_pcie_ep_dma_filter_fn(struct dma_chan *chan, void *param)
+{
+	const struct pci_epc_aux_resource *res = param;
+	struct dw_edma_hw_chan_filter filter = {
+		.dma_dev = res->u.dma_desc.dma_dev,
+		.write = res->u.dma_desc.dir == PCI_EPC_AUX_DMA_EP_TO_RC,
+		.id = res->u.dma_desc.hw_ch,
+	};
 
-	return 1;
+	return dw_edma_filter_hw_chan(chan, &filter);
 }
 
 static int
@@ -889,6 +913,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	resource_size_t db_offset = edma->db_offset;
 	resource_size_t dma_ctrl_bar_offset = 0;
 	resource_size_t dma_reg_size;
+	unsigned int i;
 	int count;
 
 	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
@@ -910,6 +935,64 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
+				.dma_dev = edma->dev,
+				.filter_fn = dw_pcie_ep_dma_filter_fn,
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
+				.dma_dev = edma->dev,
+				.filter_fn = dw_pcie_ep_dma_filter_fn,
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
@@ -918,7 +1001,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  sizeof(u32), dma_reg_size))
 		return -EINVAL;
 
-	resources[0] = (struct pci_epc_aux_resource) {
+	resources[count] = (struct pci_epc_aux_resource) {
 		.type = PCI_EPC_AUX_DOORBELL_MMIO,
 		.phys_addr = pci->edma_reg_phys + db_offset,
 		.size = sizeof(u32),
-- 
2.51.0

