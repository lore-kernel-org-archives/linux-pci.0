Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7534EA368;
	Thu,  1 Oct 2026 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846582; cv=fail; b=OausnfWeGFDyCyXJzyN8qa3lS3V/XetTpvvf8IufkH5Xmk9yoIXnV5OEevegEOPDSGlVfMJ3v2M+bKxpQZs3wVhGp4np9kUUVXioZTjxBJXpDHGqrxtzPcU7xPnqffQyc++9kgbUL6DYpoiynOEIMBf8I1bnGtGyOIjyo0c7n08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846582; c=relaxed/simple;
	bh=xmaQ5pVSAjP+6bFfj32p4IEZCT+jJZL5tdEzW9RYJqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BcURw0yRPXq03UyUT+PTOkJjrk5krYOUFYK20pSIPyOnnXOg/7Af4ujBjYs6TnV12dWXOyrfTgTsJt2AFAfaQ1yCZPKTGAzElmeDAuh1QVps53FUE9/D0dOr/4d15yp7iDZCPwhreNQvubmRAxYjQKVkiEUR/YfnEMvIhd5vDms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C7WpFdmU; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C7WpFdmU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUO/TLkTEHDKXvKhH/wqnIVB5d088lZNFWyoZ3a0jYRbH2msnN2mQKNLwL8DDJ3VciqvMsVIDWCLoRAoyksHuZUqmO8+dR9ZpQFprxn90tP1LvBV//YFLWJiJeYT5PtNtUxs3WvhoL5kKtSwpMZ9xsLJ4SoS67wEP+tWeVYuOR/vVLE9BIIdS3iIUVyY+FEJ/buSlPbx6s9J9YXd/0yYsB9lRSbST0CpiBweASUVLxGO5gTNAFQ/mUkkNYrSnTB86fLdj74zQoIEzS+eiI6hb/PUFJ4yBo/aottPvg1WjgSCZP7wLEgd/c8ku1WD2c8d8i4HqA1Dq2iEhdj98KOXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJPkaxssBp9GbD4rr12J+iWQYyQr99eMgV8ao6pJJYA=;
 b=YgSmTcCb//n8G59Db4QV1PtTHmDGZ4wpViByrMbbrbZqVCJ9xQhUae3K73DAwCumunj9IQigDUAl4x37/3LOkj53xtsnHwu50f4aHYHBZg++swvw5984EWX2oqh0JNgdsostuetlRkfYpks8RzS93NUaiAflqh+9+ZBH6gPbMO9JBwlLR2jwImVc/xFFva142KGDALOj4q+D+y1JhnEmFv1U8cQ50RWCEOgJXeryECFox88n7dWti4mpQYZl8OzGHtZU53wxZk0QNp6bbYBGsTtOOl8s22pMuV69DC0mpTGyevn+BibrF15Wii88NECREw0iKCSMf4ODEcexJt0kOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJPkaxssBp9GbD4rr12J+iWQYyQr99eMgV8ao6pJJYA=;
 b=C7WpFdmU0fq/XdCS3YB0MpL3eggE2FkBmQ+LVwPJBoTKXutENAG3Kc/2xnHuXWNvV5ZuCv1q1RqneN31fXjGTh6Xx8YH0vM+DM+DC3G3UHsUw74CS13KzBpiaAenBFrmUOgEATPdfYEtfzjrsX681UWqKaaQysaD6Gp3krTLctwtJNfnto79ODRR+UvHBTJUIiQfdhBTxjZtBliz9GNxwitixxtP+eCTBJVxFzIVP9qS+g5t+u4Fre7MfAWRmZAQ6RaqyyGqzq+VIqgVlz3n5qkmjLNZA5llkL7OwU5E6fTV187DkoI42IJxsCwSFkHjRsJ1L4H/e5X7ZDLl2SK6mA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:22:52 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:22:52 +0000
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
Subject: [PATCH v14 07/16] cxl: Share HDM decoder register unpacking
Date: Thu,  1 Oct 2026 09:22:18 +0000
Message-ID: <20261001092227.3004747-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:303:8e::29) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 915e898f-5992-4f5b-b90c-08df1f9d918c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|6133799003|921020|3023799007|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	s7WW0gdVAeSHG4SatMV1Sn3maanZEm8V72YlqyrNitKG0ANdnPJHAO+wmaov1WciavCl+FsjUNTHHqemNkNnj+XuwBjrWw29/Pf+SFFerPWDwnjMOWfrDE64ttA8ZY1LkwZucX9l6JWroX7BxLFyvUvKgOR3lcQx0vcA0KdxWQV+97yC3CBnf6jYh/8vxsD8Max4Ux1ey0HVAQkgkwwKfF3UTAmLP8qCalOUWfzmUul3kfveyyEDT/EpCsangbUgQsPzMqNliPtl4SEm7Uj+0tRT9ek9nCjmyN1AkZm3npSgdim2lEtGWCl70pB1a8DS9pZcRrEbybi5VMh78OKH305ni1Xm6/xHXUaQ4JvYaU/gcsxGzQ8kXJ3nARpKqzGD103LVLc/ktbQ/ifeuFjxZ0DXypq/F+v5NHiFUliEKWF2dcxjwjklNtYU6zvIljc3bZGhfeiUDadXWQ9DCh1E29mHVtrEoDIhuX4Vq7KuOWVaorI5BH57i8+qOzcxVxE+YNqibnSGMAwzxyH2hMfjerPfymEik0YdSx1+TOez/JgbkI3FPw8QpKffihohSSAg1ZGiwr3SIEWg5bJxAAcDWANtRSW8a0r6sx/tckZ7ye0d8ppSqWFSgaf/fZuKiVgqSV5lZghuAf53LMO0EKrP8gsqWnDcUr9R0TneplA0elGmcTkq1XtHobvaF8gU6KBxrtPBsqJFsdt3yj2V0cHxew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(921020)(3023799007)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1aMJMMovbEM1LKpqr6pWcPuwDZDKdxtOfdK39MFd9ZmnDeavgE8pB7q4l2Kj?=
 =?us-ascii?Q?nC5Ila8GvJR6f6QAXzxQ+gl487gdr+kO6RFwGQ329qS5Ca7avyf9/JIZntG0?=
 =?us-ascii?Q?CnD0BZgCzJ5Ns4ysTAZw9dAo5JPLbVF4AHAvfVXsBDCNBYvsBvaYfiJ93uDC?=
 =?us-ascii?Q?AJmWxH7iWBh16PenfeYmJJG5KJ4HqmB/RAcf+LEANe5T/E93tVXbgXmbBAEu?=
 =?us-ascii?Q?KvSEW6whW3X+1sEfCs5RAx77lr7FAg80fB9WkwHHMWEMazkAieYjT6cTwKEg?=
 =?us-ascii?Q?yk7dKZtph9TiukvcgjSPsCz244GMmGF4CNnduiTnJIspxPRieAb8CxhAL0mw?=
 =?us-ascii?Q?/51j3WpWYKW7IwO5ArTrDUQFivv/pq6OA1no9QvEOKUbKNSvlff43Kj+x3eP?=
 =?us-ascii?Q?ccMK8135AuIeTOipFXGEw9cQ3r+N+O0P/qJTIcplBQON7+XvNJ6FxB70omvL?=
 =?us-ascii?Q?Hn1L+EeSRtpj8Ng73uFZLSAnI93h8AEF1gvw4Tn+A9+J90nrzaT8RHCFo7+G?=
 =?us-ascii?Q?uGuiFg7yjIVDT7XVDdllVaf+WHsNNOgpXp/rf57BUaGfjTqiQcKXlwcw9O7G?=
 =?us-ascii?Q?cuqZ73uzeAekSdXjJmem8M7kou9T5FI/QWLykQoN2htCPnt5B8cJJcnjAflE?=
 =?us-ascii?Q?c1u1RkvzCUg3AgkzoDhOidWY3I+YKbkfsnTE1Or+1IlT2OKxlEvj/tpZZ2ch?=
 =?us-ascii?Q?Q9U16QLJ0tIDCHsabr4GGa4wW2AUADcDR02P1LTl4z3YjagprM/GpyR1tRfT?=
 =?us-ascii?Q?gWKjOSulmfV6u1RRRpfvIolzvsA1WXrEpMG2FjK+15RznDQk2AQgRAHiobsg?=
 =?us-ascii?Q?Z0h5oOrUCprnvUnXlFm2IEycTtD6r50Ta6e3n28P1TfV/6bo1YI1X/BRLCT4?=
 =?us-ascii?Q?aM4727IkEmTcb+cQM63pk8swBo4wVxKpI2rQO1kodaJsLmI104NNLCM76TDa?=
 =?us-ascii?Q?pWu6DMAXLTqSuUG3ROEl8/CKRkz7q14rxco8AKj9UCacJEc/4L8eAXp+UH0n?=
 =?us-ascii?Q?667+gMEdWpl/E/hUaOauOlt0aWacuVnS1ktfztVHGVeGkHIFOKX9Lo9el1Ea?=
 =?us-ascii?Q?CqFcUUUkJ2seeOrpzWM9TNaK16kLCJHC7r82Xq2A+3P4RJGMGyHd7MyRGPMG?=
 =?us-ascii?Q?dzR/UO7vEkRDEMr9QiNOMBylDuR1kddVyoWLWhriCPvLDKO+0RBgCOMKkZvZ?=
 =?us-ascii?Q?43vLNmcV6BgVEih7/0FTu6QUvCMEAvWLuKkROQaAetyMsBeGg2D+tABmSAqT?=
 =?us-ascii?Q?J9o+DznMlR9e2x1FvIzv3pJk+tDwBa5UnO3vqHKrkpgFmtTTL+tuyxFxJyH9?=
 =?us-ascii?Q?rCwGG45VgorFauHDWAwC9NyqcCqPaYCTdt0MGeTmeTlxjhblPqwr+GhKt7MT?=
 =?us-ascii?Q?hNW6SBamJLM4k6b0OsxQmmAtk6yk4xjchMgbDPDajsB3UFkNm4+Yu32S4HnM?=
 =?us-ascii?Q?aFxmxuTOM8+diuKJ7oYZ9u9HMdTKWx8d6zqfB8RunloFf/rSbnwGuKv79OjE?=
 =?us-ascii?Q?EIW03TNp/mJJg/QCtbrDSYeEA+WoY/l7TDy/bqDto9kRBhtjby4Leq0fjBjZ?=
 =?us-ascii?Q?y3MBu8Qd13rxIJrRiFLTACq/8KH1aGxvF9HwZWngTsScs14AL/Pm/rTqznnx?=
 =?us-ascii?Q?LGIAO+bygl7tfNojvoHWKImV3t6M0+JelBs7H8yaQOB4fd5fsefHNdfbgsh6?=
 =?us-ascii?Q?gn1EzOtp9It07Aw/2q5WRRfF/kbzZCE55Ovmhav8acknQqEL0oX/1ZNduywt?=
 =?us-ascii?Q?jO+RZCouRQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915e898f-5992-4f5b-b90c-08df1f9d918c
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:22:52.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /18FnZdJUUiDVbRjbgsO8YDBbMLfZWfbMwSYLIWsXtF+md0NQ6i9SF+0omfasEecw0VKAm9GAU+1+cjKJF0Lqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

