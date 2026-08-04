Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C51E339379;
	Tue,  4 Aug 2026 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871832; cv=fail; b=CbFqnBWSDbkelmau8u5sZtWN47OsTzc/towj3RBlZT1R8ZAf6HIwnOTPhgkINrYrWdXIcffgKruyb8zyAEZXAcYGUwszvfzB6bXGeDjqU1VDiKPekF4evhjqOx5Nl/DbgkECe/fVGGMK1RJ+9ZIuxGEo7/DYSzbce8o46r7d/Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871832; c=relaxed/simple;
	bh=TLExlai3AglIvBOXSDRFEoW/x6/EP7auJJFI1ha9DEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bw+LJ5K7MqLH6GseLoqETucmx8FJjQkwZvjAfCfYey9Nd1j0KOSUFH6pgvVnFq1lPE33ABoNuyvb51L1jiTXOx/94UfLjIuq7qabRf7uGrXj/pzIjBtjkrBD1FNxPgdLKgOavIEKWkvPQ/MkyMPV5vT9Hel97b7EARrHSkaz01A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L50Ksz4x; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L50Ksz4x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LD/6nWHWYDTZ7wrBzG0sAfLn+VD4eGJvKWk+BC8bJSQjlZybPrn8ElaTR30GsTv0xvgy5DAg6Mo9NrxGCLLh+23aUJtNV6NKekVA5gu4UoArOyML+5coegvXu+8R2od3BzPmE6oflSYco1wjoWo1DjNSBL9DsTSbqjLWuV6h44h2dLCixbsiQNNhgwD4Zc/k6Q7uTfMScumg0L+DUBDyp/KAaAWWrKHQd2Jviid4w16/WBpRNjvwAlT8FgqT7RLT1C5x0+cNxKjIqI+IRcWGmw6ejvxRrU0xnBBmY3M+02MzTpS2dGx7dCHt6syLRrSZbmPU9NjG+heNiujCjuUL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEAlCKE6+454HNWlLhBu7nty6k9TFeST9hM05fAhWU8=;
 b=j87CUcqG9pWzscgrX/vm0Crx58m5no5zIColFnpikANKpoFE7n0KWDUMi0bWB552O7Lzmc555HcKhGfZxbfGqgdC5bbI3rFicGyLNlgMipvaV2cJTJDVof2GYvIwTDOGzqtvWp7slaa3C2++V+bqLXI0T0srQvMjk7MOie9bx+Cy0R9veUp2R2clWPsBSohYl3j+oQxQqV6orX6QEorzjybvS/LxuUw/xsBjctqfhU5G6Jsm2YnBzLSauYRHDtWYQ7B8DGbsFia4VDOvYaeXCfMnlG6bVKjgD3WLKj9P1XeA7odUt8wp/liuODmGJYO3SZ7Wg3paW1TFwdCuSdvXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEAlCKE6+454HNWlLhBu7nty6k9TFeST9hM05fAhWU8=;
 b=L50Ksz4xMbUfDodSsF2oht7ncuFsVfRRtdUU9+g6LV9kfYLfcl3W+BV+mL/rRcOFlvBj2NQhP1GtsCXeox/6KgHnGQXhdNMgfw78BUroooxXvirzBRAUH3Ph7CF0jJZnvlgApyS1kYtV1vVUsbxHGrH46wADW9kixXoqyQo6S16SVCBLzT0RBMzWH8y9GrvQyzMdsUK+zkACAqpIUWtiI9kKtJJVmIFlwVbuQg3Ag+uL54yIDBtrXgcDaDbJu9oXDUcq4ejOLqr402ouqxbz4Rdc5PFSVseho8bgeZZLVVu1PpE8c0nG8wsSuIbZuIFP1Q6KttAhgLDPjHCBfjG0nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 19:30:21 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:21 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v10 05/12] cxl: Cache endpoint decoder settings during PCI enumeration
