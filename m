Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E952759A;
	Tue, 22 Sep 2026 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066389; cv=fail; b=XoJ1ZU+0XDt9Y9djuz7PzHImR/CRzerpU5i/pZ0Mmk4PTuyqC3kj8UX+gPAJT5SlgojKm8bnawVBUR/GA3Gyjm+aL6l+ifGjcrFalcLStcte8oH95WIw9+mLzgNiyYNEo02t2+8tgvncd3Y3qExX+wkSpcMOAsOWr6Ou68Qi5WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066389; c=relaxed/simple;
	bh=EfqTyiOxIBTvsbU+e8yoxkKaKFRyRPf0u0jdsSJDO+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBg9dRwv8EP9ZaAyJWTlHlqQObsIIdTjMV0vuN2WGtM97haqxiNUqhMdyOzHlp1aA8rjnQhgpqUiaBPS2p8ra/k3jG/3Rt+hePOQkxltOjTHEREaNN/OogEsAHgdS2Kt2Pm3VI5k2pT2uyfEhjZdejGIEuoec0sJ+EGQGxDrwCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uCiflQXx; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uCiflQXx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4JAIZOrLqVyLywxvT3vrzZqXO61/VkUa8byc0DmSfOmWTB2x6HdbzFd1vhSp9NUo6hEnc8YKJJ5X+YdTxE9d+qrtMru3pdsivRMv4D7zYM3QPg4f4Ym/F5idNMCCF+fcmTtD1u3MttXlRZQ/kluYzgSpNr0KL6+wPVBbK5fUTve5y02IB6fJXF9MjdoeOZIPdq8iOkrHPEE/j5GmXORNa1WPXQAJupRWxtlRgpKWuLufvufKJrkbnBc7hpqCEHANo3MaWjl8Qzn6gExxCvnv/7hym54ZCw+zAxLYyLnay5giCFcD4khYWYCfaFG4sa+bYDnSMcPlOSIJwTPFDFgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/J9TksaBUz4wI/2nVLOvaPfZ7lQN/M/hs25ZuX9LlU=;
 b=H0QFxFckgy0AX2HFkYzdHCWPYkRCJGaOeCk/V0JRSxHozdQw3+3rEoO2fYbC8NGBgckO2GAjeReDv77p5k1dsZOyuXuvapZl+OIU4El+Eocbz63TO2hE7L7Wwhea7jZQ1M9+DoWr3QYqBoJYUJUXicSszCYfgJphMCgbgLEkF2+eIBF9uEDJq/j2H1RWwh4yul8LMtv3Cd3P2kNBRRoE6goOLgCNEwCyuPysbFGrEdaToBmwROqX30+fA65isSXspDCdj17shDNo4aVZLPONJOMf8cmQKmQCbcgldRRmEYffqEKmaPCfKbGTyy1ZwD7o6z7UDsDqqQACr7yePs+yLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/J9TksaBUz4wI/2nVLOvaPfZ7lQN/M/hs25ZuX9LlU=;
 b=uCiflQXxddf4nX/4XRFxfWG/mohZw5QlPkoT2Qk0mRUfYXzSw+Q1hhGclr3Lf/Mo/eetosy+MOJI2iDh3UPyK0I+4ZcuuqolVVrVHeTr6YzgqHq01V7Ol0ULAnKWXzRBb6hnJKjdE7daIjK+mnq88xUfMvwNpPykZglVN66r8zrl6V2TN3aNYiqibGttOL6okV7V1pVqqkQLYQ7wUrysMXaunUFMW8bZVVyOzEMMC7+8w2cQ2jisJGLlXAXsIGRKC4cMx1t+b0hDKSfKseSjrUSOG2kptwB1Jl7ll2TSNatOwZ9gBySGgwdLq5EbfndddX/Cbzy2z7t5kWeyKWRoOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:43 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:43 +0000
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
Subject: [PATCH v13 06/15] cxl: Make HDM reset helpers available to built-in PCI code
Date: Tue, 22 Sep 2026 08:39:15 +0000
Message-ID: <20260922083924.2451158-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:303:b5::24) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ac2b63-b77b-4def-1684-08df18850c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OQYq7Sv6aPbkBeQ9HzQP9/By2t+ih7oH3SbVFntn1NXkRMOajQHESbFXqhQ4UH91d5Tb2xc7k2E4qE/YOwGVX89K2avoFJG/Y0q/5LF9oIJFtmMM2RNXzNs7+9J7L6g9C2aIeXeY2Cotbe5T6zVndopN8Ge28pbQ5BfAT4n3If4K/gnnI43wfvtFzbj1Q3HweF4TPUzzQD0XM1e0n9wsJM/pDc9dzefZ3zQmHYaIz1ORs2sj9eedef+CCldXWEX6ueJKCImzb88912s/UbKDEehQL8zPU1LCwjwSqfWOPF30tXu1FmFJFjA00CIGeZkFlFY4l1TX70kX2blpU2hhpDkYsEdkn0k2w42ES5uTV+diyRfs8bZH8ZZirNN+9E2QLEr1xDzxtinDTJX9zaROr2gyO7bzn+PBAxXIY8Pp2+KQJSVGnshq/nj0tuFGtAKGYxZH7YUl84jnq1y0FpnWwPNu8veiAHOoNhWi+igJX8Eujew6T3prWXMHK/Arl1uODHdrEslnq19pxAcjRa0gWuz/FVGvPj1wkQW7ctcVPPQeIcraWCEKBv8kpgu07GkzMBzAoFHGc1GRNUu2o1dIBCz12V5SKs+FQ3qd1mpdJJGhS6KkXI1nnMawipj0626SbUBqfSGPaztK4LbjsrvDHv10xEpSo+rX0hQXKupFv5CDsHljv9bKuG/31OKQlNS/4F22SojCM0gJsow4XdMIqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7r1WBJXw5dDZ1pSK05bm2n/8R4pp/h8111PP9ZLRV6mqVzCs5Md16QbzHO9W?=
 =?us-ascii?Q?pBTIlO0WhAS16hnXsfcZVLwKLwQUN7caOJB5G2XbFfe8iO9GGmjk0XxR1kks?=
 =?us-ascii?Q?6D2bRou7bXurnpwwa3QBqxs7UXLmft72NQKinYnIqp2YUSijTokqpgUD1GxV?=
 =?us-ascii?Q?KC4El1nR6O1y8kbupY+t15mHVoI2UQIJx/vXpcviiL0AV7CDKLJR48F8WW2g?=
 =?us-ascii?Q?maPV+Ft3maKUdl2WunKdTOa+5MkMzFp2bZ1vkVafiDvisw1awmz4PfR3wwWa?=
 =?us-ascii?Q?+DeWhvOheu+OmuHU2HW5DvO1o0YuBrzs+Ms8oHg3IEdDs0mswqK790FbyhA0?=
 =?us-ascii?Q?gsxdzhPgIje+2wCSY6r8g+76d5BunZcqNoCHDsMd1+hrhmluy/Y5U5jpTGs/?=
 =?us-ascii?Q?Kz9akyCFnkVnxzW1N9phcsNw6EbtMxUbUp6yKcr4S1iGKpT8LxPV/SPi5nAi?=
 =?us-ascii?Q?QowKYZwkCoiCulQM2WsPRnt/xXM7GSNdr0O3ssDFaGfNU+E1vnw1upx73O4u?=
 =?us-ascii?Q?FGL/WK24bZwfHr6GD+IeR8qdMEDKBR5Y2VZO4P224zHedBSPEHNaiOGIHSID?=
 =?us-ascii?Q?h1Y+lMXunroRgA6DruxiykG8LEnRniL/nkDkJ1JU3jKwHIKWUNvnr3hnW2Ii?=
 =?us-ascii?Q?0YrwdNxQzHoGUegNg8IIVC4RbnFrg5AMao4X1SVsS6HdN9NNAW9/I5E6+hFR?=
 =?us-ascii?Q?3C2d+DCDPnyOI0T5AZYfqpt3dIOLzt1GDbXYErOQaRLxD6WVwATcB0iet6HI?=
 =?us-ascii?Q?/gSbfVOrltjEhblsT/FZgbRTVJYR34rhWG6YvQo1W+cv3siAuGBlcQ+OGcJY?=
 =?us-ascii?Q?EC+XTfRPXIcQjlfLQGdzbemFxT+1x434dyz3VosxqIrSQsv6x33983uHXjcj?=
 =?us-ascii?Q?QlIPDffkG2q2+UzIdNwwWYbstPnYdxv7Z/7V1483IJ4SrPZWBt2tx7Asa28I?=
 =?us-ascii?Q?wX98zHBIpRnM5R4m6gdyyLvG53QsTTiqFX1toIOYsQU1npsfX+4iHX8OZWFb?=
 =?us-ascii?Q?1+ZaCxrX6LvSMdmXFhOFccb6p2DocdZwAj3bBuzxJYW+gOzWE2Uvc0R/h6f9?=
 =?us-ascii?Q?zttw5XsJmeY1OZ7dfOH7D5pWBIMjJ2X/WhMhdPjWMeALC5i80OZK+ruaEQc5?=
 =?us-ascii?Q?UaHlGp6rQEuElj9Uv7XI8gnVY2sgTyHvTwYlzjXppGfHyFbaBLNTrVzfOceo?=
 =?us-ascii?Q?vxBqyuX8YManZ7Dh6Omf+nmF+iRTPMigtO1GgeP/UrrzDrWKnsn+X7BUtifX?=
 =?us-ascii?Q?XXpnoGPrUn3/gxggqg5JHshtAmgFbaKk1GZxPqvaL9I2RtLzBLMyNOYpewmP?=
 =?us-ascii?Q?fpvDv3xW39hR2gSTmb298/unUS3YzOMuxGB+5Jjy1III/5rxMG1lEQ00TeBN?=
 =?us-ascii?Q?Jk3E21LFNLWhXkoBEjKN1zGfE99fd1J/prxeibuSanfyP4Eovt36fA45rR1d?=
 =?us-ascii?Q?YueUxh91sLEbkJmQwPZcqwEjMN5QBVBlqM5JjORLQ6jHbWsl4gEQlZ8wJOhM?=
 =?us-ascii?Q?lf7wrJWXu3hEHL9DhTLQLRygW0nYG8u0RAP9TMFJ1JdrYTD0Wha1OVoJolcZ?=
 =?us-ascii?Q?WMzXRM/d8jlcaUsANIuSz+SVh1o/PautYYtH82zk7y3JDaWVJxrikOgso3GV?=
 =?us-ascii?Q?7/pC2QqECEcmyla16qouUycFjYsRUQkCxRZlQBWgzys+yo0dDKovAKxdGIlq?=
 =?us-ascii?Q?0SoD4BnwC6ZLl+2pNgy1tYRPkGrONQd/DW0znbtxJML1emrh//p51fO06rBK?=
 =?us-ascii?Q?YElU1fjVyg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ac2b63-b77b-4def-1684-08df18850c87
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:43.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY3/dMdFTSKsMoSDXuuj5TY5AYf4ddXXtZrjYFcKF2mlqdedFXfgO/epNw0er7x/hCzMFCkZOjDAiMu7EFk6RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

