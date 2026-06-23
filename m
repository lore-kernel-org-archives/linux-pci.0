Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126C331A66;
	Tue, 23 Jun 2026 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185107; cv=fail; b=aTitClFXocc6dAZ+jVvPyvC2B0WSXXlDHtGPhl4qkliULvwV1bxABo4mldG8DgFqYbqUwexEcADG/fP8aoGRZXHHqR8edWQXrK++elJ1xFrs/w5S4LABbRqjMswLv9Nn+0V8+Dn4m4wYDAA1rDFBCd8DfMLCcI8TPSZle0pktuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185107; c=relaxed/simple;
	bh=oHO/tPjPvZuDHnvj7emZr3Ikx7awAoxKonklmB/p5sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CvAbRlx2Eq8mcqjhfokOBEaCDZFHBIHt9+9os2xMIOi10opaWiMREWJaP5yHjMD7LQ7nix129jHrddw0qpuUFlmd72rGr8O06U+tONiojVzP5YZZuD7p/+HjSEV77MwgDbcIImmTGwXipJzCfnd9BrpFYQipV0Om6TOBXFGKFlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CODOSC75; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CODOSC75"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cbc8usbHcky5ADPE3bOcKSmJhs7nPx2MwOnoa04W2Gr36F6qJsXoesnYnn0uCtjTV7cDE9iusqQLbXnssKKJ5zBaRcs468r6e8xlglgZe17SFsgM922z5vBJvhuNz2YUZoqR+9XpA/dj/x0M59waZuzhuVtUkhnhtud3IJVikLxEhsz4v0T5Bc4cZ5R3V5WW0iD4U4upnjB2WfWpewdghZcRdaIIvkG+hLDYuBK6l9e3gT04h4B0QbglTKFMTVQTt4yXQVYinuuxzwbaf2iPGfLZwOsmX4oWTAHJyCXo85QVpoxpBVpiXj8pL4H2bKLxJp7rRILo1JzQikD5zqPnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+ExYgfHAyNrI+vLW4y2rH/qjOTW3oueqUA307Qx8Qs=;
 b=F9Cc/ueTRV2P4ESy9yklwa+88HMJzNjJVpkdU6x4VdnYIpUn57wjCxLSmIqxZtwahZgV5C4DlAj6iXKKRnjk6Wc5rQFUmnTTffv2st607v6zp6QXUhrHZytDJ8ngipvlrLa8Eo93k7pcFT+75HR59sEHM3heozkxynyyNV4DueQBBT8o5NTPvi1xhk6ZcELkY/N+qIQs49aV0Msv7KWJ8KOI/i2OwGIwfEY70NKClr1E03g6vJhDo5sGRYIzNc2m5rCH8n2vt9Dmn+w8s8NHisdJyyKUltMigUml0GrNpoD6hkiaV0NXPvTW4Ga7aAsUPgDqop/SoKjK2Ic9tOW3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+ExYgfHAyNrI+vLW4y2rH/qjOTW3oueqUA307Qx8Qs=;
 b=CODOSC75GUnFUfeOzqzgP8+Yv0lmgpwsMuhAegFZ4CQSl7R5I8MXvay7xwff3lJiX64r+xfAM/+1L6TOuF7GDtwfHZC3vXrJVV5B2TAREZC8fKA7e4QkRbkao0IzOwCR+p7GKUlvRmJCsBfZeB/v7zgBu712CwMLPnr3jNcBlB/6W0gWPZoDwM7wcCB58joN7wr/yxub4YNNqF9DpNYkDM+jEKH0K6kySf4xS4YqWECpPJuXki7aPGah6DhY1gPkNuber0f+KeSBN79FqWuq5kk6Hq6P5OgnkoMAekVoH4Zy/3tADwSlxSExKnXXJ8MStoJjgCFMLrFVw8dL51wzFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:24:59 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:24:59 +0000
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
Subject: [PATCH v7 01/11] cxl: Split decoder programming into a reusable helper
Date: Tue, 23 Jun 2026 03:24:43 +0000
Message-ID: <20260623032453.3404772-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623032453.3404772-1-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 20db7f37-1f9e-413d-ba80-08ded0d701a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	grUEe8EVKduSuJNXi+oVGi0Oe9jzF6dGmXTPUhp2/U8sZX4zI2ksBymopwXuSu68ha3fm9M7RO1K9yhS2t6hnzaDRt7tpKTIAE9ipBcbMM9+F/fWOgnAAt91XTgplmRkPS3qgCxsmsB8CbOIZV4MvH1YobsaCgmYjTeca96APg7CeAJkI8mXon0Ut0rYfgl7ItufNYkcd3nDV9ktzhzyfeMh5E2tm/foGd9Da9Tf83QkaKcEFsAHuD1GXYLF5HFvMRXnKvbBK70TazeWTgrj6uUpif3jJQDrWxO6jmgmrYI1fWZ/fKurHs+JeT5PBJUiMoRmGI+s3qe9gFHv4/xXZtDAxA2mclp06kzUGkIJjxFL/Hksn5stXfU52yYi32hW+KKQMr2phyI/+SQDNj0eWx+htZcZSDu9BMRTGs9mhCU6Yqiyp5RpVX3+56iNSX5FXhXIh5m3ZAOmtE3STj4tlXD2glLFWCX4gAun/f+F+XGADMXQMgzvJVerAHah+AKwlpL0q4vvObPlHwKvUMxXJukFQfGi9BiGcmvNBIkLhgyYxFYSHwkwqXaZnpqj1aQuGd3aYihJkNAivAzcbM7BWjDEBhMyHoSkt891aWwujjrqDNdMQItUd6+mM6AZW4r7VrPVFnMK5/vtdBGJ4MGTU3HSJDe89qAzjgXLSlHO71moj/zn1HfMembBtqBIoWXpkEI26osd0EP43pFw7nROkQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qkGHeLZYBgFPSwwipvFKhG/+BdxTE2JwUCUEMSoGKhmADX5dmMLEjWgS/GMd?=
 =?us-ascii?Q?eCArJ1nl0BiLzsBvuZLLLRa6m9HrhrZ9FYM9heCV0Sl2yOuIOKo9vVRCghPO?=
 =?us-ascii?Q?efYv+zXyyikMGlNibBt2WcivlsPEn57UbTLoBamjAWw51nPInGuVXnY835B8?=
 =?us-ascii?Q?MDb5X21cXBAAApfqME33kmjO5t1yJ9Bv3+p0I/fLovNlHxUiqeuqFarCp78I?=
 =?us-ascii?Q?35yXO7zpNDTeYMj3my/OM35JMu2HM2O6TI//P0T8xlEK68BLmplNYtIbEY9B?=
 =?us-ascii?Q?4XutaIQQ6cAt+Vk+ijvMg/fHUhjIsKhIU0sDYft7fXb8y0cRveJSNGj46aXQ?=
 =?us-ascii?Q?VoQmCnWTSqz0ji5mNrz6CLWLuh3mWTw3IOGIecpM0v+klZONotR+4ECIcJjb?=
 =?us-ascii?Q?VGhKJaSi0wmB5ZgbxGz3mDptH1vPBD4nWjbujb7lWmG7gdh4AtgcN61KtjiP?=
 =?us-ascii?Q?PPkfXBWGDrPSrsRnfoUYKPY0dohpHZymxeUhu1u/CsLMY4/NrH78Lj6QLNrq?=
 =?us-ascii?Q?0aJhZ0lLsX3+IWidow/V0hK5RNQAk5izCLf27c5Ny+EqIZDxrhHA6jTWDknM?=
 =?us-ascii?Q?90sWWhkgg7KJEEYhZWjbtD2tu+5HxqBIWPrLH+73stzVk7Qn5cnav72Q22fK?=
 =?us-ascii?Q?8V6cHsNGc3Pf7yM/5UsQjj1MIe6QOG4eh6htXOtZyEgPxHib/HFgJXNfEWdu?=
 =?us-ascii?Q?1tU/03qgxbaG6edYs3odLkj7YsyxpNGXTGzwmp+wUGP7p0ltvbXH4cPdwiZB?=
 =?us-ascii?Q?471NkVBLkNSCO9EWoDS8zZlUF2DaApzG+V8yYgbsLu5e8o2u7TPe4ysyaw7k?=
 =?us-ascii?Q?swioFEN8W3f6a74JvERY75XO3VqUoKybQvliqLqhMLcmejJwqScWkCx3IYHv?=
 =?us-ascii?Q?BxYShYNiEC5bhTMu/SGj5igr/sI1fz1lCcLL4D/nmG1/VzdlCbBN5I24kCHV?=
 =?us-ascii?Q?XbVSCrFyJ6Mbzi59GPmgN7wgp11B7qn++EecL8m0EcS6I7mpy6E4H4AoUxTs?=
 =?us-ascii?Q?HmnD5cvsSO/JMWs52AT4KQoJfi34O6HnssxgsnXnz9h5v1yIMPEkZQrvSZoM?=
 =?us-ascii?Q?b/t3ID0KIHCNkc6k4Fbbh5PgVO9ETO5S4AC4xIE1eXrbCCF73XqA3e7Nsx3j?=
 =?us-ascii?Q?gH+JIMCGLhYHOIvbaKl/Y5bB/FGQ9oz6ktSGamddR2rlgkrxsD9pR3q1NYoI?=
 =?us-ascii?Q?P531fR3aWRSSVGb4gs4hrjcKp3gjQijHEqAQnP+X9TYsla6USN2sUTQO+g3w?=
 =?us-ascii?Q?h9PTEZPFM1Alw/Y3nlXiVW0hxeJVvyDaG9nvf19DZvi+KJa4rAplzz7obflP?=
 =?us-ascii?Q?ftWDOTKatE+/D+ZJO2G6c779DiEE4LXPD/SyTcD5329d6h9VmJArsEzIoF3K?=
 =?us-ascii?Q?0XX1E61nrMFeuCA99vK0JHwOUzUMpoL3BjTZ/M+yZIg+E67nx4//y0bXgNof?=
 =?us-ascii?Q?QESDes6Qas6k7IiHbHLsQCRQbDampdN60I6Zhf7cLxqMSMkVrNAxGrrjrL9I?=
 =?us-ascii?Q?SXgnvALIKmiGWd3Qj+quZWXqC0JyaDsjEa2wcqae59+zJynfUKsT4Jnes+3a?=
 =?us-ascii?Q?op6dSLoy1VP2bIYEI6PD0BwvKNO7fp7MZ6d5arl8ES5qPEESeKXLM4IExKHM?=
 =?us-ascii?Q?eniBoAPVSHr7aQB8yrRcf1UZ+SRHe3f7SMp/d4uLPJMxUoCw8Z/jcsvgw/2g?=
 =?us-ascii?Q?rTxGMV40WINp18Du7GbLInzq1D6baq0e+Vpu5kOv7pTN4Xwv8Mx7+A3Ywdd5?=
 =?us-ascii?Q?bwVDO75GTQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20db7f37-1f9e-413d-ba80-08ded0d701a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:24:59.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ow/LztP6EHXZ5oQVZh2/aY1ydAMEvCxKvlc5epCmWJOfZy7Xk/yTqRYsekoO0p0dZBuXlCTZxcAAWFEa++WbxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

