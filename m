Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A614BB27F;
	Thu, 24 Sep 2026 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276821; cv=fail; b=sBfYZyhPVaNXrapVs/VHZGfIBrr5pTMBwfi0NzzlnHSe3jnuyNg+0/vtmQPzG2Z4e3rAae7aC2EQKthDv4AvU/rd2QYYznZ3+pnOtC15wHhB3STwRTp+hKXot8LpVnhK87wjPhKb81Y8c7RSzNcCxEj0M6LtFk1KeaQ8gIjIibA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276821; c=relaxed/simple;
	bh=HySFwJ+bTWWCMNzSE9PYNuJC7fqNyaeGtxOeFVnqWOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7fpAEoNl0ZEPpiHAylaoLkUn1tbsu45NbrefZZtWylowo0T4YOkQAFknOWs8v8GGxBn5W8lw6O9aB1DuyDw5np7ahmEr+tJmW1lJVY+wd4jiYRVHxBtnevAHWjQCA2i1rI8FDlRXe+hBRKYYCpz/LS3MTcmtv7C5ePG7DtE6aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IOodaql9; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IOodaql9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8U5CE0y8w9eDrKdAWXgefNMPyNTKdFPl9cIs0VHu3A9Uc39Us+TtRA/uL88YHGhdHt7NHTJvq8lcr/7f5ahhaEOiVZ1A1P89fWaA44sUs2ziP/cAPdzoxhn0f+jgCvY35czLBfel9DYaQnKjzga4odlJnUE5Zo8SkByysNEOy5LF/ayPxQFX4U6qkVq4orCCqX7VPrzGarbEH/Y63sXbmfF+ScsExtpSk25JC62BhlVEvfdUZXBmh6sQAJrVWKk6sU3uKgQmxT9Y10SSxt21cCNCEXCenJJpBLn/aN9GP4oimXeQWttFCydPAOVrMQQET67ICUXPjidR2Vezpn/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOMJ9op30Bw2OBasDyaAjoaqg5PyG8/Lnub/mucEVFA=;
 b=LTRAnZPMHMmksC4YC0RxaZfLvsju/SeDik4OfMeDMN5LIBJg2mnfqaJrxuc0EY0/SiCpIX70JGXRSMy0qHKqLDgNQyi1tCLhNjuxGmdg7q8fAftkWYbl784sd++giBMpmEtS4kUE808apNPomrlSe7ONe9tK43JeBD7AkYI5WbWPi72BOg9pJmM/K6VXq0+9eFqU1OVhjxAmQVaUABZ4W+ByzMSWYnswTZx91JoN+SLPF8kR09okD2On0Gn+6Qztcg1dT6tEEkcOt4DwyFggrrwnwgm3TbU8ca/Z83OYRtTGHdJ6pJmK4aPozQqV4J29u7JY6LjbxNeiYFmc7rD25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOMJ9op30Bw2OBasDyaAjoaqg5PyG8/Lnub/mucEVFA=;
 b=IOodaql9cCggLXeqlkJ6BVBXCy5TWT3hmnPf6ryrLhob2Oa3/Fvzyp0WdvPsUCQS4xsTAlviDL9rG+u938LLB1Na0X/xTjFOmXXgKOu2akT4VAhlOFTGJXgvGfS3BjIb4DPiAn3TR7DG6z7SrFXr+AiIVNZEHB8veCERjc6WG+Uk23moAfLSZewTDGQCVkOw74qi2ioRbE0WY5TEPIIm+1ExRqeKbvpdltgd18K8LAvWGjq3m8/mFrs9UX15lybgNJB1lXQEhIlKSxjNAQkEU65ooXEcybaRiJK1+13JkZVjWnwmW5OHaZAP2Gxue7UY5b9XAZxS4iuafpGnwQOsNA==
