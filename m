Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E113AEF37;
	Wed,  2 Sep 2026 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334101; cv=fail; b=olwHwmhY9ZURd3eXN32BJfuH4BaYvp1p2oF3lQT5d/zqVbnliA7Og7hdG8V1zzbonzFr1pePa+jMu/OmzOebRCtsbbniSgeaqEZyfGgRmIOsZlLwLSjCUvsSBFW7YUbgnibFhrQhiH5t3GFC/So25XqD8iO1tsTJF5kaeSXPHPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334101; c=relaxed/simple;
	bh=VDmwCNegrnAurYpztlL3oMJNp7yvbqHnTvl8nUAXBg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eaev01kt66ZrdcMcuigGxr679YKAQiTc/l7lRu2IeNZJ4/2QLuSexO33C52cluGHksFB7pv3pM0ZoClMlab5iGz2y5IlEaJ85/Iobp811hZhvrGzMfvi99PWEsXeEa9EGk9lX43+XqwYEq+KqrnffI36VgK3t793uklDQ8Ganbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pB3WvMp1; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pB3WvMp1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYKC9pds3vT/JDzGG1aZ5kf/7vKNb48fiGS4EecYRIUqON6MYdcdg1CDZTZVeOAoaAzzjlnXgM+D/rg+hg9ft+5aHpQp/0VDFEa3Df8ocPngpou7rlDOMrT8/BVftT+VPHdQs5ywfYH88SNRCcSC0jtJJLh8f1RwSrWm9m0n7gxfyAJKh95xWPYx8Ov+39F0gaiujKQeQH5Xiv0Nmx21b+w+NyDN22wNOE1vqsqivsmwwMX6xSh9ZX6eeX5u5RIFiUBGQHsCq/CiujYbpjfACtxYFU/J3yyAHR3lSRlL1t/Ch2cVw+wal4Ri15BwThmYdTvc5BKEwgqqb7S3CrizlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjBqIRCHONLi2PU6tOVV+a6+sIjPAZTwG00rRlOV1z8=;
 b=oZJPU+MiQT89Q2jeKdDGXG7+pAuSO3bFX74kQjgFlhpq2QH6OeBvy2hIuwMycVfksq51s30f+OqusYpryOnYzTGDo0c8VTJbewVd7zXszx1F1FBe0tT2KkJK2dgwWum97jIlNX7gApKW76oiKx/7uqvYTQbGlonTvVMg+RSxUezoNOhimzya2y5NTe0xRleKoaF8nlAG7LTmVUPqkDeVkQBxjzx47+6EfE3K9yQYGvX6rbAvVYSNl58v9IVE6ALqKfjLdEI6EGA/rD1UaiT9sWvXuhw0sV98thhF/n4rf59ynof9RLmylZn42zRaZKMOrXoJwjh9FMBLbdYJ9D5OVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjBqIRCHONLi2PU6tOVV+a6+sIjPAZTwG00rRlOV1z8=;
 b=pB3WvMp1edivYaKZuhxYVAUIaeZ/0DfMJHtoemnjoXlY6JSA4EmMRbWeKjJ5sm/yg4CnCpFXUYT3zd3M2rPcRKzUrdDgVF//fDy8h8mhf0j7+ZM2lDd0p5rrsD7ZtFhub+T1VhjqJJoqklu0eLGQASleH3YVTGWJ5y6Hsb0e7TONQnusvbvMtAH7qUnMVcfrjlwxP0EKBkFS2r4DY75dyes84AVcSmJ18m7T3l5DH9lmQkKpU6uv8mChcGvKAtctJXiL051Go84uZAsXd4qGExiUr+kH0xmTivQBTco62+UDidQa4gtAOuKQjiQZ+TW5BgcINSQi3C4p6Ezx5PW+6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:28:17 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:17 +0000
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
	Srirangan Madhavan <smadhavan@nvidia.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v11 03/12] cxl: Share HDM decoder decode logic
