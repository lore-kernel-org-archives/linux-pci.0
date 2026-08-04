Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021078.outbound.protection.outlook.com [40.107.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E532B10D;
	Tue,  4 Aug 2026 03:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814752; cv=fail; b=ggLj0MnNDQBdrASgn95wdmx7piRrMKqdahfXYxCkkW4235/VHLJV9A23wDGud9XJElSd4q+7YnnxqxrnJDmC2iCs6NMzBnejFHBop/rC0Y4kLHImlBq3Eubn1SC3XjbyWZq1j+jnU9PrOh8cTZzppt4ASvw8MskAsXeYyBEKpcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814752; c=relaxed/simple;
	bh=Sc5Y6b5orjtTFeMDcRdO8tC48KRDSnhzQO9Q6vBf9E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nhhnKYttXoCxAuOF7zA7BWMKNOon9lhmFdrjIp6jcbXRFRNVm3MdtLlORbO4yILPCz+vgStkafZFut2iVyXcx8TOtJH1jfTh67Ga5thLBnqxsvljoDMp5BxZr+MOb/b2Tsg9T0V4DYj/c0/Rk73sNf1MuJy8b/i2q3dKNcLR7ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jDbQVtwD; arc=fail smtp.client-ip=40.107.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jDbQVtwD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRs1Y6YZ3kfLTFcmR+Ei2WbvLSUzgcFcmLZzYu3Bks+RTl9oLFylNRaS1Fs8sPoFkFoZm4+kTJCDfOmOoeEag8LMNzZw/8GeLQmz1zSHfKvdvzXzfff5DDQb0hrairFkrmLu8878ChnsRIObtb6DeV+60ZDib+Me+BbOJjByGNQ9lHWB9iA43PFxqpm0z2INeRqMOu1r9wfeZLxCT1g1CCTS6iy8NvoVjBAz4OcJKRBn45WjzicAK3FcOl0Fp3VkjIj/iwn53NZQC4PfZpGXPyldbAOIIjzDzZyD+zU+6SZG4Er1PycvCk+LZ6mIOS19yVucSoXbQ1b4L6yfe0Welw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veyFtpKN+1UaIm/H3y1DwQqzohqzoPXALdWklV8e/iI=;
 b=g5KvbAXHDeZtYrBYuIdDQR5rb1g1aWy5h5Q2UgUrMvoYtC5US7fHxInVgYyb37MHx1QAWeGxKv3pUysvX69aETHo91kYfOmuSMfc2Th3Sra+NEPQ/QhWCW4zxjyu9t+Gbo2Ur1QiWq8KIZVYv4eEQYVylD10z8GJnGal0VCl5kno2MvTphZGTS7IzUTc0uU8QJcqROXHQSyGUo9+SfFI90P7Ip+W2wc6EvFOWpc41H0MDQe1LsG+hV3gnAoZ9Cl1dYra9dohCFFOQizWPqgO6B1wG4F6SXqF1dHxgxHbMQCJgZvpL3welPcW05FLTC0uvv/Efx7T32NtNRsmMmE9qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veyFtpKN+1UaIm/H3y1DwQqzohqzoPXALdWklV8e/iI=;
 b=jDbQVtwD/ueRVp4P6CSBfZ2Bt3LXbdsqnszXxKAcZqlWvPYmtq695UTZuspOBArTSbxkiYRLqL9ZqgS685n60yLz/g+Qzlul8XvuYXr+yUFWPEg5+Qi5+aPJ7UV8/A881auGgXLp9hR/0oWUcE+h4D+f39nxBTGmzeokX+amCsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2080.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:188::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 03:39:06 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 03:39:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/6] PCI: dwc: Expose endpoint DMA resources
