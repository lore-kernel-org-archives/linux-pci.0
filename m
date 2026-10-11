Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A02F8E90;
	Sun, 11 Oct 2026 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684916; cv=fail; b=j5IntCfEO9B+8j+sAqOCkBnvWK43ub+f31jdPX9ESww1UNEA+mxprKtCtwcH7L1EQkbWEmzGIPigZy6biHPWLf8Hu3cq5DrIXJ6jgTxWn7Hd2txChJKuRBzmAAw8oCxIsYF7EPfVZf5GV74JzsqLvHI4NruSVXzob25uy1eKQTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684916; c=relaxed/simple;
	bh=pufw4oxGC9SKLXeo1+72dlNh7jkkq077PumOcSaTCEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ehhLPZue25HqdyI/xqD3rdMPT0IVNX6eAVnAjmOxrv9An7er6J6kOzEqHCjQvBkNWk0pcif1gH0hahUOFw8IWD2HGTGGNSoWriWifeHxX8XTQcEg9xae8NOLpt6wOeJWhGgA8pi6zt+9dBk/vD15ggWD2xWIn087P90LPBqPzfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RokwQy2k; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RokwQy2k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GokUX7gCnFxx+pM7DuDhlB0+68+n0nZ+/QGGR5DSatdAXBN5hg0knnoxJxyPltpR4u5xPOJLXqNUm0JJM9Cxelx70Rl2w3L8vZcHgZe95O7U8/UTqxbY4EG+Mq7T86L0i+4vpc3K9erPXaHZ14j+edMSKnkQQaK57j6cnwH5qq/30ZUQuPEcKzx/9weG/AQoXQ5QCvo0R9v1n5k315JzvqJ83nv04o900JOwCvlUz3Av0OpYOB5sxzgfp+SEB7GC+vhlzlQ5dZIycyYouGSpL9OSxaoJL2A8S/xmtqvKTGH/AXReFWQy2kMoA5TJjmgdG+21k4Rc8O1oRvMe2LVOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWD98FxksKG+uNzz1T0kbP3D2mfbVf9saFb0Onhvw4E=;
 b=MGThAxkjSdcA1kpHWKcF9NoHxML/KjRwYv7PIjdcaLkTXYRmQykO65zr1wmCXfaxKGS8cnQMnWHri+EmBTm4QO7aNYq1X9v+eNalU/KdCStRfnDg3gOPsx4dJ01R4yMLY0rSUsixL1TO0hWvLuRtFgBQbndmSAwcqneqeB83cRAN5Hdqogya8IjzvOJUUnbOUCWYZz7sRGe69SibN/8JCU9t5oKMD91JqsQVXFYPyp6/ulBmh0+1BE+wF8h+T/iGbR6dK0zxgIEU7zpoa2qELcTpbtHeW2JFJzZ3TnDDavrBLkN6LW6z77Q6u0nAh27VSbOBHAX9/CREaoD3//ul6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWD98FxksKG+uNzz1T0kbP3D2mfbVf9saFb0Onhvw4E=;
 b=RokwQy2kr/mfrH4BNQJzPyzNvOcxWlZPx8KEM8wgYIyi2o3NKG08n19DmL6IcCbNH2/4QqPUs8BbTjhgmDtHZX1QLylZR5viYOHSfr+F7dDhyhN5m5U15sX1MliVBnD8zTvmGkWbjhuzi1qekLjmZmT9ztaP6kn3u006fj171BTCY0vv2B/1zpvkWDUnqHXfCzVg2NN1G0wmu3r3RxnixbRIT5bZimglt/yV/OqQU8Gm4/avoiDt7gLgGDojf8LagCpwV+Fjw5m5DtrS6/kt/5MzmdhfqdO3xWlCRVqeG7MyRH/LMF78fcIIveHffp3rkma4kk9ADbEAhXsxiNmYPw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:15:02 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:15:02 +0000
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
Subject: [PATCH v15 13/16] PCI/CXL: Restore CXL state after PCI reset
Date: Sun, 11 Oct 2026 02:14:19 +0000
Message-ID: <20261011021422.3428136-14-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::25) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cf1de3-aeb9-4fa7-dc1e-08df273d7560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|3023799007|261009223027099003|921020|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6142OFPCcoeV+cWfNm/StzrrBvlpHrlAQkmYQ3R+fhfq0mHXXJE+qgBrwUmTFHLXctx2FGVpM0fWtnNqbMR0e/RPj0EquwIMCdWHWpQ8een2nZDJvk7F+ClkGXHQpuzupsDQvY9O9TTK1bdwxmOAvwOQc7H1BkJv0kQxob3E6NfZDwzCRfIWNGEpVCDJNZ5Y0SdZdbV3B+OZ+qI+FRtWH3fafbXnd9srkwq+Ivy8d5N4aM+CA5hf3dtr+9e0CKfEwUPlfSLaSqqp2rG0PWT/pMivPM2ilSO2+P0Kgh/GsS8fSmXOSz4prtYv0Evmt4JwnpoWGmNZOB+kM3DozHst8MKqedfDajGZNVv/pM81fLYOe88FgdC/NNl/TCr3+kN74EZBDbdwnFC37bgzklZjMys/x9+B6xh/72SUn+LxTU8im0Kane80SLzByzjuHgTdA6Mc7l5F7tNMLfBBJj59+A9SRN5DboKSE5tz0D/RKwQ+lVJkKb3LYxjW9NajDVOn6hJ6eNEZo4sCer7wDo4KU88GpR0N+5P+uvmu2FuF7gB+NJPpt0unf894XfiuonIi2lh9g1MKRIfTD1scpbpP90Vw337f9dHf84JYkAtLsI1TAjjYf3g0n1gRN3mRv3L0v+q4FnLDT2M070ZVfcaQaZCWzv6vhgT3jnvFS6U6IFHVcwF3ooYmleWoKMFWnuSQUtYw/AGubd/HKhCDFL7Frg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(3023799007)(261009223027099003)(921020)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DlLHXJ4wR1AkQ2Aomf2nCJFSZLnjhPZ6LqM+TIX03p372lyMk8HoHlRWoc0e?=
 =?us-ascii?Q?wfi7XXuSRuBvitSD6m8EUs037HhnSHghacueW/a/zJRIpf6omAUnLl/tjE2S?=
 =?us-ascii?Q?bh6zDpj30EadIC7Wg8I+zf++yZvpKw1JTGkuSb0F4z+dev8dN6Lnfvqu8/gl?=
 =?us-ascii?Q?XcE8UVsJ673D9//Sgi9iKj1HBplNHI8ERIIUJJZg5bB87xkMz0Y53ShmQ7CG?=
 =?us-ascii?Q?sJiN7Y+Ifc/9wwjHpC7HzO7FJypljxVvTUY0jYHiR5L9SOJmASy7HoTQke1x?=
 =?us-ascii?Q?b1vFQz8DkSrDKddEXB5ewe5m+P2XGjLxaBWPlFCx/yQxUHShPRq/Ld6An2WD?=
 =?us-ascii?Q?lPvScfnvVlFguL4JQln743oHryTOcHopvIIh3oIG1vnS1iZWOdrWlHCRTfon?=
 =?us-ascii?Q?8TE+hTZj8iQrw+EavJ9dQeJ5J7o4lRRWvLx54grCe46QCT3wGYH5u8PqeI3t?=
 =?us-ascii?Q?SaYOX68LpAbO11qE5tvqDRatR+/wINDFghu5SnqssuE1I2Msy6Qbtuwcos26?=
 =?us-ascii?Q?hyoUffbAQbUYOZz/3aPnbZMZPlURHfbjX/oNGvFSvYm1IMXeDnFwc5Qsor5A?=
 =?us-ascii?Q?72iGY0I4b/oQWjoeMjdTjDiWt3Wt3eK9uDkI2vDRX8I8/B3S1zv1GCnKk2ep?=
 =?us-ascii?Q?UbPlX1/fuGcDcgw8XhTjrYuVfm3PBEyRzeGAjmWwq0Oz5t3CGcTzbinic1KA?=
 =?us-ascii?Q?EDpUZXRzCxvywy4O08gXd8Se3lZmT86HrHBVrxsvczEeL+PQTsqERdMrXFdq?=
 =?us-ascii?Q?cIGDhMTghw5zeqHbdQ6YbXGp01vT6IMwDulYh0Z/Oaa34cnb8xVYucgp7boJ?=
 =?us-ascii?Q?FXmE5hy9Gv+iHvPPSOCIQo28bJnakqQTIZd6ztIegLrJMw9CjH84bcQR/+7a?=
 =?us-ascii?Q?F2iur+rabejMq2m1DHCaQTgFv2+Is8ZwPubNr+/fB3FwSDta7vqdOIc1uiVk?=
 =?us-ascii?Q?TLiATGx7X/7Zzl4Ayqpygwc1Z2eEmgM1tgdllsaK0t976eOfdE4kELc7ZEuC?=
 =?us-ascii?Q?2lB9R8mYCmKI/pt9KrT8KmlnkDYFisTS4QnVUz2lkO4Tc3rrCehfw8DF4JBZ?=
 =?us-ascii?Q?SEXb8wFcob8Uux8/p1A9i8dK1E9vNFDiXNSYhBgomCVpcmP3HQAe6hzxNTga?=
 =?us-ascii?Q?5GfKYgLNuCHeLNp04GbCZ8y8w+9+EqX3mEsDFptRvhgHScnPZCihvbgdMyRH?=
 =?us-ascii?Q?aExCrF77IUOhNsQlnQQ46QMtTVpg+2k5WLQNPplBoC54tHBBPHW5OmrItaAj?=
 =?us-ascii?Q?9lV7Z/V8v92CBlOAuEuSWHMyOhkkhLKnfXSbuk68zfv7CkjqlHTCcOzUi4Mn?=
 =?us-ascii?Q?Qvq4qppqlfiWhCPAnqmKfz63hZChYQQkpu9OTOgkvgXo+S+1vCn7x95c7Iu6?=
 =?us-ascii?Q?G49U4YV9t5VqmrdTjR41W9B8HF4lYlUQq88YsgN/YkKB1PXGnc8MKn9hp0wQ?=
 =?us-ascii?Q?SBrOjcqkGGYIlMrhjdkhRxTCmO27eRSzfpyn5aHlj4hMFJF5WBnCvhI2Bjxc?=
 =?us-ascii?Q?X/lRHgyF97hl3smO4KcwEk/5wgiyzFDt0EQsQJiQlYqHJnWR92zWdcy/f7Yt?=
 =?us-ascii?Q?LmvOt10rkRU6o2qrsIoY2pHUcRIOZ2pJGoxFE4lzhEgnB6qSzSQRIvEJEUKB?=
 =?us-ascii?Q?PyG9FSDRt0G18F23EjOIAxbLbGo/q6biM6wSqiXcDMdqN8MFWTqDhvSn9qX9?=
 =?us-ascii?Q?F+rh835T9b8XfA47qG4NPSB7chKWzthSqWMB7nZswblr62qzwsv/qxxv24Vi?=
 =?us-ascii?Q?ab/ClJ1/+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cf1de3-aeb9-4fa7-dc1e-08df273d7560
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:15:02.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9wjggRYKbYGslfvtnVkRXJrn7rhTFGibk3HtikbIoKVbMyHxG2F9Obve4rCuhAXZEfums3mGqQY6XD7+8F6Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

