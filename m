Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022106.outbound.protection.outlook.com [52.101.101.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063541931D;
	Thu, 11 Jun 2026 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195312; cv=fail; b=dVKgws8MWvh/eAjU80JhVNhcayg9JhhxlmCBl6/s+aUrLJF/Q7NENSf3d9uqIjK9Lb0CcDh0aU6H25StKAWEl4bzGoVwWJSbEGRPa5rJGtsol1cS/WGSFOgIQkwFa0dMzMxrh4FS0uizbBybXvKuGgjDqwJP/MbE8X5jc1kv7+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195312; c=relaxed/simple;
	bh=kZBNsPkay2J/c/qRJQEZ3Wab5O9w345WmRB9JEIlcC4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Q96dSu5ekQ8AWZfg3KQViZO2/0KlO3yV/46UJu/f+o69tfTJ30ALM0x8eCxaPLnKFP5hl4Dhl+nPDarryY+ovWwd9DBCFEFpfHfLknYtweVbhpNysB+wnfqEOCkkwf3WSBfHPqXg3PJBWXTbDvx2QoxsmTqNRZAABhve3JgjRm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=nH8Ujydk; arc=fail smtp.client-ip=52.101.101.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="nH8Ujydk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDk2hJRZJcQ/uCvLlAJbmjhV2raxFX/adbG7uD9rg0CEUXvnF4pNZcC8nNFyOrmh/5bEOiTEWDuZ58tLP2Cf0HO26IpGxlsCXMzZhUHuXE6coLj/0jtpH1ZT3zcF1oQPW0SQE0cdIyqwb0Ajmw2RHDR2Zd/zwEPmdZ/MXDAmVDYxPr4e6XrjMeyAsA8cgv3HV/1fSZ37LYnw4GnPmack2Cu2hm5Wt0R1jN65HAo978bF4JGYIHVJQ8ambdATIzONg7a4zqx9g1NmKe2UIzDXblA+7GIDWUJC0dXy5Kg0DCLMP7m3SwuRMK7Rue7C79rys414yw6ZW4fckIezgVVEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JR7U0Sf1KcLY0zoisZpR1s4x1O+lNuvo1axQDaSOtk=;
 b=gksfLRzq/vI8Se07XLyZe5gpq3W6YtJEnlmnuejAbQ+G+begvxnPf0HEDW1QVS2mlNdZFhaLVaiT9ShxuirbnXf0Ja3qCQNledCSfxSgn/2OCAXu5yXBjlYMitwibwONlyOfhDdxOi3ASQj84I/F/aBDIwIr6bM0hngfa+a3K3K6T4TaNX3OuAsl3RcwG+njR55oOFTx5APO0BZc0rUtGOGfb9aC3VnC1TKSUM3916RElhZp2b446EjRM7lbIb48uStcg0aWyukBhTryFpgC5FCQctKVg4qZeXtJ4WAhM1gnbPqoo/cdVXfwSTV90HPPy/MF/dhFnUH+h9eAHMQFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JR7U0Sf1KcLY0zoisZpR1s4x1O+lNuvo1axQDaSOtk=;
 b=nH8Ujydkzpw43yt8iOYcNcWqCakccwVunpE6ovJpvmLhhyLaEZJPMqYOB9oZws9pfncdgChbdptjjfZM0YuPm4CveE0D2mb2uBhn4ZCVZMFAnEu0vmYI3jqxUbnia95cwrewo8PHWFzfYqmgQ7mmZ9NXQhYJfBuXvexSP5UtluU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:27 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:27 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:09 +0100
Subject: [PATCH v4 07/20] rust: io: implement `Mmio` as view type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-7-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
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
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=16840;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=kZBNsPkay2J/c/qRJQEZ3Wab5O9w345WmRB9JEIlcC4=;
 b=iJkkyL8jnoIEN/vznEU5qEQFykBpDw7ql3NMcWR9rmKTdSnTZRSdpe3jxSPV6BAmGCybTkzlI
 d3in4J+9jSUCQRfDcjHX+ZEefwTj3QV1nE7YcjchauS5d2BVK/fUrRo
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO6P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::8) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO4P265MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: c310b527-bfb9-4498-57fe-08dec7d6770b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|6133799003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/ZM7en63rCYdLn4Ane+WOQtyPJ5+vez5WzXX9BcoUq5wBa3yQJ1qQ8hCMNtGKZTw4Z+mt5+Kx1F06kr+E7WhUduaDv463T+1FdL+sl4flZyUL3Qlh06ye1p92ZkO+iKSxu7qohDNSOgVuTlpMGymAXK9gFnoMetvXWurpCOV37DxhW9AGifBrEDgjSM0JokTQ0tzF8STQ27aOYQ7jHnbWEPfNf15N7cRbtkRLBnvg9Eh6yfLEkeiU4SKd0V4w/VMszPBWVWEOq5S6zO+zmUN8RO1iqYeAfANCEWxLlRXH3NgStcMy4wZ+ogm74UCV+iOTZYjwnbnmQda5PewYLWCTmPrb0EM5P8c08bHhkZHl2OvpsdcV6KAjNrqvxwnz2xz8sXu+V6aPDPs6HG9wBIYC97ucEhJ8ZHN7+3XQtIxqC7woyJqKyjePaGazvcnTW1Nk92ubLfVv2gXwinNwmvp7lUY0b+6o7HICMz0UEaNMgLXIWPpDJCwIeUZZI4w4bABBeipWkD6oVdN1m5j+ocqDvUqbKzBYjVJA4LuzRZKYJX/JFzBK/lgTaKRWYnZ7YCAO2D/U99B4t33hwRSnajfp2y4+9w6D1wKiaIZoWAJbK/zjEymK8sHx4qIRvqa0+K06H//0M6fwidT1ZFMH/2B/Jnw+ctSZQPj4WrdaDxRIQ5d6st098kFyE2TCr+xG4KJSJeAQm7Cymhb+gqLv+N9xVupO8PZ6yCof7txFffa4Dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkZLNmxSS29DOGZJZytxZjdnQjVvQjhvSzNDdjF4SHcxdnFSSFZ0bHI4RG5Z?=
 =?utf-8?B?NXo4clRRaWE3cG8xaStJOUdjQUF4Ny9MeVY0azlqT2ErN0MrQWpJSHcwaVoy?=
 =?utf-8?B?eThJWWswbEt5NnRVa3B2cW52V0dSR3JzR04rWGxKSVJMQ0swL2EySXRuZDFN?=
 =?utf-8?B?M0pzTXFvQXloa0xJK1lPbDVYclN0eWFvdDRmOHpWWWJpRzhheTFRTlNlTW43?=
 =?utf-8?B?YmlidGlsYkdndnI4TjZRWXI4V1BLUFdYdkhwb25jZjVmNkd6ZUE1MXpwQ2dM?=
 =?utf-8?B?Mm9jUDR0ejdKVjFtdXU1S3p1WGZ1eC8xSmhveDVNWjZ1clJJbkc1K2tXWGdm?=
 =?utf-8?B?QUNZUWJiRytZeFQyR09VWUsyZ0Y0UWoveEpzTG02NkdRUDNPVStNakMvRnRv?=
 =?utf-8?B?TVkvWEZic3F1N053bU5FaWhNQ3JOUTRUUDRCcHJ3WkRscXpjVDZLMkdIR1Mv?=
 =?utf-8?B?K1F5SExEZWJTSjUzRVhoZlQzVWIyQ0g0WE9EaytDdDNJVmF0OGNOKzFUZWhX?=
 =?utf-8?B?Yzh2dTRkbDl2d0ZrZEhFNFZEOXhHSUV0S3RUMVE1YTZ2c09xNHU2MHE1RFVi?=
 =?utf-8?B?bkNXbDNGRVJrSVF6RVlQRE9lRkZrNzZvVi9nenpud3lzVzhLSlhPL0FubHZI?=
 =?utf-8?B?VVYyZEg0ZkNScE9lVm1xOSs4RWZSYzV2ZVV2aDhXTnpteWVRTHhBWGZRU1VE?=
 =?utf-8?B?TUs3MS9za1hwVzhkNEc3dk5kSGtva2RRdXpHTHlRbmt1MXNQWUZCdEljc3hQ?=
 =?utf-8?B?UURpV3F5bm5JbHFpUFhCaE1ueHhFT0NZV3ZXQXhBZEVibVoxN0hSa3E2UkVr?=
 =?utf-8?B?cUN1SDJqS3ZpVGpTNXdBT0VXWlE1aWhaM2RBdC95MWRvam5ZeFVCTGJKamFR?=
 =?utf-8?B?U3FiK1E3d3RnWlpoc2ZtTlp2T2xtalRHZkJVTTU4T3VNSFZLTVBlR2NwQksy?=
 =?utf-8?B?N3VBSTVOTWNpVFBVL25lWTkrN1EwQlBBenRhTXJwNEZVUkhjL2hIaUNuNzR3?=
 =?utf-8?B?Q3pEUE41SkwySVY1WUtxcmllck5tSGdUN2NPcnlkc0YvTGxsbUJZVDNRVmIy?=
 =?utf-8?B?WE9sb3JWdGFHWXZ6anVWd2dQcXlsMGNJRTN2d3FyVW80NXBLNDgrUHNQZFJs?=
 =?utf-8?B?TVlLaStjZzdTMGxCa01qT1BQMUFQNnNHRlB5a2RlZXcrcXJ0VTN0RFlQZHpF?=
 =?utf-8?B?Wk1uVzJSZld1aEVBYnpYcGZKVldFRVZBR2dlUmRGaHlPQnNmNmZ4YUovM2NE?=
 =?utf-8?B?clp5SE9hNTF5b3lkVXlBais0OUg2M3g4NVJtS1dmcTM4TkZ0V2tUVE1oODEz?=
 =?utf-8?B?VEJiY1p5a3FNYkpYMDlERWdjRmtPUzZySWVHclB0Mkd3U1l6c2Z6eHJTRCtz?=
 =?utf-8?B?ajRJK2x4NkpPSVNYUlZuZTNsVGxzZll2NGM3QlBDTnBBVFNhWGJ0MlBDbkhl?=
 =?utf-8?B?YmR0NFBnTUtaWVlIVW41QWVvSU02YnA0a01aWGdXRENTaGwxQjJ2VjhDRFVh?=
 =?utf-8?B?QzAya0dGR3piNU9xanozdy9ONVowWXEyNXNMNE8wV3lKWFJjTk5uaDJpb2xl?=
 =?utf-8?B?N29MeCtPcmR6dk14Uk1HUnptZjk5cDd4QU9RWVVqdE1ENXhnQWExQWt3Z0Nt?=
 =?utf-8?B?MTFZWEtKUW9yYS9pdDNuOEF6OHJ3R2hqRE4xWnpIK3hYUG1McGhKbW1MMnNt?=
 =?utf-8?B?UWd4QWtSSG43NjYxNkNrR1R1bTZoOVJkWjFoeGRiUEF4dE5YdFJ5MHdnaFJJ?=
 =?utf-8?B?QWZ1a1BVRzZ0U3VRQ1MvV1ZYN3BrN0pBSWNCMkVXZnYzUWxKeXUvU0lIQ012?=
 =?utf-8?B?MG84WU50V2V0aG1ZQ2NRdmZEaVVIcnlZNncvRVVqQ3BjTi9pWFFPdk5OR1V1?=
 =?utf-8?B?Z1k2UFN6dG95YkNkazVLbWpSVzlrQjJnejdKMEN4UEgydmhxZUxwb2V0eGhE?=
 =?utf-8?B?dUIrSDhSZG1pd2U3QkxmdGk3b3YyaXVURWtNZzM3MlQ0V1J4Q1R2YjgzOEMz?=
 =?utf-8?B?UEpDK1pMWXFTT2ZBR1VpdHZLeEhVWWxIaXVNM1htV3NMekxObURiMTBKdSs3?=
 =?utf-8?B?ZFE4b1F1VThHVkFSM3BldXV0MmFZT1VmYkpvOTZ6RUV3VXZKOTdtWnZ4aXIr?=
 =?utf-8?B?aFdjV3B6dHk5bzRVa1RZbWdqMzIrZzdKSFZkYWJvdGladmgxdUIwbmlROWNt?=
 =?utf-8?B?eGU3OEF6TVpoUE1KeGoxV2hsd29CUmZpeDV2a3gveUNjd082ZWxXcnp2TWlK?=
 =?utf-8?B?elBQODZ6cUYxV1dHWURqQmMwRk9SSE90OGIzanlJL3doUU9BYkwxY2VRQW9O?=
 =?utf-8?B?bTludFZFZWZ0SnVCekFINGovb05ENkpjVDFKTG8rKzZuM3Y0QTNnZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c310b527-bfb9-4498-57fe-08dec7d6770b
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:26.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TmSJzG+G3pCsaNEQTP42F8hbKT5r/UppZQBI8DSY83v3oyFDgjdot61Bdup0J17zRt9KntK+XPuav04lYFkcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

