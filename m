Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2B439CD0D;
	Thu, 10 Sep 2026 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024138; cv=fail; b=I/haFoJUeh8YHRvP0f/GelxhF5joy8iZy+EnbnfnjkksZDht2ceGIFzRQRPl33kKm/tFjQigZ+dBq9Ah6LrRx58uQHxh+sdQytRRerRya6mPSSHYlTvHmiTB7kkyTliKt4DqjRRcrjQJgwdgWqQMO8SJU5YXWHOk0B/l2Yv019c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024138; c=relaxed/simple;
	bh=iHeBpq2wy6NVBSV0frpFnG9lFRt+gkkIiGVOpGZu0Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDL+2yQdVoov2sCjRoiNT1gWgw7DZ0P6jPG15ToLUoXwTPZRaSVlWLYCgXpyYa7cZfMbHlG7XULZsC4q6QiTTJ6tfoWtZ5SWsJL/Ppa6aLEXIwJ5AfpAQ4ojraNfRlb8qBfBt27bMvFk8vQXlYZ6QmOQJ3eE/3a7nk/rGqaQwRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EUb5LfVo; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EUb5LfVo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjyRSOn87fo+Y3ysX4bXl4GgrnP6LXtwtxfXjkXF1t2+kPRE1Jt1AAN1DZA4LI9KHzB8FybJ6TTg4tHRQ0iV5BF2OejUeteeb0Wi/oC+QDlBjxhRjABApWbm80gn4onu88gp6RcrU+o1CoQYls+hTbH352FmJP9jyVDJJasl2iaFB2ZGaGK9aiDN2lc3bzU2XUKG23bU7/ET96XTsRhY1ADQSg6im0d7d5llS+J7RQnRXsRp9yhCoZeoDUQDfh0tQWeekDHoshaour0yGSCK72Ili7TG9d88Lk2kef9zH82dw0nnwNE4300eipH1kDDfoeiU85/CdRLffMcNN0X3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZn1oqcgqYKiPGiDAkcxdWofv2k0zZRUuW4wcGDNznE=;
 b=EQB7uJjAzLNlaA9X++gAGqSH6hM+jQW6aSjmqC+bgWv1LrpCYU0ycqICjoILyEyf168KqjiYrRuw0PhKLrym1/hmRT3N4fH8LpMfssImPRUOCtkcjDYPYUq4N26XSRzEEN4fS2+UCa2xkeK+fE7L6ZwlC+yYSG3XbW01QNQoLmH9SI2xVskhoqpJEi5aakwpGcVa8KNKytpHJrNq0T2AUZaEFrRjWJAhD+NQccKifipyM7RgH3IwD4nZGUXWjb1zBR0IvB3CU9u0MnfTIHOq4Zqfho37wWeIAiguy3/omjeJSTcfmJ68Mw327JZxKWen/WPpNIHvWNfp+JQw3uuUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZn1oqcgqYKiPGiDAkcxdWofv2k0zZRUuW4wcGDNznE=;
 b=EUb5LfVoOTlCtib/GS4UmODpop2MS4Lh2pTOfTYzlWuCPx18dfFZwiberVHQB20/eIXeVh2nZhrPkASZxuM6KjDZAlR2nyqATIpjSyRtGkhw8WG/U72reujX1RZprj4+jcPRL2XQlHternJNebuZ8VkP65LxJIl4uOXRa0NU5ikKMaP40pe/83ALkBGcUB/XOjzlpaL8qmSUU/hE2c4utxNYpN7CY8HyK4Cf4NC+xalS0D0JHzgtgz5irMnzJBtN34D8VUGIFsszevCKpfglGepwR9vjH65T1PLPtV30JYbURxna3k6dzobeSLWW79FfhcZ8k07nqPvWGtsBiJlT+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:28 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:28 +0000
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
Subject: [PATCH v12 05/12] cxl: Cache endpoint decoder settings during PCI enumeration
Date: Thu, 10 Sep 2026 07:08:01 +0000
Message-ID: <20260910070808.1444264-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:303:b7::24) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a04a26-b47b-45f6-82ff-08df0f0a5062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|5023799004|56012099006|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	EivvduzqPPXBDeDiK2rSLsmG1wJEqXUP8B3JFRa9CeC4uoldOTEdoaz6g4JOInP5QSTcNUhc+NoCSTunwVswGy9qNSPc53nJcnqVKuVCtrbI2GuDM3LZj9vJhnWYAEftetQc9hBDc2rYUO7/WwB2zRwRFhRRNRSGZLqIjZO3QKcw52L+q2sdV0bajXQxJXo9B9TmOd0+TwhnZj48mgEBu1yCI+nzGIws/J7qpF/03MQw+TZvBLrtoNYBSDL6M0ISatzLib4Xrapeb9YHprTWYnLS6qKJJK+zIyBzO12jQA2QkK9d3I9PGVg5XvyYpmdbjELdTgLe323/qV2bhnvmDbK1CklL36XXzMxG1Iiq8ZpJtIoz730eSEMZ5MMirGU5d4SZmrROojjCbxD1jsozvd3D7dqsO9z3qaLTr8sI/4XYVfVhCFzBSLtnnK5cKc61ZJl+bpn/3RTOyOvod5wEpq26xqf8s5X1Th6lewCoofm03rSr1mCe6+1bRXVcdDOsD3g5x5ZEUtw7Be8JiwvARm655M9d+18rGDfOS8Lq6M7zY577/BcDo17q1a6HSKcl/V4qOyqHNelRfIrm7Sbv82/liqV0+RKcD/64dCukthnQLBRUk3mizCR8nCddhASOzRnpX5W1QJhNED8TNvZjqD0jrJdEVdK5x5XJdFfZrHlk+/I/8hyLVeQkhNpUK+Ym4GxWfAR5Ovlxc/u8rttUcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(5023799004)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zyAhIZBLO/OA1q715NtDCHM9aTxhf0nfDNfCa7W5lg/bgYCaD5PYyuoRW9sk?=
 =?us-ascii?Q?xXRquMJEvhd5r4CRsMQpURctglj30EetvcgBi4QObHKKwl9mMNGmqnxZOOXp?=
 =?us-ascii?Q?eYnkQ6IiVXIf0VPA1mq6a83qat9DWNCY/EfMHKqp2L5hsAbOvjI3VdI+2Yqb?=
 =?us-ascii?Q?4X1OvLeBaaxsn+qus4NqlOgH4e7SBbjVgjUOLRWol80Y5ELEMYcDmmnD6Ry/?=
 =?us-ascii?Q?VUlXrdDLBvju65gf31wZPi25ZS6i+D/fuWEihH1kEUGVg7YEtqyXyGhW0Q3x?=
 =?us-ascii?Q?MCPy+akHt1EGL4whoRE0yfpzwkYXZt+gWWroKhM7ugPruernhsBU8aGCY9S/?=
 =?us-ascii?Q?i2Rng0ShsZfIMd06uayZ9Vl1QrBlDIhgxaHPue4TNV0lLQENA4fkwNLr1Qzs?=
 =?us-ascii?Q?xCr6tQzyYEYqra0/25xGOixurPt3hq983r8mPXnfRTOGdyVDgRT/0GGd6/Gz?=
 =?us-ascii?Q?GHXmvu23z016rgdcioyGxR8S4sVKOkn9Dd06ZdZ3LMS3UIjaz+8MsO4Gl/cK?=
 =?us-ascii?Q?nrnT7oxVyh1kzPxvnLj60ALCIt4rdIDVt8+wb2cgLE2D3fbRBeL8RT60wZNj?=
 =?us-ascii?Q?FXRg1tm8HCQiEiqtskP5TYQnY2vsCRDoVDAJuP4Ffu/vUeK7JaWWgOUxbpPT?=
 =?us-ascii?Q?od4ijwKUalB5DblK/OyYo0Xoo1QI3/PvUUOO+fofqiGSVj6rE1iHpooZFYjq?=
 =?us-ascii?Q?jGxHZqxi+v384Uo37M7HkafuMN7f15eTsuQKwKKTJSmbGm8TWp8GOFH6t8Ld?=
 =?us-ascii?Q?KSjDBR8Kv54uM38IOQcGzPtTa2TNBA1V3VJXkygI853bmIIx6vjjQFmjuhwT?=
 =?us-ascii?Q?KSOnRFqOMyzkVsTAV+/eynDRLroDHcQI56CQ0J+bFuAeMLs+E4bB9ZEx4Ob9?=
 =?us-ascii?Q?HZk1Kub+C9vt6GaoCOogBq1berSi4m8GTtfy9AfXpJjYJkAY7y1nEKZaxDDm?=
 =?us-ascii?Q?yZ+PJwGXLkdjdsCcdXbi7BNbh3aeLGcth1Dw6sxcgyYjBADLKA6n5afJbP7z?=
 =?us-ascii?Q?G+E+OLg22OXIyer1CtxZ8KpWWisH/nD1XPxBlvU7T9R1/0E5acYttHFLZP8c?=
 =?us-ascii?Q?mMMlvlAmSnpa6zbofDdMYpy+h1LGcamBfOElVmVBgrLKpiSVYRKGcS9MceHH?=
 =?us-ascii?Q?I+pnkatoGCHHkouE6pFMGITxtJgKmFrBBwNzahTQ2VNI3alqveqrmdQFsWFP?=
 =?us-ascii?Q?MXmFPcI+A/u48LG9+NqNioWZ0ag4mO6ZtyqPKw22sbaWZ6SsWUlQrAJ2OLWW?=
 =?us-ascii?Q?bOcK8eRNntABc+Ogrc6AeSHAlK7ND4JO+nHNKieEja5HYRzHzXr3RRsKjxy+?=
 =?us-ascii?Q?1Wd9urwX2J8R57ImdB2c7PiEYLWRS4tAjIaNM7Kx7bhH8gIFGVb7qnRZUjMp?=
 =?us-ascii?Q?+0xMfeZArmyUsETUEOU4bkjeXhouosPMP8jef+nMYyvOOtxj48TGblvsE8IP?=
 =?us-ascii?Q?mTaZG7wnn1TehheZlGAQKGLdaLF1bUWhvSMIQDN5u23PXN2VYTxBFOsstY5Z?=
 =?us-ascii?Q?VjLrgVAKEtthkEPUVgHsACVwdPgw7GKDFfB2JIvvuRRvfYjYSUWtLnq8y6YX?=
 =?us-ascii?Q?pODF+hgPrklrN1LPLhWHOK31F2w7tIcSWI0DAc+hznKg8Sa8b8SQJZd9Oqvt?=
 =?us-ascii?Q?fMe+72UL8wl4/YqXErDfCsT8QN1uZGtFZXEO74otEa9F3DwTzaAkb1hZvPFF?=
 =?us-ascii?Q?BbJ1eBkgdWVwthOGjb/mxC/kVh4OYB9LUVNNi11pOSR0uEjNsoo+9L0TzgwN?=
 =?us-ascii?Q?A3jFKatv4A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a04a26-b47b-45f6-82ff-08df0f0a5062
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:28.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJtFBeYJPJgBSdm/5srZ/z/MrirJuV1YKcgAqJUqW+dB0OmPzfxU8203sUP0vJCPvmr7gsvVawjG7aTCk9CHtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