PCI can be built in while CXL_BUS is modular, so PCI reset code cannot
depend on helpers provided by the cxl_core module.

Build the HDM resource helpers under CONFIG_CXL_RESET and restrict their
exports to cxl_core.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/Kconfig         | 4 ++++
 drivers/cxl/core/Makefile   | 2 +-
 drivers/cxl/core/resource.c | 4 ++++
 tools/testing/cxl/Kbuild    | 1 -
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd..0cd704670735 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -6,6 +6,7 @@ menuconfig CXL_BUS
 	select FW_UPLOAD
 	select PCI_DOE
 	select FIRMWARE_TABLE
+	select CXL_RESET
 	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
 	select FWCTL if CXL_FEATURES
 	help
@@ -244,3 +245,6 @@ config CXL_ATL
 	depends on ACPI_PRMT && AMD_NB
 
 endif
+
+config CXL_RESET
+	bool
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 57995777af0d..30470799e059 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
+obj-$(CONFIG_CXL_RESET) += resource.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
 CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
 
 cxl_core-y := port.o
-cxl_core-y += resource.o
 cxl_core-y += pmem.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index ea0d855e5549..1b4742622054 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -3,6 +3,7 @@
 #include <linux/delay.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 
 #include "cxl.h"
@@ -12,6 +13,7 @@ struct cxl_rwsem cxl_rwsem = {
 	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
 	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
 };
+EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
 
 static void cxld_set_interleave(struct cxl_decoder_config *config, u32 *ctrl)
 {
@@ -100,8 +102,10 @@ void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
 	lockdep_assert_held(&cxl_rwsem.dpa);
 	setup_hw_decoder(hdm, settings);
 }
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start, "cxl_core");
 
 int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)
 {
 	return cxld_await_commit(hdm, settings->config.id);
 }
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6c09932587ce..2be1df80fcc9 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -60,7 +60,6 @@ cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
-cxl_core-y += $(CXL_CORE_SRC)/resource.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
-- 
2.43.0

