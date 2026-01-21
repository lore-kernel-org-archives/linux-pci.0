Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF92381710;
	Wed, 21 Jan 2026 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026998; cv=fail; b=ORuBySEWp8tcZapSTVoJqa/PwCA0AQbVjPxff1DjZbij/j4YmPa8rm5B5xInTAHde++P4XqjT6R2B8Sav3lorsGGcwWukDM2TwO8PAeIGcpbnfV6GJSTiWC8K7z4dsY4IIthQb8imDlNwkSF9NhE+HvzQJ9djSQ/Dl7aoVzQUR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026998; c=relaxed/simple;
	bh=ea8SfwPHfXrd9Vn0IHe8ZEfIBNmof2pO7ZliIqAN558=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=id7RImzi8qQ+UfMrDWsnlP6UiisnNNAl2zcjsQz29pYqKQJ0S2v6U8KCgkXtsenOoSLaUlXU+2lPv36F0y91npaqIp2q9uQipsXoCTikM1AcxgVDYAVQkr3cePRlNKs1fINC09y+Pjwk3TCIZH/XduDFRvfVwLztAOmrYtXQ9j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pVDn2KzF; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pVDn2KzF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdeASngR8bJRv3wUfvkph5uUrOE3kuszzh2ggX1+097Mnm1dfAE22KuBI0iI+Rxri2ar/BLZwJVrCePde6YXUOYlCeACHMbiMZWVwYvM5/Deg1lJ9n9FEdqTMSLJs94dSA3on0jzVLmevZ/jPffysiCI5q5wTYn08XbFzRcJxGcnVu2GCNuCh0ZMsPpfUf8taWCCq70CQy2/R3twY4I2FBmiGt1ZTm6zTv1ELddQYMPPxyCypvDX176i0xOTPzJOS7F8M+V8p6lWtD6IXPQxK/e2EYKJRNzujSh9W2BuTzUc+4Iz1L5Uo+6HbBU655LIdmQKeFFiAWG+I+AxNJU6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Qe1Pdnfw0CCAjk62etWuE115kRttKl7phAQm5Sgw7k=;
 b=BDLZJj87Tsk4aQFFkVTk1+pd2KE6v6qhbJee4mRLrh3RnXOodytIGnpAHoGUaBPLzYLqe0xTjwRwIgMR+sOYQqZBv/eBJtxa6FaKzITyHgB+FmFI5TeTF4N113ummjXGCluuAzmsKmlO08RKNtn5OPB0X5Pk6Y2MZ7KpcX208nyEiqzN75jnGyHyhbbo3g35WO6p9CKmzAXL1lpK0W7oQQi1oJ2fDZ3rmCkDBwH/C9VlNeUBJIw7dlXlVq+PalRre8HP87mVACxCjx7YDp8uq08JnUQGznUaPwMSFdeCcDMV2SAGFujSWZCL3RYOf6pH0x2DowTlyMawT6lMHK7M2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Qe1Pdnfw0CCAjk62etWuE115kRttKl7phAQm5Sgw7k=;
 b=pVDn2KzFSNbaDqco752s/f3WUbwuDU9okW7ayMKNaxYqZN3MnflBPzOcZgN3fosEnR0nnVsKDfM6FEEnwg7ZwyFxS7otolLH8iHwmLcQhBJ1za388HW4RDIeF/tj2XWqj990KmX1yObyQVDQ2DUuJ4GTLFwPc9AuGQ9Rf2l//O6Z30Jeh9F4kpBsgwsFNhn0VdTat5ubt5X/mwnoiiKZH+A6M5nGb2nbUc2aKnvsWagVUlt0t+JBSz7cC1wqRWxwQqqSY/L9eGR6GgPI8sJxnhurMVIvSm3/nCDOetkUmEjv06tKb+Ybq9pqzk6uI7HHwqqYQi67FS5Dv3/wNSHbvQ==
Received: from CH0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:610:e7::29)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Wed, 21 Jan
 2026 20:23:03 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::ab) by CH0PR03CA0234.outlook.office365.com
 (2603:10b6:610:e7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 20:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 20:23:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 12:22:46 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 12:22:45 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 12:22:39 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v12 4/5] rust: pci: add config space read/write support
