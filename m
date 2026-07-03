Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A103353A82;
	Fri,  3 Jul 2026 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116341; cv=fail; b=c+Uq9SEJNu+Y70HO7gWnedyHj3SLIPNShhtbEQKpY41uATctPighcZfvwo8iI7oY+fQET9aYD87DdavdgdW0QlHTmUTpD/0WaNM7NlYs37b7m4nxhqzVtVR7/wyf+v0MxsaRi/OwNCkZ4mwekYFuMC5pEdAtEm+zBLBMWlnevYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116341; c=relaxed/simple;
	bh=9odlhBFIitMNWM9wabmBYzj2Le3AdPHpnwulwhsCk50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jeSvLh5BZ7TihbSd+Tae/oAziDO+mpso9SHnDoOO4Tett9U9nJMyr/LiU8gpHNuzDWiRlgKaC/py9KJuzfOTW97AuepHCvPIwxJkR6pxQ3f+DPRkSsDLC0KA9J1Ukj1JD8edWJ5gPctY9Ih3yCm14D87thJmn/ouPglA0zaUZS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=byIekdff; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="byIekdff"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zq/csTbrT3598Id5EsCiRsVcKUgaHSJTflrc0QBICGQnsP4HqKaWEPU7B9MNyie+kyL2hxwHWHiaFIA07EBTUIO3qvdDAVtoi01rXKqEmG9Y+AaJ9YX1wDz6h62cqPj9gMC83PPbgqnG+7fW5YJ5Buxw5MXRwHhU3yTLXQ7DBax2r/4pZFLSrrfGHIS9QRYn7xwqFIi0bpk7c8EmH1vcoW2oAYULjvHt6mpBKYuvAkft+u02MX+CqP5ScbVOm/m+/ng6F/iHThCfPqdY6Cp6A2GrCPt7LwNybGGT78moA9u5H7Ptldjbgb/uh75SnAADHeHhodSLdaHIXthAIFiEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7r+WOuAfleyqX/U5ubZiWiXbsPANx4ReN4GmyXF0NI=;
 b=PBtcuZqbZhHgmJb8wLS7awgHiZ0dA7T8VHICUNX0EpNnyyZP981aLWovwUJPjsCrq0oixyRP2EHZF1Nmn9TVKaqt0sB3tjUvokVDH4qjOxef9zdWEUew7I0qRw9itOFw/D9R0CNSSPDGSnZ3sfQonal6kD4T3Lh0LTi5n2dedpgahNoq7Z+aVNPf95Ws5GDbcS1i9Bl7BUe2nGSLaageott+nlbWHgDtEnH3s772DnNjgHWgij2LVlqMMfXsQbmwCf3S2DorSFftbDC+jobXlKu2Nv/yKz6j7i0vMirbgmTnewH2ZSvHEj655UuOYDfT4714Iit/uXCqlJfxgIF5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7r+WOuAfleyqX/U5ubZiWiXbsPANx4ReN4GmyXF0NI=;
 b=byIekdffLXdcM6JtLcU+P1OHCRnCrR2UMqtzgU9LNiflGGEcRfuiDvqon69QkI0+Yza8z86R0RLWeREBMBPKSP1jW9yTPrPbXeO3UnxkcafPl4ATNeKa4w4kYxp2SPfZxCVEXa6GXvkj9bpLt5ZVbJFlv4ObToCDCGmPTYz3vk4+lEkU8UnnTGKsp8u3ZnSLAfxL8jz/KLTcuJ8ruW7ESP2SsHnF0SdaNS8DjYIEcRdqimLpmTGGMc3eS9j9PCLnQ5Gw9QfUj2n9C3q4kI0NyKp8g1m/rivoxC1CmrLOyM4dQthLsTVxvIPoyhZY6mO6sKa8Qm9Q7a6zv7izjwDcZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 22:05:29 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 22:05:29 +0000
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
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v8 07/10] PCI/CXL: Discover the CXL reset scope
Date: Fri,  3 Jul 2026 22:05:05 +0000
Message-ID: <20260703220508.546528-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703220508.546528-1-smadhavan@nvidia.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4791cd-3b85-4b34-4223-08ded94f3194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|22082099003|18002099003|5023799004|11063799006|56012099006|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	YwelEcnDUeHs4+PP2vztj9K+S+ceIhvp9o+cJQFDZW33D88USAHN00Ao6VmNob/LpTC2i1282F54PfCep05yhcBRVKoMSH67bYV0tjkO71cpr9YHYrk04gj+U8bCca2UCovHV9XYjmQ7RTCPfdDv5AfDHI5E74hXXpEkucPFUqMv85R0kHdLk9SHCYtc6P8jMuq18SbSFh9iLELYip+lcNvYxIgN7dOTYAEb6ZObqMXnmSt5bv3goUo8mdqIDcAtyXfSSTMss6oKIKmKCuMdh4iiz4SVZgNmSPBREVobIi/XstINmncBbfG7g37NiXTRJxCpsKbbp4r+j1PnJi2jpCRnUF5O3qFVZNIr/og6EMk9fAEn8F0gxjyH/oN/b9iI7pQ4ZSjuHfKn3XjH2+nLx2Jua1ahb/jZerlRRYFzQFbrJfDtVpaGJOy7waNLkhb2Lk28djy4fx8eMBBFEsAxUHn9bKknd5H3qT/qgkbxy34m7Jprif0GJOvBVb487NiJaW7JceSdFEodzMCsHWOxYBe0DLV7DVjTKXs9dn04lGcIeh9rFY5uqCqxmhDy2sGiyIhHzOtvB7jkaadpKIuhhmpBGxD2Gb8N6xZwPCgLVcmQNbO/Q0UD0ovw1qsAaQCf+YsYWCrf2jGf2169HuqCZwiCkuyN1HiWhblEXM9JkuX8rDFWSW3OoreZrWUUfjyvpdl2SC9hkb3zola/u6croQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hKZOgtinU0A2qbTt6+CsjY+KGLXLiCC0t4VqarX2TjhexDoGqklt1aV7Pi3/?=
 =?us-ascii?Q?+MZD/S55/e8K8otiou/0DTC//sxDqqCjRHgZaC1WaBTeJiSMNGyMG6C8lhA7?=
 =?us-ascii?Q?9JDAlXgCwnD0RsmFH3vrtZ5w5JeYlMq+fF6dCS/t08K0VBRcvhKfM53X+pPN?=
 =?us-ascii?Q?wCX0GowqN1QcC+MaEL0GlYmjOCwIRJ8SZMEyEHCj1THLSJxjoIigS6EIlMNU?=
 =?us-ascii?Q?EPpEvo6I5W9k/kyac3AMvdlhue69JSykYUTfdtSEXBql/pDD3lcM3bawgrZ0?=
 =?us-ascii?Q?lODLS8H3Z8MOEKRSL7nF1/5AyKerCGuUB/nTR4PTf7xijzSTaUh7jeXNLDUk?=
 =?us-ascii?Q?55UOrYXsIlUMI3duM548U0vIs+94pQSjEb5VgrHnF4v3//sLRShy/qsR5gjl?=
 =?us-ascii?Q?stMmX6LV6X/t0gRepk1kqtjqzcARIWJYkFKHTe518jc/3xfzMxfDZwYtclE8?=
 =?us-ascii?Q?BX+0X0coPiGS5rAWhBTp3wDmyhf4GtYcyBGUIOond7lE41bjrFw0NwoJy1QM?=
 =?us-ascii?Q?trGd05oJWWnGRrfof+0AjsbOAkgZK3ZT9jZrTMev+iMHGxq7k7+rhVwh92wP?=
 =?us-ascii?Q?Cvpot/tOSDDMNRMQBfk4lVUqv85w23LivRheMYFdfiXHQ5VW4ypgfe9Hph2f?=
 =?us-ascii?Q?iXtcM6HvS5gxN6hgtq02DpCwrtMXyv/YV6ZDJhqy+wqwxXBEv4VhTChrBJdL?=
 =?us-ascii?Q?aDn5BM3JsxPraC3rCvallAV+yWGM/gvQ4cITufNYHNHSZyWFsp0PvvSe2m2v?=
 =?us-ascii?Q?hvL9kzltllWjcj6iz0KyGQnW1U7XlOSLLADf/GW+Y1o4eSjAD4M6DTQN+g4H?=
 =?us-ascii?Q?uSduRDXpNNlDagWktmlhO/adY0ZoTYXV63G/D+EPuuBjcFKNN7J3i7m3NZ+a?=
 =?us-ascii?Q?YRkbHOrbEy6lPU1dqFPF6vD4eZRY2i6RdbvfzqylEV8t3e8gZLu0Xcuy/nkx?=
 =?us-ascii?Q?4Lk33ft4TjrDOFFUCGHm7/mf8UCxKrTGR8a0b5OYd41pVn237KaRXsP98UJq?=
 =?us-ascii?Q?5OK4ObrX5WNpJIYNrWQiBKZEX5JGSaVgNQBuFzzI/JsSOHNJAwL16C/L40Ll?=
 =?us-ascii?Q?ifOfZHs9BNkxTarVRgi5HXw1bNdQKHiKAN4ROabIWqotX5MVXsijC+FqNV5D?=
 =?us-ascii?Q?hpMXNgBo+/jj/8mdbuqjtIR50IhCy0bKxaOxLXXptMfqdfmqnYVAAdeuKI1u?=
 =?us-ascii?Q?PjSWA5asb7Gb0Ep3q6IBE+rl76yL/6nLcWvOFICk+n51AGV7Lrwl7ZblwKs3?=
 =?us-ascii?Q?G7VY+KY2rzXDHYixeyUnwfdNXhfIahgsx/jLbBMYhc7+INOV8uu6SMajnSKG?=
 =?us-ascii?Q?11TsRq2aJbdv6ydvuftWszmGJ1g9rk+EFenxXjDdyNDMY2CjNsACtUXY13K6?=
 =?us-ascii?Q?XL3+RnxEglkzk538qGhDaoATs88sXSi0SGEOXCmSee7vReuYiuednDWPNCUv?=
 =?us-ascii?Q?uk37MuI7qHmjhqfFlOSpGfdYejQYY5wkBa39ZUxeElhvWGdZxGpnjI2uNJc+?=
 =?us-ascii?Q?v01854c33DS/3ec3VE8uCUknnghQxjSj/atRr89VpW5SiZxG2Y03uhFlTtad?=
 =?us-ascii?Q?BqwMW+l5Fqjavahi2u2VnjI5YGBXEk2gpIxoPjFuDdH+g/7HFnGWebE+GdZd?=
 =?us-ascii?Q?p+iTGMDLvX7ozPQYnpxoLcy+d1IIKTW21gXhfkrFyn+RzO4xWMInNENfwo3r?=
 =?us-ascii?Q?z5lu0v+LjtufMjPKoe65V85O8+4aFEbU+GaWUvCdgcqR39JAfDT7cELnCdcL?=
 =?us-ascii?Q?PgBExqgAKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4791cd-3b85-4b34-4223-08ded94f3194
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 22:05:29.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbS26bmxJcVbScKCiCl6AHMJ1EL8iPkzoNYybUxRIuAUEM24L7zoiCwqmIVeUc2GNwHLA5SJJaOeXYpv717QPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

