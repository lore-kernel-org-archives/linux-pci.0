Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38C3E95A4;
	Mon,  8 Jun 2026 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948759; cv=fail; b=FYBsTGV1ZGNk9vPWSesCw8ugLJjJgaIzDKmGVg+ni+Z1x08HgqWZpewYQu+Xh6VWe5RI/bPSjXpyQYmG9Am3gAZ4HLBEmefR49zv2rh9VexzUVTZbWte3ZbtlIISt7hNLL1JQqbaw5PF+3QxxrEzk5ML1Zgy0NkYpi9lCnjy0uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948759; c=relaxed/simple;
	bh=JrWvnoFu8en2jfBcWMs/D2BwWcGYO3qY0mO+16Fdi4Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M2IY8TBXH/GZzuS8TpVYYCjJ7wC0pw+BuYnJwyBX1PCQDidr6H67KFM0JwvHeJsG801qJRpIysFmuVFsS5NiPxkAYiVdkQRrppr4c42Xa5J4hmjpbW4meL4yox2rwD/1jRYEq2ttJhWRN2UAfKL8vquzrurg/YghE7xISHSv+JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=dpFaWNu7; arc=fail smtp.client-ip=52.101.195.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="dpFaWNu7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b18aw5yrOY0AYTh4IMYglsP4gMQEzbZQ80RAxKt5Ce2YDhVInqYAXX0jbNIOrqtGJ7IGxJcrD2osIC6zzpeEODdsxhKgDce6CbXf/uONdY+tL2iNiOmBHaQKcVwdY/siuBIZFAdXA8fyalkyYMbMHjt+MAMaX1Lgc4DfYnYvYhYTBWzVUd940EgaNFZaZytsrGcTAFzhnri8rPLZ1cvht7zfQaa7lZ74xNfv6JKga1X8kkeZrIWQx8dUztWL+cnRpwnX++09lUbveWK/nVzV0mNlCG4gENBRITQf5+YL8LJX94OhE9DqOMhm0Oax9cuPQlYSuiz68BwHL2Es2cxzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8D6u+DmuDvUSll1wCtj/pUENbrxckYN0a2P55ksnMA=;
 b=mCSiNDv44vt8GZg2C7j4Gp9iyRrT+LIo+XonEBxOcPBG6jTkMS7VwUGk715yInAY6tKY6G5TmqlXAQQMvm4qpmPgVb5cIhwRrDTYE2JWm75hqMcib4WP7jmHCuhrJwugXJE7EKA3KNbsK8RaQY6Nm2XLqx0Aalsk9rBEd+FDw9ZqEF5fE/R5HsRZt93qWshEFPgK08VtwbQ/Li+t/3l++wTm3y0uDltMEmF0P6BuPtERuw5WBGeX1zfkeXq8od1LR41KOhKbAn6ctWTRkMYivr/6/qGMsnb01hLa7u6mzRnBKlTIe3st2EQRKyD9HRnf/qO2Ng0bi6QmnSfXlEnAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8D6u+DmuDvUSll1wCtj/pUENbrxckYN0a2P55ksnMA=;
 b=dpFaWNu7RkJcNpQFog5e88wWSobJrWYHm4rtj2M8oshVv73SAOvj/qi2SZ2l1JYD4SyoxDmfV7/x5NKoWH0e4geFSeePPgB1te/RPtt/XB1VUajMfA6roPkJUK1eqow8Hdz5Am2dgK921lla1d4zgTXif4zE/k0bdLWymyXT7hM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:09 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:09 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:01 +0100
