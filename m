Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FCE3DA5BC;
	Fri,  6 Mar 2026 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840518; cv=fail; b=B8pJwQso4vHAZzIStcmiaU+zroXbmrGQcqZsoP9nXS55p+KPYPdla9rBggL31RIhiyfzdvmVQe3cnqt6sD/C6B6jdDm1Z5tLSyQT77vQq8ysaUvesAL4nNB23BPqphCoJ/lf4KlHOqFbnYAPiJeVnI7FtH7tmwfnNqIkn6+sUzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840518; c=relaxed/simple;
	bh=ULOMVU1gz38YoPpJx15ZAXEBs7MCz9wjeWhkagB+W1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mb/GsFbnxwRVr2inutIrmN+IWhyBY2KPdB4AHwfeWqiTOpN5l17HlHUm1nIQkhdrzxD2k7raykCqyhl8HfoyDMeL/aB82zqLmFp+EE9QPSwvsRhuHrkow0sAOVAGSXVA2UIoS7fg1wYspHCj6//GgSiImcRwjnqQybaOmjmTNqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uZJUWnAi; arc=fail smtp.client-ip=40.107.200.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uZJUWnAi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ow/tiBcNR4sKb4xL2KgMW19TA7GPVTVE816zekwgEAhN/NbOEkt8gWT1f95qh6wtz5hTCF00DAtU0E+NLwfGb3mTLz037zbRrWYlN/22NT7UhOoWdX4McKLMCTgmgmU5uTnHEdYZ8Fvy3zL3LhjWzunGtk7pZy0MIV1Qqn77aoN1uHCPF/1qqMr8S58Sk0doGTnmU+XucxYiqMj4ARBpAFHs6gOA5UEXKcxZsGUyEBCHz454pAqCktqYP9rexi82RRqH6xNbaJlU694v3hiLF4MpcKDxX1GJ2aP+wAlUYjXQy19P0Yb2I5FIPYlhLfw0L2ftTaxrxDmYQ6k4mrUWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHpaw0mfq2Kwi/TO3ExjTH7BS2cxSJWRx/q/NlTbNss=;
 b=BQLkJof8aKrbtDKyetp6yypSjZVdl5xmwSBDtp8m6l7yfq0OzWshJZ1tAzfwfa+q2JanxcKSvVsAVsykFoEwTJObIT1idSgMeKZCuFv9pg4wC/+5c+7Oi4d0gDTQKIebNkEs3RqxAnYIvhWcZPIvmVli5IBQFUlMwfk6GBVqAxIC1ZRzJydCUs6zFa2JwXDITj87dQfGCtla3tKOd3nQsqqW7JwPhMqeZWiFcOi8yXbWbjgTeL8C7P+mvLuMxtTgI+yWuIpkn61jr8pbSRfzJ9E5qQApv1G+NhAwl19pIIPznmB389UsXCz7C3XwlKHZcLKr5jsCP5mOsc0MUuB4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHpaw0mfq2Kwi/TO3ExjTH7BS2cxSJWRx/q/NlTbNss=;
 b=uZJUWnAikRvBoSPOo2JfHzJ8k+dsGMch4t3ceCmlHqkf1Sy0obzv2GMye55HG/rrTEsgojqvo3CC2bkQVeoq5SvNCWH594cdGux+z+L8LcGIo8EbVXXJyQrqdoBtyWMNW+h0x2B2ONYuGIUDnUg/+hXZSLijEu1kXQ/8BkxPWqlu52aCYunJqnI59TpHzodrZWoWH6Q/xCxCQ/9tEOEZwNyWcIArFpxFd4v+HW+89SdL9xiwBgKhfwusyDYm7p49eCmpkIkuoDz/Y5TfDCXNbWzB2dvp7PA0kwwiwBN+EdhdB/bCwqpvqHPgv9EMQMprlSstvIYndhaQ8SFGmcoj2w==