Factor HDM register parsing into cxl_hdm_unpack_decoder(). Validate the
range and interleave parameters in locals before publishing the complete
settings, including enable/lock flags and the target-or-skip register
value.

Use the unpacked settings in init_hdm_decoder(), retaining the target-list
union and passing endpoint skip state to the existing DPA reservation
helper.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/core.h     |  4 +++
 drivers/cxl/core/hdm.c      | 68 +++++++++++--------------------------
 drivers/cxl/core/resource.c | 57 +++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 48 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a3fddb2bed63..a0bef246121d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -142,6 +142,10 @@ extern struct cxl_rwsem cxl_rwsem;
 void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
 int cxld_await_commit(void __iomem *hdm, int id);
 
+int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size,
+			   u64 target_or_skip_reg_val);
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 629e3420ad0b..b6a8fe83d336 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -932,8 +932,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
-	u64 size, base, skip, dpa_size, lo, hi;
-	bool committed;
+	struct cxl_decoder_settings settings;
+	u64 size, base, skip, dpa_size, lo, hi, target_or_skip_reg_val;
 	u32 remainder;
 	int i, rc;
 	u32 ctrl;
@@ -953,35 +953,28 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
 	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
 	size = (hi << 32) + lo;
-	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+	hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
+	target_or_skip_reg_val = (hi << 32) + lo;
+	rc = cxl_hdm_unpack_decoder(&settings, which, ctrl, base, size,
+				    target_or_skip_reg_val);
+	if (rc) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
+			 port->id, cxld->config.id, ctrl, rc);
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
-			 port->id, cxld->config.id);
-		return -ENXIO;
-	}
+	cxld->config = settings.config;
+	size = range_len(&cxld->config.hpa_range);
 
 	if (info)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-	cxld->config.hpa_range = (struct range) {
-		.start = base,
-		.end = base + size - 1,
-	};
 
 	/* decoders are enabled if committed */
