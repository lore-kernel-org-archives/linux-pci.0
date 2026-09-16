Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4ED4D956C;
	Wed, 16 Sep 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583863; cv=fail; b=EvzI2Rf0DTlEwGriu3IWucUHghUTH1kRGzrDRVX+VMPJu3zy67Y48QE/EQYFqDQMwmeVlYXLghiwxM7mAR+GAGUb25wQd5NXm9sFR0T9DV/H7eLZTTipUCTQ4vDWl7bVIvxqy4MDErqdA2cldlKHZ0Z2R+w4knEGeaZLhownVUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583863; c=relaxed/simple;
	bh=QeZ1Y4HfZ07E2IfbQLP/DHuyXWUmoMuhBfwTvJ5yFhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTPM2A20+O7Otez+ngBJ0l6GagAIe6FD4VSHGrsMzUlIf/p/bz2D5MExbWFmF5w7EW6K+lKHmBW4CMTLa9J62VKvU/lj6AaXm8tkeHYtFDg+NpuMLmENU6mwi5L1LvyfyISQlOnkQUsySvfjPz8QTyEivIEhl7bRkXuesiV5XWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YgjbEpKg; arc=fail smtp.client-ip=52.101.57.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YgjbEpKg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMabpkGLfT8lux8mHrSpONg5hasW7WTRZhzJGMGnA19GIQDIY3cpCZjPYKmRaiN8vMM7m0aeEvFnr6wDBypOH1JQE//kFQCQM9LfkZQHs0lTXE/8eYmIjHkZ9d+MWWRKzg6RshRvJ+xNNvxlei0kh5v/1HaDty5FpD6vFbu4k+pA6LAswuZOp9Uc1/ruaAN6YXAywS0HzuYgbZvdZnhW2/lctdHc1G0GfYcLZZIhL/NStchnC8roRu6qU6R5o4o44NEQOIspSIilTu4x56geLJNKTGiSqmz9SBn+y/oVyDdUwjeJSbGrDH0r346E6zp8Dkczazb7xbjfHRR6/RIC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpRf7i0jmtsZ5Lk58BLEG6flQUee8EBvMkn8Jo2GUuc=;
 b=HnWgZfBVdocXcTU4GhaebVOoVIF3TmztmRvzseA0d8FJ1nyBbHV8m5nmLMSgzIeVyazciPZ45ZeIxiWYTMhmc5uncppbZ3upbFRvtXrlTWKzO6x/fvf1BLWV4hPrrgceQVY7GhmN0LYnF33joaRtmVPNfn2n3zPdH9c6C4nM3d0PqnzEoPKWrdty3qPuae1SfVOlRb3q8ZSaXSGnDy7130lu0k6BmOuroJ25Uw4bFmvyD/agxjPqtTwtACg2VGtiQa6/G4Gs2jZQwug1m0mj6u6XHhuls5W/91bKwur+YpUT1b56HSn0m5tAoyNZH9zpLLgGZMjPnoqZ5pPsGDiGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpRf7i0jmtsZ5Lk58BLEG6flQUee8EBvMkn8Jo2GUuc=;
 b=YgjbEpKgJ24eNZLZmmbQ9Mjn2W95xdvvzopUfTw5780CM1OGNAk+saQgNQQ5BzJOvebRjXmptyQUJcAqHrCZsvmCk2QLUrGftGJlpLVn6cmueSxmD1BUMqAmvueAHcTL2YsHkiRVDIGCxMAYAfesjC1UNxogygCyeTeu5o2vslBpnTpE97fQuJtq1RsxcmAZkH0akO3bLg6V9aBXJ3Oav86+Zl7g6BvKqabwrJlVhGxlAEjhJl7//9kmrVwOpkGBW60eUQnDgWM6X7Vm8UQ54UfWI4UQ3s8uvfq+DA4ACYQO2+QUizdtyT28bMiZ+Vxvo4n0FjnubA88pPzXNqmvsQ==
Received: from BL1PR13CA0238.namprd13.prod.outlook.com (2603:10b6:208:2bf::33)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:37:12 +0000
Received: from LV8PEPF0000006B.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::97) by BL1PR13CA0238.outlook.office365.com
 (2603:10b6:208:2bf::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Wed, 16
 Sep 2026 18:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 LV8PEPF0000006B.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:37:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:36:44 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:36:35 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v5 04/27] cxl: Add cxl_reset_dvsec_sequence() for vfio-pci
