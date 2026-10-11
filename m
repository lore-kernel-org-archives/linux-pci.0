Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193CA2EEE80;
	Sun, 11 Oct 2026 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684908; cv=fail; b=ZMpEOWH2tEn5O94NctZ8oN4/WtVFP1sEUotWuWxLOXaslRVjbeARmE6/2daYMl5UHf+sv+58K4IzO1q+q6zMLS6hTeF7spbO9THYJaReNLmBkRele0gPak5L1EnpasECCjdHPxn9Aw2bzvmsg7k1eO6HBzZu1PL7WzoCLYKSdkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684908; c=relaxed/simple;
	bh=pwuxk3oT6AJnCThEslaeowB4YlDkRecm1WB3020QHGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3tWDTYKzg5yS+bT7s8mcqR4eAlrEmSqaLHrRyxkZs8OGSUYWr5LePO4e7M/cTtH0K9g6JVJO3KaDCLtNfd9WzfPztyLBTnbCQZoj16Re7vUxhCuH8cvUCz1izsGvxAR9m5tWV+fKY3EJC3/09B/39YMwNbgHDQGPovVYW0QMyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EoEdOCkf; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EoEdOCkf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwMEJ0FgLosLDHM7IK8g+dr6pmAeEJF1832ciC6zTuxhIDYjy931FrxBIZ+lHwhVE47eRSJrm/iR6SOX9esjYuJFm2moZYwgNaMHDQB6UTyG+VxIV7odtlZFBx1mc2FBAg2/6gFlI203PD2evBZT4nM46Fxuy9E9GBggSpnLHak8GKeeuKN1scN+u0X90GfQFcBVBPJKeCjyoT3X/6IpmQCyNurm8isUyp5VdUf5wtirSFyzNqBwub5RWV+Qz0seZXTp0IEPRbjZwa2G4t5LjV+sYHG75Xj6+fJjUvT1795cfq/aY9fww66i2NnGDfsaTLG+x5vRYfz3SmjPM6PL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZF3tpXWM4HFwFrDGf/9v9Mm3W7pK+Y5iyImdNjT3Ek=;
 b=izvfj0extPKu1yxUZTlyICgIDAMqMcDNlMKRDf7+nCw9iEdOQNnDBBBJP+AbXcbOW6mpkbe9Tv3El6nk8PUE6M5Be3NjbgqPMlJ16twqoGj8Qc1sGd58vofas8hFlzkxlP3FKYePUYGXwFeUnW4PS/QMhHmz+tddSdoPNtE6V6qjVXNzduXCoT31P8ZSAf4Xbmnup/TcccIRjtBLwC9WErXOAw6lxZEpytWu5U90jME7egBSq+g2TDr2K/E8JZD7w1L8LpTdbDrrjB40dSxIkVkDPfP8dorcjKSZULVE5SIActS7re1ytZlXakXspHpW/ZNNE3xd8astjoTCemS8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZF3tpXWM4HFwFrDGf/9v9Mm3W7pK+Y5iyImdNjT3Ek=;
 b=EoEdOCkfGcI5tiC6Fl59EB6WxZT4ov4Pf3XFK/onpcS+GqH2Fz5kWfAdfCydpINzLQV3ITZNnY0Dq21VFzpJQ9mcUjS5rCOj7qoh2+MQhDfvvEqevq3jjE8S4P9EG3clvBPQ4ULyHo47W3w8iuhcGz9kwlpcWJscQB8NY6m1gkhrUI8yeU5AGHX/7L3n+iY2+5E1FrrqWNiFYfwzqEaHvA5eYWnV4jakJgU2f5VOaI4u2qhdy6YzypVzBTTazQkfnIjj+90Cn+iQx0Qk3ntxNG89FonWCFyjjiAVV4tCPP3aH0EafZo4DCevavQGsHvY7M6BWXZZuN/q+RHQsigd/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:14:50 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:14:50 +0000
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
Subject: [PATCH v15 08/16] cxl: Refresh cached PCI HDM decoder settings
Date: Sun, 11 Oct 2026 02:14:14 +0000
Message-ID: <20261011021422.3428136-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0324.namprd04.prod.outlook.com
 (2603:10b6:303:82::29) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 07767f2f-2128-46b1-49e5-08df273d6df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|3023799007|261009223027099003|921020|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	r6fs4+Esi34+4F7a1EECq++xPVHclD3oo4ho64ZCBCC6q/63R86aG2OFvhnvLi6cM6M48yV3EugVS/VVu5/LFV5iwaIB47VKyRc7RD62aom8uNz1tpkLv4XKmAfp4Iv2Gx5JfYZZ1047OYvb9V3FHkDwK94pts9C5O+ST1zKZfyf9nPr7dUCP0UbmhnXutl3bmncQolI1GCmiNPTReWwS4m6MxNI42hVvqKRsrHhDLSuAdZKd6XtecrkmGzI1a2mCkyB8WXdlE2GOq2UiI0IaouQ7AzPdONxQtKHjovRXkEbD7pNWeBa/Vf8cTs/A0Jhcigf8AikogLppj20XD5vP34nk6uZ0KMDw0GQ4Q6AT+a6oCFHIGBogukKaBDZv7PQ9z/2nKtrFnYt1aGEKpDgnwvDPvrmFcW2opFIUKxGP0/gDHLI6J3cpiL7LhYKkxdV5i3Uwy0BV7YDGm+oh8kLkI9q0LrMmdQr/aWH2fI5MY4enmpcvHOPSEQvY3Efpgy/MKCBF7wM/q49GY3RzIJIkTCc88WX8+3QlSauGxgvH/+m5Ak8CmXtvUiYjMPwYAgZCG3Z/LNpPt/6k3ih0D2HLUO7fQcUJQltIvYcK2ufL8d4Q+gg5+nJs+N7uVqjqWzYIaNuFAhb2lHp+n6bjZalbWlaq7ULu3T+I8KFobDIt5DVnZJ2Y5tVJlgqz6f0yppu+MzBSYrCrOqDJOqnNTJiRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(3023799007)(261009223027099003)(921020)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hF2xY6QbipviMj9x48ofMoQVM3lAJuSR7X/QPPrdJdfoN/Ozk8jHGumusmGf?=
 =?us-ascii?Q?TFPT9q1cEfyJrNvC4dgvspAtgtvUEepEH4XwTD8AB7toQEYOr1vG/jgQE7jl?=
 =?us-ascii?Q?l4Jrzky0Z1VEcm+iHQV1B//aX3JV2xxwf2xcEj91gAfTKDFo5JKTBe7VMFPM?=
 =?us-ascii?Q?MGuvstDfJMuH2UgtpSiU+KHTKqPxm1ZposXDD8gRphhk/5THRgJKW41H5/Dq?=
 =?us-ascii?Q?Db1jYMwxw/pnrIiy4FcNUO+kE6UUSLpuHOsCORD486Qv42Y0Kb5comHsXzR8?=
 =?us-ascii?Q?MAMx6Xyq54I8YQ8YGT31xPvRBp+0vQm+omYQBqDnRZg3GXR9Vs7VbJ+1UKzB?=
 =?us-ascii?Q?5L6jBdJ6OIjsGnnbxZeqxP2kZXlpLemKcXkhbN+MaNPstS5mA1jWESkVb6DQ?=
 =?us-ascii?Q?KGCg290dFLRhyQuWbNlXe0JwXUotowWZjZWp0WYsHRn8IbbkFo5NSYnO/Fyo?=
 =?us-ascii?Q?hFyAWRYPFg7jhRJ/VVKFXwgAN/Xay9BHJ/TByJbMg+B52AG4A+KjahyQC5B7?=
 =?us-ascii?Q?HoXKOTkdKIO6gWTx3ItOwStonHdU3fC0KgSKF2ITN/FKKxV/JmOi2OEVDGI7?=
 =?us-ascii?Q?K/hGIT9Xd1tk7COZK27i+AEfrDFaX3+1k+tTNUGX8B/eATUDRpPZvngKQmeV?=
 =?us-ascii?Q?MnX+bcPF5g53OIEE2xtGqp0nOn7/B9i9enjsVg2H8kI/Y6HzzqGJLY8hqcri?=
 =?us-ascii?Q?yaoIpRU304jamE1nJXR1/LnMhCI7S5ARV7ml/G5gv4/UF/oVG9FjGu3LMk3X?=
 =?us-ascii?Q?P70PvdIzjrcxswVhwXgyxbeyEOPk3aB2XBqAj+16XQ3UClyDNI4NRlbbwVt7?=
 =?us-ascii?Q?TNG0hnC7kRfysrS7dip4ZS5gDhJW4cYwgZgSoGxeIYvl1Bu2ATxv93ycvlez?=
 =?us-ascii?Q?tDtEVI1ND/u443a7haFip50XoQ67jLF4v/iXDxHK28RDkf2Zh/4waDyULpU7?=
 =?us-ascii?Q?wrEuLOmZ4z5HpGbPgXOoVCMtABMbuSGGdcxDTFWQYd4TuLzkuCPFlDHcsLtn?=
 =?us-ascii?Q?6SKA2vEf7GfuKyx1bPflMXpSCRKF3u+syrmGELTa1+ZhIkQPxbQz65bqvlzM?=
 =?us-ascii?Q?f/HuUG3lStU7W6cGKJc5VjF9ZQuMYyhoL+kKXRQjbimBqkDjDOoYU45mbX9b?=
 =?us-ascii?Q?AK2XVw+BG9LV2uQpZBCElrg9V2wqbXfPzOHR8ikYpMb14OFxbazOjXBVCUyO?=
 =?us-ascii?Q?DGq/EJ9O8vCmumKc6gIZGpRS0zpG/Jh8SwzzJTteY6OsHHpfTDNCQczzgxI1?=
 =?us-ascii?Q?msDcjX4WOmIBrrHN3vR9n5wgVwQFiaPp6qQUN5+MQXp+DVYTXmQEx8kUm8PU?=
 =?us-ascii?Q?Y76fCJDKTTJqLv2YSI5ubkt6LpxxOTd5JWfinCJxEM8eFGPACaY3FUqz5zRl?=
 =?us-ascii?Q?oftb8fF7U5mnZ9aKzwdThr9vwjONkV6TsyDrDBnsQd2bNqzsB9fkbmwOYgVS?=
 =?us-ascii?Q?lru9fkE2EOxJE2JC3S/4yO/tKPYGz2l2KtU315yO3q7//gjVmORPzvrX3FJi?=
 =?us-ascii?Q?hEdyWAwWhutdOOGqOnWJ1j6viOE1kbpyTjXpV3zXuBlQV4T+CyfC4hTcEkiG?=
 =?us-ascii?Q?5fGFmN1BqbRljDA8sDxkTWeiWYijdieSMOECtiyFv5dRn05qNEj7w29HBq42?=
 =?us-ascii?Q?+c7TfwyW1xJuB+PSoLPgLR3dJ9lwLjWgYB1aMomIZovYYg7yCTrIffwYv6iV?=
 =?us-ascii?Q?j8G4v/PMNrLJaaHN2TJb2lzFzfnVH/tUh0V6Z+jKFKIrdAdvtXQsP3f55pLH?=
 =?us-ascii?Q?jE/t3Vu6SA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07767f2f-2128-46b1-49e5-08df273d6df1
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:14:50.2135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoiVzRQEIXoZ93BREIMCrab+OVGqPUCQlK/sHJqEOi4KNteKp7Mj/GcIuHg+gtJfwJ5wuF8mLT3s5p1f7sJF0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

