Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7646D36A008;
	Mon, 27 Apr 2026 05:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269280; cv=fail; b=XMBD2Ep9fFXzVq/5n5fq0Jd8gd8uP6ef0u6NbyLxH9v+b2zxATHX8o9D4sMQofCgAV3SWjlc+iOPNcfkUc8PCjCl2wk0Q3Q1v/9xb0uQmYNkMkfREncnzMkCqtj8ou5H4L9bgZZnjHnzsrJ507nn1MyYNd0Pz/TgekrhmssXDHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269280; c=relaxed/simple;
	bh=UzaSE27LExoEPw9M62VyqT5b0TJu7rOIY1HDKIuyIzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8bfP2vXFsq7UAxidVO+6vrt8p0ZNXDNFxxtG828SLq59Lui1ORxGxusKb56UCSFtbIEUbNEe3Ij/ekzqD2w1gLfrif9MQ7f1OZJ5ZtI2qVd17Vzy/OW1KWu3JnCfNyy6O4Pfc5lLb4HXP0ClsmxIng3Y4SZtPNWAJuminUzZjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A2oqmxFw; arc=fail smtp.client-ip=52.101.53.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A2oqmxFw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLKF4cVPLs/8WA/ZpBKOcfKsme7pgu0+zNrspkDBINPcULQdvNbhxLhmZgrxrJf38UQ6V+fevEmoy4xM9Bl+fLImRSicNF84rlWw85T62hZn/qHXOWQlUpZOfd8A6cF7DYGvgyIqDLd9qarUlFWkCJShyuvlu0Nr/vXlM41mM2DeJtk5u5BAx2NXEyflPCK7h3uVFa0usCxMfkG2+6/JKrZNDe5OoPArS3R5xDjcyEHkZJJ0vkSuE/bLciGrEA5++YS+LS2nd/kVc1r6b/FzjAlxvSK7Bs+7/NcDkfYTIuVgq0Ob7gV11ZGr5fNs/WXQqXUUCjfW2R40Q30ttxRa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kuQu/tt033gD91X+KhdEYlJEPfNSZRb9jgaxw44Z94=;
 b=KZTDTZQqsG3IDZgT6QsJd0j2wimzvWwE3SHwASCH6bv/5if87M/pty6+BTXrQ+Y3ZessxRPBn/8OmpEU3fIP0xulZ66A0irl8kXOkeiO3k6JMi44rCwlqv4xINShOKc5meofgQA+gdIs86RG9Y+2PVgVHKLU+bMDacmMh1WGGedNMQyb35QjQGAzVec3YLWp5kbYQ1xpn0SI5saKkK639U88QxgLK4/FY/1rZzWz7r74i8sUO+doY7p8nmfIs3wXp2FY7Oct1PTZBTs8G3g4v/S51m9Foa7hSREVMhjfo7LL92RNmuzeDoOI1Dp58kw42OUtW4EsOOjiSn8XtrLiJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kuQu/tt033gD91X+KhdEYlJEPfNSZRb9jgaxw44Z94=;
 b=A2oqmxFwzOQ5yrT4ghre4jZ0x1PKVaBLRk7seUKttw5r/EZCm064yTquZPttLeNiiCYZxm+X3irbSr8hwNoaigVxjm1jOZiWdSM5eJ8EvbV8hwGabB76dwI7u3506rNWa0jn6eaeeoWct5s70W/v4OemUqvZGOfBf/a5iWxA0aLf6eipzsD8sNJbVQeLDA6fYy2fjPuTIANwdS9PTCEM1AU2Re4ThsOvFfler1NviHbjt+sg39YGDqTrM91oMdSmBHcCdQYOySP5EvbK5fq5MnnN5pp96ynOHR25vt284CAMTYIOgTyD7Mhq7mc12JwYf2Gq3MekZVDI3l7n1IidPw==
