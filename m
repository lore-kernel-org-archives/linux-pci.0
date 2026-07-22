Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5F408628;
	Wed, 22 Jul 2026 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706005; cv=fail; b=VK2unp4JG9qHNggVdFSU21pywmAMLgf0nHf6dy9bmEl2AWCuJwJdAKZlKVFOYBaBKFGPromdeAaUGPwOOA8yfi9IFUxdTTjpcQGyYOG4eoBxmwFw8gJ/sZSzpQopaIpoh3ZDAUCp6RvL2olhvBvaJCXAEMOWxhrhCGKJkzVsTCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706005; c=relaxed/simple;
	bh=zEx1Hc3A819OhPAiwRBFQp/pS6ONJg4zduWE1AO9LCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jecia0R6RonOgwFdcCutbuAPkQ1pohf+x7hBEz6EHUUCmFnRF+z2B9fHiEkab2AsPigBrxeQmbGgYGRPDLU/VgzJ1lMQKiJI3H6Acz6Y3soFnNSbm3g7Z2iXbLKUZnBOSq9iWDYgo9jlzw5+4SoNP2kZFZtvY9cXoVl6C/n0jXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K/oMN+Vv; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K/oMN+Vv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBQ3DjVFCx4dnA7SHOPNgAervLCcmLoqDFFydLYUtbDYio72VuNdo4kyIxOAKs6yXhTRpcEopxc3KHMYj5Ruse4mAkoD0XAAZmLusDspedYBPxmyLdA2GhUjIA/aNKDM4cY5bBtLVTLq7OwHPjpNMaukgW3EPXN3gGUBAY7kSXBw3FVCISsAJIT2OTqezi9aKFOzBF0qpEuIAI4UGCx/BN+DnWoO5G4DSGWz79E5jVPOh3hNOr1K73B2MAH36QAezrLYSHjDz4MC0IYaF6XMWl3eTqbdlQxgh7FAd7h0W1zVA0kZAo1I98K4wc2cpMi4zbXtv8GZ9IaC63/DeUDV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrORapsNJyhCBH/26E5XZhOZQ+bl0Dz+YpSM7DKWD0k=;
 b=iqnD28O+zsLIKIxz1aqTI45RgY6cCBhaIilSTV1Et5b1iuBYavh84J4qA46krB7LptLx52FcW3EjR1qrV42jx4PKARVtvv+sUdHjkShotJmjsejbDu2Eby0ZtKAtjzaNNNYorem8I7FvougA/Ec4+hp24uYffkJzG502xueiZjHpDU2bgxB3/H3UIj9k5bV5Bzdpz16bxZUHm13cosAJBgbRu6Ce+RYxPpJTjUcSAwmzjoPZjuZjhWxpnJ0+lc29roMtJu2kiOftMxxm8CluJN41B9cufcTnaLC85d8RLMrrg2avUMcbDm+7CtfL4IERczkR5SnOhsM30xi7iju3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrORapsNJyhCBH/26E5XZhOZQ+bl0Dz+YpSM7DKWD0k=;
 b=K/oMN+VvRwWvfivOL2R4FE19aaY8aXacNUFLRFlt5iPHtbg6ULZ3/ig5zzdmKQkD8q97JSOnPUulBseefng2Go9bmAiO3NdBdcPp3VdEYB6qrA0hUwJ+Q9eYj7HIucePy6S66NKW5n3XqkBNlayILpS0lgtiqJ6gtB5WWjuQ4oi32a15+xpFCVjCIJx/yG2iJl7Mn0N/gfcLKPk1Xb2wwWJCMnK8Jq/YbVdex6uXuBnnkdPVgjCEmW78yI6i4SDArcjeFBp0JVUUGEBl11VjyhHV6oj7lyvtmeVlw2+7WOXbUvim9MXjHZJ0h0JQl8en6T55zjDOTdz21Rb+C0xpwQ==
