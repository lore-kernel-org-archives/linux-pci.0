Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DEB3546EE;
	Fri,  3 Jul 2026 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116328; cv=fail; b=kKQU0M4gnBfj+BmLxibtbbdFc0SHAIERovzsPq7hfvMk4vUgH+FuG1p647NdYFms6+KfvJr86s3+jTBpRuApbeuuyr5ZtsFsjsvxoz65LpRwtuSLNg9jBKMKxwIkglb7Xo6WMsko04E8vCl6NDA0VAhP++QooiPdtOjoTbFsfnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116328; c=relaxed/simple;
	bh=u2kmDVSR10OYBpxzC4VGoXhA9LQsgfZkyoQk1j9u4V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ffccUcQZo+ROGt+KwB1ceDrpHAUn+gAEV8Fr+xCjzpYZ+JW5iZ6l79iaeVIR43P63YjxypirvLpgcZ2WPyEyQ3Lici+3WsAbTDPArnIIxft8MIAUYSuS4+SDbcuWclf8uQApkwKAJKfMvimAVogRUuvDFPlBUkBRJ+gW/euRLxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sj8KA2BI; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sj8KA2BI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0M12DdrrisYE630qZgXEPVBBEO4XPPVZKpWtPYw3oYUr6VKqIwk7nPbsg2hgyAYuIFzRVstStaajB8HQ+FN0q4wZVUqyURWdqAUWOIxEkFuVLpNWyeYHRtzb85eb3pmrqkXmwAbGff1Z3mdLgdSBWsGVtMY8Xa/79wZ0jScGfqKo7K7wLbmBFgWcCL06+EJX5iESin8YvBWw/OgQF8Kc0yJoYMu5zxc9xGqVlIusrPgS7RaPx7wSgegw2pRPY5Yzeuc4YMwG3jgTGtU18zQ91m4sU3HZ9AIZcl8OQjmIUqW9JMmpSPLnZQ5q6wo4KW92rcBQ4T7ADa06zNnglqqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qCVb56Xl3aZkXRl9PAq6CRSScmz71rChwwEfxkeOCI=;
 b=BmPRovww+5Y47wSppevaZayO5LMnSzmkh1rDqpJ5o/RgkLNJ20vvJTzjyHHT9UN0rcYo06f7Of6xAeLo34LW5BUmRMHIoL965mGem3UGY3flnMfo7yFpLbWoHyrkFTPWPhCkcON5Z20hFkkuVRLxue3QuoSr4UYSx0W6Ut1t3UMefFDmCWHBDEyaMAoy8EzOPDgsPC1z2w/q99jNTF1EvfPvGOOE5cSlhsKXkwSYdnyu3AerpTMIq11SzHwdE5sBopHvFzB0xTcFrFbkI/rAytjs9k2Ysyu9KKcB56ZfNHpXjmwJ+Yjim18wb93SILZ4zjgjYZpE4hZb5d2Fnceo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qCVb56Xl3aZkXRl9PAq6CRSScmz71rChwwEfxkeOCI=;
 b=Sj8KA2BIW0CczfgTWrqL0y7M1ZAOLosVmkGZaF7tvdgxkAEQa4HAze/1pDcd/9DYOY5bikFfoW1u0ET+io+jy32UyFg23rrhjNCNHFj8UqmjY5qRtLPSxPtTenUs8V03+T9VVNip7vE2IDePc0VEmjOljgZXSvaVvEhHK0cxYvvh/SA6jiderqQ7bkFxWyp05VNxxZMs82gNxBlVwHrGK2u+LBFIdryyEucy4pZ7CCG/KN84K+bIrKsDJFQ4tg+NFriBhM6PB/5zZTpcjYJcAqwXNN34afe06Irti+leha/8gp8hmJtw48YU4RCPK84boRLXlZGIzI2kIkRHTFaNGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 22:05:22 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 22:05:21 +0000
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
Subject: [PATCH v8 04/10] cxl: Cache endpoint decoder settings during PCI enumeration
Date: Fri,  3 Jul 2026 22:05:02 +0000
Message-ID: <20260703220508.546528-5-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703220508.546528-1-smadhavan@nvidia.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:334::13) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: aa941cf6-96be-4787-dd44-08ded94f2d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|22082099003|18002099003|5023799004|11063799006|56012099006|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	KmmVKmKmPstQnxyET/6FIm5yk3fU25dJPuHMBA5X1YvOQxVithfsj5xfnoBzmIf/R64TJviGmiuFq/j5XTwN+24mIIK1xTI8bFNVxkMgOwudeep0k6dfPMsYau2jPjQgbr2pBDRVnSzMGEu06Dz7twwaqUtHo03wlDzLr0lPtwTVGhS9n3ZaGep/iL2ogNZ6yvleax8LkSgQ8Lo0VVnPekmOGOS3l5MvkgfFW6BFMe1GDeHO7nxw4ziaqFUw/UzPIbzHOrOTdKvfJDVAzDoCEZvhV+vtzl4pkubZ5t78aVddydc71fnYnyEf4jslWDAJZMGfEmXlm9RalksoM8Ikm7nUgFLSScp0NLGYHXj532HHRzMFYL03QCXAk+kG2TqA42gZgAviG5H3kojwaM9FpMuKSdEMJOM/q/bKluaWB5rzVUeZXrblZjk2PsMLxy+i1BEgquW/nxR2vGDzsxlDY46J30Np1mhZ/Z9aYduOlcQPwgHLWtkq3u6n/R3iJBNIZw7iTVSpgCn71RExDsekR5C5zCyYc5EuPAEYhjswukPcFYFg4cBe02G39ocSQhYTCwHpropihgOoGb3mh/h0VmrambT5ogcd3aKHCPOFlBqYnomcqDmbAmBTlgDuAVIBk6LJn41xisPSbHzQAeYoyXe7oN3kO8XNQrQtgF1J2FkKwBwhgH8T0MQPzQX1Bmk5CzJ72YoheczwN7r4O1bKaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t2AVUPkhOsL5ezlYzG3hhJ5W8eXHMt9VrkIvpu+edFxSoj8ndEV0aDz79Mq+?=
 =?us-ascii?Q?+sNx0Y0XkbWqYDlhSD14/2AxBotj/HRnK6UYSSMq42lwo79YlURQv8XqhDF1?=
 =?us-ascii?Q?uj7XD89Yv2EllZigngTG6EtVN7F9zG1UQmeT/nIRIke19z2urZaq1feMlNW7?=
 =?us-ascii?Q?Mfw7c9wL/tzzcIJElHMtJOcdc71uPY2NsRZ/3g2hy5fqvyn50HcJjnCoMjOU?=
 =?us-ascii?Q?8u064NuaWDZgQgRBi06GtUZQN80YxBEZ2jdUhU2Fw3hFLMlePuOK1iMr/Buz?=
 =?us-ascii?Q?6yfnwxcXSfUmc1V8HVuLjxh6piUj2wTSzxr25o4I0SnVAvAjMdgpL2zvcvzQ?=
 =?us-ascii?Q?pVJS1763BDWkhdUOlcYMBRHWScvwZF44MD50bDmPxLR+0seI5mUDexCtgWN7?=
 =?us-ascii?Q?gu0JL9I5s/iHXs8zEVJKfStx8w2dABbhh9Sh6NMkFvQyYI3XV/StNzl0MljP?=
 =?us-ascii?Q?/LdtRlDUgV6FYRaWZtmPNv5iL4qmOebBEQC57kQ6Bku/LNcc1mK+qMqYbNru?=
 =?us-ascii?Q?z/XYLfSdg+6sNkMxDLxZ3nG3ShdL5iz1SDZyuaZtOIGbd/nyQ4RB9+c7lYwi?=
 =?us-ascii?Q?6zH3mUn9Tts6Elo8fJGOjVn11OjmhBKm+GLGY/3pmsS8kfMxZrbL0P6DQ3CV?=
 =?us-ascii?Q?EG/okxLM4vPTyqYgC07SZ8KP4NDlIWy49lB3lD845OR4BnXnnh/mTxuQkdQU?=
 =?us-ascii?Q?1RAYWR1xXnxDelrZaOWghpMEsVL8hhxRq4agU8gzTVRDkJVOqW6NuwkNtRD0?=
 =?us-ascii?Q?KsP4vn1Z7AH5J2SyaYzGBj+5ycaaFQFTvqviiFhj8Zw/QgF4DzSiPNffZlux?=
 =?us-ascii?Q?+P4SWg2mSO5TUxVMGkV7lcyHi6dBA59yqNg76hMpEMYTFYJ2Z81MkZEgn016?=
 =?us-ascii?Q?0p6ZkhC2i5ORSt2MuPDWlikw7+7xEKrsxO2gPXUYB3mbGufW5WA6qAAmoP+D?=
 =?us-ascii?Q?xxo9YD0OO6sC94GlcMiRqwhNyK+UHwvtjTdfclnf2WcTQosHKpP+CE75BrGn?=
 =?us-ascii?Q?x8/vteMEE5HAdzMq81HNpVolWy+kgOrlVMoEvRrxe8X4EwrCDT8qLj3fZXUB?=
 =?us-ascii?Q?qeJ1A3TKE/a85etvO25koSokdS5PxzRQ1WzWtdq12AAiSFQyaq2Jcn7/jd+K?=
 =?us-ascii?Q?5AV0t4vhr3zGkiyAEpaH+pDDrCXCG5TBgSEP9Y4z2w9pKIK1h8wmY+fuFDre?=
 =?us-ascii?Q?utgpZeCQAfd1eRnd6AeqlwU47hssAuxEER6hO9/3d4kIGXdQyj1y85qNSFP8?=
 =?us-ascii?Q?KwFs556ABJBjGbzhVGQahYqetHf2YCKY/m5xhGj8QxqysG2GMQPsdtyv4rPJ?=
 =?us-ascii?Q?0ezke5IJ5l9NhnOaHuB/e6uPgPc1+r1da9ZiiC7kGKA520ZgmSj1RLmcDpeE?=
 =?us-ascii?Q?pKT+XDJqT/YSJsfiCSO3UqJp+oSXThrzKqvUVVrSr837izT8cB2zz3aKvaH1?=
 =?us-ascii?Q?bNkKd8vQxnFuwlF1zJiVIcbSxRmyf77kQvd7O+Tv0yns7OgAH2/xIFBKkE2q?=
 =?us-ascii?Q?uumRCk/QkSyfgpTb2oUQDIhHUXHbF8/8qmztK2qzkDRQf3Ip/5hlge1D61iQ?=
 =?us-ascii?Q?dCfnfUregrRNUEtQ5sIIwYUpw163EaBxYLLxlvbaViJirUcbX0z+XiDZPdxn?=
 =?us-ascii?Q?JFxJwTVCa3b9FAN3UnD/blio6dce59U82sY9dS9nRdFBkVK1IlQC3IApfAMT?=
 =?us-ascii?Q?ToBdnbIlqz9FGOQ9Z0K73i8frUvVDjANL1tJADjEgxXXoqBV8qZdHFxxvnPO?=
 =?us-ascii?Q?MEwlUgAOrA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa941cf6-96be-4787-dd44-08ded94f2d0c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 22:05:21.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ow/usQPr6oPxwcjr/HmY1oPgCEptVZm2/jMOloj6UPdQJYIFB9alXgGPTK7BE+MhxzLLXYCGE8iyZXkVJozJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

