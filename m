Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828363EEAE7;
	Mon,  8 Jun 2026 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948770; cv=fail; b=QOTyTUmnrerPFoM8wU/0fBl9BFcilfk6a8x/GQFSevm3voN9npaHcYzPOYivOC0RBfiGvNdKWVWD2jYKNEka8yI3sU/tt8rCZNovSL3Z3kxDG5KjZeqxkcYwM1nOGQTAbPEajO4CphE/thi2qPfUxqnX5JOHU7U+q7Ox6ouq8Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948770; c=relaxed/simple;
	bh=07xGwWcYVaICSsPU1QnBMdFkxeGvgCqQU55QX5zieH8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dQ3tVIyWUXWwP4BkTgOjeaIMZ9c1kb8A/xPLO1+M7l7qpOQjUj3zG+kkmchj+1E8xvOycRqxQxT05edkmeST5zIO6tUa1d5ORq2YQZ+WtZNjOzpD/kmBBd3NvMVav5mjOAIV9cXu7SL6I0F8Dd1NlhecGcczX9Xxa7plGHblOeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Na4X4TC/; arc=fail smtp.client-ip=52.101.195.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Na4X4TC/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyVo032agHuHZLlt1oHNRmcMk18BmxE3RFSoHg0heTxXVW/YNSfBDVWet75yrUTKUQ2LCQ4VpqH93JMN7tYO7DmBibATVOg7uP3Ipkg3gS7pR0QqZZ/iBnRDF8BZ6qpL4ccZsaGpgMdIzEpzWHnSowaRxQCncZSnTtBekHc8/o4qX9i5HFCw5KpOnmhnq8GETyKRaXpQerP3KHBIu0pkhIPcsa85LQUp+Y4wfu7cP96oNND2el4EWrDSWfikB3X2kA6mATo0RnpqNLCCsEO9hILVwkkf2dFgZhPKsl6wJoTVlF8peDLdTjsWMMIpZH2uiMefwykOlS4CFFPf8JF/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpRY7YAg2M9rrd1G8XoLZfqEaOTd+0/YoDHU+HbjVIw=;
 b=ZEb4TXnZs1WtZQkF5pgK4RtsDzM4MaeRuf2NNSrCBxW2ewMsLIOWu2TvlP8ax5y+TI0JHaUpWAbR3Jv43Slc4ZGV+l6QyTG6Irz/q8UjNmmw4ddcxYqRahOIGMoaXuqRLifqS4RlKlix81ALMt31tsaGHdVY7ylA59xQACS6omM/7aAeUbvTuicr7yKMCjS3Jy8tjilePA6nyfw+8cEiQk571eLOJZehW4tXan5yv6DKfg7MRd7zYFNtHXQEooNQ7GRU8ulzr4fhjjnqEZA2orLzwrjGfqHem4joZ9FETvACR0faeUoxks78yvPV6uvHIeuk7N5nD4VmGKMU6UTgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpRY7YAg2M9rrd1G8XoLZfqEaOTd+0/YoDHU+HbjVIw=;
 b=Na4X4TC/FQPSdjo9dJGmNtNZPYSb3pJKVtVsGOvzHVmu8t9pqR1gG6gAFgAtDGA/F0ZEpURPTQnWAat3E8Zd0ub0Mjiu4IgaPs1T34kP9EbDw8SrXeOrhanBGL8xcsL0BPKinWFBsZsnarYgmhMQHsKtv9WZa+nhrnM8cSnRtrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:11 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:11 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:06 +0100
