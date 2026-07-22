Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C83408628;
	Wed, 22 Jul 2026 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705996; cv=fail; b=NMc3oYwBvAE3cIkABeTeOX7q6FpW05r+S4hQc33WeVVoi6EVbj+/Z+6wsLalZvWtdgam4xuBqQw7WzjCFcqk0bxkpNct7Z9kDsBDZ8z+z2bPLxnaBlLiEMeHJRMkL/ymsHomvhUzm2OoUQahnRe4V2DTgfL2B1PDgcytqqXCo7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705996; c=relaxed/simple;
	bh=ZEh/JvWIrinZ4apVI8eFGEhc2qaGY5u5bEN1sWbqR9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N83uY7ZIGh93MKIHJiDhN71RvnBVYe1FxJ2COSUxMQhD6xq3PjoWlluRlVGK3Kgq32saJ/gj8mr7CiBKaIwfE8GUiw5w0F9QZSkoy0YLE8T1eApCQ6PU3CnA3fp6Mb2jxLIBmwE08X1MetxyrU5UcunEeOHwfgrClml9quX+BI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pEihd6Hs; arc=fail smtp.client-ip=40.93.194.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pEihd6Hs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEu6HfBPnIawPssDKbbySERHYUDZNWUGh/acjFmNbn1XU1YFIDF7vw9e6e4cTwBuVHq29qcM+ek4+Ap7xi5671RtVcXZTBjEDRfefPjWvG9Eji3fCAw8FKKQpkVU7tyN4Zb9/2NfyKuuLPFWhYgURr+JmfJi/sXhdWZwkFst5KUc/Wz/yGYFXAd8dLBFi/EB8Py52TX9O7OcWZ84mg5PtwdBWrS/0W927oYESL6wlnagSclVMlcTNWEWQnVysx2r3qONGvdBx5RPhCNZZ4el/LB0lGSl7OzBV0V7jn49IVXvj9sG9O6+7SxxAtwhRS8cAvgzo04VsLtR5tLN6q4cGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lm4/dT2belvGgiv3OqFFV3HPDnNM3+7zltaTL9BKbKY=;
 b=LMR2TlYsoEwG9Ehq/rKkvBb+XW2WqKadN92WuFWKXA06Gdb/3dvTO9wsM6ekYIbTEj13UGAP1zBkoGPueUox9iev7+HMH5dgej12MXXAkhYQzmRo+822ytvBcRuUfkQyI35coi4wbfa3oymsyHpGST60dGRvFHVeywC+TgEZaAzfknAKB10+d4c62ly4ChONBoOO3tbEbY2j5k5R+rLo3W9fvkhYILlIVFplBXTGJ6cOfzpEkpTTCn6BRanNqBs+Fek1bNFON8Cx/yq5sfzF3oSgYDnz/gfvGEyqYRzus6NVgB9oVLtQTI35k8GyfyhQXkkDTnwQTRfjELxROV199Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm4/dT2belvGgiv3OqFFV3HPDnNM3+7zltaTL9BKbKY=;
 b=pEihd6HsLcT3/uklnLcgXhGuFR8zWHLM0suKIep+yS6lWBGskHXRUxzuLY4Ek20+Yb29S3hGoJrCGiCEplfimXt12zvIBkgFevlM4PI15Lr9dHQWZ/S9/rNGorPdJQEnnvU0Gi+E2dRY2L4ep5UR3WhTAm3GHTdT2jHOV2bKVhnVTHc7SQFEGLE72qJxm/yLhebjA9IK5FRt9SRKDhrCjABlvkFAPT9wvHo6kg9un76tia18eK5AzBKvfznd1UEuKump306aKGly5Em3LjvF0QMSs7h0SdDgRpbcLgcD3/hYEBO4lPbapa3xf2tZJ+Q8dX5elsKWfK51TVmdePTXfg==
