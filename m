Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228632F617C;
	Sun, 11 Oct 2026 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684913; cv=fail; b=MUrPZhRWBS9TGcW3Z4K0bXnEU4VEzr3Bnvc5GOmItn3I8Z+AXra7LiEb/z/XYatUXIwyvXXZJP7M9239jnxahwsPW8tLrBpooGmnK+ByIgINVmdNzT2XRN7M7K4tMrVlNuv1UbvlzW5gBXdYrNzUCaWCC/vnRV6Zq2kv6O+nKDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684913; c=relaxed/simple;
	bh=PNgNLRrvPMPamD7pnTE5qAK7wYOOQm+olSrK2/7eEh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FjAzBox/DhZqcJ9uXpspCXRU2mlZVCmOjI1vLYNwnnYpfhEGyjJ5qOX6YzBKhmfZwBvcRuFtQvgYn8HM5MZxSj82q5S7joF+aVqw0StyNX3l4GVzMFiCi2+gTEy4DPFSTHLg+xIgMqFza/fnaQfHuLHRFtEbwZi3w9i0UbJc4wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=imJNY7qZ; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="imJNY7qZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVfgIb4tqoYNpkT0dU1eTyGGsrWppfyRt0JXjN+teNxJYQ7clgOYALxvBiutSXm1S4epRKvvukAKkhvWTYU7swf4+bM1mCDOARYYqLSOpKW5byu6RIANgf4NkuNwDMB4Jz68PmgXCukRO52PUCw86T7/xgORITrABm/4JgZeMVt0tPjZkGrg2zLD9sK/bFxxrfpVsymCj1Jbg+nHivMwPmNUXSh+0Yd9uszCHSePG6VCgVKbwasIEx3+lLBW5ytOBwWv20u8U5Ec841mJrSjLdN4EtTi2st/zSs2IfZRfGksjHG18qyiPKvFoIKqjOXqehjwazLw6V0Vly/3afsV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYIvgLVkmO/kuNC1+LDJUL+RsfuBHD3RBn0gx0wIppc=;
 b=reXcv5EFZuGudC/CFdXVST/p6mtRTPesZlIuhKnTBcEfTkthcUOnZzfl+xgg0t8y3bM+610Zm8dA3hAIqH000rJBbJIlXTd17bZpbnOFt4ChWOIjEUjXj9lJZdk4Vo4HVEi6iEGblogfQwWCJbGbxTpz1TtNyrXjfFfYRzZ6f2shHoJwNEfOobBS0hHVtpeBCBY1MkxHfwCgLYEcK8hjeEz2RVH4u/c36v2JvOpVWVCBIQeCCIaDEDDIhDO6cI3UwNYfYwkpgjVin54j6HbcK5tDYuWTSlgj3+iUgrP6kcD0Vig03jCNFHKdoynJIxyXFeld+eG1mSBN/vCzRnlNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYIvgLVkmO/kuNC1+LDJUL+RsfuBHD3RBn0gx0wIppc=;
 b=imJNY7qZlRi/yrtpz2HSjUS9iKFaJfsj5Xokr9PujyXOeSOQNCmonIwLYFT3WDe88f5Hmyi9148IAA2XoOMYJZLCLs+Dx+hK3s2UyfFpR3BA+vGaDAtvvmHbEAi+vu0NhOMHXWX1AmCeRfPOe5lO0grgi3m5g6J+e5JzdBWHNPpV905qcv2b4JHV5AUQBgrusntu7rCiSqqJgD0P5SLcDbBy22pKqUBWeHn4CvUsX8RKoAGbiQ9P0agqQGHWskCLI51rZYQYAaQc2n1Br5f3pBDBJ+ugIRs1GMq8W5rdt25IQXaU4diD0hltuG2zGydrEd/nKOGyUBOei6zIWgxBOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:14:57 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:14:57 +0000
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
Subject: [PATCH v15 11/16] cxl: Validate and synchronize HDM ranges around reset
Date: Sun, 11 Oct 2026 02:14:17 +0000
Message-ID: <20261011021422.3428136-12-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::23) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 6672779a-fc25-457a-8ccb-08df273d7263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|261009223027099003|921020|11063799006|5023799004|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	nVPXHlK/XI8Q3nMBcEZ09fnKi/SZw3ZaFNQtm/hhmSHwS7ws6cC9hjHRiDwOQI6IpF7jAH7w1jY90GcJ9jXzbD4WoZq5mCw9PcUNfprQOs8odHYK+LbriP6NhOqIYOpjtKblPjr9a1lFGnv35qLVJI+tT+6uHd0GqjdFmSTjayP8DaZuLdOqLpS+SrsuZEhDA50kJkpps1ZZAqXro9jDJ1oSU51lZuoO19p/OcOheTCLbUqqvQ8R9yQYMXAfBSkDa8MqTwnpJq9x1E1kFkAothr331dZc28Mpbhq47ANypRIz7FoxGUToKfJlSWuHbsbLfAOujjieUOPBhLppR+1te3k+giE7E70RSvSuZgZrpyvbtWMJ/e49IVW6/z9hnERVXIVLb25GgYLicc9epvSIuIWhcw2n7XiAFAyKxn+wNesNcGf15mfk0kaOdgAnwlS9pAV7AUM2Zgd5z9yK5cwkt2ELQdxvmJRm8D79i10q/X9Ge0O+6eKvaTq5xj6UQI1XGE8mYojshMH4he7B4t9mdyENY0Fq8bEOh68j2bGTcsUt8sedNy8uwnAfPXZtIEfkSt4yyN9ysuynGudlXlXa/ss08vmV82iNyN3LnFkxR1s6SqibeTw92nN1ohuYbadACA+LSHfHgBjAErcSSzjoaBgq1woMh7iwfyAWYBc+U47HlKz2vExOG04YZChbcp5OvJc9eEykca7yk7HnDFnCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(261009223027099003)(921020)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lq0NgoqOw3Oa1E8Xd+NJhGM7kIwzvyXZ3rQ3axPtT9LyqUhs80IgPf9IDFRx?=
 =?us-ascii?Q?fO/NnFSkvO6yuU78PfZIufjtWfJ2xtyBo6Wm4H7NJuisETo4yBdKt+c/ut2J?=
 =?us-ascii?Q?bQwsxp16GPSMrrfNVKCy/sCMbbIQehDBQzGpSXbcEl5qFbkjhAYv3WloKEq/?=
 =?us-ascii?Q?iMuf1WaxKH7cD3++Tm4ZHBXEk9yR5N0b+Im4sxRNeYMBSZ743VAYBA37AdoF?=
 =?us-ascii?Q?Dd5CDXPtZ/Hp+lYF1zXO+3ILsW51MeRhVQZKN9/u5kSHlrnfubSzq7zbeAUi?=
 =?us-ascii?Q?YY6uf/rR3aq9hgMn5OBLpgdEZj3ol/kyykElQNRsYMUIIGPffti4fvV2teLA?=
 =?us-ascii?Q?PzyGIqqeYrLM2Qa/hF/bicQYbU8STuCz7eXV3vC6Rs9gp9QkS/r+hVsT7gtT?=
 =?us-ascii?Q?ttKdbobETAeoXbByuDvx8amqFC86S1mZbALhWGlM3gavdRiEiTgRbWFO/WV/?=
 =?us-ascii?Q?AlCNa/2B/h0k1T0LL2X3mlqvEMa0HKLSfA135uoDQQJFe2Mfi5BSL0iyGroy?=
 =?us-ascii?Q?7Dzn5IVDkTZ8aVcUsN6JgOFlYQpO7XYSVlmAESOx5oQK2zjQ8mUkpwUa/yMh?=
 =?us-ascii?Q?8Ah/7KedhM+N6hqiKMkauyWXAwTUZfz+iS6FoGqElCPNhiphnf7zis9p42Uq?=
 =?us-ascii?Q?llvOmo40/EZKCeM+lLUZ0FK86UloKHIpehERlfSvtoghc/7/EKGc+Y5IXPyp?=
 =?us-ascii?Q?9seD/irOrusJ7/It9gSJYOX7IYLiJban2P8ezz6eSaiCiVqs09KrJSMzhsIp?=
 =?us-ascii?Q?CPhw1qWF3RwW8/cynlJkRxFx963xGkMAhp4LMN4WH82YX1y5p+nPzrpX9Skb?=
 =?us-ascii?Q?9Odb0IsmUBUs3XnWC9iXKBA9+lYClUUOu2CHPz35aUzYf+AcydQzHLKvlV26?=
 =?us-ascii?Q?kFW/yCqG1Q0eH63ye5oH/DV8Gqoglqq8iBNafPaGOO6EMr70dmgqas64nDq7?=
 =?us-ascii?Q?JZfhjZyJonMG+ecPbUjFNzZ3GyAvwnbtDO/ZFTqOZAlEMQbJBnsqTNl2m8Jw?=
 =?us-ascii?Q?IFgKa9DRr6jSnmAYtEIVbDxL9czlkyBeYFFJFlktNMRMZpPUeAIz2xW7qm1j?=
 =?us-ascii?Q?HQv57hkgQDBMB2a454zRBsrTG+IY6Ca41Mrr5PyXfx0n+jp3RpnClc6p0etS?=
 =?us-ascii?Q?3RYxh7y3MIlq7qhR8fKnw7erLi+yxdQAwsdSNWTxSBxu0Hd+VdNTc4jxZ10Q?=
 =?us-ascii?Q?mZsfRheHXu62SBoNk5qLNF7DM2RuSs5qTXk6OX0IaWdosZdHtx3BsO0aW0pS?=
 =?us-ascii?Q?tKGwQ0iy1lBKJ3Vedp/ofIqOtib+zGsd+Q4J6zt8a6FF7QgowOc6Zk9nzIyk?=
 =?us-ascii?Q?wK27DEjBogmxHPXms8aH0MTbu6vGFzuPcAbAGQBTQ7/ufPI36oR2ajGgtB5B?=
 =?us-ascii?Q?whpHdd3rcRnQEBUp82yQhT6zNj9Adx0KRSlX9ZnG+fL/pNtw/uNsFCKX1NTp?=
 =?us-ascii?Q?JpUjGMiHqoZmN8cCEg5OyBMJmvecHW2JYRPjNjaScE5/oLoh1JnkauKgFIwU?=
 =?us-ascii?Q?Mz4EG92v9QJFCQkLlNbTaxMCnFNPA7idLnX2+Ia50lvDRRfgGboRRCDc/0jV?=
 =?us-ascii?Q?JLpzX3jOaurtoJUFtgFoV3QE9EqbFanwuaSgpvr2Hvn1+DkusSG0pnBvqTxR?=
 =?us-ascii?Q?O6One/MQTSDy17KIZ7tESxZZfnEhDJOfMuDWIjrS6dqFf+QT4xdYxs/Wyj6R?=
 =?us-ascii?Q?rszeUKToS8vXAaI+PUi6BMps1AF3aKt69pMS+71/yWQUo7ujNIHEThJppYex?=
 =?us-ascii?Q?eptqjeAoBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6672779a-fc25-457a-8ccb-08df273d7263
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:14:57.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhPNf2sxw1wZwbB4csSIhEd9j7NTJrPNI2Oc45ZZs0DYQ3Bw2dBr1Kdi39tkYpiLdEM7GfIcED28C0oHlvfOcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