Subject: [PATCH v3 09/19] rust: io: use view types instead of addresses for
 `Io`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-9-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=30401;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=07xGwWcYVaICSsPU1QnBMdFkxeGvgCqQU55QX5zieH8=;
 b=xIQoFtsLbh6JjQCaxxpd3arwHfXQ/6xl3BMYD0ckyKzCQ1/2jTJ/oFja4P0U0kAZ60HQO0Oyd
 8RDSIdG4GcZD5p6tnWZWgzKL4VZEuOfNUwUqeCj8lY5uplF5GhCxw6B
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
X-MS-Office365-Filtering-Correlation-Id: 06586865-f43c-4669-1bd7-08dec59868ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	zySko1HMfIzdKyW4H7tNTCgCjpcCjT3bMjzWA2SKxP4qKtYoSjBPrn2gPcLysyrrPwjynbcKi6e64c3osCVVpxHEuAQ7BXvcqSKIIORMEw+k16x4J+QzCDX8EHLqjFKPcR47c/rQA2tFjV3/ibxBrqFfY6G9B8QJgb0IT0FEmyPPKZJirLMxPycAZ36DVJf/u8R4knn9Ad8LAhXOHANCWXYMv9PCT6cvSEDVgtLDwEWF6+Nwim+H8TR5ENtrBOb4flK01lTevmJ0e3djTnD+TylvMLPpdg09An8KS4vmbqmi5QG3HtugscF2vWtGmW0S4pwvTUZgBKIH9L/m5A4DWz1nD7Qd12N5cWej4RlTDdua7pad+Tys4/z+o22jn8TN6nMNCpQy4zdBYW8sXvHIhNU4pZrFVBRhm6e+yfvMQ9k7tLwcU9VaGsp4M/71pbuROPSlsUTNnl+mp1HzmjGVnaz86ntL/nrAQhz5DbEsbVjVIjP2qjR0E0Hs/Fzri/gIDUxlH3coBJbz7Bd9Fhx6RPnfi7Qg3RZjzi1y+XzE+N+EnA2QK+d4pzwlzeWsXKDnqTrBGGiX1OPd+a78Yy+m+wAcpsovnqkmscWTYbHzwKje97JgkBEEr8lca5/KIHU9fDE6sHBqt68LL/o/fDI5hktiAiY373eOIxFzCqN8pCTaaaTTRvu42K1l94ypOCLmgShHZh5OiewYNQx/OywpNPPRBIRPHVBYhxy7ClHrKCM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2greWVweDZLSDNyTjNIcExJNjNNRVp6bldHU2d0RUlzMUdYbk5odmNrYkRo?=
 =?utf-8?B?cGFlVWpiSSt6MmRUN29KTHlqcmgyZTZZdUgyOWpaeTA1RitWdmFPNU5uMHdi?=
 =?utf-8?B?T0xDL0hmcHFCSGJqMVVnY0h4M1NLSjBPY01ST0RxTFlXVlpqRmljNlZUT3FC?=
 =?utf-8?B?NDhrMVFVd1dKRzRuWlQwLzU0UTNZUGtreERFa0wvOHNNN3doclFsR200N3di?=
 =?utf-8?B?ZmdSYWtGZzhBaVZYQ3FQT0h2bXBJbjNLUEdmbWJZUzdQNmVsUTFMVEhnaW4r?=
 =?utf-8?B?cW5qd2xIazRxSFloVXdwRkd0cVF2SnRhcS8wWU5RUmdiK3BaT3U1UVU1T2lR?=
 =?utf-8?B?ak4wS3hJUHlRQmV5QWRId01XS2JjdGZFNUtzZVNOVy9GUCtZZnJZZGlPWDhX?=
 =?utf-8?B?MVJUT3JoT1ZxNTVCMEljZ0lGOGFlZEEvbEFnTlgvem1lb3NzcndJL0FSbEs0?=
 =?utf-8?B?V3ZtZWVWT0dEZ2I5RnNqY1IxS244MW9BVFdnSHprRSs3by8wZnNCTkhCb2V2?=
 =?utf-8?B?eDNoMlJlcTdsR3Z5UkxvV2dRQytpZm5lUS9jNFo0OFJRd1h6dXpJVFVCOWtw?=
 =?utf-8?B?dVdQT2pxeVUvZmd0SzRHZXNzTERNeEQ2Q1hMSS9KVzRpOTdPdW9peVJ0bitm?=
 =?utf-8?B?K2JXUTJNZGM3WWNTSjdHWXJvaFE1MW5BdGZ6aU9mZDdZUW5iV2t4SGtpVDFW?=
 =?utf-8?B?c1Awa1duYnNsRE9yUkVpMkVFci82b0NhcXlKVkR0a3dvR3NOU3NkSC9hRmVK?=
 =?utf-8?B?SEJSKzVYaFV0VjJwR0EzUXovTUxPRVczQ3RFc3NpNjdvWjFXTVhOSU5HWkpa?=
 =?utf-8?B?Z2JWYnp5YjdFZE9CV3RYY3FKNVN4VnJiMDU3QURRMDFQYXhSSHI4SXF1OVpT?=
 =?utf-8?B?b1hSV3ozbTAwQkRRcDdWRWZtQmdEUUhjOWd3WHI1V1N3Rno2UGN5aDJmTDNr?=
 =?utf-8?B?eDFBZWZneVhyT2ozbDc3eWRrbnp1MHE3SzNGSDJKYjRpeHdGVUUxT3RkUU8r?=
 =?utf-8?B?aUEwc1dCcU9YOU5sVHA0a2F1N041MWtvaHhRSFpudjdTYU5JVjNkejE0a3VH?=
 =?utf-8?B?ejlmbGgxajkzVVhMNVYyQW9HODcyK2F0RXNvVlpSbmdUMHZJSnFNdnF5QXVF?=
 =?utf-8?B?eTJwTDZ5QjVLNFZlcmp2Q3BJV3NuS2dFaHdNa1pKdHN1OEx4YW1Oem1IUmFa?=
 =?utf-8?B?ODVhRVFCODZFYnhoelJRcnVoRW9UU1VIQnF5cyt5RzRjRCtPOWVQQlpzbWta?=
 =?utf-8?B?VjIyVmE1N0FUb0ZweTh5UjFWNFd0UHJ2YjgwWkJ3WFA2QVU1YktWUmh4NDg0?=
 =?utf-8?B?bEFJWVUvK01lL1hnWnAwUTZRVmI5VzBEV0JsNWhVYnBlSmV0U0lFeHoyNFp1?=
 =?utf-8?B?YUxBanlTR04rN1hzS1daMy9iU0pWS1pxVTRqUjR3QWNVZWlDK0NPVXhveG9u?=
 =?utf-8?B?a0xKMTFnSDlqNGxVT0tPSWxlRGlxUVlaTkhTQ2ZtekE4VFJSYXJZaWdDMXVp?=
 =?utf-8?B?cU1obGhGb0FLNUlxYnU5eHlFMEl2dGpnSm5tbHNvek44TzU1WXVpR25WcWJE?=
 =?utf-8?B?MG1RY1Q3VU9RNkozVjRselNQK0lOSmVCOHRKT2NNVzg4Q2tIdHA1b1MzTHpz?=
 =?utf-8?B?Y0x1Ujh1c0s3ekhvU2c3MWFVVkhaTDVoNkpiRkx0amVBcC9qN25qZmVLZFNv?=
 =?utf-8?B?UUdEVU5uekl0SHoyWk5IYkVYZHpWWFpHeVRLME03NTM3V1gydFVLd2lKekxU?=
 =?utf-8?B?ZDA0ejR2aElWM0R4cUNlQ1hXc0FsN2hZUWExeUptUGl1bXQ5bFpsTzNTK2Zv?=
 =?utf-8?B?cnNGVTdyLzZQeGFDdEk1bWpGSDdhWG81UFJpTTZ0UGlPQUFtRkFiU0tobkRp?=
 =?utf-8?B?NkdmTkJDcUxrSVpvZFY3dGh1eTlKU3lBVFZvcENYWFNVZjVaTFN0OUdNZUYv?=
 =?utf-8?B?M0FySTZxaWY1dkhqalRZVHRqQ2I5TWo2aEJENnphWUVQekNMQ3lLcHM2OWpN?=
 =?utf-8?B?cDlrTkdtTEFhbyt1enVocVNzbmdkMzZZQnBQR0RuUm9uaHJHS2d5dFB1ZmhY?=
 =?utf-8?B?blk1RHI1cTh0SEptK3RjNW5CbGJGN0w4QjREWTZMRnExMXowUDVnVFRMRXAw?=
 =?utf-8?B?NjBpbmhxR0lNTzBXazNPSVEwQkZMamo0Q1l2KzExR1dSMUxkZndjY3NPTklo?=
 =?utf-8?B?cmhSQUlsVksrOG44dFVRZml4OFdBVC9HK25UVDZmTW45dzZ4TGdDL2VSWWF6?=
 =?utf-8?B?TEJsbmw2VFV1L3ZzZ0RoSkwwSjVtYThZcVUzSnhaTStqODh4Q1RESUhIbk81?=
 =?utf-8?B?bnNKSjhDOGs2RXM3MW5zZk81MmlaOFJPK21aUFZtZ2M3OU9PQW1yQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 06586865-f43c-4669-1bd7-08dec59868ba
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:11.6689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ey2F5QoxYUhmpI7ZPGvSARnBaaaDlhEvOPek3fdqpBb8BZG13EG336yK99eHPsa6kiOEPuynxKzbRdNj+HMafQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

