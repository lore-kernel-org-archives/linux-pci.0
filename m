Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A439DBE9;
	Thu,  9 Jul 2026 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559037; cv=fail; b=Qqes+JqFrwJx95g78Hc8AcjSIDUJsbb9ewSEl5tF08fxKrwwN/6j3dQsCx6eqPV3Kvthd0AbEI5qAIojB57H/lNw9b48zRctiksTLjoym2waB+s14oRHY9LNDKc6240mZ0XK2nhCPUPaEvGhgEq/JXs77+T9tRheDwL+CYfAK7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559037; c=relaxed/simple;
	bh=/ufe/Fnd0XUgtCKQYQn83TAXdXmTwdWzvgh2mho5s3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XprqaDHmQ6ZL+dlcZKtkSASuwgWk18jM9ozLRJ/6PodV3HLPc8qht8jwa7oXo8TAKMs2E29wXzQxMecqCrAjnDurt8X8vNbW0VXJhXwHSJTPxYkeI4NKEBZmIWG2gSbP87AVLSbL4q5iZhfo65UkP6hX91NjFRRSWfp5PL7NOSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GMpq20yg; arc=fail smtp.client-ip=52.101.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GMpq20yg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntYTSOSehenAz70B3bHIAnyp3wYYLeXBfx+0I+VnP5ux5NWh1WDqJ02rl8tNvlIfYz0MdslWA7ZkDoYKQuzVX53T40XXLwAvVI6luxKR2PrhF+7UqhUTQFtq8JLo9XMu1F1VNpw4Bf4I8cieipFF1uIG4w6fScDk+9pdNZXCfWCOL99gPnuzSx+bo75eyf2trpATy9+JitZxqTdSlUlwtj4Jt2KbmjpUGolJbEfn3WVC4IvQtzoS+tMRNKqUV/jaIZnCk0pm2E7HYpURUwUQKbpZCleCfzzDFRWEdGe6KfpWNa/scLhRcG3b18jbIRwJJF7pSf+l6XzoaeCbsU6g3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUBuDgIJ57DMPnKsiY8Y6CtJk++3GkuLDb550VHRUOo=;
 b=QsObxoJe5OumGCuv26Owp5Y6JkNqfvCvh2ZozcWYAi5LAg2tVPWLSC2zuuC1+qDgK2wSKBxfQh5OA9qxV973cEOdgeoywwsB6kbtKKhCuZG8RJUq5QgPTNTg7WUSkAccmrsqQ16l7vmRyWj9V2TNg7vc9uDHj0SE8nw7QpVnmZ4DTd9Qyh57H1AQHyzLr+HvS8SyfrmRScuF3AVxxsMfgw86wFr+H8/uRe3/3wOXxXstoV1QjHdGsAkpGAFU9gW5AnedlDec5RGllGX4QLeFwAj0Bx7Oyh+k0ICCEdpmgzTaR7yomf+0gWr1vBmJ3V4LoXMjk9hm88PwiT3Cr0VqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUBuDgIJ57DMPnKsiY8Y6CtJk++3GkuLDb550VHRUOo=;
 b=GMpq20ygvPZPd2G3mTK//PIDeQ+n07vOcKnxOyv9SrOuRNbTke5QmDc3PyqOBCwny1wm+7OH6VmtK078ozonUxRrj3qTgHxaDK49/U+6X3xD/yMScEnguN6S+vNZruDzN5xlMh5aBrrqYqzMF1fok8LKm51XagEBLJ4V+GQt9PtTeEEP7IQcsjfYL84trncVxfWSLx5xG13fTgJ9tg+tJuIuYRFJ1M2SYNIaJj9na7c2VEaWZM8WbmRwG6lUk92a5TzFW9T7ndOoVpAmdmqWyfqHtQ4w1PLzjcuNFVe7rREauKuKYiY1u+0+r7iUSILk9H0iPW69KRXuuM+D78KVfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:03:54 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 01:03:53 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v9 07/11] PCI/CXL: Discover the CXL reset scope