Received: from YT4PR01CA0474.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:d6::28)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:06:54 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:b01:d6:cafe::49) by YT4PR01CA0474.outlook.office365.com
 (2603:10b6:b01:d6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 19:06:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 19:06:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:06:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:06:19 -0700
Received: from inno-dell.home (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Thu, 24
 Sep 2026 12:06:10 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <jgg@nvidia.com>,
	<alex@shazbot.org>, Peter Colberg <pcolberg@redhat.com>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v2 1/8] rust: pci: add {enable,disable}_sriov(), to control SR-IOV capability
Date: Thu, 24 Sep 2026 22:05:48 +0300
Message-ID: <20260924190556.1620886-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924190556.1620886-1-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f7ea27-fa76-4e45-5b8d-08df1a6eff84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|7416014|36860700016|3023799007|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	++bSDMG+l+J5mZNcRlnOtIZcJuLKlqnTujyyj50BkPUtX7OMKG7+1C4+LzzX2SLh05kv27s+MGy4AB0lKzjhL+8SSSe5sHLwGo87BCZgbWp6TXjdBLxZdv1itXmeChuYNEDxdv1oCrdgjmunvTU8T+77egIZ1NLuOex/qzLZg6ng0qKUqP75Qp0Sv0GLZHpkQttT72UcAqQWiyvtvdzU8hNkxRfUQnaMhGvYBMq1lqvWcvRFWe/f0dAtGgbJLHuAYbuzvTHoTKGLdrpQOymxmNMVEVZFR1GA7AhAbWHRBpyhnm6IKQLFGD0f86ZZ+FUvi01WN/5LMHVj+tz5HnYM5L4q7pTvUUrEbFZSjl5NgITnb9wE35M+CfgC/MlYOZal4yp65qMYxvbt02Jvr9iYAdcwNcRNO/hdaYKy35CILHhF682E3ctiGfFOpJbzM2VkRG5jmYcnVN+iVh1IPsmgshTH+K3E8NA6vESw1TyFqqlczV9mwwbvUm490VaRlOm6yI2RLZutc2mvovSnyH70+DKG83ee7XuduDZd3Jyl4xLDYLmil8MO49rEguosfuFo4GPo1yLiMBO3+nb77RVEEqANgeWIPHpA+BvZHcQJRAUcFFDK7sGTxnGtPp8AWviyEah1b1CXZSjVtqPShU/tycLF6vfl3RKIU4ofG6r7wLEtunoDYH2HRbda6+q3U4Hx5PIQFXUKVOHDHYrrb4WXwQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(7416014)(36860700016)(3023799007)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TO22sgmPzTbICIdUhb+K+14mjoAYID6yJ564v2yfOl+ucNgRopGF9XqnYLOacIfNuL7TKfjlsZeCYfRhwfAG0oO6xX3J368+/pCeQlt6/yijn6kfEg4viYnQdiMHFJNWdCnbyXsphGUGwpGleKNunKRgtMWLrKOmKKWBOQZOjIscmV5zIt2ItZ6quA31V+ku61GtfewdGCnIaIgHwUOOSXQJs1RqHbxHccdn1cc6Gkm/7DSMImk0dYDjwfLhqCMKEKJe+qXmEp0u2AT/R0ejuijHI6GKf4y6WJP6RVf8o3Cgo1apYwHdviouMixGWHlnAc0blVhbJxdCHZkcb9foxKXHCANNijuPfW8pgWDLUCkFfg1noCismHKDqKeed0A+OMeVxgjG/yfqXCnBw50YdsII/OOvlkqTUsi8X5AkNDK1ZArrXA737oE2rXyHemSg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:06:54.3675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f7ea27-fa76-4e45-5b8d-08df1a6eff84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543

From: Peter Colberg <pcolberg@redhat.com>

Add methods to enable and disable the Single Root I/O Virtualization
(SR-IOV) capability for a PCI device. The wrapped C methods take care
of validating whether the device is a Physical Function (PF), whether
SR-IOV is currently disabled (or enabled), and whether the number of
requested VFs does not exceed the total number of supported VFs.

Synchronously disable SR-IOV in the Rust PCI remove callback before
unbinding the PF driver. This ensures that when a Virtual
Function (VF) is bound to a driver, the corresponding Physical Function
(PF) is bound to a driver, too, which is a prerequisite for exposing a
safe Rust API that allows a VF driver to obtain the PF device for a VF
device and subsequently access the private data of the PF driver.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 3ec897709e89..e6dac919f02d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -133,6 +133,10 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // INVARIANT: `pdev` is valid for the duration of `remove_callback()`.
         let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
 
+        // Keep PF data installed until all VF remove callbacks have completed.
+        #[cfg(CONFIG_PCI_IOV)]
+        pdev.disable_sriov();
+
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T::Data<'_>>>`.
@@ -472,6 +476,38 @@ pub fn set_master(&self) {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
         unsafe { bindings::pci_set_master(self.as_raw()) };
     }
+
+    /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
+    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
+    #[cfg(CONFIG_PCI_IOV)]
+    pub fn enable_sriov(&self, nr_virtfn: i32) -> Result {
+        // SAFETY:
+        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // `pci_enable_sriov()` checks that the enable operation is valid:
+        // - the device is a Physical Function (PF),
+        // - SR-IOV is currently disabled, and
+        // - `nr_virtfn` does not exceed the total number of supported VFs.
+        //
+        // The Core device context inherits from the Bound device context,
+        // which guarantees that the PF device is bound to a driver.
+        to_result(unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_virtfn) })
+    }
+
+    /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
+    #[cfg(CONFIG_PCI_IOV)]
+    pub fn disable_sriov(&self) {
+        // SAFETY:
+        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // `pci_disable_sriov()` checks that the disable operation is valid:
+        // - the device is a Physical Function (PF), and
+        // - SR-IOV is currently enabled.
+        //
+        // The Core device context inherits from the Bound device context,
+        // which guarantees that the PF device is bound to a driver.
+        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
+    }
 }
 
 // SAFETY: `pci::Device` is a transparent wrapper of `struct pci_dev`.
-- 
2.53.0