Date: Tue,  4 Aug 2026 12:38:55 +0900
Message-ID: <20260804033855.2115817-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260804033855.2115817-1-den@valinux.co.jp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2080:EE_
X-MS-Office365-Filtering-Correlation-Id: bc498737-c90e-4840-d1bf-08def1d9ef4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|1800799024|376014|366016|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bhdBO63fZ+i63ExNm+ANouPF2Gx4Q3cP68sr08yuwN19QZiKLTolJuEJb8AGX7QB3mxGjA27Uy/tBl9/gHGCxA9Itla28Hxm3aBH3fGYsEspv/fZ7gWJfNS18cSCsUX34aF9SVx9h+biNnCzjk7mCgarZe+HaQHgQfS3UMQWYTHVLJthjQeg97VBlKu44T7SdyDFZL7xhnje7uHfv+nre2+i3vuLWulY/6N3belUhTqQrbiZMM3cQRuFUapplHSgthji8+/djrRr4wkXWSYx15XzhuvBZo1FPemxfORu0BdJozAanFZeAytD60iwdfUvNZoUKC2mDfCtxoIfDdL8HQTEHiKADzrPA8XhuDHgp5RoXHIoL1h0J1NQgijznKlsLh02i/lkCN3ZqE06qxUB54XKseBG3O8k/BkkXdxM0G2py3YME3jBL0Sj8lYyQ49hZvG+bz4WN4b1tgIV/asCuGwyNU3WjG/MWsIJDCpeP12xU+gO4hN0w0xKcXm/rqM26GaZ5xClIGc/YInJV83VDCKVvN6XH6l5Mj/Yn+ymm1wjhs/Ay9CXzbIv1Xq/534OqWzQD+ohiZKgZDqJRwEQWf6b2bO4J9J3gv7NXsTOMuvbsDZcsYfF4IyZjp6QhrLH0NhRV/H6raK5BQAfVrbHgOfF66Z+jKX222vaAWCro/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(1800799024)(376014)(366016)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TpUpQGD45ZIgIKdbzPy/ymIQ85X870v9MnVTn+/gyGbOW9JAxUTeC5jRrK5H?=
 =?us-ascii?Q?ppORFLLz1Z5EQxLD/OMQMQOZmReB+PlvTaRW5Pyzm0nm/wfpAk2y+tBXwTKm?=
 =?us-ascii?Q?h7u+uCjw9JwVTSf2H9flFXBjZw0ijeIVO1108opv09VaLDiFXfaWcREzwzdF?=
 =?us-ascii?Q?IehJPD20ribzRmX+mnAoWslyxlXqvkScikMzqlycPLtdpawOtycIV7nMMZOM?=
 =?us-ascii?Q?ppGQp1Xwbg1bmpHb80QO7ntUYC0al2INT7jgA4n1fiuLhkwjmZFsut99Q7S+?=
 =?us-ascii?Q?4egJ1zlTNaIWh5Ue7cWQxfQeqT/0N89GoHNffDPBjIaZgMxSsVWugP+/NTTq?=
 =?us-ascii?Q?J+2aoFL9R3tQgVmJRSI+HHvvCGIxls0+vLedvQ2bK+VyIUfnNMeI+zh3RPmJ?=
 =?us-ascii?Q?vGahJ6XSG76vnLWjPeOVOTmyBDp5pcbOmSaT+b2A2ko0r70kjSw0zROxjXaO?=
 =?us-ascii?Q?9GlCPkpPDnbxerDqEyfKaXOLokI2+T4jDcY1s8PlemIFxlrllNngOTjlOAev?=
 =?us-ascii?Q?0fbIcjXyPRGaXi/gMweq70gUAcWgVR5qZXeoaFLr6SyVuW1/h/AmXmLGMpgt?=
 =?us-ascii?Q?UiZaL8R4WOfMve0nDQC8PF8zqr/kRqN+6SN/rcjL482FFHYYEolhJh/U5Ujt?=
 =?us-ascii?Q?JK97OabUEcFRWoFi01/x0gbGKsnLJ62vNsuRROSP9Kg9nYsY/ddhRi16IWIu?=
 =?us-ascii?Q?ZOBBT8j5mT8NpBj1cR3khqIVAI2S7qJDaQt4EHGRBq/1fuNLRIKAvMMy/RlS?=
 =?us-ascii?Q?GB61WayfGwQ2DeN2TTCPu5OOuv6E3aec4iTfCAQhkuNJ/bg0iCM83r2Xl6D3?=
 =?us-ascii?Q?iuD8FZ7BlCWkKkelzsCKxNsIOQK+QVjFVuHb6r+b0Q8RGqtiMjs2wAQkO1G1?=
 =?us-ascii?Q?/yCOmCL7Gj0Azt9JZwDg8YunEnTeyU4lEX0NcvlwxKvexb2V20smJsGw4tY3?=
 =?us-ascii?Q?37CX2POxh5l9MW3trYhDyR35/Ag9JCi4FuELH9wOVS7clOs/GCmnl+6wHHwv?=
 =?us-ascii?Q?RAc590BnVsfQND246gVu5hUctP5CeNOnDPJXgpRbyp3r8UWRMK8KnwZggdL1?=
 =?us-ascii?Q?PtTQgV/ezYPoeAPQxfjewU7YKTDS1oy01VGb5xnAxEH3/zBWTQ/P8OTusYRV?=
 =?us-ascii?Q?KUtT7Z/26353znKgyOaRns0XiouucapYOKDEh4Zvruis1qdoUL2HO2/P5Mpw?=
 =?us-ascii?Q?sPJ/x6cjWyqZP/PuIlx4x+aF2k6Ls6VL/VYb15M1YHITeQPrYOwSmfgfvCXZ?=
 =?us-ascii?Q?QqRKWwEa+u1XbN9dZt1WQGvAC0rbwJVVwXYdMJAwZvx50SsBOtl9OD0q8s9u?=
 =?us-ascii?Q?pat9TwalqUxVyHuTrfBjgdjMMCa1mV+ywabvwys7AGSyTStcdUi6CLikL9rv?=
 =?us-ascii?Q?GFrZ8JPAu9pJd0L7QkwrorfiVu0f/yalH4NMQb3HxeFmdTSkCiIGhpDKlt/M?=
 =?us-ascii?Q?qN7QMVORaBUWNKodAuIE/oRVqpTj79GdRtCQFA/JFXBTWkR89rgWnn1vacDp?=
 =?us-ascii?Q?Fb4loScHfzdOF1aByiDVj/ZppvYR+GbB1XTKYhoHhGvqKCtUoBGU4oa7nriO?=
 =?us-ascii?Q?JsNrbla1gFUoN4lgyaLS+d5jl4dD0zDFkeGsTvh8qsHiQXjBlGlDaki6MUL+?=
 =?us-ascii?Q?1oIErPBRYDQmsWfZOnpIaCY/I5ZbGreg/ey+HYdxUhGkotkcYk54gQPTjfbR?=
 =?us-ascii?Q?oEy5qw/pSdHZxN9tCoN+f/z8sacV7Er28l0TCzv89ihv+1NV/NHN1dTm/cYQ?=
 =?us-ascii?Q?t6VZvu5he4eA8Kp/RkRGmlvsbtE3I+gLsGH8InJRfDhfByRU+XiT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bc498737-c90e-4840-d1bf-08def1d9ef4e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 03:39:05.8798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6qsLtJhG1GTuhaBAIiMpvr5cnDOF3g8iV6It7emY7lnyAynY0+70gJucqDcpJkO14bEGcCUBC+Cd447nPeEHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2080

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
Changes in v6:
  - Use the same DMA resource state for bounds checking and array filling.
    (Sashiko)
  - Move this patch after the delegation support so every advertised DMA
    channel is immediately usable. (Sashiko)

 .../pci/controller/dwc/pcie-designware-ep.c   | 138 +++++++++++++++++-
 1 file changed, 130 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8c1ac9e3c517..440311e2bed9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -858,6 +858,22 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
 	return NULL;
 }
 