Date: Wed,  2 Sep 2026 07:27:55 +0000
Message-ID: <20260902072804.665639-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:303:16d::26) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f7e70a-70db-4d71-afd0-08df08c3c191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fXLfD/IXjXI9XOwIStlETgTLHfsnfheMN6E9cWbZboT1WeNm6eBG6GRLCQBVjQLmVOYrMZdKPJEex/ZYw6Q37x/Nu4cPUWD+hi1BVXZqfZXptRPbhp91y3dG6g/gTDNchdLVz/WTPDXNHSyisAGQ5zC0L71QyqPyiv7gplyDU88gmQSrskkANGYocmiYebtmLVnsy9mcx8RbHm9nUl+OrHoeJ8erX3jdwmLqG6Zho2g6CzFVS31lkIJZQHmVNGbp/a56pM3Zet4qLYJUQAeZHRI7zi61EES7HSK2MBlVGAXM0RBOc8RQRbyHoF6wCMWQK6WQ/kCUJa1IXd4E6uzslSxO+AZMecQPG44D2kiyAXRuprEXZ3jLkih6ZAm8+EEDn5fE8RHMf2jxguzcem5e7l5vtuwa+pxEg36YSg9/h/UxME4sml4EZRUro4zcylbousRJan25DGk+YfdHbtQBA3K91oEoqVTHBM+E02/lG+MD+NaEaVJRkbODqozaiBW+Y0BRHM310CEZ3e02EmoTwTy0m1g2cOAzdZC9+WwVTnaiqLq50ktDAEscI8J34zZRiefhPzXqqM0gbRcwJ4f/fFoR+EINRE5lCMo/8SKSMX7++PqmYSLp4Qop08QPkEH4PW6cmiyjQ1Rq3DDXsXlhi604h4Z5YZb+CyknyW453yr6vXnht8WyWZK0LUBAgxcGvpTZBhj5p/Ap+oU3Lm7QQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XEZMoptJw8j1Ee9WEXXWGjgcWHMM0FnhzJW00FANKoifDDZeIri2pNKEAnld?=
 =?us-ascii?Q?JiUrJ1i3F7fLE5wuwviXugKVMWiUpFfF+IZIFQIUF4OTHQWMOVGHQa7fFfJR?=
 =?us-ascii?Q?sqgHiM4E2uDfrDacs+V0owFs/ook6YSFP3jgy8emECVzRTkCXuYc4bbTFk5X?=
 =?us-ascii?Q?K2eUOOiSZz3d1Tm4wRqfNKqNtArqpKav1366lPdOzKFRW96wAZNWTp8ow0s6?=
 =?us-ascii?Q?vbSoSnMPiW2K96gfTtEl+dCO0QVzhE/nzY0OMFLsoiIs7aFNgXSTSSBhxTp7?=
 =?us-ascii?Q?mBNv2wckUz1o2sowpQ1pDBd565FCyvxAFK8HybGxxJFi1mDe/B1LEj5T177+?=
 =?us-ascii?Q?tHjYXmdkINdaGkkQFO720Y/aNayOAMI4sXZCucHH64EwzuMuP2C3houcPJby?=
 =?us-ascii?Q?/GbgNsRX3Eb1cDAvcdt97I9rCHYEG7Fk4onOU9RjAF625iSUKMqewxL0YyIj?=
 =?us-ascii?Q?8awruJ/SO0VMk0KdiSESeDvE6dhUJq6B6jLfBs5kEatTS4Ufp1gTfuWhBRLO?=
 =?us-ascii?Q?dpYDrrQQY+vDVv/+VowMuYMGDUrU4Gjy/K8g7E5oqgx71hJQpNpFMaBwc3x4?=
 =?us-ascii?Q?D24DfW+KbVHs+xT1czUvO9bBe8X1PVF83dt/gEivL7fCS6+MLqyZu4IsxXdv?=
 =?us-ascii?Q?euwjkmaijbo8Pa/dEqc+F8tK14RczoL0GwpQH6fYoLeBZ0k16cIkxvD+F/4K?=
 =?us-ascii?Q?nA+HYEjRIYyePXoDrvmkTfWNpyOGVce1Md1lzgddXJo8qlXyzQiIi2tOrOw6?=
 =?us-ascii?Q?2X9fQQpLQ8+k6MfPB7goD6fsfOlVuxt4rU7/iA4D6FqcfJmkBdYaEm/a6IpX?=
 =?us-ascii?Q?S600xcwjOwXjqLdKtDbUpa921s+JagBa5DxihRCZJPPSLRuW53PIyivoB6w9?=
 =?us-ascii?Q?WnrjZ3Kh1bHYNMhAM/MjEzj527qC3nRKfJ4gEy+cr6r5zKJOyLPAZcp3s03B?=
 =?us-ascii?Q?XDKcmf0EpHwQYyf0OyGXaO1vd/vYTvCxKiBhKcwiVVIfWCglHIhcIX3pdwg8?=
 =?us-ascii?Q?nGrNfYR069jcqPZXz6mNZxQ8d27Ph7KukGlBOCL0WsUELesAH1VWIi/ZKMQe?=
 =?us-ascii?Q?bWJIEPJI5ZzJTCVdiMwreMUYzGfSk4bB4qP5tjHqhcqt1mzZbCpfChWtkyYE?=
 =?us-ascii?Q?OwRbGUqlivTDz3Sjlsm0JOryjUv0Z9qlpDBE0D/h2VIwDQAvd11IInjI8DBG?=
 =?us-ascii?Q?4lzrnie6eYokQkiVXPj0bSjW3SRBwqwUUrGvyeWBc0YwuvY+KF1Xwe7vmGcI?=
 =?us-ascii?Q?5DGGk+33XkHGGjO5ETgXcl++7KCBJCRgU2a5018C2jFcKWw5csX2D5FX9uGK?=
 =?us-ascii?Q?k0wMH65371xMh8ztt01dWW50urJ3SlE2rSmJt3+zJe4pVAz0UM0Tk+kOmF3Z?=
 =?us-ascii?Q?0zhRaVyXeBwGOKG1a8eHDp7qm/Kplku71OW3Rq7f4wRm3KjWEPdIePf9bFlR?=
 =?us-ascii?Q?bOJFmydbLti5es5Rk7WzuZh8uh8KYvIUhV62PNKD2neqjvC8kGK0K/MBUo6Q?=
 =?us-ascii?Q?oNh6Ro/RYqmJs4iewz1ROI3Ru+/gUBV/iBJX9BjgCKjdQHzPYmQ7YrC53Iyp?=
 =?us-ascii?Q?N6lAvekOv7HOffaoZQKreILHa6jMdC1cQ88so+UIZADP9soJBv/x3Ef8RjgH?=
 =?us-ascii?Q?92Gs1qng+Da4uMXWYIXEJG1OBsCP/6WvUwOp1l/esSzbludNX5O/3GXxI9HG?=
 =?us-ascii?Q?L9UHCcZPXOgCA/Xgt2UruReIWBejfLonrqZVqVPkY1MPlvw+1oop6oBHnVDO?=
 =?us-ascii?Q?efW31XhY9Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f7e70a-70db-4d71-afd0-08df08c3c191
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:17.0172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLzFnzJNOaV5NON4wqYc0nUybShXAgc8qHFQ3SqL7O0Np+SrbPsQJe+RmO8gNbJVuUzPKfqDEIzYLfaIJvKBYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472

