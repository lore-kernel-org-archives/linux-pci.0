Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8B385D66;
	Thu, 28 May 2026 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957147; cv=fail; b=c4CAtnX8P5Lb0ETryf6haC9YZVaSQcW/zdHfzFr1vmRU3WjPwD7GYedh7ZCvYQZ4wLiHB6rLyabiocv4OFYsUxxM9gWIsFYsieoCVyxiwsQfvxHYc298sIIfB7v7zng9y0v7bsFPrr9UwtfPkP++kPlrUmacDSVkpzrD52Mav0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957147; c=relaxed/simple;
	bh=r0oP8HspGixxaRVdgvaVdfubPlpl7drX92P8NRov32U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FILVCFQ1l4GC8JmbmZfm17y1dAY/7RgY9aSPpRa74qIkvR2m0oGugBd9ayISbYn141EbsbaZaUMTbQEAwf/sqlS1dxghgKiBgoz97qW+8lAxULTB+qSzaovxjQ8/gbtudUaadjjpQ27ZYBZJyEat4D869+HJxD4CcHcYp/BY9FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhp3btRG; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhp3btRG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPPXiYeaoHSdlFPRVY0YBb6I7I6krz0dcUfzpc00Uq4cJa6Jd1nMHgP1Jgo8hCrz++Pftwt5CaaHTmgpbsEna7qz+FFMf62g2vlveJzEBwmuMTuSP3oli1Lzv74tocWey99wwkD5tnAAfwQeCxfTkculDJW216mZoKC+EwF8iySlTCooxgGf3Yh4tHSYFFcqYOORRo6nuwzYbleZ8LxnRoYIDuO07R4ZWC9zBZMTFEFyKIbPSJkN26GIJZnDU80HUOhko/nJyFU0G2KBVhHaZ17JEhtHfT9n81HONsTKZFVRN5kuLgD5sj9PsllOa80S1xqlz8rxZ7XxsrQqhmTv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1v9MgZ1BuMBnzAarKA2NXV7LfL4EkMn5RcuUJrPrn34=;
 b=Xs6MvEzZ6dvfaRV1diWe4U/hfoKU4AzrHD32t1ymbLnDfH2CS4u2dWu276RGKp94QB14VBoTGMvlkWG3qYUw9babvZJL9tTdmhA6eOvJ/uVP8hTrsQswpD2cvhklf3g4LkzA/wIfedNKaI28UfSWBlM+T+IgQ7Xp4iZ0rFHQxNPoEGVTefzJUTzWLIhElOJITEgjtdRwS+8KG8Yx0iYXiA8Vn8GzTcjNf6tQjnIafLyB+GS60ahr/ei5UtjRlSA75vOPHhKaJSXYbChSLCRfwhKvBd8xiyel/EhZJPzvp6JbbCbd1sHPkoB2cZA2v/J5DrOtdct43aN5QroX7iKbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v9MgZ1BuMBnzAarKA2NXV7LfL4EkMn5RcuUJrPrn34=;
 b=qhp3btRGt3/0uiu8Oov8UkO4P59vrDDz0z9T07Wl5qqg1NwyrpFfsZvfCEcOrXmL/mrbcIDxR1U0JxMHZs5IVWSkgMiOkL+CDPn8WkKCfgT7OG18RJyoPWsAaqT5lf3DH927zgrPJG5VI7U5IhpvYFs4YtZYi2akMMY4Gqr2b1HO8WJPK0b5EXSuUxoI/bQyGcc3T7E9MPmvARWIryD84esgGd3hgSVrDF+WXbeaBRTAlibRFYtOlgiuGbXwvB4rO3L0+s/KOl/koBnWn51TqXFf4atGN3RHhz3r7IVQFX2SXM0l6VitC8l6afRuE4tTexHGACLItbflfUdxSI4Paw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:32:17 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:32:17 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: linux-cxl@vger.kernel.org,
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
Subject: [PATCH v6 8/9] cxl/memdev: Add cxl_reset sysfs attribute
Date: Thu, 28 May 2026 08:31:53 +0000
Message-ID: <20260528083154.137979-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528083154.137979-1-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::15) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af920c7-52cf-42f9-74ef-08debc93a0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|11063799006|5023799004|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	qdww30NM5l/xTvr2xs2fh6L0QYRewLU+PXQ9dZ3vWQ4ivKlJkSSzK9rcRC6ixnBfLD4hRaJEAeV4oORmH5QXYsPxVrxN5laoRNgWnW64NiZ73yKjTOki0Qs2Zy3Nzlg5PqbHuHh+cSJ5vQ2wA7rd4apan9HRsQaMuwVxWJv7b9eHqlIbx4983QjcATREI0fJruTFHXxU/d0xiWnuk2HV2cfW3Uhvgx/Qh9zrgb/iqaXomkar/nRAggv3dXZ/xL0FnPxJD6U6ccBKbmGkFSz3Qqj6lsuhF5/U+JOs8G8Nq30mjX4tifM4xWlADGVmGOwLg+DI/v/IzA4BRe3JRqaHQnCPlqjfFpv+QNnjmOLiwGFET/A7O3k0RKHfiTi3zc/vBp/Pk+mCG05BEVkgr/+W3CZXc6ys7S6kEELVKIGJ97tE1UZE4/aQV6B/asPDFo434Ire/oJQhevb/So1sMv842ah6AOnXI38VEOuNsPIRTL6t+fbpZ2DppQZ//N0S7gbL7j/ZRiCv3E0v+UZk9D/UB++gYdzpPpxVwEbGxsTVvovKortdpnzxCAIEX5T4QRmskFtLfjCwsN/m7IaC0PBPHhqrv/1AiLme4ox2ll9Iu7gB0vZgqBvBnkyfE3Pv8XY31wVp9srROU5ehP59H0sipU3vQMWSKVFCt9mbOB5Bofo5FKSQ+z3VcCzLTZ/d6hGuIPa9oQV8Z+fE+VQnBGMwg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WvT9JPo71IktQdPjtSV+4YZiBp0TA9aTKwr/rFQWTV6UHDWxLNjhTsB193T2?=
 =?us-ascii?Q?Ne0+9BOzfpfFWitoocwuQEEVB3V30i3lU+B6/+v5RX8vE4x7BdYJs0U1i4Mk?=
 =?us-ascii?Q?QUTdULeXDpA+FfUISm4z9x/32CqX3GfvUBuN2uFOKgn58yPpTwO1Q/EjTGUG?=
 =?us-ascii?Q?mHPWEbAk8zPWQFgl6BMFuOTOUIFYCSgQ0PR0UAyTo6bTZ3vsKvpVNqi389tj?=
 =?us-ascii?Q?cSxiseR84YPskXtX84mUsSX5m8hmBXtE7Co93IwVfED4VRFoNtvruvBTrQFv?=
 =?us-ascii?Q?EYsidkdLrrDR3FhB63mQDi+QtbsMyyaqlDyJgNBpkFDZS+5LnWKTzH7bORZp?=
 =?us-ascii?Q?Su53+9WsesORNRoJvC7k9cCVftlFpexgy0IyUrkHt8LFaiqHYZocd+GaFY8m?=
 =?us-ascii?Q?Er2PsBAWU+a2m19lSsWIkPOqfKWzg0NzQAkDN9RWBlADN+vSLDmW82HVKJ4G?=
 =?us-ascii?Q?8BLOO9XZOJigzU1glGYjdRlPaqKNgFYYnE+okHEhEiOn85CNaJ1B5ArrP5Td?=
 =?us-ascii?Q?zRZkv2TnMR9yvhNHG8l9kS4sCPZjyBwL7aPHW3dYT2pbVRqxVldLp8NAfHqt?=
 =?us-ascii?Q?IKpWxJq7P+XSnp/+eg9tJeTeNkpQRTDE7WQJLwKWP6Ns6DHRfApTac6a6AO4?=
 =?us-ascii?Q?q1VgB7hfWG3qMZmE8klWGhgeA9QmuJPu2J6a9FWudEKUHAcnW6OGqJ8l5EEk?=
 =?us-ascii?Q?IndbTc83MFqJwZwU7I+A9xpLIOC2ST8sdnXih4PkfpxV/KG6LuUXgInUGVrs?=
 =?us-ascii?Q?EOvIgtEcLoAl/jTxPUBp5CbI1bJu+gIJR6cexj0tXBTXMoYnG8mlCvhy4G2A?=
 =?us-ascii?Q?75IwuHzjC88M8vOEWRtd5jasI7u8lVT0tulWty97DgXolGMWXzEI3+d6RoFP?=
 =?us-ascii?Q?MVODBM18L2aqAcaYRkkrZU/KYTE+7evfWQGdmWNwAKd6uxYDmFFWZYHDXuX2?=
 =?us-ascii?Q?2FpViEAIUYFAahT3AtFYX683xPBQWxH5l78YaFCfctmLMjZT8u6ZQ04t5rlx?=
 =?us-ascii?Q?S+YwltPzr9ccKxOX2KcJXno+Fu6U2oBoXX9FQKOO0K9J0HDpHFW+OrmY4QKj?=
 =?us-ascii?Q?Km28ORncGaHzBOb90JEh6G12fh67bQiGwIf0eyXvZv6iPxETGAR8WvQdtgWl?=
 =?us-ascii?Q?ewJU+SCCLk/Q9JkPZjLNplZfp38Yxbv8uAL+QeABKdqkAU2g5GXEB0pwqywQ?=
 =?us-ascii?Q?1l8mZzwa3RGLo1jUExAqObMTxWFt98v6My4zxrRsArQ4E845MWW7yFJUipUf?=
 =?us-ascii?Q?1qbNFAJkOrUlJmpfnOGGLYtDNpwA5pTjC5i/eaiQzhwLk0UpOTreN9w0FgFT?=
 =?us-ascii?Q?9+YU//PeSfwaHosnEUL+08rlGDfn7JJZ1gqUkIEA6YcRbRXEcspybirUFV+Y?=
 =?us-ascii?Q?xU+gxeCp1uGzrpS7HYE/53hq0+oyveJUJ21ZG/djCM204C+pOuIBmp+5pYMy?=
 =?us-ascii?Q?v+NgUu5XVvJasOmqKG6H3lAzp0foxY+A+LkuI8ofCJJ+aMg7btTbOUEN6KSe?=
 =?us-ascii?Q?1G3mV4MHfvxwoid33k4D4bQVWjBrG7Yof6weIq3itshNQZWnF29icbAFGt8H?=
 =?us-ascii?Q?FM4m4e7aGqrepdsTbZyS2rv87AFmJW4JaiZjLutRQZZZo/ix3QJz9qq6X1Zn?=
 =?us-ascii?Q?PZpMFIHXw9dg0vipCXRKqz586pwysAyMt+YajTtg+s7r7wYvXrT2QVZ9wF0d?=
 =?us-ascii?Q?em9FqK28F8i/zGFyTAzPgbe7Fdglb7DdlznsNaxp4Dg0bQFf8Sgh3T2O1M5J?=
 =?us-ascii?Q?AWwbRHCrZg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af920c7-52cf-42f9-74ef-08debc93a0b1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:32:17.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Na2rtTu6ln2rnb4x/AkE5lQpLZROsR7IR/K8V/8naisv/RyzbasUn8KDVbcIaL62piBJUMzx8oHg1qiBNzhz5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

