Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020102.outbound.protection.outlook.com [52.101.229.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF633806A9;
	Mon,  2 Mar 2026 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435711; cv=fail; b=tgYsTIrvMamDgvGWbO+XZtOrbY7ZdBOrRjupQOthOZKVrVBC8JVaf14JHde9+QKH2BgAYmmn8EPIA0AYO18T4UM4ir2XjXFDF8LxeY0DYG8AWc/Stb2W5D8jUN1dQyHt5kTFrOuNKs5gX92l8eIjMFaEIyIPXV+r+1GJ5d0QzMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435711; c=relaxed/simple;
	bh=E/OTafXCLjUXB/ihwtFcw4GKRjYXMR/6CgKnRzDyLjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWhIK9xyj+KFnoxUrI+nRmif9YPKKV6lsI2GVOgs2hA6g5OXY/nP8JB23w6kwdcNpwPvBqI9ghAptWihgipcb5q5/6JCMgXAfeRJn2saUNHpZI3zxA2b/Zzel3hT/dXRyOIRWC3ze5eiq2YDgy8eFNojYCgABTj7ATe83Nu9290=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ptT3/ywh; arc=fail smtp.client-ip=52.101.229.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ptT3/ywh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBrB9srlzVZzLv1XOZPbfLl1Nf7nty0g64ykd5465n1uU7evz8sr9H4c6DkOj+u3PRUpqtju97hL6MILc3GZznT9VvYlFEtFQBWi3diVReh+RfojE3wM1t3f6lWjWTdODLQ09YbYlWE/w924bL7/+51hUylaCXVIj83N7CkCwpgn58Oupua11NGRM7pWuipV/ltnRofg/08zagWVfdBltwNDDNbzCEWeRngzO/oM9kju63NpA5BvjX/JxR3/4RrLSMiFiN4MCtzrG80vRION13HPEmZAOxBjTcw+Dr/Skr0eT0bcUixJmV7to+Xo5D5YuYFodttk17DJ8aY52TVsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSLHxO6rAUifD8aee+ITd0SEXXDH6mhpuYdWyl2WFJQ=;
 b=Ij+IHgGt/j3pyEuUfNKhqgJnA/XsTWwOZ8pnbxFl18R3ATYvBOldax7dZI0VFSkRclig4D0815IKdzUE7r8GnC+0FTSNsIYrT+GZwOZ4yKHEiE4HKvyqBu4XLupOaQelbPpDio0rVPJA8nEXPd+2RB7XBTlIpUJ4gfSmO8iDUcizHUfTjE7qdeKiOmCEtOpmvNL/liAN0fKJD8zylcbGfGw6b5H4yUoRsZkLId63eb2jhimmrB0qkW0Ep0q2KszwnDa2l0S33gjVHyJ8GM5mDbPU0U00GEWHCQ74ZaI+11qitICu0ttjXjteCQ9BlRu92FwptGpQlimYeu4kunDaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSLHxO6rAUifD8aee+ITd0SEXXDH6mhpuYdWyl2WFJQ=;
 b=ptT3/ywh2H2EsqHhdavDWyD41owg2wnZHJofFFCt/sEo0MblkM9frPWghmD40c3tMx9Rq40tW2fWQ6WDeQtM3m1Cuscg/UPGSvjcH1sYHMK75w5+KVfrMG+V/jMeRfSv0b5qw8E+Si8FwPqAzzBNCzcEoRm/+Xn7HS2RgydaCS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3705.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 07:15:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:15:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v10 3/7] PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource API
