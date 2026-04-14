Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021092.outbound.protection.outlook.com [52.101.125.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D83E63A3;
	Tue, 14 Apr 2026 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176193; cv=fail; b=mv9Kvh1dkZwtKdRqPrUMCHN1hCjbPWjzOkCVxT9PpC8YPBq7idKt0Gev5VRMKpHyFPd4HMD8NLmdtJb0mTpOxrlpa9E58w9ZX37HHfNzFVYuUuxywKcPOjqtB3t3vwBdPkhgapvuGY68oaG2caoJpE+7lLycYJTcK2X9X4CJvis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176193; c=relaxed/simple;
	bh=MW1Aj0gv67C9tvqQ6LpR4zRW1c/whgc3oVW6U+bAGXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gvjhu25Hj1fyJT9cM7Rxrj2JX7/gpABamS26zZBwiNaEQTJFEkNi7cwHNKhXlT0sKpohuwtP4CLE7/sFucDhc42T5BhlTv8QtoeBDhZb+PE+NPZHHoUF9k2ZSHbFoG+XwCDDrIPrwdNBjGJuzMIY3b9bFnLER8o7IEzyhTt9LUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=F6OwtxgG; arc=fail smtp.client-ip=52.101.125.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="F6OwtxgG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyl8Qwa1FoInG7Au2KGr3NkDyzukVfH820ZNmWN1/q7IYBoLUrfXrymJ2Ya7giz0E5n1mDRvLPSvEJCk9AMoDT4sRzy2kQCrPYDyuBAmsj2781kBpYxQBwlkZj1NUS6bGAG4Gy87CfjPqXqn1skt5UbQ4ojpZ33o8W9boN/NRVTjQv2T69nr9IkAfDX1mGvZA1WTM1n6NtrjrR27H46ElAHXuG4S5Z8fuh8GpAmMwWrrB1pAilkULJiqo45lAQSzrvjfjM5YZEzclEMbx3VJ1vnv/SMDZA5P/bQzxaqzgo+Z5bGmKTEd2cbpW7JNiG45xJ+DtkmITGllHmfuAGV8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trU5O1holpV7RmRFQF4xflLdExKLZ5LXpwXvnw5UsGY=;
 b=pPOiTWeG9TfXrLdPSOIgOQdPpbTyyAHI0j85IcNZkiEEzPex+U6PHq3aBg6eyI0moI0j8P8M3Ap+iLKo7baC2uTC2bXLSV7r9SbEutfLyddWb39OtQ1TYPAtrl3XIHYuRcsDjNkv1coyUKt80G1m9JxzWg056FoRpKeCMu+MCsTmMdICw5YjdpGtPipAhruIGbWKy8Ith5ZyBI8toGKrLw8AugtE/LHtA+1UQF3lf6J7C/LjaiEgOb8Lk/5BkuinNCUVwWMrTpF0Dj4okC7d2qpksiRuhDPNLt4KvGiS1U6qZBV8BxJQlpdUmjWEh37FG4B3qvRWSBGtEujn8uI6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trU5O1holpV7RmRFQF4xflLdExKLZ5LXpwXvnw5UsGY=;
 b=F6OwtxgG2W9H8ZhGas4VKn9ZYbetLYq+1gBtONnEMZ9MJ8/01jQ4BKRAgnciHiJppslLoa+ujU9S74Ug0qU0OOwF2EcSysTu3oaoicCqg0PujnvGTVJfTc9oA7KrIdKL70uGX8vncQb3abwZHFsdYQ2+Mszrh/pvL+D7EmrgpC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3623.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:392::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 14:16:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 14:16:28 +0000
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
Subject: [PATCH v14 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Tue, 14 Apr 2026 23:15:14 +0900
Message-ID: <20260414141514.1341429-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260414141514.1341429-1-den@valinux.co.jp>
References: <20260414141514.1341429-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0290.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3623:EE_
X-MS-Office365-Filtering-Correlation-Id: fb121408-0e84-4733-7503-08de9a306b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KxbF948hg92+CX8XejSVgazrvq4L1+hqxjfCs2UbyKbdNhinEcmExQ1v1vge1FnltLRUMPkHKp2lQ8lsassJ/4UOn6oVY8i+rdaVZRagcCkUC+bLgbgzb6MWxWzAINl2bApDVDUgZDAv6HcIVmO22QwtIl8mOTJIen4WLar3pQ/zGGPLxWHdwsijJ/o2/Id+a/ztcRmOw9ewIoA71zo/ZXT2t/EPCWfpL446+9Q0IHKy/q/tlYgcLlVnSKcDxuqv4+RI7dmqq3frrQG/obaEG8ZFNr27VRvrhaVgkcRRJI6IG53cQLnZDVnjHC7hHYHkstaQTwGzWBbzoZ1vokYtc0NmgCCoGjM6wljn4H4zrQ9FTtnbA5XcNpESJK9OcsaI8yptNPNjX0AK3Riygc/gVHKdsCWlowcVW240f03dL3NBJ7vEqqzhwBK79OnwHvS9x8t/SvIaTRwa4s+SdWmMyzkVRGi4nIsBMLEZK8pew8/DxmzWTSRZDj5gCIU8xjiCzP/4lrrDDckRRWc1LBYl0R10Ux4/qEBHEO6ChRINRmT1eAfOErIvo1jczNShMibrdPnv08RS/2a62nvjtXU5wtYxj3s3klDg4SMBn2HktENcZI6XX5MQY6m4angJKRYy0pYw3gI41wnHr5X7JqYtnL107HHzUzY7mpkPN5OQZA93QGWrdDfBtsmQAd5iDSrhnnOKt6p19uwbOsnFY0zcQroSusZV2UwEWkEDe+7lejF0GE5Axz3HB6pxsaKHlHPhT7oWOLL7jBY/7skKNPAF0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EOXDI2NaM7Kjb/29+oqV+zphvle3qweicqA4RlXrGkwRUr/GaeLD5RylQ1TL?=
 =?us-ascii?Q?NzmLhiLoqkrgODywm1LiObquE6HqovIGsXbVSUJCN434EPK981BpeBWJQxjM?=
 =?us-ascii?Q?tz782TXv2Ylhnq2hwsgYaTsZaMbJMF/J40vl1rPh3JDU1MizmHM6HpjswFA0?=
 =?us-ascii?Q?7olEsqveCeuu2JEwo9jt7GZO1uAH9iIMIMCwF0Byzorj+L4xnTKEw8N350yB?=
 =?us-ascii?Q?kDkzyBD9jyWjLjLcB5394n3mlMgqBN7Gn8uxEwYvnj1F6vFyFZ/wXI/LaYlh?=
 =?us-ascii?Q?CSzzXeiWyyM8f78cCzvzhT9vUXeblVayQ38GT7JyhSnchF6bzbJzz5wvU/yv?=
 =?us-ascii?Q?XYo6q4M9xT63nGkHO0jVp0sYSGTW6bjfcQaIma9mduBwZc7U+jPRo7nrAbuW?=
 =?us-ascii?Q?T8zuaprCiYb2ibCtpWMkJ3ooIgZU6sHk2LwBfYdMJT6KwXpN3xpHfV0O1JZg?=
 =?us-ascii?Q?o+RLwbkexFbwcQK6WJtk6982blnCZzO+donxKglbrB8ws7h6RliGRKRD/OX0?=
 =?us-ascii?Q?q7HWYa8IG9fgGO6q/ihEeh2MGgm/P4iiha754eNE+fg+M6UWqJvhcfkDnWwv?=
 =?us-ascii?Q?5+DZ7BIONBy3CiUMj8BZFNn6dv6gvhydv6TbGgQQOS7ujtnVOsY6rqanFxtX?=
 =?us-ascii?Q?/5KgejL7m1jBcAApTUoW2Z+WwN6uDp+p/xzGmxmHS/QyDTbhGjI+2esXA/Rg?=
 =?us-ascii?Q?udIaQprJyhh4QT+nRZ17Z3nq6eK8LZFCMdCMuOcnAIoPpOf7XgYMXPKskGQs?=
 =?us-ascii?Q?KsCRy30paAOti/9rjN+nplmpzZ572rrQdslutOcPRjS85dNLZUaa2kvBw48D?=
 =?us-ascii?Q?xuCsBI52zysFleRANdob+elxmD6rS76N0G+971bRK6uwJSEyKKlt/pMozbKx?=
 =?us-ascii?Q?lZRn2RjRIKgUWOCLnt/3XPTmgpnzg9T0/xGeF1EkaUEHbk+DvBpCUBeQc1kU?=
 =?us-ascii?Q?jaAi1fSY2H02SsEUC2yJRJwkqStL4MKkukf4QOYwyBarI8c3iGT1PnIHoNk5?=
 =?us-ascii?Q?26oKFqkC6J+wv/CG5/nG6sYLiYcojLHMgvbSOn2ah0Bw0nesjZwy8zk2hIoT?=
 =?us-ascii?Q?MJ/Ew7AkHjOwkALjgbnItKhVZM6dmXNkWMxTH9k9KymOG+Zo2eg/vjppg+XE?=
 =?us-ascii?Q?E7ignu3e2u67QiYUcb5RlIYHQpY83NscfigmG7FjuSMcZl+VxbFLPixa++Q9?=
 =?us-ascii?Q?3JQcnferCR7YnGCcjNoked9PDdiOUHkgIjSrM1CDm2yEpu4Thh9vTlYu369J?=
 =?us-ascii?Q?69RPDH8W8LCh3rGOtRKOjbg1GK9Z4Cyu+DxZQqSRvb6zRWWWdqMYwZpKbgnE?=
 =?us-ascii?Q?WZMvQcNoist6S5VOKkWPqxZxzQtWbI/PuMK45CVPyTMvoZcw8VZiyX79gTNt?=
 =?us-ascii?Q?xIqEpaPyuKdQCrclxIocHvmViQ5mrCcKNCGIq4+4Xhs3HiCquvVDARCx0XuQ?=
 =?us-ascii?Q?ffut2Thp4tI68OHQCyFTP4DD3/646tPsVFd5Wry++NX4pUTOstFjxawQ7jrq?=
 =?us-ascii?Q?A0wWr3IixoYFmDfshAfZSwbsQd/NqFfsA3tYsmF3CFLsdSaD2ZGdHRH9hXk5?=
 =?us-ascii?Q?bxf75tpMCfFY8sMK/kPcaZU4KYZA4YOx3sSLMTo0d8hWs7hrZa53bnONeJP7?=
 =?us-ascii?Q?/PPVhc/c7/OxZ3UWsOgXyZ1gchMgiP+dQyRo5ZAvkh2SjuHhUZPoj2vM5zr+?=
 =?us-ascii?Q?8/HGgHELXJZploVJTMVRshXvso7oD77RACvmVEK8uKGoQ5v0t0BftGYPPWQd?=
 =?us-ascii?Q?smk+ve4KB1rQtFueguTsyhrCR68W+G2hFs8dTPw0L+bxLY1d6PGu?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fb121408-0e84-4733-7503-08de9a306b6e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 14:16:28.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25PLQRcAAzqZAuBWdm6Ss+4HwpAz8oPpqo0ZJTKbKb4PQ3Pt2ASjfnksKEUgIhqX0tBHUwrEBXIfwg4L8PB+JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3623

Some endpoint platforms cannot use platform MSI / GIC ITS to implement
EP-side doorbells. In those cases, EPF drivers cannot provide an
interrupt-driven doorbell and often fall back to polling.

Add an "embedded" doorbell backend that uses a controller-integrated
doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
doorbell).

The backend locates the doorbell register and a corresponding Linux IRQ
via the EPC aux-resource API. If the doorbell register is already
exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
the DMA address returned by dma_map_resource() (which may be an IOVA
when an IOMMU is enabled) so EPF drivers can map it into BAR space.

When MSI doorbell allocation fails with -ENODEV,
pci_epf_alloc_doorbell() falls back to this embedded backend.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v14:
  - Drop -EOPNOTSUPP to -ENODEV conversions.

 drivers/pci/endpoint/pci-ep-msi.c | 131 +++++++++++++++++++++++++++++-
 include/linux/pci-epf.h           |   8 ++
 2 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 85fe46103220..0855c7930abb 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -6,6 +6,8 @@
  * Author: Frank Li <Frank.Li@nxp.com>
  */
 
+#include <linux/align.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
@@ -36,6 +38,109 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	pci_epc_put(epc);
 }
 