Populate pci_dev->hdm from PCI capability initialization for CXL.mem
functions. If Memory Space Enable is clear, temporarily set it while
reading HDM MMIO and restore the original PCI_COMMAND value before
returning. This gives driver-free reset paths an early HDM snapshot.

CXL core later reuses and refreshes the same cache. Move the register
helpers into the built-in CONFIG_CXL_HDM set so the early cache path is
available without cxl_core.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/Makefile |   3 +-
 drivers/cxl/core/hdm.c    |  58 ++++----
 drivers/cxl/core/regs.c   |   4 +
 drivers/cxl/core/reset.c  | 288 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c       |   3 +
 include/cxl/cxl.h         |  31 +++-
 6 files changed, 349 insertions(+), 38 deletions(-)

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index dc075cee0450..69cf2ea7ee74 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(CONFIG_CXL_HDM) += reset.o
+obj-$(CONFIG_CXL_HDM) += regs.o reset.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
@@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
 
 cxl_core-y := port.o
 cxl_core-y += pmem.o
-cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index bd1d92e5add2..7a1ade846c9c 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -84,18 +84,9 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->iw_cap_mask |= BIT(16);
 }
 
-static void clear_hdm_info(void *data)
-{
-	struct pci_dev *pdev = data;
-
-	WRITE_ONCE(pdev->hdm, NULL);
-}
-
-static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
+static struct pci_dev *cxl_hdm_to_pci_dev(struct cxl_hdm *cxlhdm)
 {
 	struct cxl_port *port = cxlhdm->port;
-	struct cxl_hdm_info *info;
-	struct pci_dev *pdev;
 	struct device *uport;
 
 	if (is_cxl_endpoint(port)) {
@@ -107,42 +98,42 @@ static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
 	}
 
 	if (!dev_is_pci(uport))
-		return 0;
+		return NULL;
 
-	pdev = to_pci_dev(uport);
-	info = devm_kzalloc(&pdev->dev,
-			    struct_size(info, settings, cxlhdm->decoder_count),
-			    GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
+	return to_pci_dev(uport);
+}
+
+static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
+{
+	struct cxl_hdm_info *info;
+	struct pci_dev *pdev;
 
-	info->decoder_count = cxlhdm->decoder_count;
-	WRITE_ONCE(pdev->hdm, info);
+	pdev = cxl_hdm_to_pci_dev(cxlhdm);
+	if (!pdev)
+		return 0;
 
-	return devm_add_action_or_reset(&pdev->dev, clear_hdm_info, pdev);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (info) {
+		if (info->decoder_count != cxlhdm->decoder_count)
+			return -ENXIO;
+	}
+
+	return 0;
 }
 
 static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
 				     struct cxl_decoder *cxld)
 {
-	struct cxl_port *port = cxlhdm->port;
 	struct cxl_hdm_info *info;
 	struct pci_dev *pdev;
-	struct device *uport;
-
-	if (is_cxl_endpoint(port)) {
-		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
-
-		uport = cxlmd->dev.parent;
-	} else {
-		uport = port->uport_dev;
-	}
 
-	if (!dev_is_pci(uport))
+	pdev = cxl_hdm_to_pci_dev(cxlhdm);
+	if (!pdev)
 		return;
 
-	pdev = to_pci_dev(uport);
-	info = READ_ONCE(pdev->hdm);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
 	if (!info || cxld->id >= info->decoder_count)
 		return;
 
@@ -948,6 +939,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 size, base, skip, dpa_size, lo, hi;
+	struct cxl_decoder_settings settings;
 	bool committed;
 	u32 remainder;
 	int i, rc;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 93710cf4f0a6..040b0304f63c 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
@@ -517,6 +518,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
 
 	return offset;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
 
 static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
 {
@@ -633,6 +635,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 
 	return component_reg_phys;
 }
+EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
 
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport)
@@ -641,3 +644,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index 4c977fc47f8d..97b72cc67b6b 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -2,9 +2,16 @@
 /* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */
 #include <linux/delay.h>
 #include <linux/bug.h>