Date: Mon,  2 Mar 2026 16:14:23 +0900
Message-ID: <20260302071427.534158-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302071427.534158-1-den@valinux.co.jp>
References: <20260302071427.534158-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0134.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3705:EE_
X-MS-Office365-Filtering-Correlation-Id: d5078579-b384-4ac8-6322-08de782b6d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	n1uduvlOwO0X5c7ANQ46O8ruOYs96hWH/uCgxbgX0EOyeAtHS3JyBkNQ7KEFHLjHCzktDIicKaLHcK8VKjSW/AC+TrrDUJ9rdBRNR2oIO7sahMGTuHckyoLax5Y8Diwag4URapHbciTY5uMpxFbF9r1XLHHUbRdyrMShrvveuuIydF1p5IWBEdoc95Amwon87wSG0MtR1tY7kvOC5B5iD80qj7yuiUM88gvOVpCxWYetYQt6/7xd0bbtR+AOtRFmjNRIA8gDnTp9mUvtBGEiFi58J/l2djLd22YxSpDlzA5DMWLW6c2aICHgBT2GHL21J4/uNuq853CBiI1uyMLjTQ7a/cuUyHW0YgaPhFrnONT6Lb9Ej6dcRbNZ2Sp6XvcbhD6RvUGPmW2oqw/V2Vj4rXnze0aRkIkL62obU3u0moYpM/rg7W/e2PP/f33jp0qGdx0q5bELPzZ4FmNY7DGp/9jM7Bcaw4LWPqJ0ltceicKgncrKF0vUA+jXagMHztnpsIKTG7M/bKmKC2JhhIE5a9YMP3ryV4gck9/fEHmmWeUFq77eZvLUok9wocK92Nul74gTvCLzNo9zPv3sQiChSnl7tYu1vazz2zaHXNBjrt7yH8FyGYud6ov4/F9cTfgMt2sBQ0e8rP5N24baJWZ4dT4/+SVKYCgFaU+2avPADEvfFuD8n/YrFoBRpjdRR4Xs1W+sEdJqsoySpOKU95boKAcLuEDHITGlSSUVj0tUm1TxyfR6Eqvgf8E1FVCDx5lD/YW47lAaJVk+xgFEB2RHbA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zCs0fFtCTc3Rf3BvXvV5rA96hoL6RnOL8k3FXvS2oj8Pr7aAFTnekojg3IAu?=
 =?us-ascii?Q?PRvk4N7bZogQRtUnTJPqvP9M8b05lRxpPtKODeagdZysce+Z7OVIEJWoozVk?=
 =?us-ascii?Q?HHNcwZDSgMSuIpiZq+PyNyJQ8SouucWYezHYpEAOPvwcOPWtz59nDMylOMg6?=
 =?us-ascii?Q?UBVFEC/2vkuwrURHoc1DifKYkKNrsk50neyGLHt2/TtqRFEZRJE0P0U36Qoj?=
 =?us-ascii?Q?NGHs/gxErWAr01bG8lPQ1HJUkxA2Z3RLr1l6xjy+SHcDcAJNYabowa8Ui1Lc?=
 =?us-ascii?Q?4GGNpRFj7T6LXZse1N7M41w6riE9wUYBUviOa9bdvhuzNQVrLk4G7yT5TNOP?=
 =?us-ascii?Q?sg3x7xrLsFFFKa04c/x9lpc2JSapTbD4vCdQpoTlezLzh4VfPyOPN52TL5W6?=
 =?us-ascii?Q?DkbSQNOF4Oped5XG6ooKk0GuOuMy5i/soBDftazb47LRqxOyv0X5ZTGSbZvr?=
 =?us-ascii?Q?NrP5E4mSJk1KnqVJAAfAY7lj6ErTjvisjoYfHkPMvqeayVGpv3DO2K+h036p?=
 =?us-ascii?Q?Sm/DLkfYVaaqfW69FHcMHuo49szwM9oXXrUeL+ZEBMVXnMdLBT399NDNAtoR?=
 =?us-ascii?Q?EHRoKIsWeTzeA0XDUMWIwbaXmfqL72Jvm6wJiMYzhq6N2HxJ531iropk6r9H?=
 =?us-ascii?Q?xyRwIKlp9c8RnhNe08lh9YwQLnABLwwf9fOcAPvTfpfJ5bnUp4QcjO8Hqh+p?=
 =?us-ascii?Q?EjD0+0XP3w2VReW9yAYGwAPEh1wowtuFv8Nl/bASbyZ5GMiK3/v76M2mzmW2?=
 =?us-ascii?Q?f1R14bWtYJGNA42rErJ99BHd0vZ3c6Gr8zrMRvHzUl36/hzt4d9GVZJbjM04?=
 =?us-ascii?Q?6X/EcqnW55LZ8wiBaDmpOsPn5h60b4pbbtxH6jYcRAvzI/qweQRgXZSe+2gw?=
 =?us-ascii?Q?z3AAhP4hzhjsFc2yvFconrXCv8xdy6WjYJtf3BhzZZQ9/g0ZnQ1BLanIX3n3?=
 =?us-ascii?Q?SMgcUBjUjBMxt/mDooB4Rgu9hV14VBHaPSSm4Se5PWv/LyiSoYvAm/I4SgxE?=
 =?us-ascii?Q?ul+879RnqwyXY4xVlQuwGAVVq4qivt/TjjX1S1bDi3Fet5oDVncEHp/WsgK+?=
 =?us-ascii?Q?rzw/qL4equobqH4KxdZkDF2m5hvNgYaYjagVbXEx+q/9QW5J3b9aLmd6T/8/?=
 =?us-ascii?Q?mfffZ83HeTTmWiejMFsCBHNoxeFaT5ofQBEG94SYAapSMjlf52kLbsPaVs36?=
 =?us-ascii?Q?OT+X339Lp3F95nxo9ZmoZHfnmoc64IeHEwtWlnzZSJJAHvxLb2qt/N72tRDx?=
 =?us-ascii?Q?KtbGTnN+jr46KDaoqfEAsKOXwbs+uJBG6ZMQ2DCrcZ1lE/0tA883nnuMY1u4?=
 =?us-ascii?Q?uhzcECt2LhF4KXttyeUZNS3hcHNRHrEXnQtA13SyUoXHzd0r8qPExfHpxbf3?=
 =?us-ascii?Q?6QJAdn6senjxHg0XfY5dnyT5ELI6Jez9GENTDRrTMiZ5KWlN9CzcVPvBiewq?=
 =?us-ascii?Q?r8kuNxMw5vRdImi1qh1PU+8LZlDDIVVZF+SpwsUsO4g0NoIVVqQHLP2uI4pL?=
 =?us-ascii?Q?nYOPFdH8+7KcMC7cSQP5JfwX/oFTrr58jTs9/V68U1RGy2LzWYCV4WLc3BuL?=
 =?us-ascii?Q?H2p7C/o3EFAuva0SnWNidTGpnV3XyljC4OyTJjzGgRQ9vaWiweoA8G5UmpTn?=
 =?us-ascii?Q?AgvAUr9aaMDq62k6HBJW4QiacGosbpj0Q1+clBAZ6V8wYbLCIMRpto5FvaqI?=
 =?us-ascii?Q?MbKE2MS7K5wm5VV/UwwMIIvyBzFI62WKT+otz//EQhpgY+zTxSuO+MON5h7N?=
 =?us-ascii?Q?5+gVF5rSu6d6rJ73hbVqSKerhjNLMnqP965UjvD7tafyBISI1MJH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d5078579-b384-4ac8-6322-08de782b6d15
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:15:04.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/9VN1NBAhIRIIDiDl4Ln/Y4qHsfcJ4Q96979VtnnfkYNT3nRdIPFujSb4AZTPKrJryZDJ/DTCDB1oOofCkDUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3705

