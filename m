Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1399396D29;
	Thu,  9 Jul 2026 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559031; cv=fail; b=iJRay3sQpsr7J86NBkMMLkAlNuzCzE7FkuS5EtscDvEsGiVQ9AxsbfgvT4/q8hn2SkUpUO1IgVY+BJAB+SueWW2Bmp6TTrAnqIajoDZPn597KETjCAlG3K4HJrJLOMPQuk2NKcm5qtU9tuhkxEavHrIoSZS4Vbi3Q+hZWV4AfuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559031; c=relaxed/simple;
	bh=BEYBrdMG3i3/nYVT/CJaMXlhQUD7F6ZweqeLPILsOac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bnlthOz349pFVOma07/5YbNzF47kbYHh3SenznP1JCD7QmaMeorS7s37E61QndAtq4a0O/oZ1PLE0QC+MRpIPuj9udSwzsiVviZgOjrEgHXgfR/qvTvjO4pLojA6+QCWAYRnqr47uDyBWwyYhrAh7PpBhBhbupcB37+kN5SjuEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J3PaAPxX; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J3PaAPxX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5AJWXG6rXO+HV/PGo2qSU7RpWVYsrPA2Q4yUoN/vV6lni7e0KT0Q2W0aTKKUn5n2wMTh9yGsFRLIsoBCzeIvaLEOk6eHyMLclqhcunY3wsYqg7ajKqSnnsF4oge7uCMle4GDJasYnbzXJXxDYoQOY2IKYK1rGB52RuGYgR0UY1fv1qxEEgRMW+7bRyjluqBx0EiTWdBBJUYkwDX5k928Xmbisd+v4l2Jvl2E8dCZfyn2p/jUlVwYX+v3QUeLP3nqjyCrE8xxtU6tnENyvyJggdBH9HZpSlp4kioMEgeaYnelE2qYM821KfZ/fld1QtsRN2CIr62husv5yiUc0c1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pdWAeT1k5Pn0YAj9pwNViRx7hAFxP5TXt31WfZfeRc=;
 b=m2VnIFXApxB/j9pPwUFqw18VEA3b/LJ5leuiTIU4ov+qTPOneOaAvrbS3WD/5P8lbDrYLLed54rpSqQmHB6mG60L0nen/zbey6rqzKzmk/e5ERo8TZuZ3tFBMil54+eJjZJCdmryFKhmbcKX1zumQENWCzzdjt83PtGcpcv4XZDELGsUi86/sDxZECJA4auiJdR45sylZvbpsVK6VzOOEnata5JDnRWiicuZerw4JT6yccOVWck64qIV0zt+P+USEAo2D2WjNeLFzycWfDpq0ua9I4MNGxMqE7oBuAFVsM7wCwlrDw+7pqdi57oflwd9BJkffMnlkd9o0d/3H08DBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pdWAeT1k5Pn0YAj9pwNViRx7hAFxP5TXt31WfZfeRc=;
 b=J3PaAPxXshTe+2AAPzWgsEEZNm0h4OIGq7z7YRiu7RUB6TZFNedXMimVkdedi5iNtwsjzG9bX3oIK5gs5Zl/SmL440Fun+YHiLJfaDwj5viEdNx1u7lpMHJ9Mou32gr5f1APh5ApWM9w2iWXvosl+twDLtgCmj8WXnadWgkoFHrOA5VmuT8n4hxAlYJ4mSohwTy2cMW6TginrO46dFh96VUf4JCsfyn2Mh5twwvfBIptM1WNVusVcQ8Y5izuyjCzcTEQ3v67nwoo8Sz+sN+4cuX/4z8ViBmbExqq3NKdlBAPB5HsujCO0JKXs3mJaSeoyIxsSCTaOuC/VLfUZg/E6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:03:47 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 01:03:47 +0000
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
Subject: [PATCH v9 05/11] cxl: Add CXL Device Reset helper
Date: Thu,  9 Jul 2026 01:02:58 +0000
Message-ID: <20260709010304.680422-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709010304.680422-1-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::34) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7a11b9-ca58-4d30-40e5-08dedd55ee79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|5023799004|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	z5PZoMcGlFl3SkpoQdU+Q4VDZvKv53En/ox8Fq6srXq0IKppcm86NFabRN27oQxjmfqzSn4k1DfIAy3PKaovoXyW0+LU+OLgf/J7j+Miht++OsV+4i3NhFGKXHQUS2Z6fE5SVZS/WVB2rRhl+MZOGn+fMIXxzURsDq8ZPvhofdU/r6luzvrwUrmnKypgDf6OEFd9zYAHC/OTgb2BCIU0qTVvhad90B8jhBVQr6XKsU/UGYpv6I6zEh25XQDAtNj11I7fAgEqXiRELWg/IKVrB1leQS6UrXicbDRyf7i6rwGI2nJpS4XAjNvN66mwMKkrgN17Jy5+4EL1pMaKurm5ouDTP6Ps/LbH06Rbxih+kMpB+E15GryIB6Px+D8DZ1JoEfSIfQH4lHdsmDp+PWnLCFs+ePVm3NUDtMnTq9tbonCsOXiCFPNZ53ihkyh7kNvdJ9IMqmFsTS9effxB+xZjQVGIotv7M26ue0Z282ZktjGQDhv/xrAds+XFiVABn1/eiVx66Uu2mMn4nKPaOm7643TKl7rDzUx7q9yQhCjWsvmEiwHM2F8ljz8H0KWhah5EoRRtF508RrgUnXjNiTiRaKi4v6C5dwxt5rgEdnZRL3e1pCTrK43Tn8axVJgV2tYd+k8BQMA5riVip+dX07ay75gPgyF5EyJ1fQ3U0VwoMU5DZm6T/ivkT/nOqyAcMmxePGf0sZ5Xl+AsmtigQ57GJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1KOyfoFb/dY/bccp17LGebZMSPeoGp0mCGNWKcyyrV7WpiV9jPc1dgq/IUbt?=
 =?us-ascii?Q?pjY77vX2a5l3HCDgHIW1UtEX4SKJ+4qh+NhSMRiwI59p5XuGakgeYTelw2Lq?=
 =?us-ascii?Q?Ru6IEbT/MV5nv6n4A5QSuyJPp3+WzUI0DiiddBOIjAQDcni6YTsi53ygRZoE?=
 =?us-ascii?Q?yn5OvM4hOW5VIbu627s87ec26bsfhw2uPYwx7s0kTsrCuZ6zIrXNzX2IY+Pq?=
 =?us-ascii?Q?9qTWJioRnYovhiaEFDJYZ5DIc3mQhTHjrZKiEcjKBYJIKKC9sSIb3gug03U+?=
 =?us-ascii?Q?ifpeA6WLB/QU5nGgO8fkwWCKpQ0Ggl75ml3tYzJL1newiqpQIRh8IbSX5Wxd?=
 =?us-ascii?Q?bpoW1bq1Z1n4dZE42ErMEgcT7jJM8sEgHptMwvBn/tFLzV6h8UGPCRoSio/j?=
 =?us-ascii?Q?k+2k9Oj9/faPZVwN8laBi5E5om/lIPmCP79l38bPiCb5S8/mJHzGFNBd/3zu?=
 =?us-ascii?Q?6VndkBbfDn0YBYsV/AEHYrIEhpF9PEK3buHU5szzIPutvveBV9+Z2Cne5mnY?=
 =?us-ascii?Q?qB4Jmn4XF/0yBT2czADHSaik/DbaeW1JhenbgkvwmTV4Uh1BC/X7cA+aT+B1?=
 =?us-ascii?Q?mZI8FaVsnU2zsD0cIdUWLgjNpaUcrX5EFiCyQlUe81jwznRNIqToggurER1v?=
 =?us-ascii?Q?gNdmSTNm/Q798U0t5eXKrf3ZFt7fwnssCKoF7+RGvjcaRHFfnTbOwNgjAMLl?=
 =?us-ascii?Q?1M9kr1cppAeEZ54AmBw9pYKpkHVO28ZXJUOhShMIKtzz7IQNpA6Tkc2lHJw4?=
 =?us-ascii?Q?OzAQjhTBBw1dC4ul7j0uL9V+eSpSy17sxJVb3kYHLbWW5wzJPLC9shumjUIr?=
 =?us-ascii?Q?X8vvpXOC5v7yCexjKd2Gj5oJ/72mhCJyruWbik6qSdMxiKkuGMC8SgLRZrBd?=
 =?us-ascii?Q?3fzw5Jty3GmB8SFMe0jW4V/GGSKbF2AERVkC9Mi8bP0P1hFZ8/2hPq/vLVBS?=
 =?us-ascii?Q?/djrTNrQGfo4aDZr2RASr0Hsi0SVwFXSJMb2y2FcsS7kJoPX3aUhPUlZwCKy?=
 =?us-ascii?Q?Ae4s6eXUf4CjY4F2h7RzKolvVWt1KzX9fyUEK/1/xrO34OD/KSZXqc12HGvN?=
 =?us-ascii?Q?+gH1nC/UIGfcEOLR61uYURgMnLqQX8jwrNyHAV6BBokKYinRvs4n+U/tjSoa?=
 =?us-ascii?Q?43gtr7Pew5suY8Cjpf/rsBhwh+onpdwEflsMZVBWvhCsn/TkhdfJN6DR8MH5?=
 =?us-ascii?Q?orQMJneAt9f3sgg44NjjfDAijWe8a4iogk1oQlmFZP3EzQZ0fu73s+eSjD5X?=
 =?us-ascii?Q?zRRh8+vdB7cXWiO6CZ41gyOBmv8AKjcFDHG5PYD0EbrXtOLm06sN5drPWOy2?=
 =?us-ascii?Q?DGrLiXBZiTW4gsggBozIaUxA9kF7P4P4Grlka8s1xZCN+PHhZv7YCGBJSYif?=
 =?us-ascii?Q?THcE8D6SgwA5BlkYBO48IQet3KeXKIhB2E4k4pYgiVK93R8H9cR9JVEux6yN?=
 =?us-ascii?Q?QMjKvLVufD8Zdv/sD6DrB7DWj++kNpR2QFFRSop8irOB09+L8QFzniGsgvVg?=
 =?us-ascii?Q?hWEoYI/9YaeQJmK6hKXMsMlkdorTOscEYcsW/z+Slt9Ih8Y5fd+ezOWOOsjb?=
 =?us-ascii?Q?WGn1H6J8Dq99sIYePAILdVx7QRnQ2Q+tRhdUdV2pm9r10Z+q/4DySoWtZlS8?=
 =?us-ascii?Q?49/oBwbCnH5Am8AgFMXTpu/GK4Ub7RZVGvole0LlZiLkUWZMUMx/JRVSbxMx?=
 =?us-ascii?Q?cG0ihAtREAJI1QiP2sqzN9uAntw+iIkXKAV2JadXqAP7VD9aBx6kPA/7zHLq?=
 =?us-ascii?Q?bwd58jEWWQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7a11b9-ca58-4d30-40e5-08dedd55ee79
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:03:47.7646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqS/ut1prDkk4X/bcl74pRcMYfi3regieKx7fE4TnqXcDH+y23WddHUtr5NyM3V9aI0yJOP5804irT/71wuEvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