Subject: [PATCH v3 04/19] rust: io: implement `Io` on reference types
 instead
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-4-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=16076;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=JrWvnoFu8en2jfBcWMs/D2BwWcGYO3qY0mO+16Fdi4Q=;
 b=r6JRD3MpPrvsbhh528ALN733mKy5SpTUYz2mk4hAqaZSAYjWT1gYpIuxxd+3t2RYzqvhsVLTD
 1DfwFYgnY6sC0zA3RyZ7p/5KXZBfqmpq8IDA6HxQGFERsQ5fOGJS6xq
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
X-MS-Office365-Filtering-Correlation-Id: 0acffe8c-07db-4d9c-5264-08dec5986788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	IOniocswQkmrT9skFTcC7cIvGnlwceZWomeHPUN8TahvTOus7DYbArEF7uXp7nMpGXbXH1yKQEyvDQHOHSs5e0s3DzxKoQmAWkvLWf/noAn8oQGY11SUuPDZvv0JwkYgM2+Q6DUPOR27o1+uMA9XhjxIGSkoIXSg4lofe3ahdTcioLpH/EFynGuoTbJ9lpGbpyWn4Zxg41yP6d9Pfx6U3rCYLqi6GozukMyPWi/njWZEeQj0Rey38r2Xjnqk+lxrMi0XCH1JOgMqAwEcglxml3O4TNvuIyU72AK1RPlA4dzZ/gbojRuRN2rmenuPCC+Zxps92titcKz8lIeYC9ZL+r14x0SCKwH8FmR+01EcUYj3Xjnk1hbKDftpOyja2YL85DYygwFEcAV0L2ZshOsRv5AWDOSTPlrByOg2iDjdwY23zFBGX/52TiYJ5rzGcwU9WF+w+EnCKqd6mSV7Sa9FTVPMBS699uE4ntQOIH7lk7AQ6Tqnl9vN6ObVNV7eowkZAlsO6Dhhh3AntuP7/wQ6diBj3Um09GFYBARWP4520ICrHiK9WWqAMW31TeZ6M/EzZgQxiWqqKMQi5oiEfGVhlM3H5c9v5EOGfqQqWQmQY8TifgusY6D7N0gSeKb8zdRFyrG4578+/ncJwpusk8wp9cDmGNU3eiv/xpWMBQBZobeMtvaE5t/0vmfACBQIPCxN+i+huH590nxSfJbiDEPKuoj3qoz/NpbW+akFsXz8LvY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGhFWlBjWXJQcDlQenREU0dxUmtVS1ZkbEV3Q3FGNmhYRGZKRFNiWDBrMGVM?=
 =?utf-8?B?T3dKMmhZR0FBbHRCUkJ1R1Y2cm1WeE8xUHVvVXovaVlxNjh5UjA2N0dROFg5?=
 =?utf-8?B?d3YxUlErY2k4VzgzMGJaNUwyQkQ0Z3BSV0ozRnEzVC9vLzFsd3V0cm9XbVVu?=
 =?utf-8?B?czFzZVVFdFpmOFlvaEgrSmRwQmJKUzdzR3BkSFd1YXR3Y1dmTit2UHJpMlhK?=
 =?utf-8?B?a05jODVRQmN0dG5xWEtPbjVQS1VsSzdaOXN0dmtBNWp1QjdLMzk0bFAxWFhu?=
 =?utf-8?B?OEJ4Nk9CdXpBM2FvenBoTU11bzNCaUFIclZoOWx0MEFqdW8vb01Kckp2UDVB?=
 =?utf-8?B?MS83R2VPQWFPZUhSM0VDTXNUQ0hnbWtkSUZuak40RkFEcysvTVp0Ukg3anRO?=
 =?utf-8?B?QzhSODhtSFZPUDNYS0xVbnFTOXVnRFJ3QzRjSTN2Y1ZkWE82TkhEVjZYSVFG?=
 =?utf-8?B?K1FnR3dGTWJ6MGk5UTlGbU1DL3B4c0NWQnpKU3BkOGF4Qi8rYzJ0RHhTNGxz?=
 =?utf-8?B?Y1RSRUlBUUF1ME15Q0xqQUsrQjIrQi9weGlNeldQcEF6VkRqaUR6Ymg3UW54?=
 =?utf-8?B?QWNwUy83bTNHK0h2aDZQa0ROZjh4MlVyOVJJNVBmb1cyRnRPckora0Zkbzhj?=
 =?utf-8?B?YTVBYzFtNGZZMVJFaVZyeU9IK2NNY2g2MkJKQ3ZJT1RSZHRYOXFWbTVvSGYx?=
 =?utf-8?B?WFp1bWhQUE9WelJ2aTJtY0dLTHJBa1JZYVoyaXdINFlqYUgydUVhTTJ3MzQv?=
 =?utf-8?B?T1kxNmRnQTltUlBXbDRUL0UrRkNmMkx3ZWdscG13K0RQUDBpUi9Uc3lYR0hP?=
 =?utf-8?B?TWVNcFF3T0kzdFRRaXFKSjNpK0NiR1N4a2gxSG9iQndHYWJjdUU4clhieWhM?=
 =?utf-8?B?QmEwbm5udmNDM2o2cndJa2o4Njd2alE1WDNrTzZaZlJubGMxcGh6YXdqaHdh?=
 =?utf-8?B?RGplNm5CeVMrT1dFTzg0Wm1vQVI0Yjk5NDhEcjhVbkFlMVpPODZieFN4WUIy?=
 =?utf-8?B?T1AxUDAyMldHbUJ0VXpwd2pWV3ppTHJReDBJTUdoWGpXOUJsZWl0YkRLWXlL?=
 =?utf-8?B?L2RCeG5SVXd3ZisyVENZRGpJVFRhZ2J3L0JaZGdMUXJmQnZMZlRIYUNqSlBB?=
 =?utf-8?B?TkRpV0doRGsvVmJkQ2ROKzk3cXMrSnNBeWR1VFJPM1ltQjZheHQ2a3JLeTho?=
 =?utf-8?B?enJDV05kR2tJWlZLUVNTN29ZN05xZjU2dk5hNE55OGFsS2xlN2Z5bGRYQ1ZM?=
 =?utf-8?B?aFJhMTRlaC9Gb0ZHRmFFaHhURVNlSkxRQXZIUFNOWE10d0VvOUdZZCswT3RV?=
 =?utf-8?B?N1BMczh0YmozOW83cjF0OTlzSk1FNitHVnFzOWRydWh4VFl1RVFWTjJ2VjJt?=
 =?utf-8?B?U0grU2VSek54MXFqckJrcXM2SDQxUllrOERnamdOVDNSYUovTkNFUFZDMzdB?=
 =?utf-8?B?NVZqc3RxNTRrL0JKTzQyeWV0d2hnaWc0c0pFYUgwQmhBUHpITENzWXZWRkZi?=
 =?utf-8?B?MkF5ci9uRER5czFjbXk5bXRldFRaNkJxVHduUi9iWEZucDBHSGJxdWxHb01h?=
 =?utf-8?B?Um4wcWVUWUpKdHViTnhReTRVRmpHVENwQlRJTFdhQ3V5L0FBOXd4TVJMNXZz?=
 =?utf-8?B?T0VPbkEycDM2VGQ0VHFVNkkvWFFkemorWkxoSFI5NER5Qm5aWjk4U1BWVXIr?=
 =?utf-8?B?L2NqbDcvSzcxNjVjZjlRN2VBNktrWnhZa1ZEYi81NjlxdzU2aERGMUIzWjh6?=
 =?utf-8?B?SlNxVUpvMVZlRVpMUlY1YURDKzNOVUE0dUF4clowZ1UxN0JOMzB0bnh5djlL?=
 =?utf-8?B?Q1J4bEV1SU93aDdIVStUOUtCc2Nlcjc4QW9uUkZXTFdxVXJFSUZiRGpwQ1lJ?=
 =?utf-8?B?RmlVdGduQlBVeWVvNFdFVHlyRStmWVV4dE5xZjhZdmpFNG5pWjVvVDZ1M0NP?=
 =?utf-8?B?R1l2dUdRNkdhV3lhaDdsT1NEN0JuYWRsSCtKTHJqOWtOdXg5S2MydGo1Tk9n?=
 =?utf-8?B?bCtFVnJJbTFDelJ0VlN3cjIzazRVNE9LYTg0NGw4aHJwUTZUcjlWSm1yZUpj?=
 =?utf-8?B?SUxYbTV4RTVzejhpdytkUnpPYlhOelQ2ek1PY2QyL2R0dkhWTXdzL3p6Smoy?=
 =?utf-8?B?N0dMUW5ndUdNSXJBcDJ6elpuK05JSUtXRmpZMTFja0hwUFdVU0ZVWEVqS1Bi?=
 =?utf-8?B?QlU4RkIyRThrUzFNSEhXTTlhRGN3ZlRBckFSQnE2dE5lZW9hUnhKYXRDQSsv?=
 =?utf-8?B?U3U3UFMwVktuRDM1Zm4zbmRCK2g2cDAwSFRUaktoRERhWEtHOG01ei9QYzI4?=
 =?utf-8?B?aVloV1ZpSGVZREluSG03RG0xeTFoYmlCYTBvS0tHVTViRlhndkVvUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acffe8c-07db-4d9c-5264-08dec5986788
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:09.6694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUqPCoKBL2lRGR1dOjJqGnEuJ75cyKs/MSDkIkHl82LxBzywd7hzn/W0C8/dBaJWAm6Y9xq1+btlQAOZ7fw0FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

