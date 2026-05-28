Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF3383C77;
	Thu, 28 May 2026 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957144; cv=fail; b=SFVbsybEwX+YV7vNLv8o94l0Uu9x5UPEYqvspMIaEhC1IycZaXS1k5WbHjD5088XDPh/NbeT66+jbcF2JPuC2WPNz45KipjLjeWyRGdWHIJdgTui20KtPPhCQFqrlavSEZ8V58JVhtAzO87c1AKK5zNldaQHhSaKVpAK9V8VDnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957144; c=relaxed/simple;
	bh=MnEdg7lTPb26NnY+50InBTmIZJgJUX0dUiBVe9qS4Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NlOK/0l42Q8dcVWOfUauGJlNPc02wZ0v7Meq3/qotCE2h1R4gYpzjLQTRtEPa3DlPSa7eM8CbggE7ct9KP8Z4yFLIOjJlTH0cVRhcApfBg4wble5ZCnqqoY0S/TtYHph+q74HAFpUnGjRef57fjdf3ldY5NlGXqa+TAJFgd4MiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LPXEnrKh; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LPXEnrKh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBvHi5a0+1kYiaTOnSAMEty4Tlf8FMB+Q0+cL4rOcnb3/80o5GcWz5XfxibLndYBpsM6+N8yndPpOL6jKz37F3h/4ryg+8olDn0NCMb9HgZ/GihuzWrRhlMefwkRNo97jqqNnRd36qOzL4buXLiya90j2eUtI8HetlHTzenRRErQT0lnOuu5VmTU4HY7El751rAXkWgqKpqyFBShI5iBAAijY5gEOfcGFBNIHpH6JfEN6VoeWoKBYRharNZTdbwXl4n4FEP15356nfPiKZZSMnixdtIAYq45TUadZdDd/mas8QQ1Wq7mGwvrhJTBUzTh4I482zrq+fDbaDVJ+5e3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVL47WseP4as7+dPo20tW24c8KlwY28+06G2yt9/ezw=;
 b=o3p8Mfm3YhEgxKpW/I02R566jyjlzbhWXeDc4PF4cnc/qF/1B0EdYq0KIqjNHhLHj3k3PtwSsNjtEDPA1f68+LYm/SG9QUj5Q3FAR4M5F09erKj4rItvCZacIeOjyb2P3kKCgaewD3pEsjE1wF1587BiXg+o0SLqV+a4SniT/XiudPGUqxv4WJKbukvwSSRu5KhapkeO03bOhryQnTHLxADao96eW0F2+yaqGpex40hwQr68G0fK/2EB1O7BGu610Qie8bRe0GA1ttBmi3hPpvmpl6ShqzvoLZr4oRVW05AY312OB0bZEnNDBmnfSQi1db2W1TOAGJrzZbZ+OhUI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVL47WseP4as7+dPo20tW24c8KlwY28+06G2yt9/ezw=;
 b=LPXEnrKhEVV8ymLgw+IcEovCA+q8x3X+b1wZU617so/k2gT79w7QzpyZ+UUpdZ+YgTjq45/B1pXh6c7t5uGMDuvj6S+eZDdVoZmPx/HfoGTHAbZTXc2T9OBhojfkF54l8krbBeLKoCEYc96pCTmWA/xuT0K3++L1wtHtfGSDP4nHnfrWiYraD9/wiWALcH4Lb1ZDSUEunWTcreXK/f2Dk/aGSjFYUq4JK5ng4Gigg/FhngB/dfCYmr6BvOawZhiQ9oxX9B6GBKuk+/3YYp6ZjcW1667Le00Nfq6ImbjXP2yBmo/S5HOJNKriOXNIW67vupwzmrVMlQ6Ty2BGxJvHNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:32:15 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:32:15 +0000
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
Subject: [PATCH v6 7/9] cxl/pci: Orchestrate CXL reset for affected memdevs
Date: Thu, 28 May 2026 08:31:52 +0000
Message-ID: <20260528083154.137979-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528083154.137979-1-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::17) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 496b2d83-ad87-44cd-8701-08debc939f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|11063799006|5023799004|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oyrF7x8cSTGPQIKpCWYfOEc29txbANXkuTztWd5YacJECuswyDpEjlHC93O+DG/AjPmgbsu0Es2lUXvBQtpAtpClvhDDk8T7I8vFp8r4gZy3WwFLgbrjtn7dwfW84QQ0C/0dmFc7Wfz8eD5lbh2kZCfkkQ0WoQuiGLhqtzHEZkFfI07mmRp1MqFOIgdDRvnVlmAJFDb42amSX7B0tjoSekXNk5+dwSO/nM3pJCeyJ17ss82tVS0Dkci//TUIDvFl/ByIYWQn+CAm3idhSlT4gkpqAXfJHBLTGsJJhsMvCelVO0hKcRNYNrrlMXs/O0j/tDQkqerXjqLjwNYXWCAOhc5FlJt7LNSpVUQjHKPvu2xUBiOvMph8/eaGgcsRnb9uSm9surZ6/FKh7cgLTKuwaY1hCBzDjiL7rXXkRHGOTqLEFyfGtcu6STCBECXR+oKOgEAvcsZLcnsI/oAWHZ/7mpTURlvbuVzHzVB/PlF+OU8ShzjbISyU5QBXqrJ1hZANZFwITgaKjhJ8GyTRVjYAq1i1wH2XSQAAM0c2a8t8cB+afCk2S9Du6aqKGjHSTjQik6NsOnJ4RKBOL0MNOjloa3O3hkx/m5bfCKjgEODpynDulEa21vqhlfplY0MDJLjMGmxkBsrX0Gv8Pq4MSlok+8eNfHN3/5b2pRGmL8brdIIAzRLFu5ZCwqwabcRTkTasxDuoZCLQGj86tEWtOXUhEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWBhTS1tVp716KbYMslIP8+WZEorafaL3eFVn4/pLHNyacoiVCi5hfYf2+CR?=
 =?us-ascii?Q?Asy0657Yw5jASLeL4PMgiwiDB9GC6w/q0fDIia5eopRy/q5kHL0BD5KON3Sz?=
 =?us-ascii?Q?sbJHyu+mByg3q+oF79xB6Ful12oKjDwWUDYe6bkhFHt/BX6DLcHXg1hL3hwY?=
 =?us-ascii?Q?dSlLnnW/OJsTSFzjzVcBk5Mu00jnaAjSYFhRlJQCQP7rgT4EQqm0VyeSdeYf?=
 =?us-ascii?Q?Z+q1JYMmTOoiQd7UZ9NhJ+wdFleq1jm3StSEmjb+GQjhsSWR+f1cMmtrfEIS?=
 =?us-ascii?Q?779251Ny963ySnT2K4cNEaXUqV1EfpsMzt8QJhcj+JElQNCLy20+sHkFFNwt?=
 =?us-ascii?Q?mijJ6KcM8GHxUB8bTS1l+H+doO/249cRB/PJK3M92vJlTORQ8szy9GHB5nZ/?=
 =?us-ascii?Q?tdcoRWvErkKmhaGDnStFMIl1jsIxPoInkrBrVI8Ner0qyYvdT9IzWKV3clWB?=
 =?us-ascii?Q?czawYznnNjnG9F+tqiLLx7T7X6Cdwk2CbN3e7xMlJ45K0Iq7wjdyfYJL9n5Y?=
 =?us-ascii?Q?R1Pl1FqTH6oIKii8qjj3gv8BcJwG+iAF7Ao7FdksuZvxlzq5eKwHd5J1Dp+D?=
 =?us-ascii?Q?QgKztQF1csewjj2Ht5A94YHk5Om2kHFNmaYh3BT9ffZ43LjsWgmLsj6htowA?=
 =?us-ascii?Q?sAdUIRS3Wj5i7rHdYD44T20jj/DpofIcK6QsNVNV/iSegugu+m90EqIn9Sqc?=
 =?us-ascii?Q?ShXfT2yvSEpYTMFPQylDlf8eWCvI/z9nGcbvTZg3T0OlZGYYa4lCPs+eydF7?=
 =?us-ascii?Q?mKiLNwhxRQorpeJ6fCrgGk2IbwfxNN7kKOKEqL1g7f0ZWwz9mDt3amJ1k8NQ?=
 =?us-ascii?Q?aACNZs4FjRBBrnT55EkjA58F+XnYK2tIbfQ5Mj5eXT41EyIbTeb1mzHqzUsD?=
 =?us-ascii?Q?jeJ/nYYFH9Ibb9nL/FIIxL8/QStmev09mBYyYBe28zmpqgaSM9Zx54rka+ic?=
 =?us-ascii?Q?+SM+JFXDxHdi+TEpXtt/35AvRtCRRu+Be4ZmlVTQNGRevYNeAjiI/DL5J/VV?=
 =?us-ascii?Q?KG4+mTMto2WwKmDyu3ebxNkZe7taphDhFolW/59O3Xbb2thISKfTqlZQp6Zi?=
 =?us-ascii?Q?caUXpkIw7oaEjWH043UMvcJWCdn/cOhRVHNxzcgYp2YL7j0Hyi2mWNiB1sVx?=
 =?us-ascii?Q?2WhP+kL5jy6Ok86pwc0BV9qG1vd4spMlVdxYV8sq6M7zsaX8o8FQpEaPhQfP?=
 =?us-ascii?Q?W7pEV+t+L3fjwyOR3Hmf1/9tCo5Jnf5pxoWIS4778XJcqhJ/U+RkU1KXEjTM?=
 =?us-ascii?Q?ua8qtbm2UNCsey7IqV0V+07blMnXp21GjlEn3+LcX2FEvMdNOvzxcXjveTeU?=
 =?us-ascii?Q?vPwOlEk2eEBgPe5zniuk+e1kVUwu2vOXeF2OxJ1DvqmHGLFVkJwkJfwjl89w?=
 =?us-ascii?Q?aQaFLqjqqgUmZSPJW0/GWCg4k+oVBv0YN8lTmZ++pif93bROWW5dg/jvG0HW?=
 =?us-ascii?Q?cTc7iXqtDBL1AvU6AOJSWVqVGRTS0pJNfXwemf+zAjPwiMbr65YZifmrstIv?=
 =?us-ascii?Q?3HMqVZ/Fd59DFndNpzbji1kEuqiaBslZhN3xjNSqLxPE7nbQcyp7du4jth4w?=
 =?us-ascii?Q?DqqZbSNlYm3eoZQiwjSJPISc2HucwklZjkKOAJeKk5+1O0PnT+3KJMN++5UR?=
 =?us-ascii?Q?BoyFmbUtahbbunl/JEadzoD+O9QWhFuwCco6n/fz6dYKjmZOchhBV3VeT6F4?=
 =?us-ascii?Q?fl4MwFgvFs5A72vwGTf1liHTSp7/o+5c+lMBkfKQY7ZT4uTpCgX7GpU0MaPw?=
 =?us-ascii?Q?6AU6IzE3cw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496b2d83-ad87-44cd-8701-08debc939f55
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:32:15.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzO1VcDuelWqXxV1P4/4Npr/YLAar0wvYLa/zB1HvNZ4ynk5uGiRJbJjciOblbVLEZ3LezZf7a9Sea6LLqdDbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