Date: Wed, 21 Jan 2026 22:22:10 +0200
Message-ID: <20260121202212.4438-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121202212.4438-1-zhiw@nvidia.com>
References: <20260121202212.4438-1-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: fae0f731-5f81-474b-d952-08de592ae10b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnRscVJxNkRMTDZoTW5Kd3lnaWlVQ3JXeVJkVytoSkdCTGhuS0xHVGZmTVQ0?=
 =?utf-8?B?dTQwUkh4eFRnWWRuMmJGaVNjT0YybUVsSVRqdUhpYUJqVDE2ZWJDU3hFNFVE?=
 =?utf-8?B?NjdCT08vSnFwNnlLWStOVjdMYmJIam1OTi95ZWFZQ3dWTEs3ZlRrRTc1T3VP?=
 =?utf-8?B?UUlTeXlqVnc5U0lQTmxBZWlEZnBpcEg4NmhpYzlrT0haL3BtRjJUTmtCOFVV?=
 =?utf-8?B?emtYd0NxV1dRRi8ycnUxL3luTll5OWI2U1BkTFdGQzRoN0VjUFNORU96YTVt?=
 =?utf-8?B?dCtTMVZKRnlGTzFYaVcweW9wUHM2OGU0N2VNbCtSVkJKeFVVNWNDclFqMDN4?=
 =?utf-8?B?ZUFLSTN0Tk1WMG1ibDJMM3RxK0ltZFRrb1pHbmtKT3dNN0hpd2VvNTVYVHJ5?=
 =?utf-8?B?WGJrQzBjb0xDOE5vVHpoVndiYkUwNlkxamFoNHI0aVlwakFkSUpiMSt6MFZ3?=
 =?utf-8?B?MFNOSWFCLzd3L0pTTlYzQlB1L1ZJL1hISmhEREwrOFVQbW5QOTZzY2VuVmtV?=
 =?utf-8?B?dTR2bTVveVNPRmtRVmxvbFpCKzMwc0cxUzJQMWdFd1JQMkJ4aTl5b0FzRkZG?=
 =?utf-8?B?WTVrSm83S1JabnNFMGQ4b01qNXBnUUFEOUdSdWlzVkhmNUgvNHZzSXFOeE91?=
 =?utf-8?B?Rmlld2NJaVZDMmoyeVlQdWlTQ3JPZ3c0a1lQdVE3MUF5OUxveHFHTzlQRmlp?=
 =?utf-8?B?Tmd5RWh6NkhvTy91T2E4MDdGSm5EOEZ2UmYvdUdoS0M4YWFBcFZUcEwvdkJW?=
 =?utf-8?B?UlJMNTZkZUY2aHpsdDdkYU1lL0VVcTdnekpFWTBVblZMdWpnU0V5MVZWRTZW?=
 =?utf-8?B?MTE5R2dTVlFSREJtWWMzOVFVa3h1dkpJdGxVY3ZGY1A0Qld4MUtKK0gxdEFu?=
 =?utf-8?B?QTdsZUd3NzZqVFJoS0R1N09NQUJUcGRwaVc1MXgzejVSRzRHR1lseHkrNnR3?=
 =?utf-8?B?aGR3ZGVVY1E1ZUpZMXJyR2l4OFhua2RvM1phUmxhMTJHeSt3OHR1V1hwNHNL?=
 =?utf-8?B?TlVEN25XT3o0T2V2TElyZUc2U0kvN1NoQ3RNWjBDZkpDcjdodHZoSE1paHg3?=
 =?utf-8?B?amFjOXRMbkovRmdxYUFiSHY1dEs4TzBzUW9VWm9uTWk1cStQVCtjKzBJVXI2?=
 =?utf-8?B?aEZhOWo4MlV6akN2K1JUSU5mT0pYMllrT0VqZHNObjlldXFiR252bXMzdEVs?=
 =?utf-8?B?Z2U1Z2UrNjljak1kbnpqa0pIK0ovSWU3dG9EQ2Z6c0poKzJDamJDOUdLNWxz?=
 =?utf-8?B?WTZSWlV3a1ppUk0vUytsbmwyWnV5NlJTaE9TUGFHQlBRZTlGQzRPUzdmR1VJ?=
 =?utf-8?B?cWM1NE1jT2xrYm9xNVUxOG53eVIvRHRZRklRN1l6eG9ZTmZPNlh2Rit2bSs1?=
 =?utf-8?B?ZFFjYTAzVFBkS0hzSG5hWm5RTnJPclZ3N0hxRFR3VW9uRnlDK2laOU01ZEFE?=
 =?utf-8?B?Q200WDdSVEpyT2xiTFcxNi9tcUZOTVpndUdpQ2FiM3dyNUw3WjVaT1NEd0xD?=
 =?utf-8?B?c3VJMFlpKzZvUGVnMjRRUXdNcm1hK2gzYzlIQ253NnNvUWFMczhUOUNaK3By?=
 =?utf-8?B?VWtPcFp2Z21kRWlHczNNUHh2UzNmMFU0U2lHSWZKcmZOdGJKZ1c0eWhlczdX?=
 =?utf-8?B?bWQySUVuMFNpdTlYNkxyRzk4OUJNTENsYlFiZkhSLzNZU1dra1B5aDZEdWow?=
 =?utf-8?B?R21qL0MySkZXZThGUVArWENBS3ZPc1NaQ0FHWXprcUZRYnY3cHJIUzJzWks5?=
 =?utf-8?B?cmNrZlZvdGR1RmZNV0p5Y1IrU1BLYzBiV1BhTTErMkx0NzJvOTZramF1R3lM?=
 =?utf-8?B?SGVSQnRmaFlSWjhsZVhNN3JkWXF1RU11ekEycnJuSUpDQ1k4UlJKWVF5L09X?=
 =?utf-8?B?Y1RXSGMzWGZEclVYWlBWY0V2R3BjVVdaU09MWlJVRjF2dWl4bmVFRlRmM1RZ?=
 =?utf-8?B?Yk1ndFRGSzFLajhFWW5Xd3gvOWt4WVRHQmxhQnRyWVpYeWFuVzhWWElFdENu?=
 =?utf-8?B?ejdLZTdYOWVKT0x1VFRJd0h4elJONCsyc1QxNGM3azFJdEFyVXhQTUlxNUh2?=
 =?utf-8?B?eXdqbk5Xa1k2eHZNK1BHZTZVb3kxbnRBMENIVldMQThlajN0YnhZdjRKMWlt?=
 =?utf-8?B?Ny9GY1U2Wko4emlmY3Z0bEF6eEpDeWptSmt1VmJka2ZIVkpqQXhzc0VxSGsy?=
 =?utf-8?B?SGVNdUE0cW45Z0FkSXlZaGE2eksxV1N4UXdTVlFZSXpla2d0NGJ6RTNZN05p?=
 =?utf-8?B?ZGtnM25kaXpWN2pxQmRPM3pIRkJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:23:03.0979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae0f731-5f81-474b-d952-08de592ae10b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775

