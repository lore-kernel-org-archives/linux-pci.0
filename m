Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618613242AC;
	Tue,  3 Feb 2026 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087292; cv=fail; b=DjIRhPgSH35uTNXs/lsMngurc05YLDEikvy3BwoRdESSAclvPTwRcU/S0Z4e3HN7G4jvkxtAf9oJVRHPq+i4e4kGz2KdRrWPz7vp/daJxTmD0iCTULiTIDzXVOAn9abSbOSbCekPrpJI8tYv/kCESBtxiGpEp+3hHUihoNY3E+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087292; c=relaxed/simple;
	bh=wMXgnGfAmLkgBmerkGuOl+CdD5FvMldIkMjFiJnoW/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xym/Ch64Vl6yUdyrYedqSdj6VQk6BVN34r34AJL7fzx9blcPyF1z+gOV11HoKcdOVPj6dlP5DTLcKPhBy+YCrFxB8gXVvFjRMFQZI+arpOtetesgNLTItv8iAFs5KPTRGoiPti6U7VqRPVmNWvnGsCtZmQ9pgThAfxTsr8D+L+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gJcERxI+; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gJcERxI+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGN9jZFMkXzt8fTg2sGSiNIRoA7dZ1xDqNLi0pa+MzTxOmqAo2GFyZDsA3WQZe6IOP/pq50vmD4VeP4X2T2e38a+6IhVXTFd/10olJsgM6BH8ey+9SFRYNZjBHIIBS+kgntFTP22GQNEGCwEX8ncKa95kvlPO96WafTgi4GIjRdiHNiDY9q+ChZNwGShGjaBeUdyvCRXV+dcdlVhFWgmOpWE09Vehp9fA4fBxru2gri1cDtnR0ztfwq8JUoJEr1Kj2b24mOYN9LD507h7U93CkoNRab7Pf97yyf5XSAEg0IlNXHN4k8PP88lJ6OF3l+73cCWuSLGQzaoOj6n2V7XlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/tvwqfCo+UlVfodmu/junJ+7rCbq0gwzEOEb42DuJI=;
 b=tSaCKEm+/IRioFFGgtgAfCOSEDVhFeHOkSLyOkhiqJnbl6aVr6cD+2bH3mX4+RAdquEFpiG1pkbCdvlIBKblXIHcNXTxgJUPWKdFey7EKXjW/2TIe98cAlqPbJzazOcE2TQ3jLpUXeZ+hb3tMG95uEwI4VWs0Zn1EfB/XeW4tARJ6I0awgpW2SVMAqfzRGGFgesxd25AcZxjFv85j9CtSOZbnYUsqpmslQZ8VZEPE9m3EPlJbc1ce/iujoJPGmEIJqfvTTrUBCktX1t5wdwoqfp8lPRHga3XZ9qd3OJZuSWn78BXoY5WZ+2G1YqczaMKw1eP7oEakAAiJsyMJtENQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/tvwqfCo+UlVfodmu/junJ+7rCbq0gwzEOEb42DuJI=;
 b=gJcERxI+Xpvla3gRPAuxsqi5h052W6lIYyhLvIU52d15hn41eP+W23CXi33AeDVBxYYmSMXmgJGqIVI2FdQX31B1Sd+0zrC+5i473uzLF+z4TbHfZF4GGVlnaIFl8tZTdHZ+P9wOYtJNu7aPIVg8bfJozTd6qkeiY7YrwjoNnzI=
Received: from MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 02:54:45 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::e7) by MN2PR05CA0060.outlook.office365.com
 (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 02:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 02:54:45 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 20:54:44 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v15 9/9] cxl: Enable CXL protocol error reporting
