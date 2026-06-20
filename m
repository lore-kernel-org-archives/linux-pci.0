Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021087.outbound.protection.outlook.com [52.101.125.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23824275B15;
	Sat, 20 Jun 2026 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975108; cv=fail; b=s+oqGgRTB64KlP2r6u2STX3krO9IAVcxE5DnLPn8oL059llbRxFCbDM9hpDSpuSXJrFdh29ZcVbfy+s6XoU4FA+dNtNXEXZyKp0EfQ/nv0KE1XzwlnIAckHrXc+iRGgvLcZtg7LX3VUAOfmN4QY93rGdThYHsZjMKUhR7E6u7N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975108; c=relaxed/simple;
	bh=zMq4L5BqhBiD+yxh/rNlVhu56WY4LUHjQ/qr1E3sqbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=se6Hk280t+0jv/GbuRES3xMEA2OjboAjOk+36C/R2DXV+nDg6qV7DXoYkpkFH7AUsaR+ok8a4X964xV98ziu2HrfzxoF7CVZjBTlHN4lrbYuPhfUJJdR1vHasLGBzaRjnV3QVK1Hlj1B3pjRlVs9dnlYeCPZ8lfGm4KqzQWPEu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VYtX0x7E; arc=fail smtp.client-ip=52.101.125.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VYtX0x7E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTakNPThCW3nbL/ATSpaY4Q68mEKkQrk1JtatuItVLpLUAU36D7lnWzI4DjLV5HHJ1/c+67RMc/kd3Y5kXKqedxxtGuLRRrUST40ccfdJXHnPW5qIPUfI9gbcrnp+YdybmOlnba7n3Gl7qkkC0VCp6YQbZrunkiGZlw7EKecQBQMiOPBYTP6BRKsBIxes0NzUF9WCCLM3q6VzIgkjyLSAja41UIy6J9LpwK4Ilg2hcoGHfi3UQTCwJDCIV7NCVZAFzbmVoOLvreqQralBDbuZfEfK99Lnsd3UbBpY3c/wA+wQB2XMmg98cJMXustDhbwdEzvsmHcHiapws+i/zHzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tD2YwLp06x3AfcTsJQcQYpYXjy3mZ9Yim4Da3nmSw8M=;
 b=CYnxpP6zh+cZsxYeqPMHtG0+D2pYDvSx7hS/NCVOugdfsBv1IFtxmkA6wDK1JmmjByDFPP/b9DvxejKDUBm17mec0r5zB3lpuW94KpMCk+3wlz5XiS8MjcmsAi0seYkCHNh1rPxDrrGldqxQpgoXAO4V5ef/HSaqeEcoVToXxKhhmBUuNBFkJsR7Q6NMsA/3aTNfnPFyJYd0BMbK9Qkrs05Ux2ShNAHbNKD8yAHA1Rjh4V8SO2YxrbIFUcMGml5Iy5ZGWmcJFONwhRc5XZJW+bEG6/X8xIJgWaEDoR+j2WbdG84ItK/dJPuHRAijhE3Gp4Wqao00nQ0qcUO404REZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tD2YwLp06x3AfcTsJQcQYpYXjy3mZ9Yim4Da3nmSw8M=;
 b=VYtX0x7ELWLibwA3aFSrUlKuJ+25WnM0Zrhi7YBTbzBRQMt5gbtjKTMNaN/zStkvytTA6TV2dLkp7Dlt29zcC6SCT4nw+K1wZRt44HzYUlQvJ7osekBqxC4WlcJ17XzBVQc2mGctrrCrzSlwtMf90jhVmP3po1DCUnBmg1l10ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:04:58 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:04:58 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 4/5] PCI: dwc: Expose endpoint DMA resources
