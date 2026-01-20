Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA32323EA99;
	Tue, 20 Jan 2026 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948016; cv=fail; b=mQfMMTt7ggv46Rz/pKlIjDPhsh/9I43b8IDj2MinjyHt/bhRWl7lkJeIWs+Rlj5v9O1NQcc9HDbw2hR3OBLU/zJdFv2yxrC5zuLjacAxHKQQpuMo3bCb5ViJYWenNOJRFzQ+yeWT99LlOLUixzq9u2SL+TssoFOuiGuH9LA1qOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948016; c=relaxed/simple;
	bh=WZIEzYdIe4qmX0HtCGEv1XUJ7MTdN7UWcmt/B5heCEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+aTkPfs1xtWfDUhK7Z/lmmYlHPHtK8Rkqow1W9Opr2X3ioQeRPM7s63wIjQ0+/e3zSu1BoJBfpbGDujqTvmPGc4Jd6+xeFQaHrSUzKALhnS3UeT7cTs1wKoUFIVTcoozqyDSYHJ1XGb+LVhseMP2E2btqV2TGy4e7vxTvRF+vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ETmfqJCg; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ETmfqJCg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCHBqf42dbXibxRYdKrR2bLwFvl0R74ySAoEFqY7QUeN2PUznSpQPc4hbSwh2WfnuFm2F3DklSxMhP2e9AjzN+OTtXVPPhG7tCB9rrh6S/afafo264Rqzxz1MH2IGHI/GLs2D+nj8V0KGTJD2veJfJJctmdX4UXyMeftg6eXyjjD00DfFZNDPXn3dMmVyeie8Ip2WQKdf4YrTUjYHVneKFh44QZ929lWqmxRhwBkah7FCeTiOt+bBQBifAxenHwsf1b59t9TcDFHaDJN6HsoskN+XIVaVcs81MHUaDnqydI1+pXg4NXCEKd7rN2s2qc8Igc40V4t/QxzOafeT8or6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vj1SZKIfZZE7eaUL5grHSWSw6GyHMO0QCJUr9P7nMc=;
 b=AytzQ2w7f6xbsbAKQpnd8M3W8XMthTq8TnSQyxs8y79itcUGpl1s7toOM14aKcAjQWXipUhLoszHwCPC9/amdXqDR2gfp1s+Oh1YlIYvK6ZV3I9QRYM93LPOqMCJhkmyRI6bCKz4jwxAJkjDrLY8Bbhe6MkcDoKUf/dJQAxIx5TGbK9R3mew8zlgWKfFuhpI1d+SLazvgMPGV5fCWMtdHVopVOJldchBOafKBldleDahSOlY7SZKwGy26al+oRQvlKniBiJlWWNvh7fWzCBA1uTxRBv2MQli6sHDyFD2n0B+3Mxp8cZ7sfFVldq/49R4Of4elwsFKPlDg77s8LBKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vj1SZKIfZZE7eaUL5grHSWSw6GyHMO0QCJUr9P7nMc=;
 b=ETmfqJCgngnPESJ9E+O2XMzH6NigJWiKWeeogGXHVoUg2k/11lDKWXDmMIGia6iZdG4GnnaaGiCNp14riWUswpkgBC0tdjSDFCe1dx9eYTjH0HILkaWgNpRzET5YeJfYb60D7thdHNtHhB+E7TqPqjzG6DPS+vXkOse8YE0L8ooN9ChpfuelH+0ODmxfU2Y1h3Pb/BMWdHakzThfcyq/edXLgqollvOkx/Uuz9pyUNvn12w+qSFWWKkC/iQ0n+GpH430htQm2Urv/k8O0D4Wy/ZX136eQej6rwOIxqzTbzlZpl5ljmmt7aBLh0xPEOkv66hbbvKdI7aJdppLPOClBw==
Received: from SA0PR11CA0073.namprd11.prod.outlook.com (2603:10b6:806:d2::18)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 22:26:42 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::3) by SA0PR11CA0073.outlook.office365.com
 (2603:10b6:806:d2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 22:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 22:26:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:20 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:19 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 20 Jan 2026 14:26:18 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v4 01/10] cxl: move DVSEC defines to cxl pci header