Currently, `io_read` and `io_write` methods require the exact type of `Io`
plus an address. This means that they need to be monomorphized for each
different `Io` instance. This also means that multiple I/O implementors for
the same I/O kind needs to duplicate implementation (e.g. `Mmio` and
`MmioOwned`).

Create a new `IoBackend` trait and define these operations on it instead.
The operations are just going to receive a view type and operate on them.
This has the additional advantage that the invariants can be moved from the
trait (and guaranteed via `unsafe`) to type invariants on the canonical
view types of the backends, so `io_read` and `io_write` can be safe.

Note that view type is needed; addresses are insufficient in this
designk, as they do not carry sufficient information. For example,
`ConfigSpace` needs `&pci::Device` in addition to the address.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs     | 345 ++++++++++++++++++++++++++------------------------
 rust/kernel/pci/io.rs |  70 ++++++----
 2 files changed, 224 insertions(+), 191 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 771372a8aa36..d09d9864858d 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -246,6 +246,38 @@ const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bool {
     }
 }
 
+/// I/O backends.
+///
+/// This is an abstract representation to be implemented by arbitrary I/O
+/// backends (e.g. MMIO, PCI config space, etc.).
+///
+/// The base trait only defines the projection operations; which I/O methods are available depends
+/// on which [`IoCapable<T>`] traits are implemented for the type. For example, for MMIO regions,
+/// all widths (u8, u16, u32, and u64 on 64-bit systems) are typically supported. For PCI
+/// configuration space, u8, u16, and u32 are supported but u64 is not.
+///
+/// This trait is separate from the `Io` trait as multiple different I/O types may share the same
+/// operation.
+pub trait IoBackend {
+    /// View type for this I/O backend.
+    type View<'a, T: ?Sized + KnownSize>: Io<'a, Backend = Self, Target = T>;
+
+    /// Convert a `view` to a raw pointer for projection.
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T;
+
+    /// Project `view` to its subregion indicated by `ptr`.
+    ///
+    /// If input `view` is valid, returned view must also be valid.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a projection of `Self::as_ptr(view)`.
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U>;
+}
+
 /// Trait indicating that an I/O backend supports operations of a certain type and providing an
 /// implementation for these operations.
 ///