Early PCI discovery creates the HDM cache, while later CXL enumeration and
decoder operations provide updated programming state.

Refresh the PCI snapshot when decoders are enumerated, committed, or reset
so reset recovery need not walk the CXL topology. Ignore updates when no
cache exists and reject decoder-count mismatches.

Use CXL_RESET for the PCI HDM cache. Shared HDM register helpers do not
require it.

Skip cache checks and updates for DVSEC-emulated decoders, which do not
use HDM registers. Keep cached global control when MMIO reads return all
ones.

Skip non-PCI mock ports to avoid test wrappers and a circular dependency
between cxl_core and cxl_mock.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=50a88f5194e5df38590d413f925d8d5afa8a8488
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM
---
 drivers/cxl/Kconfig     |  5 +++
 drivers/cxl/core/core.h |  3 ++
 drivers/cxl/core/hdm.c  | 55 +++++++++++++++++++++++++++++++-
 drivers/cxl/core/pci.c  | 70 +++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h       |  1 +
 include/cxl/hdm.h       | 25 +++++++++++++++
 include/linux/pci.h     |  6 ++++
 7 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd..8b08bfdc4982 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -6,6 +6,7 @@ menuconfig CXL_BUS
 	select FW_UPLOAD
 	select PCI_DOE
 	select FIRMWARE_TABLE
