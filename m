Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC72DC783;
	Sun, 11 Oct 2026 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684898; cv=fail; b=lLNxSAXaTq0mcPF2bQVp9USR/3exsYSM5NVTiXEVrEaPL4z3Tud6KglmeftU51EiNWHOu6o60rNzc0VHE5NV/JgWYcr9uoStLCwbD3/yjZo6gU+O3suiTn45ONqSkqxXyzIfuP8T1FgFlQTnhsv0/5JC+2t2cKWBlvJ2SGLEmZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684898; c=relaxed/simple;
	bh=46RAc+D9SVqNYQYjJkoD5wAkF4/3nC1y7X9mEP1XgnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZT2JS1p7y/vQ0ldRayYzEghz7Npgq3P0pTjcaPm9ckWMtrDfhfNFR35Dlpy/gHh4l5SDCzX1hu7f8GY4KbgS5vDyrTZRhQwT6j0zJBmmzb9q4h5Z7ygHFf2l6UV4mJDeDpQQ2B/eg5wdfOMjB/I/GSyCuF1nbMpeUJ+8ZdQUX8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FWHKH4kN; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FWHKH4kN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQlGmQ/tMrN0XORUWu1OBCKauZYuo+/JKnB85+c29JQ7AiEn0wc50zeBd2WvVAgaj6RfASz3pCH01YUq1elmMooYdSFwObQ+PfIA1n1Ba0IIhUfjUr9M98jjB+wtkGnxJl0iqXYMHAxwEl4WM2XJYh+qg4onl6r5DtKzi2NXLu2uyAzS9rHL/gM+96zrbUb92XI8UmrxVkknqL/deI4jsJMz7CyD8OE/cYJAzAymPEufoCGK+ZNLNE0EJC990N7lT4e0q+nFXGXIFClWgop3Kyi2ymY2GVgXRZrbzrPgSmCRxbSWTR9Tlq9fVw1vfbSmd7pj2Lq3jaeiDmvjFQ2pAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q5KdSIk4VydRH9NZI+JseCA8/ehq6ijgSnxzuTAFfc=;
 b=KjiMjAZ8TybQifKB8ab8v3FQnMoIxMqmZILyCb2VF+ArJqxsBxB1AqPH1w2ffSn7PVdlymPihQzvQal4iUHqV3C8n5w4m8vPFmStyveGliAv6lxBn9hWO0TonsyXk5SbPZGdtekzLLtsgH5uSb1eLXnROh787MmdY5A38/VFiz4SLisiCtYCVlCPVcrKXGHy4fSeoLgWJ1EBErHS8wWan/rXGI4ARLj88+5FHJKq2Qz6EuloRNOMcfG4imXr8CDou+zlsCUxxZFCtmINxzUYrCgRD3Ui3soWP2QyHlOdxnyfgSzB0uaiMZIzxy9h1Mpfd9zdeVHCCAe7WRcUiAsolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q5KdSIk4VydRH9NZI+JseCA8/ehq6ijgSnxzuTAFfc=;
 b=FWHKH4kNVps0EsAONO8uPqntSF/6vJPC+63EZThtfzZM8gPpHnnl2mQBAyy1lT93Jng7ewZemNzJMw04htPNrWzODcEvoXnDysn0UEtjgKqdabybIu8P93m8Oieuhibccfgu4HXk69hvsK4yo9iMS+bONKc5AJ55mi7UYWdLMFvpesG9h/MT6GIboRSfPQOzubl5CEae/huENfXX4Ltl+O3KzuEnIzGrn9SlTBsP2SAERhYoXqFGBVA8DpwNXWwKGB5NqcYP2fukeu2pFwVVrkkIKXFJTw9Zd/XnYdbxzkSMQbPIV9iyW7z6oGQu4SwDlJCTweG2CPlN3Ovn9rkUZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:14:44 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:14:44 +0000
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
Subject: [PATCH v15 06/16] cxl: Move HDM decoder helpers to built-in code
Date: Sun, 11 Oct 2026 02:14:12 +0000
Message-ID: <20261011021422.3428136-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:303:b7::22) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b8b6a5-c752-42fb-342a-08df273d6ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|261009223027099003|921020|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	nDAvde0sfeHjzdjvAqu5FXznWhyTFifvr0rZ1WowzLymb0bxKjyP1ZFNyLbywRLeDWCbuzolzKUCkQHXLJgolssNSv9P0r2/WtmcmzlUe58ChkrImqB0iGWQAVZNxNnoSzFIdRmXH3MW066V9EM89f1IPoibqKItmZLpvCrcWtv4DUmApkEQl7haN4XrCyj1pJdxRiIJivwXyY4DtiyQuKMlN24vGsxngUt2YPyci2OvOgnHCw84RdtkktVt6lf7pb6RiMT+hiuJpQeI+c9fwuCMBByUNmUD3Il9xJ+CJ2zxcVwqiAE2D7+/rm+gtwDXgJai/HK+RO8Znf5oRmg9GceNA9QLTMvPQd9Nd1uxOylKbeccCf2uWT1BPvuyEtA3WE4yIiKQZYvFNlECjNyH35z1zCY7ij7KnyheGUeMDmSq/PDSwt7NWAF4bn/rpe9MCBUX0uGzc9vLVOIN5oqVQAluDiOHOBTcxFpMXWAXXw605fb6I7v1NTXzvJkcGxCGXdMtMjv7+tqygQKHnuTEQSpURKMTzI+QohRcXje6ATnikvjGTi4aJ7q4Fa00teNBK/kDdXtm6GMg4Ben+xPXsCBpsbSg+dcWLVvCxj8VO8LS2/BhqCGjMBO96L6n0nRj9Yt6pMpKmiaysIlPwA3YX7SWZMMDNgvLWVtI6lBlWDA/Hb10OjdqP+duBrQioWryFLwRLccOwpWG6GlKp2kjhw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(261009223027099003)(921020)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JKdy55DEmjaJPVYBNdiEqKUZQW7HLOunLwLO4+w1e40AfqaD9w2X6wEZOYtJ?=
 =?us-ascii?Q?DvOkr0QClqxkPrSC+o8yJLL3KtP27y/jHM7MaoChfbgY2PO+fKEl7aZmluXn?=
 =?us-ascii?Q?qntrqtuSaJyclbZ6eRxNVLaz/cBD9Uh4nKis5LX/1xegSEhDgDsWYn6WM2/m?=
 =?us-ascii?Q?IexjC6MUsxVvI3ad9J7gBB0qXzIgQRCuN8qqFv6Z1qKMAAhb9FRENURpzk1D?=
 =?us-ascii?Q?L4OSlLA9tSBiJ9Dg5JvwAON3hrrjM9knM/lF9jgTTrJDDSppTzW9emO5/EI3?=
 =?us-ascii?Q?dz94kV7OVa2NXB7DwVYGR/KAP2JUl2ze/aN6fA1R667LiJwv+uvfutpM1Nv9?=
 =?us-ascii?Q?+jeVt9Km+cet0F6WDNYrSQafWW/w6l3Ws8T2Bg4dpY6PovryyETxox9pvtA1?=
 =?us-ascii?Q?+nyGJt5Ke1dpwW1cKP297ppYh5zgiRkefU8f4ojzMta0AsjAaPe1s3kQAE5C?=
 =?us-ascii?Q?DWYmLgdf5oTm+BDEYROmWHGXs2j2sHZtBDcLajYgB1QZeYRKG+FaHwrD/tJ1?=
 =?us-ascii?Q?S8HXdw5BmSctss4pHgbUwAJwuANJUx8tGYnIMw8T1VdDdmd5jKkpxauMFZZu?=
 =?us-ascii?Q?OnPOuvU6fFy8VD4jkkzha97bqByoxGXDO69YdDOUTKv9D8YsMbgZkrN13Tz3?=
 =?us-ascii?Q?ohaf3uOc3K1xK48Ug36+28JaSznMClvv5Fx95vH7DsJps4163JXtji7N9vBR?=
 =?us-ascii?Q?wZPpycIQbL1MKoFiV9L3sBIzhDzWsl2m4yIzDd2pt5rC50iikD2UdeE/Qd48?=
 =?us-ascii?Q?MiOE1ubypJ8sO91py5q8kc02lYeQfeedEpVpB87T4sN84UfHjDqB049p7Nwa?=
 =?us-ascii?Q?xiR1g2JSg3Y5jHZJ/ttNNEScEKByt8Qap6YLiM2AWzO9Q5l0ztrFQioz3lXa?=
 =?us-ascii?Q?yMgUkkfmC+E4XyzJuebKG7MnpoTg37zwM6H13mwz61l5/TYTruCPlbJQI9yQ?=
 =?us-ascii?Q?hpvQdqcmaFfF5aiZ9BxR+XDCr+vrNAKpKrHin7DVx3UUQYCGCTGScC2Oy2zO?=
 =?us-ascii?Q?a5Zhv2Or93PHTt0SdRWmrfoFR+OKeaaRGUpvhCq5ZnkQ/++1fkxZenNplRIm?=
 =?us-ascii?Q?C9zcqyHxn7NkseHyhVG8jIcbCtSo65+bh2HqRjdABistfsaYayPQHK977nNE?=
 =?us-ascii?Q?0d/YkJ6JWBEB/jQt8Wp3qqHPi52HeNawx9hkg9iotAATYdcr/JUvswQ32IQb?=
 =?us-ascii?Q?6aML5Z1yaBoTvUY9jb3tcXsriMzMx2/NhbZ8FdqVNwR8Dk+SFMxtsAr3vpnf?=
 =?us-ascii?Q?zKjNRTbkKYaeNOLAZWFC2nctcqL0eWFkJmD9E2CmQ0JC6MFT+he+VFfoEeqM?=
 =?us-ascii?Q?/03JcleOci6Ep6Q4+kTy+t2fruqK6aejW7IME5tkF+in5Xc/Uu4opeSPjdWT?=
 =?us-ascii?Q?zWqvLy4+16WHASj95fZJ+1sH0h4Je5xKcIIq3lGr5pENW+iI4p6VptK1sJeS?=
 =?us-ascii?Q?RPKHR6dFqAqxW86Txqdl4Yq+tCvlOusj+DdAp+FBHrzDW9Ed5qk0MKy3057Q?=
 =?us-ascii?Q?PRVeoQ5Zlc5NU7LWXxOZUTIvC9jzLUh7SJHzNXbEMunNEr2FN/p4V+EqROaC?=
 =?us-ascii?Q?9ljg7okrj5Jdnv5qZQ3TbBS8Gn+SLHbjZ1XDIlcCr/JM7jF6BLrXfZGmpQt2?=
 =?us-ascii?Q?1npL54MzC8DHfWJomArmfMEgvPP05zUp2PYsnZUoNYgBGaDgYOIUdrJ5Y0cU?=
 =?us-ascii?Q?8OwCF1E19JgFzXRNvqrBfnjQ8F02d7DIz5jXU7yik5ia/8K5nnkHJzg7BPKl?=
 =?us-ascii?Q?PrdGOPItvg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b8b6a5-c752-42fb-342a-08df273d6ac2
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:14:44.8705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ka/f8VZgxQ/x4qgeKioI+kiK6Wfr4i2Eh8VDWd45vwbnshhn4OiJxBVPRk32YB+39lPLeexcLSYHiOWVwkkzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

