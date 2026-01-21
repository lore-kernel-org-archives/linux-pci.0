Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339534963A3;
	Wed, 21 Jan 2026 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005486; cv=fail; b=Ei+EWqFLOlRKM46XAOyhGXRpz10mod7S0+e6fQCpcYrKPTUggwm4CAywGAwJ8MUC2hWeup5HwGZeVjpvR0WmcdqcXedlt6rkqCwLDevXyxHk7bv8DRAKER8/M4dR24bLfDgO4JtG4O0Ivc6mVHotOOFoi46Z18TQLkCHprUCG+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005486; c=relaxed/simple;
	bh=wPo7UbJ20GJM8UQfExioCiJyIk1r2OWGrEk/aOEUaC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdG/DLNZPqpZpNcmsRjaSMlUm09zkjtfZMKOKkWMoTML20HTSmHkXicL9sI9oHllJeLGleu6ApwdGzf+KwdX7onnK7e3hlRxFk73lHDS9G4WINhma3QWQ1iPRKq41N8dFvGM38dm2zn1d2JWZxHISRkQjHkU0WhqucmANp12oyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cMCCVfg8; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cMCCVfg8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThyJWNJZo3PeaM+d30uGUMvszW/Bof+yJek614eQ6av7G0UIgvOBaicJQ8Dh4ACFh/lAhez8LtSIa35DN3brNf3R1MD/QWpnLP0CA+BEPPFYVFX4x4pBGtGUNzZFEeL3+NQ29MTKI22Oe6SS9/ZLJl/EGKuqMRij+3NJZX2+I2v430bAHh7/oDWIyke2HGWP3BPW55lIUzJuYIofUolxG7l4/gKXGKn7FZbGXaLOSRM7nKphkEiJa0xqc9ONHr67lNYzawLCqqma5FOxkhxEP+OXTcfZoM7yNlWKRaL8savYLl0bHuJvYWzvOtXfbw8kxGsd4/VwJnKbQZCLvOQARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lai38gIl8gYykPx+C1o8FufpZkIQ/D4JfwW0fTgbeWM=;
 b=GCzGCf4yRFb+eEphP+jm9zkgLK2F0wq4ZC9De/tUyEcz+CDF1lsrRgRjhVOQo/bUqXUk0UCONk2tLflQ6JMh0r9iXX0rgU3E+oOqAhsKW/AigFdniBiJqwMpSdMCqusF2biwKq0XNzB/PwRxlhHx0vUWNV2ku/5eaqdBUwUF1sig3RtmsoAM9jQoMFSLISFkNyrMlXwR/+R52MoB7CSCWzoLYtMTZ5Qspdcyf7jjmbgenbECGUnH0fWsGkdxcCKwHnbL03oZVmXtGa41vLpBAF1589FFULQ3g8ujBav1TVBHnDKhtbxQqmwJicTDNQxm8yFtxjnAkjRnmuHzNr0p1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lai38gIl8gYykPx+C1o8FufpZkIQ/D4JfwW0fTgbeWM=;
 b=cMCCVfg8sUOpRx3bysR3osG5sFSvP45EpKeH3B0mPgYEBJ38ws11NLerGZWVdGaIOZ9kRtjyLHsPhPwFDcbVM15GWe5Z2Uzb1k2E+LQhl3HEHbqSqNn0pP54glu+/6B3CV27bZ4FLZXB9wjqdbMGWw1cWilbXk3ER4Y3QCk0KmW0RFyn0cW7OcZO6eAsZcb8fc089ND13lVr3cVkNGhDVPhvUFePbmeAkbkFq8nha4D9mEelfuvmENN2EOp4yUseuUt+/wLwelKkquBiCjM6nl3fzgMa78jUpdnBORyVu6Zbtbpl8OsXZ48BRPOdGGpFHePpThSLtbkHXcEMn+/v1A==
