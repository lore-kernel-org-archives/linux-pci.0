Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020097.outbound.protection.outlook.com [52.101.196.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D713EDAB1;
	Mon,  8 Jun 2026 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948765; cv=fail; b=Cy+upv4IlXusEQtVSaCwf6vqeEl8PEmhqToc1PUhF/Wa9yL36lP0WdJNlM8irivIZW7qqEaAB/N2ngL+nSndGnXh+XGgKqWg8+DAFCfsKl+ULPHsfC9m7AC/lDFahJlI4c28ywkvRPGc6tWoMIeJfa7WtDSG5xlgRR65JUfdU7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948765; c=relaxed/simple;
	bh=r2q1qWfO5e8jFD2g6fm9zgAg3vp0e062rU1FIO/ucj8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aSxwbVRCKCPlgNWgkguFkzWiL/ELCcsMPmvp2GfpQvqe6JJMXD/2P9VnvmNaypdefSwuHAi04SGSLdgEuIBnNrf0Wm9M/jFAfTx+bCLqjp1dGgxIby0FfhBL1YhZKfjAslxqh2nOIat3SIZTYG/yUURxHULOsHLaUGlpfECJCok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=YcC13fwe; arc=fail smtp.client-ip=52.101.196.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="YcC13fwe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhQNgHdsrDgVB3kNMCS+h3wz44g2hM4mYNQTFEDcJoydqXWM4kohho27QtrvXjCGYO0NVte3XhqCrRudBv4DFJHV5meXh+/v9kMhcFmPDCJ3VOrnDSwkc031Gotfmh8vQAcWX0p2U1fMzNvSzPTk0lZlM1NhJQXTxCNyxk29aF1aGevkUEfXMf0cEOU/6HMoe8QvyNQbA44uzXf9qhHsv/iZG/hFdYWjnR1UGZNVAt4/n9DFHp0D2l4jfBgPQ10OgbjIIhhl21L3MvdpaPymUifA7WyLRIHMSZGXDm+fJqcgYfyyA+PpWBJEe6/uzNCnCSaztaZOpfSg81NSQ+7+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEfMySBA5gL3Uwz/ku/52pFwMwCdpQEsHoeUoShfEXs=;
 b=MD7MRlwfI2Nq6pDRJdY0nCqQ1kkiOynJJ+nyvF3FmJQwCA0WteaPGz3UWyAFRjjVtSmu0GAQLjXiHTlRLnxfJM/8Rpd91HOHKSTC6KVURP8NmhBoKXSwxFstvbbta34dZYoM19ZonUwrSqehd6qDXO6adwpQTcu1mddSpqJBUsVhSjETaZ0jihTipu2k/V8vsaQlk/gMracZm/PVP17I80cS1xM828yz+tdjSFcpTXNrsHkYfbD7/X4qWAUdd+7/dElh2FyLSOGeHpLkyXAjNtJbx6kNTacmkd0SXmr1WpGhsZ+cSF7xTAygGLCap2aoT7IucUuizGBCzDOwA3B+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEfMySBA5gL3Uwz/ku/52pFwMwCdpQEsHoeUoShfEXs=;
 b=YcC13fweLU/68YEEXHda3gTqWcO7KMiztvZt9B9WoaKtHgjimFCP97+bg/q+SvYMftvR8B9/kfEV6+ZqeaktDMsCOsQ5SMhtTiVgZmUZtghyqwT+BivfOiAdLa/t24++LQ94QvM+I8bVRBCgf1P/B6wGZ51lHE8ail/rG5h4Ui4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:10 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:10 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:04 +0100
Subject: [PATCH v3 07/19] rust: io: implement `Mmio` as view type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-7-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
In-Reply-To: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=16544;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=r2q1qWfO5e8jFD2g6fm9zgAg3vp0e062rU1FIO/ucj8=;
 b=On/r4pfiW8c7U/YE1O08vKoFGA2NJRYIqz4l2MH8j1PQA+5rZxdfubFgSR99WtSB1G5R6NJw5
 9an3oto88o7CzV8oAFPTCt3DkVOCRHu4puUY77gbaRHQTas5eUnindr
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0344.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 015066b1-da44-4d36-788e-08dec5986844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Koopa51sFrQKFAOWL9jJ3EZ5VIpVvfR2NzwC8ee5S+YaA15Skf7i7C4giXqqc2QN9LKDtjO1VYtjS7SYWitpJleBNx7vY5h4GCzpMvfBLp/WYKtq91JiP0tBGzlFkd7GtF59PBYTHDcPxYSXl6PjHbgkMCVmrzrOZmUDcrq8PqnPk5cGcYcnbPAQQQZdOEPnSKAj38yACjQHkf8zeiH/SmUKZJMfQEZITzgTgFVkwoRWre68NeHYNq+WUmm8JWIZCiZJtqZZ9bHoRVybyfdm8xazxzLHADnlzSCAXoNTQtYVMXvLMDq6zZ6y0HERzTp2uGrjr9TnC3xtDx4eIUd94uyKt54K+yhC6w+VQ3M/FQPgQFga+pJAILzKFMzzdv6HnLUNV64w9GkKju/BSXVI3tgrLYOgxej6LArxohHbpq/SAC35hV5MF3gPf2RvkeFRYs94dxiPX+VXZE4dYqdt+lFkxtTLvu8fX1gjv7K5HmZLL9UF8t5RVCQ3d8gP2iwuR0HfdkdYQp2HQ0MdmTRRQD7KhtSwrK1jCrkR+S/xZGwbtibXGI0TNog5CmbfMiHJocO9cOa4UNcMGIuucdLdtTkzpprgkPkkzgRqcgtKCwtIililaOBGvnlXrr9WuaS7Qf0+5fDMiVwUkFFqgKjA7opqsP0uzBsShq2zf66Fd5+Qh3cIwGdchVpuCcAro1DkN11fMgxJfQVjwKaEZeEDQp/Ns9z21ooTNNTG5vW5ck8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXFld2tZa1YxV3lJdU1ocjYxZVZKWGpJaUNyQUpHelJ3aFQ0b3FyMnJWdlBI?=
 =?utf-8?B?dVRiVGRIMEFTem4wOGFMQm9GeUFMaVBuTHdoOTRQenFIN21sclFKem40cmt1?=
 =?utf-8?B?ZWhSeUpwcDJ2V0NKRllGWVIwcWhPTGZ6SU14eXE5THlwS2k0SmQyeGdML0Vv?=
 =?utf-8?B?TXpsdnErUVVvS21PSEs2R2RBMnkrUEhJOWI2NTNJdXdCZ3IrRjV5bmtSL1Mz?=
 =?utf-8?B?NU9tQ0Uvb1BLSE1LbjdXSnlsT0hXMCtjNENVMFhvSUFtcUJKNTAySTlWcG9W?=
 =?utf-8?B?QW10OXFaL2NWWTdlUjNDVjhoeW5lR0FqMnU2R3EwWFB3S1k2NE1Wd2wwWXFT?=
 =?utf-8?B?Ui9kWDkrdWE4TktHQmlWY0xxemlGcUhOMzZlN01vRG1mTDltZHVyUGgzelJC?=
 =?utf-8?B?Sncxa2JzLzJSYWVDK0FYSGZvZ3VJYWpsMStTYlFRWUZMK2NzTXRCNklSbFA1?=
 =?utf-8?B?aEsyNjIxY2Z4VGJOeTljVnhlQzZaNkV0eFVKVzB5dGFSV2QxUjFNRlZ5TTZm?=
 =?utf-8?B?NnVNNGJ3ZlNHTkNwN2JQUXhFa0JDMjMwUmMyWnRYb2l6NVZaVjNESm5NNTZ2?=
 =?utf-8?B?OURST0FUUm1oYUFMWVNXc2E0UTdvVVhPdEVLSVhLbDdCVGdEbTkzUHVzQ3dI?=
 =?utf-8?B?Y3g3VWRTR1YzQkpjVm1kZWtiWnM1SGZwZUt1WDhOakJWNUZQSjEwWk1QS3Fa?=
 =?utf-8?B?RktJYmQyNHJZd0YxZDg2aElBcmxnNElVMjJHR1dJQWpIaEo1Sk5YRnJGS2U2?=
 =?utf-8?B?cDJsSFJrYmJJZCtIVFBqS3AzQWM5OWdZci83QmQ5d04zZXdpSkdDQ21kbW9o?=
 =?utf-8?B?ODl2NU8vaThEVXFYSDd0WjdnNFVPY0tjSDRUUHRna0wzckZlR2ZJa2xjQUll?=
 =?utf-8?B?R2x4L3p3WlZWMm02NFBTTDczRTZ6cktadkNqdzVxVWRFMnZueGdmMVlmT3g5?=
 =?utf-8?B?SHpjMHFSSUswbHorZVBKdVBWMk8xMGJCZHl2UkdPdzQ1eUZVbTlUdEZhVGpk?=
 =?utf-8?B?bHpqWkh2a0NSeFhDLzdEQVpkeUpwUkRDY0lIa3F4TUwwV0Q4TVV2dlZrcnRL?=
 =?utf-8?B?TTRVRk82WWxUOG13cVlieTdVZDg1bFkvZXlOYWVqSnlWT0NQSTk4eUhYRlNL?=
 =?utf-8?B?OFRXQzZQeWIvTWRDclpNZ0xqRm50NnVPaVNsK3dCcURIdEZndndtN09UMDhW?=
 =?utf-8?B?WWJvaW5oTnozUHdOcTJ6dGJ6S3dyL1IwOVVDYzR4d0dKTzJjQ055UnVmbXVZ?=
 =?utf-8?B?R0hPbCtMTVRKTzROalVpVklDbnBITGVyTVBLRjVmaTFteHVkbUFSNHcrMGVY?=
 =?utf-8?B?MFhYTHFZMjUxYzY3UmtuemprN0dKdEhxRjBVQnBrMi8zTGVvT0tFczczenBt?=
 =?utf-8?B?cnMwRUJxQVg2bjFkZ0lEMEpaUGVldTlHNVZndmlMOEVFYUFMVzhhVHhKWmNj?=
 =?utf-8?B?TE5QNUYrcGNFVm9qcmFSWHFmY3Y1cTVvRURZd3pKa0FPK1BBQ3hOcnZPK2F4?=
 =?utf-8?B?c2lncU5La0N2VHpiR0YwMWxSRUp2WHBsempjTlBZdjBLMENmdytmamVtcnBs?=
 =?utf-8?B?aE5tYzkrQ3dPOGY1SERoMjljVmhuamhYRHlITzAxdEJBN2t2Q3IrWGJrcDFC?=
 =?utf-8?B?ZGZSUyt3YmhxdG9rNlZtRk5abU45QnhSQ3ErNHg1aWc4VzNKK1JvQWY0RUI2?=
 =?utf-8?B?UmhBVkJBM1dxd284WVVVRmVtYjhBNUdyS1A4K0RwelNtKzJLc1JkZTdibWox?=
 =?utf-8?B?OWdIZmFkNzF4R2ZmeW9hSmNqZmpienZpVVVUcXZ3OVlkZ2pJSjRRS0N6SEdK?=
 =?utf-8?B?djBKOTMvMHA2cEhsTk90Mzh4NElGV2hXRFhSMEJuTmVFN2RPcG1tV3R2UFhD?=
 =?utf-8?B?RGRLSnkzQnFxQXU1OTIwYVQyQXhOUHBRK2FYRFM4bHNQT0JZYTkvQ2lUSUVj?=
 =?utf-8?B?bElZSFc3bHFEL0JIamxtK0R1bVJTQnMyT2hpS1RmU2lBcFF5aXRoVjRkZHM0?=
 =?utf-8?B?R1R2dXg4bWN4YjhraGVaUXAzK3ZJelFVakx5MVZoQWJyclRzTW9HNGxhaFZ4?=
 =?utf-8?B?RFdkenhTaWFuRHZhVzBzTmhTTUNkc2hRYk1KZFdEdUIxQXdjLzNtSnRFZnFo?=
 =?utf-8?B?ekVIQlEzLzNmNUhHOTd1SVVwelZoT04rSVB6OWZkT1NnNnN3WHNVeXQyLzZU?=
 =?utf-8?B?ZE02N3RpRkxTRlB4WXA3VTBVV1JNT201dlA4NUtjZnMwMmd1ekw0K3pVOTNy?=
 =?utf-8?B?T3hCbHdZQ1BUaDFYelpsL0MwOE1iNkFVRFp2Ym5YQm13VDdzazRRWUtuc0dv?=
 =?utf-8?B?QTE3SlZKTzJzckhoTGhxQTErQm9QR1pNWk16Q3paeU9GQkhsTERzdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 015066b1-da44-4d36-788e-08dec5986844
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:10.8893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8/RlTn3aaET7PLllG9T0fSzks0+rUlzsMj1AAx5V/7beJ8DZYuS5gmdg38AQrQAKwm0Sd08hci5RynUqrwFrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

Implement `Mmio` as view type and convert `RelaxedMmio` to view type as
well. I/O implementations of `MmioOwned` are changed to delegate to the
`Mmio` view type.

All existing users of `MmioOwned` in the documentation which do not
actually reflect the owning semantics is converted.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          | 188 +++++++++++++++++++++++++++++++++++----------
 rust/kernel/io/poll.rs     |  10 ++-
 rust/kernel/io/register.rs |  24 +++---
 3 files changed, 164 insertions(+), 58 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d5c233a66846..771372a8aa36 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -4,6 +4,10 @@
 //!
 //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
 
+use core::{
+    marker::PhantomData, //
+};
+
 use crate::{
     bindings,
     prelude::*,
@@ -538,10 +542,11 @@ fn write64(self, value: u64, offset: usize)
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_reads(io: &MmioOwned) -> Result {
+    /// fn do_reads(io: Mmio<'_, Region>) -> Result {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.try_read(0x10)?;
     ///
@@ -572,10 +577,11 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_writes(io: &MmioOwned) -> Result {
+    /// fn do_writes(io: Mmio<'_, Region>) -> Result {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.try_write(0x10, 1u32)?;
     ///
@@ -610,7 +616,8 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
     /// register! {
@@ -626,7 +633,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &MmioOwned) -> Result {
+    /// fn do_write_reg(io: Mmio<'_, Region>) -> Result {
     ///
     ///     io.try_write_reg(VERSION::new(1, 0))
     /// }
@@ -655,10 +662,11 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_update(io: &MmioOwned<0x1000>) -> Result {
+    /// fn do_update(io: Mmio<'_, Region<0x1000>>) -> Result {
     ///     io.try_update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -692,10 +700,11 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_reads(io: &MmioOwned<0x1000>) {
+    /// fn do_reads(io: Mmio<'_, Region<0x1000>>) {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.read(0x10);
     ///
@@ -724,10 +733,11 @@ fn read<T, L>(self, location: L) -> T
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_writes(io: &MmioOwned<0x1000>) {
+    /// fn do_writes(io: Mmio<'_, Region<0x1000>>) {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.write(0x10, 1u32);
     ///
@@ -758,7 +768,8 @@ fn write<T, L>(self, location: L, value: T)
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
     /// register! {
@@ -774,7 +785,7 @@ fn write<T, L>(self, location: L, value: T)
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &MmioOwned<0x1000>) {
+    /// fn do_write_reg(io: Mmio<'_, Region<0x1000>>) {
     ///     io.write_reg(VERSION::new(1, 0));
     /// }
     /// ```
@@ -802,10 +813,11 @@ fn write_reg<T, L, V>(self, value: V)
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_update(io: &MmioOwned<0x1000>) {
+    /// fn do_update(io: Mmio<'_, Region<0x1000>>) {
     ///     io.update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -829,16 +841,72 @@ fn update<T, L, F>(self, location: L, f: F)
     }
 }
 
+/// A view of memory-mapped I/O region.
+///
+/// # Invariant
+///
+/// `ptr` points to a valid and aligned memory-mapped I/O region for the duration lifetime `'a`.
+pub struct Mmio<'a, T: ?Sized> {
+    ptr: *mut T,
+    phantom: PhantomData<&'a ()>,
+}
+
+impl<T: ?Sized> Copy for Mmio<'_, T> {}
+impl<T: ?Sized> Clone for Mmio<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<'a, T: ?Sized> Mmio<'a, T> {
+    /// Create a `Mmio`, providing the accessors to the MMIO mapping.
+    ///
+    /// # Safety
+    ///
+    /// `raw` represents an valid and aligned memory-mapped I/O region while `'a` is alive.
+    #[inline]
+    pub unsafe fn from_raw(raw: MmioRaw<T>) -> Self {
+        // INVARIANT: Per safety requirement.
+        Self {
+            ptr: raw.ptr,
+            phantom: PhantomData,
+        }
+    }
+}
+
+// SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, T> {}
+
+// SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
+
+impl<T: ?Sized + KnownSize> Io for Mmio<'_, T> {
+    type Target = T;
+
+    #[inline]
+    fn addr(self) -> usize {
+        self.ptr.addr()
+    }
+
+    #[inline]
+    fn maxsize(self) -> usize {
+        KnownSize::size(self.ptr)
+    }
+}
+
 /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
         $(#[$attr])*
-        impl<const SIZE: usize> IoCapable<$ty> for &$mmio<SIZE> {
+        impl<T: ?Sized> IoCapable<$ty> for $mmio<'_, T> {
+            #[inline]
             unsafe fn io_read(self, address: usize) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$read_fn(address as *const c_void) }
             }
 
+            #[inline]
             unsafe fn io_write(self, value: $ty, address: usize) {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$write_fn(value, address as *mut c_void) }
@@ -848,17 +916,12 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 }
 
 // MMIO regions support 8, 16, and 32-bit accesses.
-impl_mmio_io_capable!(MmioOwned, u8, readb, writeb);
-impl_mmio_io_capable!(MmioOwned, u16, readw, writew);
-impl_mmio_io_capable!(MmioOwned, u32, readl, writel);
+impl_mmio_io_capable!(Mmio, u8, readb, writeb);
+impl_mmio_io_capable!(Mmio, u16, readw, writew);
+impl_mmio_io_capable!(Mmio, u32, readl, writel);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
-impl_mmio_io_capable!(
-    MmioOwned,
-    #[cfg(CONFIG_64BIT)]
-    u64,
-    readq,
-    writeq
-);
+#[cfg(CONFIG_64BIT)]
+impl_mmio_io_capable!(Mmio, u64, readq, writeq);
 
 impl<'a, const SIZE: usize> Io for &'a MmioOwned<SIZE> {
     type Target = Region<SIZE>;
@@ -876,6 +939,23 @@ fn maxsize(self) -> usize {
     }
 }
 
+impl<'a, const SIZE: usize, T> IoCapable<T> for &'a MmioOwned<SIZE>
+where
+    Mmio<'a, Region<SIZE>>: IoCapable<T>,
+{
+    #[inline]
+    unsafe fn io_read(self, address: usize) -> T {
+        // SAFETY: Per safety requirement.
+        unsafe { self.as_view().io_read(address) }
+    }
+
+    #[inline]
+    unsafe fn io_write(self, value: T, address: usize) {
+        // SAFETY: Per safety requirement.
+        unsafe { self.as_view().io_write(value, address) }
+    }
+}
+
 impl<const SIZE: usize> MmioOwned<SIZE> {
     /// Converts an `MmioRaw` into an `MmioOwned` instance, providing the accessors to the MMIO
     /// mapping.
@@ -888,32 +968,53 @@ pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
         // SAFETY: `MmioOwned` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
+
+    /// Return a view that covers the full region.
+    #[inline]
+    pub fn as_view(&self) -> Mmio<'_, Region<SIZE>> {
+        // SAFETY: `Mmio` has same invariant as `MmioOwned`.
+        unsafe { Mmio::from_raw(self.0) }
+    }
 }
 
-/// [`MmioOwned`] wrapper using relaxed accessors.
+/// [`Mmio`] but using relaxed accessors.
 ///
 /// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
 /// the regular ones.
 ///
-/// See [`MmioOwned::relaxed`] for a usage example.
-#[repr(transparent)]
-pub struct RelaxedMmio<const SIZE: usize = 0>(MmioOwned<SIZE>);
+/// See [`Mmio::relaxed`] for a usage example.
+///
+/// # Invariant
+///
+/// `ptr` points to a valid and aligned memory-mapped I/O region for the duration lifetime `'a`.
+pub struct RelaxedMmio<'a, T: ?Sized> {
+    ptr: *mut T,
+    phantom: PhantomData<&'a ()>,
+}
 
-impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
-    type Target = Region<SIZE>;
+impl<T: ?Sized> Copy for RelaxedMmio<'_, T> {}
+impl<T: ?Sized> Clone for RelaxedMmio<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<T: ?Sized + KnownSize> Io for RelaxedMmio<'_, T> {
+    type Target = T;
 
     #[inline]
     fn addr(self) -> usize {
-        self.0.addr()
+        self.ptr.addr()
     }
 
     #[inline]
     fn maxsize(self) -> usize {
-        self.0.maxsize()
+        KnownSize::size(self.ptr)
     }
 }
 
-impl<const SIZE: usize> MmioOwned<SIZE> {
+impl<'a, T: ?Sized> Mmio<'a, T> {
     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
     ///
     /// Relaxed accessors do not provide ordering guarantees with respect to DMA or memory accesses
@@ -924,20 +1025,23 @@ impl<const SIZE: usize> MmioOwned<SIZE> {
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     ///     RelaxedMmio,
     /// };
     ///
-    /// fn do_io(io: &MmioOwned<0x100>) {
+    /// fn do_io(io: Mmio<'_, Region<0x100>>) {
     ///     // The access is performed using `readl_relaxed` instead of `readl`.
     ///     let v = io.relaxed().read32(0x10);
     /// }
     ///
     /// ```
-    pub fn relaxed(&self) -> &RelaxedMmio<SIZE> {
-        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `MmioOwned`, so `MmioOwned<SIZE>`
-        // and `RelaxedMmio<SIZE>` have identical layout.
-        unsafe { core::mem::transmute(self) }
+    pub fn relaxed(self) -> RelaxedMmio<'a, T> {
+        // INVARIANT: `RelaxedMmio` has the same invariant as `Mmio`.
+        RelaxedMmio {
+            ptr: self.ptr,
+            phantom: PhantomData,
+        }
     }
 }
 
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 79828a8006b5..d75f2fcf46f2 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -47,14 +47,15 @@
 /// ```no_run
 /// use kernel::io::{
 ///     Io,
-///     MmioOwned,
+///     Mmio,
+///     Region,
 ///     poll::read_poll_timeout, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: Mmio<'_, Region<SIZE>>) -> Result {
 ///     read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
@@ -134,14 +135,15 @@ pub fn read_poll_timeout<Op, Cond, T>(
 /// ```no_run
 /// use kernel::io::{
 ///     Io,
-///     MmioOwned,
+///     Mmio,
+///     Region,
 ///     poll::read_poll_timeout_atomic, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: Mmio<'_, Region<SIZE>>) -> Result {
 ///     read_poll_timeout_atomic(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index e375a1332f37..2fe7ba60a95f 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -58,7 +58,7 @@
 //!     },
 //!     num::Bounded,
 //! };
-//! # use kernel::io::MmioOwned;
+//! # use kernel::io::{Mmio, Region};
 //! # register! {
 //! #     pub BOOT_0(u32) @ 0x00000100 {
 //! #         15:8 vendor_id;
@@ -66,7 +66,7 @@
 //! #         3:0 minor_revision;
 //! #     }
 //! # }
-//! # fn test(io: &MmioOwned<0x1000>) {
+//! # fn test(io: Mmio<'_, Region<0x1000>>) {
 //! # fn obtain_vendor_id() -> u8 { 0xff }
 //!
 //! // Read from the register's defined offset (0x100).
@@ -446,7 +446,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 ///
 /// register! {
 ///     FIXED_REG(u32) @ 0x100 {
@@ -455,7 +455,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &MmioOwned<0x1000>) {
+/// # fn test(io: Mmio<'_, Region<0x1000>>) {
 /// let val = io.read(FIXED_REG);
 ///
 /// // Write from an already-existing value.
@@ -559,7 +559,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 ///
 /// // Type used to identify the base.
 /// pub struct CpuCtlBase;
@@ -584,7 +584,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: MmioOwned<0x1000>) {
+/// # fn test(io: Mmio<'_, Region<0x1000>>) {
 /// // Read the status of `Cpu0`.
 /// let cpu0_started = io.read(CPU_CTL::of::<Cpu0>());
 ///
@@ -601,7 +601,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: MmioOwned<0x1000>) {
+/// # fn test2(io: Mmio<'_, Region<0x1000>>) {
 /// // Start the aliased `CPU0`, leaving its other fields untouched.
 /// io.update(CPU_CTL_ALIAS::of::<Cpu0>(), |r| r.with_alias_start(true));
 /// # }
@@ -638,7 +638,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -651,7 +651,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &MmioOwned<0x1000>)
+/// # fn test(io: Mmio<'_, Region<0x1000>>)
 /// #     -> Result<(), Error>{
 /// // Read scratch register 0, i.e. I/O address `0x80`.
 /// let scratch_0 = io.read(SCRATCH::at(0)).value();
@@ -724,7 +724,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -752,7 +752,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &MmioOwned<0x1000>) -> Result<(), Error> {
+/// # fn test(io: Mmio<'_, Region<0x1000>>) -> Result<(), Error> {
 /// // Read scratch register 0 of CPU0.
 /// let scratch = io.read(CPU_SCRATCH::of::<Cpu0>().at(0));
 ///
@@ -794,7 +794,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: &MmioOwned<0x1000>) -> Result<(), Error> {
+/// # fn test2(io: Mmio<'_, Region<0x1000>>) -> Result<(), Error> {
 /// let cpu0_status = io.read(CPU_FIRMWARE_STATUS::of::<Cpu0>()).status();
 /// # Ok(())
 /// # }

-- 
2.54.0

