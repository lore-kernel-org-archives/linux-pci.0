Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958E50C2B9;
	Thu,  1 Oct 2026 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846600; cv=fail; b=K2QUKm1WpIoIY/b0AaTD5JQYOIKCvNyB/xyHtDTnVOdQRC7s6EbIZGkBb3DCnMlSHF/fggdIT2aOuCqFLoUWzPrNC5Ipk/YSOnmqbdhtQwnjuytzapl8RMCG2lnH6+SzFnljn1iESJUr3jLDE5gxe9PkZf8kFicEsp85ZYbTHM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846600; c=relaxed/simple;
	bh=y9/Lf7VcZJcHMOnL+NtQ3gzlefxtHL44mG69V/4ue3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sMNpfpLA/nNAC8mhrn5KkXqeTDoSRBoSHWCTIiEfaz5NyjB9z5pXXCPftUSeWbsZcJ/7oQOE+JJ1oKdJtNeOxNd+C3mygYFxqrWf8hV5VjrgYvUUZwJ+hniQDOmVxnSyh6+4x7MeX/i9LYHptE0qGYhaQYE+RxvVZGINkNQV4lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=krHGeSwx; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="krHGeSwx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9Qzr/yiGu1vX5XM86Z8Azc/fTzQtEwS7z73SSXu3kwRLhPpKOoIAsYwFwUQjTUEFJrXeQUtbqIcsW6TyW09Y6oleyOMafuqz2+mqNHQpbwmDUlX1ExQUWr8xx+B1Is9rTIZTDjfeWrwYd4eVUqXNvhJbH7QMhrag2I5qjknlPQB0xsN7S2XUCsEtr1O1vww3fUA7ZWEg1dl1e5sA58YB/PCICSgPNehncXZW2k5pQ6puSeEWivRsgiSmg8S92RRJwooy4FqQ/ryK95wcq4/IWHD2lM/FVN/Oi0L+t7/1kmCkzSqanRg22zYZ4j6xmK0alrGt4D1tkiL0umtVVF+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTstEm+rwpRQmIWPJmXj6kdzUu/tYSOWfip+iFawYQ0=;
 b=tXCtACxmFk8VUsTJaEDivar0/ckbh/pcbJ7r0AVQrQOqM073lzJDCvdf//tNnvKtiGh+WdHZ7+gxT12o/SQR1YKPECMc1c7q6qZA3C4aPHcLujGMZdmmwyI8zMKXDSkDMEvZL/oM6fkoVBFBWvvWiJSCmnPDK8tsSmu1RrASBVeqGvt+VaRJ8Mw8wwUlNLmSN4LxKMr+gcRWThyszWcDEXJozaBOajiFI4XKGeFNpOk5BjVVKN3fPKIZFbAtuKYeQIxB+MkUCwQKxXyCyAtg5lo2g+ukkdRg35nwqachC8g8AhjPwZ26YPkcfj1da8AePRZSZUukYFofWD+F9/PrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTstEm+rwpRQmIWPJmXj6kdzUu/tYSOWfip+iFawYQ0=;
 b=krHGeSwxsuqgYnW0ntt5WeaaH9lg0fkaFyFXOLfA2TRSL5V2VAIJt6PHUk+gs+4Q0gwzhWD0ObO/8/iFX1sXtontBjfK537BpztIE51WPAs+yCzeF0GpujAhWhi8nWUxZfWcMWgWDLW3XJosgHvLsCYY8+GjH07AeN33YNQH9TS/iX2+E9e1n9mKtwgJvC3p4vnc2jHuHdc40CQlf6VkRaLTV2ivB7kvHqylErkQZLZM6XfAnT/NBW8Aakz85xGIVL9SHFGrdQrEDPLIIpnptYADeeXidnsZP91R1+se0A5mVLIS7wwGLi/6OYP6Im5md7h6fWF9PRzEurVh6QQKIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:23:11 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:23:11 +0000
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
Subject: [PATCH v14 14/16] cxl: Restore CXL state after PCI reset
Date: Thu,  1 Oct 2026 09:22:25 +0000
Message-ID: <20261001092227.3004747-15-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0278.namprd04.prod.outlook.com
 (2603:10b6:303:89::13) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b3306d-cd42-4126-f243-08df1f9d9ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|6133799003|921020|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fmgVclR9tzY8tCuam8M/7BLQ65ZhLMsn/rxZHx5mRQSU7W7ddK1caYjSwjDzjdA8CiWHvy3LD+rzmYkXAW2yGkFc6IuCcBAddxJZknxMg5jrZG6UxJ0w8a/UYCFJb1S5lzPtbsnJSyCf3M7V0BF11wGrSL/30nNf78Di2innr4jHLrj42dq1Fz3UX5QIPUSzZPXh4M0Y6hW3NXgRUn3xf9q5es2A/tT015K+00SqFiYP+zff2BEpPCgODXF3+CLG9GppuVMRExjRv+YJScLCzsGJUg4fz6QT60MZl3YpkaOSgvSFgp/vJ4WHB9i7NBKjcShQRyS22atWhNXZHclPamtiDxZANkbAceyCTIUaf8fiHE9W77TmmjDgQr8cRw6m+iCK2f/QHf5kdpM9vJfToovmv8C/WZOEIckIX7mH8kf0sW/ksvxn0CBu528DCbRN+yHg0BuIjHJFX7ldHnTGL0q/dK5tHKnJVlplNNtE2Zle09AMuKv9xMSE4QslaKTBEr3Qm5J96/VEa5kWFVpJOJHZff8C6zx91mBh7sSlsCk5mwwslq+7lqDeZZmyzr1VEAUbWHSHIpbHeLN+RCBf/G/8l/ZF1y5/Sc+axLTZTmxFpeEOLJAZrCqszE1+gqw1x7XQEiAzQYr8E9LZXMtoksjmCW64wW4LIc8yOGJ2J/lu8M545AP4I0Xdb3aIXy0Tihp2qA1paz1TknpVxtqr9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(921020)(3023799007)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/KPrGagzF+/GlQxOtniiV8Fc5XcBTW9OJdvldlWmvGFFNFNBt4Z1pojp1TrI?=
 =?us-ascii?Q?JZrLquVnXV1DkGvnxeLRCxpw0eo5e0BKKNDFoA8p+p5hDPUIUmsl1131yFcW?=
 =?us-ascii?Q?y7kMVzMQGjfV+yhZc5p15SAXMTazESYNWB4jqQDtui5j9n5Z/M/O/vGUTEO3?=
 =?us-ascii?Q?UzcD2e4FwXHOasperOdWQCGAsuFmiD46T+ktexx0vrLmez6Bo9Ytb80pbdwT?=
 =?us-ascii?Q?+OC8aXqbcER9CI4wd17uQAcx+VkBn0MghJJbW3H4SzS6cFYVXePDFTuLU6jq?=
 =?us-ascii?Q?/GpT43x7Kku9WvUPbOMNKR6C8+FolnfIygUgK7BoasLRdsVefQfVmdvfa+hG?=
 =?us-ascii?Q?OD5Fiiuq3hr3K6axPsOxQB+AYIAFEqRPYZOECvs7D7EXNIw6+S3GUixJzGDd?=
 =?us-ascii?Q?5sqG4m38xf70vaTbwpeDaTuOvZBDidF+CmPaFc3/MG1fVid1UNHopVB/7ppz?=
 =?us-ascii?Q?FLD7+SidO3RSz2JoC1TE0YCIK42+u98ZQRonWrQnn6u3UCKXuMM/9JFQXH7w?=
 =?us-ascii?Q?qsKjPHDhZhL4p5gJUTI6qS/CF/jwCnTk00SzzJ/9lOsIDcNkCriP+BDCAz5L?=
 =?us-ascii?Q?FzyqIbp8uyjEMdA0OB68Ha/1X9e+EHJHCAFbCX6e8qcFl84cho1fcY0K4dIx?=
 =?us-ascii?Q?D1tlkBDmOgDD7Pp/23NvNKsJFkigU9r7xa02EKflcdsn8ZDReUYiynzLXNqk?=
 =?us-ascii?Q?DdnkhhyfFWo42kiYFocCzC8cB3TTnrm/BOi8XfOiz/GpJkTMePWBl8hJzZoW?=
 =?us-ascii?Q?qp/rQSiXaWaz2u3u4Mc85qH8KG+r3HtUW8L2inQ/vA4TZ0zeo/eH1cZcYff7?=
 =?us-ascii?Q?PNpeMetIPKkpapG+vxzqHVtv9EoVr5WUYXK5HqKsYd50RhFpwmt3kUTQ2BVO?=
 =?us-ascii?Q?QMbdlisyd2Ioch9FRh6ACtcn7v5c8A0+wGDHYmB+6fqH23vtiAMrcnsbKnTJ?=
 =?us-ascii?Q?ioiarxzSH4X0ZhTnT02BLY+r7fr0gBS2e8l4ccqBBXGssc3xBENdzQgGq2aQ?=
 =?us-ascii?Q?5yxtKacHP9V2oubV9avO+NoFXRSnNRCmel8YnMo1E0sn9PKGFEFDmInwbMTr?=
 =?us-ascii?Q?Y6X0sfCB37MYhbQClRaLDiQ8cEKFTw95SQa4jpUL/ZE1+/AdRHFxmsHOgyHJ?=
 =?us-ascii?Q?q52p0nuAGbA7CsXhtZ7+k8DUS5DQk+vUX/J+1sv5DyJIei61gZfZLSdGg7Qk?=
 =?us-ascii?Q?ok3D7ObOD1tV5jWR5ogF8KuuNcryYhZs5mDU6gVoIS0GdDXfJc4a8yyl+pym?=
 =?us-ascii?Q?hAWnzlsP3atBQ4Boycz6BGF/YQmypnt+ZVceL1J3h8pEThBK1QE1W+Mh977B?=
 =?us-ascii?Q?nLmvsk+CSVj1KDur44XeBTW3D5wrQMtc4vJ78Uz6OzN43mgtkFuaNfxJ+ddh?=
 =?us-ascii?Q?hkg2vEum7Pr3taabuLbG+fBnmiNQUiF7FvfrmzdUDcQM7l8wBbeBEpaGt5in?=
 =?us-ascii?Q?CTtNk3TFe9HO7VRnyf35sTxHf7A4WkHrWKSIrRk2H0cBxKZ4snmLxUK0LA5L?=
 =?us-ascii?Q?oI6b7tsoTycg4oV6oIfwUsBWsCqCyTATpAugKx6qNH7FGeBVszYfu89Dn2GD?=
 =?us-ascii?Q?G+NeckJt62RissSSxp5BRwQocZyprRevXNUM0EH9ShitQCgPzDDPuv8FHLAB?=
 =?us-ascii?Q?E5q9unigWIuY0TBk7M7sKOziC5AY4uxLLntLI4woFXrjCDvjrc4GD50o0bZN?=
 =?us-ascii?Q?eJNkFa42ceXMLd1kTyfEIGn/iCSXDo7iwyvxIgjHeKPdQcBG3PIwz6A6Gvqu?=
 =?us-ascii?Q?t3YhrnRqig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b3306d-cd42-4126-f243-08df1f9d9ca8
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:23:10.9234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrnSnLxJhiZv4rGzEdwARdpC0gNP2MZib7YKJzqyWcFl+E1n7eOuD4JMJ05nQLgIOTZtAoAfQpB2okIgN8kSCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

