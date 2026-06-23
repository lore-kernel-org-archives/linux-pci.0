Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC472FFF81;
	Tue, 23 Jun 2026 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185110; cv=fail; b=RZTRZI8+LBd19JENmgBwj+/buLXPFXb4yE2LdhDjJHk7SdlM8bt6RLHz3U8JKtlJS9ugx7VXR0v8w3XEx+CSXZooBrMOQGOck8eKzDjD0nwmLjKw3Zw/lscLZIkGe1Bk7fP4mJYIP9O69bhgQwMBVtWntPS+LjpU9+Uhpz73CKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185110; c=relaxed/simple;
	bh=24IDfbhp7Vn7fFRjPP89bCFqmESQxn4UWBtbguG+vx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TLJWLysxk33LaaBk7MYpbuMs2VpT0ZdXlaKSmddw1Ot2tiQtfzos+c3Jt/6nmmmfi1jrDOR8YpEVNmdOzmaqKTRmnbiFUA8h5slhJHJAfDvPmhOG1hL0mdTILcGY1tT28CILlevbSAk30KrB+JmYrULY0Kke1j3/DJbD7UXYA68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DiHQtxES; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DiHQtxES"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtcbKqXqXncYIlRgp1A9pK4DICytmSl1lgho3Pw3bpEhv7yrKget1vp0eXPsMZtAKmTrH7MqliWXygB7hjkNTVg3Jwm29yU952Th/66K95SR5nMk5hviv/rwRdCvXIIZS2ef9P/fIUNyIcatB9NOyS5NuF1SZTNbEbHiVWy7NShMq8BaJgJG3d45+G34Ys9gOALIiOTXmE05f3JMovLrJXx5ligUjXH5gs6HCssYj0I54oWSHb2QxSkFKUOYfrUot9BEOBFvJPnq0F/Ox4Cn0jlaWOh/ZvjnuYqhVTZu81MnfxLiOs8EMUNnxMAUNk6DbNq4U1rk5hRJxByFKUbBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJiX0ZK1kBJ3o+sRqB2SzYhtxu+BUWBjb9OUWdFMTNw=;
 b=n/g+I+6e+wSGa3PDgMSHV9ZdknMe0onRst712g2vCwFBM5nVYf8V6Gz+wqKEKAwWrMJPBXESp8AbTiA2jPYHHQScl1Og+aviRWVquthWz+cJ73QBV1uYG3FSectaJkZ2aluxS2h/LF2rLZOR8JzbyNPZPh3TBHu7s5hCxyA1Io3m4KGJfvC9kGzqLLB5gXE0+eVxfJqyP11+18KZD0ReuNPPdyKaFefeaFtCfigwUJrIEIiGpWNWA7jjzK+LqjidremRxr2hzOIm8Z6rAL5MeB0dP0vEtZ0Spt24RVfQLCrSfpY9aTdtqvlyYeTrgUG6h2u/aHxEKD8qAK3fZn+Sog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJiX0ZK1kBJ3o+sRqB2SzYhtxu+BUWBjb9OUWdFMTNw=;
 b=DiHQtxES107trdwYzAhRNkDs+sDN/v0gdE6eN8O8rNkwKT4Nm0YB12ptmITLXJ4LCB6bI6G3jnAth6WYZCDOEA7oi4tD3tO7q8hQ4oer2GV/jfK1reVXrj5wdoCGRrquXYM0+nWa+WX/t1oc6RMgpKef13MYTQG0WzSiB6NcnPlHeTe7ti09w38cDUPFohjJE1PbODPpL5CfeiPWK3FEV0d2brRpzlQtfYdS2FzIf+fLsrE/IYgh0rieGlu4YoSrYf8APhoeK5obDm/pEyuafeHgclsI31pNakvBPiewZh/dLXkjNdPCthFmvoVTLUgOU6SstiRm67spD5IAo13UAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:25:04 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:25:04 +0000
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
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v7 03/11] cxl: Cache endpoint decoder settings during PCI enumeration
Date: Tue, 23 Jun 2026 03:24:45 +0000
Message-ID: <20260623032453.3404772-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623032453.3404772-1-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0136.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::21) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5c74c2-7c05-4d55-ae5b-08ded0d70455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|5023799004|921020;
X-Microsoft-Antispam-Message-Info:
	7j1oUpbepRhQkfOSlGdFsZb/6v+NnjHlut9ZQlZyjub4NXkKID7yZFSIv8WS9v1C9Vy91b+53wxkWeKEB+bclMNXitv/g3UGyFnC1JIcITl/q6/wQrFTx9oYLGx80Ya0TZyfFS1hUxmjUEUw+9+SDc3P98IAGkMmUmtOvYlV1rEIbJkXSQxfT1t0XLPHIPmrWefKZhizzn1fBynySvJ605ited2XJvn1ef78fAObUkfllYwazoyDYmvJHNQRhI54TRs8uCeMxLRPZ77mPDsr4GpsOhv5/MOdJVlZal1ydIvYsKBuSGcZ2eoPNb+q+kFFLuIjv1dTvLBrmHmt5OTXJSTqbYVoMo9Ce4+NtkIqR862s5quFBihHo5+AGaVvq9jeKMcVy1xj/4NqpbNvx4zrlHfQy7moi1H4Aqvb56XSjHtNvG6gnWMLSyqELxBBURSPl2vk3eM9kYPVCa14eftnS3zZ/X3Ns5k/9Mr7cEvzAQaeiyQoN9iPGWcaaOr8Gv+8LfHqbPAx7WSibZ9WQc8OaS6NyD2pOB31dfUMp43e6yjoUa5e10eleOsnXAWdj47cKaAWMdD1EU1Dwfzj8bKtXuK8s3MogWuyr7B4Inaza2NFGAPCbmPehgNf56U0S1l2o1exS6yiEYaDfHyQdHwu9LL5GVRY6Ek4pi0q1b+jdozdcSRVipXG494oSoPADHeUQ0Uf2kzdSPvlIbldiXcsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(5023799004)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1k35fLFCkGC1E47yB+mE5sEaF9Pa2SbhtSBZYmeZCBoRl4Ij+AgMAolHQ/zf?=
 =?us-ascii?Q?PUwtSVSwabpj20OdxwWJtCOgynwG748H/1VHP+PQFhwc1z+HLMtU4v9IzI88?=
 =?us-ascii?Q?ii/vS9m/ElzxpeWR6v5n4vRYD3r8CMGWdaCtAK49aMtUyJNdfPoXbOWuqgO3?=
 =?us-ascii?Q?JQclF4S9KW5yGJpPSugw+ZluoFlEumGJwj+6jPqXYkd+wVW4f5+CgGwC2vcn?=
 =?us-ascii?Q?rKp3dkYOQbmVLz3LZfn5J1LlC6ICxcGdAHQbHcgCd/S33lDPLcAqFntzgwsF?=
 =?us-ascii?Q?90r3E9PrFGH9CGd2zg0Tji7emeQY4x8ImLFJLJlZiy4aW8GTgeAx1oEjDfIi?=
 =?us-ascii?Q?thZGyJGCxR6GFUJKyGFLdOCYGu/9a5D8mweGPAOigQRy0jSVJNiEQFJ5Qe3G?=
 =?us-ascii?Q?7LFQvTNzdAhwgT6OMleVucnRxqkAiM7K3k6hEaYj+G6uLPTW7ZBk0BR+7ggG?=
 =?us-ascii?Q?cdazwe0BbDA6ppTGNCF2wvSMLVmN9/RMIbS2h+5isHPESeYONpYxHOJQsd5J?=
 =?us-ascii?Q?0kEN4Yrk2ycbIttsU9ruFzRoFRBLo7KJa9Ep2VCyHpWGgBZ0Idx6hombaRHe?=
 =?us-ascii?Q?/m5lCsU8cJxMeMywoN0iXH03Xum4WGM/lmeoHZPpEREyhM0w4WFmdJZP2ddy?=
 =?us-ascii?Q?9Gq05M85EGIXLLMfKI/L2XJOGxKJmV6nZ6H/KD0/x/fTyxVF9xPMwkN15ql/?=
 =?us-ascii?Q?BcaRvXieGQU5d0gc8Obv4HueqnIuoND2D2pppJJgz4hT1UoaSx3XLSLNSu05?=
 =?us-ascii?Q?6DbvdXjI8Z/PC7cQdX3Qw3tLnVftDeq9E8BOG9TSBWlpEgGEcpaq6J+tp8Z+?=
 =?us-ascii?Q?giY9GcdfoGbuK7VF2c/1E/HleUWiziEOunufQaLoC8/o7vGpp/OsqbD1zp0S?=
 =?us-ascii?Q?1GvfA9PfdHX+QMElP//X51L44E6S7jolV2pjJJGnvE81Lm5VSdQW72vMAmmx?=
 =?us-ascii?Q?UQnD8Pxp/e3U8+2ME/hHSwb7Jq+S0huqe+vG+U2C2oXagZ9mLK9l5IZpzeYC?=
 =?us-ascii?Q?0Yp1GO/BfNePK3EdqqIXAkSGtxdNKrDApDNk2wBsG7TsISGew4rjQzsHStO5?=
 =?us-ascii?Q?D0MROAx6CSOLyMemKyTit9Rd3SsBaUO+LbjC31W7qg7ZWqWVpApgL4hybwvh?=
 =?us-ascii?Q?EYSHO7UkdCABifIcGz2VxTukpUw9m5mPLPGzm7UBtSTKxftQebyjSxdFS07H?=
 =?us-ascii?Q?m+aG9zhNtwzKhq3Cs6S7mRA5iulxChjhiDH92c7RpDtDflOGWPPz2APImti9?=
 =?us-ascii?Q?TyPfj/yo3nC9VbtQ5ZKZA50iY7VnWqZ2QxxEVbG/tlMl1sKFrlbrBvLU+LpK?=
 =?us-ascii?Q?M32xTWmxYbnMzq5sTDoMs1qmXLMH/QSMQPct517CTONXEyBhygvZXmPAX6Ij?=
 =?us-ascii?Q?x30FnmH9+6ixQn/twHDYPwG360Lk6zSao/I6h5Xg11jxNSuGFR/Ilm4HyrVX?=
 =?us-ascii?Q?oPjkaMTe7T5IMSOvpOKD23Mno+jsP3WG3gK558l4zgUYgn4Lny8wPZOqH3eZ?=
 =?us-ascii?Q?yFr0kgA3ymvYyPJxCq+gulFf4L/IoRr1yBoQkDEqtcrf7KoTuRz4SadlzN2Z?=
 =?us-ascii?Q?hWX3rFkMilLrwQSl9lysqsvjoD1Zr83ipQ0IntHqbEz+tmTQIiF913RHdf+o?=
 =?us-ascii?Q?xw4jCVG/fwJ0+IZmqrr9kSAZTFJ4TEocNvg7nWVFa5rfaF5O69mP/vcw5awj?=
 =?us-ascii?Q?NLhTrvFqL2AmKB4NBsQE2IWTavCJOvQ+FR06yYe+ppcERWmJi8NcFUPLtqnN?=
 =?us-ascii?Q?rkbO66mesg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5c74c2-7c05-4d55-ae5b-08ded0d70455
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:25:04.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFSbC/727AMNBadXy0d0bxxc+Asr7F1vA/ght2aqnY+kALv3NZMvub1Bz7tea3nATiUmT4/QpgqJnjlpN5ooRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

