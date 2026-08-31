Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020106.outbound.protection.outlook.com [52.101.228.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2A42CAFC;
	Mon, 31 Aug 2026 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200828; cv=fail; b=egWaFZtRK3gDBxCjF9tSRJ33Q/82Ja/W5VIgPIXXsTSAHScYfwzuPGZTbAFCnN/TCJnRmoGwBafjkj1TEY1niRq6HZnl1rQCUPzZM6Gt1GTc1aH8DpPYjT3zoUMQQgdDTmzzbXmYqx/OAzk0VGBbODSBhb/rAS4QOr/Z9PfzXCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200828; c=relaxed/simple;
	bh=gqpSVBfqugDh2jN4JqG2TjxQ3HOFFOpiFo8VU/G1W54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ezz5dgvuD7XiRXxtk/LOYgj4Zepg9Z8sc2dJNBRJ+MbSodhybiHYWNmakY9Kym5+GoA5xKr9lHjHLqGQfhZ00qMDtudZAV/sEIMpdsmHNbfRA+Ua9bdjIdNqG6eNQRL9pxRch8eQmD7rRrTwGt6YElg4Ga/x6KQ4ZeWDvMwCjnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZzaGWkNU; arc=fail smtp.client-ip=52.101.228.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZzaGWkNU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpqAY9Zx7sdWDYTAHsMGutWCG/HIeFRW8sQP8GkEPPe/vCz5yEcwaK4Vcv0xJeFuMduf6BBnVk5EVXI7vMGxIJrwZj3JTgKCVfoTgOp3w8zFfbCkopX+Szk+N9f/LYAxWqvOq5t/W+JFaoSDMwDdsMnjFeoNr0mB9yI1DclDMsgZNoQDnM5XB/eAIxFfqp2QxAeaUlRTIJZnSvwl/jE6n0r0DXqvofdM6PSUw2vDcJtfN9C99603TUH1hk3fuIRJcYJ8AX62NHDXVM8QjHJ9Y01rZzaFEWz8zHjJGRAvviTHQctnL3zssCr18/DfL9qIZoNNsp98FvXaa5c+9AQPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25+vZINM2FucgwovcvuZE2Jv02BX1fbCBrYKBdaiRFU=;
 b=efhSeE/TauIoRU/QxUKRNuwq2Ogm6NuCTmsumhrdq6KJ3/c3S5NKQeSkYI2gWPddVntJ/NWNuItWAe+/05YuheQLfpnFz32H9jnvj8YbKPHZkB8dstg0fFsCW9rWWkfVJj/no++EBePoStAYsU5R284eBx9g5iTITD5lkGjl1qhvG5E89yEDdkjIaUyvDBu70Y5txJQkWi2tq5tdkZYnelOn/NZ2YdGuZYnnffBaGJYxxQ1tx+CFcAIGxRpFXdx6pi1PYMCZ9buQ5rNOnvicHeI6u6U4NOILuzmG054KZAbx4VGTQTfSayc5V+oN7K/8JJR0ZbrYj/Sc6yojz9+DOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25+vZINM2FucgwovcvuZE2Jv02BX1fbCBrYKBdaiRFU=;
 b=ZzaGWkNU86pK4pNoUt/CwE1DdUOZAqikmnA7i4FaMR3exNjwe1kjQz3gpS130FpzKtEUSPvGH+QYX6nMetdkQqSWIijaetwX80AIQUPDY/yqdgPSQtAZIttrl5VxcH2mfePKAXb8a4sD0RoH0FkE6zqBSd+xuuv9MaJNTkiti+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB1802.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:27:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 18:27:02 +0000
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
Subject: [PATCH v3 2/7] PCI: dwc: Expose endpoint DMA resources
Date: Tue,  1 Sep 2026 03:26:52 +0900
Message-ID: <20260831182657.329614-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260831182657.329614-1-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB1802:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe20f56-69d1-4414-e620-08df078d7391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|10070799003|366016|376014|22082099003|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ROa1R+1CS8c6fWWR43bumVcPiQy1Rlz29F+eH63+k5NCB0Uq+uEIXPJSCr/V5zWDZ/eRxaw1KzreBc7EUStb0Sevg/ttNBxfbtkzOrlH/HPfnQgCzE5ot2DSMdaUxffey61B9TQH+OyyD49oj/ejlxPslggj6mV2Rw49V99JSVNCV7V9VpnCVUwCarZbXKjRcVfdlx/7FYPPIC/235GjfTXLBXhyOxyzmfkFVPdGPLWAmGJAmN+mZQmdRf7QXQyzDB+N7V2Z1D6+JFF9OZBrcxcrJ0dxkNX2QCv2HxV+rK8/Q110jDpz994Ni005Nn5IG7haaOFUbeLikzY5aHmZYNKIjQD5gf6lPGxQtbvBY/0AEmNvrAmvbVCxMlb9qDoL8/dU8y87nPQsaRPvFeji1Qk5drSc/RkJJdXLydCYgP81fJ5S0bGUPECQknyrSq3EYSKWg1GIuzWRXNyChnDoZBE5vVFfn6KCQN/7G1gkKCM1QVZLi4oCI8Z7dvDc6kVZiMgsbv6OCdhGIm+Kgumpbl/UlSMUojLRmZGCAFYMGJdCUAthdSnYioWBqAT4y5PPfZNDxt9Q+u9wJa62oPbzYTpOGdvqcFE9SzmkUhfXd3C94SgZ/1WbYaMQdCxqaIEfKrPZgeHuZEQJUTDbkHCQ8euEbqu3X8msQlZgjUyKyCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(10070799003)(366016)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Z2cb39AA0Ek7ji2Jle8lkg79ZTEmVV2YBxC8FQamEdP27DK0/ucCSY6xsvr?=
 =?us-ascii?Q?j0BlrnLY9clHQj6RGtgs/OEC/DK+xKvz51INoM3aP0c60X8KjursODh7qp+v?=
 =?us-ascii?Q?UurK6yDEG8l+P7vaBPu3VcgUfxQbAuRAt9OxfOAAR0qOSxCeJ+GljcKvlAQ4?=
 =?us-ascii?Q?6trsjZ39SBNbgOE1f8+xAMNE0u+w7y5MaOQyWs+LXZrW+aVSm3rexuucwYVG?=
 =?us-ascii?Q?f/v5q3cmY/0b4I7swVqy2vOz/ps9i1W6QQRXStppXuA4sC2Dc9UzHoYRNOg/?=
 =?us-ascii?Q?1enO/W2PhfV3ZhyRGLxp5GJp5Jw83HMuLocN9mdH1D2gtymeBT8FwwY581w1?=
 =?us-ascii?Q?QR9ShIU+ygtwsXOJFa+8WCvRJ8/Sn6yh2wyYzYoLlT8ET896tUEkH131xoRL?=
 =?us-ascii?Q?dgOI+amxsGdrlsJvtya8JwmXck8uUEY1bQPu//8M+UVCK82/d8excUhnbX1G?=
 =?us-ascii?Q?eBE8aOQucbyg6R5v/gCNcwTyadzncHzaVD8VXcyEvtTBx9OqYOBtsdATY6EV?=
 =?us-ascii?Q?NjPkwJiNV1CWrfnJRMB4rK0wzJAsFtejq7rV2cKJ8BKymubHT4rXQ2mjdiTQ?=
 =?us-ascii?Q?04nX4NgLu/SNMvhy9r63xDK39oGyZTq/Oy9bEG7pmrLzr3cmPPMxWiM3W2TI?=
 =?us-ascii?Q?lAQ1YRZOcbgwkXaQPGjYpo0MqItvM5glE+2no4vfZ/RvOv0jEzq+OgRKB+kT?=
 =?us-ascii?Q?RyaPGX4TXh6oB6Hh4EBq+snlwL9bM8Vs6D3zf4BUl27+hhlPU0kXSe8Y41YG?=
 =?us-ascii?Q?DkFLg8oT7wmD29wB1TSqQVjzP8PQBa7E9pKIozhDG+GnqMB6dpV5oT8AyKy3?=
 =?us-ascii?Q?CloOhy82hNodSEtM5SzY9y3s7hb8Z72tzUSm0vN1fvzdmupCM2HsSuaDJqpT?=
 =?us-ascii?Q?2GwuIxVbCNAk2TfrN4nKFdJcsidsafreqoZceM97uAmoCJNfHOaUILQsVzCb?=
 =?us-ascii?Q?GwxQBhVuY6HXvlAAZRq4FoCquUcRsBWlQrXFpps6mrijb1Db/6w86WuNZAK2?=
 =?us-ascii?Q?7Ssg/1oXqTVCeMVYdjJpHLKBix3JBdosQO2ajUY62ZVPF/+93yj5WqjjqvQX?=
 =?us-ascii?Q?TqXaNWSSvUjqmTImpkbkwqnL0sJrhpAv4Kb2qa24f6pHIg2H3uWlAZQij4q3?=
 =?us-ascii?Q?+7HLoyffbIkD6igE1P7c5gnVk5489I417yht830wUfLw4RzDhSsCyyuywl8F?=
 =?us-ascii?Q?24t7cTWe3HaExk3saSAYmFMsYrIiUhqgnWxqmOssIbvmVbuIA14RxZtdk7Vd?=
 =?us-ascii?Q?ijl9tXJ08E4BanPCdItRACXeGiFvTuOU9pzcLPRaM0z9BTzRQNfZKql9F3UA?=
 =?us-ascii?Q?XOzroI4TJ6zNYs3PgMxesKzgX+KscfbHSCWs7VCXtblOhPFb9DUZo2wya17s?=
 =?us-ascii?Q?ZL0moezJnl4Yf78Otbj1ZQyXkdhEtT76hlSMo0M9B5GD457kkZvtvcRtM/dw?=
 =?us-ascii?Q?FeaEJKK/rFDVEKvDXn8rWYxRrF2tsimbeByGamJ49pTOLGCBoGfj+VgLvjiz?=
 =?us-ascii?Q?6ryoFi9PWk7x8YzF0Bspo+PChN3SOM4+IzfIGjlnLp2Ld1HKf2oyo9eqEbwv?=
 =?us-ascii?Q?uTyGxR1vNx1z9QBcr56l98KS670rcsNjmmkxNQB6Mn26ToXCljuUIIx3Xtnu?=
 =?us-ascii?Q?CV9f6Z4YRA5CwYJxdzhureY+4ulcPRzr5kf6ONhxFLINulWaWCDstE5/UL7C?=
 =?us-ascii?Q?ec0Fz0/nS/gUOy5i1eUPADS/pk6XZPSPsgMQnjWXhu8HsX4rsLMwXOOTh4UE?=
 =?us-ascii?Q?GSAz9WNtNMXNx1/zS+fu/B/+IQGhQMW8U8H5SHa6QhO32318+RBp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe20f56-69d1-4414-e620-08df078d7391
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:27:02.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbvUE2G0aHNKrtaHWD9isSQ0FlDPTZ364/tScZ7bO+8kke6GFOBfCVMLUXN2nEzO+wLFBbyLfqCAFSUEn21neg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1802

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
Changes in v3:
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

