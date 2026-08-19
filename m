Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021087.outbound.protection.outlook.com [52.101.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA744E675;
	Wed, 19 Aug 2026 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137825; cv=fail; b=d5az6sqGBCtUIZOclW8zebbrjxZWcFwXrQwke+JeMNxSeORq2HJ+2SvFCa/WuZBWP5L0ZvwVtAlu9oNYdF3Ir8i4ekvLCWkksywL1pUwNmvLr3ow77d0iohPi1z+tRsO/F3QBRoFZgRe+sww3keZ8na94UaoQeZFOph/DbKRlzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137825; c=relaxed/simple;
	bh=BW8Pipu9gMJAyQKlc26RqfQ2wmugHrBod8hkXoCWiys=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K3P9qWAiyokZSrEC9OZ1s71QoUwR69nPcimAcYDObO1VC/3Bewd23hZIkrb3f+PFUKO2jeqVoaR90pfPWlnlG9hwN9TaSljHKicbo4vLHrk/oqi32uxthP0bHLQ1MSn9BrH7i6X6wF4OgpU2WrdhR+9QLMeqJJVVqpa/57pK84Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IaDFBGNl; arc=fail smtp.client-ip=52.101.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IaDFBGNl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeyFwHNwfpzJ62YhSu+SmtXQBaARcnDzcrhU9QtiCpOWFoiTodN8YQ/EFkqhAI7aakxKFAFgCCqhXu6FKwavUbFcGIZrps6H6sh2XrYPaxsB0hbMpsD9ettHqqm5tFUj2wKsCtebvwBbUhTZ/iaMhGRufsI4RvibKElwF4fYtZa+EP5M3nbNn2WYQvXSUhqMkQzhN7EGRhigT/HW9B/QXXYu9/9oXwUb6hv5cpph1jW8m4Ma1VakeXJwkplJdUsDKx8aTxlM2yGLDSLOooL9Pkm/FOL8mFtOXClcmN2pOtvYHuRi0/UShq0QqM/idTLk6z3gpDVU9Hu7TXAhsutpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtNBUdcbGgetYHqUb27b51udo1TjXJe3qFA4gF2kVMM=;
 b=B1Q+GvhIfXX2njjLRgACAvPwQbRoy47RMUFJSAlZ6RY+s+mmQjAhLd6vPAoBSEUIXFOPIOofBVKAEQAFW0cduFiXppSj2X2w4VJNho4OKL8JXTsINkAT0uUSG6Erp6L+d72lguSBnCAVja+q03DvCfPm7YEW/egwEH6zx9kJJg/0CtemteFKaIHOLRVG7uOZf5QCHjXuxZlSfHPQWWPIfqwBdNaIC78gJSBh1e1eMAF5W76HxxRfbJxOGKl55H8QIrNFJJb56NXdYYih15Kf0OOD/ijTmvfb2RKA4miwTi8rKFMAnMf48MDatCIsBlBalzIGVm8sfwth3mPyuijbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtNBUdcbGgetYHqUb27b51udo1TjXJe3qFA4gF2kVMM=;
 b=IaDFBGNlRAy7t9iS8ziIvebHuH3KqTJZM12+RvAWrZsCRNSofoFy7dndThlDIs9rAMGQ9DIkZHr+15sRwQ5NdVNWSLk6vSuvdA5wgtEXXg2DZktLLTvMLvI4n63ug0LLZfAYR0/CAurAaBQwOlA9sgXmjsx/g72C4e4YQ2jaD7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB7056.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:18 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:18 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:14 +0100
Subject: [PATCH v3 06/16] rust: io: register: allow explicit base type
 specification
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-6-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=8478;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=BW8Pipu9gMJAyQKlc26RqfQ2wmugHrBod8hkXoCWiys=;
 b=x3ccwaV/CjmSIMrbYLibNmqdYxyP+CFFg91Gyjg59igKm8Kw/9ZyUgAw7Xt85GHf6a4sBQ8ip
 8cAOjS7trSzARESi3XBRrdkYjXdesVHF9EFwbZGy31l9kT9/fBPXcMK
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: a6603e59-4c38-4bc7-6fd7-08defde27429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|7416014|366016|23010399003|10067099003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	SVwkS6xdY8EbMS90c7ePoBtINdtCZAYX7+s18lGqWLOb5ComkHCyGMkIhRs9odPY20NcXSBc6AH4tu5xvUrDRVoX4x+6+YmOnRW1uJ42ZPiNxWe8Z/8FIv3cY9WEOxn2iysfaClmrPT30qYF4UfTv9w9r+7VC3sXqOlw+Cr7TjYSyNv4gxyRgo9DBuAJkoAtnjpzOg7KIlj7w4buY1+yfvcKyCUeJRmBtZ9pkgUAQt1AEcWf2tWhSmful8meFUONbix6DfIulY5aPqw2Y3FB7fkYKfgbLoIlr4lE1899ZcTgQzRx8vDgdGIeB8Etv6thvoZI1vpWs9p9L8Ne19sWieGxzyVM8nJNFQ7hz6kp9nFimD7Ls/D0wLIxU0sdQOeO3GQXnAyZYY1AlC8oJiBkHInIRDF/PJDnO4Hpze1eGwIRyTy3G8CvrWEXfGbezblSpuQTEHPvu1GJrwYCiiAELuKe5/8ouLAezkIhnIyOWyPwujmkrnYU64mbpe904YvdkqsM6Suq7UoxxEcunJgdgg7D5jtMg27bV30isGrljSPUyCsqG8SGx4bSFdiJ2A9mz6G9f2iFQSxtK8c9gV2umhOKDznnFNqhl4uimU5ETq1Fb8uvrd8fVQkrAH/MwOUBSgXPTrpmZCaICIzoQ+k8bydxKBL6JorVqaFSRwNFcTI/1s3JMYUi2y9gBR5Rh0URUThzY+XXg4luehqoxikyyg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(7416014)(366016)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXRZMDBBcUpXNU54ZmhYM0JjM0YrM2ZOVldQTzV3bHZzK3Q4L0JLM011VWFi?=
 =?utf-8?B?cU9DUmp4VGlDYUtwdkIyL0lnMy9pbXE4bEtnUnVHRGovMStGZE0wbjlUSUpG?=
 =?utf-8?B?TEtEbU1GNHhhVDA5WXB5SjFWZWRyVmtPeFBnYkxGTFJmZFcwdS81TXpja1N5?=
 =?utf-8?B?Z21yaHJOK1BueFNhT2p4bG96dzV2OVlJVnQrZk1KTDFRbU95cFNySHlmMG9R?=
 =?utf-8?B?Nk5jdzgvL1p3TXZ3ZHh1MTJUVEVDb2pHbTVqRVVZT2xhYnlBMGVxRnp2TklS?=
 =?utf-8?B?M1RIS3VyUFlKeEl6d2xKVi9VQzd0YUtxY1RLcTR4eStnR3U0N3k1OFNLZzNT?=
 =?utf-8?B?aTJITC9xYWdZRDBqTWRWcW1kY0kyV1hhT3dQT2gyeHlRVjVsNWQxL0d6SGZK?=
 =?utf-8?B?bW5UMHc2RjJOUk43YjhRM2dZOU8rOTdMcktKM1JBQVRySHNTT2gvWHpDazd6?=
 =?utf-8?B?UGRSK1FJYTBFRTlnblJTM21FQllxQU5vemIzR1F3eCt5UFUwWllXSEJrRDdz?=
 =?utf-8?B?ZUVybjhla252OHZOUjBZRSt5cnFaa0JBVlJDQ0doN0diV3FTMXhOVGJCeTNI?=
 =?utf-8?B?YjMycXpEOFlzbFlJVW82NElMWXpXVTJlUCt1MlUzOVRuNUh2WlZFUkNEdGRu?=
 =?utf-8?B?SmxEY216ZmhhR2d0azBDdmhKQnk1dERZSlRQL2dSOU02aC9KQ0Y1SzhGRDJU?=
 =?utf-8?B?L0UxL20zaHZEY1VaTnJPVGpaUStlQnM2WFBqVFo3enBwT3NkKzlrSVo3Rmhl?=
 =?utf-8?B?ZzdFanNCME9QZ3JlZ0krTllML3NCa1lveVB5YWZCWHArbmZ3NXFlSzhaQUNk?=
 =?utf-8?B?QmJTaDEvQlQ1dDU3QlZvMFh4MDl0K0JBZHAyZnl5RTZuYkR0WFlyT3FmVmM4?=
 =?utf-8?B?MmhxRmhJVDYwVHpwSGxXK1FUQWhWdWtMYjVyL0kvME8zTVo3S1Z5VlkxTW9t?=
 =?utf-8?B?US9od21WbHlGdjZDQW4xSnVMam94ZTFlRlR4YXhLSE1WYUZadmZXKy9zNDJo?=
 =?utf-8?B?dnQwNVFCaDIva2ZtYTZnQ09hRnQxcEdsZjZLSWJxaXZoWko5RFZsblZmbVRM?=
 =?utf-8?B?KzJxU21xcElZc2RGdlRkU2FuSXUrTDNQRFFKbmtzUDVteDU2NC9QLzVrcXBk?=
 =?utf-8?B?Q1k1UnNyc0xwSDBqQnB0Yy9UM2xHNFlsR0VJWkppa2FtRlpac1pqcTAwVSt3?=
 =?utf-8?B?N1g4OHhyTjIrSkI4NnlUalZIQ0xYdlk3bFhIek1ic2xqcE1PdUZqbXY2WXpK?=
 =?utf-8?B?ZUl4U3NPZGplek1lUGtsL1NMM2dtcHpYSUJFeThzZE10anFqR2lkTWtLVkoz?=
 =?utf-8?B?c3VJeFQ3elkyemg3b21WaEEyckV2a0w2Y2NHOWNYdWlER2lXNzQ4QmJ3TFps?=
 =?utf-8?B?K280eFZpTVVrQ29rZ2pUSDFPM1ZEVmpFVHFOeEUyQlZhTXM3VmJZZG9OcDNI?=
 =?utf-8?B?MEIrQWRWRjg2cFBxMzlTSGt3WnBEQVBQS045S1kxZWtrcDNCdHlOb0dTanJ4?=
 =?utf-8?B?RGFqTXNxVjFmdTVpN1A2VStpZ05TWjJhYnV4ekRXQTcxS05hbVhibzZBQkdF?=
 =?utf-8?B?MGVUVTZFS2hueDhadkdubVl0QjZzdEdsbU42c2duMzYwTkZ4T0xmZStxTmRp?=
 =?utf-8?B?TjR0d1JSaGh6OG9vUmp6UklyVFNWdTM1ZGNNa2MranZhZ2x3UVh2REhJS3po?=
 =?utf-8?B?a1JQK2VCWFQ2U0ZpVVE4WVYyUkJmd2p4ZHY1OExBb0FCSUduQmJsOWhaSHJG?=
 =?utf-8?B?V2JBSXRwTHZpYXhBVllRaW9nWXcrcEpEWUkvWTcxcjVEVTJvYTliakhJZjNC?=
 =?utf-8?B?eWJSVDROYTh0Ui9ZamN2c2VUMkxJSzdOc0ZCOE5jVEZLVy9SdkQ5VHJNRjFM?=
 =?utf-8?B?UWRsSTRhNzk2WHkySTBReHBIYzQyaFhBY2luOXdJMVFzNVo2YlRacWxweVpq?=
 =?utf-8?B?dTJMblk5VkR5b3BzSldBaFhLTmkwMnQxVytPbnFKdmxxdzlNQis4VktCTG1w?=
 =?utf-8?B?S2dOLzFpbEdwTm5jdHdDT2ppY2ZrSjJMMS9ZTm5jR2tmWEt5ZERZSU1hOEFN?=
 =?utf-8?B?OFZCYmlodkJxbkgwQ2NhTDRqNE9ZZ0ZjMnJRQTZKUmJvQlJET05objN2Mklh?=
 =?utf-8?B?Sk5hek4rZWtwb0VqYlAxaE9ROFd6NDkyaUFEcWlZV0FlSEhMallmVXBNR1E0?=
 =?utf-8?B?bkJWRVZLZmdzUzRiRHAzRm44eE5xUzE0M1BrVXZqMmdHVzUrOW9TRG5iRFQ0?=
 =?utf-8?B?UTF2SGVCNXdtZGh3UDNna05EQ0Fqai93VFhyekJ2Z1M2cDlVMXF5cmQvYzA1?=
 =?utf-8?B?b0N5dGpXUGFTTEQzcC9nTFMrdHJWRkxuU2xUUGNBbGtoYWNzdERIdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a6603e59-4c38-4bc7-6fd7-08defde27429
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:18.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeGfWNwOZ837SR554l18lYkNwx5/gjTeYgY7/GjszmXraVXNQbaKqtkOVEIjQHHQK+Yu+akrCGGfvevMD6ZMmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7056

Currently registers work for all untyped I/O regions, which is not ideal.
It allows registers defined for device A to work for another device B and
there is no safeguarding at all.

All users of the `register!` macro know what type it will be operating on,
and that type is consistent across the driver. Therefore, add a `base`
parameter to `register!`.

Currently this parameter is unused in the generated code; it will be used
when all users of `register!` is converted to gain the parameter.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          |  4 ++++
 rust/kernel/io/register.rs | 51 +++++++++++++++++++++++++++++++++++++++-------
 rust/macros/io/register.rs | 13 +++++++++++-
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index ea072c098b13..84dd876b3407 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -916,6 +916,8 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     /// };
     ///
     /// register! {
+    ///     base: Region;
+    ///
     ///     VERSION(u32) @ 0x100 {
     ///         15:8 major;
     ///         7:0  minor;
@@ -1058,6 +1060,8 @@ fn write<T, L>(self, location: L, value: T)
     /// };
     ///
     /// register! {
+    ///     base: Region<0x1000>;
+    ///
     ///     VERSION(u32) @ 0x100 {
     ///         15:8 major;
     ///         7:0  minor;
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 45d2e73a92e7..49a5fe069e47 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -13,9 +13,14 @@
 //! # Simple example
 //!
 //! ```no_run
-//! use kernel::io::register;
+//! use kernel::io::{
+//!     register,
+//!     Region,
+//! };
 //!
 //! register! {
+//!     base: Region<0x1000>;
+//!
 //!     /// Basic information about the chip.
 //!     pub BOOT_0(u32) @ 0x00000100 {
 //!         /// Vendor ID.
@@ -55,11 +60,14 @@
 //!         register,
 //!         Io,
 //!         IoLoc,
+//!         Region,
 //!     },
 //!     num::Bounded,
 //! };
-//! # use kernel::io::{Mmio, Region};
+//! # use kernel::io::Mmio;
 //! # register! {
+//! #     base: Region<0x1000>;
+//! #
 //! #     pub BOOT_0(u32) @ 0x00000100 {
 //! #         15:8 vendor_id;
 //! #         7:4 major_revision;
@@ -429,11 +437,14 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     io::{
 ///         register,
 ///         Io,
+///         Region,
 ///     },
 /// };
-/// # use kernel::io::{Mmio, Region};
+/// # use kernel::io::Mmio;
 ///
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     FIXED_REG(u32) @ 0x100 {
 ///         15:8 high_byte;
 ///         7:0  low_byte;
@@ -464,9 +475,14 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// the context:
 ///
 /// ```no_run
-/// use kernel::io::register;
+/// use kernel::io::{
+///     register,
+///     Region,
+/// };
 ///
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Scratch register.
 ///     pub SCRATCH(u32) @ 0x00000200 {
 ///         31:0 value;
@@ -516,6 +532,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// ```ignore
 /// register! {
+///     ...
 ///     pub RELATIVE_REG(u32) @ Base + 0x80 {
 ///         ...
 ///     }
@@ -542,9 +559,10 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///             WithBase,
 ///         },
 ///         Io,
+///         Region,
 ///     },
 /// };
-/// # use kernel::io::{Mmio, Region};
+/// # use kernel::io::Mmio;
 ///
 /// // Type used to identify the base.
 /// pub struct CpuCtlBase;
@@ -563,6 +581,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// // This makes `CPU_CTL` accessible from all implementors of `RegisterBase<CpuCtlBase>`.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// CPU core control.
 ///     pub CPU_CTL(u32) @ CpuCtlBase + 0x10 {
 ///         0:0 start;
@@ -579,6 +599,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// // Aliases can also be defined for relative register.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Alias to CPU core control.
 ///     pub CPU_CTL_ALIAS(u32) => CpuCtlBase + CPU_CTL {
 ///         /// Start the aliased CPU core.
@@ -621,15 +643,18 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         register,
 ///         register::Array,
 ///         Io,
+///         Region,
 ///     },
 /// };
-/// # use kernel::io::{Mmio, Region};
+/// # use kernel::io::Mmio;
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
 ///
 /// // Array of 64 consecutive registers with the same layout starting at offset `0x80`.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Scratch registers.
 ///     pub SCRATCH(u32)[64] @ 0x00000080 {
 ///         31:0 value;
@@ -655,6 +680,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // Alias to a specific register in an array.
 /// // Here `SCRATCH[8]` is used to convey the firmware exit code.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Firmware exit status code.
 ///     pub FIRMWARE_STATUS(u32) => SCRATCH[8] {
 ///         7:0 status;
@@ -667,6 +694,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // Here, each of the 16 registers of the array is separated by 8 bytes, meaning that the
 /// // registers of the two declarations below are interleaved.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Scratch registers bank 0.
 ///     pub SCRATCH_INTERLEAVED_0(u32)[16, stride = 8] @ 0x000000c0 {
 ///         31:0 value;
@@ -688,6 +717,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// ```ignore
 /// register! {
+///     ...
 ///     pub RELATIVE_REGISTER_ARRAY(u8)[10, stride = 4] @ Base + 0x100 {
 ///         ...
 ///     }
@@ -707,9 +737,10 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///             WithBase,
 ///         },
 ///         Io,
+///         Region,
 ///     },
 /// };
-/// # use kernel::io::{Mmio, Region};
+/// # use kernel::io::Mmio;
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -731,6 +762,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// // 64 per-cpu scratch registers, arranged as a contiguous array.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Per-CPU scratch registers.
 ///     pub CPU_SCRATCH(u32)[64] @ CpuCtlBase + 0x00000080 {
 ///         31:0 value;
@@ -758,6 +791,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// // Alias to `SCRATCH[8]` used to convey the firmware exit code.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Per-CPU firmware exit status code.
 ///     pub CPU_FIRMWARE_STATUS(u32) => CpuCtlBase + CPU_SCRATCH[8] {
 ///         7:0 status;
@@ -768,6 +803,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // Here, each of the 16 registers of the array is separated by 8 bytes, meaning that the
 /// // registers of the two declarations below are interleaved.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Scratch registers bank 0.
 ///     pub CPU_SCRATCH_INTERLEAVED_0(u32)[16, stride = 8] @ CpuCtlBase + 0x00000d00 {
 ///         31:0 value;
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index 8af12caa964b..2fb48e1be82d 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -27,6 +27,7 @@
 };
 
 mod kw {
+    syn::custom_keyword!(base);
     syn::custom_keyword!(stride);
 }
 
@@ -139,16 +140,26 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
 }
 
 pub(crate) struct RegDef {
+    base: Option<Type>,
     regs: Vec<Reg>,
 }
 
 impl Parse for RegDef {
     fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
+        let base = if input.peek(kw::base) {
+            let _: kw::base = input.parse()?;
+            let _: Token![:] = input.parse()?;
+            let base = input.parse()?;
+            let _: Token![;] = input.parse()?;
+            Some(base)
+        } else {
+            None
+        };
         let mut regs = Vec::new();
         while !input.is_empty() {
             regs.push(input.parse()?);
         }
-        Ok(RegDef { regs })
+        Ok(RegDef { base, regs })
     }
 }
 

-- 
2.54.0

