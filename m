Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A952FC024;
	Mon, 26 Jan 2026 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769464852; cv=fail; b=nygsNrkh5jIwpsZvGzLkExw29o2yY5Ni/iI6jg+4nHiJg2E49BDGUDBphHrkXn19hI4yABxbQavY5LHn8HkSe3dXMqx4Ycd4lZtbfNlEpM32RT7ALggZDt2hz+i6mWrMIZ/uTneMDheCRQk4ebDL95uzUyCybHlYlYBdUslfM9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769464852; c=relaxed/simple;
	bh=qRBhYq1P2NlEOKovp9/x9vJtLGd/PBImQFJY2qS5Vyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlXkuYm5D6WC0m6KuTBC452t6VS6yZNZuSuan4SzNt0bO5ZPFeUaEmzyLQnsB+F4BeQ2zntOgLuvxM0vK3QN023S1DtUphU34YHOOICVwUrSPO1/r4lo9YNI+Ed77E+XGkMmcWcIIrqkp1w7g86sjyOPlAFl/+qZ1jeIwyH94Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TOGDojOu; arc=fail smtp.client-ip=40.107.209.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TOGDojOu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH2GpqT81kZ5HCZI44i4vY3jujrwx9uKYcQXHsj1bs5+jXvUwReZuNlI/IUSvweVCHFl0RDA9uDyPdsEDaOE5Z8caFB9BZN/ORD87B9oRnACMnnLMpcUFknXxpB7rd3IbtCOafO/JyD1ENkQgoJNNRJk8vUjcSCAjYRFziyiPcevhKtT9tP+L2nHoeNdkqA1sjr4OrddsxS8o6S1qZ4BfsAdMs2SzmRttI8aS+6q2egyksErtOsT/i8nFuVaHrSSJU8KHLP7g2+w8BRbAjQvE3Zmf4DfcAu6cxu130M+gFWtwxhszMpvele05z1sNLJmHriKccHFDpy4jY84PiMqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfMrxCtCw8NscMP9prJecgYgFA+l9RqRkeoeJK5qzZQ=;
 b=aytkOwjl622ZZh0d51F12cbNA28n2SAXJ7zjjQnzRQvdp8aD4A3Df4zol48zYq50K5AXovOiij9Jfx2Da1cvA0JuMnO7EBQvEIxGdPaQGutaws9Q8cwqay4pt6C5gtKIoT4EZgYyTjnKI2bP3WBSaK1M2FbjivebrnQZjjs6qhaWV7aGMwglkNxSu1oc0x/ncO+viL19aeYFnk6kkFGkMAId/C6k2wib4MLYbs3iF4MyRrklYPy3Pz5yfq1xQ618v82ea4gstdnKWRNPeKqQO9MJRWdfnYo0ZHPfiJ5lgBSvLklRi+aE8n8jqp/eZ3UNxbsPojwEmd8LQYh3+ExznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfMrxCtCw8NscMP9prJecgYgFA+l9RqRkeoeJK5qzZQ=;
 b=TOGDojOuV3l10HI9j2ELKKznUazf/rEEeagzhNZ/yPK/TaLlmzXlhvBoTU/TeqWzTovhIwmR6LjSSMvoS4nT/Oxnp8dGbBs0Lo603M+XaXXtokFud2domxECilA5Gn5V290wmFh4XF+Ro6+oXTtWUUWmgfcRJW6CAgi8boPAuaBiGZIIiCT09wAwsm7RzFpMkZm7HpabsiiwLAOvE4RV9kO4pAVpxUTK+r3JI7hu4q0eDEB1QFwwcJ6X88W9Zj98DiiQgGnh/99eqySHa1qP3AI8m+qtOCNUzeTR0UQjWLaLYF31smJcMmPgc0noJAZrEo+STM4YkSshTQrc6Wcrig==