Date: Tue,  4 Aug 2026 19:29:51 +0000
Message-ID: <20260804192958.1823952-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb4eb35-e20c-4f57-7c58-08def25ed2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|5023799004|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	XRGxRN+6WcJegAx5K2XmSnH7Tuc2g/WquhQaZcx0ta3Y8WsvehesPB12caow1BxR772B5F3y/JGPf+HB58zNs3A9CEZi6WnRUP7mSk/vtY8AaHCpaz6ghT3q0lYeH3Oe42dtdnTmcwZG+j2nw9mvnHJvrQ2gkia5Xo2a5XGhUooitPnHk0U1AZikGFsXY1TJFFddDWU1ekSFf7+ejDnJgGetSy701hbUpmJ2u8m2/yV14q4k0F0UZ3HFZS7ksmr7WMFYpHaO1GRor126p6VC1RXF2sjLMblSrH1QLB65cqT+4VOG6l8E1nFcmi1Z7Ps+B2DJm5SeupS04N3FWvgfjBJNGnGhRjFTWdRdLEjhW1KEOlC0BZdtxWo2j1vTCGZPgTaoRPLonPzxknJPPgaalojevacBFZR4zxqxsHwk/CM+NXIBYlR//xeDYja2yJeLpYoYFg2MbrT1y7SUW4AgaFlUx+0mFwzOd3pA3z2am8SyKNGsBSIfTOHs90RKyCkibji5DwoH/E0f9baPqt87Bc4vFjao5EEwY6aEFJ2JToECH5nUslaO8KM1m/H7+UFBiO4RNLWV1FZ/UOqm8dOm1K+Av3mEIProRlHwWFgq8kiLvHJBHYpquPekPS7FA/FW88uZtZA9/ziu2cjc5d83M7u2Poy784NBbNyn6sFj9K2qUrIdifN5S7FjbY+tCnWlgVYYvuZEuaggk0oS0GP4wg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NwmsyaxgEW5l/MoVMnaHQgTqPNxTb5No1W+5z3DkVzBMqbgvOGlV9KpP6r5i?=
 =?us-ascii?Q?ZjLJyxnKXXfSHPX/wD8/3Rj6LzTE07QIVCENovCSTwTGU44yDGyEdSLfHjPz?=
 =?us-ascii?Q?Rg4LHrpkFh2ojupmKDkbPuLwDiHYaKhii0YMVXjsAa65w47rako6Oc+hDFcX?=
 =?us-ascii?Q?gAk4WkRxYvRa1CEXf1Pna1oInnrU77YbJqMiae8AtmPJ3Krs8F41RtQKR9Ir?=
 =?us-ascii?Q?KCXC3VUYBHJGy3VgRZWnYKaLptm/f1ZkbCYw/vHzKMFsqaCyVUUHKc8ElRCw?=
 =?us-ascii?Q?tSkb83ML5d5BbfBAfpPBvzqSI2ZXPhi1d8pT/ToYLRNITUtJnBvdcl3xegJP?=
 =?us-ascii?Q?V+JfiA5EM41ROY8+YQsNU9NsMeUpGWpBDOdMzTpUcmlcFoaKM+o+TLmp/N5P?=
 =?us-ascii?Q?jkdzCdJgq41Jl1e5AHdyIQR4wwQxRh7v/GoMm0KjKNe8rpcdKRYeMjN6ATCE?=
 =?us-ascii?Q?VN1EjehEniCCPj/Iu1vy3Ex41Di/xfGmDZnqLPPa9FRbL2lst+ABsXpXAVzH?=
 =?us-ascii?Q?XwbUUMNoYMmWRgEty698m7UqsW5hx5n23uLrtuz5deuvuuFnj+H3hBfZuFWn?=
 =?us-ascii?Q?fceRL5dm8buEMPfdyc+7g2eBbzAacO7Dp2kmgJ7olXy+zq7G35Qh2Y9aaTtH?=
 =?us-ascii?Q?D2AG+pQj+p8ajGDyQziAPuffXvTijhvS6uCoVdHRugiSTxsAnyAcWN3UukZ6?=
 =?us-ascii?Q?gP5zWpgPeiV9da9GNezlkblaVncywkUWhtzA9o4RTULH/rapMq298XhoIeN6?=
 =?us-ascii?Q?a50vAJt0zPi5wxmZAGIPNEZiOajYbBP3lBwGk4WIfYoxD/xBsHyZt+SB8o3B?=
 =?us-ascii?Q?o0RNYlhoCKm4XrTIC6/Uz2bI0a/yY809oizuMpVVYZLmvYTduAbIvo/cYXJB?=
 =?us-ascii?Q?2lvcB4MJLjw3dnyRUlRvR/RyZor8dabVnbf3TdbGYtuq3y11qgQgxzURu7M+?=
 =?us-ascii?Q?AMNw9PQE5iLoG1wbbGKfS7hFJnGN/x1F6O57XDSK/kC1XwcS+YZ4HyRYVdb3?=
 =?us-ascii?Q?T7CXvedYWlabjwYahR4p1mhPT4gCNxqnuOpmESOJ9b89kKZlPR4Pe3RkYtM0?=
 =?us-ascii?Q?UTs2uEMO3HPHKevI/Xu7nx6s52GXKBkPQLJ5fxg3zPP5uYPdQZsINU/ed9C3?=
 =?us-ascii?Q?9O5kZ1KFsO0z7x5l2bzj+cri1hsjgi1Ud99i8w2Guz3q+3uKwcb4Q2iVjtnB?=
 =?us-ascii?Q?N9e8d0bqwscpY7mfA9UeQzYzxRKtWtDCKfhtBwqmk8OT9D0EZ80Euo4YEBEC?=
 =?us-ascii?Q?i1Rq3fdu9xcSKVQLiAzGOwVq6Cv4wfte89kHLkWRV0jGJDd8MB+Q6d9kuFNw?=
 =?us-ascii?Q?wgOI97CG0QdHG3uBaZW83yS6hGkIbwROPDL2yVbt2K4EZEbWtJPbcNm8I94n?=
 =?us-ascii?Q?xtiVItBTCG4aGbiGD/4EbugQj9xG9oDc314cKKeF19dD9Lq5lpqnJzib6d9g?=
 =?us-ascii?Q?g+PFcW9TY6+OYXAn7oa3J+M1H7f8Y6kS/x/PgD9HKw+JnXF2cQGCCKsc22p1?=
 =?us-ascii?Q?r+VZhHgZUbmTdONE10lEym8z47tB+acG41rNONvsTWP4BOXirEUvQvrMmUdg?=
 =?us-ascii?Q?TeSJSBWyL3GD3SACRy8yjkUOAjfOe7FZUIU6I4QoafQ2SAci65eQTKKaclJV?=
 =?us-ascii?Q?Y3hUTgyLpAF8968K/RTPIlvLiTZv1Gg03Nvk0lUw/CKlLRmrmAytygk6sNeK?=
 =?us-ascii?Q?QB72gXOZWzrldGJNGXvlOY4l6DmphCjFN0cUIDQZqWRK7TXNRXeJgpOPweT8?=
 =?us-ascii?Q?g3+O/iOmXw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb4eb35-e20c-4f57-7c58-08def25ed2a0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:21.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enjguUjKDWr0HnIp7aGzRX76g/VWrZEU25KGX8AqSTKFLeApDKjFh5Zw0fAl8tYhuTZBXvi6Jr2muMIHUSUoDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

