Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6D2F7F0A;
	Sun, 11 Oct 2026 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684917; cv=fail; b=lFRB4OvhEfQAyVO626TCurvU0JCn3B47focnIijfMNTtyHrIN5s3wzRt7boUp4ccnQ1kqgI9/UEagM4BBWFhV1Wjtk4cZiTKeuPNZ3DIo8o6A+JiBcIFJeFN6pgsCIThXDfIbuJk9x0JZotAKAGD4PCxBeL72PPYz/mZPgTxWVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684917; c=relaxed/simple;
	bh=03yuIM+e3JypDxZAjolYCp0I8JPZ/RCZ8rPtTvL5VZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NtaIR9VGn4pBiImCYW9ReFN+SuvmjcuO49Ulj25tKnXxUrE7MmWMdH5LO4tb1u6kQsKgej55Vo4to/Nz5QoDTL/Muf4xKjTyCbvvrzqGL9MNoj6Wp7K2wBTxsvOAXPNL77cQgqK5nXMdBEfD/eXvQ8H3vELgqgh1QHqiIUmLkS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aGJhQ32m; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aGJhQ32m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Un+p8sx82MZqRllDHkNhtFFsao6mpyUD5wuGgS1vOqOlzyRDAv484soj7GV1I/uKBChCi3U3C6Ayrk/eJfBnUR8y9/CoppJ0GW5kWirYg2Guq0jX0KbP2o6R4lc6H3ylK8p4Ja+ii7dmN1IEDpVatZttPRBTs8fGieSAH+uW0iK85whQ6xFHD1Mx0NX0e5O/mLP0nkKRRmcqlgBZ7aCpzJ7aQ//S920OuxIKDG16taJHMdgzLmwoDdbDeNQWPjSNW/QRQCicW4OjgCIr6jYhsDU+EGxOmCk8/CjR1nI+cGngbSGLmejnRFMk2sVKxwcQ9iYEUu8e2NUyDtERczqydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDUikg5HUWEplowDNfxs+3JwysorYvXdNGiLouoPreg=;
 b=ZQcNIW5jAAvTg/F7Zkvmg/aODw9F7j98jOxu0KJWKccXqaV2ExVtjO1IpFr/LqX4AHUf+X31kzgu/K/59LWBGt0T1hgXBgxAGg8h+lGHT0ZIPO2bPLHJ2de41EmbSWzlG8L/SVDZbg1idQ2sXY90+Fr386DxpDsSm6yO9obK6ITHgfsEbQkCQ5YjULNAX9tZ5RLLA//OMWgUJbovwlP95R1n2C0BnFwxP2DjED1o62hUnknzBCOTAYfULFcKuSlq7RgYigw7y8oMp6kAN0RVlRdwZeIsZCAYhJ1zDrxlvNn+lu5Jp82/dM7E0LBX9xZl9BIlFEet3p/tYA0urL2JKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDUikg5HUWEplowDNfxs+3JwysorYvXdNGiLouoPreg=;
 b=aGJhQ32mBax4DHewBgC6vx02dPInYqqWSJr7xedy+211Py7NjyfFKuxhrClmkZQOOgLwlmKlxGpvqQm0Rpr2TfU9HQdyeY37fkoLJXU/upqIO2/0dRFGIgnjHgFq7v7jcDhl9EoAJznYJASJZKTt7zRI5c7F7pvs5Bnr7fLZtiHif2EF+16CuKku6XWjRR/xajFN5LEbV3Ek9cCRsGPARRnOxJuXgAP/qI6hkYtb0oQEaUqz3LmjnSjuTIfVc61nZto4ZPKZzNOYg4Pmr2torKQYnxMTFdoHA+HpmdaahULteicKZOPsGMlGlr2aADbbwYVBaaAeL40rLKpBCmZSNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DS0PR12MB9348.namprd12.prod.outlook.com
 (2603:10b6:8:1a0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Sun, 11 Oct
 2026 02:15:10 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:15:09 +0000
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
Subject: [PATCH v15 16/16] tools/testing/cxl: Add HDM decoder range checks
Date: Sun, 11 Oct 2026 02:14:22 +0000
Message-ID: <20261011021422.3428136-17-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::28) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 1610231a-8dda-4077-27eb-08df273d79b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|921020|260925021911599003|56012099006|261009223027099003|10067099003|11063799006|260925022911599003|260925021311599003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	soJ3+ZDgsztAEfLeXFlVdossnDaHl47H0nU5TmUi9QDxvYR7fJuc5AeikB64N2ueUVKxTkS9E1gHOX2XDin5AsT0r8MvAoNMXGA/rYAQXCMAUeXdrUdZkk1MAMjF83dicm2Dw2FM8BWSmaSG4MV9xBkBbV/9vpp6hOqd90qSv3gthQ2J0WKmtGQlURrbn7IMrPVTL0zRVv8Kse6m/I2Lu7uOh0lZxwfTJustf1UIpyHmUJ9RFcJ/mydbnPcRUkIcll9BJ5WEEj92TjfhQVevWxgQ3OnYB/SdvcZ7apCYrbhXXOjeE06AikgP4ZLUxKBxgD3GOhfz5dOpbTC6RqrMaH0nX/jk+XE4NzMdoiwVlH1HGtsAT6VNMFLw+mIfDCqmSLYTZPtYQ6wpe42E/Slu+Sbc6o9Biimei2RkAtDIsZA2zdXiQmombWLC1caIjW52vcFU6uSpv6ZJcWtg4aL1tRsgHJeFSfqoOBuO1NmFPK/vkbYDox80Fz+5EqI3XhwGqLGhnljRVBD2lVj5z772kQlMmX51z1Sdv9osWtAnK5AsJCHOkSyTFK2BzfgCvWezXMQYL50Dmp86Doa6tBm6mREdtvS+uoCIMqfV+IfSDFFWNfkHk3lVkMHdVT1RuXviIupb78FJ1hNGJDYL5EqkXBGHTS5SSjYbX+/t7nXgL4YQI0z5tK9Mpvxg1DPDv57WbfT+uXQeDIWR4CxBU2Pi9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(921020)(260925021911599003)(56012099006)(261009223027099003)(10067099003)(11063799006)(260925022911599003)(260925021311599003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xJ3LP+c0Qjuge01BxbODEWfYQnWTXVuHrFZfcPsRZelw4vBFHEakqL44CtnK?=
 =?us-ascii?Q?ExLFRE7yi68re4syFBgArmcq4rZye9ojHAGnuxBzg3aSIFfTWVpVbKbDmWXQ?=
 =?us-ascii?Q?0SuPM3PDiIiYu3gVg+3f5BHBdN6r4Yj+BdoElW4b32/Z4ljOgGzS75g4Y4Ms?=
 =?us-ascii?Q?QARoBrkSQVEufIpNm/TYc9QIsdl3xrxQGhVastOL2dlrJLrH8/2smi+GqZwW?=
 =?us-ascii?Q?koZzPs2lKmYCMMiKYqUF47oTIXL7AtmtyC5k1PhT3uQS6T4S4jEmlPA3Pv3H?=
 =?us-ascii?Q?snR781CNeJyA7rRe/GLGl1oYALRENOy7+qtRf2DltlECtspEOIerYnaf80hP?=
 =?us-ascii?Q?thwmOnqVK3g1DXpUSumUfC6nfv7+whmidziUi535Cw866rjiecs5HcSHn9jp?=
 =?us-ascii?Q?4BdsEww6tRMQEhQlfJXUQBcPG7lJC4evVlcOVI1NZENvpsx6XuXOr/JXucdE?=
 =?us-ascii?Q?owVHr1Fvv1esUAOwHSu3PTibmOlYXuvLvtd085Y9k0lzuxW3JCjgUEKsHknT?=
 =?us-ascii?Q?CNWmZkZadBMNR/9wtz3jNAr3EBSWRzbXtcyZy6pebidMZ3Wgc1L+3Ma8FzvO?=
 =?us-ascii?Q?F+TviBHaRpAIUqyrSmD+4hrZlg1N+zuVTU6rpm/ZMnZWuzXWA+Dhk3D84QbI?=
 =?us-ascii?Q?3vAGt2J/A9z/Gf+S42Y529v8pHZVHnezV7o0sK5DgtVdzQGeIu2LEKTEnwiM?=
 =?us-ascii?Q?UFR7IgKm8SnGbOR0RjTKeS4vI07/T2JWNvs+b0dvpoMY9vSGDRksO8koFtiC?=
 =?us-ascii?Q?uWJ161V+HaceXYCfpl86RJ778BmTiI+kKjexzVjzswxtLqEdmflEWKJZX4Yz?=
 =?us-ascii?Q?kMK6GhY/wTCfCa4SxUj7xR7h6E2y+RsLu7st+6jhj6RdzE6OZ86Jq0p1NvxP?=
 =?us-ascii?Q?CzdoQbYJHXGNWYdzLssUFma4yDH09SVyH06UgNQE/+K8ihoYpSSEbEsfAJ+Y?=
 =?us-ascii?Q?AfODze0FluML/da0F6jbDd2wpLVEF6tAhjd8gIecw9CHIRhSjZ9aGt4OIzi4?=
 =?us-ascii?Q?NwOPJ/vFJvRPdiIPQlzFsPdlZ07zGsUkTuxpDXIcBuVDSew8MlOddHs9d54R?=
 =?us-ascii?Q?BYmDfnTdDhh+ReW0MZxI4SHuZoyhiRBkH+aEiUAh7/h2eda+9/OLUhA4yVCk?=
 =?us-ascii?Q?X1TmtVmyoAt25AZCwIC6Mu34CaW5EMBLvUzdq4/hBPTLYcHZvaN6pDqzXf2a?=
 =?us-ascii?Q?3qgRmqTfaBP8oZtwanbXYAjMGVnjVK+SyhIW+mSD4yyKsEOobuRrNTQk1oXp?=
 =?us-ascii?Q?bRPT3h8b0R/iRC8K6rLJKT8ho2CENsxCfZ7Pvcom5v7R+xnGzxcU5g4ZvcmZ?=
 =?us-ascii?Q?zgPVb3HLsczpXaHPmkE9o3FtXEaOsmYM3iGJCIhZQnn5dE8V3jpxMPjlSmwY?=
 =?us-ascii?Q?NwZg0tX+YiZi+y9RIYIpIDTBV4DOw+6P+nFyAL0PZy3BNfdSLiEdoetjc8GI?=
 =?us-ascii?Q?1O1/iYjCmFehG2c03MCf+dUS75FFpc+ZLJMZx3niBcHSUokmylBTtNXdMT9V?=
 =?us-ascii?Q?BKLTunEsoImVvliSXTHJ/BApdP0iqehheaXHT7cxGNWH1SkbiqU9MCMxEgU9?=
 =?us-ascii?Q?wsUFmX/bsJyNMvOLpsNijoCARKC+dUPB9OrLMs05raj7Rxq5yvlEks6TOyWS?=
 =?us-ascii?Q?dO/OfkyjITYfWwsky/iDCPk/PleyTUEMgyvjY4oNh+u0ssqmStE1+6gSgyUF?=
 =?us-ascii?Q?sgI8+IPXU+ZSoMsc0tJmkqrRm5MvR7vXqD2sJ8OTXN9PJRnLaDZcyQh478VI?=
 =?us-ascii?Q?N9qXm3qQwA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1610231a-8dda-4077-27eb-08df273d79b8
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:15:09.9022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJ7lDRvUGhdr1U21TkNesUxbSkIp610MdRToDd6pJ76u49B4EYqLVpcFDQmzsrQBgyPx3CtKUs018vVNNuSObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348

Test cxl_hdm_unpack_decoder() when cxl_test loads, failing module loading
if a check fails. Cover range boundaries and overflow, an all-ones base,
zero-size and uncommitted decoders, and a locked host-only decoder with
12-way interleave. Verify the decoded fields for valid inputs.

Run the checks separately from the watermark hooks, using a helper
exported only by mock cxl_core. No PCI device or MMIO is needed.

Cache refresh, retained-state comparison, and reset restoration need
follow-up tests with additional mock support. These checks do not cover
reset sequencing or hardware cache invalidation.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 tools/testing/cxl/cxl_core_test.c | 78 +++++++++++++++++++++++++++++++
 tools/testing/cxl/cxl_core_test.h |  8 ++++
 tools/testing/cxl/test/cxl.c      |  5 ++
 3 files changed, 91 insertions(+)
 create mode 100644 tools/testing/cxl/cxl_core_test.h

diff --git a/tools/testing/cxl/cxl_core_test.c b/tools/testing/cxl/cxl_core_test.c
index 464a9255e4d6..8072146643bd 100644
--- a/tools/testing/cxl/cxl_core_test.c
+++ b/tools/testing/cxl/cxl_core_test.c
@@ -1,6 +1,84 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
+#include <linux/bitfield.h>
+#include <linux/sizes.h>
+#include "cxl.h"
+#include "core.h"
+#include "cxl_core_test.h"
 #include "watermark.h"
 
 cxl_test_watermark(cxl_core);
+
+/* Exercise the shared unpacker without HDM MMIO or a PCI device. */
+int cxl_test_hdm_ranges(void)
+{
+	static const struct {
+		const char *name;
+		u32 ctrl;
+		u64 base;
+		u64 size;
+		int rc;
+		unsigned long flags;
+		int ways;
+		int granularity;
+		enum cxl_decoder_type target_type;
+	} cases[] = {
+		{ "valid", CXL_HDM_DECODER0_CTRL_COMMITTED,
+		  SZ_1G, SZ_256M, 0, CXL_DECODER_F_ENABLE,
+		  1, 256, CXL_DECODER_DEVMEM },
+		{ "overflow", CXL_HDM_DECODER0_CTRL_COMMITTED,
+		  U64_MAX - 127, 256, -ENXIO },
+		{ "all-ones base", CXL_HDM_DECODER0_CTRL_COMMITTED,
+		  U64_MAX, SZ_256M, -ENXIO },
+		{ "last address", CXL_HDM_DECODER0_CTRL_COMMITTED,
+		  U64_MAX - 255, 256, 0, CXL_DECODER_F_ENABLE,
+		  1, 256, CXL_DECODER_DEVMEM },
+		{ "zero size", CXL_HDM_DECODER0_CTRL_COMMITTED,
+		  SZ_1G, 0, 0, CXL_DECODER_F_ENABLE,
+		  1, 256, CXL_DECODER_DEVMEM },
+		{ "uncommitted stale size", 0,
+		  SZ_1G, SZ_256M, 0, 0, 1, 256, 0 },
+		{ "locked host-only interleave",
+		  CXL_HDM_DECODER0_CTRL_COMMITTED | CXL_HDM_DECODER0_CTRL_LOCK |
+		  CXL_HDM_DECODER0_CTRL_HOSTONLY |
+		  FIELD_PREP_CONST(CXL_HDM_DECODER0_CTRL_IW_MASK, 10) |
+		  FIELD_PREP_CONST(CXL_HDM_DECODER0_CTRL_IG_MASK, 2),
+		  SZ_1G, SZ_256M, 0, CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK,
+		  12, SZ_1K, CXL_DECODER_HOSTONLYMEM },
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct cxl_decoder_config config;
+		u64 size;
+		int rc;
+
+		rc = cxl_hdm_unpack_decoder(&config, 3, cases[i].ctrl,
+					    cases[i].base, cases[i].size);
+		if (rc != cases[i].rc) {
+			pr_err("cxl_test: HDM %s returned %d, expected %d\n",
+			       cases[i].name, rc, cases[i].rc);
+			return -EINVAL;
+		}
+		if (rc)
+			continue;
+		size = cases[i].size;
+		if (!(cases[i].flags & CXL_DECODER_F_ENABLE))
+			size = 0;
+		if (config.id != 3 || config.hpa_range.start != cases[i].base ||
+		    range_len(&config.hpa_range) != size ||
+		    config.flags != cases[i].flags ||
+		    config.interleave_ways != cases[i].ways ||
+		    config.interleave_granularity != cases[i].granularity ||
+		    config.target_type != cases[i].target_type) {
+			pr_err("cxl_test: HDM %s decoded unexpected state\n",
+			       cases[i].name);
+			return -EINVAL;
+		}
+	}
+
+	pr_info("cxl_test: HDM decoder range tests passed\n");
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(cxl_test_hdm_ranges);
diff --git a/tools/testing/cxl/cxl_core_test.h b/tools/testing/cxl/cxl_core_test.h
new file mode 100644
index 000000000000..48392759cd22
--- /dev/null
+++ b/tools/testing/cxl/cxl_core_test.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+#ifndef _CXL_CORE_TEST_H_
+#define _CXL_CORE_TEST_H_
+
+int cxl_test_hdm_ranges(void);
+
+#endif /* _CXL_CORE_TEST_H_ */
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 034d3a923b2c..5e6e9a8a21d9 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -12,6 +12,7 @@
 #include <cxlmem.h>
 
 #include "../watermark.h"
+#include "../cxl_core_test.h"
 #include "mock.h"
 
 static int interleave_arithmetic;
@@ -2453,6 +2454,10 @@ static __init int cxl_test_init(void)
 	cxl_pmem_test();
 	cxl_port_test();
 
+	rc = cxl_test_hdm_ranges();
+	if (rc)
+		return rc;
+
 	register_cxl_mock_ops(&cxl_mock_ops);
 
 	cxl_mock_pool = gen_pool_create(ilog2(SZ_2M), NUMA_NO_NODE);
-- 
2.43.0

