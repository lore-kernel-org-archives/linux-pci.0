Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A813FFAC6;
	Thu, 27 Aug 2026 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833170; cv=fail; b=CpUabVP9v96LxoxfnPgM6Cpfl+ERa9H/Ux+oYAh1hi8r6VgYnrEwGh3hEZMQBv7XbtTQsYdR4TWVAerbvPftHJZQZQq+a28hy93c8ziQPl1MiWhjP+DnR9h+jOKQw0zHBBD1NTcuqmfxw5/sDEFUtj2lDXiCvuy2W//OBJRR7Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833170; c=relaxed/simple;
	bh=/j62N8aR96zoiauLihSmDbFBewDQoSh0LMCVZjcMX9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGVMp5/fnfqdiocPuHgRbwggLYwbiXXPjF0v05aG2AFUzIL5d7AuaMDFKvBAm2AUOMWILLtkOoV1PG878QgF9jsSQBuN6sDvB53udI+PuC7cG084O3KM3QNO290PlH5qtVStxQyGahlQxE/Uy4lSvcOZZbAGIl8pr3AqLR8JMTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U2/oJR6c; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U2/oJR6c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHe7vEEMIo3qc8JZ6gI1NZhLYobvu1YH/bPxKa5RAFYLZwfVcuGXSO189UxRhSKQbBXQ4yVK+/yc/qIP3V0t24XKE2FOVq/wslQ8DbeqAPNVkOzak/LY3Rpv25Ul/J03lpblxGen3t6Pzoh4ptTIbxBMqC+t6ebtwJUkec5AeJDsXAZivccJE0aoDgxDbSYsZ9WGSkqsox/isVceT23KyH+tUG2JX+IMBe3vmnOdRXb+umTbKKFBts0ovI8Far6eFmfIYB1MOechSfoFS/suFdRamMsEbBIAghYF2M1RQRi5nPbtmaNP4vIUJKqz5glxVX7BDFBW3/nPDk40C1gIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWHazxGqauL3RDnI2NicN4Q93kx782PeT61+Kej/14c=;
 b=dInBjAa2kyDs6zJNORcM0txljNJf582P7Kv8FdSX4G2YEXxq7Er9Xlgj2RLgumaPwEsTcGwqjVz5u0q/lGJ0RUXfktdFFymlxAJNvIAfz5S3ovNaeFZk/D6b7zq5K2E5SYfuMpHFinpws8UdE09ExJTMGK5AQI0OWzL/qvAgeizdUJsuHkCTmEpJmUUetlux0cH/trherSt2/PzyeBoCfmp3OKWrwxgl78QGUk5jzjPiyOQTLdFLsC+aoColx6j0OWXD/9NkP+NiJiKCYf0rqNNQJmwcGiYCEzSjXIJofZiS+GoITFXEG4Q17S2HVZuj8BCYBGulWUDoVLmEJkS5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWHazxGqauL3RDnI2NicN4Q93kx782PeT61+Kej/14c=;
 b=U2/oJR6c0A0ARqURFgCO86gVT+vQ73xaBeItN23+dfyEGb19DVWASlyMQIzrWTtYcR0bKT6gPyFKVZc1ITM1XnfnA0oPb61n72Ds2xvOISF9f7bmLRGHdJlnnBKzB92kbhKOSxwyTX1krJngm+w6ZWemKKtrNq5nvKsrU/XhWm34lNTH9xf5jnQyjpjDkkvafslBSLCrhtJrUP7Nn2CFipnCJw+ja6NgqRKyhTCaY2kswu7E2Fcmiy8f96U9Z+ViKOqtmyDq/BzCPGXq/KooygesuwuN6XdsEEykco2oRfi01s9vJ2aKu8HxuEpRG337+ilNvGGsh2Lgm955TKWjtg==