Date: Thu,  9 Jul 2026 01:03:00 +0000
Message-ID: <20260709010304.680422-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709010304.680422-1-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0121.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::6) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: 736b9b97-cad3-4a9d-9d02-08dedd55f226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|5023799004|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	uNZVNaf3fjtO2rCEm82xF7AYl/R06Uc9bRpnP5U12msu6jNS9g+ehthptQpY9/L7S646lpuoqd94Ll6gnrzcmNsphWfL85cebiHu9xTmEA6v98eOV8s5fO8qug050SIQhycz793x/QtN1GDFjMftsq/7wip9O64hVGNvW/Bxy5gcJk0XLNyBaNMQiwh/8LJVxaNq1mZNDHmwN2GB97A3GlNO/BAhR1AoRkkR9KpLG5UFdnxFjc18sx0+uQkvThH6LIHl+ZmSLoTnKkWjNJ5z8KMFUcg4kH8CvfAJ3Y/i57ujnEKDSYFHHjkgNBVBcQiQJWgzk2m8Lg6WKry/cdGQdwTgehykg+xM/m6v3kbEOCwsNySsXs1bwnggITk+Hc0XezS2nPeWoUqewv9ZteXH3IvSzLP/rrfVRPh8uw97dVH7zQg2RGC8HYegEAbnnDREKiXEwTzobgLwQuLRSg/YrL9/uQfGeJWyPW84Ld9iNcJ+F+SMjOuXOhct7ZUihXW7OPb1+v9hh0HgjZA+GejbJWzHk7o6Kz57lcEwq2krOq7EFy4fB7mL4/Zz0Q4mXTT3LOq9pANs6AeZmPyzAdsOoyLAyOzLqVeMspJ+0C0jh1b87JgsPHCiTlfu0viWcnpqSM0CFhto/EIb8ioyHrq00O6b0onTbbcF3Ae1DjbhBM+xIhI5UfFIyrXPAtWg9UIj5L/G91qxODh/KAsZkq9fPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YowbrZlJ3nVXphKTc9+UU9rRSjNd3R94JwwVdqNTUkAv8mUgDZ7wVEGvF6d+?=
 =?us-ascii?Q?k1QkPmPKE0+AiizO/D7OM1UPXCe9zPJEu8ZgHed9zj+P3truSZpba5lEKK87?=
 =?us-ascii?Q?9rrvZGwXXC4+fq+WTfvI/cDHf4SoMBeTHzUM7yb25eKBW4cA9sXAeMvIVvbh?=
 =?us-ascii?Q?p7hybSZpYbDx4lOTX87E3bTHEfqRLbOElYBGKvaqoR4UN9ofXV5eh0EpGhHe?=
 =?us-ascii?Q?+QD4kVAoZ9k1lZNJQk0UTZCojqJJYtfYawOAzLvl5W0jWxJtq1yUGNeiQ1eA?=
 =?us-ascii?Q?P7tgoOBQ1z3O5/RECju0i2iPvkvR/oYGQySU59nKXwz27h6hKsRde645JGJi?=
 =?us-ascii?Q?vAVWNffhEJRqDHoEYU2yQxyBo4EF0dnhFXgUYt/dUFgfEpXZoh9NWyHzfcaJ?=
 =?us-ascii?Q?8XCxO/i809+RcRszg6YdFx7qlQq7+rP3pXn7BzMgB31TRC0GnyXxdfKgcLt2?=
 =?us-ascii?Q?OQjqkWulnIKuhHB0X+dTetj3jQAbCo+piFXBkypU8d5lHM+/I9SpT8LzMtGA?=
 =?us-ascii?Q?JGscUPvRjHr876taRtSM4dFfTfqNo4SifJ9XoJRaLf3qlLwbRMvsQltP4zo6?=
 =?us-ascii?Q?pQNs4koySHsqBEMrIe3SxTwXYD0TB2BcUoeptMkiEU6/f5DnOjHXgTPL+fhR?=
 =?us-ascii?Q?kSIBR+LmxUKy1GLF0Wx7yJcrhsEl8sJh9NwmKn286S03vXuVhjc1mB0b0h2b?=
 =?us-ascii?Q?vGm2qN8U010/Ckt53+jkXT8KwLzobyBna7lMLdFuykjDPE6LPdexaaTEGmQQ?=
 =?us-ascii?Q?GGz+p9DM68v/ZOH6NJAi3BGGEnrnJMgNLDbw+ur/k1kgLIsQud0QpBWBnv3+?=
 =?us-ascii?Q?hNdikzF7Dv4BCjRtCXSEHhPjq0+1c3v1kZ2gYjD7iab0q0Ut3go0tsBpE710?=
 =?us-ascii?Q?AyE71UsScNHs9hHIYPxz+a7ncjxRO7/N4NOzsvGm73fhr4GPfB8/XjR2c9bv?=
 =?us-ascii?Q?XZKIf4H64FjYcUh4sMGhm3b/JENsgqv2DQRIZ1HsE/fBLR99Q6d75g0ZS7MJ?=
 =?us-ascii?Q?Z6jyAwrvDj2wm6f36v9KzRq7ssEjGcHvNp38+sF9OpJOR4XsfNAF5t6zY4Ij?=
 =?us-ascii?Q?tWhQYbMpiDji6hiRXim09L5m4pvwfYogRATFX6xP6SxdUNFqIriVg0GfkgCE?=
 =?us-ascii?Q?zWuj1ZZe6Eb+mDD2yIEIkNNEE7h5hMukBp64MfEe5Ny0DLB1Svcm5w7Unxqh?=
 =?us-ascii?Q?RHD4izeFLw/6h9F7pkDac2ub/hoonynnpEskwyKnnA5ss0M6ZzFYHqVAxJEe?=
 =?us-ascii?Q?zayQXmWD7+IZ4Vxzygshz9ri9uHycUnElawpKdLN0x6JnxY6WCsCSBZUm36+?=
 =?us-ascii?Q?zrbevwMX/+EUDECOrT/KqEPJROx9P3jU1Lmb/jCYUlVWUVWfZg2GJdHrWiqs?=
 =?us-ascii?Q?0d/mcYRddN9euGKmizpC/zp88tQJaB7H4/y/2toDqMgq3SZKOJn9MQsqhfbx?=
 =?us-ascii?Q?eAraBdGYzv9slkrSHOeyZqAicpnc9derYB1jT8FGWuG2oVYMc8arf4q7jxPV?=
 =?us-ascii?Q?o0Xjkp909cFOFTWepvfMlt9wfIBDM/haCvoULA0nFJaFhRRa3kWy+WUAlAhR?=
 =?us-ascii?Q?NJ6nEEhUS73PcUHBgtlwklCJBZGIjkL3K3oYuYN21B5MKAsQPGwojSX8Ac9W?=
 =?us-ascii?Q?oVZ3Vb4HtamU/5gqcUltlEiAUMvPcOBx2X65SrPWqCCq8q6d1skIKzKD18q6?=
 =?us-ascii?Q?XHvf3V5NfpEwu3NyH+yUIXCuPhhDes3/+xCJnSx6L8I5j93JJ+WEfikf8fVN?=
 =?us-ascii?Q?1bmyhf5Fkg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736b9b97-cad3-4a9d-9d02-08dedd55f226
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:03:53.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ta1nDQg9flCiJl/B+NculG43BjvWsKfDtib9xcJkA1E07LfQYDfJSu3LTcCoCfjGFFRLlI9+Q/SR8KFZrddZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