+#include <linux/bitfield.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include <cxlpci.h>
 
 #include "cxl.h"
 #include "core.h"
@@ -161,3 +168,284 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
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
+void pci_cxl_hdm_release(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info;
+
+	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
+		info = pdev->hdm;
+		pdev->hdm = NULL;
+	}
+	if (!info)
+		return;
+
+	kfree(info->decoder_state);
+	kfree(info);
+}
+
+static int cxl_pci_hdm_find_bar(struct pci_dev *pdev, resource_size_t hdm_start,
+				resource_size_t hdm_size, int *bar,
+				resource_size_t *offset)
+{
+	resource_size_t hdm_end = hdm_start + hdm_size - 1;
+
+	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
+		struct resource *res = &pdev->resource[i];
+
+		if (!pci_resource_len(pdev, i))
+			continue;
+		if (resource_type(res) != IORESOURCE_MEM)
+			continue;
+		if (hdm_start < res->start || hdm_end > res->end)
+			continue;
+
+		*bar = i;
+		*offset = hdm_start - res->start;
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
+	bool committed;
+	int rc;
+
+	cxl_pci_hdm_read_decoder_state(state, hdm, id);
+
+	base = ((u64)state->base_high << 32) | state->base_low;
+	size = ((u64)state->size_high << 32) | state->size_low;
+	target_or_skip = ((u64)state->target_high << 32) | state->target_low;
+
+	rc = cxl_hdm_decode_decoder(settings, id, state->ctrl, base, size,
+				    target_or_skip, &committed);
+	if (rc) {
+		pci_err(pdev, "CXL HDM decoder %d has invalid configuration: %d\n",
+			id, rc);
+		return rc;
+	}
+	if (!committed)
+		return 0;
+
+	return 0;
+}
+
+static int cxl_pci_hdm_capable(struct pci_dev *pdev)
+{
+	u16 cap;
+	int dvsec;
+	int rc;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
+		return -ENOTTY;
+
+	return 0;
+}
+
+static int __pci_cxl_hdm_init(struct pci_dev *pdev)
+{
+	struct cxl_decoder_settings *settings;
+	struct cxl_register_map map = { 0 };
+	struct cxl_hdm_info *info;
+	void __iomem *hdm = NULL;
+	bool restore_command = false;
+	bool allocated_info = false;
+	int decoder_count;
+	u16 command;
+	int rc;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		info = pdev->hdm;
+		if (info)
+			return 0;
+	}
+
+	rc = cxl_pci_hdm_capable(pdev);
+	if (rc)
+		return rc;
+
+	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if (!(command & PCI_COMMAND_MEMORY))
+		restore_command = true;
+
+	if (restore_command) {
+		rc = pci_write_config_word(pdev, PCI_COMMAND,
+					   command | PCI_COMMAND_MEMORY);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+	}
+
+	if (!info) {
+		info = kzalloc_obj(*info, GFP_KERNEL);
+		if (!info)
+			goto err_nomem;
+		allocated_info = true;
+	}
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		goto out_restore_command;
+
+	rc = cxl_setup_regs(&map);
+	if (rc)
+		goto out_restore_command;
+
+	if (!map.component_map.hdm_decoder.valid) {
+		rc = -ENODEV;
+		goto out_restore_command;
+	}
+
+	hdm = cxl_pci_hdm_map(pdev, &map, info);
+	if (IS_ERR(hdm)) {
+		rc = PTR_ERR(hdm);
+		hdm = NULL;
+		goto out_restore_command;
+	}
+
+	decoder_count = cxl_hdm_decoder_count(readl(hdm +
+						    CXL_HDM_DECODER_CAP_OFFSET));
+	if (decoder_count < 0) {
+		rc = decoder_count;
+		goto out_unmap;
+	}
+
+	if (decoder_count > CXL_HDM_DECODER_MAX_COUNT) {
+		rc = -ENXIO;
+		goto out_unmap;
+	}
+
+	if (info->decoder_count && info->decoder_count != decoder_count) {
+		rc = -ENXIO;
+		goto out_unmap;
+	}
+
+	info->decoder_count = decoder_count;
+	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	info->decoder_state = kcalloc(decoder_count,
+				      sizeof(*info->decoder_state),
+				      GFP_KERNEL);
+	if (!info->decoder_state) {
+		rc = -ENOMEM;
+		goto out_unmap;
+	}
+
+	settings = info->settings;
+	for (int i = 0; i < info->decoder_count; i++) {
+		rc = cxl_pci_hdm_read_decoder(pdev, &info->decoder_state[i],
+					      &settings[i], hdm, i);
+		if (rc)
+			goto out_unmap;
+	}
+
+	if (restore_command) {
+		rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+		if (rc)
+			goto out_restore_failed;
+	}
+
+	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
+		if (pdev->hdm)
+			goto out_unmap;
+		pdev->hdm = info;
+	}
+	iounmap(hdm);
+	return 0;
+
+out_restore_failed:
+	rc = pcibios_err_to_errno(rc);
+	goto out_unmap;
+err_nomem:
+	rc = -ENOMEM;
+	goto out_restore_command;
+out_unmap:
+	if (hdm)
+		iounmap(hdm);
+out_restore_command:
+	if (allocated_info) {
+		kfree(info->decoder_state);
+		kfree(info);
+	}
+	if (restore_command) {
+		int rc2;
+
+		rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
+		if (rc2 && !rc)
+			rc = pcibios_err_to_errno(rc2);
+	}
+	return rc;
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
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..2fd186468498 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
 #include <trace/events/pci.h>
