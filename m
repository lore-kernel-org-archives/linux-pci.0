Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC24339394;
	Wed, 30 Sep 2026 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763580; cv=fail; b=Bd7TLr5mhutHxYZCLEi2B4YkE1ctXdpbY/8R2W6QRojn0OoMbgSqXoV4OX1ggtQYR5U7hlkgfba7/VhERi4GuaNo0SF9nA/+xjEyCjhbvheWoGXya3PBOYZIkqDihjhe2A8V5aC18bXi2l/SPdvC0wHwGMy036cNcsowIUF9LA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763580; c=relaxed/simple;
	bh=xaFaOoGDpcmN0ywTzNqlXAkATnhJn770MUjzZUDeqz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEWwI1OQ8p7Cc3fxyiIDKX7N1ujs5QLdF/wjD4YuH878feONCrQwasodOAFe3Msl5v3T5asJSxWSgh6MBPqQMchiBNDxFQ6kLnQsDrVyfppLdKvlERyXK1ljkL5rIvLsHkWAYoD1VwCmIjYIeJ2ZoWtXxvhJ/JjO0pA66v+/sic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q8qEZmlm; arc=fail smtp.client-ip=40.107.209.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q8qEZmlm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtmiMSMe0RjR8PPFKhiIcnfQWRwcJd2fXwWhvI6ZPwMZRV9nYAg4OM0jvnInFvuiJel8N+7eucDl+QdNfHcFZZxm5NTPiBtJ7oEF+UQ3x4zs1grQf/AcpOb62FZLz78g+sSLrS+SAoTs1LLT0cLKbupPNILFsw2rmGbOPEg0bqqnP5mdYWSD5tPRsjiAOeGqIJA9V1+7ANEc7DXrK9xpu1fN/kJYHCQrxsg1/QtWTAMoePbLeox/qOY193y7kukLoBSbVESr1dPxUB0AeD05nYYZmx+9KmCUIwW1SLIBZ6ETM5qywvg3ctBb8u23W9sQrkPkwEKP7Qgsb0i6LWeB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WLvjId4O7hjrgkonOLHm4BcgM84B/ArLv1WvNfaYVI=;
 b=N+t4C1wtootHkbVRIkxeuW/VbYaA7bRz10dtd+kraWUEvrGvGcyj9qulxGcpyoHqGopOGZlIWxyuq97Ecyg9afgozgXRZd8XVveTgGcA6hLyX5tOpBQT7g902NKQKI9eVWg6MxIhhN0OY3fMkQDVrFR3vmqXUsyV63F4JYYE21CYzv3KfenQSeKtrsuDO+bDlgAE8NG4EHk7r6bA2msjwpSPefWMMdjogWLIs9zcrLMNzHZXx1Lofj1w+Lhi73U3NzvgLoZfxRdB8MaNMkuUVBLz8LB+MHvoz4ldPkMLHwKBtgxryLCe0t9amL3Ssa4EjruXjpoMSXAK1qO5aMeEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WLvjId4O7hjrgkonOLHm4BcgM84B/ArLv1WvNfaYVI=;
 b=Q8qEZmlmZjvFxTG+kSK7mQ5geJVOWR+AWdiRFf5MyJcj3kDWUXdEXm8VMNmwz8pZoZR9P20j1pWwkxTmXBaVdf5UJmxoQhDs6ACm7DUPQtC8jiIR47nDpgypvSFvLTK3G9qBU7sZM20sqsjV8ZkOE09uzUh/aC3QBXlAg/lOFugwQeK2qVdRjJAPdTOZg43qS4D4brzGZw4+SMXuE5ZcrEU612dtH+OUhYjMHVHBjW2+XIOJr+ihrE9YAs/gULdtDIkIT0mgiOETfVFTtXr7PS/LQn05FrpKPbnEsStsPKLY1Y0/W7ehtKJZ3jfc9oqJq79GMuc9PSSTlBzBkvLOZw==
