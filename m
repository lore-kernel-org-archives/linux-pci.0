Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01BF42E8EB;
	Tue,  4 Aug 2026 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871834; cv=fail; b=WtHO2XUblaeTcEs/4rQRXYYB61ZZNo1Div4drftTjcTp0USxwc9vjRhGS834nob0AyuyTybkSiiLXE5y9JLNjgooUl40VwJyA9EZqqB9djhaxRGC1gRPHWf62g2+uJx6Pg8ILnfCV5m5e5RKu+TOE9hrxMbkxBoQrRa65e+Qnpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871834; c=relaxed/simple;
	bh=45DtRMcavGmFea1nWakIMjGtYP1PD3DRr8IyTNKvoPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GQr+4bSlK9IminSsyTjoREiZLpQBmS4UGg0M+jxi925Zl7u+gedfReABitZYTZitp+azjsRnSJV/wqmMtDBXmnpmRl4Gpkhs/ZZ51e58i6VvBa1euG7xU/4D5d5MeDw7HpErNpMP3h9sLk0Fe9UuywDojn2WD5CwjNRZt8axCXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YLXFH8wM; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YLXFH8wM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUAX5CK7ba/IeUq0M9Ik5qNexEquG5lDx66Hv09aV4WjGNWPuc47bLlBD4HSqZSHJe7D0PoiQnQJ2vOTN2pD8jrTNU2ZBBKQzRo72bE3WrgGFER4cW3jbYSmIa/plw9aZLsAiB3dz0ii3ORkzYG5c/aGyXziiYTnh5bux6Jo97U7nf99J/Qiiy3L+g2eStukLyaMjSKQlhS+/ZgKgvSknWQ/gk/oMEjELTWqtR5mXpTgL8yI5MF1ElaC2Uc+u3tDICLT9rmrzq6NJrLVZHZILsXsVkMIAhADpzCHh8q21OQc0joq1J6o2o9ltOBu4R7giAIVMZobRzsSVPv2aSWbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/z2JnP/rM72G8rmHYYbppMACiXOUx8JH7+v4kS4YgQ=;
 b=RwTvJmx0zKvcSC90BEcplq9OxB5xhf5f8RlCJpPZ0CsDg4u/ecpkA6MgagPhzxg6E4c4s+0ArcEryO0j2vUtNnwPUlrc0utJyNT+31GVIOuKY35wYQM+jbDi20I4ZO/HJoxKM+gcp93elejXA78bc+h8oKoxlYqSBOeA3C+cvo8WpjBbxgCak3dwtK2tRiyn3DBkIYyqUZAgByAkNlSu0OakU4w5sPCs9S1Beb0ja5dHJ+khcyf1ocU6eX3sHFatklReq5a5sGQVsKQl2kNP38JbFq8CHcK24JUNbvAHhQG9yr+TKmGisUuVNsHS1rQDIAUw5YaIKgkahEu9EfnNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/z2JnP/rM72G8rmHYYbppMACiXOUx8JH7+v4kS4YgQ=;
 b=YLXFH8wMqZp0nuKlzNFf3JvpquhdGi5swxspQ5lATTFhTU2ZYxsxtXM3y9/0VSZVHocSnq8k0vjggEnNbAv1uagnqpEalE14kbnL6gENQqxeuURJDSpJLuMF2JI/Z5RiDhRkFlW2EFG+fkvW/CEDjdhkhwH1v6GlM+FI4RRtfUUk/Na0eEu8CE+sFtR69bibez5Zb3TKDYQyzztPilX5Rzhlt0tyr++r+kTpBhzjeEXLz/lBrEM4y80ggQRxS1cyC7O5IIbOSvZupINyDobztqpa2M0PsJPewWgjJWo3OpDBE8w4HjX1dS0azqQjkBl2y0whRIKCuum5z1f8tnIcpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 19:30:25 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:25 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v10 06/12] cxl: Add CXL Device Reset helper
