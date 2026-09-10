Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAC53D9538;
	Thu, 10 Sep 2026 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024144; cv=fail; b=bPnJSP6pptrJmbDWKfIbWdRJSrZfu+Y9cJ2T9jqF/lrN8dJJuy2nN3NY24FR7DgsnzaOvFtrXUvcl4NqxXQaxVypp3do9uzZ7VJUIh/mIYt/q9N7ZpxMmV+xt7fYHUvCVhGY0O8UzCZm2g8zOhEzONdpvJupC9ajgN8YJhS/bFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024144; c=relaxed/simple;
	bh=VvHirXnTflv67ZIXepKGyF1J/YCX4Kz1p+/DeXzSMIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKqz0wLlNRNEN56TTBewJAWs3uzhX1CsgusCON8AtyCs6WyfSikd+0riQx2HluPtwz1fi5wcAfcol/JfIYRyl3APqdgwSQF7iA4KRfzQ9Jd2INcsE6FTZ8JHI3bsUuL/qc6sKaNL1kUOKq+70325TtVXBgIK87dejW2bOusT8zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J767DxZ7; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J767DxZ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrOY1T/wSWx8ezFxhdHALtG0ImWD3DvCyAF/Wy0xiWBqipR2UmNwJ6txk74MrYdrzoHM3FuOG7i1f0GxEzSAE9frat7XjV2RlD9LME5PFCLKuPZRBvAJlLUkBQz0GKuorca7PngHHRhGMhakSlBiGHl3GdYzzBVMXP8ZB9QGZMB3MPhrB7Hhnk1drgWaMH9ZExMdDxs/rwD1nMd2wo8k+psKAuOJ/LeH4r6Xw1OMybNF6u54mSmQdrb8X+d5bfyga3bKXb2PJvIen54SK6OV/q1VIS328Jjbar0OoCv0tZGXl6ErrtCNbSP0ZZ7C6kTWRCJazQZnLG2G3bjqfXpn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtNmnkKYLn7pETLra0vtoiZriyckIN97U5O1MazZwR4=;
 b=ImeQVSmmnWLyv9ku78drN0oA1fcYN260VTJFQDJqMe25vyqdBSjwewIjXKKGpYDDHQRWmhecE67wkxqVL/1uDuVSbIT1wB/TTnubeWSKJASz+FXCoZyYXOQlKLRnl+8QEaGq8yiqodhyZwADzSJuq3Byqh74EmbvWY6lCr/BXUUKyTRYpznVu6gY8FpHrLx/PgPMUkvADRp1hQuTAFR3koEok66i+gijwoNhY5KdEv70/NJ8wX2+fnBDJF9dydHQNpoHQkeutbs1yTX6rohrxmnQVAd3HAnV81RKodJfkJ+IBGlxkTPq4tuwtUWmumhk2+Vxd96J13SNDJ53mraDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtNmnkKYLn7pETLra0vtoiZriyckIN97U5O1MazZwR4=;
 b=J767DxZ7D92mdhnaIDEWoXR8yAQqyFaADFbvnlYB/52doqDtXO/Qu6nGsafVxSovSqC49nlu+RyKuLtHOmRxhTS/IQ+G6drcvmZReVhhx3vaBTISfKuQ7b+vec38AnQVJ9gaeuvcB5dQAv5X0ftzRrlzoxxP1BZAODoFeHS1OX03N4kiHec+vf4D7IrOMYJq7T5y5TLSkjY+fp5tKb0dhrcQqqY2Fj9iGXV4fWWYIspvGjq9IHZfkZD7Truwq8fU8ysl4o22/FOKflqbpUVwTkyJJxFI45R6vx4YH7ZvMRqQtJ7rDEGC2yVUc9JhsGkKAiHLWjeTi9PGi05e+212JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:53 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:53 +0000
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
Subject: [PATCH v12 10/12] PCI/CXL: Expose CXL Reset as a PCI reset method
Date: Thu, 10 Sep 2026 07:08:06 +0000
Message-ID: <20260910070808.1444264-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b20886-c6f2-44e3-bced-08df0f0a5f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	aEDdxzlf7ijMkwbsvEkZorjCCZMXW5e6HAgIbw1QQEowUxXf/KcoBmG2DjBgFpj12im7ziijPy4Ehz3KFQ/QsJuOEC2IJoxhG6SrH81T9zSkHH+yeB0tBPtdJfm3flxzNTNAhOZNkDwtvHe+DtsybUy1H27DuVG+/Xu3BqPP4nGPhnUuJjSgq0YB5Arb17DvuHFgUs0towqWQGD1yZEDB/2lNimnnBw2Bt3t4aXXr7MyUMOMgshCLStpVH7fGq2DOpNi6fcJPZJ5+ZaW+7MUH7dvhA1s1pqnMOQb5vWfPgwfPU5NjoBmz+sSyaEWXJ4yo6e3Fzpsik34la4/fyUsaWnF0M6djNzdVIJjKAnHiVSBxwMAnwp8HsYgTy/Hmsy9fiMsQjDYwON2XakzLvwDSIkLAFWE56mZhM4gIycj0PfBdEFrA/NMFyz5Ki1jSTcFJmECpHmM/tzllI4c/+H3gfvLijiQ4+XfHVfYfwBFjMSeqkDNVEgrt/Pwh0n4PdxMYt1mrqGybzNNR2/ft21k88BIbWIDjYPRoXnUcDCyQMEyumCv9yRsV7TDOWwNmminiwerhwUTlCPcldlXrbbFRzVUnqFjv6gRfTHHVwj19MauZvxemaq+GPTrzRuj5F+G2aNtGkZ2P6o8u6+RT/cYtopZ2v0Z9YenOizZBpPpdsJyEYLP9e2IK9ZIDzFu57VoqLuZto3x1peTaqQ+a0mCJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NOsgA76eelcYIlLDIsHn6JPMMSjqGaujCuE+idcRAUjUcY5dzE7xaTwlVdM2?=
 =?us-ascii?Q?ZVrJNcWrYpDcvPLihFUd1abET69NsREXDL/4+/YIPWAgX43J2wnoF/3fdGqn?=
 =?us-ascii?Q?0Hq7peS45V/dhi590AwZrWZcawC/QEMF7xsmZ2xT+4D116gbYM9S4rMt1nio?=
 =?us-ascii?Q?PecLQSW3Txn9lWyp9MItK6B6i59TahNdbWHtHSjUBEpcv0r4nE8SRF4SNTB+?=
 =?us-ascii?Q?wvkNKYv26nHCKRfoCmjoJ0r0/xucV3Jab+/plnmZ7po1ry31ecP955xTHOlZ?=
 =?us-ascii?Q?tPiPVm2LxPdtTC+maQWwYzY9cux9cXbyPcWMVRMoT2XeK/kAe3a3DES2zsfK?=
 =?us-ascii?Q?Ei3UfxdGUgk+qRiZqldHI6uZrEYtesFZGIpL10+yf697RMLFKNC5jZdTqp3e?=
 =?us-ascii?Q?UqwfedAfq+SYGTAfXBKEGtFciOMhogCO0IQHkKOMNxIJkV+hY8P5zwreho4q?=
 =?us-ascii?Q?QH+J2A5jHxJDxKLTJxbrQwZokoLsC1xCnEoAFFcX2UKPOyGJQs15tZtO79st?=
 =?us-ascii?Q?ZVQnQkG/dQOWdD4vXG2aW+z65gJqQ/qWEcnGfQlgWiTXB9hVgT2zFtP+rI3L?=
 =?us-ascii?Q?AzgUsZFS3B4s0ybaknJN+x4YSuMohczie9Smv9q+9E3WJpoR02WUR3wQLFbI?=
 =?us-ascii?Q?Fszz335gEbsSoMETf6Gslgc99pWxhldGUKIa6cTSE0qAFtprIVQW6RVEyzHv?=
 =?us-ascii?Q?N+8vPyzlMRTyB+oznT1TNO3pfQ4+qH3qF2OMqze5Tzb25ZmQ/07jVdnwhUZW?=
 =?us-ascii?Q?7mt0LP1PzqNi56Doq4j9tmdjEI87Ggo0SYReTZ0mBgrpjhiIUmAPVWhrp+n6?=
 =?us-ascii?Q?/3xneTUyM13SAeMc2Cb7aSoNoUMfInIRLxsWvYXXAIt5zOgTm5pFj2SA2aNQ?=
 =?us-ascii?Q?CfwzhxRVZzwAJurAeRV/J23TB6RcYfJYBPzXP2nnjB4VC0tD548HBKe1PxIk?=
 =?us-ascii?Q?8CywSzoKLTH2jv5ndqn6ZldqdSnXv/jnAp7f+8z3ysU6ClIMiGZ+TFheRN4M?=
 =?us-ascii?Q?Cl11hBBkkhOJtmu7FPBzf0f9xzEeJplhQwSyR9pSKZ6q9vGzrUUPQ1qtBWQG?=
 =?us-ascii?Q?F6QaElZvtTJk3H75ZrczFepedY4Njo1kaSExO+NqEvhNwHVFVNqHvE8eVBZj?=
 =?us-ascii?Q?WaUhnPMu6b9TLJdzhqMOcnKpecTxYmvGDLBBLDaneiu2Ubm/GtNxddfwfDZ2?=
 =?us-ascii?Q?7gLv/zMZMRomOGbNV5LuuvITR/GAhoor8bdsyC9gE/6nVZkFl1Z+45Pxhzcp?=
 =?us-ascii?Q?A4RypNTU5L3e7Rtvo+r7S1oHazJeX36d1PC58lMuGFGW3JXTuAp8gUsdvY3/?=
 =?us-ascii?Q?LF2YHVvQyXqPBadL7FywqtpT6Lt8GDAF9ex0GotERtAyxukFlw39tZ5jT84D?=
 =?us-ascii?Q?XLBcGjki5lDsLe9f4efOQp8u9pMEKq7f7nW3eZAE+vdJ/YX4Imgk96GRbuue?=
 =?us-ascii?Q?my545aqnA70IZMmrph1r+PIpC6GcfVB+MOqlWlW9olcyGDJsIZjKyTxFTi+0?=
 =?us-ascii?Q?ZHMIef7s7liGGhKBkMfzKYqtS9mYly+lo1kXO+CJgLHLGXAks/tCxc4psvCq?=
 =?us-ascii?Q?0Gy2KwtxcFKAcPH0+bjxb14P+kSQtCUfFbOXqM3a3y9jT1lILfRlbo8833OS?=
 =?us-ascii?Q?0MClPfN0G8yzueIsyhBh1Afn4zNe+R1vHAH/PtrxRPRwYivv8kPaYOWjOp1F?=
 =?us-ascii?Q?lwsPC/tEH7wj+8w4i5xTSJZFMlJz3x6NGrGbweNkuzwV6TRnh4BbhlZeZkUC?=
 =?us-ascii?Q?BEkM9dJvGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b20886-c6f2-44e3-bced-08df0f0a5f15
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:53.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9WnLud5cGV4bxez38pqMlb/jHe01313Z/JfK5/nH/LQdsF0lERczBduS7PyfSAuOdxpOvB2VeYGUUWns5nmig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

Add the CXL Reset helper to the PCI reset-method table so userspace can
select it through the existing reset_method ABI.

Advertise the method for Type 2 CXL devices that report CXL Reset and
CXL Reset Memory Clear support in the CXL Device DVSEC and pass the
function-scope check. Reset execution requires cached HDM decoder state
for the target so affected ranges can be validated and HDM programming
can be restored. If that state is unavailable at reset time, return
-ENOTTY so PCI can try the next reset method.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c   | 2 ++
 include/linux/pci.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..157f06c576e9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -35,6 +35,7 @@
 #include <linux/aer.h>
 #include <linux/bitfield.h>
 #include <linux/suspend.h>
+#include <cxl/cxl.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -5145,6 +5146,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ pci_dev_specific_reset, .name = "device_specific" },
 	{ pci_dev_acpi_reset, .name = "acpi" },
+	{ cxl_reset_function, .name = "cxl_reset" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 84d058b1b492..074767c7afc4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -52,7 +52,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
-- 
2.43.0