@@ -254,22 +286,12 @@ const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bool {
 /// For example, a PCI configuration space may implement `IoCapable<u8>`, `IoCapable<u16>`,
 /// and `IoCapable<u32>`, but not `IoCapable<u64>`, while an MMIO region on a 64-bit
 /// system might implement all four.
-pub trait IoCapable<T> {
-    /// Performs an I/O read of type `T` at `address` and returns the result.
-    ///
-    /// # Safety
-    ///
-    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
-    /// - `address` must be aligned.
-    unsafe fn io_read(self, address: usize) -> T;
+pub trait IoCapable<T>: IoBackend {
+    /// Performs an I/O read of type `T` at `view` and returns the result.
+    fn io_read<'a>(view: Self::View<'a, T>) -> T;
 
-    /// Performs an I/O write of `value` at `address`.
-    ///
-    /// # Safety
-    ///
-    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
-    /// - `address` must be aligned.
-    unsafe fn io_write(self, value: T, address: usize);
+    /// Performs an I/O write of `value` at `view`.
+    fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
 
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
@@ -321,56 +343,54 @@ fn offset(self) -> usize {
 /// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
 /// can perform I/O operations on regions of memory.
 ///
-/// This is an abstract representation to be implemented by arbitrary I/O
-/// backends (e.g. MMIO, PCI config space, etc.).
-///
 /// The [`Io`] trait provides:
-/// - Base address and size information
+/// - Method to convert into [`IoBackend::View`].
 /// - Helper methods for offset validation and address calculation
 /// - Fallible (runtime checked) accessors for different data widths
 ///
-/// Which I/O methods are available depends on which [`IoCapable<T>`] traits
-/// are implemented for the type.
-///
-/// # Examples
-///
-/// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
-/// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
-pub trait Io: Copy {
+/// Which I/O methods are available depends on the associated [`IoBackend`] implementation.
+pub trait Io<'a>: Copy {
+    /// Type that defines all I/O operations.
+    type Backend: IoBackend;
+
     /// Type of this I/O region. For untyped regions, [`Region`] can be used.
     type Target: ?Sized + KnownSize;
 
-    /// Returns the base address of this mapping.
-    fn addr(self) -> usize;
-
-    /// Returns the maximum size of this mapping.
-    fn maxsize(self) -> usize;
+    /// Return a view that covers the full region.
+    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target>;
 
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing compile-time bound checks.
+    /// Returns a view for a given `offset`, performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
-    fn io_addr_assert<U>(self, offset: usize) -> usize {
-        // We cannot check alignment with `offset_valid` using `self.addr()`. So set 0 for it and
+    fn io_addr_assert<U>(self, offset: usize) -> <Self::Backend as IoBackend>::View<'a, U> {
+        // We cannot check alignment with `offset_valid` using `ptr.addr()`. So set 0 for it and
         // ensure alignment by checking that the alignment of `U` is smaller or equal to the
         // alignment of `Self::Target`.
         const_assert!(Alignment::of::<U>().as_usize() <= Self::Target::MIN_ALIGN.as_usize());
         build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_SIZE));
 
-        self.addr() + offset
+        let view = self.as_view();
+        let ptr = Self::Backend::as_ptr(view);
+        let projected_ptr = ptr.cast::<U>().wrapping_byte_add(offset);
+        // SAFETY: `offset_valid` checks for size and alignment and therefore `projected_ptr` is a
+        // valid projection.
+        unsafe { Self::Backend::project_view(view, projected_ptr) }
     }
 
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing runtime bound checks.
+    /// Returns a view for a given `offset`, performing runtime bound checks.
     #[inline]
-    fn io_addr<U>(self, offset: usize) -> Result<usize> {
-        if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
+    fn io_addr<U>(self, offset: usize) -> Result<<Self::Backend as IoBackend>::View<'a, U>> {
+        let view = self.as_view();
+        let ptr = Self::Backend::as_ptr(view);
+
+        if !offset_valid::<U>(ptr.addr(), offset, KnownSize::size(ptr)) {
             return Err(EINVAL);
         }
 
-        // Probably no need to check, since the safety requirements of `Self::new` guarantee that
-        // this can't overflow.
-        self.addr().checked_add(offset).ok_or(EINVAL)
+        let projected_ptr = ptr.cast::<U>().wrapping_byte_add(offset);
+        // SAFETY: `offset_valid` checks for size and alignment and therefore `projected_ptr` is a
+        // valid projection.
+        Ok(unsafe { Self::Backend::project_view(view, projected_ptr) })
     }
 
     /// Fallible 8-bit read with runtime bounds check.
@@ -378,7 +398,7 @@ fn io_addr<U>(self, offset: usize) -> Result<usize> {
     fn try_read8(self, offset: usize) -> Result<u8>
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self: IoCapable<u8>,
+        Self::Backend: IoCapable<u8>,
     {
         self.try_read(offset)
     }
@@ -388,7 +408,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
     fn try_read16(self, offset: usize) -> Result<u16>
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self: IoCapable<u16>,
+        Self::Backend: IoCapable<u16>,
     {
         self.try_read(offset)
     }
@@ -398,7 +418,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
     fn try_read32(self, offset: usize) -> Result<u32>
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self: IoCapable<u32>,
+        Self::Backend: IoCapable<u32>,
     {
         self.try_read(offset)
     }
@@ -408,7 +428,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
     fn try_read64(self, offset: usize) -> Result<u64>
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self: IoCapable<u64>,
+        Self::Backend: IoCapable<u64>,
     {
         self.try_read(offset)
     }
@@ -418,7 +438,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
     fn try_write8(self, value: u8, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self: IoCapable<u8>,
+        Self::Backend: IoCapable<u8>,
     {
         self.try_write(offset, value)
     }
@@ -428,7 +448,7 @@ fn try_write8(self, value: u8, offset: usize) -> Result
     fn try_write16(self, value: u16, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self: IoCapable<u16>,
+        Self::Backend: IoCapable<u16>,
     {
         self.try_write(offset, value)
     }
@@ -438,7 +458,7 @@ fn try_write16(self, value: u16, offset: usize) -> Result
     fn try_write32(self, value: u32, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self: IoCapable<u32>,
+        Self::Backend: IoCapable<u32>,
     {
         self.try_write(offset, value)
     }
@@ -448,7 +468,7 @@ fn try_write32(self, value: u32, offset: usize) -> Result
     fn try_write64(self, value: u64, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self: IoCapable<u64>,
+        Self::Backend: IoCapable<u64>,
     {
         self.try_write(offset, value)
     }
@@ -458,7 +478,7 @@ fn try_write64(self, value: u64, offset: usize) -> Result
     fn read8(self, offset: usize) -> u8
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self: IoCapable<u8>,
+        Self::Backend: IoCapable<u8>,
     {
         self.read(offset)
     }
@@ -468,7 +488,7 @@ fn read8(self, offset: usize) -> u8
     fn read16(self, offset: usize) -> u16
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self: IoCapable<u16>,
+        Self::Backend: IoCapable<u16>,
     {
         self.read(offset)
     }
@@ -478,7 +498,7 @@ fn read16(self, offset: usize) -> u16
     fn read32(self, offset: usize) -> u32
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self: IoCapable<u32>,
+        Self::Backend: IoCapable<u32>,
     {
         self.read(offset)
     }
@@ -488,7 +508,7 @@ fn read32(self, offset: usize) -> u32
     fn read64(self, offset: usize) -> u64
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self: IoCapable<u64>,
+        Self::Backend: IoCapable<u64>,
     {
         self.read(offset)
     }
@@ -498,7 +518,7 @@ fn read64(self, offset: usize) -> u64
     fn write8(self, value: u8, offset: usize)
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self: IoCapable<u8>,
+        Self::Backend: IoCapable<u8>,
     {
         self.write(offset, value)
     }
@@ -508,7 +528,7 @@ fn write8(self, value: u8, offset: usize)
     fn write16(self, value: u16, offset: usize)
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self: IoCapable<u16>,
+        Self::Backend: IoCapable<u16>,
     {
         self.write(offset, value)
     }
@@ -518,7 +538,7 @@ fn write16(self, value: u16, offset: usize)
     fn write32(self, value: u32, offset: usize)
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self: IoCapable<u32>,
+        Self::Backend: IoCapable<u32>,
     {
         self.write(offset, value)
     }
@@ -528,7 +548,7 @@ fn write32(self, value: u32, offset: usize)
     fn write64(self, value: u64, offset: usize)
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self: IoCapable<u64>,
+        Self::Backend: IoCapable<u64>,
     {
         self.write(offset, value)
     }
@@ -560,12 +580,10 @@ fn write64(self, value: u64, offset: usize)
     fn try_read<T, L>(self, location: L) -> Result<T>
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
-        let address = self.io_addr::<L::IoType>(location.offset())?;
-
-        // SAFETY: `address` has been validated by `io_addr`.
-        Ok(unsafe { self.io_read(address) }.into())
+        let view = self.io_addr::<L::IoType>(location.offset())?;
+        Ok(Self::Backend::io_read(view).into())
     }
 
     /// Generic fallible write with runtime bounds check.
@@ -595,14 +613,11 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
-        let address = self.io_addr::<L::IoType>(location.offset())?;
+        let view = self.io_addr::<L::IoType>(location.offset())?;
         let io_value = value.into();
-
-        // SAFETY: `address` has been validated by `io_addr`.
-        unsafe { self.io_write(io_value, address) }
-
+        Self::Backend::io_write(view, io_value);
         Ok(())
     }
 
@@ -643,7 +658,7 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -676,17 +691,14 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
-        let address = self.io_addr::<L::IoType>(location.offset())?;
+        let view = self.io_addr::<L::IoType>(location.offset())?;
 
-        // SAFETY: `address` has been validated by `io_addr`.
-        let value: T = unsafe { self.io_read(address) }.into();
+        let value: T = Self::Backend::io_read(view).into();
         let io_value = f(value).into();
-
-        // SAFETY: `address` has been validated by `io_addr`.
-        unsafe { self.io_write(io_value, address) }
+        Self::Backend::io_write(view, io_value);
 
         Ok(())
     }
@@ -716,12 +728,10 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     fn read<T, L>(self, location: L) -> T
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
-        let address = self.io_addr_assert::<L::IoType>(location.offset());
-
-        // SAFETY: `address` has been validated by `io_addr_assert`.
-        unsafe { self.io_read(address) }.into()
+        let view = self.io_addr_assert::<L::IoType>(location.offset());
+        Self::Backend::io_read(view).into()
     }
 
     /// Generic infallible write with compile-time bounds check.
@@ -749,13 +759,11 @@ fn read<T, L>(self, location: L) -> T
     fn write<T, L>(self, location: L, value: T)
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
-        let address = self.io_addr_assert::<L::IoType>(location.offset());
+        let view = self.io_addr_assert::<L::IoType>(location.offset());
         let io_value = value.into();
-
-        // SAFETY: `address` has been validated by `io_addr_assert`.
-        unsafe { self.io_write(io_value, address) }
+        Self::Backend::io_write(view, io_value);
     }
 
     /// Generic infallible write of a fully-located register value.
@@ -794,7 +802,7 @@ fn write_reg<T, L, V>(self, value: V)
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -827,17 +835,13 @@ fn write_reg<T, L, V>(self, value: V)
     fn update<T, L, F>(self, location: L, f: F)
     where
         L: IoLoc<Self::Target, T>,
-        Self: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
-        let address = self.io_addr_assert::<L::IoType>(location.offset());
-
-        // SAFETY: `address` has been validated by `io_addr_assert`.
-        let value: T = unsafe { self.io_read(address) }.into();
+        let view = self.io_addr_assert::<L::IoType>(location.offset());
+        let value: T = Self::Backend::io_read(view).into();
         let io_value = f(value).into();
-
-        // SAFETY: `address` has been validated by `io_addr_assert`.
-        unsafe { self.io_write(io_value, address) }
+        Self::Backend::io_write(view, io_value);
     }
 }
 
