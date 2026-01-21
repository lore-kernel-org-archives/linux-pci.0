Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF923EDADE;
	Wed, 21 Jan 2026 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026992; cv=fail; b=AGwh71X02CENPe5ltTlRA4NbewUrhwXsnyOn68F8jMSwwEitvI+8T/4kelz1lgg3jAcUe+Pr/BTRhMVLKXy2HlLrNHauXgsYDlJawO2XfYhokFEf8+w5c1DJs27XPzjzjVi24QgzYmiGaozdwxUf9E/JCVCY3T04mKtwxptRzRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026992; c=relaxed/simple;
	bh=4KIgJAA3dK8b17oE5S3haQkZJDXVlyaNS3JUknwi3/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsrmjeeWXeUOscKzlme0UQLuMcx7AL/QeDwVXkMrJQklbNjP6jOCIrb1dDdcOZg8ZnEkcO9d/5fgAaZw+MxUVz2j1pmqwMmlRwWLMgF2aiuiHsGR06QeD2OwiMS6mboWKqNoH80Hncl5HyEwgfnV5LnvLNxxIuUtV3BpCRTF7ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VuD/2Sph; arc=fail smtp.client-ip=40.93.194.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VuD/2Sph"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkNgEaioL72PaX4tW/zRkCXscbC9CClLl/DqtEvYcUFykM49Yr3fs6BHYBxyCANl6Ri+adQscqV65RqWDZ4EtZSd2hZT6wkd+G0ATSSxT9ZBU515kVxTZEZrlc6ExecPXssADD2SMKgNZoHOxKDUnRARHxX/MPtWRyKlPVu9dYp7IV4AjKu5XyW8VCX7qsf6lDDY8VLidF7erB6UcZ/Wa2n+2kA/WmOWy4mZEcs/LuDYjdjH/v3v2CrtVHMKvJbpTNlIqiMSQs6sKmUi4ctUhzbWwl+6xboUNInfFrTWhMudMNKy0ikVAKhHoLHhOaWHa80sgAkw4cFm0ENEKRpLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnrRM0Bd7XcPCamofFLqcEafBu5H6TZsO23tks9hTFA=;
 b=Z0jDG3bSI/rh9CT62xO3p/10H4AFWluntd1ITj/QqWFe+G9p100OJv1ajsOMaEObuLelp1KijdpWUbj4gvQqAbJUFqVCylpkjcgR8qBH1AUFvPzDrfkvOSY5qW0unamGv/XT2hSZ/e0dZ0yScq7m7mQliC8L+HSiItgJP5letSkj2v5TMokLvqb4IgtIScqu0z/yBIUBg6SMBHdbDwoW4nw3hFrlFbV7wbX3PperDrq+b1dohgXQoYLH5lWnJNQN805HQlXQBcznd9eLur7VEy8DPZVqratCAi2WG8Epo2T45hSWca1BknrjDC0f75pXcg6OuwU8f8NwhGLfJyw2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnrRM0Bd7XcPCamofFLqcEafBu5H6TZsO23tks9hTFA=;
 b=VuD/2Sph1J1REEawjOGmVdc4xc5CTtgrFQcUOM1uP5E9Z19/RsWH0fpjb5fJmOlUTHSQQRBY6sB7ZXLM1hMn0irY417cFxqC5Ab0At3APYSxn5sdnFGX4HIteopcAMXlsTDyRlt2vq8UEA4WaXnh/YgQyhZEPLJUFRjHGtOyUBdSQvU7youQT/oxH4Z4iOBbK/zVQK5fyEtLNW8ptu2qrhBWBi6nJGezdpttaEs+7Roo0ynm8yCVhVTcExp8rj6kTHuQJUQ7CSUQZGBeYVZxrdWNNbX5J7iyL76m91nCtYOpjtfAk7LE1omTAV+fB5EzLtBCcso+ML5G/y+2FQJBgQ==
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 20:22:59 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::8) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 20:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 20:22:59 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 12:22:39 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 12:22:39 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 12:22:33 -0800
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
Subject: [PATCH v12 3/5] rust: io: factor out MMIO read/write macros
Date: Wed, 21 Jan 2026 22:22:09 +0200
Message-ID: <20260121202212.4438-4-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef89e8f-954e-4933-0c03-08de592adeeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czFTOGx5czZpV0tXRmgxdjZRbHJybEh5cGhyekNwT1RjUGJIRU1BaFpLSHRZ?=
 =?utf-8?B?eEdrNFdHNnpYMUZKLzRzbi9FeWpMZC9mblBSb0FNV2NxZWRpT3B5NWtVdENE?=
 =?utf-8?B?VWJsVFBxdHJCUkh5L05RQzlmM2RTMUwzVFdUWXhYanEzaWg4T3VDdnpiMkkz?=
 =?utf-8?B?alROZ292ejNGRmRLbDBXeEpLOWdNeEIzL3Z4aFp6VnhpRS9iRmJndjBRa2hp?=
 =?utf-8?B?U0R2UUttNkMwcjV0M1d1ditlSzBtM1FtaUxpYUhGdWxlMXhBNVpLV3VpSlBZ?=
 =?utf-8?B?VkRDL3JDVVQxejVmUXluTFNsQ0FmajF6TDM1OWpQenNIREJkQ2lxV2haYzVE?=
 =?utf-8?B?UU9IMVJEUTVvNHJQM2R1VFhyY1RLNmdkTndLcFppckhEbWVzNHpXRm9oTkto?=
 =?utf-8?B?bUpNbUNrd3ZSYm5ySkNwdTgzcTJFQzRRUnpKZVdVSGFqZHAxbXVCU3ZFK1Nk?=
 =?utf-8?B?OEVNVnc2c3hybDNTa29QY2daZDB5MUU1cmJwSGJ3M3lCbCtyUE81VmJmVlNG?=
 =?utf-8?B?cUNxU0RWOVVUWTVlTTZDcDFMZnQ0SkIzWGNQSDVMbTUrNytxbTJUREJyWGt0?=
 =?utf-8?B?WER6SlE4WmRGRnNQblIrVGllYlhBUjhsY0EzWU5Cck42dWM5blMxbWZicE96?=
 =?utf-8?B?K1lyTEdWY0o5cGVUeTI3VUtjWVRsU1RTWjlrcHpKVmdXQ1E5RXM3aTYzMnRF?=
 =?utf-8?B?RTYyNzJmbEhrbTZUM3hJMEh0L3YwTUJTRmI3dFZFTGNsMHozZkEvUWcrRHp6?=
 =?utf-8?B?cmpQZ0IzZTI2cDZOUHFaYTlLdkdPQTFtZmIvT1VNbXhIdG13YjVkUVZ0SjFR?=
 =?utf-8?B?VzVlcFlNRmVQbW00Nk0yRWh5enpHUHF3ZFZYblRyd3BiUlh3azBod2ZxSmFu?=
 =?utf-8?B?bnpiVmRyVmwwT1FIbElVMjdQZUhyVVJJa01lYmdlcDRrRTRCUGFjdUJMbld3?=
 =?utf-8?B?eUVUTmhubncyZUQ1cHlvWkZpd2NLMzJYZ0gxNlY2SW5McmJqRWlxaksrYzdk?=
 =?utf-8?B?RW1VdmVIYTZueDlWUmxja3JETTQwWTVtazNRaVBIalpTbDNGaUxFaVVkRVR1?=
 =?utf-8?B?Zmd2M3N0ZEpLMHI0SVJsenFpOTFDT0JtM05relFNL1dmYndLTXNRM0lQZTIr?=
 =?utf-8?B?MHJua1lQQ1FHQThoNVVtRllTZDgxTERjVTZvMm0yS0lKNStXcnliRW1hNUNy?=
 =?utf-8?B?T0dHaW0yVmh3dDdNTU16V0ZkMFFKbndHZTcxODI2eFZrK09aY2F2dmlON0U0?=
 =?utf-8?B?blE1M2FNaCtyTDMvM01RUG1XRWxIczhyKzJqTnZQc1hsS1RLaTZyL1cxZXRX?=
 =?utf-8?B?bFJWeGE4dGQ0SFlZWGRFQzN1aERCOUFmSEVOMThKMTdYajdZR2NISTJkSkVw?=
 =?utf-8?B?VEVOVUtUTXNnRUlLSU1aSFovS1MydXRmM0w5bVp5dFFkOUtWQjYwVDF1MEVI?=
 =?utf-8?B?ZEREVmtDVUJ5Y1RtbWhkOGxWak9ybWlkSVh0bHo0cW5jZzJBQnZ0Rmc4VkQx?=
 =?utf-8?B?N21IY3pTRjNQVkUzQm9reVJ4SUoxWDEzeUlML2xqcVUxK0RQZVEwbUFkeC9l?=
 =?utf-8?B?TXZwSXo1Z2JJTk5CaU40NGFRbzhkbVkvcHQ5bFZVcEdOOTM4UGxicm9lKy9w?=
 =?utf-8?B?dEFsWmV3UlhKVnlQS1ptVU9jd2Q2UUV4S1pJQjI2ZGFUQTBrbjhiZWRhOURu?=
 =?utf-8?B?d3NhTWtsaXdWNlhldEFrMlZQa3pkQnU5L0doMzUwdlMzc25mNXl1aExRMjRZ?=
 =?utf-8?B?YXREUU82dis5Zit1UEZaV3FDcmJVWlZ6cWUyYU5YUGZzYk5NeGFIL0VQR0lJ?=
 =?utf-8?B?eFEvS1hIWUxWdUJ2L0Ivck5KODhGQnJpM1JKckRDcGlSOFR0UWNGY0hPdXow?=
 =?utf-8?B?QlIxdVZnU2k2UzBzY2dRa2JpcmljYlRBQnJiZ0hFOVBsUi9LcGxMMmk5ZDBL?=
 =?utf-8?B?Y0tBZkJlRVhMdklhaXBLbnR3VHhvVFpoaFVybU8vMjdlejltdWRsV25JbFdo?=
 =?utf-8?B?cFBPK09lSUtjZVZUcDJ1b0w0ckxDQ3M2Y0U4Vk81QTNaTXZMTDZlbXo4QVZq?=
 =?utf-8?B?dHpkVEFoOUFjN3RWdUtqMjJGUVB1YTV2cTF3SUZYc1BiSVlmODJZY0pIY0x5?=
 =?utf-8?B?R0pBMEFSUzR6VE84eXdVTitPemFidVBjWDhCSDV4bTNBbml3ZWFMenF1T09S?=
 =?utf-8?B?Q0V6LzVZVTJ0M1RMK1lwWERmWVI1NUZOU2MvdFFpQ285UkRRVjVNTVhRenBX?=
 =?utf-8?B?dStuN3ROOVByZXJINHhDWkJ4QStnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:22:59.5697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef89e8f-954e-4933-0c03-08de592adeeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472

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
index 687d32572d6b..fcd1b156a14a 100644
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
@@ -451,44 +508,44 @@ fn maxsize(&self) -> usize {
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
 
@@ -506,43 +563,43 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
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

