Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021131.outbound.protection.outlook.com [40.107.74.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717443D8912;
	Tue, 24 Mar 2026 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341538; cv=fail; b=SuGf0r919Y3YlCDpRRcm9emyBbmJ4loB99/1CVq3CcIaatcNZItnWAilw26DGHJsfm8wdhxkOWq3s3YfMVMOJn9HP2rJb3uOSyGbVKu+uaLi85UiaNiRrIlbvOlLwv5shBLWSkCw2XKAtT9r0CRg1QeozSOddP9qbxvfy4Iercs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341538; c=relaxed/simple;
	bh=SGhx/v6WA8xPIez4UyOkSnbG9oUxpaPlU0pOHhUdqWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TEPhIyELtRbMyWLMuKKe3Kp5alLPoeVHtVvGFovkMJA5C4q1313+udXcMxDfiXR0qtyARXMsTN4zMq4cV8Y60/oox6VTvpZlJLUbPpUKH89lLDHyBL/1DP26UV/Bu+NLOonubEcdnEb5tlLarG1/Dow45QG3QBnthC8Lhhu8HiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=COe+U7ia; arc=fail smtp.client-ip=40.107.74.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="COe+U7ia"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnpTCabc/oVf2jdiD2JBShl9JH3yhVCotdHNCtrAoO26RNAoh9eyzXPPCGc2BdoSPgQNLVZlUV/wliKmlei0xx5i/TRhvF7WfMlmrHcdjzZImsXfDo/OByM7/fVEtyBDAUWAh4HS7E8fX9Sq/YiO6ySLa3Dh9xQsQaDifdSKuU+J64zvDIQ9wJcwSdtY9ch7It+FrL4bnfSp5V1DURVR2T0eXtMa2tVMjBkOqfqR0O1R+04/D5odOsT/EaBDxU3EEF0cT49sCVyAfNacCJEux2TUWnl1Qc0lPj6GJinZrzCPAayN2n7vzKCGHPyt1JeEcSvERCps4gQYCoB9OKyb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK4FAx7GVu6SftufUyn+YzFcrJM94nzV0WVXfZPLKYk=;
 b=huFnxBidyRPET1gxKgZCICQje+n+Zlsng0alAdjFXefLs4KytNrHhg8ARIaYeQ1EVV+5lzHsRCgQj5xUr/DunkieQaGsKjNF1H2khlx2OsS6ZWn3sktlDkgjsmIGBBJkEsO84Z8ew2yNK3FxE2tAtaMax3V5nI6MwgSsVDs3WpX/1tlWVQ2j7fkKC+WNif6aEIAaJZCjLJyU1Nqa3tExLGPb6zKZmJP9OYkMGe3NlnqlqMQ4BJYDpQcqOvqpM1mLw1NLXDFgQconG3LUrJX9DQ4s+lr7vCE+skS3gfbeF2QNyHsRvwCl8bRCrloOLZKdYbof63vEl8giZAxW1Qo7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK4FAx7GVu6SftufUyn+YzFcrJM94nzV0WVXfZPLKYk=;
 b=COe+U7iaz1xuMwbgwFaVv2lILTzVyyholeenUHQZDgRkKvYdUifR4UrkznQb5lbeFBOnSp8Xg6NpiFahyTHA5LTz3EI3hpPL1JC4KYjCfDat4qgfqesPgU3mUbpBWGgk2yr92+lWXalOMd2xVxcyI9lcYScqDT9yiPTOTHv7jTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6981.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:414::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 08:38:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 08:38:22 +0000
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
Subject: [PATCH v11 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Tue, 24 Mar 2026 17:37:28 +0900
Message-ID: <20260324083728.3744734-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324083728.3744734-1-den@valinux.co.jp>
References: <20260324083728.3744734-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0038.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cdf9bb8-2349-4a21-8c98-08de8980b525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LcbJIT//20K8OUpey+4/KtiqRVxeVlavOt3qN7ra9DKiWoSEimBAMB27j8U72jmhwOTo2ahLwzo4IDTy1DdYILzzdCpVwp4I9TMaRtIL3CFRQaYCaQqsTvMshz57+Td+GTotqxcGOX1/K6ODKPL8SaXR9xYkg4ry8jnX2hJAVeubAKxIu2UvhbKjqvBXoB68BsWnbG+Ec6zxxnV4FFD8u0QK7PgJOLeKT9+vRcavMJvLy9w6iwk4xOlr8s0NtUxlra6dKt+I0LyiYipfgATzUo+l5y6ShKJWViFES34QpFZTXDKGqdcCvuxE88I6NqEtr52NrXQvFbQmyy50ML2ngXwnpAj4hn67D7OrjSg2F06+EjZM4z5qvqCvR8ntlxZcMVnMv2WFuQc0YhvUtAwhTtJHwucxP2hSQ1BsZhilv8qY+L4tXKKW4Z/L7PjpyFLZBkBSReiHGziKgpmGpnhV2WWi6RuQ5MI4U7OXcs4be2pnv54Z+qGUlNp1A64Au1mMJkRf5KwAeUbumahK2NX3ejdgT2L3GMfC3e8iGQl1TdLlrO+JfVFXndttrNF+4ifP7ttYWv+FJr9Z2/9lpFRWYSP90sChLW4fP385LbTSBawSG2W2qGC4heRp8JDDhtX+ZuIQNsofSN3T6Z1Dj9jbVuYYuWQ1Lu0rtYU7ZZ4We1YkolcFLZeJ2NJGZeOnbdr/Wo881PGaby0QCO6VClS8YGwG6p5WOal5e244u2VjTEBfEbXnSuAQNGvrqtxuC+9od5o8ZfILyVdWiJaSydzY4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sMAT2UtBOk+A4yl2RxfiL0yxtV4e9zITcL1NpyqKA+lNM3x5fUxjykHXlB67?=
 =?us-ascii?Q?9ANvs4arVLWo/5a/4XoXJthn3p8affBr5MYC9D06vcpr+ybkRtrm+B8EtNr4?=
 =?us-ascii?Q?I2zL6g9WkP90/cTlx0k91VTYcNwV+HAW5nZYbSti8jz9cTdZ2iRsi6HHCVZV?=
 =?us-ascii?Q?UmajXwfZ9lXtSQxMZgkZz0DwAm8YjBfpywwMOI8VbifllUagVQdGqtilvxAB?=
 =?us-ascii?Q?z77kKlgqTCEP68x2ERWMSkNYtcG04prY1tFSWpeLqfrbMDnwVZJWjETEg2Pd?=
 =?us-ascii?Q?n8YrW2eTXbDwo9ntleD4/mDMTQO+z4uIKI1ni9Fi9MEqXXx03eUSeXyxmqvi?=
 =?us-ascii?Q?exyOrpGkkKXp3JvkhkQmSXO6qnYlilHje53d+0oUoNIz81tCwPmaTgRgxkbJ?=
 =?us-ascii?Q?jTcerz5hvXah3QKhef8OczJxuyWqLboyvEZ+wM10rQwdiMUy4us++xf2XaBB?=
 =?us-ascii?Q?2CTE4S4+QvgAcVsVlwGMSrrvtmMzKvP2jtahCDn7XRSArh4pivBfxzkXZHqd?=
 =?us-ascii?Q?QApUbPnQ7Z5t0sXhSjvq6JQKnFQHDZx1P3h94hTfBAIZ4Tm8gCWBLkqpTB3C?=
 =?us-ascii?Q?fILrBSpmKRjABHSyn/sgYDnfoJeb9O6lIyYRtUkSRvO3UOsc832DRYrBy5AJ?=
 =?us-ascii?Q?3b5VKYndiG4wvmSNbyG9X0xRYtkBARyXgO22mLtVVGW0FHC510dqAFDwb8dJ?=
 =?us-ascii?Q?xED1Ygh9xsGjKMUklrLYpc4b9HjMc0ZyzXNuIA3BGbBnDli5UeXXvOrYiU1A?=
 =?us-ascii?Q?cEX25BwwQksmFOEjDAGkVPHLqLrenmbmOntExJLGpF07hc8KueQoHwhpl/YY?=
 =?us-ascii?Q?EqEeYsFGQSU4AzNh3M/pUMzeBoDkzLOeA+GVesbx3kAvkBXX9jdsa0cmbi0O?=
 =?us-ascii?Q?GAaPPI8G2JZvFdmYHHnhbOMujQ7PhfQynZADvri77pLDQsdUmHubeCDUFQ0p?=
 =?us-ascii?Q?9CJpfM1q2Fo+UP9x6bTLZxQ01ILX62oIa8SSKUNfBvzjRnfwKUftDJdMTnHl?=
 =?us-ascii?Q?D+bfvklx2iReS17cdLNxXQl1gUbSzxQh9vUwcyO+Jr5iIftYCJf7CvpzNZ6R?=
 =?us-ascii?Q?eFVOXd5uXpJkezwns2/v9LiwDzvP290a/4snPtoijhx8TY+QE1ewQNKg5PiI?=
 =?us-ascii?Q?yVpE2T83AXESXIX/vpgRT8eoQpTNeSEjk+6mtGZZ3HlgtiayHbhIKfqL6i1f?=
 =?us-ascii?Q?DBX5De3OGPhZWLUc0MUFoTsXso1NkmovtFzpXnhaJSClYrfShCXkNyzOyYZ3?=
 =?us-ascii?Q?vREc+LQGLz87EUzvNcbs466+RLgYYcHgo/0TFPHvQU1HXLM5uZkWjR75Jo+i?=
 =?us-ascii?Q?PHDv640wO6w0zM5SQRVdq5TstxjRdGHfvCDEiG4aA1xd9bvQZdfrJ01zhO1C?=
 =?us-ascii?Q?bc744K8CjBwhY9ZccVRSHmVW6/CnIVeJvOpAkEK0PiH0LBzeW2JVVkTG+Kec?=
 =?us-ascii?Q?ef2EbPXD1Y+VN3POpxmZefASAtMabwEZteJLov/qWfA0jb6OhJ+ARdoZ410e?=
 =?us-ascii?Q?xZOJsQHmbqN2KKxkChmLwmiwNBFjMVfiyLfNv1jEAyvFLD5GckWE3/jlGmfm?=
 =?us-ascii?Q?/HqSmZWsYjkVZRuvoVk61Jyjk2LYVeJ7C5ZotkWUd3MFCIkanraGPLvuYFnE?=
 =?us-ascii?Q?QB1Cf1FqD8Ykhq9o+WdPiZBxzE8WRhAo9lLvHuBDlBRU3/ePM/pCqG+nE9nr?=
 =?us-ascii?Q?+QpyQArxHKWp3TWANmTC9VPmEDQdeeLp98gcRETMHIFfIqOEt+Nl0tDrfr8l?=
 =?us-ascii?Q?Ruh+tobakyXcYqcapoii5ohdBf2Z9jrwi3QdjWNumT+Ycx9KjPrJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdf9bb8-2349-4a21-8c98-08de8980b525
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:38:22.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3S1VZHvdEEW7BI2Zh1KTuLWh4z3I4q20g7uVEvWVmfl8VOTMjwJK/RzW5WezAk/dXsPowL8HM5yRfjpHm/0ciQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6981

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

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-ep-msi.c | 139 +++++++++++++++++++++++++++++-
 include/linux/pci-epf.h           |   8 ++
 2 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 85fe46103220..331d84a79193 100644
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
@@ -36,6 +38,117 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	pci_epc_put(epc);
 }
 
+static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
+{
+	const struct pci_epc_aux_resource *doorbell = NULL;
+	struct pci_epf_doorbell_msg *msg;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	size_t map_size = 0, off = 0;
+	dma_addr_t iova_base = 0;
+	phys_addr_t phys_base;
+	int count, ret, i;
+	u64 addr;
+
+	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					  NULL, 0);
+	if (count == -EOPNOTSUPP || count == 0)
+		return -ENODEV;
+	if (count < 0)
+		return count;
+
+	struct pci_epc_aux_resource *res __free(kfree) =
+				kcalloc(count, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					res, count);
+	if (ret == -EOPNOTSUPP || ret == 0)
+		return -ENODEV;
+	if (ret < 0)
+		return ret;
+
+	count = ret;
+
+	for (i = 0; i < count; i++) {
+		if (res[i].type == PCI_EPC_AUX_DOORBELL_MMIO) {
+			if (doorbell) {
+				dev_warn(dev,
+					 "Duplicate DOORBELL_MMIO resource found\n");
+				continue;
+			}
+			doorbell = &res[i];
+		}
+	}
+	if (!doorbell)
+		return -ENODEV;
+
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
@@ -109,18 +222,38 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
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