Implement `Mmio` as view type and convert `RelaxedMmio` to view type as
well. I/O implementations of `MmioOwned` are changed to delegate to the
`Mmio` view type.

All existing users of `MmioOwned` in the documentation which do not
actually reflect the owning semantics is converted.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          | 195 +++++++++++++++++++++++++++++++++++----------
 rust/kernel/io/poll.rs     |  10 ++-
 rust/kernel/io/register.rs |  24 +++---
 3 files changed, 171 insertions(+), 58 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 9ca0d325da50..3ac8b396f5a7 100644
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
@@ -536,10 +540,11 @@ fn write64(self, value: u64, offset: usize)
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
@@ -570,10 +575,11 @@ fn try_read<T, L>(self, location: L) -> Result<T>
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
@@ -608,7 +614,8 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
     /// register! {
@@ -624,7 +631,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &MmioOwned) -> Result {
+    /// fn do_write_reg(io: Mmio<'_, Region>) -> Result {
     ///
     ///     io.try_write_reg(VERSION::new(1, 0))
     /// }
@@ -653,10 +660,11 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
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
@@ -690,10 +698,11 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
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
@@ -722,10 +731,11 @@ fn read<T, L>(self, location: L) -> T
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
@@ -756,7 +766,8 @@ fn write<T, L>(self, location: L, value: T)
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
     /// register! {
@@ -772,7 +783,7 @@ fn write<T, L>(self, location: L, value: T)
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &MmioOwned<0x1000>) {
+    /// fn do_write_reg(io: Mmio<'_, Region<0x1000>>) {
     ///     io.write_reg(VERSION::new(1, 0));
     /// }
     /// ```
@@ -800,10 +811,11 @@ fn write_reg<T, L, V>(self, value: V)
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
@@ -827,16 +839,72 @@ fn update<T, L, F>(self, location: L, f: F)
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
@@ -846,17 +914,12 @@ unsafe fn io_write(self, value: $ty, address: usize) {
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
@@ -874,6 +937,23 @@ fn maxsize(self) -> usize {
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
@@ -886,32 +966,59 @@ pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
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
+// SAFETY: `RelaxedMmio<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Send for RelaxedMmio<'_, T> {}
+
+// SAFETY: `RelaxedMmio<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Sync for RelaxedMmio<'_, T> {}
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
@@ -922,20 +1029,24 @@ impl<const SIZE: usize> MmioOwned<SIZE> {
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
+    #[inline]
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
index 242ad96ac805..d0feaf7c8736 100644
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
@@ -447,7 +447,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 ///
 /// register! {
 ///     FIXED_REG(u32) @ 0x100 {
@@ -456,7 +456,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &MmioOwned<0x1000>) {
+/// # fn test(io: Mmio<'_, Region<0x1000>>) {
 /// let val = io.read(FIXED_REG);
 ///
 /// // Write from an already-existing value.
@@ -560,7 +560,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 ///
 /// // Type used to identify the base.
 /// pub struct CpuCtlBase;
@@ -585,7 +585,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: MmioOwned<0x1000>) {
+/// # fn test(io: Mmio<'_, Region<0x1000>>) {
 /// // Read the status of `Cpu0`.
 /// let cpu0_started = io.read(CPU_CTL::of::<Cpu0>());
 ///
@@ -602,7 +602,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: MmioOwned<0x1000>) {
+/// # fn test2(io: Mmio<'_, Region<0x1000>>) {
 /// // Start the aliased `CPU0`, leaving its other fields untouched.
 /// io.update(CPU_CTL_ALIAS::of::<Cpu0>(), |r| r.with_alias_start(true));
 /// # }
@@ -639,7 +639,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -652,7 +652,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &MmioOwned<0x1000>)
+/// # fn test(io: Mmio<'_, Region<0x1000>>)
 /// #     -> Result<(), Error>{
 /// // Read scratch register 0, i.e. I/O address `0x80`.
 /// let scratch_0 = io.read(SCRATCH::at(0)).value();
@@ -725,7 +725,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -753,7 +753,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &MmioOwned<0x1000>) -> Result<(), Error> {
+/// # fn test(io: Mmio<'_, Region<0x1000>>) -> Result<(), Error> {
 /// // Read scratch register 0 of CPU0.
 /// let scratch = io.read(CPU_SCRATCH::of::<Cpu0>().at(0));
 ///
@@ -795,7 +795,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
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