Populate pci_dev->hdm for CXL.mem functions from pci_bus_add_device(),
after final PCI fixups and state save but before driver binding. This
gives driver-free reset paths an early HDM snapshot while avoiding the
pre-resource-assignment window in PCI capability initialization.

Use the CXL Register Locator BAR Indicator to find the component register
BAR, reject unassigned, disabled, or zero memory BAR resources before
temporarily enabling Memory Space, and restore the original PCI_COMMAND
value before returning.

CXL core reuses and refreshes the same cache as decoders are committed or
reset, and retries cache setup during CXL HDM enumeration if the PCI
bus-add attempt did not publish a cache. Move the register helpers into
the built-in CONFIG_CXL_HDM set so the early cache path is available
without cxl_core, and keep the cxl-test mock core from building a
duplicate regs.o.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/Makefile   |   3 +-
 drivers/cxl/core/hdm.c      |  13 +-
 drivers/cxl/core/regs.c     |   4 +
 drivers/cxl/core/resource.c | 313 ++++++++++++++++++++++++++++++++++++
 drivers/pci/bus.c           |   2 +
 drivers/pci/probe.c         |   2 +
 include/cxl/cxl.h           |  26 +++
 tools/testing/cxl/Kbuild    |   1 -
 8 files changed, 360 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 0df4178bbbaa..e22f05d83c39 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(CONFIG_CXL_HDM) += resource.o
