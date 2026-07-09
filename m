Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736C3911AD;
	Thu,  9 Jul 2026 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559019; cv=fail; b=I458a22d6CTzskOnj5RWuKW4UNQJnqOu2CqZY72ewhABPwY8M/WRYHhRxPkfd73XenOptAvhg3X8LgOquLJOgyDcbh9rLe++kDiTs4e50BWguu1C0uQZI6qoR/Ed1YOf64EI28YNAUSiWWtMOM9ZIWZy6k27GCQYTvnjclAH3XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559019; c=relaxed/simple;
	bh=6PJ+0ag6aBIfaPIuTBosiZVIi6DiKpvk4isH6p/Dq68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UJybzuBqfrCoI+YhNKRrkz/3YcYf+te0yqjqYa/u+JbYTgFyBJCGRDyyW8al+DRx8UeOmsF7aUZ/s6RiTqS50FIkh0R8MrccVpKMeqmqUrvt8xPiYzxfu1RJ6xwrKwR/JmqOfh84iZIp7iK6GYXIP2iLrgOR00EREhHYw05kxH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fv9lnqqI; arc=fail smtp.client-ip=52.101.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fv9lnqqI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKzS4D5TKoKoAN0c/CAnKZjIVqTWjS+Xjm0Ma9RM/I+jrv2bud5yBmMGtOvwKhusP3k1+wsMkr/zdU4+NvmlXqUIDY9Q84hy96Fu9PVPOkx3u5xNHAyrDh2nupNejQhWHYI4iATfNsqSpteQRB66F8Teo3ZtQzZpOqVisDiSgs6+jqEYsVQJndZL9dL34FfvaN89DAseR34c4cFR79TrE1Izuz0eRNHLtg/hxqu3hvR0OhjHT7j1Ex1mwj227sQcKjDP1GvGrONzIe5ho5Dxx5PglaH9Ye00CxSVXhbJct91LO1rWNgCo9wS44EFN69TiuiC0TiF/OUSMHRzFrsSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0wAqCaSwTHhicpTOQelmhH+aoKXc6Is+1WATPiOsXU=;
 b=tUUoYcltqJn41S30IztFacMACpQfhhZ0DAvhdC6RXstGwrjQ8VJ2rn8UYqHJAgQm1u0XHe2Nfg++3RzEQWY/oNBGbyeqaqnBPFz7WOjGz9BVAqxFa9DfgiodKrsN190wcTzVHVmHH29vzoGD8OOSK6/J7t7lMPlVwEiiEx6qFNXvJyDHHXG1N7AWrUhfWvIsNT/TCTrz1zn4YRHsODAXE4DPR7OxiG3WQAB4n5v8yHxT0bedNLYIGNz1oqUj/ugGXE1ikeOQ62TWBscyDUOi9DFzOcdx9qKOuy61gQqG4YWMG8Hwl5QgX5YhPiTKx+YhafbBzZN63U/4Rx80oSxuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0wAqCaSwTHhicpTOQelmhH+aoKXc6Is+1WATPiOsXU=;
 b=fv9lnqqIH2ZMTF0uUWFD25lRNRujvRSORqvwxhhJ7mvYO27vTnDvq4LDyJKKSAIlsvfCC/BDeHi50Hqk8uKulhvufR4+esIxGdNZpYyOcFTORN5ob2KzHZplxsrP9VWA0UGOO0HYLSZtiIRzY0V7wdUWVMt404op9Qh1nseZ8YKjLhhCpdwJbEEhp209NBUJuVQH0T3JFVfsLN5XvMU1Fu62s3Bs3BI3KshFvZcblXB9PJ5u3bTwlgU4CMupR1+TkOo/zBt27aWkmQCxNEws4z140sLDe+0Zc9vZnqeT+F4EOy5wedJohd/z2kMlQSBpi03iL+fh8M8owwrryjyf9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:03:33 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 01:03:33 +0000
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
Subject: [PATCH v9 02/11] cxl: Cache decoder settings on PCI devices
Date: Thu,  9 Jul 2026 01:02:55 +0000
Message-ID: <20260709010304.680422-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709010304.680422-1-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce78387-a991-424b-45f2-08dedd55e60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|56012099006|3023799007|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	Aham+iYJOVHFs1c7f6tlyn05wqO42fRzwP75m7b+MFfRvnkRspcRBmYN3Ya5zMl3xK8Ie4u6DObu/UbbTVeHrxHNfZaES3hfE7BXUrqc/XrGc4dAuNtAfEs/+/vE60RRa2Dm09zhQNcErZ8qlU2qSzDb1H/lljuU22vx1RMvIr/h4GoxqkY9gpqmdkZA4k2H3VBIeekQpTtSzCyJwTUm1tekfeNNMfmZvM18dYcn0qfRgyNqhS0CsM7cZui5yLrZbv28ab7MPldSz65Z8R0vz3pT/id19FIu9zfYAoHJ20xVjGvPbjIiB7khn5Tu6rNEm9P4Dy6PWasuksKsWjGUNc1mLgu6pXKO8UYZq/ONcwABZ8zhueAeN0Pz7iIWOa7TMCsNV/Qv7VF0KUzDJvH+zdCKYOxAJSlFgyeehMAaS9iCvE/6RPhnMcQ8nsCJR07olQyu73G2WQIGgAeD0qEg28uxcpNGD35BUzGi9LOg4B7LlyRh4i3k9mENJmGqm6Y3NKpjcHp3HbzDwsl84U42oDmbj9CfJimWx27UCQNAhfWT1WTFEFFl2JzMKxys/SWPMuG6sJYEC/yT3blZCQgCII3+ZV+25gerUHK/GXQKCqLTY7Kk0ew/d93kXZsr0EiJqPX+UPhsNy51wir8ockjiS+W0imbtbNm+1fr09ZHixNpuejNyJL/1+P85qQHnYXcyJDmdtMcq0/jkAJgH8uc4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?suvw/BrhKeViNeRPJIyNiXDlbTIxMZsarD5SSY1J7BzE+OkIJTAA7Ondk5mt?=
 =?us-ascii?Q?aucKt/uqPxviI5oASMwHEeaCGZAxDRk8V91kE26URFShBr4FppYmR875TJCP?=
 =?us-ascii?Q?gouZ4zUzd2We644Fna7ws8NV9XbGKCrATbwGDa3/S3F76RTfF9dvC8GaLpEA?=
 =?us-ascii?Q?dTa/UhOfi+ECRQaKtymKPovVH9k34xJLWCvd+T49GMKRAwth6g5EWb1+4lRU?=
 =?us-ascii?Q?BIF+swDrnKBccfmgxfcvkocwCHWx4O6JRGOyLAhGpiIUgu6SyKsTKmFBWu17?=
 =?us-ascii?Q?iepHLrQ8dnPP1CL1p61TryD/HLlU6bCEjIcFpToMBAKCFkmf+1P3AQGkJBx9?=
 =?us-ascii?Q?Y3o3bbJDrQ7+nIpMIX7v2dlC241zqCkRV2XUc91bI+2sKh5rvPzjEdJpAPoA?=
 =?us-ascii?Q?kkZ8jzvoauxt421nCQVMYN8RHOOWM9RGT+ibFftQWME2XocP/2S6KBOnc7D8?=
 =?us-ascii?Q?bUBLYt8YPqeaiFt69kZ+Eto79kfCvtzG2SzrzgoUAIangYfe0d9SwhHOecCz?=
 =?us-ascii?Q?5YcQq5gGP/s0SUk+lfwN2NQYajA5XIUz9BqwXVHIkqyypvUKmKRiR8s+WgeN?=
 =?us-ascii?Q?HWv9piMZ29Rg6vzWc+Yrilu4uo5f3R9Ejy+w6F5ECDdBSL3YBBk/3a3Ak8xN?=
 =?us-ascii?Q?9IBii/+5cEG3Zlx3BZqAfL3gCEOduPXRgNomEvxA+qoKVNoTyHCglINKqVPG?=
 =?us-ascii?Q?cdPmtLG0C6w5RvbRb/XM0x7kBbqRVLNqPIFrum3STr1+l7jnIeD5aJFaYUlZ?=
 =?us-ascii?Q?TQKB5UukChKSIqzsg+a4QWi9ClvoESzM4bsXpR1+pf7d+IY+T9zvO5rBzmTz?=
 =?us-ascii?Q?NEB9BgSTjfuZJUa35zNkcv2VuuYwLof91ky53uzcwKleHYUBdibJ6ODKT5SP?=
 =?us-ascii?Q?PEYUfDJOhYhQTaHdaxSCihqAMJMDdXmDLKkeybdlTVqZDV7JveokL1FEcGjP?=
 =?us-ascii?Q?uDOK05l63jOsv54bZQnhRB0aJRMLVQGeINbt8jXpLnKAYEeGHFkLE957ACd5?=
 =?us-ascii?Q?/jo0MIPaKo6UbJCZhk5IrFSo1XAaijfXxWdaWGhPPmesqeniVMrTYWQmpDCx?=
 =?us-ascii?Q?aHsOjADriqvslZiWpUv5s7vuVaf2qazxNJLk+DAgYh4tJmrDwz5vxs3MnFck?=
 =?us-ascii?Q?1YcNtnH2sOYKYkqc1O0fRIzNy1lLcRPrhyqwXec9lKKYK5fEL9lT0y2zggV7?=
 =?us-ascii?Q?RiczgxDnkAhqqgjuv7K11Rtjvs5ckHRIQeMk6rrOGhGefqp9OO6lV/KzQPfi?=
 =?us-ascii?Q?q+2rA3BCPDgcDiePQwhDmwSurmz3uovY1cf+n2Li62jwsTwuHAlegngZhhKE?=
 =?us-ascii?Q?R5txX3VBYc4cS5B9tPuTTk3M9RBuW4qnSZL49Il1G4pQEMPjPZlYr4c6gA7s?=
 =?us-ascii?Q?xjksiRrV2NPEpgC31+r1m8LuzwgnY0Fd2RZURVMwPP8yuq08KOboSlXyI1DY?=
 =?us-ascii?Q?iLXK7lWCh0ORfmawXdSdjOCP3VYIYDPjwaBuV9LuVKRBTHG/ppJWI6/IQtLP?=
 =?us-ascii?Q?UR/18GyAsIS63GgDMzGZEcuqsbBYtQMKzRAFq1FvuYtqPhs07J3HzIGYxptg?=
 =?us-ascii?Q?+5nly0jvGUG/Q6r6uFrpqiwAZW8cdDVk5Py/jzEMCR/2nEV3WnE3vTBUC3de?=
 =?us-ascii?Q?sKNYiIV7TImLgh/lvqUaTvzTwEKVCMRdBg4kVJzFYQQwTZYlas4IdEkg7+Uy?=
 =?us-ascii?Q?rkfaIAPTA6xWI3qWQCeXd5MOssWHbf1G3+2rGHz8OHgg6PoZ+E7DiZ+Em7v8?=
 =?us-ascii?Q?6Bbxdg/jQA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce78387-a991-424b-45f2-08dedd55e60b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:03:33.6274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEpCUyAkYwGoDaNuhwhBxC76H/4j4vFOe+xXo3tqPN9/7ZbpBQtU4c3IPAEDgaRPfpG8dGU5X+IwGhn6HOUlaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