Restore the PCI configuration needed for HDM access, followed by cached
HDM decoder and CXL Device DVSEC state. Recommit a cleared locked decoder
before restoring its lock, but leave surviving locked state unchanged.

Stop at the first restoration failure and preserve a disabled PCI command
snapshot. Keep IOMMU exclusion active through restoration and post-reset
cache invalidation.

Program the decoders from built-in CXL code that takes only a mapped
register block, and keep PCI state handling in drivers/pci/cxl.c.

The restore helper structure and diagnostics follow Dave Jiang's
reference implementation on his cxl-type2-reset branch.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=81fff5893a3140361cac625b09ada798afb92e03
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM
---
 drivers/cxl/core/hdm_regs.c | 180 ++++++++++++++++++++++++++++++++++++
 drivers/pci/cxl.c           | 176 +++++++++++++++++++++++++++++++++--
 include/cxl/hdm.h           |   2 +
 3 files changed, 351 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
index f0b360867655..cef5e9949d2c 100644
--- a/drivers/cxl/core/hdm_regs.c
+++ b/drivers/cxl/core/hdm_regs.c
@@ -73,6 +73,26 @@ int cxld_await_commit(void __iomem *hdm, int id)
 }
 EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
 
+static int cxld_await_uncommit(void __iomem *hdm, int id)
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
+		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
 static u32 cxl_hdm_write_range(void __iomem *hdm,
 			       const struct cxl_decoder_config *config)
 {
@@ -273,3 +293,163 @@ int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
 
 	return 0;
 }