Add reset context support to validate that CXL Reset is function-scoped
before advertising it as a PCI reset method. Use the Non-CXL Function
Map, ARI/devfn rules, and CXL.cache/mem capability bits to reject reset
when another same-scope function would also be affected.

If the Function Map cannot be read, warn and conservatively treat all
candidate same-scope functions as CXL-capable for scope validation.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c      | 153 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/pci_regs.h |   1 +
 2 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index fb741b66e502..8e80e7588046 100644
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
+		int rc;
+
+		rc = pci_read_config_dword(pdev,
+					   dvsec + PCI_DVSEC_CXL_FUNCTION_MAP_REG +
+					   reg * sizeof(u32), &words[reg]);
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
 
@@ -907,7 +1056,7 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 		if (!rc)
 			rc = cxl_reset_execute(pdev, dvsec);
 	}
-
+out:
 	cxl_hdm_range_context_destroy(&range_ctx);
 	return rc;
 }
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 194ae56b4404..7fc1d34fcce7 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1380,6 +1380,7 @@
 
 /* CXL r4.0, 8.1.4: Non-CXL Function Map DVSEC */
 #define PCI_DVSEC_CXL_FUNCTION_MAP			2
+#define  PCI_DVSEC_CXL_FUNCTION_MAP_REG			0x0C
 
 /* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
 #define PCI_DVSEC_CXL_PORT				3
-- 
2.43.0