Restore the PCI configuration needed for HDM access, followed by cached
HDM decoder and CXL Device DVSEC state. Recommit a cleared locked decoder
before restoring its lock, but leave surviving locked state unchanged.

Stop at the first restoration failure and preserve a disabled PCI command
snapshot. Keep IOMMU exclusion active through restoration and post-reset
cache invalidation.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 418 +++++++++++++++++++++++++++++++++---
 1 file changed, 392 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 679a605da24c..0acc471d0d7e 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/memregion.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -83,6 +84,26 @@ int cxld_await_commit(void __iomem *hdm, int id)
 }
 EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
 
+static int cxld_await_uncommit(void __iomem *hdm, int id)
+{
+	u32 ctrl;
+	int i;
+
+	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
+			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+			return -EIO;
+		}
+		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
 static void setup_hw_decoder(void __iomem *hdm,
 			     struct cxl_decoder_settings *settings)
 {
@@ -448,6 +469,335 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 	kfree(info);
 }
 
+static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
+						 int bar,
+						 resource_size_t offset,
+						 resource_size_t size)
+{
+	struct resource *res;
+	resource_size_t hdm_start;
+	void __iomem *hdm;
+
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size)
+		return ERR_PTR(-EINVAL);
+
+	res = &pdev->resource[bar];
+	if (!pci_resource_len(pdev, bar) ||
+	    (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) ||
+	    resource_type(res) != IORESOURCE_MEM || !res->start || !res->end)
+		return ERR_PTR(-ENODEV);
+	if (offset > resource_size(res) || size > resource_size(res) - offset)
+		return ERR_PTR(-ENODEV);
+	if (check_add_overflow(res->start, offset, &hdm_start))
+		return ERR_PTR(-EOVERFLOW);
+
+	hdm = ioremap(hdm_start, size);
+	if (!hdm) {
+		pci_err(pdev, "failed to remap CXL HDM decoder registers\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return hdm;
+}
+
+static int cxl_hdm_decoder_uncommit(struct pci_dev *pdev, void __iomem *hdm,
+				    int id, bool *retained)
+{
+	u32 ctrl;
+	int rc;
+
+	*retained = false;
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return -EIO;
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR) {
+		pci_err(pdev, "CXL HDM decoder %d has commit error set\n", id);
+		return -EIO;
+	}
+
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
+		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+			*retained = true;
+			return 0;
+		}
+
+		pci_err(pdev, "CXL HDM decoder %d is locked and uncommitted\n",
+			id);
+		return -EIO;
+	}
+
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		return 0;
+
+	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	rc = cxld_await_uncommit(hdm, id);
+	if (rc)
+		pci_err(pdev, "CXL HDM decoder %d uncommit failed: %d\n", id,
+			rc);
+
+	return rc;
+}
+
+static bool cxl_hdm_decoder_settings_match(
+	const struct cxl_decoder_settings *saved,
+	const struct cxl_decoder_settings *active)
+{
+	const struct cxl_decoder_config *a = &saved->config;
+	const struct cxl_decoder_config *b = &active->config;
+
+	return a->id == b->id &&
+	       a->hpa_range.start == b->hpa_range.start &&
+	       a->hpa_range.end == b->hpa_range.end &&
+	       a->interleave_ways == b->interleave_ways &&
+	       a->interleave_granularity == b->interleave_granularity &&
+	       a->target_type == b->target_type &&
+	       (a->flags & CXL_DECODER_F_RESET_MASK) ==
+		(b->flags & CXL_DECODER_F_RESET_MASK) &&
+	       saved->target_or_skip_reg_val == active->target_or_skip_reg_val;
+}
+
+static int cxl_restore_hdm_decoder_commit(
+	void __iomem *hdm, struct cxl_decoder_settings *settings)
+{
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+
+	cxl_commit_start(hdm, settings);
+	return cxld_await_commit(hdm, settings->config.id);
+}
+
+static int cxl_restore_hdm_decoder(struct pci_dev *pdev, void __iomem *hdm,
+				   struct cxl_decoder_settings *settings)
+{
+	struct cxl_decoder_config *config = &settings->config;
+	bool retained;
+	u32 ctrl;
+	int rc;
+
+	rc = cxl_hdm_decoder_uncommit(pdev, hdm, config->id, &retained);
+	if (rc)
+		return rc;
+
+	if (retained) {
+		struct cxl_decoder_settings active;
+
+		rc = cxl_pci_hdm_read_decoder(pdev, &active, hdm,
+					      config->id);
+		if (rc)
+			return rc;
+		if (!cxl_hdm_decoder_settings_match(settings, &active)) {
+			pci_err(pdev,
+				"CXL HDM decoder %d retained unexpected locked state\n",
+				config->id);
+			return -EIO;
+		}
+		return 0;
+	}
+
+	if (!(config->flags & CXL_DECODER_F_ENABLE))
+		return 0;
+
+	rc = cxl_restore_hdm_decoder_commit(hdm, settings);
+	if (rc) {
+		pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
+			config->id, rc);
+		return rc;
+	}
+
+	if (!(config->flags & CXL_DECODER_F_LOCK))
+		return 0;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return -EIO;
+	ctrl |= CXL_HDM_DECODER0_CTRL_LOCK;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+	if (PCI_POSSIBLE_ERROR(ctrl) ||
+	    !(ctrl & CXL_HDM_DECODER0_CTRL_LOCK)) {
+		pci_err(pdev, "CXL HDM decoder %d failed to restore lock\n",
+			config->id);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int cxl_snapshot_hdm(struct pci_dev *pdev,
+			    struct cxl_hdm_info **snapshot)
+{
+	struct cxl_hdm_info *info;
+	size_t size;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (!info)
+		return -ENXIO;
+	if (info->decoder_count <= 0)
+		return -EINVAL;
+
+	size = struct_size(info, settings, info->decoder_count);
+	if (size == SIZE_MAX)
+		return -EOVERFLOW;
+	*snapshot = kmemdup(info, size, GFP_KERNEL);
+	if (!*snapshot)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void cxl_restore_pci_state_for_hdm_restore(struct pci_dev *pdev,
+						  u16 *command)
+{
+	u32 saved_config = pdev->saved_config_space[PCI_COMMAND / 4];
+	u32 restore_config;
+
+	device_lock_assert(&pdev->dev);
+	*command = saved_config & 0xffff;
+
+	/*
+	 * pci_restore_state() is the available interface for restoring BARs and
+	 * related PCI state needed to reach HDM MMIO. Temporarily alter its saved
+	 * command value so that it enables MSE but cannot enable BME or INTx
+	 * before CXL state restoration completes. Preserve the original saved
+	 * value for the outer PCI reset path.
+	 */
+	restore_config = saved_config | PCI_COMMAND_MEMORY |
+			 PCI_COMMAND_INTX_DISABLE;
+	restore_config &= ~PCI_COMMAND_MASTER;
+
+	pdev->saved_config_space[PCI_COMMAND / 4] = restore_config;
+	pci_restore_state(pdev);
+	pdev->saved_config_space[PCI_COMMAND / 4] = saved_config;
+}
+
+static int cxl_restore_dvsec_ctrl(struct pci_dev *pdev, u16 saved_ctrl)
+{
+	int dvsec;
+	int rc;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENOTTY;
+
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
+				   saved_ctrl);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
+static int cxl_restore_hdm_state(struct pci_dev *pdev, void __iomem *hdm,
+				 struct cxl_hdm_info *snapshot)
+{
+	int count;
+	int rc;
+
+	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (count != snapshot->decoder_count) {
+		pci_err(pdev, "CXL HDM decoder count changed from %d to %d\n",
+			snapshot->decoder_count, count);
+		return -ENXIO;
+	}
+
+	/* Restore global HDM control before committing individual decoders. */
+	writel(snapshot->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	for (int i = 0; i < snapshot->decoder_count; i++) {
+		rc = cxl_restore_hdm_decoder(pdev, hdm,
+					     &snapshot->settings[i]);
+		if (rc)
+			return rc;
+	}
+
+	/* Flush posted HDM writes before restoring protocol enables. */
+	readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	return 0;
+}
+
+static int cxl_restore_state(struct pci_dev *pdev,
+			     struct cxl_hdm_info *snapshot)
+{
+	void __iomem *hdm;
+	int rc;
+
+	hdm = cxl_pci_hdm_ioremap_current(pdev, snapshot->hdm_bar,
+					  snapshot->hdm_offset,
+					  snapshot->hdm_size);
+	if (IS_ERR(hdm)) {
+		pci_err(pdev, "failed to map CXL HDM state for restore: %ld\n",
+			PTR_ERR(hdm));
+		return PTR_ERR(hdm);
+	}
+
+	rc = cxl_restore_hdm_state(pdev, hdm, snapshot);
+	iounmap(hdm);
+	if (rc)
+		return rc;
+
+	if (!snapshot->dvsec_ctrl_valid) {
+		pci_err(pdev, "CXL DVSEC control snapshot is invalid\n");
+		return -ENXIO;
+	}
+	rc = cxl_restore_dvsec_ctrl(pdev, snapshot->dvsec_ctrl);
+	if (rc)
+		pci_err(pdev, "failed to restore CXL DVSEC control: %d\n", rc);
+
+	return rc;
+}
+
+static void cxl_reset_save_disabled_state(struct pci_dev *pdev)
+{
+	u32 *saved_command = &pdev->saved_config_space[PCI_COMMAND / 4];
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+	if (rc)
+		pci_err(pdev,
+			"failed to disable device after CXL reset failure: %d\n",
+			pcibios_err_to_errno(rc));
+
+	/* Preserve the pre-reset snapshot if PCI state has not been restored. */
+	if (!pdev->state_saved) {
+		rc = pci_save_state(pdev);
+		if (rc)
+			pci_err(pdev,
+				"failed to save disabled state after CXL reset failure: %d\n",
+				rc);
+	}
+
+	/* Ensure the outer PCI restore cannot re-enable MSE or BME. */
+	*saved_command &= GENMASK(31, 16);
+	*saved_command |= PCI_COMMAND_INTX_DISABLE;
+}
+
+static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
+{
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		pci_err(pdev, "failed to restore PCI command state: %d\n", rc);
+		cxl_reset_save_disabled_state(pdev);
+		return rc;
+	}
+
+	rc = pci_save_state(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to save restored state after CXL reset: %d\n",
+			rc);
+		cxl_reset_save_disabled_state(pdev);
+	}
+
+	return rc;
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
@@ -814,7 +1164,9 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
 }
 
 static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
-			      struct cxl_hdm_range_context *range_ctx)
+			      struct cxl_hdm_info *snapshot,
+			      struct cxl_hdm_range_context *range_ctx,
+			      u16 *command)
 {
 	int rc, rc2;
 
@@ -839,42 +1191,69 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
 		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
 	rc = rc ?: rc2;
 
+	if (!rc) {
+		cxl_restore_pci_state_for_hdm_restore(pdev, command);
+		rc = cxl_restore_state(pdev, snapshot);
+	}
+
 	/* Evict lines fetched during reset before ending DMA exclusion. */
 	rc2 = cxl_hdm_ranges_invalidate(range_ctx);
 	rc = rc ?: rc2;
+	if (rc)
+		cxl_reset_save_disabled_state(pdev);
 
 	pci_dev_reset_iommu_done(pdev);
 	return rc;
 }
 