Move common HDM decoder settings to include/cxl/cxl.h and route the
register programming sequence through cxl_commit(). This lets reset code
restore cached HDM state without depending on private cxl_core types while
keeping hdm.c in charge of the existing commit policy checks.

Build the low-level HDM helper under CONFIG_CXL_HDM so it is available even
when cxl_core is modular.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/Kconfig          |   4 ++
 drivers/cxl/core/Makefile    |   1 +
 drivers/cxl/core/hdm.c       | 122 ++++-------------------------------
 drivers/cxl/core/region.c    |   6 +-
 drivers/cxl/core/reset.c     | 118 +++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h            |  43 ------------
 include/cxl/cxl.h            |  55 +++++++++++++++-
 tools/testing/cxl/test/cxl.c |  10 +--
 8 files changed, 197 insertions(+), 162 deletions(-)
 create mode 100644 drivers/cxl/core/reset.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd..87d719ea1e14 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -6,6 +6,7 @@ menuconfig CXL_BUS
 	select FW_UPLOAD
 	select PCI_DOE
 	select FIRMWARE_TABLE
+	select CXL_HDM
 	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
 	select FWCTL if CXL_FEATURES
 	help
@@ -243,4 +244,7 @@ config CXL_ATL
 	depends on CXL_REGION
 	depends on ACPI_PRMT && AMD_NB
 
