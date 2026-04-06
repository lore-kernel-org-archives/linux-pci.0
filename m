Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E13314B7;
	Mon,  6 Apr 2026 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491065; cv=fail; b=i6wl34W7fLCdHOX+Jr8zEWeEDIJ3CP441AA7L44/aXuyVsUv9bK6ILPygrNTdKeiAZwbWq/0wA0T2udGoyXO2+N68FMOrqa/GLxeudjx4Tilwf87ugOOOqWiG0zRCE687zIzf2ixvzNyGaVIgR0+4/VN0d5d1ZaPkn65wicpy+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491065; c=relaxed/simple;
	bh=rC8/e+0xzWtSpmaLkTHYAqFNhZV3sXj57dWCZl4sNSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kNyyEWLhraO+5qcDr/UNUz/QAe+BO4exy7Bn4nZigLbLtnZR66LJGV64c0J8QlOy7VeLiTIIPFQEggqX31oMX9C5uCBMkDacyXqpqa6j2ZbrMHWgUtAgoSB1pI9UjtqPEGJXOz+HFksylM+rKXhtVWKLrzjOBnexbwYhLFuH3C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=W5igRUuw; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="W5igRUuw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKRLHvP3FkQ2SwtOoVIBZ2bGjVCQdPJNM48M1onKiUw+gk06BMYHLaqZzb71qwNjKoL+th7ogZVK2C8IvD0pZx22JdOfmtb7uoEd7g4+MOi9OxOGXBUPrTvuJJ9D5mlIaLAVvxpwk091CIScURDuwXuRIMDNESiS13Z7QGG5GFDjjAd/7mqsbEkmtGdDENBm0u6xNAxu4wJK2OyRfVtDCKs+i0ho6KSGJLYAjOlO3gTuTldfS4pOOtXYucb55QRt4Wf7Xce070Z9IrGYRx+UalLC1pN156Di7Zn6h8eru9U2F4TezLZZL3q5D8fZfEg1t2KzjvVnrfE3q4kkQpn+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3mmhLUdELv/sZCya3jrncy1RulA/dDzpU5C1RE68nE=;
 b=YeSjor9iSC2HVrAio7KMwhUvmjdlVJar33g/zYdHqI/RHvVlX4RGOiQN4kuorGkRO0e023GIZr2VRRHe9Ow+/4PEIbT4kPUK+JYLayk3Iwh6rpjP6rJhMy7K4p1zeNPaJKOV61eeNqKXEdQEuen8cFVkYI9EsZraLhgLsheLhwoKGEaA1RPLsAwPB2U2J8ROzsZ56wBjzhYomL9j8EPM1jDVDLhlq5UqfJFsTsCT2EsqHgMVOud0wsW6d+Nby/Rcf7O/sQDgWP3ISuqB/+N2r+wVwkT6K2xlcz8q5tTnjcT3SGA8ICKBW9BFpJwnoRH+FTcNenhm+p8hDw8wTm2xQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3mmhLUdELv/sZCya3jrncy1RulA/dDzpU5C1RE68nE=;
 b=W5igRUuwjS8Y7xpng7Pov5GAoGO5xoH6GGWeUVBuy+E9/vBFXGRcTsHEejDwGwG+Eio7mpHx04DEPgunIn0Tr4OD11yGW4jslAb35D18JUfoAZMY6xJKPc1bT+hmbptn5sNsabvemRW/W57uVX3PgV7Q8XAxLwFjyt80v3X5xcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4187.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 15:57:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 15:57:27 +0000
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
Subject: [PATCH v13 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Tue,  7 Apr 2026 00:57:17 +0900
Message-ID: <20260406155717.880246-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406155717.880246-1-den@valinux.co.jp>
References: <20260406155717.880246-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: a04d73b3-bd50-4311-0ac3-08de93f53376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	L2LkqTfUd5yfOodHj6n/G69WRITgyXD49paERxOv5rgwdHnHbyPkZAe41Ax/h+IdjqJfqfO2S7Sk+7AaQSFCIE5JaABbO6Zw2ZwhGPB6s7aTQRzQ+BFMSCVNa+PeUAIc1Px1pjUQ0XYlzTKEAXb9ccvoDDN4f31hpbpIWFS3UtAieW3eJrNNrmZWPfbovDzX2s7l8igKFP9R7ES9YiLc8OLHiTyaWIMyO6oaECK5ZymlYTyvKsdEr8ByKfxktneVf3UZpnnjv8WTmppEbg2EKx1aTR/W/c4kCBtHu3UJLWJVWeOkdYS4uuawnBzobedDVCK7cSRks8uy9S74G4uS8THBbOFSNEz8eA3CU9yGifYK+eh6da9EPgqxIcoODExqW+Y5gsMF778mmJCIYaArZX9lgOVrEaL5bFc23YAoR4EK3w9Dks9mDPMJ/xbAHTUe/e/fSxgJMuE+pI2jF5JZu9NaW7mD/EI6M/oA0KdRUPqOVsnqrkVWobeLLKQNlxDSSeBA5Jx0nLjbdornfATeLUKs85m83WtWLRjFMmy7GtC7amYNA1gKX2nqxEGGcxM2P8tLdsINyOrY+ZdXLS9D1sqamSV4HwlvbECCM+wZsSotdPh/3NQaCO4TTsUDllw/2/D0/GigCdvKoa/iC9UYlsDTDDk0uTEJMnMgf/GS0Ll1yT2bUPr9dgPUAszjVK8lR9J5p21Ikn8xxfJQ1p7OBOozT5UMJAtlkzlkDdWlrZRO3y2XDKljta+SjENCzJ1QhX0uSxz5vMyNr6cFvQNP6w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8thWL33NGS14Vd8waUQp9/HsshwGK2czSutDf/tUGRQV4v4MF6/QHrPg/NoC?=
 =?us-ascii?Q?2rdwmXyG1WSAk5NZFiO7B4glPXak/6f+vnXqIWz+ian2bb+2hDOJ5EbGhSWB?=
 =?us-ascii?Q?LmPuGkUCHfWD31iMBLVrjB/nr8K5DHWSj7U70t5AIEe2jOuhvKWIgoFLQpHZ?=
 =?us-ascii?Q?IuevpRNNaJ+dOce8lQgUSykFsqs2gCLoXBlSJOohpZ1XdmWVmmeGHDrqlD95?=
 =?us-ascii?Q?pN4UdEYZEj3zrTJxQ85aTuWg8i95GbtMdG3we9Aw1eKW9p8Nj0RRVzj/BR5f?=
 =?us-ascii?Q?+DwfmsaEhuj0RnguCFzI4gef/0wdNPA4hmnQ6SWp5KJMRs6iH5ePPfclTGy3?=
 =?us-ascii?Q?L8QD5zV9yTbzvCMyi12CR9PDr+Ceri0mfcpfGUO9ahQUhaGyPNaNHikhXtN2?=
 =?us-ascii?Q?oPI4xaQSMynwJNcHocimXYMCD7LG267bynzTZl5fs+Ihsmhhazw5oLHlpr3y?=
 =?us-ascii?Q?owyX4Fc1OI72l4fhjCd7Xk3fbsU2kxFjbFqumF9wj73ERmp7E+dEowRtMi7x?=
 =?us-ascii?Q?TKCGOtdHXOfMVQgqBpzh0+aTY43xOuvkIOWc9vtnvcKif2gASOBOgQD0fS2i?=
 =?us-ascii?Q?sYXklM0LH9ZC62RR/DkMNFhG87nV2zZlAL687FM74i8iS9sSdFksww9zxQ0h?=
 =?us-ascii?Q?iaYct1e+4pOcvg5z9ECMJ/pZajRdHos/7S+UmE/VlN2NKI35eqTQYI+Y3PRi?=
 =?us-ascii?Q?wYj3bk2ckvLIAMHCcqtXwZwjNEMZnxnavTPfmSem4M889QIBITmTZFnc8jc8?=
 =?us-ascii?Q?AkmsGxgDYv+9qvqIOfNIBKuKDximaryE7AJCmJuI9bB86p5LPHoxemnkM2Ks?=
 =?us-ascii?Q?yLxjfrR1vTXkoeLBq1pZQoCQNLZDBSfELdSXmzMy6mJjNaaOuJpjCnnW1+Rx?=
 =?us-ascii?Q?u5I5xFgtItUWPVwHkjiK/5Lc8iT9gOwfssQ67KckkVTuA98q+N2V8LNNUf6n?=
 =?us-ascii?Q?Hih0rf2Vx/mKPGM6/l2Vc4k5IwxSq1mL3Uh7OQt2zQe8F8da62qUW42s6W0k?=
 =?us-ascii?Q?MQeoSRu7xgiuuEDaP+YmRrVhJjNoUp0K4dZheOJrv6EFPuhKaL/FaYcYv/tu?=
 =?us-ascii?Q?q8mbnXhYOsAoOQCMJ2stX2K892fWT3Dqbtyye0hOVQjbdfb0wdKfm9EE06Wx?=
 =?us-ascii?Q?b0kasHFH3EDKJqIWvib5XtlqedZXEomcAgcwa2xeVAPHBgZsVLp7ye0EnJOo?=
 =?us-ascii?Q?DTzUfXWFM+21unwY+/uj6WJbQ/y1sFGj0fchHO5t9T3J0K9MlZpK/ye1qYHJ?=
 =?us-ascii?Q?8+g0UZsX/Tsto6gaR2Ixow4ToLqWp/OtSpG65cSUQccVNmKofa8nDblWgqZd?=
 =?us-ascii?Q?IUCy5JCtYYcwAtT5SfKOpfBaLtq6hmcDTk5TCgX0KSlOkauxw05epzrtY3TR?=
 =?us-ascii?Q?DQGGo1/pJeCHLxjmxTsYw+NYSxCCIFU/BUEHsbAxVCWolHcZ4TcJk8NQ5dRj?=
 =?us-ascii?Q?Jg5CwQm+N9pHyoxToJtIuZuibPiYjVlKdbqr9oNCNzOtgMd2sAAKsi6IgNO3?=
 =?us-ascii?Q?Mwip60cV9Sta/kgjxVvqB88AH4Wg9u5C2FYJZzoD2DjDTYB4uzNomsjZPqxr?=
 =?us-ascii?Q?HYL36hkdWzzkypNzhE8UAiKzwuBfv5JL96CL92eBYC9cOCTUa7mJtYy6vbQo?=
 =?us-ascii?Q?vGDPJSy8WXaVXfKQvPEDQxkwAufOVAN4AUsZx1IyM0UDxft2cneAyeZYLzmv?=
 =?us-ascii?Q?mZN4SREuaixOBMO0LoftkErx7MCPwP68K1KE3eWezTXtcubMYE/cGE4M8T4U?=
 =?us-ascii?Q?7Ciepr25NFDDVMKdHiEgpq2HDWGiicJOw5p8j3MgIQs3cKnl2teC?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a04d73b3-bd50-4311-0ac3-08de93f53376
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:57:27.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgb+3HMF5qUqGn4xKel8uLP8mkZsnd6SMwTh8il4Nytx/ZoQFeniYfliomOVvK5iy0UTERlFvzNyMArqm36qwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4187

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
Changes in v13:
  - Switch the embedded-doorbell caller over to use the updated
    pci_epc_get_aux_resources_count().

 drivers/pci/endpoint/pci-ep-msi.c | 135 +++++++++++++++++++++++++++++-
 include/linux/pci-epf.h           |   8 ++
 2 files changed, 140 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 85fe46103220..4ebec9092e59 100644
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
@@ -36,6 +38,113 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
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
+	if (count == -EOPNOTSUPP)
+		return -ENODEV;
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
+	if (ret == -EOPNOTSUPP)
+		return -ENODEV;
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
@@ -109,18 +218,38 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
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