Add the reset flow that coordinates the target function, affected CXL
sibling functions, and any active memdevs in the CXL.cache/mem reset
scope.

The flow collects regions for the affected memdevs under
cxl_rwsem.region, verifies that those regions are idle, flushes CPU
caches for the affected ranges, saves and disables the target and sibling
PCI functions, and locks active memdevs to revalidate that their
endpoints are still present before reset.

After the CXL DVSEC reset completes, restore PCI config space so CXL
MMIO is accessible, restore decoder programming for all active affected
memdevs, commit their restored decoders, and only then re-enable CXL.mem
for the affected set.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/pci.c | 414 +++++++++++++++++++++++++++++++++++------
 1 file changed, 358 insertions(+), 56 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c755c18c8d84..486c447e98f3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -947,14 +947,12 @@ struct cxl_reset_region_context {
 	struct xarray regions;
 };
 
-static void __maybe_unused
-cxl_reset_region_context_init(struct cxl_reset_region_context *ctx)
+static void cxl_reset_region_context_init(struct cxl_reset_region_context *ctx)
 {
 	xa_init(&ctx->regions);
 }
 
-static void __maybe_unused
-cxl_reset_region_context_destroy(struct cxl_reset_region_context *ctx)
+static void cxl_reset_region_context_destroy(struct cxl_reset_region_context *ctx)
 {
 	xa_destroy(&ctx->regions);
 }
