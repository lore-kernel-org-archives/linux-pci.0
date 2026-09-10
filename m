Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C281390603;
	Thu, 10 Sep 2026 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024114; cv=fail; b=J/3n3G2P+wEIo6RKn7zkFFAFiTAGcak+u6g9+q9/DNNnkDk6A5R/m1NmZaJTHYfcjrdacy9zw9Jq7EbK4kmLDElcoijaQ5opyEQqHYvrtBs51rtidAaK10FDCp++zAdyKN8un8sdrvPHYQfb+ZnFU7HQNyAB9FG4BD6cBPl+HhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024114; c=relaxed/simple;
	bh=e5wA6QBEcDu7xAmRpr6LoDJrIFnyrxrR+ZlnEzivk+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OFrrt7FYjIanqctjIbWYd1nPRDvRvKVJWkb1WqWeJ2lB0+wvNFyF8YEZS4Wq2JsBowUu55g1D71smoB1zebnN31/BC74n4TQ+yEO350OnmMPD/c7cRY0fozf5vuRvLS7LFtvUDb2GsRfhzCZPaswmEPoyDZez+jKF651uIE3S2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GwjtMubv; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GwjtMubv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rF4TkFYJshkeGPcxWZXa6fYxIX5tp0c3kGqiUPns5oNEssasEsyshQsxknDYhkOwNHIh7W3gcK0c9f6yEzcEDu5C4831VcmNfuwzTxv+9HVc23DLO1nne4p78DdFiFVY4AYpUtfG2eVfSxLWVUppqNraUblK/kI5Hur1slzGPJ9D0dUk2ftWmbvxeBkYaQFU3M7aDFVhGww6Ve6XDXgs9xMPHF6up7FH/4vivEEGfOptcPFW9yNJBejgUHk1KJGfB2aA0A35UHi4e4O18MqF23QDoZh5x300j9tBsytUFnxRxgfxEa7ZSuS5XqDlwpZ2OXPIpw++HBp1pt8RmZxslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM4TmqHp8eX5oJ7T7744Wyx8zCKOxYoJS0doeg+Hbps=;
 b=l09sQL21K2qefi2bRr3m509NLcMor6pBA5jurUEhFq69JaCVc32S5riRcrWCa4LDAYIdxoK2LPYfGcxHS3WGjbxS2Ml/9cZmy4pTPRbEwzCM/Ew7ByD1mMQ+ORLfVYihXJufe/b47+IZMd7F5aDhPBJuAjfBO0nO3egJ7OU+y//U7gry2wGuDwyjSejUG75DzHw5sIxiUgPuyMhxZnPm4KKUuiRg/kQoB0e4rZpgAyV1qE4VkwN+oiTQS6BkEeDVCxVUfl5kWmfj5E/ONG9Y/PJ5cQZBAeNJOyx0w+fVGasJNqioHxvkVsbbFWhkEMh0Pd/PtGbwnXWjbyeAjgHV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM4TmqHp8eX5oJ7T7744Wyx8zCKOxYoJS0doeg+Hbps=;
 b=GwjtMubvnHAdfpndSTtdFkoPcLaUwJT7iey3RG/ypf4VxJOmKjxib3VUqqxirPKdoQ42pQKjN8TLbfT+vtcciTT4Db+NIQPiQd41BruqdIcqmmaKpD4jX4VQHg7hevuI/vQ8IQYEa12QQtHwKoTCabfSTFp76EXw6NcjOVq2KnsamYbVUyAE7TbrQSWfegoa7U0mnAec9xj/BhVbkzolp42H+Io/jjrPIqyW/W39AUhWFsx+P5LyWVAy5Ga2psLTzw4pTMR9ZW2a0Q+B+DH2/hNpNqohJPLsaEO83iDotKYwe8NWCTzZR2ummRu0oTryQcDtAGLqGZEusQYTt5U2LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:17 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:17 +0000
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
Subject: [PATCH v12 01/12] cxl: Move HDM decoder programming helpers
Date: Thu, 10 Sep 2026 07:07:57 +0000
Message-ID: <20260910070808.1444264-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::6) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f3826c-f9b3-4fb9-5063-08df0f0a4a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	g5KDNqF8vdsThcn1aL1Uq0Gl2pYMoLU/2WnVXcQzptJGQIL8g9rHt7DM38NFiOtymon+bHoZWUMfL/mB16M3K/KtpmzWugJQdMzLAAZSc49vgVni2ryrVLS8rjUXAELkNy0/FK2PcNF/NoJisdsqTn1/Gh0fRJHxcRdcoLF0MbvU6otQNqNu0OzPZ/TPHQO1Ivw/lTWJmqsgEfmpgZwnszyFQKmTFETNThR6vMbnUPV6g4qTpPt+4VWYz6B5p/jAKpAEYNE5Vi6x8A3almvTGTlREwpeLbID/5XOncto0nFgqQpsGg0oMcnN80WnwP6+apAs6GFsD2ao6TldLBhJ28rzj8kGV9ZKX2UMAeUOZZjQEA8AtXyeqpm1AFy2f8a7WraLbIHJ9txcc6Bjgh5y73rvh2Rj5f8YPB0ynNxTTcfQTfaYFrAZmQKg+W+dEMV2vcwIrf9hCqOqynS5/R6EEAqXyPpi5vDt4J2ljoS116N9j1xLSqOManfyl9IkOWTs/KVLKLrW6QAva0q+EkU30gxG2ZlP/AB2Zp2NuMdlBFvNqFbuUHt1dtFyzEb5dGGMFZlvNliFT88ERCcOvxWmz5G5Rf8r2XzmIOZ1vK11/7yuu+RfSfQWTK0/b6h2vnwB7ifpzu6VsFkLc34Uf5S5HaXIH9EcD/ImZ8YsPXMaWtfmHHrqbg0HM2j88rxRPSreq6dN1zvAv4DtP3kSsPVgGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?avZeeVyHyaajrAaKtWFygeK9OLk97gIIuLW1qSwxl6e9sCu8KKsIMSZrym8y?=
 =?us-ascii?Q?KAvZudJ5elxtmiiP/TbpJzyIGqMflH7xu/vT+8oGPsEohrhj74+WBYx3Dtq4?=
 =?us-ascii?Q?kCpFwJPw6l1RrlkJYRW0f4Nxr6X9JCLnRh39Cnlp52xc17rNcfDFowlH1b3k?=
 =?us-ascii?Q?wKET4oM6GvjkNrLYXdHSPzck2wmDJAefeVJb2RfjxpbRebt0EruTT+ocdbcM?=
 =?us-ascii?Q?Y/iEGjOpJ0+EmDI10it5NBZ6XfHHUwsdecQLyck65HZm8ZrlosCsiorBo8Ad?=
 =?us-ascii?Q?y8ARuJgExt7DHLHMJOS2UxR+gtLqCqt2LvLWWZe3lLT9fLrPwW6Xhe0VgID8?=
 =?us-ascii?Q?1UIwGX5ivlHBy1T5FNJQ+GZW/zZT7QIf9t8kKRYkOHFhK0k69IM33Abe+pSa?=
 =?us-ascii?Q?wYem3JlsGnbzr6P86qqvyTi3mnOdXYa4Hp+jip952lBMYjOCxf6NDNDigh3v?=
 =?us-ascii?Q?nPwYd0AFSEIixkG6D2E5U7wMIor6RhOyNTuLME8J+lLW0EsBECGknc2pvjuE?=
 =?us-ascii?Q?ul28PLsAmg0wNWNxT2u8iTbwHIdu0VaTMDhASX+MZlhPM/fRLn7VjAiUODSA?=
 =?us-ascii?Q?TuDSoHYGoTMDgTh8CK3H+8tvoHPfBxZUwRyDGxBPKGkcVDwXhcMANxtcvTdg?=
 =?us-ascii?Q?ftOs29i1XrSQoku3AI5mkNdbzTtV10g1ur8r+MdRzq5Rw1U4y5pXjQdLpqCC?=
 =?us-ascii?Q?TotagJDbwgL5ylSFvXlY3i/g6+GtVsL5udAYf7tnQ+99iYKYw2gYe4vaaHYl?=
 =?us-ascii?Q?eHTSHt6gVIdSkhH4gRQ7RgBON9pQ5kh1DEP16DIWIJRPWWK27D9Gu/hVSSYh?=
 =?us-ascii?Q?crxO5nTr5LCJKD7MtdMAS9i1bx1FS+Zcb2jc2IfEn6eEYdLafRGUTaJcVb1Q?=
 =?us-ascii?Q?89D7QyC9Js6RwLJVBmyEbgF4Sy6ERjCd54Pk4RV+2YXA+1YFn03uUFc1RBSj?=
 =?us-ascii?Q?75rxP2NPGo2iO9JsAuvMOmNabxVaFe5/uTREB8VLA3cU26dQQ/u+eHwQSSoS?=
 =?us-ascii?Q?RUDuaiRAB4UL7TdbC4M1BClizeLs2tEYOjeCttb7h8H/+9KNxpYPjrkuftmC?=
 =?us-ascii?Q?T5Helw4x+YNghtIAahoRIOaWdF1iHmlFonEg8MPeUu/zjGUy9VOepoOYceuT?=
 =?us-ascii?Q?eVfonnz0GLnz85eZLnhZuEHYb3B3Hk/w8VOInKAVbmAFdJt42n1iGkTEXaGQ?=
 =?us-ascii?Q?B2cWn76EIcZWn/E9hWIK+YCMsKXEiBcOxuQVWbCgJ2KN1/k+i6EKzpjw/QmR?=
 =?us-ascii?Q?cZ0fnUIIua4NnEJPFu91thdQ2Uwf1kp8NdwZa/ML8meXEzR0HE0mmf+Kpq/F?=
 =?us-ascii?Q?WupniQVoO1L2nxtST+9SAOY9vpbqV9lyJuQBoKOv1jK2eRtDjbwiyyhJEHhf?=
 =?us-ascii?Q?Cv9YgOIXKxpWgJlpUXoJOkZQ8uh7CS5Rb78wIEbmD4tFdijSRsOB1fxD0p7i?=
 =?us-ascii?Q?6AyViRVg9o8CEMpvFI9nzABbgjmpAOtsxJ57dOE4SJKXlla3oBny/AF+h6sr?=
 =?us-ascii?Q?x0mzLsDX1mJx1p50iRlfsKP9oGk3OWG6bZICVPk6jP3THmhnG2ZWiAo4kPvM?=
 =?us-ascii?Q?RY+4OsqIexFED0K6enoK1JzW/K05YYkqIlPBR48dyPuX9nT3dfh/9orOVtKj?=
 =?us-ascii?Q?3ln/pie4AT0zCFGHnk9vDeLJoAMamzLalwpZeYdumtSBIGknKvHQPQ2Wp/eC?=
 =?us-ascii?Q?e0YD/wDZ+Zub88GBY0tqq+Yahlgzq781xbL78kPQN+KZ/kkQQ0OQXCw5SGyP?=
 =?us-ascii?Q?sm9HdKp5Wg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f3826c-f9b3-4fb9-5063-08df0f0a4a0b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:17.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9DDVuQRni7L2NDG5LEX5R6syPXu7SMbam7rxC4oGoNPKuqw467TdDFNR/DZB1+D/JTn8NN4UpBsfSa4DuoqNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

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

