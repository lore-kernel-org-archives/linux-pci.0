Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7F43CE77;
	Sun,  4 Oct 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115692; cv=fail; b=iFPbsciXpijaGInYfAw5wv2i8mGpGZLvHRL07mRVXKusZPuBlqzIFQrhCgCZWGoDntsHqad6pzM6/HQdO+YveC74NjHSlzcnJBua6AQju+IijEo21h+jvDmyikf+dcE5o3am4WQanW2X55JH+huqDOUl+xCset9gd0ktvgWmtqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115692; c=relaxed/simple;
	bh=9dXxbXKUa8ebizfiseaQu/sBeRaMTLAgE3lJSzpxCYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVJub4rPt0wWQNniwf732WmZb588LWm4NLiZ6IN5g0ewV6UJ99seDnOQSLopaw2u4jZZ2CSY7EZ61hEqj+XdyZG0hIDdd08QUX68LdVsp7af+fZ7FUKXkhgQ4osYvaprG5ehwrvDaswJRh89BvfKImeoHjIpfQie6YgqdfkArCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AkYaxgxA; arc=fail smtp.client-ip=40.107.209.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AkYaxgxA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vA7fbmSmtTNaUH5QfXc5gcO7Skg/XhbeoDM6/utxRSgQmqa87ZUecdk4EQ0FSKZAjGj0KfLfyrM5R9fp9yv4v6AS7XrGOEjG88ERFBZY2uFhgI5d0v0y+bWodNMXtMfQtl9bAKeixc9NFRWhH7SfLtM8GQpZUf5DFOeUz5bObpgLH5iUSav92A6C3lvGkIOZ4uSLUfyfLr9O61IZqxvdnOL/hsKbthWg1K1M/QLBZk40D+8i2lA51F+sJIFi9hhRocQ+Vqxp8+tyYyD+Ca+ffDw8vSrxs+1YU7vcWNP+obmZHj9VXWaWOBj6ria6tVusBrMopoFB3hfUfvhQ+tuDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/QawyciRIeQX9g8H0S5//9hsEITJgkW+8KhO0RUle4=;
 b=lfMI6N6Tqfo3u2CYj1Xq2lWiJP3zQC2ZSEgIH2bVHajvUFGuIWDeze8NQPYUM6dk62Ppe1XLWDh56mLDA34fdEc4vggBzScx6vAQHieM8oVKtYG2DkoHLkjBzXuCP5l2sWY5iayID7B0OmsCopSXJPj2DOvAV+E9vx0oKtHJtsMwKsWPa9nOq6vhu9clWE0UTStyUKi7M21+9kDBXlX1IYIdtnlW59OPlFYSJxGbL4J/BaFZaByeZ8nkOuymG8068IiJoZYGmT8NaJjwSqMuSIejPLJQgTbE11Iq3bkLbfOxzjJPCM+z8EAd/NeJNQn8T6LUXM/Hw3GYOw2lNADoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/QawyciRIeQX9g8H0S5//9hsEITJgkW+8KhO0RUle4=;
 b=AkYaxgxA2mf/OuAyZhMN3e6j99UtZ+NsyTlU23Jb2NiXi9O/BOaIxKlrmKs+n/e9JKoYX5LMRh2pFirAvdJVCooRIG1fSKjZ6MiqqZy0Ms8E4mDgn4Ht8vsujrx6UHl5XVQGUPrc9P3MFrTtcuvXO/QMWBdgjCXPdS5eevt7zf6U3gkz+7yV95byv8MjEwn5nuUBGrRCU9V7SGsCQzhZC5RL24DQ/+6aaXX8eskMKAaBVEFEuGQsH2z/wa3E/lrsroRL8eJIYEVE64XwtgEHS5oJAhY8kOOUb+wnNleJYG60SnpzhyDQh+JeVS79GLS46Smcbx+Faz5WmzyFPhauLg==
Received: from BN9PR03CA0450.namprd03.prod.outlook.com (2603:10b6:408:113::35)
 by SA1PR12MB999229.namprd12.prod.outlook.com (2603:10b6:806:4db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:08:06 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::50) by BN9PR03CA0450.outlook.office365.com
 (2603:10b6:408:113::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 12:08:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 12:08:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:07:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:07:47 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Sun, 4 Oct
 2026 05:07:40 -0700
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
	<alex@shazbot.org>, Peter Colberg <peter@colberg.org>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v4 1/9] rust: pci: add internal SR-IOV enable and disable helpers
