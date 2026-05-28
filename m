Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AFF3783C7;
	Thu, 28 May 2026 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957135; cv=fail; b=PsRlkCVLVNlqvj5aPtzafRbgRCI9Y44xiQMZuM9V19VAC5u3BrsZ0cK220f5L3+Zsu9S3v8xv5cue62hDeM7myx62K5rdKLSN1eGwwcgN3yIsoOwkuqwi28Dq3vTuw4RoNJ+9aK490F7brirU8gJJbeRnDPQM4yllWZqeUvhcoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957135; c=relaxed/simple;
	bh=ht0Urj349w7jYSsBVGF9XyGIycCvC48K4QvL0AyghWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQwMyMJHq/Eaa1NTpxnFSIDnpMUGDDYoG2NIqXsy+Pm4WQirHGaG/zY2GRjaMeFRmscJAGZ0R6J2Hla5Hkv5iNGJkyG2QLxIsAelgNBEvLLBmHKNviE7yIaYVdpis7UqCviAHdv22+TdGsl2GWglsxUSfN1p2g6saQesnn2GnNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rCMvOdbr; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rCMvOdbr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkNhd1UfGSdaB75WA3nenRLrrqyiiG/ope58ubf/8TmJbcd25RNDFfFfn0UgoM1bxABzZmNopXzTUHmiZCzCWovgSS102O7mGaHqKbBH7LF5cxu0VaAPGyMPsvpMsPQQ5Wb1D8YRxHXBAOY22M4kNlkOx+SPv0LJiGdMK4r8Rseh82pToi1rvctoFw2Byuaa5mbDEd4mzpgnGF3Old7KQDi3XDTA6oxA6t5V/GNI9XWVTRosiDNE608ITgfjKLHDK67Uwdcgp/DrJLKHVDa2FzxSbCGvEplW+2I7NrXL7YC8ywZ5KoXvNW/PHm8lEY+CBSP7yWRGKigGeTI6+iKkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8O2r3aZrNObPpykVcyVYSuen1iMfLW3OgtWAAWsTk8=;
 b=TpI1CBB/FBKhcIPp2DV1Pde3DYuYVGzUIJg5SZA97LtuqV+hoYew4GPombHy7jdUnKOkSpBKlZuwg+R5ANMhcn4PtLNZHO9MxwVt1qZVUUBC8RlGH8E3efvNhuW198PLPYWJUnYfcC2iS/6JN4udckkFb//Cqg0vtSwD77vREdfMj0fgbx+b8GMQ6haQA2U7NVE2w6KNHtTN25NO6++LWvi2SBU/V5j7yEouW2YzlDuv7Nfm33gSRwRkkUqLGWpK+0rMQRJ363SiZBI+FW5cSdndvmKtSFZJfVIBb3r/J0XzTgPxNQGzlH6zr1jA0fu3v0qqbM/8SgMPzl8qKv8r3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8O2r3aZrNObPpykVcyVYSuen1iMfLW3OgtWAAWsTk8=;
 b=rCMvOdbrqZOfEJa5EcNJIivRF2AZcPkUH0PJ15V4zDFW/XG3MxKaBqN/mp4kPmwlo8e3X+ZhG+fAdID9PK9UaOMFMS7IHRFJzamK4n7iSg1sjq0/zOvrHfqmtyOCWqTqkqUt5EZYbP3O3m5PAx7tPI+9qIEHYYy8TRS0lj9xaHL4GghikQ7kflnKyAVRrV0c5iZORfmOg4TCEJi0tEinufqnpWzpp5kJQdLP9gx46qePlgsQKdVfamntRXgxDJ8XC5V3KQoByK68cuYFxZXgseEVipFMbB6RLMwkUHce9ZzgdmPKBfHEm5/7M9TTLTwsqVW1PjhooGPEO7AkAT3cZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:32:08 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:32:08 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: linux-cxl@vger.kernel.org,
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
Subject: [PATCH v6 4/9] PCI/CXL: Add sibling function coordination for reset
Date: Thu, 28 May 2026 08:31:49 +0000
Message-ID: <20260528083154.137979-5-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528083154.137979-1-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d17e24-29b0-49a5-8df3-08debc939af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|11063799006|5023799004|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	HGMbX1O68RwRaMEiQJIkMzUw9Y+UQxtuvyqa0LiAtbXKjI6YnsuYgWIDXv1mMMpZhaFREWChPcIJg9BvBdR2A85MJEQfUfri7JZ4QkJyjv48ZhRgvP7oEBkQVc6DlUb3F95oulTak7ryMMR96nDcGCIZszJKbmTFI1I728/6e8WiKtAkGeGBZ93C7IJ5Es3N31FLw29Dl/w+Dahss1vrH+GpGIHrgLq940kqRQFr5zAoxYYUBEWVXsJUJYYeHissl1z4d+TwYvr++1fMNBeETypXweWaNliyDKhtNFlQ4//6bvbiEmnJgFljTKnKPa//Idk8dGS0etcbpGWm0H+2Ph4rSh3R4X0+6y5Y1CY8z6sRX6+iaPe2RMekAsOJ6KOndr8ZAO2Egj6tZh6IwZMFl62FTIcY+a6w2ezutqpR9X7Z8WSyMHcMKi0NigU/kDzO0VY+hoq+fz7DKCM7B9mMkFQu9u6pR8b2MKk7vwYPWBBIp06ToZuf4Ve3pbvrhDyPWczUbRaTtZfwhVI1YkCcR7AX2OQ+um+GaE+Tu5hFT0QKpvbVelbl/+6r7GXXL6iRPW33ox6mqAPaZlLPEKbnPIEh/73qfGS8fEQpvUY42Sg3azltsy6bCCzik1rAJtq2yvUxnGLZ6XE/lLLHQNWWb5FIbIcX++yrQXK+zgwn0GxhAMTGVeqklM2LmznipSch
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?okEHK5yQvoY6Qs52g4BcMa10R5IY8KHfsHZRqG+HynzE5YioGP08jnt29v04?=
 =?us-ascii?Q?gvSk8vhjVBk1pMHwr/EnuV/fDaO7g7wsshKd0HidiFDXacV6LQXG1J+/hjxT?=
 =?us-ascii?Q?yGbef03A7nSiZhphq3KFw//Qbcv20DKEoE9N/cAsGXr4E4WWm1BRUnhRHKF+?=
 =?us-ascii?Q?46ngynDksFCWLNa/vcfzRnfVulypjFJcqmjXfM1QWsqdmiaYjTcNjdGwDN5L?=
 =?us-ascii?Q?UACyymfMWQi9cEz6/Q/hOTj2bAXAUxaVBBw2+1zXW6zYtz0SbacGKnBkvK7F?=
 =?us-ascii?Q?QrN9VK6gJQNOhhD2tVOROgnBeFeWweGuJNnNsFYGMiyBcE6RDOHsDEiJEo+X?=
 =?us-ascii?Q?ZsP0jXh/jFA+/bdsCBQVH0wdVJkggdsGZWnhYA6xFNEz1NCOmpALf91IGsnr?=
 =?us-ascii?Q?q4yyyqs0vg+7WjhcoVDXaNaXtzH7RkIF3/0Es140fNA9oumg6U1W4M0K+O0Z?=
 =?us-ascii?Q?p7FodSC0yW7T5Aodsv987Kc5/6K/+BsTSBEI1rx5dryShO28c33YCQAj2BGg?=
 =?us-ascii?Q?mGQguuBBfWh59U3nPpYtsCzdWOB2L3RcQqRYSgti2CEiRuk1PlMtoh3hFyoI?=
 =?us-ascii?Q?rLJYAn8u08FX88rAeRCF/plBxBZWEmxVwwHr0B+dA1K7P3UreV/FDUcsR/9h?=
 =?us-ascii?Q?NlW2sKAKMBkUKXk4jEPvMmptiL/vLdnwNYW7RzTwJySlLuz+k0ebsoq8QRNY?=
 =?us-ascii?Q?c1fjVelfKPhyGbhSEuvhuRCZvl+jNDW9YDtqkzS4DDqWdAnOIL4COF7SwR95?=
 =?us-ascii?Q?7Tcm2xZRDXKzafMCLiBaM8e5WovKPQFLn+n/p2Zfk+WJ1DjW4nire5XqJI0I?=
 =?us-ascii?Q?wYBFStWnyybZfJic581Sj+TNtVuPYePrNmGgcbaHVV9zyB5G+owaAIS0G848?=
 =?us-ascii?Q?1SgV1l/+Gm81jnonwUB1PjsntDqJI+95ny2+m1p2q/2nOikppe+6v7LApH5/?=
 =?us-ascii?Q?jgPz3MD6gZwzDPXs+d+n6jTWXfYquWfHJkf3Z7XsTTW+NkolSa8pxVf44RhL?=
 =?us-ascii?Q?MD9axZ9VyvDpkuAvAysg0mZk/M/Yu7vi5zYS2zVTJjmDt7XevCyxpGnu4pWM?=
 =?us-ascii?Q?YPiUW6U2ib7qou3P5j++um3O71iis+atwI+8k+b9/rt/ycK4o8cmmHyxV03W?=
 =?us-ascii?Q?ezGlKADN8BcvsRV4NlLXdWbUiP202wK5Km0s6vK+e8V9VdJOFEkHJBCFT0vn?=
 =?us-ascii?Q?SVfJ91eStgv+FULuhajNFtNauYmUluHy88fUi+KHSJaxCC5oY7NCj3qZAUhC?=
 =?us-ascii?Q?6lN+k11IqdxReLcnjAsf+23SPyVje7/q7nOD66xbPaThaOvbS/nvhBKK5mAw?=
 =?us-ascii?Q?1I670BGs4io73Wf8lXHFCISRJC1MbPjcLcujyrfSAVQbMX4UnfexIklTgIqN?=
 =?us-ascii?Q?OvJNtPW9N7rs4vgWB8rDRCIJIGmNP5/TvFMGaMXv8/JqQWrgR3yQBdg1rxlF?=
 =?us-ascii?Q?s3IltS5E/m/H/gbfRkmxf/qRkLeoOYOmYVYaX+e82u3C57lW3xWlikOLEuBd?=
 =?us-ascii?Q?TYgup89FwVztA2qqje3d2BCXnDf7FiN6zpEDbwIVaG7IBXgx1gSHCTMkrK3f?=
 =?us-ascii?Q?TDqHU2Upx0CRUwDFdJEL6xZchPALBujfk6VUJTqoRkuGTNfDSYh/K6UgCVPV?=
 =?us-ascii?Q?H9Vyzkzk6gNCpN9BTSp3URioLP+lZIzDy8WATD8mCMdfTUABmRfKWHMBT97W?=
 =?us-ascii?Q?wX7dqTyAxHoJcLihU+yH4B22S5QyGWZZorXUdnRdMSTEUL2T7fBnTpVPj8uX?=
 =?us-ascii?Q?PPlKx8hTGQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d17e24-29b0-49a5-8df3-08debc939af8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:32:08.0639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n75k4bI4Y5LjdR+MEj8JS6Up2FCL4UdQ+9cb6kaU+A50dnws/597yeAVjrodqufc6CvMn1C8bT/zIN4qC3QC4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