Date: Tue, 20 Jan 2026 22:26:01 +0000
Message-ID: <20260120222610.2227109-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120222610.2227109-1-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f372c8-6dbe-489f-12ab-08de5872fc4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hC3gyLKvoudtGwDFNrtQU0nRKDduTGo9iTWGKOZkw9ciCqHt5728hB5ydYrN?=
 =?us-ascii?Q?7ind6HR0v2egKm1sHizVamI2EV5UMC5V2MTniYebXsPmBDw+C1pX/IqxF252?=
 =?us-ascii?Q?jPBxYtGa78l5+gXKSCs5jziByjN2Vmu9tI3NHps+8EiM5Z7u0xikB0Fdz3oo?=
 =?us-ascii?Q?bXT/YrShEzT5GzI7myhe05LEHpLT+IVI81aNLt+SkZMzmbSCg60om0xuwqox?=
 =?us-ascii?Q?BHkukcPzOrObHDT78KhgUu/01aAdbL5gHqM0zQ6GsCVtsZPUf+MuDCfIkfxs?=
 =?us-ascii?Q?bqd2MnHM5qsmYuKy8XBM1nvJ4udax8F1RZkn0IwLqOY/wplP595p9zK9SamC?=
 =?us-ascii?Q?GZlW3sDHRCiMk1EaS5C9si3YUeWQtRoxpPO3x0j7l1sT4OkjXFyYb7syxy1i?=
 =?us-ascii?Q?/JF5u9v3l4hokREZqHbEc90PJ6RU474lq4rQetr4vPwlyswvjLoelbrhyeHN?=
 =?us-ascii?Q?wDyUEUd1x1RI46TKgDhPl4Zf8Z6GWBDntk3CCMxYQNn+/23hfHfn8ozcacNz?=
 =?us-ascii?Q?QoQsRi9IsI+ITG7BedRHk/uz5QRLCkkNVeACc6yqn9XREp1EpQ1kPyhHjc04?=
 =?us-ascii?Q?IvKV4AfsTFqW0hU3Grq+nfrEQUqueVYN1vuPm7n1TGdxCXZnuHeqrlNWo1l0?=
 =?us-ascii?Q?f5h1JMF8tCTTUxq4nedeXz67CnBrnwFnPXy3zdaaITcp9RJmZenIF26Ymgwo?=
 =?us-ascii?Q?r2Wf4L+NZsaIUa+3YBJsOyrmJy6KzF8DRCC6NibdqeqBNsz4/awHLOR6cobc?=
 =?us-ascii?Q?DBMcO/6OvZgUz2uLsQCaXRUxtBCzYC//im/EymTg14DalvK+ADWYQD4ZIHTT?=
 =?us-ascii?Q?8sgbMjhkLZrysk/EdINHlH09a1W1z6cHL8zH7No/XtiXgQKCuUt6yClp2rDA?=
 =?us-ascii?Q?zcuzughKtAQgfZKzUaKeUSqj2m0z0qruVS45jLdpxePbrtU1H7lR2jBysC+9?=
 =?us-ascii?Q?BDtueeZrrEK0C0kklIsDjeP6sjXTPBGkyTb5x/x2nkZES9xSP87A9FH1SkY4?=
 =?us-ascii?Q?AQE0n0jNzbic7WuOnwaWtYrL1gDWG2BOGxBCj6y+XaolHvV6jgQhIums64j/?=
 =?us-ascii?Q?gusKdWmNGEggg+XXEe7r99VXYoCrFBXU0BqYg2Y1JAwcgb68N66/cACzFDk6?=
 =?us-ascii?Q?HNXxEYUekl+2JWU7KDB1VTGgwojcGl1aorPDL6+9nVoHHZUiGa4j0vmlV0m6?=
 =?us-ascii?Q?nGasm7CmQibv53j73+XuidFOab4DTpCpvpfxmn6tNIXfXJVslYL+Ay6nRRCF?=
 =?us-ascii?Q?ufCnbxZyANwcV4dtkB0MorqNZw8lgM2Zn3d8RG0FlqeGyiGglwwTRRcBpDXT?=
 =?us-ascii?Q?RdfooiU7ez72CaS/GcdgNEL9rSDrO9NR4jh0WH2o6v+hf20eaZEttO8cbTOr?=
 =?us-ascii?Q?KwGVeqYIw2aTc+IMhyuiQOjm301SmLk907w4RuiAPmuTGyozE+A1WvMNKnR/?=
 =?us-ascii?Q?Pt85G9Lact2EW5PoHJVSI+qS4l/E63YliE0HAvhIUmlqUU8BecsmvC+w6Lf/?=
 =?us-ascii?Q?VW6fJYX4wtnyGI2sVGvBy40Pc1WwqWnyVTopOcgOLgF/ksnpleSwyRcYWtfL?=
 =?us-ascii?Q?+SpiMeMrwpK9/dg/ByewSoPu8lQv5r0/pdalDGmF9B265MaFP32zqK3Cohb4?=
 =?us-ascii?Q?lUBdVlbc+/yE/xcRdHh5xNl96gZoWPolWBSRPxzHyrvxEPaApcZJreOJriUC?=
 =?us-ascii?Q?n6TY5CF+JxqOyy6SwnwD+aNtS0g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:26:41.4173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f372c8-6dbe-489f-12ab-08de5872fc4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208