@@ -881,78 +885,76 @@ unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, T> {}
 // SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
 unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
 
-impl<T: ?Sized + KnownSize> Io for Mmio<'_, T> {
+impl<'a, T: ?Sized + KnownSize> Io<'a> for Mmio<'a, T> {
+    type Backend = MmioBackend;
     type Target = T;
 
     #[inline]
-    fn addr(self) -> usize {
-        self.ptr.addr()
+    fn as_view(self) -> Mmio<'a, T> {
+        self
     }
+}
+
+/// I/O Backend for memory-mapped I/O.
+pub struct MmioBackend;
+
+impl IoBackend for MmioBackend {
+    type View<'a, T: ?Sized + KnownSize> = Mmio<'a, T>;
 
     #[inline]
-    fn maxsize(self) -> usize {
-        KnownSize::size(self.ptr)
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        view.ptr
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        _view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement, `ptr` is projection from `view`, so it is also a valid
+        // memory-mapped I/O region.
+        Mmio {
+            ptr,
+            phantom: PhantomData,
+        }
     }
 }
 
-/// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
+/// Implements [`IoCapable`] on `$backend` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
-    ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
-        $(#[$attr])*
-        impl<T: ?Sized> IoCapable<$ty> for $mmio<'_, T> {
+    ($backend: ident, $ty:ty, $read_fn:ident, $write_fn:ident) => {
+        impl IoCapable<$ty> for $backend {
             #[inline]
-            unsafe fn io_read(self, address: usize) -> $ty {
-                // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
-                unsafe { bindings::$read_fn(address as *const c_void) }
+            fn io_read(view: <$backend as IoBackend>::View<'_, $ty>) -> $ty {
+                // SAFETY: By the type invariant, `view.ptr` is a valid address for MMIO operations.
+                unsafe { bindings::$read_fn(view.ptr.cast_const().cast()) }
             }
 
             #[inline]
-            unsafe fn io_write(self, value: $ty, address: usize) {
-                // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
-                unsafe { bindings::$write_fn(value, address as *mut c_void) }
+            fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
+                // SAFETY: By the type invariant, `view.ptr` is a valid address for MMIO operations.
+                unsafe { bindings::$write_fn(value, view.ptr.cast()) }
             }
         }
     };
 }
 
 // MMIO regions support 8, 16, and 32-bit accesses.
-impl_mmio_io_capable!(Mmio, u8, readb, writeb);
-impl_mmio_io_capable!(Mmio, u16, readw, writew);
-impl_mmio_io_capable!(Mmio, u32, readl, writel);
+impl_mmio_io_capable!(MmioBackend, u8, readb, writeb);
+impl_mmio_io_capable!(MmioBackend, u16, readw, writew);
+impl_mmio_io_capable!(MmioBackend, u32, readl, writel);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
 #[cfg(CONFIG_64BIT)]
-impl_mmio_io_capable!(Mmio, u64, readq, writeq);
+impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
 
-impl<'a, const SIZE: usize> Io for &'a MmioOwned<SIZE> {
+impl<'a, const SIZE: usize> Io<'a> for &'a MmioOwned<SIZE> {
+    type Backend = MmioBackend;
     type Target = Region<SIZE>;
 
-    /// Returns the base address of this mapping.
     #[inline]
-    fn addr(self) -> usize {
-        self.0.addr()
-    }
-
-    /// Returns the maximum size of this mapping.
-    #[inline]
-    fn maxsize(self) -> usize {
-        self.0.size()
-    }
-}
-
-impl<'a, const SIZE: usize, T> IoCapable<T> for &'a MmioOwned<SIZE>
-where
-    Mmio<'a, Region<SIZE>>: IoCapable<T>,
-{
-    #[inline]
-    unsafe fn io_read(self, address: usize) -> T {
-        // SAFETY: Per safety requirement.
-        unsafe { self.as_view().io_read(address) }
-    }
-
-    #[inline]
-    unsafe fn io_write(self, value: T, address: usize) {
-        // SAFETY: Per safety requirement.
-        unsafe { self.as_view().io_write(value, address) }
+    fn as_view(self) -> Mmio<'a, Self::Target> {
+        // SAFETY: `Mmio` has same invariant as `MmioOwned`
+        unsafe { Mmio::from_raw(self.0) }
     }
 }
 
@@ -968,13 +970,6 @@ pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
         // SAFETY: `MmioOwned` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
-
-    /// Return a view that covers the full region.
-    #[inline]
-    pub fn as_view(&self) -> Mmio<'_, Region<SIZE>> {
-        // SAFETY: `Mmio` has same invariant as `MmioOwned`.
-        unsafe { Mmio::from_raw(self.0) }
-    }
 }
 
 /// [`Mmio`] but using relaxed accessors.
