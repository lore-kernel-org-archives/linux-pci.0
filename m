Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F2330B3F;
	Tue, 23 Jun 2026 03:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185130; cv=fail; b=Ll3KTnOp3LX/smOT4D3zoHYOP1ZjndbuA/ECBExQSzXXeMzYsPGmsecvaq3BX5jEReMitHVCR8lqZeKHP0a+wpWUGVk5CW2UpwOLzEcxH49m8m4k3OPC1xDOaMhM0kfsY+UB+u630KwHprGAWxkptxKgBAQuHBgCq1TdbkFMR7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185130; c=relaxed/simple;
	bh=SUYXcLCSf4Rxd8p1U2S6s/Nz/IpbO9/pyxiiWd7fMHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nx//L4AMcjSx8gUEbdJT+MGSv9GmZBZQLFflkwzIPi8vxvXrHd39vwb4sOj5u9L4u5MMVSOr2jXhZ3olofcUBcl77g+W5rOtTMKJ8F00XZr6iAWCuvKHiIpBfnqCczwX5nZcS+VLwvkHh+7eTZrKPE6hAiwU0NAnPhh7gqlV9NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WjccB4xO; arc=fail smtp.client-ip=40.107.209.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WjccB4xO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz9IL9P/kWlWzn4Vups7nINiIck40Fmz4Z2IOSfEWMGqTL4Z221WHurIFBfDENBFutfHoekMmyUvyMUgDO4JjbHwA0XGzuoGGT6rzD0oy30Mufn+iqt0HMpjMAPOiU3WGoSx/Dl9B9/fKRvo29gW11jun+MwbjF7wRtzu9BMlagPxcIjUIf99V9tdaQy1hQDEg/5lGa81C5e0ozMDGFtgyZKEUvQTr8An+uKHz63/RwXQUzki3hExYmzt8HYDntol6SvgHUUo4ouBSOjJo5WjxjUcw9rrj/eY5GfhVfD8K7r7tJg9ykioYDmJDqTGZFFqrAicpelbfcUt5p8uWlAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ajr1hmOoe+xlFO843EVOm48GpXQVCDgnnydpAXHdQbw=;
 b=OBHFOq9RiQ7OEXlHlLYbDwfEeqeWqQezJrlrNKH8atza82DXTA0MIGvXXtBbY8QnC8hEevXRgS1m540H3B8ONzBJzbpc5ve7pf9pLW48Ul5shuMO6kLyaeGH1qbabACV2R5rgJa1vCZRSHeHF/YEVrAx/bjrhCRit+tKMSTWiE/Y3Eol6dafZElbq/8TPiN6KX42K7Aq8GFkdFmN3w0FiM10l8yv9Go6ZzGIBl6yaOrrWmTxS9faw7LPCaMKimhCFOX1EXuXacnSMhoyefkKYiW9LKBgNhYbKDgJHa+ENRyF0mf3HUcyawyqWea8KbSweS8dvaKcNPjGQ8ZYFvVVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ajr1hmOoe+xlFO843EVOm48GpXQVCDgnnydpAXHdQbw=;
 b=WjccB4xObiFhmd6y2/YOKDSHNRYDW5hp26OcjKhRYkyNhe41s0x9GQDWDPfAZnaHl6GfvvpzobX8BCzune5uqFrDr7dsiZd3aoQqtKjQIL3R5zEMKiHyxB1O5yw1NAU0I8d5DRuv3SbpHJ3ayz+IHsNgUcCjpkqMlwfQOIroOJiAqmAy0yxTIGCsXLr4BjVj6da07jZDe7bJixJJFK/bDUz/MtgHr4ICbJFem4lRHn99ixyPaBNULH1pnDRjcAlxrG0NDQXfU+QuGLiqip7ksxyP4xq0W9Z+MNABhJNNL+DlbeF/KQmN9zjU9V1Oue2rWyMZgpScTKMUYaDqgAtHfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 03:25:21 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:25:21 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v7 10/11] PCI/cxl: Expose CXL Reset as a PCI reset method