Refuse reset unless enabled system-physical HDM ranges can be reserved
exclusively and CPU-cache invalidation is available. Invalidate before
reset and again before ending IOMMU exclusion, holding range reservations
until the second invalidation completes. A later patch places state
restoration before the second invalidation.

Reject normalized-addressing decoders because their cached ranges are not
system physical addresses. Ignore zero-size decoders because they map no
address range. Refuse reset when the device decodes memory through its
DVSEC ranges instead of HDM decoders, since the cache holds no range to
reserve for that memory.

Provide the range handling as a region quiesce in built-in CXL code. The
quiesce lock blocks region commit and teardown for the whole reset, and
the HDM state copy taken under it supplies both the reserved ranges and,
later, the state to restore.

The range handling and region-quiesce structure follow Dave Jiang's
reference implementation on his cxl-type2-reset branch.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=5944c6e61f14c0dd28d54537be15edb2cadb0e8b
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM
---
 drivers/cxl/core/hdm_state.c | 274 ++++++++++++++++++++++++++++++++++-
 drivers/pci/cxl.c            |  50 ++++++-
 include/cxl/hdm.h            |  47 +++++-
 3 files changed, 366 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
index 9a31f5996c74..cef604013350 100644
--- a/drivers/cxl/core/hdm_state.c
+++ b/drivers/cxl/core/hdm_state.c
@@ -1,7 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 #include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/ioport.h>
+#include <linux/list.h>
+#include <linux/memregion.h>
+#include <linux/overflow.h>
+#include <linux/pci.h>
+#include <linux/rwsem.h>
 #include <linux/slab.h>
 
 #include <cxl/hdm.h>