Received: from MN2PR19CA0047.namprd19.prod.outlook.com (2603:10b6:208:19b::24)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Mon, 26 Jan
 2026 22:00:45 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::c6) by MN2PR19CA0047.outlook.office365.com
 (2603:10b6:208:19b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 22:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 22:00:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 14:00:18 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 14:00:18 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 14:00:12 -0800
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
Subject: [RFC 2/2] pci: Add PCI capability infrastructure and SR-IOV capability support
Date: Mon, 26 Jan 2026 23:59:57 +0200
Message-ID: <20260126215957.541180-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126215957.541180-1-zhiw@nvidia.com>
References: <20260126215957.541180-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 537f8885-59b0-41cf-9cba-08de5d265aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6CoJSCxqlhwKCJASnqecRsoIRows0WyXlSuJ0LOXR+CJQ1d3B0DreleTpgAB?=
 =?us-ascii?Q?VQkZisJpBCViZNTduCVy32Gbs8FGhOLM5HDQWdZdB+t1HwpfnBRW+SYXPr0p?=
 =?us-ascii?Q?pu3KRIzO12JAHfCYPJjURgfdEmcsDTJOxqOw1JpT668pqLCRsa7tog0x0eAt?=
 =?us-ascii?Q?+4cPfL4wY8KGQ3gk1sT9cmhh6XX/lVB/ej+2T+a3pMm/GDKySPYTxxg1maUx?=
 =?us-ascii?Q?hpM4K0oQEHrZnYS/y+zuvDNqOJkzgaNjf8mxCgNLXF7iwOTXH0vO2dMswYDu?=
 =?us-ascii?Q?Q04Z2CreCXv7mOSn01tOx0d9ZwxJthLmcUiF6YKlp7zb5FIPs1I5Q5dRdX1p?=
 =?us-ascii?Q?ynPuG9UJdml4PBBtI1203XrhGY9XHMq+/bDM+vVDFqiRFySt57nsVK+fIjVX?=
 =?us-ascii?Q?pJNQTpohPYL4pGxb/RcJmNs1oHNjjK0Wbc7tvrhgN4i9FF2Z6I09GqaCUUNo?=
 =?us-ascii?Q?V7252L0EQMvycbtgIJSY7rxf4Uc0oemvJ6ZDmPHPs6f8frWVK66T756DBFae?=
 =?us-ascii?Q?OpBoe/JdghYaUlTnrY0SN9bzB6lhtrcsTRkvWy1yaHzHYfuHdSc0XtHoXjCo?=
 =?us-ascii?Q?uhtUtd6aWVwIblex1SMOZx/jnTcp/eb68fP/onIPkFUoDfmoId9gb7JwI3fD?=
 =?us-ascii?Q?5O6UBBm/Eo8MMJxOfNUJMrAp8NG6Mp5+AHFrtls0GheTU2eH5es9YfGSndZA?=
 =?us-ascii?Q?Dx9F8otzcIsSQ2IF+ywrFqJ6vNVqh7jSSid9L6KM/IzCCBML/uYcRA8nn4Ft?=
 =?us-ascii?Q?elK7/6CQoT5iBfhvs+yBSDHkypUhEiKm8mj8BhOVrOOjZ+N3HGjtHKIMAAgx?=
 =?us-ascii?Q?ow0aSf0pGix3+lNibj3amwRzkiy7gZWUy98JtWXN8KDiKyZ1bFBiR3G3W3Hb?=
 =?us-ascii?Q?9Wud0WpLrkamKR09R2wMwj17cbhuU0KsfQTfBDlTMyK7+ZKO7T3BJhc4kgRI?=
 =?us-ascii?Q?q2+K8Ui2zNzLJsmOyp1kInKlBAIhZZ2LPnyS9MnpZlPwhdEhpgVgWNk1AHPx?=
 =?us-ascii?Q?/gTUjWt+NYN6ZDTNVWYjNHFLhuT/4g/WkfOiUXg8dlB3ciWL7m62NTkmqnX/?=
 =?us-ascii?Q?wPx+RTAwCHRDn7ziNvNeptZ7qbUjxCIcnF7hP0EbEVODqnj2Fe0rETVX+QRv?=
 =?us-ascii?Q?PTjxbQQhm954r5v+zv2GNyq9xHqWoC/2Q8Fk1LjD3M8ILZ2IsWOwbPSvEgL0?=
 =?us-ascii?Q?nEVSWVk3j1dDVs/yViDjYlUacAusJqjsfGv48b22WCpRrbbs/FUej54EPguU?=
 =?us-ascii?Q?mo6ixqMjvqc5QlvePAXaOzwmDga5/kiFroJyIzkVKb5Ij5M4cq9FDUdF1FHP?=
 =?us-ascii?Q?BN/sDUoECGD+yc9WCtnfY1baP+pdlCXKsmNA1ExM4+oWHQCHOqQR46BiKLgZ?=
 =?us-ascii?Q?BCJOCn6dWjAsE0AhOuYFTfAUvz56IacnnvllJujCaqCAbyDWba8mMxdSjwrc?=
 =?us-ascii?Q?r4FJEEyfrsvYp7cjKskpvarq59o401+iPkVPTpqJqhadbH/1EcJc/wCcs0Qt?=
 =?us-ascii?Q?SGjAshmJVc61J/Qofb30JLyveTRm1vxAlKRWCLHhRSJVKdUcpXp6mRQg1xH+?=
 =?us-ascii?Q?AumWiOfOaAzaDnCynj+7qfiZ2ohNz0OA1ZnerE/k42V5uuoDz+HIUhvZ703S?=
 =?us-ascii?Q?XWKC9ExyRdFC+5lkTmsX4UkjM10XLIRNYhoVvduxCXxcOWd5RjxwikpsGfTh?=
 =?us-ascii?Q?PLWTNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 22:00:44.7454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 537f8885-59b0-41cf-9cba-08de5d265aea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987

Rust drivers may need to access PCI capabilities (such as SR-IOV) to
configure firmware metadata.

Add a generic Capability<S, K> structure that:
- Wraps capability discovery via kernel's pci_find_ext_capability()
- Dynamically calculates capability size by reading next capability
  pointers (using 0xffc mask per PCI_EXT_CAP_NEXT for extended caps)
- Implements fallible I/O via the Io trait with runtime bounds checking

Add SR-IOV (Single Root I/O Virtualization) capability support:
- SriovCapability wraps Capability<Extended, Extended>
- read_vf_offset() reads PCI_SRIOV_VF_OFFSET register
- read_vf_bar(n) reads PCI_SRIOV_BAR + n*4 (32-bit BAR)
- read_vf_bar64(n) reads 64-bit BAR by combining two 32-bit reads

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs     |   9 ++
 rust/kernel/pci/cap.rs | 274 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 283 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index cd46ac12812c..2deb26fb3775 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -31,6 +31,7 @@
     },
 };
 
