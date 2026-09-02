Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9BF36B923;
	Wed,  2 Sep 2026 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334097; cv=fail; b=G40z1DWPIOp5pdB5sWfdM22Ata7n7Wfyz1ZY11Nk5Zcul8I2MJzxi2M/R6xpd+zV7TWxnUy33egiNlHxAYcmg7jMarQ+ds2QuVhlJeYUtgxFkXb+fSg3/XQxX56U3xDssnfV243BkIo/uk8uH7gbS7H2lBHakDJnlbkSAH3PSss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334097; c=relaxed/simple;
	bh=e5wA6QBEcDu7xAmRpr6LoDJrIFnyrxrR+ZlnEzivk+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lPdj5xxU19ENTLh3J4dK7F1VRke9j/JqOh8SPJeDnjzbrUSMZGEpqswKl5yZ4RlVIYhpCGK9QMQOjoskmEVG+hlBTPwqaYSsGor080Je9uR6iEl8UwOshHsQ4E5H99RpBVjtQH6iVtqi6TYH3i4CGSW8A+3sefgVCOYhZcVa27I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UVMEWSS+; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVMEWSS+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oU4Quul2220W+c/kzP+zzEp7zsIiLj163IN7WedYN5JXqBP+n2PG5NS2YtXmSAUh012j7+CuluIKn7CRkMtMAY+K6LrXLkCl5GF3/GO1d9BgTuznLh/lv3XTkOGLjlwExxclqa3sRwfxDqoh+0GmDIjqXpTl2eyZvMODoHYJVRbjdzruc3802SAkl/aisXLNgeBfXaGqklewRM6ojrFGuY4WrK/uL9wyxjXS+I3QeNnqSzOsg6KIfEM3GoaOdSC1P0BOZ+vZXmatxZcSXcKU97T4EaGxR5B8NnMeLdp+0yyCxAYy02tbhyivBwC14IP1LE3QXmpNRCYxcF0u5AAmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM4TmqHp8eX5oJ7T7744Wyx8zCKOxYoJS0doeg+Hbps=;
 b=SmSEab1omenunvQeWQyojWZ1+dKAYzUy9Y0JuoVwbhTy9fhtAZ9z0pn6YDu4R8GFIkthi/1fC850qqeX9K3BnpUOq57bIQeKKn3fO/cP238MYxOkLXMP7atuaC4jD0JunNR3mKL3jCUkscG+R6XnApDZVElbsqGvoDcshuERHM5JcYm1cvh6Z/GebSYb2Q9tMAbembloTVqLrwQCpBnzbWQVTd6UFPfXHgTGoOssM8sECcWI0OJQIk5gQx7JaOFUirilaIuYvghM3L/SIOZc58+HUOuxxpCLh3+v21y05BD+szWPWMGMk9mHyYpdPRtDQwKHkhzWgtlfHvs3AJLbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM4TmqHp8eX5oJ7T7744Wyx8zCKOxYoJS0doeg+Hbps=;
 b=UVMEWSS+UW18o0qlPT3Y6VbaQ5KjnMzMQ7Gs/Zdq0eXGEsaJ5IbkyOihC/xKx63pCTtCYqpN3NO2xn/i6ZpEJtJGBJfVTl1uFoxKW6MdQB9Shp/YZQatHA1tugSAtbxi2YsvghNA4DhNQE87BGmCWGMotoRHwnahEK6TZuTQ2aTFDBCwEGQt5HH5aHYSNh3vVEsDoMRH+5GJPLDGxTdzARpvCLvE7Rxf6eQZyWm1ISdJTIlb+fLUSLID8+ARP/+VIIUdpbvDaJAJ0/eWgOHdBRj4pQi5l4yzaLB4VCu31UNEYv5VzKzErM5JJ+cXfaWbSOfHadRZgTNkLu7xBH04ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:28:11 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:11 +0000
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
Subject: [PATCH v11 01/12] cxl: Move HDM decoder programming helpers
Date: Wed,  2 Sep 2026 07:27:53 +0000
Message-ID: <20260902072804.665639-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:303:b9::29) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d36347-a3be-4779-0105-08df08c3be59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hZDKiSGwgora3DxL2f2wS3pu1Ew+78MF1D4BnZNjYst/FZLcXifbTb4Y8CVQuxmsHIm/yGk3P4usGFITU3xXmkKezwYH673G4Nxxs4mdV8flPqNT8aeMOrhcNpabOglnoxeeG7n7sfWr9mWx2vFuYTyn1WruD1XrsBAdvHakGVU5gbtqhGQopZtqlsXeHk8mOV1unhtccHxAKLn+fShOckA52RSiRC6YQADxWvmYK3N3MRwWG6DbEh8ZpvHFFbBU87Bmq0x4CtmfbuBsv/gytvCcMvjF8tdpRL+UWOGHE3kHUGcQ4L+aRPd0JM6PJmnOvNUKxCMQ3OItpMHeFXckdoudwLGLoH5SY+dP4P3qGK1l/G6h5bgP+ZGrbvJC8cgqHwRSpQsW5GDdPcGa8fhdFvk2dGea0T5EUtFK/dM7nzpNYRqZSjFwQ9WdLnEeXEFL6K5EFdlvZDS7eMVuv1+tc5773oWQInKy5LutSpY/l/MnGr86zUD0AuscklJ3EAIS7zTJR3r2TS2fuZa91iqPYamlbGPn7SSdZ9sHKG+lTiEoIuNfjW8tiWsZlzZl5bnqLpfEXye+q5DjqA0kSjCxOLnr3r38OQTzybBeIVcCUoO+Z2YQX5M8KXQ7GmwReISM4fVVaO2nsO8b/rgylfVGqwcG6FX1KbEsQQli/7aWcFCqjeXoVfokJ3mX48/33ZkZ1ZI/jLoBxpIKkIEXW4e6Wg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MOTjU3XSEb3CvvecnLAeGbbsaa0Sz5g4Ynj7IWu79fDQdtQF3VvV8rcnLrI+?=
 =?us-ascii?Q?r/9thglwpN2KhZjAsN4FEfFsTNJMqZ3dO5OtJqTMGAm33wwrkuvxZZ6PKotN?=
 =?us-ascii?Q?+lHUz5zEQSL30Khx0ohOE9CRSEw1TiHL/AcHyjE6Wx5uUCJCC+TkOvHjdSn4?=
 =?us-ascii?Q?pW3l9TSiQjtBKM2xW5JoHrPI3MW42VyRpaDxGDgjODkQP9x4wljE8hV58MS4?=
 =?us-ascii?Q?amxdOU+AYlEqXx0dtMMmLcFO4paBv/us137fwyXcXXNCpXp3srKxWY9teGXn?=
 =?us-ascii?Q?mKgcZtPdfrxth3nZ30hX3+NsjCM/uO5pNG0vdHFW/UOBvYz+1yq0C1d64Kws?=
 =?us-ascii?Q?UM1jAc6iW+RyQKg662umJE5L6y/gdsxW4mGL+UewKtQmCRwBQRx6g/jz2k56?=
 =?us-ascii?Q?nRq8t3nMBOD5GAe1WDSvQzgV4aWurUzyFK0v0q0aTR9TpB2e4gWnCzNq8YZB?=
 =?us-ascii?Q?ZHXUv9tAr9RjP9jxRlqtNt7gI4NiGWu+tpduIa0bI2ZQjeQtPrdHzmTbNWk3?=
 =?us-ascii?Q?E3ON/YqcNziQNGDOqNBIEsm3c1xfHtp0Ajr2z5lDmKrZj0vlCQWgVidEWvR1?=
 =?us-ascii?Q?Mg62mS6p0tSM6PVZSf495ILYVF5uGOkhv2BOrX63oioIfvaAFYLKKq5Zu6T/?=
 =?us-ascii?Q?k2znDBxhQtBFNAV5rc6mJBvi5faAq4V70TEYRIWicYAlDb1ugrDFMF76UNuG?=
 =?us-ascii?Q?phsny4T17fxJz/2Y3kwbTzgil582lpXnqrP/shAycVdHgxtFpQA9MfFvRCIA?=
 =?us-ascii?Q?0DyRk1HEz9cmxz2HjeckL8o9HTEhxzuF0xZdFn/N5qOJKUxRmpJ+INqLOV5R?=
 =?us-ascii?Q?OJRxjU/C5h5ogbixfo3lhgdxQRqARCzt4OpBsCQb00sGnmHoF5oeaqo1Kk+Y?=
 =?us-ascii?Q?/UNKVQcEEOrF6raL2mP62btvXD9as3fE+dShLTDr1IReGIivCjqMGdeT1Q0g?=
 =?us-ascii?Q?BKM3dLe5wU7u+D8RuQ/7W6fRzY9td8nOBgePps+6dnqUV3Ji37d2aTTwAKDt?=
 =?us-ascii?Q?kLrPo9ypi0DGkvZXdqzVZ14xGoAs8QoK1TLHvF/MB18kUvIxZ7Uf9CpjAcXh?=
 =?us-ascii?Q?R6nMb7SZlIpgzclXmtabLDcCUXxtCQdfPOkgFWQmUrluUVE7XeWhbZn2L1Gb?=
 =?us-ascii?Q?3kEMVsqBmwP/ALskzI969YvzuCOd8gi6PqZz6mM5cDOPh2tO6aonq2mETzBS?=
 =?us-ascii?Q?xAkMkfu6Ux1pW0Wt4DEd49P5w1rpSRcIjah2PM251WP2b0lvlqO1Nm6MmZFz?=
 =?us-ascii?Q?6Lo7zpc+tCqj8zOuc3IPFbinMGPYhK7zo2Rb5SfKZqqyi6V6BqlaRv9UKgSe?=
 =?us-ascii?Q?PA7RAtCMrUfSiARDmKnmt8aTdveOCb3K9jxak7SthwvsmcT9qhyciYQaiG0X?=
 =?us-ascii?Q?gaM6hAjEgNJYixhL1dOJ6+/kJX7ggCtvVEdDkBcpn8qRAdWl2wWDx7AmNm6+?=
 =?us-ascii?Q?XW9ewbEBcfUnfdAAm41ul3CFG0Ybze6+GB3Y3/zSTjscQz1fZfC30PjrXx7l?=
 =?us-ascii?Q?NqQywB09/RM4h2MwG/Mm4htME2/sC1unKXHVgXvjP2AbNAkljoH+KhWd9+oL?=
 =?us-ascii?Q?iuzfjO7nnqto51JKvzohFlC0DpgQ5KgWFQ8t85KftJKw+uPJFLfFceJJldcc?=
 =?us-ascii?Q?N/9LXsU91ZJWIRhcKQ431Z0IpxLKheohlGj9v9x9SSapYV4THh187QCy4CJr?=
 =?us-ascii?Q?B47fFER5ilX+Cqq0nCIkLotn9UklXwOW7TH8Hx4TxpCZZufBeXLkUvMKjRfK?=
 =?us-ascii?Q?szSTKp0w8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d36347-a3be-4779-0105-08df08c3be59
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:11.6574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZxp3eCDp3mgsSYlrYQwWizwr+eVE2vc2IgJblddgBMHEZ5DZf+8RaQTzGjD+vtcqmwoys9am0LXqmEAyLNqfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472

