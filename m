Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E136B923;
	Wed,  2 Sep 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334114; cv=fail; b=CUtACCAKHUzIjLeC1ivFA7rPf3lrW7pqn40qapUrMe11kF+7ajk2LT64tMDfrlTv5cvju9BJ+QYCxzZBGrH1ITv+THhbm7T5WogmFtSNBihcPs5Ncd7h/zmTOPsHqNPKDvuXDbUf3KesJgrVmRA/k5xZEWpLztVbI6Q9f95yhN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334114; c=relaxed/simple;
	bh=5EGNfEca/Af9MAzM/9TjjEzj/aW4u9jpiEVetKlbybc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EY7TOKSGrcCgoVVwWzs+cJ7T23yhwB1tnUqRCpeFr5qPap6RXjDzp7QlH8nQ4e4M/NvlxxAxvWTdUOl3cJhwpB2nmvbVyOWXFh6ZuWIaIvEzmW0BUP75Z7H+HICcpzrZW1W5/y+9UFu8Fmb1heT/y7uVDMAdPNfjFs7oZv+js3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eqn5b6f+; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eqn5b6f+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+M+yE0y2NI6KHghsVke4/EfO78pCdVP8fs5YlCrhh54vJJzL75P6CiF0CcDqCjAgi/Qgqo58FyVFrvnvJmOqakhJWEGuMJKhYCCqlwbP8SeFuABsJSaDks2/4pH+HJJX5ScdPOoTC0HAzAuDISwtwgooCBNAH+pAMjUNkKB2LNIKIrTSmqkaTmYe7+cJBzWYCa6SLtftAecuQ9oYEFR9m8YdBOXmC7qbWlgNEZUe+3hj3RYr7Wxhz/qBlqSLosY6IQosJhSsRgpMREPe4vM+i3UedVCMEQ7crkl9ZfZXQO+tSLylJdRHPPi2p4KZs0FeWQgFYmLDBkn/hTpoqTnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sznJRaHD2CnhGyT+VP1j5BPzD8aX4/+pRayqtNGZ/Os=;
 b=cfolXfEMkRGqHKBRAlDDPVg2LvfMUZgU0rQIALGLkMRUDeuek6qCv4g4A390KaYeiB8IlfLubZrYk5pz2SjbsrMdanlOY1TlkyV7AvY/lK9+ICkc65wxuHBr78YaZgdw6NCyCRiyOwaZvRzR3JkL8s6/23fq4gXe2/EBoAmTY00nmKc6oUXkcZ1v8I/L+76f+tf1xQt6XHR3FNKpmayFlyY5EzKog+rpVgaXBntJrNvgseYZgUWkLz6/KvgtfCkDHRMD9i0VcZwNw0aJkWk174EZK/EzYMUSFZG3SC8r00xW+HJSYxKnBpopB+pwq/uBz/NMnPvo26ZSOYHAayXKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sznJRaHD2CnhGyT+VP1j5BPzD8aX4/+pRayqtNGZ/Os=;
 b=eqn5b6f+dTwYD6thPH/VQl1rWIA2XrNxJqLit/qsZEge5ExVByXqI7Q9clKH1Sv4Z4GbRqzIb9B0fJ/3n3v1OlE8KGxTljhEJjamqU1P21puO+MIXEY6/c2BBwUlk/6ScaXFk46zD66zgs6C91kRjc7wQ/le/KWQszIfFXvg8A26lEEgBFRAbpmpkIble8P1x0Cp7llpxUc0+/2dL8GK5t9YYTZWvChHYe0xgTVltyOJbIybxmxDEOyv2NLNtBw+3/J5IzJt5wZpciAHloXlnJqn6wrN41Z3aEjbq1mIQtIu+IONhvsJXcyt/dSf2xvrsU7mh0JnGn5+x2RXJKXgKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:28:22 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:22 +0000
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
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v11 05/12] cxl: Cache endpoint decoder settings during PCI enumeration
Date: Wed,  2 Sep 2026 07:27:57 +0000
Message-ID: <20260902072804.665639-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6e19b7-0a10-43eb-2d7a-08df08c3c46d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|921020|6133799003|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4+LC+4tH9HIB7Dn+5WNkfdjZPBWUyZZ9Y4/N3YqAtPK4H3G4SgDlWper83J7U7ZggXqToketsIHZi0PX8OSU6a6QXQRD4gegSa0sPYWxRhGY8PyYtzR54kwk/gLE6KCUfaM7RTS6xqTjns/lrJTtXRkEsPtomNBtS1BmwD+bcLYhrR8Dqa7VTVGAR5/NcDx2FOi4O/H6gzf0o2Ug7jpOHgXeR/U1Bbaic9IPR3iQE4LagrSHhNQ0p4m71mLzl03ZGZuLr4WgT90fiLXSfSAwBlh4wmEVgdSmMyqq/BvbttGbg+rJOiDWtBIY9gK7HNzU4ZdT0XgEzS8Hac1ov2nJ4Yn2G6VmxRGcjOA+EB04Vv6gU6YjxDqmTMl1465Hx5cdnxaymNsSQReBIV3K4eF9q2zR2MnurPln+zgmDCyypACNY9zQ1M8dMoF/vMR+hmcm1GlChfb9I/ezrT+i7MThEN30t1Em3ZVGyyq6s3NFgj0za5sto9gaTcWsZNW4mG/3MxLdk4sHrjWAG7JG66uBhhD1FZmp8MX9ptGVHnbuKQZGy3iMuIm55cL+glM6QWLpxXNSGf9qlivmKNtX4ulX1a/WTHkuChWRSItoj6FO7lFtQRCJwH3rUp/lzBpGAStwgKaISStQivhRCgpF293kbT8LbBkyDogzUHaLeJwJgH0negwuAmOQ2yjG8hIGJgsYjK/nuxD9cvmBoVeFq1AF3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(921020)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PnTQ6BCzFKjYyzsh/FYH9RG9Z8+PVeLOQMwShsZMBx0+cazSnSPtkDsvcoQU?=
 =?us-ascii?Q?Zl/77V9MZdf/pWY21htDtC3MaE8ksq4av/rVMKnVPFQTeyK4DI07nvzEy1yN?=
 =?us-ascii?Q?Y/5gJtTeMthltyaqIudZ3dssBJUCzfa3DFDIGmqro2gyr+XKIz1bfHDbwZsw?=
 =?us-ascii?Q?BRvCER+fTh5F8pCRZYnX/iwmkd1rVxAXFYdzA8/Ifd7bfqCGtYq65fjoV0O6?=
 =?us-ascii?Q?iDMYLFNsoh9xF3j/lPj8jFpGEfDoiHNsxYn32Zd1Sxb8U/QJTukRXgz/vmyy?=
 =?us-ascii?Q?BvgoF0z3EZu3pPEmOfbidiUi34oIL51oQx7b19LB+O/L9zj2OQnAJVP2+BzR?=
 =?us-ascii?Q?B2Rjr2OjYEVQLShx1KxC8AlUuL3I+MhCl+GnM4zGBOqS5MNtUywUd4TJfEhO?=
 =?us-ascii?Q?oHMONFauZIjWIYVdbWM4juoTYkTYCrs/VmG2/vXT5lI+Z1d8cJxzn6giycIh?=
 =?us-ascii?Q?B01qi5eHV51JjkJIRJVNpGfn/D7T+2N9VBOzUlU4QYBL/zaOoN4SIDYp/r0h?=
 =?us-ascii?Q?FsHxbFU8QaSa3BL2/ANLdTevS4OtAxw+myVp1lGZdUjAXQkOy5gTaSBrjSiS?=
 =?us-ascii?Q?8xMNjAcMe9F1ZjAMwqiZiLbOiSkaXaK/qcVTNdfWdQBgJm7js8iybHaYgMFt?=
 =?us-ascii?Q?6K9ZyNdk2lsbT1ZciNU+nah6EK4s/Dzm1WNxVnr36v+OPAVOsNkkHq6xCL1R?=
 =?us-ascii?Q?BeXu6nnyegwGDpaA+ke5RFBXcqk8oabK0WjnYwwjYsk3cLlH4nAtT9gO14x8?=
 =?us-ascii?Q?Cd2AyXKcauKNduApCF26HxzGxuR3NGQ2hL4+fNLwjUGD4wnuHZHtqkql08TQ?=
 =?us-ascii?Q?aqN7nSFN8RcyMHeDtRDd8J0CTS1MreNwjD/NbW090AlWpilv6LMP24x5i/NF?=
 =?us-ascii?Q?tctKCB2Qa5molAe5uwTrm6AOp4N37EOcDPamQlDi/npo9EJhoA1xKTiBrZat?=
 =?us-ascii?Q?33ltEV11Rpc73V7h2Ue79VOmNP4FShZY/lQgchUXDpxVGR3bVT1cBLPDHQwg?=
 =?us-ascii?Q?bngWaeiH5TAeiGb8j6GlSxvCFbQPSmPFa8kHhGLLGDisVOS0dLAxkxrP7m7I?=
 =?us-ascii?Q?efb6PwYL40TjvEyWYCWx3MKjqldzjSt60OT/aMfe3xY6JIZvNp893MFqb5VL?=
 =?us-ascii?Q?eRu5zlVPQPI8e4FK//xAmAVuAg9LUVTIEqYzpMYQ5CWDLnItgjHQbvuAztdW?=
 =?us-ascii?Q?MQKPBPYGlnEar49Ac+wH+Z6+5WCQbIerE1jRpVgwhK1kXme43oJrOm+R8rHx?=
 =?us-ascii?Q?v8xrXoyQxNa7p163QBBUVCaUDz3YnG08o3wiLmah8yYnA223BP+N5LmEXgvi?=
 =?us-ascii?Q?/CSyySsKhLa0krl/cSUj3ROrGHYCVQtAr60GlYcLmREL/qUGKXOWsOT+fZDw?=
 =?us-ascii?Q?YVZ2pOGjIQcaEfVRYZucEt4KJGfqG8Wk2c28mQvRqTTt7BLhr7XiEBXlnghs?=
 =?us-ascii?Q?Ads4AZQEtxR7ete8I6xrJWnrCQtF19hL7Rps8h2iYcs6+23ctRHeYOSk+4iX?=
 =?us-ascii?Q?gN28IY5BEJnMRsLiVE/iNdROH9Lo6AkKmIyAZln/54Q3v91mk/gvfgv8fIuP?=
 =?us-ascii?Q?fbNeMmyBDOraSlKYBMgP02AUFT2cOPKV+eLqK/YpRp4yZtysIl6i7MEYF3Ak?=
 =?us-ascii?Q?87KB/k2AdxIAvl+JlG45g1ZOr8XOnSBrezIjxD0oz/bTJ/A703hXamnvlVsI?=
 =?us-ascii?Q?JqdiRVbaLZJXzWyM7nIpPtnl8kSKdS+0udmPIx5R7YyVdwaYnUmQM6RG+5Mp?=
 =?us-ascii?Q?iurPzDHKog=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6e19b7-0a10-43eb-2d7a-08df08c3c46d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:21.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T07+1lTUhPi6JPu+YHkafXBEbHv9+AXMo6TbyHiRUQil+bRN5HrFvONxNp29Cm1FMGdzVNMEkvXR0lmTBMa9tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472