The PCI core will restore HDM decoders after a reset, possibly while no
CXL driver is loaded, so it cannot call into cxl_core.

Move the HDM register programming helpers from hdm.c to hdm_regs.c and
build that file into the kernel whenever CXL_BUS is enabled, including
when CXL_BUS is modular. Export only the symbols that cxl_core uses.

Keep the DPA lock assertion in the normal decoder programming caller so
the register helpers do not depend on cxl_rwsem. Leave cxl_rwsem in
cxl_core until built-in cache management needs it.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=e0b476ea99567fb5aa416eac0cf61bca20724880
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/Makefile   |   1 +
 drivers/cxl/core/hdm.c      | 102 +------------------------------
 drivers/cxl/core/hdm_regs.c | 118 ++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 100 deletions(-)
 create mode 100644 drivers/cxl/core/hdm_regs.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..6703c1729396 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
+obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7d3254a712e4..47cf49bcd2e5 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -708,35 +708,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
-{
-	u16 eig;
-	u8 eiw;
-
-	/*
-	 * Input validation ensures these warns never fire, but otherwise
-	 * suppress unititalized variable usage warnings.
-	 */
-	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
-		      "invalid interleave_ways: %d\n", config->interleave_ways))
-		return;
-	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
-		      "invalid interleave_granularity: %d\n",
-		      config->interleave_granularity))
-		return;
-
-	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
-	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
-	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
-}
-
-static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
-{
-	u32p_replace_bits(ctrl,
-			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
-			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
-}
-
 static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 {
 	struct cxl_dport **t = &cxlsd->target[0];
@@ -759,77 +730,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
 }
 
-/*
- * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
- * committed or error within 10ms, but just be generous with 20ms to account for
- * clock skew and other marginal behavior
- */
-#define COMMIT_TIMEOUT_MS 20
-int cxld_await_commit(void __iomem *hdm, int id)
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
-static u32 cxl_hdm_write_range(void __iomem *hdm,
-			       const struct cxl_decoder_config *config)
-{
-	u64 size = range_len(&config->hpa_range);
-	u64 base = config->hpa_range.start;
-	int id = config->id;
-	u32 ctrl;
-
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-	cxld_set_interleave(config, &ctrl);
-	cxld_set_type(config, &ctrl);
-
-	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
-	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
-	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
-	return ctrl;
-}
-
-void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
-			       void __iomem *hdm)
-{
-	int id = settings->config.id;
-	u32 ctrl;
-
-	lockdep_assert_held(&cxl_rwsem.dpa);
-	ctrl = cxl_hdm_write_range(hdm, &settings->config);
-	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
-	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-}
-
-void cxl_commit_start_switch(const struct cxl_decoder_config *config,
-			     u64 targets, void __iomem *hdm)
-{
-	int id = config->id;
-	u32 ctrl;
-
-	lockdep_assert_held(&cxl_rwsem.dpa);
-	ctrl = cxl_hdm_write_range(hdm, config);
-	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
-	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-}
-
 static void
 cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
 			      struct cxl_endpoint_decoder_settings *settings)