Date: Tue,  4 Aug 2026 19:29:52 +0000
Message-ID: <20260804192958.1823952-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::20) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: c47fa2fc-439f-416e-b491-08def25ed512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|5023799004|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	xXnDYIHDOk9gC5hGXwOU2kFwr4GeTQ3hsyQz7+H6tizHcDER0BoNwLvCUVG0nLeMqYKTSNgi3/4YEFSDA3g56QA3suwpDMk31R1JFLWe+7K9fSBDPaPSMKmh7+dnX0oKQSBHuRRo4nVejkcNodGwp1lceX2xehZFw9X8wGgeKF2Cz79Yyuq//ag/Z7kwU5wXG6pjm0BXD7HBgaXbKI3RLHdLglwgBf2Y1WrImUIOTqJqUtQjD9XPy+cQPUCCnV/cfkyjtJDTYMtPnYvkNcGsdCjEyJx8kB2wbr2OzsHlaV7afOrzFWHwWO7VHHTWD8rSUzNa3w5kycO0bmODi07zU3p6c8zWW73UmNk00GM0fmgPxI/sP+k5yFU3mjIK6Mia4sYTrVVPAlnOM/3bHs95zfleYI/XRAVP6Th1KolWRgx8RZZglzbIO8kU99AFoCskIHtSNG/AL+d13aWc3TFZ6lajlc2R3RJTvfD9sHmPSl9SUrDJcir4UN2YBRLS0otrRJFZZcbkR61yTsr6lssq4IlBY3AOJX9a8lwQ5OFJQ7YehWtuvVp64kl2ZHjakbUTrYh74OskY0d3iFU39kcajKnXKzAFpPy3B033lHSJaeI7bZX4V5nMhuPkDXCR0uDgk0Aq02NBzFLiYJcu7jW92Jf+fKLuO+MI01zgnggKjjk59oj/AHemvg8eJGwbIRdKp1AuDLXQdLlSWwz3OPg9Qg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+OliWSgOPqGM/cnHwVbUlM4MbkDXQJZzbDmMj82ifV1n69tL9QYzzpSH+3F/?=
 =?us-ascii?Q?Yo6w4mUEs0C5s4IfkjaweBGSrwwDtoxpiJrzL79V/BjzeZ4pejs5hxDjEvOY?=
 =?us-ascii?Q?+cIrInSdoFaiZTGznXczzTFwDgxPU2N8OFJ73t4smovvnKoMjXhsyVf8CsW4?=
 =?us-ascii?Q?8Fd53h9x68Wwd3um9rb7x90JVG0RU7okN0faRtUe1svPq8FP59117LPJJcRV?=
 =?us-ascii?Q?pxEg7qWZIP2DVKNY6mBpyYTCiNcjv2HG2g1kdRj4oC8fhbFSttVQVxVeXWdP?=
 =?us-ascii?Q?atBYWk5oHp2CwCgvfcmKuHemDgxCJnqVA6qEE/37HI22bBy5NyVl947nQlCh?=
 =?us-ascii?Q?rw9SCODsqIp2jwPX9jpkYleN3naxjcEE23MIFrZaKKJoqF0dsXbD2vkJ+oAa?=
 =?us-ascii?Q?FTZ+Kx2AXK0vyFt0GWm4OzPtLQMIIkadmYwUuPJx5dUOAk1ZtGOH88AuWCxA?=
 =?us-ascii?Q?nKQvPVcIMxdJUnbr32ZztaE1C3XDvaJfdYtryIcSjU3Nd9vfH0fYx2/8pUhq?=
 =?us-ascii?Q?n+75GUp2a3762lN1lSadThPi0CBoAFNbAlS1/pyb4Om4N1AJ7np4fQvs+2pC?=
 =?us-ascii?Q?Qsot9WbB7qHxNseABC4JcGZtetT34LIBmN1eyTbe/J9J7syoeJyUcCTg0u6B?=
 =?us-ascii?Q?M0mJzEmUwgrCOnEtRaGdGkwlnKA+UtA2KCjIbu1JJbNaJUixTqZPIp2TBPn1?=
 =?us-ascii?Q?uOsiOkiI7F5wpMnBtPTZjdPxsdYysmHKSJcZdiGJ0q8mTMl4T2alsebDQxZo?=
 =?us-ascii?Q?qZaLym5s8A20tIGJpXVeassTSIvWunPwg1frv7KNv0Mt3PHQri08oZOdDi09?=
 =?us-ascii?Q?wbmwkumM7QClm2PCFBrNQbyJcWzw7/8DHKA2NroBO/IqwBiGVAAlxcebD3Nd?=
 =?us-ascii?Q?d9j5ZU++/G2KuISPWDvmZm7UzsAzPoxLVAzAcJU4xLa5qtwXD4scZ8iBr0hr?=
 =?us-ascii?Q?1xYTiTP/YIWrnMMMYr9dwNS7BEWPeK+MNAG/ZprDNZ+GRUYhnINjvduutfVP?=
 =?us-ascii?Q?y2hlqB03HIVEbC5Hifv92+34UP3RFegLp1MG+5ULw9XjF1y/g7rc4cvfWat/?=
 =?us-ascii?Q?+LYusvgs8j3Dsc1zjeo6LOmY2uFV13/9vJJ11vbLnsI6Ex/zkqb7jjP/G914?=
 =?us-ascii?Q?aguw+ioI1F0YF8aYEdadjUdAa3forQjosFUBiUUVJQtF39SqPgRM8VN8nMi7?=
 =?us-ascii?Q?B6YZdegVAyu2CbxyZeC4tA2uTn0HBbQjeQArb1FuDhUGZP6P7lQocb4cjuek?=
 =?us-ascii?Q?zvN8SONV2unSaPVnJG6yjnaXbWq+nmH2cXfizkT6DqIafq8GxKy+TmVa/SA8?=
 =?us-ascii?Q?PoDxUcF0q2RSWO9Yw1P9WeqwWdTiKMqQ9zv/Y7Xb44EwD+c9dihH0yoZAhr4?=
 =?us-ascii?Q?UEwLX52W6+C2mr3HrxOoHv+VmDW0Lgsn0JAtgSW9fd+ch1OFdJ9NX8hrinPU?=
 =?us-ascii?Q?aWFPGLZl+heJi7fREX16STc0sh3C7MguCAlNxPzr4S2CYeci17/PjxlHSO44?=
 =?us-ascii?Q?6Ktne1HAJcwVLfCfwGXoy7/Doq3Ra4gJRvt2X36vBVQk+Q/EOr0Doh2wddDG?=
 =?us-ascii?Q?rvpFExa/qGnY6YMleVNQsJITTwOV/IKPsqfT6sJ1VLL26GqwnjF4hCFJTJkx?=
 =?us-ascii?Q?zesO+6PzqoZne/wRUHwMuTpDkSmlIU72/UDn3yFUz11JC1KZ0EzHIz/GJahc?=
 =?us-ascii?Q?rEUBjY+vTGN9z83pdq2EcUXg4Yil7lkEnlGo96ZMHsZcWwxlNavFV32QW17r?=
 =?us-ascii?Q?Lq4bgMmguw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47fa2fc-439f-416e-b491-08def25ed512
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:25.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4ruzKOlnMON5leUQu+LTpFacPQB2RP7yiKJsOeIRgUxYXHi+/AfhTHXM1VFHTxiMCNXoojoWXzs0zigqptqSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