+mod cap;
 mod id;
 mod io;
 mod irq;
@@ -42,6 +43,7 @@
 };
 pub use self::io::{
     Bar,
+    ConfigSpace,
     ConfigSpaceKind,
     ConfigSpaceSize,
     Extended,
@@ -52,6 +54,13 @@
     IrqTypes,
     IrqVector, //
 };
+pub use self::cap::{
+    Capability,
+    CapabilityId,
+    CapabilityKind,
+    ExtCapabilityId,
+    SriovCapability, //
+};
 
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
new file mode 100644
index 000000000000..e3a903b79299
--- /dev/null
+++ b/rust/kernel/pci/cap.rs
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! PCI Capability support.
+//!
+//! This module provides abstractions for discovering and accessing PCI capabilities.
+
+use super::{
+    ConfigSpace,
+    ConfigSpaceKind,
+    Extended,
+    Normal, //
+};
+use crate::{
+    bindings,
+    io::{
+        define_read,
+        define_write,
+        Io,
+        IoCapable, //
+    },
+    prelude::*,
+};
+
+/// Internal helper macro to call ConfigSpace fallible methods from Capability.
+macro_rules! call_cap_read {
+    (fallible, $method:ident, $self:ident, $ty:ty, $addr:expr) => {
+        $self.config_space.$method($self.offset() + $addr)
+    };
+}
+
+/// Internal helper macro to call ConfigSpace fallible write methods from Capability.
+macro_rules! call_cap_write {
+    (fallible, $method:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
+        $self.config_space.$method($value, $self.offset() + $addr)
+    };
+}
+
+/// PCI Capability IDs for normal capabilities (in 256-byte config space).
+///
+/// These are not currently implemented, but the enum is provided for API completeness.
+#[repr(u8)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub enum CapabilityId {
+    /// Power Management
+    PM = bindings::PCI_CAP_ID_PM as u8,
+    /// Message Signalled Interrupts
+    MSI = bindings::PCI_CAP_ID_MSI as u8,
+    /// MSI-X
+    MSIX = bindings::PCI_CAP_ID_MSIX as u8,
+    /// PCI Express
+    Express = bindings::PCI_CAP_ID_EXP as u8,
+    /// Vendor Specific
+    VendorSpecific = bindings::PCI_CAP_ID_VNDR as u8,
+}
+
+/// PCI Extended Capability IDs (in 4096-byte config space).
+///
+/// Currently only SR-IOV is implemented.
+#[repr(u16)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub enum ExtCapabilityId {
+    /// Single Root I/O Virtualization
+    SRIOV = bindings::PCI_EXT_CAP_ID_SRIOV as u16,
+}
+
+/// Trait for capability kinds (Normal or Extended).
+pub trait CapabilityKind {
+    /// The capability ID type for this kind.
+    type IdType: Copy + PartialEq;
+
+    /// Start offset for capability scanning.
+    const START_OFFSET: usize;
+}
+
+/// Marker for normal (legacy) PCI capabilities.
+impl CapabilityKind for Normal {
+    type IdType = u8;
+    const START_OFFSET: usize = bindings::PCI_CAPABILITY_LIST as usize;
+}
+
+/// Marker for extended PCI capabilities.
+impl CapabilityKind for Extended {
+    type IdType = u16;
+    const START_OFFSET: usize = bindings::PCI_CFG_SPACE_SIZE as usize;
+}
+
+/// A PCI capability.
+///
+/// This type represents a discovered PCI capability and provides safe access
+/// to its registers. All I/O operations are relative to the capability's
+/// base offset in configuration space.
+pub struct Capability<'a, S: ConfigSpaceKind, K: CapabilityKind> {
+    config_space: &'a ConfigSpace<'a, S>,
+    offset: usize,
+    id: K::IdType,
+    size: usize,
+}
+
+impl<'a, S: ConfigSpaceKind, K: CapabilityKind> Capability<'a, S, K> {
+    /// Creates a new capability handle.
+    fn new(
+        config_space: &'a ConfigSpace<'a, S>,
+        offset: usize,
+        id: K::IdType,
+        size: usize,
+    ) -> Self {
+        Self {
+            config_space,
+            offset,
+            id,
+            size,
+        }
+    }
+
+    /// Returns the offset of this capability in configuration space.
+    pub fn offset(&self) -> usize {
+        self.offset
+    }
+
+    /// Returns the capability ID.
+    pub fn id(&self) -> K::IdType {
+        self.id
+    }
+
+    /// Returns the size of this capability in bytes.
+    pub fn size(&self) -> usize {
+        self.size
+    }
+}
+
+// Implement IoCapable for Capability
+impl<'a, S: ConfigSpaceKind, K: CapabilityKind> IoCapable<u8> for Capability<'a, S, K> {}
+impl<'a, S: ConfigSpaceKind, K: CapabilityKind> IoCapable<u16> for Capability<'a, S, K> {}
+impl<'a, S: ConfigSpaceKind, K: CapabilityKind> IoCapable<u32> for Capability<'a, S, K> {}
+
+// Implement Io trait for Capability using fallible methods (runtime checks)
+impl<'a, S: ConfigSpaceKind, K: CapabilityKind> Io for Capability<'a, S, K> {
+    const MIN_SIZE: usize = S::SIZE; // Use config space size for fallible bounds checking
+
+    #[inline]
+    fn addr(&self) -> usize {
+        0  // Offsets are relative to capability base, not absolute
+    }
+
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.size()
+    }
+
+    // Only implement fallible methods (no IoKnownSize, so infallible methods not available)
+    define_read!(fallible, try_read8, call_cap_read(try_read8) -> u8);
+    define_read!(fallible, try_read16, call_cap_read(try_read16) -> u16);
+    define_read!(fallible, try_read32, call_cap_read(try_read32) -> u32);
+
+    define_write!(fallible, try_write8, call_cap_write(try_write8) <- u8);
+    define_write!(fallible, try_write16, call_cap_write(try_write16) <- u16);
+    define_write!(fallible, try_write32, call_cap_write(try_write32) <- u32);
+}
+
+impl<'a> ConfigSpace<'a, Extended> {
+    /// Finds a specific extended capability by ID using the kernel's `pci_find_ext_capability`.
+    pub fn find_ext_capability(&self, id: u16) -> Option<Capability<'_, Extended, Extended>> {
+        // SAFETY: pdev is valid by ConfigSpace invariants
+        let offset = unsafe { bindings::pci_find_ext_capability(self.pdev.as_raw(), id as i32) };
+
+        if offset == 0 {
+            return None;
+        }
+
+        let size = self.calculate_ext_cap_size(offset as usize);
+        Some(Capability::new(self, offset as usize, id, size))
+    }
+
+    fn calculate_ext_cap_size(&self, offset: usize) -> usize {
+        // Extended capability header: [31:20] = next capability offset
+        // Use 0xffc mask (not 0xfff) to match kernel's PCI_EXT_CAP_NEXT macro
+        let header = self.try_read32(offset).unwrap_or(0);
+        let next_ptr = ((header >> 20) & 0xffc) as usize;
+
+        if next_ptr == 0 {
+            // Last capability, size goes to end of config space
+            self.pdev.cfg_size().into_raw() - offset
+        } else {
+            // Size is distance to next capability
+            next_ptr - offset
+        }
+    }
+
+    /// Finds the next occurrence of a specific extended capability starting from a given position.
+    pub fn find_next_ext_capability(
+        &self,
+        start_pos: u16,
+        id: u16,
+    ) -> Option<Capability<'_, Extended, Extended>> {
+        // SAFETY: pdev is valid by ConfigSpace invariants
+        let offset = unsafe {
+            bindings::pci_find_next_ext_capability(self.pdev.as_raw(), start_pos, id as i32)
+        };
+
+        if offset == 0 {
+            return None;
+        }
+
+        // Calculate real capability size
+        let size = self.calculate_ext_cap_size(offset as usize);
+        Some(Capability::new(self, offset as usize, id, size))
+    }
+}
+
+/// SR-IOV register offsets (relative to the capability base).
+mod sriov_offsets {
+    use crate::bindings;
+
+    /// First VF Offset register offset
+    pub(super) const VF_OFFSET: usize = bindings::PCI_SRIOV_VF_OFFSET as usize;
+    /// VF BAR0 register offset (first of 6 VF BARs)
+    pub(super) const VF_BAR0: usize = bindings::PCI_SRIOV_BAR as usize;
+}
+
+/// SR-IOV capability structure.
+///
+/// This structure provides typed access to the SR-IOV extended capability
+/// registers using the PCI configuration space backend.
+pub struct SriovCapability<'a> {
+    cap: Capability<'a, Extended, Extended>,
+}
+
+impl<'a> SriovCapability<'a> {
+    /// Creates a new SR-IOV capability from an extended capability.
+    pub fn new(cap: Capability<'a, Extended, Extended>) -> Result<Self> {
+        if cap.id() != ExtCapabilityId::SRIOV as u16 {
+            return Err(EINVAL);
+        }
+        Ok(Self { cap })
+    }
+
+    /// Tries to find and create an SR-IOV capability from a config space.
+    pub fn from_config_space(config_space: &'a ConfigSpace<'a, Extended>) -> Result<Self> {
+        let cap = config_space
+            .find_ext_capability(ExtCapabilityId::SRIOV as u16)
+            .ok_or(ENODEV)?;
+        Self::new(cap)
+    }
+
+    /// Returns the offset of this capability in configuration space.
+    pub fn offset(&self) -> usize {
+        self.cap.offset()
+    }
+
+    /// Reads the First VF Offset register.
+    pub fn read_vf_offset(&self) -> Result<u16> {
+        self.cap.try_read16(sriov_offsets::VF_OFFSET)
+    }
+
+    /// Reads a VF BAR register (32-bit).
+    /// Returns the 32-bit value of the specified VF BAR register.
+    pub fn read_vf_bar(&self, bar_index: usize) -> Result<u32> {
+        if bar_index >= 6 {
+            return Err(EINVAL);
+        }
+        self.cap.try_read32(sriov_offsets::VF_BAR0 + bar_index * 4)
+    }
+
+    /// Reads a 64-bit VF BAR register.
+    /// Returns the 64-bit address combining BAR[n] (low) and BAR[n+1] (high).
+    pub fn read_vf_bar64(&self, bar_index: usize) -> Result<u64> {
+        if bar_index >= 5 {
+            return Err(EINVAL);
+        }
+        let low = self.read_vf_bar(bar_index)?;
+        let high = self.read_vf_bar(bar_index + 1)?;
+        Ok((u64::from(high) << 32) | u64::from(low))
+    }
+}
-- 
2.51.0

