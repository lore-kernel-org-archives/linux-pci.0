Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667D2836E;
	Thu, 29 Jan 2026 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678308; cv=fail; b=eRdlsAOW/kEWo4+ojAMB9QnrXmx9U7QRxR2aRZxnQrwTU3cTYwA924Af+CAHLh9NhOE0qmVlZEeqGLrIz8F6QlwCjbEoYkFvi667N0efGg6TKJiBaT3NkuJd6FpvkSLit3Edl/MFEqTPmYryNEMgxlsDpRCvja+7q7E6U8aBmWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678308; c=relaxed/simple;
	bh=ycTynOqFJpLql4mhaUOl7FjyJzPcsp30aRR71/gAmLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrbFtuPiegSbpkrJ6RUkloGTvpWRJDbwfZn8TUO/PmaG4KYgOY+p0Sakdlmbz7DsMKIEAIS7OQJj7hMToOmxmKD/uKuMgHLV9d9DrUIyvqrUsCjKXzoHbrW3kFxKL/V3fkasTnNEDD+vwadvlvRpfTTm0h1DH0ztePbCduwPXns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BCvVdqDl; arc=fail smtp.client-ip=40.107.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BCvVdqDl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3ndn33DYdbI/JBam9/pxXkQcndVWUzltmAp9Ju+ToX0A3+WVMlBDjUmtx2ckEM3ATMYtEiucwDICNimX4XuOfIkPHw3U1vfy0nXaLP6o4Q+4U6WLck4l9OoDkvotRK+4lOEXC26s6Q0Ef6oSdM3p4uugtSJn30PwWtA3Aff+k3EeWWqXz3DVYasKOriAHhBux6YYnlmIJniAcM33VBf149dfpNEi3q+DZNbhBC5F93nJ9j9HUJbr8y7zjmySMgffW3BAOdgpDV3dIwgPphVg7HUE4E+UN/J41P0JklyT09EqNVxBD+2lqzQvk2LOI5xgMBNgL4oOCwWajc+FhIhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5vNfEJuBgS5bWs8ncayXQUzcKIMHzV5IABp0uAHhhM=;
 b=hpRS1Kh/R38sdpq6GZ39boRUOSE9oMDBA/MnBDDnqEi6wMfAmltPTvtlIOQJxQ7O1K3YFUmkJtoZpfClvrd/maUo2ggZGwNiuo+KsKYtRYW7IFt5pWb3Mtw9DtP8Benj9N5IOlFCJRubvU8h4Zjx/1fF+9bXhZI4S957pINGiXqq+FEf80F///SMXq8ii246f1OsDz/nzijV1+BdtoSBF8RyDLuJG1WnG+9SuDErqNPXzThsoCBbeHOgoQeM6EdRdK+3iIi8I13rVW0cKL/g8Qcj9fD+RSkdxO5eu0GeKR1fGCWinHTy7/zCb+tokEX1aGiT8D3LRNByciVGsXSVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5vNfEJuBgS5bWs8ncayXQUzcKIMHzV5IABp0uAHhhM=;
 b=BCvVdqDlbU12Q1p8lPcq2c/pbFNK0/woJ/A7NK+jSEUqP6oW92DgZZMho/PZ50QrMj3htkbFqPuYhwEArrvY349bIqRuCFDn/PVjyk6dKe+KgWkgts6geWqJmb/sT+CWJpPhIT3gEUGP2lRNMFtoCfGLMLcijbZXVxDhBw6Kk1k=
Received: from BLAPR03CA0128.namprd03.prod.outlook.com (2603:10b6:208:32e::13)
 by DS7PR10MB7190.namprd10.prod.outlook.com (2603:10b6:8:db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 09:18:23 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:32e:cafe::6) by BLAPR03CA0128.outlook.office365.com
 (2603:10b6:208:32e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Thu,
 29 Jan 2026 09:18:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 09:18:21 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 03:18:12 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 03:18:12 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 03:18:12 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60T9Htkq3499594;
	Thu, 29 Jan 2026 03:18:08 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v4 3/3] PCI: dwc: ep: Add comment explaining controller-level PTM access