+obj-$(CONFIG_CXL_HDM) += regs.o resource.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
@@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
 
 cxl_core-y := port.o
 cxl_core-y += pmem.o
-cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ec988e7b7c0c..b47701fc5315 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -112,10 +112,17 @@ static int cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
 	struct pci_dev *pdev __free(pci_dev_put) =
 		cxl_port_get_uport_pci_dev(cxlhdm->port);
 	bool present;
+	int rc;
 
 	if (!pdev)
 		return 0;
 
+	rc = cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
+	if (rc || present)
+		return rc;
+
+	pci_cxl_hdm_init(pdev);
+
 	return cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
 }
 
@@ -180,6 +187,10 @@ static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
 	if (!info || cxld->id >= info->decoder_count)
 		return;
 
+	if (cxlhdm->regs.hdm_decoder)
+		info->global_ctrl = readl(cxlhdm->regs.hdm_decoder +
+					  CXL_HDM_DECODER_CTRL_OFFSET);
+
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		cxl_decoder_snapshot(cxld, &info->settings[cxld->id]);
 	else
@@ -1002,11 +1013,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 size, base, skip, dpa_size, lo, hi;
+	struct cxl_decoder_settings settings;
 	bool committed;
 	u32 remainder;
 	int i, rc;
 	u32 ctrl, tl_low, tl_high;
-	struct cxl_decoder_settings settings;
 
 	if (should_emulate_decoders(info))
 		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 93710cf4f0a6..040b0304f63c 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
@@ -517,6 +518,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
 
 	return offset;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
 
 static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
 {
@@ -633,6 +635,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 
 	return component_reg_phys;
 }
+EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
 
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport)
@@ -641,3 +644,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 97cb136cb2ae..7f5946d3f2c4 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -2,9 +2,16 @@
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 #include <linux/delay.h>
 #include <linux/bug.h>
+#include <linux/bitfield.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include <cxlpci.h>
 
 #include "cxl.h"
 #include "core.h"