Populate pci_dev->hdm from PCI capability initialization when a CXL.mem
function already has memory decoding enabled. This gives driver-free reset
paths an early HDM snapshot without enabling BAR decoding during
enumeration.

CXL core later reuses and refreshes the same cache. Move the register
helpers into the built-in CONFIG_CXL_HDM set so the early cache path is
available without cxl_core.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/Makefile |   3 +-
 drivers/cxl/core/hdm.c    |  59 +++++++----
 drivers/cxl/core/reset.c  | 202 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c       |   2 +
 include/cxl/cxl.h         |   9 ++
 5 files changed, 252 insertions(+), 23 deletions(-)

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
index 83cda63f76a5..0230ebfada42 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -91,11 +91,9 @@ static void clear_hdm_info(void *data)
 	WRITE_ONCE(pdev->hdm, NULL);
 }
 
-static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
+static struct pci_dev *cxl_hdm_to_pci_dev(struct cxl_hdm *cxlhdm)
 {
 	struct cxl_port *port = cxlhdm->port;
-	struct cxl_hdm_info *info;
-	struct pci_dev *pdev;
 	struct device *uport;
 
 	if (is_cxl_endpoint(port)) {
@@ -107,9 +105,27 @@ static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
 	}
 
 	if (!dev_is_pci(uport))
+		return NULL;
+
+	return to_pci_dev(uport);
+}
+
+static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
+{
+	struct cxl_hdm_info *info;
+	struct pci_dev *pdev;
+
+	pdev = cxl_hdm_to_pci_dev(cxlhdm);
+	if (!pdev)
+		return 0;
+
+	info = READ_ONCE(pdev->hdm);
+	if (info) {
+		if (info->decoder_count != cxlhdm->decoder_count)
+			return -ENXIO;
 		return 0;
+	}
 
-	pdev = to_pci_dev(uport);
 	info = devm_kzalloc(&pdev->dev,
 			    struct_size(info, settings, cxlhdm->decoder_count),
 			    GFP_KERNEL);
@@ -125,23 +141,13 @@ static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
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
 	info = READ_ONCE(pdev->hdm);
 	if (!info || cxld->id >= info->decoder_count)
 		return;
@@ -202,6 +208,7 @@ static struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	struct cxl_register_map *reg_map = &port->reg_map;
 	struct device *dev = &port->dev;
 	struct cxl_hdm *cxlhdm;
+	struct pci_dev *pdev;
 	int rc;
 
 	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
@@ -227,11 +234,21 @@ static struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 		return ERR_PTR(-ENODEV);
 	}
 
