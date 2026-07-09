Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847713358C6;
	Thu,  9 Jul 2026 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609396; cv=fail; b=dH5jpe8chOuziRXsCsRFDbe8KF+7+fs84B/93KBOIGZC8ppgOm02ZV6OTcL8NLjqGmYkp1zoLBJtQlFu11+HRsb/eKVc0NmUMreBLAfuYglN3/leDe3vyKmPY9s4d/NNf8lsKpoSlxerV7d6iHtiXfDCY9zIn2HUcKppdagqncY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609396; c=relaxed/simple;
	bh=clzDMKZ428LCemOi147VpIfcpkg2uWC8xGZPiDl21D4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXq3313NWOb7zMiMO4uQqES+feIKFXN8zKTWxIC5OzU1074BWHjkCMz3ptPkBDBS2fHKHCwnSwOgF31/jOvQbRVY25AtUxFhQ4EsDI8p7q+DSdKYwnKOpvQLRUv44wX58ppdQD3rbZPw3mcA6P4SPxSUNyGYzjbP5YOAWXlTFnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mEQ0xHMV; arc=fail smtp.client-ip=40.107.200.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mEQ0xHMV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRscNCNpRUPU25lKrl4S7FCwyH3x2D2g8dolaGQOF1+dhmzafLyjVdxXAPdZtrfDPtOvEZVguTonfPnLUUP5pfplSg0EfpmOHbRO+wZGD98rHVaq6yXR8OIjFGne5uAxVHc1FfOUdiEYa67c+OgISH1x8t622Kt98Wngj1b7q625HlYFvIx+1/3Ll3zgKihVMIuX8N+v2yHD4W8HY29fRAOlZsR3QEaDRY70XQrgLKKg0lXaYXKFvkIC1haecGAJS2VY/fQf+CJfaGi7JSwfETbpj9LKIv6ibGrJw83MBO57e8zm8Yijd5Udeu/7Ze+I7DtYFcyJU5oTIiJsDe+Qfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnFPYwswKJGvnxylLvA+TfWOCaZTzDVeldvtdOtyV7o=;
 b=cvNliosxCXKhjYy52ZnAACZS+Z+DByPYfu8c/cPlbEsZTI1QxKGRu8bNVCtHU83wHtu7bAZ7uA6i7yCJEXfgGiIKgM5gsjasKBXqpnTR9tpW2adhRuFLH6+Om1Q/lk5u14n4ur52kds1+GcRJqS/o3G/7tB0G6bu1tNSoJTcq20zVl43h61n9mroBIuihQKEcBl+OKtwi/4S9PefMYn5qTN2Ev0cO3iDW900llVjVgjayU7nT8GY6PteyHfQBBBlwzENfck/Xa0M8yq1M0dqb9tSRyutpLXIsXSsmwgETdWSsBhZNvUj91KZfj3EfF15vFok9NSac0e/7Q3ThbrXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnFPYwswKJGvnxylLvA+TfWOCaZTzDVeldvtdOtyV7o=;
 b=mEQ0xHMVihk5PrA8XlDhnVsQ+KTus/cviEszMvv1za05tiV3z3szHxdaXbpy51sWpE6rFVpg4pNfPH9ctfJENEL7jFor7yThSEmFEeD0TFSmhxwEfE2RM71U7fhxyD3iB7lmtpPswizKIsNcNF2i/qGzCjHcf8LYiCctiAGrMD5x1olLLGrvu11CCRVb7iyxuacpC5o18iTShh8TO+1hHOWQXUA0FaZNMOtt3f2GX9+zSi+15UjRMIB5diLBCAoLMY6TJd8vOS0qMG4RmivOWu9uc1yes1DImIrvahxtjclBy2vXL+22t+jkpGcFh+Vj27us2RsZ6T+ECtVV3BarEQ==