Introduce struct cxl_decoder_settings as a snapshot of HDM decoder
programming state. Collect endpoint skip and switch target-list state in
hdm.c while holding the DPA lock, then pass the snapshot to generic commit
helpers.

Move the low-level settings-based register programming into resource.c so
later reset restore code can reuse it without depending on private decoder
types.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/Makefile   |   1 +
 drivers/cxl/core/core.h     |   3 +
 drivers/cxl/core/hdm.c      | 159 +++++++++++-------------------------
 drivers/cxl/core/resource.c | 112 +++++++++++++++++++++++++
 drivers/cxl/cxl.h           |  41 ----------
 include/cxl/cxl.h           |  65 ++++++++++++++-
 tools/testing/cxl/Kbuild    |   1 +
 7 files changed, 227 insertions(+), 155 deletions(-)
 create mode 100644 drivers/cxl/core/resource.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..57995777af0d 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -6,6 +6,7 @@ ccflags-y += -I$(srctree)/drivers/cxl
 CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
 
 cxl_core-y := port.o
+cxl_core-y += resource.o
 cxl_core-y += pmem.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 35eaf636adc9..48fbc635975a 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -210,8 +210,11 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 
 struct cxl_hdm;
+struct cxl_decoder_settings;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
+int cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
+int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings);
 int cxl_port_get_possible_dports(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..70ffebd3e213 100644
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
@@ -679,122 +674,52 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
+static u64 cxl_switch_get_target_list(struct cxl_switch_decoder *cxlsd)
 {
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
+	struct cxl_decoder *cxld = &cxlsd->cxld;
+	u64 targets = 0;
+	int ways = min(cxld->interleave_ways, cxlsd->nr_targets);
 
-static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
-{
-	struct cxl_dport **t = &cxlsd->target[0];
-	int ways = cxlsd->cxld.interleave_ways;
-
-	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
-	if (ways > 1)
-		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
-	if (ways > 2)
-		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
-	if (ways > 3)
-		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
-	if (ways > 4)
-		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
-	if (ways > 5)
-		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
-	if (ways > 6)
-		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
-	if (ways > 7)
-		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
-}
+	/* target_map[] holds the raw list before target[] is resolved. */
+	for (int i = 0; i < ways && i < 8; i++) {
+		u8 port_id;
 
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
+		if (cxlsd->target[i])
+			port_id = cxlsd->target[i]->port_id;
+		else
+			port_id = cxld->target_map[i];
 
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
+		targets |= (u64)port_id << (i * 8);
 	}
 
-	return -ETIMEDOUT;
+	return targets;
 }
 
-static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
+static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
+				 struct cxl_decoder_settings *settings)
 {
-	int id = cxld->id;
-	u64 base, size;
-	u32 ctrl;
+	lockdep_assert_held(&cxl_rwsem.dpa);
 
-	/* common decoder settings */
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
-	cxld_set_interleave(cxld, &ctrl);
-	cxld_set_type(cxld, &ctrl);
-	base = cxld->hpa_range.start;
-	size = range_len(&cxld->hpa_range);
+	*settings = (struct cxl_decoder_settings) {
+		.id = cxld->id,
+		.hpa_range = cxld->hpa_range,
+		.interleave_ways = cxld->interleave_ways,
+		.interleave_granularity = cxld->interleave_granularity,
+		.target_type = cxld->target_type,
+		.flags = cxld->flags,
+	};
 
-	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
-	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
-	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	if (is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
 
-	if (is_switch_decoder(&cxld->dev)) {
+		settings->target_or_skip = cxled->skip;
+	} else if (is_switch_decoder(&cxld->dev)) {
 		struct cxl_switch_decoder *cxlsd =
 			to_cxl_switch_decoder(&cxld->dev);
-		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
-		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
-		u64 targets;
 
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
+		settings->target_or_skip = cxl_switch_get_target_list(cxlsd);
 	}
-
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 }
 
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
@@ -802,7 +727,8 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	int id = cxld->id, rc;
+	struct cxl_decoder_settings settings;
+	int id = cxld->id, rc = 0;
 
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		return 0;
@@ -815,10 +741,6 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		return -EBUSY;
 	}
 