Date: Sun, 21 Jun 2026 02:04:37 +0900
Message-ID: <20260620170438.3756593-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170438.3756593-1-den@valinux.co.jp>
References: <20260620170438.3756593-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0244.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b6124f-efea-4298-eea9-08deceee0f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10070799003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yMjjhF3S1hrqHxhlh3x9CPCl28rJ49hEW1/u5Q52nvzWtXCS0/gSv6a1MJa7Xn9CYMmLwEN5x7BW/Wqe/zWrrIIKqWpza4sq1o+mXH9j/yFGzp7lmlUwxLmRi4VNSwOFjPYgJd6bUIYlOi0/zCa/i9ToC/f/IbOuMBwpJ1tGu/BirEAbxSzZaJLz9fV9DUqhFZjuSImNJEx8SOFQEoN8ZgFpC6s1KFHq3ZLyPqoJBNVQXIE43MY3H9iDtBadmXz+wYKtEuoqz0/wdlkG5DtjfPbjLK1zrGB727O7Gs5JP5N5moDBRpob7/s4UiRvqR/qff0DxAjfBl6NyNeRX7vkbNwi7hwGWvH/4fA3qQfSM0N/HBR6rp5/IDEd32DCVtZX4rmy+yBPW/rsLaiUHFHyvsjgEhyu7HhybjaqnbhSmfEshrfK5h0FGnUfRPIVt/EJaSc3yHieO351UCG0fuWtCAoxiFhkwy3NubwesyI7oH5IPQcQ7rV3r+cQIan5YaXQl+dEMzLrE7nCEjuhB6b32V23D99A6UJ43XOhjSEaryFDteTocm5JKjBao7Y3jfKHt5RnWTC293Qu6wsRax5pAl5xESXuzMxgfoKDIHjQR54DbBSAHMGMci0ZEVSb3zXO3WcuXSXJiZC5IlP3E4oBSiH2j9WfqPjuIlHxYlA0Leg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10070799003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?akQkHF+GARcmcgJPq89OMrIRaRhm6kHubhMI+lTIwOHNDzpx+Am++jOKN+0u?=
 =?us-ascii?Q?AO3xFCD+33Z8JmAbgTlt3kK/+P/6MgWOdpILr/+uFcauGmgZcmGq7Xxi7Ul1?=
 =?us-ascii?Q?kq1igg5y8AcrDb888Is0O3MuRUgxbNbqbESJ4U1zyF5ho9iD0d+9Ua6C9bq5?=
 =?us-ascii?Q?JN3kBgtt3/odBi+bWSP+dKaKaVai+w5mPBvvohdB42f+DXutT9LHRKd96pbp?=
 =?us-ascii?Q?pHLximoITpC6oHsB4YVKEEQvhPukW7GGJdN4HTwSXzBStfbwqbsAUrppuWxO?=
 =?us-ascii?Q?t7jtoRX8QqbBvefuXEFjUMJj3h8A2qgPh4v2CYjZF7nPQWJrdib0mKCaqGwb?=
 =?us-ascii?Q?tBd8v0u15aZEZoujzEabRt2g2bQlUThFNQSmiMrGZGl+YDHEdRJZIpDyd0/C?=
 =?us-ascii?Q?/Svvuc9qRk2rbNVgwlDkM/dGIw8Q47HgubPsZYBG13px4WLoW8SuvAVOUbE8?=
 =?us-ascii?Q?5UJtMet0W8Q9hr62kieK0h4iyI/QsGSYCIB9LjoMA4ZIFgryXnBZ+xJ9SXxA?=
 =?us-ascii?Q?yw1qAj96wKpv4+V2TMYye1fuXpfdjEN5fgZtqIhKpzqXQJXehIwbyfoGqApu?=
 =?us-ascii?Q?VvamqHfpIHO8Qh/GB8vaDy15TvUGQwv0KNtrG2htte99jhr2g96rEsUwvcqu?=
 =?us-ascii?Q?2cs4LEpiDOVU7YZbweEx6ZLUHWlyNJAoybjOZgker4uzTGMXtPxPPLk7oosf?=
 =?us-ascii?Q?uAxgYllsuCTQZczpiMMu1X9u4YJUD3PQ0PrP26EkcYGQOm1K07ShgQJj0lr9?=
 =?us-ascii?Q?OHvyGaB/OyaxUzgFX90ZxIQYBlp+Zjv0OJ3pL2H2s900c4jY204QyzQhza1Q?=
 =?us-ascii?Q?2obKeq+r9m1aoe1L5MzAf96GEnombvMLxab0WnCHwp6/3m4izpNuuMDzwQik?=
 =?us-ascii?Q?tRAfNcrismuuODotxosIFwrsHlOwndYt2ybqgQj1gK+EXRgUd9AaABQVyEBO?=
 =?us-ascii?Q?mIMpMKua3rD4mX8bMLnIekQ7t8aRkLDWOao74LK/tKT0xgWiL8iDxQhkE9B1?=
 =?us-ascii?Q?chlvRkLq9Q6BopjoNEai1HEz7RINehcqG5XNTujDmV3Pg2V9g//f9Uu6NIU2?=
 =?us-ascii?Q?9aS2CTx9glkEjZuKH5Snv30QhVrqLuMM0KG1iY9kvgTnlc2BQZwcjQwKBJJn?=
 =?us-ascii?Q?qiqq+NNOUV6/SdYu0sQvDnFNcJ7T97r5yGvX9RcAe8ESVRA2hRjgFTg62SF1?=
 =?us-ascii?Q?+X8L1nZSZWT66X6IGYnU+v9dPZM/CZGrBzTPsHnFad7ZzVM0UkoIP72Wvc0A?=
 =?us-ascii?Q?+1KxCfhRKk9FyQu2p7cmPbXquydLJ/U3Q5IZbWjUN+4pXjAL33Iio4fgOJtq?=
 =?us-ascii?Q?U3NPzE/Rcush23mfcqUZk/vTOpWHddX1qK5G795xFOA5wRGjtJmWZC9sjKLZ?=
 =?us-ascii?Q?3IpCRfGz/PT4/E7XfdfVNXJ6dOYACyx8RrYX7ZnTWzZ61Q/Ze0CNOo+hwPUf?=
 =?us-ascii?Q?JVmq0BC+zjnC3hRvTQi++rY4UIIY4TDWriGiQBaXynxOKJn6/yFAONJMq0si?=
 =?us-ascii?Q?Hll6HvF14jcfJvTGK8ndRE97S3zEzDBB2S6FYhconx+Mf5RXMcT4cENwFy1l?=
 =?us-ascii?Q?rH7FD9a1PEXghSQbJEwnVAAeYohpwBO2ZEFg2JytFL1gxPLCt8L2thruUSZF?=
 =?us-ascii?Q?eZzmIFCKV02Q2B3JgL/W4QjM5FLaLZAUrvLfzKeod0zl/LjOZrZFRGOAqF8L?=
 =?us-ascii?Q?e+vekWsIJrLh5G9+emNvInaLbLcF6NqyUKb+FJokhMmRyyRN+Kuj/rhiVRfX?=
 =?us-ascii?Q?jS1geIr+ttHKQgXzCP+s3xWmmEfZ5BbWQpq1LTTS9uCIyy1tgRG/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b6124f-efea-4298-eea9-08deceee0f3e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:04:58.7009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwN34WOCEI15RThVyE8lwV8lEjRmvFj5nbhPpPTpWijtJYOLyMD6AnC9mcfX7eGrV/9qR+j/p3uzrEYKAC76IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673