+config CXL_HDM
+	bool
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..dc075cee0450 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
+obj-$(CONFIG_CXL_HDM) += reset.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..fa978c297546 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -16,11 +16,6 @@
  * for enumerating these registers and capabilities.
  */
 
-struct cxl_rwsem cxl_rwsem = {
-	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
-	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
-};
-
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 {
 	int rc;
@@ -255,11 +250,11 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	lockdep_assert_held_write(&cxl_rwsem.dpa);
 
 	/* save @skip_start, before @res is released */
-	skip_start = res->start - cxled->skip;
+	skip_start = res->start - cxled->cxld.skip;
 	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
-	if (cxled->skip)
-		release_skip(cxlds, skip_start, cxled->skip);
-	cxled->skip = 0;
+	if (cxled->cxld.skip)
+		release_skip(cxlds, skip_start, cxled->cxld.skip);
+	cxled->cxld.skip = 0;
 	cxled->dpa_res = NULL;
 	put_device(&cxled->cxld.dev);
 	port->hdm_end--;
@@ -388,7 +383,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 		return -EBUSY;
 	}
 	cxled->dpa_res = res;
-	cxled->skip = skipped;
+	cxled->cxld.skip = skipped;
 
 	/*
 	 * When allocating new capacity, ->part is already set, when
@@ -679,35 +674,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
-{
-	u16 eig;
-	u8 eiw;
-
-	/*
-	 * Input validation ensures these warns never fire, but otherwise
-	 * suppress unititalized variable usage warnings.
-	 */
-	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
-		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
-		return;
-	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
-		      "invalid interleave_granularity: %d\n",
-		      cxld->interleave_granularity))
-		return;
-
-	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
-	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
-	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
-}
-
-static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
-{
-	u32p_replace_bits(ctrl,
-			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
-			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
-}
-
 static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 {
 	struct cxl_dport **t = &cxlsd->target[0];
@@ -730,73 +696,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
 }
 
-/*
- * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
- * committed or error within 10ms, but just be generous with 20ms to account for
- * clock skew and other marginal behavior
- */
-#define COMMIT_TIMEOUT_MS 20
-static int cxld_await_commit(void __iomem *hdm, int id)
-{
-	u32 ctrl;
-	int i;
-
-	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
-		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
-			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
-			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-			return -EIO;
-		}
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
-			return 0;
-		fsleep(1000);
-	}
-
-	return -ETIMEDOUT;
-}
-
-static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
-{
-	int id = cxld->id;
-	u64 base, size;
-	u32 ctrl;
-
-	/* common decoder settings */
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
-	cxld_set_interleave(cxld, &ctrl);
-	cxld_set_type(cxld, &ctrl);
-	base = cxld->hpa_range.start;
-	size = range_len(&cxld->hpa_range);
-
-	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
-	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
-	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
-
-	if (is_switch_decoder(&cxld->dev)) {
-		struct cxl_switch_decoder *cxlsd =
-			to_cxl_switch_decoder(&cxld->dev);
-		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
-		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
-		u64 targets;
-
-		cxlsd_set_targets(cxlsd, &targets);
-		writel(upper_32_bits(targets), tl_hi);
-		writel(lower_32_bits(targets), tl_lo);
-	} else {
-		struct cxl_endpoint_decoder *cxled =
-			to_cxl_endpoint_decoder(&cxld->dev);
-		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
-		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
-
-		writel(upper_32_bits(cxled->skip), sk_hi);
-		writel(lower_32_bits(cxled->skip), sk_lo);
-	}
-
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-}
-
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
@@ -834,17 +733,20 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		}
 	}
 