Date: Thu, 17 Sep 2026 00:05:17 +0530
Message-ID: <20260916183540.3813685-5-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006B:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e96fd61-9e46-4ac6-3588-08df1421861e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|22082099003|18002099003|921020|10067099003|56012099006|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Io5JZaZwR1EnGxtqw+q4HC6xQxuF/fiEbT71pSMPMmNc6xi19IdKjpxxbOgLiVrw5k4+Rf5t0fZbTIboRp6tZuWBy3skKnifglOkCYlmSejucKnYLzi/ucO8OASWn45fmvqF8d7wrCAwgXYfpWzHcG1RIPKEixIfUOVVP+h385lvfkb9+ZiqclmbDMd1APMcit5i5y0K9qY3eIC7ehbZy+hxkJ0oghXOsTISgT41BvatA7Wgh+Kx58bO2It9w3c529HtstTILU3xVQBRizc+wGY3rcXN+RTey4ibRuGwDc4TnaiGEMn6l85NE/ZDuSmDY5GwKOPDyc3qhBdT8I0z9hDY1TB20zu1AzkdW5fuZRRXDlQV0tecji/0Lr2pUybBSxiAvfe5uiS/32KmpBxbhKRRwn29X+gVp9Z59EoyI9QuaVWFNn3F+sVpXAcno+P0/+Hw+/16M9edaxj9kxhZyHGVsN/XP2/wfaAl0SFHl/HOHeduXL/LilexR+jwnynLpwhhp4Bsr4rczVIAyT0Y1G0EIymjJGaj6ix0rDKUEfslffXhd1sNtqinwTBS3MK0jFSYir0numd12bofi94FJbOKQO9sHHnXFxiz8FsV4BHn6Di4jKuTA7ypqCkVRyt5aXmUNfbr36zuWQLYHFYvsq4YxkzTYYtSZ79/kj6VtGZKHAsiJtoIozncYK/EnknQ1h1P6+LyB+vlqu3F0cKxHuGR90Y/MBGKW3WnbPVSmwy9JdDN+7EnQqxIeIw3TEbs
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+t1sYfLkbPTBBEjJtGB5kdBd0uMuUl8krgn+I8OPJsFB73gsDQBum8bWT2bBusFQiV1dV2i0njBKTwkJ/4DQ3KAboOvdnkW/oAcEh9u+vbnB+BSGwvryDIM8jrllo3qH0eaC5p5/jOWdFvN7pgzv08e+tfggCfMGqRohbY/j4FKMDXokubKpQJzMVKiJZrM07TDn9TB+4Vph/1Vs4GsJY2p1Fg4GvzaflBxofxXYHU3lZ94QkFTArT0H/yNBjBtaINutv+SGC8EzOedOhDh3bhglLpRQSt0NmnSp/S40KbBd4zbjzT7+g501dmzJ6fIW1h/+1BBMfMB4lKkSgs9d9u/z1BBLyKSUOiSAyD13b6HhysDAzY1TEbJl9MvxLwbJm/Xe22HwikMInU2Z1F1GBtQsaCHokNOINtsBMv0Yyz3+dGWZRHxCcNFrKhwPvvVL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:37:12.4632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e96fd61-9e46-4ac6-3588-08df1421861e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000006B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364

From: Manish Honap <mhonap@nvidia.com>

vfio-pci needs to run a CXL reset on a passed-through Type-2 device
without the host-memory handling in cxl_reset_function(): the memory
behind the decoder belongs to the guest, so the HDM range collection and
host CPU cache flush that the host path performs must be skipped.

Add cxl_reset_dvsec_sequence(), which runs the DVSEC reset under the
device lock and restores HDM state through
cxl_restore_state_after_pci_reset(), and cxl_reset_capable() to gate it on
a function-scoped reset. Both are exported to the vfio-cxl module so
vfio-pci core does not import the CXL namespace.

CXL Reset always clears memory, so there is no caller Memory Clear choice.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/resource.c | 53 +++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h           | 12 +++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index d3491e20c1ca..d373df9aa127 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -1398,3 +1398,56 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	cxl_pci_target_reset_done(pdev, &target_prepared);
 	return rc;
 }
+
+/* True when a function-scoped CXL reset is available for @pdev. */
+bool cxl_reset_capable(struct pci_dev *pdev)
+{
+	u16 cap;
+
+	if (cxl_reset_get_dvsec(pdev, &cap) < 0)
+		return false;
+
+	if (pdev->multifunction || pci_num_vf(pdev))
+		return false;
+
+	return cxl_reset_hdm_available(pdev);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_reset_capable, "vfio-cxl");
+
+/*
+ * Run the DVSEC reset sequence and restore HDM state for a caller that owns
+ * device quiesce and PCI config save/restore, such as vfio-pci.
+ * The HDM range collection and host CPU cache flush that cxl_reset_function()
+ * performs for host-owned memory are skipped as that memory belongs to the
+ * guest.
+ */
+int cxl_reset_dvsec_sequence(struct pci_dev *pdev)
+{
+	bool target_prepared = false;
+	bool reset_initiated = false;
+	int dvsec;
+	int rc;
+	u16 cap;
+
+	dvsec = cxl_reset_get_dvsec(pdev, &cap);
+	if (dvsec < 0)
+		return dvsec;
+
+	if (pdev->multifunction || pci_num_vf(pdev))
+		return -ENOTTY;
+
+	if (!pci_dev_trylock(pdev))
+		return -EBUSY;
+
+	rc = cxl_reset_execute(pdev, &target_prepared, &reset_initiated, dvsec,
+			       cap);
+	if (!rc)
+		rc = cxl_restore_state_after_pci_reset(pdev);
+	else if (reset_initiated)
+		cxl_reset_save_disabled_state(pdev);
+
+	cxl_pci_target_reset_done(pdev, &target_prepared);
+	pci_dev_unlock(pdev);
+	return rc;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_reset_dvsec_sequence, "vfio-cxl");
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 92314f67b702..a28903fc2960 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -168,6 +168,8 @@ void pci_cxl_hdm_init(struct pci_dev *pdev);
 void pci_cxl_hdm_release(struct pci_dev *pdev);
 int cxl_restore_state_after_pci_reset(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
+bool cxl_reset_capable(struct pci_dev *pdev);
+int cxl_reset_dvsec_sequence(struct pci_dev *pdev);
 #else
 static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
 {
@@ -186,6 +188,16 @@ static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	return -ENOTTY;
 }
+
+static inline bool cxl_reset_capable(struct pci_dev *pdev)
+{
+	return false;
+}
+
+static inline int cxl_reset_dvsec_sequence(struct pci_dev *pdev)
+{
+	return -ENOTTY;
+}
 #endif
 
 struct cxl_reg_map {
-- 
2.25.1