Date: Mon, 2 Feb 2026 20:52:44 -0600
Message-ID: <20260203025244.3093805-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203025244.3093805-1-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c82db04-e76a-4c1d-1035-08de62cf9690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U05IYaVA6w5iVKUp1aOenH8Xm0jBy+iTaWwCuZ637W5YT00CtrXgGK8IYrft?=
 =?us-ascii?Q?/UaE0oPL5TI/pvF1zo+EHJUPivJXtOyG38qqn1zRMla8FLQd0JX4DbFYcKbM?=
 =?us-ascii?Q?yFhoTh5UfhkQ1onK0bE5Qg0EporDzDdcXg4gTwtPTJiGEEQ7z50lgw3CnuWr?=
 =?us-ascii?Q?/6qNvXvBe7kAMU1yL99uZ7OcY30OOP0u2B3tAC/smZqmK8oCjjNpXPjdxPgq?=
 =?us-ascii?Q?j7+Z4oINE5DNZ7rGROCt1wvAkKM+t3EMC8dhw5YItrfiME1fwAxNKv9oy/SV?=
 =?us-ascii?Q?RJF5g9m5UlOXZPVBy52ciyBemT+NbB13UClChJ83l+jrY76JXXJegAnTG+gX?=
 =?us-ascii?Q?6jXTb0pd/OYlNWs/5iNTUao1b2I9s+yPCzYXvVCJ2/Qro7AazowmnjUXvPO0?=
 =?us-ascii?Q?LNrP11qRupfUSZUuBtt4Jur6q4DdBurvgdgxkPJ70Vv4jd97Xnq3Pms4Wa35?=
 =?us-ascii?Q?WTFdjcL98yvI/8QX9IfmInY8VgV/r43XPzzefpTLRAnNxnB3pCBDHfhmW+QU?=
 =?us-ascii?Q?WV9XloIqYC0jKqrxAUBpd4Oyxm4LC1G1llB7QkuGE1vwqeoHOZp+dZQbiCBC?=
 =?us-ascii?Q?UbxJm0Fv1z6dDBbARzAcZjjFmPaZhnpp4Rel6PI0WVD2iC6B2Cmi9Rjz18Y8?=
 =?us-ascii?Q?YZM5CK5kjn7Uqr1OZtsBT247LjcPFHQbe0pRT6birowh5JQFATgpzchkda6Z?=
 =?us-ascii?Q?9yMTC2oo+FQNbOI03NM9Oy/gr8O3otQidHBR1o3zfjCmiNqcv9bsb+lJy24N?=
 =?us-ascii?Q?sHTUEn/tX9AA9xNtd4nkddpG6rUlCQMcURz6Q09L0l6Ut5vOMo7oJLoMNmnj?=
 =?us-ascii?Q?UIXcj5HIvUx+8BP4tpNJJdMltLDpmEkrL1uT0CNuwW5iK8IzumodMHtYY5Q8?=
 =?us-ascii?Q?nyz+qGikkR5ld2XSkhlO/J+6R6uQTa4FjugAXii/a1aEGWm6DbU1kHqnJOfy?=
 =?us-ascii?Q?Vpdan+sMaaXpDPXpLzwarrA9u6XZ8/Hhr2jou000lE+nbMrzsrjLdVl/JC2i?=
 =?us-ascii?Q?8waL9DZ+90mtLcBiPJfX8EMHe8S9s2HPYD//mYSMD/nze/5KykIM4XkuRnKg?=
 =?us-ascii?Q?Ufa+DXhNIY8SAocMOUAEdcvWQZzCISO/w/TpdceTNTc5y7Oh3YadRyXk3pg+?=
 =?us-ascii?Q?29kWVX50F+3mFqPjASdnU/CzqtH1ZwlzRKW0z0kXTJs0D/YghPHEdC/XJICI?=
 =?us-ascii?Q?wPITNfUFKruCkqjABqTYNMtJW2pE1ZtxgBYfUdu1DO+YEeRIkI5u9gTLPvWK?=
 =?us-ascii?Q?hjYdqIDphyWWTqZcmfDue34BgVz1c+nI388N4C7lTMJ1uY/hXT4zg4bV9rGE?=
 =?us-ascii?Q?nrEsjBaD+o9yaWMNpQiZ04jP95m5KF3euH9TUF5rwZW77GbdaJ3aAy1JJAx/?=
 =?us-ascii?Q?fASRzKOCc9S4MnpupakbviN8uGlX1G4/GlFP/U9iERziFl8qmu3lmntMmiLX?=
 =?us-ascii?Q?xqfAT9YlRG4bmYhDxoYfnslXtHKuCyedQndXNjDjXdQkPmu1p1+RW8jm0CdW?=
 =?us-ascii?Q?W+yWMVzeO25bhoCvm/ijmChGd9jsLvWLD90qvHVcikVHRiCzRSYMlWwecYmu?=
 =?us-ascii?Q?UW8xaWlFKQ4bG7uDs72nd6RAGFX+Y5CcYZb/9jC7AUZO9k2f97tzUdptS72Y?=
 =?us-ascii?Q?z4z8tugMyr9YlweQ+6ilGZfq08RdvItTtpDnaUQ9fCocXBfQm9O+Wxdj5L6G?=
 =?us-ascii?Q?wHHfGZ5WyrCuuLn2PzFMjNeNIHE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GmP1gH15ZDAvO/Krr2NUhRcnSFqXT5H4IqtNDv3WybQhOgZKgIEgZokalcWAPXXN6+TyEC3YYxMRbUOYzl2QNp1Klq+53Uq0IxRJYeTuIm0Wi/3kZEHgB3cCe7uweKjljhtdPuYpZSnlothBV/7jX1TuVtwxljMCF2eN8+TynSin6WBFYdW5kf6X7Q1tkepIUb6M8FngFhl0WOsLe+R/1guoXIMvFCMv5u/2BA/CiwKPnoxYgLN36hOu+23GaUWkLOpB46rm2oiMC5s+y8iR8HgIo8RCaTOifuKO0odwTKpUdJgnSwVi8EARNpUykcJEVdzXdavs6t2roP0214LvcqyoxxS0PjXBcxyXEy9uVRhbcWncJgTtgxoc0eEIIJfEbMVtKJeW4ZP1KLQg3Q3f6kUQG8fAhouF/r5SmXdKLiJvKPTqKH7j8yVNRaTCGkTq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 02:54:45.6530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c82db04-e76a-4c1d-1035-08de62cf9690
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