Populate pci_dev->hdm for CXL.mem functions from pci_bus_add_device(),
after final PCI fixups and state save but before driver binding. This
gives driver-free reset paths an early HDM snapshot while avoiding the
pre-resource-assignment window in PCI capability initialization.

Use the CXL Register Locator BAR Indicator to find the component register
BAR, reject unassigned, disabled, or zero memory BAR resources before
temporarily enabling Memory Space, and restore the original PCI_COMMAND
value before returning. Cache the CXL Device DVSEC control register with
the HDM state for reset recovery before a driver can alter it.

CXL core refreshes the cache as decoders are committed or reset, and keeps
the cached DVSEC control synchronized when CXL.mem is enabled or disabled.
Move the register helpers into the built-in CONFIG_CXL_RESET set so the
early cache path is available without cxl_core, and keep the cxl-test mock
core from building a duplicate regs.o.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/Makefile   |   3 +-
 drivers/cxl/core/core.h     |   1 +
 drivers/cxl/core/hdm.c      |  45 ++---
 drivers/cxl/core/pci.c      |  22 ++-
 drivers/cxl/core/regs.c     |   4 +
 drivers/cxl/core/resource.c | 336 ++++++++++++++++++++++++++++++++++++
 drivers/pci/bus.c           |   2 +
 drivers/pci/probe.c         |   2 +
 include/cxl/cxl.h           |  30 ++++
 tools/testing/cxl/Kbuild    |   1 -
 10 files changed, 417 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 30470799e059..2335059f687a 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(CONFIG_CXL_RESET) += resource.o