Received: from SJ0PR05CA0132.namprd05.prod.outlook.com (2603:10b6:a03:33d::17)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 12:19:18 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::54) by SJ0PR05CA0132.outlook.office365.com
 (2603:10b6:a03:33d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.5 via Frontend Transport; Thu, 27
 Aug 2026 12:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 12:19:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 27 Aug
 2026 05:19:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 27 Aug
 2026 05:19:02 -0700
Received: from inno-dell.home (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.46 via Frontend Transport; Thu, 27
 Aug 2026 05:18:55 -0700
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
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>,
	<joelagnelf@nvidia.com>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>
Subject: [PATCH v9 1/1] rust: pci: add extended capability and SR-IOV support
Date: Thu, 27 Aug 2026 15:18:40 +0300
Message-ID: <2e9d992509299c2f13de48109c4c933f53817acb.1787830828.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787830828.git.zhiw@nvidia.com>
References: <cover.1787830828.git.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: ec53d425-5298-4221-68c5-08df04356aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NnQU6QLvJGozttffqCqcghkecpRMwdXNpFOuMWXlik5M36ZPvSVKHseoDESUAZRHc3oPSy5WcB7j4X/M6LDScEnSBC1vb1bXls/+U6MTnjohqGBaz4s0pH9p0EZp11oMLnhAfpwj16KMxbBacopCTrJl8gyFNBQKGB+h7T9Ut+q4ckPcikY9bL9Aiwvq0JLXLF2q1w4Cdk8cXtR6b+uOpL6Kek7EGaN6Bq5/WvUnwf2VU2GvRyo/IZwAOv1bp1LeN32xVLTsxOIakPdOOGaD0JJrCmtUzKQdpWwqlx6yLqEAkTVomaBDnF9UcYbhMfAP1NFTMDCIAgjzYfNAAcZbOsT6jkKT7JKoQDL83ukAusr9FxYlgguJgpR2fDm47c2iYEcdymklI4TefdhptOQhob5qsMH8i79961JNRS9Vl9dLDX4npmk04tPdEApjms15CzVMgnMPlKs9hQozHiL07UTyfWsifZEtQ+7bqzRMb36bkPPttIiaBGjMdsyIDxkBPTLTXppxjSpXD4gEaJcYs3h7w01ozy0ds0B68gmRy7lr9EtwYW+3myr2v1F4PeCvfsP5mjwxE4Nr8OP/HORi1QDXkhie4iB9CGWB2Na8lKgPlditihEP30h4tB41FUy2+QgGsjmfFvhQTc0vPajPieu8aXfNn1mEEzAPfvkuyLAjxMa2zckXhqiUDSo2cnh64dpidhFsR2HgDV4L84ynzw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pL/CjtKihgN2GQd9wogYhQJFEyi0epFydyBPmxnL7GiBnob45IzBZdA2aSZ/YhW/WSOfNXDeBvPbxMJLUstjJfw1WVoIEG5Zma3lfxl2y2iShL5758soZDvtg/GECbo6zkQuz30PNQJlL6Abx7dmdtTFJGRMcriFgZOvodGBMYISpako6/syrPayKEz09IVoqPp5WnDQ1Ck5oFx3mAY0x5qp6XWjxeGIFJDqbOnkA+uc17JWtGhzA3DUvgMbbdsHabe9e3NVL5Sqab5qojUexNTfbcklIQ8gFui/lyGaidPiq5FeGAo8aKKoezui8aw1c4vjCrK31EuqPGSYoLMEGvw+/Mzlpg2YvMAxtIXq0kTuXpmIBT1MR/FLMDrCc6GZ4Vzj4JjCnwBuusqLzFNTDQkveBRfbNOTtPTP7dNlmRtuRuRE05O7MzJzeuX4hm/x
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 12:19:17.8657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec53d425-5298-4221-68c5-08df04356aa7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714

Rust PCI drivers have no typed interface for locating and accessing PCIe
extended capabilities.

The SR-IOV extended capability describes VF topology and VF BARs. Expose
this information through the Rust PCI abstraction so drivers can use the
existing typed configuration-space accessors instead of raw bindings.

Define ExtCapability to associate a capability ID with a register layout,
and add ConfigSpace::find_ext_capability() to locate and project that
layout. Bound the view at the next capability or the end of extended
configuration space. Add ExtSriovRegs and a decoded VF BAR iterator that
reads and validates all six VF BAR register slots up front, yields decoded
BAR addresses and widths in logical order, and keeps the raw
configuration-space slot advancement internal. Since PCI_EXT_CAP_NEXT() is
a function-like macro, expose it through a Rust helper.

Keep raw SR-IOV registers private because PCI core owns their state. Expose
the current First VF Offset through a read-only accessor because the Nova
GSP ABI needs the raw 16-bit First VF Offset in Routing ID space. The
pci_iov_virtfn_devfn() helper instead returns the low eight bits of a
calculated VF Routing ID.

Link: https://lore.kernel.org/rust-for-linux/20260818084633.1673214-2-zhiw@nvidia.com/
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   8 ++
 rust/kernel/pci/cap.rs | 290 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index a714cc2bfb7a..502f56e02fcc 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -29,6 +29,11 @@ __rust_helper unsigned int rust_helper_pci_irq_type(struct pci_dev *pdev)
 	return pci_irq_type(pdev);
 }
 
+__rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
+{
+	return PCI_EXT_CAP_NEXT(header);
+}
+
 #ifndef CONFIG_PCI_IOV
 __rust_helper unsigned int
 rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 3ec897709e89..77c52fe59551 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -32,10 +32,18 @@
     },
 };
 
