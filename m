Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC73E2ADD;
	Wed,  2 Sep 2026 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334116; cv=fail; b=F3TZWsEL+v7IqcpqJW1sRzWLKI+t/fO/QwqiYLvCn/e39ju1idJBRkb8/Tqs782CKlINFy/dfjIFnCzN46MdBhQjoPVNjTKM0Prq/qn201t3hCqHqUpa28xCb55uyGZtAb0/NnwXrccKayYMTZ6M8gntTTyIJBmh302ZPGzrX5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334116; c=relaxed/simple;
	bh=kR3MIej0FNAJbWuPBF/8dbhCBn2tbRBmmdgRj8Dzesk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pq+I2nSLxhzHyZBVAZXqYbj2eBRjHLKg5fQQ5uG9AEwDK1dQJAoXYydjB10PH/9jCnZTyhWCcyYU4ndxIbRYS+BUD5Giu2IanpOS96XA3tBhkFnaW25zDrQ8LluTtgI0UiNqC/sLuz4Y+6vTkSbYssQROG9zsYov6iy7icm3k+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oM+VycSE; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oM+VycSE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goYpJwyr1Mn4jHNMnB5ILnEkQtTrx0oqVb+GplaWslbbhRe1FV4LHXdLzIKT+xzMl7u+QTW0SEH3uS2cX1ia6FDWe2ymRgZdYJLONRQt6umZHpEJezm74QzcXd3EVjwn0SZ0Uiu4Rl0f5VkrScqV2CMB+vxaWKz8UIxp1TjQXIsK254vj7nqiwWumWtn8Org2UMkN0Xlc24x3pXLYyMG2mIcRtUsk9tHdUZ8zFl2kUvt87V69E1hiaEk1hroHA0KeSCc6PtqNuaIAmdwnWQH30c+BfIvLvFWJa0ro/eBzfwt9eTssjzqnD1rXXkRx1SWUz5jm9p6TMyKuTVJeo4Ukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSN+YjZPXnmsSYvlsW17etPcMAY9QNyshvgpwtBbht0=;
 b=T2dsAnE5qySV0yvo1ghK0AvBbReEEeVkeBbbyBcps28TjlWAfWQeI0GUKhLmAD3U72+wX0UoEvok/xg0PfgjjdyvUhwj5f6ZlZ23AV/rzPWBNyNcVpmsTqS/zlwlwrpbAAG5wzoZv5lRNuDC8XH4s0uozQN5e4iBpJexvo5HkWD4k/FO6bnjxrLD+5VATVTyCVW62yIikSBNUblzpbRtApXajl8R2319KplJFEE1QPhiWwQWKSs6r6C5NhNx6uGPIh8MWTL9Ll9gTv3O6aI18JRO6N3P0uFoJgWu0Id4kl2x39TP3PLur6sB9AuPYIQvjIpUyUP28qP0vTkirLQcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSN+YjZPXnmsSYvlsW17etPcMAY9QNyshvgpwtBbht0=;
 b=oM+VycSEMRqP3RUGxlVjtsXSFo6FSOKnb+vEjyrWn175IxH29K3CCdxUAWvR+88Wszr4T0XBA3LbB3v6my4J7SHk5to4C9fLL3tZ4HWaa6LRbaD3J++jpUF69eC5WwOX5nJdNND8PdNHXYSiS3p/bL5qe4yC5CEy6nAyKNZhcedYnp4EpK49NNxFV+zyzsCvjdbvJK5fYByukXcgxA76CEjoHmsfOX+nzmxaCJ2PDBRv45OeC/xWwXKJnBFfllStR1KUwCX0a+mjIAELh9zoj176Ub0cucN5pvxu5ANe3TX6z3+KGzEszViOSZWvoCS9bUH9YMrkyDKjugPgsc/YtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:28:24 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:24 +0000
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
Subject: [PATCH v11 06/12] cxl: Add CXL Device Reset helper
Date: Wed,  2 Sep 2026 07:27:58 +0000
Message-ID: <20260902072804.665639-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:303:b6::15) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: c48bca8f-5771-40fe-62c6-08df08c3c611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|921020|6133799003|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eyNhkzBW1JB+dXa4CnPjHftkFm/TNouXJy4c2qa7cYQNlB/scselhLZl0fu20q+xqfM0hgDXruxRFnOUMOuF0EWdVMYATtGRoWSe0oqrIHNm9vL5Lxx6xwkrdnX1RfAQG5y22bkZdc93VXPwC3TtBaGxa2OPCwK58tm+4GtPcsIIOgLkR8lV4pBbvk+ViiU8q9UWcEfbjOqTkJI8x3hbqXvST9AlBIqDszWk0hoIrGaIy4vJeQ/d+i9xenQJgqpxgiEvorCiBdSiggmVXZq1lU7phOrBcP0lZJGjXkodAVkQRQ44XEg+5PibBbaFhXEvdLizCVINqTAhqYF8arivMSpA8rePWFfetFs5p0fI6Qh8pFOV55/ASYG+OioroCmB+2fYw9qIdqApvYTFEoNkQ0IgZT8PpAkClHlKjJbaIajWGYlewxxehjBO41gwz7uP68SY7BVRBWoltCkRte3mn4OqfupXPqQIjyg3oeNqnNz4Koub69lHmY1HOyh+Gcbv0C2Ps65H9a1kA91d3Ps/XZ9dop3/g2f05ASyVMxHIXxu3foaIKI4KWAPz0A1pWvAUVelCGV3At2WgX/GBCLTxbf8cQ8QiAFz0i6ADr44XQ3EYD1unmMhAiI2PU+9GgCw6kgpx9FlVSQazKmbmpfvWRzt7FXEFXxFEwnn7y3jDwEjojBI04OL4zTzm2iK9c/UeRwFcGTYUG09Uy4iQJwQcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(921020)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aHF3V1+vfzJs1tMWljCyWWahUoRDDnOdOIlGVb36xK83IlUsIp2SsIksk6yV?=
 =?us-ascii?Q?FB1dfkck9/dfKIDJi/NhYzLmvMpJZBpGojdgDVMwUbCiZMhT5Z5I8hgkyR0f?=
 =?us-ascii?Q?34MTbnREXbddxvmPKi0iftIgbXGbAkEFTaUcZ2koXl5/2rs+ce3ao3GW1ZH+?=
 =?us-ascii?Q?TYx1pXH2jiDIrYMRacOejG1SSSTaNEtI0ae7GLlRN4i4Whe8FYVUiBGOxJwz?=
 =?us-ascii?Q?f5jMev+oqt7aAwmbpY2wTF8b6lYlRh9LZgYMZZtZRbORvOHpvjg4m6VflSA3?=
 =?us-ascii?Q?827fmFtH+s+0GMlrPM2uHDIApBBLAO7bfqpOn6g6bKPM8NyDe38Zv8gLXyMk?=
 =?us-ascii?Q?mfu8ZGBJSFBJzqhe6I9tTXMkX7tbBrveI68V7QUScHjMZp9opedHvhTKfKDs?=
 =?us-ascii?Q?bS7FGxKJUNSSBPiV6EVFQvO+dpSPUzGWbAUaI/1rQ77XCNCL8sIS5XW8ko7w?=
 =?us-ascii?Q?o6Xcq5XpoybRFL3NS2ZNmmKOU0eLAnIOo6vPC0lmndrBwDtJoAkOYE4dn8ey?=
 =?us-ascii?Q?DaSjqykHj99d01uLjybia9JHfTItXwGByIBFMb6pPhQB2q832CP4LZigKrYn?=
 =?us-ascii?Q?lOA9/rssV9mEWxoH4QGQbgbtZZ4zw6Pv4ll0shxrrN65mJ1nv0TiQlL0+3d5?=
 =?us-ascii?Q?H8NcskKDyKdbp5L7Q0kTxl7Kf5XBTHsopU/BYVeVwzQZuIaqa6rnyoFzIDoe?=
 =?us-ascii?Q?n0uIq8zXqhyKRTN0q0IMBG10AFtE7q5IOEhyEJ6V1cNOCklnuiwrGuiSk4/a?=
 =?us-ascii?Q?Ch6MFPbaWM1azvDmALXrzTTVSII421k8yNh+TJ6A+J7Ri6RMVkhHk7pTJqGB?=
 =?us-ascii?Q?cDbg5GZgowk04f6TVyAXUG99xDM0Rn42GKkhoUjavF4zha4BLyQ+lJrKnYpG?=
 =?us-ascii?Q?I/B4liiB0RebCy/N2EQfvmiElBO/d7V1qk4Idcnz3EBylKLkIO/8FqOeQZye?=
 =?us-ascii?Q?3my9yrleOK5Sy8z/2G8PsuNinFmR/DmDjH1kF98JM5Q0HImHrfBGxnIxItAj?=
 =?us-ascii?Q?tNybk2KheV3Cw+5341pT95T5UyuKIzuujA/+8lVoR7/d0ByNJ31IYKwAaSLu?=
 =?us-ascii?Q?vlAeWDc46vWKkGHiMyLW2NTLBDCS7askl+9EAPFzGFYXwiGG9F7e4oEzO8Pl?=
 =?us-ascii?Q?kU7zr/ukJMOsktx5mu3Eevzy/B0e1b79tMXvKXsKfqtTtlqfgh8A1sO9dXT/?=
 =?us-ascii?Q?qV7lKeSXduQWHZIvb6dlaGZalhS/ZBbTlZ08jJO46tYQ0BUx8G3HeWxJ6iAC?=
 =?us-ascii?Q?E0Z+5kShY97bttVbaDsdpB9keKC4wxcBWKlEtLZ/vKWLiKmcMOQscKYNaEcZ?=
 =?us-ascii?Q?1ioFUxvyBY8eGbTHV9GVk4UmzMJ1xwAlfGdLNsv90QcsbavGLkCsOy26yH5U?=
 =?us-ascii?Q?z5UF7Cpwc9rHbv1cj6WbQjqyHoLyareQRIsfhXCZ6QsMYoMqKwd110vwBoMB?=
 =?us-ascii?Q?QaRqh9TrMvna2yCpqQO80pRJ506pdt/gukY+0NyUcilHzfuM/y8nTmrJkvIS?=
 =?us-ascii?Q?iXFG6qzIYnbb3SaFFAfVeFCu/WqUmwudp7mHp7Xcdr2lLEK6nnuS7ldX7J9Q?=
 =?us-ascii?Q?ZcNHmn96pi7uVGT1icf7YcUKe61cnCGOdGEZDX18d32xSQeet2HKLx5CyAb7?=
 =?us-ascii?Q?C8ZLYqUHAq756FuHkyicEznzfZG2OoGzqz0C7ThO2ZiXTDxHZ4Dw84ORSDV9?=
 =?us-ascii?Q?//5pGdq9XYJZq7danU86kQKMC1dgDIeno3yCQ5NiWNkbOxf/DzcDPhttKI34?=
 =?us-ascii?Q?Bh7rvYRgAg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48bca8f-5771-40fe-62c6-08df08c3c611
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:24.6104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGFH7pk7hfVne9RvOa+U9lZh7xw5AcPSvAXUkrwxpFBXtD1JbiCwpDxoI8FMahUd3XIMu+nG0ckRg/X4DVv2ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472