+obj-$(CONFIG_CXL_RESET) += regs.o resource.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
@@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
 
 cxl_core-y := port.o
 cxl_core-y += pmem.o
-cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 5350c154d88e..8dc33ea933c3 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -158,6 +158,7 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
+int cxl_pci_get_device_dvsec_cap(struct pci_dev *pdev, int dvsec, u16 *cap);
 
 static inline struct device *port_to_host(struct cxl_port *port)
 {
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0927036aed27..90a0fe6dff92 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -87,36 +87,26 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->iw_cap_mask |= BIT(16);
 }
 
-static bool __cxl_pci_hdm_decoder_count_match(struct pci_dev *pdev,
-					      int decoder_count)
-{
-	struct cxl_hdm_info *info;
-	bool match = true;
-
-	down_read(&cxl_rwsem.dpa);
-	info = pdev->hdm;
-	if (info) {
-		if (info->decoder_count != decoder_count) {
-			pci_warn(pdev,
-				 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
-				 info->decoder_count, decoder_count);
-			match = false;
-		}
-	}
-	up_read(&cxl_rwsem.dpa);
-
-	return match;
-}
-
 static bool cxl_pci_hdm_decoder_count_match(struct cxl_hdm *cxlhdm)
 {
 	struct pci_dev *pdev __free(pci_dev_put) =
 		cxl_port_get_uport_pci_dev(cxlhdm->port);
+	struct cxl_hdm_info *info;
 
 	if (!pdev)
 		return true;
 
-	return __cxl_pci_hdm_decoder_count_match(pdev, cxlhdm->decoder_count);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (!info)
+		return true;
+	if (info->decoder_count == cxlhdm->decoder_count)
+		return true;
+
+	pci_warn(pdev,
+		 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
+		 info->decoder_count, cxlhdm->decoder_count);
+	return false;
 }
 
 static void cxl_hdm_save_decoder_info(struct cxl_hdm *cxlhdm,
@@ -126,10 +116,17 @@ static void cxl_hdm_save_decoder_info(struct cxl_hdm *cxlhdm,
 		cxl_port_get_uport_pci_dev(cxlhdm->port);
 	struct cxl_decoder_settings *settings;
 	struct cxl_hdm_info *info;
+	u32 global_ctrl = 0;
+	bool has_hdm_decoder;
 
 	if (!pdev)
 		return;
 
+	has_hdm_decoder = !!cxlhdm->regs.hdm_decoder;
+	if (has_hdm_decoder)
+		global_ctrl = readl(cxlhdm->regs.hdm_decoder +
+				    CXL_HDM_DECODER_CTRL_OFFSET);
+
 	guard(rwsem_write)(&cxl_rwsem.dpa);
 	info = pdev->hdm;
 	if (!info || cxld->id >= info->decoder_count)
@@ -139,6 +136,10 @@ static void cxl_hdm_save_decoder_info(struct cxl_hdm *cxlhdm,
 	*settings = (struct cxl_decoder_settings) {
 		.id = cxld->id,
 	};
+
+	if (has_hdm_decoder)
+		info->global_ctrl = global_ctrl;
+
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		cxl_decoder_snapshot(cxld, settings);
 }
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d807c1a002c..0cd52753f5ef 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -180,6 +180,16 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
 
+static void cxl_hdm_cache_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
+{
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	if (!pdev->hdm)
+		return;
+
+	pdev->hdm->dvsec_ctrl = ctrl;
+	pdev->hdm->dvsec_ctrl_valid = true;
+}
+
 static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
@@ -191,8 +201,10 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	if (rc)
 		return pcibios_err_to_errno(rc);
 
-	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
+	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val) {
+		cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
 		return 1;
+	}
 	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
 	ctrl |= val;
 
@@ -200,6 +212,7 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	if (rc)
 		return pcibios_err_to_errno(rc);
 
+	cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
 	return 0;
 }
 
