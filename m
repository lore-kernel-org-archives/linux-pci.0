Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0BC4DAFB5;
	Thu,  1 Oct 2026 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846575; cv=fail; b=dcLI+3gJlzb1eBGfX2JhjeiIfkE9r/p09jBhZk7ud3eaGUrrqxj8gsqPRLo7VCdCkReBNvtc2QiR3fWl8FHQqhv6UWlYc/rznA0+Xp/+uy30L5iAWxSbtC0v7bqhmXq66Up0sU68sJzmgbuBpIZmgITGqik6kQxmkH2XYGrms+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846575; c=relaxed/simple;
	bh=qXH8aQq30ww6khUGv4G8qT8Q/i29krHaBdfhhDgMw1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JxZjjLftJ22NN0Pc99mpXod9hLyPLoqIVu1r/IKmWzS5P+MED7rNuNsnGVucm1hhhoDsCULIZawifkUivoTVf0vBZEEsc9jn1+owrO1bbqIHAcrlur2ee4Gp2z3upMPuucMH5+xvYJurGZAnCET7HwVTwobEIb6xsX00vxVPsQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=njkyYCPq; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="njkyYCPq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dH4yEYGeL0Ppat0D4CN+YBPegNgI6YvD0Hkvv2SvhQxzVtc8Mvl15CrwwDsMHBtHDvMB+PSeRJAUNkcYCkqmO1YF3QyZeHUmk4t9rsnTZJmk0jtVAo6EgtsgEu/H6HlkuRtVAIlgUTE21qxKVI4Q/aLxVxva/OQEr7FUgEpiTuDVQEiDuFEDz0LE9cU8zdgyZlHK6PiES/MZbJK1v5maKElWi5UST0YYoPkSoPUQ0je2fAQV7x5EDaoVtIw1qr4g3QUQLUw3QynA3Nk6ybujcws2RMtW8+nMwA5X4WjbrMryohgHGpCztRZ+t6phQ7r76AB1b+3f8WPSqMw3VekPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSiTXfbOwGUNC5DgkdFMjjU4nSeMTPRmaH6nMbJTDeg=;
 b=dsDqfuYYZYnpITwnd+gDIWG9e2DmRUb9LM4s2TVgMVD42VD6av2vmXHCgIOVf1D/rXZ1ODgr1LOCX4L7ctP0NzZ2rXGBt0nmUBi/Yn2LANzTB4cMaVzuxc6EgDNwe1rPEHg/pWyQoFesG3W+pRRKTDl+Lsuy495adrhVtowXiyk5B3tSfLVO6CjkuR6KM0ylwK3IO4h532MqiXY2cyj99zs0l7KzlbYxUoEjietpkcGyMG/6fvY26L1rhsl5RUQrbwkUIhlHlBB3i95oabIouw+vmTix1RSh1PJLkSA/bLot3+SMPbGIOJ7hCaipGlnoNEa4O6VJ04A6QffIEvLE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSiTXfbOwGUNC5DgkdFMjjU4nSeMTPRmaH6nMbJTDeg=;
 b=njkyYCPqknlWFP0mr1wxZD4mqYbX7UMtox+wWWroeTQOrj5GEBcF7ntKRght9wNxK333avbSTkY/DqctI5aXa1pgtnqtsxCiaBpGTRu0NEoSIa1K72FbA3UNFc7tSwBDycgTnFtH/Rtad5+31RDu09XhgUKdNQ7QHu+sAAWgucesMcBy8V4Qc/WtXwvJI4+4eFlsmbdurJCJpsJpI2kHVI/+wom4lg7oNeSS1ll4z5tOWjTfhZoYbuV8+T7hBfWbGhokdZb1/qe5+gxBKDig7GzNt6p9shWxTy7rlVHojX5AsDhXut7KSHv/guK07DubluqmEHe9BU5mjd73huxktA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:22:50 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:22:49 +0000
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
Subject: [PATCH v14 06/16] cxl: Move HDM decoder helpers to built-in resource code
Date: Thu,  1 Oct 2026 09:22:17 +0000
Message-ID: <20261001092227.3004747-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 175ae59d-749f-4c1b-0961-08df1f9d9006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|6133799003|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3mCDUUbRui7IXYVGBapee3huuf+WTVih1zPJC9RzjFUpzLbqKo0YObt4Vj6ckmCvd/u3TRvisckabYiP+NlYe0cREOsA94eo/O6pjSWyhAfvmKnRr9ANOxwLCC2Qj6MUC3QRvf8Dy1Ya+5rx1d7bdUfqdkfDN6ihLBI++ODkPIQlfOUQ1UhisfKEzFQJDDsM/JGZcIYUP2scJjEWXqqQUnVF2F93rf8DamaVJDS0mv265E4SO4I8fjKJtVGPC+gMYRPgnueMqFR1y7FM4eb2JifPMceNyVGxTl/QzNk00yI+uk+NrBTnJ8ArGOq82nLJfM/0h0+ECbuAs8FxKOqLSzZdFWYDpkmv5Nm0pl+A1wVpqOT/24hiwS1vE8JlRRBwuFELyJYtfaobhLPUx6toU70aTiT/g/czhIh0nMVO034sWFoh6MrBa4y8gazIEbxynYHYeSp1Z7DpYwh4k3VsYcuJYLvO0/YXgWGh4Om8K+dTZoG48dkTVezwcoj65GV6/arAm43n6hzi0oWbUd2xlYWu3TI5FU0RyUDbdx5GLP1BV8cKviQO1QLpdSidh45zP9wX0wGmEa46oFzTK2SpkLKZuh2zOnFh93B+brT+GFBk9cek4rPpxhBOP/hrJSlps3PpwFd5tT6h52Lh3ZM/T1EMZNf2bAJnjijeTjBhxy+aLCH07EuMYPNc2aNNEKrZVKgHYaJBgnOFZOhpb/ywog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(921020)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IXubx2suImsIwbR/fTTCzABr1WDVHRBaIhNVJ9PD3lD8+mgxOFktiwpNmXIE?=
 =?us-ascii?Q?qR6CS1iDCxZ1jBvaaiY1tnUGxSp2TDG1d8c+0rOhfbOTqglEks1LBTC7Yt4y?=
 =?us-ascii?Q?85cPbMysFaNAE0wPr1L7sxUv/+Fwo98LdpEiNWTW82uGt1Z2BfATS4MtLTk8?=
 =?us-ascii?Q?nLt2aKZMhpqaxmAW5l4H/KZP0eoCCyW1bQBl5678BjFIU35NyafQWPxyIpsE?=
 =?us-ascii?Q?xJaK4URzNwZJ3UnMA/fGZiMdhjxKD6VQCXHFJ1zd9bxX2uMBrXrbtR0pRZ11?=
 =?us-ascii?Q?akA2ExWziMdigLSm/9GbcqcXwXPwGxji2eFizFLISktSP+2a3Anizoo3UhbP?=
 =?us-ascii?Q?TcbcWLZT7sKXEw0MeFfbZJJEeYc5U7KgLBqx6PK8cJq30lp7uByQC+DOpOGb?=
 =?us-ascii?Q?OM97UeqIaicyI9u+7rqn2vaSZspnbrWAJJvKrq7WwVzD1J8NOEJnfvCQvLrk?=
 =?us-ascii?Q?LiBnKfH5rtUIYZ/kqxJrvtNft+mzYVFaJJucG7Cgk170DwT3CXlPllhI8tyt?=
 =?us-ascii?Q?i2g/6Hasx5lF/Y+Gr7xKbYqYC/d7hV+Fe8nPXF9grqB67xE7lWCiWiH12Kwu?=
 =?us-ascii?Q?omsdYvfo2l7nhh+3VLPrkzwturrWUODu2NnX+kRXE49P1l4nsuWYp8ipTzgN?=
 =?us-ascii?Q?eRGaCHnea8jn0a9XR3gwD6xqgGn0ZqSPIRNmSdCipoR2pe/tBpg7YmTchLdc?=
 =?us-ascii?Q?98syYzNFoNm4+PyEeQTHHLzXcU/VJ6Vy2vQqRm0mBCWq3lS8Y/0rL/viL9Jr?=
 =?us-ascii?Q?i9MRJZVC4o1vm19ncZlCYMGKzn5wcQXmNFK5HHI1GW2dE9e/zuiTN6KSyIXC?=
 =?us-ascii?Q?HrzQJhBbJcevUgPyt4Qoi6RUM8jOiqkm6rE4Gh292WCbS0b3y/tgqZyj0aic?=
 =?us-ascii?Q?2Hra1Y8HtRw428Qa7pqzRxYXFWF4RQZOMIautWD4sS29UmZ897G0PgQCN7Ft?=
 =?us-ascii?Q?bcrU/LqZBMqY5w8ypa50VRGP99VgGQI0tE3eAEgkBOwMMlvovAvqdwhOVcOa?=
 =?us-ascii?Q?6+iqg+11il676igBinIy7W8UP10mmZhxt7tOarhBZG5Mc6fLQmHungO27HmC?=
 =?us-ascii?Q?Wb3Elq8K8N0brQs4bpcmSHlvSeiByIbQ60ekIfNJLdwww9B4PJuGREt8mZjK?=
 =?us-ascii?Q?AoH9rw+Yore+17R3f9lyn/b1E4ZCHpMogcKCVP+6OIXSsxaadiW2EFMId8L4?=
 =?us-ascii?Q?wmwoGEsY3u52/DLDH9dqWfqroyawpsDrwXhGRXvMgG3Lm0JYpNljjkPSiP9O?=
 =?us-ascii?Q?MCJ6bJf9lGFtyV4RQZ201FkBSdfbVAhMJfRl50QbfRU6p15+wqX/n45Vp/l2?=
 =?us-ascii?Q?teEycVlBEUjjStKErefrQRQ8Bl0kBD8vFPNpowR+HXlxaRivfwR/TDBFj3E4?=
 =?us-ascii?Q?k0dINAEH3M1W0DJwNj4I0EsR3xztWv9tnc7JC9EpJi7XOO8O82oJYu+c4nco?=
 =?us-ascii?Q?sJwDDO/lkFg+45ycKmktSxVZf0/La2W1Lp5Y5WqTHpJ6KQxjKb2TSHNWKbwj?=
 =?us-ascii?Q?mahKBFtAiiqDLApmrGVlTGlbVT9V9DOGxiCVcrCc39xhfVHEdp+j7genzRnT?=
 =?us-ascii?Q?F1hNV9AB5O9sjxDkR5iGzcMqw4Jo9QNN/qX0aNRvogRwAhSF93O0Yuhogiyc?=
 =?us-ascii?Q?YKwwfEPMuP1bPscO0YOK4lys8BEu8JTim0hgn5WhJjE5doNhGwcogHL3Hb6P?=
 =?us-ascii?Q?EnQ6k3PKrpQA/oRM5V/Zfr6Bb7CgQ7v/BAY5i0wND85WZUjZPp0r+8a5zA6J?=
 =?us-ascii?Q?zyggELHy5w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175ae59d-749f-4c1b-0961-08df1f9d9006
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:22:49.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykKbEH+es+VVNbM1FIUsFAIgaBgVsQJLkw7rBLvD2ukXoB875AvuxqS2YhDeH5dRfCBQ7l3jrE1jzq9wMLbl+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