Received: from BN9P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::12)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 10:19:31 +0000
Received: from BN2PEPF0000A994.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::62) by BN9P222CA0007.outlook.office365.com
 (2603:10b6:408:10c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 10:19:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A994.mail.protection.outlook.com (10.167.248.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:19:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:19:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:19:12 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:19:03 -0700
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
	<alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>, Peter Colberg
	<peter@colberg.org>
Subject: [PATCH v3 01/10] rust: pci: add internal SR-IOV enable and disable helpers
Date: Wed, 30 Sep 2026 13:18:42 +0300
Message-ID: <af34ce6151b5be98668d712fbe62b5d6af291770.1790759932.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790705494.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A994:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cec1a41-0a89-461f-6818-08df1edc5105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|36860700016|82310400026|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	f2II12CbEM4h0RhkX/xg+M8dIDON1fmzNuYHpsJgCIkU448Ju8bTilCfRTttMVUceGvKf6sAv8mhqbo1rmv12549KxPd5sDMLmbcFVwHjQee/sgp1dXWokLN+plHdUYSA4v4XzG+eJjwsJB7/9IEqvsyPd9lUt6MTlEfbm2qLbV+S9LDGTlS1I3Tyyj/rQp75TXBRY5Lo3hpFM0JRQwmQ41zkR5Im48zn92EC3tBtn7NoBm0gB5wMM35NN5wXf6pbHk8gLGXUzMA4n+UzPJPyaNzwmXeuN2y88re6A+5zU26JDenrxayQIGd6xVyBsR7s8aaTq8V2QxbOCMNEIzmc1JsyQuxrVPYudHy9xxvDvLLaRf1z7T84lqc/ZRN6GsHmt2m+ynD/dmdCgN3UNySiAFLtAn9g7CcuAmu0ySjypB8+xdbykFRPfx7FNFLO6Fo1vlX4B1ebvngQZEtM28mfc6KhPaWQNh4Nyij9LjVke1CgjRGSa+Nze/4umiw3uzX9r883WB92/OsyvGeLGaySNNWFmoRuMLiEp/MOnXDgOwkkhHZvFyi3cPrt0zWzO/wH2TtHCGWqqxnKEQHFNfGMGOLcVQv1ujp8mFNOwgumQFWN22CmtNhh2FCc4ZjQq5jGKJ6/NHrsAS3NNT6LVK8AmqWdKTy0lE2BtJ2+mszb7InjC8pjmBInU6u6hnNAm1PWvUg4Ug5NShy0HX9xEboRw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9KibNGlIKy0jMR1qri51l/b8qcd8/sj64duVhbGQKj8194cBobmVJlONyGOTwmgpn9zUgcrOOPmdX7eV5EmfZ62AejGvMQADQfcrP9EMbMR2FJ5oeyBvImyUI06J2YSgkYz6DRTXHF+CNBESuqK3CmOfyQvLIMT5nMQYEWT+cm2BTvZCxm9miGxTFEqQHYUJ1nILcBUvDNb+/2qoJZt39HndBJUUZ5DTeiCHdK5DMN1hoKVUgvR8YpSL+h2nFlP11gsONUggKGtglsmzqCsHPhYer4czwZC9aSmFXCKIorJr+tDhQtrOC6thidrW6aHcpcSglm9+wyM9KJbvVb0FJwq8vGLZaLbHcTAY2PFxFJhWz8DUxwS3RAel0EOoP8Jr/Ha7nOoIkClkmGOMBerm8sppv2HzrUGeowzzSRETZXkdw1who/F7evPuH9FoKouf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:19:30.8956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cec1a41-0a89-461f-6818-08df1edc5105
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A994.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295

From: Peter Colberg <peter@colberg.org>

Wrap pci_enable_sriov() and pci_disable_sriov() on Device<CoreInternal>
for use by the SR-IOV callback tokens and their rollback guard.
Keep these operations internal so drivers can only enable or disable
VFs through the callback-scoped API introduced later in this series.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs     |  2 ++
 rust/kernel/pci/iov.rs | 46 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 rust/kernel/pci/iov.rs

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 3ec897709e89..b11a1d32c5db 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -34,6 +34,8 @@
 
 mod id;
 mod io;
+#[cfg(CONFIG_PCI_IOV)]
+mod iov;
 mod irq;
 
 pub use self::id::{
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
new file mode 100644
index 000000000000..c37ce5134673
--- /dev/null
+++ b/rust/kernel/pci/iov.rs
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for PCI Single Root I/O Virtualization (SR-IOV) drivers.
+
+use super::Device;
+
+use crate::{
+    bindings,
+    device,
+    error::to_result,
+    prelude::*, //
+};
+
+impl Device<device::CoreInternal<'_>> {
+    /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
+    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
+    #[expect(dead_code)]
+    pub(crate) fn enable_sriov(&self, nr_virtfn: c_int) -> Result {
+        // SAFETY:
+        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // `pci_enable_sriov()` checks that the enable operation is valid:
+        // - the device is a Physical Function (PF),
+        // - SR-IOV is currently disabled, and
+        // - `nr_virtfn` does not exceed the total number of supported VFs.
+        //
+        // The CoreInternal device context inherits from the Bound device context,
+        // which guarantees that the PF device is bound to a driver.
+        to_result(unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_virtfn) })
+    }
+
+    /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
+    #[expect(dead_code)]
+    pub(crate) fn disable_sriov(&self) {
+        // SAFETY:
+        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // `pci_disable_sriov()` checks that the disable operation is valid:
+        // - the device is a Physical Function (PF), and
+        // - SR-IOV is currently enabled.
+        //
+        // The CoreInternal device context inherits from the Bound device context,
+        // which guarantees that the PF device is bound to a driver.
+        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
+    }
+}
-- 
2.53.0

