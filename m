Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA33344D8D;
	Thu, 28 May 2026 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957130; cv=fail; b=swjuPwq/gG2uqcsg6och/RoMOt3sKlVlw/C8iR4+/t3X6Bjluh6vkpX921dzETQsKsBZpibGyS8Jcty+G+UJ3B5mKGMmASz31oX2aPM7jecftsVDgzI+9FuEADghnBGBg75eKZHjpaDrxrcOKZFXbXZd3alE/ctEwI2+Kg6W2KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957130; c=relaxed/simple;
	bh=cGD3tgsbuR8DV201a8gUp2xQBxtxOuLL345mmL9MbOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mwgw6wLCSTI5TIk8Qw4vGs6jMeXA+SNNGFacuGZc3lOHM13WCW/8eGhIiq9gsl0B2bdf5DKqiWLvOoqcF9Zmme1s0fIEilUgeE2+8EKLrdrrk6gDqbBCh0qtnj9PstKi1KbtEYJTS8aC2a/wvdJ6gMjVFmSAdVdClpmgbyzVBgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VB86UkmY; arc=fail smtp.client-ip=52.101.57.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VB86UkmY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQaixhF0+pyYmpNg+fy56XHew9pcMzs9F1xIvsZeVDkGahdhXRod5TBUkXUjZh82QYtw+LwYsGs+Yb1YcFToqJrR0sEPQ3oY2PVPcQEhbYZ1XG2HLO/VGcdyJNP9YrYxcgss+ukocmwgxk/Hv+yVwjmxxbv/ohpB1ib0x12bxL1jMaAbo1PUWr1HVqhzifepVdHYi2uMEdKBNb+GLTKuhOqYt9Vwc+v0uP447FolpJmYOy9RoBDH28Mhi3I0xWAcGKPM+L6FVI1PkouIg03Lf2x0bpauuEdMf06eVZqA2KbmyR56nPPju46FzU88GddthLc4iDeQswSdYq484VkVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pFmH6gxQ9uKM1KW1MSzqz2UOl3jrEPx2Kn7cxmZEDo=;
 b=W3XhFWFAALPQ5LA66BxjWOqCo7zAAOCXg9MShNepzaxSxBwOMqY9Vv7FYXTUnnD2fu/OCzMWWkhztVbWqCBYO+mKjPeNFdETO9O3d3qwMNmEb75o+tkQFZJOXO3K0P0fBP1lM2RjOmIbMrrbQ967YfNQ04ttBmbwKUZKM5P7LMG3NVmWlbKGqOzBFH0E1s+1/lvEEr66sR2v2OGW7nC6wwLMALRzGcNao2SzH5jpDURWWw4kK330P2wwAFzWPciadYZ1PEULBU5dQufbYT+WqPhvDkN7ynjDnpxljoaPRp7iMMLIKlPW0ehlCA12zRNlAbZOJ/PDcas2D6wkoGQMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pFmH6gxQ9uKM1KW1MSzqz2UOl3jrEPx2Kn7cxmZEDo=;
 b=VB86UkmYTVeI5cMjczC86VP7fQSQXsaCqypc+qEXJM+/ZLnzScPG1u27B3adGQALWPB574rTqGsovk3dFvGNaUZDRnjCowz/rLUHfMrq7+j3as7zepn+jcH5SfYQhvP3yr91Y0b0m3KEHFrTaKquJptouJYa1dNMKrvCma6F+x/EOA00Vf29OBGdvg/oJ7hH1z1Z/xuhR+Z4cwte+f47sCyxTOFvKLCdYABf2h9JA97KVA3Nz9NDHgkABewOpy1eoC1WjG5UDIOCNCb6vekiH7MTXuNzE7GfQNaclzAYh5VIN3aoove7GMSb076gnrRN/5Kdb715DXuFEpVP7nuV5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:32:05 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:32:05 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: linux-cxl@vger.kernel.org,
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
Subject: [PATCH v6 3/9] cxl: Add reset-idle and cache flush helpers
Date: Thu, 28 May 2026 08:31:48 +0000
Message-ID: <20260528083154.137979-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528083154.137979-1-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 081644ac-2707-4692-205f-08debc939956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9b5RiWokK8UiVOJVRzd8uC/OiLqk8nW3s/eckqYztW1ZXftPWbpcdlKYa1rIRt8UsoZ6IIpE9cIuLO1JdQ317oklb4Xx3MXJU/uibf95dFR8XiusqQ/qPi1LwM7oFHYhcDyyocBIJ20SJ3EqNigFSI0xHMN+6qJBgpgJavY6X1LmujucS+5E3Vu9YeHqiscErLhtz1QbMlT9eHFqG18EQdrMlmEy+FvBzBpEVpoXkI414icobgM6d7GBwMXCN6pakaeZoMdzEQkG0NG5NAPR6jh1wryf0dG9Rvpt3Ncv7bGmDjSn3YidsRb3TzRj3KHerBeY0WW7BGgaCr+s22rgHwtXbLraCq7nKOBe4RbSwbXM+M5kYZ8z6cx7X1v82ed0cV7p+k503XpoQTnF8skRIyYBtp0gIubPsEUmdmNSOikHgAiUZNjFcNgkEyE617uB1vZD17Gy9GSxgfD6bVyQJoA0YxfeaAMjtP9z3NPm9MLzdVeD9bG8TQo16TN4d61UQ66toOVVL8SlBeqZuyIkR8lrUDCAXnuD9a9nE1DNjJMu+l9ZNGWSJISzVoFyLT+Sxe6lHNbkWpT7fomyeHftLqGzHtweXAhtnwBCU1rI/P9qTyrkKgU7i6NSUfsvlvsPbZF/HN1iuut4b2gWFP0wuQYPjupZI0Abv0pGHN4wd71B6YiDUulwNnx2sWUDTHkx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8WAL+ap8hpgFA+BWq0KXNcB68jBuo4Mjo56B8u/ZvEKhx6XbuCeK78ZQXBLZ?=
 =?us-ascii?Q?vJy+BoggyA6UmRDvxrNJQM56lNOQtemipg/W2GQou7deWSgmUWiOjg+teHJN?=
 =?us-ascii?Q?1ka/bPJfTMFFs2vawmeASf6rayAqxTAexL9gFszTboKyEYuT0IdZeacwSPwO?=
 =?us-ascii?Q?hZsTTMFlq5CFG/W16NmHADYL2BofA/TwTs9wdFnF6D6wj9bzbdwwSKkeccPu?=
 =?us-ascii?Q?mX26Gf5Us8vPEDdoFCGsxtIgpi5Vm5bZ8s48QQHVOH9Zec56qEeKMJR0/MNE?=
 =?us-ascii?Q?aaR9wUUZ3wy5F3aYZCKdcmcQmXaXfdF+9mGWCPGSg/81cknR1JTA6j03EbK3?=
 =?us-ascii?Q?Mhh8Iw9ZhbLgnFeOmfS7lVv1O0ygJ7jMfjk0UTsqzcTgEj76v7cTJtp5zZAx?=
 =?us-ascii?Q?y4q1+Wyatop+/JBKzy3P359e8xRSJ+9NDjNCddz00dFzdEAPBlTYMuBDSjXF?=
 =?us-ascii?Q?1v0Fbx6tiEUN/OkejAyL/hJBtbkw7SIsOVKmdxis47+ujtMabHwpumALmtIN?=
 =?us-ascii?Q?38dXBm45FiK2G20L+rDMSmzalmI86Fezcol3dsZabLNWCBk8m+z+oo6tWaoC?=
 =?us-ascii?Q?VLfj+fa0DnzZ5B2LOyGy1NUhy1iXSJr2SkT/pnx5x0bQo6RLqNFvvJXfwgMC?=
 =?us-ascii?Q?OHpSpfoadGvN1oUaV0BBE0kKjlKb8POB4J5o4KigxReWrpTqpp+CTI9N39Jj?=
 =?us-ascii?Q?WH3kEgSLTnd7Btce7z2ymHlbJAHcHa+vu1AL7kxqRSweHfZCrVZ642Yf/iqk?=
 =?us-ascii?Q?+NwITx8hoqvzZv40HQUsE3cHTuKRNgdISE/xEjW4p4lpVpRpYmeBuqU0n6ap?=
 =?us-ascii?Q?PTiZTXbibSw1tBPs9Yvex/dmOvnSWXdujI82UzEiclB82XQc/5C4/sFc+5BO?=
 =?us-ascii?Q?0P9D2yGbaEC8fMm8ONAs9kgzc7n/4CjYrkXek+pb4cJQscCBhLXzGwcyaDU0?=
 =?us-ascii?Q?l4YVznifwYRziZI8rXgXOLJcPmWEeQrxTASzIOw3z9VT0yMkI5wdpNbyuzDU?=
 =?us-ascii?Q?uao2JjLlh+hDdq6jvLO0bTfDFR4r3o3jcAvTeMvr6ceANUl5qqYfafmmjcV9?=
 =?us-ascii?Q?NBc82AmfPp6G3Aw4CRULjSQiKXAUcGNooznbNAnkkQOcj/0LS6fq+0U2jYyN?=
 =?us-ascii?Q?qQWMwiYHpCZFcJJF6nybeWkNg3IgKuBujNOYZ4GVum5p9oepuGoUGGWM+S8e?=
 =?us-ascii?Q?FCydVQCQjCfXjZZxRESEedOKhxLOaphhnagQk9MYjWbYGmh+hLe+E1jzWhkm?=
 =?us-ascii?Q?bVPYon2grp4g5W+LUVaPhSjLGBXv41Ss7D0uQW7eMKm7m/hHI+TdAYKIgjTZ?=
 =?us-ascii?Q?ZDQvl1WQSEhRxYTEwdx94MUiK6I5Goji17YPm3rW1d0ZgTd0rG6pGU7zV7/I?=
 =?us-ascii?Q?26eRYwogE7JvRz5ZqjhBAHPi1+F4c9Yo9JZKJOT2ZsZRhm8P8X7cZJcRVvXf?=
 =?us-ascii?Q?7c+PCp/UvXEtpflldskPu9C56H1lUh128KXEEum8ISog1WRhrC59iSu6227G?=
 =?us-ascii?Q?CBqxJkhkygTUnOjRe4IUQGRotSg4jpH08osJL8kPyX8r5qPit3FNi66XAyi4?=
 =?us-ascii?Q?+VfRfvbnqiH3ETIp6fXuPlsorYR4GvIfJ+3ROUvtUdPh2wljuSiF04YMuvwL?=
 =?us-ascii?Q?ngpIRk9lJjAo5ejwRosCD07wkdXG/FoYrwNxgH8XmuxVNrMyzsCymxjX+ovQ?=
 =?us-ascii?Q?GLzzkt+d4O5ABTCQgfsstK5WCSefk0BIHHBNbKgNg7MukDBV2hCiDR7J3R/q?=
 =?us-ascii?Q?PeBmSc/2Ig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081644ac-2707-4692-205f-08debc939956
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:32:05.2900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aa+Dp2ZnJT1WXaYdqgLBbmBFo8BJEdWCnxoNQ13Qdak5YAAsGRHS0rXM1GCFylLs3yO6Sr4G1WmX3v3r5MsTYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617