Add reset context support to validate that CXL Reset is function-scoped
before advertising it as a PCI reset method. Use the Non-CXL Function
Map, ARI/devfn rules, and CXL.cache/mem capability bits to reject reset
when another same-scope function would also be affected.

If the Function Map cannot be read, warn and conservatively treat all
candidate same-scope functions as CXL-capable for scope validation.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c      | 152 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/pci_regs.h |   1 +
 2 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index fb741b66e502..cdfaa699583d 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */
+#include <linux/bitmap.h>
 #include <linux/delay.h>
 #include <linux/bug.h>
 #include <linux/bitfield.h>
@@ -469,6 +470,21 @@ static const u32 cxl_reset_timeout_ms[] = {
 #define CXL_CACHE_WBI_TIMEOUT_US 100000
 #define CXL_CACHE_WBI_POLL_US 100
 
+/* CXL r4.0 sec 8.1.4 defines 256 bits of Non-CXL Function Map. */
+#define CXL_RESET_MAX_FUNCTIONS 256
+#define CXL_RESET_FUNCTION_MAP_REGS (CXL_RESET_MAX_FUNCTIONS / 32)
+
+struct cxl_reset_context {
+	struct pci_dev *target;
+};
+
+struct cxl_reset_walk_context {
+	struct cxl_reset_context *ctx;
+	DECLARE_BITMAP(non_cxl_func_map, CXL_RESET_MAX_FUNCTIONS);
+	bool ari;
+	int rc;
+};
+
 struct cxl_hdm_range {
 	struct list_head list;
 	struct pci_dev *pdev;
@@ -480,6 +496,137 @@ struct cxl_hdm_range_context {
 	struct list_head ranges;
 };
 
+static void cxl_reset_context_init(struct cxl_reset_context *ctx,
+				   struct pci_dev *pdev)
+{
+	*ctx = (struct cxl_reset_context) {
+		.target = pdev,
+	};
+}
+
+static void cxl_reset_read_non_cxl_func_map(struct pci_dev *pdev,
+					    unsigned long *map)
+{
+	u32 words[CXL_RESET_FUNCTION_MAP_REGS];
+	int dvsec, reg;
+
+	bitmap_zero(map, CXL_RESET_MAX_FUNCTIONS);
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_FUNCTION_MAP);
+	if (!dvsec)
+		return;
+
+	for (reg = 0; reg < CXL_RESET_FUNCTION_MAP_REGS; reg++) {
+		int offset = dvsec + PCI_DVSEC_CXL_FUNCTION_MAP_REG +
+			     reg * sizeof(u32);
+		int rc;
+
+		rc = pci_read_config_dword(pdev, offset, &words[reg]);
+		if (rc) {
+			pci_warn(pdev,
+				 "failed to read Non-CXL Function Map; treating same-scope functions as CXL\n");
+			bitmap_zero(map, CXL_RESET_MAX_FUNCTIONS);
+			return;
+		}
+	}
+
+	bitmap_from_arr32(map, words, CXL_RESET_MAX_FUNCTIONS);
+}
+
+static int cxl_reset_func_map_bit(struct pci_dev *sibling, bool ari)
+{
+	if (ari)
+		return sibling->devfn;
+
+	/*
+	 * Without ARI, the Function Map is organized as 32 device slots per
+	 * conventional 3-bit function number.
+	 */
+	return PCI_FUNC(sibling->devfn) * 32 + PCI_SLOT(sibling->devfn);
+}
+
+static int cxl_reset_read_cxl_cap(struct pci_dev *pdev, u16 *cap)
+{
+	int dvsec, rc;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENODEV;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, cap);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		pci_warn(pdev, "failed to read CXL capability: %d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_reset_has_cache_or_mem(struct pci_dev *pdev)
+{
+	u16 cap;
+	int rc;
+
+	rc = cxl_reset_read_cxl_cap(pdev, &cap);
+	if (rc == -ENODEV)
+		return 0;
+	if (rc)
+		return rc;
+
+	return !!(cap & (PCI_DVSEC_CXL_CACHE_CAPABLE |
+			 PCI_DVSEC_CXL_MEM_CAPABLE));
+}
+
+static int cxl_reset_validate_function_scope(struct pci_dev *sibling,
+					     void *data)
+{
+	struct cxl_reset_walk_context *wctx = data;
+	struct cxl_reset_context *ctx = wctx->ctx;
+	struct pci_dev *pdev = ctx->target;
+	int fn, rc;
+
+	if (sibling == pdev)
+		return 0;
+
+	if (sibling->bus != pdev->bus)
+		return 0;
+
+	if (!wctx->ari && PCI_SLOT(sibling->devfn) != PCI_SLOT(pdev->devfn))
+		return 0;
+
+	fn = cxl_reset_func_map_bit(sibling, wctx->ari);
+	if (test_bit(fn, wctx->non_cxl_func_map))
+		return 0;
+
+	rc = cxl_reset_has_cache_or_mem(sibling);
+	if (rc < 0) {
+		wctx->rc = rc;
+		return rc;
+	}
+	if (!rc)
+		return 0;
+
+	wctx->rc = -ENOTTY;
+	return wctx->rc;
+}
+
+static int cxl_reset_validate_function_scoped(struct cxl_reset_context *ctx)
+{
+	struct pci_dev *pdev = ctx->target;
+	struct cxl_reset_walk_context wctx = {
+		.ctx = ctx,
+		.ari = pci_ari_enabled(pdev->bus),
+	};
+
+	cxl_reset_read_non_cxl_func_map(pdev, wctx.non_cxl_func_map);
+	pci_walk_bus(pdev->bus, cxl_reset_validate_function_scope, &wctx);
+
+	return wctx.rc;
+}
+
 static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
 {
 	INIT_LIST_HEAD(&ctx->ranges);
@@ -890,6 +1037,7 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	struct cxl_hdm_range_context range_ctx;
+	struct cxl_reset_context ctx;
 	int dvsec;
 	int rc;
 
@@ -897,8 +1045,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (dvsec < 0)
 		return dvsec;
 
+	cxl_reset_context_init(&ctx, pdev);
 	if (probe)
-		return 0;
+		return cxl_reset_validate_function_scoped(&ctx);
 
 	cxl_hdm_range_context_init(&range_ctx);
 
@@ -907,7 +1056,6 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 		if (!rc)
 			rc = cxl_reset_execute(pdev, dvsec);
 	}
-
 	cxl_hdm_range_context_destroy(&range_ctx);
 	return rc;
 }
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 9b24cdcfd648..761057c90f5a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1381,6 +1381,7 @@
 
 /* CXL r4.0, 8.1.4: Non-CXL Function Map DVSEC */
 #define PCI_DVSEC_CXL_FUNCTION_MAP			2
+#define  PCI_DVSEC_CXL_FUNCTION_MAP_REG			0x0C
 
 /* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
 #define PCI_DVSEC_CXL_PORT				3
-- 
2.43.0