+#include <cxl/cxl.h>
 #include "pci.h"
 
 static struct resource busn_resource = {
@@ -2489,6 +2490,7 @@ static void pci_release_dev(struct device *dev)
 	struct pci_dev *pci_dev;
 
 	pci_dev = to_pci_dev(dev);
+	pci_cxl_hdm_release(pci_dev);
 	pci_release_capabilities(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
@@ -2679,6 +2681,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rebar_init(dev);		/* Resizable BAR */
 	pci_dev3_init(dev);		/* Device 3 capabilities */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
+	pci_cxl_hdm_init(dev);		/* CXL HDM Decoder Capability */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 80839517eabf..2215fe1c3f78 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,7 @@ enum cxl_devtype {
 };
 
 struct cxl_region;
+struct pci_dev;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -121,22 +122,46 @@ struct cxl_regs {
 	);
 };
 
+#define CXL_HDM_DECODER_MAX_COUNT 32
+
+struct cxl_hdm_decoder_state;
+
 /**
  * struct cxl_hdm_info - PCI device HDM decoder programming cache
  * @decoder_count: number of decoder settings entries
- * @regs: mapped CXL component registers for this HDM decoder block
+ * @hdm_bar: BAR containing the HDM decoder registers
+ * @hdm_offset: HDM decoder register offset relative to @hdm_bar
+ * @hdm_size: HDM decoder register resource size
+ * @global_ctrl: cached HDM decoder global control register
+ * @decoder_state: cached raw per-decoder register state
  * @settings: cached per-decoder programming state
  */
 struct cxl_hdm_info {
 	int decoder_count;
-	struct cxl_component_regs regs;
-	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
+	int hdm_bar;
+	resource_size_t hdm_offset;
+	resource_size_t hdm_size;
+	u32 global_ctrl;
+	struct cxl_hdm_decoder_state *decoder_state;
+	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
 };
 
 int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
 			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
 			   bool *committed);
 int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
+#ifdef CONFIG_CXL_HDM
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
 
 struct cxl_reg_map {
 	bool valid;
-- 
2.43.0