@@ -1000,17 +995,38 @@ fn clone(&self) -> Self {
     }
 }
 
-impl<T: ?Sized + KnownSize> Io for RelaxedMmio<'_, T> {
-    type Target = T;
+/// I/O Backend for memory-mapped I/O, with relaxed access semantics.
+pub struct RelaxedMmioBackend;
+
+impl IoBackend for RelaxedMmioBackend {
+    type View<'a, T: ?Sized + KnownSize> = RelaxedMmio<'a, T>;
 
     #[inline]
-    fn addr(self) -> usize {
-        self.ptr.addr()
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        view.ptr
     }
 
     #[inline]
-    fn maxsize(self) -> usize {
-        KnownSize::size(self.ptr)
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        _view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement, `ptr` is projection from `view`, so it is also a valid
+        // memory-mapped I/O region.
+        RelaxedMmio {
+            ptr,
+            phantom: PhantomData,
+        }
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> Io<'a> for RelaxedMmio<'a, T> {
+    type Backend = RelaxedMmioBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> RelaxedMmio<'a, T> {
+        self
     }
 }
 
@@ -1046,14 +1062,9 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
 }
 
 // MMIO regions support 8, 16, and 32-bit accesses.
-impl_mmio_io_capable!(RelaxedMmio, u8, readb_relaxed, writeb_relaxed);
-impl_mmio_io_capable!(RelaxedMmio, u16, readw_relaxed, writew_relaxed);
-impl_mmio_io_capable!(RelaxedMmio, u32, readl_relaxed, writel_relaxed);
+impl_mmio_io_capable!(RelaxedMmioBackend, u8, readb_relaxed, writeb_relaxed);
+impl_mmio_io_capable!(RelaxedMmioBackend, u16, readw_relaxed, writew_relaxed);
+impl_mmio_io_capable!(RelaxedMmioBackend, u32, readl_relaxed, writel_relaxed);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
-impl_mmio_io_capable!(
-    RelaxedMmio,
-    #[cfg(CONFIG_64BIT)]
-    u64,
-    readq_relaxed,
-    writeq_relaxed
-);
+#[cfg(CONFIG_64BIT)]
+impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_relaxed);
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index a4cfa1ec6e62..9286b2e419f9 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -9,6 +9,7 @@
     devres::Devres,
     io::{
         Io,
+        IoBackend,
         IoCapable,
         MmioOwned,
         MmioRaw,
@@ -78,32 +79,57 @@ fn clone(&self) -> Self {
     }
 }
 