Expose CXL reset through the CXL memdev device. The reset flow
depends on CXL memdev state to identify affected regions, coordinate
decoder restore, and keep CXL-specific policy out of the PCI sysfs ABI.

Add a write-only cxl_reset attribute under memX. The attribute is visible
only when the memdev's PCI parent advertises CXL Reset capability.
Writing a true boolean value invokes the CXL reset orchestration.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/memdev.c |  30 +++++++++++
 drivers/cxl/core/pci.c    | 102 +++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h         |   3 ++
 drivers/cxl/cxlmem.h      |   2 +
 4 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 80e65690eb77..af67fa3d11b8 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -199,6 +199,26 @@ static ssize_t security_erase_store(struct device *dev,
 static struct device_attribute dev_attr_security_erase =
 	__ATTR(erase, 0200, NULL, security_erase_store);
 
+static ssize_t cxl_reset_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	bool reset;
+	int rc;
+
+	rc = kstrtobool(buf, &reset);
+	if (rc)
+		return rc;
+
+	if (!reset)
+		return -EINVAL;
+
+	rc = cxl_memdev_reset(cxlmd);
+	return rc ? rc : len;
+}
+static DEVICE_ATTR_WO(cxl_reset);
+
 bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
 			       enum poison_cmd_enabled_bits cmd)
 {
@@ -421,6 +441,7 @@ static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_payload_max.attr,
 	&dev_attr_label_storage_size.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_cxl_reset.attr,
 	NULL,
 };
 