Date: Tue, 23 Jun 2026 03:24:52 +0000
Message-ID: <20260623032453.3404772-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623032453.3404772-1-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::11) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a70983-c3ca-4d6f-289c-08ded0d70e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|921020|6133799003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	U7GaIkit+41xjmE1zr2GsYDh3WRdBy90Oq/ZkWw1FQ+lszmapQKgK41e27afvUZc3EbpayyLHfp91i0oQWcdJiNHily92HhstDqcJ+bQ+alPM82biesMdEEq9Yh4u+tT5YHgZxm3oL3wbT6KAVhJSI3iKPvFmY0HsVmHgNlOdmCWUfDwULIwtfKWI7F4BOukJf1s6r8mKLn2Ropfla1gcJKM/o8+FkMya2yBTARvP0y5QJE/erR+HlGCYbmpxtt2OZ1koz7VfwM5J628s05LtJYl2jAfJO+EpZx9H4COKwilpxf5xlDKJhH1IjqnuWJX9hqXesCtVAPFToA6l5EutB1Qif9Vsqv5zL1VL+A3Cpn0398rmCgZ5FOn+ttF6eP26CdvIlzU8ld2xZUNzQPRfvOdC74s+/W6mrIB2Uq5QzZykN/W4KX3tw1EuhQLsIFF6Rab9u7Sqm8FiZbiCrnLK1gA/cH4fzUzLC5Afp9AzB7Lu+AM72FAB4GHGL12VZmqyUPGtxBoL3VVgxBObONAPLkX6XWuwKf50g3GX/t1Wn1jYCuLEQR50FKFZx+yH9kJQBJAVB6iSZVAVIsDPN97zrM2VA0y0ykFvjF6OV0bv4Vf2xXM61d9Pk4ZGtTojIEb9TBd/VR1EN2OILZZ5d8lAQykTGXAE57fCaI7rWCPP/5z/OKcDz1pD3gkEHsxlpcPnyWPUflCMEQG6PUsevtQ4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(921020)(6133799003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bk49cjKD5sj9fTeMlZlQe3VPqUL14EHO6HW5MklNOr/wN/4xPpo/FdXncSTP?=
 =?us-ascii?Q?kOs9KTYlEyDi8VkMmmTWjDwGYNMXZdbY3MRR1MNGMDiGgLPkq8v3Q1g8Iv5H?=
 =?us-ascii?Q?XFooNRTMWwwHHixAQh5VTcZZwiyYOkiKXTUdEAEdf5meulSUltUOuvIC/E9e?=
 =?us-ascii?Q?yS8b0gOifDEq2WOcAUSMV9rA373Uk2vFcU6q8tS58FThiXUGU28dZ4IUKUMz?=
 =?us-ascii?Q?TLAU7TeHnQscM9ORRoOouKz3Csz0mX/NTLFRdGRsus8860XO1xQ508R9MbR2?=
 =?us-ascii?Q?thkDg+USkviCwCngWIUPcL/bQex8+clk1WXrUVzJiVAyN73v/9gKSvJpiWE1?=
 =?us-ascii?Q?39gAyQLUCh9Ri/mXnaMIEWdX60oXaFcZHhXonw9Ta4ZUwBIOzsl/cwsDigyL?=
 =?us-ascii?Q?qMcSFRtvRP93k+jylz8GHjcGQrkFIn28TS7pWhKoQGiEbAS6PkqmxTcv5wNh?=
 =?us-ascii?Q?v7rhJdrpSMVPVnA56ELzqStrmgv43zBRfLNOhExThBGps3bNpnaS6TyaNF3I?=
 =?us-ascii?Q?INYPcasfZ2rWnW3jtW81cWk7RBK7SwBiMAT0FcDndeeZ+QiwsJhdaz6+LwiM?=
 =?us-ascii?Q?zHVwfYuJav4BLDP1ZLsCp73/ahhI/1OXrg+cScZzoUxbvZTL5wqK87O/0Xfg?=
 =?us-ascii?Q?xXgy2XYaOnRODxCTCGm1mvzQbRpqLqmM8veaxqVWaCP/w66KBBeLGAVMTVj3?=
 =?us-ascii?Q?6cA9+veNJyWBIqoV0Ue1PV4YDS7h64Ab4gGBnG8rb7S7qkpkQUdcD0SE8Z09?=
 =?us-ascii?Q?ZBsdFF5P0j6HkTU3bSBm7m9GSBOXnTUMtuxIt6sJ9CmY0L5m+eXAtVA6h/4p?=
 =?us-ascii?Q?xq1+2SfNP7ZQ3luNmd1EmZw+ashZfGWvLg0LYsKCFqwUpOHGKs9w/JOJ1JYH?=
 =?us-ascii?Q?nWIrF3TlR8vXmFc34MLV3ak8ZHDd5BeieAUObP2gTKx3Gc32WWpxjol52NAP?=
 =?us-ascii?Q?szGpBj5V32TDRRhFyrayBgKPiIIQrEKbgV19s4UaERtyJdJSZ3Gg2VuFffzx?=
 =?us-ascii?Q?Q/nVYFajf/32KDJ2LtHUWW7k+e8GXSgAWmRn0IK+5cKtkW2g2YKHG6J8VSdp?=
 =?us-ascii?Q?L3WxguS3joMbwe+8LfxyJ6Zk53tc2QjcaMZZ3TIbH9GFMz4Xsuc9RusWl5zH?=
 =?us-ascii?Q?SQ9mshHK1J74twyACy57GUWgBsreFXxJvzoT/QycsF23n+Z2DgAVapIyLRtJ?=
 =?us-ascii?Q?M6qmHu5hhMVL6AT9JHdkk+8UAsTcI/RS/oXh+GPkf3VQ7XswCXNu3bDnA8Vt?=
 =?us-ascii?Q?6XlrAYu/US2aHGgPbX1JGULNbqQ4tpQ2PcxbdceVQUDdAbC0UJ41o+J+wEAo?=
 =?us-ascii?Q?yFRr8AG5cBlmzDEg5l8nMxYHNKvibjbJm4OIdv6RblDtCRA6rQ/70TXeuY5l?=
 =?us-ascii?Q?B/EEt0cTr54CoHg+qKi+le3VrpIyx0XqLltOUaYDIzJ0eFOIFv5J+1G2XM6l?=
 =?us-ascii?Q?2S74j63nrd7tL7/xwEOqPDUprtQBILhN9gWVFhBYMsmDZcv0ztutKLm+C6U0?=
 =?us-ascii?Q?vSfb464dMCJ4ISRh+GLyX+k3j54fxo+7waJeyAV+Ec/1pZfYhqi97MAUXJ7i?=
 =?us-ascii?Q?0cPLLSa2aPr/++4+x80K/ahHsGPGCJj1XVHtBwDwx7SKqEscovN63aZdazEx?=
 =?us-ascii?Q?ruwCL+NEHqZrpCnMvpbgJqqTKudqgUdhf7jQ3CiB3Dxyq9/hwSp3Jc2fjaCf?=
 =?us-ascii?Q?SNDjFhK3g8Rg2LhO1Ja8qb6ZbpvI9tIlEDUmg7dnI6C/i1W5APNU7Lr0g2lz?=
 =?us-ascii?Q?aUd3gzWIKQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a70983-c3ca-4d6f-289c-08ded0d70e46
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:25:20.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RVwiVHPJ3LfXrvhxvTVtN12+tQw3vQluY0wfL1soQua8uzfC1mP3PXBCRzkg3UIeUJ/z6ROYtofiFoidGP/JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505

Add the CXL Reset helper to the PCI reset-method table so userspace can
select it through the existing reset_method ABI.

Advertise the method for Type 2 CXL devices that report CXL Reset support
in the CXL Device DVSEC. Reset execution still requires cached HDM decoder
state for the target and mem-capable siblings so that affected ranges can
be validated and HDM programming can be restored. If that state is
unavailable at reset time, return -ENOTTY so PCI can try the next reset
method.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c | 33 +++++++++++++++++++++++++++++++++
 drivers/pci/pci.c        |  2 ++
 include/linux/pci.h      |  2 +-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index d801c91a5cbf..694d8a3789a4 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -1035,6 +1035,34 @@ static int cxl_reset_dvsec(struct pci_dev *pdev)
 	return dvsec;
 }
 