Add an internal CXL Device Reset helper for Type 2 functions that advertise
CXL Reset in the CXL Device DVSEC. The helper disables CXL.cache, performs
cache writeback when supported, initiates reset with Memory Clear disabled,
waits for completion, and re-enables CXL.cache on exit.

Leave the helper unregistered until range validation and reset-scope
validation are in place.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c      | 224 ++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h             |   7 ++
 include/uapi/linux/pci_regs.h |  13 ++
 3 files changed, 244 insertions(+)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index 97b72cc67b6b..7a9b1ecfadcf 100644
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
@@ -449,3 +451,225 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
 	if (rc && rc != -ENOTTY && rc != -ENODEV)
 		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
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
+	u16 cmd = PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST;
+	u16 ctrl2;
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	ctrl2 &= ~cmd;
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
+		if (rc || status2 == U16_MAX)
+			goto not_ready;
+
+		if (status2 & PCI_DVSEC_CXL_RST_ERR)
+			return -EIO;
+
+		if (status2 & PCI_DVSEC_CXL_RST_DONE)
+			return 0;
+
+not_ready:
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
index 2215fe1c3f78..de58f484b7d9 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -9,6 +9,7 @@
 #include <linux/node.h>
 #include <linux/ioport.h>
 #include <linux/range.h>
+#include <linux/errno.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -153,6 +154,7 @@ int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
 #ifdef CONFIG_CXL_HDM
 void pci_cxl_hdm_init(struct pci_dev *pdev);
 void pci_cxl_hdm_release(struct pci_dev *pdev);
+int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
 {
@@ -161,6 +163,11 @@ static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
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
index facaa324bd86..9b24cdcfd648 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1352,8 +1352,21 @@
 #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
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