@@ -10,7 +18,8 @@
 
 /*
  * CXL state that must stay available while no CXL driver is bound: the CXL
- * locks and the per-device HDM cache filled during PCI enumeration.
+ * locks, the per-device HDM cache filled during PCI enumeration, and the
+ * region quiesce used around a reset.
  */
 struct cxl_rwsem cxl_rwsem = {
 	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
@@ -62,3 +71,266 @@ void cxl_hdm_cache_release(struct cxl_hdm_info **slot)
 	}
 	kfree(info);
 }
+
+/**
+ * cxl_hdm_cache_dvsec_decode() - check for memory decoded by DVSEC ranges
+ * @slot: cache pointer owned by the device
+ *
+ * Return: true if the published state shows CXL.mem enabled while HDM
+ * decoders are globally disabled, so that the device decodes memory through
+ * its DVSEC ranges, which the cache does not describe.
+ */
+bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot)
+{
+	struct cxl_hdm_info *info;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = *slot;
+	return info && (info->dvsec_ctrl & PCI_DVSEC_CXL_MEM_ENABLE) &&
+	       !(info->global_ctrl & CXL_HDM_DECODER_ENABLE);
+}
+
+/**
+ * cxl_hdm_cache_snapshot() - copy the published HDM state
+ * @slot: cache pointer owned by the device
+ *
+ * Return: a copy the caller frees with kfree(), ERR_PTR(-ENXIO) when nothing
+ * is published, or another ERR_PTR() on failure.
+ */
+struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot)
+{
+	struct cxl_hdm_info *info, *copy;
+	size_t size;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = *slot;
+	if (!info)
+		return ERR_PTR(-ENXIO);
+	if (info->decoder_count <= 0)
+		return ERR_PTR(-EINVAL);
+
+	size = struct_size(info, settings, info->decoder_count);
+	if (size == SIZE_MAX)
+		return ERR_PTR(-EOVERFLOW);
+
+	copy = kmemdup(info, size, GFP_KERNEL);
+	if (!copy)
+		return ERR_PTR(-ENOMEM);
+
+	return copy;
+}
+
+void cxl_region_quiesce_lock(void)
+	__acquires(cxl_region_quiesce)
+	__context_unsafe(token maps to cxl_rwsem.region)
+{
+	down_write(&cxl_rwsem.region);
+	__acquire(cxl_region_quiesce);
+}
+
+void cxl_region_quiesce_unlock(void)
+	__releases(cxl_region_quiesce)
+	__context_unsafe(token maps to cxl_rwsem.region)
+{
+	__release(cxl_region_quiesce);
+	up_write(&cxl_rwsem.region);
+}
+
+/*
+ * Bound the range twice: request_mem_region() takes resource_size_t while
+ * cpu_cache_invalidate_memregion() takes size_t, and the two differ on
+ * 32-bit builds with CONFIG_PHYS_ADDR_T_64BIT. range_len() can also reach
+ * RESOURCE_SIZE_MAX + 1 for a full-width range, and wraps to zero when
+ * resource_size_t is 64-bit, which the !len test catches.
+ */
+static int cxl_hdm_range_validate(struct device *dev,
+				  const struct range *hpa_range)
+{
+	u64 len = range_len(hpa_range);
+
+	if (!len)
+		return -EINVAL;
+
+	if (hpa_range->end > RESOURCE_SIZE_MAX) {
+		dev_err(dev,
+			"CXL reset range [%#llx-%#llx] exceeds resource address size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	if (len > RESOURCE_SIZE_MAX) {
+		dev_err(dev,
+			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	if (len > SIZE_MAX) {
+		dev_err(dev,
+			"CXL reset range [%#llx-%#llx] exceeds cache flush size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_range_add(struct cxl_hdm_quiesce *q, struct device *dev,
+			     const struct range *hpa_range)
+{
+	struct cxl_hdm_range *range, *next, *new_range;
+	int rc;
+
+	rc = cxl_hdm_range_validate(dev, hpa_range);
+	if (rc)
+		return rc;
+
+	list_for_each_entry(range, &q->ranges, list)
+		if (range_contains(&range->hpa_range, hpa_range))
+			return 0;
+
+	new_range = kzalloc_obj(*new_range);
+	if (!new_range)
+		return -ENOMEM;
+
+	new_range->dev = dev;
+	new_range->hpa_range = *hpa_range;
+	new_range->len = range_len(hpa_range);
+
+	list_for_each_entry_safe(range, next, &q->ranges, list) {
+		if (range_contains(hpa_range, &range->hpa_range)) {
+			list_del(&range->list);
+			kfree(range);
+		}
+	}
+	list_add_tail(&new_range->list, &q->ranges);
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_collect(struct cxl_hdm_quiesce *q, struct device *dev,
+				  const struct cxl_hdm_info *snapshot)
+{
+	int rc;
+
+	for (int i = 0; i < snapshot->decoder_count; i++) {
+		const struct cxl_decoder_config *config =
+			&snapshot->settings[i].config;
+
+		/* A committed zero-size decoder maps no HPA. */
+		if (!(config->flags & CXL_DECODER_F_ENABLE) ||
+		    !range_len(&config->hpa_range))
+			continue;
+
+		if (config->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING) {
+			dev_err(dev,
+				"CXL reset does not support normalized address decoders\n");
+			return -EOPNOTSUPP;
+		}
+
+		rc = cxl_hdm_range_add(q, dev, &config->hpa_range);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q)
+{
+	struct cxl_hdm_range *range;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	list_for_each_entry(range, &q->ranges, list) {
+		const struct range *hpa_range = &range->hpa_range;
+
+		range->res = request_mem_region(hpa_range->start, range->len,
+						"cxl_reset");
+		if (!range->res) {
+			dev_err(range->dev,
+				"cannot reset while CXL memory range is busy [%#llx-%#llx]\n",
+				hpa_range->start, hpa_range->end);
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_invalidate(struct cxl_hdm_quiesce *q)
+{
+	struct cxl_hdm_range *range;
+	int rc = 0;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	list_for_each_entry(range, &q->ranges, list) {
+		const struct range *hpa_range = &range->hpa_range;
+		int rc2;
+
+		rc2 = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
+		if (rc2)
+			dev_err(range->dev,
+				"failed to invalidate CPU cache [%#llx-%#llx]: %d\n",
+				hpa_range->start, hpa_range->end, rc2);
+		rc = rc ?: rc2;
+	}
+
+	return rc;
+}
+
+/**
+ * cxl_hdm_quiesce_prepare() - take the HPA ranges of a device out of use
+ * @dev: device for error messages
+ * @q: quiesce state to initialize
+ * @snapshot: HDM state from cxl_hdm_cache_snapshot()
+ *
+ * Reserve every enabled system-physical range in @snapshot exclusively, then
+ * write back and invalidate CPU caches for them. Call
+ * cxl_hdm_quiesce_destroy() afterwards whether or not this succeeds.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int cxl_hdm_quiesce_prepare(struct device *dev, struct cxl_hdm_quiesce *q,
+			    const struct cxl_hdm_info *snapshot)
+{
+	int rc;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+	INIT_LIST_HEAD(&q->ranges);
+
+	if (!cpu_cache_has_invalidate_memregion()) {
+		dev_err(dev, "CPU cache invalidation unavailable\n");
+		return -ENXIO;
+	}
+
+	rc = cxl_hdm_ranges_collect(q, dev, snapshot);
+	if (rc)
+		return rc;
+
+	rc = cxl_hdm_ranges_request(q);
+	if (rc)
+		return rc;
+
+	return cxl_hdm_ranges_invalidate(q);
+}
+
+/* Evict lines fetched during reset before DMA exclusion ends. */
+int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
+{
+	return cxl_hdm_ranges_invalidate(q);
+}
+
+void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q)
+{
+	struct cxl_hdm_range *range, *next;
+
+	list_for_each_entry_safe(range, next, &q->ranges, list) {
+		list_del(&range->list);
+		if (range->res)
+			release_mem_region(range->hpa_range.start,
+					   resource_size(range->res));
+		kfree(range);
+	}
+}
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 9eb13adf0daa..3da8b316857f 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -15,6 +15,7 @@
 #include <linux/iommu.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/memregion.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -392,7 +393,8 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
 					      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
 }
 
-static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
+			      struct cxl_hdm_quiesce *q)
 {
 	int rc, rc2;
 
@@ -417,12 +419,18 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
 	rc = rc ?: rc2;
 
+	rc2 = cxl_hdm_quiesce_flush(q);
+	rc = rc ?: rc2;
+
 	pci_dev_reset_iommu_done(pdev);
 	return rc;
 }
 
-static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
+	__must_hold(cxl_region_quiesce)
 {
+	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
+	struct cxl_hdm_quiesce q;
 	u16 saved_ctrl2;
 	int rc, rc2;
 
@@ -432,14 +440,39 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
 		return -ENODEV;
 
+	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
+	if (IS_ERR(snapshot)) {
+		pci_err(pdev, "CXL HDM decoder state unavailable: %ld\n",
+			PTR_ERR(snapshot));
+		return PTR_ERR(snapshot);
+	}
+
+	rc = cxl_hdm_quiesce_prepare(&pdev->dev, &q, snapshot);
+	if (rc) {
+		cxl_hdm_quiesce_destroy(&q);
+		return rc;
+	}
+
 	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
 	if (!rc)
-		rc = __cxl_reset_execute(pdev, dvsec, cap);
+		rc = __cxl_reset_execute(pdev, dvsec, cap, &q);
 	/* Restore cache policy after any attempt to disable caching. */
 	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
+	cxl_hdm_quiesce_destroy(&q);
 	return rc ?: rc2;
 }
 
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc;
+
+	cxl_region_quiesce_lock();
+	rc = cxl_reset_quiesced(pdev, dvsec, cap);
+	cxl_region_quiesce_unlock();
+
+	return rc;
+}
+
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	u16 dvsec, cap, ctrl;
@@ -466,5 +499,16 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (probe)
 		return 0;
 
+	/* The cache is owned by @pdev and does not require a bound CXL driver. */
+	if (!cxl_hdm_cache_present(&pdev->hdm))
+		return -ENOTTY;
+
+	/* Memory decoded through DVSEC ranges has no HPA ranges to quiesce. */
+	if (cxl_hdm_cache_dvsec_decode(&pdev->hdm))
+		return -ENOTTY;
+
+	if (!cpu_cache_has_invalidate_memregion())
+		return -ENOTTY;
+
 	return cxl_reset_execute(pdev, dvsec, cap);
 }
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index af7cef649446..f6446a2a7fcd 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -3,9 +3,14 @@
 #ifndef __CXL_HDM_H__
 #define __CXL_HDM_H__
 
+#include <linux/list.h>
 #include <linux/types.h>
+
 #include <cxl/cxl.h>
 
+struct device;
+struct resource;
+
 /**
  * struct cxl_endpoint_decoder_settings - endpoint HDM decoder programming
  * @config: common decoder configuration
@@ -42,7 +47,6 @@ struct cxl_hdm_info {
 	bool dvsec_ctrl_valid;
 	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
 };
-struct device;
 
 int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
 				 resource_size_t size);
@@ -52,5 +56,46 @@ bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot);
 void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
 			   struct cxl_hdm_info *info);
 void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
+bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot);
+struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot);
+
+/*
+ * Region quiesce blocks CXL region commit and teardown, and with them decoder
+ * reprogramming, while reset handling captures or restores HDM decoder state.
+ */
+token_context_lock(cxl_region_quiesce);
+
+/**
+ * struct cxl_hdm_range - HPA range held exclusively across a reset
+ * @list: entry in &cxl_hdm_quiesce.ranges
+ * @dev: device for error messages
+ * @hpa_range: system physical address range decoded by the device
+ * @len: length of @hpa_range
+ * @res: reservation of @hpa_range, once requested
+ */
+struct cxl_hdm_range {
+	struct list_head list;
+	struct device *dev;
+	struct range hpa_range;
+	u64 len;
+	struct resource *res;
+};
+
+/**
+ * struct cxl_hdm_quiesce - HPA ranges held exclusively across a reset
+ * @ranges: list of &struct cxl_hdm_range, see cxl_hdm_quiesce_prepare()
+ */
+struct cxl_hdm_quiesce {
+	struct list_head ranges;
+};
+
+void cxl_region_quiesce_lock(void);
+void cxl_region_quiesce_unlock(void);
+int cxl_hdm_quiesce_prepare(struct device *dev, struct cxl_hdm_quiesce *q,
+			    const struct cxl_hdm_info *snapshot)
+	__must_hold(cxl_region_quiesce);
+int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
+	__must_hold(cxl_region_quiesce);
+void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q);
 
 #endif /* __CXL_HDM_H__ */
-- 
2.43.0