+	select CXL_RESET
 	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
 	select FWCTL if CXL_FEATURES
 	help
@@ -244,3 +245,7 @@ config CXL_ATL
 	depends on ACPI_PRMT && AMD_NB
 
 endif
+
+# CXL_BUS requires the PCI HDM cache and built-in state helpers, even when modular.
+config CXL_RESET
+	bool
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index d69864b25656..77bc4f7d2e99 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -222,6 +222,9 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 
 struct cxl_hdm;
+/* Hold cxl_rwsem.dpa for write while using the returned cache. */
+struct cxl_hdm_info *cxl_hdm_get_cached_info(struct cxl_hdm *cxlhdm, int id);
+int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm);
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 int cxl_port_get_possible_dports(struct cxl_port *port);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1a19078e6c6c..b57257efbf4e 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -730,6 +730,47 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
 }
 
+static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
+				    struct cxl_decoder *cxld)
+{
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_endpoint_decoder_settings *settings;
+	struct cxl_hdm_info *info;
+	u32 global_ctrl;
+
+	if (!hdm)
+		return;
+	if (!is_endpoint_decoder(&cxld->dev))
+		return;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	info = cxl_hdm_get_cached_info(cxlhdm, cxld->config.id);
+	if (!info)
+		return;
+
+	/* Preserve the last good value when the device does not respond. */
+	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	if (global_ctrl != U32_MAX)
+		info->global_ctrl = global_ctrl;
+	settings = &info->settings[cxld->config.id];
+
+	/*
+	 * A disabled decoder's software object may retain its old range and
+	 * skip state. Leave only the decoder id in the cached settings so stale
+	 * state is not restored as an enabled decode.
+	 */
+	*settings = (struct cxl_endpoint_decoder_settings) {
+		.config.id = cxld->config.id,
+	};
+	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+
+		settings->config = cxld->config;
+		settings->skip = cxled->skip;
+	}
+}
+
 static void
 cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
 			      struct cxl_endpoint_decoder_settings *settings)