@@ -985,9 +983,8 @@ static int cxl_reset_collect_region(struct device *dev, void *data)
 	return cxl_reset_add_region(ctx, cxled->cxld.region);
 }
 
-static int __maybe_unused
-cxl_reset_collect_memdev_regions(struct cxl_reset_region_context *ctx,
-				 struct cxl_memdev *cxlmd)
+static int cxl_reset_collect_memdev_regions(struct cxl_reset_region_context *ctx,
+					    struct cxl_memdev *cxlmd)
 {
 	struct cxl_port *endpoint;
 
@@ -1045,8 +1042,7 @@ static int cxl_reset_validate_region_idle(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int __maybe_unused
-cxl_reset_validate_regions_idle(struct cxl_reset_region_context *ctx)
+static int cxl_reset_validate_regions_idle(struct cxl_reset_region_context *ctx)
 {
 	struct cxl_region *cxlr;
 	unsigned long index;
@@ -1077,26 +1073,41 @@ static int cxl_reset_flush_region_cache(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int __maybe_unused
-cxl_reset_flush_cpu_caches(struct cxl_reset_region_context *ctx)
+static int cxl_reset_cpu_cache_flush_preflight(struct cxl_reset_region_context *ctx,
+					       bool *skip)
 {
-	struct cxl_region *cxlr;
-	unsigned long index;
-	int rc;
+	if (skip)
+		*skip = false;
 
 	if (xa_empty(&ctx->regions))
 		return 0;
 
-	if (!cpu_cache_has_invalidate_memregion()) {
-		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
-			pr_info_once(
-				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
-			return 0;
-		}
-		pr_warn("Failed to synchronize CPU cache state\n");
-		return -ENXIO;
+	if (cpu_cache_has_invalidate_memregion())
+		return 0;
+
+	if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
+		pr_info_once(
+			"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
+		if (skip)
+			*skip = true;
+		return 0;
 	}
 
+	pr_warn("Failed to synchronize CPU cache state\n");
+	return -ENXIO;
+}
+
+static int cxl_reset_flush_cpu_caches(struct cxl_reset_region_context *ctx)
+{
+	struct cxl_region *cxlr;
+	unsigned long index;
+	bool skip;
+	int rc;
+
+	rc = cxl_reset_cpu_cache_flush_preflight(ctx, &skip);
+	if (rc || skip)
+		return rc;
+
 	xa_for_each(&ctx->regions, index, cxlr) {
 		rc = cxl_reset_flush_region_cache(cxlr);
 		if (rc)
@@ -1120,7 +1131,11 @@ struct cxl_reset_context {
 	struct pci_dev **siblings;
 	int nr_siblings;
 	int sibling_capacity;
+	int nr_siblings_locked;
 	int nr_siblings_prepared;
+	bool target_locked;
+	bool target_saved;
+	bool target_iommu_prepared;
 };
 
 struct cxl_reset_walk_ctx {
@@ -1306,7 +1321,7 @@ static int cxl_reset_collect_pci_memdev(struct cxl_reset_context *ctx,
  * function set to find memdevs whose regions and endpoint decoder state must
  * be handled around the reset.
  */
-static int __maybe_unused cxl_reset_collect_memdevs(struct cxl_reset_context *ctx)
+static int cxl_reset_collect_memdevs(struct cxl_reset_context *ctx)
 {
 	int rc, i;
 
@@ -1323,7 +1338,7 @@ static int __maybe_unused cxl_reset_collect_memdevs(struct cxl_reset_context *ct
 	return 0;
 }
 
-static int __maybe_unused
+static int
 cxl_reset_collect_regions(struct cxl_reset_context *ctx,
 			  struct cxl_reset_region_context *region_ctx)
 {
@@ -1370,7 +1385,7 @@ static void cxl_reset_unlock_memdevs(struct cxl_reset_context *ctx)
 	}
 }
 
-static int __maybe_unused cxl_reset_lock_memdevs(struct cxl_reset_context *ctx)
+static int cxl_reset_lock_memdevs(struct cxl_reset_context *ctx)
 {
 	int i;
 
@@ -1400,7 +1415,7 @@ static int __maybe_unused cxl_reset_lock_memdevs(struct cxl_reset_context *ctx)
 	return -EAGAIN;
 }
 
-static void __maybe_unused cxl_reset_put_memdevs(struct cxl_reset_context *ctx)
+static void cxl_reset_put_memdevs(struct cxl_reset_context *ctx)
 {
 	int i;
 
@@ -1417,14 +1432,20 @@ static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
 {
 	int i;
 
+	/*
+	 * Config state was restored early for CXL MMIO access. Complete PCI
+	 * reset recovery here by unblocking IOMMU and running reset_done().
+	 */
 	for (i = ctx->nr_siblings_prepared - 1; i >= 0; i--) {
 		struct pci_dev *sibling = ctx->siblings[i];
 
 		pci_dev_reset_iommu_done(sibling);
 		pci_dev_restore(sibling);
-		pci_dev_unlock(sibling);
 	}
 
+	for (i = ctx->nr_siblings_locked - 1; i >= 0; i--)
+		pci_dev_unlock(ctx->siblings[i]);
+
 	for (i = 0; i < ctx->nr_siblings; i++)
 		pci_dev_put(ctx->siblings[i]);
 
@@ -1432,31 +1453,39 @@ static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
 	ctx->siblings = NULL;
 	ctx->nr_siblings = 0;
 	ctx->sibling_capacity = 0;
+	ctx->nr_siblings_locked = 0;
 	ctx->nr_siblings_prepared = 0;
 }
 
-static int __maybe_unused
-cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
+static int cxl_pci_functions_lock(struct cxl_reset_context *ctx)
 {
-	int rc, i;
-
-	ctx->siblings = NULL;
-	ctx->nr_siblings = 0;
-	ctx->sibling_capacity = 0;
-	ctx->nr_siblings_prepared = 0;
+	int i;
 
-	rc = cxl_reset_collect_siblings(ctx);
-	if (rc)
-		goto err;
+	ctx->nr_siblings_locked = 0;
 
 	for (i = 0; i < ctx->nr_siblings; i++) {
 		struct pci_dev *sibling = ctx->siblings[i];
 
 		if (!pci_dev_trylock(sibling)) {
-			rc = -EAGAIN;
-			goto err;
+			cxl_pci_functions_reset_done(ctx);
+			return -EAGAIN;
 		}
 
+		ctx->nr_siblings_locked++;
+	}
+
+	return 0;
+}
+
+static int cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
+{
+	int rc, i;
+
+	ctx->nr_siblings_prepared = 0;
+
+	for (i = 0; i < ctx->nr_siblings_locked; i++) {
+		struct pci_dev *sibling = ctx->siblings[i];
+
 		pci_dev_save_and_disable(sibling);
 		rc = pci_dev_reset_iommu_prepare(sibling);
 		if (rc) {
@@ -1469,7 +1498,6 @@ cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
 			 * nr_siblings_prepared and must not get iommu_done().
 			 */
 			pci_dev_restore(sibling);
-			pci_dev_unlock(sibling);
 			goto err;
 		}
 
@@ -1483,6 +1511,79 @@ cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
 	return rc;
 }
 
+/*
+ * Restore PCI config space after reset so CXL MMIO is accessible for memdev
+ * restore. Driver reset_done callbacks remain deferred to final cleanup.
+ */
+static void cxl_pci_functions_restore_state(struct cxl_reset_context *ctx)
+{
+	int i;
+
+	for (i = ctx->nr_siblings_prepared - 1; i >= 0; i--)
+		pci_restore_state(ctx->siblings[i]);
+}
+
+static int cxl_pci_target_lock(struct cxl_reset_context *ctx)
+{
+	struct pci_dev *pdev = ctx->target;
+
+	if (!pci_dev_trylock(pdev))
+		return -EAGAIN;
+
+	ctx->target_locked = true;
+	return 0;
+}
+
+static int cxl_pci_target_reset_prepare(struct cxl_reset_context *ctx)
+{
+	struct pci_dev *pdev = ctx->target;
+	int rc;
+
+	/* Disable first to stop new transactions, then drain in-flight ones. */
+	pci_dev_save_and_disable(pdev);
+	ctx->target_saved = true;
+
+	if (!pci_wait_for_pending_transaction(pdev))
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to block IOMMU for CXL reset: %d\n", rc);
+		return rc;
+	}
+
+	ctx->target_iommu_prepared = true;
+	return 0;
+}
+
+static void cxl_pci_target_restore_state(struct cxl_reset_context *ctx)
+{
+	if (ctx->target_saved)
+		pci_restore_state(ctx->target);
+}
+
+static void cxl_pci_target_reset_done(struct cxl_reset_context *ctx)
+{
+	if (ctx->target_iommu_prepared) {
+		pci_dev_reset_iommu_done(ctx->target);
+		ctx->target_iommu_prepared = false;
+	}
+
+	/*
+	 * cxl_pci_target_restore_state() restores config space before memdev
+	 * restore. Complete PCI reset recovery here with reset_done().
+	 */
+	if (ctx->target_saved) {
+		pci_dev_restore(ctx->target);
+		ctx->target_saved = false;
+	}
+
+	if (ctx->target_locked) {
+		pci_dev_unlock(ctx->target);
+		ctx->target_locked = false;
+	}
+}
+
 static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
 				  u16 clear)
 {
@@ -1599,7 +1700,7 @@ static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
 	return 0;
 }
 
-static int __maybe_unused cxl_dev_reset(struct pci_dev *pdev, bool mem_clear)
+static int cxl_dev_reset(struct pci_dev *pdev, bool mem_clear)
 {
 	int dvsec, rc;
 	u16 ctrl2_clear = 0;
@@ -1620,19 +1721,9 @@ static int __maybe_unused cxl_dev_reset(struct pci_dev *pdev, bool mem_clear)
 	if (mem_clear && !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
 		return -EOPNOTSUPP;
 
-	if (!pci_wait_for_pending_transaction(pdev))
-		pci_err(pdev, "timed out waiting for pending transactions\n");
-
-	rc = pci_dev_reset_iommu_prepare(pdev);
-	if (rc) {
-		pci_err(pdev, "failed to block IOMMU for CXL reset: %d\n",
-			rc);
-		return rc;
-	}
-
 	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
 	if (rc)
-		goto out_iommu;
+		return rc;
 	if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE)
 		ctrl2_clear |= PCI_DVSEC_CXL_DISABLE_CACHING;
 
@@ -1651,7 +1742,7 @@ static int __maybe_unused cxl_dev_reset(struct pci_dev *pdev, bool mem_clear)
 
 	rc = cxl_reset_wait_done(pdev, dvsec, cap);
 	if (rc)
-		goto out_iommu;
+		return rc;
 
 	rc = cxl_reset_update_ctrl2(pdev, dvsec, 0,
 				    PCI_DVSEC_CXL_DISABLE_CACHING);
@@ -1660,7 +1751,218 @@ static int __maybe_unused cxl_dev_reset(struct pci_dev *pdev, bool mem_clear)
 	if (rc && ctrl2_clear)
 		cxl_reset_update_ctrl2(pdev, dvsec, 0, ctrl2_clear);
 
-out_iommu:
-	pci_dev_reset_iommu_done(pdev);
+	return rc;
+}
+
+static int cxl_reset_restore_memdev(struct cxl_reset_memdev *rmd)
+{
+	struct cxl_memdev *cxlmd = rmd->cxlmd;
+	int rc;
+
+	if (!rmd->active)
+		return 0;
+
+	rc = cxl_restore_memdev_decoders(cxlmd);
+	if (rc)
+		dev_err(&cxlmd->dev,
+			"Failed to restore CXL.mem decoders after reset: %d\n",
+			rc);
+
+	return rc;
+}
+
+static int cxl_reset_commit_memdev(struct cxl_reset_memdev *rmd)
+{
+	struct cxl_memdev *cxlmd = rmd->cxlmd;
+	int rc;
+
+	if (!rmd->active)
+		return 0;
+
+	rc = cxl_commit_memdev_decoders(cxlmd);
+	if (rc)
+		dev_err(&cxlmd->dev,
+			"Failed to commit CXL.mem decoders after reset: %d\n",
+			rc);
+
+	return rc;
+}
+
+static int cxl_reset_enable_memdev(struct cxl_reset_memdev *rmd)
+{
+	struct cxl_memdev *cxlmd = rmd->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	int rc;
+
+	if (!rmd->active)
+		return 0;
+
+	cxlds->media_ready = false;
+
+	rc = cxl_set_mem_enable(cxlds, PCI_DVSEC_CXL_MEM_ENABLE);
+	if (rc < 0) {
+		dev_err(&cxlmd->dev,
+			"Failed to enable CXL.mem after reset: %d\n", rc);
+		return rc;
+	}
+
+	rc = cxl_await_media_ready(cxlds);
+	if (rc) {
+		dev_err(&cxlmd->dev,
+			"Media not active after CXL reset: %d\n", rc);
+		return rc;
+	}
+	cxlds->media_ready = true;
+
+	return 0;
+}
+
+static void cxl_reset_disable_memdevs(struct cxl_reset_context *ctx)
+{
+	int rc, i;
+
+	for (i = ctx->nr_memdevs - 1; i >= 0; i--) {
+		struct cxl_memdev *cxlmd = ctx->memdevs[i].cxlmd;
+
+		if (!ctx->memdevs[i].active)
+			continue;
+
+		rc = cxl_set_mem_enable(cxlmd->cxlds, 0);
+		if (rc < 0)
+			dev_err(&cxlmd->dev,
+				"Failed to disable CXL.mem after reset restore failure; device state may be inconsistent: %d\n",
+				rc);
+	}
+}
+
+static int cxl_reset_restore_memdevs(struct cxl_reset_context *ctx)
+{
+	int rc;
+	int i;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	for (i = 0; i < ctx->nr_memdevs; i++) {
+		rc = cxl_reset_restore_memdev(&ctx->memdevs[i]);
+		if (rc)
+			return rc;
+	}
+
+	for (i = 0; i < ctx->nr_memdevs; i++) {
+		rc = cxl_reset_commit_memdev(&ctx->memdevs[i]);
+		if (rc)
+			return rc;
+	}
+
+	for (i = 0; i < ctx->nr_memdevs; i++) {
+		rc = cxl_reset_enable_memdev(&ctx->memdevs[i]);
+		if (rc) {
+			cxl_reset_disable_memdevs(ctx);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+static void cxl_reset_context_destroy(struct cxl_reset_context *ctx)
+{
+	/*
+	 * LIFO unwind for regular completion and partial initialization:
+	 * memdevs, sibling functions, target function, then references.
+	 * Each cleanup helper tolerates being called after its state was
+	 * already released on an earlier error path.
+	 */
+	cxl_reset_unlock_memdevs(ctx);
+	cxl_pci_functions_reset_done(ctx);
+	cxl_pci_target_reset_done(ctx);
+	cxl_reset_put_memdevs(ctx);
+}
+
+static int cxl_do_reset_locked(struct cxl_reset_context *ctx, bool mem_clear)
+{
+	struct cxl_reset_region_context region_ctx;
+	int rc;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	cxl_reset_region_context_init(&region_ctx);
+
+	rc = cxl_reset_collect_regions(ctx, &region_ctx);
+	if (rc)
+		goto out;
+
+	rc = cxl_pci_target_lock(ctx);
+	if (rc)
+		goto out;
+
+	rc = cxl_pci_functions_lock(ctx);
+	if (rc)
+		goto out;
+
+	rc = cxl_reset_lock_memdevs(ctx);
+	if (rc)
+		goto out;
+
+	rc = cxl_reset_cpu_cache_flush_preflight(&region_ctx, NULL);
+	if (rc)
+		goto out;
+
+	rc = cxl_reset_validate_regions_idle(&region_ctx);
+	if (rc)
+		goto out;
+
+	rc = cxl_reset_flush_cpu_caches(&region_ctx);
+	if (rc)
+		goto out;
+
+	rc = cxl_pci_target_reset_prepare(ctx);
+	if (rc)
+		goto out;
+
+	rc = cxl_pci_functions_reset_prepare(ctx);
+	if (rc)
+		goto out;
+
+	rc = cxl_dev_reset(ctx->target, mem_clear);
+
+	cxl_pci_target_restore_state(ctx);
+	cxl_pci_functions_restore_state(ctx);
+
+	if (!rc)
+		rc = cxl_reset_restore_memdevs(ctx);
+
+	cxl_reset_unlock_memdevs(ctx);
+
+out:
+	cxl_reset_region_context_destroy(&region_ctx);
+	return rc;
+}
+
+static int __maybe_unused cxl_do_reset(struct pci_dev *pdev, bool mem_clear)
+{
+	struct cxl_reset_context ctx = {
+		.target = pdev,
+	};
+	int rc;
+
+	/*
+	 * Snapshot the CXL r3.2 9.7 device reset scope before taking
+	 * cxl_rwsem.region. Hot-added functions after this point are not
+	 * coordinated by this reset operation.
+	 */
+	rc = cxl_reset_collect_siblings(&ctx);
+	if (rc)
+		goto out;
+
+	rc = cxl_reset_collect_memdevs(&ctx);
+	if (rc)
+		goto out;
+
+	scoped_guard(rwsem_write, &cxl_rwsem.region)
+		rc = cxl_do_reset_locked(&ctx, mem_clear);
+
+out:
+	cxl_reset_context_destroy(&ctx);
 	return rc;
 }
-- 
2.43.0

