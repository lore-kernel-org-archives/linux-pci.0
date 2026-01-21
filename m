Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1FE4963A7;
	Wed, 21 Jan 2026 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005487; cv=fail; b=i682D7LrtWbBd5ndXRISf9cTnlcf2Jda8dG+EGPMLkhft171UfpjKcLT6FhiSzuvS7SLyzdMlz7MGV/AwUtQApYww02Bi5Q2wfSJ+WmhoKN6e+4QxqI/fQPjBu1/v34qZ0MkD7qRrh17790Bm8T9UjZmLuucR45oitxtenuFoq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005487; c=relaxed/simple;
	bh=aioJkGmuKXz8SSFROhqkedNPj23M35rnthBfMlyKzII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHnaR6ytSQB9Mp98RR2MQQnwIPidPnLAWLWmvKfnAbtu2c3bex8rbW7E+TQm1bectyVjEjPw1QARjliRgq1ze8MTPVN1hqml54DfQ8nLzKeqlREQvhI2IhuTjWkoyg2QV4JPA8DOKmlVFyWdAi1PnVTEhZOOLhFvDXqsPOqNtZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IMojhSJV; arc=fail smtp.client-ip=52.101.62.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IMojhSJV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtukYKydGZAmburm4qLcbc4AimZuMDmLi15xP3o9PJKYlkSeqljuJ7fQvqgTIdkwTdR3vgjbCI46HFzKRleZkqi4p6W07x1MOq2lzKaaeTxWIOd/dIcytXGToNJfiWMWAV0eYfTQ4Pq9T5vWo2SReeU/kCgKgmLtEQcLWLhR39EQz8hgbjGkkDRyB2C5puQeZYwsfWs8g1Bkn699IBKGWc+TtzlJ2JCJy9m4Vz3tnRR6ZH0yXW6SK5kBVT8MvNCeLJ63iRJVQUT46Qw9AAjR5wxgucNcVgT7OoXVxMsb8SkFYnuEkOI7SN5vP6WFsCXwgm0lYsj5g5sUqmCoGlY6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USEyD1NagRi4PjjYms8GmHFPMyMfE9N5rrEp7v4/2t4=;
 b=r3qFNT0t2DqhjZJ65TMDS/Rb2Ed/3+lSJJ2XkZWcSjKHSAVuLnobHHMT9zT7xQN5vTXYG9uzzJch21UvNto4dBjTOD74Gu0FzksotOGRH23UqkOBBG2qJK5njOY7qnBFWk8q0AOvriDtdV6T+4/qnHK2k7dN8mCQ5/E53Niza9w5dX05Lxs3ymy03u0NEiRLm5InGxCEBdRyxmV/3NjVq6FsQGl4rgQ8tmaghaOns1TxF0Sik8P1TUgdczZHaPnzb0wfwlBVvIx2zvg1RwMTNXdq0p7PCubNsj08tmX//+lhPGGDfuWcj8pnde+FcGAy7TMGSp7FosgrjgbDxopIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USEyD1NagRi4PjjYms8GmHFPMyMfE9N5rrEp7v4/2t4=;
 b=IMojhSJVMJ57N7eNXy9TVWdbp8DqUC1SLywZNjOosOTgQeElKHDBFWWkjySibSDsPjpR+81VzeC6Asj24AqdsVMWr+nVqoB//Bo+UPE7NUva79w7NajL1ThSke1e5HXTnF9QN9PoO+aRkwbdF1A+6cza5NJG8FQPgqSAhzz/qmHngOc96Ezt36Y6p2wVlLZhjLvQ65AXGYRKl2FF4zco7nunpMfhcnLnQ2jTgufQfaF7LOe9hDUr9LTnTrbvBfUsmgJh1x15FfoIfifvtG7Z6buXOWyjOORj0JtY3snwNh/GxbvrfbJf8TfjCKkb+cA7Dz0x+fC2Dg0SxF6oWz2u5g==
