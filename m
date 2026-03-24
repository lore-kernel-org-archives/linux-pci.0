Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021131.outbound.protection.outlook.com [40.107.74.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC33624B5;
	Tue, 24 Mar 2026 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341522; cv=fail; b=kDya1a83P3lhm0FgWBeoQ7O6VfDhFtErK39Tnk/At3ZJWyDBIbsxcQrAE2cFvdoSiuMNlvEoysJ2C+xKSszNO/OKfCugtXJmi6b7K0nTJDbQo9IiLKQ0nVsOcA39jxzFZmQsmlz+aB8iNmiGOn85xtfrt+5yN5OjX1jLJ7pFq9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341522; c=relaxed/simple;
	bh=VjgoF9kYH4XwL3oExbso47kw2kup32F+/2Jnrm2zyc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WBycgpewojG3ftGV41zIF07EJupZpRuZfCIZMTqxhayGTWhWeeVYcZYSDQl518/wlcCXshcImrOufjBScd2XA1/sJ8nintazi/0ZKo89dJKtKPfajvpaFTbnGTrEZD2QWonbaWzSbbEMNWfMAkcYS4AR40k2Cw/+s69g/oDc++U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uTGPKLxq; arc=fail smtp.client-ip=40.107.74.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uTGPKLxq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxBLKR2ghmU6hsc6+QqMcIL64AuZNm1f3zvbo8IfEFobuujBe8s/LH3DtWOK5pmTZ5IkAHyTLK1ZVDGylUIRtHU6F3jmnPSWt40GdQ5VKHkTLv9G3JQSve6lR8lg/qfzprrl11uerPOX0GXU9lF9bhIqiRaeZytLblfYvbc3hYktAIRqVcE9bZ8TdmfvigmRr3af5cI/JLZCDleR4Jx3qVNKUtXG8cVruVV5SHt10fCsms9Co9gwZcFqpKuOnJAl3czpsX7uKlyfX3EOjx9rDoAGNRcAPHY36deu72LsRtuKwjbwT/1pbee31gEEv5G7KTsEzuDn8O6M19caCuXLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKMqjGuT+l93MjCW10Wsk4/QYj9QHqTtvfZQuF7Wsp0=;
 b=SguKA1xile/9vsdbwWl4Q0DnN+DTJqP+PAu8PZxaBcJUtSf+Wz7az7fBwHzx9Dg2/unqSd11+6pGH8evOP/YAcL4L22bt95HhHIiX5Ue16mxgGKIUyBunXt0QZhvNYh1B4lbHA+nJc4+AMYQvgVBWeullMZcabR9v+nCTvmwrXuiNpAmsu1T8hlw7TZhkmlS83MG1CxAhnw9mDa2OpJAA8MimrX6upK7W0LNIGBXtJKaBtj7LsxaAHbWpHz+JAGqLQ6WQPK4NHsxS0Iu/kjWC4HIQFe7jiqw7NBJVS68WlB9g9QgorGnKVVCfC1c6cSDIjvWoVDXtYb47M5F1u2EEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKMqjGuT+l93MjCW10Wsk4/QYj9QHqTtvfZQuF7Wsp0=;
 b=uTGPKLxqCRyJUU0b9hKNgZpUAO76cQiCd4GKIgdnHi1uoFCt8HpA5fhrkz/xweSWoYnZk3vRMTb1PC9K++89EaD3QvnxpwJL9GlmWHD6WGidmxR02ss9lztyUeXlR+bppEeiYctWl5+q8iH4iZ654Sb2kJF5fcQp7kB8SkbWqx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6981.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:414::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 08:38:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 08:38:18 +0000
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
Subject: [PATCH v11 3/7] PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource API
Date: Tue, 24 Mar 2026 17:37:24 +0900
Message-ID: <20260324083728.3744734-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324083728.3744734-1-den@valinux.co.jp>
References: <20260324083728.3744734-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a5388f-2081-4e2c-28e9-08de8980b333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q59YslvN357eC6Uvra7XY/W5dSrRTv/6yVmEHbX69s4alQ37TRw1TaoXaKpu0FUgxvvfGTrLN0f1ZubZSJoo3Ev9D2s4y6WlV4XXYEclFPt976Y9YbuLTQJ1UvOsDcfnkonj+HzM2m0/u6/YeloGGxEsT+dw1FeInjMUmPcOleF1ccR0QOBM2Vkh123cck/brPMnGB1AlxjrWXChz9AVyPvEJ6wmGyTS5CjkMWTwrAPzdkX6oCaFPwToiPc0FyCrAuwvJXkvlvsJgSZ2V10CxSOI+a9dOdmoXBvH46PDy/p+mmTanY7fqV8Q/wWkL5iPOaVl2gT4JW427TuQhijxirP3lLuammm4UQv5/1TJXDwJdJ56TNjtWTsODQl9chW5Jw7N8YCxHpVAzisNi6t2oNdK44Vv4W+zc3ArDyzyZOyOs3U04rj97oLAHBHeatnbFglk0F4DCRRVPxJ04h18e5JeFRebs2TLxv9B9G0vs6yNhwzevoJxxJZsabmw4xnX3RH46BCmS3SYrSgRP0uV/7sIZPPioypMZZ3lL7tiL4g+qbbTqlilmzy81UbHzJV9ThzvVVfQSOUshtd4cuf4lrIP1Lnn9nBJRZRWpboi7OVuIwa99KWC2R7zs/x9dljUxf03OKxEXcuWTyiBZuYxyf2/T0p4e0JJwGSw8/7IXjbGyD2TkQc6QljRmbiOr6EQMJpucIj0rrwkCP0zFh4hIoZTkbCRlPQk2BfQum2YrvKcnBaXRMp3zs5kmGmXTymw8t2Y/VKQ1BliLFBNS0wPJQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+/RMkFCGze5yG7u8/pfPSXdwWYk9EnSwYQTH0xUbMSPcKYd8sm0jLTVpFOmO?=
 =?us-ascii?Q?VhfWgkZdR2VGLHHmSgs+dnkx2/LVxWIE4UbxPhGomMwyuunH8U9gLxPuY9gh?=
 =?us-ascii?Q?ITWt7Xu0hK7EJP4eQria/O0ngv+ZCNOyOXr0ntCFcXHUXEk1qKDgxRvjN3Z7?=
 =?us-ascii?Q?5YcP5avKjxdOBHSneDw7MpMYdE5PGLt6W7LXq2BG4WaWu9C2ECmpTC6PuXQ0?=
 =?us-ascii?Q?G8L+Tt9o0t8/qe9eqZwxMm8Wo4BIXVed40FlVbe3eA6KeZB1eF7obRZubSOB?=
 =?us-ascii?Q?ARBiKbg63l4qyLbtLh0B71ThgehgrghQm2cZq4PLDEGgJ9cUmp3J1ZcLzHiQ?=
 =?us-ascii?Q?n3EB+abzihb7H/HhmBQCroyNYx6QfGA0RC+GyXNBLrpaXUvt2qY7vvCNTn6H?=
 =?us-ascii?Q?hZM3tYCygzk4TpS864k+8oyRqo0erAwb5RnKrYFDmNyWe8Re15IzzcPzDXFY?=
 =?us-ascii?Q?S1w3Ie4NMg6Dp3K3XC0OUqtGFSSn5ecXHHT2elBBZkDrGM3LCtZtfRTse+Me?=
 =?us-ascii?Q?UYGWDEa8hk3OPK2HRfXrfVHE04VlkK5KrgohB09UmKILirJzUjfHKCRfzCoJ?=
 =?us-ascii?Q?ClXcAp6HRySyzOMMWipg/tCFJIQR5z4WuXznN0rA40CzHyaxWF4KhfdnCDKV?=
 =?us-ascii?Q?efJ96iiskRH8NaptwEGsjfWB+WtiDYRi8sCUXO8Fk8jMWKXlYefbhcJ+gkQe?=
 =?us-ascii?Q?sLEHzhEYP0Gt+tPMjlueYyRlsgqeQcaCxyc27PU/RWiTWWfpMtAnjS2W32XP?=
 =?us-ascii?Q?TwlbNikX6QlwNXkvW0s5d29MFYiB/doQJJPVqGbeq/sVhNB+oL9Ri0NAnK+f?=
 =?us-ascii?Q?9iPQF+xmrsnCCqFZsM9RvAqqQKHtWVLm2KIBfiwF5qAqH3hmDspI0u5AiZKg?=
 =?us-ascii?Q?pX9tr8J859MyW6uG2JOVA5N+LKcxFDESpR09Aw/Jf9gXR0LLS5XhWpLQb9j8?=
 =?us-ascii?Q?50oOv7kPwCS++tgdOrzCiRtlEIGTsR7p4Pm8wqtYQ8RtrszYrWwVwYzEVeOB?=
 =?us-ascii?Q?zJd1Qc2MmfK90GM8ETQ/XWZ0oKUlexosKtFSQPbwqDFWa615Mr071UnjW2nI?=
 =?us-ascii?Q?FSnyiu336EJlIL++1mqOGRFnQdPv+zYhCkly22VYcxl5GG3Rq9clk7iOvPps?=
 =?us-ascii?Q?AeAIW7g+2TF6wIa8PDpMz1zxpLzV7vLww8CV+SptzWHJ5IY3Ocvea+sDlk0H?=
 =?us-ascii?Q?VwnGLYw2l0P8UbtjcyXt/6weM1ggvPOuhKphzdpN/6T3/i0tRx1aZyW0o8Qg?=
 =?us-ascii?Q?RKgd7VCepUobVHdroK2PDnJaGH6M9UgGMYkTDxEor5kMaAfZ4KVgYhasv7In?=
 =?us-ascii?Q?DfHCa85v6yU8teCBvcHY08QvZJZUjWvBWUlS9eIuESnyzoARskOf4ZpjK8if?=
 =?us-ascii?Q?5d1v93gR/LQYbrtdWrxI2k42GOEcnXuI8AHpVVlfwSmvTol8V8dUIlEEmmpo?=
 =?us-ascii?Q?WFWnBFbcCeQ4jIEnA8P9qypGgUgZtchpVG2IR8VWlCbfftwDiD4zTB/vsP9k?=
 =?us-ascii?Q?UmFMkYGwJehZQHjPVmqzeHsDzRJr5u0fcQF8JjlRARqx5LIK11wQTSS8oeuE?=
 =?us-ascii?Q?l1z005orHr/GsPG+XQq2Q9b80khGYzqstcwG16FAhf1CHGWqYdyarLcP4gEi?=
 =?us-ascii?Q?rbuN8vztIvMCQc6synPS8e9VYvWwclHFWmbJ80NiysB9/TjnqvvpIcuUyhAd?=
 =?us-ascii?Q?emlOa9+FVRJGauvkQ6rgDEINuDA5mhU+3+SToF9Lvpbujhr+6TJe8s8lF87W?=
 =?us-ascii?Q?BHr2uYVkWnUN5w0iWWbHNUROXt9DLj10rjZlvyO8egXZDFiMbh8m?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a5388f-2081-4e2c-28e9-08de8980b333
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:38:18.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rl/SgZoKUJk/OPq4DPC53yqOHU49u/DOaLigFHh27WX1IjJraKeAvRiJueqeo6lmsjEw6cL0w/PD0x7CdWisA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6981

Implement the EPC aux-resource API for DesignWare endpoint controllers
with integrated eDMA.

Currently, only report an interrupt-emulation doorbell register
(PCI_EPC_AUX_DOORBELL_MMIO), including its Linux IRQ and the write data
needed to trigger the interrupt.

If the DMA controller MMIO window is already exposed via a
platform-owned fixed BAR subregion, also provide the BAR number and
offset so EPF drivers can reuse it without reprogramming the BAR.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v11:
  - Stop exposing PCI_EPC_AUX_DMA_CTRL_MMIO and
    PCI_EPC_AUX_DMA_CHAN_DESC. Keep only the DOORBELL_MMIO aux resource
    used by the embedded doorbell fallback.

 .../pci/controller/dwc/pcie-designware-ep.c   | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 386bfb7b2bf6..f78ed73b0a3f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -817,6 +818,110 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
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
+	resource_size_t db_offset = edma->db_offset;
+	resource_size_t dma_ctrl_bar_offset = 0;
+	resource_size_t dma_reg_size;
+	int idx = 0;
+
+	if (!pci->edma_reg_size)
+		return 0;
+
+	dma_reg_size = pci->edma_reg_size;
+
+	if (db_offset == ~0)
+		return 0;
+
+	/* Count query mode */
+	if (!resources || !num_resources)
+		return 1;
+
+	if (num_resources < 1)
+		return -ENOSPC;
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
+	return idx;
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -832,6 +937,7 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
 };
 
 /**
-- 
2.51.0