+/// I/O Backend for PCI configuration space.
+pub struct ConfigSpaceBackend;
+
+impl IoBackend for ConfigSpaceBackend {
+    type View<'a, T: ?Sized + KnownSize> = ConfigSpace<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: ConfigSpace<'a, T>) -> *mut T {
+        view.ptr
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement.
+        ConfigSpace {
+            pdev: view.pdev,
+            ptr,
+        }
+    }
+}
+
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, T: ?Sized> IoCapable<$ty> for ConfigSpace<'a, T> {
-            unsafe fn io_read(self, address: usize) -> $ty {
+        impl IoCapable<$ty> for ConfigSpaceBackend {
+            fn io_read(view: ConfigSpace<'_, $ty>) -> $ty {
+                // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
+                // signed offset parameter. PCI configuration space size is at most 4096 bytes,
+                // so the value always fits within `i32` without truncation or sign change.
+                let addr = view.ptr.addr() as i32;
+
                 let mut val: $ty = 0;
 
                 // Return value from C function is ignored in infallible accessors.
-                let _ret =
-                    // SAFETY: By the type invariant `self.pdev` is a valid address.
-                    // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
-                    // signed offset parameter. PCI configuration space size is at most 4096 bytes,
-                    // so the value always fits within `i32` without truncation or sign change.
-                    unsafe { bindings::$read_fn(self.pdev.as_raw(), address as i32, &mut val) };
-
+                // SAFETY: By the type invariant `pdev` is a valid address.
+                let _ = unsafe { bindings::$read_fn(view.pdev.as_raw(), addr, &mut val) };
                 val
             }
 
-            unsafe fn io_write(self, value: $ty, address: usize) {
+            fn io_write(view: ConfigSpace<'_, $ty>, value: $ty) {
+                // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
+                // signed offset parameter. PCI configuration space size is at most 4096 bytes,
+                // so the value always fits within `i32` without truncation or sign change.
+                let addr = view.ptr.addr() as i32;
+
                 // Return value from C function is ignored in infallible accessors.
-                let _ret =
-                    // SAFETY: By the type invariant `self.pdev` is a valid address.
-                    // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
-                    // signed offset parameter. PCI configuration space size is at most 4096 bytes,
-                    // so the value always fits within `i32` without truncation or sign change.
-                    unsafe { bindings::$write_fn(self.pdev.as_raw(), address as i32, value) };
+                // SAFETY: By the type invariant `pdev` is a valid address.
+                let _ = unsafe { bindings::$write_fn(view.pdev.as_raw(), addr, value) };
             }
         }
     };
@@ -114,17 +140,13 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, T: ?Sized + KnownSize> Io for ConfigSpace<'a, T> {
+impl<'a, T: ?Sized + KnownSize> Io<'a> for ConfigSpace<'a, T> {
+    type Backend = ConfigSpaceBackend;
     type Target = T;
 
     #[inline]
-    fn addr(self) -> usize {
-        self.ptr.addr()
-    }
-
-    #[inline]
-    fn maxsize(self) -> usize {
-        KnownSize::size(self.ptr)
+    fn as_view(self) -> ConfigSpace<'a, T> {
+        self
     }
 }
 

-- 
2.54.0