Date: Thu, 29 Jan 2026 14:47:53 +0530
Message-ID: <20260129091753.490167-4-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129091753.490167-1-a-garg7@ti.com>
References: <20260129091753.490167-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS7PR10MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 93567ec0-be6a-4f73-e2a0-08de5f175957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5NmraHNsWyPGXBAatWsWX2m06Q9hPjxkGmLwfYjlypNRRcoK5hk5j2mrq2iy?=
 =?us-ascii?Q?ONHkL5vaVKiYM8UzHd+LUjwTCR60G921oCHmzwltaK5VeUeWHX5dCvI5W+ZM?=
 =?us-ascii?Q?fLznX//gUSy8EG3uYsTKkilOJPCxocYzkc6v7NwkKklXmCj/d8tfqB/NTVru?=
 =?us-ascii?Q?ok6K8F5P+FmoLPcpbchsaNorvHforp8GliK21zkjVo8LCeUK143k8pfWfR5B?=
 =?us-ascii?Q?ad6TXY9KtTp1d0YWRn0u7iyjn9mplFTtRduXKD4vliNUkLsUoh+fVIRPxxX9?=
 =?us-ascii?Q?3PBCbM7xc02iqkkdFn4shQNYX1cOcipWL7X3lQ0gaam68tt3B0oweSNenL5A?=
 =?us-ascii?Q?1HtgnMYG6mmQQYS5kgY0hnIDbBKSNm1N1fnxyw4ahYGYGHhOteqgvcXorT4s?=
 =?us-ascii?Q?XnruDl8Uxwp7H1JgYiL+HBoWzJutZ61+HCdJakCUcfx52NeNFlnITEh09GUJ?=
 =?us-ascii?Q?UTAFfXj7yyPWjvHgTEJTzcGvr+dC733SiXCVBZ29hB2hUg4LfQbsDTRQY2Mp?=
 =?us-ascii?Q?nCQRg8sl+40/fedn2I/OJ5nHox5LAsqgi7MoCFBIkxej07Clh+nbhmHsu1ke?=
 =?us-ascii?Q?+22eUTGmQ2ppMCOdMmxF61mMv6O7GK4GWvXVC8U6RJYo/xg0MTNNnYAsra3N?=
 =?us-ascii?Q?SbSG4YdlHGp0PiXWcx2v8VcfoSXn/Z7ldJo7J5cD6/iguwqAE54N7RNl02Wt?=
 =?us-ascii?Q?oq+wDxi65stqBlwE5AcxoueaY5K9zyvfWIuzuh0P48tJNfldbeT4KerOm5LR?=
 =?us-ascii?Q?Y35v4UtZ886Hj+6lOgkkFBvJpwYZcknHlapKrueYXqN1viwENJIMOptGeaDx?=
 =?us-ascii?Q?GgLt/Zbi8emG3wPsZg9GSrddfjo8XcATExJa1fvo68/jpcreOrZc0tRmXBdL?=
 =?us-ascii?Q?y2Jti6eu36RIZinnN9m33LGfqTmZCQg/VMuJ9Ov0KukIF6ZvIWP3FnW79LQE?=
 =?us-ascii?Q?yNCmCWpo8pmElyOXaP8iRpeEz+JkqhUXrzTH+bBK0+xwqxTdiBLH0HygNoKD?=
 =?us-ascii?Q?7YWpYXxEdhuWB5F1tBUCcm06IP1neznrOmsUtmyxYqFPLSUnF+NL+BTAu74a?=
 =?us-ascii?Q?KnIOcOSDZr/swazfROr8SJVGiN2IxoPaxmFb1yOEz4mxc+Am1WwXV+fpdpcY?=
 =?us-ascii?Q?iQkYX7o8PbgaortTiDVe3gTwfSXPUCBuMO6+uPEHQejh8fbdDjD93+fUDJ6k?=
 =?us-ascii?Q?zkVx4HJy46SniNh46SPIIGAosyzYMpllrGcHWsjQkYexeKFCdHgXlsUlC2+f?=
 =?us-ascii?Q?hQ1rVAMVF0ktcwVvE8Q4qswgc/+PCiy0eEz9ldc7p3lrgDE7Mzs4eL7rMqR/?=
 =?us-ascii?Q?QcBCnCH4SkZcMrtM/FP9AC4rPPepYGK1IHj74xI31vLtu2wvfn6juZc4UMfz?=
 =?us-ascii?Q?teq4KH6fVzXxzPyEytLEfs3R1mucLd96u6J8uosrcNI91DZlMrfWfkj8NrIv?=
 =?us-ascii?Q?LAQCfYetNRo5Q6zN0zL23yQ+I2HvBpg7kPhyqZhhCw+qnEA48wb6KYZ8wJoS?=
 =?us-ascii?Q?ucK2zf7vdOiPe616cZBXxNo5a1mRQBM6PKd5ORcbFFZb6wCo4mq4IalFX+Og?=
 =?us-ascii?Q?YlZ57QAqZenvvIN4tegKsMPVQl5NP9UnBTpHFJ3iMzNQg98ZUgZNCgvFEmHD?=
 =?us-ascii?Q?pWt8R32lsUdOvqgpzN3/nAOCNytwDnzGrcaIoU7gWBwnzmuxia8KgXPO3N69?=
 =?us-ascii?Q?wHoePfpQG3R+zYXUiObrcLH/s4o=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:18:21.9862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93567ec0-be6a-4f73-e2a0-08de5f175957
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7190

PCIe r6.0, section 7.9.15 requires PTM capability in exactly one
function to control all PTM-capable functions. This makes PTM registers
controller-level rather than per-function.

Add a comment explaining why PTM capability registers are accessed
using the standard DBI accessors instead of func_no indexed
per-function accessors.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---

Changes from v3 to v4:
- Rebase

Changes from v2 to v3:
- Fixed the suggested nits

v3: https://lore.kernel.org/all/20260127085010.446116-4-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260122082538.309122-4-a-garg7@ti.com/

 drivers/pci/controller/dwc/pcie-designware-ep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index b9a234b47aab..aa0c1dac297c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1183,6 +1183,16 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	if (ep->ops->init)
 		ep->ops->init(ep);
 
+	/*
+	 * PCIe r6.0, section 7.9.15 states that for endpoints that support PTM,
+	 * this capability structure is required in exactly one function, which
+	 * controls the PTM behavior of all PTM capable functions. This indicates
+	 * the PTM capability structure represents controller-level registers
+	 * rather than per-function registers.
+	 *
+	 * Therefore, PTM capability registers are configured using the standard DBI
+	 * accessors, instead of func_no indexed per-function accessors.
+	 */
 	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
 
 	/*
-- 
2.34.1

