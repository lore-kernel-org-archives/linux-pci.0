Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD63B4A13BC;
	Tue,  4 Aug 2026 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871819; cv=fail; b=rMeWwA4zS4258XPMbZHvgNezKJUctOvaSXtZJ0crPhFSW86C5Prl5lMCyV6UYRhEfFvBiz99VzOuhv/MVrxs3JO2HJcG57nVT9OXNA6BOYQ25F1OZV6ZiFKDaVvnuQSfbYMfMqZLCqC67Jk8oviONjavvmvhIjkSFOXTDLwwN3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871819; c=relaxed/simple;
	bh=p37VvFp+/vqgqp0HpHQM5jQwHwO55UfhZ+nsIkyv/Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PoPkhn8t/y3/fYSY+S6R2ShvRldogLlQEwDptrgke874NYhlzBV7q2DMvlorqMwcHMUAQkrhnzw8ekCIY/g08nnZfFAQVCNoFrrOFA2bJtqZCtWN5xDOvU7oSAAQxnAcRR4mNHcuj8NiU4YSSjLJPA9Gw0DQX09BZKFwU4yl2Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t2hkgVxS; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t2hkgVxS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyS/Id69HuZ4L3qHoW51eElxrNxaK392c6QGBdVGyrD2JgXcYpnEDumVrN2mKAVx9wdTDT2ADswh5sqKm4JQ8UWpYQ10Q74aootabFnMV/mFRPxM1FgoB2tZM5pB+XdtRx6y8jA1iPFsZFbMDqo6YBb962NEfWIZkd8ihtzXRYk882yF4OjnzxFqvHhpkVmr4ONHiotqTm/pTkSdCLlIGBUg4dTdL9Swn8H+kg3UJBtckEeB8PY653Ieslu4KfP02q5pYD5oy3bHaBVOTjB7sIzgKa2vBSpxii006EIWFUVgioGr1FKlbuPeirtrg3qak/PLI19nIyWXQiAHmZ7ujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uVE33hciyqzKDmcNbYmjVQ1bRCYqliedDV/XGeI6qM=;
 b=MA2BI8QCEBPT0GcbCXYykdGIVLLBmLp/PYLT0jaqLW4v8peJAz6f7cUk4SGRlNZv4OVMpiE7znX7jp+zKAZYhya2ds7EuegxF7O5vl6UCjKwnnyrrPkKx5bVD6Q7qUSujSchr9bHWygpSq4L04EVtrrtunszHcH8/lsziJNnYuEO54Yb2lMVjgMyknW+yeDQqrQl2uANiZRpHAaxO14P3fURYInoB/+KrNEtrF+8YWXcCLcOhM8ezDS9ZJwKSYaV+PlwxqxP/3SsapyiNK2M2swDNRjgSM7eESFcfe5b2+z9e8HqTo0SGKvghwAmvtaN04P5xJAkfhNSQwvwJTqsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uVE33hciyqzKDmcNbYmjVQ1bRCYqliedDV/XGeI6qM=;
 b=t2hkgVxSSWazMsTlquNTORw6asFitPNEc97qXgInxZ+C2sWWfCAMWH/eTkTDPfkiaoprKyblGGR/CilXNbVggdM+wG84dcF0sVMW/ubc75X7pK5Fs/tobF5NK8nxguR34BhGQOrabMG3kqek/oQJ5dFl8yrsLqavYTPcC0AoefzIjqRFAudiZEOuieNwwfiQyVeYSWcgM9wp/ARwtJx+t9a6kVt072XX1OhZ71r2u3D5rhMp34FEPhNL3Xt77+8eLGgXWRIlM72zraHkl7wfaVsYE8PHcQXKAGogyw3HJt5QSdw7s9qUqrb7INxKnXEf55FLZRvK1lFrc39wABRKxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 19:30:09 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:09 +0000
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
Subject: [PATCH v10 01/12] cxl: Move HDM decoder programming helpers
Date: Tue,  4 Aug 2026 19:29:47 +0000
Message-ID: <20260804192958.1823952-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::26) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a03efc-3de9-4c10-127c-08def25ecb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	CcLSIM8EBgyaTtDMnV/F1aLHRALcR6Ov1BaNP8LUKTX4dyfAzkztf6iIKXAK86YDbsPRRYkTfa0Q4B2uU6bURyCbRhbmJrfgFX4wJN/2n6WZ79/urTroQgamA2LbGgGgNP4Z5wbRy8DhYUtRkeH2u/bIAIkx3NhqnhU/re48jDCqxhbXwAlXXOOrWqPHgmzQDibLzL7PPKfyzBKqu39CjtxkTP2Z04u35FRoqN6cylFe336IuMJjgjEUeQL8SLOdd2wP0CcKYU359mwlH+31cuD/TuxnMFZ8MLm+5MHSCAasEBQE6dbY+zyChnHikkXKVVg86pzY99x1MgKdVvOGcI7AoFx5Yk+X3O1/BwaX0rEJueEM+37iCKuA4ooAedlcKapSh9tj9UMVvzX3ZGlvhlzNCzq9AXibtIVeZsw/w3F5TQrodbhrHTVdnmqJbKiUTvBgF8hlF27RY65U7etMBYLTTzgUkAowxjIZ8r5iDj3zT5SkrWepQT6IcJEA8mezEuhkhlg9rlApbag7KeC3kUoYi+F1t45AUE83tS9bSc4vZKm7wpw/ZiCuOH3wNlMAmt3YAQSwnF3REu7MbKEeFDZFw5IrrXs9Z/pcDwWVw4vQ5j1ND1mWWX52ygaXfHPyNYh20UKI5A4TjRqrL3jZcLWkJV1lpfQIsZ26HWgu1mEk6oLgB034jsHySMK+QA3hSH2akpTbEWkqBsnlEv0lNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kKVfJ+qbZSu87LVERs4cVfC/YUBjEgc9VgqyWmXyBgm7iBMGYujhFij+Vo5W?=
 =?us-ascii?Q?6a9BVkyMA3FPAzvw1tUPiiE6RA1pAFMUFVvIMX6Xqsr5rymwpC/1aqgfG7Dj?=
 =?us-ascii?Q?YI2/GcNvvTYZgdF9ynAninhcClgPElTLYegV232mmIA25f0kgoR3NECgvHkE?=
 =?us-ascii?Q?cThTxhDPSPQhRxuUVyneWRHW9f5iT3Xyf9xZOen2euY4pXbHu877RFu0xVPN?=
 =?us-ascii?Q?XVrjEzSxCsNZ6lmf6RAgf7KC98pgZTl21Me7J56dYmoq+Z0JimvgWDpRfKrk?=
 =?us-ascii?Q?cenZY7HV+Uy9F6O2HsqKMWRFLCounkRliO+SelDMmCZPAyiKYI9LrwRP64Z/?=
 =?us-ascii?Q?gfcpghkDvkFlT96oFOdoErgckIYu9+glEVc473kzRpujiaR5i42pyIXlWMbZ?=
 =?us-ascii?Q?6G80eUg0FPfxoHJ4LymYXh1SD55DOhYoxUCbEV/meK77dxXBkxEzGutGV9+l?=
 =?us-ascii?Q?M2ibZVaCY52kJBnexgZbElD2u6/imn1HlaotjkWvy2LSeiFS79G+ja3nKDdk?=
 =?us-ascii?Q?jWBvjqLLbYo54obMqoWG0x4eCYDXPIm4bcDr+oolbsTnRlIlUxDvlgyvxK6V?=
 =?us-ascii?Q?ZkBk9sSLPITX6T2rwtSiHkmnfXhYuqbQZqaUUP2K4WAExUp085iDEX8pXomu?=
 =?us-ascii?Q?xHVJk0UR6NAkWoLeAqy59DC09oPJiHJ7j4AgX0K3dgFAg1bS0h6vO8sk6sA1?=
 =?us-ascii?Q?cuenrrR7VQIvtXFZ7/kO0WJ+ckXVC0f20I1Gtqj3QMvx/F6F5qqEU5MwCFwc?=
 =?us-ascii?Q?hnaeYyzREzGKWYTxGFH3OuW5MiTvUCVdvmVmOiqO7X8GbJSGSjn3m7luZvtF?=
 =?us-ascii?Q?KFi9Uz+b0g8Ke4uvnYEZ+UaW3PK/kBhEGwCYFbJWCav0nPbOIKi0U8D9IVSE?=
 =?us-ascii?Q?6n//t6S/EdWdoS1vrU32tzZTw9X5w3v2HLiig5kjzok7n2PFZdJqsHFyT7H8?=
 =?us-ascii?Q?u87D2Bfpa0wQyt0HwHN99ur2HGGmywZ3jK7XCzMqFErSy2i4W1nNnzr5sGet?=
 =?us-ascii?Q?rvKQu246jIsQeo3AQK68km2PTjVbUSoz7eVNtRUrQ+T0irglTLs4c3g0PQFV?=
 =?us-ascii?Q?SZu7B7ah+ys1isnFJ115vCMcuIiJ29vkUhI4EF7FdLU+iQFDdptDl+8zxx2c?=
 =?us-ascii?Q?zDn1JO45PMnRr1+Si3DuEkycGRItrqaLK7096nHikFVx2+sFl0knmftWxa77?=
 =?us-ascii?Q?94xOT/D21vtECQ8jpSf/KkV/RvsiH0zj134P0gl+2zg+tv6duGRwJVHcI3Ex?=
 =?us-ascii?Q?NY2G7tfnY+MCLl3+P7LWtYyevRM9yZ2awHlhJ370LRV8f5qGb3sfkE7f2nR4?=
 =?us-ascii?Q?WYe2aPYDzL/MaU2c0CBqJGzUeOO4gRzKrLRa6OkxqeVBAztE935sTUgY5/8/?=
 =?us-ascii?Q?irZ1HdN0QuCg6aGUUIekKppYv4jinb7MPwDQomENQRB8Rt+Di+mIDE/Ng7JC?=
 =?us-ascii?Q?jhH2OFUSQHqz2ekyypgMCmo9hnHM/Ph++w0ZTu7QNjEy7gAxrg4DrJXUTqhT?=
 =?us-ascii?Q?xcjx9n1663vCAoeMcemoLUEweU4MdiUkowP7YD2tj11rntrjOCqV9sZzScY6?=
 =?us-ascii?Q?xoIeFan46sHCUduK8eL+VMXXj3XEJClmNjVTC4OqsgH9A7eoRusJoGukBFkL?=
 =?us-ascii?Q?GyMFOMwFOU+ECajxMCu54PhuEZFOOxo2yt2AtGgsleEpGisIXT9zvHQsmOeR?=
 =?us-ascii?Q?jJEhpdr+4aabebUwkFa4wtJ81MM+FOPB/rSZVdzdPITX97HV1lnR8+ihf+iu?=
 =?us-ascii?Q?JC9QbuzZLg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a03efc-3de9-4c10-127c-08def25ecb7a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:09.0165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8t4eHc5w5vmlkpN4dpadEH3kA/9D1Xo7fCNSGGvHMGLSN4dahTrXj7ATFBjnF2ux9VrHo6r3/Wk7lcPvc17vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