Received: from SJ0PR03CA0069.namprd03.prod.outlook.com (2603:10b6:a03:331::14)
 by DS0PR12MB9728.namprd12.prod.outlook.com (2603:10b6:8:226::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 23:41:47 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::83) by SJ0PR03CA0069.outlook.office365.com
 (2603:10b6:a03:331::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Fri,
 6 Mar 2026 23:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 23:41:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 15:41:33 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 15:41:32 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Mar 2026 15:41:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache capable devices
Date: Fri, 6 Mar 2026 15:41:15 -0800
Message-ID: <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772833963.git.nicolinc@nvidia.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DS0PR12MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d644958-37c0-4d5f-cf0c-08de7bd9edf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	J/OwBRnzi48RrPRakbzjCvt+clCJ5E2MljBGLeCz5EkmnCrENt0C3oZi5L7LmAa1rIqc6YYJT1Q5Us3B8z5PNpH6QIH9gYR44ZEavQgZg1HKB/t0aYoN3bLjuqGGJdYRXx1dKqltwI42nPhdmek56+R+20YkOcwsDSx33FnmsHTOuYzL7ljCvZjdKyW3i7eIlEGvYbBwnVuiwv5v6KH1gyE4zErHuwToBr3MPR2qTZMGt49knjc6E91aOPr2tNXNNTMIMkQtCD4IVK/18ujbpUVGAc7uG19xWwIFs2NLHBItsDsOKE0lbyZnZaSCIsqWwtWV0t7ZgF8qPzD+QSBkNX9q8RbkZNAjc5vBRZUnq3W74X4hOr4el+Q0ivbp1w7BloPt8TeWl2/UNoDf8oadu512+KcLC737l/4Vy/yqYkIhoZEHx4wnaAzWMLNp8fwDyBGI+N6ckrs9RJsEslhYC7umwxFL+kXESb7w06SJqplJhOdwa3278GI5BjiML8HSbxl0tE1TjcA+c+n4/Joso1xfFuOmInLXL5iHBcbLI55fqjkzoPICUObQ5G/GnGuSdfRtUI60bJlc3OPF3s+WDjLwu5/ZWqMKIyhDA375QveP2+7DUh860e027t8tPLG4Rj7W7ro8JkVSDJSMSgEiumV9mRWwWhQYTpgRWElRwDB3/OdwO69/FnW8t+AYd6z5HT4XaNmK1HLFDs2n0MJ8fYHYzHdf+NC9Tqw31QQKBvYSVB9/zuij29ErTDoM06Gn/retNl5U74hiwEZyeRsCIw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hBbW8e6Se1lLQH5wsmrPHs9OzbPTGcJrP+qDNzOHwK3xC0qXGePRr1JigKUeUqUaMyod/9YwL6c4nTRMkbjgFc3X+0Ega/YfEZeWxZhktSTfcy2RTbrClfp9eN+kXyOa92PqgMI6tJxvIWJSx+Ou9V8E4irTlT+uqKYLw5MWT6gtOqC0jtBkZuoDNMIqr4uTVIxS13ThKoDYUNshiMOCqWSksldmnX0laSBw+2GsKqtQqSMMHYr6cwV+lQ1PYpmCGafB2f9irCvnGt2L6Vr8EHf12zmFKTaucixUP/a/bi/ZJbIJcLiqdHqS4s4J4H6X5nnOtbqlOX2hCzgv5tscpLkBYFYvBEwKHIf55y40w5F3e+b7/Ux1iIOEd07Ep0/gmXrq1medxvIcGfJMsiJD8MoF6KV1BOPby37GAxZohARChlH36L3ODvkaKzzE8Wa5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 23:41:46.3372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d644958-37c0-4d5f-cf0c-08de7bd9edf6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9728

Controlled by the IOMMU driver, ATS is usually enabled "on demand" when a
device requests a translation service from its associated IOMMU HW running
on the channel of a given PASID. This is working even when a device has no
translation on its RID (i.e., the RID is IOMMU bypassed).

However, certain PCIe devices require non-PASID ATS on their RID even when
the RID is IOMMU bypassed. Call this "always on".

For instance, the CXL spec notes in "3.2.5.13 Memory Type on CXL.cache":
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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/pci-ats.h       |  3 +++
 include/uapi/linux/pci_regs.h |  1 +
 drivers/pci/ats.c             | 42 +++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

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
index ec6c8dbdc5e9c..cf262eb6e6890 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -205,6 +205,48 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
 	return 0;
 }
 
+/*
+ * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source requests on
+ * CXL.cache, devices need to get the Host Physical Address (HPA) from the Host
+ * by means of an ATS request on CXL.io.
+ *
+ * In other world, CXL.cache devices cannot access host physical memory without
+ * ATS.
+ */
+static bool pci_cxl_ats_always_on(struct pci_dev *pdev)
+{
+	u16 cap = 0;
+	int offset;
+
+	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					   PCI_DVSEC_CXL_DEVICE);
+	if (!offset)
+		return false;
+
+	pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap);
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