Currently, `Io` is implemented on owned I/O objects (e.g. `Bar`). This is
going to change with I/O projections, as then `Io` need to work both for
owned objects and views of them. Views are themselves reference-like
(however they obviously cannot be references, because they belong to a
different address space).

To faciliate the change, change `Io` to be implemented on reference types
for the owned I/O objects, and make methods take `self` instead of `&self`.
When I/O views are implemented, we can then naturally implement `Io` for
these objects.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs     | 80 +++++++++++++++++++++++++--------------------------
 rust/kernel/pci/io.rs | 12 ++++----
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 5a657bb3da09..d57df2a072a0 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -226,7 +226,7 @@ pub trait IoCapable<T> {
     ///
     /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
     /// - `address` must be aligned.
-    unsafe fn io_read(&self, address: usize) -> T;
+    unsafe fn io_read(self, address: usize) -> T;
 
     /// Performs an I/O write of `value` at `address`.
     ///
@@ -234,7 +234,7 @@ pub trait IoCapable<T> {
     ///
     /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
     /// - `address` must be aligned.
-    unsafe fn io_write(&self, value: T, address: usize);
+    unsafe fn io_write(self, value: T, address: usize);
 }
 
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
@@ -301,21 +301,21 @@ fn offset(self) -> usize {
 ///
 /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
 /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
-pub trait Io {
+pub trait Io: Copy {
     /// Type of this I/O region. For untyped regions, [`Region`] can be used.
     type Target: ?Sized + KnownSize;
 
     /// Returns the base address of this mapping.
-    fn addr(&self) -> usize;
+    fn addr(self) -> usize;
 
     /// Returns the maximum size of this mapping.
-    fn maxsize(&self) -> usize;
+    fn maxsize(self) -> usize;
 
     /// Returns the absolute I/O address for a given `offset`,
     /// performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
-    fn io_addr_assert<U>(&self, offset: usize) -> usize {
+    fn io_addr_assert<U>(self, offset: usize) -> usize {
         // We cannot check alignment with `offset_valid` using `self.addr()`. So set 0 for it and
         // ensure alignment by checking that the alignment of `U` is smaller or equal to the
         // alignment of `Self::Target`.
@@ -328,7 +328,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
     /// Returns the absolute I/O address for a given `offset`,
     /// performing runtime bound checks.
     #[inline]
-    fn io_addr<U>(&self, offset: usize) -> Result<usize> {
+    fn io_addr<U>(self, offset: usize) -> Result<usize> {
         if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
             return Err(EINVAL);
         }
@@ -340,7 +340,7 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
 
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read8(&self, offset: usize) -> Result<u8>
+    fn try_read8(self, offset: usize) -> Result<u8>
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -350,7 +350,7 @@ fn try_read8(&self, offset: usize) -> Result<u8>
 
     /// Fallible 16-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read16(&self, offset: usize) -> Result<u16>
+    fn try_read16(self, offset: usize) -> Result<u16>
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -360,7 +360,7 @@ fn try_read16(&self, offset: usize) -> Result<u16>
 
     /// Fallible 32-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read32(&self, offset: usize) -> Result<u32>
+    fn try_read32(self, offset: usize) -> Result<u32>
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -370,7 +370,7 @@ fn try_read32(&self, offset: usize) -> Result<u32>
 
     /// Fallible 64-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read64(&self, offset: usize) -> Result<u64>
+    fn try_read64(self, offset: usize) -> Result<u64>
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -380,7 +380,7 @@ fn try_read64(&self, offset: usize) -> Result<u64>
 
     /// Fallible 8-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write8(&self, value: u8, offset: usize) -> Result
+    fn try_write8(self, value: u8, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -390,7 +390,7 @@ fn try_write8(&self, value: u8, offset: usize) -> Result
 
     /// Fallible 16-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write16(&self, value: u16, offset: usize) -> Result
+    fn try_write16(self, value: u16, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -400,7 +400,7 @@ fn try_write16(&self, value: u16, offset: usize) -> Result
 
     /// Fallible 32-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write32(&self, value: u32, offset: usize) -> Result
+    fn try_write32(self, value: u32, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -410,7 +410,7 @@ fn try_write32(&self, value: u32, offset: usize) -> Result
 
     /// Fallible 64-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write64(&self, value: u64, offset: usize) -> Result
+    fn try_write64(self, value: u64, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -420,7 +420,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
 
     /// Infallible 8-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read8(&self, offset: usize) -> u8
+    fn read8(self, offset: usize) -> u8
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -430,7 +430,7 @@ fn read8(&self, offset: usize) -> u8
 
     /// Infallible 16-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read16(&self, offset: usize) -> u16
+    fn read16(self, offset: usize) -> u16
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -440,7 +440,7 @@ fn read16(&self, offset: usize) -> u16
 
     /// Infallible 32-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read32(&self, offset: usize) -> u32
+    fn read32(self, offset: usize) -> u32
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -450,7 +450,7 @@ fn read32(&self, offset: usize) -> u32
 
     /// Infallible 64-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read64(&self, offset: usize) -> u64
+    fn read64(self, offset: usize) -> u64
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -460,7 +460,7 @@ fn read64(&self, offset: usize) -> u64
 
     /// Infallible 8-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write8(&self, value: u8, offset: usize)
+    fn write8(self, value: u8, offset: usize)
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -470,7 +470,7 @@ fn write8(&self, value: u8, offset: usize)
 
     /// Infallible 16-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write16(&self, value: u16, offset: usize)
+    fn write16(self, value: u16, offset: usize)
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -480,7 +480,7 @@ fn write16(&self, value: u16, offset: usize)
 
     /// Infallible 32-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write32(&self, value: u32, offset: usize)
+    fn write32(self, value: u32, offset: usize)
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -490,7 +490,7 @@ fn write32(&self, value: u32, offset: usize)
 
     /// Infallible 64-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write64(&self, value: u64, offset: usize)
+    fn write64(self, value: u64, offset: usize)
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -521,7 +521,7 @@ fn write64(&self, value: u64, offset: usize)
     /// }
     /// ```
     #[inline(always)]
-    fn try_read<T, L>(&self, location: L) -> Result<T>
+    fn try_read<T, L>(self, location: L) -> Result<T>
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -555,7 +555,7 @@ fn try_read<T, L>(&self, location: L) -> Result<T>
     /// }
     /// ```
     #[inline(always)]
-    fn try_write<T, L>(&self, location: L, value: T) -> Result
+    fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -601,7 +601,7 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     /// }
     /// ```
     #[inline(always)]
-    fn try_write_reg<T, L, V>(&self, value: V) -> Result
+    fn try_write_reg<T, L, V>(self, value: V) -> Result
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
@@ -634,7 +634,7 @@ fn try_write_reg<T, L, V>(&self, value: V) -> Result
     /// }
     /// ```
     #[inline(always)]
-    fn try_update<T, L, F>(&self, location: L, f: F) -> Result
+    fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -673,7 +673,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     /// }
     /// ```
     #[inline(always)]
-    fn read<T, L>(&self, location: L) -> T
+    fn read<T, L>(self, location: L) -> T
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -705,7 +705,7 @@ fn read<T, L>(&self, location: L) -> T
     /// }
     /// ```
     #[inline(always)]
-    fn write<T, L>(&self, location: L, value: T)
+    fn write<T, L>(self, location: L, value: T)
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -748,7 +748,7 @@ fn write<T, L>(&self, location: L, value: T)
     /// }
     /// ```
     #[inline(always)]
-    fn write_reg<T, L, V>(&self, value: V)
+    fn write_reg<T, L, V>(self, value: V)
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
@@ -781,7 +781,7 @@ fn write_reg<T, L, V>(&self, value: V)
     /// }
     /// ```
     #[inline(always)]
-    fn update<T, L, F>(&self, location: L, f: F)
+    fn update<T, L, F>(self, location: L, f: F)
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -802,13 +802,13 @@ fn update<T, L, F>(&self, location: L, f: F)
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
         $(#[$attr])*
-        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
-            unsafe fn io_read(&self, address: usize) -> $ty {
+        impl<const SIZE: usize> IoCapable<$ty> for &$mmio<SIZE> {
+            unsafe fn io_read(self, address: usize) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$read_fn(address as *const c_void) }
             }
 
-            unsafe fn io_write(&self, value: $ty, address: usize) {
+            unsafe fn io_write(self, value: $ty, address: usize) {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$write_fn(value, address as *mut c_void) }
             }
@@ -829,18 +829,18 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
     writeq
 );
 
-impl<const SIZE: usize> Io for Mmio<SIZE> {
+impl<'a, const SIZE: usize> Io for &'a Mmio<SIZE> {
     type Target = Region<SIZE>;
 
     /// Returns the base address of this mapping.
     #[inline]
-    fn addr(&self) -> usize {
+    fn addr(self) -> usize {
         self.0.addr()
     }
 
     /// Returns the maximum size of this mapping.
     #[inline]
-    fn maxsize(&self) -> usize {
+    fn maxsize(self) -> usize {
         self.0.maxsize()
     }
 }
@@ -867,16 +867,16 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
 #[repr(transparent)]
 pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
 
-impl<const SIZE: usize> Io for RelaxedMmio<SIZE> {
+impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
     type Target = Region<SIZE>;
 
     #[inline]
-    fn addr(&self) -> usize {
+    fn addr(self) -> usize {
         self.0.addr()
     }
 
     #[inline]
-    fn maxsize(&self) -> usize {
+    fn maxsize(self) -> usize {
         self.0.maxsize()
     }
 }
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index b4996aa059d8..505305cd9b86 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -79,8 +79,8 @@ pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind = Extended> {
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
-            unsafe fn io_read(&self, address: usize) -> $ty {
+        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for &ConfigSpace<'a, S> {
+            unsafe fn io_read(self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
                 // Return value from C function is ignored in infallible accessors.
@@ -94,7 +94,7 @@ unsafe fn io_read(&self, address: usize) -> $ty {
                 val
             }
 
-            unsafe fn io_write(&self, value: $ty, address: usize) {
+            unsafe fn io_write(self, value: $ty, address: usize) {
                 // Return value from C function is ignored in infallible accessors.
                 let _ret =
                     // SAFETY: By the type invariant `self.pdev` is a valid address.
@@ -112,18 +112,18 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ?Sized + ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+impl<'a, S: ?Sized + ConfigSpaceKind> Io for &ConfigSpace<'a, S> {
     type Target = S;
 
     /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
-    fn addr(&self) -> usize {
+    fn addr(self) -> usize {
         0
     }
 
     /// Returns the maximum size of the configuration space.
     #[inline]
-    fn maxsize(&self) -> usize {
+    fn maxsize(self) -> usize {
         self.pdev.cfg_size().into_raw()
     }
 }

-- 
2.54.0