Received: from BY5PR16CA0023.namprd16.prod.outlook.com (2603:10b6:a03:1a0::36)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:24:40 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::92) by BY5PR16CA0023.outlook.office365.com
 (2603:10b6:a03:1a0::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 14:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 14:24:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 06:24:30 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 06:24:29 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 06:24:23 -0800
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
Subject: [PATCH v11 4/5] rust: pci: add config space read/write support
Date: Wed, 21 Jan 2026 16:23:53 +0200
Message-ID: <20260121142355.4761-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121142355.4761-1-zhiw@nvidia.com>
References: <20260121142355.4761-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: c489b5ab-6642-4940-6f19-08de58f8d081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YysycDczNm9mZmhzZHdHaERTVGdKMVE1RXFwL3VHdTNKSmh0UmVtRkRFYWxO?=
 =?utf-8?B?OXkvc2xpY1pIZHNHZ0pwL2N0WXdNL0d2YVFlZGFwbXhKalUxNFN1SnlSSDMy?=
 =?utf-8?B?VVRjd0NUbk5lZlJJUTVwRlJPSDJZRE44MVNHMkQzK2tzaXVXL3lVQmRvY1lv?=
 =?utf-8?B?RE4xMkJLMURoRTVkUS8vRW9WdWttOHlGRGJBdXlxUVAwL0lPOGJFMjJubVh5?=
 =?utf-8?B?TmloUjJTcWVzYUozcGx5RjJJUGFLbHNTOEZzN1hndHR2aTFHNTRhNUJkOXVI?=
 =?utf-8?B?QVRLc2xOcGpndEhrTFFycjFaVm9tckpDdHd0RjAxanhtUmd1RkNvOWpyRzk5?=
 =?utf-8?B?TDFhL3h6NXpkK2ZvTWJLNEhxZWpiTVg3UlJWWmhtR3ViVWNJNUNnelZGU3Ey?=
 =?utf-8?B?QWlkVks4cU5raGRqQ0hKeHlJb1Zjd3UydGJGNTUzMHlZdnhwdmlCZVFhaFJ6?=
 =?utf-8?B?blFZYy9GZDc2TE9QQmliMUpUK3VGZGxEWVJ2TVo2ZG03U0w0SHQ1Z1VMRUh5?=
 =?utf-8?B?WnZPdjBCQVlHMERacHpFUlhsTHJtbDRUeXYzcUdzL1lLNGx5NnozbW1kb1dJ?=
 =?utf-8?B?VTJMcXFjMnFHTTJSNGpiK3M1YXBENWQyTTNWZjFRS1c5YzhCMWxrSmgydzRr?=
 =?utf-8?B?ZEVWUEt4U3Zvc1YySkt6WWo3QzlEbVo4S3k3bVRSek9iZXZFeGYybmxkVlhW?=
 =?utf-8?B?dCtBNERSdC9RaHJrbFM1Q0ZjVDRFNzZxaWQvNWU2R3pGZHlrUUVRNVp3d3l1?=
 =?utf-8?B?UmtkSnowMnlYbkUxL1dOQ2VmSkI2WkhCcFdxNUMvWERaZ05QQyt4ZS9MMlhD?=
 =?utf-8?B?K1Jvc1JLYUYvVTl0bTZnVHlWVW9PSzhvZVphb2FrQWhkNjF4aGROU200TG5v?=
 =?utf-8?B?M1ExTnBlSE8wNTFlWWNoSG10VGF4MmlrTWZTMzJsVE9FZkZqTTJZZnFSaU1V?=
 =?utf-8?B?eGd5WEN2ZnJQd2NnMlh1MjVYbWRWSk1pUDNIbnpPdTR4bEpDQVdQSnJ3Q2Vi?=
 =?utf-8?B?V01NUkNkVXR2T3MyajErd2FGamgwajNXSG5maEN5M3RPenpodHBUWmp0UVZh?=
 =?utf-8?B?ZVBES0dsODhxTlVRRGQ2eS9GZ0N0dWVTMWlvMXo3WGJZRUMyU0NWdDZldXlL?=
 =?utf-8?B?MVJVTDZtanNEUXFIL1RtWHBrQk9sSytHV2kyZDZGMjdkVEhWdkFlVU1ub04z?=
 =?utf-8?B?NEtmYm1rcm8vaWZBZG9FRjB5dnJ2RDJaMmVRb1plSnM4Q1ZDVUQvWUxLL1Aw?=
 =?utf-8?B?TDZyZ1V0Wk9KMjlwSDYwM1l2ZXhzTW0veFZBSlR0bXB2c2FJOEd5RkhkSE1Q?=
 =?utf-8?B?MXZIcVBhRFVOb3JhU21jQmtldzVHc0J0QnYralZmV05aZDhNYkRDN3pFSUt5?=
 =?utf-8?B?N0xCMFRFNU9BaXQyWHVsYWZnQ1UrUU8yS20wQU1CWnRRQ3U3UHRUVTMyUHhJ?=
 =?utf-8?B?R1hGUUtHK1IwdXBpL1lVYlVPQUsvSEp3STF0UHN3eXE2Rml3QlhSYXZnMVJB?=
 =?utf-8?B?YVVsVjBDTXNVTDZ0Y2tXTGhIVkJUZzZiYVJXM3hSUThlMmhzc3Z3cFcwUmJD?=
 =?utf-8?B?ak1XcnhBQWp2bWtGQUZhaEFLMDBrTCtiZ0p5KzAyTFJjQ1dqQ1pmYkNGOCsx?=
 =?utf-8?B?UkpwMy83K09TaytMZW1wM2pLNmRhZ3FJZFZhVmdyVk5JTGZOem5zUzBjTDAy?=
 =?utf-8?B?MWNUUmcwQUVCWTdFRndyRk1ZWUVvbFpKWGVVU2FDa0VmSmgvblBtTDl5V0U2?=
 =?utf-8?B?V1VITjBQZHhLTStINVZJUHNEVW52QWtOT2E1VXB5dWdtYjdxRWRPU3hLNFdV?=
 =?utf-8?B?ZjlmMlVhMVpZM3hzZWxxdWNhM1pUQVBqWFdHZUd2TExlc3dNUDczQnozYTVz?=
 =?utf-8?B?VWtFY25xUWlBQ01hL3hhcnZpeU5rWFA1SFFWNnN3MTlCQXhlUG9UaEtwbWho?=
 =?utf-8?B?ekFuMjdMWTlVZ2ZqNDNnTEg1aFJjLzd3MjNrcjBCVkRwYXVQNm1hTWdwMVpu?=
 =?utf-8?B?SjRDeHBhdGhtaVhRbUYveDkwSjBDWkh1ZnZlNWJ3djl1MnZMSHZ3b3ZhZzk3?=
 =?utf-8?B?RFpyaHBJWFJyT2Vndm52a01US0V5NWhWQmlXaElMUVA1cVZjTHgwY1FSY1NE?=
 =?utf-8?B?RGJ5cG13cDFmS3dCbVA5VnQxcmppRWxLTHFZcnJYT2Q4N2krU3dZL0kxOFoy?=
 =?utf-8?B?RE01VStuMzRPdDBFd0l1VGVCSTd6KzZzcGNiSFh1Z3dCckhCNmplL3JYLzVz?=
 =?utf-8?B?V3dwVG0ySHpFWmlTeUFKNDhGcXlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:24:40.6334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c489b5ab-6642-4940-6f19-08de58f8d081
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488

Drivers might need to access PCI config space for querying capability
structures and access the registers inside the structures.

For Rust drivers need to access PCI config space, the Rust PCI abstraction
needs to support it in a way that upholds Rust's safety principles.

Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
accessors for PCI config space. The new type implements the `Io` trait and
`IoCapable<T>` for u8, u16, and u32 to share offset validation and
bound-checking logic with other I/O backends.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci/io.rs | 161 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e3377397666e..e9c540fe80ac 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,6 +8,11 @@
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
@@ -16,6 +21,134 @@
 };
 use core::ops::Deref;
 
