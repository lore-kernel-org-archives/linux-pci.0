Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29E331A63;
	Tue, 23 Jun 2026 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185118; cv=fail; b=ciluG3BPUKb3bL/d7+eLj27EG/ppyzlUJmPbTbmE+ow/8z//NKUHKio+xkX+5Isn54UdwEXyLmm9JBsFTzdAAgIaNxIjP7d31q84EfMZX7MeqOSCQbKGO9c7n6tFEh+MUcpLHHtWg2zwlD5O9h+fQKmdwQwdmorTDLQhuQYzW+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185118; c=relaxed/simple;
	bh=wmqPbInIvvpOqmLCYQHmcQPDe1qxXfd90ZDzGTJJvs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CVIo2A2n25mxTankPkXFvGlEd+dUB+BcEnlnO5X3xGRoNv6bF8qHimL9J315D/0bfuK2xsRfqrrTnJmK9KUYb0kF/7h6Ap2LEj+MjJ48BX9vCd5OYr7QKvwOQ4yQ/7tSst6yVMl3X0CzUFYq7v71MyvL9rPPsieebnK+ZCiNQFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=krSriDJm; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="krSriDJm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vw14Ndn+bFHUeKOFPcSVfq1SRFDaJD/Pjj36EfXN9lgylo4eIMZaSbjyvuz7DQmG7HlJXBY+C/Ma/1R0UcRJlHYBvbpSfGViro3Mnpb9y/QQmGd3xZF7CbkumMGHtrhTU9vK9Nl1v/SJ6GZ89vnJgF+uHvvgZjRJTlWzLuIL7A7FsouDh9FJt3DGz8hUtVzfVFBMvgwFFVV65eeCNyQm6JlZhFL0AkmXzRTlN9NyeadnpUpBAbxpEptwLOxPf+o5iWD/FXK3wOV05bGb0NwJobUOslhD0J9VQ0xGUVMaPoyNko8avdq62zO6XkYS6us/TWngcgzSJIyQ73KC7NUtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8BnPzMHllO2Tq9GMZhfMb6tRDcIaU7u493Vy4mqRT4=;
 b=xJpsDYTOV0i+WKfBbIzStC4VcTWY5NSKRi9NuRJC9jD3yZd2//LmRYmfNmbt6+Mp9k98S7F+oCxOdys452lhGuYKaBH981DAkf96BhnwTsR2Mo6tB04sZTTBjOHffEfJGU1vJwxI48NE70+tl1BOKKegMDqQQpnhlogccmWpBajCI284uQNTiN+YvQwRK+mGp3BXg0U81iOA9NIJt4IR43v04VBK2Om7/QzGSzu/4DAhGO9LXqw4b6tEvmaXUTevfV+9CBb6O+4SvsESJimdvepch3JoW+ZBX0J81SULjgVZF4m3vcXPMvNjrCdvP9Sg2/deHqqiaB8Sw43d/dQKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8BnPzMHllO2Tq9GMZhfMb6tRDcIaU7u493Vy4mqRT4=;
 b=krSriDJmX4t7i3BC4uw8XYtzErnnTsyg0OI4LHeVI7/nqbCoIH9MDJiwRlfBfYZmti+jCi0G8gfauz72ql9pOe679qd/JQ0t+n4ZjNdtnIGRXGA+fYQ/H/l3EjUQVLeSYcEUajNk42/kh6qG98zqm9tyv5dW1BDqF9POx+1hg+YKkCr6uh03/Zfy+14mvjCeAcH18PflPCLWyDcGd4pDc6TpxL7skSM2TXGMN1nia+j+4BVma6ygXpXAkjm+HQp1hBLftg4i3fHmGhfM69JH9L0aEV/vPqdo/r7oKeXYh+WxPAjekcm8Z0D8jXlRaNfD4v4GCJgoGh8393HZuVJGfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:25:09 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:25:09 +0000
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
Subject: [PATCH v7 05/11] cxl: Add CXL Device Reset helper
Date: Tue, 23 Jun 2026 03:24:47 +0000
Message-ID: <20260623032453.3404772-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623032453.3404772-1-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::8) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: df098ede-a6ad-453b-3689-08ded0d70732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|5023799004|921020;
X-Microsoft-Antispam-Message-Info:
	wyTjeWPCn+dG9B2xBrkUCsVSzU0KOlTm1lNYJS04DhRxacld76XzIBYLBvo9QfdKG22uPdjUWEJdXXubwDBTcr6M/naGBfV80eAuh3Dr/IPyj/dKDBB53ZxqUUH3TY8NjBGSKAoE4qFUXN1s3IG1HNf8TJt+mV9Gi8uwqkgDrbXIh+0bg46itDNyFEMd3rQ18xTObmZIZSpAF7AfqvkqxxngUTx1vsEW67Vred8x87igpyEQIcVL+WaqlWiaRqAK5BytUnyJT925fjCqGrLYnoElYmxSTSsmhXVIqB/aqKohk5pUDNStSyWr7hCU2efy6wcdMOjFhOxCAg/DT82M9A+P00ENm4DB+vhJg8FNTMPAi8Qbd3fTii7PzCHbMp3o7RpcxUA+m4wjH2xltP7paXag4I73inVQzr5KrF28b5hMiQpxi4FRma2F/P7/s9K0KPx53CSU0PAnnkVNRbVeTQ+tf+pYnI4mPbQE6H2K0IOEJ16ATLS8WfeJUBRIfm94N++j8ucYrulV4h6EirnRicjJTErepNDkC1Wc+X/3WwQ7vwS8NZK6VSzCeAG8YjRYNfX1NUUZDgITyh90Zf7qzgBKqiyrPIbMnmH/C5fFWdw6MVwNa45PgDR2s7/V5lYH8zhYxPWkUO5C8TFX/AoZM4wCWYlPvt6NTW4Bw8CBF24KlJ9/QM9/6CZkxwV5OWgXbTBkhj0jqyw0btiqIVEFIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(5023799004)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q5Cq2Ku3bcWieJtQmK2UCClDkDErBzvvqJWJvpkqVTabXpu6fzKPMwnuW58/?=
 =?us-ascii?Q?bYYtbSwCzDb7beCG+Nxl+XvtGqM3VsdkJNgC2NDnwaMzgCrUTCongIn8UiLq?=
 =?us-ascii?Q?sVqX4blvMpIa/jwW/lgEMs5vH51Xq6c0arPmPH+JFqUaRB0J4JyCUDQx093d?=
 =?us-ascii?Q?H8Cz5V6e01ppFA+Nrb2UEdCOx0qZQ1vKlOntfan65M5sit+jlC9rbXTL6LJm?=
 =?us-ascii?Q?hVAalmneY1D+dP5TLy6iTkmFeSMXO53gxJv8lJfHNaWagB6RtDCWPXxT+ZSY?=
 =?us-ascii?Q?PmjIufvCLOhxI/SBzg7P3BHTdNRPz/+zq+Ostp+LW6MuMQNIU7nj/+EUT43b?=
 =?us-ascii?Q?MH29M6jguOHQkbZLj5Vaz04XXf7op/dQL1sxyhVi1bLTLYM0qrkoV1gHFwXk?=
 =?us-ascii?Q?JGOqEFzUT390cQNWzHRyFY97hPI7nXbXFN92NKVAU0URbmbZeyT3BcIenTnq?=
 =?us-ascii?Q?o4J5Iq3rReJNu/rAnDBFtWzmTA+P+Mqq/LaVNlI3EaRPUhhl87jlOMERbkTD?=
 =?us-ascii?Q?wv27xKFeo2kZnX/9qLlpS00M31ScK9oG3IqWVt5r05ZH3shod5mFSdsuRalq?=
 =?us-ascii?Q?B1bWYB8KuRAU9PoRokaimyzqY2pAUNd7GVvfGRwbyDlSL/WIQys1tgyAk9mo?=
 =?us-ascii?Q?HfMRGjstCQ7fiFgaTPeiOl+3ww0i2N4JiE56fCkirvR5EsyN/NyLhNUzqGmI?=
 =?us-ascii?Q?lXPj1hkqZVOzD4MaPJmAhilDu+zAxePNdiTnkmc4JH6Wf99/QbHQjdcNV5FL?=
 =?us-ascii?Q?EEUb6QtIKAg12jjwofXKuMLxDOWtf64KaAJew4d9HjBJaDP3KMs8rKXfqSqg?=
 =?us-ascii?Q?Z24UPOXCF8/+RQl3dTe3NwKfH3kqz5SsMxAnB5osK5yBVVIRBHue2R2QJFQM?=
 =?us-ascii?Q?+xM7U8i1bIm+Xx/9EeJD/XCxU+txCOX6pO3gK8CQCVaNeA+cOYxDo9NvmeH+?=
 =?us-ascii?Q?0VYGGGtGR3DcEyNIYerNcJ89tjT3xLz4g0f2MGmIH46R+f/iNVfoeQhxTcNf?=
 =?us-ascii?Q?fcHg9nv9Vm951bAOjbNgkDaOhG5natw9YsOyDc8NTJY9p/TNW3mzCIzh5TCT?=
 =?us-ascii?Q?7uGxH5O/cgL0dJh5LzjyoYOsStKQvlcQpSyZINV9hvVasFyj86zRWLNzyP+N?=
 =?us-ascii?Q?Q8TaGUXX8peAUDunDcqc9if5dawIYJOYdpdNUFsPFaJYiL79c3DFNKMVa7Sx?=
 =?us-ascii?Q?TpSXNeLHNzWBOg27biZl0kbXC1AOwdQ53Ikbd5zKd7NxqWIshuNKUpBOrpfq?=
 =?us-ascii?Q?YA84m1NyxIxIkEdSymfj4wUypvEBLWoJDw6V9e2EVU7xiWkkrluOb7qVCpS3?=
 =?us-ascii?Q?uLSjmwfkkhrKU8uySgQp7NTg3aikNdbbdxKt3jKctdLKcbiCJWpkVYOPfle/?=
 =?us-ascii?Q?3sc3VvbdU+JLnbumT7wXy04xwRxm3TYwMii0KUD92ix5yMZVix88hIUGy5Nm?=
 =?us-ascii?Q?Ne6IIcysQFiFZN/2wOgaNvIO+N5dYHBWl5mWsd+JIcD3DL4WRDvi4g+LWVXO?=
 =?us-ascii?Q?l9UxZp0WmznIxIkkUonHRQCX12qM36sz3cKyF0wVQe375EVXg8jd/vdyXu/J?=
 =?us-ascii?Q?fFT5oRnS3ZSBeiRENXR8HLFJzJ+EkP8GOeHSdaWuA4ewEsYRiurdRo/08FQs?=
 =?us-ascii?Q?NUjDhmCKvUQXRkAncEaWuon1pg86BdofxcQ7osnBvG2QZPpTbwE1oymYUrXC?=
 =?us-ascii?Q?364wYeajVdxwvzO5YkSAJJBbaLc5Ps+E5iM1tPb6I7+T4wSD5us20EX7nx67?=
 =?us-ascii?Q?md89uKchEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df098ede-a6ad-453b-3689-08ded0d70732
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:25:09.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJpOxcguFrQGBmNJ3E0gdVyVAM9R7k3YJ/gyka0w3YMeFkhB+4If+AUsj/+u35Gs0KHRvijDwbSGXWg/xiIpcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