Drivers might need to access PCI config space for querying capability
structures and access the registers inside the structures.

For Rust drivers need to access PCI config space, the Rust PCI abstraction
needs to support it in a way that upholds Rust's safety principles.

Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
accessors for PCI config space. The new type implements the `Io` trait and
`IoCapable<T>` for u8, u16, and u32 to share offset validation and
bound-checking logic with other I/O backends.

The `ConfigSpace` type uses marker types (`Normal` and `Extended`) to
represent configuration space sizes at the type level.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs    |   7 +-
 rust/kernel/pci/io.rs | 167 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 82e128431f08..9020959ce0c7 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -40,7 +40,12 @@
     ClassMask,
     Vendor, //
 };
-pub use self::io::Bar;
+pub use self::io::{
+    Bar,
+    ConfigSpaceSize,
+    Extended,
+    Normal, //
+};
 pub use self::irq::{
     IrqType,
     IrqTypes,
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e3377397666e..39df41d0eaab 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,13 +8,149 @@
     device,
     devres::Devres,
     io::{
+        define_read,
+        define_write,
+        Io,
+        IoCapable,
+        IoKnownSize,
         Mmio,
         MmioRaw, //
     },
     prelude::*,
     sync::aref::ARef, //
 };
-use core::ops::Deref;
+use core::{
+    marker::PhantomData,
+    ops::Deref, //
+};
+
+/// Marker type for normal (256-byte) PCI configuration space.
+pub struct Normal;
+
+/// Marker type for extended (4096-byte) PCIe configuration space.
+pub struct Extended;
+
+/// Trait for PCI configuration space size markers.
+///
+/// This trait is implemented by [`Normal`] and [`Extended`] to provide
+/// compile-time knowledge of the configuration space size.
+pub trait ConfigSpaceSize {
+    /// The size of this configuration space in bytes.
+    const SIZE: usize;
+}
+
+impl ConfigSpaceSize for Normal {
+    const SIZE: usize = 256;
+}
+
+impl ConfigSpaceSize for Extended {
+    const SIZE: usize = 4096;
+}
+
+/// The PCI configuration space of a device.
+///
+/// Provides typed read and write accessors for configuration registers
+/// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
+///
+/// The generic parameter `S` indicates the maximum size of the configuration space.
+/// Use [`Normal`] for 256-byte legacy configuration space or [`Extended`] for
+/// 4096-byte PCIe extended configuration space (default).
+pub struct ConfigSpace<'a, S: ConfigSpaceSize = Extended> {
+    pub(crate) pdev: &'a Device<device::Bound>,
+    _marker: PhantomData<S>,
+}
+
+/// Internal helper macros used to invoke C PCI configuration space read functions.
+///
+/// This macro is intended to be used by higher-level PCI configuration space access macros
+/// (define_read) and provides a unified expansion for infallible vs. fallible read semantics. It
+/// emits a direct call into the corresponding C helper and performs the required cast to the Rust
+/// return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the PCI configuration space write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the value to read.
+/// * `$addr` – The PCI configuration space offset to read.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_config_read {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
+        let mut val: $ty = 0;
+        // SAFETY: By the type invariant `$self.pdev` is a valid address.
+        // CAST: The offset is cast to `i32` because the C functions expect a 32-bit signed offset
+        // parameter. PCI configuration space size is at most 4096 bytes, so the value always fits
+        // within `i32` without truncation or sign change.
+        // Return value from C function is ignored in infallible accessors.
+        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
+        val
+    }};
+}
+
+/// Internal helper macros used to invoke C PCI configuration space write functions.
+///
+/// This macro is intended to be used by higher-level PCI configuration space access macros
+/// (define_write) and provides a unified expansion for infallible vs. fallible read semantics. It
+/// emits a direct call into the corresponding C helper and performs the required cast to the Rust
+/// return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the PCI configuration space write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the written value.
+/// * `$addr` – The configuration space offset to write.
+/// * `$value` – The value to write.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_config_write {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
+        // SAFETY: By the type invariant `$self.pdev` is a valid address.
+        // CAST: The offset is cast to `i32` because the C functions expect a 32-bit signed offset
+        // parameter. PCI configuration space size is at most 4096 bytes, so the value always fits
+        // within `i32` without truncation or sign change.
+        // Return value from C function is ignored in infallible accessors.
+        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
+    };
+}
+
+// PCI configuration space supports 8, 16, and 32-bit accesses.
+impl<'a, S: ConfigSpaceSize> IoCapable<u8> for ConfigSpace<'a, S> {}
+impl<'a, S: ConfigSpaceSize> IoCapable<u16> for ConfigSpace<'a, S> {}
+impl<'a, S: ConfigSpaceSize> IoCapable<u32> for ConfigSpace<'a, S> {}
+
+impl<'a, S: ConfigSpaceSize> Io for ConfigSpace<'a, S> {
+    const MIN_SIZE: usize = S::SIZE;
+
+    /// Returns the base address of the I/O region. It is always 0 for configuration space.
+    #[inline]
+    fn addr(&self) -> usize {
+        0
+    }
+
+    /// Returns the maximum size of the configuration space.
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.pdev.cfg_size().map_or(0, |v| v)
+    }
+
+    // PCI configuration space does not support fallible operations.
+    // The default implementations from the Io trait are not used.
+
+    define_read!(infallible, read8, call_config_read(pci_read_config_byte) -> u8);
+    define_read!(infallible, read16, call_config_read(pci_read_config_word) -> u16);
+    define_read!(infallible, read32, call_config_read(pci_read_config_dword) -> u32);
+
+    define_write!(infallible, write8, call_config_write(pci_write_config_byte) <- u8);
+    define_write!(infallible, write16, call_config_write(pci_write_config_word) <- u16);
+    define_write!(infallible, write32, call_config_write(pci_write_config_dword) <- u32);
+}
+
+/// Marker trait indicating ConfigSpace has a known size at compile time.
+impl<'a, S: ConfigSpaceSize> IoKnownSize for ConfigSpace<'a, S> {}
 
 /// A PCI BAR to perform I/O-Operations on.
 ///
@@ -144,4 +280,33 @@ pub fn iomap_region<'a>(
     ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
     }
+
+    /// Returns the size of configuration space in bytes.
+    fn cfg_size(&self) -> Result<usize> {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        let size = unsafe { (*self.as_raw()).cfg_size };
+        match size {
+            256 | 4096 => Ok(size as usize),
+            _ => {
+                debug_assert!(false);
+                Err(EINVAL)
+            }
+        }
+    }
+
+    /// Return an initialized normal (256-byte) config space object.
+    pub fn config_space<'a>(&'a self) -> Result<ConfigSpace<'a, Normal>> {
+        Ok(ConfigSpace {
+            pdev: self,
+            _marker: PhantomData,
+        })
+    }
+
+    /// Return an initialized extended (4096-byte) config space object.
+    pub fn config_space_extended<'a>(&'a self) -> Result<ConfigSpace<'a, Extended>> {
+        Ok(ConfigSpace {
+            pdev: self,
+            _marker: PhantomData,
+        })
+    }
 }
-- 
2.51.0