-	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
-		setup_hw_decoder(cxld, hdm);
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+
+		cxlsd_set_targets(cxlsd, &cxld->targets);
+	}
 
-	rc = cxld_await_commit(hdm, cxld->id);
+	rc = cxl_commit(&cxld->settings, hdm);
 	if (rc) {
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
 		return rc;
 	}
 	port->commit_end++;
-	cxld->flags |= CXL_DECODER_F_ENABLE;
 
 	return 0;
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f5cd20f48d2b..adaf583ccbab 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2912,9 +2912,9 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	cxlds = cxlmd->cxlds;
 	mode = cxlds->part[cxled->part].mode;
 
-	if (cxled->skip) {
-		offset = cxled->dpa_res->start - cxled->skip;
-		length = cxled->skip;
+	if (cxled->cxld.skip) {
+		offset = cxled->dpa_res->start - cxled->cxld.skip;
+		length = cxled->cxld.skip;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
 		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
 			rc = 0;
diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
new file mode 100644
index 000000000000..14f024098e82
--- /dev/null
+++ b/drivers/cxl/core/reset.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */
+#include <linux/delay.h>
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+
+#include "cxl.h"
+#include "core.h"
+
+struct cxl_rwsem cxl_rwsem = {
+	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
+	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
+};
+EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
+
+static void cxld_set_interleave(struct cxl_decoder_settings *settings, u32 *ctrl)
+{
+	u16 eig;
+	u8 eiw;
+
+	/*
+	 * Input validation ensures these warns never fire, but otherwise
+	 * suppress uninitialized variable usage warnings.
+	 */
+	if (WARN_ONCE(ways_to_eiw(settings->interleave_ways, &eiw),
+		      "invalid interleave_ways: %d\n",
+		      settings->interleave_ways))
+		return;
+	if (WARN_ONCE(granularity_to_eig(settings->interleave_granularity, &eig),
+		      "invalid interleave_granularity: %d\n",
+		      settings->interleave_granularity))
+		return;
+
+	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
+	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
+	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
+}
+
+static void cxld_set_type(struct cxl_decoder_settings *settings, u32 *ctrl)
+{
+	u32p_replace_bits(ctrl,
+			  !!(settings->target_type == CXL_DECODER_HOSTONLYMEM),
+			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+}
+
+/*
+ * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
+ * committed or error within 10ms, but just be generous with 20ms to account for
+ * clock skew and other marginal behavior.
+ */
+#define COMMIT_TIMEOUT_MS 20
+static int cxld_await_commit(void __iomem *hdm, int id)
+{
+	u32 ctrl;
+	int i;
+
+	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
+			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+			return -EIO;
+		}
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void setup_hw_decoder(struct cxl_decoder_settings *settings,
+			     void __iomem *hdm)
+{
+	int id = settings->id;
+	u64 target_or_skip;
+	u64 base, size;
+	u32 ctrl;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	cxld_set_interleave(settings, &ctrl);
+	cxld_set_type(settings, &ctrl);
+	base = settings->hpa_range.start;
+	size = range_len(&settings->hpa_range);
+	target_or_skip = settings->targets;
+
+	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	/* Target-list and endpoint-skip registers alias the same slot. */
+	writel(upper_32_bits(target_or_skip),
+	       hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(lower_32_bits(target_or_skip),
+	       hdm + CXL_HDM_DECODER0_TL_LOW(id));
+
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm)
+{
+	int rc;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		setup_hw_decoder(settings, hdm);
+	}
+
+	rc = cxld_await_commit(hdm, settings->id);
+	if (rc)
+		return rc;
+
+	settings->flags |= CXL_DECODER_F_ENABLE;
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit, "cxl_core");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 21fc89d3aeea..95bab833fc80 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -262,49 +262,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
 #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
 
-enum cxl_decoder_type {
-	CXL_DECODER_DEVMEM = 2,
-	CXL_DECODER_HOSTONLYMEM = 3,
-};
-
-/*
- * Current specification goes up to 8, double that seems a reasonable
- * software max for the foreseeable future
- */
-#define CXL_DECODER_MAX_INTERLEAVE 16
-
 #define CXL_QOS_CLASS_INVALID -1
 
-/**
- * struct cxl_decoder - Common CXL HDM Decoder Attributes
- * @dev: this decoder's device
- * @id: kernel device name id
- * @hpa_range: Host physical address range mapped by this decoder
- * @interleave_ways: number of cxl_dports in this decode
- * @interleave_granularity: data stride per dport
- * @target_type: accelerator vs expander (type2 vs type3) selector
- * @region: currently assigned region for this decoder
- * @flags: memory type capabilities and locking
- * @target_map: cached copy of hardware port-id list, available at init
- *              before all @dport objects have been instantiated. While
- *              dport id is 8bit, CFMWS interleave targets are 32bits.
- * @commit: device/decoder-type specific callback to commit settings to hw
- * @reset: device/decoder-type specific callback to reset hw settings
-*/
-struct cxl_decoder {
-	struct device dev;
-	int id;
-	struct range hpa_range;
-	int interleave_ways;
-	int interleave_granularity;
-	enum cxl_decoder_type target_type;
-	struct cxl_region *region;
-	unsigned long flags;
-	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
-	int (*commit)(struct cxl_decoder *cxld);
-	void (*reset)(struct cxl_decoder *cxld);
-};
-
 /*
  * Track whether this decoder is free for userspace provisioning, reserved for
  * region autodiscovery, whether it is started connecting (awaiting other
@@ -320,7 +279,6 @@ enum cxl_decoder_state {
  * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
  * @cxld: base cxl_decoder_object
  * @dpa_res: actively claimed DPA span of this decoder
- * @skip: offset into @dpa_res where @cxld.hpa_range maps
  * @state: autodiscovery state
  * @part: partition index this decoder maps
  * @pos: interleave position in @cxld.region
@@ -328,7 +286,6 @@ enum cxl_decoder_state {
 struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
 	struct resource *dpa_res;
-	resource_size_t skip;
 	enum cxl_decoder_state state;
 	int part;
 	int pos;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index fa7269154620..93d4eba6947a 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -5,8 +5,10 @@
 #ifndef __CXL_CXL_H__
 #define __CXL_CXL_H__
 
+#include <linux/device.h>
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -23,7 +25,56 @@ enum cxl_devtype {
 	CXL_DEVTYPE_CLASSMEM,
 };
 
-struct device;
+struct cxl_region;
+
+enum cxl_decoder_type {
+	CXL_DECODER_DEVMEM = 2,
+	CXL_DECODER_HOSTONLYMEM = 3,
+};
+
+/*
+ * Current specification goes up to 8, double that seems a reasonable
+ * software max for the foreseeable future
+ */
+#define CXL_DECODER_MAX_INTERLEAVE 16
+
+/**
+ * struct cxl_decoder - Common CXL HDM Decoder Attributes
+ * @dev: this decoder's device
+ * @id: kernel device name id
+ * @hpa_range: Host physical address range mapped by this decoder
+ * @skip: offset into @dpa_res where @cxld.hpa_range maps (endpoint)
+ * @targets: interleave position to dport mapping (switch)
+ * @interleave_ways: number of cxl_dports in this decode
+ * @interleave_granularity: data stride per dport
+ * @target_type: accelerator vs expander (type2 vs type3) selector
+ * @flags: memory type capabilities and locking
+ * @region: currently assigned region for this decoder
+ * @target_map: cached copy of hardware port-id list, available at init
+ *              before all @dport objects have been instantiated. While
+ *              dport id is 8bit, CFMWS interleave targets are 32bits.
+ * @commit: device/decoder-type specific callback to commit settings to hw
+ * @reset: device/decoder-type specific callback to reset hw settings
+ */
+struct cxl_decoder {
+	struct device dev;
+
+	struct_group_tagged(cxl_decoder_settings, settings, int id;
+		struct range hpa_range;
+		union {
+			u64 skip;
+			u64 targets;
+		};
+		int interleave_ways;
+		int interleave_granularity;
+		enum cxl_decoder_type target_type;
+		unsigned long flags;
+	);
+	struct cxl_region *region;
+	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
+	int (*commit)(struct cxl_decoder *cxld);
+	void (*reset)(struct cxl_decoder *cxld);
+};
 
 /*
  * Using struct_group() allows for per register-block-type helper routines,
@@ -70,6 +121,8 @@ struct cxl_regs {
 	);
 };
 
+int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
+
 struct cxl_reg_map {
 	bool valid;
 	int id;
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 4281d34cd0e7..244e8ec28769 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -843,11 +843,11 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
 		dbg_cxld(port, "restore", &td->cxled.cxld);
 		cxld_copy(cxld, &td->cxled.cxld);
 		cxled->state = td->cxled.state;
-		cxled->skip = td->cxled.skip;
+		cxld->skip = td->cxled.cxld.skip;
 		if (range_len(&td->dpa_range)) {
 			rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
 						  range_len(&td->dpa_range),
-						  td->cxled.skip);
+						  td->cxled.cxld.skip);
 			if (rc) {
 				init_disabled_mock_decoder(cxld);
 				return rc;
@@ -885,7 +885,7 @@ static void __cxld_registry_save(struct cxl_test_decoder *td,
 
 		cxld_copy(&td->cxled.cxld, cxld);
 		td->cxled.state = cxled->state;
-		td->cxled.skip = cxled->skip;
+		td->cxled.cxld.skip = cxled->cxld.skip;
 
 		if (!(cxld->flags & CXL_DECODER_F_ENABLE)) {
 			td->dpa_range.start = 0;
@@ -973,7 +973,7 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 			to_cxl_endpoint_decoder(&cxld->dev);
 
 		cxled->state = CXL_DECODER_STATE_MANUAL;
-		cxled->skip = 0;
+		cxled->cxld.skip = 0;
 	}
 	if (decoder_reset_preserve_registry)
 		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
@@ -1024,7 +1024,7 @@ static void init_disabled_mock_decoder(struct cxl_decoder *cxld)
 			to_cxl_endpoint_decoder(&cxld->dev);
 
 		cxled->state = CXL_DECODER_STATE_MANUAL;
-		cxled->skip = 0;
+		cxled->cxld.skip = 0;
 	}
 }
 
-- 
2.43.0