@@ -170,3 +177,309 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
 				  &settings->interleave_granularity);
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
+
+struct cxl_hdm_decoder_state {
+	u32 ctrl;
+	u32 base_low;
+	u32 base_high;
+	u32 size_low;
+	u32 size_high;
+	u32 target_low;
+	u32 target_high;
+};
+
+static void cxl_pci_hdm_info_free(struct cxl_hdm_info *info)
+{
+	if (!info)
+		return;
+
+	kfree(info->decoder_state);
+	kfree(info);
+}
+
+void pci_cxl_hdm_release(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info;
+
+	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
+		info = pdev->hdm;
+		pdev->hdm = NULL;
+	}
+
+	cxl_pci_hdm_info_free(info);
+}
+
+static bool cxl_pci_bar_usable(struct pci_dev *pdev, int bar)
+{
+	struct resource *res = &pdev->resource[bar];
+
+	if (!pci_resource_len(pdev, bar))
+		return false;
+	if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
+		return false;
+	if (resource_type(res) != IORESOURCE_MEM)
+		return false;
+	if (!res->start || !res->end)
+		return false;
+
+	return true;
+}
+
+static int cxl_pci_hdm_find_bar(struct pci_dev *pdev, resource_size_t hdm_start,
+				resource_size_t hdm_size, int *bar,
+				resource_size_t *offset)
+{
+	resource_size_t hdm_end;
+
+	if (!hdm_size)
+		return -EINVAL;
+
+	hdm_end = hdm_start + hdm_size - 1;
+	if (hdm_end < hdm_start)
+		return -EINVAL;
+
+	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
+		struct resource *res = &pdev->resource[i];
+
+		if (!cxl_pci_bar_usable(pdev, i))
+			continue;
+		if (hdm_start < res->start || hdm_end > res->end)
+			continue;
+
+		if (bar)
+			*bar = i;
+		if (offset)
+			*offset = hdm_start - res->start;
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
+				     struct cxl_register_map *map,
+				     struct cxl_hdm_info *info)
+{
+	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
+	resource_size_t hdm_start;
+	void __iomem *hdm;
+	int rc;
+
+	hdm_start = map->resource + hdm_map->offset;
+	info->hdm_size = hdm_map->size;
+
+	rc = cxl_pci_hdm_find_bar(pdev, hdm_start, info->hdm_size,
+				  &info->hdm_bar, &info->hdm_offset);
+	if (rc)
+		return ERR_PTR(rc);
+
+	hdm = ioremap(hdm_start, info->hdm_size);
+	if (!hdm) {
+		pci_err(pdev, "failed to map CXL HDM decoder registers\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return hdm;
+}
+
+static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
+					   void __iomem *hdm, int id)
+{
+	state->ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	state->base_low = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	state->base_high = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	state->size_low = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	state->size_high = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	state->target_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
+	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+}
+
+static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
+				    struct cxl_hdm_decoder_state *state,
+				    struct cxl_decoder_settings *settings,
+				    void __iomem *hdm, int id)
+{
+	u64 target_or_skip, base, size;
+	int rc;
+
+	cxl_pci_hdm_read_decoder_state(state, hdm, id);
+
+	base = ((u64)state->base_high << 32) | state->base_low;
+	size = ((u64)state->size_high << 32) | state->size_low;
+	target_or_skip = ((u64)state->target_high << 32) | state->target_low;
+
+	rc = cxl_hdm_decode_decoder(settings, id, state->ctrl, base, size,
+				    target_or_skip, NULL);
+	if (rc) {
+		pci_err(pdev, "CXL HDM decoder %d has invalid configuration: %d\n",
+			id, rc);
+		return rc;
+	}
+	return 0;
+}
+
+static int cxl_pci_hdm_capable(struct pci_dev *pdev)
+{
+	u16 cap;
+	int dvsec;
+	int rc;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
+		return -ENOTTY;
+
+	return 0;
+}
+
+static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
+				 struct cxl_register_map *map,
+				 struct cxl_hdm_info *info)
+{
+	struct cxl_decoder_settings *settings;
+	void __iomem *hdm;
+	int decoder_count;
+	int rc;
+
+	rc = cxl_setup_regs(map);
+	if (rc)
+		return rc;
+
+	if (!map->component_map.hdm_decoder.valid)
+		return -ENODEV;
+
+	hdm = cxl_pci_hdm_map(pdev, map, info);
+	if (IS_ERR(hdm))
+		return PTR_ERR(hdm);
+
+	decoder_count = cxl_hdm_decoder_count(readl(hdm +
+						    CXL_HDM_DECODER_CAP_OFFSET));
+	if (decoder_count < 0) {
+		rc = decoder_count;
+		goto out_unmap;
+	}
+
+	if (decoder_count > CXL_HDM_DECODER_MAX_COUNT) {
+		rc = -ENXIO;
+		goto out_unmap;
+	}
+
+	info->decoder_count = decoder_count;
+	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	info->decoder_state = kcalloc(decoder_count,
+				      sizeof(*info->decoder_state),
+				      GFP_KERNEL);
+	if (!info->decoder_state) {
+		rc = -ENOMEM;
+		goto out_unmap;
+	}
+
+	settings = info->settings;
+	for (int i = 0; i < info->decoder_count; i++) {
+		rc = cxl_pci_hdm_read_decoder(pdev, &info->decoder_state[i],
+					      &settings[i], hdm, i);
+		if (rc)
+			goto out_unmap;
+	}
+
+	rc = 0;
+out_unmap:
+	iounmap(hdm);
+	return rc;
+}
+
+static int __pci_cxl_hdm_init(struct pci_dev *pdev)
+{
+	struct cxl_register_map map = { 0 };
+	struct cxl_hdm_info *info;
+	bool restore_command;
+	u16 command;
+	int rc;
+
+	down_read(&cxl_rwsem.dpa);
+	if (pdev->hdm) {
+		up_read(&cxl_rwsem.dpa);
+		return 0;
+	}
+	up_read(&cxl_rwsem.dpa);
+
+	rc = cxl_pci_hdm_capable(pdev);
+	if (rc)
+		return rc;
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_hdm_find_bar(pdev, map.resource, map.max_size, NULL, NULL);
+	if (rc)
+		return rc;
+
+	info = kzalloc_obj(*info, GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		goto out_free_info;
+	}
+
+	restore_command = !(command & PCI_COMMAND_MEMORY);
+	if (restore_command) {
+		rc = pci_write_config_word(pdev, PCI_COMMAND,
+					   command | PCI_COMMAND_MEMORY);
+		if (rc) {
+			rc = pcibios_err_to_errno(rc);
+			goto out_free_info;
+		}
+	}
+
+	rc = cxl_pci_hdm_read_info(pdev, &map, info);
+
+	if (restore_command) {
+		int rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
+
+		if (rc2) {
+			rc2 = pcibios_err_to_errno(rc2);
+			pci_err(pdev,
+				"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
+				rc2);
+			if (!rc)
+				rc = rc2;
+		}
+	}
+
+	if (rc)
+		goto out_free_info;
+
+	down_write(&cxl_rwsem.dpa);
+	if (!pdev->hdm) {
+		pdev->hdm = info;
+		info = NULL;
+	}
+	up_write(&cxl_rwsem.dpa);
+
+	cxl_pci_hdm_info_free(info);
+	return 0;
+
+out_free_info:
+	cxl_pci_hdm_info_free(info);
+	return rc;
+}
+
+void pci_cxl_hdm_init(struct pci_dev *pdev)
+{
+	int rc;
+
+	rc = __pci_cxl_hdm_init(pdev);
+	if (rc && rc != -ENOTTY && rc != -ENODEV)
+		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
+}
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 655ed53436d3..5fd7bae8e786 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
+#include <cxl/cxl.h>
 
 #include "pci.h"
 
