Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022092.outbound.protection.outlook.com [52.101.96.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830B429811;
	Thu, 11 Jun 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195316; cv=fail; b=BPwlDW7m7Dym5DQ0u9wNXQ0jR5+xC0IJFbNadmfL23XtnD76gEp/enpMTQ81466ToVkZPlJPTQ0sTQydrGIynqDZxbtwICwdRat1Yr8LBk+yOasUwvxHhUnBrvVxDjYsXTLQVXXcfDyZDgOE13aU62u4diZMRQA2R7pK01PwFCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195316; c=relaxed/simple;
	bh=SrFfOHPnj3XpIXHr75f9FycoGL9SYFYygZ9kS+LCZg0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HIA9n7aK9Uem92OSUMGHTgQuhJfIi/BGEe+mt+TeZXRPd8W8ceC+jH4jZddVsxMnSymAoWxJUZYqUUe+6dJ/eB5qHnB/lG7Ukvjy8CLXetkzH9y1hRr9n6/BsSqitkUzwhodOusXPajCaLOHAMT2bULJFmnUewLroxTFtA2sjfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=I9rlsiI7; arc=fail smtp.client-ip=52.101.96.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="I9rlsiI7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZhisqnEChievMbXMKZB14JjCS5o9IyZUO+SISBQKT8PKbC7d1eJfcRJCXn7PYizhyfSczrDWmbnYv1IKzGXjeqzTc/JHMLRMluLP2GWmZmbUrphUhyt+CpkWvcJCtAWI3ZbTlOhe0SmFBAXPtFxKESZTjzZFyzx6HlqkbAhXFHePaRcaidJQXQSRrhfhzGBNXdVuDroxDXYeYrF3fu3N8xZbN1V1EvF1bNdV+g9FsOOuDJdAXJtK01wVg7kUMZjHVf/36x6dPxoz8lyy2Kw3wMPe3i2mBpUf6KhXNsWuc0kTe7vC2W29Ym29keUyzwt9Tjve7q9Ka9S0Nj6EONHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lH390IS2xn+Ehy2wop3ztGAqHMj2r1XssAT/o5Yxo8=;
 b=ppvnYbafJLfM7fBcURtKgGFe3vh/nX7mTIrELH+Karv+vY/QzPTZPjPfrMoySYS9cA1vkZ/0pRE6cRe0eswf9SBfwVSMOSj6TSd941xzzrJ2k5aMLjJ8fAl4IY6vrdi95j1KJWpf8/NloF/pQow2ScXB1VpXvZT1xBBkt90SIc1LC5olA8Fs94U5NbFi745RZUd/zwrDeOVIcoXsq6xtL72LcoWnBxEar+iFM1tq+hDj+V3O00tXgMeF4cSl9tCHJtYHauhyC16NFF2vbb2Pq7GPcuzVhbOsJQW3f9Cm+C9CLgzpAaCaTRB4lAwNiD5VbUm8RUXMOoGDb3t22UteFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lH390IS2xn+Ehy2wop3ztGAqHMj2r1XssAT/o5Yxo8=;
 b=I9rlsiI7kuYjZUFPf2xaqSX2Qk1fNyVlel0L2sbmw1R5ia2Lwu0pzxAg/Ulo9X1nK2l4zx8DivMSyf7KfXXDKfG0of82LoJTRRBya5MY+0z0c9KOsODM85nnZngi830hqjULywCljBGMXSv/69GHJxSFohxsvvhnEmNQfNAjoGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO2P265MB3263.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:28:23 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:23 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:03 +0100
Subject: [PATCH v4 01/20] rust: io: add dynamically-sized `Region` type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-1-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=17117;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=SrFfOHPnj3XpIXHr75f9FycoGL9SYFYygZ9kS+LCZg0=;
 b=NzECPXyh8VRDQLPuHusW0leQ6OYgcE9njCfUsgOPqtFHbLE5o9/WE2eVp9z4crrFCVE8HsADE
 3TcQk0j0GvbBo0gV8+DjyVt2lY7V3Y4w0/ZjrcDPcakDc/GsmVF3S0G
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
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO2P265MB3263:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca0c1bb-d414-4695-eb02-08dec7d674e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|921020|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1u1u/PKb7xw55r3BA2Q9cSYvWlKg5w5WqPMIgjbjx2QA0WuloEwUxUtLMp93Exe2UrD2pOFoYb8neHyDurNUhhZ3RCWbX365T8HYWTegFyH9j0ubfst+d1xWOWbl88CecOCaewJCF23anC518z5GZjM+8c3K7uu9KewgUPsl57Zn0RJ1t2fh2iMqYN2HWjMTr9k+naNDAqlWmtooSgzOAExCDL64XAm4tP6br/15tHjVifoKyaamN8m5AacshEbf4Y60fQH08dTkaX437LZHbTD7/N+PezMFsepozjTzfJhty5ZF+dzKSBupGWYQnBdiraFvObXCeb9zKyzvYLa2KiYxopj2Syrx+7e+NkZJ1EZwvGyRjto4dTMay7jtaClU3mpN+gvHgj5tQhaUFSGLt6TagKjBQlFGTZaywvHPQeJr0m/cyHkdtQ0ttdWE490CzYS5q00E4W9ne2R34kTSZO5/1lfNrYMfXq03ZE+FkGJ7cIJq+mmtubEm++A/AxOG+EuFMyTpcLS9vlIOqC1v4Vel9csa2N1eXS5+zUMG07rHY+pDyJ6G6xtYeO/fs+FLxgs2Ugps3TmViDEXynttDiZ/od+h9T3N0sYYrvKA3L1U1ehoqmL/xelcB/OyiXQ9yjPyqvAbzyBQWyxWrdblCnKhlCkp2pMZxBQzPzM6SxUop5Hvhh7zV1Qw4nKvBki+WcIDkx0OqmBW3xbrRp+ya3ptRO5dTiMM7uXy3bzx+tTO3wFC0QyjyDsbPx7PZaRk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(921020)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk5mN2gzMWNmbC9sSzdTZGt1R3loUmJGT3M1WkkvZTFkZXVYRDgyVjRud2tZ?=
 =?utf-8?B?SGU5ZXJqNFozYjFPY3JNYzYzanM2cWtvZlVaR1dmU3RvQTFhZW9vZjdWdzll?=
 =?utf-8?B?ZndkTngycE9KTE1PMjJuY0RQZzIwVjZ6dk04MTBnMFBsUnpaay9PWlREVmFt?=
 =?utf-8?B?Q1pwV0RVaTJmMDI5QWxRNFBOdnVVYkZxcGtmSExEdUhvNkpVQ3preDRDbEFF?=
 =?utf-8?B?ZUJ2Nkcya3BYWkJYRWg2TS9OM0l0RVRMSnNYU2tvUGJWVU1zQTJ4dVBaQWV4?=
 =?utf-8?B?dGlibmxyaDM5eXEzZVNxazdSc043OTV3amVmejZhR1lzbEtvM3dsMWpQbVBa?=
 =?utf-8?B?azZkQWU0ZzZTRmh0SGdRV2RMNVlzSnVGVDMxNjdacDRuZGtrNEU4YTEzRTFH?=
 =?utf-8?B?QUlwRUFDNDR3Q2FadFd6Y2RHbmxBSngxSjRWT1Z0TW9vNUkzcGRCaGdKeVox?=
 =?utf-8?B?VWlTUmxERW00dmlaZ0Y0WWlpaVV5TndmQWRpVFQvclhIb3FFTUdaYWwzYjVw?=
 =?utf-8?B?VVoxVzhCd3FFRVRSZXNmYmhPdHVwTjlMbmlBU3cyYUJtbDNiQS9vb2JkLzZ4?=
 =?utf-8?B?OHpNdjRYS0RyKzZhQ3JUbEdhNzlNZ0FJT21BQzhhRE0vWWdFQ3B5d2NsdXZZ?=
 =?utf-8?B?QlU2UjB2Sm1TdFprRG5VVmY4ejAzRUxDYlkybVlka2xwV2ZVTUJEa2dwQ0tU?=
 =?utf-8?B?eGtabVdXVnpobVNHVUg5UzJ0WUNtYkdkTVZiOXBOQ0FaRy9RL2R3bHg4R2FV?=
 =?utf-8?B?YkhybCsyZ0I3Y0Y2amlJWHA4S3ZCdFVkdkVqZjJvK0M4eDIwSFV5QzMyZk1B?=
 =?utf-8?B?Vzc2V3RReENKWmdjK2REVFRkVENTMDUyRzRPV2xyeUlnb1U3TktMaHExSS9k?=
 =?utf-8?B?RFJwOUpsMy85T2J1VnRGQVpXNzl0NU1ONnlSQXpJWVBGaVhIY3N4OXd0RjZm?=
 =?utf-8?B?TWxmcWlLbXpQb2FHaW5maWxXaExOZlc3aXoyZ2FxN3hkVVVSU2FyUnhWTTJI?=
 =?utf-8?B?a3RXWUc3R1JDcG5jb0xRbUZXMktiWkdhQ3NVbUU1cXc0TS84VTFrRmh5NUpx?=
 =?utf-8?B?Uy96MkczUVRFM05QdXNSblgrQWRaTk53MEQ5Q2tXb3U4RFhQZmtyeVA0bStm?=
 =?utf-8?B?UytyQVBRN2MwaGcvK1Vxb3NyVGV2d1JaRXprUmdaaWxmdlJoMUlVUUFHanVO?=
 =?utf-8?B?OGRnWXp6ZFA2eENZRGRhdjZKSU52cERZK2xTeWRJdEticEtRNExGL2E5UEcv?=
 =?utf-8?B?bVJQOFhodWJWNHF5cTcvaWcvbUJ0Mlo1QnNzQ2loRlhpRk1pU2xNbXJrM0Rz?=
 =?utf-8?B?TWJKeVhyT0sxd25LQWtEMExqVHhEVks4Y1o4aERHVG5SVmRsUVJmUnplaUxo?=
 =?utf-8?B?ajViUkxmdXVxVjU4SXVIcDFxazhDN01NTldSRDdnNHV1cWU5YkxlQVFBTE8x?=
 =?utf-8?B?UzFyWVpxNnlpcWJSVjJLZzNLWUlDMFNNUUJsWWNFRlE2VHZJK1lTM0ZEQzVY?=
 =?utf-8?B?UVUwQkk2S1RGVzJJRkRUTUlsK2ZWbWlieVIrV3k0ckFnbDB1QUZBaVAvcWc0?=
 =?utf-8?B?em1lQU5LOWliNHZ0eGd0VGtFUFRVbU4rdWdIVG1RR1huZC9xeHpRWWQ2Wk5o?=
 =?utf-8?B?OTU4OGxsV281UDE3bFgrK3RxbGtaaWRNblJoYW9zY3JLb1A3U3ZVZVhpZVhZ?=
 =?utf-8?B?V00wb0s1dGc0L2h0dFkwM3VYVUlYcVNHSUN2ZVUxRTk0VDBlQWlQTmhDMFhL?=
 =?utf-8?B?dUJqSDBMdW1YazcyUlpkYU5TVkR3MGUzakVuSWViU1N2MlpnSy9DbENwaDBy?=
 =?utf-8?B?NmxhTjhQdVQ3eUJYbFBNS0l5SFJVWUl4M0FwMWRieVArSUR0MUpsS1pPK3I1?=
 =?utf-8?B?S2I3VWppUHVtcSs3ZndoRVZsR25adXFpRXJVSEE3OFg1QXBQVDJOaWhFWGgr?=
 =?utf-8?B?U3k5UmtCTnBzRCt6SWlHNHdJakV6cVF6KzczaThKUWRRSnVuNmlaQ0wxL0FW?=
 =?utf-8?B?YUNmYkxFZU9nN2F6SGp5YklnM3dnbW11dEo4WkpLSWxaZkcxY1hvOVdsbzVW?=
 =?utf-8?B?WVoyNnNCQytHcHJEZUpUOGJDS1FlT1RweEtSdjlPQmtuMVVZRE1OYnJpMnhC?=
 =?utf-8?B?dkFaZU52RkRzTEtsb3Vad3lCR2xjSWRydEQvZXlNTFNQK05yaUMreVljeTh0?=
 =?utf-8?B?ZWM5K1lRcjlBRmNSMWZtdnhzSVhoRnFkLzNhekJFNkFoYlR5OVdHN2d6SHQ0?=
 =?utf-8?B?Wkx3bTZOcEJFYjhXTEdhTjIzVWVjeXdrazV1MWw1T3EzOGlLTmRMcnZVVDM1?=
 =?utf-8?B?Mmo3WVFqMGZIUjRLR3lXKzFsZWxqWmViNmFLdk1zR0RET292UGZuUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca0c1bb-d414-4695-eb02-08dec7d674e2
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:23.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaZaGC+bNo6NpB5x9cYCav8HZmgMGpqahnsPRkaUDauu2QcGXTLrdg7SZV7PBePv2Wlbz2GyQYrg5FluzvR8bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3263

Currently many I/O related structs carry a `SIZE` parameter to denote the
minimum size of the I/O region, while they also carry a field indicating
the actual size. Proliferation of the pattern creates a lot of duplicated
code, and makes it hard to create typed views of I/O.

Introduce a `Region` type that carries the `SIZE` parameter. It is a
wrapper of `[u8]`, which makes it dynamically sized with a metadata of
`usize`. This way, pointers to `Region` naturally carry size information.
This type is required to be 4-byte aligned.

Expose the minimum size information via `MIN_SIZE` constant of the
`KnownSize` trait. Similarly, expose the minimum alignment information via
`KnownSize::MIN_ALIGN`.

With these changes, it is possible to add an associated type to `Io` trait
to represent the type of I/O region. For untyped regions, this is the newly
added `Region` type. Remove `IoKnownSize` as it is no longer necessary. Use
the same mechanism to indicate minimum size of PCI config spaces.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |   6 +--
 rust/kernel/io.rs     | 130 +++++++++++++++++++++++++++++++++-----------------
 rust/kernel/lib.rs    |   3 ++
 rust/kernel/pci.rs    |   1 -
 rust/kernel/pci/io.rs |  40 +++++++---------
 rust/kernel/ptr.rs    |  12 +++++
 6 files changed, 118 insertions(+), 74 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 11ce500e9b76..ed30ccc6e68e 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,7 +68,6 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
-///         IoKnownSize,
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr, //
@@ -297,10 +296,7 @@ pub fn device(&self) -> &Device {
     /// use kernel::{
     ///     device::Core,
     ///     devres::Devres,
-    ///     io::{
-    ///         Io,
-    ///         IoKnownSize, //
-    ///     },
+    ///     io::Io,
     ///     pci, //
     /// };
     ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index fcc7678fd9e3..bef571dad6eb 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -6,7 +6,11 @@
 
 use crate::{
     bindings,
-    prelude::*, //
+    prelude::*,
+    ptr::{
+        Alignment,
+        KnownSize, //
+    }, //
 };
 
 pub mod mem;
@@ -31,6 +35,58 @@
 /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
 pub type ResourceSize = bindings::resource_size_t;
 
+/// Untyped I/O region.
+///
+/// This type can be used when an I/O region without known type information has a compile-time known
+/// minimum size (and a runtime known actual size).
+///
+/// This must be 4-byte aligned.
+///
+/// # Invariants
+///
+/// Size of the region is at least as large as the `SIZE` generic parameter.
+#[repr(C, align(4))]
+pub struct Region<const SIZE: usize = 0> {
+    inner: [u8],
+}
+
+impl<const SIZE: usize> Region<SIZE> {
+    /// Create a raw mutable pointer from given base address and size.
+    ///
+    /// `size` should be at least as large as the minimum size `SIZE`, and `base` and `size` should
+    /// be 4-byte aligned to uphold the type invariant.
+    ///
+    /// Just like other methods on raw pointers, it is not unsafe to create a raw pointer
+    /// that does not uphold the type invariants. However such pointers are not valid.
+    #[inline]
+    pub fn ptr_from_raw_parts_mut(base: *mut u8, size: usize) -> *mut Self {
+        core::ptr::slice_from_raw_parts_mut(base, size) as *mut Region<SIZE>
+    }
+
+    /// Create a raw mutable pointer from given base address and size.
+    ///
+    /// The alignment of `base` is checked, and `size` is checked against the minimum size specified
+    /// via const generics.
+    #[inline]
+    pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Result<*mut Self> {
+        if size < SIZE || base.align_offset(4) != 0 || !size.is_multiple_of(4) {
+            return Err(EINVAL);
+        }
+
+        Ok(Self::ptr_from_raw_parts_mut(base, size))
+    }
+}
+
+impl<const SIZE: usize> KnownSize for Region<SIZE> {
+    const MIN_SIZE: usize = SIZE;
+    const MIN_ALIGN: Alignment = Alignment::new::<4>();
+
+    #[inline(always)]
+    fn size(p: *const Self) -> usize {
+        (p as *const [u8]).len()
+    }
+}
+
 /// Raw representation of an MMIO region.
 ///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
@@ -85,7 +141,6 @@ pub fn maxsize(&self) -> usize {
 ///     ffi::c_void,
 ///     io::{
 ///         Io,
-///         IoKnownSize,
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr,
@@ -241,12 +296,25 @@ fn offset(self) -> usize {
 /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
 /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
 pub trait Io {
+    /// Type of this I/O region. For untyped regions, [`Region`] can be used.
+    type Target: ?Sized + KnownSize;
+
     /// Returns the base address of this mapping.
     fn addr(&self) -> usize;
 
     /// Returns the maximum size of this mapping.
     fn maxsize(&self) -> usize;
 
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing compile-time bound checks.
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
+    fn io_addr_assert<U>(&self, offset: usize) -> usize {
+        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE));
+
+        self.addr() + offset
+    }
+
     /// Returns the absolute I/O address for a given `offset`,
     /// performing runtime bound checks.
     #[inline]
@@ -336,7 +404,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(&self, offset: usize) -> u8
     where
-        Self: IoKnownSize + IoCapable<u8>,
+        Self: IoCapable<u8>,
     {
         self.read(offset)
     }
@@ -345,7 +413,7 @@ fn read8(&self, offset: usize) -> u8
     #[inline(always)]
     fn read16(&self, offset: usize) -> u16
     where
-        Self: IoKnownSize + IoCapable<u16>,
+        Self: IoCapable<u16>,
     {
         self.read(offset)
     }
@@ -354,7 +422,7 @@ fn read16(&self, offset: usize) -> u16
     #[inline(always)]
     fn read32(&self, offset: usize) -> u32
     where
-        Self: IoKnownSize + IoCapable<u32>,
+        Self: IoCapable<u32>,
     {
         self.read(offset)
     }
@@ -363,7 +431,7 @@ fn read32(&self, offset: usize) -> u32
     #[inline(always)]
     fn read64(&self, offset: usize) -> u64
     where
-        Self: IoKnownSize + IoCapable<u64>,
+        Self: IoCapable<u64>,
     {
         self.read(offset)
     }
@@ -372,7 +440,7 @@ fn read64(&self, offset: usize) -> u64
     #[inline(always)]
     fn write8(&self, value: u8, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u8>,
+        Self: IoCapable<u8>,
     {
         self.write(offset, value)
     }
@@ -381,7 +449,7 @@ fn write8(&self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(&self, value: u16, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u16>,
+        Self: IoCapable<u16>,
     {
         self.write(offset, value)
     }
@@ -390,7 +458,7 @@ fn write16(&self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(&self, value: u32, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u32>,
+        Self: IoCapable<u32>,
     {
         self.write(offset, value)
     }
@@ -399,7 +467,7 @@ fn write32(&self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(&self, value: u64, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u64>,
+        Self: IoCapable<u64>,
     {
         self.write(offset, value)
     }
@@ -582,7 +650,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     fn read<T, L>(&self, location: L) -> T
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
 
@@ -614,7 +682,7 @@ fn read<T, L>(&self, location: L) -> T
     fn write<T, L>(&self, location: L, value: T)
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
         let io_value = value.into();
@@ -658,7 +726,7 @@ fn write_reg<T, L, V>(&self, value: V)
     where
         L: IoLoc<T>,
         V: LocatedRegister<Location = L, Value = T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -690,7 +758,7 @@ fn write_reg<T, L, V>(&self, value: V)
     fn update<T, L, F>(&self, location: L, f: F)
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType> + Sized,
+        Self: IoCapable<L::IoType> + Sized,
         F: FnOnce(T) -> T,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -704,28 +772,6 @@ fn update<T, L, F>(&self, location: L, f: F)
     }
 }
 
-/// Trait for types with a known size at compile time.
-///
-/// This trait is implemented by I/O backends that have a compile-time known size,
-/// enabling the use of infallible I/O accessors with compile-time bounds checking.
-///
-/// Types implementing this trait can use the infallible methods in [`Io`] trait
-/// (e.g., `read8`, `write32`), which require `Self: IoKnownSize` bound.
-pub trait IoKnownSize: Io {
-    /// Minimum usable size of this region.
-    const MIN_SIZE: usize;
-
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing compile-time bound checks.
-    // Always inline to optimize out error path of `build_assert`.
-    #[inline(always)]
-    fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
-
-        self.addr() + offset
-    }
-}
-
 /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
@@ -758,6 +804,8 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 );
 
 impl<const SIZE: usize> Io for Mmio<SIZE> {
+    type Target = Region<SIZE>;
+
     /// Returns the base address of this mapping.
     #[inline]
     fn addr(&self) -> usize {
@@ -771,10 +819,6 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
-}
-
 impl<const SIZE: usize> Mmio<SIZE> {
     /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
     ///
@@ -798,6 +842,8 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
 pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
 
 impl<const SIZE: usize> Io for RelaxedMmio<SIZE> {
+    type Target = Region<SIZE>;
+
     #[inline]
     fn addr(&self) -> usize {
         self.0.addr()
@@ -809,10 +855,6 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<const SIZE: usize> IoKnownSize for RelaxedMmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
-}
-
 impl<const SIZE: usize> Mmio<SIZE> {
     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
     ///
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9512af7156df..68f4d9a3425d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -16,6 +16,9 @@
 // Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
 // the unstable features in use.
 //
+// Stable since Rust 1.87.0.
+#![feature(unsigned_is_multiple_of)]
+//
 // Stable since Rust 1.89.0.
 #![feature(generic_arg_infer)]
 //
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..c6d6bd8f251d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -43,7 +43,6 @@
 pub use self::io::{
     Bar,
     ConfigSpace,
-    ConfigSpaceKind,
     ConfigSpaceSize,
     Extended,
     Normal, //
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 0461e01aaa20..b4996aa059d8 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -10,11 +10,12 @@
     io::{
         Io,
         IoCapable,
-        IoKnownSize,
         Mmio,
-        MmioRaw, //
+        MmioRaw,
+        Region, //
     },
-    prelude::*, //
+    prelude::*,
+    ptr::KnownSize, //
 };
 use core::{
     marker::PhantomData,
@@ -46,28 +47,21 @@ pub const fn into_raw(self) -> usize {
     }
 }
 
-/// Marker type for normal (256-byte) PCI configuration space.
-pub struct Normal;
+/// Alias for normal (256-byte) PCI configuration space.
+pub type Normal = Region<256>;
 
-/// Marker type for extended (4096-byte) PCIe configuration space.
-pub struct Extended;
+/// Alias for extended (4096-byte) PCIe configuration space.
+pub type Extended = Region<4096>;
 
 /// Trait for PCI configuration space size markers.
 ///
 /// This trait is implemented by [`Normal`] and [`Extended`] to provide
 /// compile-time knowledge of the configuration space size.
-pub trait ConfigSpaceKind {
-    /// The size of this configuration space in bytes.
-    const SIZE: usize;
-}
+pub trait ConfigSpaceKind: KnownSize {}
 
-impl ConfigSpaceKind for Normal {
-    const SIZE: usize = 256;
-}
+impl ConfigSpaceKind for Normal {}
 
-impl ConfigSpaceKind for Extended {
-    const SIZE: usize = 4096;
-}
+impl ConfigSpaceKind for Extended {}
 
 /// The PCI configuration space of a device.
 ///
@@ -77,7 +71,7 @@ impl ConfigSpaceKind for Extended {
 /// The generic parameter `S` indicates the maximum size of the configuration space.
 /// Use [`Normal`] for 256-byte legacy configuration space or [`Extended`] for
 /// 4096-byte PCIe extended configuration space (default).
-pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
+pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind = Extended> {
     pub(crate) pdev: &'a Device<device::Bound>,
     _marker: PhantomData<S>,
 }
@@ -85,7 +79,7 @@ pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
+        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
             unsafe fn io_read(&self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
@@ -118,7 +112,9 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+impl<'a, S: ?Sized + ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+    type Target = S;
+
     /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
     fn addr(&self) -> usize {
@@ -132,10 +128,6 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
-    const MIN_SIZE: usize = S::SIZE;
-}
-
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// I/O backend assumes that the device is little-endian and will automatically
diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 3f3e529e9f58..82acb531b17b 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -235,11 +235,20 @@ fn align_up(self, alignment: Alignment) -> Option<Self> {
 ///
 /// This is a generalization of [`size_of`] that works for dynamically sized types.
 pub trait KnownSize {
+    /// Minimum size of this type known at compile-time.
+    const MIN_SIZE: usize;
+
+    /// Minimum alignment of this type known at compile-time.
+    const MIN_ALIGN: Alignment;
+
     /// Get the size of an object of this type in bytes, with the metadata of the given pointer.
     fn size(p: *const Self) -> usize;
 }
 
 impl<T> KnownSize for T {
+    const MIN_SIZE: usize = size_of::<T>();
+    const MIN_ALIGN: Alignment = Alignment::of::<T>();
+
     #[inline(always)]
     fn size(_: *const Self) -> usize {
         size_of::<T>()
@@ -247,6 +256,9 @@ fn size(_: *const Self) -> usize {
 }
 
 impl<T> KnownSize for [T] {
+    const MIN_SIZE: usize = 0;
+    const MIN_ALIGN: Alignment = Alignment::of::<T>();
+
     #[inline(always)]
     fn size(p: *const Self) -> usize {
         p.len() * size_of::<T>()

-- 
2.54.0

