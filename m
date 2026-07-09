Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26AE38C2DE;
	Thu,  9 Jul 2026 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559017; cv=fail; b=QDbs/Z+u3kQ68QqjJqH+OZFvU4NIxQ7YbMobzf14Cnaigln8+2QS5gNe1iUpRWiTMLX9nqs5lJ2EMYkweuVPSLWtcKhvmRa9F9I1gCBm9ZiRKZtr+aqOXiP4tdEbZlyeOZI8dmG5Uzmey0mFgayj0sLuF6CeW/iqIftP8kbM23o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559017; c=relaxed/simple;
	bh=ReT0ShjMCqSProbQ1uVltfY3l3OQd4IUqjO9JP0AM9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PuqCZSS8DoQoPlxM71pJypoW5aCo45bT+L9OcE1dOELxgIovTod6O3eOTIe0qQBuUY1Si+uHEOuO2fmxRipEUkFw89zwS+SJrYbMdxu32lmgAvyQiatC0k2iCM6Zq+RNQX+LMqFEOIe2bhATnF+jsMytpGVYpHYw7fkoOuiMS38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GOU/HmVT; arc=fail smtp.client-ip=52.101.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GOU/HmVT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9qQzJgjGFlrJ1hMbB4rVmx2Enl7LIobWcWkrPkdwBOEzkMTagS1+Z70PvMRGz8xX7B2c88EZk/hJlsonCJp1/4NaF+AI5cYN/p4PjjZDEI2FaIjcbUObPkpCGjjeaV+iOjSHn64gu/7L5zaCcLyPjicKCle0qkLG0UIXkAI8ewbYTHOIyjrYnXHbRAHtBWMkXBctZaWtGBICUwZx7MLdneXdXbNm3TisvDtUZkA5r8T7DhLqjyeyvsdbHJ+sobCKk9au74zLfoRmHLP3Dc/VRZ2M/RXKHhfg8IOCJiSv2k7NFBSDDZenB60Oohbqs7gCxro5OFPog9aYEFcVNJLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIllfuXtDeLSU9va+0Bk2/M94UT+/DgyBsPmgMZWjrQ=;
 b=itqX0ot7eNUuSooEXwUWyUeR3vhtE7P4VH3LPdME1PJdtL4W5LS5mU3H3oH24eNrJ3HDXiiDf+PyMUoZAKtnqvPN3ryqXxxdgBnll09l64x5tFzBgDvZjHosPxnWhGrDEKHNuqaeVDXe0dMZwaZ+DLToanP5eVtLgT88PNfb7Bl1g+98EePcLX8X4l09uLnWx9FUspXMuntzNZlSMg+5U24t5LM2X3BCpj9lgItlX6mtowQgwcwoFIgd61oTg5nHRarM7YnjGROYKLzIwpmcP//Xwdy4n23fxwFvUPXpikSbTJBGn93CTIDqTXgm6Q793ZqY6im/LOC14co6CWrCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIllfuXtDeLSU9va+0Bk2/M94UT+/DgyBsPmgMZWjrQ=;
 b=GOU/HmVTIr3FzUiHj1rlpcg34rSQNpN5ROYt8qRZwh3Egs4BU/QATe0Tiha6LCyG/2aRqqNThFzdhJfZyvwtK5XHa9y+LA9PItOjAuVA6piKc/KdwV81xB/MlOYn40tGTAdht7wtbCHc9Wdv6YsQcnG5nj59LdVQACAN5w6f7EYSjYYR1NlCnpcTzfn5oX6H2Htt2UFqZvXsRRAf3Yp9eP2t46uPhxHqYkGBwq0icYO+WEqDPCLg6tcwdAtaP2j9pG/yKwjTu/w5we4aYK49dHv4MXbg+UmU41/0p9qu8SjGB/VjgC3X8lVgWxsBwSf6fvURjZamEq9+y6dZgaSG+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:03:29 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 01:03:29 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v9 01/11] cxl: Split decoder programming into a reusable helper