-	if (committed) {
-		cxld->config.flags |= CXL_DECODER_F_ENABLE;
-		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
-			cxld->config.flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
-			cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
-		else
-			cxld->config.target_type = CXL_DECODER_DEVMEM;
-
+	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->config.id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -1015,38 +1008,19 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
 	}
-	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			  &cxld->config.interleave_ways);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
-			 port->id, cxld->config.id, ctrl);
-		return rc;
-	}
-	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				 &cxld->config.interleave_granularity);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
-			 port->id, cxld->config.id, ctrl);
-		return rc;
-	}
-
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
 		port->id, cxld->config.id, cxld->config.hpa_range.start, cxld->config.hpa_range.end,
 		cxld->config.interleave_ways, cxld->config.interleave_granularity);
 
 	if (!cxled) {
-		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
-		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
-		target_list.value = (hi << 32) + lo;
+		target_list.value = settings.target_or_skip_reg_val;
 		for (i = 0; i < cxld->config.interleave_ways; i++)
 			cxld->target_map[i] = target_list.target_id[i];
 
 		return 0;
 	}
 
-	if (!committed)
+	if (!(cxld->config.flags & CXL_DECODER_F_ENABLE))
 		return 0;
 
 	dpa_size = div_u64_rem(size, cxld->config.interleave_ways, &remainder);
