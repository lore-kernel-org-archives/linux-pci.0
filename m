Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020114.outbound.protection.outlook.com [52.101.229.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5253750A7;
	Fri, 27 Mar 2026 03:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583685; cv=fail; b=YsH+8BGZ5OCyRTCWfJ0FMF9oRyEhPY+Ak+JGdO34CjSwcEpdd1CLtXfs3grr3EHEi3uzw+0I+1j4I8B/8QhOK2AEHkW9sz8hTHhGW55AJlDufj42nuzGFlHTT7Dc+7TQwL3A+PZHf1FG/4VdqR4eIRDW/o+lFt0gvQqZnTrjPBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583685; c=relaxed/simple;
	bh=B4rbh1Ems44OpgdoI6e1gh2sq5DROt0kGDzKLXhnZLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyVZQTQie/mhv4UKrOkRhdy8oCJEZC4lcRSd+u9dgbdj+Ca88Fu6qDwoyl66w4otkl0x32VdO9x1Jh28ED5xUdLDrpVFw63AxnMH5oEPyJnpPF0KM2jwUZbKGqdSCorUX09TP613oLYIsbbVKGXQYQaPwyvO4P2oPXkZilfSErs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wSaxy9Nm; arc=fail smtp.client-ip=52.101.229.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wSaxy9Nm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oY+nTS4aTDCIVcx6EIF3nT04ScCDUKiP3fPpKxpkQK9nZSvF3CWplXnJNex/wemdVJhNORic8vlLrn6X0mGU3Nvalz4N/a/7QWjMKIlpQ2VLrV1E/v5VrY6yc0tm6uRh43ir5rgGxZBWYqPT9oKmq+tiGO6moLiDPFqRB7faOUJMEH/zXqq2r1W7sQDx1ETmGS7YYxf7c2qDmnHtyrcSL1bvFPO2GXMCEK5rDo7F8xCipCRr+/47nc6LGS3x5W+p1QhW6vQacGoALd84K7uaFTIGR0ItR+m/9TFHYWqtcnjf0TeeLXQlULzkB2ndwRS2alAt+uUfRWyTgk4wIElN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/8fb8TGVZ2wRfIziBAcqkzxaIYB/us0nO/tCrP+47w=;
 b=lAydB4llHuuo8s4hD6w5jw3RxycAQyIUUEQhI+FIakqmdAF24x5+CILSAYlnDHYSrPmN0C++ukb4yR87Qum8uzGFkmFyCj8sljhNrDX4mzNjYjK4PtwF/2pM3TVOfIMZ2d5J9qpBJISWcsdQxt33P2gQt0lrfdkwhdOPSdSV9cSVNmyrOIV76jXHmA1/BBhLCBZWRGKiLKN7jRgYpF63VlrTnmp2Fa2GT+NSDVB1O9g0QtypCZBQAt2hJ7Zp+MLYaKIeHpljzsFby3Oi/JVdXFFNg3vzt0KUYojOJQ48q5/yxwW8s7XX+BLIyy4Jg9uNrYqLeA49P+O7ZPep4Qym+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/8fb8TGVZ2wRfIziBAcqkzxaIYB/us0nO/tCrP+47w=;
 b=wSaxy9Nm1a8bVklDQJb7gxbxk+eQPwCr/5aMNEtKqXHJ5ZJVuHd4bSqKtNHBwfnYLKnZqCa9lY2j4s+Z05J5+RzUa5d8lUbFiY9m+KjrDqpznmD59yXPWMH1bE5eiAf/mo8gR9WPhe8L7uazulzd0lNOdXEu3XiBT4CJEvfEG0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7090.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 03:54:30 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 03:54:30 +0000
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
Subject: [PATCH v12 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Fri, 27 Mar 2026 12:54:22 +0900
Message-ID: <20260327035422.4020455-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327035422.4020455-1-den@valinux.co.jp>
References: <20260327035422.4020455-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: aec3e780-6b7f-40a2-a75c-08de8bb48cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aFKNtbKRcQxa/kWF/1of95Z8NJWK1ePTVWTf51OqSUKTBQcxHkJhqFVyv4+zXuK6mUqr9hthGsdCRaTB4/zeIMnCNTP6ZHZzI47rYLS3sMZQEfmUE8WWMcXcHOiWQwHlwIm4PN9iqHW5T+0iUBiEc+5bhIoXTdQawzbeXHLVvdQPCU434978zE8toP3WYEqkchZD8TqvifdxgXFRJCcfgmOjZVegiZkTcI4MfB538qsJZvOMfdIGqSqrIvxRIvk39mffWO1lc8IwuI9l+nEDEGBqYOrawp1pHhKG+DS04vJ9ZRfkcgzVNpvC33694Z94E4ayLYev6edvJk8lZxEdGeYl9LOEzi6GhzpWyqk/HjtzNYftVNcVItl3M/lON789s7UMPGgbcQdEqdI+v6iJTnXEF9Ae3YEQPJZ4Jxmfc7uThmjvi9sqsNv2kxErbxaFy7kwOlOkrdwcBX8M9hjSKU/0C8S6vQwrcVA46avOxG6weQnTdt2DySO9+SHNLXCXJPCX5LyQTSqpPV1fheLOmceGmrH5z0FU95mKZXQDKRL+S3XOyz+i9mSod9gue4dbmwYBrvfZWofQ3vGEU55uso9aKboxx+O95sy/0mdzGJpFtOWlfUxr//XM0eSaa8hSHDjOngiO3QnupPsZtzEBHxNmbi3MU+TsYW5+eOzEaszwMVG/M1R6vPz4/6mCilo5WoT6ih2Z89M2AJ+f0gGsngDTHwWQ1gZvpNBgr6Cs8b6FF1kRSUOr7qbCJX2OXqeq1eSFdWaVsOm+y4bm2HeW1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tz96X0ItyI4Vc9lsPjoc3gNwpUZRiYCFJnihVDmJVJsyaL1g25yWf1HgA8zS?=
 =?us-ascii?Q?prU1QsQIssrBHoVPkvIjVGvAdtEGE552cLB4rAxPQRdFQqAvVsx3QZkNtwwZ?=
 =?us-ascii?Q?SORqwOFE/a02KMu3HAkbzxSBsTfuOwOwC3b/pGVGvYh90ggyD/c3zJhe21FY?=
 =?us-ascii?Q?RsyHbvUPn0lv+QPLJlGmbKkw+ReUOIvKEDUEydWOZ4Pm3fwyH5pxvx5qrIn0?=
 =?us-ascii?Q?qCgW03dc9EjoFCORI8qKgTPhVBwpDz9zAIhTaK/g8XlQlx62wlSp4jzXtd40?=
 =?us-ascii?Q?15xQb0cOgpclBD9lzFOLej3EFDqi8mf35Km889ISQIQvMdUcBI8nPcOcgeTn?=
 =?us-ascii?Q?UiRBmOyXxgCIxNJku5zaDojjRsqctHrDtOcFUIxR1+77Xim8qjHQQw5bulkA?=
 =?us-ascii?Q?BjiXSL77vGsxJAmUAX+7bLVPW05vP3CFxWzr6D/gNQgaOm+cR0H4mFTvFznv?=
 =?us-ascii?Q?vhgpgWto4+ntIu620AIhOCHuCsQ9LY/8K2FMP7nyw5KXkUDyBHiQ8vy4Vtqp?=
 =?us-ascii?Q?gDDEs2lP5aM6t8KEAk500CquaD694sgxMhMN598PAsu4pZ4EXZ2HjsKKzj8J?=
 =?us-ascii?Q?Kgqydll5s1EXQLBD7n+V2N+4kBeGxzbSyyGWJluUhDl5UctOUIQrZ9qLzQbw?=
 =?us-ascii?Q?BxcuyZ/0OeZjUCjbH/phsSxpdffbyVUNKcUBg30kh8CPIqMpRHS81n1ban8I?=
 =?us-ascii?Q?dVAyeNQFqFAqBAXNnqzkcp5gi2rsOssNqAiG71NYPI5ca23KsQwPt0nM3AQt?=
 =?us-ascii?Q?TN6qR/lQoOLi7Vd9DsVjUvnCe2yaLYJH6ozhXqmVhOqggQAN4xLvw6N7D3xB?=
 =?us-ascii?Q?vhR0Td6Vn6AmO0OYpoaIn6YJXWrdVu+zxe3Y3OjV2swy0AFZr+Ut4isI1zIl?=
 =?us-ascii?Q?uFtposgU+dSAxhS/+1gZlphGjpVRJT1qtbZvy8eYmh5lhAmg6TaD+nQkmOeb?=
 =?us-ascii?Q?Nc4QEzIDj8e597v3+Ag9ZvOEYHPwD4E/bgFn5SuXOXYvQ6QPaI4/TxpYdACf?=
 =?us-ascii?Q?rqIyoFEkO9F+/qqYZzvcSMq/M/PldNDFw1JGk+vSgkV+hgauS8HLJHgXCTjw?=
 =?us-ascii?Q?fMihsIZmFe42XpC2Zctzs/uD8Z1k5TzAqx6suKHh/BoGKs4a2tbc7IUiAtXT?=
 =?us-ascii?Q?NGrwG8zJXTARV9nREcMEF+mgUqth/AWB5+NBmUwZFjBEyR6pJIouYy81w8Hb?=
 =?us-ascii?Q?nJd7p3DoNIbMFBnpnHvD3KQT/xdjNGMwxE/bou/zw1ShXksP2d3cCjjnc2YZ?=
 =?us-ascii?Q?p9E680c7goXnzVKlPauCiDOBTFcsjuJ2qR3fIxvvSqN2AjaXJ/rmNbKehvWM?=
 =?us-ascii?Q?e3TgmQbi6Ei0AM6JMNk6bigYYCfGCuqWN31s2z5y0OnV46/0juLTQjxaF+Ni?=
 =?us-ascii?Q?tqRcuRVZ+/cEJsrdMKAFLZx6we5aH8KUZ2mpXZ4uIAY1gVk7P8EIWIk6lPq0?=
 =?us-ascii?Q?N0dF7YUjqpkDZayXJL7dias5CZVEZSZhTyKZdylhbs0ZfPo5TvGqbD4eVXXd?=
 =?us-ascii?Q?Nm7YS5YIe2yzW983hZUfgWrlDvUsGxhB9D5jKT27i4MLORcgZaDqiBCERlMq?=
 =?us-ascii?Q?egroEC7xX8TXcqqW4ioQIV1BfejSjajaxlIQI0klqzKxh6EwNjSgpJY4f+Cq?=
 =?us-ascii?Q?fc2rvn6lSAIXnHIVLgb7dDu7DT1Zis+6REFrx+KXZACN6hrMHFvesgGwDIeL?=
 =?us-ascii?Q?F7MTJFpZCgxj7gdE2k3eaq3aNfavlCU/VSfHXVh2cNwHPmeIKF0BFhZ4y9aF?=
 =?us-ascii?Q?7CFcNgT20PQvSim1rBimw5hjDBKRZQWZJLFX6I5hTIdECLcX5o8Y?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: aec3e780-6b7f-40a2-a75c-08de8bb48cdc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 03:54:30.7524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dezn0J2IiOlGeTBIvGd2QAsbUOM2qQl+CDPG1WbQCdvZ8ZUs1w/KZTsqdZYfmblCEmOkZ2AhUbGcUuRVH1TKcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7090

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
Changes in v12:
  - Use the new pci_epc_count_aux_resources()
  - Add TODO comment and defer multiple DOORBELL_MMIO resources per EPC
    case.

 drivers/pci/endpoint/pci-ep-msi.c | 135 +++++++++++++++++++++++++++++-
 include/linux/pci-epf.h           |   8 ++
 2 files changed, 140 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 85fe46103220..0d720556205b 100644
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
+	ret = pci_epc_count_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					  &count);
+	if (ret == -EOPNOTSUPP)
+		return -ENODEV;
+	if (ret)
+		return ret;
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

