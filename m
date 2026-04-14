Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020133.outbound.protection.outlook.com [52.101.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0133E715F;
	Tue, 14 Apr 2026 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176194; cv=fail; b=DDcBfBih4ubdrzJs66iV4BRpLSUVhOciL/Vhh3sjcDGOBDl284U0gds6BRcuBlVhoSCP1pEld5ennwOp1/ZyESC32gqO+9SfVY/6nU6TSCnfXBpcp07ts+omlirEGh3UBPLAnP76DTW87CpCZORks7XF9wK54goJZfuj7gqGPAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176194; c=relaxed/simple;
	bh=N1MSGvwVyzz6fkc2a93y1b0XFQgdrBI10ugKsrIXGW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NT0IunAU16j8jX0a4eZqx8WwhAjzFHcmJ9bR7wTWtasoWPhbBgFSgwNiVF7+5NfbWFgcq7Tnn0IIL2M686PItD83Up46c+SmT9PG2sXodTjXmhs4WlMXz/FeChoqEPCP+/AR6ckbom3tHtNLW74VepZGnZrY+EQ30kQXwZW0wcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kKJFJugS; arc=fail smtp.client-ip=52.101.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kKJFJugS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCH7jF/duxSr+qfLCkJnUUD+q/dgBr7MBu+Od7eyxcE1HbfYwy0A0fzJ6uXsxKboLoBnm/+Pzz/xwA5yXtTh9t1VgN1gs4B2NB9GKMzLR82D81MX6TfLpzkRSJZVZM0HzZB5FWxLCOKiWEs+uQl/H2C48KyL/dYapcl87ufjUu1X7ujGfRwBNIsxA7uESAWRNxgXv38/ctOB5VP0datgZNo9bbkN4o3lxXabdHMOneX/e/zToMdB/gTo1Qm1u1ZlUn+TAEm1FJ9urxY8NvmevjOpZUliJTg99DqKs+wWv+QwQRyb+auF+QyE1ZJNm+qxmWItLEQp/+2UFe4BwOhUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrnaEL7HBeJ/AijiHnahAUBcGY2wojYfS4R0k7UbMj0=;
 b=QyWdPbkW5XOEVea57eqXJ3gI9o3r81e980WuztKEHgX7YHFukFw7XfbrwnMG3PJz8XS22IZnkXKGp055bBceEg8ezQsm/XUj4ims0kjmNR7aYKqAQaAbUKLs+BmBvX+3EfX0wal0mfyWBsvrXZ0O640+kf1BcM4swriZf0Abq75P2yyADShXZN5d4zgfYb1w9o6O9YQOw/l78IXhejkVECEodfsfly+mDYTc42zVNIxhWew0bTG9TPJoL4KYiBSj/h1UboO5cPIZlQ/15M1oOjeNgJkt8xJpBIvCrXCdW5rS9raASex+4FiYmPhMZUl7Gyqc5YqD1sSKU85UR6pSIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrnaEL7HBeJ/AijiHnahAUBcGY2wojYfS4R0k7UbMj0=;
 b=kKJFJugS+4/701yob5cc40G3n+78otKKnPQ3ul6xRXFlLK1QblfdIvVsQwFpwaTSnIs0Kg+dbhxMLp+vnulN+vT+pn7IX9gRKes6V15HMz5jrB7SYtxt4XpZqWptkhO8ncwdJUEi0NrDm+vv9a6bZ0Lg40/BQGDN38XsvlQuXnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2529.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:222::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 14:16:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 14:16:25 +0000
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
Subject: [PATCH v14 3/7] PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource API
Date: Tue, 14 Apr 2026 23:15:10 +0900
Message-ID: <20260414141514.1341429-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260414141514.1341429-1-den@valinux.co.jp>
References: <20260414141514.1341429-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2529:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c812b0a-1223-4065-915e-08de9a306956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rFV7rbWHoh9lZ+WzBD+nmcNdsuh95DwYwql6hOi7YhcGI+8sEcduUggoh9Hv5gqCuu8UQCe4Qzvnwp3a7yYKnsT7vgSD/Tk7pB8uKuYTssiTuqv2FEG9SHKZZ9uTzo3OQAxLxGTP8nqB2d5BXX1kvoRnvKpXTGEgkV+k4K+8mYbzYv/OyY+A71iAjYx7YePHxG4aGVH7/liEtH3nvw6T/EjWlinWNvY6QVTDHKVeLzBmCWzhoX8Xsjdna6Xbu3myNjIw2+bSZJnXB3k2KAtVPacwsfZKqKaumclt/bCkkWqvrjCWTZNa2/OTY5uJ2oxZRbJzZ+3iSZu6IVC5B8Ptrp+BWFqP7rS+vgi+MxmkAzbwGDWYlap+2GqvqgLfJ6XISqEEw50BbUCS4eI0hznGODf3px+K94JESzq3UqEQdEVvjiROHgqb2IoUmgLQ7Cg9y2n/d5V1uPdt3hSNr/AzA+03cfkI8oQBjK3iNne0nJ8rJoixLHdoStktDC05Lkeloxy9oVJeYthPBeOLqzHT8s9FlP5KkPCCLtXFd9OLpxCXAw68kRZcBtI4DkGmUQ9kuAKEIl8Qqz8RPOw0zu6vkHcl/+9X9+CYO/PBY6YSGvfzViuyVnAahJPw517QOJA7jHCY8sZZS0lIGXPUa5w5QYLm5BQyuNTZ+/pycx971NsobobD68DtMMsLFegI1BtkExFkXVxt2EBcnREgxFpxWuSntBysp9FlW/9Yk9iWPJLsnOLzPolcHu55tNoN+teXC/2g6o7WWMsGnOHoYCUOXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hrQ+ozNlLj2r2Kphr1hioJYC6Jv089ylUuUhIS7OvzX3Z5yvjCChviyIQU/Q?=
 =?us-ascii?Q?VxAx3uIaeIy6c9PzgmIt2l9fjyaBCyUC4u8qRCxFbWdF8IiT/6v4xOjTX/wr?=
 =?us-ascii?Q?botGioPzjbC9pFSkdXs3O+uu36/XZyT44KYsqI6agfOwBp5H+DSFFGqQlaRX?=
 =?us-ascii?Q?IbLJTHVW3vIqwrd2DJG04ZyCI0PcR+UEsgPOm6uUV2Pk0Yx+N3fWIOXUnBvI?=
 =?us-ascii?Q?t+mrE1M1LWTjAc87CpPrEy9NxEai9f3Ink975ZGYFChyxIodIvb1C3ewzpa2?=
 =?us-ascii?Q?FzNK1FQtQ1MyK3WLnsUSx7ST0dGx2V57fYwrB/GgsEUSVzuApJ6oupUC/fea?=
 =?us-ascii?Q?qWkwpi2G6GkehsW28ZiKco4olAoa4D4KKqtd1XcEYrQRYHSbTC1bErKQ1iQW?=
 =?us-ascii?Q?8fz8kBl7q/T1yuM/woZEUABt0mgYJmEQ9TMPbe/PT4SlPHCtJPUB8bsFx8Wa?=
 =?us-ascii?Q?tQSSuFl/oB45Fmz2ZiTgyx/xjkffN+WgTeo4TXik+33cfeUdGxf8PaK8nb56?=
 =?us-ascii?Q?wNwEnxmjUCzEJtLqdsqXgHVQSEzd2Y0y8vNxDdIOSJjn2SeC+S6M0I7B99Tr?=
 =?us-ascii?Q?9J48jJHgzJvwVxmh3FUG4FYJRt4WPv7m7FNZYC3/wX68ehC+/48BeWcJsqU/?=
 =?us-ascii?Q?XaSJStUZbUZ0FT5g1aqKjDWzdxRFraFdBzDmbJN1cVUhHShZN/o+cZEhlLVW?=
 =?us-ascii?Q?r8mC2fkGm84KYMEWGoCk4xy2OEcPuLfWkhEWosL2XEgIcdfIDyEuOJoHnG/O?=
 =?us-ascii?Q?662RymnIDVoTzjHlDjVEQo4HNPIN4J55E3b6uohZyAZiUiwXSFlshJ+qeSuK?=
 =?us-ascii?Q?fcA4rP1lOZENRoW/B6UGIL3ousTMTXJ8NhcZaEw1sn0ejjkj3k+YD0MRAy2F?=
 =?us-ascii?Q?W6zZ+teRN3taSY/7CDBp5nEtcXEZulvptNcIk5w3mTbh3X1v0gW/fCM64B5w?=
 =?us-ascii?Q?MsM+lbkVjkGZ7LX5gCaJ5R492wYB3q8igdKUVntY858gRQT0JiPL+IbYqkeN?=
 =?us-ascii?Q?YrSYB6YwVZgWSDpb0DgxTODbVCVAiWV+w5vKVI/bImvczK6dL05f095g9Kgr?=
 =?us-ascii?Q?Dxzgdoa9Z0hf+t9pYolwYM+GYFwiO6MyxhPNLHip90pBOQdG0RB9JnhOg41X?=
 =?us-ascii?Q?FEgYmz/7WoBoT3HxgjN3GER+dYPkTKn3eMyYOEs5sgM5C+bfDuMrhA14qdj2?=
 =?us-ascii?Q?OTOMtnMWjRkaxqRPOhbe/VtHWFHNoT/FRyEI9m+CBrWj1B1+oUSLDBnKgeeM?=
 =?us-ascii?Q?JIEZp6Jtz36HHNMchOhSS5k3UfE11DvHA/drqCq0mTFbXRa8Kwrp31otTGXW?=
 =?us-ascii?Q?RmmXucKlE1Ym8e1VZiMrbqoBcpKguUM0sfis6Xp1l8tGJ4DTdY/8AtFqFwWR?=
 =?us-ascii?Q?LXImVeCJmyi5FkMN3GCZKUW6k71Bwi5/uK4J3yzwc6QHtf8P2r/mwGEaThWn?=
 =?us-ascii?Q?vw1n/pMLnDkM5vhvhW7crKdsEED394kVZKK9m5nGifUFLRsIOuu2wgZCQl8f?=
 =?us-ascii?Q?3TOuiq0Tm/YzPOfEMqDicdgnOsVG4RFH6h9lfHKWR0TH9o3PAOIsLM4bgNQ5?=
 =?us-ascii?Q?oYWrZWRgMf8FjkT0A8Woi/wU0cUN1Jlz65adGt+JjWceY47qtpFnzitPMpRQ?=
 =?us-ascii?Q?R28ok7bFmCwzi6lxxKAhKxvmi8yq8NHdMEEbYTrLkDQCE5FKRU0v4p1uAHeR?=
 =?us-ascii?Q?DszF2F6Gk/Dys1w3SRTB3UOHSBHeiMytddsyK1WyOBwDKZ7cDF/fuDt19/rD?=
 =?us-ascii?Q?GVbgrSWCwsg7066jNfhygNDvuttwFgnKPIEYL+yxKi2xkbLF0Gt+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c812b0a-1223-4065-915e-08de9a306956
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 14:16:25.0212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Exb9EvRvQ2mVCGOV78QrcFdCjZQJOCgOeo8jPk/gCeYJvc13erYQS8HoESSS8OSoTr+KiVQt7XxbyRIb1xid6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2529

Implement the EPC aux-resource API for DesignWare endpoint controllers
with integrated eDMA.

Currently, only report an interrupt-emulation doorbell register
(PCI_EPC_AUX_DOORBELL_MMIO), including its Linux IRQ and the write data
needed to trigger the interrupt.

If the DMA controller MMIO window is already exposed via a
platform-owned fixed BAR subregion, also provide the BAR number and
offset so EPF drivers can reuse it without reprogramming the BAR.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 386bfb7b2bf6..c3c354265307 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -817,6 +818,122 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
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
+dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
+				   u8 vfunc_no)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_edma_chip *edma = &pci->edma;
+
+	if (!pci->edma_reg_size)
+		return 0;
+
+	if (edma->db_offset == ~0)
+		return 0;
+
+	return 1;
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
+	resource_size_t db_offset = edma->db_offset;
+	resource_size_t dma_ctrl_bar_offset = 0;
+	resource_size_t dma_reg_size;
+	int count;
+
+	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
+	if (count < 0)
+		return count;
+
+	if (num_resources < count)
+		return -ENOSPC;
+
+	if (!count)
+		return 0;
+
+	dma_reg_size = pci->edma_reg_size;
+
+	rsvd = dw_pcie_ep_find_bar_rsvd_region(ep,
+					       PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
+					       &dma_ctrl_bar,
+					       &dma_ctrl_bar_offset);
+	if (rsvd && rsvd->size < dma_reg_size)
+		dma_reg_size = rsvd->size;
+
+	/*
+	 * For interrupt-emulation doorbells, report a standalone resource
+	 * instead of bundling it into the DMA controller MMIO resource.
+	 */
+	if (range_end_overflows_t(resource_size_t, db_offset,
+				  sizeof(u32), dma_reg_size))
+		return -EINVAL;
+
+	resources[0] = (struct pci_epc_aux_resource) {
+		.type = PCI_EPC_AUX_DOORBELL_MMIO,
+		.phys_addr = pci->edma_reg_phys + db_offset,
+		.size = sizeof(u32),
+		.bar = dma_ctrl_bar,
+		.bar_offset = dma_ctrl_bar != NO_BAR ?
+				dma_ctrl_bar_offset + db_offset : 0,
+		.u.db_mmio = {
+			.irq = edma->db_irq,
+			.data = 0, /* write 0 to assert */
+		},
+	};
+
+	return 0;
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -832,6 +949,8 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.get_aux_resources_count	= dw_pcie_ep_get_aux_resources_count,
+	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
 };
 
 /**
-- 
2.51.0