@@ -485,8 +506,16 @@ static struct attribute *cxl_memdev_security_attributes[] = {
 static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 				  int n)
 {
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+
 	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
 		return 0;
+
+	if (a == &dev_attr_cxl_reset.attr &&
+	    !cxl_memdev_reset_capable(cxlmd))
+		return 0;
+
 	return a->mode;
 }
 
@@ -1099,6 +1128,7 @@ static int cxlmd_add(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
 
 	cxlmd->cxlds = cxlds;
 	cxlds->cxlmd = cxlmd;
+	cxl_memdev_init_reset(cxlmd);
 
 	rc = cdev_device_add(&cxlmd->cdev, &cxlmd->dev);
 	if (rc) {
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 486c447e98f3..09f016544d24 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1207,6 +1207,22 @@ static bool cxl_reset_has_cache_or_mem(struct pci_dev *pdev)
 	return cap & (PCI_DVSEC_CXL_CACHE_CAPABLE | PCI_DVSEC_CXL_MEM_CAPABLE);
 }
 
+static bool cxl_reset_is_type2(struct pci_dev *pdev)
+{
+	u16 dvsec, cap;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return false;
+
+	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
+		return false;
+
+	return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
+	       (cap & PCI_DVSEC_CXL_MEM_CAPABLE);
+}
+
 static int cxl_reset_add_sibling(struct cxl_reset_context *ctx,
 				 struct pci_dev *sibling)
 {
@@ -1939,7 +1955,7 @@ static int cxl_do_reset_locked(struct cxl_reset_context *ctx, bool mem_clear)
 	return rc;
 }
 
-static int __maybe_unused cxl_do_reset(struct pci_dev *pdev, bool mem_clear)
+static int cxl_do_reset(struct pci_dev *pdev, bool mem_clear)
 {
 	struct cxl_reset_context ctx = {
 		.target = pdev,
@@ -1966,3 +1982,87 @@ static int __maybe_unused cxl_do_reset(struct pci_dev *pdev, bool mem_clear)
 	cxl_reset_context_destroy(&ctx);
 	return rc;
 }
+
+static struct pci_dev *cxl_reset_get_fn0(struct pci_dev *pdev)
+{
+	unsigned int devfn;
+
+	/*
+	 * CXL Reset control/status is exposed in Function 0 and affects all
+	 * CXL.cache/mem functions in the device.
+	 */
+	if (pci_ari_enabled(pdev->bus))
+		devfn = 0;
+	else
+		devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), 0);
+
+	if (pdev->devfn == devfn)
+		return pci_dev_get(pdev);
+
+	return pci_get_slot(pdev->bus, devfn);
+}
+
+static bool cxl_memdev_probe_reset_capable(struct cxl_memdev *cxlmd)
+{
+	struct device *dev = cxlmd->dev.parent;
+	struct pci_dev *pdev, *fn0;
+	int dvsec;
+	u16 cap;
+
+	if (!dev || !dev_is_pci(dev))
+		return false;
+
+	pdev = to_pci_dev(dev);
+	if (!cxl_reset_is_type2(pdev))
+		return false;
+
+	fn0 = cxl_reset_get_fn0(pdev);
+	if (!fn0)
+		return false;
+
+	dvsec = pci_find_dvsec_capability(fn0, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		goto out;
+
+	if (pci_read_config_word(fn0, dvsec + PCI_DVSEC_CXL_CAP, &cap))
+		goto out;
+
+	pci_dev_put(fn0);
+	return cap & PCI_DVSEC_CXL_RST_CAPABLE;
+
+out:
+	pci_dev_put(fn0);
+	return false;
+}
+
+void cxl_memdev_init_reset(struct cxl_memdev *cxlmd)
+{
+	cxlmd->reset_capable = cxl_memdev_probe_reset_capable(cxlmd);
+}
+
+bool cxl_memdev_reset_capable(struct cxl_memdev *cxlmd)
+{
+	return cxlmd->reset_capable;
+}
+
+int cxl_memdev_reset(struct cxl_memdev *cxlmd)
+{
+	struct device *dev = cxlmd->dev.parent;
+	struct pci_dev *fn0;
+	int rc;
+
+	if (!cxl_memdev_reset_capable(cxlmd))
+		return -EOPNOTSUPP;
+
+	if (!dev || !dev_is_pci(dev))
+		return -ENODEV;
+
+	fn0 = cxl_reset_get_fn0(to_pci_dev(dev));
+	if (!fn0)
+		return -ENODEV;
+
+	rc = cxl_do_reset(fn0, false);
+	pci_dev_put(fn0);
+	return rc;
+}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b51b1e9d6400..bf65996e24dc 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -796,6 +796,9 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info);
 int cxl_restore_memdev_decoders(struct cxl_memdev *cxlmd);
 int cxl_commit_memdev_decoders(struct cxl_memdev *cxlmd);
+void cxl_memdev_init_reset(struct cxl_memdev *cxlmd);
+bool cxl_memdev_reset_capable(struct cxl_memdev *cxlmd);
+int cxl_memdev_reset(struct cxl_memdev *cxlmd);
 
 bool is_cxl_region(struct device *dev);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 776c50d1db51..c8e7349fb130 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -48,6 +48,7 @@ struct cxl_memdev_attach {
  * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
  * @endpoint: connection to the CXL port topology for this memory device
  * @attach: creator of this memdev depends on CXL link attach to operate
+ * @reset_capable: cached CXL Reset support
  * @id: id number of this memdev instance.
  * @depth: endpoint port depth
  * @scrub_cycle: current scrub cycle set for this device
@@ -65,6 +66,7 @@ struct cxl_memdev {
 	struct cxl_nvdimm *cxl_nvd;
 	struct cxl_port *endpoint;
 	const struct cxl_memdev_attach *attach;
+	bool reset_capable;
 	int id;
 	int depth;
 	u8 scrub_cycle;
-- 
2.43.0