Cache CXL core's HDM decoder settings in pci_dev->hdm as decoders are
enumerated, committed, or reset. PCI reset paths can use this snapshot to
restore HDM programming without walking CXL topology during reset recovery.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c | 81 +++++++++++++++++++++++++++++++++++++++++-
 include/cxl/cxl.h      | 12 +++++++
 include/linux/pci.h    |  6 ++++
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index fa978c297546..83cda63f76a5 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -84,6 +84,76 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->iw_cap_mask |= BIT(16);
 }
 
+static void clear_hdm_info(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	WRITE_ONCE(pdev->hdm, NULL);
+}
+
+static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
+{
+	struct cxl_port *port = cxlhdm->port;
+	struct cxl_hdm_info *info;
+	struct pci_dev *pdev;
+	struct device *uport;
+
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+
+		uport = cxlmd->dev.parent;
+	} else {
+		uport = port->uport_dev;
+	}
+
+	if (!dev_is_pci(uport))
+		return 0;
+
+	pdev = to_pci_dev(uport);
+	info = devm_kzalloc(&pdev->dev,
+			    struct_size(info, settings, cxlhdm->decoder_count),
+			    GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->decoder_count = cxlhdm->decoder_count;
+	WRITE_ONCE(pdev->hdm, info);
+
+	return devm_add_action_or_reset(&pdev->dev, clear_hdm_info, pdev);
+}
+
+static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
+				     struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = cxlhdm->port;
+	struct cxl_hdm_info *info;
+	struct pci_dev *pdev;
+	struct device *uport;
+
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+
+		uport = cxlmd->dev.parent;
+	} else {
+		uport = port->uport_dev;
+	}
+
+	if (!dev_is_pci(uport))
+		return;
+
+	pdev = to_pci_dev(uport);
+	info = READ_ONCE(pdev->hdm);
+	if (!info || cxld->id >= info->decoder_count)
+		return;
+
+	if (cxld->flags & CXL_DECODER_F_ENABLE)
+		info->settings[cxld->id] = cxld->settings;
+	else
+		info->settings[cxld->id] = (struct cxl_decoder_settings) {
+			.id = cxld->id,
+		};
+}
+
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm;
@@ -747,6 +817,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		return rc;
 	}
 	port->commit_end++;