Received: from BY5PR16CA0012.namprd16.prod.outlook.com (2603:10b6:a03:1a0::25)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:24:36 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::49) by BY5PR16CA0012.outlook.office365.com
 (2603:10b6:a03:1a0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 14:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 14:24:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 06:24:23 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 06:24:23 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 06:24:17 -0800
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
Subject: [PATCH v11 3/5] rust: io: factor out MMIO read/write macros
Date: Wed, 21 Jan 2026 16:23:52 +0200
Message-ID: <20260121142355.4761-4-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: acd5264f-08a7-4d50-5164-08de58f8ce1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFZxQVUwa3hhaENNN0Nvc2FRNGpjdnpHQXdUNE5lTnBiMzlJeWlwMjkrSWtE?=
 =?utf-8?B?b09RSDBKbTVYanFXSjZHcllFcysrWHc4STRoRGMyMG9jRWk2U21kaXI5SENV?=
 =?utf-8?B?UXdtSC9OYkIyekRwU05ySDBySGc1NHptTWpwcVZFdVlXMGV3bldGbUtTcG11?=
 =?utf-8?B?TmRpazg0L25iMDB4UUFjNmxlNzJsZmN1d0ltNXcxZDZRaGUvdkRRVkdPRHhV?=
 =?utf-8?B?WllwVWxoSW10MGV4OEdYSWFORzZxTm9hK3dmOG5vcWlNQStMSWtIMzNnbS96?=
 =?utf-8?B?S1dIRlV5M01Ud1JpMnV5K1YwL1dhWnpQYkhhS0FpYXRCcEJjR05BNEIwSkZJ?=
 =?utf-8?B?V2EwUTUzdTVrYzIxZER0Q01RUTBIS09MeDNKdEVtNG43RUNIZDg5OWV6b25M?=
 =?utf-8?B?T291ek80L1EzdUNkOU9UbisrMStiNEhMOW5WUnBzTm9pb3Z0ajQzaUlLV01T?=
 =?utf-8?B?TjVKT0xvZ0JGbmE1Uk9pdjZldGs3a2VzbEtieVJpaDM0dUNuMUpWUDlCTms2?=
 =?utf-8?B?bkhXQ2U1NkliaWx0eUcya1lrSk5wYktyVk9NQ3F4UXg2YkdEMURURVZIUWRi?=
 =?utf-8?B?TE5xTzJJRlZCY0xGelc4aDhUM0ZaL3MwZzFJTnlOVWJsa0VWWEJrMzJhQ01a?=
 =?utf-8?B?NG1WMkxVcVovTVE5SWpkbE5GWEhxOWhiQkp5NUFvdTdmRDVvUzJaUHNmSjh2?=
 =?utf-8?B?WjB2dGx6M0VOTElFMXZlMlVZeHRQdWttelhJNUYwNVZlRllkK0xPK25PZWQ4?=
 =?utf-8?B?V2wwVzNoZ3BtQnNWUUpRbEpieDhJRTJ6eFBXZFMrbGJyejZtWFdmbWRhOE5n?=
 =?utf-8?B?Nk5SVWJYVWI1QjJsb0RZQzRkZDdPeU9PQlZiVzlIVnFpVVZZbnJMRFNtTXF0?=
 =?utf-8?B?aFFydVRSajBVMVNCWU5sclRSOFdvd1Z0eDN5bk9ybHFmWG4rcFFPMHVIb3Zm?=
 =?utf-8?B?Qjd3OXBTYnpCRktjNHJzTkVjcW5QZWVvRXNibUU1MjVLNDlMS2wwSlVqZ29u?=
 =?utf-8?B?NzJob0FZcXdIUHVicnR5T1IzS3FMOEpMTkpQUDF2cWRoM3kvWDM3bVAya3FR?=
 =?utf-8?B?dWJUOHc3clc1UVRXWDQyalRWS1kxVGs2ZkpSYXYveDVNWWZqY3RuNjRQa010?=
 =?utf-8?B?bDQyZisxd2FnL3NuUHJrZDJQamcxWjJaMjVSTWtIV0Q1cXZGY3dzTXlqdmhz?=
 =?utf-8?B?UjNZK1JOSDUvbkRzeXdaYTBUbVB5YUxiNDdVOVNOQnIxQlFHcjV1bVNlakIw?=
 =?utf-8?B?ZFg3TWRTeFk3ZENRTlJYbllJWlQyTkltanBCblRaSjdaZlF2cTdha0ZuK25V?=
 =?utf-8?B?d2owa1VySm9lSWMvWnRIV0ZkZGc1azFycVMxOHVKTlZYcjl2R01saWQrUWZx?=
 =?utf-8?B?Qkk4Z2t3ZjFiL1phREREeFptbjZhTTFYdHNXSDZrREtZbE1VRlJtaWRGYXhI?=
 =?utf-8?B?QmlIMGkzMEd6VTRlcFBlVm5uM3ZqamI3OUlkYXU5dHJQU0w3SU9CQjNhNlNV?=
 =?utf-8?B?elMwdzRBazRnT2UvS3dGcjE1dEJQTUJNV0t4b0ZWTXN3TzJBdWdLYWs3ZEYw?=
 =?utf-8?B?SGs4ZldRYjlWS1BqcnFTMHFGdzhYdmdNZFdXZkhzSHppVzRXcUhpalo2dnM4?=
 =?utf-8?B?QjFOelJCWnR1Y01XNXM4RE5EY3lMNkpOWnFObnQ3Z2YrV2wvOFZwcE5CZ0cz?=
 =?utf-8?B?ZTZ0SEIyQWd5Q2tGZWJIeFRQYjEraDJEejhyMU9IK3JPNjArQVhBM0R5ZUtj?=
 =?utf-8?B?ZkZwampydzg3YkRVeHhBUjF3SXFBL0dDVmp6empwWER4WlVVOGtPaFM2Q2l5?=
 =?utf-8?B?VmlBb2FBWDlaeVNIeVo0TlUvcUZNYm5XcmE3Y0hHQkhEYjRkMVExSXBjTzNM?=
 =?utf-8?B?cy9BQkxkMWFHOFBFSUVrTlFhN3N1NFp0T2QzbGtYdUhlMGlqS0JNN0pZZ3Uz?=
 =?utf-8?B?SnhTT2Z3V3F0SDdmd1plcjFZckJSR2NQdy9HZ1g3ZGJvaDM1SXpDR1dmajFR?=
 =?utf-8?B?eFd6MGh3L2JaOHJzQW9yNWcrc1BOUzFxeWE3aFM2MlpYSWNhaVE4OUZocjFK?=
 =?utf-8?B?bXJzNi8xZGhaVlBlUGJZUFJkcmJxcEVsdmJvYlZVb0xXZ1BzdnZzbm5lanRn?=
 =?utf-8?B?U3FRVUtHRGt3clV1TDRHWjkyOTFVak9uSzJaTGt5TmlWdGhqVDRxRnVYQkhP?=
 =?utf-8?B?N2lBaDRkQ09UMGhaa0RRMzAza3VOWVh5N2k0RkkvZXovaVh6aUJSR3lySVNG?=
 =?utf-8?B?Wkx5VUpGYzlCM0ZBS0ZTUC9zS0t3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:24:36.5934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acd5264f-08a7-4d50-5164-08de58f8ce1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495

Refactor the existing MMIO accessors to use common call macros
instead of inlining the bindings calls in each `define_{read,write}!`
expansion.

This factoring separates the common offset/bounds checks from the
low-level call pattern, making it easier to add additional I/O accessor
families.

No functional change intended.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/io.rs | 147 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 45 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 152afdcbaf78..d62fd6714256 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -137,8 +137,65 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
+/// Internal helper macros used to invoke C MMIO read functions.
+///
+/// This macro is intended to be used by higher-level MMIO access macros (define_read) and provides
+/// a unified expansion for infallible vs. fallible read semantics. It emits a direct call into the
+/// corresponding C helper and performs the required cast to the Rust return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the MMIO read.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the value to be read.
+/// * `$addr` – The MMIO address to read.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_mmio_read {
+    (infallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($addr as *const c_void) as $type }
+    };
+
+    (fallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {{
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        Ok(unsafe { bindings::$c_fn($addr as *const c_void) as $type })
+    }};
+}
+
+/// Internal helper macros used to invoke C MMIO write functions.
+///
+/// This macro is intended to be used by higher-level MMIO access macros (define_write) and provides
+/// a unified expansion for infallible vs. fallible write semantics. It emits a direct call into the
+/// corresponding C helper and performs the required cast to the Rust return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the MMIO write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the written value.
+/// * `$addr` – The MMIO address to write.
+/// * `$value` – The value to write.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_mmio_write {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($value, $addr as *mut c_void) }
+    };
+
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {{
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($value, $addr as *mut c_void) };
+        Ok(())
+    }};
+}
+
 macro_rules! define_read {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident -> $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) ->