Received: from SJ0PR05CA0171.namprd05.prod.outlook.com (2603:10b6:a03:339::26)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:39:58 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::13) by SJ0PR05CA0171.outlook.office365.com
 (2603:10b6:a03:339::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 07:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 07:39:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 22 Jul
 2026 00:39:42 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 22 Jul 2026 00:39:41 -0700
Received: from inno-dell.home (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Jul 2026 00:39:34 -0700
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
Subject: [PATCH v5 2/6] rust: pci: add sriov_get_totalvfs() helper
Date: Wed, 22 Jul 2026 10:39:09 +0300
Message-ID: <20260722073913.1807677-3-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3fc42d-5f0a-4e51-fff5-08dee7c46e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	UIigq5Lw+FrUvoFG5RYgrinmz6QGS7n8qY3qKHp1wAQnld2irwVXkpEJtbut7SQ14c2pOca8o/mQz7sxkSmZzmD+WxPfeclXo6d35tlS61NWe34VhGUQCSmTkLHqh4g4TfHN6wS60Yq/7S/53KVwEabuIS6rR/glMXgz+/psBzydM5uRoy1Q8ejqBu8Qr2PGcix3mYL3l6wUPIfykEsJNGSg3TgLssh+atHqHXp+aoIYlYI6WoJP85o683XmoN7qc5oNdM3i7gKj0I/hTcmeYmv47LafpT0gp0VbXDVEVAs2pJtWhLkwWW/6ExOrUssn+1IF99rREKC0R/xVqaQkAh0LukjH8TnvoGQmarjTvEvK4ZLRyOLPC+QGKh0acv4quizzGNVAVIptHGo9fMr1e6owd4psS3f9tNUMW+8T8qmTzDWgWa3B58qr649RJVNyoZd4EQnaPLJg5fE/hSm88SBRZVy9QoxmJxhOfmDFDOmkDHmkaiscQWdVjB1PMfXHGp5pnfYCLtewQLopQ9Su74B1w/4yfdAiV/BzwTse7BAz+7306OQiAsnH1hueNXNf98fzB0R1GyOLWChabjAx/G4vLZVMwTJKQo8YpuCYU4kOEOqC4jdiML51wpsoUEDpA14gsNYAyLtJh4AWmTAOdwB/qkpgDMlrxDPY77zdwNZHNte0JPKfoavEaxbfLau0C/IgMkucUDy3WWqJZppMOg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2SXEtmKtLavwdJZQbrciLFegscQp0zfY7cmOkNG0OIqeFcVwKeUcTqkR1GGXugfmwliCGzQcp9pk28sQuY8U2VOO+FI+21lNnuC6unTE0cHKbV+of3Hzl3gk9Yeiei6c+gt/cnlS+T+pOMKT8iWmF3OsMZAt3g0k7M6aqTPD97CTvvrdJ+manlpXRn1nRGTvlkxWsx+kzi04hjP9anWiHr8LgrnSErGmoSxOXqX5K9qWb7cXaEITZkWN/S8ojsY+wvCcbAtZcauzNYn/8jPxKIDHbgJSQfkdR+Y5Jt/rLS82HwQ6hAurHpCA7sgftdfmnUv/esXUYq1Yo0BajNF4wFlbaySjjmaykt+1uqgWNLwA5RD/FQziUe7KntZe6L1voFFJEKw0hj51irJGlTJPFma/KFfEpCynFqB5hiidGz7EyVyRtIgVdgvP8NHFKh1Z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:39:58.6517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3fc42d-5f0a-4e51-fff5-08dee7c46e7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216

Expose pci_sriov_get_totalvfs() to Rust PCI drivers so they can query
how many SR-IOV VFs a device supports.

Use a conditional C helper because the !CONFIG_PCI_IOV version of
pci_sriov_get_totalvfs() is a static inline function and is therefore
not emitted into the Rust bindings. Return Option<NonZero<u16>> so Rust
callers must handle the zero value that represents unavailable SR-IOV.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Laight <david.laight.linux@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org
Link: https://lore.kernel.org/all/DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com/
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/helpers/pci.c |  8 ++++++++
 rust/kernel/pci.rs | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index e44905317d75..4ebf256dff23 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -24,6 +24,14 @@ __rust_helper bool rust_helper_dev_is_pci(const struct device *dev)
 	return dev_is_pci(dev);
 }
 
+#ifndef CONFIG_PCI_IOV
+__rust_helper unsigned int
+rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
+{
+	return pci_sriov_get_totalvfs(pdev);
+}
+#endif
+
 #ifndef CONFIG_PCI_MSI
 __rust_helper int rust_helper_pci_alloc_irq_vectors(struct pci_dev *dev,
 						    unsigned int min_vecs,
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c6d6bd8f251d..9f19ccd5905c 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -25,6 +25,7 @@
 use core::{
     marker::PhantomData,
     mem::offset_of,
+    num::NonZero,
     ptr::{
         addr_of_mut,
         NonNull, //
@@ -452,6 +453,18 @@ pub fn pci_class(&self) -> Class {
 }
 
 impl<'a> Device<device::Core<'a>> {
+    /// Returns the total number of VFs, or [`None`] if SR-IOV is not available.
+    #[inline]
+    pub fn sriov_get_totalvfs(&self) -> Option<NonZero<u16>> {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_dev`.
+        let total_vfs = unsafe { bindings::pci_sriov_get_totalvfs(self.as_raw()) };
+
+        // CAST: The C function returns `unsigned int`, but the value originates
+        // from TotalVFs/driver_max_VFs (which are defined as `u16`), so this cast
+        // cannot truncate.
+        NonZero::new(total_vfs as u16)
+    }
+
     /// Enable memory resources for this device.
     pub fn enable_device_mem(&self) -> Result {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
-- 
2.53.0