Implement the EPC aux-resource API for DesignWare endpoint controllers
with integrated eDMA.

Report:
  - DMA controller MMIO window (PCI_EPC_AUX_DMA_CTRL_MMIO)
  - interrupt-emulation doorbell register (PCI_EPC_AUX_DOORBELL_MMIO),
    including its Linux IRQ and the data value to write to trigger the
    interrupt
  - per-channel LL descriptor regions (PCI_EPC_AUX_DMA_CHAN_DESC)

If the DMA controller MMIO window is already exposed via a
platform-owned fixed BAR subregion, also provide the BAR number and
offset so EPF drivers can reuse it without reprogramming the BAR.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 386bfb7b2bf6..eec20800a745 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -817,6 +818,155 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static const struct pci_epc_bar_rsvd_region *
+dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
+				enum pci_epc_bar_rsvd_region_type type,
+				enum pci_barno *bar,
+				resource_size_t *bar_offset)
+{
+	const struct pci_epc_features *features;
+	const struct pci_epc_bar_desc *bar_desc;
+	const struct pci_epc_bar_rsvd_region *r;
+	int i, j;
+
+	if (!ep->ops->get_features)
+		return NULL;
+
+	features = ep->ops->get_features(ep);
+	if (!features)
+		return NULL;
+
+	for (i = BAR_0; i <= BAR_5; i++) {
+		bar_desc = &features->bar[i];
+
+		if (!bar_desc->nr_rsvd_regions || !bar_desc->rsvd_regions)
+			continue;
+
+		for (j = 0; j < bar_desc->nr_rsvd_regions; j++) {
+			r = &bar_desc->rsvd_regions[j];
+
+			if (r->type != type)
+				continue;
+
+			if (bar)
+				*bar = i;
+			if (bar_offset)
+				*bar_offset = r->offset;
+			return r;
+		}
+	}
+
+	return NULL;
+}
+
+static int
+dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			     struct pci_epc_aux_resource *resources,
+			     int num_resources)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	const struct pci_epc_bar_rsvd_region *rsvd;
+	struct dw_edma_chip *edma = &pci->edma;
+	enum pci_barno dma_ctrl_bar = NO_BAR;
+	int ll_cnt = 0, needed, idx = 0;
+	resource_size_t db_offset = edma->db_offset;
+	resource_size_t dma_ctrl_bar_offset = 0;
+	resource_size_t dma_reg_size;
+	unsigned int i;
+
+	if (!pci->edma_reg_size)
+		return 0;
+
+	dma_reg_size = pci->edma_reg_size;
+
+	for (i = 0; i < edma->ll_wr_cnt; i++)
+		if (edma->ll_region_wr[i].sz)
+			ll_cnt++;
+
+	for (i = 0; i < edma->ll_rd_cnt; i++)
+		if (edma->ll_region_rd[i].sz)
+			ll_cnt++;
+
+	needed = 1 + ll_cnt + (db_offset != ~0 ? 1 : 0);
+
+	/* Count query mode */
+	if (!resources || !num_resources)
+		return needed;
+
+	if (num_resources < needed)
+		return -ENOSPC;
+
+	rsvd = dw_pcie_ep_find_bar_rsvd_region(ep,
+					       PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
+					       &dma_ctrl_bar,
+					       &dma_ctrl_bar_offset);
+	if (rsvd && rsvd->size < dma_reg_size)
+		dma_reg_size = rsvd->size;
+
+	/* DMA register block */
+	resources[idx++] = (struct pci_epc_aux_resource) {
+		.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+		.phys_addr = pci->edma_reg_phys,
+		.size = dma_reg_size,
+		.bar = dma_ctrl_bar,
+		.bar_offset = dma_ctrl_bar_offset,
+	};
+
+	/*
+	 * For interrupt-emulation doorbells, report a standalone resource
+	 * instead of bundling it into the DMA controller MMIO resource.
+	 */
+	if (db_offset != ~0) {
+		if (range_end_overflows_t(resource_size_t, db_offset,
+					  sizeof(u32), dma_reg_size))
+			return -EINVAL;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DOORBELL_MMIO,
+			.phys_addr = pci->edma_reg_phys + db_offset,
+			.size = sizeof(u32),
+			.bar = dma_ctrl_bar,
+			.bar_offset = dma_ctrl_bar != NO_BAR ?
+					dma_ctrl_bar_offset + db_offset : 0,
+			.u.db_mmio = {
+				.irq = edma->db_irq,
+				.data = 0, /* write 0 to assert */
+			},
+		};
+	}
+
+	/* One LL region per write channel */
+	for (i = 0; i < edma->ll_wr_cnt; i++) {
+		if (!edma->ll_region_wr[i].sz)
+			continue;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_wr[i].paddr,
+			.size = edma->ll_region_wr[i].sz,
+			.bar = NO_BAR,
+			.bar_offset = 0,
+		};
+	}
+
+	/* One LL region per read channel */
+	for (i = 0; i < edma->ll_rd_cnt; i++) {
+		if (!edma->ll_region_rd[i].sz)
+			continue;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_rd[i].paddr,
+			.size = edma->ll_region_rd[i].sz,
+			.bar = NO_BAR,
+			.bar_offset = 0,
+		};
+	}
+
+	return idx;
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -832,6 +982,7 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
 };
 
 /**
-- 
2.51.0