+     $type_name:ty) => {
         /// Read IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -148,12 +205,13 @@ macro_rules! define_read {
         $vis fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(addr as *const c_void) }
+            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
+            $call_macro!(infallible, $c_fn, self, $type_name, addr)
         }
     };
 
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident -> $type_name:ty) => {
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident($c_fn:ident) ->
+     $type_name:ty) => {
         /// Read IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
@@ -162,15 +220,16 @@ macro_rules! define_read {
         $vis fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$c_fn(addr as *const c_void) })
+            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
+            $call_macro!(fallible, $c_fn, self, $type_name, addr)
         }
     };
 }
 pub(crate) use define_read;
 
 macro_rules! define_write {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident <- $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) <-
+     $type_name:ty) => {
         /// Write IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -180,12 +239,12 @@ macro_rules! define_write {
         $vis fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
+            $call_macro!(infallible, $c_fn, self, $type_name, addr, value);
         }
     };
 
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident <- $type_name:ty) => {
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident($c_fn:ident) <-
+     $type_name:ty) => {
         /// Write IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
@@ -194,9 +253,7 @@ macro_rules! define_write {
         $vis fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) };
-            Ok(())
+            $call_macro!(fallible, $c_fn, self, $type_name, addr, value)
         }
     };
 }