From: Srirangan Madhavan <smadhavan@nvidia.com>

CXL DVSEC definitions are shared across PCI core and CXL drivers, so
move the register macros into the common CXL PCI header. This keeps
the DVSEC surface in one place and avoids duplication as the reset and
config helpers build on these offsets and bitfields.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/pci.c  |  1 +
 drivers/cxl/core/regs.c |  1 +
 drivers/cxl/cxlpci.h    | 53 -----------------------------------
 drivers/cxl/pci.c       |  1 +
 include/cxl/pci.h       | 62 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 53 deletions(-)
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b023a0178a4..968babcc09a2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <cxl/pci.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 5ca7b0eed568..ecdb22ae6952 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <pmu.h>
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 1d526bea8431..cdb7cf3dbcb4 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -7,59 +7,6 @@

 #define CXL_MEMORY_PROGIF	0x10

-/*
- * See section 8.1 Configuration Space Registers in the CXL 2.0
- * Specification. Names are taken straight from the specification with "CXL" and
- * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
- */
-#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
-
-/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
-#define CXL_DVSEC_PCIE_DEVICE					0
-#define   CXL_DVSEC_CAP_OFFSET		0xA
-#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
-#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
-#define   CXL_DVSEC_CTRL_OFFSET		0xC
-#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
-#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
-#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
-#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
-#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
-#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
-#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
-
-#define CXL_DVSEC_RANGE_MAX		2
-
-/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
-#define CXL_DVSEC_FUNCTION_MAP					2
-
-/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
-#define CXL_DVSEC_PORT_EXTENSIONS				3
-
-/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
-#define CXL_DVSEC_PORT_GPF					4
-#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
-#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
-#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
-#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
-#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
-#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
-
-/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
-#define CXL_DVSEC_DEVICE_GPF					5
-
-/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
-#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
-
-/* CXL 2.0 8.1.9: Register Locator DVSEC */
-#define CXL_DVSEC_REG_LOCATOR					8
-#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
-#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
-#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
-#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
-
 /*
  * NOTE: Currently all the functions which are enabled for CXL require their
  * vectors to be in the first 16.  Use this as the default max.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3b2293dffb3f..55c767df4543 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -12,6 +12,7 @@
 #include <linux/aer.h>
 #include <linux/io.h>
 #include <cxl/mailbox.h>
+#include <cxl/pci.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
new file mode 100644
index 000000000000..728ba0cdd289
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+#ifndef __CXL_ACCEL_PCI_H
+#define __CXL_ACCEL_PCI_H
+
+/*
+ * See section 8.1 Configuration Space Registers in the CXL 2.0
+ * Specification. Names are taken straight from the specification with "CXL" and
+ * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
+ */
+#define PCI_DVSEC_HEADER1_LENGTH_MASK  GENMASK(31, 20)
+
+/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
+#define CXL_DVSEC_PCIE_DEVICE					0
+#define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
+#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
+#define   CXL_DVSEC_CTRL_OFFSET		0xC
+#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
+#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
+#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
+#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
+#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
+#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
+#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
+#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
+
+#define CXL_DVSEC_RANGE_MAX		2
+
+/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
+#define CXL_DVSEC_FUNCTION_MAP					2
+
+/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
+#define CXL_DVSEC_PORT_EXTENSIONS				3
+#define   CXL_DVSEC_PORT_CTL		0xC
+#define     CXL_DVSEC_UNMASK_SBR		BIT(0)
+
+/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
+#define CXL_DVSEC_PORT_GPF					4
+#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
+#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
+#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
+#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
+#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
+#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
+
+/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
+#define CXL_DVSEC_DEVICE_GPF					5
+
+/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
+#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
+
+/* CXL 2.0 8.1.9: Register Locator DVSEC */
+#define CXL_DVSEC_REG_LOCATOR					8
+#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
+#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
+#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
+#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
+
+#endif
--
2.34.1