-	/*
-	 * For endpoint decoders hosted on CXL memory devices that
-	 * support the sanitize operation, make sure sanitize is not in-flight.
-	 */
 	if (is_endpoint_decoder(&cxld->dev)) {
 		struct cxl_endpoint_decoder *cxled =
 			to_cxl_endpoint_decoder(&cxld->dev);
@@ -826,6 +748,10 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		struct cxl_memdev_state *mds =
 			to_cxl_memdev_state(cxlmd->cxlds);
 
+		/*
+		 * For endpoint decoders hosted on CXL memory devices that
+		 * support the sanitize operation, make sure sanitize is not in-flight.
+		 */
 		if (mds && mds->security.sanitize_active) {
 			dev_dbg(&cxlmd->dev,
 				"attempted to commit %s during sanitize\n",
@@ -834,10 +760,17 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		}
 	}
 
-	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
-		setup_hw_decoder(cxld, hdm);
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		cxl_decoder_snapshot(cxld, &settings);
+		rc = cxl_commit_start(hdm, &settings);
+	}
+	if (rc) {
+		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
+			dev_name(&cxld->dev), rc);
+		return rc;
+	}
 
-	rc = cxld_await_commit(hdm, cxld->id);
+	rc = cxl_commit_wait(hdm, &settings);
 	if (rc) {
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
new file mode 100644
index 000000000000..64e63114cfbf
--- /dev/null
+++ b/drivers/cxl/core/resource.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
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
+static int setup_hw_decoder(void __iomem *hdm,
+			    struct cxl_decoder_settings *settings)
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
+	target_or_skip = settings->target_or_skip;
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
+
+	return 0;
+}
+
+int cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
+{
+	lockdep_assert_held(&cxl_rwsem.dpa);
+	return setup_hw_decoder(hdm, settings);
+}
+
+int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)
+{
+	return cxld_await_commit(hdm, settings->id);
+}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cab8ce39f465..03ce50a6a06e 100644
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
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 802b143de83d..c09492af8fbd 100644
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
@@ -23,7 +25,68 @@ enum cxl_devtype {
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
+/**
+ * struct cxl_decoder_settings - CXL HDM decoder programming snapshot
+ * @id: decoder id
+ * @hpa_range: Host physical address range mapped by this decoder
+ * @target_or_skip: switch target list or endpoint skip register value
+ * @interleave_ways: number of cxl_dports in this decode
+ * @interleave_granularity: data stride per dport
+ * @target_type: accelerator vs expander (type2 vs type3) selector
+ * @flags: memory type capabilities and locking
+ */
+struct cxl_decoder_settings {
+	int id;
+	struct range hpa_range;
+	u64 target_or_skip;
+	int interleave_ways;
+	int interleave_granularity;
+	enum cxl_decoder_type target_type;
+	unsigned long flags;
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
+	int id;
+	struct range hpa_range;
+	int interleave_ways;
+	int interleave_granularity;
+	enum cxl_decoder_type target_type;
+	unsigned long flags;
+	struct cxl_region *region;
+	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
+	int (*commit)(struct cxl_decoder *cxld);
+	void (*reset)(struct cxl_decoder *cxld);
+};
 
 /*
  * Using struct_group() allows for per register-block-type helper routines,
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc9..6c09932587ce 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -60,6 +60,7 @@ cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
+cxl_core-y += $(CXL_CORE_SRC)/resource.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
-- 
2.43.0