@@ -1056,9 +1030,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			port->id, cxld->config.id, size, cxld->config.interleave_ways);
 		return -ENXIO;
 	}
-	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
-	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
-	skip = (hi << 32) + lo;
+	skip = settings.target_or_skip_reg_val;
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
 	if (rc) {
 		dev_err(&port->dev,
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index ff027cb89e57..8dfeb12de8c9 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -104,3 +104,60 @@ void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
 	setup_hw_decoder(hdm, settings);
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start, "cxl_core");
+
+int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size,
+			   u64 target_or_skip_reg_val)
+{
+	bool committed = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+	enum cxl_decoder_type target_type = 0;
+	int interleave_granularity;
+	int interleave_ways;
+	unsigned long flags = 0;
+	struct range hpa_range;
+	int rc;
+
+	if (!committed)
+		size = 0;
+	if (base == U64_MAX || size == U64_MAX)
+		return -ENXIO;
+
+	hpa_range = (struct range) {
+		.start = base,
+		.end = base + size - 1,
+	};
+
+	if (committed) {
+		flags |= CXL_DECODER_F_ENABLE;
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+			flags |= CXL_DECODER_F_LOCK;
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
+			target_type = CXL_DECODER_HOSTONLYMEM;
+		else
+			target_type = CXL_DECODER_DEVMEM;
+	}
+
+	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			 &interleave_ways);
+	if (rc)
+		return rc;
+	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
+				&interleave_granularity);
+	if (rc)
+		return rc;
+
+	*settings = (struct cxl_decoder_settings) {
+		.config = {
+			.id = id,
+			.hpa_range = hpa_range,
+			.interleave_ways = interleave_ways,
+			.interleave_granularity = interleave_granularity,
+			.target_type = target_type,
+			.flags = flags,
+		},
+		.target_or_skip_reg_val = target_or_skip_reg_val,
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
-- 
2.43.0