@@ -359,6 +360,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	/* Save config space for error recoverability */
 	pci_save_state(dev);
+	pci_cxl_hdm_init(dev);
 
 	/*
 	 * Enable runtime PM, which potentially allows the device to
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18..0bed5638d6da 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
 #include <trace/events/pci.h>
+#include <cxl/cxl.h>
 #include "pci.h"
 
 static struct resource busn_resource = {
@@ -2484,6 +2485,7 @@ static void pci_release_dev(struct device *dev)
 	struct pci_dev *pci_dev;
 
 	pci_dev = to_pci_dev(dev);
+	pci_cxl_hdm_release(pci_dev);
 	pci_release_capabilities(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 703285966946..a1fe8949f3f7 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,7 @@ enum cxl_devtype {
 };
 
 struct cxl_region;
+struct pci_dev;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -135,16 +136,41 @@ struct cxl_regs {
 
 #define CXL_HDM_DECODER_MAX_COUNT 32
 
+struct cxl_hdm_decoder_state;
+
 /**
  * struct cxl_hdm_info - PCI device HDM decoder programming cache
  * @decoder_count: number of decoder settings entries
+ * @hdm_bar: BAR containing the HDM decoder registers
+ * @hdm_offset: HDM decoder register offset relative to @hdm_bar
+ * @hdm_size: HDM decoder register resource size
+ * @global_ctrl: cached HDM decoder global control register
+ * @decoder_state: cached raw per-decoder register state
  * @settings: cached per-decoder programming state
  */
 struct cxl_hdm_info {
 	int decoder_count;
+	int hdm_bar;
+	resource_size_t hdm_offset;
+	resource_size_t hdm_size;
+	u32 global_ctrl;
+	struct cxl_hdm_decoder_state *decoder_state;
 	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
 };
 
+#ifdef CONFIG_CXL_HDM
+void pci_cxl_hdm_init(struct pci_dev *pdev);
+void pci_cxl_hdm_release(struct pci_dev *pdev);
+#else
+static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
+{
+}
+
+static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
+{
+}
+#endif
+
 struct cxl_reg_map {
 	bool valid;
 	int id;
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6c09932587ce..2eb61812a8e7 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -55,7 +55,6 @@ obj-m += cxl_core.o
 
 cxl_core-y := $(CXL_CORE_SRC)/port.o
 cxl_core-y += $(CXL_CORE_SRC)/pmem.o
-cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
-- 
2.43.0