Expose the DesignWare endpoint-integrated eDMA register window, logical
DMA channels, and linked-list descriptor memories through the EPC
auxiliary resource API. This lets endpoint functions decide which
channels to publish to the host.

When the DMA register window is already visible through a reserved BAR
region, report its BAR and offset. Otherwise report it as a normal
physical resource so an endpoint function can map it. DMA channel
resources carry hardware channel selectors and refer to linked-list
descriptor memory by ID.

Expose DMA resources only after the local DW eDMA provider has been
registered, and only expose channels whose linked-list descriptor memory
is available. DWC non-LL exposure needs a metadata ABI and host parser
extension, so leave it unsupported for now. Reject VF auxiliary resource
queries because the RC-programmable DWC eDMA/HDMA register window is
assigned to a PF BAR only.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Report logical DMA channels separately from descriptor memory
    resources (Sashiko).
  - Use channel-referenced descriptor memory resource IDs instead of
    embedding descriptor metadata in channel resources (Sashiko).
  - Stop exporting DMAengine filter callbacks through EPC auxiliary
    resource metadata.
  - Suppress DMA aux resources when the local DW eDMA provider is
    unavailable.
  - Keep DWC exposure limited to linked-list channels until non-LL
    metadata and host parsing are added.
  - Reject VF resource queries because the DWC eDMA/HDMA register window
    is PF-only.

 .../pci/controller/dwc/pcie-designware-ep.c   | 120 +++++++++++++++++-
 1 file changed, 115 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7d2794945704..770cd7efe699 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -858,6 +858,26 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
 	return NULL;
 }
 