+	cxl_hdm_info_set_decoder(cxlhdm, cxld);
 
 	return 0;
 }
@@ -819,6 +890,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxl_hdm_info_set_decoder(cxlhdm, cxld);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -989,6 +1061,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
 		target_list.value = (hi << 32) + lo;
+		cxld->targets = target_list.value;
 		for (i = 0; i < cxld->interleave_ways; i++)
 			cxld->target_map[i] = target_list.target_id[i];
 
@@ -1062,11 +1135,16 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	struct cxl_port *port = cxlhdm->port;
 	int i;
 	u64 dpa_base = 0;
+	int rc;
 
 	cxl_settle_decoders(cxlhdm);
 
+	rc = devm_cxl_pci_setup_hdm_info(cxlhdm);
+	if (rc)
+		return rc;
+
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
-		int rc, target_count = cxlhdm->target_count;
+		int target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
 		if (is_cxl_endpoint(port)) {
@@ -1101,6 +1179,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 			put_device(&cxld->dev);
 			return rc;
 		}
+		cxl_hdm_info_set_decoder(cxlhdm, cxld);
 		rc = add_hdm_decoder(port, cxld);
 		if (rc) {
 			dev_warn(&port->dev,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 757d916a6330..84924ca06e52 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -121,6 +121,18 @@ struct cxl_regs {
 	);
 };
 
+/**
+ * struct cxl_hdm_info - PCI device HDM decoder programming cache
+ * @decoder_count: number of decoder settings entries
+ * @regs: mapped CXL component registers for this HDM decoder block
+ * @settings: cached per-decoder programming state
+ */
+struct cxl_hdm_info {
+	int decoder_count;
+	struct cxl_component_regs regs;
+	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
+};
+
 int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
 
 struct cxl_reg_map {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c..a8e5cec96bae 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -335,6 +335,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_CXL_HDM
+struct cxl_hdm_info;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -562,6 +565,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_CXL_HDM
+	struct cxl_hdm_info *hdm;	/* CXL HDM decoder reset state */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.43.0