Add an internal CXL Device Reset helper for Type 2 functions that advertise
CXL Reset in the CXL Device DVSEC. The helper disables CXL.cache, performs
cache writeback when supported, initiates reset with Memory Clear disabled,
waits for completion, and re-enables CXL.cache on exit.

Leave the helper unregistered until range validation and reset-scope
validation are in place.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c   | 247 ++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h             |   7 +
 include/uapi/linux/pci_regs.h |  14 ++
 3 files changed, 268 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index a43a29e08650..439071a5c34d 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -8,6 +8,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/iommu.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -496,3 +498,248 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
 		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
 }
 EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_init, "cxl_core");
+
+/*
+ * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
+ * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
+ * initiating CXL Reset, then limits software to CXL Status2 access until
+ * reset completion, timeout, or error.
+ */
+#define CXL_RESET_RRS_WAIT_MS 100
+#define CXL_RESET_STATUS_POLL_MS 20
+static const u32 cxl_reset_timeout_ms[] = {
+	10, 100, 1000, 10000, 100000,
+};
+
+#define CXL_CACHE_WBI_TIMEOUT_US 100000
+#define CXL_CACHE_WBI_POLL_US 100
+
+static int cxl_reset_get_dvsec(struct pci_dev *pdev, u16 *cap_out)
+{
+	int dvsec, rc;
+	u16 cap, ctrl;
+
+	dvsec = cxl_pci_get_device_dvsec_cap(pdev, 0, &cap);
+	if (dvsec < 0)
+		return dvsec;
+
+	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
+		return -ENOTTY;
+
+	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
+	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
+		return -ENOTTY;
+
+	*cap_out = cap;
+	return dvsec;
+}
+
+#define CXL_RESET_CTRL2_CMD_MASK \
+	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
+
+static int cxl_reset_read_ctrl2(struct pci_dev *pdev, int dvsec, u16 *ctrl2)
+{
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	*ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
+	return 0;
+}
+
+static int cxl_reset_write_ctrl2(struct pci_dev *pdev, int dvsec, u16 ctrl2)
+{
+	int rc;
+
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
+static int cxl_reset_modify_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
+				  u16 clear)
+{
+	u16 ctrl2;
+	int rc;
+
+	rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
+	if (rc)
+		return rc;
+
+	ctrl2 &= ~clear;
+	ctrl2 |= set;
+	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
+}
+
+static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
+{
+	return cxl_reset_modify_ctrl2(pdev, dvsec, 0,
+				      PCI_DVSEC_CXL_DISABLE_CACHING);
+}
+
+static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
+{
+	return cxl_reset_modify_ctrl2(pdev, dvsec,
+				      PCI_DVSEC_CXL_INIT_CXL_RST,
+				      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
+}
+
+static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
+{
+	unsigned long deadline;
+	u16 status2;
+	int rc;
+
+	rc = cxl_reset_modify_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
+	if (rc)
+		return rc;
+
+	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
+	do {
+		usleep_range(CXL_CACHE_WBI_POLL_US, CXL_CACHE_WBI_POLL_US + 1);
+
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		if (status2 != U16_MAX && (status2 & PCI_DVSEC_CXL_CACHE_INV))
+			return 0;
+	} while (time_before(jiffies, deadline));
+
+	return -ETIMEDOUT;
+}
+
+static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc, rc2;
+
+	rc = cxl_reset_modify_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
+	if (rc)
+		return rc;
+
+	if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
+		return 0;
+
+	rc = cxl_reset_wait_cache_wbi(pdev, dvsec);
+	if (!rc)
+		return 0;
+
+	/*
+	 * Restore the default CXL.cache policy after error paths that
+	 * successfully set DISABLE_CACHING before reset completion.
+	 */
+	rc2 = cxl_reset_enable_cache(pdev, dvsec);
+	if (rc2)
+		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
+
+	return rc;
+}
+
+static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	unsigned long deadline;
+	u32 timeout_ms;
+	u16 status2;
+	bool final = false;
+	int idx, rc;
+
+	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
+	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
+		int last = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
+
+		pci_warn(pdev,
+			 "unknown CXL reset timeout encoding %d; using %u ms\n",
+			 idx, cxl_reset_timeout_ms[last]);
+		idx = last;
+	}
+
+	timeout_ms = max_t(u32, cxl_reset_timeout_ms[idx],
+			   CXL_RESET_RRS_WAIT_MS);
+	msleep(CXL_RESET_RRS_WAIT_MS);
+	deadline = jiffies + msecs_to_jiffies(timeout_ms -
+					      CXL_RESET_RRS_WAIT_MS);
+
+	do {
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (!rc && status2 != U16_MAX) {
+			if (status2 & PCI_DVSEC_CXL_RST_ERR)
+				return -EIO;
+
+			if (status2 & PCI_DVSEC_CXL_RST_DONE)
+				return 0;
+		}
+
+		if (time_after_eq(jiffies, deadline)) {
+			if (final)
+				return -ETIMEDOUT;
+			final = true;
+			continue;
+		}
+
+		msleep(CXL_RESET_STATUS_POLL_MS);
+	} while (true);
+}
+
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	bool target_prepared = false;
+	int rc, rc2;
+
+	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	if (rc)
+		return rc;
+
+	if (!pci_wait_for_pending_transaction(pdev))
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc)
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+	else
+		target_prepared = true;
+
+	if (!rc)
+		rc = cxl_reset_initiate(pdev, dvsec);
+	if (!rc)
+		rc = cxl_reset_wait_done(pdev, dvsec, cap);
+
+	rc2 = cxl_reset_enable_cache(pdev, dvsec);
+	if (rc2 && rc)
+		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
+	else if (rc2)
+		rc = rc2;
+
+	if (target_prepared)
+		pci_dev_reset_iommu_done(pdev);
+	return rc;
+}
+
+int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	int dvsec;
+	u16 cap;
+
+	dvsec = cxl_reset_get_dvsec(pdev, &cap);
+	if (dvsec < 0)
+		return dvsec;
+
+	if (probe)
+		return 0;
+
+	return cxl_reset_execute(pdev, dvsec, cap);
+}
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 3638b8983c4b..d07afb789d63 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -9,6 +9,7 @@
 #include <linux/node.h>
 #include <linux/ioport.h>
 #include <linux/range.h>
+#include <linux/errno.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -161,6 +162,7 @@ struct cxl_hdm_info {
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_init(struct pci_dev *pdev);
 void pci_cxl_hdm_release(struct pci_dev *pdev);
+int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
 {
@@ -169,6 +171,11 @@ static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
 static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
 {
 }
+
+static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	return -ENOTTY;
+}
 #endif
 
 struct cxl_reg_map {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..4f5942ebd29b 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1352,8 +1352,22 @@
 #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
+#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
+#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_CTRL2				0x10
+#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
+#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
+#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
+#define  PCI_DVSEC_CXL_STATUS2				0x12
+#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
+#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
+#define   PCI_DVSEC_CXL_RST_ERR			_BITUL(2)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
-- 
2.43.0