Populate pci_dev->hdm for CXL.mem functions from pci_bus_add_device(),
after final PCI fixups and state save but before driver binding. This
gives driver-free reset paths an early HDM snapshot while avoiding the
pre-resource-assignment window in PCI capability initialization.

Use the CXL Register Locator BAR Indicator to find the component register
BAR, reject unassigned, disabled, or zero memory BAR resources before
temporarily enabling Memory Space, and restore the original PCI_COMMAND
value before returning.

CXL core reuses and refreshes the same cache as decoders are committed or
reset, and retries cache setup during CXL HDM enumeration if the PCI
bus-add attempt did not publish a cache. Move the register helpers into
the built-in CONFIG_CXL_RESET set so the early cache path is available
without cxl_core, and keep the cxl-test mock core from building a
duplicate regs.o.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/Makefile   |   3 +-
 drivers/cxl/core/core.h     |   1 +
 drivers/cxl/core/hdm.c      |  28 ++-
 drivers/cxl/core/pci.c      |   7 +-
 drivers/cxl/core/regs.c     |   4 +
 drivers/cxl/core/resource.c | 340 ++++++++++++++++++++++++++++++++++++
 drivers/pci/bus.c           |   2 +
 drivers/pci/probe.c         |   2 +
 include/cxl/cxl.h           |  26 +++
 tools/testing/cxl/Kbuild    |   1 -
 10 files changed, 406 insertions(+), 8 deletions(-)

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
index 0927036aed27..6efabf293516 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -88,14 +88,17 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 }
 
 static bool __cxl_pci_hdm_decoder_count_match(struct pci_dev *pdev,
-					      int decoder_count)
+					      int decoder_count,
+					      bool *present)
 {
 	struct cxl_hdm_info *info;
 	bool match = true;
 
+	*present = false;
 	down_read(&cxl_rwsem.dpa);
 	info = pdev->hdm;
 	if (info) {
+		*present = true;
 		if (info->decoder_count != decoder_count) {
 			pci_warn(pdev,
 				 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
@@ -112,11 +115,21 @@ static bool cxl_pci_hdm_decoder_count_match(struct cxl_hdm *cxlhdm)
 {
 	struct pci_dev *pdev __free(pci_dev_put) =
 		cxl_port_get_uport_pci_dev(cxlhdm->port);
+	bool present;
 
 	if (!pdev)
 		return true;
 
-	return __cxl_pci_hdm_decoder_count_match(pdev, cxlhdm->decoder_count);
+	if (!__cxl_pci_hdm_decoder_count_match(pdev, cxlhdm->decoder_count,
+					       &present))
+		return false;
+	if (present)
+		return true;
+
+	pci_cxl_hdm_init(pdev);
+
+	return __cxl_pci_hdm_decoder_count_match(pdev, cxlhdm->decoder_count,
+						 &present);
 }
 
 static void cxl_hdm_save_decoder_info(struct cxl_hdm *cxlhdm,
@@ -126,10 +139,17 @@ static void cxl_hdm_save_decoder_info(struct cxl_hdm *cxlhdm,
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
@@ -139,6 +159,10 @@ static void cxl_hdm_save_decoder_info(struct cxl_hdm *cxlhdm,
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
index 9d807c1a002c..4b365c80e3d2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -274,9 +274,10 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
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
index e6aa55079c76..a43a29e08650 100644
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
@@ -156,3 +164,335 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
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
+void pci_cxl_hdm_release(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info;
+
+	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
+		info = pdev->hdm;
+		pdev->hdm = NULL;
+	}
+
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
+	void __iomem __free(cxl_hdm_iounmap) *hdm =
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
+	struct cxl_hdm_info *info;
+	int rc;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		if (pdev->hdm)
+			return 0;
+	}
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
+	info = kzalloc_obj(*info, GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	rc = cxl_pci_hdm_read_info(pdev, &map, info);
+	if (rc)
+		goto out_free_info;
+
+	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
+		if (!pdev->hdm) {
+			pdev->hdm = info;
+			info = NULL;
+		} else {
+			cxl_pci_hdm_info_free(info);
+		}
+	}
+
+	return 0;
+
+out_free_info:
+	cxl_pci_hdm_info_free(info);
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
+EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_init, "cxl_core");
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
index ed5237df510f..3638b8983c4b 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,7 @@ enum cxl_devtype {
 };
 
 struct cxl_region;
+struct pci_dev;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -135,16 +136,41 @@ struct cxl_regs {
 
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
+ * @decoder_state: cached raw per-decoder register state
  * @settings: cached per-decoder programming state
  */
 struct cxl_hdm_info {
 	int decoder_count;
+	int hdm_bar;
+	resource_size_t hdm_offset;
+	resource_size_t hdm_size;
+	u32 global_ctrl;
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