+/// Represents the size of a PCI configuration space.
+///
+/// PCI devices can have either a *normal* (legacy) configuration space of 256 bytes,
+/// or an *extended* configuration space of 4096 bytes as defined in the PCI Express
+/// specification.
+#[repr(usize)]
+pub(super) enum ConfigSpaceSize {
+    /// 256-byte legacy PCI configuration space.
+    Normal = 256,
+
+    /// 4096-byte PCIe extended configuration space.
+    Extended = 4096,
+}
+
+impl ConfigSpaceSize {
+    /// Get the raw value of this enum.
+    #[inline(always)]
+    pub(super) const fn as_raw(self) -> usize {
+        // CAST: PCI configuration space size is at most 4096 bytes, so the value always fits
+        // within `usize` without truncation or sign change.
+        self as usize
+    }
+}
+
+/// The PCI configuration space of a device.
+///
+/// Provides typed read and write accessors for configuration registers
+/// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
+///
+/// The generic const parameter `SIZE` can be used to indicate the
+/// maximum size of the configuration space (e.g. `ConfigSpaceSize::Normal`
+/// or `ConfigSpaceSize::Extended`).
+pub struct ConfigSpace<'a, const SIZE: usize = { ConfigSpaceSize::Extended as usize }> {
+    pub(crate) pdev: &'a Device<device::Bound>,
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
+impl<'a, const SIZE: usize> IoCapable<u8> for ConfigSpace<'a, SIZE> {}
+impl<'a, const SIZE: usize> IoCapable<u16> for ConfigSpace<'a, SIZE> {}
+impl<'a, const SIZE: usize> IoCapable<u32> for ConfigSpace<'a, SIZE> {}
+
+impl<'a, const SIZE: usize> Io for ConfigSpace<'a, SIZE> {
+    const MIN_SIZE: usize = SIZE;
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
+        self.pdev.cfg_size().map_or(0, |v| v as usize)
+    }
+
+    // PCI configuration space does not support fallible operations.
+    // The default implementations from the Io trait are not used.
+}
+
+/// Implement IoKnownSize for ConfigSpace with compile-time size.
+impl<'a, const SIZE: usize> IoKnownSize for ConfigSpace<'a, SIZE> {
+    define_read!(infallible, read8, call_config_read(pci_read_config_byte) -> u8);
+    define_read!(infallible, read16, call_config_read(pci_read_config_word) -> u16);
+    define_read!(infallible, read32, call_config_read(pci_read_config_dword) -> u32);
+
+    define_write!(infallible, write8, call_config_write(pci_write_config_byte) <- u8);
+    define_write!(infallible, write16, call_config_write(pci_write_config_word) <- u16);
+    define_write!(infallible, write32, call_config_write(pci_write_config_dword) <- u32);
+}
+
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// I/O backend assumes that the device is little-endian and will automatically
@@ -144,4 +277,32 @@ pub fn iomap_region<'a>(
     ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
     }
+
+    /// Returns the size of configuration space.
+    fn cfg_size(&self) -> Result<ConfigSpaceSize> {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        let size = unsafe { (*self.as_raw()).cfg_size };
+        match size {
+            256 => Ok(ConfigSpaceSize::Normal),
+            4096 => Ok(ConfigSpaceSize::Extended),
+            _ => {
+                debug_assert!(false);
+                Err(EINVAL)
+            }
+        }
+    }
+
+    /// Return an initialized config space object.
+    pub fn config_space<'a>(
+        &'a self,
+    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal.as_raw() }>> {
+        Ok(ConfigSpace { pdev: self })
+    }
+
+    /// Return an initialized config space object.
+    pub fn config_space_extended<'a>(
+        &'a self,
+    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended.as_raw() }>> {
+        Ok(ConfigSpace { pdev: self })
+    }
 }
-- 
2.51.0