+mod cap;
 mod id;
 mod io;
 mod irq;
 
+pub use self::cap::{
+    ExtCapId,
+    ExtCapability,
+    ExtSriovCapability,
+    ExtSriovRegs,
+    ExtSriovVfBar, //
+};
 pub use self::id::{
     Class,
     ClassMask,
diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
new file mode 100644
index 000000000000..74cd9e50e919
--- /dev/null
+++ b/rust/kernel/pci/cap.rs
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! PCI extended capability support.
+
+use super::{
+    io::ConfigSpaceBackend,
+    ConfigSpace,
+    Extended, //
+};
+use crate::{
+    bindings,
+    io::{
+        Io,
+        IoBackend,
+        Region, //
+    },
+    num::{casts, Bounded},
+    prelude::*,
+};
+
+/// Number of VF BAR register slots in an SR-IOV capability.
+const NUM_VF_BARS: usize = casts::u32_as_usize(bindings::PCI_SRIOV_NUM_BARS);
+
+/// PCI extended capability IDs.
+#[repr(transparent)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub struct ExtCapId(u16);
+
+impl ExtCapId {
+    /// Single Root I/O Virtualization.
+    pub const SRIOV: Self = Self(casts::u32_into_u16::<{ bindings::PCI_EXT_CAP_ID_SRIOV }>());
+
+    /// Returns the raw PCIe extended capability ID.
+    #[inline]
+    const fn as_raw(self) -> u16 {
+        self.0
+    }
+}
+
+/// A typed PCI extended capability register layout.
+///
+/// Implementors describe the register layout of one extended capability. The layout must start at
+/// the extended capability header, and [`Self::ID`] must identify that layout.
+pub trait ExtCapability: FromBytes + IntoBytes {
+    /// PCI extended capability ID for this register layout.
+    const ID: ExtCapId;
+}
+
+impl<'a> ConfigSpace<'a, Extended> {
+    /// Finds and projects an extended capability into its typed register layout.
+    ///
+    /// Returns [`None`] if the device does not implement the capability.
+    ///
+    /// Returns an error if the capability is present but its register span is too small or
+    /// insufficiently aligned for `C`.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::{
+    ///     device::Bound,
+    ///     pci,
+    ///     prelude::*,
+    /// };
+    ///
+    /// fn probe_sriov(pdev: &pci::Device<Bound>) -> Result {
+    ///     let Some(sriov) = pdev
+    ///         .config_space_extended()?
+    ///         .find_ext_capability::<pci::ExtSriovRegs>()?
+    ///     else {
+    ///         return Ok(());
+    ///     };
+    ///
+    ///     let first_vf_offset = sriov.first_vf_offset();
+    ///     let mut vf_bars = sriov.vf_bars()?;
+    ///     let bar0 = vf_bars.next().ok_or(EINVAL)?;
+    ///     let bar1 = vf_bars.next().ok_or(EINVAL)?;
+    ///     let bar2 = vf_bars.next().ok_or(EINVAL)?;
+    ///
+    ///     Ok(())
+    /// }
+    /// ```
+    pub fn find_ext_capability<C: ExtCapability>(&self) -> Result<Option<ConfigSpace<'a, C>>> {
+        let offset = usize::from(
+            // SAFETY: `self.pdev` is valid by the type invariant of `ConfigSpace`.
+            unsafe {
+                bindings::pci_find_ext_capability(self.pdev.as_raw(), i32::from(C::ID.as_raw()))
+            },
+        );
+
+        if offset == 0 {
+            return Ok(None);
+        }
+
+        let size = self.calculate_ext_cap_size(offset)?;
+
+        let base = ConfigSpaceBackend::as_ptr(*self)
+            .cast::<u8>()
+            .wrapping_add(offset);
+        let ptr = Region::<0>::ptr_try_from_raw_parts_mut(base, size)?;
+
+        // SAFETY: `offset` was returned by `pci_find_ext_capability`, and
+        // `calculate_ext_cap_size` bounds `ptr` at the next capability or the end of the extended
+        // configuration space. `ptr_try_from_raw_parts_mut` verified the region layout.
+        let capability = unsafe { ConfigSpaceBackend::project_view(*self, ptr) };
+
+        capability.try_cast::<C>().map(Some)
+    }
+
+    /// Calculates the size of the extended capability at `offset`.
+    ///
+    /// The capability extends to the next extended capability, or to the end of the extended
+    /// configuration space if it is the last one. `offset` must be a DWORD-aligned offset within
+    /// the extended configuration space returned by `pci_find_ext_capability`. Returns an error if
+    /// the capability header is outside the extended configuration space.
+    fn calculate_ext_cap_size(&self, offset: usize) -> Result<usize> {
+        let header = self.try_read32(offset)?;
+        // SAFETY: Pure bit manipulation, no preconditions.
+        let next = casts::u32_as_usize(unsafe { bindings::pci_ext_cap_next(header) });
+
+        Ok(if next > offset {
+            next - offset
+        } else {
+            self.size() - offset
+        })
+    }
+}
+
+/// SR-IOV register layout per PCIe spec (64 bytes starting at cap offset).
+///
+/// The raw registers are private because PCI core owns SR-IOV state management. Drivers should use
+/// PCI core APIs for operations such as enabling VFs and querying their topology.
+#[repr(C)]
+#[derive(FromBytes, IntoBytes)]
+pub struct ExtSriovRegs {
+    /// Extended capability header.
+    _header: u32,
+    /// SR-IOV capabilities.
+    _cap: u32,
+    /// SR-IOV control.
+    _ctrl: u16,
+    /// SR-IOV status.
+    _status: u16,
+    /// Initial VFs.
+    _initial_vfs: u16,
+    /// Total VFs.
+    _total_vfs: u16,
+    /// Number of VFs.
+    _num_vfs: u16,
+    /// Function dependency link.
+    _func_dep_link: u8,
+    _reserved_0: u8,
+    /// First VF offset.
+    vf_offset: u16,
+    /// VF stride.
+    _vf_stride: u16,
+    _reserved_1: u16,
+    /// VF device ID.
+    _vf_device_id: u16,
+    /// Supported page sizes.
+    _supported_page_sizes: u32,
+    /// System page size.
+    _system_page_size: u32,
+    /// VF BARs (BAR0–BAR5).
+    vf_bar: [u32; NUM_VF_BARS],
+    /// VF migration state array offset.
+    _migration_state: u32,
+}
+
+impl ExtCapability for ExtSriovRegs {
+    const ID: ExtCapId = ExtCapId::SRIOV;
+}
+
+/// A typed view of an SR-IOV extended capability.
+pub type ExtSriovCapability<'a> = ConfigSpace<'a, ExtSriovRegs>;
+
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+enum VfBarMemoryType {
+    Bits32,
+    Bits64,
+}
+
+impl TryFrom<Bounded<u32, 2>> for VfBarMemoryType {
+    type Error = Error;
+
+    fn try_from(value: Bounded<u32, 2>) -> Result<Self> {
+        match value.get() {
+            0b00 => Ok(Self::Bits32),
+            0b10 => Ok(Self::Bits64),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl From<VfBarMemoryType> for Bounded<u32, 2> {
+    fn from(value: VfBarMemoryType) -> Self {
+        match value {
+            VfBarMemoryType::Bits32 => Self::new::<0b00>(),
+            VfBarMemoryType::Bits64 => Self::new::<0b10>(),
+        }
+    }
+}
+
+crate::bitfield! {
+    /// Low DWORD of an SR-IOV VF BAR.
+    struct VfBarLow(u32) {
+        /// Base address bits 31:4.
+        31:4 address;
+        /// Whether the address range is prefetchable.
+        3:3 prefetchable => bool;
+        /// Memory BAR type.
+        2:1 memory_type ?=> VfBarMemoryType;
+        /// Whether this is an I/O-space BAR.
+        0:0 io_space => bool;
+    }
+}
+
+/// A decoded VF BAR register encoding.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub struct ExtSriovVfBar {
+    /// The PCI bus address encoded by the BAR, without PCI attribute bits.
+    ///
+    /// This is not necessarily the CPU resource address.
+    pub address: u64,
+
+    /// Whether the BAR is 64-bit.
+    pub is_64bit: bool,
+}
+
+impl ExtSriovCapability<'_> {
+    /// Returns the current PCIe First VF Offset in Routing ID space.
+    ///
+    /// This value may change when NumVFs changes. Drivers should use PCI core helpers when they
+    /// need to calculate a VF BDF; this accessor is intended for interfaces that require the First
+    /// VF Offset itself.
+    #[inline]
+    pub fn first_vf_offset(&self) -> u16 {
+        crate::io_read!(*self, .vf_offset)
+    }
+
+    /// Returns an iterator over decoded VF BAR register encodings.
+    ///
+    /// All six raw VF BAR register slots are read and decoded up front. A 32-bit encoding yields
+    /// one entry; a 64-bit encoding combines two slots into one entry.
+    ///
+    /// A zero-valued low DWORD is yielded as a 32-bit BAR at address zero; this method does not
+    /// probe whether a BAR is implemented.
+    ///
+    /// Returns [`EINVAL`] and logs an error if a BAR low DWORD does not encode a 32-bit or 64-bit
+    /// memory BAR, or if a 64-bit encoding has no upper DWORD.
+    pub fn vf_bars(&self) -> Result<impl Iterator<Item = ExtSriovVfBar>> {
+        let slots: [u32; NUM_VF_BARS] =
+            core::array::from_fn(|slot| crate::io_read!(*self, .vf_bar[panic: slot]));
+        let mut slots = slots.into_iter();
+        let mut bars = [None; NUM_VF_BARS];
+        let mut count = 0;
+
+        let mut decode = || {
+            while let Some(low) = slots.next().map(VfBarLow::from) {
+                // SR-IOV VF BARs describe memory-space apertures; an I/O-space encoding is not
+                // valid for these registers.
+                if low.io_space() {
+                    return Err(EINVAL);
+                }
+
+                let low_address = u64::from(low.address()) << VfBarLow::ADDRESS_SHIFT;
+                let bar = match low.memory_type()? {
+                    VfBarMemoryType::Bits64 => ExtSriovVfBar {
+                        address: (u64::from(slots.next().ok_or(EINVAL)?) << 32) | low_address,
+                        is_64bit: true,
+                    },
+                    VfBarMemoryType::Bits32 => ExtSriovVfBar {
+                        address: low_address,
+                        is_64bit: false,
+                    },
+                };
+
+                bars[count] = Some(bar);
+                count += 1;
+            }
+
+            Ok(())
+        };
+
+        decode().inspect_err(|_| {
+            dev_err!(self.pdev, "invalid VF BAR encoding in SR-IOV capability\n");
+        })?;
+        Ok(bars.into_iter().flatten())
+    }
+}
-- 
2.53.0