Add helpers to collect CXL sibling PCI functions affected by a CXL reset
and prepare them for reset by saving and disabling them. Restore those
siblings and drop their references when reset coordination completes.

Use the Non-CXL Function Map DVSEC to exclude non-CXL functions, and
filter remaining siblings to functions that advertise CXL.cache or
CXL.mem capability.

Use pci_dev_trylock() for sibling locking and unwind on contention or
allocation failure, so competing reset paths fail with an errno.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/pci.c        | 207 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |   2 +
 2 files changed, 209 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 318744695f62..01effbb4e7cd 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
 #include <linux/units.h>
+#include <linux/bitmap.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/iommu.h>
 #include <linux/memregion.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
@@ -15,6 +17,10 @@
 #include "core.h"
 #include "trace.h"
 
+#define CXL_RESET_MAX_FUNCTIONS		256
+#define CXL_RESET_FUNCTION_MAP_REGS	(CXL_RESET_MAX_FUNCTIONS / 32)
+#define CXL_RESET_SIBLINGS_INIT		8
+
 /**
  * DOC: cxl core pci
  *
@@ -1096,3 +1102,204 @@ cxl_reset_flush_cpu_caches(struct cxl_reset_region_context *ctx)
 
 	return 0;
 }
+
+struct cxl_reset_context {
+	struct pci_dev *target;
+	struct pci_dev **siblings;
+	int nr_siblings;
+	int sibling_capacity;
+	int nr_siblings_prepared;
+};
+
+struct cxl_reset_walk_ctx {
+	struct cxl_reset_context *ctx;
+	unsigned long *non_cxl_func_map;
+	int rc;
+};
+
+static void
+cxl_reset_read_non_cxl_func_map(struct pci_dev *pdev,
+				unsigned long *non_cxl_func_map)
+{
+	u32 map[CXL_RESET_FUNCTION_MAP_REGS] = {};
+	u16 dvsec;
+	int rc, i;
+
+	bitmap_zero(non_cxl_func_map, CXL_RESET_MAX_FUNCTIONS);
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_FUNCTION_MAP);
+	if (!dvsec)
+		return;
+
+	for (i = 0; i < CXL_RESET_FUNCTION_MAP_REGS; i++) {
+		rc = pci_read_config_dword(pdev,
+					   dvsec + PCI_DVSEC_CXL_FUNCTION_MAP_REG +
+					   i * sizeof(map[i]), &map[i]);
+		if (rc) {
+			pci_warn(pdev,
+				 "failed to read CXL Function Map; treating all siblings as CXL: %d\n",
+				 rc);
+			bitmap_zero(non_cxl_func_map, CXL_RESET_MAX_FUNCTIONS);
+			return;
+		}
+	}
+
+	bitmap_from_arr32(non_cxl_func_map, map, CXL_RESET_MAX_FUNCTIONS);
+}
+
+static bool cxl_reset_is_cxl_sibling(struct pci_dev *pdev,
+				     struct pci_dev *sibling,
+				     unsigned long *non_cxl_func_map)
+{
+	if (sibling == pdev || sibling->bus != pdev->bus)
+		return false;
+
+	if (pci_ari_enabled(pdev->bus))
+		return !test_bit(sibling->devfn, non_cxl_func_map);
+
+	if (PCI_SLOT(sibling->devfn) != PCI_SLOT(pdev->devfn))
+		return false;
+
+	return !test_bit(PCI_FUNC(sibling->devfn) * 32 +
+			 PCI_SLOT(sibling->devfn), non_cxl_func_map);
+}
+
+static bool cxl_reset_has_cache_or_mem(struct pci_dev *pdev)
+{
+	u16 dvsec, cap;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return false;
+
+	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
+		return false;
+
+	return cap & (PCI_DVSEC_CXL_CACHE_CAPABLE | PCI_DVSEC_CXL_MEM_CAPABLE);
+}
+
+static int cxl_reset_add_sibling(struct cxl_reset_context *ctx,
+				 struct pci_dev *sibling)
+{
+	struct pci_dev **siblings;
+	int capacity;
+
+	if (ctx->nr_siblings < ctx->sibling_capacity)
+		goto add;
+
+	capacity = ctx->sibling_capacity ? ctx->sibling_capacity * 2 :
+		   CXL_RESET_SIBLINGS_INIT;
+	siblings = krealloc(ctx->siblings, capacity * sizeof(*siblings),
+			    GFP_KERNEL);
+	if (!siblings)
+		return -ENOMEM;
+
+	ctx->siblings = siblings;
+	ctx->sibling_capacity = capacity;
+
+add:
+	pci_dev_get(sibling);
+	ctx->siblings[ctx->nr_siblings++] = sibling;
+	return 0;
+}
+
+static int cxl_reset_collect_sibling(struct pci_dev *sibling, void *data)
+{
+	struct cxl_reset_walk_ctx *wctx = data;
+	struct cxl_reset_context *ctx = wctx->ctx;
+	struct pci_dev *pdev = ctx->target;
+
+	if (!cxl_reset_is_cxl_sibling(pdev, sibling, wctx->non_cxl_func_map))
+		return 0;
+
+	if (!cxl_reset_has_cache_or_mem(sibling))
+		return 0;
+
+	wctx->rc = cxl_reset_add_sibling(ctx, sibling);
+	return wctx->rc;
+}
+
+static int cxl_reset_collect_siblings(struct cxl_reset_context *ctx)
+{
+	DECLARE_BITMAP(non_cxl_func_map, CXL_RESET_MAX_FUNCTIONS);
+	struct cxl_reset_walk_ctx wctx = {
+		.ctx = ctx,
+		.non_cxl_func_map = non_cxl_func_map,
+	};
+
+	cxl_reset_read_non_cxl_func_map(ctx->target, non_cxl_func_map);
+	pci_walk_bus(ctx->target->bus, cxl_reset_collect_sibling, &wctx);
+	return wctx.rc;
+}
+
+static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
+{
+	int i;
+
+	for (i = ctx->nr_siblings_prepared - 1; i >= 0; i--) {
+		struct pci_dev *sibling = ctx->siblings[i];
+
+		pci_dev_reset_iommu_done(sibling);
+		pci_dev_restore(sibling);
+		pci_dev_unlock(sibling);
+	}
+
+	for (i = 0; i < ctx->nr_siblings; i++)
+		pci_dev_put(ctx->siblings[i]);
+
+	kfree(ctx->siblings);
+	ctx->siblings = NULL;
+	ctx->nr_siblings = 0;
+	ctx->sibling_capacity = 0;
+	ctx->nr_siblings_prepared = 0;
+}
+
+static int __maybe_unused
+cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
+{
+	int rc, i;
+
+	ctx->siblings = NULL;
+	ctx->nr_siblings = 0;
+	ctx->sibling_capacity = 0;
+	ctx->nr_siblings_prepared = 0;
+
+	rc = cxl_reset_collect_siblings(ctx);
+	if (rc)
+		goto err;
+
+	for (i = 0; i < ctx->nr_siblings; i++) {
+		struct pci_dev *sibling = ctx->siblings[i];
+
+		if (!pci_dev_trylock(sibling)) {
+			rc = -EAGAIN;
+			goto err;
+		}
+
+		pci_dev_save_and_disable(sibling);
+		rc = pci_dev_reset_iommu_prepare(sibling);
+		if (rc) {
+			pci_err(sibling,
+				"failed to block IOMMU for CXL reset: %d\n",
+				rc);
+			/*
+			 * Undo save_and_disable() for this sibling. IOMMU
+			 * prepare failed, so this sibling is not counted in
+			 * nr_siblings_prepared and must not get iommu_done().
+			 */
+			pci_dev_restore(sibling);
+			pci_dev_unlock(sibling);
+			goto err;
+		}
+
+		ctx->nr_siblings_prepared++;
+	}
+
+	return 0;
+
+err:
+	cxl_pci_functions_reset_done(ctx);
+	return rc;
+}
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350..fa1fcd26af01 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1349,6 +1349,7 @@
 /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
 #define PCI_DVSEC_CXL_DEVICE				0
 #define  PCI_DVSEC_CXL_CAP				0xA
+#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
 #define  PCI_DVSEC_CXL_CTRL				0xC
@@ -1366,6 +1367,7 @@
 
 /* CXL r4.0, 8.1.4: Non-CXL Function Map DVSEC */
 #define PCI_DVSEC_CXL_FUNCTION_MAP			2
+#define  PCI_DVSEC_CXL_FUNCTION_MAP_REG			0x0C
 
 /* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
 #define PCI_DVSEC_CXL_PORT				3
-- 
2.43.0