Add an internal CXL Device Reset helper for Type 2 functions that advertise
CXL Reset in the CXL Device DVSEC. The helper disables CXL.cache, performs
cache writeback when supported, initiates reset with Memory Clear disabled,
waits for completion, and re-enables CXL.cache on exit.

Leave the helper unregistered until range validation and reset-scope
validation are in place.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c   | 265 ++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h             |   7 +
 include/uapi/linux/pci_regs.h |  14 ++
 3 files changed, 286 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 7f5946d3f2c4..c10e84b240a0 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -7,6 +7,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/iommu.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -483,3 +485,266 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
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
+static int cxl_reset_dvsec(struct pci_dev *pdev, u16 *cap_out)
+{
+	int dvsec, rc;
+	u16 cap, ctrl;
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
+static int cxl_reset_set_ctrl2(struct pci_dev *pdev, int dvsec, u16 set)
+{
+	u16 ctrl2;
+	int rc;
+
+	rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
+	if (rc)
+		return rc;
+
+	ctrl2 |= set;
+	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
+}
+
+static int cxl_reset_clear_ctrl2(struct pci_dev *pdev, int dvsec, u16 clear)
+{
+	u16 ctrl2;
+	int rc;
+
+	rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
+	if (rc)
+		return rc;
+
+	ctrl2 &= ~clear;
+	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
+}
+
+static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
+{
+	return cxl_reset_clear_ctrl2(pdev, dvsec,
+				     PCI_DVSEC_CXL_DISABLE_CACHING);
+}
+
+static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
+{
+	u16 ctrl2;
+	int rc;
+
+	rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
+	if (rc)
+		return rc;
+
+	ctrl2 &= ~PCI_DVSEC_CXL_RST_MEM_CLR_EN;
+	ctrl2 |= PCI_DVSEC_CXL_INIT_CXL_RST;
+	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
+}
+
+static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
+{
+	unsigned long deadline;
+	u16 status2;
+	int rc;
+
+	rc = cxl_reset_set_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CACHE_WBI);
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
+	rc = cxl_reset_set_ctrl2(pdev, dvsec,
+				 PCI_DVSEC_CXL_DISABLE_CACHING);
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
+	dvsec = cxl_reset_dvsec(pdev, &cap);
+	if (dvsec < 0)
+		return dvsec;
+
+	if (probe)
+		return 0;
+
+	return cxl_reset_execute(pdev, dvsec, cap);
+}
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index a1fe8949f3f7..8645d0fbd273 100644
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
 #ifdef CONFIG_CXL_HDM
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

