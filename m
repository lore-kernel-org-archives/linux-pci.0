Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7299395ADA;
	Thu,  9 Jul 2026 01:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559029; cv=fail; b=JTKitFDC4GuEFVdhQGRr5HGfpGZyU6GaGSVQAb/d2R0rsBzjgpK8/5rcvKLCxWK+HcVVTG1rBLLhJXvWP2r+brOrIZQacsiStDIeCpWPnX0MgXNx+0mNXkAF9DR9VaIyqsujX9Dm8DZqgPYN/qHllAChDrLkcGvb2Zhxstj0RrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559029; c=relaxed/simple;
	bh=GpGHdmmlSsknW53Vnv4CXcrSnBTQFuIXO4/Hyrb3OMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cH7cAbSRwOjOeoQoBsdaXyQPpUT3yt42uu5EKnN77Xigk0TJMsOlf0E9EFS9IWcd9qZRYT5erp1lMIrIjKzoopPuvjPqjjDyV4AKvUSQZPLxZOoyjDjLqw2gXw7WR7RrRFCcsPxAQuZiWgrI8ZBHK70rtece/Y5GtuP4TXfhUvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e4Lo+oUA; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e4Lo+oUA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfuvyWmTqi/598J5qnPvKcARH4gwxhjsGh6p984qghTnswx6wF5W1HS5u3FB0ZzXAFuDbPjoO9gnpLdyT5WEiEp4s94bDgHbMl9FpiTXuYbjDTX1BvLvu3WLFuuhf08pP+bHYra/c3dLA/Nge5S/n5rpritK1tpB6mi4W9jBsZ515D3RGmK0cfE24BDMKLniEollnt2W1XQcnKr1UOhbxsuQOgacl4alrPua8JorcF+k8Pv/QQHofdp06xnKGSuhhjzfucN8Kjy1w+RcKePXwwaJbB8EbMxkfZRF46Pk/uBUh8e4di8jw/kas+KzSpDXMqAkzM1+473I1jNfLmXkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCBrP5aaYhB1nOVfoJcB+2e55CyIFX//rBctQRxpxRE=;
 b=n/c7zQiRFKKMojFXumupcQY19QY6m4op4m70EHWDm8fwyZnKENyTT1Ou3mwdU0Cd/jy6PUGKDg+AnlUeh7TzEnmfaZMPxR4X8ExcLrHj0VBKuOaiIgiqygG/SLAVTIyxskNEu3MZU5+i5cel8m0Xlt2WEN7BPrnAx0zumDIJJlufT9ynPOssD1COuwG/RxqVvM4E1plAULfUEJye2Pkhw2DfTThZsJgjcJ2pWTuhlVqbAJSAambBETZhRKn2Zt0PApz85TSZM6glhdHVmoSsZYMZZcNLTABHTS/NIVKJIJFaiJQ1gC0x3jM1gwbDZrOAmJaF+VgbdfqwI2A4kXpNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCBrP5aaYhB1nOVfoJcB+2e55CyIFX//rBctQRxpxRE=;
 b=e4Lo+oUAjhTUiSb4CawaWsRNynrdtBdQmEFEIyHwmN1zrAoUJTLfAOg7nVgmd7o9PGLQi50eNyd268XESMouJlxz7Yoco+obm6T2PTvyzfb+ERek4gJtxdCxYdRN7ya7aYT8Cs1WKMNj/1U62LFPEgNi1RzRX85OtF1WRiENZEJrMcZF2t29Lfgyf5YKkpnl3yTcIUX7dRN9vobyALmWHQBSbNrabz5FSUYhANudCwo52ixjnct65Wpco0mNfKEqHChRCgiE8q6CG9WLWR39oLkC1+0OXxPKhw9IHry31aQclpaxgAiwJNXb72GxHv43y3E4USJGOa1J2I/zzxbELA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:03:44 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 01:03:44 +0000
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
Subject: [PATCH v9 04/11] cxl: Cache endpoint decoder settings during PCI enumeration
Date: Thu,  9 Jul 2026 01:02:57 +0000
Message-ID: <20260709010304.680422-5-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709010304.680422-1-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c71217d-1fe8-4272-69fb-08dedd55ec76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|5023799004|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	jI3R9RQrEnc4gVR9ywTGSii27cCLxBgDOhBRU9VMzZRA/xBop+aUSmN4q5hxRHO3W1LluSj28gyRq2gAlzprHFXp9k0Yz/ms9I3A3I30rsW2Vlhdnbxw9L5i/7XzTUGzhMejOGhTknbPpbkDAY9gOIJFon6XWm253x3Uv8hufvJkuqSqjOaAifz2bGxhsN3IYqUKQ/fGocAhSOyan9YU+MJJPDmwVCWPMMBCmlx2q8qXgglt5O83Rla1Ubc69jwczMjpQieZWTUv75DbpaNzahLDyaTiThY5383+bClARi/MX38Y6SBeKfu+hntfHBN+vw7iek+kQLMXaw2szZ24vSqXR6E1qBXtCihPSq+4T6OpHTZb+f5Rh+l0JWG1LuzwwUxGX7r+4QqK6lILkME1LBG6jGAxR1Zzdm1CyBeHPcib4wliO7R1WoFHAEpPBfzAF/zKh8r928SZy1zzyNnZX8Dzmv/qFvGEFoMlXcBCufGj6E1LtEO3QzN7UjDzurQZRfGz4GMZ1iJtpVIDpfbRX9XAhFvaXdEUuNJTAI4sCvlHhZ7MkvJiCe0ww+7dZshTfo9UGAABz+Kw5RVfCLXMFw5foX4UTxz/z7r5urqJ+E7LOL9n59SED3ACYG0zj9ccdFNaX5nwC52q6fmGzBDiKdGX1CrjXthlhf969wOcFJCyp3RTAbczCKsNHm9Nsy2qmm1OdRySJCjsV7fIeCzfLQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yFBXsFzgQzhcAh1xbZxvNSy076HrGebg2jAU9KlyItK1do/vsBp+rFAPha14?=
 =?us-ascii?Q?pwjshOLd5eVa5tDxdjqspVaGOZc+TUHKO64Pf/UIS1iXjg3jboivvjIq/A+o?=
 =?us-ascii?Q?HG1aSkGpo0wKNwuNQz5kInlBwfGZ9p1x3A+DP1lekXmft2qoliYHUUQ4fqyu?=
 =?us-ascii?Q?xFtlTM0oNGQAuJrAoF3exM4HS1hwzaFpneMI5UDbkmtJO3y45qBtCjYBqawZ?=
 =?us-ascii?Q?n8q9gsXbVqNJR7yIb5ToYhmyZfG7ff0Z7UdDiFXrnujXO4+ZEOg/O9JfarU0?=
 =?us-ascii?Q?38T36Su7IA9quNqRIckm6h6k4FDFdJv3Emzdbtf+de4iGxdMM61JGmjDLa0v?=
 =?us-ascii?Q?haGlFc6bgxzmEwkpcLIygyIbyU3koLx1O1Kl56LHs9zxIkoy6Dg7O+ZVcnLY?=
 =?us-ascii?Q?h9fQft79pl3n/9904kPUYJEBj3Hbhk3jQI8yDXGKtaREdbbh6rRg/ZrAAk66?=
 =?us-ascii?Q?DIS4GTj04o4PEWMPMUp9WM8WRT09rKaD49bvEllnIBUZc+6Mi1ZL7rdMYDw4?=
 =?us-ascii?Q?J9hZIcUxlQe86pgYUaKijSHhXfpj9Dms62LBnSkF0oz09wen98k+MVa4FEra?=
 =?us-ascii?Q?+TZa6qHy9Yw8ra4tdx4Y6DRA3AAqPh0BxXnxl8cLB5LyZ0UG4ov3NbkKVjEi?=
 =?us-ascii?Q?cryKv2BxNwfE7uAUH3LFF4hoSOLHgPihrM4e7Icls6e1Zaekhdg7m1FF/U7K?=
 =?us-ascii?Q?K/f3jVb1tmWjKn394tuvj1T4cL/PbZrbgIM66wmESKuzah76vjJmv56vm7Je?=
 =?us-ascii?Q?nzNDNJQINEgccAPH78T1SfIZS+JA6byWF0met2KZUM8NEk/1a2UBXC4fksto?=
 =?us-ascii?Q?yIehwyIuyB1i38N0kKyMsveFRixH/az0jN3B48HOkAzSf4GGWnonpOWINDLv?=
 =?us-ascii?Q?Itycd1Khw0Jq7TmYOnJKu4epoFXF2nnQgfVJag6iszNgGVdSBHBN8Adc01/6?=
 =?us-ascii?Q?G+P1HUzSrJEdSztgvtXBgDLRA1jRVoJGYtfoyq6IcF+BfO+JIayvo5kwtV6X?=
 =?us-ascii?Q?mjjA8OyUKiXmsCthLWDiHi5T2t4RP3x478pgjOHgF+aWcvG9SAJ/i02e3zdd?=
 =?us-ascii?Q?2iHeh52/Gjzk4/2t8cTM33uhz80yZFm1Db9D9HCJBdCEFt74+E+S3TN43sz8?=
 =?us-ascii?Q?TM/+w2qUcYX8Mj20Gj+2qrSys7cIosyWl7CtS2O3asR7Se0mnDOSO5lJlaLE?=
 =?us-ascii?Q?LDUsZhmmYsz78vo7zuRrY85WVvOdLn6qauxasm0jgojmJpQW//2ZPZuNf4Hk?=
 =?us-ascii?Q?IRzm9/altFOvp2VczuwMXroQ7cbKBNM0FVD6MlAcpqc6KYA+4XV6yhvxJEdR?=
 =?us-ascii?Q?O9RrYcxfAo0D+XKfiPEQNb9J5ezXcm/3NT1R6+WY+tJZf1vkFT8D92euzU33?=
 =?us-ascii?Q?UckLaoUXbhvAA7OPiUX2ZEUNDAb7Vx/5Vjt8+cH7X931s/1XlUFrnC2NmaVM?=
 =?us-ascii?Q?peO8FST8vrfWkZ8BuQZ6Ghu84UPYSxYlet5XDH+AF5n7K1ZUNtBJTpRCQCis?=
 =?us-ascii?Q?JnPFrsrhg93NbFQi4wijEtdm8k7VGjrjwemU5bsVz+DoZfQFq1058Kk/yduf?=
 =?us-ascii?Q?Kpbyh1+HNA+3Ue5dNuaB3G/oyAaPgrbGDEgyLlHH2GaSAOC++p9nXp+UMZHt?=
 =?us-ascii?Q?4/MRAr4JDA6AZci6N9Ud8xaNRenHJLk7gCVb2h1T1CLUQQWDsBJd3z59mMxr?=
 =?us-ascii?Q?j2hTS+n2CyGuGMDqwWRXy7kfnwG7Ybqa9g53tK5uzz9oJbT8Xymf6zZqgdDI?=
 =?us-ascii?Q?xtJCQNrElw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c71217d-1fe8-4272-69fb-08dedd55ec76
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:03:44.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImW7w1A0K4bHNK0XnXDMacI29OAcxV43T5mWXBQ7o9HWF7KQ40rIQn6w/By3JTiG73MJ8JdoXRRVyfk1SM47Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

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
 drivers/cxl/core/hdm.c    |  59 ++++----
 drivers/cxl/core/regs.c   |   4 +
 drivers/cxl/core/reset.c  | 288 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c       |   3 +
 include/cxl/cxl.h         |  31 +++-
 6 files changed, 349 insertions(+), 39 deletions(-)

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
index e9e00c68a0ad..7a1ade846c9c 100644
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
 
-	info->decoder_count = cxlhdm->decoder_count;
-	WRITE_ONCE(pdev->hdm, info);
+static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
+{
+	struct cxl_hdm_info *info;
+	struct pci_dev *pdev;
 
-	return devm_add_action_or_reset(&pdev->dev, clear_hdm_info, pdev);
+	pdev = cxl_hdm_to_pci_dev(cxlhdm);
+	if (!pdev)
+		return 0;
+
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
 
-	if (is_cxl_endpoint(port)) {
-		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
-
-		uport = cxlmd->dev.parent;
-	} else {
-		uport = port->uport_dev;
-	}
-
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
 
@@ -948,11 +939,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 size, base, skip, dpa_size, lo, hi;
+	struct cxl_decoder_settings settings;
 	bool committed;
 	u32 remainder;
 	int i, rc;
 	u32 ctrl;
-	struct cxl_decoder_settings settings;
 	union {
 		u64 value;
 		unsigned char target_id[8];
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
index dd0abbc63e18..8080389d1fc3 100644
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
@@ -2674,6 +2676,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
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