@@ -811,6 +852,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	}
 	port->commit_end++;
 	cxld->config.flags |= CXL_DECODER_F_ENABLE;
+	cxl_hdm_refresh_decoder(cxlhdm, cxld);
 
 	return 0;
 }
@@ -883,6 +925,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
 	cxld->config.flags &= ~CXL_DECODER_F_ENABLE;
+	cxl_hdm_refresh_decoder(cxlhdm, cxld);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -1090,9 +1133,17 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
-	int i;
+	/* DVSEC-emulated decoders do not describe the cached HDM registers. */
+	bool emulated = should_emulate_decoders(info);
+	int check_rc, i;
 	u64 dpa_base = 0;
 
+	if (is_cxl_endpoint(port) && hdm && !emulated) {
+		check_rc = cxl_hdm_check_decoder_count(cxlhdm);
+		if (check_rc)
+			return check_rc;
+	}
+
 	cxl_settle_decoders(cxlhdm);
 
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
@@ -1131,6 +1182,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 			put_device(&cxld->dev);
 			return rc;
 		}
+		if (!emulated)
+			cxl_hdm_refresh_decoder(cxlhdm, cxld);
 		rc = add_hdm_decoder(port, cxld);
 		if (rc) {
 			dev_warn(&port->dev,
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 33b21c8dcb21..2acddb472103 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <cxl/hdm.h>
 #include <cxl/pci.h>
 #include <linux/aer.h>
 #include <cxlpci.h>
@@ -180,6 +181,75 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
 
+/**
+ * cxl_hdm_get_cached_info() - get the PCI-owned HDM cache for a decoder
+ * @cxlhdm: HDM capability whose port identifies the upstream PCI device
+ * @id: decoder ID to validate against the cached decoder count
+ *
+ * The caller must hold cxl_rwsem.dpa for write throughout this call and
+ * all access through the returned pointer. The pointer refers to the live
+ * cache; ownership remains with the PCI device.
+ *
+ * Return: the cache containing @id, or NULL if no upstream PCI device or
+ * cache exists, or @id is outside the cached decoder count.
+ */
+struct cxl_hdm_info *cxl_hdm_get_cached_info(struct cxl_hdm *cxlhdm, int id)
+{
+	struct cxl_hdm_info *info;
+
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(cxlhdm->port);
+
+	if (!pdev)
+		return NULL;
+
+	lockdep_assert_held_write(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (!info)
+		return NULL;
+
+	if (id < 0 || id >= info->decoder_count) {
+		pci_warn(pdev, "CXL HDM decoder %d exceeds cached count %d\n",
+			 id, info->decoder_count);
+		return NULL;
+	}
+
+	return info;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_hdm_get_cached_info, "CXL");
+
+/**
+ * cxl_hdm_check_decoder_count() - check enumeration against the PCI HDM cache
+ * @cxlhdm: HDM capability containing the decoder count to check
+ *
+ * Take cxl_rwsem.dpa for read while comparing the cached count. Call only
+ * for hardware HDM decoders, since DVSEC-emulated ranges do not describe
+ * the HDM registers represented by the cache.
+ *
+ * Return: 0 if the counts match or no upstream PCI device or cache exists,
+ * or -ENXIO if the cached and enumerated decoder counts differ.
+ */
+int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(cxlhdm->port);
+
+	if (!pdev)
+		return 0;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	if (pdev->hdm &&
+	    pdev->hdm->decoder_count != cxlhdm->decoder_count) {
+		pci_warn(pdev,
+			 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
+			 pdev->hdm->decoder_count, cxlhdm->decoder_count);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_hdm_check_decoder_count, "CXL");
+
 static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 9af01e1f45ba..b29374b34cfa 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,7 @@ enum cxl_devtype {
 };
 
 struct cxl_region;
+struct cxl_hdm_info;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index 219b9bb67440..d5e7efd2ffc0 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -16,4 +16,29 @@ struct cxl_endpoint_decoder_settings {
 	u64 skip;
 };
 
+/**
+ * struct cxl_hdm_info - cached CXL HDM state for a PCI device
+ * @decoder_count: number of entries in @settings
+ * @hdm_bar: PCI BAR containing the HDM decoder capability
+ * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
+ * @hdm_size: size of the HDM decoder register block
+ * @global_ctrl: HDM decoder global control register
+ * @dvsec_ctrl: CXL DVSEC control register
+ * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
+ * @settings: per-endpoint-decoder programming state
+ *
+ * Publication through pci_dev.hdm and all mutable fields are protected by
+ * cxl_rwsem.dpa.
+ */
+struct cxl_hdm_info {
+	int decoder_count;
+	int hdm_bar;
+	resource_size_t hdm_offset;
+	resource_size_t hdm_size;
+	u32 global_ctrl;
+	u16 dvsec_ctrl;
+	bool dvsec_ctrl_valid;
+	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
+};
+
 #endif /* __CXL_HDM_H__ */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..7bb37fcb556d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -339,6 +339,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_CXL_RESET
+struct cxl_hdm_info;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -566,6 +569,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_CXL_RESET
+	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.43.0