Move HDM decoder register decoding into a helper shared by normal CXL
core enumeration and early PCI HDM cache setup. This keeps validation of
base, range overflow, interleave, target type, and enable state in one
place before adding another HDM parser.

Keep caller-owned policy out of the decode helper. A committed zero-size
decoder now decodes successfully, while init_hdm_decoder() retains its
existing zero-size rejection.

Preserve endpoint DPA state ownership by using the decoded skip value as
a local input to devm_cxl_dpa_reserve(). The reservation helper updates
cxled->skip under cxl_rwsem.dpa.

Reported-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/core.h     |  4 ++
 drivers/cxl/core/hdm.c      | 75 +++++++++++++------------------------
 drivers/cxl/core/port.c     | 19 ++++++++++
 drivers/cxl/core/resource.c | 43 +++++++++++++++++++++
 4 files changed, 91 insertions(+), 50 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 48fbc635975a..5350c154d88e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -157,6 +157,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
+struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
 
 static inline struct device *port_to_host(struct cxl_port *port)
 {
@@ -215,6 +216,9 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 int cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
 int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings);
+int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
+			   bool *committed);
 int cxl_port_get_possible_dports(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70ffebd3e213..d621d827f59f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -907,14 +907,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 size, base, skip, dpa_size, lo, hi;
+	struct cxl_decoder_settings settings;
 	bool committed;
 	u32 remainder;
 	int i, rc;
-	u32 ctrl;
-	union {
-		u64 value;
-		unsigned char target_id[8];
-	} target_list;
+	u32 ctrl, tl_low, tl_high;
 
 	if (should_emulate_decoders(info))
 		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
@@ -927,35 +924,33 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
 	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
 	size = (hi << 32) + lo;
-	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	tl_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+	tl_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
+	rc = cxl_hdm_decode_decoder(&settings, which, ctrl, base, size,
+				    ((u64)tl_high << 32) | tl_low, &committed);
+	if (rc) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
+			 port->id, cxld->id, ctrl, rc);
+		return rc;
+	}
+
 	cxld->commit = cxl_decoder_commit;
 	cxld->reset = cxl_decoder_reset;