-	rc = cxl_map_component_regs(reg_map, &cxlhdm->regs,
-				    BIT(CXL_CM_CAP_CAP_ID_HDM));
-	if (rc) {
-		dev_err(dev, "Failed to map HDM capability.\n");
-		return ERR_PTR(rc);
+	pdev = cxl_hdm_to_pci_dev(cxlhdm);
+	if (pdev) {
+		struct cxl_hdm_info *info = READ_ONCE(pdev->hdm);
+
+		if (info && info->regs.hdm_decoder)
+			cxlhdm->regs = info->regs;
+	}
+
+	if (!cxlhdm->regs.hdm_decoder) {
+		rc = cxl_map_component_regs(reg_map, &cxlhdm->regs,
+					    BIT(CXL_CM_CAP_CAP_ID_HDM));
+		if (rc) {
+			dev_err(dev, "Failed to map HDM capability.\n");
+			return ERR_PTR(rc);
+		}
 	}
 
 	parse_hdm_decoder_caps(cxlhdm);
diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index 14f024098e82..fc52d3abdb5b 100644
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
@@ -116,3 +123,198 @@ int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm)
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_commit, "cxl_core");
+
+#define CXL_HDM_DECODER_MAX_COUNT 32
+
+static void cxl_pci_hdm_clear(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	WRITE_ONCE(pdev->hdm, NULL);
+}
+
+static void cxl_pci_hdm_unmap(struct pci_dev *pdev,
+			      struct cxl_component_regs *regs,
+			      struct cxl_register_map *map)
+{
+	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
+
+	if (!regs->hdm_decoder)
+		return;
+
+	devm_iounmap(&pdev->dev, regs->hdm_decoder);
+	devm_release_mem_region(&pdev->dev, map->resource + hdm_map->offset,
+				hdm_map->size);
+}
+
+static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
+				    struct cxl_decoder_settings *settings,
+				    void __iomem *hdm, int id)
+{
+	u64 target_or_skip, base, size;
+	u32 ctrl, lo, hi;
+	int rc;
+
+	*settings = (struct cxl_decoder_settings) {
+		.id = id,
+	};
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		return 0;
+
+	lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	base = ((u64)hi << 32) | lo;
+
+	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	size = ((u64)hi << 32) | lo;
+
+	if (!size || base == U64_MAX || size == U64_MAX ||
+	    base > U64_MAX - (size - 1)) {
+		pci_err(pdev, "CXL HDM decoder %d has invalid range\n", id);
+		return -ENXIO;
+	}
+
+	lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
+	hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	target_or_skip = ((u64)hi << 32) | lo;
+
+	settings->hpa_range = (struct range) {
+		.start = base,
+		.end = base + size - 1,
+	};
+	settings->targets = target_or_skip;
+	settings->target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
+				CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM;
+	settings->flags = CXL_DECODER_F_ENABLE;
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+		settings->flags |= CXL_DECODER_F_LOCK;
+
+	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			 &settings->interleave_ways);
+	if (rc)
+		return rc;
+
+	return eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK,
+					    ctrl),
+				  &settings->interleave_granularity);
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
+int pci_cxl_hdm_init(struct pci_dev *pdev)
+{
+	struct cxl_decoder_settings *settings;
+	struct cxl_component_regs regs = { 0 };
+	struct cxl_register_map map = { 0 };
+	struct cxl_hdm_info *info;
+	bool allocated_info = false;
+	int decoder_count;
+	u16 command;
+	int rc;
+
+	info = READ_ONCE(pdev->hdm);
+	if (info && info->regs.hdm_decoder)
+		return 0;
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
+		return -ENOTTY;
+
+	if (!info) {
+		info = devm_kzalloc(&pdev->dev,
+				    struct_size(info, settings,
+						CXL_HDM_DECODER_MAX_COUNT),
+				    GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+		allocated_info = true;
+	}
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		return rc;
+
+	rc = cxl_setup_regs(&map);
+	if (rc)
+		return rc;
+
+	if (!map.component_map.hdm_decoder.valid) {
+		rc = -ENODEV;
+		return rc;
+	}
+
+	rc = cxl_map_component_regs(&map, &regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
+	if (rc)
+		return rc;
+
+	decoder_count = cxl_hdm_decoder_count(readl(regs.hdm_decoder +
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
+	info->regs = regs;
+
+	settings = info->settings;
+	for (int i = 0; i < info->decoder_count; i++) {
+		rc = cxl_pci_hdm_read_decoder(pdev, &settings[i],
+					      regs.hdm_decoder, i);
+		if (rc)
+			goto out_unmap;
+	}
+
+	WRITE_ONCE(pdev->hdm, info);
+	if (allocated_info) {
+		rc = devm_add_action(&pdev->dev, cxl_pci_hdm_clear, pdev);
+		if (rc) {
+			WRITE_ONCE(pdev->hdm, NULL);
+			goto out_unmap;
+		}
+	}
+	return 0;
+
+out_unmap:
+	cxl_pci_hdm_unmap(pdev, &regs, &map);
+	return rc;
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..9e214446fd42 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
 #include <trace/events/pci.h>
+#include <cxl/cxl.h>
 #include "pci.h"
 
 static struct resource busn_resource = {
@@ -2679,6 +2680,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rebar_init(dev);		/* Resizable BAR */
 	pci_dev3_init(dev);		/* Device 3 capabilities */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
+	pci_cxl_hdm_init(dev);		/* CXL HDM Decoder Capability */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index cc933379f67b..e3087b7517e8 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,7 @@ enum cxl_devtype {
 };
 
 struct cxl_region;
+struct pci_dev;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -134,6 +135,14 @@ struct cxl_hdm_info {
 };
 
 int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
+#ifdef CONFIG_CXL_HDM
+int pci_cxl_hdm_init(struct pci_dev *pdev);
+#else
+static inline int pci_cxl_hdm_init(struct pci_dev *pdev)
+{
+	return -ENOTTY;
+}
+#endif
 
 struct cxl_reg_map {
 	bool valid;
-- 
2.43.0