@@ -846,6 +746,8 @@ static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
 {
 	struct cxl_endpoint_decoder_settings settings;
 
+	lockdep_assert_held(&cxl_rwsem.dpa);
+
 	if (is_switch_decoder(&cxld->dev)) {
 		struct cxl_switch_decoder *cxlsd =
 			to_cxl_switch_decoder(&cxld->dev);
diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
new file mode 100644
index 000000000000..53d2f236e49c
--- /dev/null
+++ b/drivers/cxl/core/hdm_regs.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+#include <linux/delay.h>
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+
+#include <cxl/hdm.h>
+
+#include "cxl.h"
+#include "core.h"
+
+/*
+ * HDM decoder register helpers are built in whenever CXL_BUS is enabled,
+ * including when cxl_core is modular. Callers provide any required locking.
+ */
+
+static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
+{
+	u16 eig;
+	u8 eiw;
+
+	/*
+	 * Input validation ensures these warns never fire, but otherwise
+	 * suppress unititalized variable usage warnings.
+	 */
+	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
+		      "invalid interleave_ways: %d\n", config->interleave_ways))
+		return;
+	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
+		      "invalid interleave_granularity: %d\n",
+		      config->interleave_granularity))
+		return;
+
+	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
+	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
+	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
+}
+
+static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
+{
+	u32p_replace_bits(ctrl,
+			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
+			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+}
+
+/*
+ * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
+ * committed or error within 10ms, but just be generous with 20ms to account for
+ * clock skew and other marginal behavior
+ */
+#define COMMIT_TIMEOUT_MS 20
+int cxld_await_commit(void __iomem *hdm, int id)
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
+EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
+
+static u32 cxl_hdm_write_range(void __iomem *hdm,
+			       const struct cxl_decoder_config *config)
+{
+	u64 size = range_len(&config->hpa_range);
+	u64 base = config->hpa_range.start;
+	int id = config->id;
+	u32 ctrl;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	cxld_set_interleave(config, &ctrl);
+	cxld_set_type(config, &ctrl);
+
+	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	return ctrl;
+}
+
+void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
+			       void __iomem *hdm)
+{
+	int id = settings->config.id;
+	u32 ctrl;
+
+	ctrl = cxl_hdm_write_range(hdm, &settings->config);
+	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
+	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_endpoint, "cxl_core");
+
+void cxl_commit_start_switch(const struct cxl_decoder_config *config,
+			     u64 targets, void __iomem *hdm)
+{
+	int id = config->id;
+	u32 ctrl;
+
+	ctrl = cxl_hdm_write_range(hdm, config);
+	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_switch, "cxl_core");
-- 
2.43.0