+static int dw_pcie_ep_check_edma_ll_regions(struct dw_edma_region *region,
+					    u16 count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (region[i].sz)
+			continue;
+
+		/*
+		 * To-Do: Add non-LL support to the endpoint DMA metadata ABI
+		 * and host parser before exposing channels without descriptor
+		 * memory.
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int
 dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 				   u8 vfunc_no)
@@ -865,14 +885,35 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_edma_chip *edma = &pci->edma;
+	int ret;
+	int count = 1;
 
-	if (!pci->edma_reg_size)
+	if (!pci->edma_reg_size || !edma->dw)
 		return 0;
 
-	if (edma->db_offset == ~0)
-		return 0;
+	/*
+	 * DWC eDMA/HDMA register windows exposed to the Root Complex are
+	 * assigned to a PF BAR and cannot be assigned to a VF BAR.
+	 */
+	if (vfunc_no)
+		return -EOPNOTSUPP;
 
-	return 1;
+	ret = dw_pcie_ep_check_edma_ll_regions(edma->ll_region_wr,
+					       edma->ll_wr_cnt);
+	if (ret)
+		return ret;
+
+	ret = dw_pcie_ep_check_edma_ll_regions(edma->ll_region_rd,
+					       edma->ll_rd_cnt);
+	if (ret)
+		return ret;
+
+	count += 2 * (edma->ll_wr_cnt + edma->ll_rd_cnt);
+
+	if (edma->db_offset != ~0)
+		count++;
+
+	return count;
 }
 
 static int
@@ -888,6 +929,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	resource_size_t db_offset = edma->db_offset;
 	resource_size_t dma_ctrl_bar_offset = 0;
 	resource_size_t dma_reg_size;
+	unsigned int i;
 	int count;
 
 	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
@@ -909,6 +951,74 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
+		u16 desc_mem_id = i;
+
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CHAN,
+			.bar = NO_BAR,
+			.u.dma_chan = {
+				.dir = PCI_EPC_AUX_DMA_EP_TO_RC,
+				.hw_ch = i,
+				.desc_mem_id = desc_mem_id,
+			},
+		};
+
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_DESC_MEM,
+			.phys_addr = ll->paddr,
+			.size = ll->sz,
+			.bar = NO_BAR,
+			.u.dma_desc = {
+				.id = desc_mem_id,
+			},
+		};
+	}
+
+	for (i = 0; i < edma->ll_rd_cnt; i++) {
+		struct dw_edma_region *ll = &edma->ll_region_rd[i];
+		u16 desc_mem_id = edma->ll_wr_cnt + i;
+
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CHAN,
+			.bar = NO_BAR,
+			.u.dma_chan = {
+				.dir = PCI_EPC_AUX_DMA_RC_TO_EP,
+				.hw_ch = i,
+				.desc_mem_id = desc_mem_id,
+			},
+		};
+
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_DESC_MEM,
+			.phys_addr = ll->paddr,
+			.size = ll->sz,
+			.bar = NO_BAR,
+			.u.dma_desc = {
+				.id = desc_mem_id,
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
@@ -917,7 +1027,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  sizeof(u32), dma_reg_size))
 		return -EINVAL;
 
-	resources[0] = (struct pci_epc_aux_resource) {
+	resources[count] = (struct pci_epc_aux_resource) {
 		.type = PCI_EPC_AUX_DOORBELL_MMIO,
 		.phys_addr = pci->edma_reg_phys + db_offset,
 		.size = sizeof(u32),
-- 
2.51.0