Add an internal CXL Device Reset helper for Type 2 functions that advertise
CXL Reset in the CXL Device DVSEC. The helper disables CXL.cache, performs
cache writeback when supported, initiates reset with Memory Clear disabled,
waits for completion, and re-enables CXL.cache on exit.

Leave the helper unregistered until range validation and reset-scope
coordination are in place.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c      | 221 ++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h             |   7 ++
 include/uapi/linux/pci_regs.h |  14 +++
 3 files changed, 242 insertions(+)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index fc52d3abdb5b..fdfcc9e825e0 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -7,6 +7,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/iommu.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -318,3 +320,222 @@ int pci_cxl_hdm_init(struct pci_dev *pdev)
 	cxl_pci_hdm_unmap(pdev, &regs, &map);
 	return rc;
 }
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
+static int cxl_reset_dvsec(struct pci_dev *pdev)
+{
+	int dvsec, rc;
+	u16 cap;
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
+	if ((cap & (PCI_DVSEC_CXL_CACHE_CAPABLE |
+		    PCI_DVSEC_CXL_MEM_CAPABLE)) !=
+	    (PCI_DVSEC_CXL_CACHE_CAPABLE | PCI_DVSEC_CXL_MEM_CAPABLE))
+		return -ENOTTY;
+
+	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
+		return -ENOTTY;
+
+	return dvsec;
+}
+
+static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
+				  u16 clear)
+{
+	u16 ctrl2;
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	ctrl2 |= set;
+	ctrl2 &= ~clear;
+
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
+static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
+{
+	return cxl_reset_update_ctrl2(pdev, dvsec, 0,
+				      PCI_DVSEC_CXL_DISABLE_CACHING);
+}
+
+static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int remaining_us = CXL_CACHE_WBI_TIMEOUT_US;
+	u16 status2;
+	int rc, rc2;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
+	if (rc)
+		return rc;
+
+	if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
+		return 0;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
+	if (rc)
+		goto err_enable_cache;
+
+	do {
+		usleep_range(CXL_CACHE_WBI_POLL_US, CXL_CACHE_WBI_POLL_US + 1);
+		remaining_us -= CXL_CACHE_WBI_POLL_US;
+
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc) {
+			rc = pcibios_err_to_errno(rc);
+			goto err_enable_cache;
+		}
+	} while (!(status2 & PCI_DVSEC_CXL_CACHE_INV) && remaining_us > 0);
+
+	if (!(status2 & PCI_DVSEC_CXL_CACHE_INV)) {
+		rc = -ETIMEDOUT;
+		goto err_enable_cache;
+	}
+
+	return 0;
+
+err_enable_cache:
+	/*
+	 * DISABLE_CACHING can be rolled back here. INIT_CACHE_WBI is
+	 * self-clearing on completion, so leave any in-flight writeback alone.
+	 */
+	rc2 = cxl_reset_enable_cache(pdev, dvsec);
+	if (rc2)
+		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
+	return rc;
+}
+
+static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	unsigned long deadline;
+	u32 timeout_ms;
+	u16 status2;
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
+	deadline = jiffies + msecs_to_jiffies(timeout_ms);
+	msleep(CXL_RESET_RRS_WAIT_MS);
+
+	do {
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+
+		if (status2 & PCI_DVSEC_CXL_RST_ERR)
+			return -EIO;
+
+		if (status2 & PCI_DVSEC_CXL_RST_DONE)
+			return 0;
+
+		if (time_after_eq(jiffies, deadline))
+			return -ETIMEDOUT;
+
+		msleep(CXL_RESET_STATUS_POLL_MS);
+	} while (true);
+}
+
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
+{
+	bool cache_disabled = false;
+	u16 cap;
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if (!pci_wait_for_pending_transaction(pdev))
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+		return rc;
+	}
+
+	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	if (rc)
+		goto out;
+	cache_disabled = true;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CXL_RST,
+				    PCI_DVSEC_CXL_RST_MEM_CLR_EN);
+	if (rc)
+		goto out;
+
+	rc = cxl_reset_wait_done(pdev, dvsec, cap);
+	if (rc)
+		goto out;
+
+out:
+	if (cache_disabled) {
+		int rc2;
+
+		rc2 = cxl_reset_enable_cache(pdev, dvsec);
+		if (rc2 && rc)
+			pci_warn(pdev, "failed to re-enable CXL caching: %d\n",
+				 rc2);
+		else if (rc2)
+			rc = rc2;
+	}
+
+	pci_dev_reset_iommu_done(pdev);
+	return rc;
+}
+
+int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	int dvsec;
+
+	dvsec = cxl_reset_dvsec(pdev);
+	if (dvsec < 0)
+		return dvsec;
+
+	if (probe)
+		return 0;
+
+	return cxl_reset_execute(pdev, dvsec);
+}
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index e3087b7517e8..1fe606f15733 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -9,6 +9,7 @@
 #include <linux/node.h>
 #include <linux/ioport.h>
 #include <linux/range.h>
+#include <linux/errno.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -137,11 +138,17 @@ struct cxl_hdm_info {
 int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
 #ifdef CONFIG_CXL_HDM
 int pci_cxl_hdm_init(struct pci_dev *pdev);
+int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline int pci_cxl_hdm_init(struct pci_dev *pdev)
 {
 	return -ENOTTY;
 }
+
+static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	return -ENOTTY;
+}
 #endif
 
 struct cxl_reg_map {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350..194ae56b4404 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1349,10 +1349,24 @@
 /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
 #define PCI_DVSEC_CXL_DEVICE				0
 #define  PCI_DVSEC_CXL_CAP				0xA
+#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
+#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
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