Date: Thu,  9 Jul 2026 01:02:54 +0000
Message-ID: <20260709010304.680422-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709010304.680422-1-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: 369bec8d-e720-4b13-678f-08dedd55e3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	aUSNnPwyfCDsU82Z1M0sLTpa9kqZACGIpN1u1jMNeMnq28OI7+xVzryC/dxqyrhDbGZsEs6YmHyLeFy+qXo0gKo7LILO8EicWY6PtwlXfNIjf8y6m1MPR6D0PfGetzK27ImQ8/NBmBSIlcZPQyOGjMIYPCGSQaFur1HMw8FrMsdhrCgBBnxTEIP/Y/7rIjxR+WQyr/qOJe2O7ljDwEnNPc4yuNxws32Du2+SUOn+GpCXBuoTyI07z9Tv79ZiVOdvVes2XgT4lP5uJC6nMTNU71ZeNwfjodCrih1rh1nXiZ4x4x1rvMTNTB8Pc/1dIfp0ND4hnh3YjdMPUT/MyaI+1NZbTQGTwCGVqnV7HE23nXO4UrDdOaPIW8qI+0TS5gQWbYmDEkRci5d/riVvwDTZSX6au7oAV/uC8Nr7nTf/whVHF9ldJLb6DIxEi1gTujE5OIOHJ60ssUyso/cGx5i6lRpywG10lYE4QBPcRD7alI+D94WVdFB9meWIwy1wJW67LNfSdbU08zl6yZHnXKfNS6Hl5I5Dj3pt04UV/lEvNPY0KDIXY1kb8Y4lfLa0sjISrTGl87hdVd+Jcz+YtmYgRWG9ETeDxiM/DORQRA9PSWJflvnot2jxfjAq87v1A4IKOBffpOEnAq0q0cxmQ1kfEBSvhcHLMLAef2S5BcBo8EwtwsvZ9CU6abja3S5IuBlZnZf7JiOkmKS+Xn7k1ZN5bQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sGulqELRBiCz+J+oa9bSvUeB1djfOonacaAljUlc3PUPVeydScn/ouWL3HLG?=
 =?us-ascii?Q?T7vDfUYJcyS2m+btkkqJQm8EWGAgWT8kVsdH2ILsRXcxoXTDwwOvvGXn7cl9?=
 =?us-ascii?Q?ZAWbMzS8sgw/ivIHoBXk3e1VZDUIwKi5yvHnc1/7arC3swWeldWLcaftCOoj?=
 =?us-ascii?Q?eOrqXE+XCOxlEvSMsQmdsI3vMtt3UgCD6/F50ov+MKqfMcr+33b/npk87axS?=
 =?us-ascii?Q?93Uu6uhvVRyRSuYi+R0KmMM3XKi3t1PhDushx9KAAfcZlYUX0HaXenF9BE29?=
 =?us-ascii?Q?aV7el6KonTKd64pK9ogR6hN1r/jJT6bR0Y8M2ccf4XFX45c5Sz8UDABlMdkW?=
 =?us-ascii?Q?8cNBsO9Hmb6EBK4FlGK28VL6rUIZpEnzQab5VZVxDTy9tm3Xe5FgX+l7smYF?=
 =?us-ascii?Q?fRglj/i/0h3McpIjAZ7JOAZSp3clVyaQH+oqK3hHHhtj0mHgGLKIE5jeewxZ?=
 =?us-ascii?Q?EHpeaSBVdk2mBh4jcsETRlT4UwVc1TviMlRJu79TPjruX3r4HFs+qm78og2h?=
 =?us-ascii?Q?KGlQN1hRHnJTNtgoq8eVoAJdLB9wG+DzfaI2+ly1Kv4wtRClZKbToRRJX1GV?=
 =?us-ascii?Q?iIzoRBn1j5kNNBm+6/KzgCxJm8hGiZVjggt7//vTPNGxhlqPewEn3UMCnjs/?=
 =?us-ascii?Q?5H0MZ2AC7b6Z+ra6JoNyQjZcZUNMyKO1MAHF1kiPna99r9xse/9bkwBi6NNY?=
 =?us-ascii?Q?zoA+xkUtuSgsN5FXMlYtItMfu4ETdgD5CjuXyAxS953gtbqC7aY290Sm2cOD?=
 =?us-ascii?Q?RSU8M8/rpsj847UA5rDS8UKxDIzXyesgBnRo3xcLYHzeCReeLmS1sdtyfJrL?=
 =?us-ascii?Q?aDpShwiqK9JPQ990ywGQ7A1lu6+CG2GoRiP7uRPO+ARbBdSsjyTCkWkB0H1H?=
 =?us-ascii?Q?R2Ga7vahtLUk/2O+aO02iaHyFMzR3Gxfk9HnLsMrO60FV3uF9fe4si45m3PQ?=
 =?us-ascii?Q?o1/ugQm5r0KIMB4p54zPVpy2+9Golh38ev/QVFt+I0950X/DSk3jWK6YEhZk?=
 =?us-ascii?Q?ZyIDq0QjRviJ4NwgR+64e7sTlsH9F2LFR13UVrvca9rk6JLhtkCzD2cmimqy?=
 =?us-ascii?Q?6GpbIrGr5p065CZIpaSA9bnKQ197H9hQBb/fCYHRSu9XKWVJJXXF1oX5Brve?=
 =?us-ascii?Q?pjEPcfQ+i9uQRezoe/8N8V24LJPsJi372C0IxSQdudeqMeZ/t2/weKcCOhBx?=
 =?us-ascii?Q?O3r0u85uuKcvofXskhVecCV8A0hzQJdYlJuORQlIMAwiT1d3fqaZcRWBxRDe?=
 =?us-ascii?Q?Ozbi4SD676mWJabmajfvvrWkepedZIw4ruNoNza9/vfAiAq7Bx6vqxKK0Jgz?=
 =?us-ascii?Q?t0XQzgUPSEsJ/bljmK56+JCsb6b2H6zsm1+whW1y6/+m6Uag9oA69h0onLP4?=
 =?us-ascii?Q?ai3Vub30eahqMmkXabefnxlf1TgUaeEmZFFSRwZKeB8gYd15EnkulY5x93/x?=
 =?us-ascii?Q?twSwPCvMTuV4R9oGKOGcVA6D9nug3LzjE5l+0/fOhhcr7XZjFSM+epWhXPqv?=
 =?us-ascii?Q?wO1lalsFz/G3dgMXibhhNy9cuSF9vlbYjyc3OfTa/aK1l/iVbiD062ztDSc5?=
 =?us-ascii?Q?3HDRLtrqiLe/vuLgQuhwMIldPfhfDVwkS6D3OZ+K15sp2k7tRn63LGwc8gVW?=
 =?us-ascii?Q?bWQPvDkzg0L2I+zZ+XzJhpRfOVpDJnAiaWmOAYnZsPvc23YQ0v+QgpVfmvnl?=
 =?us-ascii?Q?S/Ca24eaGXdNNBhRB64fj9mSoZ1hFsl5KSwVIQFTGHNu6Jo4m+adcKa5w6DW?=
 =?us-ascii?Q?lKUa4VySEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369bec8d-e720-4b13-678f-08dedd55e3a9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:03:29.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FR5583PzZ8tnL/w6LZ1jaa+4hhTXR32N+FWjqXnV+L3bphUXoedmCeyxzMD++SHOlQtD1B4O84v8h+7PybTD0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

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
index 1e211542b6b6..468cca014c94 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2963,9 +2963,9 @@ static int poison_by_decoder(struct device *dev, void *arg)
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
index c0e5308e4d1b..e995f189cad7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -264,49 +264,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
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
@@ -322,7 +281,6 @@ enum cxl_decoder_state {
  * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
  * @cxld: base cxl_decoder_object
  * @dpa_res: actively claimed DPA span of this decoder
- * @skip: offset into @dpa_res where @cxld.hpa_range maps
  * @state: autodiscovery state
  * @part: partition index this decoder maps
  * @pos: interleave position in @cxld.region
@@ -330,7 +288,6 @@ enum cxl_decoder_state {
 struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
 	struct resource *dpa_res;
-	resource_size_t skip;
 	enum cxl_decoder_state state;
 	int part;
 	int pos;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 016c74fb747c..757d916a6330 100644
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
index ef92dd35e030..589a9bf8c96f 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -847,11 +847,11 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
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
@@ -889,7 +889,7 @@ static void __cxld_registry_save(struct cxl_test_decoder *td,
 
 		cxld_copy(&td->cxled.cxld, cxld);
 		td->cxled.state = cxled->state;
-		td->cxled.skip = cxled->skip;
+		td->cxled.cxld.skip = cxled->cxld.skip;
 
 		if (!(cxld->flags & CXL_DECODER_F_ENABLE)) {
 			td->dpa_range.start = 0;
@@ -977,7 +977,7 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 			to_cxl_endpoint_decoder(&cxld->dev);
 
 		cxled->state = CXL_DECODER_STATE_MANUAL;
-		cxled->skip = 0;
+		cxled->cxld.skip = 0;
 	}
 	if (decoder_reset_preserve_registry)
 		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
@@ -1028,7 +1028,7 @@ static void init_disabled_mock_decoder(struct cxl_decoder *cxld)
 			to_cxl_endpoint_decoder(&cxld->dev);
 
 		cxled->state = CXL_DECODER_STATE_MANUAL;
-		cxled->skip = 0;
+		cxled->cxld.skip = 0;
 	}
 }
 
-- 
2.43.0