-static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
-			     struct cxl_hdm_range_context *range_ctx)
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 {
-	u16 saved_ctrl2;
+	struct cxl_hdm_info *snapshot = NULL;
+	struct cxl_hdm_range_context range_ctx;
+	u16 command, saved_ctrl2;
 	int rc, rc2;
 
+	guard(rwsem_write)(&cxl_rwsem.region);
 	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
 	if (rc)
-		rc = pcibios_err_to_errno(rc);
-	else if (PCI_POSSIBLE_ERROR(saved_ctrl2))
-		rc = -ENODEV;
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
+		return -ENODEV;
+
+	INIT_LIST_HEAD(&range_ctx.ranges);
+
+	rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
+	if (rc) {
+		cxl_hdm_range_context_destroy(&range_ctx);
+		return rc;
+	}
+
+	rc = cxl_snapshot_hdm(pdev, &snapshot);
 	if (rc) {
-		cxl_hdm_range_context_destroy(range_ctx);
+		cxl_hdm_range_context_destroy(&range_ctx);
 		return rc;
 	}
 
 	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
 	if (!rc)
-		rc = __cxl_reset_execute(pdev, dvsec, cap, range_ctx);
+		rc = __cxl_reset_execute(pdev, dvsec, cap, snapshot, &range_ctx,
+					 &command);
 	/* Restore cache policy after any attempt to disable caching. */
 	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
-	cxl_hdm_range_context_destroy(range_ctx);
-	return rc ?: rc2;
+	kfree(snapshot);
+	cxl_hdm_range_context_destroy(&range_ctx);
+	if (rc)
+		return rc;
+	if (rc2) {
+		cxl_reset_save_disabled_state(pdev);
+		return rc2;
+	}
+
+	return cxl_reset_save_restored_state(pdev, command);
 }
 
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
-	struct cxl_hdm_range_context range_ctx;
 	int dvsec, rc;
 	u16 cap, ctrl;
 
@@ -917,18 +1296,5 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (!cpu_cache_has_invalidate_memregion())
 		return -ENOTTY;
 
-	INIT_LIST_HEAD(&range_ctx.ranges);
-
-	scoped_guard(rwsem_write, &cxl_rwsem.region) {
-		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
-		if (rc) {
-			cxl_hdm_range_context_destroy(&range_ctx);
-			return rc;
-		}
-
-		/* cxl_reset_execute() releases the ranges on success and failure. */
-		rc = cxl_reset_execute(pdev, dvsec, cap, &range_ctx);
-	}
-
-	return rc;
+	return cxl_reset_execute(pdev, dvsec, cap);
 }
-- 
2.43.0