+static bool cxl_reset_hdm_available(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info = READ_ONCE(pdev->hdm);
+
+	/*
+	 * pdev->hdm is allocated with PCI-device devres. Reset requests
+	 * operate on a live pci_dev, so the devres allocation remains valid
+	 * for this check.
+	 */
+	return info && info->regs.hdm_decoder;
+}
+
+static bool cxl_reset_scope_hdm_available(struct cxl_reset_context *ctx)
+{
+	if (!cxl_reset_hdm_available(ctx->target))
+		return false;
+
+	for (int i = 0; i < ctx->nr_siblings; i++) {
+		struct cxl_reset_sibling *sibling = &ctx->siblings[i];
+
+		if (sibling->has_mem &&
+		    !cxl_reset_hdm_available(sibling->pdev))
+			return false;
+	}
+
+	return true;
+}
+
 static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
 				  u16 clear)
 {
@@ -1211,6 +1239,11 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (rc)
 		goto out;
 
+	if (!cxl_reset_scope_hdm_available(&ctx)) {
+		rc = -ENOTTY;
+		goto out;
+	}
+
 	rc = cxl_pci_functions_lock(&ctx);
 	if (rc)
 		goto out_unlock;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 360f2aaee10c..b1ec20126390 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -33,6 +33,7 @@
 #include <asm/dma.h>
 #include <linux/aer.h>
 #include <linux/bitfield.h>
+#include <cxl/cxl.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -5081,6 +5082,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_dev_acpi_reset, .name = "acpi" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
+	{ cxl_reset_function, .name = "cxl_reset" },
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
 	{ cxl_reset_bus_function, .name = "cxl_bus" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4df030837a3a..05b5feac5a49 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,7 +51,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
-- 
2.43.0