Move the low-level HDM decoder programming helpers from hdm.c into
resource.c so they can be shared by later reset restore code.

Keep the existing decoder commit flow and register programming sequence
unchanged. This patch is intended to be a mechanical move. Follow-on
patches update the helper interface for reset restore.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/Kconfig         |   4 ++
 drivers/cxl/core/Makefile   |   1 +
 drivers/cxl/core/core.h     |   2 +
 drivers/cxl/core/hdm.c      | 124 +-------------------------------
 drivers/cxl/core/resource.c | 138 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h           |  41 -----------
 include/cxl/cxl.h           |  45 +++++++++++-
 tools/testing/cxl/Kbuild    |   1 +
 8 files changed, 191 insertions(+), 165 deletions(-)
 create mode 100644 drivers/cxl/core/resource.c

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
index ce7213818d3c..0df4178bbbaa 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
+obj-$(CONFIG_CXL_HDM) += resource.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 07555ae63859..cb6853a92a93 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -213,6 +213,8 @@ int cxl_gpf_port_setup(struct cxl_dport *dport);
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
+void cxl_setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm);
+int cxld_await_commit(void __iomem *hdm, int id);
 int cxl_port_get_possible_dports(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..6ae0b9f46ac0 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -16,10 +16,6 @@
  * for enumerating these registers and capabilities.
  */
 
-struct cxl_rwsem cxl_rwsem = {
-	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
-	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
-};
 
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 {
@@ -679,124 +675,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
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
-
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
@@ -835,7 +713,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	}
 
 	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
-		setup_hw_decoder(cxld, hdm);
+		cxl_setup_hw_decoder(cxld, hdm);
 
 	rc = cxld_await_commit(hdm, cxld->id);
 	if (rc) {
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
new file mode 100644
index 000000000000..dd8bed3d3ff0
--- /dev/null
+++ b/drivers/cxl/core/resource.c
@@ -0,0 +1,138 @@
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
+EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
+
+static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
+{
+	u16 eig;
+	u8 eiw;
+
+	/*
+	 * Input validation ensures these warns never fire, but otherwise
+	 * suppress unititalized variable usage warnings.
+	 */
+	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
+		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
+		return;
+	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
+		      "invalid interleave_granularity: %d\n",
+		      cxld->interleave_granularity))
+		return;
+
+	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
+	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
+	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
+}
+
+static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
+{
+	u32p_replace_bits(ctrl,
+			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
+			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+}
+
+static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
+{
+	struct cxl_dport **t = &cxlsd->target[0];
+	int ways = cxlsd->cxld.interleave_ways;
+
+	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
+	if (ways > 1)
+		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
+	if (ways > 2)
+		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
+	if (ways > 3)
+		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
+	if (ways > 4)
+		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
+	if (ways > 5)
+		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
+	if (ways > 6)
+		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
+	if (ways > 7)
+		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
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
+
+EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
+
+void cxl_setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
+{
+	int id = cxld->id;
+	u64 base, size;
+	u32 ctrl;
+
+	/* common decoder settings */
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+	cxld_set_interleave(cxld, &ctrl);
+	cxld_set_type(cxld, &ctrl);
+	base = cxld->hpa_range.start;
+	size = range_len(&cxld->hpa_range);
+
+	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
+		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
+		u64 targets;
+
+		cxlsd_set_targets(cxlsd, &targets);
+		writel(upper_32_bits(targets), tl_hi);
+		writel(lower_32_bits(targets), tl_lo);
+	} else {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
+		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
+
+		writel(upper_32_bits(cxled->skip), sk_hi);
+		writel(lower_32_bits(cxled->skip), sk_lo);
+	}
+
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+EXPORT_SYMBOL_FOR_MODULES(cxl_setup_hw_decoder, "cxl_core");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c0e5308e4d1b..c795cce0fcbc 100644
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
index 016c74fb747c..05a8bc32138c 100644
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
@@ -23,7 +25,48 @@ enum cxl_devtype {
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