@@ -274,9 +287,10 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 		return -ENXIO;
 	}
 
-	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CAP, &cap);
-	if (rc)
-		return pcibios_err_to_errno(rc);
+	rc = cxl_pci_get_device_dvsec_cap(pdev, d, &cap);
+	if (rc < 0)
+		return rc;
+	d = rc;
 
 	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE)) {
 		dev_dbg(dev, "Not MEM Capable\n");
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 20c2d9fbcfe7..989e79383b99 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -200,6 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
@@ -518,6 +519,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
 
 	return offset;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
 
 static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
 {
@@ -634,6 +636,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 
 	return component_reg_phys;
 }
+EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
 
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport)
@@ -642,3 +645,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index e6aa55079c76..6d9f8fe14b16 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -2,9 +2,17 @@
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 #include <linux/delay.h>
 #include <linux/bug.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include <cxl/pci.h>
 
 #include "cxl.h"
 #include "core.h"
@@ -156,3 +164,331 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
 				  &settings->interleave_granularity);
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
+
+struct cxl_hdm_decoder_state {
+	u32 ctrl;
+	u32 base_low;
+	u32 base_high;
+	u32 size_low;
+	u32 size_high;
+	u32 target_low;
+	u32 target_high;
+};
+
+static void cxl_pci_hdm_info_free(struct cxl_hdm_info *info)
+{
+	if (!info)
+		return;
+
+	kfree(info->decoder_state);
+	kfree(info);
+}
+
+DEFINE_FREE(cxl_pci_hdm_info, struct cxl_hdm_info *,
+	    cxl_pci_hdm_info_free(_T))
+
+void pci_cxl_hdm_release(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info = pdev->hdm;
+
+	pdev->hdm = NULL;
+	cxl_pci_hdm_info_free(info);
+}
+
+static bool cxl_pci_bar_usable(struct pci_dev *pdev, int bar)
+{
+	struct resource *res = &pdev->resource[bar];
+
+	if (!pci_resource_len(pdev, bar))
+		return false;
+	if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
+		return false;
+	if (resource_type(res) != IORESOURCE_MEM)
+		return false;
+	if (!res->start || !res->end)
+		return false;
+
+	return true;
+}
+
+static int cxl_pci_hdm_find_bar(struct pci_dev *pdev, resource_size_t hdm_start,
+				resource_size_t hdm_size, int *bar,
+				resource_size_t *offset)
+{
+	resource_size_t hdm_end;
+
+	if (!hdm_size)
+		return -EINVAL;
+
+	hdm_end = hdm_start + hdm_size - 1;
+	if (hdm_end < hdm_start)
+		return -EINVAL;
+
+	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
+		struct resource *res = &pdev->resource[i];
+
+		if (!cxl_pci_bar_usable(pdev, i))
+			continue;
+		if (hdm_start < res->start || hdm_end > res->end)
+			continue;
+
+		if (bar)
+			*bar = i;
+		if (offset)
+			*offset = hdm_start - res->start;
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
+				     struct cxl_register_map *map,
+				     struct cxl_hdm_info *info)
+{
+	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
+	resource_size_t hdm_start;
+	void __iomem *hdm;
+	int rc;
+
+	hdm_start = map->resource + hdm_map->offset;
+	info->hdm_size = hdm_map->size;
+
+	rc = cxl_pci_hdm_find_bar(pdev, hdm_start, info->hdm_size,
+				  &info->hdm_bar, &info->hdm_offset);
+	if (rc)
+		return ERR_PTR(rc);
+
+	hdm = ioremap(hdm_start, info->hdm_size);
+	if (!hdm) {
+		pci_err(pdev, "failed to map CXL HDM decoder registers\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return hdm;
+}
+
+static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
+					   void __iomem *hdm, int id)
+{
+	state->ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	state->base_low = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	state->base_high = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	state->size_low = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	state->size_high = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	state->target_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
+	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+}
+
+static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
+				    struct cxl_hdm_decoder_state *state,
+				    struct cxl_decoder_settings *settings,
+				    void __iomem *hdm, int id)
+{
+	u64 target_or_skip, base, size;
+	int rc;
+
+	cxl_pci_hdm_read_decoder_state(state, hdm, id);
+
+	base = ((u64)state->base_high << 32) | state->base_low;
+	size = ((u64)state->size_high << 32) | state->size_low;
+	target_or_skip = ((u64)state->target_high << 32) | state->target_low;
+
+	rc = cxl_hdm_decode_decoder(settings, id, state->ctrl, base, size,
+				    target_or_skip, NULL);
+	if (rc) {
+		pci_err(pdev, "CXL HDM decoder %d has invalid configuration: %d\n",
+			id, rc);
+		return rc;
+	}
+	return 0;
+}
+
+int cxl_pci_get_device_dvsec_cap(struct pci_dev *pdev, int dvsec, u16 *cap)
+{
+	int rc;
+
+	if (!dvsec) {
+		dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+						  PCI_DVSEC_CXL_DEVICE);
+		if (!dvsec)
+			return -ENOTTY;
+	}
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return dvsec;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_pci_get_device_dvsec_cap, "cxl_core");
+
+DEFINE_FREE(cxl_hdm_iounmap, void __iomem *, if (_T) iounmap(_T))
+
+static bool cxl_pci_hdm_capable(struct pci_dev *pdev)
+{
+	u16 cap;
+	int dvsec;
+
+	dvsec = cxl_pci_get_device_dvsec_cap(pdev, 0, &cap);
+	if (dvsec < 0) {
+		if (dvsec != -ENOTTY)
+			pci_dbg(pdev,
+				"failed to read CXL DVSEC capability: %d\n",
+				dvsec);
+		return false;
+	}
+
+	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
+		return false;
+
+	if (!FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap))
+		return false;
+
+	return true;
+}
+
+static int __cxl_pci_hdm_read_info(struct pci_dev *pdev,
+				   struct cxl_register_map *map,
+				   struct cxl_hdm_info *info)
+{
+	struct cxl_decoder_settings *settings;
+	int decoder_count;
+	int rc;
+
+	rc = cxl_setup_regs(map);
+	if (rc)
+		return rc;
+
+	if (!map->component_map.hdm_decoder.valid)
+		return -ENODEV;
+
+	void __iomem *hdm __free(cxl_hdm_iounmap) =
+		cxl_pci_hdm_map(pdev, map, info);
+	if (IS_ERR(hdm))
+		return PTR_ERR(no_free_ptr(hdm));
+
+	decoder_count = cxl_hdm_decoder_count(readl(hdm +
+						    CXL_HDM_DECODER_CAP_OFFSET));
+	if (decoder_count < 0)
+		return decoder_count;
+
+	if (decoder_count > ARRAY_SIZE(info->settings))
+		return -ENXIO;
+
+	if (CXL_HDM_DECODER0_CTRL_OFFSET(decoder_count - 1) + 0x10 >
+	    info->hdm_size) {
+		pci_err(pdev,
+			"CXL HDM decoder count exceeds mapped register block\n");
+		return -ENXIO;
+	}
+
+	info->decoder_count = decoder_count;
+	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	info->decoder_state = kcalloc(decoder_count,
+				      sizeof(*info->decoder_state),
+				      GFP_KERNEL);
+	if (!info->decoder_state)
+		return -ENOMEM;
+
+	settings = info->settings;
+	for (int i = 0; i < info->decoder_count; i++) {
+		rc = cxl_pci_hdm_read_decoder(pdev, &info->decoder_state[i],
+					      &settings[i], hdm, i);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
+				 struct cxl_register_map *map,
+				 struct cxl_hdm_info *info)
+{
+	bool restore_command;
+	u16 command;
+	int rc, rc2;
+
+	guard(pci_dev)(pdev);
+
+	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	restore_command = !(command & PCI_COMMAND_MEMORY);
+	if (restore_command) {
+		rc = pci_write_config_word(pdev, PCI_COMMAND,
+					   command | PCI_COMMAND_MEMORY);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+	}
+
+	rc = __cxl_pci_hdm_read_info(pdev, map, info);
+
+	if (!restore_command)
+		return rc;
+
+	rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (rc2) {
+		rc2 = pcibios_err_to_errno(rc2);
+		pci_err(pdev,
+			"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
+			rc2);
+		if (!rc)
+			rc = rc2;
+	}
+
+	return rc;
+}
+
+static int __pci_cxl_hdm_init(struct pci_dev *pdev)
+{
+	struct cxl_register_map map = { 0 };
+	int dvsec;
+	int rc;
+
+	if (!cxl_pci_hdm_capable(pdev))
+		return -ENOTTY;
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_hdm_find_bar(pdev, map.resource, map.max_size, NULL, NULL);
+	if (rc)
+		return rc;
+
+	struct cxl_hdm_info *info __free(cxl_pci_hdm_info) =
+		kzalloc_obj(*info, GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
+				  &info->dvsec_ctrl);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	info->dvsec_ctrl_valid = true;
+
+	rc = cxl_pci_hdm_read_info(pdev, &map, info);
+	if (rc)
+		return rc;
+
+	pdev->hdm = no_free_ptr(info);
+
+	return 0;
+}
+
+void pci_cxl_hdm_init(struct pci_dev *pdev)
+{
+	int rc;
+
+	rc = __pci_cxl_hdm_init(pdev);
+	if (rc && rc != -ENOTTY && rc != -ENODEV)
+		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
+}
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 655ed53436d3..5fd7bae8e786 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
+#include <cxl/cxl.h>
 
 #include "pci.h"
 
@@ -359,6 +360,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	/* Save config space for error recoverability */
 	pci_save_state(dev);
+	pci_cxl_hdm_init(dev);
 
 	/*
 	 * Enable runtime PM, which potentially allows the device to
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..13a2784b8fb8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
 #include <trace/events/pci.h>
+#include <cxl/cxl.h>
 #include "pci.h"
 
 static struct resource busn_resource = {
@@ -2484,6 +2485,7 @@ static void pci_release_dev(struct device *dev)
 	struct pci_dev *pci_dev;
 
 	pci_dev = to_pci_dev(dev);
+	pci_cxl_hdm_release(pci_dev);
 	pci_release_capabilities(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index ed5237df510f..c8070d9cfbfb 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,7 @@ enum cxl_devtype {
 };
 
 struct cxl_region;
+struct pci_dev;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -135,16 +136,45 @@ struct cxl_regs {
 
 #define CXL_HDM_DECODER_MAX_COUNT 32
 
+struct cxl_hdm_decoder_state;
+
 /**
  * struct cxl_hdm_info - PCI device HDM decoder programming cache
  * @decoder_count: number of decoder settings entries
+ * @hdm_bar: BAR containing the HDM decoder registers
+ * @hdm_offset: HDM decoder register offset relative to @hdm_bar
+ * @hdm_size: HDM decoder register resource size
+ * @global_ctrl: cached HDM decoder global control register
+ * @dvsec_ctrl: cached CXL Device DVSEC control register
+ * @dvsec_ctrl_valid: @dvsec_ctrl contains valid state
+ * @decoder_state: cached raw per-decoder register state
  * @settings: cached per-decoder programming state
  */
 struct cxl_hdm_info {
 	int decoder_count;
+	int hdm_bar;
+	resource_size_t hdm_offset;
+	resource_size_t hdm_size;
+	u32 global_ctrl;
+	u16 dvsec_ctrl;
+	bool dvsec_ctrl_valid;
+	struct cxl_hdm_decoder_state *decoder_state;
 	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
 };
 
+#ifdef CONFIG_CXL_RESET
+void pci_cxl_hdm_init(struct pci_dev *pdev);
+void pci_cxl_hdm_release(struct pci_dev *pdev);
+#else
+static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
+{
+}
+
+static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
+{
+}
+#endif
+
 struct cxl_reg_map {
 	bool valid;
 	int id;
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc9..e80500f457a9 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -55,7 +55,6 @@ obj-m += cxl_core.o
 
 cxl_core-y := $(CXL_CORE_SRC)/port.o
 cxl_core-y += $(CXL_CORE_SRC)/pmem.o
-cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
-- 
2.43.0