Move the refactored HDM programming helpers and cxl_rwsem from hdm.c to
resource.c. Build resource.o under CONFIG_CXL_RESET so the helpers are
available to built-in PCI code when CXL_BUS is modular. Export only the
symbols used by cxl_core.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/Kconfig         |   4 ++
 drivers/cxl/core/Makefile   |   1 +
 drivers/cxl/core/hdm.c      |  93 -------------------------------
 drivers/cxl/core/resource.c | 106 ++++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 93 deletions(-)
 create mode 100644 drivers/cxl/core/resource.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd..0cd704670735 100644
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
@@ -244,3 +245,6 @@ config CXL_ATL
 	depends on ACPI_PRMT && AMD_NB
 
 endif
+
+config CXL_RESET
+	bool
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..30470799e059 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
+obj-$(CONFIG_CXL_RESET) += resource.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d3f21dfda146..629e3420ad0b 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -16,11 +16,6 @@
  * for enumerating these registers and capabilities.
  */
 
-struct cxl_rwsem cxl_rwsem = {
-	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
-	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
-};
-
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 {
 	int rc;
@@ -707,35 +702,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxld_set_interleave(struct cxl_decoder_config *config, u32 *ctrl)
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
-static void cxld_set_type(struct cxl_decoder_config *config, u32 *ctrl)
-{
-	u32p_replace_bits(ctrl,
-			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
-			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
-}
-
 static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 {
 	struct cxl_dport **t = &cxlsd->target[0];
@@ -758,65 +724,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
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
-static void setup_hw_decoder(void __iomem *hdm,
-			     struct cxl_decoder_settings *settings)
-{
-	struct cxl_decoder_config *config = &settings->config;
-	int id = config->id;
-	u64 target_or_skip_reg_val;
-	u64 base, size;
-	u32 ctrl;
-
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-	cxld_set_interleave(config, &ctrl);
-	cxld_set_type(config, &ctrl);
-	base = config->hpa_range.start;
-	size = range_len(&config->hpa_range);
-	target_or_skip_reg_val = settings->target_or_skip_reg_val;
-
-	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
-	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
-	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
-	/* Target-list and endpoint-skip registers alias the same slot. */
-	writel(upper_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
-	writel(lower_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_LOW(id));
-
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-}
-
-void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
-{
-	lockdep_assert_held(&cxl_rwsem.dpa);
-	setup_hw_decoder(hdm, settings);
-}
-
 /*
  * Endpoint skip and switch targets have different owners. Keep that state with
  * its owning type and flatten it only into a transient register-programming
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
new file mode 100644
index 000000000000..ff027cb89e57
--- /dev/null
+++ b/drivers/cxl/core/resource.c
@@ -0,0 +1,106 @@
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
+static void cxld_set_interleave(struct cxl_decoder_config *config, u32 *ctrl)
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
+static void cxld_set_type(struct cxl_decoder_config *config, u32 *ctrl)
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
+static void setup_hw_decoder(void __iomem *hdm,
+			     struct cxl_decoder_settings *settings)
+{
+	struct cxl_decoder_config *config = &settings->config;
+	int id = config->id;
+	u64 target_or_skip_reg_val;
+	u64 base, size;
+	u32 ctrl;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	cxld_set_interleave(config, &ctrl);
+	cxld_set_type(config, &ctrl);
+	base = config->hpa_range.start;
+	size = range_len(&config->hpa_range);
+	target_or_skip_reg_val = settings->target_or_skip_reg_val;
+
+	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	/* Target-list and endpoint-skip registers alias the same slot. */
+	writel(upper_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(lower_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_LOW(id));
+
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
+{
+	lockdep_assert_held(&cxl_rwsem.dpa);
+	setup_hw_decoder(hdm, settings);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start, "cxl_core");
-- 
2.43.0

