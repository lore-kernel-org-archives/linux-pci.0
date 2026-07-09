Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B1244687;
	Thu,  9 Jul 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609384; cv=fail; b=sh/22A1GAqlT8JG38PeySUfoZV/Qep2oFhAGvN54+ql/t2XhkfuhRfdErTkJWpmUc/wIXlO4VL15ZYd0E9g3EiL4H6MSG1+WCqyuFT/mFnZopE7qtX9O0ukWEFNAk4nZ0+y3vNP53UWqEM5pwSYj1a9oI/4XK/PIgcADL3X9Kd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609384; c=relaxed/simple;
	bh=wfKtQHEQeDF9Kpe0DnObb8Xfrt0KMNOBF50TV3q7Xkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZXDI+VUm4BT03gMoz8FPXSn1Po4KS6aR2v3JP1dUPOAEweqCsBIDv7AhddfqLbvF1H4izZb8y2x+Qn/1kR6d6hry8UqD7Mhe8/WIE9PDhNNcDQ9x1xIQmkeGZezs/Yy59/hBe2vwkBTSSpMOzxPmfwC8kFmFjX1jRH3vxXglSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CP0858qh; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CP0858qh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZr+MuDe9HevpePDfVDQWqLJSNxctXueQNx/phElZVG/LQrkRawTIim8jW+oQh7X8Fok4LXhGLzW3MFkznijK8/f+QGkz5VIjBRV30zT0wHvpECPpQ8YqPh2wBCb9siL6KhytzKnzqKFG31mW/rKedluiYElZeqeqkdLP7tha5wvRbtveMkyjDxzjV2PPKI4Gi2/KCIuxF2ot62MNT0RItJJmkl1CjfbQE/hlsUGDAxt+Kp3r9F6mBDP7GbM0IOpuMBDayPEHdbRdRWc9GlGUNZ+S8A2KlJHuvSAhf+jASLbN5qVZjyDOgzxuKNBT6ipHzazBTwsFRLpRNHsYSD8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5MosNsBodKaE5MmrKp06QoTNxwlhQgqLaomnFla4Mg=;
 b=koHdvPGDZ7pYnkN60j6pKce8ZX5MJ3FbR3BhNmnXIS7taq97XeMbFSWBEaExFvE9BCnmWiqxqowYT/R+/HWPbcVmdv2pr2+a4FluyFAzNJB52kEoSuw95LTPjcilYgqqG9jGyiLoKTIsAaz8ikRoODgTEH16WMHeUv3AJmxBNUewUIJ08TMKMoI/bhVLdy5Xex0R0UnY/czh9LHxC1yjgIMQW5mM7p7wEvb/PxwsRKoG6cfmF7ZHfHMR10DyAMMVHXxvRC3GiVqvLnxQTV+ww7Kq0/Ts3FbagLDQjqvkLjV6WOpIJiQxy831AmdMEh3eU5fB+edAUuzh6liPZ32DQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5MosNsBodKaE5MmrKp06QoTNxwlhQgqLaomnFla4Mg=;
 b=CP0858qheNHz2qGi0jpR8w48faechTzvXgzLdVdw2Wi4GKhZCj+RCO8BtoWqgUu8Y2//ZXWAXJTfe9bLeiTSyoRon3QDp0uwstDm5ss/wzaq47PIbsISnVqG6k8mOPRRDuBZxWZun/9MRAEhbtYaIbsCLQSIy9cGvtYYRD1TocqqM8oGb/9ycy0/nK3p3Ik4Ds+n/HEQSWuzBzBxMRkcSIxdLqmDunKNvb/aNcPjEAXF0XZ/5MnjahxZ4o3ZbjRSTWXIf1P/A9xoDPBazhUhh0Lt32MRbnMzR6CIx5GUbGXIFlO8WVGuDltRDwlUQ5Rt4NjGCxrM6idTjhdBuYDawQ==
Received: from DS7PR07CA0011.namprd07.prod.outlook.com (2603:10b6:5:3af::22)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 15:02:53 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3af:cafe::54) by DS7PR07CA0011.outlook.office365.com
 (2603:10b6:5:3af::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 15:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Thu, 9 Jul 2026 15:02:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 08:02:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 08:02:22 -0700
Received: from inno-dell.vdiclient.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Jul 2026 08:02:15 -0700
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
Subject: [PATCH v4 1/6] PCI/IOV: Return unsigned int from pci_sriov_get_totalvfs()
Date: Thu, 9 Jul 2026 18:02:01 +0300
Message-ID: <20260709150206.1046839-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260709150206.1046839-1-zhiw@nvidia.com>
References: <20260709150206.1046839-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: b13c005a-ce99-4e94-420c-08deddcb2478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	abUPv/N16MovpqeBsBhgUE5WBStNAY7WvD34IHEKhQ9SatM5nS84HvC1p2Q5VkHUok5PammYAK6sXIM7FKBY0CAXQX0/Ha/dgi0oYBdeR8IlkLxqEmC5+MRAFczdbArM2ZmCNViAKsp+U8RK+rQKLyL5okS3N/S1n1X2jE4RdXMeG212rwVhOvhW67P6/L0a2GREnTWL9tZkSBl4P1/Z2wSlDqd7azR2tJ6UipqrF+AdaI1SKopypjACKGhIeaTkuJLSO7YnIiXjhukF2H6qJPpNlIZeIv+REEVbt7CA+IwfdWL1f3hMtuI+lTbteP2pH7/Eu5rTNFXqm1bI1xKpTdoZ5oNrDt3Iswrs2nPzQV1bVGJyJhD4AWNgQO75Ac+Rbk3mZl35Ak6so1h5yhjhPEqZjMw17UJ2vwhehOtI7IvW9LmgwdKhwUjqZoJ8NHR7pusMIBL39CiDJTtE8vsMkqXScZrqmtEL1bG3PhL5qgY3XzIPYgbsYOn26uLwmN91Ae20rzJtc+1XtqzEqIOc2vjoEHb4zwwFH8kSQqis6SUlqqzXfYhKr0blLcUKHxB2wtwk9ubeeSW24zc32JTueZgDk/xcF8saMu9sOtZ9rwn9NOCqICn7ikd6FZ2I+mLrPAXfxYVq4eGrVAO1V9MWOHOyFMrF3VWkK+jAgBy1chxrdwwtA0yICVl1xRN2BzyT57ZhLBk+PWpQXFdFzAsfMA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nbUTFqH940hI73CA0L4XQrfxyWxGxhTyNTfkRra2a4HIUNTtNQGae6NTKYsyBRP7+bkMrDn/sTS+VM+KixtTz1+/DBCZKb3yrqN7LX7AI9FlWyEgt3iafHx5ZdQ1E9eKcL7fL1CjjAfPacLPKMDkQlfP4bLsTght83Hx+kgXa3CfjpCu3D8ncpzC+i6CRzDUdLsUvTzMVof07rcJ6YYfmxZkWdVtIgpxHXDMJicRPEhZFucE/sE9lHHmHty5qk+eHjfiLMw6xIt5Whs9yKsmVSl4u/tFNTCvoDBu08/sDYrsWJdnl1espjiOoyxjGcI0O9BeJSFQGm/HE+SmsMW/6jkD7lriy+ko+Fq2rRZ6nGrtPByTZmz5l1zAwxITL6F/Kfan9LQ7I+4q2JiY0ao+hIQVCeu8cHbG9IvI2q5/lxaH1d0KmPVpkyd1qI/fRi5f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:02:49.1564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b13c005a-ce99-4e94-420c-08deddcb2478
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

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
2.51.0