Received: from CY5PR22CA0018.namprd22.prod.outlook.com (2603:10b6:930:16::30)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 05:54:31 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::d4) by CY5PR22CA0018.outlook.office365.com
 (2603:10b6:930:16::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 05:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 05:54:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 22:54:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 26 Apr 2026 22:54:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 26 Apr 2026 22:54:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache capable devices
Date: Sun, 26 Apr 2026 22:54:00 -0700
Message-ID: <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777269009.git.nicolinc@nvidia.com>
References: <cover.1777269009.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d4a61f-6617-45f6-adcd-08dea4217359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	15lFeq2Ea+IMJWLXoTo0RqiZywHftBsfN7oV312QnMSidbgUeVGvH/A2fYeyDMaUkjNgGjwh8zBMjD2guOHlFin2WcngGcFPeX1oXFnus47dpLVb3Tki4ns8VR+T8QIvYrHcMYoBU/F4mNMr+6EAHdwMD6OR7QSjl8ZEKeo9nhdMYvoyWf4JEt+Kf0o4GT4nNzO8gcBSULF3x1PPvtw1mn2sqY0FmNC0clm/pVNR851msRfEOvXyOaNwy/0luJhQlpVJBatcUwUOyCYcRlRUqyg8GILvJelTlwGcZimpO9DqMaun9F+3pnVxpcF9FxnC31Ya9EfQjawmBSMh2s6caTgSnqk93xL6i2uKcT1LLHpOHGzAa+V1sSA46V+nyN0lhxrceSTunG20dDy7ApZhvxq0QcD6I2WZY7IwfKr+VJXlxVT4HCcYE9oaldDh4Ez9Cz/2HPPRNnT42PQ20unAGy1cdYZ2kfuMYUbHc7NdJ9jsoIJDgh7KLU3UpLc+JQbSHBUUp6o5VnpP8FRHiesvzDB7OUPoMULbhZd+uY8mRSleu02fuELYQPdlp78FfiFBZ2/NAhut0kzWz0sGikKLJU8MWoYxR10JACY+2kjLEucFDRYLIYOZEkH7YlQhC0qCYCUTrZGvvsML2x15UAXwHDlvKo7X0EN20oHSje3K6YET9JkzVuNc7nnFRv7AIybG0++zCXZO6NZHuKzbiKnQSzf+KO8UfYUp6jK6m2x3llZiqMvnJkmWj12qMHQK9bgVun1d/RiG/FcEQRhU8FIGbw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	seVfNbcnwrkSFIDUCqBZfuZqECxAjN9aCMN1w+GM9RXLySn/OCuR7WDcnYQC1tjdFUUGzG69Q5jYzth65M4etFr0nSmbgaCRwkKlEBLuFXi7ZsMBdidJKpw6bqAVpBC/pTgCkNWgQnnljEkfM6HhB7rzxV3VZC8oRjXLodHsQUzZ0ffo495qC6KZYwQINRJ1SPQodbNKDKwe+SCRHGNkVPFQ+7yLo8PXemp/GpW7piOglRnREHQpIlDO5Os3U1gnDUKMaKd/mPm4ul4C+qQ5QBRQSXYvif1UQAAdN89Z9iOKhU9sHro18KPNysZ8YK9yccbfkKeRJkmkj02EmQwWHW5+o6Qhs20ox865jLtYJ3T6kL/p72XND5j1Wne/L1Rl6fg6tw0J/cLUFb/Mj4/VAi6GXVFt+ebIyinqhB51Cwl47ZxesJZ6SIcd8iOWbzsx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 05:54:30.8024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d4a61f-6617-45f6-adcd-08dea4217359
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217

Controlled by the IOMMU driver, ATS is usually enabled "on demand" when a
given PASID on a device is attached to an I/O page table. This is working
even when a device has no translation on its RID (i.e., the RID is IOMMU
bypassed).

However, certain PCIe devices require non-PASID ATS on their RID even when
the RID is IOMMU bypassed. Call this "always on".

For example, CXL spec r4.0 notes in sec 3.2.5.13 Memory Type on CXL.cache:
 "To source requests on CXL.cache, devices need to get the Host Physical
  Address (HPA) from the Host by means of an ATS request on CXL.io."

In other words, the CXL.cache capability requires ATS; otherwise, it can't
access host physical memory.

Introduce a new pci_ats_always_on() helper for the IOMMU driver to scan a
PCI device and shift ATS policies between "on demand" and "always on".

Add the support for CXL.cache devices first. Pre-CXL devices will be added
in quirks.c file.

Note that pci_ats_always_on() validates against pci_ats_supported(), so we
ensure that untrusted devices (e.g. external ports) will not be always on.
This maintains the existing ATS security policy regarding potential side-
channel attacks via ATS.

Cc: linux-cxl@vger.kernel.org
Suggested-by: Vikram Sethi <vsethi@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
Acked-by: Nirmoy Das <nirmoyd@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/pci-ats.h       |  3 +++
 include/uapi/linux/pci_regs.h |  1 +
 drivers/pci/ats.c             | 43 +++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 75c6c86cf09dc..d14ba727d38b3 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -12,6 +12,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
 int pci_ats_page_aligned(struct pci_dev *dev);
+bool pci_ats_always_on(struct pci_dev *dev);
 #else /* CONFIG_PCI_ATS */
 static inline bool pci_ats_supported(struct pci_dev *d)
 { return false; }
@@ -24,6 +25,8 @@ static inline int pci_ats_queue_depth(struct pci_dev *d)
 { return -ENODEV; }
 static inline int pci_ats_page_aligned(struct pci_dev *dev)
 { return 0; }
+static inline bool pci_ats_always_on(struct pci_dev *dev)
+{ return false; }
 #endif /* CONFIG_PCI_ATS */
 
 #ifdef CONFIG_PCI_PRI
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350d..6ac45be1008b8 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1349,6 +1349,7 @@
 /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
 #define PCI_DVSEC_CXL_DEVICE				0
 #define  PCI_DVSEC_CXL_CAP				0xA
+#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
 #define  PCI_DVSEC_CXL_CTRL				0xC
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9c..fc871858b65bc 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -205,6 +205,49 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
 	return 0;
 }
 
+/*
+ * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source requests on
+ * CXL.cache, devices need to get the Host Physical Address (HPA) from the Host
+ * by means of an ATS request on CXL.io.
+ *
+ * In other words, CXL.cache devices cannot access host physical memory without
+ * ATS.
+ */
+static bool pci_cxl_ats_always_on(struct pci_dev *pdev)
+{
+	int offset;
+	u16 cap;
+
+	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					   PCI_DVSEC_CXL_DEVICE);
+	if (!offset)
+		return false;
+
+	if (pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap))
+		return false;
+
+	return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;
+}
+
+/**
+ * pci_ats_always_on - Whether the PCI device requires ATS to be always enabled
+ * @pdev: the PCI device
+ *
+ * Returns true, if the PCI device requires ATS for basic functional operation.
+ */
+bool pci_ats_always_on(struct pci_dev *pdev)
+{
+	if (pci_ats_disabled() || !pci_ats_supported(pdev))
+		return false;
+
+	/* A VF inherits its PF's requirement for ATS function */
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
+	return pci_cxl_ats_always_on(pdev);
+}
+EXPORT_SYMBOL_GPL(pci_ats_always_on);
+
 #ifdef CONFIG_PCI_PRI
 void pci_pri_init(struct pci_dev *pdev)
 {
-- 
2.43.0