@@ -468,46 +525,46 @@ fn maxsize(&self) -> usize {
         self.0.maxsize()
     }
 
-    define_read!(fallible, try_read8, readb -> u8);
-    define_read!(fallible, try_read16, readw -> u16);
-    define_read!(fallible, try_read32, readl -> u32);
+    define_read!(fallible, try_read8, call_mmio_read(readb) -> u8);
+    define_read!(fallible, try_read16, call_mmio_read(readw) -> u16);
+    define_read!(fallible, try_read32, call_mmio_read(readl) -> u32);
     define_read!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         try_read64,
-        readq -> u64
+        call_mmio_read(readq) -> u64
     );
 
-    define_write!(fallible, try_write8, writeb <- u8);
-    define_write!(fallible, try_write16, writew <- u16);
-    define_write!(fallible, try_write32, writel <- u32);
+    define_write!(fallible, try_write8, call_mmio_write(writeb) <- u8);
+    define_write!(fallible, try_write16, call_mmio_write(writew) <- u16);
+    define_write!(fallible, try_write32, call_mmio_write(writel) <- u32);
     define_write!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         try_write64,
-        writeq <- u64
+        call_mmio_write(writeq) <- u64
     );
 }
 
 impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
-    define_read!(infallible, read8, readb -> u8);
-    define_read!(infallible, read16, readw -> u16);
-    define_read!(infallible, read32, readl -> u32);
+    define_read!(infallible, read8, call_mmio_read(readb) -> u8);
+    define_read!(infallible, read16, call_mmio_read(readw) -> u16);
+    define_read!(infallible, read32, call_mmio_read(readl) -> u32);
     define_read!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         read64,
-        readq -> u64
+        call_mmio_read(readq) -> u64
     );
 
-    define_write!(infallible, write8, writeb <- u8);
-    define_write!(infallible, write16, writew <- u16);
-    define_write!(infallible, write32, writel <- u32);
+    define_write!(infallible, write8, call_mmio_write(writeb) <- u8);
+    define_write!(infallible, write16, call_mmio_write(writew) <- u16);
+    define_write!(infallible, write32, call_mmio_write(writel) <- u32);
     define_write!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         write64,
-        writeq <- u64
+        call_mmio_write(writeq) <- u64
     );
 }
 
@@ -523,43 +580,43 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
 
-    define_read!(infallible, pub read8_relaxed, readb_relaxed -> u8);
-    define_read!(infallible, pub read16_relaxed, readw_relaxed -> u16);
-    define_read!(infallible, pub read32_relaxed, readl_relaxed -> u32);
+    define_read!(infallible, pub read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
+    define_read!(infallible, pub read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
+    define_read!(infallible, pub read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
     define_read!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub read64_relaxed,
-        readq_relaxed -> u64
+        call_mmio_read(readq_relaxed) -> u64
     );
 
-    define_read!(fallible, pub try_read8_relaxed, readb_relaxed -> u8);
-    define_read!(fallible, pub try_read16_relaxed, readw_relaxed -> u16);
-    define_read!(fallible, pub try_read32_relaxed, readl_relaxed -> u32);
+    define_read!(fallible, pub try_read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
+    define_read!(fallible, pub try_read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
+    define_read!(fallible, pub try_read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
     define_read!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_read64_relaxed,
-        readq_relaxed -> u64
+        call_mmio_read(readq_relaxed) -> u64
     );
 
-    define_write!(infallible, pub write8_relaxed, writeb_relaxed <- u8);
-    define_write!(infallible, pub write16_relaxed, writew_relaxed <- u16);
-    define_write!(infallible, pub write32_relaxed, writel_relaxed <- u32);
+    define_write!(infallible, pub write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
+    define_write!(infallible, pub write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
+    define_write!(infallible, pub write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
     define_write!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub write64_relaxed,
-        writeq_relaxed <- u64
+        call_mmio_write(writeq_relaxed) <- u64
     );
 
-    define_write!(fallible, pub try_write8_relaxed, writeb_relaxed <- u8);
-    define_write!(fallible, pub try_write16_relaxed, writew_relaxed <- u16);
-    define_write!(fallible, pub try_write32_relaxed, writel_relaxed <- u32);
+    define_write!(fallible, pub try_write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
+    define_write!(fallible, pub try_write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
+    define_write!(fallible, pub try_write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
     define_write!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_write64_relaxed,
-        writeq_relaxed <- u64
+        call_mmio_write(writeq_relaxed) <- u64
     );
 }
-- 
2.51.0