-
-	if (!committed)
-		size = 0;
-	if (base == U64_MAX || size == U64_MAX) {
-		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
-			 port->id, cxld->id);
-		return -ENXIO;
-	}
+	cxld->hpa_range = settings.hpa_range;
+	cxld->interleave_ways = settings.interleave_ways;
+	cxld->interleave_granularity = settings.interleave_granularity;
+	cxld->target_type = settings.target_type;
+	cxld->flags = settings.flags;
+	size = range_len(&cxld->hpa_range);
 
 	if (info)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-	cxld->hpa_range = (struct range) {
-		.start = base,
-		.end = base + size - 1,
-	};
+	if (!cxled && cxld->interleave_ways > 8)
+		return -ENXIO;
 
 	/* decoders are enabled if committed */
 	if (committed) {
-		cxld->flags |= CXL_DECODER_F_ENABLE;
-		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
-			cxld->flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
-			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-		else
-			cxld->target_type = CXL_DECODER_DEVMEM;
-
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -995,33 +990,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
 	}
-	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			  &cxld->interleave_ways);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				 &cxld->interleave_granularity);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
 		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
-		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
-		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
-		target_list.value = (hi << 32) + lo;
 		for (i = 0; i < cxld->interleave_ways; i++)
-			cxld->target_map[i] = target_list.target_id[i];
+			cxld->target_map[i] = i < 4 ?
+				(tl_low >> (i * 8)) & 0xff :
+				(tl_high >> ((i - 4) * 8)) & 0xff;
 
 		return 0;
 	}
@@ -1036,9 +1013,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			port->id, cxld->id, size, cxld->interleave_ways);
 		return -ENXIO;
 	}
-	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
-	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
-	skip = (hi << 32) + lo;
+	skip = settings.target_or_skip;
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
 	if (rc) {
 		dev_err(&port->dev,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..5085574521c6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -34,6 +34,25 @@
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
+{
+	struct device *uport = port->uport_dev;
+	struct device *host;
+
+	if (is_cxl_memdev(uport)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
+
+		host = cxlmd->dev.parent;
+	} else {
+		host = uport;
+	}
+
+	if (!host || !dev_is_pci(host))
+		return NULL;
+
+	return pci_dev_get(to_pci_dev(host));
+}
+
 /*
  * The terminal device in PCI is NULL and @platform_bus
  * for platform devices (for cxl_test)
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 8d3f43640199..e6aa55079c76 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -113,3 +113,46 @@ int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)
 	return cxld_await_commit(hdm, settings->id);
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
+
+int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
+			   bool *committed)
+{
+	bool enabled = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+	int rc;
+
+	*settings = (struct cxl_decoder_settings) {
+		.id = id,
+		.target_or_skip = target_or_skip,
+		.target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
+			       CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM,
+	};
+
+	if (committed)
+		*committed = enabled;
+	if (!enabled)
+		size = 0;
+	if (base == U64_MAX || size == U64_MAX ||
+	    (size && base > U64_MAX - (size - 1)))
+		return -ENXIO;
+
+	settings->hpa_range = (struct range) {
+		.start = base,
+		.end = base + size - 1,
+	};
+	if (enabled) {
+		settings->flags = CXL_DECODER_F_ENABLE;
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+			settings->flags |= CXL_DECODER_F_LOCK;
+	}
+
+	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			 &settings->interleave_ways);
+	if (rc)
+		return rc;
+
+	return eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK,
+				    ctrl),
+				  &settings->interleave_granularity);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
-- 
2.43.0