+
+static int cxl_hdm_decoder_uncommit(struct device *dev, void __iomem *hdm,
+				    int id, bool *retained)
+{
+	u32 ctrl;
+	int rc;
+
+	*retained = false;
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (ctrl == U32_MAX)
+		return -EIO;
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR) {
+		dev_err(dev, "CXL HDM decoder %d has commit error set\n", id);
+		return -EIO;
+	}
+
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
+		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+			*retained = true;
+			return 0;
+		}
+
+		dev_err(dev, "CXL HDM decoder %d is locked and uncommitted\n",
+			id);
+		return -EIO;
+	}
+
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		return 0;
+
+	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	rc = cxld_await_uncommit(hdm, id);
+	if (rc)
+		dev_err(dev, "CXL HDM decoder %d uncommit failed: %d\n", id, rc);
+
+	return rc;
+}
+
+static bool
+cxl_hdm_decoder_settings_match(const struct cxl_endpoint_decoder_settings *saved,
+			       const struct cxl_endpoint_decoder_settings *active)
+{
+	const struct cxl_decoder_config *a = &saved->config;
+	const struct cxl_decoder_config *b = &active->config;
+
+	return a->id == b->id &&
+	       a->hpa_range.start == b->hpa_range.start &&
+	       a->hpa_range.end == b->hpa_range.end &&
+	       a->interleave_ways == b->interleave_ways &&
+	       a->interleave_granularity == b->interleave_granularity &&
+	       a->target_type == b->target_type &&
+	       (a->flags & CXL_DECODER_F_RESET_MASK) ==
+		(b->flags & CXL_DECODER_F_RESET_MASK) &&
+	       saved->skip == active->skip;
+}
+
+static int
+cxl_hdm_restore_decoder(struct device *dev, void __iomem *hdm,
+			const struct cxl_endpoint_decoder_settings *settings)
+{
+	const struct cxl_decoder_config *config = &settings->config;
+	bool retained;
+	u32 ctrl;
+	int rc;
+
+	rc = cxl_hdm_decoder_uncommit(dev, hdm, config->id, &retained);
+	if (rc)
+		return rc;
+
+	if (retained) {
+		struct cxl_endpoint_decoder_settings active;
+
+		rc = cxl_hdm_read_decoder_settings(dev, &active, hdm, config->id);
+		if (rc) {
+			dev_err(dev,
+				"CXL HDM decoder %d has invalid configuration: %d\n",
+				config->id, rc);
+			return rc;
+		}
+		if (!cxl_hdm_decoder_settings_match(settings, &active)) {
+			dev_err(dev,
+				"CXL HDM decoder %d retained unexpected locked state\n",
+				config->id);
+			return -EIO;
+		}
+		return 0;
+	}
+
+	if (!(config->flags & CXL_DECODER_F_ENABLE))
+		return 0;
+
+	cxl_commit_start_endpoint(settings, hdm);
+	rc = cxld_await_commit(hdm, config->id);
+	if (rc) {
+		dev_err(dev, "CXL HDM decoder %d restore failed: %d\n",
+			config->id, rc);
+		return rc;
+	}
+
+	if (!(config->flags & CXL_DECODER_F_LOCK))
+		return 0;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+	if (ctrl == U32_MAX)
+		return -EIO;
+	ctrl |= CXL_HDM_DECODER0_CTRL_LOCK;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+	if (ctrl == U32_MAX ||
+	    !(ctrl & CXL_HDM_DECODER0_CTRL_LOCK)) {
+		dev_err(dev, "CXL HDM decoder %d failed to restore lock\n",
+			config->id);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_hdm_restore_state() - reprogram endpoint HDM decoders from a snapshot
+ * @dev: device for error messages
+ * @hdm: mapped HDM decoder capability
+ * @snapshot: state from cxl_hdm_cache_snapshot()
+ *
+ * Restore global control, then recommit each enabled decoder in order. Leave
+ * a locked decoder that kept its programming across the reset unchanged,
+ * after checking that it still matches @snapshot.
+ *
+ * Return: 0 on success, or the first failure.
+ */
+int cxl_hdm_restore_state(struct device *dev, void __iomem *hdm,
+			  const struct cxl_hdm_info *snapshot)
+{
+	int count;
+	int rc;
+
+	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (count != snapshot->decoder_count) {
+		dev_err(dev, "CXL HDM decoder count changed from %d to %d\n",
+			snapshot->decoder_count, count);
+		return -ENXIO;
+	}
+
+	/* Restore global HDM control before committing individual decoders. */
+	writel(snapshot->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	for (int i = 0; i < snapshot->decoder_count; i++) {
+		rc = cxl_hdm_restore_decoder(dev, hdm, &snapshot->settings[i]);
+		if (rc)
+			return rc;
+	}
+
+	/* Flush posted HDM writes before restoring protocol enables. */
+	readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	return 0;
+}
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index eccdb57945fe..4c6b712ed4fa 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 /*
- * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
- * memory device at enumeration, so it can be restored after a reset without
- * a CXL driver, and implement CXL Device Reset. HDM register formats and
+ * CXL reset support in the PCI core: cache the HDM decoder state of a CXL
+ * memory device at enumeration, implement CXL Device Reset, and restore the
+ * cached state afterwards without a CXL driver. HDM register formats and
  * programming live in drivers/cxl.
  */
 #include <linux/bitfield.h>
@@ -16,6 +16,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/memregion.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -227,6 +228,150 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 	cxl_hdm_cache_release(&pdev->hdm);
 }
 
+static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
+						 int bar,
+						 resource_size_t offset,
+						 resource_size_t size)
+{
+	struct resource *res;
+	resource_size_t hdm_start;
+	void __iomem *hdm;
+
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size)
+		return IOMEM_ERR_PTR(-EINVAL);
+	if (!cxl_pci_bar_assigned(pdev, bar))
+		return IOMEM_ERR_PTR(-ENODEV);
+
+	res = &pdev->resource[bar];
+	if (offset > resource_size(res) || size > resource_size(res) - offset)
+		return IOMEM_ERR_PTR(-ENODEV);
+	if (check_add_overflow(res->start, offset, &hdm_start))
+		return IOMEM_ERR_PTR(-EOVERFLOW);
+
+	hdm = ioremap(hdm_start, size);
+	if (!hdm) {
+		pci_err(pdev, "failed to remap CXL HDM decoder registers\n");
+		return IOMEM_ERR_PTR(-ENOMEM);
+	}
+
+	return hdm;
+}
+
+static void cxl_restore_pci_state_for_hdm_restore(struct pci_dev *pdev,
+						  u16 *command)
+{
+	u32 saved_config = pdev->saved_config_space[PCI_COMMAND / 4];
+	u32 restore_config;
+
+	device_lock_assert(&pdev->dev);
+	*command = saved_config & 0xffff;
+
+	/*
+	 * Restore BARs and the related PCI state needed to reach HDM MMIO.
+	 * Temporarily alter the saved command value so that
+	 * pci_restore_state() enables MSE but cannot enable BME or INTx before
+	 * CXL state restoration completes. Preserve the original saved value
+	 * for the outer PCI reset path.
+	 */
+	restore_config = saved_config | PCI_COMMAND_MEMORY |
+			 PCI_COMMAND_INTX_DISABLE;
+	restore_config &= ~PCI_COMMAND_MASTER;
+
+	pdev->saved_config_space[PCI_COMMAND / 4] = restore_config;
+	pci_restore_state(pdev);
+	pdev->saved_config_space[PCI_COMMAND / 4] = saved_config;
+}
+
+static int cxl_restore_dvsec_ctrl(struct pci_dev *pdev,
+				  const struct cxl_hdm_info *snapshot)
+{
+	int rc;
+
+	if (!snapshot->dvsec_ctrl_valid) {
+		pci_err(pdev, "CXL DVSEC control snapshot is invalid\n");
+		return -ENXIO;
+	}
+
+	rc = pci_write_config_word(pdev, snapshot->dvsec + PCI_DVSEC_CXL_CTRL,
+				   snapshot->dvsec_ctrl);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		pci_err(pdev, "failed to restore CXL DVSEC control: %d\n", rc);
+	}
+
+	return rc;
+}
+
+static int cxl_restore_state(struct pci_dev *pdev,
+			     const struct cxl_hdm_info *snapshot)
+{
+	void __iomem *hdm;
+	int rc;
+
+	hdm = cxl_pci_hdm_ioremap_current(pdev, snapshot->hdm_bar,
+					  snapshot->hdm_offset,
+					  snapshot->hdm_size);
+	if (IS_ERR(hdm)) {
+		pci_err(pdev, "failed to map CXL HDM state for restore: %ld\n",
+			PTR_ERR(hdm));
+		return PTR_ERR(hdm);
+	}
+
+	rc = cxl_hdm_restore_state(&pdev->dev, hdm, snapshot);
+	iounmap(hdm);
+	if (rc)
+		return rc;
+
+	return cxl_restore_dvsec_ctrl(pdev, snapshot);
+}
+
+static void cxl_reset_save_disabled_state(struct pci_dev *pdev)
+{
+	u32 *saved_command = &pdev->saved_config_space[PCI_COMMAND / 4];
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+	if (rc)
+		pci_err(pdev,
+			"failed to disable device after CXL reset failure: %d\n",
+			pcibios_err_to_errno(rc));
+
+	/* Preserve the pre-reset snapshot if PCI state has not been restored. */
+	if (!pdev->state_saved) {
+		rc = pci_save_state(pdev);
+		if (rc)
+			pci_err(pdev,
+				"failed to save disabled state after CXL reset failure: %d\n",
+				rc);
+	}
+
+	/* Ensure the outer PCI restore cannot re-enable MSE or BME. */
+	*saved_command &= GENMASK(31, 16);
+	*saved_command |= PCI_COMMAND_INTX_DISABLE;
+}
+
+static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
+{
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		pci_err(pdev, "failed to restore PCI command state: %d\n", rc);
+		cxl_reset_save_disabled_state(pdev);
+		return rc;
+	}
+
+	rc = pci_save_state(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to save restored state after CXL reset: %d\n",
+			rc);
+		cxl_reset_save_disabled_state(pdev);
+	}
+
+	return rc;
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
@@ -394,7 +539,9 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
 }
 
 static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