+static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
+{
+	const struct pci_epc_aux_resource *doorbell = NULL;
+	struct pci_epf_doorbell_msg *msg;
+	struct pci_epc *epc = epf->epc;
+	size_t map_size = 0, off = 0;
+	dma_addr_t iova_base = 0;
+	phys_addr_t phys_base;
+	int count, ret, i;
+	u64 addr;
+
+	count = pci_epc_get_aux_resources_count(epc, epf->func_no,
+						epf->vfunc_no);
+	if (count < 0)
+		return count;
+	if (!count)
+		return -ENODEV;
+
+	struct pci_epc_aux_resource *res __free(kfree) =
+				kcalloc(count, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					res, count);
+	if (ret)
+		return ret;
+
+	/* TODO: Support multiple DOORBELL_MMIO resources per EPC. */
+	for (i = 0; i < count; i++) {
+		if (res[i].type != PCI_EPC_AUX_DOORBELL_MMIO)
+			continue;
+
+		doorbell = &res[i];
+		break;
+	}
+	if (!doorbell)
+		return -ENODEV;
+	addr = doorbell->phys_addr;
+	if (!IS_ALIGNED(addr, sizeof(u32)))
+		return -EINVAL;
+
+	/*
+	 * Reuse the pre-exposed BAR window if available. Otherwise map the MMIO
+	 * doorbell resource here. Any required IOMMU mapping is handled
+	 * internally, matching the MSI doorbell semantics.
+	 */
+	if (doorbell->bar == NO_BAR) {
+		phys_base = addr & PAGE_MASK;
+		off = addr - phys_base;
+		map_size = PAGE_ALIGN(off + sizeof(u32));
+
+		iova_base = dma_map_resource(epc->dev.parent, phys_base,
+					     map_size, DMA_FROM_DEVICE, 0);
+		if (dma_mapping_error(epc->dev.parent, iova_base))
+			return -EIO;
+
+		addr = iova_base + off;
+	}
+
+	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
+
+	/*
+	 * Embedded doorbell backends (e.g. DesignWare eDMA interrupt emulation)
+	 * typically provide a single IRQ and do not offer per-doorbell
+	 * distinguishable address/data pairs. The EPC aux resource therefore
+	 * exposes one DOORBELL_MMIO entry (u.db_mmio.irq).
+	 *
+	 * Still, pci_epf_alloc_doorbell() allows requesting multiple doorbells.
+	 * For such backends we replicate the same address/data for each entry
+	 * and mark the IRQ as shared (IRQF_SHARED). Consumers must treat them
+	 * as equivalent "kick" doorbells.
+	 */
+	for (i = 0; i < num_db; i++)
+		msg[i] = (struct pci_epf_doorbell_msg) {
+			.msg.address_lo = (u32)addr,
+			.msg.address_hi = (u32)(addr >> 32),
+			.msg.data = doorbell->u.db_mmio.data,
+			.virq = doorbell->u.db_mmio.irq,
+			.irq_flags = IRQF_SHARED,
+			.type = PCI_EPF_DOORBELL_EMBEDDED,
+			.bar = doorbell->bar,
+			.offset = (doorbell->bar == NO_BAR) ? 0 :
+				  doorbell->bar_offset,
+			.iova_base = iova_base,
+			.iova_size = map_size,
+		};
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+	return 0;
+
+err_unmap:
+	if (map_size)
+		dma_unmap_resource(epc->dev.parent, iova_base, map_size,
+				   DMA_FROM_DEVICE, 0);
+	return ret;
+}
+
 static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
 {
 	struct pci_epf_doorbell_msg *msg;
@@ -109,18 +214,38 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
-	return ret;
+	/*
+	 * Fall back to embedded doorbell only when platform MSI is unavailable
+	 * for this EPC.
+	 */
+	if (ret != -ENODEV)
+		return ret;
+
+	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
+	if (ret) {
+		dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
 
 void pci_epf_free_doorbell(struct pci_epf *epf)
 {
+	struct pci_epf_doorbell_msg *msg0;
+	struct pci_epc *epc = epf->epc;
+
 	if (!epf->db_msg)
 		return;
 
-	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
+	msg0 = &epf->db_msg[0];
+	if (msg0->type == PCI_EPF_DOORBELL_MSI)
 		platform_device_msi_free_irqs_all(epf->epc->dev.parent);
+	else if (msg0->type == PCI_EPF_DOORBELL_EMBEDDED && msg0->iova_size)
+		dma_unmap_resource(epc->dev.parent, msg0->iova_base,
+				   msg0->iova_size, DMA_FROM_DEVICE, 0);
 
 	kfree(epf->db_msg);
 	epf->db_msg = NULL;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index cd747447a1ea..8a6c64a35890 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -171,6 +171,12 @@ enum pci_epf_doorbell_type {
  *       (NO_BAR if not)
  * @offset: offset within @bar for the doorbell target (valid iff
  *          @bar != NO_BAR)
+ * @iova_base: Internal: base DMA address returned by dma_map_resource() for the
+ *             embedded doorbell MMIO window (used only for unmapping). Valid
+ *             when @type is PCI_EPF_DOORBELL_EMBEDDED and @iova_size is
+ *             non-zero.
+ * @iova_size: Internal: size of the dma_map_resource() mapping at @iova_base.
+ *             Zero when no mapping was created (e.g. pre-exposed fixed BAR).
  */
 struct pci_epf_doorbell_msg {
 	struct msi_msg msg;
@@ -179,6 +185,8 @@ struct pci_epf_doorbell_msg {
 	enum pci_epf_doorbell_type type;
 	enum pci_barno bar;
 	resource_size_t offset;
+	dma_addr_t iova_base;
+	size_t iova_size;
 };
 
 /**
-- 
2.51.0

