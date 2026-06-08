Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020080.outbound.protection.outlook.com [52.101.196.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD73F1658;
	Mon,  8 Jun 2026 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948774; cv=fail; b=puISLc23DD1GBQ/3jK4GC7ZVsTyS50adyXJGwciHAEHk1PCx5vVz2ha9sKefCi+N8vTGhsl/0aZcNVQZKjqfwAU82ChTRdK/rnVuyBGTJPpqYHqb3msARYOU/GsPpb+mVo4JmybeXzy5vWP5GmbWf6mnDha44mz8i1C+63C51i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948774; c=relaxed/simple;
	bh=BBwKMm17IeGIaVGQr0hPKvwXhlHdIsUV/DwitqNy3e0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g+VybHXC8Tsdbewg3wT7TBauVzP8Liowwv08LAOnhFK99q7cWigji842vTpIoK4uSaXvm7Y6K0pdyNj1oEFydlfyryAVckR81fKDKkMe5U4B4HkWO/naHopsJ/4pA8FBd06O6LQ9hOQqF6JMD8vYNpyMP6C5RAHvAZWJLBkrjuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=jtbD8i72; arc=fail smtp.client-ip=52.101.196.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="jtbD8i72"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJMDaR0KP3Sus9P6IX3+ZrHQsDduz+hm8Eni/CiNFi8go6HQXWLXViQobY4ajY1I3qZSfMAH5B65biDAQBe/BUm0/Su3Gh498K+Li0iwar7i46yQDphEnQxML8+rQUcU3nK1FHDiymrH5y7OpC0CIbCgwqFUxfE0DW7QhbM6EfHch+02hP17JkDHkjRPuJls4mAsPdFtDk62nCphVy484ljD3JRdDuO0g8ECc6Fx0WhI8R5gy2XcimOyxdswpI6NorPQyZhhCtT/9Nn793X6COUZ7lOICT0mvCD0Drg95/yGMCUaIjFP8DbTFFTV9iZVpg+MBBYrhPH9L8uQ3ZLBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SyRkf5bGgPUNu0KLGOX4k+Q9xt5K6NM7mKy99GC+5k=;
 b=eD8FvnQQFmiy71LF48AqHYe1lQIoN/ZvUxCIA2glQvFHjri7p31twu2W/rohrWCQZvlOImqXMBlTpsEKe//4baOZFJkU7Fu7ftUkdIWQTacay4z26esc9HyJsPvD5e+I/PHeOTMfzlH8Dp0IGSGWGvELm7nNJi43MlhxMAGKH0AMIR+/LltluppR8n+XpQEVNEmCABppXpi6IDGK2mw3Xy23LBEahwQuMl7NPrRKOBjf6ELR+GLCPKj4PgR0Bjqqj5ptjrRuokwpzISq7j1ICUDtYHGCe+5PX7uZOpsPkPUhi7q2wIavqdO2XFbCI93m3KBQb9Zak/LQGpeCJmzWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SyRkf5bGgPUNu0KLGOX4k+Q9xt5K6NM7mKy99GC+5k=;
 b=jtbD8i72AZ/ulmpvLY2BIIiw0Z40RxnsMipSvnwKZeN4lM4iOcPpT/qBwzF1zwnitA5ecDvXRqwOyMeKhsLQvNN1/WmP5CxaLiuAiHu9fWRctdIdgB5ZMb7Z50YtCoIPzqwUmUcb4+e7ny6rgfzZUxiRpTBwvo1DhzMSNklDnC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:12 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:12 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:09 +0100
Subject: [PATCH v3 12/19] rust: io: add projection macro and methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-12-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=5924;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=BBwKMm17IeGIaVGQr0hPKvwXhlHdIsUV/DwitqNy3e0=;
 b=lCk+4unqi+baHmzzweBh/dNSAyE65Rz7YrGYT13/6/LSGKTvuDmrnVhTsAdVBa5VbdPV9pqee
 oB+aWEENS29Bbfa79/wXHQ2lzPJKpyo8lcvliW2rruTlN5Jkrmyp9vM
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
X-MS-Office365-Filtering-Correlation-Id: 8bca0864-c199-4a08-f363-08dec598696c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	6+4ovOPyJWB//g8ERHMYceAI+AM9K/sZhP3KTUSAB9QE8zOJu5lC7H2SywPssOmb4xXCLgLKu9JKEB9Fwggxq4uodfUQH0o3o32nyhe11ITQ4dLOp88DHsl2ahrqRFxEp4L+Tj+QijaEVltKySDG3BK4qMadssdhe2wpbUH/qF4KwM/0oxCbPf18+/nyuFrX+kB5K7ZrUx41fHSL/E8chxMFD6cIL6gz4TKw+Zzw/JspBLRgAQbTHLgnJw/nL9dBS8RzNZEZC7N5t05YC92Y5vdFV3Cn4m7jcabo7otrKiBvaa/ZA1qSQbNCq5NfboucdhrjvyH82ctAGifLZF8ARmRI+i1GSDFhlXt9PFFNicFE8vpTACRan5KNED5prT6ezQuAzqBxmA+QKRC7OBCCtcLmUThcth8Q6EcO+78/jNIFcpLfTF7SBB0BdM0lvxbWQ1+TZ1B2RXhOrVBYLcFolAGG4yl2wilgVdXhbx3j4BMhH5zumNlW9kEwVGcDOu2QJfcPEoPdoo2YPmyZ9VIS8asg3YlyM44MtbVqXGEXNTxXr3c768363Q0RyB02tT5aQAq1+JLtNGZs5H7gt8mHdXv03smmbjZ3+FBtecElk96/uv5AAmMVJiQvjkNRnnB8gMJ7zk+HHNEeTynT0ozClxpA4rWoaU86BBW48jr1kEWoPszlqgRkz4sQvf+ZqcwR5X3d82/xpl2au82mpnwVqncJRMdOvxN69C7/pWNj3hc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0o4K1p4TU9BZ3VmVHk1b0JTcFdaeDlOamtKam1DdEdtUFZvM2xCMDJnUFp2?=
 =?utf-8?B?ODlhbkVYWEVvRUp6bVVhdm9hZCtNczlxRTIycnBwUjFYcXFEdVhwVE83QUtZ?=
 =?utf-8?B?RTEvazlJSjhQNzUwbC9OL083eTQ0UmIxT3JuRzYraXdFT1Rsc2ZSckk2cDdO?=
 =?utf-8?B?TXFqYi94dllsdEdGWkk0dVVEV2JxSWUwVE5EdVU2MjhVVTZ2dE1xeUQzYzMz?=
 =?utf-8?B?NWc0OEpYL1ZpTFdKdWw0bnJPZkZOMlNGMThsTU9LMFFLMFlNWFI5TmVtUG5Z?=
 =?utf-8?B?OWVGOVg2SCt6NGdnaG14VW5iSHJVd3VFOU1MMGVWT3VJYkdZNFlSVjlNeFFJ?=
 =?utf-8?B?dDJzUWxwRE5yeGJBS2pHbmRVSEtwenQwT3pUM0Q2T1RyODNGeEpVS0N6emFF?=
 =?utf-8?B?REJsbkhZZFd1VEVGdEhXeDRTQ0ZUSUgvUW9oYlVaYlBmVzZXS2d4Z3N2SHBy?=
 =?utf-8?B?aldzcWU0azUvdGhhNjZSdkRsckJqa1g2eHpnZS9XMWVIdUZ5WHA1NlgxT3dR?=
 =?utf-8?B?bE9EWXVldGZvY2tVaDdRZjlENlpEbnpXS29jemx3RGtzL01hV2MyTjJLQXZF?=
 =?utf-8?B?eVk3MllZQ0xhbE01L2trNm9NTW9QZFVWRllQVTJiQnoxMnRiSjBJclNReXVw?=
 =?utf-8?B?aklhRXliMWloODBCS2YrQUVNVWJHeUE0OEdvY29yNDh4Q2UwK0swT1ZJQmVq?=
 =?utf-8?B?ZUcvR0hCck93MHJiMVlsMTZWb0tZaGJQUldWOHJ6UXpPVnRRNkdyZllkVkRs?=
 =?utf-8?B?ZmZmY20rTGQzVVhTSm1OZW93YWx2ekVsbnBzRUd6KzNzRTlTRVRQMWZnK1dE?=
 =?utf-8?B?bzlPaHRPbDdmbjhRNTl5cU5IRFBvTGpSMStxRnd2MUh2bVlWK25wdGFldEZj?=
 =?utf-8?B?ZGhoNURvbGlzWVhOdllGSGJWRElpaWN1RWZocDBIZmpwSlR5SERmNFVLMzQr?=
 =?utf-8?B?WHdZbWkra3ZTQXhmSm03VWZRNTZ0b2sxTGR4MjJoS0FGd1RFR20xMmNhd2Zl?=
 =?utf-8?B?clVwRmdpQXU4d3BzL0k2d04raTZkTGdKUFhSNStFcFEyRHNOWk1HMU5Kck1n?=
 =?utf-8?B?WVBvVkdIQURqZXo4RDAvV2NQVEliWGRLbkZpL2xRQmdweTJIak1WZk10Sys1?=
 =?utf-8?B?UWM2KzE2THpuampCclAwMlZQSjZmMDhHTmZBVDFDcURkTkVTalZyUXJTb0dt?=
 =?utf-8?B?Uy9xNkkzSFpvZVFNUi9VQS9IajdKL1NPbVVjK093bXJJSGRxaW5NUjlZaTNW?=
 =?utf-8?B?TU4wM1lFWUROSGVLT1BtOXRRQXFzd3Rya21ualR4UDZlbmxSeTc5cHA5WmRi?=
 =?utf-8?B?U09keEpvNUtLRTBUSWp4R1hrbzFFNDNyWHMzSDZ1bkF4RTNXWElxdVkxNlk3?=
 =?utf-8?B?VERhTVE0WVpiTzVhN052MURQU0F3OGFZWWRQQjNiTFJkMHhmMGtOUTBXK2N5?=
 =?utf-8?B?QzNYWkVMbnZIQm1WMytpVEdod3pDVHlTdFJMSG1QZUVaSmxEcktVRjFtNFJ3?=
 =?utf-8?B?T3lNSzhwN1JyQ2MrSW1kNEc1T2hNbjdrTWErUlhTQ1FYRjhrRnBQa3BZdEd4?=
 =?utf-8?B?enVPYmlZRXU0WnUyeUpUT3psVlAzMjUzZGxYVzMyeUU3YUdrL0trbXVlQ0d1?=
 =?utf-8?B?Q2U2RFJ4OVdyRmJiTWNETXFwcTc1bENEQmZsRFpoNEpEaUxKVVNYZTdhcHFZ?=
 =?utf-8?B?aUFpWlptalRobFcyampWdjZQanlxL2dUUlJKbkRwMU5VTW9SV2U2UDhkc3Rk?=
 =?utf-8?B?NCt1WlhMcUwwYVNGTFd3SjFIZjdZNkl1ZWczYmxHVlJndDhhNWZ0SzFER2cx?=
 =?utf-8?B?UDNiSVpOUmVNQXR3YWQxTGF4bXJ5eUdKOWJYTXFwYnhDNGZoaWd5M2R4M3pv?=
 =?utf-8?B?Z3hzNVAxK0tyMzBiOWs3enQrOTdEMXBvL0dacWhvdkwzM1poaWlpYUQrN0xW?=
 =?utf-8?B?bGtvejRCMGRmd3RTNSs4anNpUXFvcUsxYnlvSVhKN1pIZldrYVErZE1jV1hF?=
 =?utf-8?B?TnA0aXJ1L3c4VGlEUitWNUJwR2Y4QWY1cjZTKzV3Tnp0c1d4T1RhNmY5MGNa?=
 =?utf-8?B?NnRHOGlzOFhIaVFXbW9MRFhmK3NSdjNESXpmL3VVMjdvYWI1NlBJZXVybndL?=
 =?utf-8?B?UG9jUHIzaVFUSk1lMnNqTEZnTUc2L1AvSzk3MjBsV1N0SHZucjlqL3c1SWRX?=
 =?utf-8?B?UjV5ZEFBSTZ4VHlCNFlOd2wrQjFqcUNoOFFWbEtxWjYxWVNpSlFQVjBwR25B?=
 =?utf-8?B?a2ZZWS9tZk5HbHlwWE41d3EvcmUvUlc0WFpIREtOTGdjRU5leEpXQWt0aTU3?=
 =?utf-8?B?c1lhcm5sdHhPYXI5R2pGNDlGVFhzQm5mMkduWkpqbmxHWEIyYmxhUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bca0864-c199-4a08-f363-08dec598696c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:12.8292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeK4EOKfcT9ctFu+TbUV5BfHJmiKufCAzxGkgclJGsTLXFBGSHnC8E+AcGf6aiy+OsXClu02Tq3vCEnHnZcjFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

Add a `io_project!()` macro allows projection from `Io` to a subview of it,
using the pointer projection mechanism to perform compile-time checks.

For cases where type-casting is required, the `try_cast()` function may be
used where the size and alignment checks are performed at runtime.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 9c2ea17ca87b..173f8c0ba2d6 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -14,6 +14,10 @@
     ptr::{
         Alignment,
         KnownSize, //
+    },
+    transmute::{
+        AsBytes,
+        FromBytes, //
     }, //
 };
 