Date: Sun, 4 Oct 2026 15:07:22 +0300
Message-ID: <20261004120732.1045629-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004120732.1045629-1-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SA1PR12MB999229:EE_
X-MS-Office365-Filtering-Correlation-Id: 162209f1-b230-43f2-3805-08df221025ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|7416014|82310400026|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	eBRzdaAEd8BUNB37wqwPiRlDtKO98vqEHQoSNZk9eonUqnyMRa06qU/CRz1S1eMZeZVWVnzLSAZQhxBVQl2uycB/klKmMw0aVSlEHDHLzjO9aIBn7gh2Ugv8mmOpOa2JMF3vU7LI/Tu72lM06M8LTLV5IGFaVAygMbapmJ5LxOtXBsZ/F7ZxX0NDUsr4KmnEMGbNvmPkpLNyd2DybjW3tFD8fmDDFG6KwVsXEP+Ue1E3skj1dbrMqyY/5Tdj+PUCt9X52oT99LnSHYrd6vKqUY24hdADJ1kH/lDloUuQxkAdRKMSAXhG1xTQcnvQej1jESfv1ZEWzU1EcEqVRaRocOUJcyY8SA7Bell8cZvMIwWAcWlrgd7qo7kvzyD4lr8s9VRf8xgf95ktQgvwDXP3GC4jePiMEgKOtd6xrqPVtL04gz6QDTqBNe8Ow/5QY1+UR01slwa14kMz9rmDzBtC+v0jwp6zmFGzAPRt6FVjwNFxvX7/rR1M4+csrT4fcJrXNXgfedGjna+j9qYrNow9rhezmUYd57DmC3GQN+cacf+MTw6fmJ1t/Xu5I4j9hyIPxaptStGWsi2qnNUMR3dm4RiCouTNfMexpGYKvdq9lKOK0MtGHPus38CyBG2zDZJEIhw2gxC7qyGt+05PiqYbFm8DIIhIF/YB6bAKysJNVYxe38PkN/4xXf+fGc6eCEAaHd7NeHCcQj9r70sDFQg7Dw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(7416014)(82310400026)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9C2l6m8qfSmQmS0pR/BA1fiIii4NeROdmR0Fqb4qFRRP8hvynZ0Uem+L3NXP/No6kZePEHVzJpYpW7Apaq2uuIyXtgwSvS+qIw9CCfYvY5zvDWo3J6oR8C1sJZPvT/em4JMpd5uhbHjd4s6Uu53ToMEm3d3y+N6htWRYoFGDB7KxnJB6ZKdoN3ZsVWM5q6j5VFOL6zW2YIMinUb/LvYFLO6mLaWNAryGc46qBZkqTUZW8fM66tdmfFgp31agvVe6a/05OMh9vuOs0GMSPTw29+o2yaQwDOspj3GfTIIz+sZD1Qv/y/PoNEs+68LAYSGqp9XMVrFuFNTyIhdh04j7KWRLv0c5PW2p4DxXgcTi5oCyUkuRWAccj4JZi2vG29Uln+wWA/Qp0Bqjw6ckVFQDEj9LOx/gNnYmZMZidhMDZBUgBqEtWy866uNbATBEbDll
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:08:05.9011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162209f1-b230-43f2-3805-08df221025ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999229

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
index 000000000000..1af5bdc19830
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
+    pub(crate) fn enable_sriov(&self, nr_virtfn: u16) -> Result {
+        // SAFETY:
+        // - `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // - `pci_enable_sriov()` checks that the enable operation is valid:
+        //   - the device is a Physical Function (PF),
+        //   - SR-IOV is currently disabled, and
+        //   - `nr_virtfn` does not exceed the total number of supported VFs.
+        //
+        // - The [`CoreInternal`] device context inherits from the [`Bound`] device context,
+        //   which guarantees that the PF device is bound to a driver.
+        to_result(unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_virtfn.into()) })
+    }
+
+    /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
+    #[expect(dead_code)]
+    pub(crate) fn disable_sriov(&self) {
+        // SAFETY:
+        // - `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // - `pci_disable_sriov()` checks that the disable operation is valid:
+        //   - the device is a Physical Function (PF), and
+        //   - SR-IOV is currently enabled.
+        //
+        // - The [`CoreInternal`] device context inherits from the [`Bound`] device context,
+        //   which guarantees that the PF device is bound to a driver.
+        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
+    }
+}
-- 
2.53.0