Received: from IA1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::12)
 by SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:39:48 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::4b) by IA1P220CA0024.outlook.office365.com
 (2603:10b6:208:464::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 07:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 07:39:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 00:39:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 22 Jul 2026 00:39:33 -0700
Received: from inno-dell.home (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Jul 2026 00:39:26 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>
CC: <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <joelagnelf@nvidia.com>, <apopple@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, David Laight
	<david.laight.linux@gmail.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v5 1/6] PCI/IOV: Return unsigned int from pci_sriov_get_totalvfs()
Date: Wed, 22 Jul 2026 10:39:08 +0300
Message-ID: <20260722073913.1807677-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722073913.1807677-1-zhiw@nvidia.com>
References: <20260722073913.1807677-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: f435e787-6b10-4862-7d92-08dee7c46871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|7416014|376014|13003099007|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wW4+l3eOtKNb+j5Br0FS+989QoiuUJkzGuOUdRozRsplrffWlVgLMbIlK06ynlZ1YydCq+5rYDgTfdkmgvpkCTT1ysqrt60n4UKT1m19Mez1NIR8B3aIZgyjZOKRH7V0oLLILHFmO02N7aMghs5pOi0nZcYdTdfsx1pBwIi45xDOAAxHm44LkXd8/VK4JpIaL1OmNhfQxoJKRYdXX0clN4pWTph0snUQ+EpSM0tDrXGtrHXXmtNXiPw/rLIgpmeyQPAQyLR/VY7KJGUwydGZml0vxAXk1z0F6+4VSuk5eWEDA/VPIPkqTqDcCj0qg0XbQQAjXyULGF6fZ+8ytAnfnJvhhpRSHa4enJaeSEVNZQGxoqErK+EesaoSGw06Nj8emBilNXV/g1ersajWJgSbZc6cDxU5apjj+/ciaO59/1SOkxgbAnVOUt0z2CKZa800hrCXw+S577GA8O28ehAN8rJIypRFJ+p1KBsnw9C9QxTbTsiiU/tcquHIGbgW390TTFbLbGUiPXANCcZ/5jDDM9ojGcL17zN2kxZhnW3WA0yyPC470lGkdLOej5YjBcYHY/1tlB+1rtrIXgQmq9FXq8dAQbyNNmDhxnC6Dx28rBdcQIGf07LCDO9iHsNwQAjdaMI648kge6XvIxTMVyUOnvKcUuRwaffMLa61VjtoeKY8YgB2X4rY9QfPSbs0wih6EmDid3Pzg1OCo7kZkQyQLw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(7416014)(376014)(13003099007)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZYMGnES122p7oa1w42aJNMeP0v+yCjh78LGCWfKkQAdTwum0p44wcSGngh6ChssWb5f5U4+yfNN4DuuiOjOVdypsYy01S9gm7Ug1RcDtdZ1wJTFFHejLWFAQUkKiBP7HaNj/e29lOWzOCVkQ8lzLK6jOuDxZ70MG6+QCAgwHwX3IQIdNd4oVIbmMUHYunvzvpsus20EFKcdxbWHCObC2A3sNBK6XM7pVg2gfxdDGE5XoSZRnoWUgvy43Ctt7bzoUuF9y8bHUi0rOYJH5SOaPC41sfdQBF7Td9MzrZ7/sNFJwT+OVXCS++BLBHV48jNk3uOCKUS+WU7u8+BpeFU9d8s9vOPZ+OpmcBAsZ3mtFmHEpAS2n1PaAnPKRp+NWgBkaePFQyDFFBhLyBXrXVIYHn3Hgmf/vnsDodw17hJmqs6x+BD8+PuNDXODec/Wf++LM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:39:48.3186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f435e787-6b10-4862-7d92-08dee7c46871
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420

pci_sriov_get_totalvfs() reports a VF count, not an errno-style
status. It returns 0 when SR-IOV is unavailable or the device is not a
PF, and otherwise returns the PF's driver_max_VFs value.

driver_max_VFs is stored as a u16 in struct pci_sriov. It is derived
from the SR-IOV TotalVFs field or from a driver-provided limit, so the
implementation cannot return a negative value.

Change the declaration, CONFIG_PCI_IOV stub, and implementation to
return unsigned int.

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Laight <david.laight.linux@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org
Link: https://lore.kernel.org/all/DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com/
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/pci/iov.c   | 2 +-
 include/linux/pci.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index b0d24839c084..9d408fb8ac25 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1283,7 +1283,7 @@ EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
  * SRIOV capability value of TotalVFs or the value of driver_max_VFs
  * if the driver reduced it.  Otherwise 0.
  */
-int pci_sriov_get_totalvfs(struct pci_dev *dev)
+unsigned int pci_sriov_get_totalvfs(struct pci_dev *dev)
 {
 	if (!dev->is_physfn)
 		return 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ebb5b9d76360..2b9c61de5f67 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2569,7 +2569,7 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
 int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
-int pci_sriov_get_totalvfs(struct pci_dev *dev);
+unsigned int pci_sriov_get_totalvfs(struct pci_dev *dev);
 int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn);
 resource_size_t pci_iov_resource_size(const struct pci_dev *dev, int resno);
 int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size);
@@ -2622,7 +2622,7 @@ static inline int pci_vfs_assigned(struct pci_dev *dev)
 { return 0; }
 static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 { return 0; }
-static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
+static inline unsigned int pci_sriov_get_totalvfs(struct pci_dev *dev)
 { return 0; }
 #define pci_sriov_configure_simple	NULL
 static inline resource_size_t pci_iov_resource_size(const struct pci_dev *dev,
-- 
2.53.0