Add helpers to collect the CXL regions affected by a memdev reset,
verify that those regions are idle, and invalidate CPU caches for the
affected address ranges before reset.

A memdev can participate in an interleaved region through multiple
endpoint decoders. Track affected regions in a temporary xarray so each
region is checked and cache-invalidated once per reset operation.

These helpers prepare the CXL.mem data path for reset. The actual reset
orchestration and decoder restore flow are added separately.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/pci.c | 170 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d1f487b3d809..318744695f62 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -4,9 +4,11 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/memregion.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <linux/xarray.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -926,3 +928,171 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
 
 	return ctx.count;
 }
+
+static int cxl_reset_system_ram_found(struct resource *res, void *data)
+{
+	return 1;
+}
+
+struct cxl_reset_region_context {
+	struct xarray regions;
+};
+
+static void __maybe_unused
+cxl_reset_region_context_init(struct cxl_reset_region_context *ctx)
+{
+	xa_init(&ctx->regions);
+}
+
+static void __maybe_unused
+cxl_reset_region_context_destroy(struct cxl_reset_region_context *ctx)
+{
+	xa_destroy(&ctx->regions);
+}
+
+static int cxl_reset_add_region(struct cxl_reset_region_context *ctx,
+				struct cxl_region *cxlr)
+{
+	int rc;
+
+	if (!cxlr || !cxlr->params.res)
+		return 0;
+
+	rc = xa_insert(&ctx->regions, (unsigned long)cxlr, cxlr, GFP_KERNEL);
+
+	/* A region may be referenced by multiple affected endpoint decoders. */
+	return rc == -EBUSY ? 0 : rc;
+}
+
+static int cxl_reset_collect_region(struct device *dev, void *data)
+{
+	struct cxl_reset_region_context *ctx = data;
+	struct cxl_endpoint_decoder *cxled;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	return cxl_reset_add_region(ctx, cxled->cxld.region);
+}
+
+static int __maybe_unused
+cxl_reset_collect_memdev_regions(struct cxl_reset_region_context *ctx,
+				 struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint;
+
+	if (!cxlmd || !cxlmd->cxlds)
+		return -ENODEV;
+
+	endpoint = cxlmd->endpoint;
+	if (!endpoint)
+		return 0;
+
+	return device_for_each_child(&endpoint->dev, ctx,
+				     cxl_reset_collect_region);
+}
+
+static bool cxl_reset_region_has_system_ram(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int rc;
+
+	if (!p->res)
+		return false;
+
+	rc = walk_iomem_res_desc(IORES_DESC_NONE,
+				 IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+				 p->res->start, p->res->end, NULL,
+				 cxl_reset_system_ram_found);
+
+	return rc > 0;
+}
+
+static int cxl_reset_validate_region_idle(struct cxl_region *cxlr)
+{
+	struct resource *res = cxlr->params.res;
+	int rc = 0;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	if (cxl_reset_region_has_system_ram(cxlr)) {
+		dev_err(&cxlr->dev,
+			"Cannot reset while CXL memory is online as System RAM [%pr]\n",
+			res);
+		return -EBUSY;
+	}
+
+	if (!device_trylock(&cxlr->dev))
+		return -EAGAIN;
+
+	if (cxlr->dev.driver) {
+		dev_err(&cxlr->dev,
+			"Cannot reset while CXL region has an active driver\n");
+		rc = -EBUSY;
+	}
+
+	device_unlock(&cxlr->dev);
+	return rc;
+}
+
+static int __maybe_unused
+cxl_reset_validate_regions_idle(struct cxl_reset_region_context *ctx)
+{
+	struct cxl_region *cxlr;
+	unsigned long index;
+	int rc;
+
+	xa_for_each(&ctx->regions, index, cxlr) {
+		rc = cxl_reset_validate_region_idle(cxlr);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_reset_flush_region_cache(struct cxl_region *cxlr)
+{
+	struct resource *res = cxlr->params.res;
+	int rc;
+
+	if (!res)
+		return 0;
+
+	rc = cpu_cache_invalidate_memregion(res->start, resource_size(res));
+	if (rc)
+		dev_err(&cxlr->dev, "Failed to invalidate CPU cache [%pr]: %d\n",
+			res, rc);
+
+	return rc;
+}
+
+static int __maybe_unused
+cxl_reset_flush_cpu_caches(struct cxl_reset_region_context *ctx)
+{
+	struct cxl_region *cxlr;
+	unsigned long index;
+	int rc;
+
+	if (xa_empty(&ctx->regions))
+		return 0;
+
+	if (!cpu_cache_has_invalidate_memregion()) {
+		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
+			pr_info_once(
+				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
+			return 0;
+		}
+		pr_warn("Failed to synchronize CPU cache state\n");
+		return -ENXIO;
+	}
+
+	xa_for_each(&ctx->regions, index, cxlr) {
+		rc = cxl_reset_flush_region_cache(cxlr);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
-- 
2.43.0