@@ -92,6 +96,11 @@ fn size(p: *const Self) -> usize {
     }
 }
 
+// SAFETY: I/O regions can compose of arbitrary bytes.
+unsafe impl<const SIZE: usize> kernel::transmute::FromBytes for Region<SIZE> {}
+// SAFETY: Values read from I/O are always treated as initialized.
+unsafe impl<const SIZE: usize> kernel::transmute::AsBytes for Region<SIZE> {}
+
 /// Raw representation of an MMIO region.
 ///
 /// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
@@ -297,6 +306,53 @@ fn size(self) -> usize {
         KnownSize::size(Self::Backend::as_ptr(self.as_view()))
     }
 
+    /// Try to convert into a different typed I/O view.
+    ///
+    /// The target type must be of same or smaller size to current type, and the current view must
+    /// be properly aligned for the target type.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::io::{
+    ///     io_project,
+    ///     Mmio,
+    ///     Io,
+    ///     Region,
+    /// };
+    /// struct MyStruct { field: u32, }
+    ///
+    /// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+    /// unsafe impl kernel::transmute::FromBytes for MyStruct {};
+    /// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+    /// unsafe impl kernel::transmute::AsBytes for MyStruct {};
+    ///
+    /// # fn test(mmio: &Mmio<'_, Region>) -> Result {
+    /// // let mmio: Mmio<Region>;
+    /// let whole: Mmio<'_, MyStruct> = mmio.try_cast()?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    #[inline]
+    fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
+    where
+        Self::Target: FromBytes + AsBytes,
+        U: FromBytes + AsBytes,
+    {
+        let view = self.as_view();
+        let ptr = Self::Backend::as_ptr(view);
+
+        if size_of::<U>() > KnownSize::size(ptr) {
+            return Err(EINVAL);
+        }
+
+        if ptr.addr() % align_of::<U>() != 0 {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: We have checked bounds and alignment, so this is a valid projection.
+        Ok(unsafe { Self::Backend::project_view(view, ptr.cast()) })
+    }
+
     /// Returns a view for a given `offset`, performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
@@ -983,3 +1039,78 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
 // MMIO regions on 64-bit systems also support 64-bit accesses.
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_relaxed);
+
+// This helper turns associated functions to methods so it can be invoked in macro.
+// Used by `io_project!()` only.
+#[doc(hidden)]
+#[derive(Clone, Copy)]
+pub struct ProjectHelper<T>(pub T);
+
+impl<'a, T> ProjectHelper<T>
+where
+    T: Io<'a, Backend: IoBackend<View<'a, T::Target> = T>>,
+{
+    // These helper methods must not have symbols present in binary to avoid confusion.
+    #[inline(always)]
+    pub fn as_ptr(self) -> *mut T::Target {
+        T::Backend::as_ptr(self.0)
+    }
+
+    /// # Safety
+    ///
+    /// Same as `IoBackend::project_view`
+    #[inline(always)]
+    pub unsafe fn project_view<U: ?Sized + KnownSize>(
+        self,
+        ptr: *mut U,
+    ) -> <T::Backend as IoBackend>::View<'a, U> {
+        // SAFETY: Per safety requirement.
+        unsafe { T::Backend::project_view::<T::Target, _>(self.0, ptr) }
+    }
+}
+
+/// Project an I/O type to a subview of it.
+///
+/// The syntax is of form `io_project!(io, proj)` where `io` is an expression to a type that
+/// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!).
+///
+/// In addition to projecting from [`Io`], you may also project from a [`View`] of an [`Io`].
+///
+/// # Examples
+///
+/// ```
+/// use kernel::io::{
+///     io_project,
+///     Mmio,
+/// };
+/// struct MyStruct { field: u32, }
+///
+/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct {};
+/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct {};
+///
+/// # fn test(mmio: Mmio<'_, [MyStruct]>) -> Result {
+/// // let mmio: Mmio<[MyStruct]>;
+/// let field: Mmio<'_, u32> = io_project!(mmio, [try: 1].field);
+/// let whole: Mmio<'_, MyStruct> = io_project!(mmio, [try: 2]);
+/// let nested: Mmio<'_, u32> = io_project!(whole, .field);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_project {
+    ($io:expr, $($proj:tt)*) => {{
+        #[allow(unused)]
+        use $crate::io::IoBase as _;
+        let view = $crate::io::ProjectHelper($io.as_view());
+        let ptr = $crate::ptr::project!(
+            mut view.as_ptr(), $($proj)*
+        );
+        #[allow(unused_unsafe)]
+        // SAFETY: `ptr` is a projection.
+        unsafe { view.project_view(ptr) }
+    }};
+}
+#[doc(inline)]
+pub use crate::io_project;

-- 
2.54.0