Received: from PH8PR22CA0023.namprd22.prod.outlook.com (2603:10b6:510:2d1::21)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 15:03:01 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::5) by PH8PR22CA0023.outlook.office365.com
 (2603:10b6:510:2d1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 15:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 15:03:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 08:02:31 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 08:02:30 -0700
Received: from inno-dell.vdiclient.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Jul 2026 08:02:23 -0700
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
Subject: [PATCH v4 2/6] rust: pci: add sriov_get_totalvfs() helper
Date: Thu, 9 Jul 2026 18:02:02 +0300
Message-ID: <20260709150206.1046839-3-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: fe95a415-75a4-4b62-8d60-08deddcb2bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|36860700016|82310400026|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kXseOygHPC4Yy3n4s/zaBqje6ZIEZfBIkybWBIwavyRBd3f3PKR8Uwb2pqOAODSbl4XBMLwzoalM0uuh9mcIPO2WrxdxuaQs7WW7doIxb5YJpN7NLXK6T2G6CBdlJYY538j1xKBK/5BoqiwCR7d7UlSHu3V2/HI7g0QTRj/ibi6CJV6y498Cam2htA7JN9CDe0q3QAKJ9bdr9CF2Kg5+o96s7bw14d4KryKQPWFczoCer8Vvnf0P5Z0KkqIyEHyFQHOr785f0tf79+RzsW8MlDfrgQhz9g5jBuXhACI76yT/0CILT+JLiAmRtFH60iSz/kE2dLeeBWIhwlbGSX5pS4FuHIsIR/AQuYH5w5kD6rujd6zsOhBbr388sNNSaL1w6aEP9tgZyS7ELwAcBJ+PLkri0Z64yoZ6I1OmldjxiXzP+7OJ8hoZhMWGnGcxlPcqF0GB4Y2Gye+Sgm5biOA/58cn2b3k592QOFqF9e1IIv77xmDyQ0aoLD240Wh+Lkz+vLyrwq1VF7XuB2PIL45DOcHH+8mnpQGmya5gOUbzvnEtGdSx5E9Cdopek1ulgIDUJ66svgHegcVP0cP6+bkr2t7/f0YWYcmMT2RMlZ+XBTeh19JA3jl9XfUuS8xJtEdhF6OOFfTXXuDOQXdWuEUfGgJwIaUz4YzYoQpg79osJuWATkoChscptrhPkDXrp6KRUWuKD/O7rjZ5Ur6hjfLHlA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iSwR5LUiuSrRSJQhJtRzc3zdOSAaD3BtN4n/Pxz6k4y8lfWig/C1pw6bV7P+3vu7kKpTqUJtwxHFK9eVIjqT7Rc8cTYvqaMLjbx2NUjQC7oiVNkwdDgPLC8ZpP33rLiyLyaSvVlimorogycu06dzgcGMV4fB+es6vycjL5HalTQFyiL3qp4EyJGGlQDB5JCEClpOzEV2vi5cbFCZgtmfiKUOR0xSKsxz5lXR7WIooh3yT7HYfZK+RAv34dBnMl04NDo0/4ftdmz28d/ek4zBTS1bFA2jlChv+t7pZe0CZFMGf2J5gx/AEULphfMlVCYqYfuPLYgs2wM5FJUFSYzNFR0lfLvHxW+Go82Fzm67F6iXtCaT5KJys6TuM89GrhcMzri5yGUiwfsB6IxTCkSV1glVsKwyYHg05noW8580uxS71DnlDTW1BE1wmxZGnMt+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:03:01.6078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe95a415-75a4-4b62-8d60-08deddcb2bd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077

Expose pci_sriov_get_totalvfs() to Rust PCI drivers so they can query
how many SR-IOV VFs a device supports.

Use a conditional C helper because the !CONFIG_PCI_IOV version of
pci_sriov_get_totalvfs() is a static inline function and is therefore
not emitted into the Rust bindings. Return Option<NonZero<u16>> so Rust
callers must handle the zero value that represents unavailable SR-IOV.

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
index 5071cae6543f..280e84201d9a 100644
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
@@ -450,6 +451,18 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
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
 }
 
 impl<'a> Device<device::Core<'a>> {
-- 
2.51.0