-			      struct cxl_hdm_quiesce *q)
+			      const struct cxl_hdm_info *snapshot,
+			      struct cxl_hdm_quiesce *q,
+			      u16 *command)
 {
 	int rc, rc2;
 
@@ -419,8 +566,15 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
 		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
 	rc = rc ?: rc2;
 
+	if (!rc) {
+		cxl_restore_pci_state_for_hdm_restore(pdev, command);
+		rc = cxl_restore_state(pdev, snapshot);
+	}
+
 	rc2 = cxl_hdm_quiesce_flush(q);
 	rc = rc ?: rc2;
+	if (rc)
+		cxl_reset_save_disabled_state(pdev);
 
 	pci_dev_reset_iommu_done(pdev);
 	return rc;
@@ -431,7 +585,7 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
 {
 	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
 	struct cxl_hdm_quiesce q;
-	u16 saved_ctrl2;
+	u16 command, saved_ctrl2;
 	int rc, rc2;
 
 	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
@@ -455,11 +609,19 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
 
 	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
 	if (!rc)
-		rc = __cxl_reset_execute(pdev, dvsec, cap, &q);
+		rc = __cxl_reset_execute(pdev, dvsec, cap, snapshot, &q,
+					 &command);
 	/* Restore cache policy after any attempt to disable caching. */
 	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
 	cxl_hdm_quiesce_destroy(&q);
-	return rc ?: rc2;
+	if (rc)
+		return rc;
+	if (rc2) {
+		cxl_reset_save_disabled_state(pdev);
+		return rc2;
+	}
+
+	return cxl_reset_save_restored_state(pdev, command);
 }
 
 static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index f6446a2a7fcd..445093cf0452 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -52,6 +52,8 @@ int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
 				 resource_size_t size);
 int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
 		       struct cxl_hdm_info *info);
+int cxl_hdm_restore_state(struct device *dev, void __iomem *hdm,
+			  const struct cxl_hdm_info *snapshot);
 bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot);
 void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
 			   struct cxl_hdm_info *info);
-- 
2.43.0

