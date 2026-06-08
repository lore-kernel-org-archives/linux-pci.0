Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020080.outbound.protection.outlook.com [52.101.196.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179213ED3C3;
	Mon,  8 Jun 2026 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948766; cv=fail; b=qFu2N3hZaX7n/t8bqmsZmBIDf5OBu4/aIE2MU1tSAidnegzpt7RZF4+vgFWOuS047AB2DFyVW3WtLBMyHkQVX6dWRwMHVzj9pNrAuxglB7HNyISZULd4hhnX/59wCX44e7TBRBF5nRRCaS+MBghu23jLqY1U3i1RQTTvH9RfLoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948766; c=relaxed/simple;
	bh=mreONJ+AHAEhaJglZOeJLMnPk4Q9LO40LchOeihcJSQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=vEwMrnxhhZgOlS+jW8NoufOS1ivxhIWj6ZDjdth7jzELBdn0E6NQNKoicW6Fsx0UILvkistAy5ErE04aZSJcE16o0wOr60jAF9YzidlQ+IQ55HXez/Weu3TsreCw2sCYVf1XS46iZe+EIhPQGsz+oOs2u6jV7hPqnrQXGa0Ki18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=KEdTEqnj; arc=fail smtp.client-ip=52.101.196.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="KEdTEqnj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx4rK5OoogDBzvWU+2eXWfJV9zLBMGe4oUPjNQT4G6J0WOxZOcDeF1fCKkps/kE9WGiiH6iSZ0Q4/axeIhc8HJ9GAk1wNCbeLgeMNbmH9Ezq+v27bDVwZ9YykgBER0LobnF5TCO3RA3eQ/F0gLE7k9puLLiRokS0tAPGOHzSQQ+wK9Ssr7dbFymAEf3V1U6JIAGB/Y3T3gByJidzfHES+KbHVXxty9+OgFpSMX1NphB2Mz6QSsJXic1bHYYMmuBaJO5uWe3A7V0vo4d+yXVavDy3u9e6u0xWtkgqe04utOGUog9rLVx5kBo0p19UXtj2vyZbVFj2psYZbmAgkhIy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkHARU1FufBVHwKsb1jGceHWa7BP9kZ+4tdcCjmNEhQ=;
 b=IZuelxFTuFbkzg/E1fmC9C8Yms/HBDkpo21sV8sP49xuBEPizdSAv+MjE7rUqMymXR6j8Ik84gc9uGWBd+MBwBNsehqb9D6KXqoeduiljOcLacWzwLRy6ieh0t9WrGwIq0m+//1Fch/DMlSnAYF4VXOhdWUK5m7lW1ijGH+wjTiIht/fdV/OB1pQoFIEqQtmDOd3WYbkuTxp/VTXIGHKtDXD7aak2TJdik+BUJrrYqRjO9BUQdRwrrTiLTx8SQYi/Fd/KhNWwpz18daxm6E79NxgOWQXQ1nvBQLQng48zbzp9+A9twZGJ84EBsV0i2aCIv6X4Ly/ddtjag7Pfaml9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkHARU1FufBVHwKsb1jGceHWa7BP9kZ+4tdcCjmNEhQ=;
 b=KEdTEqnjnyjVhnhXR8LHmHccJ/Tn17DsOIyf1buUJbBg7CC+LExjjyn3wlex2Ozw3pQsTqNs1WYVOCLxz3An3sAe+s9Rer7kThcJIGjR0wThcI/3OfiZ2FnpWSX25U4/b+tOaP4H8Q9X0gSjsA2+aHgPEsUjGL0kbk9q5PehBt0=
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
Date: Mon, 08 Jun 2026 20:59:03 +0100
Subject: [PATCH v3 06/19] rust: io: rename `Mmio` to `MmioOwned`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-6-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=16838;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=mreONJ+AHAEhaJglZOeJLMnPk4Q9LO40LchOeihcJSQ=;
 b=3fQNSfZoaiIYvzkb90FtUo9hDj7LSRt3MDi+U41f1/37VzdGDqFhX9fGCFOIA/fKO6NPhO6zX
 JYU0dHQQoS9BPEZMt40lycJ2dPlLv/BQLkQMPXS7KST1W2F8CHjNdDk
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
X-MS-Office365-Filtering-Correlation-Id: 6abad7a6-0081-4c9a-0f5e-08dec598680a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Azmi8fcck6bU9bVa27WA60hNruEMO03KvlgJdPudZ4JjYTfczEq6bTb3TrNfUvYHbTeBysfNr6rokVGiLOsvMhMwFLPo4168abKbZJ5wapp1PPfPg1V2xlr4zk0/gcy/fV6j1QlbErWfgP6vd+2993SV9lL+R2MMLfO/QfrQ/l4FBhYwFHBCq9fyIaYA220Snou7Gns9KgYFzzxrK0S/qd2lEEMcjZfm6ZNOuP8rIlgKRAuHMN24BdnvGAxMvEt6U/WyGrCEp9TvGzjCvJGjk5g66TuzDgtQlouVLVu98HQbCz8yYgkUVqXL2IHgDlv4djBMM8WoB270o1tSHvznVZYMd/GnjrlsxBLw5HTzzdEjv9PNxiOrxSARyWgM0IZxrJMKVq6t4pmrzVtLh5kJOE6wB+0y6K5XM7ZeyKdvX4SLraIUmhmeapcyrc0ahW6dg04aJafafEL9h5JXMY72bsQ3EvJELJdnrcraZn/gV5Mj83TyKXrPb4JUII5Q7WyuO8UWTsNF0whkf0pVhCI1ebQjxaXs46/Uf8Z1KIcUuih1gWJZUyiD7rhmP3GyFZLwUBabeSLtYFVSZbTHDPT0IqK1HsFoidcbPT3/ygrCH9kfboxSi88I/U2oX8D8LExh9p3hTuljBXpuL8VEeEV2xtXr0qj8nz+ACB3cOpWXOHx8kOrQ9a6Y538+Y3elUGsVpVoDmN7C3yniZLUGUscqArtK8RgC9Ln3a4MqVVij4zQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0QvNVZ3V202RC90VjR2bVNCaVBuRGxicVYzV2dVYnBoUXN0SnNndVBNNlAy?=
 =?utf-8?B?R0pHRVNvVDlySDkwdUwxSmU4TjBGeTJmZjh1SlJWNXFKSzVvVTI5aEFBWHpC?=
 =?utf-8?B?dERYMlU1aFJieDZHWC9USlRIeFJ2WFZ1bTR4OTBnai9INlMxZWovK1p6Mk8y?=
 =?utf-8?B?aWZkMmRaZ1hBdjhTV0RONGpqSWQzakx6Q3M3MXFyRkNxTGx0SEJGY1JkT05o?=
 =?utf-8?B?MzAvcGN1TktYdU80eC9wRVQwUHJTeUNicGR1RUlBUjVreFVBeW1zd2o3bmwy?=
 =?utf-8?B?Ty9rR2t3a3VncXRyenhHUGlGMEhlQzgvMjB2K1QveTJiK1oxUWxQRmpKdk1y?=
 =?utf-8?B?a3liSWJCdDdhbkh6RFFpNVg2dVBFek5McUtSL2NnZ0ZxUVVLVjVSVE5sSE1Y?=
 =?utf-8?B?ZVdyeGdFNUp2dE9BdTBOYjJxRXBwY3QreEhwS015d3dHclVreGRLVjQzZW41?=
 =?utf-8?B?Uk1XQnJVZ1J1dlVpVWNTeUszak5JNU1QTTBjb0NuN1hOWDJ0Y2pJc3kzTnY4?=
 =?utf-8?B?Ym03UWZTNWZMelJPak5HMjZ3L1B2QXJUVHpiZkxqRmNFTStabWt2Q2pxS2lY?=
 =?utf-8?B?U1RIUnFSdkZXUnErTUdNM1hxd0xicTEzQnJvU2RJNktBenZXNVJBYmNRLzVo?=
 =?utf-8?B?TEc0cUFKUnNFK1h5ZmpOeWd2RjFwN3MxeTNZRExKYkZZV3hqTmdsUC9PWjRS?=
 =?utf-8?B?ZkJROCs5Ykk3NmNQQlNFcGF4SS9DcFMyT3VBVVdUeERuUHJlSlNOM2ptTm5O?=
 =?utf-8?B?NmdoZUJIMkxwQ01zYTdjWitDblFzclhOem00SE1mYjVQMG4yZ0pQVUE0TDF5?=
 =?utf-8?B?UXZkWjhOSCt1K2lPY2RtVVJueVNvK203VVZxcXF2M01rWW9tRnA3WHViemFL?=
 =?utf-8?B?enRHRk52SWNyNjlQRnhwMkdpTU1KSllFa3NKZS9WZ3ZzK3dYUjRNWWQ4MHlz?=
 =?utf-8?B?UUNTbWNDOUVHN3lMYlVnSXkrRUdodk0wRXAvaExIRDNDSzBNM3lIVUp0cGlr?=
 =?utf-8?B?bExlbW1ySVJuUjZtYlI4TWxnQjQ3eHNjZndKTHJqUkpIV3k3RGRxejh5RTAy?=
 =?utf-8?B?QXdBbzlTbnVObVc5elNET3FNTDhMUndwRXZlM1RvamNMMk50YXdnaVRuZnpv?=
 =?utf-8?B?N0ZreGhDWDFrZ1dEZU5FVjltUmN1U3kwQUgxc3d5MXdJbWdhcWFrYjZCYTZY?=
 =?utf-8?B?WDcwazlSNzcrcnhuWnhJcFZmQ0l4Qm9pS1FlNFpseDY4ZzZzZFdVRGlQR01Y?=
 =?utf-8?B?S0FZdzlKMEdjY2N2VkE2cWZBVkRsV1R5QURKMUtxbVNyWXZ5eXYrRjhIc2RX?=
 =?utf-8?B?aUVsbGJRTGJYVC9TczRIRGZOQ1EwaXVyamk4VUR4eW1kRzhuWUJSN3J1VkJQ?=
 =?utf-8?B?UHZTMWxkdGlGN0pEWnNBK3FTNWVGd2tiQTFUOXRqWVJoejRYMnBPenhHdndl?=
 =?utf-8?B?blVyQ3ptY1QyaG9Sdk1nemRycTZSY2QvRGdqR0NrdVg4VVJ0QXgvUjl2UTcw?=
 =?utf-8?B?Z1lTSlVITHhoeU54RFNUbkFaNlNTUjZMQWFBbWdCeEd4ZWVRKzVVOGRuUXkx?=
 =?utf-8?B?N0Z3NkkvUWEwN2x4azcxaHMwNkh2Q1U2TEZlUXVGcmE1VW00VEN2NjlpSUtU?=
 =?utf-8?B?N2F0eFZWTCtUTzQrUXlyWmtmRXcrVzFjV3ZhYktOa3dQOUxwWjJCUVNYb2Va?=
 =?utf-8?B?RzgwY1MyQ0dQVnltcHRlcHhXNlZkZ3VuRDc4azVQSThPM2QraEgwQm10NmJF?=
 =?utf-8?B?Mk4wOXk1UzhlbTZCUTEzQ1dsVWFEZnZ4WkRNWEQzTjY2ajVyZzg2bkNTWnFa?=
 =?utf-8?B?WSt6aC9WWE1XUG5hL0xmZ0EwN3RLY3UwVmNDbWc0akNaaTh4Z2lhUGlVcGtq?=
 =?utf-8?B?bHRhQzRQTEl2MTIyeWQ1bWtmRlIvWkhvWXpZY1RnN2VJVFVFSlkzSjYzOXE1?=
 =?utf-8?B?NkdxZS9ZTjVBdDBVMGEraXkwdXZrbFlCMnU3Rm5oNmR1STl4RE8xMXNCRGx0?=
 =?utf-8?B?akRIRmNTdDNSelB4M1htNDREWngvMEdvNFJOSHgyZExoWjhrcXVPNEx0eFpU?=
 =?utf-8?B?Tk5Cb0ZXZmZ6UWdUcEJ2aEhjMjEvRFFVUEM4L3dMR0dITC9mUVljVmdxc0V2?=
 =?utf-8?B?K3h4ejlya04vcUFtdHFBZGVmY2hJeHkvMkZVbkZBTDZMZHlWMHUwWEcxWWJo?=
 =?utf-8?B?YWFBZDl1bUFjZGNPbWltM2puUEQxOUtTMzk4Tk1TanRyckNOZjlESDNOSTE5?=
 =?utf-8?B?bk9kY0VyRmFPOTk3VGRGQlg4OHRkSEJVU1IwbXQ1UkM1Z2d1b0NzVFRMbHFB?=
 =?utf-8?B?ZUFKaUgrYWVpSXR2WDRpYVJuRlJFRTNtdkh1L3ZsWlNaRklZU0xmUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abad7a6-0081-4c9a-0f5e-08dec598680a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:10.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1PQWMpoJakW5qTCsevm/EbUWJezFJ2YCZcMM6LzKUtbmcKnGiJL1k6GsykxVUthBdLPyBD5xhZ8UeETWGKvrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

Most users would more commonly reach out to a view of `Mmio` rather than an
owned instance of `Mmio`. Only implementor of `Io` like `Bar` or `IoMem`
would need the owned version. Thus, rename `Mmio` to `MmioOwned` so that
the name `Mmio` can be used for the view type instead.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs      |  6 ++--
 rust/kernel/io.rs          | 77 +++++++++++++++++++++++-----------------------
 rust/kernel/io/mem.rs      |  8 ++---
 rust/kernel/io/poll.rs     |  8 ++---
 rust/kernel/io/register.rs | 24 +++++++--------
 rust/kernel/pci/io.rs      |  6 ++--
 6 files changed, 65 insertions(+), 64 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index d0c677fd7932..aed0c994fd30 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,7 +68,7 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
-///         Mmio,
+///         MmioOwned,
 ///         MmioRaw,
 ///         PhysAddr,
 ///         Region, //
@@ -105,11 +105,11 @@ struct Inner<T> {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Mmio<SIZE>;
+///    type Target = MmioOwned<SIZE>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Mmio::from_raw(&self.0) }
+///         unsafe { MmioOwned::from_raw(&self.0) }
 ///    }
 /// }
 /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index c9533d3f003b..d5c233a66846 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -96,8 +96,8 @@ fn size(p: *const Self) -> usize {
 /// the represented MMIO region does exist or is properly mapped.
 ///
 /// Instead, the bus specific MMIO implementation must convert this raw representation into an
-/// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
-/// structure any guarantees are given.
+/// `MmioOwned` instance providing the actual memory accessors. Only by the conversion into an
+/// `MmioOwned` structure any guarantees are given.
 pub struct MmioRaw<T: ?Sized> {
     /// Pointer is in I/O address space.
     ///
@@ -172,7 +172,7 @@ pub fn size(&self) -> usize {
 ///     ffi::c_void,
 ///     io::{
 ///         Io,
-///         Mmio,
+///         MmioOwned,
 ///         MmioRaw,
 ///         PhysAddr,
 ///         Region,
@@ -208,11 +208,11 @@ pub fn size(&self) -> usize {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Mmio<SIZE>;
+///    type Target = MmioOwned<SIZE>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Mmio::from_raw(&self.0) }
+///         unsafe { MmioOwned::from_raw(&self.0) }
 ///    }
 /// }
 ///
@@ -226,7 +226,7 @@ pub fn size(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
+pub struct MmioOwned<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
 
 /// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
@@ -538,10 +538,10 @@ fn write64(self, value: u64, offset: usize)
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_reads(io: &Mmio) -> Result {
+    /// fn do_reads(io: &MmioOwned) -> Result {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.try_read(0x10)?;
     ///
@@ -572,10 +572,10 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_writes(io: &Mmio) -> Result {
+    /// fn do_writes(io: &MmioOwned) -> Result {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.try_write(0x10, 1u32)?;
     ///
@@ -610,7 +610,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
     /// register! {
@@ -626,7 +626,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &Mmio) -> Result {
+    /// fn do_write_reg(io: &MmioOwned) -> Result {
     ///
     ///     io.try_write_reg(VERSION::new(1, 0))
     /// }
@@ -655,10 +655,10 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_update(io: &Mmio<0x1000>) -> Result {
+    /// fn do_update(io: &MmioOwned<0x1000>) -> Result {
     ///     io.try_update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -692,10 +692,10 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_reads(io: &Mmio<0x1000>) {
+    /// fn do_reads(io: &MmioOwned<0x1000>) {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.read(0x10);
     ///
@@ -724,10 +724,10 @@ fn read<T, L>(self, location: L) -> T
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_writes(io: &Mmio<0x1000>) {
+    /// fn do_writes(io: &MmioOwned<0x1000>) {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.write(0x10, 1u32);
     ///
@@ -758,7 +758,7 @@ fn write<T, L>(self, location: L, value: T)
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
     /// register! {
@@ -774,7 +774,7 @@ fn write<T, L>(self, location: L, value: T)
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &Mmio<0x1000>) {
+    /// fn do_write_reg(io: &MmioOwned<0x1000>) {
     ///     io.write_reg(VERSION::new(1, 0));
     /// }
     /// ```
@@ -802,10 +802,10 @@ fn write_reg<T, L, V>(self, value: V)
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_update(io: &Mmio<0x1000>) {
+    /// fn do_update(io: &MmioOwned<0x1000>) {
     ///     io.update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -848,19 +848,19 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 }
 
 // MMIO regions support 8, 16, and 32-bit accesses.
-impl_mmio_io_capable!(Mmio, u8, readb, writeb);
-impl_mmio_io_capable!(Mmio, u16, readw, writew);
-impl_mmio_io_capable!(Mmio, u32, readl, writel);
+impl_mmio_io_capable!(MmioOwned, u8, readb, writeb);
+impl_mmio_io_capable!(MmioOwned, u16, readw, writew);
+impl_mmio_io_capable!(MmioOwned, u32, readl, writel);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
 impl_mmio_io_capable!(
-    Mmio,
+    MmioOwned,
     #[cfg(CONFIG_64BIT)]
     u64,
     readq,
     writeq
 );
 
-impl<'a, const SIZE: usize> Io for &'a Mmio<SIZE> {
+impl<'a, const SIZE: usize> Io for &'a MmioOwned<SIZE> {
     type Target = Region<SIZE>;
 
     /// Returns the base address of this mapping.
@@ -876,27 +876,28 @@ fn maxsize(self) -> usize {
     }
 }
 
-impl<const SIZE: usize> Mmio<SIZE> {
-    /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
+impl<const SIZE: usize> MmioOwned<SIZE> {
+    /// Converts an `MmioRaw` into an `MmioOwned` instance, providing the accessors to the MMIO
+    /// mapping.
     ///
     /// # Safety
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
     /// `maxsize`.
     pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
-        // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
+        // SAFETY: `MmioOwned` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
 }
 
-/// [`Mmio`] wrapper using relaxed accessors.
+/// [`MmioOwned`] wrapper using relaxed accessors.
 ///
 /// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
 /// the regular ones.
 ///
-/// See [`Mmio::relaxed`] for a usage example.
+/// See [`MmioOwned::relaxed`] for a usage example.
 #[repr(transparent)]
-pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
+pub struct RelaxedMmio<const SIZE: usize = 0>(MmioOwned<SIZE>);
 
 impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
     type Target = Region<SIZE>;
@@ -912,7 +913,7 @@ fn maxsize(self) -> usize {
     }
 }
 
-impl<const SIZE: usize> Mmio<SIZE> {
+impl<const SIZE: usize> MmioOwned<SIZE> {
     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
     ///
     /// Relaxed accessors do not provide ordering guarantees with respect to DMA or memory accesses
@@ -923,19 +924,19 @@ impl<const SIZE: usize> Mmio<SIZE> {
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     ///     RelaxedMmio,
     /// };
     ///
-    /// fn do_io(io: &Mmio<0x100>) {
+    /// fn do_io(io: &MmioOwned<0x100>) {
     ///     // The access is performed using `readl_relaxed` instead of `readl`.
     ///     let v = io.relaxed().read32(0x10);
     /// }
     ///
     /// ```
     pub fn relaxed(&self) -> &RelaxedMmio<SIZE> {
-        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `Mmio`, so `Mmio<SIZE>` and
-        // `RelaxedMmio<SIZE>` have identical layout.
+        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `MmioOwned`, so `MmioOwned<SIZE>`
+        // and `RelaxedMmio<SIZE>` have identical layout.
         unsafe { core::mem::transmute(self) }
     }
 }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 9e15bc8fde78..8f6c257c5b8e 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -16,7 +16,7 @@
             Region,
             Resource, //
         },
-        Mmio,
+        MmioOwned,
         MmioRaw, //
     },
     prelude::*,
@@ -211,7 +211,7 @@ pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
 }
 
 impl<const SIZE: usize> Deref for ExclusiveIoMem<'_, SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = MmioOwned<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         &self.iomem
@@ -291,10 +291,10 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for IoMem<'_, SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = MmioOwned<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: Safe as by the invariant of `IoMem`.
-        unsafe { Mmio::from_raw(&self.io) }
+        unsafe { MmioOwned::from_raw(&self.io) }
     }
 }
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 75d1b3e8596c..79828a8006b5 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -47,14 +47,14 @@
 /// ```no_run
 /// use kernel::io::{
 ///     Io,
-///     Mmio,
+///     MmioOwned,
 ///     poll::read_poll_timeout, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> Result {
 ///     read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
@@ -134,14 +134,14 @@ pub fn read_poll_timeout<Op, Cond, T>(
 /// ```no_run
 /// use kernel::io::{
 ///     Io,
-///     Mmio,
+///     MmioOwned,
 ///     poll::read_poll_timeout_atomic, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> Result {
 ///     read_poll_timeout_atomic(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 1e81de770b4f..e375a1332f37 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -58,7 +58,7 @@
 //!     },
 //!     num::Bounded,
 //! };
-//! # use kernel::io::Mmio;
+//! # use kernel::io::MmioOwned;
 //! # register! {
 //! #     pub BOOT_0(u32) @ 0x00000100 {
 //! #         15:8 vendor_id;
@@ -66,7 +66,7 @@
 //! #         3:0 minor_revision;
 //! #     }
 //! # }
-//! # fn test(io: &Mmio<0x1000>) {
+//! # fn test(io: &MmioOwned<0x1000>) {
 //! # fn obtain_vendor_id() -> u8 { 0xff }
 //!
 //! // Read from the register's defined offset (0x100).
@@ -446,7 +446,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::Mmio;
+/// # use kernel::io::MmioOwned;
 ///
 /// register! {
 ///     FIXED_REG(u32) @ 0x100 {
@@ -455,7 +455,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>) {
+/// # fn test(io: &MmioOwned<0x1000>) {
 /// let val = io.read(FIXED_REG);
 ///
 /// // Write from an already-existing value.
@@ -559,7 +559,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::Mmio;
+/// # use kernel::io::MmioOwned;
 ///
 /// // Type used to identify the base.
 /// pub struct CpuCtlBase;
@@ -584,7 +584,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: Mmio<0x1000>) {
+/// # fn test(io: MmioOwned<0x1000>) {
 /// // Read the status of `Cpu0`.
 /// let cpu0_started = io.read(CPU_CTL::of::<Cpu0>());
 ///
@@ -601,7 +601,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: Mmio<0x1000>) {
+/// # fn test2(io: MmioOwned<0x1000>) {
 /// // Start the aliased `CPU0`, leaving its other fields untouched.
 /// io.update(CPU_CTL_ALIAS::of::<Cpu0>(), |r| r.with_alias_start(true));
 /// # }
@@ -638,7 +638,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::Mmio;
+/// # use kernel::io::MmioOwned;
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -651,7 +651,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>)
+/// # fn test(io: &MmioOwned<0x1000>)
 /// #     -> Result<(), Error>{
 /// // Read scratch register 0, i.e. I/O address `0x80`.
 /// let scratch_0 = io.read(SCRATCH::at(0)).value();
@@ -724,7 +724,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::Mmio;
+/// # use kernel::io::MmioOwned;
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -752,7 +752,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>) -> Result<(), Error> {
+/// # fn test(io: &MmioOwned<0x1000>) -> Result<(), Error> {
 /// // Read scratch register 0 of CPU0.
 /// let scratch = io.read(CPU_SCRATCH::of::<Cpu0>().at(0));
 ///
@@ -794,7 +794,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: &Mmio<0x1000>) -> Result<(), Error> {
+/// # fn test2(io: &MmioOwned<0x1000>) -> Result<(), Error> {
 /// let cpu0_status = io.read(CPU_FIRMWARE_STATUS::of::<Cpu0>()).status();
 /// # Ok(())
 /// # }
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 42f840d64a6f..e0acb62f58a2 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -10,7 +10,7 @@
     io::{
         Io,
         IoCapable,
-        Mmio,
+        MmioOwned,
         MmioRaw,
         Region, //
     },
@@ -242,11 +242,11 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for Bar<'_, SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = MmioOwned<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
-        unsafe { Mmio::from_raw(&self.io) }
+        unsafe { MmioOwned::from_raw(&self.io) }
     }
 }
 

-- 
2.54.0