+static bool dw_pcie_ep_has_edma_ll_resources(struct dw_edma_chip *edma,
+					     u16 ll_wr_cnt, u16 ll_rd_cnt)
+{
+	unsigned int i;
+
+	for (i = 0; i < ll_wr_cnt; i++)
+		if (!edma->ll_region_wr[i].sz)
+			return false;
+
+	for (i = 0; i < ll_rd_cnt; i++)
+		if (!edma->ll_region_rd[i].sz)
+			return false;
+
+	return true;
+}
+
 static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
 {
 	/*
@@ -877,14 +893,30 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
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
+	if (dw_pcie_ep_has_edma_ll_resources(edma, ll_wr_cnt, ll_rd_cnt))
+		count += 1 + 2 * (ll_wr_cnt + ll_rd_cnt);
+
+	if (edma->db_offset != ~0)
+		count++;
+
+	return count;
 }
 
 static int
@@ -897,14 +929,34 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
+	/* Keep the bounds check and fill on the same provider view. */
+	ll_wr_cnt = edma->ll_wr_cnt;
+	ll_rd_cnt = edma->ll_rd_cnt;
+	db_offset = edma->db_offset;
+	has_ll = dw_pcie_ep_has_edma_ll_resources(edma, ll_wr_cnt,
+						  ll_rd_cnt);
+
+	count = db_offset != ~0;
+	if (has_ll)
+		count += 1 + 2 * (ll_wr_cnt + ll_rd_cnt);
 
 	if (num_resources < count)
 		return -ENOSPC;
@@ -921,6 +973,76 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
+		for (i = 0; i < ll_rd_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_rd[i];
+			u16 desc_mem_id = ll_wr_cnt + i;
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
@@ -929,7 +1051,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  sizeof(u32), dma_reg_size))
 		return -EINVAL;
 
-	resources[0] = (struct pci_epc_aux_resource) {
+	resources[count] = (struct pci_epc_aux_resource) {
 		.type = PCI_EPC_AUX_DOORBELL_MMIO,
 		.phys_addr = pci->edma_reg_phys + db_offset,
 		.size = sizeof(u32),
-- 
2.51.0

