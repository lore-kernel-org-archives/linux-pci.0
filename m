Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D48391E7C;
	Fri, 28 Aug 2026 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936989; cv=fail; b=sce6+ov9lx8kl9IeWSwq9oREPuGtZ4SsShcIYC7NPG40p8FNPY7M5r6ySE6hrWGzAW7YAu8gKiwqumCVspoWxu79sl8x05VvRSAqo66fOB9B9kM2O2PPa8G3563CqjArkUv1yhZNDBi/jEB0n20Ff0sUR59i/Ec6dvdpPIauocY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936989; c=relaxed/simple;
	bh=lVa1fArIrqRFjwnfRBJaRai4VLIYaO/MnvQDAAWyrZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Px/q9iOnaZHWJ+cfK22hGDm61ivRpnzD5Ta1rYNmL6FZBiHvg+NXF1KISftyO9iUc5qhiSh/U+j0DQ9z61ntexk5tPbEuFY7SSzDA9STH4T8iLF1J+z34UAStP+AfkiwOUu1QbsIcTZhtwqe61ua7oU8Z/0BFQA460WavJ0usZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=fePDIoNd; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="fePDIoNd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+qND8RfasAqB01YS3AFblnEsV3XEVjlJnBQLLX1P4kt/Iy91QyEbdMSSuZSbNP6yjiVjXJx0yDItqvbK4t93eUhZ8PHrXNb/iQlRNIDkm0Z4xSOvKJkQGG991gXYAHf+n0y3v2RR8is/8LdB7u+LINB2AiEADEexJ7Y/Ep5ikJWsng0LjuOLShQYJ3Sk74Vdg/iI/dEOaBBdtrNgnkpxharTBMSndybK+ErfspVOoaQxVzZjXJOAqKGHNbouZ8z7ET0ZvhyaxYBqzpLWezwzWosJFbgeb3qMwESHhhCt/0xwcjnsCccCuJrfVMWfp2n3O5qTigjbA/tul+tLYz6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBysjQNyatnjI0g7wPvt68TPWdqBCw93ODOQcBe3kBM=;
 b=R5mMho6KuL15aIikGudw6kQecG+sSfYBvqDNnyChbnoo38Nj05CIoyhyRLc2Jk1+3vIKi0kZOEVgkJPY1NGGDN6ewwI2KKFd+oA2xK65BxZ9vHnkNzgBEs4XYvKuQ+e9RrjoM9FMrb9I2JJBNSIqM+sJUkE8Cjx4SbA1Woo+ShstJOKIFlqIhLgXv9eBfcWibX7tUyj9ERcWlBNNDlcldBXqwHdF4fWan6Ou3PbpfQjd5ljd5Iitf+aKbunqokqa0dbVFy/6tj7u82BWhy3e1z5Sl5u2NqLQMFm+j+3yTE4UwkVwXzmDwnhffHSPmjQrlZQDAtDWMITTwQLx+0+xYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBysjQNyatnjI0g7wPvt68TPWdqBCw93ODOQcBe3kBM=;
 b=fePDIoNd96zT293m1pU9XPygZuOm6zqoZQgwlPIo4FKesXOyVMjnF6AKGiledAwtHvyFP4IpgOUboK9nKKReUVZl8tFbgBi/vTjzm16v1favge7cYpUya+/zuf+Oi64SjKF9BdtrL6OIrxtny1hoHem9EVHk3Eyv4kueIeWtRa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7951.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:09:40 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:09:40 +0000
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
Subject: [PATCH v2 2/5] PCI: dwc: Expose endpoint DMA resources
Date: Sat, 29 Aug 2026 02:09:29 +0900
Message-ID: <20260828170932.2735807-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260828170932.2735807-1-den@valinux.co.jp>
References: <20260828170932.2735807-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0087.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a3b867-bdda-4225-2f48-08df052725cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|376014|7416014|1800799024|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8PgqlnxuTHDEequxnG9YYsZxA65BCGnorij4sRkb/1RfGBuHah2ASF4Ugwe86kWD7Wr4BTHZVtCnQTHLpDrNcCVDgkbv/ZLYpZtONUImBua9+Xvt1Cdu52gMlZNy1z0cYdgD66nuMkr+f/lwEg5VZdn5Akm9VZMRLckBP0qmUmYtCyNTaoc/fo05ZXiTRahIHyRjc2gymeheGRhZ13T6kaB7wUu+z0RdWCMb32IIgZM7IjSmEgI6pxiegFhaTyAsjXkt341bYaps2h6qM282SkVx6xdnekh0I9mxUAMfMfzYjXupuTQCCRKm7tiEiaYgCz4A6BHcv11rgQGQwxCn3fB8sBGLGELZbe/418x4wW8y07Qdy9RkR4KipxYnfbeUEgzIhdRkKOX0Dp+awxqBntfXkYgK2D+WYE8nLsvOx/Hh5OG3X3662XtBzNC65/56/LurEXhgu+PokGHPqtMyZCSHAV8uSFh1oKygko+F2wvAOuP5hm0cH99R1eziOb7Jek/ui+Z7lSBMqFhnnkTgR1N/6TEcRwEUNzw8A2Bj4iMHG5m6GaiFfOGDHJVxs2bUa2Fs93QlqJGeV6C/lRnKtTgEKtKnmuNtaQIumm0S95suAaZNouhzC2DYbyQ8jQzD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(376014)(7416014)(1800799024)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7cxmvs83a+LH6mbsg0rpPw2Rycrn6Dj6u8v80KAR4Md68HLq0JlznBGasHyW?=
 =?us-ascii?Q?imxV039WOCqwoB+pc8a6oAZB835w5aI9yImdZIJ03ik+FhfS26HCfVVO8Bez?=
 =?us-ascii?Q?UieLzt/YGAGapAY+p1mVaWGgQhQfbPgimsJIsAVyOSxY2g4POxJAVEkPc112?=
 =?us-ascii?Q?LOJDuJJDL9mGdvAy4pWct4c5HaKaqU5ViqHp++1ZN4Fdo9/jr7Yz3T8tS056?=
 =?us-ascii?Q?185zRdo6wVMsbtNz1PWqV67f0USVkXR9qJCDw8cNhNsw0OWpJdeioyL63wjD?=
 =?us-ascii?Q?QN9Ldje8M6SnwqwV/fmGA5CADgsvUelRplyIGpS1AzSMkok3NWuAxo/AN1G9?=
 =?us-ascii?Q?T3u9YXBW200txaw8NTVP/+HZFX9xKKEEzzBKKMxwCVRRKpHrC5jNzRQTHT++?=
 =?us-ascii?Q?iIhrG9TZg5wSbGvXJgpktStaFCyPHzzI8JlXwc2Iejw7qwiP+xqRxUz/dF63?=
 =?us-ascii?Q?mkApykyYg4u00cjOfa4yw5k1G33oy3hNGm5+p4qPGiA3ZpjNnhowu+sekyq5?=
 =?us-ascii?Q?rFt1sFr0psDZQmnuv0S3VYZqu4GDauapT+jPSK0YiDRF20i6/GUUJFCLR3aH?=
 =?us-ascii?Q?a7UkE105cTQCz09/cQHB7528CyqlFBRsw7Dt3hN1/q5Pm4G5PUpDMcbViXXp?=
 =?us-ascii?Q?LPI+yLSNt3F3scklc+mghSrxcgYSzCSSPGYoRzND6bVKVIBqbKgUCJE3MvwX?=
 =?us-ascii?Q?ty1AiqRX3ZTf5P2Bok3M5t6ekSda0CbQ9kKWB3b1/O5yn87rJKqd8w6MfwO6?=
 =?us-ascii?Q?IsIyIe8HCTQdF8pKv082nqBjdc01TfABvVrtMx8X4m0as1iHQdtlmjJob+89?=
 =?us-ascii?Q?i93T/SauHfodfbaBxJ8NirbDyJvRzTd8Ie4G0mOm7R67OvnIHB2Yg0uY6ns5?=
 =?us-ascii?Q?Gk3yD9IUxrprUXLiwBI8ofMlglHlMRAMsjexoc/TFlw1AKXiNAzwxhAKg3Iq?=
 =?us-ascii?Q?0plSmkDL56sgB6dA1+FYfS4bWgc9cewUmvXRN0TS4YKUUCHEuQHba8fq52xe?=
 =?us-ascii?Q?D2rKga7DSR1bqA1wKxer8X6UbGjMGIomUU/nf5KtVbh6uNro4oD0yRyI7iyl?=
 =?us-ascii?Q?nD7U+IU9mC2aZsIamHtt352aQgFpLLJc0nFEKbWtopFUX23ZLeF60wzQy3cT?=
 =?us-ascii?Q?aNsz92qsOWCCcAaNUAGa1g8WOf5VtuLg97u6e4nWGJFMV/fqSDUsEbsE2s0X?=
 =?us-ascii?Q?TdMT1gSyVXuf6ByAFVfSxKQViLw6H7iIY7/ANOTPa2hiZRfdMgrkEDs/Mp5o?=
 =?us-ascii?Q?fXO5YHUNPaag98eOJapktE+HXOGpqdgyFOkkteBXCxY7nTK12dVygPHxTPLt?=
 =?us-ascii?Q?ADGExXY+7ky7o43ppHMMjWT5zi1o4cxtW0BZ8CSL9zaKqUnzG/bZS9E346QZ?=
 =?us-ascii?Q?y/x281V9RlDBKBjN4qeg4tSzTKEKhWyx5ZYpzSav4qYrsy4HuMcoyKOSRZn1?=
 =?us-ascii?Q?A4KjeZVqcky7YYqSJVykN46hrvrzsNtFnDKUO3VFZh40RqL+WfE0ixsy8yna?=
 =?us-ascii?Q?ghZs5xTXXuE2k3NImDLZU8Ne6gKtvQeDGVBgQ0Tf0h/udMngHH9l7wXpw/Z2?=
 =?us-ascii?Q?jm3gpqkc2H4PgI9V7N0EOEZUB/iyGSa7wMdCwql3spPN7eiMRh8nmHfANmQL?=
 =?us-ascii?Q?GLyPwhEjB1S05506Ui9ou4UR6WVVJICAV8zjE13hDo3kkYz1/abABFEzPy1H?=
 =?us-ascii?Q?UIX0FCGr+OLhYfIcEuT9mjgYkk4wM/TjgNcsNTOU0y01+6ONbnxywbXZ/ZZN?=
 =?us-ascii?Q?iyGuuAnV+oc0JWqC8H/73IuGTKwxe8UcMJG9PLqKsEoQb6qyp3gj?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a3b867-bdda-4225-2f48-08df052725cb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 17:09:40.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6hu06J8DSzc1OXGpHozW9/9CI3BiUwyQNktyQiuSpPcum8+6whn0gN5D0N3qD12kj9/e1CRh0P+/+ql7JKZPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7951

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

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Rework PCI DMA EPF v7 patch 7 around static channel IDs and the
    reduced metadata.
    https://lore.kernel.org/r/20260813063757.3131865-8-den@valinux.co.jp/
  - Use cfg_non_ll instead of carrying over its LL-region scan.
  - Leave the peer-visible layout to pci-epf-vntb.

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