CXL protocol errors are not enabled for all CXL devices after boot. These
must be enabled inorder to process CXL protocol errors.

Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
correctable internal errors and uncorrectable internal errors for all CXL
devices.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

Changes in v13->v14:
- Update commit title's prefix (Bjorn)

Changes in v12->v13:
- Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
- Add Dave Jiang's and Ben's review-by

Changes in v11->v12:
- None

Changes in v10->v11:
- Added check for valid PCI devices in is_cxl_error() (Terry)
- Removed check for RCiEP in cxl_handle_proto_err() and
  cxl_report_error_detected() (Terry)
---
 drivers/cxl/core/port.c |  2 ++
 drivers/cxl/core/ras.c  | 22 ++++++++++++++++++++++
 drivers/cxl/cxlpci.h    |  4 ++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8e30a3e7f610..b63e8117d937 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1870,6 +1870,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 
 			rc = cxl_add_ep(dport, &cxlmd->dev);
 
+			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
+
 			/*
 			 * If the endpoint already exists in the port's list,
 			 * that's ok, it was added on a previous pass.
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index e5a0d0283d3f..d6c2fd4ae067 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -118,6 +118,24 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
+void cxl_unmask_proto_interrupts(struct device *dev)
+{
+	if (!dev || !dev_is_pci(dev))
+		return;
+
+	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
+
+	if (!pdev->aer_cap) {
+		pdev->aer_cap = pci_find_ext_capability(pdev,
+							PCI_EXT_CAP_ID_ERR);
+		if (!pdev->aer_cap)
+			return;
+	}
+
+	pci_aer_unmask_internal_errors(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unmask_proto_interrupts, "CXL");
+
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
@@ -128,6 +146,8 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
 	else if (cxl_map_component_regs(map, &dport->regs.component,
 					BIT(CXL_CM_CAP_CAP_ID_RAS)))
 		dev_dbg(dev, "Failed to map RAS capability.\n");
+
+	cxl_unmask_proto_interrupts(dev);
 }
 
 /**
@@ -171,6 +191,8 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 	if (cxl_map_component_regs(map, &port->regs,
 				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
 		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+
+	cxl_unmask_proto_interrupts(port->uport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index e3388dffdd75..b5fea624b2cc 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -82,6 +82,7 @@ void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
 pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 					pci_channel_state_t error);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
+void cxl_unmask_proto_interrupts(struct device *dev);
 #else
 static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 						      pci_channel_state_t state)
@@ -94,6 +95,9 @@ static inline void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
 static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 {
 }
+static inline void cxl_unmask_proto_interrupts(struct device *dev)
+{
+}
 #endif
 
 #endif /* __CXL_PCI_H__ */
-- 
2.34.1

